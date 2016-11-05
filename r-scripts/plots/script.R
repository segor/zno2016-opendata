library(RODBC)
library(ggplot2)
library(maptools)
library(rgeos)
library(rgdal)
library(ggmap)
library(gridExtra)
library(grid)
library(reshape2)
library(grImport)

# Backup system locale settings
l <- Sys.getlocale()

# Fix for Ukrainian characters
Sys.setlocale('LC_ALL', 'Ukrainian')

sql.server.name <- "RIM"
user.name <- ""
user.login <- ""
db.name <- "zno2016"
con.string <-  paste("driver={SQL Server};server=", sql.server.name,";database=",db.name,";trusted_connection=true", sep = "")
dbhandle <- odbcDriverConnect(con.string)
eit.data <- sqlQuery(dbhandle, 'select * from OpenData2016')

# Fix quotes
eit.data <- as.data.frame(sapply(eit.data, function(x) gsub("\"", "", x)))


# Substract needed data
eit.data.reg.sub <- data.frame(eit.data$Regname, eit.data$UkrBall100, eit.data$HistBall100, 
                               eit.data$MathBall100, eit.data$PhysBall100, eit.data$ChemBall100, 
                               eit.data$BioBall100, eit.data$GeoBall100, eit.data$EngBall100, 
                               eit.data$FrBall100, eit.data$DeuBall100, eit.data$SpBall100, 
                               eit.data$RusBall100)

# Fix factors in numeric columns
for(i in 2:ncol(eit.data.reg.sub)){eit.data.reg.sub[[i]] <- as.character(eit.data.reg.sub[[i]])}

# Convert "null" to NA
for(i in 2:ncol(eit.data.reg.sub)){eit.data.reg.sub[[i]][eit.data.reg.sub[[i]] == "null"] <- NA}

# Fix numeric columns type
for(i in 2:ncol(eit.data.reg.sub)){eit.data.reg.sub[[i]] <- as.numeric(sub(",", ".", eit.data.reg.sub[[i]], fixed = TRUE))}

# Group data by regions
eit.data.reg <- aggregate(eit.data.reg.sub[, 2:ncol(eit.data.reg.sub)], 
                          by = list(eit.data.reg.sub$eit.data.Regname), FUN = mean, na.rm=TRUE)
colnames(eit.data.reg) <- c("Region", "UkrLngLit", "UkrHist", "Math", "Phys", "Chem", 
                            "Bio", "Geo", "Eng", "Fr", "Deu", "Sp", "Rus")

# Add Crimea and Sevastopol regions
eit.data.reg$Region <- as.character(eit.data.reg$Region)
eit.data.reg <- rbind(eit.data.reg, c("АР Крим", NA, NA, NA, NA,NA, NA, NA))
eit.data.reg <- rbind(eit.data.reg, c("м. Севастополь", NA, NA, NA, NA, NA, NA, NA))
eit.data.reg <- eit.data.reg[order(eit.data.reg$Region) ,]

# Fix numeric columns type
for(i in 2:ncol(eit.data.reg)){eit.data.reg[[i]] <- as.numeric(as.character(eit.data.reg[[i]]))}

states.shp <- readOGR(dsn="resources\\geo\\UKR_adm",layer="UKR_adm1")
states.shp.f <- fortify(states.shp, region = "ID_1")

reg.names.cyr <- eit.data.reg$Region

reg.names.tsl <-  c("AR Krym", "Vinnytska oblast", "Volynska oblast", "Dnipropetrovska oblast",
                    "Donetska oblast", "Zhytomyrska oblast", "Zakarpatska oblast", "Zaporizka oblast",
                    "Ivano-Frankivska oblast", "Kyivska oblast", "Kirovohradska oblast", "Luhanska oblast",
                    "Lvivska oblast", "m. Sevastopol", "m. Kyiv", "Mykolaivska oblast", "Odeska oblast",
                    "Poltavska oblast", "Rivnenska oblast", "Sumska oblast", "Ternopilska oblast",
                    "Kharkivska oblast", "Khersonska oblast", "Khmelnytska oblast", "Cherkaska oblast",
                    "Chernivetska oblast", "Chernihivska oblast")

p4s <- proj4string(states.shp)
oblpts <- c()
for(obl in reg.names.tsl) {
    latlon <- geocode(obl)
    point <- SpatialPoints(latlon, proj4string = CRS(p4s))
    oblpts <- c(oblpts, point)
}

states.shp.f <- fortify(states.shp, region = "ID_1")
reg_ids <- unique(states.shp.f$id)
obl_reg_ids <- c()

