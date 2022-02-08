Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DA74AE3F2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386864AbiBHWY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386881AbiBHVRX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:23 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD196C0612BA
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:22 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso198883ooi.1
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulTF2hxvuEkRlHh2KLWnbeUZj1+dl09v2C4+yKaBJY8=;
        b=MRrj1LnivVzJNwxWl4gmI7zu79uK7gNzcfTtMwf6Dk9jCoiDeld9N7IhgPUbPjSVTF
         9KjFe+ddsNtyZfP5NwvIUQqEtSsFLOKkMwNCxaTIIAyxhv2uTNQ6WXWGwo3j9CIfLxbs
         SbqZX2sUsIP/RIYYZw73AGj44MP19t6u63CvTuZV8SbINOj6sfW2y8aw9dUb1GYek7Zp
         RwWCywTN/AU8D6szzMnOzlC/yM9wZ+iUHTCgWOlsh5ngDrZDAtkO3KAmgrEL2s1/OR5R
         qXLEa1Y67KCppal6IavB0wJSC8rEWbhVvE/ZEcoHPqFzytDJbA44Fve9aDFRNDjWq7lH
         pmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulTF2hxvuEkRlHh2KLWnbeUZj1+dl09v2C4+yKaBJY8=;
        b=FIMomfzM+cRjiKWa6/DJ1ORwWwRcgEE6GLobHQ76MxQ0WOQXmLN0ek26CXVNX9FQru
         0N/1/o/cloK5q5hgeyt9fN3UY6dL/Qjv8L49C1FNbOmHyiLrcpjDzQJ2p7jMoruNor89
         wY8+62AsejtBsSVOfYxnlAJd96nn556WBVUaB8YCH2lJU7M7g+ih+s+imypPb0hgHjrz
         gYVJhu8tb+QDW7by5/8L5/mQuTvdrAx1+AbBrcPCCHlBx9j3u28AfZZPQghLeBX1l5+u
         WfSEqtfZQ0PA9w3B8o4L0ZG44r1TGPS1sCsYwm6FAuX6Gcku16vb2Qd83itklaOucWdS
         a0Gw==
X-Gm-Message-State: AOAM530guGmdbwtxXkPvsAXWlWhNG5KPibrGe97mAbt+KHab5DpwZJbi
        WyU3x2rJrRZFr7x0qb32HiXQEiM786I=
X-Google-Smtp-Source: ABdhPJy61c5SbsTYM+homsrsxlI7Gf1U9RQsU9l9WbU9mLUK2DQ/m4oYR6CLRHFXGVEU2zUei1QwWQ==
X-Received: by 2002:a05:6870:3811:: with SMTP id y17mr1039662oal.318.1644355042062;
        Tue, 08 Feb 2022 13:17:22 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:21 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 08/11] RDMA/rxe: Add code to cleanup mcast memory
Date:   Tue,  8 Feb 2022 15:16:42 -0600
Message-Id: <20220208211644.123457-9-rpearsonhpe@gmail.com>
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

Well behaved applications will free all memory allocated by multicast
but programs which do not clean up properly can leave behind allocated
memory when the rxe driver is unloaded. This patch walks the red-black
tree holding multicast group elements and then walks the list of attached
qp's freeing the mca's and finally the mcg's.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 ++
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mcast.c | 31 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 3520eb2db685..603b0156f889 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -29,6 +29,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
 
+	rxe_cleanup_mcast(rxe);
+
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 409efeecd581..0bc1b7e2877c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -44,6 +44,7 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 void rxe_cleanup_mcg(struct kref *kref);
+void rxe_cleanup_mcast(struct rxe_dev *rxe);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 07c218788c59..846147878607 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -382,3 +382,34 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
 	return rxe_detach_mcg(rxe, qp, mgid);
 }
+
+/**
+ * rxe_cleanup_mcast - cleanup all resources held by mcast
+ * @rxe: rxe object
+ *
+ * Called when rxe device is unloaded. Walk red-black tree to
+ * find all mcg's and then walk mcg->qp_list to find all mca's and
+ * free them. These should have been freed already if apps are
+ * well behaved.
+ */
+void rxe_cleanup_mcast(struct rxe_dev *rxe)
+{
+	struct rb_root *root = &rxe->mcg_tree;
+	struct rb_node *node, *next;
+	struct rxe_mcg *mcg;
+	struct rxe_mca *mca, *tmp;
+
+	for (node = rb_first(root); node; node = next) {
+		next = rb_next(node);
+		mcg = rb_entry(node, typeof(*mcg), node);
+
+		spin_lock_bh(&rxe->mcg_lock);
+		list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list)
+			kfree(mca);
+
+		__rxe_remove_mcg(mcg);
+		spin_unlock_bh(&rxe->mcg_lock);
+
+		kfree(mcg);
+	}
+}
-- 
2.32.0

