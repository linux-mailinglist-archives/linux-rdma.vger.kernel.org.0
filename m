Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7717639F5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjGZPDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjGZPDX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 11:03:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D11BFA
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e6541c98so6376937b3a.2
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690383794; x=1690988594;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TxtIiQ2UTv36FdDseVProJr/0okxfhbglYJvGFAJX6Q=;
        b=O6AdN6th1jWJQoBKInxMkRxxnDdIilkERNyLgHS0TKqfVkEVQqsZ+PO6lPxF11i4TH
         QzDMZ+hsSrQQxP7aTh8P9hnIJMozduMD2PHWM14Q30GHJY+flf6/QA2gLtNaYWVozm0B
         R1xq/FKlE15Js12VZs7xwx2OznG8pHq+pGhdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383794; x=1690988594;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxtIiQ2UTv36FdDseVProJr/0okxfhbglYJvGFAJX6Q=;
        b=Jlrmy99/BNyMRwGznII53nd8oK3ooRJfjdHmWxVqqrhZVcKL9rWV1Um5Vy80JbNiMW
         ioJHXYU65aHqwquJcOvk2dR8hbxuReZNX0kKfShmmmAvXSs3GXSuJOutpCs+/5nVGUhg
         /wQTOWtu4Ow/1Jz7Tr16nEQYJLFQ2f0TuRo8geoIiu/plEMaHELGdtbnWXZ6PKFSpYLv
         5wiUEfDTEcp5ixNCnmBaKqNBE8gDSBt0agX0aFGQ8sSKA34rz0D5GC4tx+ZOV0NEDTO8
         lpVz5a+Srug4jYS9dUz5YLwLYYURW2PDkwg1DEXNHd0/JVGbeS/P66u8yY765G1y4lVy
         ogeQ==
X-Gm-Message-State: ABy/qLaPOpRUS0KXRI2HmdMjNkxhZzNTc5fRU1s6EdCGbkWo/fnBiuZI
        jeHg49fKx0nudMvrWG5ZOFs3gQ==
X-Google-Smtp-Source: APBJJlEdyFeusgE9zPGHM5U6BDIBPJ71VEcCMZW0vPi8oqQIGMp1d4DqNP2l5loQSa1juvAJNmOh2w==
X-Received: by 2002:a05:6a00:a06:b0:64c:4f2f:a235 with SMTP id p6-20020a056a000a0600b0064c4f2fa235mr3423336pfh.30.1690383793750;
        Wed, 26 Jul 2023 08:03:13 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y4-20020a63ad44000000b0055fd10306a2sm12772846pgo.75.2023.07.26.08.03.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:03:12 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 4/4] bnxt_re: Update the debug counters for doorbell pacing
Date:   Wed, 26 Jul 2023 07:51:21 -0700
Message-Id: <1690383081-15033-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009558240601652560"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_BOUND_DIGITS_15,MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000009558240601652560

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Add debug counters to track the Doorbell pacing events and report the
doorbell pacing debug stats.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 18 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/hw_counters.h | 11 +++++++++++
 drivers/infiniband/hw/bnxt_re/main.c        |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index e50a1cb..9357240 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -146,6 +146,10 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_TX_CNP].name                = "tx_cnp_pkts",
 	[BNXT_RE_RX_CNP].name                = "rx_cnp_pkts",
 	[BNXT_RE_RX_ECN].name                = "rx_ecn_marked_pkts",
+	[BNXT_RE_PACING_RESCHED].name        = "pacing_reschedule",
+	[BNXT_RE_PACING_CMPL].name           = "pacing_complete",
+	[BNXT_RE_PACING_ALERT].name          = "pacing_alerts",
+	[BNXT_RE_DB_FIFO_REG].name           = "db_fifo_register",
 };
 
 static void bnxt_re_copy_ext_stats(struct bnxt_re_dev *rdev,
@@ -278,6 +282,18 @@ static void bnxt_re_copy_err_stats(struct bnxt_re_dev *rdev,
 			err_s->res_oos_drop_count;
 }
 
+static void bnxt_re_copy_db_pacing_stats(struct bnxt_re_dev *rdev,
+					 struct rdma_hw_stats *stats)
+{
+	struct bnxt_re_db_pacing_stats *pacing_s =  &rdev->stats.pacing;
+
+	stats->value[BNXT_RE_PACING_RESCHED] = pacing_s->resched;
+	stats->value[BNXT_RE_PACING_CMPL] = pacing_s->complete;
+	stats->value[BNXT_RE_PACING_ALERT] = pacing_s->alerts;
+	stats->value[BNXT_RE_DB_FIFO_REG] =
+		readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off);
+}
+
 int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			    struct rdma_hw_stats *stats,
 			    u32 port, int index)
