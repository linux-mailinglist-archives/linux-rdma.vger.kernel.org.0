Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FCF48F4C0
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jan 2022 05:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiAOE34 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 23:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiAOE34 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 23:29:56 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA60C061574
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 20:29:56 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so12484118otu.2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 20:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjPeX1jbCfEkNv54BR706NhrU+GZ1wnWhr3NxoYiB2c=;
        b=TNNZAERAGHEdg6SukFJjCIKPhwZifiwrUv/TIDKCLMzvjdfU0Nsj24CswOl1M2eyhc
         18fwIRJspZXtVrqQ3oJ+0GUpFJImjr73MbRtnsgSuLCzSQz1emXQxE9QKjJ16W0enW/J
         NK5Z0tePJ9bq/PBzXpil3F/shF2/4GABeb9ULFwdIu9Io4fuVFl9cmGvUDrAFPZSYhwm
         rcU/6yH/dw7xnaWXLXGA6GUuBBsCH1+GuVF0+Y5yaJYJGoQLvHwi1VP+4hTD33hYtXus
         In3+xsJY3wksm2hguBUOpGCeBROezvx/Ym2uhgg3NklhWMwIAssq/dKpt5gPdX9IbTVI
         JAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjPeX1jbCfEkNv54BR706NhrU+GZ1wnWhr3NxoYiB2c=;
        b=H7Fcd8mGNTUqF74tZrVVcBaNxL1Xwsmo8ocRWoNebquqMYsLgpIsC452Cgofqxazz0
         pYBV2+d4pC9xbp0q4mlXF4Q3kYP3OmxYKpNzV6RMhLX861Vwc4oTjtC+U4g1ddbdh53T
         R1rvxekEUheqXeORcb48xj/VzxtzzC5bihlq/GhujE7wytIlmiuR/wlKbODTCwFhQ1mW
         IzTFjRE/iAt/V9TY0HDJFt7+HTHlJKPsMtsZNefOA4pdzqiuhJfIbRggazieIpptGm6d
         7lEZgLIs1ugV1J3PBN6iIfZ2xRZnRzeeKxNFpmD7TeEjCEd73NTfhEXrsHLBvDNGz0CU
         O7dg==
X-Gm-Message-State: AOAM533wg4ZRAA3qLIDJn23RL8CFlttiPvGiu2eOjeFI2VGs49yA6FMU
        UbA/zYbn4N/w/4lDcHiBF78=
X-Google-Smtp-Source: ABdhPJzKqx0xcuido9K4GVGwRGduz4+Z4YCP8Ktwye0aolaph54377KtUfKSdWO7s/qMefFoXLjpCw==
X-Received: by 2002:a9d:4b13:: with SMTP id q19mr8982213otf.300.1642220995326;
        Fri, 14 Jan 2022 20:29:55 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id k8sm2757515oon.2.2022.01.14.20.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 20:29:54 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 1/4] RDMA/rxe: Move keyed objects to rxe_mcast.c
Date:   Fri, 14 Jan 2022 22:29:08 -0600
Message-Id: <20220115042910.40181-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115042910.40181-1-rpearsonhpe@gmail.com>
References: <20220115042910.40181-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently there are two different types of objects supported by the
pool machinery in rxe_pool.c. One is shared with rdma/core and
can be indexed and the other has a key. The keyed type is only used
once by rxe_mcast.c and is not shared with rdma/core. This patch
separates this type by itself and moves the code into rxe_mcast.c
which will allow simplification of the other object types. rxe_mcast.c
is mostly re-written.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  19 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  19 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 436 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.c   |  18 --
 drivers/infiniband/sw/rxe/rxe_pool.c  | 135 --------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  39 ---
 drivers/infiniband/sw/rxe/rxe_qp.c    |   5 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |  28 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  26 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  29 +-
 10 files changed, 367 insertions(+), 387 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index fab291245366..c560d467a972 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -28,8 +28,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->cq_pool);
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
-	rxe_pool_cleanup(&rxe->mc_grp_pool);
-	rxe_pool_cleanup(&rxe->mc_elem_pool);
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
@@ -158,22 +156,8 @@ static int rxe_init_pools(struct rxe_dev *rxe)
 	if (err)
 		goto err8;
 
