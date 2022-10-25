Gitfinal.html: Gitfinal.Rmd finalprojectcode.R output/finalproject1.rds output/finalproject2.rds output/finalproject3.rds
	Rscript renderproject.R 

output/finalproject1.rds output/finalproject2.rds output/finalproject3.rds: finalprojectcode.R data/Smoke2.csv data/Income2.csv
	Rscript finalprojectcode.R
    
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f *.html
	
	

