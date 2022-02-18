Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DFF4BAE9B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 01:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiBRAg6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 19:36:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiBRAg5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 19:36:57 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A602612F
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:42 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q5so1412841oij.6
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCikr/21UBQgDZaKxWYexvox9IwibwcSTcDjepolExE=;
        b=Kgrv/x13azUEwcxZ/xOk3D+cL/Oe1thqH7AXW98mYs8xDQiQ6MRvEVquT5aIgaQ44N
         mtsK4AWVFG4GCO4wJn77D7vdd5aM4FIRc/CSY/Lpx/Iw+Re1lbyak1otxZjCXewTSeZN
         pqmJ5UZ4TnY2ckOXnocxurGtccM5Kfl0+wIpKnfvIvRAKiZKeT8JO252JvV3aU8Utn6/
         kK06lhxhaSKAWy9POWw95jxL04OVzVcerVrYrhlJBigh5rcuJElvypc1KayZAXpl7lex
         HOsaHjrJ9nciIl8xUJXsjWZfq6SSbHnjfdL6P9QB9WNYoMrHwmdJ5ar1vRgN8Sr0gzfR
         bIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCikr/21UBQgDZaKxWYexvox9IwibwcSTcDjepolExE=;
        b=rNuoh/+Du4ZY5azazL5043fhii537dNMOp38kVTe4J0KbpLuCQs3/8wSlNeNOPkdzO
         WOWM5aPB9SU4Hrd8PjVWP7Tbhj5pgJFbZA357igdCYj5bM3pOPeHgobO6L9oOJDIA3us
         RYzkfRAK1Qjo9SUB4CHh+MWVK3gWOVBYwjujwTUSoZ/YfujBFa6WU8zyRZpQKQwWsbLU
         Hmie74yw4l0HNFYW+cDJx5pWJnye7UkNM2dkSzaeIt+ODKhCmRKcu5RyjCxBfbM2hiLG
         9UsrTPWH98IDt+DokpyEDU4xL/dj/rpcgZzZh7frXX2BipVV7BEP9Bs4BOycUvwwi11K
         x67Q==
X-Gm-Message-State: AOAM533/pi4lsCuwBEWSFIzWBTRjot9sColm0pp97iLgl7wBIPtX5q7u
        cdSQyj0ZRvFL5uiNqABFu/U=
X-Google-Smtp-Source: ABdhPJzbPhg9ddQMzOsK2l9T+D7TpDpxHW8koExSDUT+PmFIZ5Tzt4LDTnbQGbxmEsRWADjn8Sl9JQ==
X-Received: by 2002:aca:42c6:0:b0:2cc:a020:c00f with SMTP id p189-20020aca42c6000000b002cca020c00fmr2246435oia.86.1645144601448;
        Thu, 17 Feb 2022 16:36:41 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-1772-15fa-cf3f-3cd5.res6.spectrum.com. [2603:8081:140c:1a00:1772:15fa:cf3f:3cd5])
        by smtp.googlemail.com with ESMTPSA id t31sm19698299oaa.9.2022.02.17.16.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:36:41 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 1/6] RDMA/rxe: Add code to cleanup mcast memory
Date:   Thu, 17 Feb 2022 18:35:39 -0600
Message-Id: <20220218003543.205799-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218003543.205799-1-rpearsonhpe@gmail.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
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

Well behaved applications will free all memory allocated by multicast.
If this fails rdma-core will detach all qp's from multicast groups when
an application terminates. This patch prints a warning and cleans out
memory allocated by multicast if both of these fail to occur.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 ++
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mcast.c | 38 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

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
index 4935fe5c5868..447d78bea28b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -388,3 +388,41 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
 	return rxe_detach_mcg(rxe, qp, mgid);
 }
+
+/**
+ * rxe_cleanup_mcast - cleanup all resources still held by mcast
+ * @rxe: rxe object
+ *
+ * Called when rxe device is unloaded. Walk red-black tree to
+ * find all mcg's and then walk mcg->qp_list to find all mca's and
+ * free them.
+ *
+ * This is belt and suspenders. These should have been recovered
+ * already by the application else rdma-core.
+ */
+void rxe_cleanup_mcast(struct rxe_dev *rxe)
+{
+	struct rb_root *root = &rxe->mcg_tree;
+	struct rb_node *node, *next;
+	struct rxe_mcg *mcg;
+	struct rxe_mca *mca, *tmp;
+
+	if (RB_EMPTY_ROOT(root))
+		return;		/* expected behavior */
+
+	pr_warn("RDMA/core bug: Recovering  leaked multicast resources\n");
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

