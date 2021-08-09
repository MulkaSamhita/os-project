#include<stdio.h> 
#include<conio.h>
	


	main() 
	{	
	
		int processIndicator = 0;
		int processWait = 0;
		int processTUT = 0;
		int ProcessNumber,numberNO,CurrentTime,remainingProcesses,timeQuantum;
		int timeART[10],busTime[10],remainingTime[10];
		int j,x=1;
		
		
		printf("Enter for how many processes do you want to check --> "); 
		scanf("%d",&numberNO);
		remainingProcesses = numberNO;
		
	
		printf("Now enter the arrival time and bus time of each processes -->\n");
		for(ProcessNumber = 0;ProcessNumber < numberNO;ProcessNumber++) 
		{
	
			printf("Arrival time of process P%d = ",ProcessNumber+1); 
			scanf("%d",&timeART[ProcessNumber]);
			printf("Burst time of process P%d = ",ProcessNumber+1); 
			scanf("%d",&busTime[ProcessNumber]); 
			remainingTime[ProcessNumber]=busTime[ProcessNumber]; 
			printf("\n");
		} 
	printf("let's see the details of time quantum we declared, it as follows -->:\n");
		printf("For the first round time quantum is --> 3.\n"); 
		timeQuantum=3;         // Time quantum is -> 3
		CurrentTime=0;
		for(ProcessNumber=0;remainingProcesses!=0;) 
		{
			if(remainingTime[ProcessNumber]<=timeQuantum && remainingTime[ProcessNumber]>0)
			{ 
				CurrentTime+=remainingTime[ProcessNumber]; 
				remainingTime[ProcessNumber]=0; 
				processIndicator=1; 
			} 
			else if(remainingTime[ProcessNumber]>0)
			{ 
				remainingTime[ProcessNumber]-=timeQuantum; 
				CurrentTime+=timeQuantum; 
			} 
	if(remainingTime[ProcessNumber]==0 && processIndicator==1)			
			{ printf("%d",ProcessNumber);
				remainingProcesses--;				
				printf("P %d",ProcessNumber+1); 
				printf("\t\t\t%d",CurrentTime-timeART[ProcessNumber]);
				printf("\t\t\t%d\n",CurrentTime-busTime[ProcessNumber]-timeART[ProcessNumber]);
				processWait+=CurrentTime-timeART[ProcessNumber]-busTime[ProcessNumber]; 
				processTUT+=CurrentTime-timeART[ProcessNumber]; 
				processIndicator=0; 
	                     } 
			if(ProcessNumber==numberNO-1){
				x++;
				if(x==2){
					ProcessNumber=0;
					timeQuantum=6;                  // now the Time Quantum is -> 6.
					
					printf("For the second round time quantum is --> 6. \n");
				}
				else{
					break;
				}
			}
			else if(CurrentTime >= timeART[ProcessNumber+1]){
				ProcessNumber++;
			}
			else{
				ProcessNumber=0;
			}
		}
		
		functionRR(numberNO,remainingTime,CurrentTime,timeART,busTime);
		
		return 0;
	}
	


	void functionRR(int numberNO,int remainingTime[10],int CurrentTime,int timeART[10], int busTime[10]){
		
	// Variable declaration inside the function and assignment -->
		int n=numberNO;
		int total=0;
		int locationMethod;
		int temporaryVariable,busTimeMethod[20],ProcessNumber[20],waitingTimeMethod[20],turnAroundTime[20];
	    float averageWait;
		float averageTurnAroundTime;
	    
	    printf("Third round is the round with least burst time.....\n");
	    
	    
	    int i=0;
	    
	    for(i=0;i<n;i++)
	    {
	        busTimeMethod[i]=remainingTime[i];
	        waitingTimeMethod[i]=CurrentTime-timeART[i]-busTimeMethod[i];
			ProcessNumber[i]=i+1;
	    }
	    
	    int j=0;
		
	    for(i=0;i<n;i++)
	    {
	        locationMethod=i;
	        for(j=i+1;j<n;j++)
	        {
	            if(busTimeMethod[j]<busTimeMethod[locationMethod]){
	            	locationMethod=j;
	            }
	        }
	        temporaryVariable=busTimeMethod[i];
	        busTimeMethod[i]=busTimeMethod[locationMethod];
	        busTimeMethod[locationMethod]=temporaryVariable;
	        temporaryVariable=ProcessNumber[i];
	        ProcessNumber[i]=ProcessNumber[locationMethod];
	        ProcessNumber[locationMethod]=temporaryVariable;
	    }
		
	    for(i=1;i<n;i++)
	    {
	        for(j=0;j<i;j++){
	        	waitingTimeMethod[i]+=busTimeMethod[j];
	        }
	        total+=waitingTimeMethod[i];
	    }
	 
	    averageWait=(float)total/n;
	    total=0;
	    printf("\nProcess Number\t\tBurst time of Process\t\twaiting time of Process\t\tTurnaround Time of Process");
	    for(i=0;i<n;i++)
	    {
	        turnAroundTime[i]=busTimeMethod[i]+waitingTimeMethod[i];
	        total=total + turnAroundTime[i];
	        printf("\nP%d\t\t\t\t%d\t\t\t\t%d\t\t\t\t%d",ProcessNumber[i],busTimeMethod[i],waitingTimeMethod[i],turnAroundTime[i]);
	    }
	    averageTurnAroundTime=(float)total/n;
	    printf("\n\nPrcoess's Average calculated waiting time is -->  %f",averageWait);
	    printf("\n Process's Average calculated turnaround time is -->  %f\n",averageTurnAroundTime);
		
	}


