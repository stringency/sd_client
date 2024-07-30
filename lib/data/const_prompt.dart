Map<String, String> promptTemplate ={
  "色彩鲜明":"A modern,eye-catching,poster,[a marketing exhibition:0.5],with vibrant colors,dynamic shapes,and an elegant font,The design should include elements related to technology,innovation,and business growth,(background),(panorama),",
  "其他":"other,",
};
Map<String, String> negativePromptTemplate={
  "基础反面":"blurry,NSFW,text,low quality,lowres,normal quality,bad anatomy,signature,watermark,worstquality,grayscale,bad proportions,out of focus,username,",
  "其他":"other,",
};

Map<String, String> promptSug = {
  "人":"people,","狗":"dog,","猫":"cat,",
};
Map<String, String> negativePromptSug = {
  "商标":"logo,","文字":"text,","水印":"watermark,","单色":"monochrome,",
  
};