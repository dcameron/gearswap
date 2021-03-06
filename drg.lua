-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  state.Buff['Spirit Surge'] = buffactive['Spirit Surge'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

end


-- Define sets and vars used by this job file.
function init_gear_sets()

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- A list of specific spells for which we trigger Healing Breath.
healingBreathTriggers = S{
  'Dia',
  'Poison',
  'Blaze Spikes',
  'Protect',
  'Sprout Smack',
  'Head Butt',
  'Cocoon',
  'Barfira',
  'Barblizzara',
  'Baraera',
  'Barstonra',
  'Barthundra',
  'Barwatera',
}

-- A list of wyvern elemental breath attack names.
elementalBreaths = S{
  'Flame Breath',
  'Frost Breath',
  'Sand Breath',
  'Hydro Breath',
  'Gust Breath',
  'Lightning Breath',
}

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  if healingBreathTriggers:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
    equip(sets.precast.HealingBreath)
  end

  -- Use Spirit Jump instead of Jump if the wyvern is present.
  if pet.isvalid and player.main_job_level >= 77 and spell.name == "Jump" then
    eventArgs.cancel = true
    send_command('@input /ja "Spirit Jump" <t>')
  end

  -- Use Soul Jump instead of High Jump if the wyvern is present.
  if pet.isvalid and player.main_job_level >= 85 and spell.name == "High Jump" then
    eventArgs.cancel = true
    send_command('@input /ja "Soul Jump" <t>')
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
  if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
    equip(sets.midcast.HealingBreath)
  end
  if elementalBreaths:contains(spell.english) then
    equip(sets.midcast.ElementalBreath)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
  update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end
