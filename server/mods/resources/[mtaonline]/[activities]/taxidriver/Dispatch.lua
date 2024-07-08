Dispatch = {
    prefix = "[Dispatch]"
    color = "#ffffff"
    dialogue = {
        driver_prompt = {
            "You are in a taxi. Press 'e' to become a taxi driver"
        }
    }


function Dispatch.Dialogue( self, category, index, to_player )
    if not category then return false end
    if not index then index = math.random(1,#self.dialogue[category]) end
    outputChatBox(self.color .. self.prefix .. "#ffffff" .. self.diaologue[category][index], to_player, 255,255,255, true )
end

function Dispatch.Say( self, msg, to_player )
    outputChatBox(Dialogue.color .. self.prefix .. "#ffffff" .. msg, to_player, 255,255,255,true)
end