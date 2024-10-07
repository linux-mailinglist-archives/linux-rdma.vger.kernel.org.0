Return-Path: <linux-rdma+bounces-5267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A0992CA2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 15:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09991B24645
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604201D271F;
	Mon,  7 Oct 2024 13:07:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D81E519
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306434; cv=none; b=R8PHw6M4E+Rl9JcKDkUweMZHX71dzQWXrifpon6CbXTj9lqYa1N8XjdXS/+qGBpHbSaf7bKdHDjvMl3aYuQGt4o/cN16lY/IyIPsh+J0E8vQYgXL1Zz1rmWuuTjryFZrpMu/Pg+rri8e3uQDJpcRTKvbbwLFsuR8f7DW8ov4PH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306434; c=relaxed/simple;
	bh=Ke4CdwLRCsnG1d7oi0sD22JYw2AFaVd9Wehu/WSwkxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gKjkwm7EQlJJKGnijcx2SX8Fvke9a7z8JxRdo9xaPtBdL35b4PKxsZoJ5TrakXQ1BzXMFd+a+DW0zgdviYQ46KsK+Zl66GgLGhkaMyVO3hvS20QNZUKdZ/b2MAiIeUyGNigtLfQI6ChK+MlCIod9BjFkqC7ldtC2Fp/o/V3ovkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 497D76rM004691;
	Mon, 7 Oct 2024 06:07:07 -0700
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-rc v2] RDMA/core: Fix ENODEV error for iWARP test over vlan
Date: Mon,  7 Oct 2024 18:39:41 +0530
Message-Id: <20241007130941.62709-1-anumula@chelsio.com>
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
Changes since v1:
Added fixes line
Addressed static checker warnings
Targeting to rc since this is a bug fix
---
 drivers/infiniband/core/addr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index be0743dac3ff..8962fc0fe4c4 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -269,6 +269,8 @@ rdma_find_ndev_for_src_ip_rcu(struct net *net, const struct sockaddr *src_in)
 		break;
 #endif
 	}
+	if (dev && is_vlan_dev(dev))
+		dev = vlan_dev_real_dev(dev);
 	return ret ? ERR_PTR(ret) : dev;
 }
 
-- 
2.39.3


