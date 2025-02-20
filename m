Return-Path: <linux-rdma+bounces-7908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE58FA3E459
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 19:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE55189EE16
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45E265617;
	Thu, 20 Feb 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eK5IZSoe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4226388E
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077767; cv=none; b=REGGXv9KabcsHIyB7ONrwKaCzuWe2xY/OqR9HuNS1Yn6ZNC+VdnuInB1gR9MIRThMEhfhx1xJKLA8t42HywVb0BGF0wyaZnOvDLL10mVp9WY5bI9T8hUL0vexNLTnVkctH/mM7ZmRDCmGJ2b28Kl0MeijREGoeQ3I7I3Qhi3wMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077767; c=relaxed/simple;
	bh=e39Ye7f115z5V+apYQtx/SpSC66HkndM95PkDhQUplA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CGx6V0Ne9bGGYNnA4DCRcG7CT8rU2qnF5nJz6ZMhLJvCoougf3koRyLEwvMHOX7yerMb/046YK8fuo/MTQ0T1cC4X8RB4ylfhG08L+D5BfDFeQEGE4nVcnDjuesRHYCfzZKtoKtzMfHNOhsL1HeVcZVAomt+9Hrg1bSULo87jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eK5IZSoe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21c2f1b610dso35644625ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077765; x=1740682565; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PBW5jpO95lyNQP0CO3WA3VL0tUEtqSN8vPLv1rH3qtg=;
        b=eK5IZSoemjr4SSUgJaZ+Uc700VsnHd2/2hKolark4FtoClu4vHkE2sQk5fvYGPd5kH
         hvDdjfhNbv1NvJjYZTFChzORUWSlFESwG0R6Shej8TzBpzDIf3FGHwvwjKYdfl2l8v8T
         sl+ArTwudajLuYNvUUFoKQq+qHdijVlb/nsj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077765; x=1740682565;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBW5jpO95lyNQP0CO3WA3VL0tUEtqSN8vPLv1rH3qtg=;
        b=ZfHMjNVZVYta1Vl/8d6aZV/PVg1qOslwQoM6Rlk+hEwig20cJFx8AsAJqYfLvQxxh5
         YmDdWYILeDmR8V8vFPFx28911XdtksobocBOny6QlAlMKMzsiVQdUezuyC3QNNaEDiVE
         +SS4JFu+Q5QSwJbxG6NfO9JsSRRePb88fZ+6n5PdzJ0DGTFMae5jxo8kbbaNLdBnRDe1
         ghNGGd2+Yw6NHZi/eN3R9SQbMaZop03O6c6lgrGWbmS3o7hpxRK777lXGwhFPefhN6XI
         1ezlBTgD+Nt2xBi/rheVBhV0ozFhtGs5y0cbk+lfbFcHx722DUebWEeDwfOoR1tlVHP1
         kRNQ==
X-Gm-Message-State: AOJu0Yzor36dmXDUntfyG/Z1CIX0tplWvQojmyCZ17mKu8YX2FQ3zhUO
	EM7H3j0IQUejF7j79zYK90tlNEU5hiF/nTfVs3Uv3ouFze9PTtZM3eVI8PH9Xg==
X-Gm-Gg: ASbGncuDCI3LhayAKby/BgOc/+bvppV06NL+LAQhmC94PR+D+e1XR06SultQX6XogIB
	ZvLRcD0VDRrnxAC1B8KRRtuZARWYxmg8/6bZ1PaRkMY4Dkt4JYf1C8HMjaV0T2ns6lXJ8wR69wV
	8ziaiAvSlf0WIIva/W6rl6zmmFmMQ+rxRfOo2cd1KcMK0GbM9fahphPq9CZ+Gc0yQo/3n+sgSeR
	m5qSXKNyG2DLp7QHDKPAybZBtQIc6dRcHgirNFNrbqz8Foja8QQIO5Q7f8YI7mTp9GBBxhVgo0d
	R7pttWyR3Y6Ehxg3cBW9+utn1chXQ6XhVxXMHTVfDy/ImoYoGdlzbQGUUDyNMrEDhxe0U60=
X-Google-Smtp-Source: AGHT+IGgxyoRm0rro/+RGU0DQSiNh0KMz3mFvEijqmEYGx7+Kd8cXubMPj5jjq6aQuAQ/+11wvdvFQ==
X-Received: by 2002:a05:6a21:3949:b0:1ee:c7c8:cad with SMTP id adf61e73a8af0-1eef3dc67c0mr335619637.28.1740077764264;
        Thu, 20 Feb 2025 10:56:04 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.56.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:56:03 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 4/9] RDMA/bnxt_re: Get the resource contexts from the HW
