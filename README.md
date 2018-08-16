# Preprocessing SPM
Matlab preprocessing batches for the encoding **encoding_jobs_d001_akalla.m** and for working memory **WM_jobs_d001_akalla.m**

This files run the same preprocessing JOB in all the runs. The preprocessed output that we are interested on are :  
+ ***nocfmri3_Encoding_Ax.nii*** for the encoding
+ ***nocfmri5_task_Ax.nii*** for the working memory task
<br/>

If you want to explore the JOB for a single run in the UI of **SPM**, you can open the **batch_1.m**.

### Job details
+ **Realign: Estimate**

+ **Slice timming**
      <br/>
      Session:realigned images dependency
      <br/>
      Interleaved in our case [1:2:47 2:2:47]
      <br/>

+ **Corregister: Estimate**
      <br/>
      Ref: Sag_T1w3D_BRAVO.nii (structural image: ***you get in when you use dcm2nii in the structurals .dcm***)
      <br/>
      Source: Slice timing dependency
      <br/>
      Other images: Slice timing dependency
      <br/>
     
+ **Corregister:Estimate and reslice**
      <br/>
      Ref: template.nii (from the encoding_1/bold/001/template.nii). This is the functio
      <br/>
      Source: Corregistered dependency
      <br/>
      Other images: Corregistered dependency
      <br/>
     
+ **Smooth**
      <br/>
      Resliced Dependency
      <br/>
      [4 4 4]
 
 

<br/>
<br/>

# Preprocessing Freesurfer

Transfor the .dcm to .nii and move it to the local with
<br/>
The directory structure is the following:
<br/>
/home/david/Desktop/freesurfer/David/encoding/encoding_1, sessidlist
<br/>
/home/david/Desktop/freesurfer/David/encoding/encoding_1/bold, subjectname
<br/>
Check [this](https://surfer.nmr.mgh.harvard.edu/fswiki/FsFastTutorialV5.1/FsFastDirStruct) for more details about structure.

```
scp -r davsan@akalla.cns.ki.se:~/Desktop/Distractor_project/imaging/David/encoding_mapping/run6/fmri3_Encoding_Ax.nii /home/david/Desktop/freesurfer/David/encoding/encoding_1/bold/001/f.nii
```

Run the preprcessesing with the following line
<br/>
```
preproc-sess -s encoding_1 -fsd bold -surface self lhrh -mni305 -fwhm 5 -per-run
```

In case you have more than one session, you would need to register the others to the encoding_1 template with the 
spmregister function

```
Example:

spmregister --fsvol /home/david/Desktop/freesurfer/David/encoding/encoding_1/bold/001/template.nii.gz --mov /home/david/Desktop/freesurfer/David/encoding/encoding_1/bold/002/fmcpr.nii.gz --reg /home/david/Desktop/freesurfer/David/encoding/encoding_1/bold/002/register_templ_enc1.dat --o /home/david/Desktop/freesurfer/David/encoding/encoding_1/bold/002/regfmcpr.nii.gz
```

<br/>
Required Arguments:
<br/>
   --s subjid   or  --fsvol full/path/to.mgz 
   <br/>
   --mov volid  : input/movable volume
   <br/>
   --reg register.dat
   <br/>

Optional Arguments
<br/>
   --frame frameno : reg to frameno (default 0=1st)
   <br/>
   --mid-frame : reg to middle frame (not with --frame)
   <br/>
   --template-out template : save template (good with --frame)
   <br/>
   --fsvol volid : use FreeSurfer volid (default brainmask)
   <br/>
   --force-ras : force input geometry to be RAS
   <br/>
   --o outvol : resample mov and save as outvol
   <br/>

   --tmp tmpdir  : temporary dir (implies --nocleanup)
   <br/>
   --nocleanup  : do not delete temporary files
   <br/>
   --version : print version and exit
   <br/>
   --help    : print help and exit
   <br/>


