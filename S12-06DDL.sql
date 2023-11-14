--- CREATE statmenets for initial db design

CREATE TABLE ref_file_types(
    filetype            INT(4),
    description         VARCHAR(45),
    primary key (filetype)
);

CREATE TABLE files(
    fileid              INT(4),
    filename            VARCHAR(45),
    description         VARCHAR(45),
    filelocation        VARCHAR(45),
    filetype            INT(4),
    sumbitdate          DATE,
    uploader            VARCHAR(45),
    primary key (fileid),
    foreign key (filetype) REFERENCES   
        ref_file_types (filetype),
    unique (filelocation, filename)
);

CREATE TABLE ref_coldays(
    day     INT(4),
    primary key (day)
);

CREATE TABLE hoa(
    name                VARCHAR(45),
    streetno            VARCHAR(45),
    streetname          VARCHAR(45),
    barangay            VARCHAR(45),
    city                VARCHAR(45),
    province            VARCHAR(45),
    region              VARCHAR(45),
    zipcode             VARCHAR(45),
    coordx              VARCHAR(45),
    coordy              VARCHAR(45),
    estabyear           DATE,
    website             VARCHAR(45),
    subdname            VARCHAR(45),
    aofincorporation_fileid     INT(4),
    bylaws_fileid       INT(4),
    minutesga_fileid    INT(4),
    attendance_fileid   INT(4),
    certification_fileid        INT(4),
    coethics_fileid     INT(4),
    other_streetno      VARCHAR(45),
    other_streetname    VARCHAR(45),
    other_barangay      VARCHAR(45),
    other_city          VARCHAR(45),
    other_province      VARCHAR(45),
    other_region        VARCHAR(45),
    other_zipcode       VARCHAR(45),
    other_coordx        VARCHAR(45),
    other_coordy        VARCHAR(45),
    regmondues          DECIMAL(9,2),
    regcolday           INT(2),
    primary key (name),
    foreign key (aofincorporation_fileid) REFERENCES
        files (fileid),
    foreign key (bylaws_fileid) REFERENCES
        files (fileid),
    foreign key (minutesga_fileid) REFERENCES
        files (fileid),
    foreign key (attendance_fileid) REFERENCES
        files (fileid),
    foreign key (certification_fileid) REFERENCES
        files (fileid),
    foreign key (coethics_fileid) REFERENCES
        files (fileid),
    foreign key (regcolday) REFERENCES
        ref_coldays (day)
);

CREATE TABLE homeowner(
    homeownerid         INT(4),
    hoaname             VARCHAR(45),
    lastname            VARCHAR(45),
    firstname           VARCHAR(45),
    middlename          VARCHAR(45),
    yearsasho           VARCHAR(45),
    birthday            DATE,
    gender              ENUM('M','F'),
    email               VARCHAR(45),
    fburl               VARCHAR(45),
    undertaking         ENUM('Y', 'N'),
    expression          ENUM('Y', 'N'),
    other_streetno      VARCHAR(45),
    other_streetname    VARCHAR(45),
    other_barangay      VARCHAR(45),
    other_city          VARCHAR(45),
    other_province      VARCHAR(45),
    other_region        VARCHAR(45),
    other_zipcode       INT(4),
    other_coordx        VARCHAR(45),
    other_coordy        VARCHAR(45),
    other_email         VARCHAR(45),
    other_mobileno      INT(12),
    primary key (homeownerid),
    foreign key (hoaname) REFERENCES
        hoa (name)
);

CREATE TABLE homeowner_mobile(
    homeownerid         INT(4),
    mobileno            INT(12),
    primary key (homeownerid, mobileno),
    foreign key (homeownerid) REFERENCES
        homeowner (homeownerid)
);

CREATE TABLE property(
    propertycode        VARCHAR(10),
    homeownerid         INT(4),
    hoaname             VARCHAR(45),
    size                VARCHAR(45),
    turnoverdate        DATE,
    classification      ENUM('R','C'),
    commercialtype      INT(4),
    maximumtentants     INT(2),
    primary key (propertycode),
    foreign key (homeownerid) REFERENCES
        homeowner (homeownerid),
    foreign key (hoaname) REFERENCES
        hoa (name)
);

