Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7B6166DC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 17:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKBQCh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiKBQCb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 12:02:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221A2C64D
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 09:02:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so1587870wmb.2
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDsZaODISPHa/FkbcPR83zbfemQ/3Q3oLJ0hJ0eKUnY=;
        b=qNvQczvc02vftdYsGhjCyrEIbfu4PNxD/42bj8A6qol5PLzuhhWrxUsivPYAK9CbL/
         +pF08Bpog04nSyoTehmApEgGe8hsEmeIIAhddSoBpXHokmhMglHP21yD9f7nTwfOl6KA
         ST6us4iX1Cuzdyd/3j1xM8YiIkhB+7yfAqUW0vxcX1xwm2o98BPTeYpYkXDm85wyKr/E
         R12f6bHZLc7PtTR4wfKieH5FeitKp+gov5rPuWitPlGLy/EBmiaOo8nQIngNLtI82a9v
         O+P74P9HeI/03Jtuj3lX7/HFLKpnNKkXhrzP+CNybZ0qyKVudFvizhXBGlf3sfCYmxWG
         bc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDsZaODISPHa/FkbcPR83zbfemQ/3Q3oLJ0hJ0eKUnY=;
        b=Ixtd/qZjIl/gwChvT9oTt4xDvGG3VMLNkW5jkAwJQsybciiIVQUiqK/TlFnc6sjOxt
         wGt9JhUScYecgw+4eggy904unG53cNWSJxFGuMpsVyePoXFHXNmjYPq8C7u+Ufc+8Jaa
         eHShacOnkUEPfshnwlCaHCb/+ZlJTIebg99pKJab35d3DVP3RsVlx6oFw7kbS9GIel6f
         vQe41kz0LXgKGSQ48Z7/QtIIZEIxzA665I8PWexv3VYfmO/hdkpCN7FPUW5QakR3xyiA
         bS9G0iZgoSEG0WW+xtDYoHTYaz2QJT8rXM0QYl40odPfwOxwbWLhoNFtAOMjmx+xkQIt
         dlpQ==
X-Gm-Message-State: ACrzQf0TqYgkFT9GlJpe3UCp/GSNOAxFmoBARU4665gdwzeqU/H+kmBh
        SHiwk5anZFW9q5ZzRwkTnvM5aw==
X-Google-Smtp-Source: AMsMyM7u4ttiKBYrYDte24fl5I/lLbvlw454hHPUK64Y82bqLY4mpJmX61HggSOEMat6ZWyxHPEqwA==
X-Received: by 2002:a05:600c:3b88:b0:3c6:cef8:8465 with SMTP id n8-20020a05600c3b8800b003c6cef88465mr26023143wms.64.1667404943934;
        Wed, 02 Nov 2022 09:02:23 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d45c9000000b0022e36c1113fsm12739462wrs.13.2022.11.02.09.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:02:23 -0700 (PDT)
From:   Jiri Pirko <jiri@resnulli.us>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: [patch net-next v4 07/13] net: devlink: remove netdev arg from devlink_port_type_eth_set()
Date:   Wed,  2 Nov 2022 17:02:05 +0100
Message-Id: <20221102160211.662752-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221102160211.662752-1-jiri@resnulli.us>
References: <20221102160211.662752-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 6f06c05c7b1a..70a374c828ae 100644
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
2.37.3

