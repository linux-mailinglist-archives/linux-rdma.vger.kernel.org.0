Return-Path: <linux-rdma+bounces-4610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 461889622FD
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79F7B233EB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BDB15D5C4;
	Wed, 28 Aug 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TUllCMC3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230F158543
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836092; cv=none; b=U/44chPqLZ7Z5wlcRVs9kELZTz3WIQrGLUcBGzgZGL81BnTayEJj2zosZzmDzWrz77Xl4RiDbCd91JU4/LBhb9pqQiUcMSYLUXJkyEfECWN5OuxFRScaj/ktecWaCmJ/qilrDTAo08FyHs1Y4mAT+BJHBc0/871EdiofaNvcIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836092; c=relaxed/simple;
	bh=CahLkRkI0YEB76+DqjQuxihiWf0/LB2VTY6KvJ3bhjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=O+5Fz2at+3qT/r5o7qRuv/Scw5Wh+gQtj0BH3cNOCIhZfc5KnqkKyERd/MjvZHeBfop7DZOlFwH2881QsA/COg756yStsm43PSVKIepSDMEJFIlqivWhUda+JrYIwONedDR5wZtfM+YAx2VJjMHssluud99BOaSOYQ/tb65p3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TUllCMC3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021537a8e6so58417125ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724836090; x=1725440890; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WAyH0O3kecdWjMfkNU3QcPJXxk4o4Np6gebcGmF2oPM=;
        b=TUllCMC39OSiVI6MjM8XqziXaPeHNJLHrJ7PTDvt0bpAsfGZZtJR3zYUadepr1zV7i
         HyjdCyydTIRMH3NAIjw5UsqFvaHARHOF8GRp4ltYKxnqV8p4x+RKIrr3xJwE5nHe7uWC
         6fw/fnasGnrBc9Z9zzlrEOmLzCWJ/wpfH40mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724836090; x=1725440890;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAyH0O3kecdWjMfkNU3QcPJXxk4o4Np6gebcGmF2oPM=;
        b=Gh+9sjWOCGmFGEAfaEmXpbpfSBKttWFCMuQ2BiVqF6AggZq/syNfkuBskHXrC1sFGq
         8J4h2372KxgNjkYZ20UkdhIOKCu70NwEXPRqxxGeN8dIRr24IdWkPR/9yPN1C6V81T92
         4yyVLeH5yPQMf0TsjSF7lTHIgAFtwoeqDrqh6va69iYH6RQ74CIi4ZeJrtgBw2AOvlr9
         AT0qHM+aiHJ+5j9L6qPxjS6CHoWYLCJbRL+9+rbF4RJOpkewnT7P1e6Opiag9TzWq00e
         WTPgL3j0QBiZxXWlxnrif70N+Ga3Qh8u0w2bpJIQ1OxA36vmIIBlRVp9uGiir4GeDfZy
         +5EA==
X-Gm-Message-State: AOJu0YyWVFSQxN1edt5/Xg7UFsP3JF24jWWU2DnS4mCbRFMcGH0kuwlB
	0RAOEAI6fyAe+X4QQybyP00coPLaLCczeiHnq7sSst5BVoqWOcL6qibvxS/8xA==
X-Google-Smtp-Source: AGHT+IEIo4ccwB5oSbTGxY0canEa43uGlTRDYjSulPYdgDvjFmB8WOW9B9So9OcOUy7TChyCELoV1Q==
X-Received: by 2002:a17:902:d4ce:b0:202:dcd:d44 with SMTP id d9443c01a7336-2039e51b696mr183405975ad.54.1724836089865;
        Wed, 28 Aug 2024 02:08:09 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm94735955ad.196.2024.08.28.02.08.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 02:08:09 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/3] RDMA/bnxt_re: Share a page to expose per SRQ info with userspace
Date: Wed, 28 Aug 2024 01:47:12 -0700
Message-Id: <1724834832-10600-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Gen P7 adapters needs to share a toggle bits information received
in kernel driver with the user space. User space needs this
info to arm the SRQ.

User space application can get this page using the
UAPI routines. Library will mmap this page and get the
toggle bits to be used in the next ARM Doorbell.

