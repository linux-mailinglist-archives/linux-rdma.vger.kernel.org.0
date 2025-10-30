Return-Path: <linux-rdma+bounces-14149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8042CC20457
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AF6405A0A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83AF33343A;
	Thu, 30 Oct 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gdKMZL3n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3851D5CD1;
	Thu, 30 Oct 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831249; cv=fail; b=Y2xnaCylTrEjPusfvybiELgAjFwVhuHoRm2OCkb0E6QxC5QYvBtjnRm5mz2eYpN/MjrRVvKz6I93I0e0awa2/nvco2We9TYgMl6hSR9cqVqeFfF3wUEmiMDSYj5uv7pX9mluanQoIRUqrERkdgXpbU0vNqZzHauf+cIiA0/nLHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831249; c=relaxed/simple;
	bh=mut9atht4X+EJC5RcDu+A+v60wYS23pDvB8/Wwlf4lI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvR9qUkSlKDEfs2ys2A7M5nbKDBl1ae4wDMDKEU2/4NQKRHi47/1+Ukg8oLgRAa69j66sRQ8c/pxTLIlWWswn2p4fK2sMp9KP0jajGh5jhvI6NZUmlhbp3pqLQ4WCRew7TZzW+GqE7iXC93fVqsvkWEKZQ6EzGF0SOb4HShQHfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdKMZL3n; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag7antoS2jOwchVK7EEdqR0ofeUBXWzB7mDBANXoV2sGYySBcxdFMhzjBPZl53Z1TwiMIMDjENTfAvWCIXCX7k1Au70/PcV9sSS7d5xVrdsp844JcWym/PrPTI2IMENkuq1pKtHW5VLkztBhSWXgwtWqfH3vD/Dzg0uPsT0AkkyEKaCyKfVvbSCMSxtDBWRjA4Jek48oB7rGt4U9dTre2w2ASkbDQ0tOmhzdst96/8PFjVxIzYukC9wKR6p+mK5JYABFtqcQN0RzuRvfJYECGZ6p8CVmV1q03zBSwv3BeULI3Kc4HOEw7L6rXhOxi2HVvO1/bpMbyMKmHla334z1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CbSUAUF1XsOhcRSJAEGdqgSKK5yUFVvxT9zDw/f8dk=;
 b=Td5K6rRQY9YyEdwtne0BOKm3IPiyibq/YWyepBagXCR5XLgj1S9IeWBuZy9s0TvXeRE72PuFUTuPOPv0NlMW+7xV6/pxgO2nYSo2rooLouOUY6Sx3GdOsUgst+X00et/DzeXNCoYGMsA7HaN6Fk9vtNKNSXTOx0fBKjPW0KJioTVW8dTqjb/z9SMP1PUG6drSwH4ev+nX4nVwCEchqkaPSQ9Y/6Y8q+pbBRWHxjvAtaR/WlH1Pm9KqJOCob0zkpnZdehX5O7CPxohbzNWqyhSqZYBEt3NiEUKCrVIMzSPN+Yw4Fq27LcSg80Aw6HYWYNz3ZGauw7BnY4TtHuz6UGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CbSUAUF1XsOhcRSJAEGdqgSKK5yUFVvxT9zDw/f8dk=;
 b=gdKMZL3ncQdE32/MFFBlJS1sKuv3G+2bl7NkY2+92VukJwwFM9faDPRFE6vtQD28amHKCzMO3lLMiax3Er8NuN5DCDnk9TUdACvGVZGAJZlA9CbE8kY4lG6GorD+q7bHAYY3Lh6OLhcWd+NU+oLTnY9dTJ5z7wT3vZM+/lpLCxEpehlR848DdO9FnIgaRD6VwqAKMzD3wXLr2qn8+k406/mQ0XcjKNUEb1rqYiYw9+Owv0FPW+Cia4LacIGKeyP4T93aLuBNEzFfBM0tTDrwIHAgFensTk2EBWMjpW++NDVR7SDiWzaV3iomhCWAOJ5qS6oTSTXNbof+wcsbLcyftw==
Received: from CH2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:610:58::24)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 13:33:57 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::81) by CH2PR20CA0014.outlook.office365.com
 (2603:10b6:610:58::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 13:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:33:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 06:33:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:33:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 5/7] net/mlx5e: Do not re-apply TIR loopback configuration if not necessary
