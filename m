Return-Path: <linux-rdma+bounces-14335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF92C43AE9
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC7D188C33C
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015C82D8790;
	Sun,  9 Nov 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d4hRBC6F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440772D8780;
	Sun,  9 Nov 2025 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681169; cv=fail; b=gZ24LFk7v2vdxJbV4M9QkmJJMttUxXp6Y8eBxiAVXOT3MMc+V7p0hP8D+GiS6XcxPHZHl3nlhk4T/w5arxxeLX6o23q5ETcZ9XoytakPkbxAGcjm8dHZaSe0BLWpkb1LpJP8Y4QvRmA73o4rCpK1j3TNAdclT/SZjmPhse8/Hd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681169; c=relaxed/simple;
	bh=OKtkv34FYx6Xai89ZtujWHYwECB4Sr0qeCJevKKPukA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/jo2oTtgFAmCIlz7PBB8gJNigmLJ7+EDtwaDhLQbHWbc7sF6Pkew6QxlaS9AMczzEiw+nHujVcatpc3DurA1TgormQllbKT9k2QKbVOoZmQW1WbMbGyoEizk9Gam3NK0MprupJOlkscukHbdj4f26ZLSOAOLNZNxPi/G7nDlLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d4hRBC6F; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNeQxZu3GVN3kqGERuC7cJ7hIX9sV9EUj0fKr++12PrCa6mYU2ZmwbCxu+rcfSGWTT9wJizTsNzeXAF/W1dwPML+9ngFXcuHGI6U5H54eNQWwPVGQagpFlakC+coUGqduzOjrwRIRGto5aqIjpP5fDamr520yPt7hW5Fl0TG2qY4FoTF0q1l+O9O+untRf4vbScZGoeXTjISEMgleRdjBwhYEvBL3D4StgqyXQ64WP+2vRrURePt91ru91QrNAOsHckR1V7c/RZcgjwjtuRy7kKQ9yd8+jCvkHHs5DVD6/eglxdraTtf9VnqQeidccSTCAhGoUfDUM/s6rUG6wwgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqc5Ev1T0u3Fy4rmmQ5GmvBxSB2Qcngtcea5BNijcOg=;
 b=pquyIIylnfrdHfW1fl2gPMwo+vS9LbLHR6maa0e2M/mg3N+B8IJIc5yxA4gqqtAMk+IrNLDtR1f4i9PS5ZXAHTsg2tCNlDdLj2MLpPuWDq35khgtRyns0L/4xkbwJfmcdnel5fpWoQazz01MUZvN6BJI5/0Uro6/8wScijGz3bD85YLsXz5+zVzQDzx8MUsi3jIq33jDDM+ibNNMMow8hJ+9ZFvsuvbUMz/sgUCzUyVZQkDhS9C01zKlYjj8gVxNMR/7D/WQEgXFo++C5Xr/o5ctq3anSHcoRctAymJm6Y/shVIygsAXdGGaRgAOHQykcS2BcW9IU6VAfUKm0Wjt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqc5Ev1T0u3Fy4rmmQ5GmvBxSB2Qcngtcea5BNijcOg=;
 b=d4hRBC6FzLUqqqsn4GlkfvmvVpimJicYP5IMzhu+oZALiq2mOG8GGBo63P5gHgZqiBjBHbX/oS7RzA97rAyZka6ViRd5QU2wKARvoDTsHS9ioXhnF/LFHoj8mY2+W3Jhqkzoyu7H1T2rfvkyuXQ/ZwWC4qW8143oiHRqo0HJi75XcerYP2UdRwUtdkPd0vXyji4fLsqzqVaZB4RMTQpjKMIqTs6dFlZ7/mwTFloz2brKuUmTIRqOTxV1c74v32M4YVxe4tUkOPhn2lz43Rmvpb3brGNS8AHECz549lVdYkrbTTwTzepT47s+dit31IpwA5vOH2nzQcK02JYtEu0ITw==
Received: from BY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:a03:1a0::20)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Sun, 9 Nov 2025 09:39:23 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::d9) by BY5PR16CA0007.outlook.office365.com
 (2603:10b6:a03:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.14 via Frontend Transport; Sun,
 9 Nov 2025 09:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 09:39:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:39:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:39:08 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 9 Nov
 2025 01:39:04 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 5/5] net/mlx5e: Fix potentially misleading debug message
