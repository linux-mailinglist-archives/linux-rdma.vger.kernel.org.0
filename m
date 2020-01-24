Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E87147856
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 06:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgAXFxJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 00:53:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37635 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgAXFxJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 00:53:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so455069pga.4
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 21:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fxd/OyRcaVd1WajT/YScybNJu3cqwF3LF4p/CeWbQhc=;
        b=duqfShlkmHPeI0EnIXeSKHlISV7OzlZlBT8PP6F9YwTRwsF6ACyzMG4nphsuTng467
         EGAn0WsoHAqXL9PSkMxvv9HSh/O/v4aOlN4XfL9bVumt/fyONHbwGrXnn/9nHaeDVNI8
         SZj/yChUFZFSYaCyKKZYHSi8AN7TS2AiB+Wyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fxd/OyRcaVd1WajT/YScybNJu3cqwF3LF4p/CeWbQhc=;
        b=S9hpIBoVrwFTzCuugILkGj5RQZqD2LsOtseQA18z+1hrDPk7oUmxK1OUP+WEkISh2f
         C9LwtAtQtDEYC+FV+tyD3rJO5+1B71+1Wyg2WhkYabJBUFU+PWqZK+CAbB1a243wYpoA
         BrjFysG+9g+JAZYXPSuHqRpYR7dKrBU5jyzuTDfzuTCvLVur73i/zqRsWhIleBZuErQT
         rQdQfqfkKt8PWcz6ie9zxhk3lXuYpJ2IvvVQlbXJxzME90uhUn6+oPtAPRdRpQ4h/PSM
         oJTw7ubXe9PI4WiWetwPrS+bIvrhUDlEfyHKXWE6lQUXMVUTlOWAFE+HfW6hfimgIfOG
         RWLg==
X-Gm-Message-State: APjAAAUyExHMbVP2luCPmwOrVCSD+40zlJ4S5zSQOKXeg0sOkw03NP24
        +8qrpU84SKnLAXIWV/rFfUo/aJ396qxbG79j9KPdC7tCKIrtKMXuLEHTKj9rM0J7ZfPC8Jn0Mbt
        8cYgYKRYE2JX/gtrnxKh4sQweaTZLkra1ZYRuKLoLryHpAegoTw2KwSmPb4UyHg0/HKLI2jQo8P
        LT2BoG1w==
X-Google-Smtp-Source: APXvYqyiFzQLQXKVoQnyl10M6E9v7WajocJT4WMCffwD9RuIQiQnjdyLvlI4a8JqFlYE5hGoS9OjNw==
X-Received: by 2002:a63:b642:: with SMTP id v2mr2231832pgt.126.1579845188427;
        Thu, 23 Jan 2020 21:53:08 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r20sm4781024pgu.89.2020.01.23.21.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 21:53:08 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 6/7] RDMA/bnxt_re: Refactor notification queue management code
