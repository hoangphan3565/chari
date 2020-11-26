insert into app_user(username,password,usertype) values('1234','123','Collaborator');
insert into app_user(username,password,usertype) values('123','123','Donator');
insert into app_user(username,password,usertype) values('456','123','Donator');
insert into app_user(username,password,usertype) values('789','123','Donator');


insert into collaborator(full_name,phone_number,address,certificate) values('Nguyễn Minh Anh','1234','TP Hà Nội','url of certificate');
insert into donator(full_name,phone_number,address,favorite_project,avatar_url) values('Trần Văn Mạnh','123','Quận 1, TP Hà Nội','1 2 10 11 ','https://webbachthang.com/wp-content/uploads/2017/12/avatar-la-gi-01.jpg');
insert into donator(full_name,phone_number,address,favorite_project,avatar_url) values('Trần Văn Thường','456','Quận 2, TP HCM','1 3','https://i.pinimg.com/originals/01/48/0f/01480f29ce376005edcbec0b30cf367d.jpg');
--vanquan@donator.chari.com / card number:
insert into donator(full_name,phone_number,address,favorite_project,avatar_url) values('Trần Văn Quân','789','Quận 3, TP HCM','4 6','https://i.pinimg.com/originals/01/48/0f/01480f29ce376005edcbec0b30cf367d.jpg');


insert into project_type(project_type_code,project_type_name) values('G2','Gói hỗ trợ dữ án cộng đồng kinh phí thấp');


insert into supported_people(full_name,address,phone_number,bank_account) values('Nguyễn Thị Yên','Bình Dương','0723433433','972731252211');
insert into supported_people(full_name,address,phone_number,bank_account) values('Nguyễn Thị Thoái','Quảng Bình','0242122331','231231532123');
insert into supported_people(full_name,address,phone_number,bank_account) values('Nguyễn Thị Nhược','Long An','092312322','454343231233');


insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10001','Xây cầu tình thương cho làng An Phú 1','Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày,Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-10-01','2020-11-30',20000000,'https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10002','Xây cầu tình thương cho làng An Phú 2','Làng An Phú 2 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 2 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-10-01','2020-12-01',30000000,'https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10003','Xây cầu tình thương cho làng An Phú 3','Làng An Phú 3 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 3 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10004','Xây cầu tình thương cho làng An Phú 4','Làng An Phú 4 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 4 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10005','Xây cầu tình thương cho làng An Phú 5','Làng An Phú 5 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 5 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10006','Xây cầu tình thương cho làng An Phú 6','Làng An Phú 6 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 6 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10007','Xây cầu tình thương cho làng An Phú 7','Làng An Phú 7 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 7 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10008','Xây cầu tình thương cho làng An Phú 8','Làng An Phú 8 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 8 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G10009','Xây cầu tình thương cho làng An Phú 9','Làng An Phú 9 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 9 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G100010','Xây cầu tình thương cho làng An Phú 10','Làng An Phú 10 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 10 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);
insert into project(project_code,project_name,brief_description,description,start_date,end_date,target_money,image_url,video_url,prt_id,stp_id,clb_id) values('G100011','Xây cầu tình thương cho làng An Phú 11','Làng An Phú 11 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','Làng An Phú 11 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày. Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-01','2021-01-01',40000000,'https://hieuvetraitim.com/attachments/hoan-canh-gioi-thieu-jpg.1782/','https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',1,1,1);

insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',1);
insert into project_images(image_url,prj_id) values('https://i1.wp.com/thanhphohaiphong.gov.vn/wp-content/uploads/2020/10/thien-nguyen-ung-ho-dong-bao-mien-trung-241020.jpg?fit=665%2C443&ssl=1',1);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',1);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',2);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',2);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',2);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',3);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',3);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',3);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',4);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',4);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',4);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',5);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',5);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',5);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',6);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',6);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',6);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',7);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',7);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',7);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',8);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',8);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',8);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',9);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',9);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',9);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',10);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',10);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',10);
insert into project_images(image_url,prj_id) values('https://baoxaydung.com.vn/stores/news_dataimages/vananh/102020/24/12/in_article/5733_image001.jpg',11);
insert into project_images(image_url,prj_id) values('https://media.truyenhinhdulich.vn/upload/news/2127_cau_khi_viet_nam_lot_top_nhung_cay_cau_dang_so_nha.jpg',11);
insert into project_images(image_url,prj_id) values('https://songda6.com.vn/editor/elfinder/files/Hinh%20anh%20DTN/DSC01330.JPG',11);

insert into donate_activity(dnt_id,prj_id) values(1,1);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',5000000,1);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',5000000,1);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',5000000,1);
insert into donate_activity(dnt_id,prj_id) values(1,2);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',5000000,2);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',5000000,2);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',5000000,2);
insert into donate_activity(dnt_id,prj_id) values(1,3);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',5000000,3);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',6000000,3);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',7000000,3);
insert into donate_activity(dnt_id,prj_id) values(1,4);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,4);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,4);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,4);
insert into donate_activity(dnt_id,prj_id) values(1,5);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,5);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,5);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,5);
insert into donate_activity(dnt_id,prj_id) values(1,6);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,6);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,6);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,6);
insert into donate_activity(dnt_id,prj_id) values(1,7);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,7);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,7);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,7);
insert into donate_activity(dnt_id,prj_id) values(1,8);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,8);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,8);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,8);
insert into donate_activity(dnt_id,prj_id) values(1,9);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,9);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,9);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,9);
insert into donate_activity(dnt_id,prj_id) values(1,10);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,10);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,10);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,10);
insert into donate_activity(dnt_id,prj_id) values(1,11);
insert into donate_details(donate_date,money,dna_id) values('2020-11-05',3000000,11);
insert into donate_details(donate_date,money,dna_id) values('2020-11-07',3000000,11);
insert into donate_details(donate_date,money,dna_id) values('2020-11-08',3000000,11);
