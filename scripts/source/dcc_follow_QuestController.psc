Scriptname dcc_follow_QuestController extends Quest

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Spell Property dcc_follow_SpellFollow Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Actor Property Player Auto
{always the player.}

ReferenceAlias Property Creeper Auto
{the actor who is going to do the creeping.}

ReferenceAlias Property Target Auto
{the actor we are going to follow.}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function Print(String Msg)
{print branded output to notification area.}

	Debug.Notification("[Follow] " + Msg)
	Return
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Event OnInit()
{handle mod startup and reset.}

	self.ResetMod_Spells()

	Return
EndEvent

Event OnControlDown(String Ctrl)
{handle control input when we are watching for it.}

	If(Ctrl == "Jump")
		self.Unfollow()
	EndIf

	Return
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function ResetMod()
{handle resetting mod defaults.}

	self.Reset()
	self.Stop()
	self.Start()

	Return
EndFunction

Function ResetMod_Spells()
{handle resetting the spell components.}

	self.Player.RemoveSpell(self.dcc_follow_SpellFollow)
	self.Player.AddSpell(self.dcc_follow_SpellFollow)

	Return
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function Follow(Actor Who)
{follow the specified target.}

	Game.SetPlayerAIDriven(TRUE)
	self.RegisterForControl("Jump")

	self.Creeper.ForceRefTo(self.Player)
	self.Target.ForceRefTo(Who)

	self.Print("You are now following " + Who.GetDisplayName() + ". Press JUMP to stop.")
	Return
EndFunction

Function Unfollow()
{stop following the target.}

	Game.SetPlayerAIDriven(FALSE)
	self.UnregisterForControl("Jump")

	self.Creeper.Clear()
	self.Target.Clear()

	self.Print("You are no longer following.")
	Return
EndFunction