CREATE TABLE asset(
    assetid             INT(4), -- type changed from VARCHAR to INT to fix type mismatch 
    propertycode        VARCHAR(10),
    assetname           VARCHAR(45),
    description         VARCHAR(45),
    acquisitiondate     DATE,
    forrent             ENUM('Y','N'),
    asset_value         DECIMAL(9,2),
    asset_type          ENUM(''),
    status              ENUM(''),
    lcx                 VARCHAR(45),
    lcy                 VARCHAR(45),
    primary key (assetid),
    foreign key (propertycode) REFERENCES
        property (propertycode)
);

CREATE TABLE contained_assets(
    assetid             INT(4),
    contained_assetid   INT(4),
    primary key (assetid, contained_assetid),
    foreign key (assetid) REFERENCES
        asset (assetid),
    foreign key (contained_assetid) REFERENCES
        asset (assetid)
);

CREATE TABLE household(
    householdid         INT(4),
    propertycode        VARCHAR(10),
    primary key (householdid),
    foreign key (propertycode) REFERENCES
        property (propertycode)
);

CREATE TABLE resident(
    residentid          INT(4),
    homeownerid         INT(4),
    householdid         INT(4),
    isauthorized        ENUM('Y','N'),
    lastname            VARCHAR(45),
    firstname           VARCHAR(45),
    middlename          VARCHAR(45),
    renter              ENUM('Y','N'),
    email               VARCHAR(45),
    birthday            VARCHAR(45),
    gender              ENUM('M','F'),
    mobileno            INT(12),
    fburl               VARCHAR(45),
    picture             VARCHAR(45),
    relationship        VARCHAR(45),
    undertaking         ENUM('Y','N'),
    lastupdatedate      DATE,
    primary key (residentid),
    foreign key (homeownerid) REFERENCES
        homeowner (homeownerid),
    foreign key (householdid) REFERENCES
        household (householdid)
);

CREATE TABLE rental (
    assetid             INT(4),
    residentid          INT(4),
    rentdate            DATE,
    primary key (assetid, residentid, rentdate),
    foreign key (assetid) REFERENCES
        asset (assetid),
    foreign key (residentid) REFERENCES
        resident (residentid)
);

CREATE TABLE vehicle(
    plateno             VARCHAR(7),
    lastname            VARCHAR(45),
    firstname           VARCHAR(45),
    middlename          VARCHAR(45),
    residentid          INT(4), -- changed to INT to fix mismatch
    homeownerid         INT(4), -- changed to INT to fix mismatch
    classification      VARCHAR(45),
    type                VARCHAR(45),
    orcr                VARCHAR(45),
    orcupdated          ENUM('Y', 'N'),
    regdate             DATE,
    regfee              DECIMAL(9,2),
    primary key (plateno),
    foreign key (residentid) REFERENCES
        resident (residentid),
    foreign key (homeownerid) REFERENCES
        homeowner (homeownerid)
);

CREATE TABLE officer(
    homeownerid         INT(4),
    position            ENUM(''),
    electiondate        DATE,
    venue               VARCHAR(45),
    quorum              ENUM('Y','N'),
    witness_lastname    VARCHAR(45),
    witness_firstname   VARCHAR(45),
    witness_middlename  VARCHAR(45),
    witness_mobileno    INT(12),
    startdate           DATE,
    enddate             DATE,
    availdays           VARCHAR(45),
    availtime           ENUM('M', 'A'),
    primary key (homeownerid, position, electiondate),
    foreign key (homeownerid) REFERENCES
        homeowner (homeownerid)
);

