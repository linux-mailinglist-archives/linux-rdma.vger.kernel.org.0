Return-Path: <linux-rdma+bounces-4389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459A395469D
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 12:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05A21F21D96
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEDB17BED4;
	Fri, 16 Aug 2024 10:18:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5412BEBB;
	Fri, 16 Aug 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803509; cv=none; b=OszaepIF7PnEETtEhMABH3H+iMKLE8kmI2byDQOis7QhpFZs/geLiJ8zEQqGx9QNv5A3VE7lLkuornGax6qxq1xjC73xVsbEY2aSrAT6WUCjr3llAljlOi01rclbmXiiPjAQFXVlyW2sfswTsa5ENBvYWFarZBXCo+wSyDPp65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803509; c=relaxed/simple;
	bh=CjQRIJxnXkH8dlMNl1O4Tk4X+nuSm7+nn9Wu34Fjknk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FArPXWZALFPVmv5fFCD4iDDJwNKMq8qqgsrxYqyQw1msHfHivLRXzi0iu8WzHyhvVXZru3Ane7jymbBsgTKwvFsF0h3oajK2fS9Iz8vE2cOsLdjXOKJPU8X2GdERZxN8Hzc5GfZJV2DD66VHV4aGeXXiOklZAloRUT9ld3zdWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wld9d5ByRz1S7cX;
	Fri, 16 Aug 2024 18:13:25 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AAEC14037D;
	Fri, 16 Aug 2024 18:18:20 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:18:20 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] net/mlx5: E-Switch, Remove unused declarations
Date: Fri, 16 Aug 2024 18:15:50 +0800
Message-ID: <20240816101550.881844-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

These are never implenmented since commit b691b1116e82 ("net/mlx5: Implement
devlink port function cmds to control ipsec_packet").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 578466d69f21..f44b4c7ebcfd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -887,9 +887,6 @@ int mlx5_esw_ipsec_vf_packet_offload_set(struct mlx5_eswitch *esw, struct mlx5_v
 					 bool enable);
 int mlx5_esw_ipsec_vf_packet_offload_supported(struct mlx5_core_dev *dev,
 					       u16 vport_num);
-void mlx5_esw_vport_ipsec_offload_enable(struct mlx5_eswitch *esw);
-void mlx5_esw_vport_ipsec_offload_disable(struct mlx5_eswitch *esw);
-
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
-- 
2.34.1