Date: Thu, 20 Feb 2025 10:34:51 -0800
Message-Id: <1740076496-14227-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

While destroying the resources like QP/CQ/SRQ/MRs, FW sends
the contexts to the host. Driver caches these information
to be dumped later for debugging. Driver can hold the information
of the last 1024 entries of each resources.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   9 +++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 120 +++++++++++++++++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  47 +++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   9 ++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  15 +++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   3 +-
 6 files changed, 181 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 5818db1..45601635 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -175,6 +175,15 @@ static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 
 #define BNXT_RE_MAX_QDUMP_ENTRIES 1024
 
+enum {
+	BNXT_RE_RES_TYPE_CQ = 0,
+	BNXT_RE_RES_TYPE_UCTX,
+	BNXT_RE_RES_TYPE_QP,
+	BNXT_RE_RES_TYPE_SRQ,
+	BNXT_RE_RES_TYPE_MR,
+	BNXT_RE_RES_TYPE_MAX
+};
+
 struct qdump_qpinfo {
 	u32 id;
 	u32 dest_qpid;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 060143e..a1ee6ca 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -537,7 +537,7 @@ static void bnxt_re_destroy_fence_mr(struct bnxt_re_pd *pd)
 			bnxt_qplib_dereg_mrw(&rdev->qplib_res, &mr->qplib_mr,
 					     true);
 		if (mr->ib_mr.lkey)
-			bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
+			bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr, 0, NULL);
 		kfree(mr);
 		fence->mr = NULL;
 	}
@@ -886,6 +886,55 @@ int bnxt_re_query_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)
 	return 0;
 }
 
+static inline void bnxt_re_save_resource_context(struct bnxt_re_dev *rdev,
+						 void *ctx_sb_data,
+						 u8 res_type, bool do_snapdump)
+{
+	void *drv_ctx_data;
+	u32 *ctx_index;
+	u16 ctx_size;
+
+	if (!ctx_sb_data)
+		return;
+
+	switch (res_type) {
+	case BNXT_RE_RES_TYPE_QP:
+		drv_ctx_data = rdev->rcfw.qp_ctxm_data;
+		ctx_index = &rdev->rcfw.qp_ctxm_data_index;
+		ctx_size = rdev->rcfw.qp_ctxm_size;
+		break;
+	case BNXT_RE_RES_TYPE_CQ:
+		drv_ctx_data = rdev->rcfw.cq_ctxm_data;
+		ctx_index = &rdev->rcfw.cq_ctxm_data_index;
+		ctx_size = rdev->rcfw.cq_ctxm_size;
+		break;
+	case BNXT_RE_RES_TYPE_MR:
+		drv_ctx_data = rdev->rcfw.mrw_ctxm_data;
+		ctx_index = &rdev->rcfw.mrw_ctxm_data_index;
+		ctx_size = rdev->rcfw.mrw_ctxm_size;
+		break;
+	case BNXT_RE_RES_TYPE_SRQ:
+		drv_ctx_data = rdev->rcfw.srq_ctxm_data;
+		ctx_index = &rdev->rcfw.srq_ctxm_data_index;
+		ctx_size = rdev->rcfw.srq_ctxm_size;
+		break;
+	default:
+		return;
+	}
+
+	if (rdev->snapdump_dbg_lvl == BNXT_RE_SNAPDUMP_ALL ||
+	    (rdev->snapdump_dbg_lvl == BNXT_RE_SNAPDUMP_ERR && do_snapdump)) {
+		memcpy(drv_ctx_data + (*ctx_index * ctx_size),
+		       ctx_sb_data, ctx_size);
+		*ctx_index = *ctx_index + 1;
+		*ctx_index = *ctx_index % BNXT_RE_MAX_QDUMP_ENTRIES;
+		dev_dbg(rdev_to_dev(rdev),
+			"%s : res_type %d ctx_index %d 0x%lx\n", __func__,
+			res_type, *ctx_index,
+			(unsigned long)drv_ctx_data + (*ctx_index * ctx_size));
+	}
+}
+
 unsigned long bnxt_re_lock_cqs(struct bnxt_re_qp *qp)
 	__acquires(&qp->scq->cq_lock) __acquires(&qp->rcq->cq_lock)
 {
@@ -930,7 +979,7 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	bnxt_qplib_clean_qp(&qp->qplib_qp);
 
 	ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
-	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
+	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp, 0, NULL);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Destroy Shadow QP failed");
 		goto fail;
