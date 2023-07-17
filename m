Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC2755B32
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGQGIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 02:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGQGHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 02:07:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC9E6B
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 23:07:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55adfa61199so3209641a12.2
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 23:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689574040; x=1692166040;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AfYkg3CCDYeUL6Cm7P+Js4VYj7lBhU19Li0zauZkHIg=;
        b=UY5HwWJq8Wp+zgYCZiuhTBpKj52XCWvTJAwu/0XY9412izlYOvGkxmx73R9fDdZPCN
         ePJDz49qBsIfiVAGPSuTaMjVbqZyrm/WyupeduZIEMF7dnbYLTY/wdcjkqdCNWo8wZiH
         XI1dpVCmFHz7euJkSaecYIWajst01Khj6hEuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689574040; x=1692166040;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfYkg3CCDYeUL6Cm7P+Js4VYj7lBhU19Li0zauZkHIg=;
        b=cFtE+AFHm48tqirTo8ERRwWybzmSLGL+Un6bns2Z617Tgd6wyQV+dYBRImeXn54w13
         48yzo4Y3R5V4gHoksgERdhufu4qgYAVF503CumZQXLnacy1cut0KYHUy2gOKIv6l95j5
         1u4D2JEVbFwFbCA1WTHSsVuUi6GvRtxB977UoxoU/b+DXeV6skcqEVAwsN7Kew0U0wRC
         oDGxDq6ngg/dfqoSLzzNHNhiNizEP3hko1aaRIBDpovi/60ubyxoiwK5eBZyEQ211HaK
         jet6QLzsGqThhj2ExxsYueaXFPHeP/eTX1JG1yKte/RMGe1KrRwEmbjjouJDvgTg3RvM
         yDOg==
X-Gm-Message-State: ABy/qLbQcPeuSR5yf5DxhrV0lpiWDblCtg7u3aIS3WVGgjRAs16tKexS
        Xcnnc4tRo4JNkOJ7fKEUIV4fJg==
X-Google-Smtp-Source: APBJJlF4Q6RTyOqBrJh5PcIz/WNyPAHjOBvtwM6peh+zVHUFOHG3Hhr89O6LTxYxzaNihKlQVYPoYg==
X-Received: by 2002:a17:90a:3e4a:b0:262:ed49:ffe7 with SMTP id t10-20020a17090a3e4a00b00262ed49ffe7mr10711550pjm.25.1689574039669;
        Sun, 16 Jul 2023 23:07:19 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902789100b001b9da7b6bc3sm11849632pll.184.2023.07.16.23.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:07:18 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        michael.chan@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 6/7] RDMA/bnxt_re: Implement doorbell pacing algorithm
Date:   Sun, 16 Jul 2023 22:53:13 -0700
Message-Id: <1689573194-27687-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1689573194-27687-1-git-send-email-selvin.xavier@broadcom.com>
References: <1689573194-27687-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007abba60600a89c75"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000007abba60600a89c75

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

User applications alert the driver when the Doorbell FIFO
reaches the alarm threshold. The driver updates the pacing
parameters in the shared page to do the maximum pacing
by the application till the DB FIFO congestion reduces to
pacing threshold. Driver keeps checking the DB FIFO depth
at the pacing interval and gradually adjusts the pacing level.
Once the pacing level reaches default values (no congestion in
the FIFO) pacing gets completed.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |   5 ++
 drivers/infiniband/hw/bnxt_re/main.c    | 124 ++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 1543f80..2175103 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -121,8 +121,10 @@ struct bnxt_re_pacing {
 	u32 dbq_pacing_time; /* ms */
 	u32 dbr_def_do_pacing;
 	bool dbr_pacing;
+	struct mutex dbq_lock; /* synchronize db pacing algo */
 };
 
+#define BNXT_RE_MAX_DBR_DO_PACING 0xFFFF
 #define BNXT_RE_DBR_PACING_TIME 5 /* ms */
 #define BNXT_RE_PACING_ALGO_THRESHOLD 250 /* Entries in DB FIFO */
 #define BNXT_RE_PACING_ALARM_TH_MULTIPLE 2 /* Multiple of pacing algo threshold */
