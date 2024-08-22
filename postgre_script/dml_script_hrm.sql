DELETE FROM employee.tblref_position;
INSERT INTO employee.tblref_position(posId, posName)
VALUES('NV','nhân viên'),
('T','trưởng nhóm'),
('P','phó nhóm'),
('QL','quản lý'),
('PQL','phó quản lý'),
('PP','phó phòng'),
('TP','trưởng phòng'),
('GD','giám đốc'),
('PGD','phó giám đốc'),
('TGD','tổng giám đốc'),
('BV','bảo vệ');

DELETE FROM employee.tblref_department;
INSERT INTO employee.tblref_department(depId,depName, depTypeId, depParent,depOrderNo)
VALUES
('SX','sản xuất', 'S', NULL, 0),
('VP','văn phòng', 'S', NULL, 1),
('SXTD','sản xuất tiêu dùng', 'L', 'SX', 2),
('SXXK','sản xuất xuất khẩu', 'L', 'SX', 3),
('TCKT','tài chính-kế toán', 'L', 'VP', 4),
('TD','tuyển dụng', 'L', 'VP', 5),
('KT','kỹ thuật', 'L', 'VP', 6),
('NS','nhân sự', 'L', 'VP', 7),
('KTM','kỹ thuật phần mềm', 'G', 'KT', 8),
('KTC','kỹ thuật phần cứng', 'G', 'KT', 9),
('KTM1','lập trình nhúng', 'T', 'KTM', 10),
('KTM2','lập trình web', 'T', 'KTM', 11),
('KTM11','lập trình nhúng TT', 'P', 'KTM1', 12),
('KTM22','lập trình nhúng TK', 'P', 'KTM1', 13);


--------------------------------------- employee ---------------------------------------------

/* automatic generate employee information */

DROP PROCEDURE IF EXISTS employee.usp_gen_employee;
CREATE PROCEDURE employee.usp_gen_employee( total_employee INT)
LANGUAGE PLPGSQL
AS $$
DECLARE 
	employeeId_max_number INT = COALESCE( (SELECT CAST(MAX(RIGHT(employeeId,LENGTH(employeeId) -3)) AS INT) max_empid FROM employee.tblemployee) + 1, 1);
	employeeId_running INT = 0;
	employeeName_rand_number1 INT = 0;
	employeeName_rand_number2 INT = 0;
	employeeName_rand_number3 INT = 0;
	employeeName VARCHAR(150) = '';
	employedDate_rand_number DATE = NULL;
	employedDate DATE = NULL;
	birthDate_rand_number DATE = NULL;
	birthDate DATE = NULL;
	cellPhone_rand_number CHAR(15) = NULL;
	cellPhone CHAR(15) = NULL;
	address_rand_number_city INT = 0;
	address_rand_number_district INT = 0;
	address_rand_number_ward INT = 0;
	address_rand_number_street INT = 0;
	address VARCHAR(200) = '';
	address_rand_number_city_tmp INT = 0;
	address_rand_number_district_tmp INT = 0;
	address_rand_number_ward_tmp INT = 0;
	address_rand_number_street_tmp INT = 0;
	address_tmp VARCHAR(200) = '';
	isActive_rand_number BOOLEAN = TRUE;
	isActive BOOLEAN = TRUE;
	begin_while INT = 1;
	end_while INT =  total_employee;
