

-- Class
CharacterManager = {
    players = {}
}

function CharacterManager.Start(self)

end

function CharacterManager.Stop(self)

end

function CharacterManager.Restart(self)
    self.Stop()
    self.Start()
end

-- Character
function CharacterManager.setPlayerCharacter( self, player, character )

end

function CharacterManager.getPlayerCharacterList( self, player )

end

-- Handle requests
function CharacterManager.onPlayerAccountLogin(self, player, account )
    account_id
end

function CharacterManager.onPlayerRequestCharacterSwitch( self, player, character )

end

function CharacterManager.onPlayerRequestCharacterList( self, player )

end