-	err = rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
-			    rxe->attr.max_mcast_grp);
-	if (err)
-		goto err9;
-
-	err = rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
-			    rxe->attr.max_total_mcast_qp_attach);
-	if (err)
-		goto err10;
-
 	return 0;
 
-err10:
-	rxe_pool_cleanup(&rxe->mc_grp_pool);
-err9:
-	rxe_pool_cleanup(&rxe->mw_pool);
 err8:
 	rxe_pool_cleanup(&rxe->mr_pool);
 err7:
@@ -206,6 +190,9 @@ static int rxe_init(struct rxe_dev *rxe)
 	if (err)
 		return err;
 
+	spin_lock_init(&rxe->mcg_lock);
+	rxe->mcg_tree = RB_ROOT;
+
 	/* init pending mmap list */
 	spin_lock_init(&rxe->mmap_offset_lock);
 	spin_lock_init(&rxe->pending_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b1e174afb1d4..805f40f84e62 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,18 +40,11 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p);
-
-int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mc_grp *grp);
-
-int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			    union ib_gid *mgid);
-
-void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
-
-void rxe_mc_cleanup(struct rxe_pool_elem *arg);
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
+int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
+int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
+void rxe_cleanup_mcast(struct rxe_qp *qp);
+void rxe_cleanup_mcg(struct kref *kref);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
@@ -106,8 +99,6 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
-int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
-int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index bd1ac88b8700..95eb8c9ccda0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -1,178 +1,398 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * Copyright (c) 2022 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+/*
+ * rxe_mcast.c implements driver support for multicast transport.
+ * It is based on two data structures struct rxe_mcg ('mcg') and
+ * struct rxe_mca ('mca'). An mcg is allocated each time a qp is
+ * attached to a new mgid for the first time. These are held in a red-black
+ * tree and indexed by the mgid. This data structure is searched for
+ * the mcast group when a multicast packet is received and when another
+ * qp is attached to the same mgid. It is cleaned up when the last qp
+ * is detached from the mcg. Each time a qp is attached to an mcg
+ * an mca is created to hold pointers to the qp and
+ * the mcg and is added to two lists. One is a list of mcg's
+ * attached to by the qp and the other is the list of qp's attached
+ * to the mcg. mcg's are reference counted and once the count goes to
+ * zero it is inactive and will be cleaned up.
+ *
+ * The qp list is protected by mcg->lock while the other data
+ * structures are protected by rxe->mcg_lock. The performance critical
+ * path of processing multicast packets only requres holding the mcg->lock
+ * while the multicast related verbs APIs require holding both the locks.
+ */
+
 #include "rxe.h"
-#include "rxe_loc.h"
 
-/* caller should hold mc_grp_pool->pool_lock */
-static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
-				     struct rxe_pool *pool,
-				     union ib_gid *mgid)
+static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	int err;
-	struct rxe_mc_grp *grp;
+	unsigned char ll_addr[ETH_ALEN];
+
+	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
 
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
-	if (!grp)
-		return ERR_PTR(-ENOMEM);
+	return dev_mc_add(rxe->ndev, ll_addr);
+}
 
