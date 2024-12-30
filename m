Return-Path: <linux-rdma+bounces-6764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D79FE6E2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A93188195E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3E1A9B48;
	Mon, 30 Dec 2024 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuKZcnLu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD613633F
	for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568050; cv=none; b=c3ZdULiK9tb40nW/uLLKjQQjDTrngiBLXnmbnz1/NN27ymMH9+hkoQG7hp9ukvROSGM4XbNPlYVJmlFo3RBAsZyfcRvRgRen9zHBbfNxwOnWHjh8yd3jvSsenvgSAE9tK49aKuqxijAUE+IZ7nnjBvrz6timl1snLw3tPoW3zxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568050; c=relaxed/simple;
	bh=n14qTOgK4+o4OOKTNS11V6IYOsOA04BTUYKos4b00S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mumiNTS5U41U4sz9vdsgM8uvSQk+9sy2LqxGFvC7ZlFqvPDU+JKQtMBxQmRxgkc39ptsrUIS4FPBkE6IX12uF+g0wGW2SB1MA7Kdo2QXWjoLYW91R8r6OyZEG0wRXortTABahlSFMD1bOrD8SXj/WO23JIfRwnhmLAVU624ePAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuKZcnLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D9AC4CED0;
	Mon, 30 Dec 2024 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735568050;
	bh=n14qTOgK4+o4OOKTNS11V6IYOsOA04BTUYKos4b00S4=;
	h=From:To:Cc:Subject:Date:From;
	b=nuKZcnLuGGBu8KT/AMriHC97QykQrQT9wRh6iRIgQPUl8cHybTkt1AEoIsbZZek2D
	 AGnm8h1+jZBQa5XYUzy2zOv5qr0EEUSMydtQ+rMDD7utJ8ghMwE42AVNbAz1xGc8Ju
	 GpWBmvfcLoJOKuiKzo2BsNwvevHxVmr3zpUDbHD7YDbo4luzKAw3kgQZki8nzrUNbX
	 XWPIhsuZgfz6qz1z095tNyooE4+iSdCgoN54aGFHpSt4wAHQjtRXa3AjHbySp4Et2n
	 oFL1xepyZrMXaUR5rzZ7pEQFoYmy9AmDIuvmKuhM9EebqP2DxvUfKML0zSOse+uBwr
	 WeItTV5Qto9lg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Yuyu Li <liyuyu6@huawei.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix link status down event for MPV
Date: Mon, 30 Dec 2024 16:14:04 +0200
Message-ID: <d7731478e456f61255af798a7fd4e64b006ddebb.1735567976.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

The commit below prevented MPV from unloading correctly due to blocking
the netdev down event, allow sending the event for MPV mode to maintain
proper unload flow.

Fixes: 379013776222 ("RDMA/mlx5: Handle link status event only for LAG device")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9ea1869f2ab9..81849eb671a1 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -242,7 +242,8 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	case NETDEV_DOWN: {
 		struct net_device *upper = NULL;
 
-		if (!netif_is_lag_master(ndev) && !netif_is_lag_port(ndev))
+		if (!netif_is_lag_master(ndev) && !netif_is_lag_port(ndev) &&
+		    !mlx5_core_mp_enabled(mdev))
 			return NOTIFY_DONE;
 
 		if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
-- 
2.47.1


