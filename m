Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A24AE3E7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386942AbiBHWYk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386878AbiBHVRW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:22 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19225C0612BE
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:21 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso242159oop.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XY3DD4ol7toyhGXGGzuYQIC2OzhUvk7iT9xEabpmvAQ=;
        b=YQjpn/AqWm+OS6T55zkWPUemCV81lvRUofbpg/Er6LbmhXWrLEUAZQvYkKv4yPJYcR
         0YoqOsehVeUXrj9QT8j3qyFeOoiCl8BUPU+NuZZJVLYlu0x0HXTzLh+GunisYXDFzV9+
         KjBthkhPrGZFVwIIJwyvxEs+xOsa9oHyr6zs4zoJhV2n28eqp/4cVuQ21axRUX9d5owl
         Wj4X6RwOoY1AdsDVAIf7Yh8/pek6rvVIpC0xtkhyqVjh4hJND24sbaFo4odqY53qEw+n
         MALNv4hb9gExGmddkX0KG7hnXGqcf/YyiehQDkNdBW/HNaDPLPSHgaXntqM6zW/SwgYd
         Pqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XY3DD4ol7toyhGXGGzuYQIC2OzhUvk7iT9xEabpmvAQ=;
        b=cAnklYGPc4IIDEpGTMawHuWN8IFknUQ2VSjdDWQL410MdL0biGPYE2adZdKNI6g5x5
         MgbCDgIxs/zMGh/ht2alc5Xts1stymbz1ZK3zt0TJ9Pixia+6nuZAtpuAAGLStZpPTTj
         rFfDW5IDsI32E6NvC0VXcW6DGIieLwxYWsQk9kQvjdRD8Y9yuMqefdte3iA8cjrUB+b1
         taQdChjNrMoIoBx31nUE7oG7xHIUuBmlwozIzVMR7kFRvtKPKYPpjiTEhnY1WWTgDGLA
         HOwC139oem3IRgbb4W34Rq8oINHMvG31+tDv69liT5ttYOTTGr0q9C6ktp06IXLHHwGV
         CkOQ==
X-Gm-Message-State: AOAM533zszAWRrMyf/YMuU6CPEq1yPIKJMJ2qmGZZVzL/vfu531neVXf
        hsw+Z8hGk6XTsIPTrTgQoT0rl9PjhLQ=
X-Google-Smtp-Source: ABdhPJyeZWprEeyhm4/q7U9SgwmMygJoxypJE+vae9i4DbIeQ7ikEtFamJZ2DffvMag2j/G4aciYFQ==
X-Received: by 2002:a05:6870:91c6:: with SMTP id c6mr1035039oaf.147.1644355040411;
        Tue, 08 Feb 2022 13:17:20 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:19 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 07/11] RDMA/rxe: Remove mcg from rxe pools
Date:   Tue,  8 Feb 2022 15:16:41 -0600
Message-Id: <20220208211644.123457-8-rpearsonhpe@gmail.com>
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

Finish removing mcg from rxe pools. Replace rxe pools ref counting by
kref's. Replace rxe_alloc by kzalloc.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  8 ------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 39 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  9 -------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 -
 drivers/infiniband/sw/rxe/rxe_recv.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 7 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index dc36148272dd..3520eb2db685 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -28,7 +28,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->cq_pool);
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
-	rxe_pool_cleanup(&rxe->mc_grp_pool);
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
@@ -157,15 +156,8 @@ static int rxe_init_pools(struct rxe_dev *rxe)
 	if (err)
 		goto err8;
 
-	err = rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
-			    rxe->attr.max_mcast_grp);
-	if (err)
-		goto err9;
-
 	return 0;
 
-err9:
-	rxe_pool_cleanup(&rxe->mw_pool);
 err8:
 	rxe_pool_cleanup(&rxe->mr_pool);
 err7:
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index d41831878fa6..409efeecd581 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -43,7 +43,7 @@ void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
-void rxe_mc_cleanup(struct rxe_pool_elem *elem);
+void rxe_cleanup_mcg(struct kref *kref);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 78d696cd40d5..07c218788c59 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -98,7 +98,7 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 	}
 
 	if (node) {
-		rxe_add_ref(mcg);
+		kref_get(&mcg->ref_cnt);
 		return mcg;
 	}
 
@@ -141,6 +141,7 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	if (unlikely(err))
 		return err;
 