-	INIT_LIST_HEAD(&grp->qp_list);
-	spin_lock_init(&grp->mcg_lock);
-	grp->rxe = rxe;
-	rxe_add_key_locked(grp, mgid);
+static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
+{
+	unsigned char ll_addr[ETH_ALEN];
 
-	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
-		rxe_drop_ref(grp);
-		return ERR_PTR(err);
+	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+
+	return dev_mc_del(rxe->ndev, ll_addr);
+}
+
+/**
+ * __rxe_insert_mcg() - insert an mcg into red-black tree (rxe->mcg_tree)
+ * @mcg: mcast group object with an embedded red-black tree node
+ *
+ * Context: caller must hold rxe->mcg_lock and must first search
+ * the tree to see if the mcg is already present.
+ */
+static void __rxe_insert_mcg(struct rxe_mcg *mcg)
+{
+	struct rb_root *tree = &mcg->rxe->mcg_tree;
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *node = NULL;
+	struct rxe_mcg *tmp;
+	int cmp;
+
+	while (*link) {
+		node = *link;
+		tmp = rb_entry(node, struct rxe_mcg, node);
+
+		cmp = memcmp(&tmp->mgid, &mcg->mgid, sizeof(mcg->mgid));
+		if (cmp > 0)
+			link = &(*link)->rb_left;
+		else
+			link = &(*link)->rb_right;
 	}
 
-	return grp;
+	rb_link_node(&mcg->node, node, link);
+	rb_insert_color(&mcg->node, tree);
 }
 
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p)
+static void __rxe_remove_mcg(struct rxe_mcg *mcg)
 {
+	rb_erase(&mcg->node, &mcg->rxe->mcg_tree);
+}
+
+/**
+ * __rxe_lookup_mcg() - lookup mcg in rxe->mcg_tree while holding lock
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ *
+ * Context: caller must hold rxe->mcg_lock
+ * Returns: mcg on success or NULL
+ */
+static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
+					union ib_gid *mgid)
+{
+	struct rb_root *tree = &rxe->mcg_tree;
+	struct rxe_mcg *mcg;
+	struct rb_node *node;
+	int cmp;
+
+	node = tree->rb_node;
+
+	while (node) {
+		mcg = rb_entry(node, struct rxe_mcg, node);
+
+		cmp = memcmp(&mcg->mgid, mgid, sizeof(*mgid));
+
+		if (cmp > 0)
+			node = node->rb_left;
+		else if (cmp < 0)
+			node = node->rb_right;
+		else
+			break;
+	}
+
+	if (node && kref_get_unless_zero(&mcg->ref_cnt))
+		return mcg;
+
+	return NULL;
+}
+
+/**
+ * rxe_lookup_mcg() - lookup up mcast group from mgid
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ *
+ * Returns: mcg if found else NULL
+ */
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
+					   union ib_gid *mgid)
+{
+	struct rxe_mcg *mcg;
+
+	spin_lock_bh(&rxe->mcg_lock);
+	mcg = __rxe_lookup_mcg(rxe, mgid);
+	spin_unlock_bh(&rxe->mcg_lock);
+
+	return mcg;
+}
+
+/**
+ * rxe_get_mcg() - lookup or allocate a mcg
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ * @mcgg: address of returned mcg value
+ *
+ * Returns: 0 on success else an error
+ */
+static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
+		       struct rxe_mcg **mcgp)
+{
+	struct rxe_mcg *mcg, *tmp;
 	int err;
-	struct rxe_mc_grp *grp;
-	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
-	if (rxe->attr.max_mcast_qp_attach == 0)
+	if (rxe->attr.max_mcast_grp == 0)
 		return -EINVAL;
 
-	write_lock_bh(&pool->pool_lock);
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (mcg)
+		goto done;
+
+	mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
+	if (!mcg)
+		return -ENOMEM;
 
-	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (grp)
+	spin_lock_bh(&rxe->mcg_lock);
+	tmp = __rxe_lookup_mcg(rxe, mgid);
+	if (unlikely(tmp)) {
+		/* another thread just added this mcg, use that one */
+		spin_unlock_bh(&rxe->mcg_lock);
+		kfree(mcg);
+		mcg = tmp;
 		goto done;
+	}
 
-	grp = create_grp(rxe, pool, mgid);
-	if (IS_ERR(grp)) {
-		write_unlock_bh(&pool->pool_lock);
-		err = PTR_ERR(grp);
-		return err;
+	if (rxe->num_mcg >= rxe->attr.max_mcast_grp) {
+		err = -ENOMEM;
+		goto err_out;
 	}
 
+	err = rxe_mcast_add(rxe, mgid);
+	if (unlikely(err))
+		goto err_out;
+
+	INIT_LIST_HEAD(&mcg->qp_list);
+	spin_lock_init(&mcg->lock);
+	mcg->rxe = rxe;
+	memcpy(&mcg->mgid, mgid, sizeof(*mgid));
+	kref_init(&mcg->ref_cnt);
+	__rxe_insert_mcg(mcg);
+	spin_unlock_bh(&rxe->mcg_lock);
 done:
-	write_unlock_bh(&pool->pool_lock);
-	*grp_p = grp;
+	*mcgp = mcg;
 	return 0;
+err_out:
+	spin_unlock_bh(&rxe->mcg_lock);
+	kfree(mcg);
+	return err;
 }
 
-int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mc_grp *grp)
+/**
+ * rxe_attach_mcg() - attach qp to mcg
+ * @qp: qp object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold reference on qp and mcg.
+ * Returns: 0 on success else an error
+ */
+static int rxe_attach_mcg(struct rxe_qp *qp, struct rxe_mcg *mcg)
 {
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mca *mca;
 	int err;
-	struct rxe_mc_elem *elem;
 
-	/* check to see of the qp is already a member of the group */
-	spin_lock_bh(&qp->grp_lock);
-	spin_lock_bh(&grp->mcg_lock);
-	list_for_each_entry(elem, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
+	spin_lock_bh(&rxe->mcg_lock);
+	spin_lock_bh(&mcg->lock);
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+		if (mca->qp == qp) {
 			err = 0;
 			goto out;
 		}
 	}
 
-	if (grp->num_qp >= rxe->attr.max_mcast_qp_attach) {
+	if (rxe->num_attach >= rxe->attr.max_total_mcast_qp_attach
+	    || mcg->num_qp >= rxe->attr.max_mcast_qp_attach) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	elem = rxe_alloc_locked(&rxe->mc_elem_pool);
-	if (!elem) {
+	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
+	if (!mca) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	/* each qp holds a ref on the grp */
-	rxe_add_ref(grp);
+	/* each mca holds a ref on mcg and qp */
+	kref_get(&mcg->ref_cnt);
+	rxe_add_ref(qp);
 
-	grp->num_qp++;
-	elem->qp = qp;
-	elem->grp = grp;
+	mcg->num_qp++;
+	rxe->num_attach++;
+	mca->qp = qp;
+	mca->mcg = mcg;
 
-	list_add(&elem->qp_list, &grp->qp_list);
-	list_add(&elem->grp_list, &qp->grp_list);
+	list_add(&mca->qp_list, &mcg->qp_list);
+	list_add(&mca->mcg_list, &qp->mcg_list);
 
 	err = 0;
 out:
-	spin_unlock_bh(&grp->mcg_lock);
-	spin_unlock_bh(&qp->grp_lock);
+	spin_unlock_bh(&mcg->lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return err;
 }
 
-int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			    union ib_gid *mgid)
+/**
+ * __rxe_cleanup_mca() - cleanup mca object
+ * @mca: mca object
+ *
+ * Context: caller holds rxe->mcg_lock and holds at least one reference
+ * to mca->mcg from the mca object and one from the rxe_get_mcg()
+ * call. If this is the last attachment to the mcast mcg object then
+ * drop the last refernece to it.
+ * Returns: 1 if the mcg is finished and needs to be cleaned up else 0.
+ */
+static void __rxe_cleanup_mca(struct rxe_mca *mca)
 {
-	struct rxe_mc_grp *grp;
-	struct rxe_mc_elem *elem, *tmp;
-
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
-	if (!grp)
-		goto err1;
-
-	spin_lock_bh(&qp->grp_lock);
-	spin_lock_bh(&grp->mcg_lock);
-
-	list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
-			list_del(&elem->qp_list);
-			list_del(&elem->grp_list);
-			grp->num_qp--;
-
-			spin_unlock_bh(&grp->mcg_lock);
-			spin_unlock_bh(&qp->grp_lock);
-			rxe_drop_ref(elem);
-			rxe_drop_ref(grp);	/* ref held by QP */
-			rxe_drop_ref(grp);	/* ref from get_key */
-			return 0;
+	struct rxe_mcg *mcg = mca->mcg;
+	struct rxe_dev *rxe = mcg->rxe;
+
+	list_del(&mca->qp_list);
+	list_del(&mca->mcg_list);
+	rxe_drop_ref(mca->qp);
+	kfree(mca);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+	rxe->num_attach--;
+	if (--mcg->num_qp <= 0)
+		kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+}
+
+/**
+ * rxe_detach_mcg() - detach qp from mcg
+ * @qp: qp object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold reference to qp and mcg.
+ * Returns: 0 on success else an error.
+ */
+static int rxe_detach_mcg(struct rxe_qp *qp, struct rxe_mcg *mcg)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mca *mca, *tmp;
+	int ret = -EINVAL;
+
+	spin_lock_bh(&rxe->mcg_lock);
+	spin_lock_bh(&mcg->lock);
+
+	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			__rxe_cleanup_mca(mca);
+			ret = 0;
+			goto done;
 		}
 	}
