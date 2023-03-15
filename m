Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723456BAA91
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 09:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjCOIRQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 04:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjCOIRN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 04:17:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945D6A06C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 01:17:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v21so9083183ple.9
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678868229;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mLaQ1vh45UIdLcyJqbOReYerT+bdgydOGQqjH8kflY=;
        b=QgvPVY+v2IF16PeFfVFPoFS14p2h1++QhEevjBzxixJST8rfXJLaG6rGQKM+70H4y2
         AJL/uDarerK53+gKZpiUR6N2W7H/DzLbCLrL3ogR9SYefuX7wvexClwf/z2opnv/bp3Y
         jSci2/Ts5xabnEIdThqlf4vJ6zTBV+iiLOWMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678868229;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mLaQ1vh45UIdLcyJqbOReYerT+bdgydOGQqjH8kflY=;
        b=Nk/7DB9rPTeFpuCxOKhXdWS4sDvfMjGLmpHIh2a4Ny8opisxPwwre3Wzuc4lRbgRWO
         8YFoR8eswio0go53AvBGVB5502wmXc39iigtn/X36cksyj2/rd9+hAHd79I0/8lE2phO
         idFKSaw+JDUhcCrOZm1QDIVPF45Arnje1DWFOYcHZ0vt8k0J2ZUY9BD30fmwCyD6WXYI
         rPQuoi1wZ+bj0DXS7Uvfi8F4b+MhaqnHbwZwwm9psfYOafyhVZf63UukPaPkSMiWVWJz
         2fySoH7YCbec4LiaIcwAX3ybFY3Si90u9YLVt7iS2ljNHaWGSol92nErUyb0uPqFUKnj
         z4wQ==
X-Gm-Message-State: AO0yUKW4UVwrFlyN7+fPddEV+bKYWsg04lsUMF7pt9/AHLKvps492bnJ
        qcxkzcJ/2OClyzVHSeAbrV4RqBHdXSvX8vI3I0w=
X-Google-Smtp-Source: AK7set+JzIH3/JP16ZAR5cnqmmaBoavKu//9jd/yay7d/cUm1Q8JblwOiqG7Z9L9Ew29t3BITkKoVA==
X-Received: by 2002:a05:6a20:8e02:b0:ce:ca9:ab56 with SMTP id y2-20020a056a208e0200b000ce0ca9ab56mr51445512pzj.34.1678868228951;
        Wed, 15 Mar 2023 01:17:08 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78198000000b0058b927b9653sm2985706pfi.92.2023.03.15.01.17.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:17:08 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     leon@kernel.org, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Add resize_cq support
Date:   Wed, 15 Mar 2023 01:16:55 -0700
Message-Id: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007074e905f6ebf878"
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000007074e905f6ebf878

Add resize_cq verb support for user space CQs. Resize operation for
kernel CQs are not supported now.

Driver should free the current CQ only after user library polls
for all the completions and switch to new CQ. So after the resize_cq
is returned from the driver, user libray polls for existing completions
and store it as temporary data. Once library reaps all completions in the
current CQ, it invokes the ibv_cmd_poll_cq to inform the driver about
the resize_cq completion. Adding a check for user CQs in driver's
poll_cq and complete the resize operation for user CQs.
Updating uverbs_cmd_mask with poll_cq to support this.

User library changes are available in this pull request.
https://github.com/linux-rdma/rdma-core/pull/1315

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 109 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
 drivers/infiniband/hw/bnxt_re/main.c     |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  44 +++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   5 ++
 include/uapi/rdma/bnxt_re-abi.h          |   4 ++
 6 files changed, 167 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 989edc7..e86afec 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2912,6 +2912,106 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return rc;
 }
 
