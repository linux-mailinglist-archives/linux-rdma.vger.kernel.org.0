Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652B4AE3EC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387539AbiBHWYm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386860AbiBHVRR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:17 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E53C0612BA
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:15 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id y23so398393oia.13
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VebRPvsPxA5BA5urDmgWLzjvmvNxF11B7f0mE7t7dCk=;
        b=mTSEB8/d0Rk5GJshCH3CBxUyfUoRunLto9Awx5Yv2gSA996BJ8Ljo4ct1eNoJ2jSY8
         HA2CqsN2VWGygLIfU+G2+kS/zwYeHCYZJCoCH3roX6ct7zXWPKnkaJoRY6ZrqmK6BMT2
         042gHa/3rAETsUN4o8eUKmt0mZMVGWfvvvEITnMMpM1PIMnGWNW1BMSdFvA0EmR01oPA
         ZvgVn3wZWiPwh5RNioO15U/kXm0x3FZLFv59UFcP2hRYoN1KWXz0nv+WN+OY9JqGzP8Q
         k80dC8/8axDfEhKc73+9tuFLP0+lJcaslj3tUCOOPT1SQMlSmHKR1Fb0FeVLfvek0u5E
         HkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VebRPvsPxA5BA5urDmgWLzjvmvNxF11B7f0mE7t7dCk=;
        b=6WvNUFRKfdut0CzUCk4fhKdwtElRmo/7GOe2kTBi6gFygV96yusugHLNSfkv6/w7tP
         QiKVm00Witk4Gn5Jysc3k4QcRqcgpejRZXoJfIEAxfqPsFBnJ1oGj88J51BOMaSpyckC
         pstcJqBO8wGoSKLzZV0N1VxZz0K1pSjwVOktmPoLdvcHU2G+eMrmZISpsH9aAR/FxFh/
         kdGaLc6hpYEA6d4TTVXNKTd4zaQpHUW6WNzV1A0TSPkF03fhdf6ECoRdcGw2EtFRdgf4
         eIeNUNoVSAGmK0AeiDADGmADDJ7wK352ZMHKgKBCXRC080D2Qgwsb48TmER6wNRbFVYf
         G38g==
X-Gm-Message-State: AOAM5339SQmpvxLJ5mb93K6HIyGDK9r0glUxJibqyN+lxIQlyoU8br1k
        PPZkfqEo6qP4ISWeRGHSoWk=
X-Google-Smtp-Source: ABdhPJxAKCDQWuZpABpSG0Uu0IZxzMg29gQ8NzF7/4Bt8T6D4/H3ndCeU4KkVdudU9HC/HX8isXeIA==
X-Received: by 2002:a05:6808:9b3:: with SMTP id e19mr1536102oig.90.1644355034959;
        Tue, 08 Feb 2022 13:17:14 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:14 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 01/11] RDMA/rxe: Move mcg_lock to rxe
Date:   Tue,  8 Feb 2022 15:16:35 -0600
Message-Id: <20220208211644.123457-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208211644.123457-1-rpearsonhpe@gmail.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace mcg->mcg_lock and mc_grp_pool->pool_lock by rxe->mcg_lock.
This is the first step of several intended to decouple the mc_grp
and mc_elem objects from the rxe pool code.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 ++
 drivers/infiniband/sw/rxe/rxe_mcast.c | 19 +++++++++----------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ++-
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index fab291245366..e74c4216b314 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -211,6 +211,8 @@ static int rxe_init(struct rxe_dev *rxe)
 	spin_lock_init(&rxe->pending_lock);
 	INIT_LIST_HEAD(&rxe->pending_mmaps);
 
+	spin_lock_init(&rxe->mcg_lock);
+
 	mutex_init(&rxe->usdev_lock);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 9336295c4ee2..4828274efbd4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -25,7 +25,7 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
-/* caller should hold mc_grp_pool->pool_lock */
+/* caller should hold rxe->mcg_lock */
 static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
 				     struct rxe_pool *pool,
 				     union ib_gid *mgid)
@@ -38,7 +38,6 @@ static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&grp->qp_list);
-	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
 	rxe_add_key_locked(grp, mgid);
 
@@ -62,7 +61,7 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	if (rxe->attr.max_mcast_qp_attach == 0)
 		return -EINVAL;
 
-	write_lock_bh(&pool->pool_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 
 	grp = rxe_pool_get_key_locked(pool, mgid);
 	if (grp)
@@ -70,13 +69,13 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	grp = create_grp(rxe, pool, mgid);
 	if (IS_ERR(grp)) {
-		write_unlock_bh(&pool->pool_lock);
+		spin_unlock_bh(&rxe->mcg_lock);
 		err = PTR_ERR(grp);
 		return err;
 	}
 
 done:
-	write_unlock_bh(&pool->pool_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	*grp_p = grp;
 	return 0;
 }
@@ -88,7 +87,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	struct rxe_mca *elem;
 
 	/* check to see of the qp is already a member of the group */
-	spin_lock_bh(&grp->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry(elem, &grp->qp_list, qp_list) {
 		if (elem->qp == qp) {
 			err = 0;
@@ -118,7 +117,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	err = 0;
 out:
-	spin_unlock_bh(&grp->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return err;
 }
 
@@ -132,7 +131,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	if (!grp)
 		goto err1;
 
-	spin_lock_bh(&grp->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 
 	list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
 		if (elem->qp == qp) {
@@ -140,7 +139,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			grp->num_qp--;
 			atomic_dec(&qp->mcg_num);
 
-			spin_unlock_bh(&grp->mcg_lock);
+			spin_unlock_bh(&rxe->mcg_lock);
 			rxe_drop_ref(elem);
 			rxe_drop_ref(grp);	/* ref held by QP */
 			rxe_drop_ref(grp);	/* ref from get_key */
@@ -148,7 +147,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	spin_unlock_bh(&grp->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	rxe_drop_ref(grp);			/* ref from get_key */
 err1:
 	return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 7ff6b53555f4..a084b5d69937 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -250,7 +250,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	if (!mcg)
 		goto drop;	/* mcast group not registered */
 
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 
 	/* this is unreliable datagram service so we let
 	 * failures to deliver a multicast packet to a
@@ -298,7 +298,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		}
 	}
 
-	spin_unlock_bh(&mcg->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 
 	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 55f8ed2bc621..9940c69cbb63 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -353,7 +353,6 @@ struct rxe_mw {
 
 struct rxe_mcg {
 	struct rxe_pool_elem	elem;
-	spinlock_t		mcg_lock; /* guard group */
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	union ib_gid		mgid;
@@ -399,6 +398,8 @@ struct rxe_dev {
 	struct rxe_pool		mc_grp_pool;
 	struct rxe_pool		mc_elem_pool;
 
+	spinlock_t		mcg_lock;
+
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
 
-- 
2.32.0