@@ -193,6 +195,8 @@ struct bnxt_re_dev {
 	u32 is_virtfn;
 	u32 num_vfs;
 	struct bnxt_re_pacing pacing;
+	struct work_struct dbq_fifo_check_work;
+	struct delayed_work dbq_pacing_work;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
@@ -203,6 +207,7 @@ struct bnxt_re_dev {
 #define BNXT_RE_ROCEV2_IPV6_PACKET	3
 
 #define BNXT_RE_CHECK_RC(x) ((x) && ((x) != -ETIMEDOUT))
+void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev);
 
 static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 13cd84d..6469811 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -475,6 +475,125 @@ static void bnxt_re_set_default_pacing_data(struct bnxt_re_dev *rdev)
 		pacing_data->pacing_th * BNXT_RE_PACING_ALARM_TH_MULTIPLE;
 }
 
+static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
+{
+	u32 read_val, fifo_occup;
+
+	/* loop shouldn't run infintely as the occupancy usually goes
+	 * below pacing algo threshold as soon as pacing kicks in.
+	 */
+	while (1) {
+		read_val = readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
+		fifo_occup = BNXT_RE_MAX_FIFO_DEPTH -
+			((read_val & BNXT_RE_DB_FIFO_ROOM_MASK) >>
+			 BNXT_RE_DB_FIFO_ROOM_SHIFT);
+		/* Fifo occupancy cannot be greater the MAX FIFO depth */
+		if (fifo_occup > BNXT_RE_MAX_FIFO_DEPTH)
+			break;
+
+		if (fifo_occup < rdev->qplib_res.pacing_data->pacing_th)
+			break;
+	}
+}
+
+static void bnxt_re_db_fifo_check(struct work_struct *work)
+{
+	struct bnxt_re_dev *rdev = container_of(work, struct bnxt_re_dev,
+			dbq_fifo_check_work);
+	struct bnxt_qplib_db_pacing_data *pacing_data;
+	u32 pacing_save;
+
+	if (!mutex_trylock(&rdev->pacing.dbq_lock))
+		return;
+	pacing_data = rdev->qplib_res.pacing_data;
+	pacing_save = rdev->pacing.do_pacing_save;
+	__wait_for_fifo_occupancy_below_th(rdev);
+	cancel_delayed_work_sync(&rdev->dbq_pacing_work);
+	if (pacing_save > rdev->pacing.dbr_def_do_pacing) {
+		/* Double the do_pacing value during the congestion */
+		pacing_save = pacing_save << 1;
+	} else {
+		/*
+		 * when a new congestion is detected increase the do_pacing
+		 * by 8 times. And also increase the pacing_th by 4 times. The
+		 * reason to increase pacing_th is to give more space for the
+		 * queue to oscillate down without getting empty, but also more
+		 * room for the queue to increase without causing another alarm.
+		 */
+		pacing_save = pacing_save << 3;
+		pacing_data->pacing_th = rdev->pacing.pacing_algo_th * 4;
+	}
+
+	if (pacing_save > BNXT_RE_MAX_DBR_DO_PACING)
+		pacing_save = BNXT_RE_MAX_DBR_DO_PACING;
+
+	pacing_data->do_pacing = pacing_save;
+	rdev->pacing.do_pacing_save = pacing_data->do_pacing;
+	pacing_data->alarm_th =
+		pacing_data->pacing_th * BNXT_RE_PACING_ALARM_TH_MULTIPLE;
+	schedule_delayed_work(&rdev->dbq_pacing_work,
+			      msecs_to_jiffies(rdev->pacing.dbq_pacing_time));
+	mutex_unlock(&rdev->pacing.dbq_lock);
+}
+
+static void bnxt_re_pacing_timer_exp(struct work_struct *work)
+{
+	struct bnxt_re_dev *rdev = container_of(work, struct bnxt_re_dev,
+			dbq_pacing_work.work);
+	struct bnxt_qplib_db_pacing_data *pacing_data;
+	u32 read_val, fifo_occup;
+
+	if (!mutex_trylock(&rdev->pacing.dbq_lock))
+		return;
+
+	pacing_data = rdev->qplib_res.pacing_data;
+	read_val = readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
+	fifo_occup = BNXT_RE_MAX_FIFO_DEPTH -
+		((read_val & BNXT_RE_DB_FIFO_ROOM_MASK) >>
+		 BNXT_RE_DB_FIFO_ROOM_SHIFT);
+
+	if (fifo_occup > pacing_data->pacing_th)
+		goto restart_timer;
+
+	/*
+	 * Instead of immediately going back to the default do_pacing
+	 * reduce it by 1/8 times and restart the timer.
+	 */
+	pacing_data->do_pacing = pacing_data->do_pacing - (pacing_data->do_pacing >> 3);
+	pacing_data->do_pacing = max_t(u32, rdev->pacing.dbr_def_do_pacing, pacing_data->do_pacing);
+	if (pacing_data->do_pacing <= rdev->pacing.dbr_def_do_pacing) {
+		bnxt_re_set_default_pacing_data(rdev);
+		goto dbq_unlock;
+	}
+
+restart_timer:
+	schedule_delayed_work(&rdev->dbq_pacing_work,
+			      msecs_to_jiffies(rdev->pacing.dbq_pacing_time));
+dbq_unlock:
+	rdev->pacing.do_pacing_save = pacing_data->do_pacing;
+	mutex_unlock(&rdev->pacing.dbq_lock);
+}
+
+void bnxt_re_pacing_alert(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_db_pacing_data *pacing_data;
+
+	if (!rdev->pacing.dbr_pacing)
+		return;
+	mutex_lock(&rdev->pacing.dbq_lock);
+	pacing_data = rdev->qplib_res.pacing_data;
+
+	/*
+	 * Increase the alarm_th to max so that other user lib instances do not
+	 * keep alerting the driver.
+	 */
+	pacing_data->alarm_th = BNXT_RE_MAX_FIFO_DEPTH;
+	pacing_data->do_pacing = BNXT_RE_MAX_DBR_DO_PACING;
+	cancel_work_sync(&rdev->dbq_fifo_check_work);
+	schedule_work(&rdev->dbq_fifo_check_work);
+	mutex_unlock(&rdev->pacing.dbq_lock);
+}
+
 static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
 {
 	if (bnxt_re_hwrm_dbr_pacing_qcfg(rdev))
@@ -506,11 +625,16 @@ static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
 	rdev->qplib_res.pacing_data->fifo_room_shift = BNXT_RE_DB_FIFO_ROOM_SHIFT;
 	rdev->qplib_res.pacing_data->grc_reg_offset = rdev->pacing.dbr_db_fifo_reg_off;
 	bnxt_re_set_default_pacing_data(rdev);
+	/* Initialize worker for DBR Pacing */
+	INIT_WORK(&rdev->dbq_fifo_check_work, bnxt_re_db_fifo_check);
+	INIT_DELAYED_WORK(&rdev->dbq_pacing_work, bnxt_re_pacing_timer_exp);
 	return 0;
 }
 
 static void bnxt_re_deinitialize_dbr_pacing(struct bnxt_re_dev *rdev)
 {
+	cancel_work_sync(&rdev->dbq_fifo_check_work);
+	cancel_delayed_work_sync(&rdev->dbq_pacing_work);
 	if (rdev->pacing.dbr_page)
 		free_page((u64)rdev->pacing.dbr_page);
 
-- 
2.5.5


--0000000000007abba60600a89c75
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC3zxJKxvHEO
iQdLBIAUrgjwXz4Cv5C5FOJE5TPTELfvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcxNzA2MDcyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCZTJzvLczVYg7+2SBvsGZWj1SKC4Bs
vNgAGZwKHrZmObSqmZ2Cx+gV98Q5GKUskcOSIZGpmI0RCciYrX3Xj2VE3fB4OUYrNrfqKIZ1XBbA
NpGEhgixDfyeVCweOVD9EdEo2SCngATOTsO1HABpZRQZlxkrzjtD3wj9sE3DQ/cQwARDvU0iB/Qj
UOjPGeLJEfEPJmx/F48b01mmON+sm3x1Tancv4pSuCL6VxIVHomrCD2ioN6RAoupbUQG5f/wN+hU
SV4rEL0VT2emOYSqotOgujGEc9r2wzYaPM7e3gWgqoJWHOZpNG60wWPE8cSyzHalp+scGW0FGuWR
xVBbfVo5
--0000000000007abba60600a89c75--
