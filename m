Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8A3AA54F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 22:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhFPUam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhFPUaj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Jun 2021 16:30:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F7C061574
        for <linux-rdma@vger.kernel.org>; Wed, 16 Jun 2021 13:28:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p13so3198637pfw.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Jun 2021 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=mnY0Kerl3gsbbglOpnQpCUHI2cutJAceKRM61jjXBG8=;
        b=F5rCnConAETQtSV0qCFQQqLSrwOfMCQ7iQRAZ3wADZEyYN7nWYoAHPb8jnvv4bnk9A
         WUj4QNUR4RLxQqjia/ZsIv1Cxt0F3zNGDuPDLGmhA0VfQ0yh9AKiEVMKyUKc8E9NGSax
         /jqCQIIZVd5TOgihr5tUBFymKyNMvqGknUUMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=mnY0Kerl3gsbbglOpnQpCUHI2cutJAceKRM61jjXBG8=;
        b=pWTjM6m09ycfmP49NjAeLaaGDif62AFxXdlvGnaJB+4kTYU367TGPoO2NfMCHszjIF
         WXkdCgFrsDahJhEvF2ykr9VjKe8sjv1kFk52x+h37/xqTB7iPzKpy9qPvKWv2A7J9hoA
         Ww/AR4lFzf9imJPiWtEVvSdj2nptnb0hnhKIEsT6mUD+jy+YtOh9VJ0/JmHO+oUPYZI/
         8QDHr2R/yN2aDN1HvPsPYTNO55TfRJKZ+DGSe+F5rLD6Ex2u42AZqwH+llrvecA+q0ng
         g3Tq5/xWqZSWDIoptSt4BM7G0NmJxG9NeaCgQ645j//67/i1PXGrEiEGeGtxPD1w9Rpd
         xFQw==
X-Gm-Message-State: AOAM5330odi85F4FH5+dpKSnndOi0lCK4oHMAYjVCMFH1gg7PktVt+6O
        D3T0M5V0FbagKj9e2XsCZY7p6taanjnGWHCuzxKTb8vjm7AqKFMYdVasyEoM47jULaGDdaQ0qkD
        lVxYIBjJJ1rStxcNay3T9ImfQ9pkqH2zRQP7OCGx1YZzDakDu7d8Xv/cmqQcBa4ptlx2WT54Whf
        x4eerhmQ==
X-Google-Smtp-Source: ABdhPJwHG2m6jbbZBjLkkuIVRZXfMcEfrOMj0EH9KOXfq0pXuCOc3JKb8uenUL1uce3bDjEyYOL9kQ==
X-Received: by 2002:a63:f955:: with SMTP id q21mr1428293pgk.448.1623875311624;
        Wed, 16 Jun 2021 13:28:31 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s123sm2910498pfb.78.2021.06.16.13.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:28:31 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V8 for-next] RDMA/bnxt_re: update ABI to pass wqe-mode to user space
Date:   Thu, 17 Jun 2021 01:58:17 +0530
Message-Id: <20210616202817.1185276-1-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000025e22205c4e7efd6"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000025e22205c4e7efd6
Content-Transfer-Encoding: 8bit

Changing ucontext ABI response structure to pass wqe_mode
to user library.
A flag in comp_mask has been set to indicate presence of
wqe_mode.

Moved wqe-mode ABI to uapi/rdma/bnxt_re-abi.h

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  3 +++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ------
 include/uapi/rdma/bnxt_re-abi.h           | 11 ++++++++++-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a113d8d9e9ed..5955713234cb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3882,6 +3882,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	resp.max_cqd = dev_attr->max_cq_wqes;
 	resp.rsvd    = 0;
 
+	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
+	resp.mode = rdev->chip_ctx->modes.wqe_mode;
+
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
 	if (rc) {
 		ibdev_err(ibdev, "Failed to copy user context");
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index f50784405e27..037501952543 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -39,6 +39,8 @@
 #ifndef __BNXT_QPLIB_FP_H__
 #define __BNXT_QPLIB_FP_H__
 
+#include <rdma/bnxt_re-abi.h>
+
 /* Few helper structures temporarily defined here
  * should get rid of these when roce_hsi.h is updated
  * in original code base
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index d2aea52bd1d8..c291f495ae91 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -45,12 +45,6 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 #define CHIP_NUM_57504		0x1751
 #define CHIP_NUM_57502		0x1752
 
-enum bnxt_qplib_wqe_mode {
-	BNXT_QPLIB_WQE_MODE_STATIC	= 0x00,
-	BNXT_QPLIB_WQE_MODE_VARIABLE	= 0x01,
-	BNXT_QPLIB_WQE_MODE_INVALID	= 0x02
-};
-
 struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
 	/* Other modes to follow here */
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index dc52e3cf574c..b1de99bf56ce 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -49,7 +49,14 @@
 #define BNXT_RE_CHIP_ID0_CHIP_MET_SFT		0x18
 
 enum {
-	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL
+	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL,
+	BNXT_RE_UCNTX_CMASK_HAVE_MODE = 0x02ULL,
+};
+
+enum bnxt_re_wqe_mode {
+	BNXT_QPLIB_WQE_MODE_STATIC	= 0x00,
+	BNXT_QPLIB_WQE_MODE_VARIABLE	= 0x01,
+	BNXT_QPLIB_WQE_MODE_INVALID	= 0x02,
 };
 
 struct bnxt_re_uctx_resp {
@@ -62,6 +69,8 @@ struct bnxt_re_uctx_resp {
 	__aligned_u64 comp_mask;
 	__u32 chip_id0;
 	__u32 chip_id1;
+	__u32 mode;
+	__u32 rsvd1; /* padding */
 };
 
 /*
-- 
2.25.1


--00000000000025e22205c4e7efd6
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBqZyGcJVkAAJtx3BC+5SHzDAEoz
fflthBTtgePchoGiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYxNjIwMjgzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA13DAiRMYODhkfcHczZOXpbstzOkd+381CaAlS2EDlqGt+
lBzxDVhbUeISw++gXuYtfg2R59oSAjs0MEdzqZKtuZYDxHUIr0EFEuwdGfQ+2yn7erTzcxElePRN
I7/VWFoHDDKMH18SldOYvfXK98sORELqxBFc9wupF5trxiJLA2+fXKucRXd0M9GZHQVSLEtreUWO
b1gVpJIlDjP4x7wRXttdPPt43HmzR7OeWpKESr3gXSTomj3jLIwvdEvA9GmXbAQyg9ff1baNTZJ2
9bMnArno818N0G7Yad7NzLy5UBsk5adg9YjPuCXwrgHv5+n/z5AhP6t0w9lbP+D2NsAY
--00000000000025e22205c4e7efd6--
