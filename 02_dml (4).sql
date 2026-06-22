-- =====================================================================
-- 02_dml.sql
-- SISTEM BENGKEL KENDARAAN
-- Data Manipulation Language (DML)
-- Dialek : MySQL 8.0
-- Berisi data dummy realistis hasil olahan dari data UNF (3NF.xlsx)
-- =====================================================================

USE bengkel_kendaraan_db;

-- ---------------------------------------------------------------------
-- 1. PELANGGAN (20 baris)
-- ---------------------------------------------------------------------
INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, alamat, no_hp, email) VALUES
('PL001','Ahmad Fauzi','Jl. Anggrek No.5, Semarang','081123000001','ahmad.fauzi@gmail.com'),
('PL002','Rina Maharani','Jl. Melati No.12, Solo','081123000002','rina.maharani@gmail.com'),
('PL003','Bambang Sulistyo','Jl. Kenanga No.3, Purwokerto','081123000003','bambang.sulistyo@yahoo.com'),
('PL004','Sari Indahwati','Jl. Mawar No.7, Klaten','081123000004','sari.indahwati@gmail.com'),
('PL005','Hendra Kurniawan','Jl. Dahlia No.9, Magelang','081123000005','hendra.kurniawan@gmail.com'),
('PL006','Yuli Astuti','Jl. Seroja No.14, Kudus','081123000006','yuli.astuti@gmail.com'),
('PL007','Doni Hermawan','Jl. Flamboyan No.2, Pekalongan','081123000007','doni.hermawan@yahoo.com'),
('PL008','Fitri Handayani','Jl. Bougenville No.18, Tegal','081123000008','fitri.handayani@gmail.com'),
('PL009','Wahyu Nugroho','Jl. Cempaka No.6, Jepara','081123000009','wahyu.nugroho@gmail.com'),
('PL010','Novi Susanti','Jl. Tulip No.11, Boyolali','081123000010','novi.susanti@gmail.com'),
('PL011','Eko Purnomo','Jl. Angsana No.4, Blora','081123000011','eko.purnomo@yahoo.com'),
('PL012','Lina Wulandari','Jl. Akasia No.20, Rembang','081123000012','lina.wulandari@gmail.com'),
('PL013','Fajar Setiawan','Jl. Beringin No.1, Demak','081123000013','fajar.setiawan@gmail.com'),
('PL014','Mega Lestari','Jl. Cemara No.8, Salatiga','081123000014','mega.lestari@gmail.com'),
('PL015','Rizal Aditya','Jl. Durian No.15, Kendal','081123000015','rizal.aditya@yahoo.com'),
('PL016','Tika Permatasari','Jl. Enau No.3, Batang','081123000016','tika.permatasari@gmail.com'),
('PL017','Galih Pradana','Jl. Flamboyan No.22, Brebes','081123000017','galih.pradana@gmail.com'),
('PL018','Heni Purwaningsih','Jl. Glugu No.10, Cilacap','081123000018','heni.purwaningsih@gmail.com'),
('PL019','Irfan Maulana','Jl. Nangka No.5, Banyumas','081123000019','irfan.maulana@yahoo.com'),
('PL020','Jasmine Cahyani','Jl. Jambu No.17, Purbalingga','081123000020','jasmine.cahyani@gmail.com');

