Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1D727D04
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjFHKhy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjFHKhx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:37:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE272D6D
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b0314f057cso2010775ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220658; x=1688812658;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ww0q9fpRyaBvzYRhuPEEV+DRtPaxNTZDMxjiruNuri4=;
        b=aPcrki9O2+q1VyNQzTBpo53aRvHmhHBFgp/Nqd1Pdl4nIeLv/k4HFqa+KdldHUKiPA
         u9pfX2pd6/iPEtV08pcz+4qcYg3Me3ho7tR5ZGnSPxAV8nNj8nHd9OHeO34ksP6i91AB
         aHyjkU3QGNWsh4d2kuuS7qxXrJUJDsKwwbQRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220658; x=1688812658;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww0q9fpRyaBvzYRhuPEEV+DRtPaxNTZDMxjiruNuri4=;
        b=EQXZz4qUDksk8LAUeQQDz+ssw78Xt3WtqYgGsY0Ai6EIISzTbbzHCx1I0Wsm82431i
         6yWZDmJb8r7sB7nLqEo6voTJGpI/TAqdgyxiGa38Wx/kM8dr5YU0O85KOvOTdgwCNJfx
         DLV4zW2JcNCLTPsxBygxoPErDB7SfvVMg49TUNYjaa3YmeTf3gCXYjB+LmVPa5y7nV2q
         f3ECq7HXCdn6KLTRWlopBGZOQVMEgZmki7ESgw2WkVc1pWDxAJJdtpDmrfQ4lE9uY+YA
         pkID0eWE7Md6PJwjiDQJR0EHtGDSZVLaxXRYOUmmOlgiqeOUMPpvYeZ90czC92Xn58dr
         nmUw==
X-Gm-Message-State: AC+VfDwDXBR3AqwaZ5rBaWGyAqgMHJog09Nq/chnaTjbgoyial2UufRI
        u13kjrNslEMYYoC2L+X9EwljiA==
X-Google-Smtp-Source: ACHHUZ4zd/zs97m1vWfYe/KhBoTIeS1N2DZC9FAAm/8aEKtpuW+fCXZG6QeX+rZ45b4BGI2DqTp/0Q==
X-Received: by 2002:a17:903:32cf:b0:1b2:1ee9:682 with SMTP id i15-20020a17090332cf00b001b21ee90682mr6370016plr.23.1686220657687;
        Thu, 08 Jun 2023 03:37:37 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.37.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:36 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 15/17] RDMA/bnxt_re: use firmware provided max request timeout
Date:   Thu,  8 Jun 2023 03:25:06 -0700
Message-Id: <1686219908-11181-16-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000562f5605fd9bd7a5"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000562f5605fd9bd7a5

From: Kashyap Desai <kashyap.desai@broadcom.com>

Firmware provides max request timeout value as part of hwrm_ver_get
API. Driver gets the timeout from firmware and if that interface is
not available then fall back to hardcoded timeout value.
Also, Add a helper function to check the FW status.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c       |  8 +++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 57 ++++++++++++++++++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  4 ++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  1 +
 4 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 8241154..a2c7d3f 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1041,6 +1041,7 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct hwrm_ver_get_output resp = {0};
 	struct hwrm_ver_get_input req = {0};
+	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_fw_msg fw_msg;
 	int rc = 0;
 
@@ -1058,11 +1059,18 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 			  rc);
 		return;
 	}
+
+	cctx = rdev->chip_ctx;
 	rdev->qplib_ctx.hwrm_intf_ver =
 		(u64)le16_to_cpu(resp.hwrm_intf_major) << 48 |
 		(u64)le16_to_cpu(resp.hwrm_intf_minor) << 32 |
 		(u64)le16_to_cpu(resp.hwrm_intf_build) << 16 |
 		le16_to_cpu(resp.hwrm_intf_patch);