for(i in 1:length(oblpts)) {
    point <- oblpts[[i]]
    for(reg_id in reg_ids) {
        reg_indx <- match(c(as.numeric(reg_id)), states.shp@data$ID_1)[1]
        region <- states.shp[reg_indx, ]
        if(gContains(region, point)) {
            obl_reg_ids <- c(obl_reg_ids, reg_id)
            # print(paste(region$NAME_1, strtranslit[[i]],sep = " == "))
        }
    }
}

eit.data.reg.shp <- data.frame(eit.data.reg, obl_reg_ids)
colnames(eit.data.reg.shp)[ncol(eit.data.reg.shp)] <- "id"
merge.shp.coef <- merge(states.shp.f, eit.data.reg.shp, by="id", all.x = TRUE)
eit.data.reg.plot <- merge.shp.coef[order(merge.shp.coef$order), ] 

getMapPlot <- function(data, xColN, yColN, groupColN, fillColN, palette, title, margin){
    plot <- ggplot() + 
        geom_polygon(data = data, 
                     aes(x = data[[xColN]], y = data[[yColN]], group = data[[groupColN]], 
                         fill = data[[fillColN]]), color = "black", size = 0.25) + 
        coord_map()+
        scale_fill_distiller(name = "Оцінка за шкалою 100-200", palette = palette, direction = 1) +
        theme_nothing(legend = TRUE) +
        labs(title = title) + 
        theme(plot.title = element_text(hjust = 1, margin = margin, size = 36),
              legend.title = element_text(size = 20),
              legend.text = element_text(size = 16),
              legend.key.size = unit(2,"cm"),
              legend.position="bottom",
              legend.direction="horizontal") +
        guides(fill = guide_colorbar(title.position = "top", title.hjust = 0.5))
    return(plot)    
}


tlMar <- margin(t = 5, b = 0)
p1 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "UkrHist", "Blues", "Історія України", tlMar)
p2 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Geo", "BuGn", "Географія", tlMar)
p3 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Bio", "PuRd", "Біологія", tlMar)
p4 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Math", "YlGn", "Математика", tlMar)
p5 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Phys", "BuPu", "Фізика", tlMar)
p6 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Chem", "OrRd", "Хімія", tlMar)
p7 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "UkrLngLit", "Reds", "Українська мова та література", tlMar)

png(filename="out\\main_subjects_by_region.png", width = 30, height = 30, units = "in", res = 192)

grid.arrange(p1,p2,p3,p4,p5,p6,p7, ncol=3, 
             top = textGrob("Результати тестів ЗНО 2016 - за регіонами - основні предмети", 
                            gp = gpar(fontsize = 50, font = "bold")), 
             layout_matrix = rbind(c(1,2,3), c(4,5,6), c(7,7,7)))

dev.off()


tlMar <- margin(t = 20, b = -30)

p1 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Eng", "Blues", "Англійська", tlMar)
p2 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Fr", "BuGn", "Французька", tlMar)
p3 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Deu", "PuRd", "Німецька", tlMar)
p4 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Sp", "OrRd", "Іспанська", tlMar)
p5 <- getMapPlot(eit.data.reg.plot, "long", "lat", "group", "Rus", "YlGn", "Російська", tlMar)

png(filename="out\\lang_subjects_by_region.png", width = 30, height = 26, units = "in", res = 192)

grid.arrange(p1,p2,p3,p4,p5, ncol=2, 
             top = textGrob("Результати тестів ЗНО 2016 - за регіонами - іноземні мови", 
                            gp = gpar(fontsize = 50, font = "bold")),
             layout_matrix = rbind(c(1,1), c(2,3), c(4,5)))
dev.off()


# Substract needed data
eit.data.gnd.sub <- data.frame(eit.data$SexTypeName, eit.data$UkrBall100, eit.data$HistBall100, 
                               eit.data$MathBall100, eit.data$PhysBall100, eit.data$ChemBall100, 
                               eit.data$BioBall100, eit.data$GeoBall100, eit.data$EngBall100, 
                               eit.data$FrBall100, eit.data$DeuBall100, eit.data$SpBall100, 
                               eit.data$RusBall100)

# Fix factors in numeric columns
for(i in 2:ncol(eit.data.gnd.sub)){eit.data.gnd.sub[[i]] <- as.character(eit.data.gnd.sub[[i]])}

# Convert "null" to NA
for(i in 2:ncol(eit.data.gnd.sub)){eit.data.gnd.sub[[i]][eit.data.gnd.sub[[i]] == "null"] <- NA}

# Fix numeric columns type
for(i in 2:ncol(eit.data.gnd.sub)){eit.data.gnd.sub[[i]] <- as.numeric(sub(",", ".", eit.data.gnd.sub[[i]], fixed = TRUE))}

