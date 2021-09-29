--[[

    Written by darmantinjr / darmyn
    Written on: September 28th, 2021 around 11PM -> September 29th, 2021 at 2:00 AM. (I know I'm slow)

    Why filta?

    Filta makes it easy to store data under tags. This allows you to make more precise searches.

    MAKE YOUR OWN SEARCH METHODS: Filta comes built in with some search methods. These are global search methods
    inside of the "searchMethods" table on LINE 14. You can add search methods to this table to create global search methods
    that are accessible by all filta objects. You can also write custom search methods that are exclusive to
    one filta objects using :NewSearchMethod() on a filta object.

    SET DEFAULT SEARCH METHOD: You can change the global default search method for all filta objects below. You can set a 
    default search method to a specific filter object as well by modifying the `DefaultSearchMethod` property of a filta object.
    This might save you typing time if a filta object is using the same search method more than others.

]]

local DEFAULT_SEARCH_METHOD = "Whitelist"

local searchMethods = {
    Whitelist = function(tagsToSearchFor, entry)
        for _, tag in ipairs(tagsToSearchFor) do
            if table.find(entry.Tags, tag) then
                return true
            end
        end
    end,
    Blacklist = function(tagsToSearchFor, entry)
        for _, tag in ipairs(tagsToSearchFor) do
            if not table.find(entry.Tags, tag) then
                return true
            end
        end
    end,
    ExactMatch = function(tagsToSearchFor, entry)
        local isExactMatch = true
        for _, tag in ipairs(entry.Tags) do
            if not table.find(tagsToSearchFor, tag) then
                isExactMatch = false
                break
            end
        end
        return isExactMatch
    end,
}

local Filta = {}
Filta.__index = Filta

function Filta.new()
    local self = setmetatable({}, Filta)

    self.DefaultSearchMethod = DEFAULT_SEARCH_METHOD --> allows users to change the default search method specifically for certain objects. Might save them time.
    self._entries = {}
    self._uniqueSearchMethods = {}

    return self
end

function Filta:NewEntry(data: table, tags: table, callback)
    assert(data, "Missing argument @ position 1")
    assert(tags, "Missing argument @ position 2")
    assert(typeof(data) == "table", "Incorrect type of argument passed @ position 1. Expects `table`, and recieved `"..typeof(data).."`.")
    assert(typeof(tags) == "table" and #tags > 0, "Incorrect type of argument passed @ position 2. Expects `array`, and recieved another type, or possibly a table with no length. Type: "..typeof(tags))
    if callback then
        assert(typeof(callback) == "function", "Incorrect type of argumnet passed @ position 3. Expects `function`, and recieved `"..typeof(callback).."`.")
    end
    table.insert(self._entries, {
        Data = data;
        Tags = tags;
        Callback = callback;
    })
end
function Filta:Search(tagsToSearchFor: table, searchMethodName: string)
    assert(tagsToSearchFor, "Missing argument @ position 1")
    assert(searchMethodName, "Missing argument @ position 2")
    assert(typeof(tagsToSearchFor) == "table" and #tagsToSearchFor > 0, "Incorrect type of argument passed @ position 1. Expectes `array`, and recieved another type, or possibly a table with no length. Type: "..typeof(tagsToSearchFor))
    assert(typeof(self.DefaultSearchMethod) == "string", "Incorrect property value type. Filta.DefaultSearchMethod is expected to be a `string` and not a `"..typeof(self.DefaultSearchMethod).."`.")
    assert(typeof(searchMethodName) == "string", "Incorrect type of argument passed @ position 2. Expects `string`, and recieved `"..typeof(searchMethodName).."`.")
    assert(self._uniqueSearchMethods[searchMethodName] or searchMethods[searchMethodName], "Unable to locate search method under the name `"..searchMethodName.."`.")
    searchMethodName = searchMethodName or self.DefaultSearchMethod --> "Whitelist" and "ExactMatch" and "Blacklist"

    local related = {}

    for _, entry in ipairs(self._entries) do
        local entryData = entry.Data
        local entryCallback = entry.Callback
        local searchMethod = self._uniqueSearchMethods[searchMethodName] or searchMethods[searchMethodName]
        local isRelated = searchMethod(tagsToSearchFor, entry)

        if isRelated then
            table.insert(related, entryData)
            if entry.Callback then
                entryCallback(entryData)
            end
        end
    end

    return related
end

function Filta:NewSearchMethod(name: string, callback)
    assert(name, "Missing argument @ position 1.")
    assert(callback, "Missing argument @ position 2.")
    assert(typeof(name) == "string", "Incorrect type of argument passed @ position 1. Expects `string`, and recieved `"..typeof(name).."`.")
    assert(typeof(callback) == "function", "Incorrect type of argument passed @ position 2. Expects `function`, and recieved `"..typeof(callback).."`.")
end

return Filta


