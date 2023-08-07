Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B937771E72
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHGKoh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjHGKog (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5DE78
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07F3617A8
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D30DC433C7;
        Mon,  7 Aug 2023 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405074;
        bh=1aEnwy11dk3pN/SydIOG65hSjDquKCZDp+SiD8zbnQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n926ZF5dwb3rRENnmVWYSi43D4XT/5Yf6SIDumkXXJZJwT1skSZKCBwBwn6SG3WU3
         kwfiXMXDshE4VyjGFIOrGJXh/eNN1IjkhvbIfkNZDq2bAwlp8wb8P2jRuJJuMFP8Js
         eanbfvLDdtGiWFDxWA64lcw7hubtCnOpE3sOaL5Wtlgx/6BGvK1Z1X76/9QTU+KYeP
         slLU+La6nJ08mifpI/vrt+OmYFUGQFRZYfFOGXwFtdmT42iqnp5GdjxwSWtS3OfbxK
         W6Z0REcYoAiS64C7j/hrtNCTd6EI20FJ77YL5/KKtni7Mi/y0lOISls0ZeMLVV695U
         TRqG1cjJfzQtA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 01/14] macsec: add functions to get MACsec real netdevice and check offload
Date:   Mon,  7 Aug 2023 13:44:10 +0300
Message-ID: <8ff59de0c55cc6de2ae20a98ee3e70f7aa5a5953.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Given a macsec net_device add two functions to return the real net_device
for that device, and check if that macsec device is offloaded or not.

This is needed for auxiliary drivers that implement MACsec offload, but
have flows which are triggered over the macsec net_device, this allows
the drivers in such cases to verify if the device is offloaded or not,
and to access the real device of that macsec device, which would
belong to the driver, and would be needed for the offload procedure.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Raed Salem <raeds@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/macsec.c | 15 +++++++++++++++
 include/net/macsec.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 984dfa5d6c11..ffc421d2de16 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4240,6 +4240,21 @@ static struct net *macsec_get_link_net(const struct net_device *dev)
 	return dev_net(macsec_priv(dev)->real_dev);
 }
 
+struct net_device *macsec_get_real_dev(const struct net_device *dev)
+{
+	return macsec_priv(dev)->real_dev;
+}
+EXPORT_SYMBOL_GPL(macsec_get_real_dev);
+
+bool macsec_netdev_is_offloaded(struct net_device *dev)
+{
+	if (!dev)
+		return false;
+
+	return macsec_is_offloaded(macsec_priv(dev));
+}
+EXPORT_SYMBOL_GPL(macsec_netdev_is_offloaded);
+
 static size_t macsec_get_size(const struct net_device *dev)
 {
 	return  nla_total_size_64bit(8) + /* IFLA_MACSEC_SCI */
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 441ed8fd4b5f..75a6f4863c83 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -312,6 +312,8 @@ static inline bool macsec_send_sci(const struct macsec_secy *secy)
 	return tx_sc->send_sci ||
 		(secy->n_rx_sc > 1 && !tx_sc->end_station && !tx_sc->scb);
 }
+struct net_device *macsec_get_real_dev(const struct net_device *dev);
+bool macsec_netdev_is_offloaded(struct net_device *dev);
 
 static inline void *macsec_netdev_priv(const struct net_device *dev)
 {
-- 
2.41.0