@@ -1029,17 +1078,28 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	struct bnxt_qplib_nq *scq_nq = NULL;
 	struct bnxt_qplib_nq *rcq_nq = NULL;
 	unsigned int flags;
+	void  *ctx_sb_data = NULL;
+	bool do_snapdump;
+	u16 ctx_size;
 	int rc;
 
 	bnxt_re_capture_qpdump(qp);
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
+	ctx_size = qplib_qp->ctx_size_sb;
+	if (ctx_size)
+		ctx_sb_data = vzalloc(ctx_size);
+	do_snapdump = test_bit(QP_FLAGS_CAPTURE_SNAPDUMP, &qplib_qp->flags);
 
-	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
+	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp, ctx_size, ctx_sb_data);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
+	else
+		bnxt_re_save_resource_context(rdev, ctx_sb_data,
+					      BNXT_RE_RES_TYPE_QP, do_snapdump);
 
+	vfree(ctx_sb_data);
 	if (rdma_is_kernel_res(&qp->ib_qp.res)) {
 		flags = bnxt_re_lock_cqs(qp);
 		bnxt_qplib_clean_qp(&qp->qplib_qp);
@@ -1599,7 +1659,7 @@ static int bnxt_re_create_shadow_gsi(struct bnxt_re_qp *qp,
 					  &qp->qplib_qp);
 	if (!sah) {
 		bnxt_qplib_destroy_qp(&rdev->qplib_res,
-				      &sqp->qplib_qp);
+				      &sqp->qplib_qp, 0, NULL);
 		rc = -ENODEV;
 		ibdev_err(&rdev->ibdev,
 			  "Failed to create AH entry for ShadowQP");
@@ -1747,7 +1807,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	return 0;
 qp_destroy:
-	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
+	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp, 0, NULL);
 free_umem:
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
@@ -1841,6 +1901,9 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	struct bnxt_re_dev *rdev = srq->rdev;
 	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
 	struct bnxt_qplib_nq *nq = NULL;
+	void  *ctx_sb_data = NULL;
+	bool do_snapdump;
+	u16 ctx_size;
 
 	if (qplib_srq->cq)
 		nq = qplib_srq->cq->nq;
@@ -1848,7 +1911,18 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 		free_page((unsigned long)srq->uctx_srq_page);
 		hash_del(&srq->hash_entry);
 	}
-	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
+	ctx_size = rdev->rcfw.srq_ctxm_size;
+	if (ctx_size)
+		ctx_sb_data = vzalloc(ctx_size);
+
+	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq, ctx_size, ctx_sb_data);
+
+	do_snapdump = test_bit(SRQ_FLAGS_CAPTURE_SNAPDUMP, &qplib_srq->flags);
+	bnxt_re_save_resource_context(rdev, ctx_sb_data,
+				      BNXT_RE_RES_TYPE_SRQ, do_snapdump);
+
+	vfree(ctx_sb_data);
+
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
 	if (nq)
@@ -1968,7 +2042,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
 			bnxt_qplib_destroy_srq(&rdev->qplib_res,
-					       &srq->qplib_srq);
+					       &srq->qplib_srq, 0, NULL);
 			goto fail;
 		}
 	}
@@ -3127,6 +3201,9 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct bnxt_qplib_nq *nq;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
+	void *ctx_sb_data = NULL;
+	bool do_snapdump;
+	u16 ctx_size;
 
 	cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
@@ -3137,7 +3214,15 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 		free_page((unsigned long)cq->uctx_cq_page);
 		hash_del(&cq->hash_entry);
 	}
-	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	ctx_size = rdev->rcfw.cq_ctxm_size;
+	if (ctx_size)
+		ctx_sb_data = vzalloc(ctx_size);
+	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq, ctx_size, ctx_sb_data);
+	do_snapdump = test_bit(CQ_FLAGS_CAPTURE_SNAPDUMP, &cq->qplib_cq.flags);
+	bnxt_re_save_resource_context(rdev, ctx_sb_data,
+				      BNXT_RE_RES_TYPE_CQ, do_snapdump);
+
+	vfree(ctx_sb_data);
 
 	bnxt_re_put_nq(rdev, nq);
 	ib_umem_release(cq->umem);
