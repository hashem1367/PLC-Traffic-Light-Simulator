
//CODESYS PROJECT TRAFFIC LIGHT
PROGRAM PLC_PRG

VAR
    RedLight : BOOL := FALSE;
    YellowLight : BOOL := FALSE;
    GreenLight : BOOL := FALSE;
	Countdown: INT:=0;
	ElapsedSeconds : INT := 0;
    Step : INT := 0;
	Timer1 : TON;
	
	RedLight2 : BOOL := FALSE;
	YellowLight2 : BOOL := FALSE;
	GreenLight2 : BOOL := FALSE;
	
	PedestrianRequest : BOOL := FALSE;
	PedestrianGreen : BOOL := FALSE;
	PedestrianRed : BOOL := TRUE;
	
END_VAR


____________________________________________________________


ElapsedSeconds := TO_INT(Timer1.ET) / 1000;

CASE Step OF


//--------------------------------------------------
// STEP 0 -> Vertical Green
//--------------------------------------------------

0:

    Countdown := 10 - ElapsedSeconds;

    GreenLight := TRUE;
    YellowLight := FALSE;
    RedLight := FALSE;

    GreenLight2 := FALSE;
    YellowLight2 := FALSE;
    RedLight2 := TRUE;

    PedestrianGreen := FALSE;
    PedestrianRed := TRUE;

    Timer1(IN := TRUE, PT := T#10s);

    IF Timer1.Q THEN
        Timer1(IN := FALSE);
        Step := 1;
    END_IF;


//--------------------------------------------------
// STEP 1 -> Vertical Yellow
//--------------------------------------------------

1:

    Countdown := 2 - ElapsedSeconds;

    GreenLight := FALSE;
    YellowLight := TRUE;
    RedLight := FALSE;

    GreenLight2 := FALSE;
    YellowLight2 := FALSE;
    RedLight2 := TRUE;

    PedestrianGreen := FALSE;
    PedestrianRed := TRUE;

    Timer1(IN := TRUE, PT := T#2s);

    IF Timer1.Q THEN
        Timer1(IN := FALSE);
        Step := 2;
    END_IF;


//--------------------------------------------------
// STEP 2 -> ALL RED
//--------------------------------------------------

2:

    Countdown := 1;

    GreenLight := FALSE;
    YellowLight := FALSE;
    RedLight := TRUE;

    GreenLight2 := FALSE;
    YellowLight2 := FALSE;
    RedLight2 := TRUE;

    PedestrianGreen := FALSE;
    PedestrianRed := TRUE;

    Timer1(IN := TRUE, PT := T#1s);

    IF Timer1.Q THEN
        Timer1(IN := FALSE);
        Step := 3;
    END_IF;


//--------------------------------------------------
// STEP 3 -> Horizontal Green
//--------------------------------------------------

3:

    Countdown := 10 - ElapsedSeconds;

    GreenLight := FALSE;
    YellowLight := FALSE;
    RedLight := TRUE;

    GreenLight2 := TRUE;
    YellowLight2 := FALSE;
    RedLight2 := FALSE;

    PedestrianGreen := FALSE;
    PedestrianRed := TRUE;

    Timer1(IN := TRUE, PT := T#10s);

    IF Timer1.Q THEN
        Timer1(IN := FALSE);
        Step := 4;
    END_IF;


//--------------------------------------------------
// STEP 4 -> Horizontal Yellow
//--------------------------------------------------

4:

    Countdown := 2 - ElapsedSeconds;

    GreenLight := FALSE;
    YellowLight := FALSE;
    RedLight := TRUE;

    GreenLight2 := FALSE;
    YellowLight2 := TRUE;
    RedLight2 := FALSE;

    PedestrianGreen := FALSE;
    PedestrianRed := TRUE;

    Timer1(IN := TRUE, PT := T#2s);

    IF Timer1.Q THEN
        Timer1(IN := FALSE);
        Step := 5;
    END_IF;


//--------------------------------------------------
// STEP 5 -> ALL RED
//--------------------------------------------------

5:

    Countdown := 1;

    GreenLight := FALSE;
    YellowLight := FALSE;
    RedLight := TRUE;

    GreenLight2 := FALSE;
    YellowLight2 := FALSE;
    RedLight2 := TRUE;

    PedestrianGreen := FALSE;
    PedestrianRed := TRUE;

    Timer1(IN := TRUE, PT := T#1s);

    IF Timer1.Q THEN

        Timer1(IN := FALSE);

        IF PedestrianRequest THEN
            Step := 6;
        ELSE
            Step := 0;
        END_IF;

    END_IF;


//--------------------------------------------------
// STEP 6 -> Pedestrian Crossing
//--------------------------------------------------

6:

    Countdown := 5 - ElapsedSeconds;

    GreenLight := FALSE;
    YellowLight := FALSE;
    RedLight := TRUE;

    GreenLight2 := FALSE;
    YellowLight2 := FALSE;
    RedLight2 := TRUE;

    PedestrianGreen := TRUE;
    PedestrianRed := FALSE;

    Timer1(IN := TRUE, PT := T#5s);

    IF Timer1.Q THEN

        Timer1(IN := FALSE);

        PedestrianGreen := FALSE;
        PedestrianRed := TRUE;

        PedestrianRequest := FALSE;

        Step := 0;

    END_IF;

END_CASE;