@@ -350,6 +366,8 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 				goto done;
 			}
 		}
+		if (rdev->pacing.dbr_pacing)
+			bnxt_re_copy_db_pacing_stats(rdev, stats);
 	}
 
 done:
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index f3c4e35..e541b6f 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -129,11 +129,21 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_TX_CNP,
 	BNXT_RE_RX_CNP,
 	BNXT_RE_RX_ECN,
+	BNXT_RE_PACING_RESCHED,
+	BNXT_RE_PACING_CMPL,
+	BNXT_RE_PACING_ALERT,
+	BNXT_RE_DB_FIFO_REG,
 	BNXT_RE_NUM_EXT_COUNTERS
 };
 
 #define BNXT_RE_NUM_STD_COUNTERS (BNXT_RE_OUT_OF_SEQ_ERR + 1)
 
+struct bnxt_re_db_pacing_stats {
+	u64 resched;
+	u64 complete;
+	u64 alerts;
+};
+
 struct bnxt_re_res_cntrs {
 	atomic_t qp_count;
 	atomic_t rc_qp_count;
@@ -164,6 +174,7 @@ struct bnxt_re_rstat {
 struct bnxt_re_stats {
 	struct bnxt_re_rstat            rstat;
 	struct bnxt_re_res_cntrs        res;
+	struct bnxt_re_db_pacing_stats  pacing;
 };
 
 struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 91efa04..87960ac 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -533,6 +533,7 @@ static void bnxt_re_db_fifo_check(struct work_struct *work)
 		pacing_data->pacing_th * BNXT_RE_PACING_ALARM_TH_MULTIPLE;
 	schedule_delayed_work(&rdev->dbq_pacing_work,
 			      msecs_to_jiffies(rdev->pacing.dbq_pacing_time));
+	rdev->stats.pacing.alerts++;
 	mutex_unlock(&rdev->pacing.dbq_lock);
 }
 
@@ -563,12 +564,14 @@ static void bnxt_re_pacing_timer_exp(struct work_struct *work)
 	pacing_data->do_pacing = max_t(u32, rdev->pacing.dbr_def_do_pacing, pacing_data->do_pacing);
 	if (pacing_data->do_pacing <= rdev->pacing.dbr_def_do_pacing) {
 		bnxt_re_set_default_pacing_data(rdev);
+		rdev->stats.pacing.complete++;
 		goto dbq_unlock;
 	}
 
 restart_timer:
 	schedule_delayed_work(&rdev->dbq_pacing_work,
 			      msecs_to_jiffies(rdev->pacing.dbq_pacing_time));
+	rdev->stats.pacing.resched++;
 dbq_unlock:
 	rdev->pacing.do_pacing_save = pacing_data->do_pacing;
 	mutex_unlock(&rdev->pacing.dbq_lock);
-- 
2.5.5


--0000000000009558240601652560
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII7msOX0954L
rS7aE4LW1Nhlgbi7fJ9jw/WD/In84D85MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcyNjE1MDMxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBGL/7fJEac1Wt5iKUc54jlNEs4pxq/
rV0Gu2f8rFRZEG5sneq29ChikEKXJ/39TGqY3eixyIwMhk3EWp77EKub9+T72HHzR1UhnTWOVm5V
Q1KcdO8+VqsPUd6RxSLKTWg17+E4zrnD/7EsH8nLOitjz/T0aBy6DqDKHk6aQeQDheMEtEXEu1CI
nZeR7PygrksvT/DsEqbwrVL8XxFSfQCnj0/Sjyxhji/E9TzWoKyXlVf074JqOynUyIC8Wl8o17ll
xhrncH9C+UM6HGeQ2JJAFwl1qb7u4RpQI6cY5xY1hyTqYZXZjH85Id2PvIp/1t+jKmB10eC6fF03
wB+EoqaY
--0000000000009558240601652560--