@@ -3247,7 +3332,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
-			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq, 0, NULL);
 			goto free_mem;
 		}
 	}
@@ -4070,7 +4155,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	return &mr->ib_mr;
 
 fail_mr:
-	bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
+	bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr, 0, NULL);
 fail:
 	kfree(mr);
 	return ERR_PTR(rc);
@@ -4080,13 +4165,20 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 {
 	struct bnxt_re_mr *mr = container_of(ib_mr, struct bnxt_re_mr, ib_mr);
 	struct bnxt_re_dev *rdev = mr->rdev;
+	void *ctx_sb_data = NULL;
+	u16 ctx_size;
 	int rc;
 
-	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
+	ctx_size = rdev->rcfw.mrw_ctxm_size;
+	if (ctx_size)
+		ctx_sb_data = vzalloc(ctx_size);
+	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr, ctx_size, ctx_sb_data);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Dereg MR failed: %#x\n", rc);
 		return rc;
 	}
+	bnxt_re_save_resource_context(rdev, ctx_sb_data, BNXT_RE_RES_TYPE_MR, 0);
+	vfree(ctx_sb_data);
 
 	if (mr->pages) {
 		rc = bnxt_qplib_free_fast_reg_page_list(&rdev->qplib_res,
@@ -4175,7 +4267,7 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 fail_mr:
 	kfree(mr->pages);
 fail:
-	bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
+	bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr, 0, NULL);
 bail:
 	kfree(mr);
 	return ERR_PTR(rc);
@@ -4222,7 +4314,7 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
 	struct bnxt_re_dev *rdev = mw->rdev;
 	int rc;
 
-	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mw->qplib_mw);
+	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mw->qplib_mw, 0, NULL);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Free MW failed: %#x\n", rc);
 		return rc;
@@ -4301,7 +4393,7 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 	return &mr->ib_mr;
 
 free_mrw:
-	bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
+	bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr, 0, NULL);
 free_mr:
 	kfree(mr);
 	return ERR_PTR(rc);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 5336f74..fa221a7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -616,14 +616,21 @@ int bnxt_qplib_alloc_nq(struct bnxt_qplib_res *res, struct bnxt_qplib_nq *nq)
 
 /* SRQ */
 void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
-			   struct bnxt_qplib_srq *srq)
+			   struct bnxt_qplib_srq *srq, u16 sb_resp_size, void *sb_resp_va)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_destroy_srq_resp resp = {};
+	struct bnxt_qplib_rcfw_sbuf sbuf = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_destroy_srq req = {};
 	int rc;
 
+	if (sb_resp_size && sb_resp_va) {
+		sbuf.size = sb_resp_size;
+		sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+					     &sbuf.dma_addr, GFP_KERNEL);
+	}
+
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DESTROY_SRQ,
 				 sizeof(req));
@@ -632,7 +639,13 @@ void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
 	req.srq_cid = cpu_to_le32(srq->id);
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	req.resp_addr = cpu_to_le64(sbuf.dma_addr);
+	req.resp_size = sb_resp_size / BNXT_QPLIB_CMDQE_UNITS;
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
+	if (sbuf.sb) {
+		memcpy(sb_resp_va, sbuf.sb, sb_resp_size);
+		dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
+	}
 	kfree(srq->swq);
 	if (rc)
 		return;
@@ -1593,15 +1606,22 @@ static void __clean_cq(struct bnxt_qplib_cq *cq, u64 qp)
 }
 
 int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
-			  struct bnxt_qplib_qp *qp)
+			  struct bnxt_qplib_qp *qp,
+			  u16 sb_resp_size, void *sb_resp_va)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct bnxt_qplib_rcfw_sbuf sbuf = {};
 	struct creq_destroy_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_destroy_qp req = {};
 	u32 tbl_indx;
 	int rc;
 
+	if (sb_resp_size && sb_resp_va) {
+		sbuf.size = sb_resp_size;
+		sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+					     &sbuf.dma_addr, GFP_KERNEL);
+	}
 	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
@@ -1613,6 +1633,8 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 				 sizeof(req));
 
 	req.qp_cid = cpu_to_le32(qp->id);
+	req.resp_addr = cpu_to_le64(sbuf.dma_addr);
+	req.resp_size = sb_resp_size / BNXT_QPLIB_CMDQE_UNITS;
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
@@ -1623,6 +1645,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 		spin_unlock_bh(&rcfw->tbl_lock);
 		return rc;
 	}
