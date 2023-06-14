Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3262A73010D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbjFNOAo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbjFNOAn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 10:00:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628511B
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 07:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C70763C9D
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 14:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC54C433C0;
        Wed, 14 Jun 2023 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686751241;
        bh=yXdH0Bj1EtydNi/S+U3oAgvHc7WfEz5wPLW7IdVlhCo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FLtN8gQzb10lushZZgeOyUMSe9WabagiUZOyDRfu/wDxZbwMvGQGsL5fgOiCOCvSX
         Hf920KnW0LMSlHd4CEA3KoWTMhwxdf9nL2QEp5gXYYqchiWHgzX/w1HJrNMkABGPXk
         nBofM/3LGmkBGATt/RZhbo14xfVjUQKZOXPh1Hi30hOv44Lhz0LVZTpw6YEjfalIzS
         R2dfQKhYSd88Q0/ox+ukoCOS8WbGHW+s31cWzlvI+5sOKVUZD17r1JjCs3nwiHcNZD
         TxxnRaT6gLa2thdWqBHEPO35Fy61GZwqyv33LJZo+GT8Omk/xWSyGJVupilMCoJiuA
         mWLXdYbJl3WbQ==
Subject: [PATCH v3 1/4] RDMA/siw: Fabricate a GID on tun and loopback devices
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org, tom@talpey.com, BMT@zurich.ibm.com
Date:   Wed, 14 Jun 2023 10:00:40 -0400
Message-ID: <168675124033.2279.4244453854641171409.stgit@manet.1015granger.net>
In-Reply-To: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

LOOPBACK and NONE (tunnel) devices have all-zero MAC addresses.
Currently, siw_device_create() falls back to copying the IB device's
name in those cases, because an all-zero MAC address breaks the RDMA
core address resolution mechanism.

However, at the point when siw_device_create() constructs a GID, the
ib_device::name field is uninitialized, leaving the MAC address to
remain in an all-zero state.

Fabricate a random artificial GID for such devices, and ensure that
artificial GID is returned for all device query operations.

Reported-by: Tom Talpey <tom@talpey.com>
Link: https://lore.kernel.org/linux-rdma/SA0PR15MB391986C07C4D41E107E79659994FA@SA0PR15MB3919.namprd15.prod.outlook.com/T/#t
Fixes: a2d36b02c15d ("RDMA/siw: Enable siw on tunnel devices")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/sw/siw/siw.h       |    1 +
 drivers/infiniband/sw/siw/siw_main.c  |   22 ++++++++--------------
 drivers/infiniband/sw/siw/siw_verbs.c |    4 ++--
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 2f3a9cda3850..8b4a710b82bc 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -74,6 +74,7 @@ struct siw_device {
 
 	u32 vendor_part_id;
 	int numa_node;
+	char raw_gid[ETH_ALEN];
 
 	/* physical port state (only one port per device) */
 	enum ib_port_state state;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 65b5cda5457b..f45600d169ae 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -75,8 +75,7 @@ static int siw_device_register(struct siw_device *sdev, const char *name)
 		return rv;
 	}
 
-	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->netdev->dev_addr);
-
+	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->raw_gid);
 	return 0;
 }
 
@@ -313,24 +312,19 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 		return NULL;
 
 	base_dev = &sdev->base_dev;
-
 	sdev->netdev = netdev;
 
-	if (netdev->type != ARPHRD_LOOPBACK && netdev->type != ARPHRD_NONE) {
-		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
-				    netdev->dev_addr);
+	if (netdev->addr_len) {
+		memcpy(sdev->raw_gid, netdev->dev_addr,
+		       min_t(unsigned int, netdev->addr_len, ETH_ALEN));
 	} else {
 		/*
-		 * This device does not have a HW address,
-		 * but connection mangagement lib expects gid != 0
+		 * This device does not have a HW address, but
+		 * connection mangagement requires a unique gid.
 		 */
-		size_t len = min_t(size_t, strlen(base_dev->name), 6);
-		char addr[6] = { };
-
-		memcpy(addr, base_dev->name, len);
-		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
-				    addr);
+		eth_random_addr(sdev->raw_gid);
 	}
+	addrconf_addr_eui48((u8 *)&base_dev->node_guid, sdev->raw_gid);
 
 	base_dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND);
 
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 398ec13db624..32b0befd25e2 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -157,7 +157,7 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 	attr->vendor_part_id = sdev->vendor_part_id;
 
 	addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
-			    sdev->netdev->dev_addr);
+			    sdev->raw_gid);
 
 	return 0;
 }
@@ -218,7 +218,7 @@ int siw_query_gid(struct ib_device *base_dev, u32 port, int idx,
 
 	/* subnet_prefix == interface_id == 0; */
 	memset(gid, 0, sizeof(*gid));
-	memcpy(&gid->raw[0], sdev->netdev->dev_addr, 6);
+	memcpy(gid->raw, sdev->raw_gid, ETH_ALEN);
 
 	return 0;
 }


