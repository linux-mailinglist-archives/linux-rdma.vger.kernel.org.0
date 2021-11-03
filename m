Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF336443C57
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhKCFGT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhKCFGR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:17 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44133C06120C
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bk26so812752oib.11
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhceRrO00HX8Q9P/7k++CSM5n25s/okjN2P5Dcqb+HA=;
        b=RdV5ts5ovJKqvRpkQB8TdR8XJLD6k7fFRBhZY9r1zzBVo1rw6MdSNxfE8zNTLkfYx8
         TSIQ5FhsZfhZbGVSC5qDoDLeXL7YKiIxxaLVyagng/wz/dKFz0wC42hvKwzGZP6fniXW
         LPEEiv5AHkzllVLxuwMYuLqfRgU+oFgDx7fqtsEg8OITsC9usiHOCqmsn8k8+aVwceR3
         sr8fyIKMiV+XP0vpYaLLHT9jCfqNLiQhHzjQAIokFeS4Ka4+SN0mVD5hTHv1KTJ6bZKi
         D4lhE7G47GKMJXrj4UjATUEVoOrEgFHUwfJgwSwVF5ZOgFJ7HSSVy3T7hljAGJblaQeU
         sSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhceRrO00HX8Q9P/7k++CSM5n25s/okjN2P5Dcqb+HA=;
        b=U+oGydAmkpyQx7cWildcrO7lL6qQWADUW+P0BBppVe12gwFho2Nmik4Z8S+tHCPnZq
         Tq/GqiQ8Pcslfho1QO5IbSCvIn2r1ayB47nEIcKZO5Los6s88bTsjw2DJSTgT9zJVVq0
         LjXmV3xMtRY2mAaHBTCk/wnvIXPMLxdzoqI2KoIU4nXEgPohle3K8SAwY1xIpYzNtebm
         SYuyfLwSPgGS7SWpqM6Wstl5LzGVzD0AZULgt9yuj9Gd0bvyIzk5YpaErhGgLIuJfFIC
         8YO0oOTlalNfv7MYBpxd9V425cs3vMUQO45TEMa6GSpDf1UUrhq5Zl0WhWfvffJ2qNp8
         XdeA==
X-Gm-Message-State: AOAM533Fi9lBlYQPCn/7RDcjRgIBNKOb+kC9HRIyWfjdYtr6GXQCAS+H
        0aS2+BzqvoPgtIevvIdEZfk78OmBsb0=
X-Google-Smtp-Source: ABdhPJw1GV6MZ29GN1gRt8mht8A1U3sOSM68lgTVV6I6TRrpdcAGySeENb5P50TuuS56H5O8xjJS7w==
X-Received: by 2002:a05:6808:42:: with SMTP id v2mr3315548oic.27.1635915820515;
        Tue, 02 Nov 2021 22:03:40 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 09/13] RDMA/rxe: Replaced keyed rxe objects by indexed objects
Date:   Wed,  3 Nov 2021 00:02:38 -0500
Message-Id: <20211103050241.61293-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace the keyed type rxe objects by xarrays with a 64 bit
index. This was only used for mgids. Here construct an index
for each mgid that is very likely to be unique. With this change
there is no longer a requirement for xxx_locked versions of the
pool APIs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 162 +++++++++++-----
 drivers/infiniband/sw/rxe/rxe_mw.c    |   2 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 256 +++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  67 +------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  32 ++--
 7 files changed, 230 insertions(+), 302 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b1e174afb1d4..b33a472eb347 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,17 +40,13 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p);
-
+struct rxe_mc_grp *rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
+				     int alloc);
 int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mc_grp *grp);
-
 int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			    union ib_gid *mgid);
-
+			   struct rxe_mc_grp *grp);
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
-
 void rxe_mc_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mmap.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index bd1ac88b8700..0fb1a7464a7f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -7,62 +7,120 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* caller should hold mc_grp_pool->pool_lock */
