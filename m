Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6613A358
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgANI5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:57:42 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:8202 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgANI5l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578992262; x=1610528262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oo2KLvUhcrA8PCcwq8ILdSC3D0K9SwCo3YTj0mf8Jy4=;
  b=tYNX/Efrz8WQPzAX9xECWlemLW/uP5jDupiCzRRlbLbk+dMPNKK5Ybos
   sNTnRJB/m0EMz7955+U7golQbfARjl7DeZv5Jknj1SCvb3j/XoeNqf6HQ
   ymtRhUSVQ4m1arhhgsYCo8A7es6BPiiHDC8dFEzJtVXs108jVQ2Vh4GCJ
   o=;
IronPort-SDR: ZXMh9cXmTJ4Ho77vMhc3iohHxu9PTsGWYEFnCmITWvcBleU9cvL6FKKW5TiocxhjBqK8Yo5kob
 X53zwYkfPKTA==
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="19943018"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 14 Jan 2020 08:57:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS id 920F9A2CAB;
        Tue, 14 Jan 2020 08:57:33 +0000 (UTC)
Received: from EX13D02EUB001.ant.amazon.com (10.43.166.150) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 14 Jan 2020 08:57:33 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:32 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 14 Jan 2020 08:57:29 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 6/6] RDMA/efa: Do not delay freeing of DMA pages
Date:   Tue, 14 Jan 2020 10:57:06 +0200
Message-ID: <20200114085706.82229-7-galpress@amazon.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114085706.82229-1-galpress@amazon.com>
References: <20200114085706.82229-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When destroying a DMA mmapped object, there is no need to delay the
pages freeing to dealloc_ucontext as the kernel itself will keep
reference count for these pages.

Remove the special handling of DMA pages and call free_pages_exact on
destroy_qp/cq.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 9a6cff718c49..fd2fc60d569f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -413,6 +413,7 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 			  &qp->rq_dma_addr);
 		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
 				 DMA_TO_DEVICE);
+		free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
 	}
 
 	efa_qp_user_mmap_entries_remove(qp);
@@ -723,9 +724,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 	if (qp->rq_size) {
 		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
 				 DMA_TO_DEVICE);
-
-		if (!qp->rq_mmap_entry)
-			free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
+		free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
 	}
 err_free_qp:
 	kfree(qp);
@@ -848,6 +847,7 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
 			 DMA_FROM_DEVICE);
+	free_pages_exact(cq->cpu_addr, cq->size);
 	rdma_user_mmap_entry_remove(cq->mmap_entry);
 }
 
@@ -987,8 +987,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_free_mapped:
 	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
 			 DMA_FROM_DEVICE);
-	if (!cq->mmap_entry)
-		free_pages_exact(cq->cpu_addr, cq->size);
+	free_pages_exact(cq->cpu_addr, cq->size);
 
 err_out:
 	atomic64_inc(&dev->stats.sw_stats.create_cq_err);
@@ -1549,10 +1548,6 @@ void efa_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 {
 	struct efa_user_mmap_entry *entry = to_emmap(rdma_entry);
 
-	/* DMA mapping is already gone, now free the pages */
-	if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
-		free_pages_exact(phys_to_virt(entry->address),
-				 entry->rdma_entry.npages * PAGE_SIZE);
 	kfree(entry);
 }
 
-- 
2.24.1