BEGIN
	DROP TABLE IF EXISTS tblempname;
	CREATE TEMP TABLE IF NOT EXISTS tblempname( keyid INT, employeeName VARCHAR(150));
	INSERT INTO tblempname(keyid,employeeName) VALUES
	(1 		,'Huy'),(2 		,'Khang'),(3 		,'Bảo'),(4 		,'Minh'),(5 		,'Phúc'),(6 		,'Anh'),(7 		,'Khoa'),(8 		,'Phát'),
	(9 		,'Đạt'),(10 	,'Khôi'),(11 	,'Long'),(12 	,'Nam'),(13 	,'Duy'),(14 	,'Quân'),(15 	,'Kiệt'),(16 	,'Thịnh'),(17 	,'Tuấn'),
	(18 	,'Hưng'),(19 	,'Hoàng'),(20 	,'Hiếu'),(21 	,'Nhân'),(22 	,'Trí'),(23 	,'Tài'),(24 	,'Phong'),(25 	,'Nguyên'),(26 	,'An'),
	(27 	,'Phú'),(28 	,'Thành'),(29 	,'Đức'),(30 	,'Dũng'),(31 	,'Lộc'),(32 	,'Khánh'),(33 	,'Vinh'),(34 	,'Tiến'),(35 	,'Nghĩa'),
	(36 	,'Thiện'),(37 	,'Hào'),(38 	,'Hải'),(39 	,'Đăng'),(40 	,'Quang'),(41 	,'Lâm'),(42 	,'Nhật'),(43 	,'Trung'),(44 	,'Thắng'),
	(45 	,'Tú'),(46 	,'Hùng'),(47 	,'Tâm'),(48 	,'Sang'),(49 	,'Sơn'),(50 	,'Thái'),(51 	,'Cường'),(52 	,'Vũ'),(53 	,'Toàn'),(54 	,'Ân'),
	(55 	,'Thuận'),(56 	,'Bình'),(57 	,'Trường'),(58 	,'Danh'),(59 	,'Kiên'),(60 	,'Phước'),(61 	,'Thiên'),(62 	,'Tân'),(63 	,'Việt'),(64 	,'Khải'),
	(65 	,'Tín'),(66 	,'Dương'),(67 	,'Tùng'),(68 	,'Quý'),(69 	,'Hậu'),(70 	,'Trọng'),(71 	,'Triết'),(72 	,'Luân'),(73 	,'Phương'),(74 	,'Quốc'),
	(75 	,'Thông'),(76 	,'Khiêm'),(77 	,'Hòa'),(78 	,'Thanh'),(79 	,'Tường'),(80 	,'Kha'),(81 	,'Vỹ'),(82 	,'Bách'),(83 	,'Khanh'),(84 	,'Mạnh'),
	(85 	,'Lợi'),(86 	,'Đại'),(87 	,'Hiệp'),(88 	,'Đông'),(89 	,'Nhựt'),(90 	,'Giang'),(91 	,'Kỳ'),(92 	,'Phi'),(93 	,'Tấn'),(94 	,'Văn'),
	(95 	,'Vương'),(96 	,'Công'),(97 	,'Hiển'),(98 	,'Linh'),(99 	,'Ngọc'),(100 	,'Vĩ');
	DROP TABLE IF EXISTS tblempCity;
	CREATE TEMP TABLE IF NOT EXISTS tblempCity(keyid INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), city VARCHAR(150) );
	INSERT INTO tblempCity(city) VALUES('TP. Hà Nội'),('TP. Hồ Chí Minh'),('TP. Hải Phòng'),('TP. Cần Thơ'),('TP. Đà Nẵng'),('TP. Biên Hòa'),('TP. Hải Dương'),
	('TP. Huế'),('TP. Thuận An'),('TP. Thủ Đức');
	DROP TABLE IF EXISTS tblempStreet;
	CREATE TEMP TABLE IF NOT EXISTS tblempStreet(keyid INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), street VARCHAR(150) );
	INSERT INTO tblempStreet(street) VALUES('Chu Văn An'),('Nguyễn Trường Tộ'),('Lê Lai'),('Ngô Quyền'),('Nguyễn Công Trứ'),('Phan Châu Trinh'),('Lê Lợi'),
	('Nguyễn Thái học'),('Trần Hưng Đạo'),('Phan Văn Trị');
	
	employeeId_running = employeeId_max_number;
	WHILE begin_while < end_while + 1 LOOP
		-- rand employeeName
		employeeName_rand_number1 = CEILING(RANDOM() * 100);
		employeeName_rand_number2 = CEILING(RANDOM() * 100);
		employeeName_rand_number3 = CEILING(RANDOM() * 100);
		-- rand employedDate
		employedDate_rand_number = '2000-01-01'::DATE + (CAST(CEILING(RANDOM() * 10000) AS CHAR(10) ) || ' DAYS')::INTERVAL;
		-- rand birthDate
		birthDate_rand_number = '1980-01-01' ::DATE + (CAST(CEILING(RANDOM() * 13000) AS CHAR(10) ) || ' DAYS')::INTERVAL;
		-- rand cellPhone
		cellPhone_rand_number = '0' || CAST(FLOOR(RANDOM() * 1000000000) AS CHAR(10));
		-- address 
		address_rand_number_city = CEILING(RANDOM() * 10);
		address_rand_number_district = CEILING(RANDOM() * 10);
		address_rand_number_ward = CEILING(RANDOM() * 10);
		address_rand_number_street = CEILING(RANDOM() * 10);
		-- address_tmp
		address_rand_number_city_tmp = CEILING(RANDOM() * 10);
		address_rand_number_district_tmp = CEILING(RANDOM() * 10);
		address_rand_number_ward_tmp = CEILING(RANDOM() * 10);
		address_rand_number_street_tmp = CEILING(RANDOM() * 10);
		-- isActive
		isActive_rand_number = CASE WHEN CEILING(RANDOM() * 10) > 5 THEN TRUE ELSE  FALSE END;
		
		INSERT INTO employee.tblemployee(
			employeeId, employeeName, employedDate, birthDate, cellPhone, address, address_tmp, isActive
		)
		VALUES(
			-- employeeId
			CASE WHEN employeeId_running > -1 AND employeeId_running < 10 THEN 'SIV0000' || CAST(employeeId_running AS CHAR(10))
			 WHEN employeeId_running >= 10 AND employeeId_running < 100 THEN 'SIV000' || CAST(employeeId_running AS CHAR(10))
			 WHEN employeeId_running >= 100 AND employeeId_running < 1000 THEN 'SIV00' || CAST(employeeId_running AS CHAR(10))
			 WHEN employeeId_running >= 1000 AND employeeId_running < 10000 THEN 'SIV0' || CAST(employeeId_running AS CHAR(10))
			 WHEN employeeId_running >= 10000 AND employeeId_running < 100000 THEN 'SIV' || CAST(employeeId_running AS CHAR(10)) END,
			-- employeeName
			CONCAT(
				(SELECT E.employeeName FROM tblempname E WHERE keyid = employeeName_rand_number1),' ',
				(SELECT E.employeeName FROM tblempname E WHERE keyid = employeeName_rand_number2),' ',
				(SELECT E.employeeName FROM tblempname E WHERE keyid = employeeName_rand_number3)
			),
			-- employedDate
			employedDate_rand_number,
			-- brithDate
			birthDate_rand_number,
			-- cellPhone
			cellPhone_rand_number,
			-- address
			'số ' || CAST( CEILING(RANDOM() * 1000) AS CHAR(5)) || ' đường ' || (SELECT T.street FROM tblempStreet T WHERE keyid = address_rand_number_street)
			|| ', Phường ' || CAST( address_rand_number_ward AS CHAR(5)) || ', Quận ' ||  CAST( address_rand_number_district AS CHAR(5)) || ', '
			||  (SELECT T.city FROM tblempCity T WHERE keyid = address_rand_number_city),
			-- address_tmp
			'số ' || CAST( CEILING(RANDOM() * 1000) AS CHAR(5)) || ' đường ' || (SELECT T.street FROM tblempStreet T WHERE keyid = address_rand_number_street_tmp)
			|| ', Phường ' || CAST( address_rand_number_ward_tmp AS CHAR(5)) || ', Quận ' ||  CAST( address_rand_number_district_tmp AS CHAR(5)) || ', '
			||  (SELECT T.city FROM tblempCity T WHERE keyid = address_rand_number_city_tmp),
			-- isActive 
			isActive_rand_number
		);
		-- plus 1
		employeeId_running = employeeId_running + 1;
		begin_while = begin_while + 1;
	END LOOP;
	
