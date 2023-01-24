Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2667A116
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 19:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjAXSY1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 13:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAXSY0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 13:24:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960742DD1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 10:24:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2692B8163F
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 18:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38ABC433EF;
        Tue, 24 Jan 2023 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674584663;
        bh=MPO9umwd0nOj3a5SIBNiTnyFkXEXJrikt/2idDZOJwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gD5zgHKeqzSHMIiVnSIiPhrR9VMLWWFYqc5vijRDo7CbpAlV2t1cgfsb7pu7fpT7b
         1ZZBqQUPMMy0MJaKFB4aMFvnCLrxelufgJq6tMFDGX94d4DGnn/FBZav50S1ZcN+5p
         quxuoxbMwFxTWE/raU4rXFQvQ5vFp0bX2Mvrid2SAKc7HW5UFMI3+H/Bz7BNKV3RVl
         h3ceMUtzE8ClG/Ch1a2EVwRTVaRchLPUcrTohatJLohqzJZvVJI7nZW40BYzfzCgbs
         l44eITgQAonG2xVsx1jY9dE3a6+T1+OpmH+Y0zoripzKjtLeRQZI8GRqne0aKxiHkL
         c1RMfSlTirbkg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc v2] IB/IPoIB: Fix queue count for non-enhanced IPoIB over netlink
Date:   Tue, 24 Jan 2023 20:24:18 +0200
Message-Id: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.1
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

Make sure that non-enhanced IPoIB queues are configured with only
1 tx and rx queues over netlink. This behavior is consistent with the
sysfs child_create configuration.

The cited commit opened up the possibility for child PKEY interface
to have multiple tx/rx queues. It is the driver's responsibility to
re-adjust the queue count accordingly. This patch does exactly that:
non-enhanced IPoIB supports only 1 tx and 1 rx queue.

Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@nvidia.coma
---
Changelog:
v2:
 * Changed implementation
v1: https://lore.kernel.org/all/752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org
 * Fixed typo in warning print.
v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index ac25fc80fb33..f10d4bcf87d2 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2200,6 +2200,14 @@ int ipoib_intf_init(struct ib_device *hca, u32 port, const char *name,
 		rn->attach_mcast = ipoib_mcast_attach;
 		rn->detach_mcast = ipoib_mcast_detach;
 		rn->hca = hca;
+
+		rc = netif_set_real_num_tx_queues(dev, 1);
+		if (rc)
+			goto out;
+
+		rc = netif_set_real_num_rx_queues(dev, 1);
+		if (rc)
+			goto out;
 	}
 
 	priv->rn_ops = dev->netdev_ops;
-- 
2.39.1

