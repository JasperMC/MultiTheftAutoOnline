
function alphaFade( element )
    if isElement(element) then -- If only one element is passed
        triggerClientEvent(root, 'onServerRequestAlphaFadeElement', root, element )
    else
        triggerClientEvent(root, 'onServerRequestAlphaFadeElement', root, elements )
    end
end