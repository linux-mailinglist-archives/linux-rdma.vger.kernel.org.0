Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684AB3106EF
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 09:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBEIl1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 03:41:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12434 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBEIlD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 03:41:03 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DX83N6xLkzjJFh;
        Fri,  5 Feb 2021 16:39:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 16:40:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>, <aditr@vmware.com>,
        <pv-drivers@vmware.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next] RDMA/pvrdma: Replace spin_lock_irqsave with spin_lock in hard IRQ
Date:   Fri, 5 Feb 2021 16:37:58 +0800
Message-ID: <1612514278-49220-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to do irqsave and irqrestore in context of hard IRQ.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 00a3309..4b6019e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -474,7 +474,6 @@ static irqreturn_t pvrdma_intrx_handler(int irq, void *dev_id)
 	int ring_slots = (dev->dsr->cq_ring_pages.num_pages - 1) * PAGE_SIZE /
 			 sizeof(struct pvrdma_cqne);
 	unsigned int head;
-	unsigned long flags;
 
 	dev_dbg(&dev->pdev->dev, "interrupt x (completion) handler\n");
 
@@ -483,11 +482,11 @@ static irqreturn_t pvrdma_intrx_handler(int irq, void *dev_id)
 		struct pvrdma_cq *cq;
 
 		cqne = get_cqne(dev, head);
-		spin_lock_irqsave(&dev->cq_tbl_lock, flags);
+		spin_lock(&dev->cq_tbl_lock);
 		cq = dev->cq_tbl[cqne->info % dev->dsr->caps.max_cq];
 		if (cq)
 			refcount_inc(&cq->refcnt);
-		spin_unlock_irqrestore(&dev->cq_tbl_lock, flags);
+		spin_unlock(&dev->cq_tbl_lock);
 
 		if (cq && cq->ibcq.comp_handler)
 			cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
-- 
2.8.1

