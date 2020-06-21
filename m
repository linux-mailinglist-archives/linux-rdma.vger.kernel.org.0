Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8987202A18
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 12:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgFUKlx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 06:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKlw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 06:41:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C9D24861;
        Sun, 21 Jun 2020 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592736111;
        bh=fqAI1t85RYyItH33Z+gsnpoSV7O8PUO6OheoafadUUI=;
        h=From:To:Cc:Subject:Date:From;
        b=yy6Wtr8Ll9xVxr59Zd5xuluUMi+QL+Dn++uo88eHGhFAfIilXSfwk1TAz1cvSrBW0
         KieX9jawj9+1/0T4q4rT5OkTRqwVAOS1LXcF0m+WL6pq5BXnieMJCgxp7+zOcp14xP
         HczUxCReobcYLeArqfDWs3MWsDOO2Zq2PJNe/ZVY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Introduce ODP prefetch counter
Date:   Sun, 21 Jun 2020 13:41:47 +0300
Message-Id: <20200621104147.53795-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

For debugging purpose it will be easier to understand if prefetch
works okay if it has its own counter. Introduce ODP prefetch counter
and count per MR the total number of prefetched pages.

In addition remove comment which is not relevant anymore and anyway
not in the correct place.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c      | 19 ++++++++++---------
 drivers/infiniband/hw/mlx5/restrack.c |  3 +++
 include/rdma/ib_verbs.h               |  1 +
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 7d2ec9ee5097..ee88b32d143d 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -913,11 +913,6 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 		if (ret < 0)
 			goto srcu_unlock;
 
-		/*
-		 * When prefetching a page, page fault is generated
-		 * in order to bring the page to the main memory.
-		 * In the current flow, page faults are being counted.
-		 */
 		mlx5_update_odp_stats(mr, faults, ret);
 
 		npages += ret;
@@ -1755,12 +1750,17 @@ static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 	struct prefetch_mr_work *work =
 		container_of(w, struct prefetch_mr_work, work);
 	u32 bytes_mapped = 0;
+	int ret;
 	u32 i;
 
-	for (i = 0; i < work->num_sge; ++i)
-		pagefault_mr(work->frags[i].mr, work->frags[i].io_virt,
-			     work->frags[i].length, &bytes_mapped,
-			     work->pf_flags);
+	for (i = 0; i < work->num_sge; ++i) {
+		ret = pagefault_mr(work->frags[i].mr, work->frags[i].io_virt,
+				   work->frags[i].length, &bytes_mapped,
+				   work->pf_flags);
+		if (ret <= 0)
+			continue;
+		mlx5_update_odp_stats(work->frags[i].mr, prefetch, ret);
+	}
 
 	destroy_prefetch_work(work);
 }
@@ -1818,6 +1818,7 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
 				   &bytes_mapped, pf_flags);
 		if (ret < 0)
 			goto out;
+		mlx5_update_odp_stats(mr, prefetch, ret);
 	}
 	ret = 0;
 
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 224a63975822..32c6d0397946 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -99,6 +99,9 @@ int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
 		    msg, "page_invalidations",
 		    atomic64_read(&mr->odp_stats.invalidations)))
 		goto err_table;
+	if (rdma_nl_stat_hwcounter_entry(msg, "page_prefetch",
+					 atomic64_read(&mr->odp_stats.prefetch)))
+		goto err_table;
 
 	nla_nest_end(msg, table_attr);
 	return 0;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9b973b3b6f4c..1691c10f6e8a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2271,6 +2271,7 @@ struct rdma_netdev_alloc_params {
 struct ib_odp_counters {
 	atomic64_t faults;
 	atomic64_t invalidations;
+	atomic64_t prefetch;
 };
 
 struct ib_counters {
-- 
2.26.2

