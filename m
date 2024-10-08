Return-Path: <linux-rdma+bounces-5307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6BA994766
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C51C21469
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105D17C21E;
	Tue,  8 Oct 2024 11:40:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102F2F2F
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387647; cv=none; b=NC+PCxTp07qF8F39tmmwG4ujPF4vJ4O17G5yhRg5yFiYuw1Wx/fnr/DJGETtazkmwj4kxvxkdJwk9kEVYQmdJ3T2dPKzap015fp1GNJVpUKZpcSaTFe+SUR7280VUTfoq0LP9+oJCzpIB7rWJRBFoIAebKSFjZoRDS3cCT+Dv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387647; c=relaxed/simple;
	bh=V+xk8yxIR/0nm2Lk/6vHrqq230WrJOsGupvDATTfkyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XOIuOtJlV24UotrTySSQBTA+w3nb+fckhZm9TLwm39/8fV5WDqT+myTb54VX8tyifnRmFOougDRCceIQ4q3AQvcnNTZSn9p2xV0bN7oNeFScDMDKqjz57RSSnu5/17AhHZzSL0XYPSl5+6BhJU/EiUhJ9G892wWHL6ajUep5e2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 498BeYXQ005673;
	Tue, 8 Oct 2024 04:40:35 -0700
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-rc v3] RDMA/core: Fix ENODEV error for iWARP test over vlan
Date: Tue,  8 Oct 2024 17:13:34 +0530
Message-Id: <20241008114334.146702-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If traffic is over vlan, cma_validate_port() fails to match vlan
net_device ifindex with bound_if_index and results in ENODEV error.
It is because rdma_copy_src_l2_addr() always assigns bound_if_index with
real net_device ifindex.
This patch fixes the issue by assigning bound_if_index with vlan
net_device index if traffic is over vlan.

Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
Changes since v2:
Addressed previous review comments
---
 drivers/infiniband/core/addr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index be0743dac3ff..c4cf26f1d149 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -269,6 +269,8 @@ rdma_find_ndev_for_src_ip_rcu(struct net *net, const struct sockaddr *src_in)
 		break;
 #endif
 	}
+	if (!ret && dev && is_vlan_dev(dev))
+		dev = vlan_dev_real_dev(dev);
 	return ret ? ERR_PTR(ret) : dev;
 }
 
-- 
2.39.3