END;$$;
/* how to use
	CALL employee.usp_gen_employee(5999);
	SELECT * FROM employee.tblemployee;
*/

/* get employee information */

DROP FUNCTION IF EXISTS employee.ufn_get_employee;
CREATE FUNCTION employee.ufn_get_employee(empid CHAR(50), todate DATE)
RETURNS TABLE(
	employeeId CHAR(50),
	employeeName VARCHAR(150),
	employedDate DATE,
	birthDate DATE,
	cellPhone CHAR(15),
	address VARCHAR(200),
	address_tmp VARCHAR(200),
	isActive BOOLEAN ,
	keyid INT 
)
LANGUAGE PLPGSQL
AS $$
DECLARE
	empc RECORD;
BEGIN
	FOR empc IN (
		SELECT E.employeeId, E.employeeName, E.employedDate, E.birthDate, E.cellPhone, E.address, E.address_tmp, E.isActive, E.keyid
		FROM employee.tblemployee E
		WHERE E.employeeId LIKE COALESCE('%'|| empid ||'%', '%' )
			AND E.employedDate < COALESCE(todate + INTERVAL '1 DAY', '2500-01-01'::DATE)
	) LOOP
	employeeId := empc.employeeId;
	employeeName := empc.employeeName;
	employedDate := empc.employedDate;
	birthDate := empc.birthDate;
	cellPhone := empc.cellPhone;
	address := empc.address;
	address_tmp := empc.address_tmp;
	isActive := empc.isActive;
	keyid := empc.keyid;
	RETURN NEXT;
	END LOOP;
