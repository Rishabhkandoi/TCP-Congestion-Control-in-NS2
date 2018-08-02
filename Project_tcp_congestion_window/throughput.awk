BEGIN {
	startTime = 0;
	endTime = 0;
	TotalPktRec = 0;
	throughput = 0;
	
	startTime1 = 0;
		
	endTime1 = 0;
	endTime2 = 0;
	endTime3 = 0;
	endTime4 = 0;
	endTime5 = 0;
	endTime6 = 0;
	endTime7 = 0;
	endTime8 = 0;
	endTime9 = 0;
	endTime10 = 0;
	
	TotalPktRec1 = 0;
	TotalPktRec2 = 0;
	TotalPktRec3 = 0;
	TotalPktRec4 = 0;
	TotalPktRec5 = 0;
	TotalPktRec6 = 0;
	TotalPktRec7 = 0;
	TotalPktRec8 = 0;
	TotalPktRec9 = 0;
	TotalPktRec10 = 0;
	
	throughput1 = 0;
	throughput2 = 0;
	throughput3 = 0;
	throughput4 = 0;
	throughput5 = 0;
	throughput6 = 0;
	throughput7 = 0;
	throughput8 = 0;
	throughput9 = 0;
	throughput10 = 0;
}

{
	event = $1;
	time = $2;
	from = $3;
	to = $4;
	pktSize = $6;
	flow_id = $8;
	seq_no = $11;
	
	if (seq_no == 0)
		startTime = time;
	
	if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
	{
		endTime = time;
		TotalPktRec += pktSize;
	}
	
	if (time < 35)
	{
		if (seq_no == 0)
			startTime1 = time;
	
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime1 = time;
			TotalPktRec1 += pktSize;
		}
		
	}
	else if (time >=35 && time < 40)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime2 = time;
			TotalPktRec2 += pktSize;
		}
	}
	else if (time >=40 && time < 45)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime3 = time;
			TotalPktRec3 += pktSize;
		}
	}
	else if (time >=45 && time < 50)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime4 = time;
			TotalPktRec4 += pktSize;
		}
	}
	else if (time >=50 && time < 55)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime5 = time;
			TotalPktRec5 += pktSize;
		}
	}
	else if (time >=55 && time < 60)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime6 = time;
			TotalPktRec6 += pktSize;
		}
	}
	else if (time >=60 && time < 65)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime7 = time;
			TotalPktRec7 += pktSize;
		}
	}
	else if (time >=65 && time <67)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime8 = time;
			TotalPktRec8 += pktSize;
		}
	}
	else if (time >=67 && time <69)
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime9 = time;
			TotalPktRec9 += pktSize;
		}
	}
	else
	{
		if ((event = "r") && ((to == 3) || (to == 4) || (to == 5)) && (seq_no > 0))   #since seq_no = -1 for ping
		{
			endTime10 = time;
			TotalPktRec10 += pktSize;
		}
	}
}

END {
	throughput = (TotalPktRec * 8)/(endTime - startTime);  #in bits/sec

	throughput1 = (TotalPktRec1 * 8)/(endTime1 - startTime1);  #in bits/sec
	throughput2 = ((TotalPktRec2) * 8)/(endTime2 - 35);  #in bits/sec
	throughput3 = ((TotalPktRec3) * 8)/(endTime3 - 40);  #in bits/sec
	throughput4 = ((TotalPktRec4) * 8)/(endTime4 - 45);  #in bits/sec
	throughput5 = ((TotalPktRec5) * 8)/(endTime5 - 50);  #in bits/sec
	throughput6 = ((TotalPktRec6) * 8)/(endTime6 - 55);  #in bits/sec
	throughput7 = ((TotalPktRec7) * 8)/(endTime7 - 60);  #in bits/sec
	throughput8 = ((TotalPktRec8) * 8)/(endTime8 - 65);  #in bits/sec
	throughput9 = ((TotalPktRec9) * 8)/(endTime9 - 67);  #in bits/sec
	throughput10 = ((TotalPktRec10) * 8)/(endTime10 - 69);  #in bits/sec

	printf ("\nOverall throughput: %d\n", throughput);
	
	printf ("\nThroughput by intervals:\n");

	printf ("start-35: %d\n",throughput1);
	printf ("35-40:    %d\n",throughput2);
	printf ("40-45:    %d\n",throughput3);
	printf ("45-50:    %d\n",throughput4);
	printf ("50-55:    %d\n",throughput5);
	printf ("55-60:    %d\n",throughput6);
	printf ("60-65:    %d\n",throughput7);
	printf ("65-67:    %d\n",throughput8);
	printf ("67-69:    %d\n",throughput9);
	printf ("69-end:   %d\n\n",throughput10);
}