-static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
-				     struct rxe_pool *pool,
-				     union ib_gid *mgid)
+/**
+ * rxe_mgid_to_index - converts a 128 bit mgid to a 64 bit
+ * index which is hopefully unique.
+ * @mgid: the multicast address
+ *
+ * Returns: an index from the mgid
+ */
+static unsigned long rxe_mgid_to_index(union ib_gid *mgid)
 {
-	int err;
-	struct rxe_mc_grp *grp;
+	__be32 *val32 = (__be32 *)mgid;
+	unsigned long index;
 
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
-	if (!grp)
-		return ERR_PTR(-ENOMEM);
-
-	INIT_LIST_HEAD(&grp->qp_list);
-	spin_lock_init(&grp->mcg_lock);
-	grp->rxe = rxe;
-	rxe_add_key_locked(grp, mgid);
-
-	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
-		rxe_drop_ref(grp);
-		return ERR_PTR(err);
+	if (mgid->raw[10] == 0xff && mgid->raw[11] == 0xff) {
+		if ((mgid->raw[12] & 0xf0) != 0xe0)
+			pr_info("mgid is not an ipv4 mc address\n");
+
+		/* mgid is a mapped IPV4 multicast address
+		 * use the 32 bits as an index which will be
+		 * unique
+		 */
+		index = be32_to_cpu(val32[3]);
+	} else {
+		if (mgid->raw[0] != 0xff)
+			pr_info("mgid is not an ipv6 mc address\n");
+
+		/* mgid is an IPV6 multicast address which won't
+		 * fit into the index so construct the index
+		 * from the four 32 bit words in mgid.
+		 * If there is a collision treat it like
+		 * no memory and return NULL
+		 */
+		index = be32_to_cpu(val32[0] ^ val32[1]);
+		index = (index << 32) | be32_to_cpu(val32[2] ^ val32[3]);
 	}
 
-	return grp;
+	return index;
 }
 
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p)
+/**
+ * rxe_mcast_get_grp() - find or create mc_grp from mgid
+ * @rxe: the rdma device
+ * @mgid: the multicast address
+ * @alloc: if 0 just lookup else create a new group if lookup fails
+ *
+ * Returns: on success the mc_grp with a reference held else NULL
+ */
+struct rxe_mc_grp *rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
+				     int alloc)
 {
-	int err;
-	struct rxe_mc_grp *grp;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
+	struct rxe_mc_grp *grp;
+	struct rxe_mc_grp *old;
+	unsigned long index;
+	int err;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
-		return -EINVAL;
+		return NULL;
 
-	write_lock_bh(&pool->pool_lock);
+	index = rxe_mgid_to_index(mgid);
+	grp = rxe_pool_get_index(pool, index);
+	if (grp) {
+		if (memcmp(&grp->mgid, mgid, sizeof(*mgid)))
+			goto err_drop_ref;
 
-	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (grp)
-		goto done;
+		return grp;
+	}
+
+	if (!alloc)
+		return NULL;
+
+	grp = rxe_alloc_index(pool, index);
+	if (!grp) {
+		/* either we ran out of memory or someone else just
+		 * inserted a new group at this index most likely
+		 * with the same mgid. If so use that one.
+		 */
+		old = rxe_pool_get_index(pool, index);
+		if (!old)
+			return NULL;
 
-	grp = create_grp(rxe, pool, mgid);
-	if (IS_ERR(grp)) {
-		write_unlock_bh(&pool->pool_lock);
-		err = PTR_ERR(grp);
-		return err;
+		if (memcmp(&old->mgid, mgid, sizeof(*mgid)))
+			goto err_drop_ref;
+
+		return old;
 	}
 
-done:
-	write_unlock_bh(&pool->pool_lock);
-	*grp_p = grp;
-	return 0;
+	memcpy(&grp->mgid, mgid, sizeof(*mgid));
+	INIT_LIST_HEAD(&grp->qp_list);
+	spin_lock_init(&grp->mcg_lock);
+	grp->rxe = rxe;
+
+	err = rxe_mcast_add(rxe, mgid);
+	if (err)
+		goto err_drop_ref;
+
+	return grp;
+
+err_drop_ref:
+	rxe_drop_ref(grp);
+	return NULL;
 }
 
+/**
+ * rxe_mcast_add_grp_elem() - attach a multicast group to a QP
+ * @rxe: the rdma device
+ * @qp: the queue pair
+ * @grp: the mc group
+ *
+ * Allocates a struct rxe_mc_elem which is simultaneously on a
+ * list of QPs attached to grp and on a list of mc groups attached
+ * to QP. Takes a ref on grp until grp is detached.
+ *
+ * Returns: 0 on success or -ENOMEM on failure
+ */
 int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mc_grp *grp)
 {
@@ -84,7 +142,7 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		goto out;
 	}
 