CREATE TABLE sticker(
    stickerid            INT(4),
    validityyear         DATE,
    plateno              VARCHAR(7),
    officer_homeownerid  INT(4),
    officer_position     ENUM(''),
    officer_electiondate DATE,
    primary key (stickerid),
    foreign key (plateno) REFERENCES
        vehicle (plateno),
    foreign key (officer_homeownerid, officer_position, officer_electiondate) REFERENCES
        officer (homeownerid, position, electiondate)
);

CREATE TABLE asset_transfer(
    transferid              INT(4),
    scheduleoftransfer      DATE,
    authorizingofficer      INT(4),
    actualdateoftransfer    DATE,
    fromlocation            VARCHAR(45),
    toloaction              VARCHAR(45),
    cost                    DECIMAL(9,2),
    scanndor                VARCHAR(45),
    status                  ENUM('S', 'O', 'C', 'D'),
    transferername          VARCHAR(45),
    transferermobileno      VARCHAR(45),
    assetid                 INT(4),
    primary key (transferid),
    foreign key (authorizingofficer) REFERENCES
        officer (homeownerid),
    foreign key (assetid) REFERENCES 
        asset (assetid)

);

CREATE TABLE residentidcard(
    cardno               INT(4),
    residentid           INT(4),
    cancelled            ENUM('Y','N'),
    requestdate          DATE,
    reason               VARCHAR(45),
    providedate          DATE,
    officer_homeownerid  INT(4),
    officer_position     ENUM(''),
    officer_electiondate DATE,
    ornumber             INT(12),
    cardfee              DECIMAL(9,2),
    primary key (cardno),
    foreign key (residentid) REFERENCES
        resident (residentid),
    foreign key (officer_homeownerid, officer_position, officer_electiondate) REFERENCES
        officer (homeownerid, position, electiondate)
);

CREATE TABLE committee(
    committeeid              INT(4),
    head                    INT(4),
    primary key (committeeid),
    foreign key (head) REFERENCES
        resident (residentid)
);

CREATE TABLE committee_member(
    residentid              INT(4),
    committeeid             INT(4),
    foreign key (residentid) REFERENCES
        resident (residentid),
    foreign key (committeeid) REFERENCES
        committee (committeeid)
);

CREATE TABLE program(
    programid               INT(4),
    description             VARCHAR(45),
    purpose                 VARCHAR(45),
    intendedparticipants    VARCHAR(45),
    sponsoringofficer       INT(4),
    maximumparticipants     INT(3),
    startdate               DATE,
    enddate                 DATE,
    registrationstart       DATE,
    status                  ENUM('O', 'C', 'G', 'L', 'D'),
    handlingcommittee       INT(4),
    program_properexpense   DECIMAL(9,2),
    pre_programexpense      DECIMAL(9,2),
    post_programexpense     DECIMAL(9,2),
    primary key (programid),
    foreign key (sponsoringofficer) REFERENCES
        officer (homeownerid),
    foreign key (handlingcommittee) REFERENCES
        committee (committeeid)
);

CREATE TABLE expenses(
    idexpenses          INT(4),
    dateofexpense       DATE,
    description         VARCHAR(45),
    amount              DECIMAL(9,2),
    incurringmember     INT(4),
    type                SET('P','S','M','O'), 
    scannedor           VARCHAR(45),
    sponsoringofficer   INT(4),
    programid           INT(4),
    primary key (idexpenses),
    foreign key (sponsoringofficer) REFERENCES
        officer (homeownerid),
    foreign key (programid) REFERENCES
        program (programid)
);

CREATE TABLE additional_expenses(
    requestid            INT(4),
    programid            INT(4),
    justification        VARCHAR(45),
    dateofrequest        DATE,
    sponsoringofficer    INT(4),
    status               ENUM('F','A','D'),
    reasonfordisapproval VARCHAR(45),
    primary key (requestid),
    foreign key (programid) REFERENCES
        program (programid),
    foreign key (sponsoringofficer) REFERENCES
        officer (homeownerid)
);

