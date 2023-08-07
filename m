Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E9771EA6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjHGKqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjHGKqC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8E10FA
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D84617AC
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA1FC43397;
        Mon,  7 Aug 2023 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405124;
        bh=PONZ6KAAHDRUQddfGuS4AnIVYLmcjnGQRAKUNaKMi80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlY5aWVMfZ3P3H+ItYUUhlTeC8+whciSIGqr1sgXHIHIkP5Z535lLRmVypVS6wZ5O
         vBkenwGLywl6JqbgtgnaFkyExn+ygovXQtKD5E85vcPvk7CG1jz9dNDIvFg1qCkBph
         sJyLA6SKlt6XIqbhosnikUF4HT4YZEm9l+N8CANsnr5vQe/P36Q+RK+0chB/E5JiVK
         wp4qde/m7y6BZ0Hei4tOkRAeLcTM96Ej9X6vQy48KRnNJXobV35atO7ncwTmzSvr0U
         ubNKPuHa8GywVpovhmflREIGuGnm4QDvy93wZYuLV9G70BJrrmOmUdOsDwj58eVMmL
         ybpNgdne1ID2g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 13/14] IB/core: Reorder GID delete code for RoCE
Date:   Mon,  7 Aug 2023 13:44:22 +0300
Message-ID: <fad6f58dfe3e9041cb522c8422a72ee8867def7a.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Reorder GID delete code so that the driver del_gid operation is executed
before nullifying the gid attribute ndev parameter, this allows drivers
to access the ndev during their gid delete operation, which makes more
sense since they had access to it during the gid addition operation.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 2e91d8879326..73f913cbd146 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -400,6 +400,9 @@ static void del_gid(struct ib_device *ib_dev, u32 port,
 		table->data_vec[ix] = NULL;
 	write_unlock_irq(&table->rwlock);
 
+	if (rdma_cap_roce_gid_table(ib_dev, port))
+		ib_dev->ops.del_gid(&entry->attr, &entry->context);
+
 	ndev_storage = entry->ndev_storage;
 	if (ndev_storage) {
 		entry->ndev_storage = NULL;
@@ -407,9 +410,6 @@ static void del_gid(struct ib_device *ib_dev, u32 port,
 		call_rcu(&ndev_storage->rcu_head, put_gid_ndev);
 	}
 
-	if (rdma_cap_roce_gid_table(ib_dev, port))
-		ib_dev->ops.del_gid(&entry->attr, &entry->context);
-
 	put_gid_entry_locked(entry);
 }
 
-- 
2.41.0

