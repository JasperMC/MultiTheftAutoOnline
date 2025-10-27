addCommandHandler("citizen",
	function(thePlayer, command, gender, skin)
		local x, y, z = getElementPosition(thePlayer)
		local int = getElementInterior(thePlayer)
		local ped
		if gender and skin then
			if gender == "male" or gender == "female" then
				ped = createPed(skin, x, y, z)
				if isElement(ped) == false then
					outputChatBox("Can't spawn a ped with this skin (an invalid skin)", thePlayer, 255, 0, 0)
				else
					setElementInterior(ped, int)
					setElementData(ped, "Gender", gender)
					setElementData(ped, "type", "Citizen")
				end
			else
				outputChatBox("Valid genders are female and male", thePlayer, 255, 0, 0)
			end
		elseif gender and not skin then
			if gender == "female" or gender == "male" then
				if gender == "male" then
					ped = createPed(7, x, y, z)
					setElementInterior(ped, int)
					setElementData(ped, "Gender", gender)
					setElementData(ped, "type", "Citizen")
				elseif gender == "female" then
					ped = createPed(226, x, y, z)
					setElementInterior(ped, int)
					setElementData(ped, "Gender", gender)
					setElementData(ped, "type", "Citizen")
				end
			else
				outputChatBox("Valid genders are female and male", thePlayer, 255, 0, 0)
			end
		else
			if math.random(0, 1) == 0 then
				ped = createPed(226, x, y, z)
				setElementInterior(ped, int)
				setElementData(ped, "Gender", "female")
				setElementData(ped, "type", "Citizen")
			else
				ped = createPed(7, x, y, z)
				setElementInterior(ped, int)
				setElementData(ped, "Gender", "male")
				setElementData(ped, "type", "Citizen")
			end
		end
	end
)
addCommandHandler("despeds",
	function()
		for i, v in ipairs(getElementsByType("ped")) do
			destroyElement(v)
		end
	end
)
addCommandHandler("citizens",
	function(thePlayer, command)
		local x, y, z = getElementPosition(thePlayer)
		local int = getElementInterior(thePlayer)
		for i = 0, 50 do
			if math.random(0, 1) == 0 then
				local ped = createPed(226, x, y, z)
				setElementInterior(ped, int)
				setElementData(ped, "Gender", "female")
				setElementData(ped, "type", "Citizen")
			else
				local ped = createPed(7, x, y, z)
				setElementInterior(ped, int)
				setElementData(ped, "Gender", "male")
				setElementData(ped, "type", "Citizen")
			end
			
		end
	end
)
local lastX = {}
local lastY = {}
local lastZ = {}
local lastHealth = {}
setTimer(
	function()
		for i, peds in ipairs(getElementsByType("ped")) do
			if getElementData(peds, "type") == "Citizen" then
				if getElementHealth(peds) > 0 then
					if getElementData(peds, "Gender") == "female" then
						if getElementData(peds, "Panic") == true then
							setPedAnimation(peds, "ped", "woman_runpanic")
						else
							setPedAnimation(peds, "ped", "woman_walksexy")
						end
					else
						if getElementData(peds, "Panic") == true then
							setPedAnimation(peds, "ped", "sprint_civi")
						else
							setPedAnimation(peds, "ped", "walk_gang1")
						end
					end
				end
				if getElementHealth(peds) > 0 and getElementData(peds, "Rotating") == false and isPedDead(peds) == false then
					if lastX[peds] == nil then
						local x, y, z = getElementPosition(peds)
						lastX[peds] = x
						lastY[peds] = y
						lastZ[peds] = z
						lastHealth[peds] = getElementHealth(peds)
					end
					local x, y, z = getElementPosition(peds)
					if lastHealth[peds] > getElementHealth(peds) then
						lastHealth[peds] = getElementHealth(peds)
						setElementData(peds, "Panic", true)
						setTimer(
							function()
								if isElement(peds) then
									setElementData(peds, "Panic", false)
								end
							end
						, 30000, 1)
					end
					local g = 0.5
					if getElementData(peds, "Panic") == true then
						g = 0.25
					end
					if getDistanceBetweenPoints3D(x, y, z, lastX[peds], lastY[peds], lastZ[peds]) < g then
						local success = false
						local rot = getPedRotation(peds)
						setElementData(peds, "Rotating", true)
						local module = "positive"
						local executed = 0
						local rand = math.random(0, 1)
						if rand == 0 then
							module = "negative"
						end
						setTimer(
							function()
								if isElement(peds) == false then return end
								executed = executed + 1
								local rot = getPedRotation(peds)
								if module == "positive" then
									setPedRotation(peds, rot + math.random(5, 10))
								else
									setPedRotation(peds, rot - math.random(5, 10))
								end
								if executed == 18 then
									setElementData(peds, "Rotating", false)
								end
							end
						, 50, 18)
					else
						lastX[peds] = x
						lastY[peds] = y
						lastZ[peds] = z
						local c = math.random(0, 1)
						for i, elements in ipairs(getElementsByType("player")) do
							local x, y, z = getElementPosition(peds)
							local rot = getPedRotation(peds)
							local mrot = rot + 90
							mrot = math.rad(mrot)
							local jx = x + 1 * math.cos(mrot)
							local jy = y + 1 * math.sin(mrot)
							local ex, ey, ez = getElementPosition(elements)
							if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 1 then
								c = 0
								setElementData(peds, "Rotating", true)
								local gender
								if getElementData(peds, "Gender") == "female" then
									gender = "Female"
								else
									gender = "Male"
								end
								if getElementData(peds, "Panic") ~= true then
									local message = math.random(0, 4)
									if message == 4 then
										outputChatBox("Ped ("..gender.."): #FFFFFFHi", getRootElement(), 0, 255, 0, true)
									elseif message == 3 then
										outputChatBox("Ped ("..gender.."): #FFFFFFHow are you?", getRootElement(), 0, 255, 0, true)
									elseif message == 2 then
										outputChatBox("Ped ("..gender.."): #FFFFFFI'm walking, lol", getRootElement(), 0, 255, 0, true)
									elseif message == 1 then
										outputChatBox("Ped ("..gender.."): #FFFFFFYou follow me!", getRootElement(), 0, 255, 0, true)
									elseif message == 0 then
										outputChatBox("Ped ("..gender.."): #FFFFFFHey, friend!", getRootElement(), 0, 255, 0, true)
									end
								end
								local rand = math.random(0, 1)
								local module = "positive"
								local executed = 0
								if rand == 0 then
									module = "negative"
								end
								setTimer(
									function()
										if isElement(peds) == false then return end
										executed = executed + 1
										local rot = getPedRotation(peds)
										if module == "positive" then
											setPedRotation(peds, rot + 10)
										else
											setPedRotation(peds, rot - 10)
										end
										if executed == 9 then
											setElementData(peds, "Rotating", false)
										end
									end
								, 50, 9)
							end
						end
						for i, elements in ipairs(getElementsByType("ped")) do
							if elements ~= peds then
							local x, y, z = getElementPosition(peds)
							local rot = getPedRotation(peds)
							local mrot = rot + 90
							mrot = math.rad(mrot)
							local jx = x + 1 * math.cos(mrot)
							local jy = y + 1 * math.sin(mrot)
							local ex, ey, ez = getElementPosition(elements)
							if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 1 then
								c = 0
								setElementData(peds, "Rotating", true)
								local rand = math.random(0, 1)
								local module = "positive"
								local executed = 0
								if rand == 0 then
									module = "negative"
								end
								setTimer(
									function()
										if isElement(peds) == false then return end
										executed = executed + 1
										local rot = getPedRotation(peds)
										if module == "positive" then
											setPedRotation(peds, rot + 10)
										else
											setPedRotation(peds, rot - 10)
										end
										if executed == 9 then
											setElementData(peds, "Rotating", false)
										end
									end
								, 50, 9)
							end
							end
						end
						for i, elements in ipairs(getElementsByType("vehicle")) do
							local x, y, z = getElementPosition(peds)
							local rot = getPedRotation(peds)
							local mrot = rot + 90
							mrot = math.rad(mrot)
							local jx = x + 2.5 * math.cos(mrot)
							local jy = y + 2.5 * math.sin(mrot)
							local ex, ey, ez = getElementPosition(elements)
							if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 2.5 then
								c = 0
								setElementData(peds, "Rotating", true)
								local rand = math.random(0, 1)
								local module = "positive"
								local executed = 0
								if rand == 0 then
									module = "negative"
								end
								setTimer(
									function()
										if isElement(peds) == false then return end
										executed = executed + 1
										local rot = getPedRotation(peds)
										if module == "positive" then
											setPedRotation(peds, rot + 10)
										else
											setPedRotation(peds, rot - 10)
										end
										if executed == 9 then
											setElementData(peds, "Rotating", false)
										end
									end
								, 50, 9)
							end
						end
						if c == 1 then
							local rot = getPedRotation(peds)
							local rand = math.random(0, 1)
							setElementData(peds, "Rotating", true)
							local module = "positive"
							local executed = 0
							if rand == 0 then
								module = "negative"
							end
							setTimer(
								function()
									if isElement(peds) == false then return end
									executed = executed + 1
									local rot = getPedRotation(peds)
									if module == "positive" then
										setPedRotation(peds, rot + math.random(5, 10))
									else
										setPedRotation(peds, rot - math.random(5, 10))
									end
									if executed == 5 then
										setElementData(peds, "Rotating", false)
									end
								end
							, 50, 5)
						end
					end
				end
			end
		end
	end
, 750, 0)