+done:
+	spin_unlock_bh(&mcg->lock);
+	spin_unlock_bh(&rxe->mcg_lock);
+	return ret;
+}
+
+/**
+ * rxe_attach_mcast() - attach qp to multicast group (see IBA-11.3.1)
+ * @ibqp: (IB) qp object
+ * @mgid: multicast IP address
+ * @mlid: multicast LID, ignored for RoCEv2 (see IBA-A17.5.6)
+ *
+ * Returns: 0 on success else an errno
+ */
+int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
+{
+	struct rxe_dev *rxe = to_rdev(ibqp->device);
+	struct rxe_qp *qp = to_rqp(ibqp);
+	struct rxe_mcg *mcg;
+	int err;
+
+	err = rxe_get_mcg(rxe, mgid, &mcg);
+	if (err)
+		return err;
+
+	err = rxe_attach_mcg(qp, mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
-	spin_unlock_bh(&grp->mcg_lock);
-	spin_unlock_bh(&qp->grp_lock);
-	rxe_drop_ref(grp);			/* ref from get_key */
-err1:
-	return -EINVAL;
+	return err;
 }
 
-void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
+/**
+ * rxe_detach_mcast() - detach qp from multicast group (see IBA-11.3.2)
+ * @ibqp: address of (IB) qp object
+ * @mgid: multicast IP address
+ * @mlid: multicast LID, ignored for RoCEv2 (see IBA-A17.5.6)
+ *
+ * Returns: 0 on success else an errno
+ */
+int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
-	struct rxe_mc_grp *grp;
-	struct rxe_mc_elem *elem;
+	struct rxe_dev *rxe = to_rdev(ibqp->device);
+	struct rxe_qp *qp = to_rqp(ibqp);
+	struct rxe_mcg *mcg;
+	int err;
+
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (!mcg)
+		return -EINVAL;
+
+	err = rxe_detach_mcg(qp, mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
+	return err;
+}
+
+/**
+ * rxe_cleanup_mcast() - cleanup all mcg's qp is attached to
+ * @qp: qp object
+ */
+void rxe_cleanup_mcast(struct rxe_qp *qp)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mca *mca;
+	struct rxe_mcg *mcg;
 
 	while (1) {
-		spin_lock_bh(&qp->grp_lock);
-		if (list_empty(&qp->grp_list)) {
-			spin_unlock_bh(&qp->grp_lock);
-			break;
+		spin_lock_bh(&rxe->mcg_lock);
+		if (list_empty(&qp->mcg_list)) {
+			spin_unlock_bh(&rxe->mcg_lock);
+			return;
 		}
-		elem = list_first_entry(&qp->grp_list, struct rxe_mc_elem,
-					grp_list);
-		list_del(&elem->grp_list);
-		spin_unlock_bh(&qp->grp_lock);
-
-		grp = elem->grp;
-		spin_lock_bh(&grp->mcg_lock);
-		list_del(&elem->qp_list);
-		grp->num_qp--;
-		spin_unlock_bh(&grp->mcg_lock);
-		rxe_drop_ref(grp);
-		rxe_drop_ref(elem);
+		mca = list_first_entry(&qp->mcg_list, typeof(*mca), mcg_list);
+		mcg = mca->mcg;
+		spin_lock_bh(&mcg->lock);
+		__rxe_cleanup_mca(mca);
+		spin_unlock_bh(&mcg->lock);
+		spin_unlock_bh(&rxe->mcg_lock);
 	}
 }
 
-void rxe_mc_cleanup(struct rxe_pool_elem *elem)
+/**
+ * rxe_cleanup_mcg() - cleanup mcg object
+ * @mcg: mcg object
+ *
+ * Context: caller has removed all references to mcg
+ */
+void rxe_cleanup_mcg(struct kref *kref)
 {
-	struct rxe_mc_grp *grp = container_of(elem, typeof(*grp), elem);
-	struct rxe_dev *rxe = grp->rxe;
+	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
+	struct rxe_dev *rxe = mcg->rxe;
 
-	rxe_drop_key(grp);
-	rxe_mcast_delete(rxe, &grp->mgid);
+	__rxe_remove_mcg(mcg);
+	rxe_mcast_delete(rxe, &mcg->mgid);
+	kfree(mcg);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index be72bdbfb4ba..a8cfa7160478 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,24 +20,6 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
-{
-	unsigned char ll_addr[ETH_ALEN];
-
-	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-
-	return dev_mc_add(rxe->ndev, ll_addr);
-}
-
-int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
-{
-	unsigned char ll_addr[ETH_ALEN];
-
-	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-
-	return dev_mc_del(rxe->ndev, ll_addr);
-}
-
 static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 				  struct in_addr *saddr,
 				  struct in_addr *daddr)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4cb003885e00..4e558d5e0ded 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -81,20 +81,6 @@ static const struct rxe_type_info {
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
-	[RXE_TYPE_MC_GRP] = {
-		.name		= "rxe-mc_grp",
-		.size		= sizeof(struct rxe_mc_grp),
-		.elem_offset	= offsetof(struct rxe_mc_grp, elem),
-		.cleanup	= rxe_mc_cleanup,
-		.flags		= RXE_POOL_KEY,
-		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
-		.key_size	= sizeof(union ib_gid),
-	},
-	[RXE_TYPE_MC_ELEM] = {
-		.name		= "rxe-mc_elem",
-		.size		= sizeof(struct rxe_mc_elem),
-		.elem_offset	= offsetof(struct rxe_mc_elem, elem),
-	},
 };
 
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
@@ -152,12 +138,6 @@ int rxe_pool_init(
 			goto out;
 	}
 
-	if (pool->flags & RXE_POOL_KEY) {
-		pool->key.tree = RB_ROOT;
-		pool->key.key_offset = info->key_offset;
-		pool->key.key_size = info->key_size;
-	}
-
 out:
 	return err;
 }