+	if (sbuf.sb) {
+		memcpy(sb_resp_va, sbuf.sb, sb_resp_size);
+		dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
+	}
 
 	return 0;
 }
@@ -2355,25 +2381,40 @@ int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
 	return rc;
 }
 
-int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
+int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
+			  u16 sb_resp_size, void *sb_resp_va)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct bnxt_qplib_rcfw_sbuf sbuf = {};
 	struct creq_destroy_cq_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_destroy_cq req = {};
 	u16 total_cnq_events;
 	int rc;
 
+	if (sb_resp_size && sb_resp_va) {
+		sbuf.size = sb_resp_size;
+		sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+					     &sbuf.dma_addr, GFP_KERNEL);
+	}
+
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DESTROY_CQ,
 				 sizeof(req));
 
+	req.resp_addr = cpu_to_le64(sbuf.dma_addr);
+	req.resp_size = sb_resp_size / BNXT_QPLIB_CMDQE_UNITS;
+
 	req.cq_cid = cpu_to_le32(cq->id);
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
+	if (sbuf.sb) {
+		memcpy(sb_resp_va, sbuf.sb, sb_resp_size);
+		dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
+	}
 	total_cnq_events = le16_to_cpu(resp.total_cnq_events);
 	__wait_for_all_nqes(cq, total_cnq_events);
 	bnxt_qplib_free_hwq(res, &cq->hwq);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index d1acb01..1710b59 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -555,14 +555,16 @@ int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
 int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_srq *srq);
 void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
-			    struct bnxt_qplib_srq *srq);
+			    struct bnxt_qplib_srq *srq,
+			    u16 sb_resp_size, void *sb_resp_va);
 int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 			     struct bnxt_qplib_swqe *wqe);
 int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp);
 int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp);
 int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp);
 int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp);
-int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp);
+int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp,
+			  u16 ctx_size, void *ctx_sb_data);
 void bnxt_qplib_clean_qp(struct bnxt_qplib_qp *qp);
 void bnxt_qplib_free_qp_res(struct bnxt_qplib_res *res,
 			    struct bnxt_qplib_qp *qp);
@@ -584,7 +586,8 @@ int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
 			 int new_cqes);
 void bnxt_qplib_resize_cq_complete(struct bnxt_qplib_res *res,
 				   struct bnxt_qplib_cq *cq);
-int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq);
+int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
+			  u16 sb_resp_size, void *sb_resp_v);
 int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 		       int num, struct bnxt_qplib_qp **qp);
 bool bnxt_qplib_is_cq_empty(struct bnxt_qplib_cq *cq);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 4ccd440..d2c519d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -504,10 +504,12 @@ int bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 }
 
 /* MRW */
-int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
+int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
+			u16 sb_resp_size, void *sb_resp_va)
 {
 	struct creq_deallocate_key_resp resp = {};
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct bnxt_qplib_rcfw_sbuf sbuf = {};
 	struct cmdq_deallocate_key req = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	int rc;
@@ -517,6 +519,11 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 		return 0;
 	}
 
+	if (sb_resp_size && sb_resp_va) {
+		sbuf.size = sb_resp_size;
+		sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+					     &sbuf.dma_addr, GFP_KERNEL);
+	}
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DEALLOCATE_KEY,
 				 sizeof(req));
@@ -530,12 +537,18 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 	else
 		req.key = cpu_to_le32(mrw->lkey);
 
+	req.resp_addr = cpu_to_le64(sbuf.dma_addr);
+	req.resp_size = sb_resp_size / BNXT_QPLIB_CMDQE_UNITS;
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 
+	if (sbuf.sb) {
+		memcpy(sb_resp_va, sbuf.sb, sb_resp_size);
+		dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
+	}
 	/* Free the qplib's MRW memory */
 	if (mrw->hwq.max_elements)
 		bnxt_qplib_free_hwq(res, &mrw->hwq);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index e626b05..728b1f1 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -340,7 +340,8 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 			 bool block);
 int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 		      struct ib_umem *umem, int num_pbls, u32 buf_pg_size);
-int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr);
+int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
+			u16 ctx_size, void *ctx_sb_data);
 int bnxt_qplib_alloc_fast_reg_mr(struct bnxt_qplib_res *res,
 				 struct bnxt_qplib_mrw *mr, int max);
 int bnxt_qplib_alloc_fast_reg_page_list(struct bnxt_qplib_res *res,
-- 
2.5.5


