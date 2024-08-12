Map<String, String> promptTemplatetest = {
  "色彩鲜明":
      "A modern,eye-catching,poster,[a marketing exhibition:0.5],with vibrant colors,dynamic shapes,and an elegant font,The design should include elements related to technology,innovation,and business growth,(background),(panorama),",
  "自然环境":
      "Create an eco-friendly event poster with soft,natural colors like green and blue,incorporating elements such as leaves,trees,and water. Use organic shapes and earthy textures to emphasize sustainability and environmental responsibility. The poster should evoke a sense of calm and connection to nature,appealing to environmentally-conscious attendees,",
  "国风唯美":
      "Chinese style,[exhibition poster:0.5],the theme is Chinese culture,simple,elegant and beautiful colors,including painting,landscape,background elements,modern design style,to convey the information of inheriting Chinese culture. Title: Inheriting Chinese culture,(background),(panorama),",
  "其他": "other,",
};
Map<String, String> negativePromptTemplate = {
  "基础反面":
      "blurry,NSFW,text,low quality,lowres,normal quality,bad anatomy,signature,watermark,worstquality,grayscale,bad proportions,out of focus,username,",
  "其他": "other,",
};

Map<String, String> promptSug = {
  "人": "people,",
  "狗": "dog,",
  "猫": "cat,",
};
Map<String, String> negativePromptSug = {
  "商标": "logo,",
  "文字": "text,",
  "水印": "watermark,",
  "单色": "monochrome,",
};

Map<String, String> promptTemplate = {
  "清空提示词": "",
  "产品宣传溅水花":
      "splash water,flashing particles,depth of field,clean background,",
};
