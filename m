Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63E768FD0
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjGaIPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGaIPE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 04:15:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E7210B
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 01:13:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686ed1d2594so4089692b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690791179; x=1691395979;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ibkgTPoIFcZiCx3ujdUHo+jA13NWiomc/u4FEVuxcxk=;
        b=aLfsj1cyfTgSseHcvOcNDgFx+yuWNCU/Tr+Ty2yJ4t2morDH1WnIh0gscjrEpWUlPD
         bkyIkx4bWXICdPzoBTy0Fc0ei5Bwrn8PYxMlyginCEzvXQ3gl5TKZv0fH85XWTzngrf+
         Edzfm6NWPuOIXfjktBIppZ1N+v3wJdLXfLm6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791179; x=1691395979;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibkgTPoIFcZiCx3ujdUHo+jA13NWiomc/u4FEVuxcxk=;
        b=FyaDXTLxTD0+5nUiSTY0RWXXthR2lAbPynx0MMDHFQqHucp6NFL5CFcbIk8u55chdB
         07ziKDeZPdjm4VBXdFh7xjUfSzuvG3MkYkMWiulqRl5yzVQ6KRf3kNoYk8kNr17pFEqU
         EW0Ggy9dYDwzChTQcXklHmSy+ePh+X1p567yG5aQ4x2W+J3N+OprF5JjHatfCPn3YFJb
         DXZesLR29EoHuiH0Wi9Zaj6fW+yEnCdpSzwPVTr+6ymjfLLYoOB9stNiiQoAA4b01uI5
         ebRHlY/vzeJD+nDB8AML9Rv5kh3FbZDyUx/j3BBo3QaEi1qc9XtKsNPnxmhQWOqdETpb
         dbqg==
X-Gm-Message-State: ABy/qLZJOq3Nh8H+CmNs7mC0xWKi8bdvgQG9qE2Wsygf+RriSL3gObwC
        J9pYF5FBe3xzde4APEK+fYI1QQ==
X-Google-Smtp-Source: APBJJlF6Zy97OgUYB+FTy2ktRRwunh1foP8d8PAfsNAHDJTQtryvdGmCvcEVwfeFhJpiVYnfLCmhDA==
X-Received: by 2002:a05:6a21:35c2:b0:137:53d1:405 with SMTP id ba2-20020a056a2135c200b0013753d10405mr9975306pzc.26.1690791179206;
        Mon, 31 Jul 2023 01:12:59 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00686a80f431dsm6996561pfo.126.2023.07.31.01.12.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:12:58 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 1/1] RDMA/bnxt_re: Add support for dmabuf pinned memory regions
Date:   Mon, 31 Jul 2023 01:01:13 -0700
Message-Id: <1690790473-25850-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1690790473-25850-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690790473-25850-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a73bff0601c3ff20"
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

--000000000000a73bff0601c3ff20

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Support the new verb which indicates dmabuf support.
bnxt doesn't support ODP. So use the pinned version of the
dmabuf APIs to enable bnxt_re devices to work as dmabuf importer.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 83 ++++++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 ++
 drivers/infiniband/hw/bnxt_re/main.c     |  1 +
 3 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2b2505a..718572d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3981,16 +3981,13 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
 	return rc;
 }
 
-/* uverbs */
-struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
-				  u64 virt_addr, int mr_access_flags,
-				  struct ib_udata *udata)
+static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64 virt_addr,
+					   int mr_access_flags, struct ib_umem *umem)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
-	struct bnxt_re_mr *mr;
-	struct ib_umem *umem;
 	unsigned long page_size;
+	struct bnxt_re_mr *mr;
 	int umem_pgs, rc;
 	u32 active_mrs;
 
@@ -4000,6 +3997,12 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	page_size = ib_umem_find_best_pgsz(umem, BNXT_RE_PAGE_SIZE_SUPPORTED, virt_addr);
+	if (!page_size) {
+		ibdev_err(&rdev->ibdev, "umem page size unsupported!");
+		return ERR_PTR(-EINVAL);
+	}
+
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
@@ -4011,36 +4014,23 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
-		ibdev_err(&rdev->ibdev, "Failed to allocate MR");
+		ibdev_err(&rdev->ibdev, "Failed to allocate MR rc = %d", rc);
+		rc = -EIO;
 		goto free_mr;
 	}
 	/* The fixed portion of the rkey is the same as the lkey */
 	mr->ib_mr.rkey = mr->qplib_mr.rkey;
-
-	umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
-	if (IS_ERR(umem)) {
-		ibdev_err(&rdev->ibdev, "Failed to get umem");
-		rc = -EFAULT;
-		goto free_mrw;
-	}
 	mr->ib_umem = umem;
