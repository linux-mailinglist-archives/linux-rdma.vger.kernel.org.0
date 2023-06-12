Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C0F72BED7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 12:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjFLKXr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 06:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjFLKXW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 06:23:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4D1252A
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 03:02:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b3c1730fc9so6320225ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686564048; x=1689156048;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aA/a4JUDsItlmpJfZxkXbMBgpiH7ZqyI8TZfRDuceuI=;
        b=IoE3Mj6r/m2x/RjeiWmzJXdXFAFsVrqhN1qzS1L/iWTZ1yK+NUTJTtVPFp7MsNkUKB
         M74fMJhSCUtyQdknMIm9UAnuRXUZJc2NgfGPaqOFB9+tjVciKelxPna2vXygdsLsVbf8
         cWbNzxaf+6LKgIBtdWORiq7KYHOn+Qc0js1X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564048; x=1689156048;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aA/a4JUDsItlmpJfZxkXbMBgpiH7ZqyI8TZfRDuceuI=;
        b=QuuI41NC9yVnd4Jlj/O0NmjJB3+sLAs00oRsvRvCvtMofJh0LgazuPjWsgu+48/Uk9
         SOI/oC0Kccb3gE61az5/Yglahcij1Fn6iGmDDaNdHcrqky1xWioqXvtj69NLdEkRbbaC
         L2IqhLmFacYpnv04ZBzDoTHD0n+AnOwIYZNX12Xby1svzUboVQJ84yK9mPj0JenMhVnP
         qGSMRaIOINCFsLiG4pds6hU5l00mD/3x21/+n0E7ebOKl9GF+9ldDT6w1e605AdXIDkj
         KVAfT/nbLKOFiBD0pKxdEmQksXccXXwl9Mu/6kosf3TNjmr9syD3AOhhvXif1YygVFfd
         o+NA==
X-Gm-Message-State: AC+VfDxxKXychlLaw830EWeO368Zn/MyrwhXL40OWBlN3jgmsU+/cBFc
        yMhihzWt6drPh7sh6h80HrK8dA==
X-Google-Smtp-Source: ACHHUZ7nvZt5VdtTCZrq85EmpQRqUUTRZBYfO6wXfxJda0aS9CcgBulVN8OFDc2VES8rwp9jiHn9TA==
X-Received: by 2002:a17:902:e548:b0:1b3:8f19:e970 with SMTP id n8-20020a170902e54800b001b38f19e970mr6592730plf.67.1686564047990;
        Mon, 12 Jun 2023 03:00:47 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001ae2b94701fsm7792050plx.21.2023.06.12.03.00.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:00:47 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v5 for-next 3/7] RDMA/bnxt_re: Optimize the bnxt_re_init_hwrm_hdr usage
Date:   Mon, 12 Jun 2023 02:48:58 -0700
Message-Id: <1686563342-15233-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fdbb7505fdebca53"
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

--000000000000fdbb7505fdebca53

As of now bnxt_re_init_hwrm_hdr is taking only the opcode from
the caller. compl_ring and target_id field is always -1. These
fields might be changed when newer features are added. For now,
removing these parameters as they are hard coded. Also, remove
the rdev field which is not used.

Also, initialize the structure bnxt_fw_msg during declaration
itself.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 48 ++++++++++++++----------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 406b100..1b16c42 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -321,12 +321,11 @@ static int bnxt_re_register_netdev(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
-static void bnxt_re_init_hwrm_hdr(struct bnxt_re_dev *rdev, struct input *hdr,
-				  u16 opcd, u16 crid, u16 trid)
+static void bnxt_re_init_hwrm_hdr(struct input *hdr, u16 opcd)
 {
 	hdr->req_type = cpu_to_le16(opcd);
-	hdr->cmpl_ring = cpu_to_le16(crid);
-	hdr->target_id = cpu_to_le16(trid);
+	hdr->cmpl_ring = cpu_to_le16(-1);
+	hdr->target_id = cpu_to_le16(-1);
 }
 
 static void bnxt_re_fill_fw_msg(struct bnxt_fw_msg *fw_msg, void *msg,
@@ -344,9 +343,9 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 				 u16 fw_ring_id, int type)
 {
 	struct bnxt_en_dev *en_dev;
-	struct hwrm_ring_free_input req = {0};
+	struct hwrm_ring_free_input req = {};
 	struct hwrm_ring_free_output resp;
-	struct bnxt_fw_msg fw_msg;
+	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
 	if (!rdev)
@@ -360,9 +359,7 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return 0;
 
-	memset(&fw_msg, 0, sizeof(fw_msg));
-
-	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_RING_FREE, -1, -1);
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_RING_FREE);
 	req.ring_type = type;
 	req.ring_id = cpu_to_le16(fw_ring_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
@@ -379,16 +376,15 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
 				  u16 *fw_ring_id)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct hwrm_ring_alloc_input req = {0};
