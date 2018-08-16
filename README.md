# Preprocessing SPM
Matlab preprocessing batches for the encoding **encoding_jobs_d001_akalla.m** and for working memory **WM_jobs_d001_akalla.m**
This files run the same preprocessing JOB in all the runs. The preprocessed output that we are interested on are :  
<br/>
+ ***nocfmri3_Encoding_Ax.nii*** for the encoding
+ ***nocfmri5_task_Ax.nii*** for the working memory task
<br/>

If you want to explore the JOB for a single run in the UI of **SPM**, you can open the **batch_1.m**.

### Job details
+ **Realign: Estimate**
+ **Slice timming**
Session:realigned images dependency
Interleaved in our case [1:2:47 2:2:47]
<br/>
+**Corregister: Estimate**
<br/>
Ref: Sag_T1w3D_BRAVO.nii (structural image: ***you get in when you use dcm2nii in the structurals .dcm***)
<br/>
Source: Slice timing dependency
<br/>
Other images: Slice timing dependency
+ **Corregister:Estimate and reslice**
<br/>
Ref: template.nii (from the encoding_1/bold/001/template.nii). This is the functio
<br/>
Source: Corregistered dependency
<br/>
Other images: Corregistered dependency
+ **Smooth**
<br/>
Resliced Dependency
<br/>
[4 4 4]


<br/>
<br/>

# Preprocessing Freesurfer









