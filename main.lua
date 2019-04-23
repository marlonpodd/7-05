-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--background
display.setDefault( "background", 100/255, 100/255, 200/255 )

-- Gravity

local physics = require( "physics" )

physics.start()
physics.setGravity( 0, 25 ) -- ( x, y )
physics.setDrawMode( "hybrid" )   -- Shows collision engine outlines only


--leftwall
local leftWall = display.newRect( 0, display.contentHeight / 2, 1, display.contentHeight )
-- myRectangle.strokeWidth = 3
-- myRectangle:setFillColor( 0.5 )
-- myRectangle:setStrokeColor( 1, 0, 0 )
leftWall.alpha = 0.0
leftWall.id = "left wall"
physics.addBody( leftWall, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )
--local rightWall = display.newRect( 400, 0, display.contentHeight / 3 , display.contentHeight + 400 )


--ground
local theGround = display.newImage( "./assets/land.png" )
theGround.x = - 190
theGround.y = 480
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local dynamite = display.newImageRect( "./assets/dynamite.png", 50, 50 )
dynamite.x = 190
dynamite.y = 100
dynamite.id = "dynamite"
physics.addBody( dynamite, "dynamic", { 
    friction = 0.5, 
    bounce = 0.3 
    } )


--charater
local waluigi = display.newImageRect( "./assets/tpose.png", 250, 250 )
waluigi.x = display.contentCenterX
waluigi.y = 200
waluigi.id = "the character"
physics.addBody( waluigi, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )
waluigi.isFixedRotation = true

-- Character move
local dPad = display.newImageRect( "./assets/d-pad.png", 200, 200 )
dPad.x = 160
dPad.y = 400
dPad.id = "d-pad"

local upArrow = display.newImageRect( "./assets/upArrow.png", 45, 35 )
upArrow.x = 160
upArrow.y = 325
upArrow.id = "up arrow"

local downArrow = display.newImageRect( "./assets/downArrow.png", 45, 35 )
downArrow.x = 160
downArrow.y = 475
downArrow.id = "down arrow"

local leftArrow = display.newImageRect( "./assets/leftArrow.png", 35, 45 )
leftArrow.x = 85
leftArrow.y = 400
leftArrow.id = "left arrow"

local rightArrow = display.newImageRect( "./assets/rightArrow.png", 35, 45 )
rightArrow.x = 235
rightArrow.y = 400
rightArrow.id = "right arrow"

local jumpButton = display.newImageRect( "./assets/jumpButton.png", 50, 50 )
jumpButton.x = 160
jumpButton.y = 400
jumpButton.id = "right arrow"


--functions 
function upArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( waluigi, { 
        	x = 0, -- move 0 in the x direction 
        	y = -50, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function downArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( waluigi, { 
        	x = 0, -- move 0 in the x direction 
        	y = 50, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( waluigi, { 
        	x = -50, -- move 0 in the x direction 
        	y = 0, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( waluigi, { 
        	x = 50, -- move 0 in the x direction 
        	y = 0, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- make the character jump
        waluigi:setLinearVelocity( 0, -750 )
    end

    return true
end

local function characterCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
        if event.other.id == "dynamite" then
            print("yeet")
        end
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

function checkCharacterPosition( event )
    -- check every frame to see if character has fallen
    if waluigi.y > display.contentHeight + 500 then
        waluigi.x = display.contentCenterX
        waluigi.y = display.contentCenterY
    end
end

upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
leftArrow:addEventListener( "touch", leftArrow )
rightArrow:addEventListener( "touch", rightArrow )
jumpButton:addEventListener( "touch", jumpButton )
Runtime:addEventListener( "enterFrame", checkCharacterPosition )

waluigi.collision = characterCollision
waluigi:addEventListener( "collision" )