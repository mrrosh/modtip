    local AddTarget = function()
        local unit = 'mouseovertarget'
        if  UnitIsUnit('player', unit) then
            return '|cffff0000You!|r'
        else
            if  UnitPlayerControlled(unit) then
                local _, class = UnitClass(unit)
                local r, g, b = RAID_CLASS_COLORS[class]
                return UnitName(unit), r, g, b
            else
                local r, g, b = GameTooltip_UnitColor'mouseovertarget'
                return UnitName(unit), r, g, b
            end
        end
    end

local f = CreateFrame'Frame'    -- guild tag
    f:RegisterEvent'UPDATE_MOUSEOVER_UNIT'
    f:SetScript('OnEvent', function()
        local g = GetGuildInfo'mouseover'
        local n = GameTooltipTextLeft2:GetText()
        local c = UnitClassification'mouseover'
        local class, colour

        if n and string.find(n, 'Level (.+)') then
            if   string.find(n, '(Player)') then
                    --  this is the ugliest god damn capture sequence
                    --  but im too tired to make it pretty atm
                local t = gsub(n, 'Level (.+) (.+) (.+)', '%2')
                if t then colour = RAID_CLASS_COLORS[string.upper(t)] end
            end
            if  c ~= 'normal' and c ~= 'minus' then
                local t = gsub(n, 'Level (.+) ((.+))', '%1')
                local classification = c == 'elite' and '(Elite)' or c == 'rare' and '(Rare)' or c == 'rareelite' and '(Rare Elite)' or '(Boss)'
                GameTooltipTextLeft2:SetText('Level '..t..' '..classification)
            end
        end

        if g then GameTooltip:AddLine('<'..g..'>', 0, 1, .5) end

        if  UnitExists'mouseovertarget' then
            local name, r, g, b = AddTarget()
            GameTooltip:AddLine('|cfffec500Target:|r '..name, r, g, b)
        end


        if  colour then
            local r, g, b = GameTooltip_UnitColor'mouseover'
            GameTooltipTextLeft1:SetTextColor(colour and colour.r or r, colour and colour.g or g, colour and colour.b or b)
            if  GameTooltipStatusBar:IsShown() then
                GameTooltipStatusBar:SetStatusBarColor(colour and colour.r or r, colour and colour.g or g, colour and colour.b or b)
            end
        end

        GameTooltip:Show()
    end)