-- ---------------------------------------------------------------------
-- 2. MEKANIK (20 baris)
-- ---------------------------------------------------------------------
INSERT INTO mekanik (id_mekanik, nama_mekanik, no_hp, alamat, spesialisasi, status) VALUES
('MK001','Supriadi','082134000001','Jl. Mekanik Raya No.1, Semarang','Kaki-kaki','Aktif'),
('MK002','Agung Triyono','082134000002','Jl. Mekanik Raya No.2, Solo','Mesin','Aktif'),
('MK003','Nanang Susilo','082134000003','Jl. Mekanik Raya No.3, Purwokerto','AC Mobil','Aktif'),
('MK004','Hendro Wibowo','082134000004','Jl. Mekanik Raya No.4, Klaten','CVT','Aktif'),
('MK005','Sarwono','082134000005','Jl. Mekanik Raya No.5, Magelang','Injeksi','Cuti'),
('MK006','Aris Munandar','082134000006','Jl. Mekanik Raya No.6, Kudus','Kaki-kaki','Aktif'),
('MK007','Bagus Santosa','082134000007','Jl. Mekanik Raya No.7, Pekalongan','Mesin','Aktif'),
('MK008','Cahyo Prabowo','082134000008','Jl. Mekanik Raya No.8, Tegal','AC Mobil','Aktif'),
('MK009','Darmawan','082134000009','Jl. Mekanik Raya No.9, Jepara','CVT','Aktif'),
('MK010','Eko Aryanto','082134000010','Jl. Mekanik Raya No.10, Boyolali','Injeksi','Cuti'),
('MK011','Firdaus Ramadhan','082134000011','Jl. Mekanik Raya No.11, Blora','CVT','Aktif'),
('MK012','Guntur Prasetyo','082134000012','Jl. Mekanik Raya No.12, Rembang','Mesin','Aktif'),
('MK013','Haryo Utomo','082134000013','Jl. Mekanik Raya No.13, Demak','AC Mobil','Aktif'),
('MK014','Ivan Setyawan','082134000014','Jl. Mekanik Raya No.14, Salatiga','CVT','Aktif'),
('MK015','Jatmiko','082134000015','Jl. Mekanik Raya No.15, Kendal','Injeksi','Cuti'),
('MK016','Krisna Adi','082134000016','Jl. Mekanik Raya No.16, Batang','Kaki-kaki','Aktif'),
('MK017','Luqman Hamdani','082134000017','Jl. Mekanik Raya No.17, Brebes','Mesin','Aktif'),
('MK018','Marjono','082134000018','Jl. Mekanik Raya No.18, Cilacap','Kaki-kaki','Aktif'),
('MK019','Nurhadi','082134000019','Jl. Mekanik Raya No.19, Banyumas','CVT','Aktif'),
('MK020','Okky Pratama','082134000020','Jl. Mekanik Raya No.20, Purbalingga','Injeksi','Cuti');

-- ---------------------------------------------------------------------
-- 3. ADMIN (5 baris)
-- ---------------------------------------------------------------------
INSERT INTO admin (id_admin, nama_admin, username, password, nomor_hp) VALUES
('AD001','Putri Ramadhani','putri.admin', SHA2('admin123', 256), '081345000001'),
('AD002','Yusuf Maulana','yusuf.admin', SHA2('admin123', 256), '081345000002'),
('AD003','Dewi Anggraini','dewi.admin', SHA2('admin123', 256), '081345000003'),
('AD004','Rendra Saputra','rendra.admin', SHA2('admin123', 256), '081345000004'),
('AD005','Siti Nurjanah','siti.admin', SHA2('admin123', 256), '081345000005');

-- ---------------------------------------------------------------------
-- 4. SUPPLIER (8 baris)
-- ---------------------------------------------------------------------
INSERT INTO supplier (id_supplier, nama_supplier, alamat, no_hp, email) VALUES
('SP001','PT Astra Otoparts Tbk','Jl. Yos Sudarso No.10, Jakarta Utara','021-55010101','sales@astraotoparts.co.id'),
('SP002','CV Sumber Jaya Motor','Jl. Diponegoro No.45, Semarang','024-7712345','sumberjaya.motor@gmail.com'),
('SP003','PT Indoparts Sejahtera','Jl. Gajah Mada No.22, Surabaya','031-5523456','cs@indopartssejahtera.com'),
('SP004','UD Mitra Spare Part','Jl. Sudirman No.8, Solo','0271-634567','mitraspareparts@yahoo.com'),
('SP005','PT Global Auto Parts','Jl. Ahmad Yani No.99, Yogyakarta','0274-745678','info@globalautoparts.id'),
('SP006','CV Berkah Teknik Motor','Jl. Pemuda No.17, Magelang','0293-856789','berkahteknik@gmail.com'),
('SP007','PT Federal Izumi Manufacturing','Jl. Industri Raya No.5, Bekasi','021-89678901','marketing@federalizumi.co.id'),
('SP008','CV Maju Bersama Otomotif','Jl. Pahlawan No.30, Purwokerto','0281-978901','majubersama.oto@gmail.com');

