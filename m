Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F9722395
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjFEKeS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFEKeK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A547AF3
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CB9E615DA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A64CC433D2;
        Mon,  5 Jun 2023 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961235;
        bh=oFgmMBHAFi8w4Ukx5OsdcbE21NBOubsFXNRuO9K/0bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USipGcQXOTqvZ0SimYQUawl7SCN6QGnxRK+FKMUZKBDoViIs8OUlISYYQEB60zv02
         k6akNkeI6um0yrBBUz8As+Y7DQVomYY+ljN2JvU21BFhDy98Dac0UYokGzMExplELm
         WCrBmwlryIwpAoekl5+LqHZJ1y97rryBcXkbGTM7WcKkUQV6JkDQchCLWyvldyv5VX
         1d8WvSXIQjyEfLkFLE1n+kix2/IpU8InjSRNTiGsh1eSrZKk4tYXPUjTD9F97u0bGy
         U0cFwAmhD4/RJKB+wRJ23GRjQpn9zqgqpjAWEkZEWdsEMbHJ/pagJVgI+uqJUVCavS
         1NmTWWYSAjobg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 07/10] RDMA/cma: Always set static rate to 0 for RoCE
Date:   Mon,  5 Jun 2023 13:33:23 +0300
Message-Id: <f72a4f8b667b803aee9fa794069f61afb5839ce4.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Set static rate to 0 as it should be discovered by path query and
has no meaning for RoCE.
This also avoid of using the rtnl lock and ethtool API, which is
a bottleneck when try to setup many rdma-cm connections at the same
time, especially with multiple processes.

Fixes: 3c86aa70bf67 ("RDMA/cm: Add RDMA CM support for IBoE devices")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c |  4 ++--
 include/rdma/ib_addr.h        | 23 -----------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 93a1c48d0c32..6b3f4384e46a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3295,7 +3295,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	route->path_rec->traffic_class = tos;
 	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
 	route->path_rec->rate_selector = IB_SA_EQ;
-	route->path_rec->rate = iboe_get_rate(ndev);
+	route->path_rec->rate = IB_RATE_PORT_CURRENT;
 	dev_put(ndev);
 	route->path_rec->packet_life_time_selector = IB_SA_EQ;
 	/* In case ACK timeout is set, use this value to calculate
@@ -4964,7 +4964,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (!ndev)
 		return -ENODEV;
 
-	ib.rec.rate = iboe_get_rate(ndev);
+	ib.rec.rate = IB_RATE_PORT_CURRENT;
 	ib.rec.hop_limit = 1;
 	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
 
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index d808dc3d239e..811a0f11d0db 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -194,29 +194,6 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 		return 0;
 }
 
-static inline int iboe_get_rate(struct net_device *dev)
-{
-	struct ethtool_link_ksettings cmd;
-	int err;
-
-	rtnl_lock();
-	err = __ethtool_get_link_ksettings(dev, &cmd);
-	rtnl_unlock();
-	if (err)
-		return IB_RATE_PORT_CURRENT;
-
-	if (cmd.base.speed >= 40000)
-		return IB_RATE_40_GBPS;
-	else if (cmd.base.speed >= 30000)
-		return IB_RATE_30_GBPS;
-	else if (cmd.base.speed >= 20000)
-		return IB_RATE_20_GBPS;
-	else if (cmd.base.speed >= 10000)
-		return IB_RATE_10_GBPS;
-	else
-		return IB_RATE_PORT_CURRENT;
-}
-
 static inline int rdma_link_local_addr(struct in6_addr *addr)
 {
 	if (addr->s6_addr32[0] == htonl(0xfe800000) &&
-- 
2.40.1

