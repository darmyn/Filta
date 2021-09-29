local Filta = require(script.Parent.Filta)
local filta = Filta.new()
filta:NewEntry({
    Name = "SwiftAxe";
    ClassName = "Tool";
    StorageState = "InHotbar";
    Damage = 5;
    CriticalStrikeMultiplier = 1.5;
    EnemyDamagedMultiplier = 1.2;
    MaterialMultiplier = 2;
}, {
    "InHotbar", "Tool"
})

filta:NewEntry({
    Name = "LongSword";
    ClassName = "Tool";
    StorageState = "Equipped";
    BaseDamage = 20;
    LungeDamage = 15;
    SpecialMoveDamage = 40;
    CriticalStrikeMultiplier = 2;
    EnemyDamageMultiplier = 3;
    MatieralMultiplier = 0;
}, {
    "Tool"
})
filta:NewEntry({
    Name = "DiamondChestplate";
    ClassName = "Accessory";
    StorageState = "Equipped";
    DamageReductionMultiplier = 4;
    Health = 5000;
    MaxHealth = 5000;
}, {
    "Accessory", "Equipped"
})

print(filta:Search({
    "Tool"
})) --> No secondary argument representing `searchMethodName` was provided. This is because I am using the `Whitelist` search
        -- method, which is the default method used when you call :Search(). If you read the comments at the top of 
        -- Filta.lua you can learn how to change the default search method globally or locally to a specific filta object.

