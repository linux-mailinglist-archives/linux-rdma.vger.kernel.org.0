Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB672EAD4
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbjFMSYN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 14:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjFMSYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 14:24:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B810E6
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 11:24:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b3afd2f9bdso21410015ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686680650; x=1689272650;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3L7yVBgpJeCW5ffReamb7iHyD++6/r3nxJ+K7jgbXOI=;
        b=Em7PQvk7ocuGNMlTdWY7VR8U8o/2K/IgwDvAAQrvtWcLNWGPY9Al/H2sxgMwgt4f3H
         5uq0bv3SMYGODr5tEK5q4hbZSVe17UgnJxe8TQsChibJEQUmPWoeivD4lFJAVgsuZXFN
         KJiSnRMd0JQJM8PR0vLTiSY6IuAIH99uC84/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680650; x=1689272650;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3L7yVBgpJeCW5ffReamb7iHyD++6/r3nxJ+K7jgbXOI=;
        b=ClITfcQSviSxioizbQVcHKQQf5MoZR+8YUn+Anxt7JLzs8QYOPu5uJg3lgwyDOheZ8
         Hhzy5OZhALuQ5rVB+rH+DqX1iM4EJmz0Rn790rYwIv9jImYwCQKR2xUUuqtYEp60scf1
         6XFSmDYCdracCl/kE/FV/trj+Oqlt85fUEqk3aHakWzeYzSSYs1e0fe+BZOT5Hj1ax4J
         rqHHDex2uV2rXbgubtLTwKn0tIUvqd2DV9TF0lXRecKyX6MWBtjz5g11oKusLm0ctJ3d
         mX3WM8XP8XkwlWeu90qtIdkW3qcHfeVNLTqgJpWpUH1EUWSUrXum4Q9DTg6QivjwtIoZ
         b9Ig==
X-Gm-Message-State: AC+VfDwmKkjSoGsh5BIJbmm7NCxeo1kl+ajA+2sj7/oSLfuiNFs891Eu
        srGlq3PjDvn6Fa3NrXddNZ5X8A==
X-Google-Smtp-Source: ACHHUZ4dR+tJydNPf1sK2k42YrbJHjGSZZEnSlvUbM6nD5IDIvuJyoHXh/uV/recQ8QOgfZBZkQe/g==
X-Received: by 2002:a17:903:41cd:b0:1b3:d5ec:673a with SMTP id u13-20020a17090341cd00b001b3d5ec673amr4768671ple.33.1686680649638;
        Tue, 13 Jun 2023 11:24:09 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001b3fb909f73sm285493plb.112.2023.06.13.11.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:24:08 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v6 for-next 3/7] RDMA/bnxt_re: Optimize the bnxt_re_init_hwrm_hdr usage
Date:   Tue, 13 Jun 2023 11:12:19 -0700
Message-Id: <1686679943-17117-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686679943-17117-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686679943-17117-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fe0be205fe06f0a2"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000fe0be205fe06f0a2

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


--000000000000fe0be205fe06f0a2
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
hvcNAQkFMQ8XDTIzMDYxMzE4MjQwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBY70sjilZ/0ZRdRZY9YhFH7oGF13JQ
4ZWO2z5u6zHz4yIpaQEx1rxjFHA938vGgwEUSO90afNHh/kdsgGQlz6iGRCsQQ+OZRz55Wr59lLg
X1UrUuTF8BTGP+6TKcdnDUjnK63aW697gqrk7MjPLv3h2EdTKRomAxL/RpcbtUKsBXwBOqSrfaWO
utmExEk9A9k6qOfPLm9RXkT/C/g9YiFkqu3/g2J/m3kjTHf0qAPQltA37XWYpFA7pHFzPZ5IhJc5
5Y6c7fX5afdnocP7QM9sf4xJ/w9ekK8VlIvtRy6CC3Zvc6A5g7PwLPnBuG8j2Xa+u+iCYQAo4E2h
sxkMkV69
--000000000000fe0be205fe06f0a2--
