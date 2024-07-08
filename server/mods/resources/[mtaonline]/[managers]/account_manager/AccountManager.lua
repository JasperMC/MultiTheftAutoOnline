AccountManager = {
    players = {}
}

function AccountManager.Start()

end

function AccountManager.Stop()
    for player, account in pairs(self.players) do
        self.logPlayerOutOfAccount( player, account )
    end
end

function AccountManager.Restart( self )
    self.Stop()
    self.Start()
end

function AccountManager.registerAccount( self, player, email, password )

end

function AccountManager.deleteAccount( self, id)

end

function AccountManager.updateAccount( self, account, data )

end

function AccountManager.logPlayerIntoAccount( self, player, account )
    self.players[player] = account
    triggerEvent('onPlayerAccountLogin', player, account)
end

function AccountManager.logPlayerOutOfAccount( self, player, account )
    if not account then account = self.players[player]
    self.players[player] = nil
    triggerEvent('onPlayerAccountLogout', player, account)
end

function AccountManager.isPlayerLoggedIn( self, player )
    return self.players[player] ~= nil
end

function AccountManager.getPlayerAccount( self, player )
    return self.players[player]
end

function AccountManager.handleLoginRequest( self, player, method, data )

end

function AccountManager.handleLogoutRequest( self, player )

end