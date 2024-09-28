$fn=200;

switchLength=13.5;
switchWidth=9;
switchBodyHeight=10.3;
switchWiresHeight=5.4;
ledRadius=1.5+0.1;
connectorSlotRadius=1.5;
boltRadius=2;

boxLength = 60;
boxWidth= 40;
boxHeight = switchBodyHeight+switchWiresHeight+4;
boxThickness = 1.5;

connectorSlots = 6;

module box()
{
    difference()
    {
        cube([boxLength, boxWidth, boxHeight]); 
        translate([boxThickness,boxThickness,boxThickness])
        {
            cube([boxLength-boxThickness*2, boxWidth-boxThickness*2, boxHeight-boxThickness]); 
        }
    };
}

module lid()
{
    cube([boxLength, boxWidth, boxThickness]);
    difference()
    {
        translate([boxThickness,boxThickness,boxThickness])
        {
            cube([boxLength-boxThickness*2, boxWidth-boxThickness*2, boxThickness]);
        };
        translate([boxThickness*2, boxThickness*2, boxThickness])
        {
            cube([boxLength-boxThickness*4, boxWidth-boxThickness*4, boxThickness]);
        };
    }
}

module switch()
{
    cube([switchLength, switchWidth, switchBodyHeight], center=true);
}

module led()
{
    cylinder(boxThickness*2,ledRadius,ledRadius);
}

module bolt()
{
    rotate([90, 0, 0])
    {
        cylinder(boxThickness*2,boltRadius,boltRadius, center=true);
    }
}

module connectorSlot()
{
    rotate([90, 0, 0])
    {
        cylinder(boxThickness*2,connectorSlotRadius,connectorSlotRadius, center=true);
    }
}

difference()
{
    box();
    translate([boxLength*0.25, boxWidth, boxHeight/2])
    {
        bolt();
    }
    translate([boxLength*0.75, boxWidth, boxHeight/2])
    {
        bolt();
    }
    
    for ( i = [0 : 5] )
    {
        translate([boxLength*(i+1)/(connectorSlots+1), 0, boxHeight/2])
        connectorSlot();
    }
}

translate([0, -boxWidth-10, 0])
{
    difference()
    {
        lid();
        translate([boxLength/2, boxWidth/2, 0])
        {
            rotate([0, 0, 90])
            {
                switch();
            }
        }
        
        translate([boxLength*0.15, boxWidth*0.25, 0])
        {
            led();
        }
        translate([boxLength*0.15, boxWidth*0.75, 0])
        {
            led();
        }
    }
}

