Return-Path: <linux-rdma+bounces-10518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8325AC056C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 09:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0609D7B7637
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A19224893;
	Thu, 22 May 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnOjXufc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C522422E;
	Thu, 22 May 2025 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898085; cv=fail; b=V4noF0FAzPogJWsi7Apk1fgG5XTtVTpbdR0Wl0fVsVaUBplKOGQfdL4XtCAMnNyMwJW0LjHhpEedqv6we7x19gckJRkrs50ZVoGfNRaR4tVi5MucZeewG3vR3BcKPFS/0IOZbbI3B5ha0LwgEKH36Ff3h5lTl2rwDdJX45ek238=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898085; c=relaxed/simple;
	bh=pO2rOcFT8ri7OC1beMn3LB7cqGSFzd+rlobxT6gvn+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkvYwMkt8ypGjuyntB/ZlmJEahzQ+sHE30M9/0U98eL3hvKX+OFMiaNvi48MP7ixNPre2Ihcqy4VFYcGlBes5rAtj8rSqtsu/QdosWB5Sv3ik1q7jMDG39gcJDTcViT+WPkdKA13aLo6YtD7qZ1E9V957QM5VXaJ8HW4bQPGOds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnOjXufc; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcyGUNKRhQ1xbkU0JhiiZePGWOo5b8AR7DXeI4a41j4rLxvni8orDITYiB3SRLtxdn4SNGk9Y2dYxJMOBrB7sp/LotBBFJZiczPNa4XZn5m5eAQjnx63M2rx8YljbUg6txdbSXsjGJREwLchCo7of0sxEXBDkUxWK4eDyKtEPlXftu6DcmXZrxTBWt8AfLYoRu+ZZPMG4KwW2nnLVkK6V/Zn3yogWiLaH1wdm29wtTVI+D/obKVVDNGqywjgQPbjCrFdM5KTuoduEMBaul5FGFdXdNpo/8a3KxDHnmZ+QlMEbQvqd3GMYbrJStd6vaXTMNgKiHIPgxXcD0oJYdgIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84osfR8QwQRiIXp/dsP/AHj95prfR9miCZ2EUbfDdLA=;
 b=a1r0dWdxgoVLhi+TFew/AqrUcGqdB9aimIMf4TQwrRL6KcGJIuk/47EyKLmWNYU/leAJfP2EgUoVkJW/PKxh1rC950xTd5KLsuHXtKs722nHsTeny3lqBHbfneijYUW1WJaIDV/KLQDDx3y4iK7VeJO2kL/BmoxeRnOAWSkEezkraOXJunvp0NXFusFK1r8Mf9erHvVAIkoL3wlcpXR21MgDB2Hv3TaG5BVWkP9nJiXCGxLzOck6iZyqtcR3zz1J3AUnyss90YsHsJbyDyj6mFLcfKqr1veBTwyLY+3og7BMhXtr1Dz4//2D3GP0exO0haE3qvekMa7OKerF+nEcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84osfR8QwQRiIXp/dsP/AHj95prfR9miCZ2EUbfDdLA=;
 b=cnOjXufcF3VU3HqctpyEqD5KPqbwabbKOoi6UVjoehOEnrW5So+8lyef5buOa/CfquBCAVG93j2F99WtL1hVLsWjr3GO0xXj0HHwtThHSx0EhmgmGBTh58C2iAaTeyD67rpH+TJbFZsJC4Fz7JXUMtBgeauI3AN4lLqAEMqZXW99zMf4B+UCRDNnhTjfiHOTj4wa+W/DLy6N3d3ZBOxlsGM5GXEyDFhmBW3Oj7pUUZ+8QefPhv8o7pVEjMsUIdRwCC2ejPr+++4z9NiyzgL1fMIPg5EvjQii6X9MeMaqa96VKaVJZECikC4rMRDdYCMdte+AcvLQVF9ICKrzcMzXZg==