-	elem = rxe_alloc_locked(&rxe->mc_elem_pool);
+	elem = rxe_alloc(&rxe->mc_elem_pool);
 	if (!elem) {
 		err = -ENOMEM;
 		goto out;
@@ -107,16 +165,22 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
+/**
+ * rxe_mcast_drop_grp_elem() - detach a multicast group from a QP
+ * @rxe: the rdma device
+ * @qp: the queue pair
+ * @grp: the mc group
+ *
+ * Searches the list of QPs attached to the mc group and then
+ * removes the attachment. Drops the ref on grp and the attachment.
+ *
+ * Returns: 0 on success or -EINVAL on failure if not found
+ */
 int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			    union ib_gid *mgid)
+			   struct rxe_mc_grp *grp)
 {
-	struct rxe_mc_grp *grp;
 	struct rxe_mc_elem *elem, *tmp;
 
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
-	if (!grp)
-		goto err1;
-
 	spin_lock_bh(&qp->grp_lock);
 	spin_lock_bh(&grp->mcg_lock);
 
@@ -130,15 +194,12 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			spin_unlock_bh(&qp->grp_lock);
 			rxe_drop_ref(elem);
 			rxe_drop_ref(grp);	/* ref held by QP */
-			rxe_drop_ref(grp);	/* ref from get_key */
 			return 0;
 		}
 	}
 
 	spin_unlock_bh(&grp->mcg_lock);
 	spin_unlock_bh(&qp->grp_lock);
-	rxe_drop_ref(grp);			/* ref from get_key */
-err1:
 	return -EINVAL;
 }
 
@@ -163,7 +224,7 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 		list_del(&elem->qp_list);
 		grp->num_qp--;
 		spin_unlock_bh(&grp->mcg_lock);
-		rxe_drop_ref(grp);
+		rxe_drop_ref(grp);		/* ref held by QP */
 		rxe_drop_ref(elem);
 	}
 }
@@ -173,6 +234,5 @@ void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 	struct rxe_mc_grp *grp = container_of(elem, typeof(*grp), elem);
 	struct rxe_dev *rxe = grp->rxe;
 
-	rxe_drop_key(grp);
 	rxe_mcast_delete(rxe, &grp->mgid);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 3ae981d77c25..8586361eb7ef 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -14,7 +14,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 
 	rxe_add_ref(pd);
 
-	ret = rxe_add_to_pool(&rxe->mw_pool, mw);
+	ret = rxe_pool_add(&rxe->mw_pool, mw);
 	if (ret) {
 		rxe_drop_ref(pd);
 		return ret;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6fa524efb6af..863fa62da077 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -33,7 +33,7 @@ static const struct rxe_type_info {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_AUTO_INDEX,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 	},
@@ -41,7 +41,7 @@ static const struct rxe_type_info {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_AUTO_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -50,7 +50,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_AUTO_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -65,7 +65,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
+		.flags		= RXE_POOL_AUTO_INDEX | RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 	},
@@ -74,7 +74,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_AUTO_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
@@ -83,7 +83,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mc_grp),
 		.elem_offset	= offsetof(struct rxe_mc_grp, elem),
 		.cleanup	= rxe_mc_cleanup,
-		.flags		= RXE_POOL_KEY | RXE_POOL_ALLOC,
+		.flags		= RXE_POOL_EXT_INDEX | RXE_POOL_ALLOC,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
 		.key_size	= sizeof(union ib_gid),
 	},
@@ -118,109 +118,42 @@ void rxe_pool_init(
 
 	rwlock_init(&pool->pool_lock);
 
-	if (pool->flags & RXE_POOL_INDEX) {
+	if (pool->flags & RXE_POOL_AUTO_INDEX) {
 		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
 		pool->xarray.limit.max = info->max_index;
 		pool->xarray.limit.min = info->min_index;
 	}
-
-	if (pool->flags & RXE_POOL_KEY) {
-		pool->key.tree = RB_ROOT;
-		pool->key.key_offset = info->key_offset;
-		pool->key.key_size = info->key_size;
-	}
 }
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	if (atomic_read(&pool->num_elem) > 0)
-		pr_warn("%s pool destroyed with unfree'd elem\n",
-			pool->name);
-}
-
-static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
-{
-	struct rb_node **link = &pool->key.tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct rxe_pool_elem *elem;
-	int cmp;
-
-	while (*link) {
-		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_elem, key_node);
+		pr_warn("%s pool destroyed with %d unfree'd elem\n",
+			pool->name, atomic_read(&pool->num_elem));
 
-		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     (u8 *)new + pool->key.key_offset,
-			     pool->key.key_size);
-
-		if (cmp == 0) {
-			pr_warn("key already exists!\n");
-			return -EINVAL;
-		}
-
-		if (cmp > 0)
-			link = &(*link)->rb_left;
-		else
-			link = &(*link)->rb_right;
-	}
-
-	rb_link_node(&new->key_node, parent, link);
-	rb_insert_color(&new->key_node, &pool->key.tree);
-
-	return 0;
+	if (pool->flags & (RXE_POOL_AUTO_INDEX | RXE_POOL_EXT_INDEX))
+		xa_destroy(&pool->xarray.xa);
 }
 
