Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF34B7B23B1
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 19:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjI1RU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1RUz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 13:20:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F7AC0
        for <linux-rdma@vger.kernel.org>; Thu, 28 Sep 2023 10:20:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD49C433C8;
        Thu, 28 Sep 2023 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695921653;
        bh=j1Av+WCPd/cQ0fvjk/BjP/mpO195Dr3es6OA29ACnGw=;
        h=From:To:Cc:Subject:Date:From;
        b=Njue695KE06SgnSssVaD/R6paU3/Hr8/LNUsS7CRIywUeAR9n2CKku3W3jCPEvj0Z
         FdVhgi/dULmfgVwtAhbiiur2zHDmVWjm243d9jkBcBqWQcu+gUBjHvdvQXsMECSoxl
         BA6WNvPB2qILjnP9X4iyl8gno2IESLuZ/fFb0IVn8/43UVvRCQxapeZbZDeV+jTd4S
         L4qwh/kmN5hUgvA53zFsodOd/QopiQ/sXR3u/0gYIIi9RqKUsFeKy2GlVrMkaZRBE3
         FNC3O7QsVmp6bKYvy/i2toz14rO2kv80pD4wOiW6roD4MUFlbLg47qMwhpLbpf4rlA
         4xabLGPvUqtow==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Remove not-used cache disable flag
Date:   Thu, 28 Sep 2023 20:20:47 +0300
Message-ID: <c7e9c9f98c8ae4a7413d97d9349b29f5b0a23dbe.1695921626.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

During execution of mlx5_mkey_cache_cleanup(), there is a guarantee
that MR are not registered and/or destroyed. It means that we don't
need newly introduced cache disable flag.

Fixes: 374012b00457 ("RDMA/mlx5: Fix mkey cache possible deadlock on cleanup")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 1 -
 drivers/infiniband/hw/mlx5/mr.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d1ff98aad162..16713baf0d06 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -798,7 +798,6 @@ struct mlx5_mkey_cache {
 	struct dentry		*fs_root;
 	unsigned long		last_add;
 	struct delayed_work	remove_ent_dwork;
-	u8			disable: 1;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 433f96459246..8a3762d9ff58 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1026,7 +1026,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
-	dev->cache.disable = true;
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
@@ -1830,10 +1829,6 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 	}
 
 	mutex_lock(&cache->rb_lock);
-	if (cache->disable) {
-		mutex_unlock(&cache->rb_lock);
-		return 0;
-	}
 	ent = mkey_cache_ent_from_rb_key(dev, mr->mmkey.rb_key);
 	if (ent) {
 		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
-- 
2.41.0

