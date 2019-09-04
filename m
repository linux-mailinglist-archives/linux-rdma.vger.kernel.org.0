Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D613CA951D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfIDVZf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 17:25:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDVZf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 17:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ploN6se8S31/+AhnAq0SJgHDpmS+MceO/7wA+1eso5o=; b=qF9+a5MzGMscHNLmdVEDXSiAW
        Ei2e33kclC2QeYcBxyutjGgFy8cgxHIv9nQ+kFiwNJeXXJm7FF1YDzAJetd3feOvK4IQ9tKJ18S1O
        lph/JqBDo95delmDyva7R3T96XXJOugT7O1Y9dMFSY268sjIWMzVZcayNPlTBCI/q3+AluzlG4YOw
        WoBG3NRpmXCxvNWIrxKa1t3LKMBcija6aVGpTI9grn8ATOPnHcDbdPpR2aj4CsUmkdMHdHOX4Msl2
        hjsDkCgO3hhocrLXCU/peEgjDj+YnCoh9x1PKiXdTUF92R9bwpUaqe04WZ7XdOfIaTTMwSmgZIDnD
        CA9glOI2g==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5cmV-0003Gb-6I; Wed, 04 Sep 2019 21:25:35 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
Date:   Wed,  4 Sep 2019 14:25:31 -0700
Message-Id: <20190904212531.6488-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This may be the final put on a qp and result in freeing
resourcesand should not be done with interrupts disabled.

Produce the following warning:
--
[  317.026048] WARNING: CPU: 1 PID: 443 at kernel/smp.c:425 smp_call_function_many+0xa0/0x260
[  317.026131] Call Trace:
[  317.026159]  ? load_new_mm_cr3+0xe0/0xe0
[  317.026161]  on_each_cpu+0x28/0x50
[  317.026183]  __purge_vmap_area_lazy+0x72/0x150
[  317.026200]  free_vmap_area_noflush+0x7a/0x90
[  317.026202]  remove_vm_area+0x6f/0x80
[  317.026203]  __vunmap+0x71/0x210
[  317.026211]  siw_free_qp+0x8d/0x130 [siw]
[  317.026217]  destroy_cm_id+0xc3/0x200 [iw_cm]
[  317.026222]  rdma_destroy_id+0x224/0x2b0 [rdma_cm]
[  317.026226]  nvme_rdma_reset_ctrl_work+0x2c/0x70 [nvme_rdma]
[  317.026235]  process_one_work+0x1f4/0x3e0
[  317.026249]  worker_thread+0x221/0x3e0
[  317.026252]  ? process_one_work+0x3e0/0x3e0
[  317.026256]  kthread+0x117/0x130
[  317.026264]  ? kthread_create_worker_on_cpu+0x70/0x70
[  317.026275]  ret_from_fork+0x35/0x40
--

Fix this by exchanging the qp pointer early on and safely destroying
it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v2:
- store the qp locally so we don't need to unlock the cm_id_priv lock when
  destroying the qp

Changes from v1:
- don't release the lock before qp pointer is cleared.

 drivers/infiniband/core/iwcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 72141c5b7c95..c64707f68d22 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -373,8 +373,10 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	unsigned long flags;
+	struct ib_qp *qp;
 
 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	qp = xchg(&cm_id_priv->qp, NULL);
 	/*
 	 * Wait if we're currently in a connect or accept downcall. A
 	 * listening endpoint should never block here.
@@ -401,7 +403,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		cm_id_priv->state = IW_CM_STATE_DESTROYING;
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		/* Abrupt close of the connection */
-		(void)iwcm_modify_qp_err(cm_id_priv->qp);
+		(void)iwcm_modify_qp_err(qp);
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
 		break;
 	case IW_CM_STATE_IDLE:
@@ -426,11 +428,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		BUG();
 		break;
 	}
-	if (cm_id_priv->qp) {
-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
-		cm_id_priv->qp = NULL;
-	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	if (qp)
+		cm_id_priv->id.device->ops.iw_rem_ref(qp);
 
 	if (cm_id->mapped) {
 		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
-- 
2.17.1

