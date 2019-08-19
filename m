Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0DD921F8
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfHSLRV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSLRV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:21 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377A82085A;
        Mon, 19 Aug 2019 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213439;
        bh=8Jm5F5K3QaGtNexv21p6U5lSw/QYsTdUnZZBoGLQ0Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/F6cwuf1UGtCpG/x1Bsb7n/pyeYa3P90W8sjlJ4MCGdcjXfPkR/jgdgE4tmToK+F
         jubSo7dQpcg5DzcRWN/F8F/aSS2IWEYpsJmo4WFxf60wgsTW1aU2AXtXug33S5+ue6
         mU5ruvW/2rswg7k7QdHem9NjlLKTEaaNP1/9HEFY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 01/12] RDMA/odp: Use the common interval tree library instead of generic
Date:   Mon, 19 Aug 2019 14:16:59 +0300
Message-Id: <20190819111710.18440-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

ODP is working with userspace VA's in the interval tree which always fit
into an unsigned long, so we can use the common code.

This comes at a cost of a 16 byte increase in ib_umem_odp struct size due
to storing the interval tree start/last in addition to the umem
addr/length. However these values were computed and are performance
critical for the interval lookup, so this seems like a worthwhile trade
off.

Removes 2k of .text from the kernel.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/Kconfig         |  1 +
 drivers/infiniband/core/umem_odp.c | 72 ++++++++----------------------
 include/rdma/ib_umem_odp.h         | 20 +++++----
 3 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 85e103b147cc..b44b1c322ec8 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -55,6 +55,7 @@ config INFINIBAND_ON_DEMAND_PAGING
 	bool "InfiniBand on-demand paging support"
 	depends on INFINIBAND_USER_MEM
 	select MMU_NOTIFIER
+	select INTERVAL_TREE
 	default y
 	---help---
 	  On demand paging support for the InfiniBand subsystem.
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 2a75c6f8d827..8358eb8e3a26 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -39,45 +39,13 @@
 #include <linux/export.h>
 #include <linux/vmalloc.h>
 #include <linux/hugetlb.h>
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree.h>
 #include <linux/pagemap.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 
-/*
- * The ib_umem list keeps track of memory regions for which the HW
- * device request to receive notification when the related memory
- * mapping is changed.
- *
- * ib_umem_lock protects the list.
- */
-
-static u64 node_start(struct umem_odp_node *n)
-{
-	struct ib_umem_odp *umem_odp =
-			container_of(n, struct ib_umem_odp, interval_tree);
-
-	return ib_umem_start(umem_odp);
-}
-
-/* Note that the representation of the intervals in the interval tree
- * considers the ending point as contained in the interval, while the
- * function ib_umem_end returns the first address which is not contained
- * in the umem.
- */
-static u64 node_last(struct umem_odp_node *n)
-{
-	struct ib_umem_odp *umem_odp =
-			container_of(n, struct ib_umem_odp, interval_tree);
-
-	return ib_umem_end(umem_odp) - 1;
-}
-
-INTERVAL_TREE_DEFINE(struct umem_odp_node, rb, u64, __subtree_last,
-		     node_start, node_last, static, rbt_ib_umem)
-
 static void ib_umem_notifier_start_account(struct ib_umem_odp *umem_odp)
 {
 	mutex_lock(&umem_odp->umem_mutex);
@@ -209,9 +177,18 @@ static void add_umem_to_per_mm(struct ib_umem_odp *umem_odp)
 	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
 
 	down_write(&per_mm->umem_rwsem);
-	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp)))
-		rbt_ib_umem_insert(&umem_odp->interval_tree,
-				   &per_mm->umem_tree);
+	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp))) {
+		/*
+		 * Note that the representation of the intervals in the
+		 * interval tree considers the ending point as contained in
+		 * the interval, while the function ib_umem_end returns the
+		 * first address which is not contained in the umem.
+		 */
+		umem_odp->interval_tree.start = ib_umem_start(umem_odp);
+		umem_odp->interval_tree.last = ib_umem_end(umem_odp) - 1;
+		interval_tree_insert(&umem_odp->interval_tree,
+				     &per_mm->umem_tree);
+	}
 	up_write(&per_mm->umem_rwsem);
 }
 
@@ -221,8 +198,8 @@ static void remove_umem_from_per_mm(struct ib_umem_odp *umem_odp)
 
 	down_write(&per_mm->umem_rwsem);
 	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp)))
-		rbt_ib_umem_remove(&umem_odp->interval_tree,
-				   &per_mm->umem_tree);
+		interval_tree_remove(&umem_odp->interval_tree,
+				     &per_mm->umem_tree);
 	complete_all(&umem_odp->notifier_completion);
 
 	up_write(&per_mm->umem_rwsem);
@@ -765,18 +742,18 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 				  void *cookie)
 {
 	int ret_val = 0;
-	struct umem_odp_node *node, *next;
+	struct interval_tree_node *node, *next;
 	struct ib_umem_odp *umem;
 
 	if (unlikely(start == last))
 		return ret_val;
 
-	for (node = rbt_ib_umem_iter_first(root, start, last - 1);
+	for (node = interval_tree_iter_first(root, start, last - 1);
 			node; node = next) {
 		/* TODO move the blockable decision up to the callback */
 		if (!blockable)
 			return -EAGAIN;
-		next = rbt_ib_umem_iter_next(node, start, last - 1);
+		next = interval_tree_iter_next(node, start, last - 1);
 		umem = container_of(node, struct ib_umem_odp, interval_tree);
 		ret_val = cb(umem, start, last, cookie) || ret_val;
 	}
@@ -784,16 +761,3 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 	return ret_val;
 }
 EXPORT_SYMBOL(rbt_ib_umem_for_each_in_range);
-
-struct ib_umem_odp *rbt_ib_umem_lookup(struct rb_root_cached *root,
-				       u64 addr, u64 length)
-{
-	struct umem_odp_node *node;
-
-	node = rbt_ib_umem_iter_first(root, addr, addr + length - 1);
-	if (node)
-		return container_of(node, struct ib_umem_odp, interval_tree);
-	return NULL;
-
-}
-EXPORT_SYMBOL(rbt_ib_umem_lookup);
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 479db5c98ff6..030d5cbad02c 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -37,11 +37,6 @@
 #include <rdma/ib_verbs.h>
 #include <linux/interval_tree.h>
 
-struct umem_odp_node {
-	u64 __subtree_last;
-	struct rb_node rb;
-};
-
 struct ib_umem_odp {
 	struct ib_umem umem;
 	struct ib_ucontext_per_mm *per_mm;
@@ -72,7 +67,7 @@ struct ib_umem_odp {
 	int npages;
 
 	/* Tree tracking */
-	struct umem_odp_node	interval_tree;
+	struct interval_tree_node interval_tree;
 
 	struct completion	notifier_completion;
 	int			dying;
@@ -163,8 +158,17 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
  * Find first region intersecting with address range.
  * Return NULL if not found
  */
-struct ib_umem_odp *rbt_ib_umem_lookup(struct rb_root_cached *root,
-				       u64 addr, u64 length);
+static inline struct ib_umem_odp *
+rbt_ib_umem_lookup(struct rb_root_cached *root, u64 addr, u64 length)
+{
+	struct interval_tree_node *node;
+
+	node = interval_tree_iter_first(root, addr, addr + length - 1);
+	if (!node)
+		return NULL;
+	return container_of(node, struct ib_umem_odp, interval_tree);
+
+}
 
 static inline int ib_umem_mmu_notifier_retry(struct ib_umem_odp *umem_odp,
 					     unsigned long mmu_seq)
-- 
2.20.1