Date: Thu, 30 Oct 2025 15:32:37 +0200
Message-ID: <1761831159-1013140-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: f0345564-794a-48c4-cf0e-08de17b8fa41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?og2IkRyUvcPRofpYZjkvVywSlWF6X8GSPBPVCQhTYrFpP802NlgDR0nVHm2z?=
 =?us-ascii?Q?eAB8eETMA+CgIN1QyZzKfeUlDQyodmnKtyyyaZrhymEtkQugywZONq2sGiCm?=
 =?us-ascii?Q?k/qd17cY1XqOOSbbEUsTA+PBDvcz/RqKoAuSRnnvNVaToOiUyTZzl8DsNFVG?=
 =?us-ascii?Q?zh8ipsaEy86UspNilXSFNBRqmiKVCQ32M/y1InSm/AGLhAwHjnw2Rpq39TfM?=
 =?us-ascii?Q?rQvrg7zC1IJYHW71rrfMozP+LerCGHxXZJhvF5I9v05twb7CSVdYyqGP6RLh?=
 =?us-ascii?Q?d0afWNBirsgd3u+AIkHpNsvuKZKX4s2CMmfMg2G3RXHf9pVvYxNBImEg5ea7?=
 =?us-ascii?Q?zwNS3Cn8AeTFTz7B/kg6xJIqbz7LGT2inRbpAYWaDUcA1kOBCg+3/OBuYXfD?=
 =?us-ascii?Q?XIGThJDQr3hUB3RtKNityQJa9Qu7bVDfaoj8DvUqSskw6vA4YCjS+DXSBOlK?=
 =?us-ascii?Q?f/G5VcS+nQ31D/Vc+h2gk7ZSmzHt857WdFhOxwsCvtWPsOXPx9DT/FcXddXh?=
 =?us-ascii?Q?zm9zOLdyR8PsJ4eatqnTDxMxII+JTEkFVanQ+1/b+kerMO4kiZO+2qVv+4Lx?=
 =?us-ascii?Q?pV3S191wicHw7ibNj/7NOvyly8CZYH+oIlA1a/dh2acoNQd1vHt3GD9MwvZF?=
 =?us-ascii?Q?hSMBcEoaIH08C/ZQiqNptVe6cw5r0kYPe0vnLHgoSY4UZLpXxVTz7sAUGyLH?=
 =?us-ascii?Q?iuPx6GLXQHszlowXrkPHILdqLDMG6EsvwpcPx3JUeP7YxYW4tkX0cbdgp0Jx?=
 =?us-ascii?Q?ApQoeSoMoLZkp3tlrkRnw/c5hWQT5ys0CYH2lj3/wI/jL8jHL1u3n4PtAPNp?=
 =?us-ascii?Q?bJxAMqaDrVyk/2viq2kn6NRfOwED2hL1JwEeTXYFzx3tj8IU9cqdfkv3p6ar?=
 =?us-ascii?Q?UFD9wTfmsLsCT9teH+JhNSc/FN/JuugRKXu6hkHAFcQApvQaDS/d+pisaYmO?=
 =?us-ascii?Q?3UxyyaXOPvhHFeDyHXYNotgZbn3zL5UloUKQoyXJA3X4d3qlOY7BVdcWeyzd?=
 =?us-ascii?Q?QdnPVFsKZOezIj950dboWH6vpW88fMpXTh+oKWhs1tTlYgZFKc/Giet+hnuQ?=
 =?us-ascii?Q?a70aS5mBfvzhTEy7LbCLAZdCQ+PQF6i+7MhoAakczGc/FcrxxBUa0JdOW/79?=
 =?us-ascii?Q?7cQBE2iM5aSjEBMiJamo1NC7mLoy5eonXe4nDHcanDXoOv8IKa5bzP3DwqMI?=
 =?us-ascii?Q?3/qdSIOtTb3HANXsC78CILr/Nvc7ubNH8/mf8DE1MC6/e176lqNATQTFV661?=
 =?us-ascii?Q?1wAOt6A3gkCz9kykAc57tE5RvX0hWzFQJLxSKWlZZY2lEry8QThBqRCdX8a2?=
 =?us-ascii?Q?6FzArUf9Dh/+cfLwGbGX3s9MHkdzapys+fNrqmymoKYvMiRzwez97IQVijRD?=
 =?us-ascii?Q?sHrgzIdtj4frt60lnHdYf2ufA6dFjJWWz23fH+WEa0JGNSszRJUW0M560DiQ?=
 =?us-ascii?Q?ERma9ndJqltjh5HFEAl589uGi62G4cfluYgrpxBuIJkTrLJop+J1Rz120QF8?=
 =?us-ascii?Q?lLm/kXuGeEqkO3tvBjMMV/GWohe33SjxoPBjRIdOez3C2LzBdB5UKs9Ainrd?=
 =?us-ascii?Q?w3J4P2utbt1ofpm3rEI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:33:57.1584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0345564-794a-48c4-cf0e-08de17b8fa41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

On old firmware, (tis_tir_td_order=0), TIR of a transport domain should
either be created after all SQs of the same domain, or TIR.self_lb_en
should be reapplied using MODIFY_TIR, for self loopback filtering to
function correctly.

This is not necessary anymnore on new FW (tis_tir_td_order=1), thus
there's no need for calling modify_tir operations after creating a new
set of SQs to maintain the self loopback prevention functional.

Skip these operations.

This saves O(max_num_channels) MODIFY_TIR firmware commands in
operations like interface up or channels configuration change.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 022a0cf7063c..5a2ac7b6f260 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -282,5 +282,8 @@ int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 int mlx5e_refresh_tirs(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 		       bool enable_mc_lb)
 {
+	if (MLX5_CAP_GEN(mdev, tis_tir_td_order))
+		return 0; /* refresh not needed */
+
 	return mlx5e_modify_tirs_lb(mdev, enable_uc_lb, enable_mc_lb);
 }
-- 
2.31.1


