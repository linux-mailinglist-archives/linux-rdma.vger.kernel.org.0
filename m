Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1177C4A521F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiAaWKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiAaWKR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:17 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB853C061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:16 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso14433696otj.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M22qyIuNeSQMVHPFilxhiSz2IK2SLwIzs2Vwzwb7EBA=;
        b=eQ3qWzVz6o5IeBybLGjUrba+bxsqWQ6IB2pHvpW3A2h9N2sBc7mZWu7Hkh55/BsDy3
         YYeCvSmt0q4K1MbUfBoOn54i02iQPEZKduZxkpaQpfA9CzEx9A0FxaWdwU5Iv/0/Vvac
         Gqr0r/mBkFSrdR9tPdxqcxXffYKk9uFDwdS/wyBq2YC20Zc6qJgLnlmAvhAZkbI/Lj67
         Lo84q1JOOoGoJpOcEf8Xinad2tW8c/mtxlngVPWdpJfg/YO2rVarWlc8koQ7iB1k9+GE
         p5GqSYHc4UJswV1tojApWxTbSwhry8C0Rm1ZoBJsM4Gw5ki5hyIaVrZ4tkUF6sNdp20q
         4BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M22qyIuNeSQMVHPFilxhiSz2IK2SLwIzs2Vwzwb7EBA=;
        b=B11aEoWssWUxX1FhJX2zTEFZ512CO+dVVZSf/WU/tVE++cYom2xJi/dN3Fjgdzwl4e
         eY3h3txg3PU9DGnWVdirWBf7wING5FvUpH1mnD15ToPm0Suz1nwK0Jvd6qWGrJLFtz7x
         EnFH0q/E9dtgNq3m1tylmGEi/MbGNxFG0Mw2lsWa1vCRfNQ+YgB/m+ciUqspVNeYEGQW
         3Y5EjUJfHCz9pdTU9at9E8yxQfIL0MGCvir5TFU09ttRM+vdKA40ehQTxAbNtwurkzyq
         TppI5xbNi7BxR/1dA+wV+ItsHQe+ihNiWJziZy7W7UlnmZe4pB/fcyFqH6iY/UzFKOcJ
         0Wew==
X-Gm-Message-State: AOAM530KxZKcIz+ChwJrvk0+Vxpk1XItp4chADsn8erM9gdzbgq/tmCE
        v6Q9hQNQ2kLMsB77pLrpy+cmaBKoyhU=
X-Google-Smtp-Source: ABdhPJyA7pXVeeMrhykaSWe4KmOkPHDBjyhASix/Khz2TsR/zEEnE+UHGkN1Cbn+LNEH80uquvkALA==
X-Received: by 2002:a9d:7ad7:: with SMTP id m23mr12444769otn.20.1643667016158;
        Mon, 31 Jan 2022 14:10:16 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:15 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 15/17] RDMA/rxe: Add code to cleanup mcast memory
Date:   Mon, 31 Jan 2022 16:08:48 -0600
Message-Id: <20220131220849.10170-16-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
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
index ed23d0a270fd..00b4e3046d39 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -362,3 +362,34 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
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

