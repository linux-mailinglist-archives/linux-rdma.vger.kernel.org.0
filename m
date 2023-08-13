Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F277A70D
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjHMOwF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjHMOwE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 10:52:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39AD1704;
        Sun, 13 Aug 2023 07:52:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 715651F8C8;
        Sun, 13 Aug 2023 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691938324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlkLwPoGSJ/eBik/CH7trGhSdIICH1/nZbIFJG2ENWw=;
        b=JgNft9kTY/IZrc8gQqxW8iTayMD6FYnl8qngHUyIAmn21ME/+tKydRFpmt3BUDTgNknySO
        g/IiLUPw6ac3DkyibGC1dvm8RkAR9XKgLqCAtZUia7fqj60pipY3RJ2yujDIor+FDlQddw
        cXmFsZ4r78G684IW1Q8YMyxSP1JHWkY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CDE31322C;
        Sun, 13 Aug 2023 14:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GNkZDhTu2GSDFAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 13 Aug 2023 14:52:04 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 02/10] mlx4: Rename member mlx4_en_dev.nb to netdev_nb
Date:   Sun, 13 Aug 2023 16:51:19 +0200
Message-Id: <20230813145127.10653-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230813145127.10653-1-petr.pavlu@suse.com>
References: <20230813145127.10653-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rename the mlx4_en_dev.nb notifier_block member to netdev_nb in
preparation to add a mlx4 core notifier_block.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_main.c   | 14 +++++++-------
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c
index 6a42bec6bd85..be8ba34c9025 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -235,8 +235,8 @@ static void mlx4_en_remove(struct mlx4_dev *dev, void *endev_ptr)
 	iounmap(mdev->uar_map);
 	mlx4_uar_free(dev, &mdev->priv_uar);
 	mlx4_pd_free(dev, mdev->priv_pdn);
-	if (mdev->nb.notifier_call)
-		unregister_netdevice_notifier(&mdev->nb);
+	if (mdev->netdev_nb.notifier_call)
+		unregister_netdevice_notifier(&mdev->netdev_nb);
 	kfree(mdev);
 }
 
@@ -252,11 +252,11 @@ static void mlx4_en_activate(struct mlx4_dev *dev, void *ctx)
 			mdev->pndev[i] = NULL;
 	}
 
-	/* register notifier */
-	mdev->nb.notifier_call = mlx4_en_netdev_event;
-	if (register_netdevice_notifier(&mdev->nb)) {
-		mdev->nb.notifier_call = NULL;
-		mlx4_err(mdev, "Failed to create notifier\n");
+	/* register netdev notifier */
+	mdev->netdev_nb.notifier_call = mlx4_en_netdev_event;
+	if (register_netdevice_notifier(&mdev->netdev_nb)) {
+		mdev->netdev_nb.notifier_call = NULL;
+		mlx4_err(mdev, "Failed to create netdev notifier\n");
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 403604ceebc8..7066c426b95c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2967,7 +2967,7 @@ int mlx4_en_netdev_event(struct notifier_block *this,
 	if (!net_eq(dev_net(ndev), &init_net))
 		return NOTIFY_DONE;
 
-	mdev = container_of(this, struct mlx4_en_dev, nb);
+	mdev = container_of(this, struct mlx4_en_dev, netdev_nb);
 	dev = mdev->dev;
 
 	/* Go into this mode only when two network devices set on two ports
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 321f801c1d7c..72a3fea36702 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -432,7 +432,7 @@ struct mlx4_en_dev {
 	unsigned long		last_overflow_check;
 	struct ptp_clock	*ptp_clock;
 	struct ptp_clock_info	ptp_clock_info;
-	struct notifier_block	nb;
+	struct notifier_block	netdev_nb;
 };
 
 
-- 
2.35.3

