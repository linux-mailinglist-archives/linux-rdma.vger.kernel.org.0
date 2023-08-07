Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BE771EA4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjHGKqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjHGKqC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE21BE8
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B074C617C5
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11CCC433CC;
        Mon,  7 Aug 2023 10:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405125;
        bh=PONZ6KAAHDRUQddfGuS4AnIVYLmcjnGQRAKUNaKMi80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRd0Wiw2jisGw0Y5Bf2GOcfzRxsDPfKd3w0ScH5aS6i11FWN8npfhbbyxsiTdxjP1
         03N2S3lPoN4+PhqKaYb5uwf+n+hHKh0A9SMx2Jk01KRuAGSCfnR4MJo9WVes4+rvkp
         GdYzC9dndgZEJuq11E06r+xiS3eBcyKWuhzwmZlTj7QqOYLR4kL5WKVB9WFjBSDo5N
         8ufFknhMZJ9so3M0e++/PSo/8UzzKBhKKk0MF+vOJRJi7Gek4m+ih6C0l5k8nq6iEE
         zvfGx0bnyV1XJ1RzGKsS2GmXU7wSc4DfGZmzDveWt/wHIUgYucxqLb2/emB5dvABMV
         wJSuqc9eRLYqQ==
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

