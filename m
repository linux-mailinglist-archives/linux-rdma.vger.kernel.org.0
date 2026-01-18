Return-Path: <linux-rdma+bounces-15662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633DD39214
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3FD930123EC
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907681D6195;
	Sun, 18 Jan 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9n9sBBD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5171D5CE0
	for <linux-rdma@vger.kernel.org>; Sun, 18 Jan 2026 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768699516; cv=none; b=mfSKbahcfKveCgpU/NNq8RECizFdkQGqhfP8+NXeCFP0GJRbXfnJos1MhMVXlDQotsiSEVCy/La1Y+CBN4iuRtbsUJTRts0MLgDoUEhiAlGPrftNii17y2GejoTFyr9hSe4+8Ta0wbh4q8Vh20ATOy8T3Ya9uu4YrzcyS55T8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768699516; c=relaxed/simple;
	bh=15buyrVgDcl0A7Ik8xRU/KLemRhvKdThlEwRlyJDibs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e2XxtlzKb8QJXrY9kfqOE0h5EpE/mM/4RbplEACeDY9TwCICbI8Fr09Gv17SGGHwAihai2VJVBQfIfG8o7phkwOw5xQWK9SolxlUiGW4iL7IQTinKmMtfWzbpbXfcsBywhiR68IJuUN+GPe7bPA03tDONlor91aycWtktn1VihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9n9sBBD; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a47331c39so78192056d6.2
        for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 17:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768699514; x=1769304314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRFiToYN7qVW1y1fSviY5H9G4mcd/Lsj4ZQabensNwI=;
        b=v9n9sBBDrz1/JJXJWt0OPbJvf1HFnb8Qns41BZ7dgu0f6guaFedzH3mOEkvljxMxs7
         PC4THRJ6Tyq+8sXtr3Tl9DiQ1nR+TW2fOl1lEuEzaW5WgG2vwCcZBrnfGAUDLsYstUA1
         VXmLLcg4HUc2SeMHg6HzUB0NjjTOvPouiOHTzaHpjzLgIV6sqK9ovVOvrhBsCqW/gZ6q
         VysedZwppsr6bFa1aYJnCeHBYA140fiDseZNUnn4wksLXwHqPr9dzdk6OmG72L2ZUF4K
         i/2J/HV0FRLnmO90boiPVDeFEXfokN348bzx4Z/gxYITYSgJDeNs/p3H2b9efGV0dyEu
         EaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768699514; x=1769304314;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRFiToYN7qVW1y1fSviY5H9G4mcd/Lsj4ZQabensNwI=;
        b=P1a9ynSun48Ynz9a7QwmAumZy9/RNQBv21/eyGIVntpR4REPSDDlDjhoiLukj9naLA
         gpqK0ltsKJ29kJzAJaQRgWSqwckR1QQxiSYR2lK+VpgIwcCjKcDibJ1W3IT+p9eGvozg
         M0bowB2kPdpW4WZdLWVWofYgep/BBFG16O0m8ZimSMMAsLityY440jOXTJAwEc+R1rYi
         kqaoU3krNf+fNM+j+VDgD754EnoZaKxxvsGV9aZGbV4kypIJ+WutXpZKuFX5YfeARiO5
         FhdRqlmlZ7QWLvbLucOQan3qhVE1m/jl/+LT02HA+7tEYABMkfJc9aw6cc3sTx2yK3d2
         vMBw==
X-Forwarded-Encrypted: i=1; AJvYcCU7jSFCa3wZjln3SSQ0QRVzLwLo5dNqa0eUtLL5DUFlNYR9lu6Enuv6Arwk+1CSUNhQSGFq7BjzXsvN@vger.kernel.org
X-Gm-Message-State: AOJu0YwUodKU8RK62JdTWzws9LJPQh9pMsE5sVzUjyiRZBhPvlH/6Ikg
	iwwfphNcGWuD2GaUBA1nR9W4Tx4cOU4ObkRsZ9Ys0JJHL2SlamWMq8vOccKf0sl5liZKnmE0d2c
	NUiUhzu+JjQ==
X-Received: from qvbks21.prod.google.com ([2002:a05:6214:3115:b0:88a:3733:7e93])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ad4:5f09:0:b0:87f:b58f:154f
 with SMTP id 6a1803df08f44-8942e4b03c1mr103044376d6.50.1768699513736; Sat, 17
 Jan 2026 17:25:13 -0800 (PST)
Date: Sun, 18 Jan 2026 01:25:00 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118012500.681672-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Convert QP table to xarray
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

