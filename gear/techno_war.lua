--------------------------------------------------------------------------------
-- User setup functions for this job.
--------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
  state.OffenseMode:options('Normal', 'Acc')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.IdleMode:options('Normal', 'PDT', 'Proc')

  update_combat_form()

  -- Additional local binds

  select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

end


-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Start defining the sets
  --------------------------------------

  -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
  sets.idle = {
    main = "Ferocity",
    sub = "Bloodrain Strap",
    ammo = "Ginsen",
    head = "Sulevia's Mask +1",
    neck = "Twilight Torque",
    ear1 = "Steelflash Earring",
    ear2 = "Bladeborn Earring",
    body = "Sulevia's Platemail +1",
    hands = "Sulevia's Gauntlets +1",
    ring1 = "Defending Ring",
    ring2 = "Apeile Ring",
    back = "Solemnity Cape",
    waist = "Flume Belt +1",
    legs = "Sulevia's Cuisses +1",
    feet = "Sulevia's Leggings +1",
  }

  -- sets.idle.Town = {}

  -- sets.idle.Field = {}

  -- sets.idle.Weak = {}

  sets.idle.PDT = set_combine(sets.idle, {})

  sets.idle.Proc = set_combine(sets.idle, {
    main = "",
    sub = "",
  })

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Normal melee group
  sets.engaged = {
    ammo = "Ginsen",
    head = "Otomi Helm",
    neck = "Asperity Necklace",
    ear1 = "Steelflash Earring",
    ear2 = "Bladeborn Earring",
    body = "Xaddi Mail",
    hands = "Flamma Manopolas +1",
    ring1 = "K'ayres Ring",
    ring2 = "Petrov Ring",
    back = "Atheling Mantle",
    waist = "Windbuffet Belt +1",
    legs = "Flamma Dirs +1",
    feet = "Whirlpool Greaves",
  }

  sets.engaged.Acc = set_combine(sets.engaged, {
    head = "Flamma Zucchetto +1",
    body = "Flamma Korazin +1",
    waist = "Kentarch Belt",
    legs = "Flamma Dirs +1",
    feet = "Flamma Gambieras +1",
  })


  -- Precast Sets
  -- Precast sets to enhance JAs
  sets.precast.JA.Provoke = {
    ring2 = "Apeile Ring",
  }

  sets.precast.JA.Berserk = {}

  sets.precast.JA.Warcry = {}

  sets.precast.JA.Defender = {}

  sets.precast.JA.Aggressor = {}

  sets.precast.JA.Retaliation = {}

  sets.precast.JA.Restraint = {}

  sets.precast.JA['Blood Rage'] = {}


  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    ammo="Sonia's Plectrum",
  }

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}


  -- Fast cast sets for spells
  sets.precast.FC = {
    neck = "Baetyl Pendant",
    ear2 = "Loquacious Earring",
    ring1 = "Weatherspoon Ring +1",
  }


  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo = "Aqreqaq Bomblet",
    head = "Otomi Helm",
    neck = gear.ElementalGorget,
    ear1 = "Brutal Earring",
    ear2 = "Kemas Earring",
    body = "Sulevia's Platemail +1",
    hands = "Sulevia's Gauntlets +1",
    ring1 = "Ifrit Ring",
    ring2 = "Rufescent Ring",
    back = "Cuchulain's Mantle",
    waist = gear.ElementalBelt,
    legs = "Sulevia's Cuisses +1",
    feet = "Sulevia's Leggings +1",
  }

  sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    head = "Flamma Zucchetto +1",
    ammo = "Ginsen",
    body = "Flamma Korazin +1",
    waist = "Kentarch Belt",
  })

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

  -- Raging Rush has a STR: 35% modifier and is aligned with the Snow and Aqua
  -- gorgets/belts.
  sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {
    hands = "Flamma Manopolas +1",
  })
  sets.precast.WS['Raging Rush'].Acc = set_combine(sets.precast.WS.Acc, {
    hands = "Flamma Manopolas +1",
  })

  -- Steel Cyclone has STR: 60% and VIT 60% modifiers and is aligned with the
  -- Breeze, Aqua, and Snow gorgets/belts.
  sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Steel Cyclone'].Acc = set_combine(sets.precast.WS.Acc, {})

  -- King's Justice has a STR: 50% modifier and is aligned with the Breeze,
  -- Thunder, and Soil gorgets/belts.
  sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})
  sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})

  -- Fell Cleave has a STR: 60% modifier and is aligned with the Breeze,
  -- Thunder, and Soil gorgets/belts.
  sets.precast.WS["Fell Cleave"] = set_combine(sets.precast.WS, {})
  sets.precast.WS["Fell Cleave"].Acc = set_combine(sets.precast.WS.Acc, {})


  -- Sets to return to when not performing an action.

  -- Resting sets
  sets.resting = {}


  -- Defense sets
  sets.defense.PDT = {
    head = "Sulevia's Mask +1",
    neck = "Twilight Torque",
    body = "Sulevia's Platemail +1",
    hands = "Sulevia's Gauntlets +1",
    ring1 = "Defending Ring",
    back = "Solemnity Cape",
    waist = "Flume Belt +1",
    legs = "Sulevia's Cuisses +1",
    feet = "Sulevia's Leggings +1",
  }

  sets.defense.MDT = {
    head = "Sulevia's Mask +1",
    neck = "Twilight Torque",
    body = "Sulevia's Platemail +1",
    hands = "Sulevia's Gauntlets +1",
    ring1 = "Defending Ring",
    back = "Solemnity Cape",
    legs = "Sulevia's Cuisses +1",
    feet = "Sulevia's Leggings +1",
  }

  sets.Kiting = {
    head = "Sulevia's Mask +1",
    neck = "Twilight Torque",
    body = "Sulevia's Platemail +1",
    hands = "Sulevia's Gauntlets +1",
    ring1 = "Defending Ring",
    back = "Solemnity Cape",
    waist = "Flume Belt +1",
    legs = "Sulevia's Cuisses +1",
    feet = "Sulevia's Leggings +1",
  }
end


--------------------------------------------------------------------------------
-- Utility functions specific to this job.
--------------------------------------------------------------------------------

function update_combat_form()

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  if player.sub_job == 'SAM' then
    set_macro_page(1, 1)
  elseif player.sub_job == 'NIN' then
    set_macro_page(2, 1)
  elseif player.sub_job == 'DNC' then
    set_macro_page(3, 1)
  else
    set_macro_page(1, 1)
  end
end
