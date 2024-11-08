Return-Path: <linux-rdma+bounces-5859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC139C18B7
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E340282E02
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C61E0E0B;
	Fri,  8 Nov 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="drJFaJH3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C651494D4
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056619; cv=none; b=Ako/NVeWaRSZYc+hVtxOJ30COM195j0txVgbWSu/wgV8lCGmwxvy1r/rOQTBIkTs33qOA2O/6jEBoMUEVrCRQLL7rhst6HdGViTPnyqKYE84VyNlj+yW58IsDhgTdTJsQenFa5YpsrRq9ajCz4q1K+uLK9QzVDExkrzj1Yd0D20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056619; c=relaxed/simple;
	bh=9tWdv39gMa5Me/P2Ldh8AedyRLvLIsBwTfq+JA9cG9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gw8WERxTVLdSfRBxfJOBP9FzA4DKdwRzWw3wzZPnbBMKnMaYh1nPzQPWeX8J8Ocz7+rkXumJ9sc3Oo7iLUZGL0Gz78TiCUc4PC/rQDlFF3E3Fxk2bQsOl9N6A4MIc33WCTtspEsTe8/++z9/QFMPjgN1zwWdKJsWcVATeq4CGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=drJFaJH3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso1731353b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731056616; x=1731661416; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aVctW32NzObJH6RcIg60+Vw8PwZMXYnAQmajk6TSVgA=;
        b=drJFaJH3EJqNvRCdJ69w5pselSoksFeGhRbfLoTuTgt3+BtzA974TW2EZ8T0O/EBAa
         nXvpIpBBkLZ5PbczRPlDXGo9s0in2h/R4/IXg1cBvDOlWdxD8CmbuhVUUUmecOCd1l+H
         4oLNeqPd69K3RJ8KQXlHgD1R+sGj9mTmWmK+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056616; x=1731661416;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVctW32NzObJH6RcIg60+Vw8PwZMXYnAQmajk6TSVgA=;
        b=LlDfHR/NTWtp2RLuIg2sxTAOhgb3qNax/7whIO1nQDHDBoRP4ML/wfh9yX3Z4/Ay92
         RdqPhLg7WOw8gsZyWqBiH1qpeF248l2J97PLuBZCFttQnJe86jNiTo0ZF7G0fFjwXD7j
         njpsmf9BdVz334DwixP0lQcxQWudThKevGwUMGIVrTRgDd6ANJNc7Yf866YL+oCWQ4Bu
         mgHseLRO1OOLprx0wosofHiRu/jXRBsQUMbNYvG6AYKlZGXS/535J7Fg1KUsRaQFWWCG
         2KltVY9Z6dacZU5T6HoZv0wDIApsxeCS32hIzlxD5DtDu4a2bmPSFzzdRIxHc88gXzsA
         NP/w==
X-Gm-Message-State: AOJu0Ywlhtvu3sr2i7JWDuHyq9IQG7H0s+SgLQQ1lccKWesOYGZCmlR2
	YZdQ/7eXPgklWSWanTJMIh6UEb7cVM6qt5iiDssmEc70kByr9HvYdwPhGlsHew==
X-Google-Smtp-Source: AGHT+IHLyqpi+sntWNlfhTXlHjyNPMznHPA+MKz2AubCsaPvZTN1AT5o4yQyZjIUECanEvEeE3DLAw==
X-Received: by 2002:a05:6a20:9183:b0:1db:dfc0:d342 with SMTP id adf61e73a8af0-1dc228ec8damr2689441637.7.1731056616551;
        Fri, 08 Nov 2024 01:03:36 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffcdsm3096441b3a.31.2024.11.08.01.03.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:03:35 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma-next 3/5] RDMA/bnxt_re: Refurbish CQ to NQ hash calculation
Date: Fri,  8 Nov 2024 00:42:37 -0800
Message-Id: <1731055359-12603-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 +++++++++++++++++++++++++-------
 drivers/infiniband/hw/bnxt_re/main.c     |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  1 +
 5 files changed, 32 insertions(+), 7 deletions(-)

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
index a9c32c0..9b0a435 100644
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
@@ -3121,12 +3143,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 * Allocating the NQ in a round robin fashion. nq_alloc_cnt is a
 	 * used for getting the NQ index.
 	 */
-	nq_alloc_cnt = atomic_inc_return(&rdev->nq_alloc_cnt);
-	nq = &rdev->nqr->nq[nq_alloc_cnt % (rdev->nqr->num_msix - 1)];
 	cq->qplib_cq.max_wqe = entries;
-	cq->qplib_cq.cnq_hw_ring_id = nq->ring_id;
-	cq->qplib_cq.nq	= nq;
 	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
+	cq->qplib_cq.nq	= bnxt_re_get_nq(rdev);
+	cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
 
 	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
 	if (rc) {
@@ -3136,7 +3156,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ib_cq.cqe = entries;
 	cq->cq_period = cq->qplib_cq.period;
-	nq->budget++;
 
 	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
 	if (active_cqs > rdev->stats.res.cq_watermark)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9acc0e2..e556110 100644
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