-
 	mr->qplib_mr.va = virt_addr;
-	page_size = ib_umem_find_best_pgsz(
-		umem, BNXT_RE_PAGE_SIZE_SUPPORTED, virt_addr);
-	if (!page_size) {
-		ibdev_err(&rdev->ibdev, "umem page size unsupported!");
-		rc = -EFAULT;
-		goto free_umem;
-	}
 	mr->qplib_mr.total_size = length;
 
 	umem_pgs = ib_umem_num_dma_blocks(umem, page_size);
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, umem,
 			       umem_pgs, page_size);
 	if (rc) {
-		ibdev_err(&rdev->ibdev, "Failed to register user MR");
-		goto free_umem;
+		ibdev_err(&rdev->ibdev, "Failed to register user MR - rc = %d\n", rc);
+		rc = -EIO;
+		goto free_mrw;
 	}
 
 	mr->ib_mr.lkey = mr->qplib_mr.lkey;
@@ -4050,8 +4040,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 		rdev->stats.res.mr_watermark = active_mrs;
 
 	return &mr->ib_mr;
-free_umem:
-	ib_umem_release(umem);
+
 free_mrw:
 	bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
 free_mr:
@@ -4059,6 +4048,48 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	return ERR_PTR(rc);
 }
 
+struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
+				  u64 virt_addr, int mr_access_flags,
+				  struct ib_udata *udata)
+{
+	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
+	struct bnxt_re_dev *rdev = pd->rdev;
+	struct ib_umem *umem;
+	struct ib_mr *ib_mr;
+
+	umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
+	if (IS_ERR(umem))
+		return ERR_CAST(umem);
+
+	ib_mr = __bnxt_re_user_reg_mr(ib_pd, length, virt_addr, mr_access_flags, umem);
+	if (IS_ERR(ib_mr))
+		ib_umem_release(umem);
+	return ib_mr;
+}
+
+struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 start,
+					 u64 length, u64 virt_addr, int fd,
+					 int mr_access_flags, struct ib_udata *udata)
+{
+	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
+	struct bnxt_re_dev *rdev = pd->rdev;
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct ib_umem *umem;
+	struct ib_mr *ib_mr;
+
+	umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, start, length,
+						fd, mr_access_flags);
+	if (IS_ERR(umem_dmabuf))
+		return ERR_CAST(umem_dmabuf);
+
+	umem = &umem_dmabuf->umem;
+
+	ib_mr = __bnxt_re_user_reg_mr(ib_pd, length, virt_addr, mr_access_flags, umem);
+	if (IS_ERR(ib_mr))
+		ib_umem_release(umem);
+	return ib_mr;
+}
+
 int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 {
 	struct ib_device *ibdev = ctx->device;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index f392a09..84715b7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -229,6 +229,10 @@ int bnxt_re_dealloc_mw(struct ib_mw *mw);
 struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  u64 virt_addr, int mr_access_flags,
 				  struct ib_udata *udata);
+struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 start,
+					 u64 length, u64 virt_addr,
+					 int fd, int mr_access_flags,
+					 struct ib_udata *udata);
 int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata);
 void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 87960ac..c467415 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -862,6 +862,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.query_qp = bnxt_re_query_qp,
 	.query_srq = bnxt_re_query_srq,
 	.reg_user_mr = bnxt_re_reg_user_mr,
+	.reg_user_mr_dmabuf = bnxt_re_reg_user_mr_dmabuf,
 	.req_notify_cq = bnxt_re_req_notify_cq,
 	.resize_cq = bnxt_re_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
-- 
2.5.5


--000000000000a73bff0601c3ff20
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIO5uSXjI+VY
P1S4zzBNamNhJ1pVpWekhhvvFXDuW8l2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDczMTA4MTI1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB/+oYZV+i8yN+yhtgop19x6Z6SDASg
XaRxhVcVlyHPHuLKS0LGNBDCY3FFmeORwjndTSLCa+taxcQNDJACsizH3IKbk4nx21XsxcJPd8GX
FsVN24pjpv1M28f3VPcNJ4CSEfQzVpD+579pMkcXsaPsVRna0Kz2pvWifBOT1JiH9fT5jSevMNRh
4duucsQMU2n28MqWhODIc/KNHmsLG+pSH4EuFPj6XqJOiwYwoy5rL+YTe1xwPpqaKL+6HZvV5kFs
GklrxZSgF5ikh8n/3wV1ku+w1aePHgSaslSe3xxd4FWN5bot2/zZDLhha96dxv3mtVOMZ+2He2Rb
QE8b2nlN
--000000000000a73bff0601c3ff20--