Some devices can support a very large number of QPs, so convert
the qp_table array into xarray for more efficient memory usage.
This should reduce common-case memory usage by megabytes.

Also, remove the space that was being reserved for the srq table
which doesn't exist.

Tested with KASAN+lockdep and a full cycle of QP/CQ create/destroy
for the entire ID space.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/cm.c    |  8 ++++----
 drivers/infiniband/hw/irdma/hw.c    | 17 +++++++----------
 drivers/infiniband/hw/irdma/main.h  |  3 +--
 drivers/infiniband/hw/irdma/utils.c | 15 ++++++++++-----
 drivers/infiniband/hw/irdma/verbs.c |  9 +++++++--
 5 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index f4f4f92ba..3104f3870 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3448,9 +3448,9 @@ void irdma_cm_disconn(struct irdma_qp *iwqp)
 	if (!work)
 		return;
 
-	spin_lock_irqsave(&iwdev->rf->qptable_lock, flags);
-	if (!iwdev->rf->qp_table[iwqp->ibqp.qp_num]) {
-		spin_unlock_irqrestore(&iwdev->rf->qptable_lock, flags);
+	xa_lock_irqsave(&iwdev->rf->qp_xa, flags);
+	if (!xa_load(&iwdev->rf->qp_xa, iwqp->ibqp.qp_num)) {
+		xa_unlock_irqrestore(&iwdev->rf->qp_xa, flags);
 		ibdev_dbg(&iwdev->ibdev,
 			  "CM: qp_id %d is already freed\n",
 			  iwqp->ibqp.qp_num);
@@ -3458,7 +3458,7 @@ void irdma_cm_disconn(struct irdma_qp *iwqp)
 		return;
 	}
 	irdma_qp_add_ref(&iwqp->ibqp);
-	spin_unlock_irqrestore(&iwdev->rf->qptable_lock, flags);
+	xa_unlock_irqrestore(&iwdev->rf->qp_xa, flags);
 
 	work->iwqp = iwqp;
 	INIT_WORK(&work->work, irdma_disconnect_worker);
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 31c67b753..d01fcba7f 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -313,11 +313,10 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			  info->iwarp_state, info->ae_src);
 
 		if (info->qp) {
-			spin_lock_irqsave(&rf->qptable_lock, flags);
-			iwqp = rf->qp_table[info->qp_cq_id];
+			xa_lock_irqsave(&rf->qp_xa, flags);
+			iwqp = xa_load(&rf->qp_xa, info->qp_cq_id);
 			if (!iwqp) {
-				spin_unlock_irqrestore(&rf->qptable_lock,
-						       flags);
+				xa_unlock_irqrestore(&rf->qp_xa, flags);
 				if (info->ae_id == IRDMA_AE_QP_SUSPEND_COMPLETE) {
 					atomic_dec(&iwdev->vsi.qp_suspend_reqs);
 					wake_up(&iwdev->suspend_wq);
@@ -328,7 +327,7 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 				continue;
 			}
 			irdma_qp_add_ref(&iwqp->ibqp);
-			spin_unlock_irqrestore(&rf->qptable_lock, flags);
+			xa_unlock_irqrestore(&rf->qp_xa, flags);
 			qp = &iwqp->sc_qp;
 			spin_lock_irqsave(&iwqp->lock, flags);
 			iwqp->hw_tcp_state = info->tcp_state;
@@ -1701,6 +1700,7 @@ static void irdma_del_init_mem(struct irdma_pci_f *rf)
 	dev->hmc_info->sd_table.sd_entry = NULL;
 	vfree(rf->mem_rsrc);
 	rf->mem_rsrc = NULL;
+	xa_destroy(&rf->qp_xa);
 	dma_free_coherent(rf->hw.device, rf->obj_mem.size, rf->obj_mem.va,
 			  rf->obj_mem.pa);
 	rf->obj_mem.va = NULL;
@@ -2091,13 +2091,12 @@ static void irdma_set_hw_rsrc(struct irdma_pci_f *rf)
 	rf->allocated_ahs = &rf->allocated_pds[BITS_TO_LONGS(rf->max_pd)];
 	rf->allocated_mcgs = &rf->allocated_ahs[BITS_TO_LONGS(rf->max_ah)];
 	rf->allocated_arps = &rf->allocated_mcgs[BITS_TO_LONGS(rf->max_mcg)];
-	rf->qp_table = (struct irdma_qp **)
+	rf->cq_table = (struct irdma_cq **)
 		(&rf->allocated_arps[BITS_TO_LONGS(rf->arp_table_size)]);
-	rf->cq_table = (struct irdma_cq **)(&rf->qp_table[rf->max_qp]);
 
+	xa_init_flags(&rf->qp_xa, XA_FLAGS_LOCK_IRQ);
 	spin_lock_init(&rf->rsrc_lock);
 	spin_lock_init(&rf->arp_lock);
-	spin_lock_init(&rf->qptable_lock);
 	spin_lock_init(&rf->cqtable_lock);
 	spin_lock_init(&rf->qh_list_lock);
 }
@@ -2119,9 +2118,7 @@ static u32 irdma_calc_mem_rsrc_size(struct irdma_pci_f *rf)
 	rsrc_size += sizeof(unsigned long) * BITS_TO_LONGS(rf->arp_table_size);
 	rsrc_size += sizeof(unsigned long) * BITS_TO_LONGS(rf->max_ah);
 	rsrc_size += sizeof(unsigned long) * BITS_TO_LONGS(rf->max_mcg);
-	rsrc_size += sizeof(struct irdma_qp **) * rf->max_qp;
 	rsrc_size += sizeof(struct irdma_cq **) * rf->max_cq;
-	rsrc_size += sizeof(struct irdma_srq **) * rf->max_srq;
 
 	return rsrc_size;
 }
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index d320d1a22..6fd3dbef1 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -321,9 +321,8 @@ struct irdma_pci_f {
 	struct irdma_arp_entry *arp_table;
 	spinlock_t arp_lock; /*protect ARP table access*/
 	spinlock_t rsrc_lock; /* protect HW resource array access */
-	spinlock_t qptable_lock; /*protect QP table access*/
 	spinlock_t cqtable_lock; /*protect CQ table access*/
-	struct irdma_qp **qp_table;
+	struct xarray qp_xa;
 	struct irdma_cq **cq_table;
 	spinlock_t qh_list_lock; /* protect mc_qht_list */
 	struct mc_table_list mc_qht_list;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 08b23e24e..34e332ba1 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -798,15 +798,15 @@ void irdma_qp_rem_ref(struct ib_qp *ibqp)
 	u32 qp_num;
 	unsigned long flags;
 
-	spin_lock_irqsave(&iwdev->rf->qptable_lock, flags);
+	xa_lock_irqsave(&iwdev->rf->qp_xa, flags);
 	if (!refcount_dec_and_test(&iwqp->refcnt)) {
-		spin_unlock_irqrestore(&iwdev->rf->qptable_lock, flags);
+		xa_unlock_irqrestore(&iwdev->rf->qp_xa, flags);
 		return;
 	}
 
 	qp_num = iwqp->ibqp.qp_num;
-	iwdev->rf->qp_table[qp_num] = NULL;
-	spin_unlock_irqrestore(&iwdev->rf->qptable_lock, flags);
+	__xa_erase(&iwdev->rf->qp_xa, qp_num);
+	xa_unlock_irqrestore(&iwdev->rf->qp_xa, flags);
 	complete(&iwqp->free_qp);
 }
 