+static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
+{
+	struct bnxt_re_dev *rdev = cq->rdev;
+
+	bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
+
+	cq->qplib_cq.max_wqe = cq->resize_cqe;
+	if (cq->resize_umem) {
+		ib_umem_release(cq->umem);
+		cq->umem = cq->resize_umem;
+		cq->resize_umem = NULL;
+		cq->resize_cqe = 0;
+	}
+}
+
+int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
+{
+	struct bnxt_qplib_sg_info sg_info = {};
+	struct bnxt_qplib_dpi *orig_dpi = NULL;
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_re_ucontext *uctx = NULL;
+	struct bnxt_re_resize_cq_req req;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_cq *cq;
+	int rc, entries;
+
+	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
+	rdev = cq->rdev;
+	dev_attr = &rdev->dev_attr;
+	if (!ibcq->uobject) {
+		ibdev_err(&rdev->ibdev, "Kernel CQ Resize not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (cq->resize_umem) {
+		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - Busy",
+			  cq->qplib_cq.id);
+		return -EBUSY;
+	}
+
+	/* Check the requested cq depth out of supported depth */
+	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
+		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - out of range cqe %d",
+			  cq->qplib_cq.id, cqe);
+		return -EINVAL;
+	}
+
+	entries = roundup_pow_of_two(cqe + 1);
+	if (entries > dev_attr->max_cq_wqes + 1)
+		entries = dev_attr->max_cq_wqes + 1;
+
+	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,
+					 ib_uctx);
+	/* uverbs consumer */
+	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
+		rc = -EFAULT;
+		goto fail;
+	}
+
+	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
+				      entries * sizeof(struct cq_base),
+				      IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(cq->resize_umem)) {
+		rc = PTR_ERR(cq->resize_umem);
+		cq->resize_umem = NULL;
+		ibdev_err(&rdev->ibdev, "%s: ib_umem_get failed! rc = %d\n",
+			  __func__, rc);
+		goto fail;
+	}
+	cq->resize_cqe = entries;
+	memcpy(&sg_info, &cq->qplib_cq.sg_info, sizeof(sg_info));
+	orig_dpi = cq->qplib_cq.dpi;
+
+	cq->qplib_cq.sg_info.umem = cq->resize_umem;
+	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
+	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
+	cq->qplib_cq.dpi = &uctx->dpi;
+
+	rc = bnxt_qplib_resize_cq(&rdev->qplib_res, &cq->qplib_cq, entries);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Resize HW CQ %#x failed!",
+			  cq->qplib_cq.id);
+		goto fail;
+	}
+
+	cq->ib_cq.cqe = cq->resize_cqe;
+
+	return 0;
+
+fail:
+	if (cq->resize_umem) {
+		ib_umem_release(cq->resize_umem);
+		cq->resize_umem = NULL;
+		cq->resize_cqe = 0;
+		memcpy(&cq->qplib_cq.sg_info, &sg_info, sizeof(sg_info));
+		cq->qplib_cq.dpi = orig_dpi;
+	}
+	return rc;
+}
+
 static u8 __req_to_ib_wc_status(u8 qstatus)
 {
 	switch (qstatus) {
@@ -3425,6 +3525,15 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	struct bnxt_re_sqp_entries *sqp_entry = NULL;
 	unsigned long flags;
 
+	/* User CQ; the only processing we do is to
+	 * complete any pending CQ resize operation.
+	 */
+	if (cq->umem) {
+		if (cq->resize_umem)
+			bnxt_re_resize_cq_complete(cq);
+		return 0;
+	}
+
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	budget = min_t(u32, num_entries, cq->max_cql);
 	num_entries = budget;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 9432626..31f7e34 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -104,6 +104,8 @@ struct bnxt_re_cq {
 #define MAX_CQL_PER_POLL	1024
 	u32			max_cql;
 	struct ib_umem		*umem;
+	struct ib_umem		*resize_umem;
+	int			resize_cqe;
 };
 
 struct bnxt_re_mr {
@@ -191,6 +193,7 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct ib_udata *udata);
+int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
 int bnxt_re_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c5867e7..48bbba7 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -553,6 +553,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.query_srq = bnxt_re_query_srq,
 	.reg_user_mr = bnxt_re_reg_user_mr,
 	.req_notify_cq = bnxt_re_req_notify_cq,
+	.resize_cq = bnxt_re_resize_cq,
 	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, bnxt_re_cq, ib_cq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, bnxt_re_pd, ib_pd),
@@ -584,6 +585,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 		return ret;
 
 	dma_set_max_seg_size(&rdev->en_dev->pdev->dev, UINT_MAX);
+	ibdev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POLL_CQ);
 	return ib_register_device(ibdev, "bnxt_re%d", &rdev->en_dev->pdev->dev);
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 96e581c..1d769a3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2100,6 +2100,50 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	return rc;
 }
 
