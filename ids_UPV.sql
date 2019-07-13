INSERT INTO Probe(probeId,probeName,password,salt,token) VALUES (10001,"Hot_resource_scalability","n/a","n/a","n/a"),
																(10002,"Resource_scalability","n/a","n/a","n/a"),
                                                                (10003,"Service_availability","n/a","n/a","n/a"),
																(10004,"Service_performance","n/a","n/a","n/a");

INSERT INTO Description(descriptionId,dataType,descriptionName,unit) VALUES (10001,"measurement","used_cpu","%"),
																			(10002,"measurement","free_cpu","%"),
																			(10003,"measurement","used_memory","%"),
																			(10004,"measurement","free_memory","%"),
																			(10005,"measurement","total_cpu","number"),
																			(10006,"measurement","total_memory","bytes"),
																			(10007,"measurement","clues availabilty","%"),
																		    (10008,"measurement","deployment Variation","%");

INSERT INTO Resource(resourceId, resourceName, resourceType, resourceAddress) VALUES (10004,"Cluster","System","n/a"),
																	                 (10005,"CLUES","Service","http://localhost:8000/reports/cluesdata.json?secret=not_very_secret_token");