@@ -214,77 +194,6 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
 	return 0;
 }
 
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
-
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
-}
-
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
 int __rxe_add_index_locked(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -448,47 +357,3 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 	return obj;
 }
-
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
-{
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
-
-	return obj;
-}
-
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
-{
-	void *obj;
-
-	read_lock_bh(&pool->pool_lock);
-	obj = rxe_pool_get_key_locked(pool, key);
-	read_unlock_bh(&pool->pool_lock);
-
-	return obj;
-}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 214279310f4d..b6de415e10d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -9,7 +9,6 @@
 
 enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
-	RXE_POOL_KEY		= BIT(2),
 	RXE_POOL_NO_ALLOC	= BIT(4),
 };
 
@@ -23,7 +22,6 @@ enum rxe_elem_type {
 	RXE_TYPE_MR,
 	RXE_TYPE_MW,
 	RXE_TYPE_MC_GRP,
-	RXE_TYPE_MC_ELEM,
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
@@ -33,9 +31,6 @@ struct rxe_pool_elem {
 	struct kref		ref_cnt;
 	struct list_head	list;
 
-	/* only used if keyed */
-	struct rb_node		key_node;
-
 	/* only used if indexed */
 	struct rb_node		index_node;
 	u32			index;
@@ -62,13 +57,6 @@ struct rxe_pool {
 		u32			max_index;
 		u32			min_index;
 	} index;
-
-	/* only used if keyed */
-	struct {
-		struct rb_root		tree;
-		size_t			key_offset;
-		size_t			key_size;
-	} key;
 };
 
 /* initialize a pool of objects with given limit on
@@ -113,26 +101,6 @@ void __rxe_drop_index(struct rxe_pool_elem *elem);
 
 #define rxe_drop_index(obj) __rxe_drop_index(&(obj)->elem)
 
-/* assign a key to a keyed object and insert object into
- * pool's rb tree holding and not holding pool_lock
- */
-int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key);
-
-#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->elem, key)
-
-int __rxe_add_key(struct rxe_pool_elem *elem, void *key);
-
-#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->elem, key)
-
-/* remove elem from rb tree holding and not holding the pool_lock */
-void __rxe_drop_key_locked(struct rxe_pool_elem *elem);
-
-#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->elem)
-
-void __rxe_drop_key(struct rxe_pool_elem *elem);
-
-#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->elem)
-
 /* lookup an indexed object from index holding and not holding the pool_lock.
  * takes a reference on object
  */