Received: from DS7P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::24) by
 MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 07:14:39 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::8b) by DS7P220CA0051.outlook.office365.com
 (2603:10b6:8:224::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 07:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 07:14:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 00:14:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 00:14:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 00:14:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: Allow setting MAC address of representors
Date: Thu, 22 May 2025 10:13:56 +0300
Message-ID: <1747898036-1121904-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 097feb10-6cf0-4169-332c-08dd9900505b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XyqPJ6YXiseWInRm+yx5lTdT9qJBmk4WG/wsPRBjMP955GEFSwJxGzQCM/G/?=
 =?us-ascii?Q?OUIoqzPCHmiiMyNiXBCHzacnXlrDhCvIAO6sfJReBeo8X8NX2rBLSa29+10P?=
 =?us-ascii?Q?q83gViNJcbwnGvapLzDYqUKuHZ0RNAD+RVOl7n2Wxxgj/aAryIL2qL+U6RXA?=
 =?us-ascii?Q?obFrJ1MieAH1HVztanE0auaOsrDxp3IvwP+d72HCZ6Z3/+YPOQjlzs16CoRp?=
 =?us-ascii?Q?sOmAd2B8oXtvZsyCCoNC3oz7eBEx0slRwAACZl3YOvjoCMxeZlakt0PjD/0P?=
 =?us-ascii?Q?oGaiMWILPNJFqAQf4m6Q6OE4HQRcNuh+ca6Sl1phyDhBWsyOAQOoj8emRx6C?=
 =?us-ascii?Q?kQ32AZVaYo+KzJiKwfLqai/kzLZS/S+rKjhjPvTvecRgB8Ojh1k9hxDWX2/J?=
 =?us-ascii?Q?C12Jwxsr4oLhmBgbycUx/eXkmxEUp5QXTyvDREEYA5JZx7R3xSCyY4WqJ0E1?=
 =?us-ascii?Q?dKZCGP3FPDYcrPQ89u9oWoWFz5tbY5oFVSrmp+YctNKuxM0pXDDQHYBYZzY0?=
 =?us-ascii?Q?MzF1CQyt4NsYa9fY+6qcu4W5Iay9sb1aVXyf+P+JbS7+Mm84SQD0GNeZuMQn?=
 =?us-ascii?Q?8YZLBBr06v/Zx5Hd6/biC4ib33qg8v06mLPDZDLhR8LV+zF22A5t4ZqnHnsy?=
 =?us-ascii?Q?e0M6pM+Mnq6LWdnZg1OTW6BW24DNOGe02udF8ojf/U6vpHt5wdxAPmLIzsO+?=
 =?us-ascii?Q?g14wLrRPeP+U2FK256WOvKsoEIMQCdA2pj5BMP8LxxvnmdFBdnRUw7TxKawL?=
 =?us-ascii?Q?RM0Zwi8jx7KFXtj2Ba9hBLeSOOQ2G10Z6WrXhApb4Aj33f/jlaUTc+a/vOZ9?=
 =?us-ascii?Q?qumJsvazBj45FRYFrW63XEvD773I4nTaADsYKTD3OT8jEASNZRF5sf8NJrXE?=
 =?us-ascii?Q?ueHhX5yf7M6M+CekbbM+Qh47Fykd94CbPrXRZcqo2C2MpSBLVG5nhU1xLfQV?=
 =?us-ascii?Q?QYrTifRw39bfTob8lk5Z1kjEfYcSN5N2rSdk5vxgJ/XIUDgwSwIEs5tZCsgM?=
 =?us-ascii?Q?7xlbTF6/P/nJ0X1JEvJjDlhe+fEW+Nc7YHdG0Uxf6ytM00D0ZRCzQwkS9Fxr?=
 =?us-ascii?Q?wI79RJ4tpxWgMWt1SZn1ubiEisyDC/B4XrkvGuHLEgipv8COisaZfDV60fFX?=
 =?us-ascii?Q?VXsZzDUYbCF2ik9LB/UedOmFkHEnF/gB4ZZFEcK1AJK0q55Z95zw7aJirwJ9?=
 =?us-ascii?Q?8EB5iCoRUgcrEQSaGBgE42Y1g3IvHd0+zuPPl05h84iCo83h+uFMVPVS5y6D?=
 =?us-ascii?Q?OtxSoMMgXI9yltn06s+CSRNPN4ZhkVHf/8rwZHw/PithIuNrq/3abzUe2N7A?=
 =?us-ascii?Q?7SefQLKmfePPZnvsmqOxQ1X+RDG+e/IReRFh/z9fRSbcyTr/OiFyVBfuaBoQ?=
 =?us-ascii?Q?LX9TwbkPpPqPlVW+6FL8zVtosOD+8PAyMAsdaUCOpfjN3PU50U4qhtyGwS40?=
 =?us-ascii?Q?o3CnPw45hX8mt9XTlOIlKrJrPr3CUk8PLgBykmsyK8xNIO8mncpawRQcMFio?=
 =?us-ascii?Q?552cJ6qrzctCmaZTdvV04E7brxf/ZU2yuiAk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:14:38.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097feb10-6cf0-4169-332c-08dd9900505b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683

From: Mark Bloch <mbloch@nvidia.com>

A representor netdev does not correspond to real hardware that needs to
be updated when setting the MAC address. The default eth_mac_addr() is
sufficient for simply updating the netdev's MAC address with validation.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 2abab241f03b..79c6427433e3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -803,6 +803,7 @@ static const struct net_device_ops mlx5e_netdev_ops_rep = {
 	.ndo_stop                = mlx5e_rep_close,
 	.ndo_start_xmit          = mlx5e_xmit,
 	.ndo_setup_tc            = mlx5e_rep_setup_tc,
+	.ndo_set_mac_address	 = eth_mac_addr,
 	.ndo_get_stats64         = mlx5e_rep_get_stats,
 	.ndo_has_offload_stats	 = mlx5e_rep_has_offload_stats,
 	.ndo_get_offload_stats	 = mlx5e_rep_get_offload_stats,

base-commit: 3da895b23901964fcf23450f10b529d45069f333
-- 
2.31.1


