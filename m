Return-Path: <linux-rdma+bounces-3538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA1919DA9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 05:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1721C216EF
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 03:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474441171C;
	Thu, 27 Jun 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pf6z3DZb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D35F9E4
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457327; cv=none; b=fau+EVQaUyqKXKsC9sq+meQe9ohpQO0vbasNnIbR9HJgYl1BDGYTppgtX6YmQbLOKyPOS8VsHny92O2ztUvQs4HjtwumKLJpGqMt8jkBH5JajQnY/zeEh87/ZbfmTHMuI5j1qYbiaBWwzDPZR0XnLlbwVowfM2tWwfIll+t7Hdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457327; c=relaxed/simple;
	bh=HKjXnfLm2m4bFdvLBpF3QCDc1g3UNbWlBNNtpbsQFSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=cn2BGFfuKIvQMd/J71wkoAGzEqhE0sLUxP55WVMsq/x9GrXFtZqII4gzLTWanKt0nlJQm51Ire+0IIXm3iQN5ULrRO2TzlZEYxjbZpCfU1H+RwHx9gYOL2s9GFzpLr215Ah0Rs1kF0+uyVdGSKGBzwW8oz95Bt2nSxfnLSpZWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pf6z3DZb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7065e2fe7d9so4200149b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719457325; x=1720062125; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxR07j9lWmVKzHRqDbkJYOyqaI1iQZ6WqhMvpuLEi98=;
        b=Pf6z3DZbot/q3xNLy7CiwywxsDZptHq2r+I9AgOtAtx5jP9LFW80h/Fw4iTyHfP+qL
         FhvKSk7ER6Jg6XJfHbKRNuIKv06dKLxehYs6+HZUCBpXvbdkdw05Tl8WIFYa7ay+vttL
         DQueFNxsU3WAehYDmnJuRVfA/NxfyVYwmphYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719457325; x=1720062125;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxR07j9lWmVKzHRqDbkJYOyqaI1iQZ6WqhMvpuLEi98=;
        b=Nhb+4kDjeseB3kCEr91r5kz/tNU/rgR3jWl/FuQ+hR15pbikP77Unzx6Nt9hKR9OON
         LEu83/+sUcLbJYx+5pwvcUVLK24vt6qsZjV/2ENWSnKlPF9Gyx/H1Ub0w22GF5kMDfuh
         EqG6M3MHQ11OdIiDU5UPOgdNsAxqXsqyUOAXlv+VhweHf1DkdASF9XiCNeWWtYGfb0g+
         yg/Tg4l6fjHep6KaJ9o7vNP/LhCZJ13KOim5N33QCnImbQNQDIIVl39J3xI8YSTK1daW
         vwmEhMCON4hyqfyhfhFdO0C3y4AKDuyAg2lqe6CVhD/eNT5KTQMZoh5GTyAS/Fla/kHH
         2MKA==
X-Gm-Message-State: AOJu0Yxdmsylvw6GMvAPE4MBLvJQ19nOyTTILL7N7RSgy3oWKDeaw9ml
	tTLUImJun6TbkF9LMOogpxpqZyZ8U/YXOmNN7KykFr11kIYHHjoZXplKYXoTOA==
X-Google-Smtp-Source: AGHT+IGlDtCJ+D1onvo8x8HSvajywOz1qx3QqKg4H1CNQ/xF+fd79si4IBDrjJA/aGg7IQMO5Kw6+A==
X-Received: by 2002:a05:6a20:3b05:b0:1bd:27fd:ff56 with SMTP id adf61e73a8af0-1bd27fe00a6mr5601925637.58.1719457324887;
        Wed, 26 Jun 2024 20:02:04 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997da7sm2103285ad.216.2024.06.26.20.02.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 20:02:04 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/3] RDMA/bnxt_re: Disable doorbell moderation if hardware register read fails
Date: Wed, 26 Jun 2024 19:41:05 -0700
Message-Id: <1719456065-27394-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1719456065-27394-1-git-send-email-selvin.xavier@broadcom.com>
References: <1719456065-27394-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000014a41c061bd65ba5"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--00000000000014a41c061bd65ba5

If the HW register read fails, the FIFO will be always shown as
full. DB moderation doesn't work in that case and the traffic fails.
So disable this feature and log a message.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 45 +++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 2c5282f..9714b9a 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -488,19 +488,40 @@ static void bnxt_re_set_default_pacing_data(struct bnxt_re_dev *rdev)
 		pacing_data->pacing_th * BNXT_RE_PACING_ALARM_TH_MULTIPLE;
 }
 