END; $$;
/* how to use
	SELECT * FROM employee.ufn_get_employee(null,null);
	SELECT * FROM employee.ufn_get_employee(NULL,'2018-09-01');
*/



--------------------------------------- position ---------------------------------------------

/* automatic generate positions of employees */

DROP PROCEDURE IF EXISTS employee.usp_gen_pos;
CREATE PROCEDURE employee.usp_gen_pos()
LANGUAGE PLPGSQL
AS $$
DECLARE 
	begin_while INT = (SELECT MIN(keyid) FROM employee.tblemployee);
	end_while INT = (SELECT MAX(keyid) FROM employee.tblemployee);
	posId_min_keyid INT = (SELECT MIN(keyid) FROM employee.tblref_position);
	posId_max_keyid INT = (SELECT MAX(keyid) FROM employee.tblref_position);
	posId_rand_number INT = 0;
	employeeId_v CHAR(50) = '';
	employedDate_v DATE = NULL;
	curv CURSOR FOR SELECT employeeId, employedDate FROM employee.tblemployee;
	rec RECORD;
BEGIN
	OPEN curv;
	LOOP
	FETCH NEXT FROM curv INTO rec;
	EXIT WHEN NOT FOUND;
	posId_rand_number = posId_min_keyid + FLOOR(RANDOM() * (posId_max_keyid - posId_min_keyid));
	employeeId_v := rec.employeeId;
	employedDate_v := rec.employedDate;
	
	INSERT INTO employee.tblemppos (employeeId, datechange, posId)
	VALUES(
		-- employeeId
			employeeId_v,
		-- datechange
			employedDate_v,
		-- posId
			(SELECT posId FROM employee.tblref_position WHERE keyid = posId_rand_number)
	);
-- 	RAISE NOTICE 'employeeId: %, employedDate: %', employeeId_v, employedDate_v;
	END LOOP;
	CLOSE curv;
END;$$;

/* how to use
	truncate table employee.tblemppos;
	CALL employee.usp_gen_pos();
	SELECT * FROM employee.tblemppos;
	SELECT * FROM employee.tblref_position;
*/


/*---------------------------CRUD-----------------------*/

/* GET*/
/* get current positions of employees */
DROP FUNCTION IF EXISTS employee.ufn_getcurr_pos;
CREATE FUNCTION employee.ufn_getcurr_pos(todate DATE, employeeId_v CHAR(50))
RETURNS TABLE (
	employeeId CHAR(50) ,
	datechange DATE ,
	posId CHAR(50) ,
	posName VARCHAR(150),
	note VARCHAR(150)
)
LANGUAGE PLPGSQL
AS $$
DECLARE rec RECORD;
--	employeeId CHAR(50) = '';
-- 	datechange DATE = NULL;
-- 	posId CHAR(50) = '';
-- 	posName VARCHAR(150) = '';
-- 	note VARCHAR(150) = '';
BEGIN
	FOR rec IN(
		SELECT p.employeeId , p.datechange, p.posId, ref.posName, p.note
		FROM employee.tblemppos p
		INNER JOIN(
			SELECT p1.employeeId, MAX(p1.datechange) max_date
			FROM employee.tblemppos p1
			WHERE p1.datechange < COALESCE( todate + INTERVAL '1 DAY', '2500-01-01'::DATE)
			AND p1.employeeId LIKE COALESCE('%' || employeeId_v || '%','%')
			GROUP BY p1.employeeId
		)sub ON p.employeeId = sub.employeeId AND p.datechange = sub.max_date
		LEFT JOIN employee.tblref_position ref ON p.posId = ref.posId
	) LOOP
	employeeId := rec.employeeId;
	datechange := rec.datechange;
	posId := rec.posId;
	posName := rec.posName;
	note := rec.note;
 	RETURN NEXT;
	END LOOP;
END; $$;
/* how to use 
	SELECT * FROM employee.ufn_getcurr_pos('2011-01-01',null)
*/


--------------------------------------- department ---------------------------------------------

/* automatic generate department of employees */