CREATE TABLE evidence(
    evidenceid          INT(4),
    description         VARCHAR(45),
    filename            VARCHAR(45),
    residentsumbitted   VARCHAR(45),
    officeraccepted     VARCHAR(45),
    dateofevidence      DATE,
    programid           INT(4),
    primary key (evidenceid),
    foreign key (programid) REFERENCES
        program (programid)
);

CREATE TABLE registree(
    registreeid         INT(4),
    programid           INT(4),
    registrationdate    DATE,
    acceptance          BOOLEAN,
    walkin              BOOLEAN,
    primary key (registreeid),
    foreign key (registreeid) REFERENCES
        resident (residentid), 
    foreign key (programid) REFERENCES
        program (programid)

);

CREATE TABLE accepted_registree(
    registreeid         INT(4),
    primary key (registreeid),
    foreign key (registreeid) REFERENCES
        registree (registreeid)
);

CREATE TABLE unaccepted_registree(
    registreeid         INT(4),
    rejection_reason    VARCHAR(45),
    primary key (registreeid),
    foreign key (registreeid) REFERENCES
        registree (registreeid)
);

CREATE TABLE walkin(
    registreeid         INT(4),
    memberdiscretion    INT(4),
    primary key (registreeid),
    foreign key (registreeid) REFERENCES
        registree (registreeid),
    foreign key (memberdiscretion) REFERENCES
        committee_member (residentid)
);

CREATE TABLE attendance(
    attendanceid        INT(4),
    programid           INT(4),
    participantid       INT(4),
    feedback            VARCHAR(45),
    rating              INT(3),
    suggestion          VARCHAR(45),
    primary key (attendanceid),
    foreign key (programid) REFERENCES
        program (programid),
    foreign key (participantid) REFERENCES
        registree (registreeid) 
);


-- Insertion of sample data into tables

INSERT INTO ref_file_types (filetype, description)
	VALUES
		(1, 'Image'),
		(2, 'Text'),
		(3, 'PDF');

INSERT INTO files (fileid, filename, description, filelocation, filetype, sumbitdate, uploader)
	VALUES
		(1, 'file1.jpg', 'Image file 1', 'path/to/file1.jpg', 1, '2023-11-01', 'User1'),
		(2, 'file2.txt', 'Text file 2', 'path/to/file2.txt', 2, '2023-11-02', 'User2'),
		(3, 'file3.pdf', 'PDF file 3', 'path/to/file3.pdf', 3, '2023-11-03', 'User3'),
        (4, 'file4.pdf', 'PDF file 4', 'path/to/file4.pdf', 3, '2023-11-03', 'User3'),
        (5, 'file5.pdf', 'PDF file 5', 'path/to/file5.pdf', 3, '2023-11-03', 'User3'),
        (6, 'file6.pdf', 'PDF file 6', 'path/to/file6.pdf', 3, '2023-11-03', 'User3');

INSERT INTO ref_coldays (day)
	VALUES
		(1),
		(2),
		(3);

INSERT INTO hoa (name, streetno, streetname, barangay, city, province, region, zipcode, coordx, coordy, estabyear, website, subdname, aofincorporation_fileid, bylaws_fileid, minutesga_fileid, attendance_fileid, certification_fileid, coethics_fileid, other_streetno, other_streetname, other_barangay, other_city, other_province, other_region, other_zipcode, other_coordx, other_coordy, regmondues, regcolday)
	VALUES
		('HOA 1', '123', 'Main St', 'Barangay 1', 'City 1', 'Province 1', 'Region 1', '12345', 'X1', 'Y1', '2020-01-01', 'hoa1.com', 'Subdivision 1', 1, 2, 3, 4, 5, 6, '456', 'Other St', 'Other Barangay', 'Other City', 'Other Province', 'Other Region', 'Other Zipcode', 'Other X', 'Other Y', 1000.00, 1);

