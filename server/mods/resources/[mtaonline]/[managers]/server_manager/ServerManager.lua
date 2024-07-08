ServerManager = {}

function ServerManager.new(self, o)

end

function ServerManager.Start( self )

end

function ServerManager.Stop( self )

end

function ServerManager.Restart( self )
    self.Stop()
    self.Start()
end