Uses a hash list to map the SRQ structure from the SRQ ID.
SRQ structure is retrieved from the hash list while the
library calls the UAPI routine to get the toggle page
mapping. Currently the full page is mapped per SRQ. This
can be optimized to enable multiple SRQs from the same
application share the same page and different offsets
in the page

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 34 +++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 drivers/infiniband/hw/bnxt_re/main.c     |  6 +++++-
 include/uapi/rdma/bnxt_re-abi.h          |  5 +++++
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 0912d2f..2be9a62 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -141,6 +141,7 @@ struct bnxt_re_pacing {
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
 #define MAX_CQ_HASH_BITS		(16)
+#define MAX_SRQ_HASH_BITS		(16)
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -196,6 +197,7 @@ struct bnxt_re_dev {
 	struct work_struct dbq_fifo_check_work;
 	struct delayed_work dbq_pacing_work;
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
+	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1e76093..0219c8a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1685,6 +1685,10 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 
 	if (qplib_srq->cq)
 		nq = qplib_srq->cq->nq;
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+		free_page((unsigned long)srq->uctx_srq_page);
+		hash_del(&srq->hash_entry);
+	}
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
@@ -1789,9 +1793,18 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	}
 
 	if (udata) {
-		struct bnxt_re_srq_resp resp;
+		struct bnxt_re_srq_resp resp = {};
 
 		resp.srqid = srq->qplib_srq.id;
+		if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+			hash_add(rdev->srq_hash, &srq->hash_entry, srq->qplib_srq.id);
+			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
+			if (!srq->uctx_srq_page) {
+				rc = -ENOMEM;
+				goto fail;
+			}
+			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
+		}
 		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
@@ -4266,6 +4279,19 @@ static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq
 	return cq;
 }
 
+static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32 srq_id)
+{
+	struct bnxt_re_srq *srq = NULL, *tmp_srq;
+
+	hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_id) {
+		if (tmp_srq->qplib_srq.id == srq_id) {
+			srq = tmp_srq;
+			break;
+		}
+	}
+	return srq;
+}
+
 /* Helper function to mmap the virtual memory from user app */
 int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 {
@@ -4494,6 +4520,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
 	struct bnxt_re_dev *rdev;
+	struct bnxt_re_srq *srq;
 	u32 length = PAGE_SIZE;
 	struct bnxt_re_cq *cq;
 	u64 mem_offset;
@@ -4525,6 +4552,11 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		addr = (u64)cq->uctx_cq_page;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
+		srq = bnxt_re_search_for_srq(rdev, res_id);
+		if (!srq)
+			return -EINVAL;
+
+		addr = (u64)srq->uctx_srq_page;
 		break;
 
 	default:
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 4e113b9..9c74dfe 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -78,6 +78,7 @@ struct bnxt_re_srq {
 	struct ib_umem		*umem;
 	spinlock_t		lock;		/* protect srq */
 	void			*uctx_srq_page;
+	struct hlist_node       hash_entry;
 };
 
 struct bnxt_re_qp {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9714b9a..1211fe5 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -139,8 +139,10 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
 	if (bnxt_re_hwrm_qcaps(rdev))
 		dev_err(rdev_to_dev(rdev),
 			"Failed to query hwrm qcaps\n");
-	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx))
+	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx)) {
 		cctx->modes.toggle_bits |= BNXT_QPLIB_CQ_TOGGLE_BIT;
+		cctx->modes.toggle_bits |= BNXT_QPLIB_SRQ_TOGGLE_BIT;
+	}
 }
 
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
@@ -1771,6 +1773,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 		bnxt_re_vf_res_config(rdev);
 	}
 	hash_init(rdev->cq_hash);
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
+		hash_init(rdev->srq_hash);
 
 	return 0;
 free_sctx:
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index e61104f..84917a9 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -134,8 +134,13 @@ struct bnxt_re_srq_req {
 	__aligned_u64 srq_handle;
 };
 
+enum bnxt_re_srq_mask {
+	BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT = 0x1,
+};
+
 struct bnxt_re_srq_resp {
 	__u32 srqid;
+	__aligned_u64 comp_mask;
 };
 
 enum bnxt_re_shpg_offt {
-- 
2.5.5


