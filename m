Return-Path: <linux-rdma+bounces-145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF777FE0F8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD23A1C20C67
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406160EE2;
	Wed, 29 Nov 2023 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE7gvphe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A845D71
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:29 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58ceab7daddso126103eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701289589; x=1701894389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB46h1qQvGrP3T4J5+qBSgGcpfSh92PG6l8mrznpKt4=;
        b=SE7gvpheZlp8k2eGRIPAGNc+iEtnJ2ZdhwKcq8KPOe8mzeddAnbMOx7IfWYAtfIJW3
         KD1e6uHm7cvOzSjiFreiFbH4ZajWIhSlxtiJ4DuboT4RTVyhYgYkVsJVEWYXccBw23c4
         R3mzpeUIJB9v/BOoHIlbWEOKqJqHw1PM3YCTtnJfgEtDTTLpzLz7jZyd4CFlDPPr279r
         Pa6UILnBmzLMznSrMwcrqrQp99A5BTJPcidlAqP/0ICDQDs2vi4yBejOsgIIxk8eTs3a
         xHWgYHnv4NT4a6LUDIASxL/8i0wXd8RnXokcgY2FsDooo5wD6UBY5RXeSn+tPFefvT9m
         LHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289589; x=1701894389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB46h1qQvGrP3T4J5+qBSgGcpfSh92PG6l8mrznpKt4=;
        b=u/nD02KznSDZj1aYBZYCtcXAxjcClplWWFHAVh+L0G5qqx089Oy5GE7JsuudWIMZSS
         Iy4wd8LY85nGiWDan3lSLyjSW7gsgwvjXwkNKwq0A7RzsQZ2img9Bj1w+qaKLXdEeeQf
         0qD8bKRArgoyvvFxnh8te5MwGWR/CFfVM7z4ZyKKBuq4lgzFqbf7agq56HPiCWhtTeK1
         iKePap+eOCaXda/g5V7rbnhvxDlZ22uanIg1zBCS4xaFL8poV4SqU/vc7jIXC9eHrls1
         mHHsT+K9Ec9fjsoKNIcOgpGIuXDlf05i3Ttan21rdKUL/r8bdMgTnnTaTVa7nlZA9H6t
         eXWQ==
X-Gm-Message-State: AOJu0YxWGlzOwZl/7MHWRTkW8JyEBvXYGVDuhvUwn/8Fo5SRUtWmzROg
	uU7p7/fK5MxM0SUHPnTv2ayyuvLfYCU=
X-Google-Smtp-Source: AGHT+IGMVZpNCi3JoNc8jJAXVtIS/2o/ORB8K7VzuZ1iaK5CHnOeRDDMOgZHipGCXApxERtd4+V9iQ==
X-Received: by 2002:a05:6820:62a:b0:58d:8b93:eca with SMTP id e42-20020a056820062a00b0058d8b930ecamr10513603oow.6.1701289588916;
        Wed, 29 Nov 2023 12:26:28 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-6755-34f8-2ed3-56ec.res6.spectrum.com. [2603:8081:1405:679b:6755:34f8:2ed3:56ec])
        by smtp.gmail.com with ESMTPSA id 126-20020a4a0684000000b0058ab906ae38sm2473867ooj.2.2023.11.29.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:26:28 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 4/7] RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
Date: Wed, 29 Nov 2023 14:25:56 -0600
Message-Id: <20231129202558.31682-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129202558.31682-1-rpearsonhpe@gmail.com>
References: <20231129202558.31682-1-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change locking of read side operations of the mcast group
red-black tree to use rcu read locking. This will allow changing
the mcast lock in the next patch to be a mutex without
breaking rxe_recv.c which runs in an atomic state. It is also a
better implementation than the current use of a spin-lock per
rdma device since receiving mcast packets will be much more
common than registering/deregistering mcast groups.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 59 +++++++++------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index a6575381878d..5e10a3b8aa58 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -144,13 +144,18 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
 		tmp = rb_entry(node, struct rxe_mcg, node);
 
 		cmp = memcmp(&tmp->mgid, &mcg->mgid, sizeof(mcg->mgid));
-		if (cmp > 0)
+		if (cmp > 0) {
 			link = &(*link)->rb_left;
-		else
+		} else if (cmp < 0) {
 			link = &(*link)->rb_right;
+		} else {
+			/* we must delete the old mcg before adding one */
+			WARN_ON_ONCE(1);
+			return;
+		}
 	}
 
-	rb_link_node(&mcg->node, node, link);
+	rb_link_node_rcu(&mcg->node, node, link);
 	rb_insert_color(&mcg->node, tree);
 }
 
@@ -165,15 +170,11 @@ static void __rxe_remove_mcg(struct rxe_mcg *mcg)
 	rb_erase(&mcg->node, &mcg->rxe->mcg_tree);
 }
 
-/**
- * __rxe_lookup_mcg - lookup mcg in rxe->mcg_tree while holding lock
- * @rxe: rxe device object
- * @mgid: multicast IP address
- *
- * Context: caller must hold rxe->mcg_lock
- * Returns: mcg on success and takes a ref to mcg else NULL
+/*
+ * Lookup mgid in the multicast group red-black tree and try to
+ * get a ref on it. Return mcg on success else NULL.
  */
-static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
 					union ib_gid *mgid)
 {
 	struct rb_root *tree = &rxe->mcg_tree;
@@ -181,7 +182,8 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	struct rb_node *node;
 	int cmp;
 
-	node = tree->rb_node;
+	rcu_read_lock();
+	node = rcu_dereference_raw(tree->rb_node);
 
 	while (node) {
 		mcg = rb_entry(node, struct rxe_mcg, node);
@@ -189,35 +191,14 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 		cmp = memcmp(&mcg->mgid, mgid, sizeof(*mgid));
 
 		if (cmp > 0)
-			node = node->rb_left;
+			node = rcu_dereference_raw(node->rb_left);
 		else if (cmp < 0)
-			node = node->rb_right;
+			node = rcu_dereference_raw(node->rb_right);
 		else
 			break;
 	}
-
-	if (node) {
-		kref_get(&mcg->ref_cnt);
-		return mcg;
-	}
-
-	return NULL;
-}
-
-/**
- * rxe_lookup_mcg - lookup up mcg in red-back tree
- * @rxe: rxe device object
- * @mgid: multicast IP address
- *
- * Returns: mcg if found else NULL
- */
-struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
-{
-	struct rxe_mcg *mcg;
-
-	spin_lock_bh(&rxe->mcg_lock);
-	mcg = __rxe_lookup_mcg(rxe, mgid);
-	spin_unlock_bh(&rxe->mcg_lock);
+	mcg = (node && kref_get_unless_zero(&mcg->ref_cnt)) ? mcg : NULL;
+	rcu_read_unlock();
 
 	return mcg;
 }
@@ -285,7 +266,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 
 	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just added it */
-	tmp = __rxe_lookup_mcg(rxe, mgid);
+	tmp = rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
 		spin_unlock_bh(&rxe->mcg_lock);
 		atomic_dec(&rxe->mcg_num);
@@ -315,7 +296,7 @@ void rxe_cleanup_mcg(struct kref *kref)
 {
 	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
 
-	kfree(mcg);
+	kfree_rcu(mcg, rcu);
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 7be9e6232dd9..8058e5039322 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -345,6 +345,7 @@ struct rxe_mw {
 
 struct rxe_mcg {
 	struct rb_node		node;
+	struct rcu_head		rcu;
 	struct kref		ref_cnt;
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
-- 
2.40.1


