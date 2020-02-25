Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54616BFC5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 12:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgBYLks (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 06:40:48 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:51192 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgBYLks (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 06:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630848; x=1614166848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kD8D8W430GMJH/LU9CjTdWldTJVV5kVJT7rubMsK6sg=;
  b=FXRZfqIOt9RpONKmQ2O9OAp/qxMOExQkg/fSr4xdl9kyJzJEKK7bOujG
   s9sA/WfXYDJenY9KDrC/Vnhl7gfpZCYE565Zy1H60C5sk7kp0LFjdeCqe
   JwtvHAXKNjrXjuNbTWHNa4tgG8uxNOKcQNMHEi+AcpMQl6yAduMfscaxJ
   E=;
IronPort-SDR: qYpGgb6ZxKq+oBfALF32CMhA8FrqQgnZa2p/8wglhM45tnaBzkIybRs1NzBnCBuWGl+wyPGMQ1
 p5XUYPXbjQJg==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="18468179"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Feb 2020 11:40:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 415A1A20B1;
        Tue, 25 Feb 2020 11:40:33 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:40:31 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 11:40:30 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.132) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1236.3 via Frontend Transport; Tue, 25 Feb 2020 11:40:28 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next v2 3/3] RDMA/efa: Do not delay freeing of DMA pages
Date:   Tue, 25 Feb 2020 13:40:10 +0200
Message-ID: <20200225114010.21790-4-galpress@amazon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200225114010.21790-1-galpress@amazon.com>
References: <20200225114010.21790-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When destroying a DMA mmapped object, there is no need to artificially
delay the freeing of the pages to the mmap entry removal.
Since the vma keeps reference count on these pages, free_pages_exact can
be called on the destroy verb as it won't really free the pages until
the reference count is cleared (in case the user hasn't called munmap
yet).

Remove the special handling of DMA pages and call free_pages_exact on
destroy_qp/cq. The mmap entry removal is moved to the beginning of the
destroy flows, so the driver can safely free the pages.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 44 +++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ec5545870554..bf3120f140f7 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -169,6 +169,14 @@ static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
 	return addr;
 }
 
+static void efa_free_mapped(struct efa_dev *dev, void *cpu_addr,
+			    dma_addr_t dma_addr,
+			    size_t size, enum dma_data_direction dir)
+{
+	dma_unmap_single(&dev->pdev->dev, dma_addr, size, dir);
+	free_pages_exact(cpu_addr, size);
+}
+
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata)
@@ -402,6 +410,9 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	int err;
 
 	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
+
+	efa_qp_user_mmap_entries_remove(qp);
+
 	err = efa_destroy_qp_handle(dev, qp->qp_handle);
 	if (err)
 		return err;
@@ -411,11 +422,10 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 			  "qp->cpu_addr[0x%p] freed: size[%lu], dma[%pad]\n",
 			  qp->rq_cpu_addr, qp->rq_size,
 			  &qp->rq_dma_addr);
-		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
-				 DMA_TO_DEVICE);
+		efa_free_mapped(dev, qp->rq_cpu_addr, qp->rq_dma_addr,
+				qp->rq_size, DMA_TO_DEVICE);
 	}
 
-	efa_qp_user_mmap_entries_remove(qp);
 	kfree(qp);
 	return 0;
 }
@@ -720,13 +730,9 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 err_destroy_qp:
 	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
 err_free_mapped:
-	if (qp->rq_size) {
-		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
-				 DMA_TO_DEVICE);
-
-		if (!qp->rq_mmap_entry)
-			free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
-	}
+	if (qp->rq_size)
+		efa_free_mapped(dev, qp->rq_cpu_addr, qp->rq_dma_addr,
+				qp->rq_size, DMA_TO_DEVICE);
 err_free_qp:
 	kfree(qp);
 err_out:
@@ -845,10 +851,10 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
 		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
 
-	efa_destroy_cq_idx(dev, cq->cq_idx);
-	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
-			 DMA_FROM_DEVICE);
 	rdma_user_mmap_entry_remove(cq->mmap_entry);
+	efa_destroy_cq_idx(dev, cq->cq_idx);
+	efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
+			DMA_FROM_DEVICE);
 }
 
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
@@ -985,10 +991,8 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 err_free_mapped:
-	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
-			 DMA_FROM_DEVICE);
-	if (!cq->mmap_entry)
-		free_pages_exact(cq->cpu_addr, cq->size);
+	efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
+			DMA_FROM_DEVICE);
 
 err_out:
 	atomic64_inc(&dev->stats.sw_stats.create_cq_err);
@@ -1550,10 +1554,6 @@ void efa_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 {
 	struct efa_user_mmap_entry *entry = to_emmap(rdma_entry);
 
-	/* DMA mapping is already gone, now free the pages */
-	if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
-		free_pages_exact(phys_to_virt(entry->address),
-				 entry->rdma_entry.npages * PAGE_SIZE);
 	kfree(entry);
 }
 
-- 
2.25.0

