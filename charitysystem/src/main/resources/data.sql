insert into jwt_user(username,password,usertype) values('1234','$2a$10$yTw3369FSCHUYR73jX3bQOCI6KS20pww1jBOAKT49dxhVMfSB54zy','Collaborator');
insert into jwt_user(username,password,usertype) values('123','$2a$10$yTw3369FSCHUYR73jX3bQOCI6KS20pww1jBOAKT49dxhVMfSB54zy','Donator');


insert into collaborator(full_name,phone_number,address,certificate) values('Nguyễn Văn An','1234','TP HCM','url of certificate');
insert into donator(full_name,phone_number,address) values('Nguyễn Văn An','123','TP HCM');


insert into project_type(project_type_code,project_type_name) values('G2','Gói hỗ trợ dữ án cộng đồng kinh phí thấp');


insert into supported_people(full_name,address,phone_number,bank_account) values('Trần Văn Mạnh','Bình Dương','0723433433','972731252211');
insert into supported_people(full_name,address,phone_number,bank_account) values('Trần Vỹ Minh','Quảng Bình','0242122331','231231532123');
insert into supported_people(full_name,address,phone_number,bank_account) values('Phan Văn Thành','Long An','092312322','454343231233');


insert into project(project_code,project_name,description,start_date,end_date,target_money,video_url,prt_id,stp_id,clb_id) values('G10001','Xây cầu tình thương cho làng An Phú 1','Làng An Phú 1 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-11-05','2021-03-05',40000000,'url of video',1,1,1);
insert into project(project_code,project_name,description,start_date,end_date,target_money,video_url,prt_id,stp_id,clb_id) values('G10002','Xây cầu tình thương cho làng An Phú 2','Làng An Phú 2 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-12-15','2021-04-15',40000000,'url of video',1,1,1);
insert into project(project_code,project_name,description,start_date,end_date,target_money,video_url,prt_id,stp_id,clb_id) values('G10003','Xây cầu tình thương cho làng An Phú 3','Làng An Phú 3 có nhiều sông gòi cần xây cầu cho học sinh đi học hằng ngày','2020-12-30','2021-04-30',40000000,'url of video',1,1,1);

insert into project_images(title,image_url,is_default,order_number,prj_id) values('Chiếc cầu tre tạm bợ tại làng An Phú','url of image',true,1,1);
insert into project_images(title,image_url,is_default,order_number,prj_id) values('Chiếc cầu tre tạm bợ tại làng An Phú','url of image',false,2,1);
insert into project_images(title,image_url,is_default,order_number,prj_id) values('Chiếc cầu tre tạm bợ tại làng An Phú','url of image',false,3,1);

