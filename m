Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31356399EF6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFCKdG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 06:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFCKdG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 06:33:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B4C06174A
        for <linux-rdma@vger.kernel.org>; Thu,  3 Jun 2021 03:31:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t21so2657082plo.2
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jun 2021 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ZmcfLw3k6+SlIBIZa5jFhmZAitPLRSPBYRoujh7Hkhw=;
        b=fyqzhlXLoEqXqfT2NcdMkmYNS9dgpeJuJm2UYprMdr3UBLq96JcvMo7um95r3YL4nI
         wV1UoVAtO+5FkJTcy9LgwNlHbgLwRYXQrg25cYKogIox0h7SB1W3kgVfIfZaeJuS4MnB
         PnEFwe7a9JD1bTw2nE9Xh56GN1pi6yHbzRNCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ZmcfLw3k6+SlIBIZa5jFhmZAitPLRSPBYRoujh7Hkhw=;
        b=qh1xi5BTgOqwssMOk/2gTZ1NAJBt2CllCW9MlXUHihbmK7Tpu6eQsA0kAj+F5l6zhM
         TKVVP9ko6H/a0pkSb9dQzf9ngZHlT11buSuQVths2TRtP8lWTzSJlGvoqGW06s8RtDP+
         2G1qH5G/tPD1MCZdgmr0u2hhCweZY/LurxEIpUrSwSDEZUdslILGqu98wE1Hr2BjN9Nh
         DkhuaiGRg4YJe6ZFqHiRi7AJE4TJJG4IrxmFJlQHpVL9uXud6OA6gStWccNS+2ih/h4f
         1TKV7IWWQCvYBvMW6GhQFcjYJcMFqzau3mWtyl2RbbwhTw5adqoSgfQNtq7nkdzGhUMW
         fcng==
X-Gm-Message-State: AOAM531kl6buZb+6g1ROPCJwyVVtBg55Ms7SP/TsyNUbBlr0YtEW8Eu5
        eDx4Csl5FZ4VRBMXrDLRn5D7fD9vnBsdP47BWrNvMh7FsGvoUYElmn/qWGkhFhqC9ilsWN9wzEV
        2Pq9lcTVPoxmBuJM47FFxOO08DjmRUmqGwSX6FRxFtca9SkNcVqf8n3SCMGjRaLxpThv2fFPw2N
        eMUtPR6A==
X-Google-Smtp-Source: ABdhPJwvFBcxGuBY4jmD0owmCkQS46R0rHOflK+iInDiv4oGskAgadByxKPbBSHgmgh39bbLDw9TPQ==
X-Received: by 2002:a17:90b:4008:: with SMTP id ie8mr11735470pjb.19.1622716277489;
        Thu, 03 Jun 2021 03:31:17 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id ne4sm1298000pjb.26.2021.06.03.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:31:17 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V6 for-next 1/3] RDMA/bnxt_re: Enable global atomic ops if platform supports
Date:   Thu,  3 Jun 2021 16:00:55 +0530
Message-Id: <20210603103057.980996-2-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603103057.980996-1-devesh.sharma@broadcom.com>
References: <20210603103057.980996-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000059797105c3da13b2"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000059797105c3da13b2
Content-Transfer-Encoding: 8bit

Enabling Atomic operations for Gen P5 devices if the underlying
platform supports global atomic ops.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++++
 drivers/infiniband/hw/bnxt_re/main.c      |  3 +++
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 +++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 13 ++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 --
 6 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 537471ffaa79..a113d8d9e9ed 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -163,6 +163,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	ib_attr->max_qp_init_rd_atom = dev_attr->max_qp_init_rd_atom;
 	ib_attr->atomic_cap = IB_ATOMIC_NONE;
 	ib_attr->masked_atomic_cap = IB_ATOMIC_NONE;
