Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804077BEAD
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHNRMP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHNRMD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 13:12:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1752110C1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 10:12:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso2704821a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692033121; x=1692637921;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RY6rgKv5mQ07lhqwNrIqHRO/ggc4LeX4L9vHQ6hUZrA=;
        b=hNV4NSQRN8IRgF82f1QWvBP+QEQvYIrEbQ7ruEgyS/Nzu9EwH5wIEbPjDJOcANzmaz
         htpyLJDokEmea8PRZE2sn0ubZOvOW9aEGreDy1wUb7XdpsPezrAeujQk7DauVEx8zISz
         KBhyLlSHq46PVSgVHUrAF4teB7aLGmD2BOsOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692033121; x=1692637921;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY6rgKv5mQ07lhqwNrIqHRO/ggc4LeX4L9vHQ6hUZrA=;
        b=liFXqGc2JbsrFq6Udl1EbqxNUUZt5tVEKl1m2FRqT7Hq0bhTGQgfeaoc2joHAjpL1V
         mbqrERK/i84n6pn2JEtTnvAveSyNmwrx0ZVTBaxwPhHuJCIxpRFcZjn/M9fFOC9YU06B
         XrQEhpMa+Hdx7irjf/DIiD6r1Qy3psyBHA+lvI7QlAZ9W0CiQdcmPNAfDcvwk9FdyYat
         cYNKf0TFvy7hxd6gm0IBNNzjRYQkLP747Pt80E4JNeSV8BG1frQRRM9LH35Liu7KhqPE
         f7CBKTU4SKvqNdLdpDq63z1g14Z/Ii2uHVOpm6yQaxUheVwR2F3Qqbdm70rSPuiZ/gVk
         w6Kg==
X-Gm-Message-State: AOJu0YykgY4OQfKKfyh/hqLeHTD8GXY45XvvQ+oWXrI/0tG91HrFS6XG
        cMNcT93iCEaQ96+quGRXPx/qyA==
X-Google-Smtp-Source: AGHT+IGqEhn8AizQWSJ9cWBJdf0QR/PMZMkWjeGhWeeQDFjAdTetsPjWyzcOtdgjCQgEvLUNsn9pTg==
X-Received: by 2002:a17:90b:2344:b0:25e:d013:c22c with SMTP id ms4-20020a17090b234400b0025ed013c22cmr7282289pjb.47.1692033121459;
        Mon, 14 Aug 2023 10:12:01 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090a8d8300b0025bfda134ccsm8409746pjo.16.2023.08.14.10.11.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 10:12:00 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-next 2/2] RDMA/bnxt_re: Protect the PD table bitmap
Date:   Mon, 14 Aug 2023 10:00:19 -0700
Message-Id: <1692032419-21680-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1692032419-21680-1-git-send-email-selvin.xavier@broadcom.com>
References: <1692032419-21680-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002ce9b80602e52952"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000002ce9b80602e52952

Syncrhonization is required to avoid simultaneous allocation
of the PD. Add a new mutex lock to handle allocation from
the PD table.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 26 ++++++++++++++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  4 +++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c0a7181..b19334c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -619,7 +619,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	int rc = 0;
 
 	pd->rdev = rdev;
-	if (bnxt_qplib_alloc_pd(&rdev->qplib_res.pd_tbl, &pd->qplib_pd)) {
+	if (bnxt_qplib_alloc_pd(&rdev->qplib_res, &pd->qplib_pd)) {
 		ibdev_err(&rdev->ibdev, "Failed to allocate HW PD");
 		rc = -ENOMEM;
 		goto fail;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 6f1e8b7..79c43c2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -642,31 +642,44 @@ static void bnxt_qplib_init_sgid_tbl(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 }
 
 /* PDs */
-int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pdt, struct bnxt_qplib_pd *pd)
+int bnxt_qplib_alloc_pd(struct bnxt_qplib_res  *res, struct bnxt_qplib_pd *pd)
 {
+	struct bnxt_qplib_pd_tbl *pdt = &res->pd_tbl;
 	u32 bit_num;
+	int rc = 0;
 
+	mutex_lock(&res->pd_tbl_lock);
 	bit_num = find_first_bit(pdt->tbl, pdt->max);
-	if (bit_num == pdt->max)
-		return -ENOMEM;
+	if (bit_num == pdt->max) {
+		rc = -ENOMEM;
+		goto exit;
+	}
 
 	/* Found unused PD */
 	clear_bit(bit_num, pdt->tbl);
 	pd->id = bit_num;
-	return 0;
+exit:
+	mutex_unlock(&res->pd_tbl_lock);
+	return rc;
 }
 
 int bnxt_qplib_dealloc_pd(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_pd_tbl *pdt,
 			  struct bnxt_qplib_pd *pd)
 {
+	int rc = 0;
+
+	mutex_lock(&res->pd_tbl_lock);
 	if (test_and_set_bit(pd->id, pdt->tbl)) {
 		dev_warn(&res->pdev->dev, "Freeing an unused PD? pdn = %d\n",
 			 pd->id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto exit;
 	}
 	pd->id = 0;
-	return 0;
+exit:
+	mutex_unlock(&res->pd_tbl_lock);
+	return rc;
 }
 
 static void bnxt_qplib_free_pd_tbl(struct bnxt_qplib_pd_tbl *pdt)
@@ -691,6 +704,7 @@ static int bnxt_qplib_alloc_pd_tbl(struct bnxt_qplib_res *res,
 
 	pdt->max = max;
 	memset((u8 *)pdt->tbl, 0xFF, bytes);
+	mutex_init(&res->pd_tbl_lock);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 57161d3..5949f00 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -277,6 +277,8 @@ struct bnxt_qplib_res {
 	struct net_device		*netdev;
 	struct bnxt_qplib_rcfw		*rcfw;
 	struct bnxt_qplib_pd_tbl	pd_tbl;
+	/* To protect the pd table bit map */
+	struct mutex			pd_tbl_lock;
 	struct bnxt_qplib_sgid_tbl	sgid_tbl;
 	struct bnxt_qplib_dpi_tbl	dpi_tbl;
 	/* To protect the dpi table bit map */
@@ -368,7 +370,7 @@ void bnxt_qplib_free_hwq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_hwq *hwq);
 int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			      struct bnxt_qplib_hwq_attr *hwq_attr);
-int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pd_tbl,
+int bnxt_qplib_alloc_pd(struct bnxt_qplib_res *res,
 			struct bnxt_qplib_pd *pd);
 int bnxt_qplib_dealloc_pd(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_pd_tbl *pd_tbl,
-- 
2.5.5


--0000000000002ce9b80602e52952
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIhoj392Erx8
1J6ZCJrRDbxSu7VA0PDxvhRk2XxrISSrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDgxNDE3MTIwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDIhBFezVzFGdbv/pQdBtkTLdA/8xlc
p66qdsyjNNRLQXbT9dSDc/ARD9f52S575Z9P1okIlvDPW2pGMFIc14NeP850ZXhJC6uvpbb+xIz/
9NsZbgKG+Xjj+0W6exH1rb4MhqEPI33BZxvYqBLqUIGPfBLQ4tylcQXEUUWfRHfCg99U8YzG6uEn
GbnFgl4IqbZphngtcM+qnNdI8M/+3Yxuqq0I4mgKlcZ8QzrYeQePDfHZ+WvVNmKlr0HpLRrPi4Pp
vYaaOqUJtvzI3+euAK9PMSXIiBWgLO5kwSu+POp3RnSIfsiU3Ufk7HK00rrHAtwDv6kenKyMiQmm
BnsSoVMO
--0000000000002ce9b80602e52952--
