Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACE7E28B2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 16:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKFPaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 10:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjKFPaB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 10:30:01 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20B13E
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 07:29:54 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso2883082fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Nov 2023 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284593; x=1699889393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB46h1qQvGrP3T4J5+qBSgGcpfSh92PG6l8mrznpKt4=;
        b=c166Xx+cZ9Qn3nLGP4umbwH7mi3BlHc9jXl1sO4HSUy6MinD350tzMhZdS7hIFL1k8
         pAv4PB/iVqm1plQMebzAtdiaDZBoVLxN6Au41cfRsrbySKluEpNYtt19GVTTJhDCWntG
         4OA25ID8QqYCOvp4qbSQnyXqm7DOz8VH2z70k/dR8v7JqFMzIn0HC5/lxRt7HuP3k4GH
         8Sa9H5s3uNedYmcndqfiLLvBwTBdJGA+g3M1VWojJ/Y/JXdVAgbXQm/m0EmfyTtWfXhf
         Awhj5+yByejt4y3bNqQ18B8GuVM+0njIEg0rbemW5Rx9v9OwKuK422gzAOU5+Qzz1NSE
         Jo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284593; x=1699889393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB46h1qQvGrP3T4J5+qBSgGcpfSh92PG6l8mrznpKt4=;
        b=sDKhE74Z1lW77exWJroVO2NWdb0rBPBQRExb+E7nYMVjXj+JgpL2ooPdiLI6dyEGA+
         i/EWxhGJfCZabgTITqNDRXVUsisRyDfe8wgJlh2xbMB5TAQ/7KU/5gy6Fi45yLSbkLvA
         nm7qbj5N9ioF8h1MSf9ktOexIXHwxruv/3RhyUFYuVq2wKdzp8E+rcrnQcO/Va3xJTHi
         PfpPI3a7ffbPY08oZUrm9fRZGxKEMOw/3lEN44F0PQYqlTOAEPIfrDDJ9JF3umN+XDOl
         99nQGCpV13mUdUW7yAV7kXEQsib6Qtes83phDTlLz/k/ECUxZcvi9+pc1zTxgUgMVj4i
         Zi0A==
X-Gm-Message-State: AOJu0Ywt7ZlMJ4HDiHx5VMJ6cFh1BEYtMDQAx57yR88/dwFSTHKhVYpy
        Q4PKk3KFXysqaGvp+347Gek=
X-Google-Smtp-Source: AGHT+IEH6McakbWWHibS87QpDYfc+ZcRo29y9oCIF27ECxiG8dDI2OgdTXHJnAkZBx5FZYGwv6KJsQ==
X-Received: by 2002:a05:6870:2a41:b0:1ea:e7e9:abc5 with SMTP id jd1-20020a0568702a4100b001eae7e9abc5mr27669oab.6.1699284593320;
        Mon, 06 Nov 2023 07:29:53 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-7d5a-f32b-d7fe-f16c.res6.spectrum.com. [2603:8081:1405:679b:7d5a:f32b:d7fe:f16c])
        by smtp.gmail.com with ESMTPSA id ds50-20020a0568705b3200b001e578de89cesm1438897oab.37.2023.11.06.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:29:52 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 4/6] RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
Date:   Mon,  6 Nov 2023 09:29:27 -0600
Message-Id: <20231106152928.47869-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106152928.47869-1-rpearsonhpe@gmail.com>
References: <20231106152928.47869-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