-- ---------------------------------------------------------------------
-- 5. JASA_SERVIS (19 baris - master daftar jasa)
-- ---------------------------------------------------------------------
INSERT INTO jasa_servis (id_jasa, nama_jasa, harga_jasa, durasi_servis, deskripsi_jasa) VALUES
('JS001','Servis CVT',75000,60,'Pembersihan dan pengecekan sistem CVT motor matic'),
('JS002','Ganti Roller CVT',60000,45,'Penggantian roller CVT yang sudah aus'),
('JS003','Ganti Shockbreaker',100000,60,'Penggantian shockbreaker depan atau belakang'),
('JS004','Spooring',90000,45,'Penyetelan sudut roda agar lurus dan stabil'),
('JS005','Servis Kelistrikan',100000,60,'Pengecekan dan perbaikan sistem kelistrikan kendaraan'),
('JS006','Diagnosa Scanner',50000,30,'Diagnosa kerusakan menggunakan alat scanner OBD'),
('JS007','Servis Lengkap',150000,120,'Servis menyeluruh mesin dan kaki-kaki kendaraan'),
('JS008','Balancing',100000,30,'Penyeimbangan roda agar tidak bergetar saat melaju'),
('JS009','Servis AC Mobil',150000,90,'Pengecekan dan pengisian freon AC mobil'),
('JS010','Pembersihan Injektor',350000,90,'Pembersihan injektor bahan bakar dengan cairan khusus'),
('JS011','Servis Ringan',75000,45,'Servis ringan rutin kendaraan'),
('JS012','Ganti Belt CVT',150000,45,'Penggantian belt CVT yang sudah getas'),
('JS013','Ganti Kampas Rem',75000,30,'Penggantian kampas rem depan atau belakang'),
('JS014','Servis Rem Cakram',90000,45,'Pembersihan dan penyetelan sistem rem cakram'),
('JS015','Servis Karburator',85000,60,'Pembersihan dan penyetelan karburator'),
('JS016','Ganti Oli Mesin',50000,20,'Penggantian oli mesin kendaraan'),
('JS017','Ganti Filter Oli',25000,15,'Penggantian filter oli mesin'),
('JS018','Pembersihan Throttle Body',65000,45,'Pembersihan throttle body untuk performa mesin optimal'),
('JS019','Tune Up Mesin',125000,60,'Penyetelan ulang mesin agar performa optimal');

-- ---------------------------------------------------------------------
-- 6. KENDARAAN (20 baris, FK ke pelanggan)
-- ---------------------------------------------------------------------
INSERT INTO kendaraan (id_kendaraan, id_pelanggan, nomor_polisi, merk, tipe, tahun, warna) VALUES
('KD001','PL001','H 1234 AB','Honda','Beat',2019,'Hitam'),
('KD002','PL002','H 8877 KL','Yamaha','NMAX',2021,'Putih'),
('KD003','PL003','K 2211 ZX','Honda','Vario 125',2020,'Merah'),
('KD004','PL004','AA 8899 FG','Toyota','Avanza',2018,'Silver'),
('KD005','PL005','AD 5678 RT','Daihatsu','Xenia',2022,'Biru'),
('KD006','PL006','G 3456 QW','Honda','Brio',2020,'Abu-abu'),
('KD007','PL007','R 7712 LM','Suzuki','Ertiga',2019,'Hitam'),
('KD008','PL008','H 2345 CD','Yamaha','Aerox',2021,'Putih'),
('KD009','PL009','H 9988 MN','Honda','PCX 160',2022,'Merah'),
('KD010','PL010','K 3322 YZ','Toyota','Calya',2020,'Silver'),
('KD011','PL011','AA 7766 EF','Toyota','Avanza',2018,'Biru'),
('KD012','PL012','AD 1122 ST','Daihatsu','Xenia',2019,'Hitam'),
('KD013','PL013','G 5544 WE','Honda','Brio',2021,'Putih'),
('KD014','PL014','R 4411 PQ','Suzuki','Ertiga',2020,'Abu-abu'),
('KD015','PL015','H 3456 EF','Yamaha','Aerox',2022,'Merah'),
('KD016','PL016','H 7654 GH','Honda','PCX 160',2021,'Silver'),
('KD017','PL017','K 4433 XY','Toyota','Calya',2019,'Hitam'),
('KD018','PL018','AA 5566 HI','Toyota','Avanza',2018,'Biru'),
('KD019','PL019','AD 9900 UV','Daihatsu','Xenia',2020,'Putih'),
('KD020','PL020','G 1122 QR','Honda','Brio',2022,'Abu-abu');