-int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	err = rxe_insert_key(pool, elem);
-
-	return err;
-}
-
-int __rxe_add_key(struct rxe_pool_elem *elem, void *key)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	write_lock_bh(&pool->pool_lock);
-	err = __rxe_add_key_locked(elem, key);
-	write_unlock_bh(&pool->pool_lock);
-
-	return err;
-}
-
-void __rxe_drop_key_locked(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	rb_erase(&elem->key_node, &pool->key.tree);
-}
-
-void __rxe_drop_key(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	write_lock_bh(&pool->pool_lock);
-	__rxe_drop_key_locked(elem);
-	write_unlock_bh(&pool->pool_lock);
-}
-
-void *rxe_alloc_locked(struct rxe_pool *pool)
+void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
 	int err;
 
+	if (!(pool->flags & RXE_POOL_ALLOC) ||
+	     (pool->flags & RXE_POOL_EXT_INDEX)) {
+		pr_info("%s called with pool->flags = 0x%x\n",
+				__func__, pool->flags);
+		return NULL;
+	}
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_count;
 
-	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
+	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj)
-		goto out_cnt;
+		goto err_count;
 
 	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
@@ -228,111 +161,116 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
-	if (pool->flags & RXE_POOL_INDEX) {
-		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
+	if (pool->flags & RXE_POOL_AUTO_INDEX) {
+		u32 index;
+
+		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &index, elem,
 					 pool->xarray.limit,
-					 &pool->xarray.next, GFP_ATOMIC);
+					 &pool->xarray.next, GFP_KERNEL);
 		if (err)
-			goto out_free;
+			goto err_free;
+
+		elem->index = index;
 	}
 
 	return obj;
 
-out_free:
+err_free:
 	kfree(obj);
-out_cnt:
+err_count:
 	atomic_dec(&pool->num_elem);
 	return NULL;
 }
 
-void *rxe_alloc(struct rxe_pool *pool)
+void *rxe_alloc_index(struct rxe_pool *pool, unsigned long index)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
-	int err;
+	void *old;
+
+	if (!(pool->flags & RXE_POOL_ALLOC) ||
+	    !(pool->flags & RXE_POOL_EXT_INDEX)) {
+		pr_info("%s called with pool->flags = 0x%x\n",
+				__func__, pool->flags);
+		return NULL;
+	}
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_count;
 
 	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj)
-		goto out_cnt;
+		goto err_count;
 
 	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
 	elem->obj = obj;
+	elem->index = index;
 	kref_init(&elem->ref_cnt);
 
-	if (pool->flags & RXE_POOL_INDEX) {
-		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
-					 pool->xarray.limit,
-					 &pool->xarray.next, GFP_KERNEL);
-		if (err)
-			goto out_free;
-	}
+	old = xa_cmpxchg(&pool->xarray.xa, index, NULL, elem, GFP_KERNEL);
+	if (old)
+		goto err_free;
 
 	return obj;
 
-out_free:
+err_free:
 	kfree(obj);
-out_cnt:
+err_count:
 	atomic_dec(&pool->num_elem);
 	return NULL;
 }
 
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
+int __rxe_pool_add(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	int err = -EINVAL;
 
+	if ((pool->flags & RXE_POOL_ALLOC) ||
+	    (pool->flags & RXE_POOL_EXT_INDEX)) {
+		pr_info("%s called with pool->flags = 0x%x\n",
+				__func__, pool->flags);
+		goto err_out;
+	}
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_count;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	if (pool->flags & RXE_POOL_INDEX) {
-		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
+	if (pool->flags & RXE_POOL_AUTO_INDEX) {
+		u32 index;
+
+		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &index, elem,
 					 pool->xarray.limit,
 					 &pool->xarray.next, GFP_KERNEL);
 		if (err)
-			goto out_cnt;
+			goto err_count;
+
+		elem->index = index;
 	}
 
 	return 0;
 
-out_cnt:
+err_count:
 	atomic_dec(&pool->num_elem);
+err_out:
 	return err;
 }
 
