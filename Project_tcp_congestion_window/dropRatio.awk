BEGIN {
	TotalPktDropped = 0;
	PktDropped1 = 0;
	PktDropped2 = 0;
	PktDropped3 = 0;
	PktDropped4 = 0;
}

{
	event = $1;
	time = $2;
	from = $3;
	to = $4;
	pktSize = $6;
	flow_id = $8;
	seq_no = $11;
	
	if (event == "d" && from == 2)
		TotalPktDropped ++ ;
	
	if (time < 20)
	{
		if (event == "d" && from == 2)
			PktDropped1 ++ ;
	}
	else if (time >=20 && time < 40)
	{
		if (event == "d" && from == 2)
			PktDropped2 ++ ;
	}
	else if (time >=40 && time < 60)
	{
		if (event == "d" && from == 2)
			PktDropped3 ++ ;
	}
	else
	{
		if (event == "d" && from == 2)
			PktDropped4 ++ ;
	}
}

END {
	printf ("\nOverall Packets dropped: %d\n", TotalPktDropped);
	
	printf ("\nPackets dropped by intervals:\n");

	printf ("start-20: %d\n",PktDropped1);
	printf ("20-40:    %d\n",PktDropped2);
	printf ("40-60:    %d\n",PktDropped3);
	printf ("60-end:   %d\n",PktDropped4);
}
