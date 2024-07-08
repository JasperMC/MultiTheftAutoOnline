addEvent("onActivityParticipantAdded")
addEvent("onActivityParticipantRemoved")
addEvent("onActivityParticipant")

Activity = {
    id,
    status,
    name,
    type,
    participants = {}

}


function Activity.Create()

end

function Activity.Announce()

end

function Activity.Start()

end

function Activity.Stop()

end

function Activity.Complete()

end

function Activity.Fail()

end

function Activity.isJoinable( self )

end

function Activity.setJoinable(self, state )

function Activity.addParticipant( self, participant )
    table.insert( self.participants, participant)
    triggerEvent("onAcitivityParticipantAdded", participant)
end

function Activity.removeParticipant( participant )
    for i, existing_participant in ipairs(self.participants) do
        if existing_participant == participant then
            self.participants[i] = nil
        end
    end
    triggerEvent("onActivityParticipantRemoved", participant)
end