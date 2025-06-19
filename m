Return-Path: <linux-rdma+bounces-11463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05405AE048F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DEF170C77
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D602512F5;
	Thu, 19 Jun 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nh9CsevB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C32512C3;
	Thu, 19 Jun 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334179; cv=fail; b=MLoF8CZDz80JGPoxErcbM6lLaWIWMykn/SjZGbNKRNF73Yihyh8bqai1gXbzzQgg2y5b6AW3pIavBg4uEATvDlhJOY7+Fw8o0Qw/YMawKJP0rpKjAd/HKfAglp1KRJWysnOgn4NhONI4FUAJoouNOeDAA55DPVj1O9hahf7rtf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334179; c=relaxed/simple;
	bh=yU9qX4QWkdm0HiJGgvc6bhcrfjQpBUuzUWMC3nmhf30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLPO5avPQGgu0e6T/F5iA/xFEphR85O6Ih6O2ummcwscbB0CuLOQ5mpS6EJopw7JFPuus9gDD3Gg6PNv7PM9Yirgk7Gt3DPKHz9dZ3ec0+dJzN9sw8So+WCoLZqmBY0sDwD+FUpVdI5c3M1IMRDNwt+Uc90HlWjbwoZy1NfSjp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nh9CsevB; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwigwQQnJDWUMFl1oeoli/LWOvAO/NXgzAgczzFh6Xh2rq2IexWQ4ri94mcTaCk4kTzsMx3NUz6ROAxAUZIAPRRRetQv6Fr+3wVKCkRA3tp0pIA+eJFSXH1QorBA8AiMtssiQSbs6FhUeCVkKS5+WXKja04xQ+DmgnmXCTp/HFdQdS0ZbjLuEuXOeAS2hN0HX3vVltf+Wv9VAWCsXz47Zwi+ZpQ7EES0iyTOLGeazbCGZ5pA5WrC9zB0PPUws7/lrDlTEvIv3P9oZV1JOH79wzQDJkd9Ud6bCVGIw7I6cAKm/e4NY4yT2n7EMwhs0UXe2BVlQ5XURJLE1mbJ3eBGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7gy8/RtDH03zPU87GIEWJlarXtse1XhrcI/p0mpGOM=;
 b=HjvgvjodI9hcHxwOVuD+4tL5fjsWv2YDyJuJzAp0xNhbtzKwNTXjhXAbsEDRm6mG9k/XwSGzvX9QEz7mQq2uHcxsi0GtR6avld/W85IHFXpYxw+oIh/76QNdjF1dgVydrb/Mx0uWbzfUa+iiQ7+IWrXKyve0JZKPe2LJPNaew4w1y7P4XosFCLa4x+ZE4XcspMzsAQKjMfM6Gp+rQSHKZYjXqG1cfVQ45OdRxo2MTuOmTmUL6V94t/x+/16lora/lQxR/uFfyECSHZXdHrta1a1SZQj1+mkZpwktghWsTYCd30UYFIc4/TIVDHyURYWJPQad4sLpJukJ4BJstyqmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7gy8/RtDH03zPU87GIEWJlarXtse1XhrcI/p0mpGOM=;
 b=nh9CsevBa/OS7eojNr+2YAzpA2Hm7DEx/7woQjpaXqMGbccXHYr5iCFFnyY7WOr+meqNYC1pO8DltWFEmKl9cfEVenpHf6+JPLHznTKkYKWPu/Zl58LyViQ40f7/OXbeSt6dcYFD/Bc2iox20pXZQMT3HZmYiTiPcM7NhWySCf34sCgHPsVRPfdyeXvzQZwy2Bk9iOW2Yyxm3y37OyjNbIZsEwKAc6LykNj1piJyeWEO6n5ej0fXNzZ2oqd6W75mk59eQviO5/eHPNgnzsjkzB+ObUb8ThOPYPvOYKTkKPoekdsJWnJX7BzSLLTZTL4k44Gbslvd7jgfZAo6SgZ2qA==
Received: from BY5PR20CA0007.namprd20.prod.outlook.com (2603:10b6:a03:1f4::20)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 11:56:12 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::a4) by BY5PR20CA0007.outlook.office365.com
 (2603:10b6:a03:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Thu,
 19 Jun 2025 11:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:56:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:56:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:56:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:56:00 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 8/8] net/mlx5: Add HWS as secondary steering mode
