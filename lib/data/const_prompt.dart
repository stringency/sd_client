Map<String, String> promptTemplatetest = {
  "简朴雅致":
      "A modern,eye-catching,poster,[a marketing exhibition:0.5],with vibrant colors,dynamic shapes,and an elegant font,The design should include elements related to technology,innovation,and business growth,(background),(panorama),",
  "生动鲜艳":
      "Create an eco-friendly event poster with soft,natural colors like green and blue,incorporating elements such as leaves,trees,and water. Use organic shapes and earthy textures to emphasize sustainability and environmental responsibility. The poster should evoke a sense of calm and connection to nature,appealing to environmentally-conscious attendees,",
  "清新自然":
      "Chinese style,[exhibition poster:0.5],the theme is Chinese culture,simple,elegant and beautiful colors,including painting,landscape,background elements,modern design style,to convey the information of inheriting Chinese culture. Title: Inheriting Chinese culture,(background),(panorama),",
  "其他": "other,",
};
Map<String, String> negativePromptTemplate = {
  "基础反面":
      "blurry,NSFW,text,low quality,lowres,normal quality,bad anatomy,signature,watermark,worstquality,grayscale,bad proportions,out of focus,username,",
  "其他": "other,",
};

Map<String, String> promptSug = {
  "生动文字": "people,",
  "简朴文字": "dog,",
  "细腻文字": "cat,",
};
Map<String, String> negativePromptSug = {
  "商标": "logo,",
  "文字": "text,",
  "水印": "watermark,",
  "单色": "monochrome,",
};

Map<String, String> promptTemplate = {
  "清空提示词": "",
  "产品宣传溅水花": "splash water,flashing particles,depth of field,clean background,",
  "产品宣传展示台":
      "no humans,sky,reflection,scenery,blue theme,star (sky),blue sky,starry sky,cloud,night,night sky,",
  "产品宣传金色纹":
      "(Hyper quality:1.41),High resolution,Extreme Details,Vivid Colors,(masterpiece:1.42),rocks,golden water,golden background,waves,Cosmetic,",
  "营销展会宫崎骏":
      "Anime merchandise promotion poster, featuring popular anime characters and a variety of products such as figurines, posters, toys, and apparel BREAK vibrant colors like red, blue, yellow, and purple to attract attention BREAK dynamic and energetic design, with cartoonish elements and bold text effects, emphasizing creativity and enthusiasm, highly detailed, engaging for anime fans,",
  "营销展会中国龙":
      "(1 dragon:1.5),break,chinese New Year celebration poster,traditional style,festive and joyful atmosphere, red lanterns,",
  "营销展会海报图":
      "DDicon,Transparent Blue,no humans,sky,cloud,scenery,outdoors,linear,line,[runway::cityscape:0.5],magnificent_architecture,blue sky,sun,sunlight,skyscraper,cloudy sky,day,lens flare,cover,",
};
