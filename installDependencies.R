dependencies = readLines('depends.txt')


installed = installed.packages()

install.packages(dependencies[!dependencies %in% installed])

