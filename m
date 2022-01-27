Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20ED49ED8A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiA0ViS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbiA0ViR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:17 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418FC061747
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:16 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u129so8536609oib.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKNe5f1UiRXo4zGBhN7dw31pRci+hLgKcAj+G8bW8o4=;
        b=CyK8NNhe8SxICIU0Lg1WRr+fpsS5MELfOvjIeWqk272j2R95aHv8VBOEXMFalN5PVo
         DRyQyRp6vluLZiI/28yha+Q/YMlU8U68NkrAge/x7lDA4HabpgS2e4E2afyP6BBBp0KF
         RYnbgE0yZTa0iqFzCOvZ09fDkSegkg1edZXv8jFaPVIKUiChQ7IpANONmwXRjgQPCugs
         SeDwAGiIFX1oS1zL4WxVoBGKe6BU+sHOq+dwtvSQdpzCETFXNRmEHH9N0bbbVhzGDQ9I
         WNcELtThamOrnWYnyJD69hu8bHFIwz9GV3nLzstM5A0PdIy+H+4BTmwSmqUDNdHJsjXC
         lO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKNe5f1UiRXo4zGBhN7dw31pRci+hLgKcAj+G8bW8o4=;
        b=aCjY4+nj3JPeC/t2iHP/x1IPzAlgBVF15IJspnU/DY9oMZoknafGKc02iAtG5XGU3z
         hp0oYa3f2SABM58OW0rx4eU7RC1OrpRwIG+6UIoJMWqCqlDP7M3RY03PVxI6/rQhGEeT
         t7LknvP9M1ph+Nnvk4K+nQpNqCeIYRP8e7wFpxFW5538wAOR1mmVZs0xPB3lvby1OZXO
         BGDyGqJYFGrcx6TgecMKvZK9xnB5yYJ+IugQOP2Ie5XcGDnSKLGul13/RslH5ev+5wLk
         J17A/kPV0v63Pgx8jGEWIPLC4cX5pLS9ppfwQ9ygqS6OgjfQR/D9MWJkVFJ/EoFasqoo
         3y4g==
X-Gm-Message-State: AOAM533dsa4YCSeg25Xjm07L5SE4jGn4JLHzV3G/gVToI47Oh05UO4zL
        VlVbFK9rX2hQZhpQws440Hkw+k4mTgw=
X-Google-Smtp-Source: ABdhPJyWKHA2PwnrS/A+A6blOkHiibW7jCzNFt6woS45OzcVaOX069rm4iRzn9axtVRfJ7xQU8KxQg==
X-Received: by 2002:a05:6808:13cc:: with SMTP id d12mr3851685oiw.29.1643319496066;
        Thu, 27 Jan 2022 13:38:16 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:15 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 15/26] RDMA/rxe: Add code to cleanup mcast memory
Date:   Thu, 27 Jan 2022 15:37:44 -0600
Message-Id: <20220127213755.31697-16-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c560d467a972..74c5521e9b3d 100644
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
index d01456052879..49cc1ad05bba 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -336,3 +336,34 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
 	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
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