+	kref_init(&mcg->ref_cnt);
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
@@ -152,7 +153,7 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	 * Inserting mcg makes it visible to outside so this should
 	 * be done last after the object is ready.
 	 */
-	rxe_add_ref(mcg);
+	kref_get(&mcg->ref_cnt);
 	__rxe_insert_mcg(mcg);
 
 	return 0;
@@ -167,7 +168,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
  */
 static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	struct rxe_pool *pool = &rxe->mc_grp_pool;
 	struct rxe_mcg *mcg, *tmp;
 	int err;
 
@@ -180,7 +180,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 		return mcg;
 
 	/* speculative alloc of new mcg */
-	mcg = rxe_alloc(pool);
+	mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
 	if (!mcg)
 		return ERR_PTR(-ENOMEM);
 
@@ -188,7 +188,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	/* re-check to see if someone else just added it */
 	tmp = __rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
-		rxe_drop_ref(mcg);
+		kfree(mcg);
 		mcg = tmp;
 		goto out;
 	}
@@ -208,10 +208,21 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 err_dec:
 	atomic_dec(&rxe->mcg_num);
 	spin_unlock_bh(&rxe->mcg_lock);
-	rxe_drop_ref(mcg);
+	kfree(mcg);
 	return ERR_PTR(err);
 }
 
+/**
+ * rxe_cleanup_mcg - cleanup mcg for kref_put
+ * @kref:
+ */
+void rxe_cleanup_mcg(struct kref *kref)
+{
+	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
+
+	kfree(mcg);
+}
+
 /**
  * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_lock
  * @mcg: the mcg object
@@ -221,11 +232,14 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
  */
 static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
+	struct rxe_dev *rxe = mcg->rxe;
+
 	/* remove mcg from red-black tree then drop ref */
 	__rxe_remove_mcg(mcg);
-	rxe_drop_ref(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
 	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
+	atomic_dec(&rxe->mcg_num);
 }
 
 /**
@@ -241,11 +255,6 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 	spin_unlock_bh(&mcg->rxe->mcg_lock);
 }
 
-void rxe_mc_cleanup(struct rxe_pool_elem *elem)
-{
-	/* nothing left to do for now */
-}
-
 static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 				  struct rxe_mcg *mcg)
 {
@@ -328,7 +337,7 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 			/* drop the ref from get key. This will free the
 			 * object if qp_num is zero.
 			 */
-			rxe_drop_ref(mcg);
+			kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 			kfree(mca);
 			err = 0;
 			goto out_unlock;
@@ -336,7 +345,7 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 
 	/* we didn't find the qp on the list */
-	rxe_drop_ref(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 	err = -EINVAL;
 
 out_unlock:
@@ -362,7 +371,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (atomic_read(&mcg->qp_num) == 0)
 		rxe_destroy_mcg(mcg);
 
-	rxe_drop_ref(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 	return err;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 49a25f8ceae1..b6fe7c93aaab 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -79,15 +79,6 @@ static const struct rxe_type_info {
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
-	[RXE_TYPE_MC_GRP] = {
-		.name		= "rxe-mc_grp",
-		.size		= sizeof(struct rxe_mcg),
-		.elem_offset	= offsetof(struct rxe_mcg, elem),
-		.cleanup	= rxe_mc_cleanup,
-		.flags		= RXE_POOL_KEY,
-		.key_offset	= offsetof(struct rxe_mcg, mgid),
-		.key_size	= sizeof(union ib_gid),
-	},
 };
 
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 2db9d9872cd1..8fc95c6b7b9b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -21,7 +21,6 @@ enum rxe_elem_type {
 	RXE_TYPE_CQ,
 	RXE_TYPE_MR,
 	RXE_TYPE_MW,
-	RXE_TYPE_MC_GRP,
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index fb265902f7e3..53924453abef 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -300,7 +300,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	spin_unlock_bh(&rxe->mcg_lock);
 
-	rxe_drop_ref(mcg);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
 	if (likely(!skb))
 		return;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index caa5b1b05019..20fe3ee6589d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -352,8 +352,8 @@ struct rxe_mw {
 };
 
 struct rxe_mcg {
-	struct rxe_pool_elem	elem;
 	struct rb_node		node;
+	struct kref		ref_cnt;
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	union ib_gid		mgid;
-- 
2.32.0