+
+	cctx->hwrm_cmd_max_timeout = le16_to_cpu(resp.max_req_timeout);
+
+	if (!cctx->hwrm_cmd_max_timeout)
+		cctx->hwrm_cmd_max_timeout = RCFW_FW_STALL_MAX_TIMEOUT;
 }
 
 static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 4f36644..8d08715 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -90,6 +90,41 @@ static int bnxt_qplib_map_rc(u8 opcode)
 }
 
 /**
+ * bnxt_re_is_fw_stalled   -	Check firmware health
+ * @rcfw      -   rcfw channel instance of rdev
+ * @cookie    -   cookie to track the command
+ * @opcode    -   rcfw submitted for given opcode
+ * @cbit      -   bitmap entry of cookie
+ *
+ * If firmware has not responded any rcfw command within
+ * rcfw->max_timeout, consider firmware as stalled.
+ *
+ * Returns:
+ * 0 if firmware is responding
+ * -ENODEV if firmware is not responding
+ */
+static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
+				 u16 cookie, u8 opcode, u16 cbit)
+{
+	struct bnxt_qplib_cmdq_ctx *cmdq;
+
+	cmdq = &rcfw->cmdq;
+
+	if (time_after(jiffies, cmdq->last_seen +
+		      (rcfw->max_timeout * HZ))) {
+		dev_warn_ratelimited(&rcfw->pdev->dev,
+				     "%s: FW STALL Detected. cmdq[%#x]=%#x waited (%d > %d) msec active %d ",
+				     __func__, cookie, opcode,
+				     jiffies_to_msecs(jiffies - cmdq->last_seen),
+				     rcfw->max_timeout * 1000,
+				     test_bit(cbit, cmdq->cmdq_bitmap));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/**
  * __wait_for_resp   -	Don't hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
@@ -120,8 +155,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 		ret = wait_event_timeout(cmdq->waitq,
 					 !test_bit(cbit, cmdq->cmdq_bitmap) ||
 					 test_bit(ERR_DEVICE_DETACHED, &cmdq->flags),
-					 msecs_to_jiffies(RCFW_FW_STALL_TIMEOUT_SEC
-							  * 1000));
+					 msecs_to_jiffies(rcfw->max_timeout * 1000));
 
 		if (!test_bit(cbit, cmdq->cmdq_bitmap))
 			return 0;
@@ -131,10 +165,9 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 		if (!test_bit(cbit, cmdq->cmdq_bitmap))
 			return 0;
 
-		/* Firmware stall is detected */
-		if (time_after(jiffies, cmdq->last_seen +
-			      (RCFW_FW_STALL_TIMEOUT_SEC * HZ)))
-			return -ENODEV;
+		ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, cbit);
+		if (ret)
+			return ret;
 
 	} while (true);
 };
@@ -357,6 +390,7 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	unsigned long issue_time;
 	u16 cbit;
+	int ret;
 
 	cbit = cookie % rcfw->cmdq_depth;
 	issue_time = jiffies;
@@ -373,11 +407,10 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 		if (!test_bit(cbit, cmdq->cmdq_bitmap))
 			return 0;
 		if (jiffies_to_msecs(jiffies - issue_time) >
-		    (RCFW_FW_STALL_TIMEOUT_SEC * 1000)) {
-			/* Firmware stall is detected */
-			if (time_after(jiffies, cmdq->last_seen +
-				      (RCFW_FW_STALL_TIMEOUT_SEC * HZ)))
-				return -ENODEV;
+		    (rcfw->max_timeout * 1000)) {
+			ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, cbit);
+			if (ret)
+				return ret;
 		}
 	} while (true);
 };
@@ -957,6 +990,8 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	if (!rcfw->qp_tbl)
 		goto fail;
 
+	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
+
 	return 0;
 
 fail:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 338bf6a..b644dcc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -51,7 +51,7 @@
 
 #define RCFW_DBR_PCI_BAR_REGION		2
 #define RCFW_DBR_BASE_PAGE_SHIFT	12
-#define RCFW_FW_STALL_TIMEOUT_SEC	40
+#define RCFW_FW_STALL_MAX_TIMEOUT	40
 
 /* Cmdq contains a fix number of a 16-Byte slots */
 struct bnxt_qplib_cmdqe {
@@ -227,6 +227,8 @@ struct bnxt_qplib_rcfw {
 	atomic_t rcfw_intr_enabled;
 	struct semaphore rcfw_inflight;
 	atomic_t timeout_send;
+	/* cached from chip cctx for quick reference in slow path */
+	u16 max_timeout;
 };
 
 struct bnxt_qplib_cmdqmsg {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 982e2c9..77f0b84 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -55,6 +55,7 @@ struct bnxt_qplib_chip_ctx {
 	u8	chip_rev;
 	u8	chip_metal;
 	u16	hw_stats_size;
+	u16	hwrm_cmd_max_timeout;
 	struct bnxt_qplib_drv_modes modes;
 };
 
-- 
2.5.5


--000000000000562f5605fd9bd7a5
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBxEKg3px07b
QziP1d6nj9qroh94Zx638kolXVEmGoZwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzczOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDSowavDLm5QtnOoPV0e7+DRxFUSKX2
ruj9YTe3UwBUMdw5z5788TBAl6eayxk6J3NGWJjJo6uqFtE3AbL+To/9bXIaL5bfT5cCy3a+aweY
TWkpornz8LYY0nzbQSEGk1rtF4Nxsxak25odrX/l4/sZoxlyH71t3EUCwMJnDXjdXFqgd5aBQFiE
R7/XAx6QIQhwG7zjwY6M/5H4A99paSnmIgUD95buwknN4dmnhnHwi4rV8CGyNLso450F6VMPVmil
GYXdpZ9g8WP1DW2pDK+3tps7HFhdmw4yoQm6WD6aod7pq8NCotM5VzICLlAwelwzdlnlrPl1mSe+
CxVMVCU9
--000000000000562f5605fd9bd7a5--
