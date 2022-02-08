Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F54AE3F1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387548AbiBHWYy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386888AbiBHVR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:26 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B226C0612BE
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:25 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so189465oov.3
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04OBAbMZdx8m+LUHoCK8AJ7Vdo9yDfZsBItW/wXTXIA=;
        b=Y00SPhT9fdH5mPtMqsTpKlg8nluFKCJ3eosVeKArhbKBSpIgnh4AI8HSj48I1rKFr/
         MdCEG/E0FHlE5XLXGh1qeagtaKtFK5kybfnk2hlqZtyesnd0rtUohnRKZBfRizio0U8A
         BfIZXxGy/W/hKLnVGv5eCN993t89mD8gmWwWhdqu14H9bSKvbzDBMSqv8EbNUtlJi00g
         jNi/QHJWNfUaMCfj2/V0hxhSx1NL2c5qwLah9MVoKRlwqy9a/JuzOK7XmPRLoJwYP5fH
         q9DCHKDmcxar7SFM6UQwOnOC1gjyANn5G+nQW/ebxOXFz+nzvECG9npfJUXOxlHTGuMI
         4PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04OBAbMZdx8m+LUHoCK8AJ7Vdo9yDfZsBItW/wXTXIA=;
        b=zeuikrqjQKqkLm4zdIvtZyLfF7lhTrsG3ZJSER8NekjQTjFonYRWDdijt84k4MAMRX
         tXq7jp3NEexryDYlcLzY9WxTNBnhsxQhA+EEobsXbwyJD8GVXcjT2VL5t2n6NX/OZxHD
         kfZskUjE3mrAKFSxXZs7uzI1uGeDPpuJbaBimGccZslcNUtengbX4D+BVBX6fXKrBjK+
         amb+p1zfbyC23trPOD1G32tngJS99d1fn2ALCvzFg55Ld/T4hjdR9zVAi3uP3HNu3dRy
         gE8t0YiNqP5m7j2jMWvLfPnlgP+PSkTkXFHEaWg+7NxuliuN/iJgacXPO/f7W/PvdiXO
         QU+Q==
X-Gm-Message-State: AOAM532ekqF6W6fcBv3L7k7yd5VpgklCmIOdcZTXh+W9u/J1njDHVxM3
        QLhTymqc332/oGGwg/nNEMs=
X-Google-Smtp-Source: ABdhPJyaIih8im86GsDGoIT6a//gvhOZxPLCxt9ZFbuWbiQANZT4gwDqvaqh95eXOs505YZ2gAtlNw==
X-Received: by 2002:a05:6870:111a:: with SMTP id 26mr705334oaf.142.1644355044747;
        Tue, 08 Feb 2022 13:17:24 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:24 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 11/11] RDMA/rxe: Convert mca read locking to RCU
Date:   Tue,  8 Feb 2022 15:16:45 -0600
Message-Id: <20220208211644.123457-12-rpearsonhpe@gmail.com>
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

Replace spinlock with rcu read locks for read side operations
on mca in rxe_recv.c and rxe_mcast.c. Use rcu list extensions on
write side operations and use spinlock to separate write threads.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 73 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +--
 2 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index b66839276aa6..19cfa06c62ec 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -17,6 +17,12 @@
  * mca is created. It holds a pointer to the qp and is added to a list
  * of qp's that are attached to the mcg. The qp_list is used to replicate
  * mcast packets in the rxe receive path.
+ *
+ * The highest performance operations are mca list traversal when
+ * processing incoming multicast packets which need to be fanned out
+ * to the attached qp's. This list is protected by RCU locking for read
+ * operations and a spinlock in the rxe_dev struct for write operations.
+ * The red-black tree is protected by the same spinlock.
  */
 
 #include "rxe.h"
@@ -284,7 +290,7 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 }
 
 /**
- * __rxe_init_mca - initialize a new mca holding lock
+ * __rxe_init_mca_rcu - initialize a new mca holding lock
  * @qp: qp object
  * @mcg: mcg object
  * @mca: empty space for new mca
@@ -294,8 +300,8 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
  *
  * Returns: 0 on success else an error
  */
