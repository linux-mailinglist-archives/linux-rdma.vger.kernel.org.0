Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F1BA7806
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfIDBKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 21:10:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfIDBKZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 21:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w6Hi0L8v/jhu4iisbLvNVSTbIoRJEhHICCzDDKSShPc=; b=umHVoEoqNjIDdqAedttBW+R1k
        +FtsOfatn1wtt2TN+0420wv92D454+vY2QHE7fV1bXq7VX499vpRdWGMa2Yrg4FCWJ7+dEGOiFd6A
        1rLF6kQDRuWu/tteLsDlxoTENSeSvv42Ni6q35tgx+hS5twOQUdLG1XBZDixjDp+agAq/whrRKDG4
        B8qQIH3PLBJqepDDOAJev6Wcax8mKBF/rCx4upNeXG/J5c91xWW0dm3sIDK0+Opj22Y71JTTeiX9F
        yyR0jegccDN4kHfbW/ZqhxBhzqQAC6K8AZ67kZ6BO2VwSSK8bw/qYxt2D4ntZ8Bhk+zL6z3befA/R
        AfnrXIKWw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5JoW-0004Ir-71; Wed, 04 Sep 2019 01:10:24 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2] iwcm: don't hold the irq disabled lock on iw_rem_ref
Date:   Tue,  3 Sep 2019 18:10:20 -0700
Message-Id: <20190904011020.12845-1-sagi@grimberg.me>
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
changes from v1:
- don't release the lock before qp pointer is cleared.

 drivers/infiniband/core/iwcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 72141c5b7c95..ad6fd5019285 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -427,8 +427,10 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		break;
 	}
 	if (cm_id_priv->qp) {
-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
 		cm_id_priv->qp = NULL;
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
+		spin_lock_irqsave(&cm_id_priv->lock, flags);
 	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 
-- 
2.17.1

