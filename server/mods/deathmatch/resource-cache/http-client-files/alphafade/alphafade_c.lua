

function alphaFade( element, state )
    if isElement(element) then
        if state then
            setElementAlpha(element, 0)
            setTimer(
                function(element)
                    if isElement(element) then
                        setElementAlpha(element, getElementAlpha(element)+1)
                    end
                end
            , 1, 255, element)
        else
            local alpha = getElementAlpha(element)
            setTimer( function(element)
                if isElement(element) then 
                    setElementAlpha(element, getElementAlpha(element)-1)
                end
            end, 1, 255-alpha, element)
        end
    end
end

addEventHandler("onClientElementStreamIn", root,
    function()
        if getElementType(source) == "ped" or getElementType(source) == "vehicle" then
            alphaFade( source, true )
        end
    end
)

addEvent("onServerRequestAlphaFade", true )
addEventHandler("onServerRequestAlphaFade", root,
    function(element, state )
        if isElement(element) then
            alphaFade( element, state )
        else
            for i, el in ipairs(element) do
                alphaFade( element, state )
            end
        end
    end
)