-static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
-			  struct rxe_mca *mca)
+static int __rxe_init_mca_rcu(struct rxe_qp *qp, struct rxe_mcg *mcg,
+			      struct rxe_mca *mca)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	int n;
@@ -318,7 +324,7 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
 	rxe_add_ref(qp);
 	mca->qp = qp;
 
-	list_add_tail(&mca->qp_list, &mcg->qp_list);
+	list_add_tail_rcu(&mca->qp_list, &mcg->qp_list);
 
 	return 0;
 }
@@ -338,14 +344,14 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	int err;
 
 	/* check to see if the qp is already a member of the group */
-	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_bh(&rxe->mcg_lock);
+			rcu_read_unlock();
 			return 0;
 		}
 	}
-	spin_unlock_bh(&rxe->mcg_lock);
+	rcu_read_unlock();
 
 	/* speculative alloc new mca without using GFP_ATOMIC */
 	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
@@ -362,7 +368,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 		}
 	}
 
-	err = __rxe_init_mca(qp, mcg, mca);
+	err = __rxe_init_mca_rcu(qp, mcg, mca);
 	if (err)
 		kfree(mca);
 out:
@@ -371,22 +377,22 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 }
 
 /**
- * __rxe_cleanup_mca - cleanup mca object holding lock
+ * __rxe_cleanup_mca_rcu - cleanup mca object holding lock
  * @mca: mca object
  * @mcg: mcg object
  *
  * Context: caller must hold a reference to mcg and rxe->mcg_lock
  */
-static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
+static void __rxe_cleanup_mca_rcu(struct rxe_mca *mca, struct rxe_mcg *mcg)
 {
-	list_del(&mca->qp_list);
+	list_del_rcu(&mca->qp_list);
 
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
 	atomic_dec(&mca->qp->mcg_num);
 	rxe_drop_ref(mca->qp);
 
-	kfree(mca);
+	kfree_rcu(mca);
 }
 
 /**
@@ -399,30 +405,35 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
-	struct rxe_mca *mca, *tmp;
+	struct rxe_mca *mca;
+	int ret;
 
 	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
-		if (mca->qp == qp) {
-			__rxe_cleanup_mca(mca, mcg);
-
-			/* if the number of qp's attached to the
-			 * mcast group falls to zero go ahead and
-			 * tear it down. This will not free the
-			 * object since we are still holding a ref
-			 * from the caller
-			 */
-			if (atomic_read(&mcg->qp_num) <= 0)
-				__rxe_destroy_mcg(mcg);
-
-			spin_unlock_bh(&rxe->mcg_lock);
-			return 0;
-		}
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
+		if (mca->qp == qp)
+			goto found;
 	}
 
 	/* we didn't find the qp on the list */
+	ret = -EINVAL;
+	goto done;
+
+found:
+	__rxe_cleanup_mca_rcu(mca, mcg);
+
+	/* if the number of qp's attached to the
+	 * mcast group falls to zero go ahead and
+	 * tear it down. This will not free the
+	 * object since we are still holding a ref
+	 * from the caller
+	 */
+	if (atomic_read(&mcg->qp_num) <= 0)
+		__rxe_destroy_mcg(mcg);
+
+	ret = 0;
+done:
 	spin_unlock_bh(&rxe->mcg_lock);
-	return -EINVAL;
+	return ret;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 9b21cbb22602..c2cab85c6576 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -265,15 +265,15 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
 	n = 0;
 
-	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		/* protect the qp pointers in the list */
 		rxe_add_ref(mca->qp);
 		qp_array[n++] = mca->qp;
 		if (n == nmax)
 			break;
 	}
-	spin_unlock_bh(&rxe->mcg_lock);
+	rcu_read_unlock();
 	nmax = n;
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
-- 
2.32.0

