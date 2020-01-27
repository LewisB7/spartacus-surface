#!/bin/bash
INPUT=$(echo $1 | awk -F_ '{print $1}')
BAND=$(echo $INPUT | awk -F- '{print $1}')
SURF=$(echo $INPUT | awk -F- '{print $2}')
FRAC=$(echo $INPUT | awk -F- '{print $3}')
VREGS=$(echo $INPUT | awk -F- '{print $4}')
STREAMS=$(echo $INPUT | awk -F- '{print $5}')

if [ "$BAND" = vis ]; then
    SSA=0.1301
    if [ "$SURF" = med ]; then
	ALBEDO=0.1217
    elif [ "$SURF" = snw ]; then
	ALBEDO=0.9640
    else
	echo "Surface \"$SURF\" not understood"
	return 1
    fi
elif [ "$BAND" = nir ]; then
    SSA=0.8058
    if [ "$SURF" = med ]; then
	ALBEDO=0.2142
    elif [ "$SURF" = snw ]; then
	ALBEDO=0.5568
    else
	echo "Surface \"$SURF\" not understood"
	return 1
    fi
else
    echo "Band \"$BAND\" not understood"
fi

if [ "$VREGS" ]; then
    VREG="n_vegetation_region_forest=$VREGS"
fi

if [ "$STREAMS" ]; then
    STR="n_stream_forest=$STREAMS"
else
    STR=""
fi

echo vegetation_fraction=$FRAC ground_sw_albedo=$ALBEDO vegetation_sw_ssa=$SSA $VREG $STR
