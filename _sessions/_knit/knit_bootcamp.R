# install.packages("webshot")
# install_phantomjs()

# file paths
from_path = '_sessions/'
to_path = '_sessions/_pdf/'

# htmls to be saved as pdf
htmls = c(
  'Welcome/Welcome.html',
  'IntroToR/IntroToR.html',
  'Data/Data.html',
  'Data/Data_practical.html',
  'Wrangling/Wrangling.html',
  'Wrangling/Wrangling_practical.html',
  'Analysing/Analysing.html',
  'Analysing/Analysing_practical.html',
  'Plotting/Plotting.html',
  'Plotting/Plotting_practical.html',
  'CaseStudies/Financial_Data_Case_Study.html',
  'CaseStudies/Clinical_Data_Case_Study.html',
  'NextSteps/NextSteps.html'
)

# get pdf names
pdfs = stringr::str_replace_all(
  sapply(stringr::str_split(htmls, '/'),`[`,2),
  '.html',
  '.pdf')


# save as pdf
for(i in 1:length(htmls)){
  
  webshot::webshot(paste0(from_path, htmls[i]),
                   paste0(to_path, pdfs[i]),
                   vheight = 900 * .8,
                   vwidth = 1600 * .8)
}

# zip files
zip(paste0(to_path, 'Intro2DataScienceWithR_pdfs.zip'),
    c(paste0(to_path, pdfs), paste0(to_path, 'README.rtf'))
    )