+	struct hwrm_ring_alloc_input req = {};
 	struct hwrm_ring_alloc_output resp;
-	struct bnxt_fw_msg fw_msg;
+	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
 	if (!en_dev)
 		return rc;
 
-	memset(&fw_msg, 0, sizeof(fw_msg));
-	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_RING_ALLOC, -1, -1);
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_RING_ALLOC);
 	req.enables = 0;
 	req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
 	if (ring_attr->pages > 1) {
@@ -417,7 +413,7 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct hwrm_stat_ctx_free_input req = {};
 	struct hwrm_stat_ctx_free_output resp = {};
-	struct bnxt_fw_msg fw_msg;
+	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
 	if (!en_dev)
@@ -426,9 +422,7 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return 0;
 
-	memset(&fw_msg, 0, sizeof(fw_msg));
-
-	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_FREE, -1, -1);
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_FREE);
 	req.stat_ctx_id = cpu_to_le32(fw_stats_ctx_id);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
@@ -445,10 +439,10 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 				       u32 *fw_stats_ctx_id)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx = rdev->chip_ctx;
-	struct hwrm_stat_ctx_alloc_output resp = {0};
-	struct hwrm_stat_ctx_alloc_input req = {0};
+	struct hwrm_stat_ctx_alloc_output resp = {};
+	struct hwrm_stat_ctx_alloc_input req = {};
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct bnxt_fw_msg fw_msg;
+	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
 	*fw_stats_ctx_id = INVALID_STATS_CTX_ID;
@@ -456,9 +450,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 	if (!en_dev)
 		return rc;
 
-	memset(&fw_msg, 0, sizeof(fw_msg));
-
-	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_ALLOC, -1, -1);
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_ALLOC);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(dma_map);
 	req.stats_dma_length = cpu_to_le16(chip_ctx->hw_stats_size);
@@ -1045,15 +1037,13 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct hwrm_ver_get_output resp = {0};
-	struct hwrm_ver_get_input req = {0};
+	struct hwrm_ver_get_output resp = {};
+	struct hwrm_ver_get_input req = {};
 	struct bnxt_qplib_chip_ctx *cctx;
-	struct bnxt_fw_msg fw_msg;
+	struct bnxt_fw_msg fw_msg = {};
 	int rc = 0;
 
-	memset(&fw_msg, 0, sizeof(fw_msg));
-	bnxt_re_init_hwrm_hdr(rdev, (void *)&req,
-			      HWRM_VER_GET, -1, -1);
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VER_GET);
 	req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
 	req.hwrm_intf_min = HWRM_VERSION_MINOR;
 	req.hwrm_intf_upd = HWRM_VERSION_UPDATE;
-- 
2.5.5


--000000000000fdbb7505fdebca53
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILKnHVcG5G3O
ChQOhIYtbMaWWFJmqXAgrae8e+PhwdIBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYxMjEwMDA0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAEvnW3HnQUR+bDHtla0Ngwa9rKqoFO
rVYTEMqovBAcY7in0JCaYRWu1QaMXd8pbp5xnaKP+jjUE+24wNGJCK7qgUpwjyPb7B0jf50D4jFR
+6NxU6EbHfD8CADwHQ2+czB5Y8NXPcb78fNjcY/Z7DghDguiTph5uBAsQirvSpx8Fa/YJpUFy7F6
SXX5KaWV1ALDAzfB5g2sY7RxXkHz8pE43shZJoOiF9zx5CvnJ3Q9sKyg/Xuu/wkSYwzJRJQY90lz
5bjrtOq6OgpPcG9MTOPg9g1mR2gSYrBYnlo1rRbuBlcRILYhwrfNYZso+iFD9vJH58SKKUqg1xAL
8yKmoGZP
--000000000000fdbb7505fdebca53--
