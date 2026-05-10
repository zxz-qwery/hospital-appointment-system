CREATE DATABASE hospital_system;
USE hospital_system;

##用户
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    gender VARCHAR(10),
    real_name VARCHAR(50),
    birthday DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

##管理员
CREATE TABLE admins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'admin',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

##科室
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

##医生
CREATE TABLE doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    title VARCHAR(50),
    avatar VARCHAR(255),
    introduction TEXT,
    status TINYINT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

##医生排班
CREATE TABLE schedules (
    id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    schedule_date DATE NOT NULL,
    time_period VARCHAR(20),
    max_number INT DEFAULT 20,
    current_number INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

##预约
CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    schedule_id INT NOT NULL,
    appointment_no VARCHAR(50),
    status VARCHAR(20) DEFAULT '已预约',
    cancel_reason VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(id)
);

##公告
CREATE TABLE announcements (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

##评价
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

##就诊记录
CREATE TABLE medical_records (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT,
    treatment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

##请假表
CREATE TABLE doctor_leaves (
    id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    leave_date DATE,
    time_period VARCHAR(20),
    reason TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

##通知
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(200),
    content TEXT,
    is_read TINYINT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

##操作日志
CREATE TABLE logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    admin_id INT,
    action VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES admins(id)
);

INSERT INTO departments (name, description) VALUES
('内科','负责内科疾病诊疗'),
('外科','负责外科手术治疗'),
('儿科','儿童疾病诊疗'),
('妇科','女性疾病诊疗'),
('骨科','骨骼相关疾病'),
('眼科','眼部疾病诊疗'),
('口腔科','牙科治疗'),
('皮肤科','皮肤疾病治疗'),
('神经科','神经系统疾病'),
('耳鼻喉科','耳鼻喉疾病');

INSERT INTO admins (username,password,role) VALUES
('admin1','123456','admin'),
('admin2','123456','admin'),
('admin3','123456','admin'),
('admin4','123456','admin'),
('admin5','123456','admin'),
('admin6','123456','admin'),
('admin7','123456','admin'),
('admin8','123456','admin'),
('admin9','123456','admin'),
('admin10','123456','admin');

INSERT INTO users (username,password,phone,gender,real_name,birthday) VALUES
('user1','123456','13800000001','男','张三','2000-01-01'),
('user2','123456','13800000002','女','李四','1999-05-03'),
('user3','123456','13800000003','男','王五','2001-02-11'),
('user4','123456','13800000004','女','赵六','1998-07-15'),
('user5','123456','13800000005','男','孙七','2000-03-09'),
('user6','123456','13800000006','女','周八','2002-08-20'),
('user7','123456','13800000007','男','吴九','1997-12-12'),
('user8','123456','13800000008','女','郑十','2003-09-05'),
('user9','123456','13800000009','男','钱一','1999-10-10'),
('user10','123456','13800000010','女','冯二','2001-11-01');

INSERT INTO doctors (name,department_id,title,avatar,introduction,status) VALUES
('李医生',1,'主任医师','doctor1.jpg','内科专家',1),
('王医生',2,'副主任医师','doctor2.jpg','外科专家',1),
('张医生',3,'主治医师','doctor3.jpg','儿科医生',1),
('刘医生',4,'主任医师','doctor4.jpg','妇科专家',1),
('陈医生',5,'主治医师','doctor5.jpg','骨科医生',1),
('杨医生',6,'副主任医师','doctor6.jpg','眼科专家',1),
('赵医生',7,'主治医师','doctor7.jpg','口腔医生',1),
('黄医生',8,'副主任医师','doctor8.jpg','皮肤科专家',1),
('周医生',9,'主任医师','doctor9.jpg','神经科专家',1),
('吴医生',10,'主治医师','doctor10.jpg','耳鼻喉医生',1);

INSERT INTO schedules (doctor_id,schedule_date,time_period,max_number,current_number) VALUES
(1,'2026-04-01','上午',20,5),
(2,'2026-04-01','下午',20,3),
(3,'2026-04-02','上午',20,2),
(4,'2026-04-02','下午',20,1),
(5,'2026-04-03','上午',20,4),
(6,'2026-04-03','下午',20,2),
(7,'2026-04-04','上午',20,3),
(8,'2026-04-04','下午',20,1),
(9,'2026-04-05','上午',20,2),
(10,'2026-04-05','下午',20,1);

INSERT INTO appointments (user_id,doctor_id,schedule_id,appointment_no,status) VALUES
(1,1,1,'A001','已预约'),
(2,2,2,'A002','已预约'),
(3,3,3,'A003','已预约'),
(4,4,4,'A004','已预约'),
(5,5,5,'A005','已预约'),
(6,6,6,'A006','已预约'),
(7,7,7,'A007','已预约'),
(8,8,8,'A008','已预约'),
(9,9,9,'A009','已预约'),
(10,10,10,'A010','已预约');

INSERT INTO announcements (title,content) VALUES
('医院通知1','请按时就诊'),
('医院通知2','疫情期间注意防护'),
('医院通知3','门诊时间调整'),
('医院通知4','新医生入职'),
('医院通知5','节假日安排'),
('医院通知6','体检活动'),
('医院通知7','预约流程说明'),
('医院通知8','健康讲座'),
('医院通知9','疫苗接种通知'),
('医院通知10','门诊公告');

INSERT INTO reviews (user_id,doctor_id,rating,content) VALUES
(1,1,5,'医生非常专业'),
(2,2,4,'服务态度很好'),
(3,3,5,'孩子很喜欢医生'),
(4,4,4,'诊断很准确'),
(5,5,5,'非常满意'),
(6,6,4,'医生耐心'),
(7,7,5,'治疗效果好'),
(8,8,4,'不错'),
(9,9,5,'技术很好'),
(10,10,4,'推荐');

INSERT INTO medical_records (user_id,doctor_id,diagnosis,treatment) VALUES
(1,1,'感冒','开药治疗'),
(2,2,'阑尾炎','手术'),
(3,3,'发烧','退烧药'),
(4,4,'妇科炎症','药物治疗'),
(5,5,'骨折','石膏固定'),
(6,6,'近视','配眼镜'),
(7,7,'牙痛','补牙'),
(8,8,'皮炎','外用药'),
(9,9,'头痛','检查治疗'),
(10,10,'鼻炎','药物治疗');

INSERT INTO doctor_leaves (doctor_id,leave_date,time_period,reason) VALUES
(1,'2026-04-10','上午','休息'),
(2,'2026-04-11','下午','会议'),
(3,'2026-04-12','上午','培训'),
(4,'2026-04-13','下午','家庭事务'),
(5,'2026-04-14','上午','休假'),
(6,'2026-04-15','下午','外出'),
(7,'2026-04-16','上午','会议'),
(8,'2026-04-17','下午','培训'),
(9,'2026-04-18','上午','休假'),
(10,'2026-04-19','下午','会议');

INSERT INTO notifications (user_id,title,content,is_read) VALUES
(1,'预约成功','您的预约已成功',0),
(2,'预约提醒','明天请按时就诊',0),
(3,'预约成功','预约完成',1),
(4,'预约提醒','请提前到达',0),
(5,'预约成功','挂号成功',1),
(6,'预约提醒','请按时就诊',0),
(7,'预约成功','预约成功',1),
(8,'预约提醒','门诊提醒',0),
(9,'预约成功','预约完成',1),
(10,'预约提醒','请按时到医院',0);

INSERT INTO notifications (user_id,title,content,is_read,created_at) VALUES
(11,'预约成功通知','您已成功预约张伟医生，时间：2026-04-02 上午，请提前10分钟到医院报到。',0,'2026-04-01 10:10:00'),

(11,'预约提醒','您预约的李丽医生将于明天上午就诊，请按时前往医院。',0,'2026-04-01 18:20:00'),

(11,'系统通知','医院系统将于今晚23:00进行维护升级，期间部分功能可能无法使用。',1,'2026-03-31 15:30:00'),

(11,'预约成功通知','您已成功预约王强医生，时间：2026-04-03 下午，请提前到达医院候诊。',0,'2026-04-02 09:40:00'),

(11,'就诊提醒','您今天下午预约的赵敏医生，请提前准备好相关检查资料。',1,'2026-04-02 13:10:00'),

(11,'健康提示','近期天气变化较大，请注意保暖，如有不适请及时预约医生。',0,'2026-04-02 20:00:00');

INSERT INTO logs (admin_id,action) VALUES
(1,'新增医生'),
(2,'修改科室'),
(3,'删除公告'),
(4,'新增排班'),
(5,'修改排班'),
(6,'删除用户'),
(7,'新增公告'),
(8,'修改医生信息'),
(9,'查看日志'),
(10,'系统维护');