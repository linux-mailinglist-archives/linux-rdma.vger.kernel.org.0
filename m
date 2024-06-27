Return-Path: <linux-rdma+bounces-3536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F6919DA7
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 05:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834371C217B8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 03:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BE1134B1;
	Thu, 27 Jun 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C+BTrpwg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA778F9E4
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457321; cv=none; b=WNPEVlJDfE9IPxW3OkcfETJm/X2EveByrntL31r30cguusrGKowKkxCj0xOBODHFbpGIkhc2Mx6eHrDIGwU3hRZgiMvvdb82jXLiVonexcJXnKwMML7QIenBmA13wv996c+e4G3B96JRo0Bb5xsKgt17XL/0LDVuxmFcQiLEUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457321; c=relaxed/simple;
	bh=1yjIGELiQA3lMiP3LpOYsS4EzyN6dHVTg3ptYNYhJec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=LItFUX1/YbWzVouF90tw2IXd0E1BBPuWKUXyLcura6AACsyDS1zMaL1liuy79uZLS69Ky4nOcIgo7qiedcESn5DFXBZEGFvPNYmt98cwDQwrZAD6mkhxGrdx2YBSA7dLNIHU/Ac4v2OTlDNLMlWMmKd5sul7eUKkYc57bGStDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C+BTrpwg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-725a7b0fc55so795843a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719457319; x=1720062119; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iHAC9FGVqvLCNFsGqlyNt0g7E3PC19iLYRwVC4l6Ww8=;
        b=C+BTrpwg/WWOV/xZg7ty0GkIFP1yu8CCCDaaOR1GdzLRv7qLRhNPrB1NtsEuisoUK6
         wNiUXlYpgJ12q+NYAlDRXyy92M5DQxaCb46/EdXF7P+vLf5IRAxjyU5BTCdvtibwiDHd
         iJ18iLseNSPOzs6+NTfC2K0yKw86TLgK5e4k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719457319; x=1720062119;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHAC9FGVqvLCNFsGqlyNt0g7E3PC19iLYRwVC4l6Ww8=;
        b=lcQh0w5vHlSmEM+DNqz8EgmD4BORAJodoQ3D5292jeFetc/lah6+Vw5EHTi/ssQ6a5
         zY0Vn/MI9WsKD/ZhqWSUHKpxxq+G7cO7fSqIbkKh/9v9SUD17+9Ahl67af6Fxp/HVeeD
         a+U6wcoh4j7y6/9Ld/7eVkRdfRgOi1pZsGuYu6H8Fw6eLpwpJJ4LJ8z9XYHbzJT4m1Ks
         PVlSKJ/ofzlqF1Pp3XwlfWXhxLFR8gNvChbqrmRajcCp2aGzPI1zWLle+YJUZWvHQz1W
         NaDtSV2fKqMj6jG3QqITz2Lzzzw5IZqFQRIbrzE7XurOfxJ5j5b7sOBDXKvwBADwxIsr
         +puw==
X-Gm-Message-State: AOJu0YwQxc3nvBO+6eoQUsSOcD2aBgKfKUOebO1eFM8tXH9CIpWrlcON
	xfpCqvKvYKQoUZi55Mk10loB/lWQltelmLVfU7dARpjR9SjPPWxEsBKXUSo6vQ==
X-Google-Smtp-Source: AGHT+IFQ43BEMg3xIe3HUm55aK0AUj67/DJr3+qon30VQTUsbdUYmoTT7ccfRDwYWoduEqn9kokiaw==
X-Received: by 2002:a05:6a20:354b:b0:1bd:2d0b:e143 with SMTP id adf61e73a8af0-1bd2d0be318mr3628783637.52.1719457319122;
        Wed, 26 Jun 2024 20:01:59 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997da7sm2103285ad.216.2024.06.26.20.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 20:01:58 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH for-next 1/3] RDMA/bnxt_re: Update the correct DB FIFO depth and mask for GenP7
Date: Wed, 26 Jun 2024 19:41:03 -0700
Message-Id: <1719456065-27394-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1719456065-27394-1-git-send-email-selvin.xavier@broadcom.com>
References: <1719456065-27394-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bd205a061bd65a3c"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--000000000000bd205a061bd65a3c

GenP5 and P7 devices have different DB FIFO depth. Use different
values based on the chip context.