DROP PROCEDURE IF EXISTS employee.usp_gen_dep;
CREATE PROCEDURE employee.usp_gen_dep()
LANGUAGE PLPGSQL
AS $$
DECLARE 
	begin_while INT = (SELECT MIN(keyid) FROM employee.tblemployee);
	end_while INT = (SELECT MAX(keyid) FROM employee.tblemployee);
	depId_min_keyid INT = (SELECT MIN(keyid) FROM employee.ufn_get_dep_struct_max_depth());
	depId_max_keyid INT = (SELECT MAX(keyid) FROM employee.ufn_get_dep_struct_max_depth());
	depId_rand_number INT = 0;
	employeeId_v CHAR(50) = '';
	employedDate_v DATE = NULL;
	curv CURSOR FOR SELECT employeeId, employedDate FROM employee.tblemployee;
	rec RECORD;
BEGIN
	OPEN curv;
	LOOP
	FETCH NEXT FROM curv INTO rec;
	EXIT WHEN NOT FOUND;
	depId_rand_number = depId_min_keyid + FLOOR(RANDOM() * (depId_max_keyid - depId_min_keyid));
	employeeId_v := rec.employeeId;
	employedDate_v := rec.employedDate;
	
	INSERT INTO employee.tblempdep (employeeId, datechange, depId)
	VALUES(
		-- employeeId
			employeeId_v,
		-- datechange
			employedDate_v,
		-- posId
			(SELECT primary_depId FROM employee.tblref_deptruct WHERE keyid = depId_rand_number)
	);
-- 	RAISE NOTICE 'employeeId: %, employedDate: %', employeeId_v, employedDate_v;
	END LOOP;
	CLOSE curv;
END;$$;

/* how to use
	truncate table employee.tblempdep;
	CALL employee.usp_gen_dep();
	SELECT * FROM employee.tblempdep;
	SELECT * FROM employee.tblref_department;
*/



/*---------------------------CRUD-----------------------*/

/* GET*/
-- get department structure

DROP FUNCTION IF EXISTS employee.ufn_get_dep_struct;
CREATE FUNCTION employee.ufn_get_dep_struct(
	depId_v CHAR(10)
)
RETURNS TABLE (
	sectionId CHAR(10),
	lineId CHAR(10),
	groupId CHAR(10),
	teamId CHAR(10),
	partId CHAR(10)
)
LANGUAGE PLPGSQL
AS $$
DECLARE 
	 level_number INT = (SELECT orderNo FROM (
	 	SELECT 
			depTypeId,
			ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) orderNo
		FROM
			(
				VALUES('S'),('L'),('G'),('T'),('P')
			)sub(depTypeId)
	 )sub1 WHERE depTypeId = (SELECT depTypeId FROM employee.tblref_department WHERE depId = depId_v));
	 begin_while INT = 1;
	 end_while INT = level_number;
	 depId_running CHAR(10) = depId_v;
	 depId_curr CHAR(10) = (SELECT depParent FROM employee.tblref_department WHERE depId = depId_v);
	 rec RECORD;
BEGIN
	
	-- check first level dep
	DROP TABLE IF EXISTS tbllevel;
	CREATE TEMP TABLE IF NOT EXISTS tbllevel (
		depTypeId CHAR(10),
		orderNo INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
		depId CHAR(10)
	);
	INSERT INTO tbllevel (depTypeId) 
	VALUES('S'),('L'),('G'),('T'),('P');

	DROP TABLE IF EXISTS result;
	CREATE TEMP TABLE IF NOT EXISTS result (
		depId CHAR(10),
		orderNo INT
	);

	
	INSERT INTO result(depId,orderNo) VALUES(depId_v, end_while);
	WHILE  end_while > 0 LOOP
		depId_curr = (SELECT D.depParent FROM employee.tblref_department D WHERE D.depId = depId_running);
		INSERT INTO result(depId, orderNo) VALUES(depId_curr,end_while - 1);
		depId_running = depId_curr;
		end_while = end_while - 1;
	END LOOP;
	
	DROP TABLE IF EXISTS tbl;
	CREATE TEMP TABLE IF NOT EXISTS tbl ( depId CHAR(10), orderNo INT);
	INSERT INTO tbl
	SELECT B.depId, A.orderNo FROM tbllevel A
	LEFT JOIN 
		( SELECT R.* FROM result R WHERE R.depId IS NOT NULL ORDER BY R.orderNo LIMIT 1000) B ON A.orderNo = B.orderNo;

	DROP TABLE IF EXISTS tblref_dep;
	CREATE TEMP TABLE IF NOT EXISTS tblref_dep (sectionId CHAR(50), lineId CHAR(50), groupId CHAR(50), teamId CHAR(50), partId CHAR(50));
	INSERT INTO tblref_dep VALUES(NULL,NULL,NULL,NULL,NULL);
	UPDATE tblref_dep 
	SET sectionId = ( SELECT D.depId FROM tbl D WHERE orderNo = 1 ),
	lineId = ( SELECT D.depId FROM tbl D WHERE orderNo = 2 ),
	groupId = ( SELECT D.depId FROM tbl D WHERE orderNo = 3 ),
	teamId = ( SELECT D.depId FROM tbl D WHERE orderNo = 4 ),
	partId = ( SELECT D.depId FROM tbl D WHERE orderNo = 5 );
	
	FOR rec IN (
		SELECT D.sectionId, D.lineId, D.groupId, D.teamId, D.partId 
		FROM tblref_dep D
	) LOOP
	sectionId := rec.sectionId;
	lineId := rec.lineId;
	groupId := rec.groupId;
	teamId := rec.teamId;
	partId := rec.partId;
	RETURN NEXT;
	END LOOP;
