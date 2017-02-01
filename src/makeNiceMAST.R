# This code is care of Sean Simmons

makeNice<-function(mrk, val="ko_vs_wtwt", comp="H")
{
  mrk_h<-mrk[mrk$datatable.component==comp & mrk$datatable.contrast==val,]
  pval<-mrk_h[,4]
  padj<-p.adjust(pval,"fdr")
  padj_strict<-p.adjust(pval,"BY")
  pval<-cbind(pval,padj)
  pval<-cbind(pval,padj_strict)
  rownames(pval)<-mrk_h[,1]
  mrk_logFC<-mrk[mrk$datatable.component=="logFC",]
  z<-cast(mrk_logFC,formula=datatable.primerid~datatable.component+datatable.contrast,value="datatable.z",fun.aggregate=sum)
  logfc<-cast(mrk_logFC,formula=datatable.primerid~datatable.component+datatable.contrast,value="datatable.coef",fun.aggregate=sum)
  rownames(z)<-z[,1]
  rownames(logfc)<-logfc[,1]

  cls<-colnames(z)
  for(i in 1:length(cls)){cls[i]=paste(cls[i],"_z",sep="")}
  colnames(z)<-cls
  z<-z[2:dim(z)[2]]
  logfc<-logfc[2:dim(logfc)[2]]
  lst<-mrk_h[,1]
  rownames(mrk_h)<-mrk_h[,1]
  ret<-cbind(pval,logfc)
  ret<-ret[order(ret$pval),]
  ret["Gene"]<-rownames(ret)
  ret<-ret[c(dim(ret)[2],1:(dim(ret)[2]-1))]
  return(ret)
}
