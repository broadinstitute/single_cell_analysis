# The follow code is taken from  the Github Repo BipolarCell2016 written by Karthik Shekhar
# All credit goes to Karthik
# For the original code please see
# https://github.com/broadinstitute/BipolarCell2016/blob/master/class.R

library(ggplot2)
library(reshape)

dot.plot <- function(seurat.obj,
            features.use,
            group.use=NULL,
            subset.group=NULL,
            thresh.use=0,
            max.val.perc=NULL,
            max.val.exp=NULL,
            max.size=10,
            min.perc=0, ...) {

  # Only use the provided names found in the seurat object
  features.use=features.use[features.use %in% rownames(seurat.obj@data)]
  # If groups or names are not used default to seurat@ident
  if (is.null(group.use)) group.use = "ident"

  # Set the group labels
  group.labels = seurat.obj@ident
  names(group.labels) = names(seurat.obj@ident)
  if (group.use != "ident"){
    if (group.use %in% colnames(seurat.obj@data.info)){
      group.labels = seurat.obj@data.info[[group.use]]
      names(group.labels) = rownames(seurat.obj@data.info)
    } else {
      print("Could not find the group in the seurat object. Please check your group.use value.")
      return("Error, did not complete. Code 1")
    }
  }

  # Initialize matrix of percent expressing cells
  PercMat = matrix(0, nrow=length(features.use), ncol = 0)
  rownames(PercMat) = features.use; 
  # Initialize matrix of average transcript levels
  ExpMat = PercMat;
  # Get count mat
  Count.mat = seurat.obj@raw.data[features.use, colnames(seurat.obj@data)]

  # Define the cell groupings
  groupings = unique(group.labels)
  if(!is.null(subset.group)){
    additional.labels = setdiff(subset.group,group.labels)
    if(length(additional.labels) > 0){
        print("Some of the groups in subset.group were not in grouping found for group.use.")
        print(paste(additional.labels, collapse=","))
        print("Please check your group.use and subset.group values.")
        return("Error, did not complete. Code 2")
    }
    groupings = subset.group
  }

  # In each group, for each gene find:
  # The percent expressed over a certain threshold
  # The expectation which is the mean of the non-zero values
  for (label in groupings){
    cells.in.cluster = names(group.labels[group.labels == label])
    vec.exp = apply(seurat.obj@data[features.use, cells.in.cluster], 1,
                    function(x) sum(x>thresh.use)/length(x)) 
    PercMat = cbind(PercMat,vec.exp)
    vec.exp = apply(Count.mat[features.use, cells.in.cluster], 1,
                    function(x) if (sum(x>0) > 1){ mean(x[x>0]) } else {sum(x)})
    ExpMat = cbind(ExpMat, vec.exp)
  }

  # Set the column names as the groups/labels
  colnames(ExpMat) = groupings
  colnames(PercMat) = groupings

  # Use genes that have one entry that meets a min precent threshold
  rows.use = rownames(PercMat)[apply(PercMat, 1, function(x) max(x) >= min.perc)];
  PercMat = PercMat[rows.use,]
  ExpMat = ExpMat[rows.use,]
  features.use = rows.use
  if (!is.null(max.val.perc)) PercMat[PercMat > max.val.perc] = max.val.perc
  if (!is.null(max.val.exp)) ExpMat[ExpMat > max.val.exp] = max.val.exp

  # Prep for ggplots
  ExpVal = melt(ExpMat)
  PercVal = melt(PercMat)
  colnames(ExpVal) = c("gene","cluster","nTrans")
  ExpVal$percExp = PercVal$value*100

  # Plot
  ExpVal$gene = factor(ExpVal$gene, levels=features.use)
  ExpVal$cluster = factor(ExpVal$cluster, levels=rev(groupings))
  p = ggplot(ExpVal,
             aes(y = factor(cluster),
                 x = factor(gene))) +
      geom_point(aes(colour=nTrans, size=percExp)) + 
      scale_color_gradient(low="blue", high="red", limits=c( 1, max(ExpVal$nTrans))) +
      scale_size(range=c(0, max.size)) +
      theme_bw() +
      theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank())
  p = p +
      ylab("Cluster") +
      xlab("Gene") +
      theme(axis.text.x=element_text(size=12, face="italic", angle=45, hjust=1)) + 
      theme(axis.text.y=element_text(size=12, face="italic"))
  print(p)
}
