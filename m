Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0B0849A1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfHGKeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfHGKeV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 06:34:21 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03992086D;
        Wed,  7 Aug 2019 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565174060;
        bh=4b7JdE8+yVkeRJKXiScMPtKZvBChiNNl2iwvcDkI4PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcKAozP5MLUTbhKLG/sr4uuBFM0U2Jorg6Bmb+LyVcApE3o5gX2O6iq4ug20OxrCn
         OgFOjpZinGq3nQMVrQH67+o4OjlZ7ETn2X+hhauyH9lMYzTK5SHc8hxvUOSPNaznOO
         32YojeHeRHZN5y4o7+HIYGcPDrryZk6tUdf+LOAY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next 4/6] IB/mlx5: Introduce ODP diagnostic counters
Date:   Wed,  7 Aug 2019 13:34:01 +0300
Message-Id: <20190807103403.8102-5-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807103403.8102-1-leon@kernel.org>
References: <20190807103403.8102-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

Introduce ODP diagnostic counters and count the following
per MR within IB/mlx5 driver:
 1) Page faults:
	Total number of faulted pages.
 2) Page invalidations:
	Total number of pages invalidated by the OS during all
	invalidation events. The translations can be no longer
	valid due to either non-present pages or mapping changes.
 3) Prefetched pages:
	When prefetching a page, page fault is generated
	in order to bring the page to the main memory.
	The prefetched pages counter will be updated
	during a page fault flow only if it was derived
	from prefetching operation.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 17 +++++++++++++++++
 include/rdma/ib_umem_odp.h       | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 673d18b0b743..c651c684a656 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -287,6 +287,10 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
 
+	/* Count page invalidations */
+	ib_update_odp_stats(mr->ibmr, invalidations,
+			    (end - start)/BIT(umem_odp->page_shift));
+
 	if (unlikely(!umem_odp->npages && mr->parent &&
 		     !umem_odp->dying)) {
 		WRITE_ONCE(umem_odp->dying, 1);
@@ -830,6 +834,19 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 		if (ret < 0)
 			goto srcu_unlock;
 
+		/*
+		 * When prefetching a page, page fault is generated
+		 * in order to bring the page to the main memory.
+		 * In the current flow, page faults are being counted.
+		 * Prefetched pages counter will be updated as well
+		 * only if the current page fault flow was derived
+		 * from prefetching flow.
+		 */
+		ib_update_odp_stats(mr->ibmr, faults, ret);
+
+		if (prefetch)
+			ib_update_odp_stats(mr->ibmr, prefetched, ret);
+
 		npages += ret;
 		ret = 0;
 		break;
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 81dc53a2848c..ebc6074c8dc7 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -42,6 +42,12 @@ struct umem_odp_node {
 	struct rb_node rb;
 };
 
+struct ib_odp_counters {
+	u64 faults;
+	u64 invalidations;
+	u64 prefetched;
+};
+
 struct ib_umem_odp {
 	struct ib_umem umem;
 	struct ib_ucontext_per_mm *per_mm;
@@ -72,6 +78,11 @@ struct ib_umem_odp {
 	 */
 	u8			type;
 
+	/*
+	 * ODP diagnostic counters.
+	 */
+	struct ib_odp_counters odp_stats;
+
 	int notifiers_seq;
 	int notifiers_count;
 	int npages;
@@ -118,6 +129,9 @@ static inline void ib_umem_odp_set_type(struct ib_umem_odp *umem_odp,
 		umem_odp->type = IB_ODP_TYPE_EXPLICIT;
 }
 
+#define ib_update_odp_stats(mr, counter_name, value)			\
+	(to_ib_umem_odp(mr.umem)->odp_stats.counter_name += value)
+
 /*
  * The lower 2 bits of the DMA address signal the R/W permissions for
  * the entry. To upgrade the permissions, provide the appropriate
-- 
2.20.1