Date: Thu, 19 Jun 2025 14:55:22 +0300
Message-ID: <20250619115522.68469-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffa70bf-638b-4b6b-8c68-08ddaf284936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wRh7XIPZKSAo9YrlRHx16ujl82S4UNzH7hMMLO1F0h8kbrolasn9XTlLAaQf?=
 =?us-ascii?Q?x6UlsUv738rLbVv6elvpZJA605UTD5NVr+3jQOgpaOPRcRfGXcY9Qeg/Cnly?=
 =?us-ascii?Q?crm4bZoQ1JuvfNVP3XSa9d23UzfkVGCZ/WxZWtyEFwF+vtdH7DIiudUjDgfS?=
 =?us-ascii?Q?AqVWwXsY6TutipZrWpJEGvKSgPacSW9KammcyPjIIZcC8k7eKSdF9f8Z4pWL?=
 =?us-ascii?Q?kcKvUZab9yNiqmd35ysFMZoUu5ZTPK7lUSKA7lB76Di6bzwuX93xqeSKbV12?=
 =?us-ascii?Q?TrkVQPPpdJFVP+5cObSz1K9LH89+wbbjJe81GkrUiXQxLrxSVymGG+XYOp05?=
 =?us-ascii?Q?ymNrO9MVbhHTBydZecyFmlEL/Vzv1Oebfr5beWpJNGwMLOwL59ayjpr3b1zr?=
 =?us-ascii?Q?vsEAViyjXLS1rw9cKzSsbAMGGYyj/u9jpV6qVT+NCJGOW/FZwBSCXe0rs6Rg?=
 =?us-ascii?Q?j7iW6KluBFIYm+VtneOBAfBa4ca7BMu9FAOefQ0EkGhZbchXs36wn/uwS7wI?=
 =?us-ascii?Q?L8jeav0EC6JKNwtdp8S9gluINQojVvgLoVw7Bf/Clb1eHmsn5np+pRppW61Y?=
 =?us-ascii?Q?mSm/sAYFkaFeDuAf5op9Y3bKUlkGEw/QJcyHlwi7LzbA/Nb5wMXhd7GCJuv0?=
 =?us-ascii?Q?aj7vSE3PPdeHgLEqD40tjjkCTzzWEUGKe9KD/jVIb2B8aajqGfub9zclaBMR?=
 =?us-ascii?Q?ZxsRxbF/Bp131RXBTg+ffabMwwFZfI7rPRq1n+NvRC4lLOXzPaqnaFgu8KVt?=
 =?us-ascii?Q?OreVpjwYhKGgJbXqt8m2HXoxzTVfZOx6bPBpCITBbdv3DG3wlPQevTY3liL3?=
 =?us-ascii?Q?zz8rdsHuP2qVueOQB8b1I1esNW7YT9H/uvkrlDzcQBbT+8dEHFvlAqTlm8MS?=
 =?us-ascii?Q?ZvygqMCMdPtlFwGq7YPMh0nd1dGsuCLq3v4b2dYqwJD/l+MTrwfPuAXEJEAZ?=
 =?us-ascii?Q?Xq7J3QJf0QVImpmebQoM1Vp8I6XgUQgANwoxJUmYI6lwtUjwAoTw9ljwpl/r?=
 =?us-ascii?Q?lBpxrGOnzumSiCrOnwCiITPCDXY2LR/f4rbvVwdBc1GrIGu+yNsia8OmcBoW?=
 =?us-ascii?Q?5BmQ7mtPeK3piJu+eqdD1/lxPiungt3lan3XsMbs7mUyW1Ya2ouJwwPZtqzs?=
 =?us-ascii?Q?oRcWJdeh1h4L8Pvv7p0UPYt+sJnz9cMFeP1LINTbM4KC6EzAd/DwGZA/EW2P?=
 =?us-ascii?Q?GNtTVoShybiHLE+iWbMB/TcQM6BWET7jayGSAucIEUeLZpkP3kU+NFdv2Vva?=
 =?us-ascii?Q?TyYNWTKa1PqIW5W7jV8nvQeCbuiEj3jolh9H2hvp7LGSOsXuktMslFR536NH?=
 =?us-ascii?Q?WtVrof7Eb5VCoN+1onPVXrSBuZOlW3lOEw6XqlAPvAUA5OPGrEY+J8Y00FNJ?=
 =?us-ascii?Q?vaqgrxK+tUdsHbKylpWfRHbgLe6K6jguf8/6TJlGA0LpJsyiQI4TUYzrU9u/?=
 =?us-ascii?Q?HA1qLNBqwbkpOkOmiy3l9UZC8A+tMUtaStJZfWjBx7wKy1FtnnkvJpT4Rf7H?=
 =?us-ascii?Q?wLen8QuxxfiOoOSevwXA3trYfTyfOpV19S0p?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:56:11.8040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffa70bf-638b-4b6b-8c68-08ddaf284936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

From: Moshe Shemesh <moshe@nvidia.com>

Add HW Steering (HWS) as a secondary option for device steering mode. If
the device does not support SW Steering (SWS), HW Steering will be used
as the default, provided it is supported. FW Steering will now be
selected as the default only if both HWS and SWS are unavailable.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a8046200d376..f30fc793e1fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3919,6 +3919,8 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 
 	if (mlx5_fs_dr_is_supported(dev))
 		steering->mode = MLX5_FLOW_STEERING_MODE_SMFS;
+	else if (mlx5_fs_hws_is_supported(dev))
+		steering->mode = MLX5_FLOW_STEERING_MODE_HMFS;
 	else
 		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
 
-- 
2.34.1