-- ---------------------------------------------------------------------
-- 7. SPAREPART (26 baris, FK ke supplier)
-- ---------------------------------------------------------------------
INSERT INTO sparepart (id_sparepart, id_supplier, nama_sparepart, harga, stok) VALUES
('PRT001','SP001','Disc Brake Pad Honda PCX',95000,12),
('PRT002','SP002','Shockbreaker Belakang Yamaha NMAX',350000,8),
('PRT003','SP003','Filter Udara Avanza',60000,25),
('PRT004','SP004','Roller CVT Honda Vario 13g',48000,30),
('PRT005','SP005','Bearing Roda Depan Universal',65000,15),
('PRT006','SP006','Castrol Magnatec 10W40 1L',85000,40),
('PRT007','SP007','Filter Oli Honda Brio',42000,35),
('PRT008','SP008','Filter Udara Yamaha NMAX',55000,20),
('PRT009','SP001','Roller CVT Yamaha NMAX 15g',50000,18),
('PRT010','SP002','Belt CVT Honda Beat',110000,22),
('PRT011','SP003','Filter Bensin Universal',35000,28),
('PRT012','SP004','NGK Iridium IX',65000,14),
('PRT013','SP005','Coolant Prestone 1L',55000,33),
('PRT014','SP006','Per Shockbreaker Avanza',150000,10),
('PRT015','SP007','Kampas Rem Aspira Belakang',48000,45),
('PRT016','SP008','Kampas Rem Federal Parts Belakang',52000,38),
('PRT017','SP001','Shell Helix HX7 1L',90000,16),
('PRT018','SP002','Motul 5100 10W40 1L',110000,9),
('PRT019','SP003','Minyak Rem DOT 4 500mL',40000,27),
('PRT020','SP004','AHM MPX 2 0.8L',38000,50),
('PRT021','SP005','Sekring Set Universal',15000,19),
('PRT022','SP006','Kampas Rem Aspira Depan',55000,24),
('PRT023','SP007','Bohlam Osram H7 55W',95000,13),
('PRT024','SP008','Federal Matic 0.8L',35000,31),
('PRT025','SP001','Oli Gardan Yamalube 140mL',20000,17),
('PRT026','SP002','Bohlam LED Motor 12V',45000,21);