# Group data by gender
eit.data.gnd <- aggregate(eit.data.gnd.sub[, 2:ncol(eit.data.gnd.sub)], 
                          by = list(eit.data.gnd.sub$eit.data.SexTypeName), FUN = mean, na.rm = TRUE)
colnames(eit.data.gnd) <- c("Gender", "Українська мова та література", "Історія України", 
                            "Математика", "Фізика", "Хімія", "Біологія", "Географія", 
                            "Англійська", "Французька", "Німецька", "Іспанська", "Російська")
eit.data.gnd.melted <- melt(eit.data.gnd, id.vars=c("Gender"))

# Order factor properly
eit.data.gnd.melted$variable <- factor(eit.data.gnd.melted$variable, 
                                       levels = levels(eit.data.gnd.melted$variable)[12:1], ordered = TRUE)

eit.data.gnd.melted.m <- subset(eit.data.gnd.melted, Gender == "чоловіча")
eit.data.gnd.melted.f <- subset(eit.data.gnd.melted, Gender == "жіноча")

img.male <- pictureGrob(readPicture("resources\\graphics\\male.ps.xml"))
img.female <- pictureGrob(readPicture("resources\\graphics\\female.ps.xml"))

p <- ggplot(data=eit.data.gnd.melted,aes(x=variable, y = value, fill=Gender)) +
    geom_bar(data=eit.data.gnd.melted.f, stat = "identity") + 
    geom_bar(data=eit.data.gnd.melted.m, stat = "identity", position = "identity", 
             mapping = aes(y = -value)) + 
    
    scale_y_continuous(breaks=seq(-200,200,50),labels=abs(seq(-200,200,50))) + 
    geom_text(data = eit.data.gnd.melted.f, 
              aes(variable, value, group=Gender, label=format(value, digits=2, nsmall=2)),
              hjust = 1.25, vjust = 0.5, size=15) +
    geom_text(data = eit.data.gnd.melted.m, 
              aes(variable, -value, group=Gender, label=format(value, digits=2, nsmall=2)),
              hjust = -0.25, vjust = 0.5, size=15) +
    geom_text(data = eit.data.gnd.melted, 
              aes(x = variable, y = 0, label=variable), hjust = 0.5, vjust = 0.5, size=16) +
    coord_cartesian(ylim = c(-1500, 1500)) +
    theme_nothing(legend = FALSE) +
    coord_flip()

png(filename="out\\subjects_by_gender.png", width = 30, height = 10, units = "in", res = 192)

grid.arrange(img.male, p, img.female, ncol=3, widths=c(10, 80, 10), 
             top = textGrob("Результати тестів ЗНО 2016 - за статтю (Оцінка за шкалою 100-200)", 
                            gp = gpar(fontsize = 50, font = "bold")))

dev.off()

# Substract needed data applying age calculation based on EIT year and birth year from data
eit.data.age.sub <- data.frame(eit.data$Birth, eit.data$UkrBall100, eit.data$HistBall100, 
                               eit.data$MathBall100, eit.data$PhysBall100, eit.data$ChemBall100, 
                               eit.data$BioBall100, eit.data$GeoBall100, eit.data$EngBall100, 
                               eit.data$FrBall100, eit.data$DeuBall100, eit.data$SpBall100, 
                               eit.data$RusBall100)

# Fix factors in numeric columns
for(i in 1:ncol(eit.data.age.sub)){eit.data.age.sub[[i]] <- as.character(eit.data.age.sub[[i]])}

# Convert "null" to NA
for(i in 1:ncol(eit.data.age.sub)){eit.data.age.sub[[i]][eit.data.age.sub[[i]] == "null"] <- NA}

# Fix numeric columns type
for(i in 1:ncol(eit.data.age.sub)){eit.data.age.sub[[i]] <- as.numeric(sub(",", ".", eit.data.age.sub[[i]], fixed = TRUE))}

eit.data.age.sub[[1]] <- 2016 - eit.data.age.sub[[1]]

colnames(eit.data.age.sub)[1] <- "Age"


eit.data.age.cnt <- aggregate(eit.data.age.sub$Age, by = list(eit.data.age.sub$Age), FUN = length)
colnames(eit.data.age.cnt) <- c("Age", "Count")

png(filename="out\\count_by_age.png", width = 30, height = 10, units = "in", res = 192)

ggplot(eit.data.age.cnt, aes(x = factor(Age), y = Count)) + 
    geom_bar(stat = "identity") + theme_gray() +
    labs(title = "Розподіл екзаменованих під час ЗНО 2016 за віком", x = "Вік", y = "Кількість") + 
    theme(plot.title = element_text(size = 36),
          axis.title = element_text(size = 20),
          axis.text = element_text(size = 16))
dev.off()

eit.data.age.cut <- eit.data.age.cnt[eit.data.age.cnt$Count/sum(eit.data.age.cnt$Count) > 0.001,]

