Return-Path: <linux-rdma+bounces-6037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95009D2026
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 07:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD0B20A49
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF113CA9C;
	Tue, 19 Nov 2024 06:16:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B218256D
	for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2024 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996977; cv=none; b=JBNK2+QfXpxViq7JxOcbe6Vt5C5cO8nnO3SeSobJzBtJ4QN7DCBidkLksF+AcG6OGMS8rzn9TewHqMg4YdMI7dO/5aDiNnGr1fLxGhhsDbfm83dJKXgg58MvnMfsLtvYPRpXeTS6Rwa8pG2EctXnFPU9SUVIF7A/oy3meHvIeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996977; c=relaxed/simple;
	bh=YA7pcgq9QYVv3emLEVtnKJyUKi/gfkgzvAOkEu32WoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQy5A9I88fOOqrttd/wKoONPWsSZ9uPuJ1L9behx0LuMTCAkWje3HUpwJzsRhs0Wjyccif3RAWBaL6/2IjWv4AcEYiA76KCpq2U1uiRjabqVfq7MidfRXJrBSyHcgji2GvSWn4LfDM6JZmC6xieuirLIejfvj3qYqavng2O6w5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 4AJ6G27T013370;
	Mon, 18 Nov 2024 22:16:02 -0800
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>
Subject: [PATCH for-rc] RDMA/core: Fix ENODEV error for iWARP test over vlan
Date: Tue, 19 Nov 2024 11:48:51 +0530
Message-Id: <20241119061850.18607-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If traffic is over vlan, cma_validate_port() fails to match
net_device ifindex with bound_if_index and results in ENODEV error.
As iWARP gid table is static, it contains entry corresponding  to
only one net device which is either real netdev or vlan netdev for
cases like  siw attached to a vlan interface.
This patch fixes the issue by assigning bound_if_index with net
device index, if real net device obtained from bound if index matches
with net device retrieved from gid table

Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
Link: https://lore.kernel.org/all/ZzNgdrjo1kSCGbRz@chelsio.com/
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/core/cma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 64ace0b968f0..97657e1810d8 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -689,7 +689,7 @@ cma_validate_port(struct ib_device *device, u32 port,
 	const struct ib_gid_attr *sgid_attr = ERR_PTR(-ENODEV);
 	int bound_if_index = dev_addr->bound_dev_if;
 	int dev_type = dev_addr->dev_type;
-	struct net_device *ndev = NULL;
+	struct net_device *ndev = NULL, *pdev = NULL;
 
 	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
 		goto out;
@@ -714,6 +714,21 @@ cma_validate_port(struct ib_device *device, u32 port,
 
 		rcu_read_lock();
 		ndev = rcu_dereference(sgid_attr->ndev);
+		if (ndev->ifindex != bound_if_index) {
+			pdev = dev_get_by_index_rcu(dev_addr->net, bound_if_index);
+			if (pdev) {
+				if (is_vlan_dev(pdev)) {
+					pdev = vlan_dev_real_dev(pdev);
+					if (ndev->ifindex == pdev->ifindex)
+						bound_if_index = pdev->ifindex;
+				}
+				if (is_vlan_dev(ndev)) {
+					pdev = vlan_dev_real_dev(ndev);
+					if (bound_if_index == pdev->ifindex)
+						bound_if_index = ndev->ifindex;
+				}
+			}
+		}
 		if (!net_eq(dev_net(ndev), dev_addr->net) ||
 		    ndev->ifindex != bound_if_index) {
 			rdma_put_gid_attr(sgid_attr);
-- 
2.39.3


