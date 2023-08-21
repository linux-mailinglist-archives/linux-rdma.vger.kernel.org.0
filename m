Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636E782A21
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjHUNM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjHUNM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:12:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFD6EC;
        Mon, 21 Aug 2023 06:12:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 541BE206C0;
        Mon, 21 Aug 2023 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692623562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrDZ69H2NWA/XUC/sTqplN7GhGldnmZpsSLx8bYevfo=;
        b=g01CvYRTAQaUQKyygK+ZdRr1dpgLaJdZk8rh7HPL2JcUgjSzEUPe+bKzngBGcLcLgzyhMj
        QeJyipM9N4RrRF9t7wIr8CIaXwEkFEWxvdH61dvNXCWI/aTPWXAQALozcX9kGMZQPNHvSS
        5ztLP1pxuYkpUeduMSAz4/uuS/lQqN0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 165C613421;
        Mon, 21 Aug 2023 13:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cCCiBMpi42QUVgAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 21 Aug 2023 13:12:42 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v3 07/11] mlx4: Avoid resetting MLX4_INTFF_BONDING per driver
Date:   Mon, 21 Aug 2023 15:12:21 +0200
Message-Id: <20230821131225.11290-8-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230821131225.11290-1-petr.pavlu@suse.com>
References: <20230821131225.11290-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mlx4_core driver has a logic that allows a sub-driver to set the
MLX4_INTFF_BONDING flag which then causes that function mlx4_do_bond()
asks the sub-driver to fully re-probe a device when its bonding
configuration changes.

Performing this operation is disallowed in mlx4_register_interface()
when it is detected that any mlx4 device is multifunction (SRIOV). The
code then resets MLX4_INTFF_BONDING in the driver flags.

Move this check directly into mlx4_do_bond(). It provides a better
separation as mlx4_core no longer directly modifies the sub-driver flags
and it will allow to get rid of explicitly keeping track of all mlx4
devices by the intf.c code when it is switched to an auxiliary bus.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/intf.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 8cbc1bcdfe77..d578f754d882 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -96,11 +96,6 @@ int mlx4_register_interface(struct mlx4_interface *intf)
 
 	list_add_tail(&intf->list, &intf_list);
 	list_for_each_entry(priv, &dev_list, dev_list) {
-		if (mlx4_is_mfunc(&priv->dev) && (intf->flags & MLX4_INTFF_BONDING)) {
-			mlx4_dbg(&priv->dev,
-				 "SRIOV, disabling HA mode for intf proto %d\n", intf->protocol);
-			intf->flags &= ~MLX4_INTFF_BONDING;
-		}
 		mlx4_add_device(intf, priv);
 	}
 
@@ -155,10 +150,18 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
 
 	spin_lock_irqsave(&priv->ctx_lock, flags);
 	list_for_each_entry_safe(dev_ctx, temp_dev_ctx, &priv->ctx_list, list) {
-		if (dev_ctx->intf->flags & MLX4_INTFF_BONDING) {
-			list_add_tail(&dev_ctx->bond_list, &bond_list);
-			list_del(&dev_ctx->list);
+		if (!(dev_ctx->intf->flags & MLX4_INTFF_BONDING))
+			continue;
+
+		if (mlx4_is_mfunc(dev)) {
+			mlx4_dbg(dev,
+				 "SRIOV, disabled HA mode for intf proto %d\n",
+				 dev_ctx->intf->protocol);
+			continue;
 		}
+
+		list_add_tail(&dev_ctx->bond_list, &bond_list);
+		list_del(&dev_ctx->list);
 	}
 	spin_unlock_irqrestore(&priv->ctx_lock, flags);
 
-- 
2.35.3

