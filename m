Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546D86469F4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 08:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLHHxM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 02:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLHHxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 02:53:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6E2F028
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 23:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72AC861D3E
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 07:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58442C433C1;
        Thu,  8 Dec 2022 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670485986;
        bh=QlwY3FKepiz3BEO99zQtXjW27RIpgBgDb3kaUUm7j7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Fbp97HSfTR8rCOFwfsyC27ECZVV1A/hNoskvwaonuycKAwJB0zMfwpQrG+Zjl2bUR
         fGX8UlbcJP7YncV9o3BsOag3MR+B2Jz6zy4cwLf6vAJlU4tzCIkkZ26dofWCVHjthW
         kmR7+un4eaL5WhVogI92Z9GAHnPUmlYAE6iDU0iCLfKNXj0KnzHzWr/PTotWferaba
         nOLp6ZG0Xzz/maHSzlEFDNj1oxLPPiKRhXaikZxC6yw5l5G+9XbLDaba0ujSrS1Th0
         rklOF9Nj/uoQeFL4+Kl1+gfdreG6BkgS2VPiNF7PjFzXh+pSo2Elmp1aPQ7Ps2jdZm
         e0Q5PtjTMy4qw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Erez Shitrit <erezsh@mellanox.co.il>,
        linux-rdma@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Subject: [PATCH rdma-next] IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces
Date:   Thu,  8 Dec 2022 09:52:54 +0200
Message-Id: <f4a42c8aa43c02d5ae5559a60c3e5e0f18c82531.1670485816.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dragos Tatulea <dtatulea@nvidia.com>

There are 2 ways to create IPoIB PKEY child interfaces:
1) Writing a PKEY to /sys/class/net/<ib parent interface>/create_child.
2) Using netlink with iproute.

While with sysfs the child interface has the same number of tx and
rx queues as the parent, with netlink there will always be 1 tx
and 1 rx queue for the child interface. That's because the
get_num_tx/rx_queues() netlink ops are missing and the default value
of 1 is taken for the number of queues (in rtnl_create_link()).

This change adds the get_num_tx/rx_queues() ops which allows for
interfaces with multiple queues to be created over netlink. This
constant only represents the max number of tx and rx queues on that
net device.

Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index ea16ba5d8da6..9ad8d9856275 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -41,6 +41,11 @@ static const struct nla_policy ipoib_policy[IFLA_IPOIB_MAX + 1] = {
 	[IFLA_IPOIB_UMCAST]	= { .type = NLA_U16 },
 };
 
+static unsigned int ipoib_get_max_num_queues(void)
+{
+	return min_t(unsigned int, num_possible_cpus(), 128);
+}
+
 static int ipoib_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
@@ -172,6 +177,8 @@ static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
 	.changelink	= ipoib_changelink,
 	.get_size	= ipoib_get_size,
 	.fill_info	= ipoib_fill_info,
+	.get_num_rx_queues = ipoib_get_max_num_queues,
+	.get_num_tx_queues = ipoib_get_max_num_queues,
 };
 
 struct rtnl_link_ops *ipoib_get_link_ops(void)
-- 
2.38.1

