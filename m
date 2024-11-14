Return-Path: <linux-rdma+bounces-5981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CA19C875B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0215B281654
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DC01F942F;
	Thu, 14 Nov 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pu+JYaJS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DA1F942D
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579005; cv=none; b=pVc81N/IqMKCm1QStOQ3hsHV3OOAJK+44bv0pvt9GvgrgSB5kg6FGgkwA1uwY3t07cpXKtlxkxyQNUupUZAIh5FSj45cs5fUEDUYiN163mUEgC2u/NgAYx5YWBz/Xs9IsxVRt45X+wsxu4ppWUMGMk6zTNb0B+wqT6r4kdVxmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579005; c=relaxed/simple;
	bh=baxiIC1nPKsiXM67V+rYXNFN5IskF/tU2Kspg9dAL4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JgW63Sjig3TF0fcsbOcUyG2WgpzqffbnyCNqmX8S2RGDOJn/fKHlC7pm312hw6mWf2kz0ZGT3+Y86ArmjISgjfdC+GFwE8eP+3g99X0WnTEXp/3DEnTA/MbUePFZefxIwmbbtKzPfujZrXoGqc72hWTksyGr0mCRUK2FZq9h/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pu+JYaJS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb47387ceso4523865ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 02:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731579003; x=1732183803; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gk841z4BLx62XFc2h9J4aU0K9bzkZNC3kcYlHZpWf9g=;
        b=Pu+JYaJSMdGW666Wse0deNwQ+5oU/qM7C1gCA/5JpHoLgrudT5CCp//wyTAODeVx+0
         9UbO+ATys24fMTylmvP886PxjYosCUptD17MDZJBMZYxHgnimryv6SoP7W6IQLNBgVvu
         UIGGAokUpkwEIl8geVG1NOl3AbS9A9cQd2Mto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579003; x=1732183803;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk841z4BLx62XFc2h9J4aU0K9bzkZNC3kcYlHZpWf9g=;
        b=K+pqfdeAPXY+Ov0cnl1jek7LraetzSLcDEeCH83jyhGKKLzq3S2u+lXI5FF8ozzx6U
         B6gXuNcEuIhqFkD33tkJm2hYIB8C3fNBF3fYmV1vdYErYAPkBUVzxkKFGoSpCDQ1pP81
         1aXuhO/Q/TQBdijNn6VaE84DPO+gEuRYDyYfO69rSSF52Kk2WbLq7NS8lbyTViwmPD3s
         Wt8a8ZLSzAGJHT1+NjtfyZq3zfNEJNPiiv4We+1REC5SmYp851jqsJyb5EV4B2H9dbbM
         2p4OBoP7wsFB3hf73/bJY7BaH/tsIIKFqwG9Sd291lBq4pSkXcqV4WvCyLu1tG32NR7s
         lXIQ==
X-Gm-Message-State: AOJu0YxIxFh0qAjr2Ai1JhIgRj/Qdo4iz5YRM/Mpq+SN4VIWNzoYdhgc
	K2hsbkcRM+LUfmsCyqlD2O41l6feli9kiaTB37R8oPKVUfD6+o2Mt2e5ai0LJg==
X-Google-Smtp-Source: AGHT+IFvFl0NnfUqxRhoxrkc28locKjNC1fqUoEDd2eLqFdjd6teAY0mfAEcJiwB2qY16kKhAttoBw==
X-Received: by 2002:a17:903:1cf:b0:20c:f39e:4c15 with SMTP id d9443c01a7336-211835268a9mr346791105ad.22.1731579002683;
        Thu, 14 Nov 2024 02:10:02 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d062absm7251135ad.206.2024.11.14.02.10.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:10:02 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v2 3/4] RDMA/bnxt_re: Refurbish CQ to NQ hash calculation
Date: Thu, 14 Nov 2024 01:49:07 -0800
Message-Id: <1731577748-1804-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

There are few use cases where CQ create and destroy
is seen before re-creating the CQ, this kind of use
case is disturbing the RR distribution and all the
active CQ getting mapped to only 2 NQ alternatively.