END; $$;


/* how to use
	SELECT  * FROM employee.ufn_get_dep_struct ('KTM22')
*/


/* function get depName */

DROP FUNCTION IF EXISTS employee.ufn_get_dep_struct_withName;
CREATE FUNCTION employee.ufn_get_dep_struct_withName(depId_v CHAR(50))
RETURNS TABLE(
	sectionId CHAR(50),
	sectionName VARCHAR(200),
	lineId CHAR(50),
	lineName VARCHAR(200),
	groupId CHAR(50),
	groupName VARCHAR(200),
	teamId CHAR(50),
	teamName VARCHAR(200),
	partId CHAR(50),
	partName VARCHAR(200)
)
LANGUAGE PLPGSQL
AS $$
DECLARE rec RECORD;
BEGIN
	FOR rec IN (
		SELECT  d.sectionId, d.lineId, d.groupId, d.teamId, d.partId ,
				d1.depName AS sectionName, d2.depName AS lineName, d3.depName AS groupName, d4.depName AS teamName, d5.depName AS partName
		FROM employee.ufn_get_dep_struct (depId_v) d
		LEFT JOIN employee.tblref_department d1 ON d1.depId = d.sectionid
		LEFT JOIN employee.tblref_department d2 ON d2.depId = d.lineId
		LEFT JOIN employee.tblref_department d3 ON d3.depId = d.groupId
		LEFT JOIN employee.tblref_department d4 ON d4.depId = d.teamId
		LEFT JOIN employee.tblref_department d5 ON d5.depId = d.partId
	)LOOP
	sectionId := rec.sectionId;
	sectionName := rec.sectionName;
	lineId := rec.lineId;
	lineName := rec.lineName;
	groupId := rec.groupId;
	groupName := rec.groupName;
	teamId := rec.teamId;
	teamName := rec.teamName;
	partId := rec.partId;
	partName := rec.partName;
	RETURN NEXT;
	END LOOP;
END; $$;
/* how to use
	SELECT * FROM employee.ufn_get_dep_struct_withName('KTM22')
*/

-- get max depth for each department
DROP FUNCTION IF EXISTS employee.ufn_get_dep_struct_max_depth;
CREATE FUNCTION employee.ufn_get_dep_struct_max_depth()
RETURNS TABLE(
	depId CHAR(10),
	keyid INT 
)
LANGUAGE PLPGSQL
AS $$
DECLARE 
	begin_while INT = 1;
	rec RECORD;
