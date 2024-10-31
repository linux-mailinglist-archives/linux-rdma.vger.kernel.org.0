Return-Path: <linux-rdma+bounces-5644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F6B9B7581
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 08:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96660B2154C
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47114D2A0;
	Thu, 31 Oct 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDkqVCg9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FA1494C2
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360372; cv=none; b=JMOog+egWktDqcE9YFBjWBMZxnYFAPS+RQQe1D8VzufycZemTC8eKOrSWYztf/qrLtXV37gLdut5YImb8N+P9Ltt/oMcX3HHUgUvAyBFuWXlJbs+griiCXzsWOaXR7xo44vH8YFL8EfRVtTAG0FYIEgN1SKFxcnb+HDSZRFx1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360372; c=relaxed/simple;
	bh=JUNCG2YFubDOFciO8VRpkJEWUm7261kRPD8iDC3NDAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/0fCUjofCch/aLOi2hvPqeh3gS4jHEviWDpxANuhOsC5JK2ep+08GwuTWMM6HSi9gMl5gVA7DQcnVJKE379d37Eo5rB8p7kvzU+nrUv32GfL/TOXvsLHW56Zivn6l7vTufv2S3nfD2FjlQlDvh51jjOget+TQ/fpySN5VRqsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDkqVCg9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730360367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iTyJVQNtcPskjaiO+k4YIfe6zjh6T7dLOMCvlbiHr6M=;
	b=cDkqVCg9oxtpzD1LVYGGzp8/9zvAgho2emYCYa/1vJstNrHOUwrSjNbc2vXs/BN//km50w
	pPciMLbVaTdRVH28e+j0jr8igZp+8gDxPlkz36CoP9r/0yBvx2GN6VVUJ+hJ4r+zwkgGT5
	20ZnHRCF6fQd42waacNQIjXeCVuJz54=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: yishaih@nvidia.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/mlx4: Use IB get_netdev functions and remove get_netdev callback
Date: Thu, 31 Oct 2024 08:39:14 +0100
Message-Id: <20241031073914.2368421-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev
functions") removed the get_netdev callback from
mlx5_ib_dev_common_roce_ops, in mlx4, get_netdev callback should also
be removed.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
compile successfully only
---
---
 drivers/infiniband/hw/mlx4/main.c | 35 -------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 529db874d67c..cf34d92de7b1 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -123,40 +123,6 @@ static int num_ib_ports(struct mlx4_dev *dev)
 	return ib_ports;
 }
 
-static struct net_device *mlx4_ib_get_netdev(struct ib_device *device,
-					     u32 port_num)
-{
-	struct mlx4_ib_dev *ibdev = to_mdev(device);
-	struct net_device *dev, *ret = NULL;
-
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, dev) {
-		if (dev->dev.parent != ibdev->ib_dev.dev.parent ||
-		    dev->dev_port + 1 != port_num)
-			continue;
-
-		if (mlx4_is_bonded(ibdev->dev)) {
-			struct net_device *upper;
-
-			upper = netdev_master_upper_dev_get_rcu(dev);
-			if (upper) {
-				struct net_device *active;
-
-				active = bond_option_active_slave_get_rcu(netdev_priv(upper));
-				if (active)
-					dev = active;
-			}
-		}
-
-		dev_hold(dev);
-		ret = dev;
-		break;
-	}
-
-	rcu_read_unlock();
-	return ret;
-}
-
 static int mlx4_ib_update_gids_v1(struct gid_entry *gids,
 				  struct mlx4_ib_dev *ibdev,
 				  u32 port_num)
@@ -2544,7 +2510,6 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.get_dev_fw_str = get_fw_ver_str,
 	.get_dma_mr = mlx4_ib_get_dma_mr,
 	.get_link_layer = mlx4_ib_port_link_layer,
-	.get_netdev = mlx4_ib_get_netdev,
 	.get_port_immutable = mlx4_port_immutable,
 	.map_mr_sg = mlx4_ib_map_mr_sg,
 	.mmap = mlx4_ib_mmap,
-- 
2.34.1


