Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F55F2F14
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Oct 2022 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJCKwc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Oct 2022 06:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJCKwX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Oct 2022 06:52:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C156B87
        for <linux-rdma@vger.kernel.org>; Mon,  3 Oct 2022 03:52:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w10so1103065edd.4
        for <linux-rdma@vger.kernel.org>; Mon, 03 Oct 2022 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lMF6OxhpO77TCv6j/JI/rAyTxaoEZW/QukSEoe2fqbM=;
        b=UrN2he7rINLxWXQgoqIz2L4cdWWENVjbrsgxxCUEMYH/lPB791hS6H/CedMKrKXLEr
         Rzjv0GPEM/LEWegAG+2UmHHK7UHKVZYUYLyPR/3C5P6D8sfOfqmi/pvY2TmLFn+YPd+N
         HJUSkY1VBAxUxuHjoRqkVQebJdCuftbOXUsI4dVBO/7MdAHSXKYD+kU8Mb6WH4ao0FRs
         1iiMnatEclxqLSu4sSOYO4+nGmNsop6etAvAX5jKBGFj/85VY2Wl3bBymIjhOP1U2HHL
         X4VfOzH+HMDcCf6k90761Z4dzWzN8F3UfoJf+qaYKD8NDgw4mZOeJXvkui94LVD7VMnl
         /LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lMF6OxhpO77TCv6j/JI/rAyTxaoEZW/QukSEoe2fqbM=;
        b=drSkblzwaLOajzqUZCQDl+zv79qBK7txNYsbqMLXKbUccSV5uGdXX7E1+Ly49GpDwk
         Em7ZqoLQl3Zwquj5Q9IhftmKn7hWfRQnvLsMMLM+KIUsM1GcW+S8wOeSZodyAToAOg1v
         u7ccTX2WlK7EW2+WyPk/BrgIsSQQbopepoKtf0v7MBqVhbn7mc9zAR8Qze56OVBca69b
         uVpzen1KfW2VCg1wvLsf96J+Qn6UEOoBnkWfVg4hFJ6NusPpTnIWYgoleXU0KlNIisDS
         t67Sq0CRePIAaHQ4eHoPrpfaBZy0a9ixDxm5Y8UFQV6KQgBEn53M4QMZswkIQ0/bfgWE
         M4vA==
X-Gm-Message-State: ACrzQf2AvUqUOA9cv11TmjETZkabZ+S/L8mMbGycz8HWci43eJEwu/Lz
        F4j2XRK4JJWFKJ1bQqsMXzocIA==
X-Google-Smtp-Source: AMsMyM4Obpraj6gKIRR9w/N0yc1e7UfNiaTkhkT26P2F2ZDxzI/u4K8HGUi+Pblxzd0rFY8qv60/gA==
X-Received: by 2002:a05:6402:1d54:b0:44e:a683:d041 with SMTP id dz20-20020a0564021d5400b0044ea683d041mr18107072edb.411.1664794334994;
        Mon, 03 Oct 2022 03:52:14 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id c20-20020a1709060fd400b0078167cb4536sm5197970ejk.118.2022.10.03.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:52:14 -0700 (PDT)
From:   Jiri Pirko <jiri@resnulli.us>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: [patch net-next v2 07/13] net: devlink: remove netdev arg from devlink_port_type_eth_set()
Date:   Mon,  3 Oct 2022 12:51:58 +0200
Message-Id: <20221003105204.3315337-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221003105204.3315337-1-jiri@resnulli.us>
References: <20221003105204.3315337-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiri Pirko <jiri@nvidia.com>

Since devlink_port_type_eth_set() should no longer be called by any
driver with netdev pointer as it should rather use
SET_NETDEV_DEVLINK_PORT, remove the netdev arg. Add a warn to
type_clear()

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/main.c |  2 +-
 include/net/devlink.h                     |  3 +--
 net/core/devlink.c                        | 23 ++++++++++++++---------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index d3fc86cd3c1d..3ae246391549 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -3043,7 +3043,7 @@ static int mlx4_init_port_info(struct mlx4_dev *dev, int port)
 	 */
 	if (!IS_ENABLED(CONFIG_MLX4_EN) &&
 	    dev->caps.port_type[port] == MLX4_PORT_TYPE_ETH)
-		devlink_port_type_eth_set(&info->devlink_port, NULL);
+		devlink_port_type_eth_set(&info->devlink_port);
 	else if (!IS_ENABLED(CONFIG_MLX4_INFINIBAND) &&
 		 dev->caps.port_type[port] == MLX4_PORT_TYPE_IB)
 		devlink_port_type_ib_set(&info->devlink_port, NULL);
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 6c55aabaedf1..b1582b32183a 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1582,8 +1582,7 @@ int devlink_port_register(struct devlink *devlink,
 			  unsigned int port_index);
 void devl_port_unregister(struct devlink_port *devlink_port);
 void devlink_port_unregister(struct devlink_port *devlink_port);
-void devlink_port_type_eth_set(struct devlink_port *devlink_port,
-			       struct net_device *netdev);
+void devlink_port_type_eth_set(struct devlink_port *devlink_port);
 void devlink_port_type_ib_set(struct devlink_port *devlink_port,
 			      struct ib_device *ibdev);
 void devlink_port_type_clear(struct devlink_port *devlink_port);
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 87aa39bc481e..f119ac43c50d 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -10097,17 +10097,15 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
  *	devlink_port_type_eth_set - Set port type to Ethernet
  *
  *	@devlink_port: devlink port
- *	@netdev: related netdevice
+ *
+ *	If driver is calling this, most likely it is doing something wrong.
  */
-void devlink_port_type_eth_set(struct devlink_port *devlink_port,
-			       struct net_device *netdev)
+void devlink_port_type_eth_set(struct devlink_port *devlink_port)
 {
-	if (!netdev)
-		dev_warn(devlink_port->devlink->dev,
-			 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
-			 devlink_port->index);
-
-	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_ETH, netdev,
+	dev_warn(devlink_port->devlink->dev,
+		 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
+		 devlink_port->index);
+	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_ETH, NULL,
 				false);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_eth_set);
@@ -10130,9 +10128,16 @@ EXPORT_SYMBOL_GPL(devlink_port_type_ib_set);
  *	devlink_port_type_clear - Clear port type
  *
  *	@devlink_port: devlink port
+ *
+ *	If driver is calling this for clearing Ethernet type, most likely
+ *	it is doing something wrong.
  */
 void devlink_port_type_clear(struct devlink_port *devlink_port)
 {
+	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH)
+		dev_warn(devlink_port->devlink->dev,
+			 "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
+			 devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_NOTSET, NULL,
 				false);
 }
-- 
2.37.1