Date:   Fri, 24 Jan 2020 00:52:44 -0500
Message-Id: <1579845165-18002-7-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cleaning up the notification queue data structures and
management code. The CQ and SRQ event handlers have been
type defined instead of in-place declaration. NQ doorbell
register descriptor has been added in base NQ structure.
The nq->vector has been renamed to nq->msix_vec.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 113 ++++++++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  54 +++++++--------
 2 files changed, 93 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 792fc6b..549ab43 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -236,16 +236,16 @@ static int bnxt_qplib_alloc_qp_hdr_buf(struct bnxt_qplib_res *res,
 static void bnxt_qplib_service_nq(unsigned long data)
 {
 	struct bnxt_qplib_nq *nq = (struct bnxt_qplib_nq *)data;
+	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(nq->res->cctx);
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
 	struct nq_base *nqe, **nq_ptr;
 	struct bnxt_qplib_cq *cq;
 	int num_cqne_processed = 0;
 	int num_srqne_processed = 0;
-	u32 sw_cons, raw_cons;
-	u16 type;
 	int budget = nq->budget;
+	u32 sw_cons, raw_cons;
 	uintptr_t q_handle;
-	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(nq->res->cctx);
+	u16 type;
 
 	/* Service the NQ until empty */
 	raw_cons = hwq->cons;
@@ -314,7 +314,7 @@ static void bnxt_qplib_service_nq(unsigned long data)
 	}
 	if (hwq->cons != raw_cons) {
 		hwq->cons = raw_cons;
-		bnxt_qplib_ring_nq_db_rearm(nq->bar_reg_iomem, hwq->cons,
+		bnxt_qplib_ring_nq_db_rearm(nq->nq_db.db, hwq->cons,
 					    hwq->max_elements, nq->ring_id,
 					    gen_p5);
 	}
@@ -333,7 +333,7 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 	prefetch(&nq_ptr[NQE_PG(sw_cons)][NQE_IDX(sw_cons)]);
 
 	/* Fan out to CPU affinitized kthreads? */
-	tasklet_schedule(&nq->worker);
+	tasklet_schedule(&nq->nq_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -341,17 +341,17 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 {
 	bool gen_p5 = bnxt_qplib_is_chip_gen_p5(nq->res->cctx);
-	tasklet_disable(&nq->worker);
+	tasklet_disable(&nq->nq_tasklet);
 	/* Mask h/w interrupt */
-	bnxt_qplib_ring_nq_db(nq->bar_reg_iomem, nq->hwq.cons,
+	bnxt_qplib_ring_nq_db(nq->nq_db.db, nq->hwq.cons,
 			      nq->hwq.max_elements, nq->ring_id, gen_p5);
 	/* Sync with last running IRQ handler */
-	synchronize_irq(nq->vector);
+	synchronize_irq(nq->msix_vec);
 	if (kill)
-		tasklet_kill(&nq->worker);
+		tasklet_kill(&nq->nq_tasklet);
 	if (nq->requested) {
-		irq_set_affinity_hint(nq->vector, NULL);
-		free_irq(nq->vector, nq);
+		irq_set_affinity_hint(nq->msix_vec, NULL);
+		free_irq(nq->msix_vec, nq);
 		nq->requested = false;
 	}
 }
@@ -364,16 +364,17 @@ void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
 	}
 
 	/* Make sure the HW is stopped! */
-	if (nq->requested)
-		bnxt_qplib_nq_stop_irq(nq, true);
+	bnxt_qplib_nq_stop_irq(nq, true);
 
-	if (nq->bar_reg_iomem)
-		iounmap(nq->bar_reg_iomem);
-	nq->bar_reg_iomem = NULL;
+	if (nq->nq_db.reg.bar_reg) {
+		iounmap(nq->nq_db.reg.bar_reg);
+		nq->nq_db.reg.bar_reg = NULL;
+		nq->nq_db.db = NULL;
+	}
 
 	nq->cqn_handler = NULL;
 	nq->srqn_handler = NULL;
-	nq->vector = 0;
+	nq->msix_vec = 0;
 }
 
 int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
@@ -385,68 +386,86 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 	if (nq->requested)
 		return -EFAULT;
 
-	nq->vector = msix_vector;
+	nq->msix_vec = msix_vector;
 	if (need_init)
-		tasklet_init(&nq->worker, bnxt_qplib_service_nq,
+		tasklet_init(&nq->nq_tasklet, bnxt_qplib_service_nq,
 			     (unsigned long)nq);
 	else
-		tasklet_enable(&nq->worker);
+		tasklet_enable(&nq->nq_tasklet);
 
 	snprintf(nq->name, sizeof(nq->name), "bnxt_qplib_nq-%d", nq_indx);
-	rc = request_irq(nq->vector, bnxt_qplib_nq_irq, 0, nq->name, nq);
+	rc = request_irq(nq->msix_vec, bnxt_qplib_nq_irq, 0, nq->name, nq);
 	if (rc)
 		return rc;
 
 	cpumask_clear(&nq->mask);
 	cpumask_set_cpu(nq_indx, &nq->mask);
-	rc = irq_set_affinity_hint(nq->vector, &nq->mask);
+	rc = irq_set_affinity_hint(nq->msix_vec, &nq->mask);
 	if (rc) {
 		dev_warn(&nq->pdev->dev,
 			 "set affinity failed; vector: %d nq_idx: %d\n",
-			 nq->vector, nq_indx);
+			 nq->msix_vec, nq_indx);
 	}
 	nq->requested = true;
-	bnxt_qplib_ring_nq_db_rearm(nq->bar_reg_iomem, nq->hwq.cons,
+	bnxt_qplib_ring_nq_db_rearm(nq->nq_db.db, nq->hwq.cons,
 				    nq->hwq.max_elements, nq->ring_id, gen_p5);
 
 	return rc;
 }
 
+static int bnxt_qplib_map_nq_db(struct bnxt_qplib_nq *nq,  u32 reg_offt)
+{
+	resource_size_t reg_base;
+	struct bnxt_qplib_nq_db *nq_db;
+	struct pci_dev *pdev;
+	int rc = 0;
+
+	pdev = nq->pdev;
+	nq_db = &nq->nq_db;
+
+	nq_db->reg.bar_id = NQ_CONS_PCI_BAR_REGION;
+	nq_db->reg.bar_base = pci_resource_start(pdev, nq_db->reg.bar_id);
+	if (!nq_db->reg.bar_base) {
+		dev_err(&pdev->dev, "QPLIB: NQ BAR region %d resc start is 0!",
+			nq_db->reg.bar_id);
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	reg_base = nq_db->reg.bar_base + reg_offt;
+	nq_db->reg.len = 8;
+	nq_db->reg.bar_reg = ioremap_nocache(reg_base, nq_db->reg.len);
+	if (!nq_db->reg.bar_reg) {
+		dev_err(&pdev->dev, "QPLIB: NQ BAR region %d mapping failed",
+			nq_db->reg.bar_id);
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	nq_db->db = nq_db->reg.bar_reg;
+fail:
+	return rc;
+}
+
 int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
 			 int nq_idx, int msix_vector, int bar_reg_offset,
-			 int (*cqn_handler)(struct bnxt_qplib_nq *nq,
-					    struct bnxt_qplib_cq *),
-			 int (*srqn_handler)(struct bnxt_qplib_nq *nq,
-					     struct bnxt_qplib_srq *,
-					     u8 event))
+			 cqn_handler_t cqn_handler,
+			 srqn_handler_t srqn_handler)
 {
-	resource_size_t nq_base;
 	int rc = -1;
 
-	if (cqn_handler)
-		nq->cqn_handler = cqn_handler;
-
-	if (srqn_handler)
-		nq->srqn_handler = srqn_handler;
+	nq->pdev = pdev;
+	nq->cqn_handler = cqn_handler;
+	nq->srqn_handler = srqn_handler;
 
 	/* Have a task to schedule CQ notifiers in post send case */
 	nq->cqn_wq  = create_singlethread_workqueue("bnxt_qplib_nq");
 	if (!nq->cqn_wq)
 		return -ENOMEM;
 
-	nq->bar_reg = NQ_CONS_PCI_BAR_REGION;
-	nq->bar_reg_off = bar_reg_offset;
-	nq_base = pci_resource_start(pdev, nq->bar_reg);
-	if (!nq_base) {
-		rc = -ENOMEM;
-		goto fail;
-	}
-	/* Unconditionally map 8 bytes to support 57500 series */
-	nq->bar_reg_iomem = ioremap_nocache(nq_base + nq->bar_reg_off, 8);
-	if (!nq->bar_reg_iomem) {
-		rc = -ENOMEM;
+	rc = bnxt_qplib_map_nq_db(nq, bar_reg_offset);
+	if (rc)
 		goto fail;
-	}
 
 	rc = bnxt_qplib_nq_start_irq(nq, nq_idx, msix_vector, true);
 	if (rc) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index d3f080c..765e5d2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -470,29 +470,32 @@ static inline void bnxt_qplib_ring_nq_db(void __iomem *db, u32 raw_cons,
 		writel(NQ_DB_CP_FLAGS | (index & DBC_DBC32_XID_MASK), db);
 }
 
+struct bnxt_qplib_nq_db {
+	struct bnxt_qplib_reg_desc	reg;
+	void __iomem			*db;
+};
+
+typedef int (*cqn_handler_t)(struct bnxt_qplib_nq *nq,
+		struct bnxt_qplib_cq *cq);
+typedef int (*srqn_handler_t)(struct bnxt_qplib_nq *nq,
+		struct bnxt_qplib_srq *srq, u8 event);
+
 struct bnxt_qplib_nq {
-	struct pci_dev		*pdev;
-	struct bnxt_qplib_res	*res;
-
-	int			vector;
-	cpumask_t		mask;
-	int			budget;
-	bool			requested;
-	struct tasklet_struct	worker;
-	struct bnxt_qplib_hwq	hwq;
-
-	u16			bar_reg;
-	u32			bar_reg_off;
-	u16			ring_id;
-	void __iomem		*bar_reg_iomem;
-
-	int			(*cqn_handler)(struct bnxt_qplib_nq *nq,
-					       struct bnxt_qplib_cq *cq);
-	int			(*srqn_handler)(struct bnxt_qplib_nq *nq,
-						struct bnxt_qplib_srq *srq,
-						u8 event);
-	struct workqueue_struct	*cqn_wq;
-	char			name[32];
+	struct pci_dev			*pdev;
+	struct bnxt_qplib_res		*res;
+	char				name[32];
+	struct bnxt_qplib_hwq		hwq;
+	struct bnxt_qplib_nq_db		nq_db;
+	u16				ring_id;
+	int				msix_vec;
+	cpumask_t			mask;
+	struct tasklet_struct		nq_tasklet;
+	bool				requested;
+	int				budget;
+
+	cqn_handler_t			cqn_handler;
+	srqn_handler_t			srqn_handler;
+	struct workqueue_struct		*cqn_wq;
 };
 
 struct bnxt_qplib_nq_work {
@@ -507,11 +510,8 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 			    int msix_vector, bool need_init);
 int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
 			 int nq_idx, int msix_vector, int bar_reg_offset,
-			 int (*cqn_handler)(struct bnxt_qplib_nq *nq,
-					    struct bnxt_qplib_cq *cq),
-			 int (*srqn_handler)(struct bnxt_qplib_nq *nq,
-					     struct bnxt_qplib_srq *srq,
-					     u8 event));
+			 cqn_handler_t cqn_handler,
+			 srqn_handler_t srq_handler);
 int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_srq *srq);
 int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
-- 
1.8.3.1

