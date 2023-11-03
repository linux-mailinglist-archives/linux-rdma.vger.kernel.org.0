Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828FA7E0A74
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjKCUoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 16:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKCUoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 16:44:06 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47BAD53
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 13:44:03 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce532451c7so1365195a34.2
        for <linux-rdma@vger.kernel.org>; Fri, 03 Nov 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044243; x=1699649043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Euuk1CoKdsLX4uJckCJJnbeWBSM5LTqAOY/mINYTWMU=;
        b=OycQNzNFakPjq4Gyae2o/LL2diUQIarcINS5zILDTiOXGeV+XkcCIU09gRiHdbLfmo
         pdpC5qQ95jIj8QLZgYD5T8SY5EM1Vl5TUIeBkyBUAX7P2Gk8pwm8AIsDsCGIrIZFlq2c
         XmOZ8wqzg9L/fplRyXLJDxxkcSvxvoUB4uRicQaBm+jbTfortZTmQqpmxxBK2zM7jEIm
         bntaYT3gr8yQIFmwiU5YSM0fm8uXFUrafXNJggQCE72wjaV6qUnG3Qj4G90Vm0UIh0C5
         3MdGrawA9LAmalez1XN0wer+CiF3dM3sjpy6EHFzveEHwbyjdeANgJq+YehVtlt7c0F8
         uuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044243; x=1699649043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Euuk1CoKdsLX4uJckCJJnbeWBSM5LTqAOY/mINYTWMU=;
        b=CQywwFIsufftG+/SXYJTEa2ZNL31Xp6POfMKqk/b2JYINxWHQjI0CvVJ8/ms7rWFx1
         H0sqUddi2g2BZxvG0QbQ57qWspbaNnWkw6WyXa67FkAD/BBpyuZJa2PAn315zcUEyWPf
         3jx8N9rsBbE24InLFOB+3Z8tt1WZz7S9c0GGHfZ7+wWGQOq/h66KIMpF5rOeQGAR5MPx
         DmkmeZARpSf1prDDF/4D8zAh1lQo9Nuq0lBLF6sRUhMCusJxG5CcAJwvUH4eDq5gjCLh
         b3xHKK0+ETkP/gQ1jKVMBt0jzJplN8MQuX/hDxttWdmqMEcP+C0R6trbX1CBFXnIcDpq
         jk5A==
X-Gm-Message-State: AOJu0YzU9lycmnQIye2eaKSJ0/O3uwxMBHuVoi2wBF07vzeJBNx/gKke
        2q4f++HXhrlu0pkqBNaudv289c/1Td06Rg==
X-Google-Smtp-Source: AGHT+IFXnBgBgsSDPHB9xS+Xcyn7BwhgM5Twm49UF0UP/V42cJEfpwPQGtsBEswNk66PXweC0v1n3A==
X-Received: by 2002:a9d:6390:0:b0:6d3:1e5a:d928 with SMTP id w16-20020a9d6390000000b006d31e5ad928mr8616796otk.9.1699044243039;
        Fri, 03 Nov 2023 13:44:03 -0700 (PDT)
Received: from bob-3900x.lan (2603-8081-1405-679b-6bc0-11b9-c519-2c18.res6.spectrum.com. [2603:8081:1405:679b:6bc0:11b9:c519:2c18])
        by smtp.gmail.com with ESMTPSA id v9-20020a4ae049000000b00581e5b78ce5sm447766oos.38.2023.11.03.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:44:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/6] RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
Date:   Fri,  3 Nov 2023 15:43:23 -0500
Message-Id: <20231103204324.9606-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231103204324.9606-1-rpearsonhpe@gmail.com>
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
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

Change locking of read side operations of the multicast group
red-black tree to use rcu read locking. This will allow changing
the mcast lock in the next patch to be changed to a mutex without
breaking rxe_recv.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 35 +++++++--------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index ec757b955979..d7b8e31ab480 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -148,7 +148,7 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
 			link = &(*link)->rb_right;
 	}
 
-	rb_link_node(&mcg->node, node, link);
+	rb_link_node_rcu(&mcg->node, node, link);
 	rb_insert_color(&mcg->node, tree);
 }
 
@@ -164,14 +164,13 @@ static void __rxe_remove_mcg(struct rxe_mcg *mcg)
 }
 
 /**
- * __rxe_lookup_mcg - lookup mcg in rxe->mcg_tree while holding lock
+ * rxe_lookup_mcg - lookup mcg in rxe->mcg_tree while holding lock
  * @rxe: rxe device object
  * @mgid: multicast IP address
  *
- * Context: caller must hold rxe->mcg_lock
  * Returns: mcg on success and takes a ref to mcg else NULL
  */
-static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
 					union ib_gid *mgid)
 {
 	struct rb_root *tree = &rxe->mcg_tree;
@@ -179,7 +178,8 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	struct rb_node *node;
 	int cmp;
 
-	node = tree->rb_node;
+	rcu_read_lock();
+	node = rcu_dereference_raw(tree->rb_node);
 
 	while (node) {
 		mcg = rb_entry(node, struct rxe_mcg, node);
@@ -187,12 +187,13 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
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
+	rcu_read_unlock();
 
 	if (node) {
 		kref_get(&mcg->ref_cnt);
@@ -202,24 +203,6 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	return NULL;
 }
 
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
-
-	return mcg;
-}
-
 /**
  * __rxe_init_mcg - initialize a new mcg
  * @rxe: rxe device
@@ -313,7 +296,7 @@ void rxe_cleanup_mcg(struct kref *kref)
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