+void bnxt_qplib_resize_cq_complete(struct bnxt_qplib_res *res,
+				   struct bnxt_qplib_cq *cq)
+{
+	bnxt_qplib_free_hwq(res, &cq->hwq);
+	memcpy(&cq->hwq, &cq->resize_hwq, sizeof(cq->hwq));
+}
+
+int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
+			 int new_cqes)
+{
+	struct bnxt_qplib_hwq_attr hwq_attr = {};
+	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct creq_resize_cq_resp resp = {};
+	struct cmdq_resize_cq req = {};
+	struct bnxt_qplib_pbl *pbl;
+	u32 pg_sz, lvl, new_sz;
+	u16 cmd_flags = 0;
+	int rc;
+
+	RCFW_CMD_PREP(req, RESIZE_CQ, cmd_flags);
+	hwq_attr.sginfo = &cq->sg_info;
+	hwq_attr.res = res;
+	hwq_attr.depth = new_cqes;
+	hwq_attr.stride = sizeof(struct cq_base);
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&cq->resize_hwq, &hwq_attr);
+	if (rc)
+		return rc;
+
+	req.cq_cid = cpu_to_le32(cq->id);
+	pbl = &cq->resize_hwq.pbl[PBL_LVL_0];
+	pg_sz = bnxt_qplib_base_pg_size(&cq->resize_hwq);
+	lvl = (cq->resize_hwq.level << CMDQ_RESIZE_CQ_LVL_SFT) &
+				       CMDQ_RESIZE_CQ_LVL_MASK;
+	new_sz = (new_cqes << CMDQ_RESIZE_CQ_NEW_CQ_SIZE_SFT) &
+		  CMDQ_RESIZE_CQ_NEW_CQ_SIZE_MASK;
+	req.new_cq_size_pg_size_lvl = cpu_to_le32(new_sz | pg_sz | lvl);
+	req.new_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
+
+	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
+					  (void *)&resp, NULL, 0);
+	return rc;
+}
+
 int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 0375019..d74d5ea 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -400,6 +400,7 @@ struct bnxt_qplib_cq {
 	u16				count;
 	u16				period;
 	struct bnxt_qplib_hwq		hwq;
+	struct bnxt_qplib_hwq		resize_hwq;
 	u32				cnq_hw_ring_id;
 	struct bnxt_qplib_nq		*nq;
 	bool				resize_in_progress;
@@ -532,6 +533,10 @@ void bnxt_qplib_post_recv_db(struct bnxt_qplib_qp *qp);
 int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 			 struct bnxt_qplib_swqe *wqe);
 int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq);
+int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
+			 int new_cqes);
+void bnxt_qplib_resize_cq_complete(struct bnxt_qplib_res *res,
+				   struct bnxt_qplib_cq *cq);
 int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq);
 int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 		       int num, struct bnxt_qplib_qp **qp);
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index b1de99b..f761e75 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -96,6 +96,10 @@ struct bnxt_re_cq_resp {
 	__u32 rsvd;
 };
 
+struct bnxt_re_resize_cq_req {
+	__u64 cq_va;
+};
+
 struct bnxt_re_qp_req {
 	__aligned_u64 qpsva;
 	__aligned_u64 qprva;
-- 
2.5.5


--0000000000007074e905f6ebf878
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKgh8PrqftHo
US/BWARxd+/RWgAuFt0ye7bXmLUggc6CMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMxNTA4MTcwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCkyiwSZ32MjEbE7OjdgZe0yVM8V5nL
zS4KdCKYhqyQ/Z35qFGz9XFANu6NoOBT21gjy16Vq3bplSTNORgjHj55+ntSh3Ee1nhrIsQNAllj
F0AqOc6PPoQMRGxMtIadO2kq5SyloNWLAr02xGzAa+wPPwvLUYBPjeBwEBqT5O65p1X8VS0J5dsJ
U8G5YGPD3G6PuZ0jezjZyWc4nJdy3dUPegVXHDEDZ9EQ4E34Ddq9aL4n78KKR0cyPb4BQnRZEKXn
Yt8Qu7SurmByxq8LXyMMjNVgdqTmaHFovoi4gl4osBIG5GbPyZ+1p9c6lAjXhIt/tu8iLXybh7MI
TC7TX10u
--0000000000007074e905f6ebf878--