Instead of hardcoding doorbell FIFO related values, get it
from the HWRM interface. Maintain backward compatibility
by having default values when FW is not providing the doorbell
FIFO related values.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h | 12 ++++++++---
 drivers/infiniband/hw/bnxt_re/main.c    | 38 +++++++++++++++++++++------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 9dca451..0880b4b 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -131,9 +131,15 @@ struct bnxt_re_pacing {
 #define BNXT_RE_PACING_ALARM_TH_MULTIPLE 2 /* Multiple of pacing algo threshold */
 /* Default do_pacing value when there is no congestion */
 #define BNXT_RE_DBR_DO_PACING_NO_CONGESTION 0x7F /* 1 in 512 probability */
-#define BNXT_RE_DB_FIFO_ROOM_MASK 0x1FFF8000
-#define BNXT_RE_MAX_FIFO_DEPTH 0x2c00
-#define BNXT_RE_DB_FIFO_ROOM_SHIFT 15
+
+#define BNXT_RE_MAX_FIFO_DEPTH_P5       0x2c00
+#define BNXT_RE_MAX_FIFO_DEPTH_P7       0x8000
+
+#define BNXT_RE_MAX_FIFO_DEPTH(ctx)	\
+	(bnxt_qplib_is_chip_gen_p7((ctx)) ? \
+	 BNXT_RE_MAX_FIFO_DEPTH_P7 :\
+	 BNXT_RE_MAX_FIFO_DEPTH_P5)
+
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
 #define MAX_CQ_HASH_BITS		(16)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 54b4d2f..2a727f4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -444,6 +444,7 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 
 static int bnxt_re_hwrm_dbr_pacing_qcfg(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
 	struct hwrm_func_dbr_pacing_qcfg_output resp = {};
 	struct hwrm_func_dbr_pacing_qcfg_input req = {};
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
@@ -465,6 +466,13 @@ static int bnxt_re_hwrm_dbr_pacing_qcfg(struct bnxt_re_dev *rdev)
 		cctx->dbr_stat_db_fifo =
 			le32_to_cpu(resp.dbr_stat_db_fifo_reg) &
 			~FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK;
+
+	pacing_data->fifo_max_depth = le32_to_cpu(resp.dbr_stat_db_max_fifo_depth);
+	if (!pacing_data->fifo_max_depth)
+		pacing_data->fifo_max_depth = BNXT_RE_MAX_FIFO_DEPTH(cctx);
+	pacing_data->fifo_room_mask = le32_to_cpu(resp.dbr_stat_db_fifo_reg_fifo_room_mask);
+	pacing_data->fifo_room_shift = resp.dbr_stat_db_fifo_reg_fifo_room_shift;
+
 	return 0;
 }
 
@@ -481,6 +489,7 @@ static void bnxt_re_set_default_pacing_data(struct bnxt_re_dev *rdev)
 
 static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
 	u32 read_val, fifo_occup;
 
 	/* loop shouldn't run infintely as the occupancy usually goes
@@ -488,14 +497,14 @@ static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
 	 */
 	while (1) {
 		read_val = readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
-		fifo_occup = BNXT_RE_MAX_FIFO_DEPTH -
-			((read_val & BNXT_RE_DB_FIFO_ROOM_MASK) >>
-			 BNXT_RE_DB_FIFO_ROOM_SHIFT);
+		fifo_occup = pacing_data->fifo_max_depth -
+			     ((read_val & pacing_data->fifo_room_mask) >>
+			      pacing_data->fifo_room_shift);
 		/* Fifo occupancy cannot be greater the MAX FIFO depth */
-		if (fifo_occup > BNXT_RE_MAX_FIFO_DEPTH)
+		if (fifo_occup > pacing_data->fifo_max_depth)
 			break;
 
-		if (fifo_occup < rdev->qplib_res.pacing_data->pacing_th)
+		if (fifo_occup < pacing_data->pacing_th)
 			break;
 	}
 }
@@ -553,9 +562,9 @@ static void bnxt_re_pacing_timer_exp(struct work_struct *work)
 
 	pacing_data = rdev->qplib_res.pacing_data;
 	read_val = readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
