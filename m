Return-Path: <linux-rdma+bounces-5268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F25992D08
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769DD286D1F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322021D359A;
	Mon,  7 Oct 2024 13:20:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6A1D362B
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307223; cv=none; b=oIeoSnhITp0ckuHeVxMdwBMWuEy0MQB0dKd8mTztXWWc7STEuH70b2pYnF79Xoq0KKxciONrsPk2sg//tob31Zq7NyzSy9X7xZiK1U0G6Ewa181oGlP3SwkWtMxyUME9TB6BVJJMbj32EL3mahtAIWi0uq6N+3F6h6nWEU2G5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307223; c=relaxed/simple;
	bh=IXtvs8heVaodpxLs0woevCq6z4/9NtUAAK+3M3S8Pig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WlrBjfz9eD7yr3crE0qODGAzOSalnh/xp/idBNdFSN+t9TXtuALI37uEQ9PTMCb9d1/YVXqJzCnw9fX0w9o67nO6lpfdGX22IRt0z2Wns5nZTJlJX6QTuEOZ+1c/1hCE8hLgmsMjehlj00BYGRSG1CTrVRHD68Msi0Hcfkl3LxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 497DKF7x004698;
	Mon, 7 Oct 2024 06:20:16 -0700
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-rc] RDMA/cxgb4: fix RDMA_CM_EVENT_UNREACHABLE error for iWARP
Date: Mon,  7 Oct 2024 18:53:11 +0530
Message-Id: <20241007132311.70593-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_dev_find() always returns real net_device address, whether traffic is
running on a vlan or real device, if traffic is over vlan, filling
endpoint struture with real ndev and an attempt to send a connect
request will results in RDMA_CM_EVENT_UNREACHABLE error.
This patch fixes the issue by using vlan_dev_real_dev().

Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index b3757c6a0457..8d753e6e0c71 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2086,7 +2086,7 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 	err = -ENOMEM;
 	if (n->dev->flags & IFF_LOOPBACK) {
 		if (iptype == 4)
-			pdev = ip_dev_find(&init_net, *(__be32 *)peer_ip);
+			pdev = __ip_dev_find(&init_net, *(__be32 *)peer_ip, false);
 		else if (IS_ENABLED(CONFIG_IPV6))
 			for_each_netdev(&init_net, pdev) {
 				if (ipv6_chk_addr(&init_net,
@@ -2101,12 +2101,12 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 			err = -ENODEV;
 			goto out;
 		}
+		if (is_vlan_dev(pdev))
+			pdev = vlan_dev_real_dev(pdev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
 					n, pdev, rt_tos2priority(tos));
-		if (!ep->l2t) {
-			dev_put(pdev);
+		if (!ep->l2t)
 			goto out;
-		}
 		ep->mtu = pdev->mtu;
 		ep->tx_chan = cxgb4_port_chan(pdev);
 		ep->smac_idx = ((struct port_info *)netdev_priv(pdev))->smt_idx;
@@ -2119,7 +2119,6 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 		ep->rss_qid = cdev->rdev.lldi.rxq_ids[
 			cxgb4_port_idx(pdev) * step];
 		set_tcp_window(ep, (struct port_info *)netdev_priv(pdev));
-		dev_put(pdev);
 	} else {
 		pdev = get_real_dev(n->dev);
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
-- 
2.39.3