-- ---------------------------------------------------------------------
-- 8. TRANSAKSI_SERVIS (20 baris, FK ke kendaraan, mekanik, admin)
-- ---------------------------------------------------------------------
INSERT INTO transaksi_servis (id_transaksi, id_kendaraan, id_mekanik, id_admin, tanggal_servis, keluhan_pelanggan, status_servis, total_biaya) VALUES
('TR001','KD001','MK011','AD005','2024-07-03','Motor terasa bergetar saat jalan pelan','Selesai',245000),
('TR002','KD002','MK018','AD003','2024-07-04','Suspensi belakang terasa keras dan berisik','Selesai',530000),
('TR003','KD003','MK005','AD001','2024-07-07','Filter udara kotor, tarikan berat','Selesai',210000),
('TR004','KD004','MK012','AD005','2024-07-09','CVT bergetar saat akselerasi awal','Selesai',245000),
('TR005','KD005','MK019','AD001','2024-07-10','Lampu indikator sering berkedip','Selesai',205000),
('TR006','KD006','MK006','AD002','2024-07-11','Roda depan terasa goyang saat dikemudikan','Selesai',245000),
('TR007','KD007','MK013','AD003','2024-07-15','AC mobil tidak dingin','Selesai',1627000),
('TR008','KD008','MK020','AD004','2024-07-16','Mesin tersendat saat RPM tinggi','Selesai',565000),
('TR009','KD009','MK007','AD005','2024-07-17','Bensin terasa boros dan tarikan ngempos','Selesai',110000),
('TR010','KD010','MK014','AD001','2024-07-19','Mobil bergetar saat kecepatan tinggi','Selesai',415000),
('TR011','KD011','MK001','AD002','2024-07-20','Rem terasa kurang pakem','Selesai',355000),
('TR012','KD012','MK008','AD003','2024-07-22','AC mobil kurang dingin dan berbau','Selesai',208000),
('TR013','KD013','MK015','AD004','2024-07-26','Oli mesin sudah lama belum diganti','Selesai',285000),
('TR014','KD014','MK002','AD005','2024-07-29','Mesin kasar saat idle','Selesai',115000),
('TR015','KD015','MK009','AD001','2024-07-31','CVT berisik saat jalan','Selesai',285000),
('TR016','KD016','MK016','AD002','2024-08-03','Rem belakang berdecit','Selesai',305000),
('TR017','KD017','MK003','AD003','2024-08-05','AC mobil bau apek','Selesai',220000),
('TR018','KD018','MK010','AD004','2024-08-08','Rem cakram bunyi saat ditekan','Selesai',120000),
('TR019','KD019','MK017','AD005','2024-08-09','Mesin brebet saat digas','Selesai',310000),
('TR020','KD020','MK004','AD001','2024-08-13','CVT kasar dan tarikan berat','Selesai',195000);

-- ---------------------------------------------------------------------
-- 9. DETAIL_JASA (32 baris, FK ke transaksi_servis & jasa_servis)
-- ---------------------------------------------------------------------
INSERT INTO detail_jasa (id_detail_servis, id_transaksi, id_jasa, subtotal) VALUES
('DSV001','TR001','JS001',50000),
('DSV002','TR001','JS002',100000),
('DSV003','TR002','JS003',100000),
('DSV004','TR002','JS004',80000),
('DSV005','TR003','JS005',100000),
('DSV006','TR003','JS006',50000),
('DSV007','TR004','JS007',150000),
('DSV008','TR005','JS001',80000),
('DSV009','TR005','JS002',60000),
('DSV010','TR006','JS004',125000),
('DSV011','TR006','JS008',120000),
('DSV012','TR007','JS009',1500000),
('DSV013','TR008','JS010',350000),
('DSV014','TR009','JS011',75000),
('DSV015','TR010','JS001',200000),
('DSV016','TR010','JS012',150000),
('DSV017','TR011','JS013',60000),
('DSV018','TR011','JS014',90000),
('DSV019','TR012','JS009',30000),
('DSV020','TR013','JS015',85000),
('DSV021','TR014','JS016',50000),
('DSV022','TR014','JS017',25000),
('DSV023','TR015','JS001',175000),
('DSV024','TR016','JS013',100000),
('DSV025','TR017','JS009',125000),
('DSV026','TR018','JS006',15000),
('DSV027','TR018','JS018',50000),
('DSV028','TR019','JS019',125000),
('DSV029','TR019','JS006',50000),
('DSV030','TR019','JS018',80000),
('DSV031','TR020','JS002',100000),
('DSV032','TR020','JS001',50000);