-static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
+static u32 __get_fifo_occupancy(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
 	u32 read_val, fifo_occup;
 
+	read_val = readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
+	fifo_occup = pacing_data->fifo_max_depth -
+		     ((read_val & pacing_data->fifo_room_mask) >>
+		      pacing_data->fifo_room_shift);
+	return fifo_occup;
+}
+
+static bool is_dbr_fifo_full(struct bnxt_re_dev *rdev)
+{
+	u32 max_occup, fifo_occup;
+
+	fifo_occup = __get_fifo_occupancy(rdev);
+	max_occup = BNXT_RE_MAX_FIFO_DEPTH(rdev->chip_ctx) - 1;
+	if (fifo_occup == max_occup)
+		return true;
+
+	return false;
+}
+
+static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
+	u32 fifo_occup;
+
 	/* loop shouldn't run infintely as the occupancy usually goes
 	 * below pacing algo threshold as soon as pacing kicks in.
 	 */
 	while (1) {
-		read_val = readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
-		fifo_occup = pacing_data->fifo_max_depth -
-			     ((read_val & pacing_data->fifo_room_mask) >>
-			      pacing_data->fifo_room_shift);
+		fifo_occup = __get_fifo_occupancy(rdev);
 		/* Fifo occupancy cannot be greater the MAX FIFO depth */
 		if (fifo_occup > pacing_data->fifo_max_depth)
 			break;
@@ -556,16 +577,13 @@ static void bnxt_re_pacing_timer_exp(struct work_struct *work)
 	struct bnxt_re_dev *rdev = container_of(work, struct bnxt_re_dev,
 			dbq_pacing_work.work);
 	struct bnxt_qplib_db_pacing_data *pacing_data;
-	u32 read_val, fifo_occup;
+	u32 fifo_occup;
 
 	if (!mutex_trylock(&rdev->pacing.dbq_lock))
 		return;
 
 	pacing_data = rdev->qplib_res.pacing_data;
-	read_val = readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
-	fifo_occup = pacing_data->fifo_max_depth -
-		     ((read_val & pacing_data->fifo_room_mask) >>
-		      pacing_data->fifo_room_shift);
+	fifo_occup = __get_fifo_occupancy(rdev);
 
 	if (fifo_occup > pacing_data->pacing_th)
 		goto restart_timer;
@@ -613,7 +631,6 @@ void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev)
 
 static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
 {
-
 	/* Allocate a page for app use */
 	rdev->pacing.dbr_page = (void *)__get_free_page(GFP_KERNEL);
 	if (!rdev->pacing.dbr_page)
@@ -637,6 +654,12 @@ static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
 	rdev->pacing.dbr_bar_addr =
 		pci_resource_start(rdev->qplib_res.pdev, 0) + rdev->pacing.dbr_db_fifo_reg_off;
 
+	if (is_dbr_fifo_full(rdev)) {
+		free_page((u64)rdev->pacing.dbr_page);
+		rdev->pacing.dbr_page = NULL;
+		return -EIO;
+	}
+
 	rdev->pacing.pacing_algo_th = BNXT_RE_PACING_ALGO_THRESHOLD;
 	rdev->pacing.dbq_pacing_time = BNXT_RE_DBR_PACING_TIME;
 	rdev->pacing.dbr_def_do_pacing = BNXT_RE_DBR_DO_PACING_NO_CONGESTION;
-- 
2.5.5


--00000000000014a41c061bd65ba5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfAYJKoZIhvcNAQcCoIIQbTCCEGkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDHL4K7jH/uUzTPFjtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDdaFw0yNTA5MTAwODE4NDdaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIjAgBgNVBAMTGVNlbHZpbiBUaHlwYXJhbXBpbCBYYXZpZXIx
KTAnBgkqhkiG9w0BCQEWGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEA4/0O+hycwcsNi4j4tTBav8CvSVzv5i1Zk0tYtK7mzA3r8Ij35v5j
L2NsFikHjmHCDfvkP6XrWLSnobeEI4CV0PyrqRVpjZ3XhMPi2M2abxd8BWSGDhd0d8/j8VcjRTuT
fqtDSVGh1z3bqKegUA5r3mbucVWPoIMnjjCLCCim0sJQFblBP+3wkgAWdBcRr/apKCrKhnk0FjpC
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILXvW2eoMiWR
n7WhBmMgpZ5tyJlg/6RDpPEfAKIS2a4kMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDYyNzAzMDIwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCSqrIiXHaahc5TG2r/QjW+yerWewDf
Tr6BdlZ9eLlzkdv9mMFkELPwrFIyFizY4UBXtq88YhlRpGQU3vOigbtBEeSPsAc2sEUdBBbUj3me
m9ZX2L9LUNkuvjhY7mDi9MTB01mF596xkGmDZglSR0FMf2EcuLUt7L+8kvIww1XgCvmcbJ46KJn2
ku5GW1Lvk95OacsBuCL9GTkNMypZrwOXvzSDiatwVtBwOo0Y3j6yQYEDHOUWzZOuplSxlY7TfPTc
ugaA4zQM9CUKSJ6iOsk4EWnI1y8Ts95s0OqR7D1zgKJ+RcDmF4yWOpQD88dVquVvkh2LO4RwGOoY
2QJeFQyX
--00000000000014a41c061bd65ba5--

