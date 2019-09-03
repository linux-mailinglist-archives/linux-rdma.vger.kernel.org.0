Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2754A7397
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICTWZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 15:22:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfICTWY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 15:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rOgj+Udj/SVslBo/wGoCPgqIw1KOQxB8hV1eV7Z2miA=; b=GmwS5TWqrEtYXxR842AsUVQYL
        xseCOLMrFSnDM+ac9wXElaUWnFiBr+v9qJrop7yORQpXo/m+Dg2FwdLwPKtMqYnUhEH1+xh1O3yV7
        jLsNoRsgp2cj5b2yQP67hDnVeVfOVnGxtmAiXFaqkvBtHgvWvPXltGyD0ZwV+D1YZBfms8g5e6LuC
        28QbbxyA8TmxtgQ6ibKbU7XA+Op2mRDCHRbjG4lUguJxrnv+gUmBQ1C4LRUBmN+ovObxaUvKY5RHb
        OQWPSgfjTbHT0do6QRFw9dFiQsVap2AH4jVV13bGQj8BkWYealDLr3eImr3KQjlpsZ2KD/x2eJyrL
        rYCl8jqLQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5ENk-0007iu-6f; Tue, 03 Sep 2019 19:22:24 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] iwcm: don't hold the irq disabled lock on iw_rem_ref
Date:   Tue,  3 Sep 2019 12:22:23 -0700
Message-Id: <20190903192223.17342-1-sagi@grimberg.me>
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

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/core/iwcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 72141c5b7c95..94566271dbff 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -427,7 +427,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		break;
 	}
 	if (cm_id_priv->qp) {
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
 		cm_id_priv->qp = NULL;
 	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-- 
2.17.1