-- ---------------------------------------------------------------------
-- 10. DETAIL_SPAREPART (30 baris, FK ke transaksi_servis & sparepart)
-- ---------------------------------------------------------------------
INSERT INTO detail_sparepart (id_detail_sparepart, id_transaksi, id_sparepart, jumlah, harga_satuan, subtotal) VALUES
('DSP001','TR001','PRT001',1,95000,95000),
('DSP002','TR002','PRT002',1,350000,350000),
('DSP003','TR003','PRT003',1,60000,60000),
('DSP004','TR004','PRT004',1,45000,45000),
('DSP005','TR004','PRT004',1,50000,50000),
('DSP006','TR005','PRT005',1,65000,65000),
('DSP007','TR007','PRT006',1,85000,85000),
('DSP008','TR007','PRT007',1,42000,42000),
('DSP009','TR008','PRT008',1,55000,55000),
('DSP010','TR008','PRT009',1,50000,50000),
('DSP011','TR008','PRT010',1,110000,110000),
('DSP012','TR009','PRT011',1,35000,35000),
('DSP013','TR010','PRT012',1,65000,65000),
('DSP014','TR011','PRT013',1,55000,55000),
('DSP015','TR011','PRT014',1,150000,150000),
('DSP016','TR012','PRT015',2,48000,96000),
('DSP017','TR012','PRT016',1,52000,52000),
('DSP018','TR013','PRT017',1,90000,90000),
('DSP019','TR013','PRT018',1,110000,110000),
('DSP020','TR014','PRT019',1,40000,40000),
('DSP021','TR015','PRT020',1,38000,38000),
('DSP022','TR015','PRT007',1,42000,42000),
('DSP023','TR015','PRT021',2,15000,30000),
('DSP024','TR016','PRT022',2,55000,110000),
('DSP025','TR016','PRT001',1,95000,95000),
('DSP026','TR017','PRT023',1,95000,95000),
('DSP027','TR018','PRT022',1,55000,55000),
('DSP028','TR019','PRT024',1,35000,35000),
('DSP029','TR019','PRT025',1,20000,20000),
('DSP030','TR020','PRT026',1,45000,45000);

-- ---------------------------------------------------------------------
-- 11. PEMBAYARAN (20 baris, relasi 1-ke-1 dengan transaksi_servis)
-- ---------------------------------------------------------------------
INSERT INTO pembayaran (id_pembayaran, id_transaksi, tanggal_bayar, total_bayar, metode_bayar) VALUES
('BY001','TR001','2024-07-03',245000,'Debit'),
('BY002','TR002','2024-07-04',530000,'Transfer'),
('BY003','TR003','2024-07-07',210000,'Debit'),
('BY004','TR004','2024-07-09',245000,'Transfer'),
('BY005','TR005','2024-07-10',205000,'Debit'),
('BY006','TR006','2024-07-11',245000,'Transfer'),
('BY007','TR007','2024-07-15',1627000,'Debit'),
('BY008','TR008','2024-07-16',565000,'Transfer'),
('BY009','TR009','2024-07-17',110000,'Debit'),
('BY010','TR010','2024-07-19',415000,'Transfer'),
('BY011','TR011','2024-07-20',355000,'Debit'),
('BY012','TR012','2024-07-22',208000,'Transfer'),
('BY013','TR013','2024-07-26',285000,'Debit'),
('BY014','TR014','2024-07-29',115000,'Transfer'),
('BY015','TR015','2024-07-31',285000,'Debit'),
('BY016','TR016','2024-08-03',305000,'Transfer'),
('BY017','TR017','2024-08-05',220000,'Debit'),
('BY018','TR018','2024-08-08',120000,'Transfer'),
('BY019','TR019','2024-08-09',310000,'Debit'),
('BY020','TR020','2024-08-13',195000,'Transfer');

-- ---------------------------------------------------------------------
-- 12. PEMBELIAN_SPAREPART (10 baris, FK ke supplier)
-- ---------------------------------------------------------------------
INSERT INTO pembelian_sparepart (id_pembelian, id_supplier, tanggal_pembelian, total_pembelian, metode_pembayaran, status_pembayaran) VALUES
('PB001','SP001','2024-06-20',2150000,'Transfer','Lunas'),
('PB002','SP002','2024-06-22',875000,'Tunai','Lunas'),
('PB003','SP003','2024-06-25',1320000,'Transfer','Lunas'),
('PB004','SP004','2024-06-27',990000,'Debit','Lunas'),
('PB005','SP005','2024-06-29',1540000,'Transfer','Lunas'),
('PB006','SP006','2024-07-01',760000,'Tunai','Lunas'),
('PB007','SP007','2024-07-02',1980000,'Transfer','Belum Lunas'),
('PB008','SP008','2024-07-05',640000,'Debit','Lunas'),
('PB009','SP001','2024-07-18',1180000,'Transfer','Lunas'),
('PB010','SP005','2024-08-01',2050000,'Tunai','Lunas');

-- =====================================================================
-- SELESAI 02_dml.sql
-- =====================================================================