BEGIN
	DROP TABLE IF EXISTS tblref_deptmp;
	CREATE TEMP TABLE IF NOT EXISTS tblref_deptmp(
		depId CHAR(10),
		depId1 CHAR(10),
		depId2 CHAR(10),
		depId3 CHAR(10),
		depId4 CHAR(10),
		keyid INT GENERATED ALWAYS AS IDENTITY( START WITH 1 INCREMENT BY 1 )
	);

		INSERT INTO tblref_deptmp 
		SELECT
			D.depId,
			D1.depId depId1,
			D2.depId depId2,
			D3.depId depId3,
			D4.depId depId4
		FROM
			employee.tblref_department D
		LEFT JOIN 
			employee.tblref_department D1 ON D1.depParent = D.depId
		LEFT JOIN 
			employee.tblref_department D2 ON D2.depParent = D1.depId
		LEFT JOIN 
			employee.tblref_department D3 ON D3.depParent = D2.depId
		LEFT JOIN 
			employee.tblref_department D4 ON D4.depParent = D3.depId
		ORDER BY D.depId;

		DROP TABLE IF EXISTS tblcontains;
		CREATE TEMP TABLE IF NOT EXISTS tblcontains(
			sectionId CHAR(10),
			lineId CHAR(10),
			groupId CHAR(10),
			teamId CHAR(10),
			partId CHAR(10),
			keyid INT  GENERATED ALWAYS AS IDENTITY( START WITH 1 INCREMENT BY 1 )
		);

		WHILE begin_while < 6 LOOP
			DROP TABLE IF EXISTS tblcheck_tmp;
			CREATE TEMP TABLE IF NOT EXISTS tblcheck_tmp( depId VARCHAR(10));
			INSERT INTO tblcheck_tmp
			SELECT sub.depId FROM(
							SELECT C.sectionId depId FROM tblcontains C  UNION ALL
							SELECT C.lineId FROM tblcontains C UNION ALL
							SELECT C.groupId FROM tblcontains C UNION ALL
							SELECT C.teamId FROM tblcontains C UNION ALL
							SELECT C.partId FROM tblcontains C
							)sub WHERE sub.depId IS NOT NULL;
			IF(begin_while = 1)
			THEN
			INSERT INTO tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT ref.depId, ref.depId1, ref.depId2, ref.depId3, ref.depId4 FROM tblref_deptmp ref
			WHERE ref.depId4 IS NOT NULL --AND depId3 IS NOT NULL AND depId2 IS NOT NULL AND depId1 IS NOT NULL AND depId IS NOT NULL 
				;
			END IF;
			IF(begin_while = 2)
			THEN
			INSERT INTO tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT ref.depId, ref.depId1, ref.depId2, ref.depId3, ref.depId4 FROM tblref_deptmp ref 
			WHERE ref.depId3 IS NOT NULL --AND depId2 IS NOT NULL AND depId1 IS NOT NULL AND depId IS NOT NULL 
			AND ref.depId3 NOT IN (
					SELECT refs.depId FROM tblcheck_tmp refs
				);
			END IF;
			IF(begin_while = 3)
			THEN
			INSERT INTO tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT ref.depId, ref.depId1, ref.depId2, ref.depId3, ref.depId4 FROM tblref_deptmp ref
			WHERE ref.depId2 IS NOT NULL --AND depId1 IS NOT NULL AND depId IS NOT NULL 
			AND ref.depId2 NOT IN (
					SELECT refs.depId FROM tblcheck_tmp refs
				);
			END IF;
			IF(begin_while = 4)
			THEN
			INSERT INTO tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT ref.depId, ref.depId1, ref.depId2, ref.depId3, ref.depId4 FROM tblref_deptmp ref
			WHERE ref.depId1 IS NOT NULL --AND depId IS NOT NULL 
			AND ref.depId1 NOT IN (
					SELECT refs.depId FROM tblcheck_tmp refs
				);
			END IF;
			IF(begin_while = 5)
			THEN
			INSERT INTO tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT ref.depId, ref.depId1, ref.depId2, ref.depId3, ref.depId4 FROM tblref_deptmp ref
			WHERE ref.depId IS NOT NULL 
			AND ref.depId NOT IN (
					SELECT refs.depId FROM tblcheck_tmp refs
				);
			END IF;

			begin_while = begin_while + 1;
		END LOOP;

		FOR rec IN (
			SELECT	
				CASE WHEN C.partId IS NOT NULL THEN partId 
					 WHEN C.teamId IS NOT NULL THEN teamId
					 WHEN C.groupId IS NOT NULL THEN groupId
					 WHEN C.lineId IS NOT NULL THEN lineId
					 ELSE C.sectionId END depId,
				ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS keyid
			FROM tblcontains C
		) LOOP
		depId := rec.depId;
		keyid := rec.keyid;
		RETURN NEXT;
		END LOOP;
END; $$;

/*	how to use:
	SELECT * FROM employee.ufn_get_dep_struct_max_depth()
*/


-- create data for table employee.tblref_deptruct;

DROP PROCEDURE IF EXISTS employee.usp_insert_dep_struct;
CREATE PROCEDURE employee.usp_insert_dep_struct()
LANGUAGE PLPGSQL
AS $$
DECLARE begin_while INT = 1;
		end_while INT = (SELECT COUNT(*) totalDep FROM employee.ufn_get_dep_struct_max_depth());