@@ -849,11 +849,16 @@ struct ib_device *to_ibdev(struct irdma_sc_dev *dev)
 struct ib_qp *irdma_get_qp(struct ib_device *device, int qpn)
 {
 	struct irdma_device *iwdev = to_iwdev(device);
+	struct irdma_qp *iqp;
 
 	if (qpn < IW_FIRST_QPN || qpn >= iwdev->rf->max_qp)
 		return NULL;
 
-	return &iwdev->rf->qp_table[qpn]->ibqp;
+	iqp = xa_load(&iwdev->rf->qp_xa, qpn);
+	if (!iqp)
+		return NULL;
+
+	return &iqp->ibqp;
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cf8d19150..9d80388f4 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1104,7 +1104,13 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	spin_lock_init(&iwqp->lock);
 	spin_lock_init(&iwqp->sc_qp.pfpdu.lock);
 	iwqp->sig_all = init_attr->sq_sig_type == IB_SIGNAL_ALL_WR;
-	rf->qp_table[qp_num] = iwqp;
+	init_completion(&iwqp->free_qp);
+
+	err_code = xa_err(xa_store_irq(&rf->qp_xa, qp_num, iwqp, GFP_KERNEL));
+	if (err_code) {
+		irdma_destroy_qp(&iwqp->ibqp, udata);
+		return err_code;
+	}
 
 	if (udata) {
 		/* GEN_1 legacy support with libi40iw does not have expanded uresp struct */
@@ -1129,7 +1135,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		}
 	}
 
-	init_completion(&iwqp->free_qp);
 	return 0;
 
 error:
-- 
2.52.0.457.g6b5491de43-goog


