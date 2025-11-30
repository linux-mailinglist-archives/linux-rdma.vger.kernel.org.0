Return-Path: <linux-rdma+bounces-14836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A12C94DB8
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D4084E290B
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D64279DB7;
	Sun, 30 Nov 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZLDSnW00"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26492279792;
	Sun, 30 Nov 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764498405; cv=fail; b=lQRdQVWmfybSVuMcKc7Mbt9CEyP6KfXAuLK0qpHMPckahqDkIq79ojD1mQIBojTXh3UTleKet31jtM38CzxfcJJ6c4gPKFuzK6gJKDBArpYa3LcC4aHz10LX0W+R8CMVivO2OhFGjC18z4q9dl7QNFs6p/EU2dANxqV1e0gD3oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764498405; c=relaxed/simple;
	bh=4c70czgOrx+xd01rc/c8ZUmT74bq7mtvpE1fIfSYdr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj8xaktf8ChUKLfAksmHfJJLDgGOeZKd0JZA8mIG/8m/7Eiuv2sYr/53OAxqCcxexyddq3Mp7cs4XK7CQOXQyaXsdMvD+/N561x5kTjSxsUPbPWQbN4ByiyZF1H28QezYsMWS1TYdkmQVGuemWXOOgij3FY3H7/qVcK+qqeWA5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZLDSnW00; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDMUD6+p7pp/qs+4hi6utIRdg2k6Auq3e47fL+iLh8TuSfF08K9eEKfSds1jENPPuUxfvhzy/wiE/mUpH96KIgxA+fmVVWNLYedKCaIJsd4TLv0GXSlgG47pfQ7TwpeL4vRwM4dUxPx5uArkWI+EC7tU8fgYFN0C23cLa3HeJks/gP+HJOWOegg3AVD/JT8iyhad85VlBenC5Fc32fn5ebf41GdI9yu1WIluCdU81fdSlPgfDlU5SY1SEZAIwdgVfIUCNGlMEE3AE3vWGa9OwGSj1IWLq2tK3Bzpe71rGGFnqQN5gv+8CWOQu451iP4LGsKx3x/Vdp9wKI1Z0yCgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzE8k5pmsrpbWlykXpehF6fj4RhM3jl5YAoVdMx6m6I=;
 b=OEt+Fl5aA7N0urLL681BDJtsWoHlXHq+Rod6Cxw627zO7cBD4kSdd8pCHCuFsK2uc2ltb3yakU9f7T6Q4Y0itEH5oR+J6ejBYJNb64JycgATSLWtTxWz4l8fplcNeKIFC4y6SXqm0jYzynHKS6Avuvv+UmB0TwfAdfDSPNs8Ge3aGzKAheRWSYGSD0sf2jdD4GD271uU5SVPfvTNnrg/k1YQ9TKQUvpvk8vURvzgZRaBSJqOfHxZmhe801yJzkN/TaCT1Exu/PgCCkAeFfcvFuE3V2vmirN5T9VlvYq9DtPap3FFcjUPKhNXWjFzc8Ig4/dV9gyJbLdGBX5esgLaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzE8k5pmsrpbWlykXpehF6fj4RhM3jl5YAoVdMx6m6I=;
 b=ZLDSnW00wrQgCe+xH1Tn7TKsE3HNSo9e6tC14NDjVezyYz9/K5GIorYPQreWaM47oQNDRfyXp1SrKcuAilo6rdtg30xlwcJJ8+IFBx74FP7+bqXk1Ed/Dx+s8GTyCHWPldhCZi+uNKts3+PqSntYTpq5+/HQlUVtQ5h7GLPg/dKt4bp+7C1lzcYVQD0Q+BYBySWZaRAUQoFwDKVlmA5P4MRozgm13cfPYOJdnVuFmXg3kad3zHuZ9YmLW68NPse4BKZZx014CNRu8L3SFip6kH1w2+PBE6hL88ztiVZ+2KhzlxdCXgnMWbJ7AOIfOOQ4Sz58H6bbkiyyR/JdsPf4ow==