+	if (dev_attr->is_atomic) {
+		ib_attr->atomic_cap = IB_ATOMIC_GLOB;
+		ib_attr->masked_atomic_cap = IB_ATOMIC_GLOB;
+	}
 
 	ib_attr->max_ee_rd_atom = 0;
 	ib_attr->max_res_rd_atom = 0;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b090dfa4f4cb..0de4e22f9750 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -128,6 +128,9 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	rdev->rcfw.res = &rdev->qplib_res;
 
 	bnxt_re_set_drv_mode(rdev, wqe_mode);
+	if (bnxt_qplib_determine_atomics(en_dev->pdev))
+		ibdev_info(&rdev->ibdev,
+			   "platform doesn't support global atomics.");
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 3ca47004b752..108a591e66ff 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -959,3 +959,20 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
 	bnxt_qplib_free_res(res);
 	return rc;
 }
+
+int bnxt_qplib_determine_atomics(struct pci_dev *dev)
+{
+	int comp;
+	u16 ctl2;
+
+	comp = pci_enable_atomic_ops_to_root(dev,
+					     PCI_EXP_DEVCAP2_ATOMIC_COMP32);
+	if (comp)
+		return -ENOTSUPP;
+	comp = pci_enable_atomic_ops_to_root(dev,
+					     PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	if (comp)
+		return -ENOTSUPP;
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctl2);
+	return !(ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
+}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 7a1ab38b95da..d2aea52bd1d8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -373,6 +373,7 @@ void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx,
 			 bool virt_fn, bool is_p5);
+int bnxt_qplib_determine_atomics(struct pci_dev *dev);
 
 static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_hwq *hwq, u32 cnt)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 049b3576302b..3d9259632eb3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -54,6 +54,17 @@ const struct bnxt_qplib_gid bnxt_qplib_gid_zero = {{ 0, 0, 0, 0, 0, 0, 0, 0,
 
 /* Device */
 
+static bool bnxt_qplib_is_atomic_cap(struct bnxt_qplib_rcfw *rcfw)
+{
+	u16 pcie_ctl2 = 0;
+
+	if (!bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+		return false;
+
+	pcie_capability_read_word(rcfw->pdev, PCI_EXP_DEVCTL2, &pcie_ctl2);
+	return (pcie_ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
+}
+
 static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 				     char *fw_ver)
 {
@@ -162,7 +173,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 		attr->tqm_alloc_reqs[i * 4 + 3] = *(++tqm_alloc);
 	}
 
-	attr->is_atomic = false;
+	attr->is_atomic = bnxt_qplib_is_atomic_cap(rcfw);
 bail:
 	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
 	return rc;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index bc228340684f..260104783691 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -42,8 +42,6 @@
 
 #define BNXT_QPLIB_RESERVED_QP_WRS	128
 
-#define PCI_EXP_DEVCTL2_ATOMIC_REQ      0x0040
-
 struct bnxt_qplib_dev_attr {
 #define FW_VER_ARR_LEN			4
 	u8				fw_ver[FW_VER_ARR_LEN];
-- 
2.25.1


--00000000000059797105c3da13b2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHgt1TEnptsSGD/3p4GPdtyjG5Kj
WP+62jGaEhgviaCSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYwMzEwMzExOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA8qIJz4PmZ/dcVV7YVIN0Dqph+y/XWLacMLp1nHzB2kMFC
8ODTNIVoFx3gb71foq5Gs3mQ44GfMRU7Wlb6Aegfq6o3nhwCz8Gq64Pi7O9kCO2EaGjZc8pG/2Jg
6rZ5RSTAkNqN85ZPYmj/e/UBxf56YyB6twTWslAiQCxCCZnTJnzK/F6GrTtH0YUgtCIURcBzUxUu
GGiahw5CpHQNoJkIiqXveSdhWlRI1JPqrOdJFHIIYfyOKRo76kF05VCUxbdOl+Vsuc+FMa/fn7Tg
ULMYSOlqV90UBj3ka/SxctkIEUO2vUShr/RJT0KZCj0RmieZG4IZ6SQRiaDC4HqQvDxy
--00000000000059797105c3da13b2--