@@ -140,13 +108,6 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index);
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup keyed object from key holding and not holding the pool_lock.
- * takes a reference on the objecti
- */
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
-
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
-
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index afe11f475b8c..4c0cea0833ee 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -188,9 +188,8 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 		break;
 	}
 
-	INIT_LIST_HEAD(&qp->grp_list);
+	INIT_LIST_HEAD(&qp->mcg_list);
 
-	spin_lock_init(&qp->grp_lock);
 	spin_lock_init(&qp->state_lock);
 
 	atomic_set(&qp->ssn, 0);
@@ -799,7 +798,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 {
 	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
 
-	rxe_drop_all_mcast_groups(qp);
+	rxe_cleanup_mcast(qp);
 
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 6a6cc1fa90e4..78681f25a6d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -233,32 +233,33 @@ static inline void rxe_rcv_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 {
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
-	struct rxe_mc_grp *mcg;
-	struct rxe_mc_elem *mce;
+	struct rxe_mcg *mcg;
+	struct rxe_mca *mca, *last;
 	struct rxe_qp *qp;
-	union ib_gid dgid;
+	union ib_gid mgid;
 	int err;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		ipv6_addr_set_v4mapped(ip_hdr(skb)->daddr,
-				       (struct in6_addr *)&dgid);
+				       (struct in6_addr *)&mgid);
 	else if (skb->protocol == htons(ETH_P_IPV6))
-		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
+		memcpy(&mgid, &ipv6_hdr(skb)->daddr, sizeof(mgid));
 
-	/* lookup mcast group corresponding to mgid, takes a ref */
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
+	mcg = rxe_lookup_mcg(rxe, &mgid);
 	if (!mcg)
 		goto drop;	/* mcast group not registered */
 
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&mcg->lock);
+
+	last = list_last_entry(&mcg->qp_list, typeof(*last), qp_list);
 
 	/* this is unreliable datagram service so we let
 	 * failures to deliver a multicast packet to a
 	 * single QP happen and just move on and try
 	 * the rest of them on the list
 	 */