Fixing the CQ to NQ hash calculation by implementing
a quick load sorting mechanism under a mutex.

Using this, if the CQ was allocated and destroyed
before using it, the nq selecting algorithm still
obtains the least loaded CQ. Thus balancing the load
on NQs.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 37 ++++++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/main.c     |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  1 +
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index d1c839e..5f64fc4 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -159,6 +159,8 @@ struct bnxt_re_pacing {
 struct bnxt_re_nq_record {
 	struct bnxt_qplib_nq	nq[BNXT_RE_MAX_MSIX];
 	int			num_msix;
+	/* serialize NQ access */
+	struct mutex		load_lock;
 };
 
 #define MAX_CQ_HASH_BITS		(16)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a9c32c0..f6e9eef 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3029,6 +3029,28 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 	return rc;
 }
 
+static struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev)
+{
+	int min, indx;
+
+	mutex_lock(&rdev->nqr->load_lock);
+	for (indx = 0, min = 0; indx < (rdev->nqr->num_msix - 1); indx++) {
+		if (rdev->nqr->nq[min].load > rdev->nqr->nq[indx].load)
+			min = indx;
+	}
+	rdev->nqr->nq[min].load++;
+	mutex_unlock(&rdev->nqr->load_lock);
+
+	return &rdev->nqr->nq[min];
+}
+
+static void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq)
+{
+	mutex_lock(&rdev->nqr->load_lock);
+	nq->load--;
+	mutex_unlock(&rdev->nqr->load_lock);
+}
+
 /* Completion Queues */
 int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
@@ -3047,6 +3069,8 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 		hash_del(&cq->hash_entry);
 	}
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+
+	bnxt_re_put_nq(rdev, nq);
 	ib_umem_release(cq->umem);
 
 	atomic_dec(&rdev->stats.res.cq_count);
@@ -3065,8 +3089,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
-	struct bnxt_qplib_nq *nq = NULL;
-	unsigned int nq_alloc_cnt;
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3117,16 +3139,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 		cq->qplib_cq.dpi = &rdev->dpi_privileged;
 	}
-	/*
-	 * Allocating the NQ in a round robin fashion. nq_alloc_cnt is a
-	 * used for getting the NQ index.
-	 */
-	nq_alloc_cnt = atomic_inc_return(&rdev->nq_alloc_cnt);
-	nq = &rdev->nqr->nq[nq_alloc_cnt % (rdev->nqr->num_msix - 1)];
 	cq->qplib_cq.max_wqe = entries;
-	cq->qplib_cq.cnq_hw_ring_id = nq->ring_id;
-	cq->qplib_cq.nq	= nq;
 	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
+	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
+	cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
 
 	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
 	if (rc) {
@@ -3136,7 +3152,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ib_cq.cqe = entries;
 	cq->cq_period = cq->qplib_cq.period;
-	nq->budget++;
 
 	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
 	if (active_cqs > rdev->stats.res.cq_watermark)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9669def..fcaf2b3 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1566,6 +1566,8 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 
 	bnxt_qplib_init_res(&rdev->qplib_res);
 
+	mutex_init(&rdev->nqr->load_lock);
+
 	for (i = 1; i < rdev->nqr->num_msix ; i++) {
 		db_offt = rdev->en_dev->msix_entries[i].db_offset;
 		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nqr->nq[i - 1],
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index e2eea71..e56f42f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -551,6 +551,7 @@ int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
 	nq->pdev = pdev;
 	nq->cqn_handler = cqn_handler;
 	nq->srqn_handler = srqn_handler;
+	nq->load = 0;
 
 	/* Have a task to schedule CQ notifiers in post send case */
 	nq->cqn_wq  = create_singlethread_workqueue("bnxt_qplib_nq");
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index b5a90581..8ff56d7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -519,6 +519,7 @@ struct bnxt_qplib_nq {
 	struct tasklet_struct		nq_tasklet;
 	bool				requested;
 	int				budget;
+	u32				load;
 
 	cqn_handler_t			cqn_handler;
 	srqn_handler_t			srqn_handler;
-- 
2.5.5