-	fifo_occup = BNXT_RE_MAX_FIFO_DEPTH -
-		((read_val & BNXT_RE_DB_FIFO_ROOM_MASK) >>
-		 BNXT_RE_DB_FIFO_ROOM_SHIFT);
+	fifo_occup = pacing_data->fifo_max_depth -
+		     ((read_val & pacing_data->fifo_room_mask) >>
+		      pacing_data->fifo_room_shift);
 
 	if (fifo_occup > pacing_data->pacing_th)
 		goto restart_timer;
@@ -594,7 +603,7 @@ void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev)
 	 * Increase the alarm_th to max so that other user lib instances do not
 	 * keep alerting the driver.
 	 */
-	pacing_data->alarm_th = BNXT_RE_MAX_FIFO_DEPTH;
+	pacing_data->alarm_th = pacing_data->fifo_max_depth;
 	pacing_data->do_pacing = BNXT_RE_MAX_DBR_DO_PACING;
 	cancel_work_sync(&rdev->dbq_fifo_check_work);
 	schedule_work(&rdev->dbq_fifo_check_work);
@@ -603,8 +612,6 @@ void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev)
 
 static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
 {
-	if (bnxt_re_hwrm_dbr_pacing_qcfg(rdev))
-		return -EIO;
 
 	/* Allocate a page for app use */
 	rdev->pacing.dbr_page = (void *)__get_free_page(GFP_KERNEL);
@@ -614,6 +621,12 @@ static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
 	memset((u8 *)rdev->pacing.dbr_page, 0, PAGE_SIZE);
 	rdev->qplib_res.pacing_data = (struct bnxt_qplib_db_pacing_data *)rdev->pacing.dbr_page;
 
+	if (bnxt_re_hwrm_dbr_pacing_qcfg(rdev)) {
+		free_page((u64)rdev->pacing.dbr_page);
+		rdev->pacing.dbr_page = NULL;
+		return -EIO;
+	}
+
 	/* MAP HW window 2 for reading db fifo depth */
 	writel(rdev->chip_ctx->dbr_stat_db_fifo & BNXT_GRC_BASE_MASK,
 	       rdev->en_dev->bar0 + BNXT_GRCPF_REG_WINDOW_BASE_OUT + 4);
@@ -627,9 +640,6 @@ static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
 	rdev->pacing.dbq_pacing_time = BNXT_RE_DBR_PACING_TIME;
 	rdev->pacing.dbr_def_do_pacing = BNXT_RE_DBR_DO_PACING_NO_CONGESTION;
 	rdev->pacing.do_pacing_save = rdev->pacing.dbr_def_do_pacing;
-	rdev->qplib_res.pacing_data->fifo_max_depth = BNXT_RE_MAX_FIFO_DEPTH;
-	rdev->qplib_res.pacing_data->fifo_room_mask = BNXT_RE_DB_FIFO_ROOM_MASK;
-	rdev->qplib_res.pacing_data->fifo_room_shift = BNXT_RE_DB_FIFO_ROOM_SHIFT;
 	rdev->qplib_res.pacing_data->grc_reg_offset = rdev->pacing.dbr_db_fifo_reg_off;
 	bnxt_re_set_default_pacing_data(rdev);
 	/* Initialize worker for DBR Pacing */
-- 
2.5.5


--000000000000bd205a061bd65a3c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJHKmloMqgVI
6+ztRjPRBpJfRb2MhY7LjMd+LohNm4QOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDYyNzAzMDE1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCIrsXk1wWeWMrkIKAyDCVl3/TlHsZ0
ZJg4zs8kkrHO6YKWCUh32dalqfw9Cyi94zmJjVkPUpStcFQXkNlOd33dNjGfl1hqg9evC2jiGiUS
8OkwFMQegBEUkiEJ/WGEQ1Yyq0z6QtvbfSmhlIYKKiFTUrUttAAVQU/LRneAMk+4YNlOgkcJ56/M
rTacwKbZiWU05nFp+cLg9MQeFD1deOs3945JSaAQgo4+C/Gkiqe2padQsEWkXQ1T63d+oHWw3BJQ
5gC0vDnes1MLVQFEtAajNgQm2bVndRh8pzFbYA8AS6FLjQW9mt2uY1ZAe9+GbAWFzd7Nil/KBbex
ECpUrwJX
--000000000000bd205a061bd65a3c--