Received: from CH2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:610:60::17)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:26:40 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::71) by CH2PR14CA0007.outlook.office365.com
 (2603:10b6:610:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 30 Nov 2025 10:26:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:23 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:26:17 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Danielle Costantino
	<dcostantino@meta.com>
Subject: [PATCH net-next 3/4] net/mlx5e: Use U8_MAX instead of hard coded magic number
Date: Sun, 30 Nov 2025 12:25:33 +0200
Message-ID: <1764498334-1327918-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
References: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: b83a5655-db37-4ff7-6512-08de2ffaf31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DJ1JFt40kUJBR0fHtP6b9Ae/DC168/6kNSPXPC8N+NCy0kEJq6w3BrXsmotE?=
 =?us-ascii?Q?CZDIkzq2TV3I+25ZOoz4wQH5VzMUNuR04Jn4tqM/nk9fULaCZ5lxad3+NP48?=
 =?us-ascii?Q?ogVGc0sxlntMsrULsKJeXP7j9PKbFBmR146vMFxtL2x6yS5nAVrykorvGOqa?=
 =?us-ascii?Q?8sq1vOO0J1CUVYS1I4z7lRXQRibPaxLkJYR4vYV+WYs0yrlDBw8f8ViImm7H?=
 =?us-ascii?Q?R+zMmRwD7m98pMXkI9BUbJZK0G8Rnyvy5+F/PxWWoZX+i9CmTSev9KDOzVyM?=
 =?us-ascii?Q?1m6vYOFBWWVmxWz/gXSZoqJlIPLdMcobbMF0AwEXuX+Tw34IgSQ8Alq5qvvi?=
 =?us-ascii?Q?ZR1qDfKr2iXQaywx7WDuPbsu60WOFPbeg8ZjF7+AKh7IfdGqQtY9dL+glyEF?=
 =?us-ascii?Q?NcfcwtMiiBAhzjcrhdh1l0ds28Ra8w5CJc4JYcsMvUbCJ0x5jcFw2/VfSf3R?=
 =?us-ascii?Q?FVErFjSrniTAtC7INZnFthdmCAskCbtwqpo2d1Dzcvol7XM1foP2wQRaO72C?=
 =?us-ascii?Q?wsvNIk6GVFqFwcfgZTJrdXUw6kCsbLWwRpHd7JzGUeZkGomC/+KWih/l9MSo?=
 =?us-ascii?Q?wichXmc+Qns7pjceVCgQj4pHZ+2oT1oopmQMMRK4HsYqeY5EK81R6qZnAlOC?=
 =?us-ascii?Q?ptziE3n0MsbYYBfYeDnRqks1x1kMeG4JF0hve+D4UZ70YenbD/i++0hTUf7Z?=
 =?us-ascii?Q?18BDrAi4bcqFA9ofI4kcP77o0J2AycOcTn85MMm2hXxNFYZM9DH79IOEIxeG?=
 =?us-ascii?Q?IV6rkPOP2vMFckzI95FKCMTeaUj+86mN5JjgJEUmpnqj5xYGzn2/BchmGjBA?=
 =?us-ascii?Q?nkDDPY4KxR2ql5kRVNDYURk6z2BuQ5w24SprQ4DOZDlnYiagLhNHAtC2F76j?=
 =?us-ascii?Q?0yUDYUO0s9kl1xmjtupxrtyIDtTHIDi0kksLBJ4MUO845OcPBs/wJYR+DFBo?=
 =?us-ascii?Q?vkPrS5n02YS+fCuIivR/kcF5y2sOrwRER2voSRBDd3l4mHtTeLVvder8WQD/?=
 =?us-ascii?Q?V2GXrMBwJ+jyKW4qjKrq5r1FLm9lMTG5JUBExM59w8i0ikeQ8FAt14Dp1L+O?=
 =?us-ascii?Q?UPRwkG/NI/ZEvjqLpKRO4qaaGrMgr/f7CzbNaviyq49oiuNsZHIkUzlt86Yp?=
 =?us-ascii?Q?ogg6qP8tmtL38xjHqgqIj/54hZzqArqEjbDwY2ATORo4sVOyMzVn6t5b1wh8?=
 =?us-ascii?Q?4jSsqoLmJhGkdH9ycOn9dMte7j2XYMWozHqHUi0m5T5M/ANZDdy6kIHLuxIA?=
 =?us-ascii?Q?dggWDyfMSLA1JQuG6tFpNbjcC4hLvo245SojkE6prKC07uNE752vrVhbl4l9?=
 =?us-ascii?Q?kxJWe3BSk7uNVdcWNmMeLqASBDT7Aw3fybtdH8hmjt7fX5JqGREbg53O4anr?=
 =?us-ascii?Q?mD9r1pYnqgx/pf2mTmgdkWH/RfvdBfFl4iHDFE0urr5diGqcwY8CjAIQDVpp?=
 =?us-ascii?Q?xUoH2der3d0bfvdsRBhD57Ej5/9x81U9FWjYpl8NFMbG5qpgR9JfcNWhOpGg?=
 =?us-ascii?Q?MQKDUhYPYfXv7Cl3+EVnohXT1pu4jWDFvIKY8zirfdna+zwrNtUI4lTLyXAw?=
 =?us-ascii?Q?R6V6CrfnPxX+wIJgf44=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:26:39.8930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b83a5655-db37-4ff7-6512-08de2ffaf31f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

From: Gal Pressman <gal@nvidia.com>

Replace hard coded 255 magic number with U8_MAX (the register field is 8
bits).

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 7127442f8003..79f9d43b09b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -614,8 +614,8 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
-	upper_limit_100mbps = 255 * MLX5E_100MB;
-	upper_limit_gbps = 255 * MLX5E_1GB;
+	upper_limit_100mbps = U8_MAX * MLX5E_100MB;
+	upper_limit_gbps = U8_MAX * MLX5E_1GB;
 
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
 		if (!maxrate->tc_maxrate[i]) {
-- 
2.31.1