png(filename="out\\count_by_age_cut.png", width = 30, height = 10, units = "in", res = 192)

ggplot(eit.data.age.cut, aes(x = factor(Age), y = Count)) + 
    geom_bar(stat = "identity") + theme_gray() +
    labs(title = "Розподіл екзаменованих під час ЗНО 2016 за віком - фільтр 0.1 % вибірки", x = "Вік", y = "Кількість") + 
    theme(plot.title = element_text(size = 36),
          axis.title = element_text(size = 20),
          axis.text = element_text(size = 16))
dev.off()

eit.data.age <- aggregate(eit.data.age.sub[, 2:ncol(eit.data.age.sub)], 
                          by = list(eit.data.age.sub$Age), FUN = mean, na.rm=TRUE)

colnames(eit.data.age) <- c("Age", "Українська мова та література", "Історія України", 
                            "Математика", "Фізика", "Хімія", "Біологія", "Географія", 
                            "Англійська", "Французька", "Німецька", "Іспанська", "Російська")

# Apply 0.01 % cut off
eit.data.age <- eit.data.age[eit.data.age$Age %in% eit.data.age.cut$Age,]

eit.data.age.melted <- melt(eit.data.age, id.vars=c("Age"))
eit.data.age.melted$variable <- factor(eit.data.age.melted$variable, levels = levels(eit.data.age.melted$variable)[12:1], ordered = TRUE)

library(cowplot)

hm <- ggplot(data = eit.data.age.melted, aes(x=factor(Age), y=variable, fill=value)) + 
    geom_tile() + 
    scale_fill_distiller(name = "Оцінка за шкалою 100-200", palette = "Blues", direction = 1, na.value = "transparent") +
    scale_x_discrete(breaks=unique(eit.data.age.melted$Age),labels=unique(eit.data.age.melted$Age)) +
    theme_gray() +
    theme(legend.position="bottom",
          legend.direction="horizontal",
          legend.title = element_text(size = 40, margin=margin(20,0,0,0)),
          legend.key.size = unit(3,"cm"),
          legend.text = element_text(size = 30)
    ) +
    guides(fill = guide_colorbar(title.position = "top", title.hjust = 0.5))

eit.data.age.avg <- aggregate(eit.data.age.melted$value, by = list(eit.data.age.melted$Age), 
                              FUN = mean, na.rm=TRUE)
colnames(eit.data.age.avg) <- c("Age", "ScoreAvg")

eit.data.dis.avg <-aggregate(eit.data.age.melted$value, by = list(eit.data.age.melted$variable), 
                             FUN = mean, na.rm=TRUE)
colnames(eit.data.dis.avg) <- c("Discipline", "ScoreAvg")

ageBG <- ggplot(data = eit.data.age.avg, aes(x=factor(Age), y=ScoreAvg)) + 
    geom_bar(stat="identity", aes(fill=ScoreAvg)) + 
    theme_gray() +
    theme(axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.x = element_text(size = 40, margin=margin(20,0,0,0)),
          axis.text.x = element_text(size = 30),
          legend.position="none") +
    scale_fill_distiller(name = "Score", palette = "Blues", direction = 1) + 
    labs(x = "Вік")

ageBGFlip <- switch_axis_position(ageBG, "x")

discBG <- ggplot(data = eit.data.dis.avg, aes(x=Discipline, y=ScoreAvg)) + 
    geom_bar(stat="identity", aes(fill=ScoreAvg)) +
    coord_flip() + 
    theme_gray() +
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y = element_text(size = 40, margin=margin(0,0,0,20), angle = -90),
          axis.text.y = element_text(size = 30),
          legend.position="none") +
    scale_fill_distiller(name = "Score", palette = "Blues", direction = 1) + 
    labs(x = "Предмети")

discBGFlip <- switch_axis_position(discBG, "y")

# Substract legend for heatmap
tmp <- ggplot_gtable(ggplot_build(hm))
leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
legend <- tmp$grobs[[leg]]

# Remove legend from heatmap
hmNoLg <-hm +
    theme(axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          legend.position="none")

#grid.newpage()
gg <- arrangeGrob(ageBGFlip, legend, hmNoLg, discBGFlip, 
                  nrow = 2, ncol = 2, widths = c(50, 30), heights = c(30, 70),
                  padding = c(0,0,0,0))

png(filename="out\\subjects_by_age.png", width = 30, height = 20, units = "in", res = 192)

grid.draw(gg)

dev.off()

detach("package:cowplot", unload=TRUE)

# Restore system locale settings
for(locale.item in strsplit(l, ";")) { 
    li <- strsplit(locale.item, "=")
    Sys.setlocale(category = li[[1]][1], locale = li[[1]][2])
}