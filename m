Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6388B728928
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFHUGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjFHUGJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 16:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C5270B
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 13:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A337F650F0
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 20:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAECFC4339C;
        Thu,  8 Jun 2023 20:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686254766;
        bh=f1cHYlupR0oFb5304vxXyxaysq0TujyczT9IWwZuWgw=;
        h=Subject:From:To:Cc:Date:From;
        b=jMxeXNKTtX8Z4nhBUY9eiBLUb0bnHkQerQcmQ1KAiYUecosr2zotL3l3KvL+ni2PK
         daycRoUaQvIJyDzOa4YdE9d3Lc52o5m5Am4I7YktyDNPOz3KrPnwSQ4JRQnrGVyUkB
         dXImBVUZFn05+W4vQSLkiHwQODF0cfV+4v/5dKukKDnUll+K6kScLE6bIjFoosLq7g
         IJDSv60X1f8IEIZxLnbwgbt3rsWQQMzYIuOOS3hhYxM9nmEad1k+/XW46HSbMIPdm5
         H0djt+eyvzyEq+AJh8IrDpD2ftn7OsC3nDzz2kfzci7oZiqSAn+jK/hi6q2vh8tYgt
         P4bRkvOei4tSQ==
Subject: [PATCH v2] RDMA/cma: Handle ARPHRD_NONE devices for iWARP
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com, BMT@zurich.ibm.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com,
        linux-rdma@vger.kernel.org
Date:   Thu, 08 Jun 2023 16:05:54 -0400
Message-ID: <168625464167.6526.1226449785871036437.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

We would like to enable the use of siw on top of a VPN that is
constructed and managed via a tun device. That hasn't worked up
until now because ARPHRD_NONE devices (such as tun devices) have
no GID for the RDMA/core to look up.

But it turns out that the egress device has already been picked for
us -- no GID is necessary. addr_handler() just has to do the right
thing with it.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

Further testing convinced me of the necessity of confirming that
the ndev and ib_device are properly related. This version works
on systems with multiple RDMA devices present.


diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 56e568fcd32b..44ef0539957a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -686,30 +686,47 @@ cma_validate_port(struct ib_device *device, u32 port,
 		  struct rdma_id_private *id_priv)
 {
 	struct rdma_dev_addr *dev_addr = &id_priv->id.route.addr.dev_addr;
+	const struct ib_gid_attr *sgid_attr = ERR_PTR(-ENODEV);
 	int bound_if_index = dev_addr->bound_dev_if;
-	const struct ib_gid_attr *sgid_attr;
 	int dev_type = dev_addr->dev_type;
 	struct net_device *ndev = NULL;
 
 	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
-		return ERR_PTR(-ENODEV);
+		goto out;
+
+	if (rdma_protocol_iwarp(device, port)) {
+		struct ib_device *base_dev;
+
+		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
+		if (!ndev)
+			goto out;
+		base_dev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
+		if (base_dev)
+			ib_device_put(base_dev);
+		dev_put(ndev);
+
+		if (device == base_dev)
+			sgid_attr = rdma_get_gid_attr(device, port, 0);
+		goto out;
+	}
 
 	if ((dev_type == ARPHRD_INFINIBAND) && !rdma_protocol_ib(device, port))
-		return ERR_PTR(-ENODEV);
+		goto out;
 
 	if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
-		return ERR_PTR(-ENODEV);
+		goto out;
 
 	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
 		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
 		if (!ndev)
-			return ERR_PTR(-ENODEV);
+			goto out;
 	} else {
 		gid_type = IB_GID_TYPE_IB;
 	}
 
 	sgid_attr = rdma_find_gid_by_port(device, gid, gid_type, port, ndev);
 	dev_put(ndev);
+out:
 	return sgid_attr;
 }
 


