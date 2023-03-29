Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27256CF1E9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjC2SOM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2SOL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 14:14:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA684EC7
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 11:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F40BCB823EA
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 18:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2B5C433D2;
        Wed, 29 Mar 2023 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680113647;
        bh=ieVlmdrww4BPAoK2tBczAIsgcRvl7l3YEhORQrHQ35Q=;
        h=From:To:Cc:Subject:Date:From;
        b=lu0IaWgYEkk+2vlRiKcGR8hvORiCePptBMdgPk0oQmMhp+V0uJmz2pXbbaR0XETvT
         wCQ3nAhJCPd7HUC247noRyQVZ1rP7HCkyK8r2FqBXYh+Tb0alV3ADlHeD4rXNyi91d
         nWXbee4rxQE4IukPOdUcuKJS2udFJFXCns9cE5ZdQFCGq7sd5enBFf6j/per6Ahlit
         7IJIxeZf5x+gHwSBp6LOGPCoApsKp6fyiehzs4gDRn50yxSBZQdXxBlz6SKNqC4pko
         3fbWVtE/e/BlszNgwJsV9sJREFrt/kgD0OYQqpDEYuyMhSBTzxGgx64JAlRbinfHP0
         3sSUboyMajafQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Dan Carpenter <error27@gmail.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next] RDMA/rxe: Clean kzalloc failure paths
Date:   Wed, 29 Mar 2023 21:14:01 +0300
Message-Id: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need to print any debug messages after failure to
allocate memory, because kernel will print OOM dumps anyway.

Together with removal of these messages, remove useless goto jumps.

Fixes: 5bf944f24129 ("RDMA/rxe: Add error messages")
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/ea43486f-43dd-4054-b1d5-3a0d202be621@kili.mountain
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.c |  5 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 23 ++++++-----------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index d6dbf5a0058d..9611ee191a46 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -61,11 +61,11 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
 
 	/* num_elem == 0 is allowed, but uninteresting */
 	if (*num_elem < 0)
-		goto err1;
+		return NULL;
 
 	q = kzalloc(sizeof(*q), GFP_KERNEL);
 	if (!q)
-		goto err1;
+		return NULL;
 
 	q->rxe = rxe;
 	q->type = type;
@@ -100,7 +100,6 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
 
 err2:
 	kfree(q);
-err1:
 	return NULL;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 090d5bfb1e18..06f071832635 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1198,11 +1198,8 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	int err;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
-	if (!mr) {
-		err = -ENOMEM;
-		rxe_dbg_dev(rxe, "no memory for mr");
-		goto err_out;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
 	if (err) {
@@ -1220,7 +1217,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 err_free:
 	kfree(mr);
-err_out:
 	rxe_err_pd(pd, "returned err = %d", err);
 	return ERR_PTR(err);
 }
@@ -1235,11 +1231,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	int err, cleanup_err;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
-	if (!mr) {
-		err = -ENOMEM;
-		rxe_dbg_pd(pd, "no memory for mr");
-		goto err_out;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
 	if (err) {
@@ -1266,7 +1259,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
 err_free:
 	kfree(mr);
-err_out:
 	rxe_err_pd(pd, "returned err = %d", err);
 	return ERR_PTR(err);
 }
@@ -1287,11 +1279,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	}
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
-	if (!mr) {
-		err = -ENOMEM;
-		rxe_dbg_mr(mr, "no memory for mr");
-		goto err_out;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
 	if (err) {
-- 
2.39.2