Date: Sun, 9 Nov 2025 11:37:53 +0200
Message-ID: <1762681073-1084058-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
References: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a0b3e8-73e8-4f03-424d-08de1f73dd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DIqTXqAGyc7NSP82Zymua8AGgEQXcxenN87jQaFNgQqHIKmf5KfUFL2Sda2A?=
 =?us-ascii?Q?aPYomuIu/lbBor/JuFqobgJFwtNQ0G1zRvqgMgcJ4xYa3OHyUlrKa2fpIpk6?=
 =?us-ascii?Q?+VwyQXAB+eALlN/xdgaP3pmm/UdRDXPYrGrPDuyiRvU341wXcrQ2UzR4ijyg?=
 =?us-ascii?Q?fkP3rmANBk9LNYQHOhmBmPtfgZ16Z84l0rU2PDao8EJzdhB3yKwohhKTMYjy?=
 =?us-ascii?Q?vqNPf4RgCNaZ2geIUix/h2SsH3xmWZdUqBUqXFX0txHxPEHaHC9CrdpGyYJi?=
 =?us-ascii?Q?Kir9FVhwnD+gry75y+A1FxJluUMoLOZNB+1VXY6efcveG4wFERdaRIxDZKK6?=
 =?us-ascii?Q?W9tEcaye7paGtrVqHdk2pp8wGZSC7DPmaKRq3U3hnRYlt18Zzh9vpqcH4Ynm?=
 =?us-ascii?Q?r8oC1emNhRLUQ2qYRShu0sBHgcdlLx/wpdRjLozr9dANoyx5hLt4g+S0Ifg8?=
 =?us-ascii?Q?WO6Y7a+SDkJh5p5YJBufPvPHdZYzAobcPduOqkav8HoO26zjnrrUEGWxfDQe?=
 =?us-ascii?Q?DmkzQb0qkwUY9mseE/waJ2wlQapE5vjW3F/8aixIP8qEesek6KXkndibCyAB?=
 =?us-ascii?Q?+t2oD9G9Yuuzb4dUzxXQciER+LfEzw43FoO6CqkkNqT/uLbdgCTOb9H3lqj7?=
 =?us-ascii?Q?jEETXtNWExjDH6M405m+pxvOE7u5k40lJOWzlpr0Eae2NDCN3lmvTsjF5cPh?=
 =?us-ascii?Q?DkFRNaIXEUO6zhYzoFG1SzovndT3ZEz/MZakdVCU8bTEZNKA8sIO0o5/odan?=
 =?us-ascii?Q?iStsLzghBwcwpEeETBwBXkzvFzJtBNomw0uHTdMHfCveYlBdjJ94Kdc9S7GB?=
 =?us-ascii?Q?DbkmbnfTQUJb4u8mfWWWJTGNTMZqgD+wejkDiL3IENb5lb39Wq1J9sWTaRwi?=
 =?us-ascii?Q?U+0zQb7TK3WziuNbJLYLXzj9IPMzDeeH2zgpJpYBafqfDvfbc3Era5sl+iZI?=
 =?us-ascii?Q?8LzGRwFMPJvGsx0aoJ2l77Me9GldPvfKOJttJ8DelDij+8+S3V1G0JfHybvS?=
 =?us-ascii?Q?9uFwaUegfHq+q5y5z9iM9hNUS9OFuDF5kNmL3vMic1ijumFJtHZnLBms7YG3?=
 =?us-ascii?Q?cFhnAZiHeYGCc4LiAF8D6R6NmtbzU0DvDEBHHrkYg2pS9KzsfxhWyv7m6Oi4?=
 =?us-ascii?Q?+5SX3HzJBnp+qK//Gdsy2hHCgQDPJSNPUC8PGyOVWsQxoyU5ujt0aRvuCBxY?=
 =?us-ascii?Q?WigKIcwm6gYKUM0naJvPsVuRdAJc2/yHbXFWJHhdhJp46PrbXEftbkvX3rY7?=
 =?us-ascii?Q?QiZQTHy59Awyo5cnWY3Lxj5cYCVFMRuNo9ccvclmcpXrYUrhfb1ALW5DbXHh?=
 =?us-ascii?Q?5a/mMm65omeTgRQ3Rtgsf6DD0HTxeBHuXt8MQrkyjRFpiqbanlz8gFSt3tw6?=
 =?us-ascii?Q?VkOnLE5yiX2LVgZ0kCsOGOFsfK+ZTFLzCjehCDMZ2Ohv4aIiogrpYtInB27C?=
 =?us-ascii?Q?RTRKCLNu7FmUh7LUMNYfRcXY7JBpcwmGr22Vlxe4t/WMgLdPMIV2e7YRuKpR?=
 =?us-ascii?Q?oeonuqvM0kz9Dd2yWPwgZbeUaVZ/jaNBeKV///y/C1w25qM0xCv3tKEbd4f6?=
 =?us-ascii?Q?AnmX1R9ivVeKVgl0fuY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 09:39:22.6468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a0b3e8-73e8-4f03-424d-08de1f73dd48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

From: Gal Pressman <gal@nvidia.com>

Change the debug message to print the correct units instead of always
assuming Gbps, as the value can be in either 100 Mbps or 1 Gbps units.

Fixes: 5da8bc3effb6 ("net/mlx5e: DCBNL, Add debug messages log")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index d88a48210fdc..9b93da4d52f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -598,6 +598,19 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 	__u64 upper_limit_mbps;
 	__u64 upper_limit_gbps;
 	int i;
+	struct {
+		int scale;
+		const char *units_str;
+	} units[] = {
+		[MLX5_100_MBPS_UNIT] = {
+			.scale = 100,
+			.units_str = "Mbps",
+		},
+		[MLX5_GBPS_UNIT] = {
+			.scale = 1,
+			.units_str = "Gbps",
+		},
+	};
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
@@ -628,8 +641,9 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 	}
 
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
-		netdev_dbg(netdev, "%s: tc_%d <=> max_bw %d Gbps\n",
-			   __func__, i, max_bw_value[i]);
+		netdev_dbg(netdev, "%s: tc_%d <=> max_bw %u %s\n", __func__, i,
+			   max_bw_value[i] * units[max_bw_unit[i]].scale,
+			   units[max_bw_unit[i]].units_str);
 	}
 
 	return mlx5_modify_port_ets_rate_limit(mdev, max_bw_value, max_bw_unit);
-- 
2.31.1


