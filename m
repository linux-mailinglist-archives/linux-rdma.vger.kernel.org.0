Return-Path: <linux-rdma+bounces-321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0DF809155
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 20:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD231F2112F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380950255;
	Thu,  7 Dec 2023 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egFRhdgo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356C10DC;
	Thu,  7 Dec 2023 11:30:20 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1eb39505ba4so807321fac.0;
        Thu, 07 Dec 2023 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701977419; x=1702582219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltRshs1fvRyryntixBOeAHNaaxz9f8ewSjKaE4jwwUs=;
        b=egFRhdgoVxgsR+6s3HM9/A/vWAbjMjRdKXVAxItUPDEgj9k/u723eVrts1k6qYYYZm
         fkB0mC17WM2W/YU/PfTo5CdKzI+8Bc6NS6qR6e29M4fdeTKXu6AjNC4up7y4yi23wQCU
         iGW+l/AwVmhJIJ2EQGnBEe5NXjgdeALB7yrs4164d8iYRc1nseBRxvX+1/BQPzjtufJD
         wKV94jPnO6blAdah8goJBeurGHRQ9PtpA1Oca+HMXSTV/4nCfIoWaxTVzVhzLvnxFlNw
         KrdbEsj00Ql3dn3neyrp0nuNjDHv/LzGqrXSK53mLQa569Ik+zX8A56UQBC+a/3fKj4R
         xExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977419; x=1702582219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltRshs1fvRyryntixBOeAHNaaxz9f8ewSjKaE4jwwUs=;
        b=oWFEfLJ8ctSOBDRuKSR7ok3P41X+1hpCSAD5lg6krf5aueoh5wjCOLrfspoVWyWTJe
         rlgmxtMJqzt2BLoA/Uh8Gzp77LOrx3Ypd2659KE8yKxSw78KfbK/l0kKX0ZV3OcWoEaV
         9nsS7b0b5Empsk7L5Wyo2kW1fEHbT6r0umaeubKIes5dLXteOyKR2BH1XhgkoElgN2WZ
         BFjI198/b5gN4eSuGH/qlq6ZX9AFgbtB9ZTrgd7lYRNgYmEdc1qbuu5hgnLKU6WIMy2X
         skXzB60tbjeaZN7Ku+LyAKooeNc3pePHEum/+9S7byuAssfEyH+0/3smV3UQQq18ZqUI
         0ubw==
X-Gm-Message-State: AOJu0Yw3Dts0Remxr5ExlEb73hZhH4MLiVfw3urJoOUy0OZH//nhNHKw
	26GTYVvP9IKu1k37LzPGBwE=
X-Google-Smtp-Source: AGHT+IFNTI6DyZUNhTkN7GjIBXcmYRmsB7fKUY9AWEov8yNijYDJ3cQ8oXlWm9jDmh9SDSLAFuKR3A==
X-Received: by 2002:a05:6870:818d:b0:1fb:75b:99b0 with SMTP id k13-20020a056870818d00b001fb075b99b0mr3311898oae.95.1701977419502;
        Thu, 07 Dec 2023 11:30:19 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-ca1f-53fd-59c8-8b84.res6.spectrum.com. [2603:8081:1405:679b:ca1f:53fd:59c8:8b84])
        by smtp.gmail.com with ESMTPSA id mp23-20020a056871329700b001fb634b546dsm92347oac.14.2023.12.07.11.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:30:19 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	rain.1986.08.12@gmail.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 4/7] RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
Date: Thu,  7 Dec 2023 13:29:05 -0600
Message-Id: <20231207192907.10113-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207192907.10113-1-rpearsonhpe@gmail.com>
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
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
index 5236761892dd..315e7615e6a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -151,13 +151,18 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
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
 
@@ -172,15 +177,11 @@ static void __rxe_remove_mcg(struct rxe_mcg *mcg)
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
@@ -188,7 +189,8 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	struct rb_node *node;
 	int cmp;
 
-	node = tree->rb_node;
+	rcu_read_lock();
+	node = rcu_dereference_raw(tree->rb_node);
 
 	while (node) {
 		mcg = rb_entry(node, struct rxe_mcg, node);
@@ -196,35 +198,14 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
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
@@ -292,7 +273,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 
 	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just added it */
-	tmp = __rxe_lookup_mcg(rxe, mgid);
+	tmp = rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
 		spin_unlock_bh(&rxe->mcg_lock);
 		atomic_dec(&rxe->mcg_num);
@@ -322,7 +303,7 @@ void rxe_cleanup_mcg(struct kref *kref)
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


