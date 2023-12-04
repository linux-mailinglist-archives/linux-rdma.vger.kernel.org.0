Return-Path: <linux-rdma+bounces-232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EF803EF4
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 21:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2631F2119B
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188833CC3;
	Mon,  4 Dec 2023 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXR+SAnh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E465CE
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 12:04:13 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b8952b8066so1606238b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720252; x=1702325052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC0+7mYwsAJlvO0RRjM9AEB9idiTbfTQVsPoxJjjCK4=;
        b=cXR+SAnhLer1YRs720WcTtG6mth/KGdt+DYJWhGnUrkZsdgjsxfgLHQuw7pOKxBxHy
         Ywpcl7U9/2+RFbJdi2iNhW0gU8CtWkO7Pv9LA5cH1LCGVbw9KYoCwvgaqfDjh39QOfIT
         J5AgpN9EsGx+aaB4ceijU2LfgSPPM+LC7rTghMwlpGE6Tfs+VHXvXNIIness3FUhE8wG
         oSuOUOCzyaVAcOYoeUMW4Hu05k7hv4ibn0soQVxtvbBDEhCjK1i2u/ZmZqk887t4pvI2
         M55Eyrw1rtGnslqdMc+FhgVE7eM6ZwM4sWeYxeHn7m2micgNCcCBA6wushxIRxZHkmSU
         4J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720252; x=1702325052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC0+7mYwsAJlvO0RRjM9AEB9idiTbfTQVsPoxJjjCK4=;
        b=qzWX2hSNgeKoDeptWHQ5zf2sT8zfYKrjd54fpBtKg/cBHmh6wAPH7pX/Wq2qPPawfJ
         z7G/vJfns878ODMgBAjFsptjQFpOBhh+jwE60wnmNyeDKjlTEAOn/lATy+DslpBaOhXh
         6OWGjJavN6blVUTQu9S55QtzFN0lUh6wDGLhWS9x22jlWkA9Mv4YV1D9Djc9cTZ9XCud
         no3CWr5mn68NEdbhkmDLyZpjpfUOr/JcHIlYOFTarFcp6Kv2+hwO3hRG2yjVEUmeQ4W+
         iJrbUrudpyiClOjvJVI4XGCsafvZxhxu+D04yN1xecCjPrFd3q2kB90saZxOUKOp5wYz
         tIog==
X-Gm-Message-State: AOJu0Yx6MlTWb1njejjSHDwnKTe8IJYXilUmQEAUraSbQSTIhqMJ31J6
	9DNT0b33mdcuotXfoPuYJVY=
X-Google-Smtp-Source: AGHT+IHeNCzltb1TSwKHle77odLJ2CqRu4WOxxNxJmkXGkNsg2u5RjK9hDEqEupl37MRYHVccOjsaQ==
X-Received: by 2002:a05:6808:3a6:b0:3b8:b06b:97fb with SMTP id n6-20020a05680803a600b003b8b06b97fbmr150088oie.43.1701720252609;
        Mon, 04 Dec 2023 12:04:12 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id e72-20020a4a554b000000b0054f85f67f31sm537281oob.46.2023.12.04.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:04:12 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 4/7] RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
Date: Mon,  4 Dec 2023 14:03:40 -0600
Message-Id: <20231204200342.7125-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204200342.7125-1-rpearsonhpe@gmail.com>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
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
index 40c69642a66c..428ecc510fdd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -149,13 +149,18 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
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
 
@@ -170,15 +175,11 @@ static void __rxe_remove_mcg(struct rxe_mcg *mcg)
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
@@ -186,7 +187,8 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	struct rb_node *node;
 	int cmp;
 
-	node = tree->rb_node;
+	rcu_read_lock();
+	node = rcu_dereference_raw(tree->rb_node);
 
 	while (node) {
 		mcg = rb_entry(node, struct rxe_mcg, node);
@@ -194,35 +196,14 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
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
@@ -290,7 +271,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 
 	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just added it */
-	tmp = __rxe_lookup_mcg(rxe, mgid);
+	tmp = rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
 		spin_unlock_bh(&rxe->mcg_lock);
 		atomic_dec(&rxe->mcg_num);
@@ -320,7 +301,7 @@ void rxe_cleanup_mcg(struct kref *kref)
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