BEGIN
	--WHILE begin_while  < end_while LOOP 
	INSERT INTO employee.tblref_deptruct(
		sectionId, sectionName, lineId, lineName, groupId, groupName, teamId, teamName, partId, partName, primary_depId
	)
	SELECT DISTINCT ref.sectionId, ref.sectionName, ref.lineId, ref.lineName, ref.groupId, 
			ref.groupName, ref.teamId, ref.teamName, ref.partId, ref.partName, d.depId
	FROM employee.ufn_get_dep_struct_max_depth() d
	LEFT JOIN LATERAL 
			employee.ufn_get_dep_struct_withName(d.depId) ref ON 1 = 1;
	begin_while = begin_while + 1;
	--END LOOP;
END; $$;
/* how to use
	CALL employee.usp_insert_dep_struct();
	SELECT * FROM employee.tblref_deptruct;
*/


/* get current departments of employees */
DROP FUNCTION IF EXISTS employee.ufn_getcurr_dep;
CREATE FUNCTION employee.ufn_getcurr_dep(todate DATE, employeeId_v CHAR(50))
RETURNS TABLE (
	employeeId CHAR(50) ,
	datechange DATE ,
	sectionId CHAR(50) ,
	sectionName VARCHAR(150),
	lineId CHAR(50) ,
	lineName VARCHAR(150),
	groupId CHAR(50) ,
	groupName VARCHAR(150),
	teamId CHAR(50) ,
	teamName VARCHAR(150),
	partId CHAR(50) ,
	partName VARCHAR(150),
	note VARCHAR(150)
)
LANGUAGE PLPGSQL
AS $$
DECLARE rec RECORD;
BEGIN
	FOR rec IN(
		SELECT d.employeeId , d.datechange, 
				ref.sectionId, ref.sectionName, 
				ref.lineId, ref.lineName, 
				ref.groupId, ref.groupName, 
				ref.teamId, ref.teamName, 
				ref.partId, ref.partName, 
				d.note
		FROM employee.tblempdep d
		INNER JOIN(
			SELECT d1.employeeId, MAX(d1.datechange) max_date
			FROM employee.tblempdep d1
			WHERE d1.datechange < COALESCE(todate + INTERVAL '1 DAY', '2500-01-01'::DATE)
			AND d1.employeeId LIKE COALESCE('%' || employeeId_v || '%','%')
			GROUP BY d1.employeeId
		)sub ON d.employeeId = sub.employeeId AND d.datechange = sub.max_date
		LEFT JOIN employee.tblref_deptruct ref ON d.depId = ref.primary_depId
	) LOOP
	employeeId := rec.employeeId;
	datechange := rec.datechange;
	sectionId := rec.sectionId;
	sectionName := rec.sectionName;
	lineId := rec.lineId;
	lineName := rec.lineName;
	groupId := rec.groupId;
	groupName := rec.groupName;
	teamId := rec.teamId;
	teamName := rec.teamName;
	partId := rec.partId;
	partName := rec.partName;
	note := rec.note;
 	RETURN NEXT;
	END LOOP;
END; $$;
/* how to use 
	SELECT * FROM employee.ufn_getcurr_dep(null,null);
	SELECT * FROM employee.ufn_getcurr_dep(CURRENT_DATE,'SIV00037');
	SELECT * FROM employee.tblempdep WHERE employeeid = 'SIV00037';
	SELECT * FROM employee.tblempdep ORDER BY keyid DESC;
*/

--------------------------------------- account ---------------------------------------------

/*---------------------------CRUD-----------------------*/

-- update 
DROP PROCEDURE IF EXISTS employee.usp_update_account;
CREATE PROCEDURE employee.usp_update_account(
	keyidV INT,
	accountNameV VARCHAR(250),
	emailV VARCHAR(250),
	pwdV VARCHAR(1000)
)
LANGUAGE PLPGSQL
AS $$
BEGIN
	UPDATE employee.tblaccount
	SET accountName = COALESCE(accountNameV, accountName),
		email = COALESCE(emailV, email),
		pwd = COALESCE(pwdV, pwd)
	WHERE keyid = keyidV;

END; $$;

-- delete
DROP PROCEDURE IF EXISTS employee.usp_delete_account;
CREATE PROCEDURE employee.usp_delete_account(keyidV INT)
LANGUAGE PLPGSQL
AS $$
BEGIN
	DELETE FROM employee.tblaccount WHERE keyid = keyidV;
END; $$;


