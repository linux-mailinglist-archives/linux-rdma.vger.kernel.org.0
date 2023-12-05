Return-Path: <linux-rdma+bounces-253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840BD80435A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8511F21331
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766A5392;
	Tue,  5 Dec 2023 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhmZGWiz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E964FF
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:26:37 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d986a75337so1214979a34.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735996; x=1702340796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj0PU7uEjCTBczW0/yievyQR0AIrXN2P5Hcurk7TtSE=;
        b=dhmZGWizEpgZhq+Htdpurc7DZT1LRh9lX/uiTkMm1V7ZL4JWc+Pvr7wDRvHc5nM8d5
         HDpRsd5YICdGG5oJ5gNZVSiJgGotVpylfP1JHRr9FOj/fLI7FbnllkHpThu6biQLcwmW
         cYnOE29JeW1QDv8XO6vsm7maABGWJFHf61Rh9Id+O3+NSAf73t9ya48EQgSMoVeY7LI8
         +sPUGTb+JEZJMRavDnhWTXwkntC0GQEtJ8fTSTpc+iScFMHWQkeO+nroN2i+JrcTzf/w
         ACxyaC5zHDJHC3qft4wdjXVySAUJ9xGdI53QdWrm7z8ika4vkHr7UFkEHWUkz1U8GCHG
         NkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735996; x=1702340796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj0PU7uEjCTBczW0/yievyQR0AIrXN2P5Hcurk7TtSE=;
        b=uRTjZCJO43osno4iKlwKPV9A0rA8T8CeXrU9G2oH+KoHuTwgw9S3azFv+/TQNAGxIa
         GA2sQNfCVDemy0iMQxEOrpFYSDWr1UZ5vZG6mIdNlZOjToi6MqoM6oRh24J/6WggH2/1
         AHChpNwyubvBFQkYtOGgUnh36F867Eyno61lS6gvbnCKTc9l5ZGP6Wo37KUxbq/xIOlc
         NsNkwtUrEO+doVkOUMKqN6gIJ2zW5f8C7vV6cUSiy3H+iuuPjbQI7uid/bt4p/zP9efv
         jvXHKQXUZJv30LJ80Z3738yKM8uWINm7Z2C2xxc6X5QQi3a0eo22R1qk83jRjrs7lwMa
         7EFg==
X-Gm-Message-State: AOJu0YxiUWQZMFzQLVpj/6XwsqrP9cfpco2NikADynv+1kM5meB8DITK
	ZHvqU/Cd2gqBZCn/JCQujPU=
X-Google-Smtp-Source: AGHT+IEmrDLD3lDXg9MkyEqLEb7IMMTElHH2N53S8C4REFmlmN7GlnsONMC/mQWGSu5Cj1DZx9UbPQ==
X-Received: by 2002:a05:6871:6a9:b0:1fa:e7f8:efd5 with SMTP id l41-20020a05687106a900b001fae7f8efd5mr5695080oao.34.1701735996392;
        Mon, 04 Dec 2023 16:26:36 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id se6-20020a05687122c600b001faf09f0899sm2524844oab.24.2023.12.04.16.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:26:35 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 4/7] RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
Date: Mon,  4 Dec 2023 18:26:11 -0600
Message-Id: <20231205002613.10219-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205002613.10219-1-rpearsonhpe@gmail.com>
References: <20231205002613.10219-1-rpearsonhpe@gmail.com>
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
index 54735d07cee5..44948f9cb02b 100644
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


