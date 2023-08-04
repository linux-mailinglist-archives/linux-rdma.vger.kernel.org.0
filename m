Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF67703F3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjHDPGd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjHDPGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 11:06:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83494C04;
        Fri,  4 Aug 2023 08:06:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C1AC21889;
        Fri,  4 Aug 2023 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691161568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0HSa8izoUImPyEB19gkjsv8om3wKtyg62opC34ZVzA=;
        b=syAWY128ThDIT/mi11rS49CF3d/D/JwRfj+aBRt1Bi4H4ymzI6ci9Il+B6ZJkJp1PQixZR
        qB2YEFVbDUS0vY5dAehlR/U+HSxnXRulq0darUNkmXXldNhpv7hkl/rqhdcBfTlU223K9j
        yha9CMkGkKiyMh6WeFANBVmvMsgpWz0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69AD5133B5;
        Fri,  4 Aug 2023 15:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SAQOGeATzWRwSQAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Fri, 04 Aug 2023 15:06:08 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH net-next 06/10] mlx4: Avoid resetting MLX4_INTFF_BONDING per driver
Date:   Fri,  4 Aug 2023 17:05:23 +0200
Message-Id: <20230804150527.6117-7-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230804150527.6117-1-petr.pavlu@suse.com>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Tested-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/intf.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 8b2c1404cb66..30aead34ce08 100644
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