-void rxe_elem_release(struct kref *kref)
+void *rxe_pool_get_index(struct rxe_pool *pool, unsigned long index)
 {
-	struct rxe_pool_elem *elem =
-		container_of(kref, struct rxe_pool_elem, ref_cnt);
-	struct rxe_pool *pool = elem->pool;
+	struct rxe_pool_elem *elem;
 	void *obj;
 
-	if (pool->flags & RXE_POOL_INDEX)
-		xa_erase(&pool->xarray.xa, elem->index);
-
-	if (pool->cleanup)
-		pool->cleanup(elem);
-
-	if (pool->flags & RXE_POOL_ALLOC) {
-		obj = elem->obj;
-		kfree(obj);
+	if (!(pool->flags & (RXE_POOL_AUTO_INDEX | RXE_POOL_EXT_INDEX))) {
+		pr_info("%s called with pool->flags = 0x%x\n",
+				__func__, pool->flags);
+		return NULL;
 	}
 
-	atomic_dec(&pool->num_elem);
-}
-
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
-{
-	struct rxe_pool_elem *elem;
-	void *obj;
-
 	elem = xa_load(&pool->xarray.xa, index);
 	if (elem) {
 		kref_get(&elem->ref_cnt);
@@ -344,46 +282,20 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
+void rxe_elem_release(struct kref *kref)
 {
-	struct rb_node *node;
-	struct rxe_pool_elem *elem;
-	void *obj;
-	int cmp;
-
-	node = pool->key.tree.rb_node;
-
-	while (node) {
-		elem = rb_entry(node, struct rxe_pool_elem, key_node);
-
-		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     key, pool->key.key_size);
-
-		if (cmp > 0)
-			node = node->rb_left;
-		else if (cmp < 0)
-			node = node->rb_right;
-		else
-			break;
-	}
-
-	if (node) {
-		kref_get(&elem->ref_cnt);
-		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
+	struct rxe_pool_elem *elem = container_of(kref, struct rxe_pool_elem,
+						  ref_cnt);
+	struct rxe_pool *pool = elem->pool;
 
-	return obj;
-}
+	if (pool->cleanup)
+		pool->cleanup(elem);
 
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
-{
-	void *obj;
+	if (pool->flags & (RXE_POOL_AUTO_INDEX | RXE_POOL_EXT_INDEX))
+		xa_erase(&pool->xarray.xa, elem->index);
 
-	read_lock_bh(&pool->pool_lock);
-	obj = rxe_pool_get_key_locked(pool, key);
-	read_unlock_bh(&pool->pool_lock);
+	if (pool->flags & RXE_POOL_ALLOC)
+		kfree(elem->obj);
 
-	return obj;
+	atomic_dec(&pool->num_elem);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 7299426190c8..6cd2366d5407 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -8,9 +8,9 @@
 #define RXE_POOL_H
 
 enum rxe_pool_flags {
-	RXE_POOL_INDEX		= BIT(1),
-	RXE_POOL_KEY		= BIT(2),
-	RXE_POOL_ALLOC		= BIT(4),
+	RXE_POOL_AUTO_INDEX	= BIT(1),
+	RXE_POOL_EXT_INDEX	= BIT(2),
+	RXE_POOL_ALLOC		= BIT(3),
 };
 
 enum rxe_elem_type {
@@ -32,12 +32,7 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
-
-	/* only used if keyed */
-	struct rb_node		key_node;
-
-	/* only used if indexed */
-	u32			index;
+	unsigned long		index;
 };
 
 struct rxe_pool {
@@ -59,67 +54,25 @@ struct rxe_pool {
 		struct xa_limit		limit;
 		u32			next;
 	} xarray;
-
-	/* only used if keyed */
-	struct {
-		struct rb_root		tree;
-		size_t			key_offset;
-		size_t			key_size;
-	} key;
 };
 
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
-		  enum rxe_elem_type type, u32 max_elem);
+		   enum rxe_elem_type type, u32 max_elem);
 
-/* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool holding and not holding the pool lock */
-void *rxe_alloc_locked(struct rxe_pool *pool);
-
 void *rxe_alloc(struct rxe_pool *pool);
 
-/* connect already allocated object to pool */
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
-
-#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
-
-/* assign a key to a keyed object and insert object into
- * pool's rb tree holding and not holding pool_lock
- */
-int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key);
-
-#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->elem, key)
-
-int __rxe_add_key(struct rxe_pool_elem *elem, void *key);
+void *rxe_alloc_index(struct rxe_pool *pool, unsigned long index);
 
-#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->elem, key)
+int __rxe_pool_add(struct rxe_pool *pool, struct rxe_pool_elem *elem);
+#define rxe_pool_add(pool, obj) __rxe_pool_add(pool, &(obj)->elem)
 
-/* remove elem from rb tree holding and not holding the pool_lock */
-void __rxe_drop_key_locked(struct rxe_pool_elem *elem);
+void *rxe_pool_get_index(struct rxe_pool *pool, unsigned long index);
 
-#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->elem)
-
-void __rxe_drop_key(struct rxe_pool_elem *elem);
-
-#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->elem)
-
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
-
-/* lookup keyed object from key holding and not holding the pool_lock.
- * takes a reference on the objecti
- */
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
-
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
-
-/* cleanup an object when all references are dropped */
-void rxe_elem_release(struct kref *kref);
-
-/* take a reference on an object */
 #define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
 
-/* drop a reference on an object */
+void rxe_elem_release(struct kref *kref);
 #define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 6a6cc1fa90e4..780f7902f103 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -245,8 +245,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	else if (skb->protocol == htons(ETH_P_IPV6))
 		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
 
-	/* lookup mcast group corresponding to mgid, takes a ref */
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
+	mcg = rxe_mcast_get_grp(rxe, &dgid, 0);
 	if (!mcg)
 		goto drop;	/* mcast group not registered */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e3f64eae088c..7d5b4939ed6d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -108,7 +108,7 @@ static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibuc->device);
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	return rxe_add_to_pool(&rxe->uc_pool, uc);
+	return rxe_pool_add(&rxe->uc_pool, uc);
 }
 
 static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