INSERT INTO homeowner (homeownerid, hoaname, lastname, firstname, middlename, yearsasho, birthday, gender, email, fburl, undertaking, expression, other_streetno, other_streetname, other_barangay, other_city, other_province, other_region, other_zipcode, other_coordx, other_coordy, other_email, other_mobileno)
	VALUES
		(1001, 'HOA 1', 'Doe', 'John', 'M.', '5', '1980-01-15', 'M', 'john.doe@example.com', 'https://www.facebook.com/johndoe', 'Y', 'Y', '789', 'Other St', 'Other Barangay', 'Other City', 'Other Province', 'Other Region', '101', 'Other X', 'Other Y', 'other@example.com', 12345612),
		(1002, 'HOA 1', 'Bobby', 'Bob', 'B.', '3', '1999-11-21', 'M', 'bbb.bobby@example.com', 'https://www.facebook.com/b3bob', 'Y', 'Y', '989', 'Some St', 'Some Barangay', 'Some City', 'Some Province', 'Some Region', '102', 'Some X', 'Some Y', 'some@example.com', 12345613);

INSERT INTO homeowner_mobile (homeownerid, mobileno)
	VALUES
		(1001, 12345612);

INSERT INTO property (propertycode, homeownerid, hoaname, size, turnoverdate, classification, commercialtype, maximumtentants)
	VALUES
		('PROP1', 1001, 'HOA 1', '200 sqm', '2023-10-01', 'R', 1, 4);

INSERT INTO asset (assetid, propertycode, assetname, description, acquisitiondate, forrent, asset_value, asset_type, status, lcx, lcy)
	VALUES
		(2002, 'PROP1', 'Asset 1', 'Description 1', '2023-11-01', 'Y', 1000.00, '', '', 'LCX1', 'LCY1'),
		(2003, 'PROP1', 'Asset 2', 'Description 2', '2023-11-02', 'N', 500.00, '', '', 'LCX2', 'LCY2');

INSERT INTO contained_assets (assetid, contained_assetid)
	VALUES
		(2002, 2003);

INSERT INTO household (householdid, propertycode)
	VALUES
		(3008, 'PROP1'),
		(3009, 'PROP1');

INSERT INTO resident (residentid, homeownerid, householdid, isauthorized, lastname, firstname, middlename, renter, email, birthday, gender, mobileno, fburl, picture, relationship, undertaking, lastupdatedate)
	VALUES
		(4007, 1001, 3008, 'Y', 'Doe', 'Jane', 'A.', 'N', 'jane.doe@example.com', '1990-05-20', 'F', 9876108, 'https://www.facebook.com/janedoe', 'avatar.jpg', 'Spouse', 'Y', '2023-11-01'),
		(4008, 1001, 3008, 'Y', 'Smith', 'John', 'B.', 'N', 'john.smith@example.com', '1985-03-15', 'M', 9876109, 'https://www.facebook.com/johnsmith', 'portrait.jpg', 'Spouse', 'Y', '2023-11-01'),
		(4009, 1002, 3009, 'Y', 'Johnson', 'Mary', 'C.', 'N', 'mary.johnson@example.com', '1992-09-10', 'F', 9876100, 'https://www.facebook.com/maryjohnson', 'profile.jpg', 'Spouse', 'Y', '2023-11-01');
		
INSERT INTO rental (assetid, residentid, rentdate)
	VALUES
		(2002, 4007, '2023-11-01');

INSERT INTO vehicle (plateno, lastname, firstname, middlename, residentid, homeownerid, classification, type, orcr, orcupdated, regdate, regfee)
	VALUES
		('ABC123', 'Doe', 'Jane', 'A.', 4007, 1001, 'Sedan', 'Type 1', 'ORCR123', 'Y', '2023-10-01', 5000.00);

INSERT INTO officer (homeownerid, position, electiondate, venue, quorum, witness_lastname, witness_firstname, witness_middlename, witness_mobileno, startdate, enddate, availdays, availtime)
	VALUES
		(1002, '', '2023-10-15', 'Community Center', 'Y', 'Smith', 'Alice', 'R.', 9876109, '2023-10-15', '2023-10-15', 'Mon', 'M'),
		(1001, '', '2023-10-15', 'Community Center', 'Y', 'Jones', 'Bob', 'W.', 9876106, '2023-10-15', '2023-10-15', 'Tue', 'A');

