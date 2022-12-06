Gitfinal.html: Gitfinal.Rmd code/finalprojectcode.R output/finalproject1.rds output/finalproject2.rds output/finalproject3.rds
	Rscript code/renderproject.R 

output/finalproject1.rds output/finalproject2.rds output/finalproject3.rds: code/finalprojectcode.R data/Smoke2.csv data/Income2.csv
	Rscript code/finalprojectcode.R
    
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f *.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"	