@@ -142,7 +142,7 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	return rxe_add_to_pool(&rxe->pd_pool, pd);
+	return rxe_pool_add(&rxe->pd_pool, pd);
 }
 
 static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -176,7 +176,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	if (err)
 		return err;
 
-	err = rxe_add_to_pool(&rxe->ah_pool, ah);
+	err = rxe_pool_add(&rxe->ah_pool, ah);
 	if (err)
 		return err;
 
@@ -299,7 +299,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err1;
 
-	err = rxe_add_to_pool(&rxe->srq_pool, srq);
+	err = rxe_pool_add(&rxe->srq_pool, srq);
 	if (err)
 		goto err1;
 
@@ -430,7 +430,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 		qp->is_user = false;
 	}
 
-	err = rxe_add_to_pool(&rxe->qp_pool, qp);
+	err = rxe_pool_add(&rxe->qp_pool, qp);
 	if (err)
 		return err;
 
@@ -787,7 +787,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (err)
 		return err;
 
-	return rxe_add_to_pool(&rxe->cq_pool, cq);
+	return rxe_pool_add(&rxe->cq_pool, cq);
 }
 
 static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
@@ -984,15 +984,14 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 
 static int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mc_grp *grp;
+	int err;
 
-	/* takes a ref on grp if successful */
-	err = rxe_mcast_get_grp(rxe, mgid, &grp);
-	if (err)
-		return err;
+	grp = rxe_mcast_get_grp(rxe, mgid, 1);
+	if (!grp)
+		return -ENOMEM;
 
 	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
 
@@ -1004,8 +1003,17 @@ static int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
+	struct rxe_mc_grp *grp;
+	int err;
+
+	grp = rxe_mcast_get_grp(rxe, mgid, 0);
+	if (!grp)
+		return -EINVAL;
 
-	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
+	err = rxe_mcast_drop_grp_elem(rxe, qp, grp);
+
+	rxe_drop_ref(grp);
+	return err;
 }
 
 static ssize_t parent_show(struct device *device,
-- 
2.30.2