INSERT INTO sticker (stickerid, validityyear, plateno, officer_homeownerid, officer_position, officer_electiondate)
	VALUES
		(5001, '2023-12-31', 'ABC123', 1002, '', '2023-10-15');

INSERT INTO asset_transfer (transferid, scheduleoftransfer, authorizingofficer, actualdateoftransfer, fromlocation, toloaction, cost, scanndor, status, transferername, transferermobileno, assetid)
	VALUES
		(6001, '2023-11-10', 1001, '2023-11-15', 'Location A', 'Location B', 500.00, 'Scan1.jpg', 'S', 'John Doe', '98761095', 2002);

INSERT INTO residentidcard (cardno, residentid, cancelled, requestdate, reason, providedate, officer_homeownerid, officer_position, officer_electiondate, ornumber, cardfee)
	VALUES
		(7001, 4007, 'N', '2023-11-01', 'Lost card', '2023-11-05', 1002, '', '2023-10-15', 12345, 50.00);

INSERT INTO committee (committeeid, head)
	VALUES
		(8001, 4007);

INSERT INTO committee_member (residentid, committeeid)
	VALUES
		(4007, 8001);

INSERT INTO program (programid, description, purpose, intendedparticipants, sponsoringofficer, maximumparticipants, startdate, enddate, registrationstart, status, handlingcommittee, program_properexpense, pre_programexpense, post_programexpense)
	VALUES
		(9001, 'Program 1', 'Purpose 1', 'Intended Participants 1', 1001, 50, '2023-12-01', '2023-12-10', '2023-11-01', 'O', 8001, 1000.00, 200.00, 300.00),
		(9002, 'Program 2', 'Purpose 2', 'Intended Participants 2', 1001, 30, '2023-11-01', '2023-11-10', '2023-10-15', 'C', 8001, 800.00, 150.00, 250.00);

INSERT INTO expenses (idexpenses, dateofexpense, description, amount, incurringmember, type, scannedor, sponsoringofficer, programid)
	VALUES
		(1101, '2023-11-05', 'Expense 1', 500.00, 1, 'P', 'Expense1.jpg', 1001, 9001),
		(1102, '2023-11-05', 'Expense 2', 300.00, 1, 'S', 'Expense2.jpg', 1002, 9002);

INSERT INTO additional_expenses (requestid, programid, justification, dateofrequest, sponsoringofficer, status, reasonfordisapproval)
	VALUES
		(1201, 9002, 'Justification 1', '2023-11-05', 1002, 'F', 'Not approved'),
		(1202, 9001, 'Justification 2', '2023-11-05', 1001, 'A', NULL);

INSERT INTO evidence (evidenceid, description, filename, residentsumbitted, officeraccepted, dateofevidence, programid)
	VALUES
		(1301, 'Evidence 1', 'Evidence1.jpg', 'John Doe', 'Alice Smith', '2023-11-05', 9002),
		(1302, 'Evidence 2', 'Evidence2.jpg', 'Jane Doe', 'Bob Jones', '2023-11-05', 9001);

INSERT INTO registree (registreeid, programid, registrationdate, acceptance, walkin)
	VALUES
		(4008, 9002, '2023-11-05', true, false),
		(4007, 9001, '2023-10-25', false, false),
		(4009, 9002, '2023-10-24', true, true);

INSERT INTO accepted_registree (registreeid)
	VALUES
		(4008);

INSERT INTO unaccepted_registree (registreeid, rejection_reason)
	VALUES
		(4007, 'Program full');

INSERT INTO walkin (registreeid, memberdiscretion)
	VALUES
		(4009, 4007);

INSERT INTO attendance (attendanceid, programid, participantid, feedback, rating, suggestion)
	VALUES
		(1401, 9001, 4008, 'Good program', 4, 'Keep it up!'),
		(1402, 9001, 4009, 'Average program', 3, 'Could be better');