-	list_for_each_entry(mce, &mcg->qp_list, qp_list) {
-		qp = mce->qp;
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+		qp = mca->qp;
 
 		/* validate qp for incoming packet */
 		err = check_type_state(rxe, pkt, qp);
@@ -273,7 +274,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		 * skb and pass to the QP. Pass the original skb to
 		 * the last QP in the list.
 		 */
-		if (mce->qp_list.next != &mcg->qp_list) {
+		if (mca != last) {
 			struct sk_buff *cskb;
 			struct rxe_pkt_info *cpkt;
 
@@ -298,9 +299,8 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		}
 	}
 
-	spin_unlock_bh(&mcg->mcg_lock);
-
-	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+	spin_unlock_bh(&mcg->lock);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
 	if (likely(!skb))
 		return;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 915ad6664321..f7682541f9af 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -999,32 +999,6 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 	return n;
 }
 
-static int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
-{
-	int err;
-	struct rxe_dev *rxe = to_rdev(ibqp->device);
-	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_mc_grp *grp;
-
-	/* takes a ref on grp if successful */
-	err = rxe_mcast_get_grp(rxe, mgid, &grp);
-	if (err)
-		return err;
-
-	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
-
-	rxe_drop_ref(grp);
-	return err;
-}
-
-static int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
-{
-	struct rxe_dev *rxe = to_rdev(ibqp->device);
-	struct rxe_qp *qp = to_rqp(ibqp);
-
-	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
-}
-
 static ssize_t parent_show(struct device *device,
 			   struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e48969e8d4c8..e2431753755e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -232,9 +232,7 @@ struct rxe_qp {
 	struct rxe_av		pri_av;
 	struct rxe_av		alt_av;
 
-	/* list of mcast groups qp has joined (for cleanup) */
-	struct list_head	grp_list;
-	spinlock_t		grp_lock; /* guard grp_list */
+	struct list_head	mcg_list;
 
 	struct sk_buff_head	req_pkts;
 	struct sk_buff_head	resp_pkts;
@@ -353,23 +351,23 @@ struct rxe_mw {
 	u64			length;
 };
 
-struct rxe_mc_grp {
-	struct rxe_pool_elem	elem;
-	spinlock_t		mcg_lock; /* guard group */
-	struct rxe_dev		*rxe;
-	struct list_head	qp_list;
+struct rxe_mcg {
+	struct rb_node		node;
 	union ib_gid		mgid;
+	struct list_head	qp_list;
+	struct kref		ref_cnt;
+	struct rxe_dev		*rxe;
+	spinlock_t		lock; /* guard qp_list */
 	int			num_qp;
 	u32			qkey;
 	u16			pkey;
 };
 
-struct rxe_mc_elem {
-	struct rxe_pool_elem	elem;
+struct rxe_mca {
 	struct list_head	qp_list;
-	struct list_head	grp_list;
+	struct list_head	mcg_list;
 	struct rxe_qp		*qp;
-	struct rxe_mc_grp	*grp;
+	struct rxe_mcg		*mcg;
 };
 
 struct rxe_port {
@@ -400,8 +398,11 @@ struct rxe_dev {
 	struct rxe_pool		cq_pool;
 	struct rxe_pool		mr_pool;
 	struct rxe_pool		mw_pool;
-	struct rxe_pool		mc_grp_pool;
-	struct rxe_pool		mc_elem_pool;
+
+	spinlock_t		mcg_lock; /* guard mcg_tree and mcg->qp_list */
+	struct rb_root		mcg_tree;
+	int			num_mcg;
+	int			num_attach;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

