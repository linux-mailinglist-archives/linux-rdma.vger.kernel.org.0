Return-Path: <linux-rdma+bounces-11159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2BAAD3CD2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC07B2E8B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C19244674;
	Tue, 10 Jun 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WfnYqNZu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255062441AF;
	Tue, 10 Jun 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568602; cv=fail; b=sZddyLEOBWOpmzeEu5NvA2jkXHND3uTlR3biJoUgMu/qBEWzQS1Lwih4G5PTGgBTXsyFM5f5oNZLKsFDabUuiiuKezPldEOjo64kC3W9odArxXMlD/hxkDOQC0H8aUVsfpaWN6xq+VlZM2nX6n2mhYgGJc2ef8ekO/GFTS7m5qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568602; c=relaxed/simple;
	bh=A8w3E5NZoBjwQKv0LCjpaiIF1/GCJ6OwYhhVTnZV/B4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwOo0w/YdRjDsGIFXw/ndWnKkbX8XH8hgVLkCXhccfHe0feDxBAHYHnF8gCUX9YQYftIgWGvlu4lvwKp0P1RDumNNGFy/71ncMoYZhV1cJgmaJbhypKn8moURIg7GKYwct2OLAUk4fmjSwZi5TweG//gmR6j8+yNju3hW1tXlHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WfnYqNZu; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIBLGpl1agUoCbr+TZzAfX81p2Jn5Gf5I2gZ0JihXrhPOTCwRh16l32CqLBzNC0hO057zwtHROKYs4LaHX76yWXvJkJ7+Ax7sNjlilPgsqypTeWL08Ag3mvJwQZm7GXkk/r/22VgG1UrRcFdWeGDVrdLGzo0zleuKB5epCcGDRJMCjGsixMemoYe5iJDc19DYkICdyWXu6f9fIEoh+U/lVd1jPBTzV/WeyGFM1XVVMywOOE8BtDwZ9gPD7rTgENwFPI385P4fbKmSGfugZLaI2bLjCGr/jvtoxSCdKE0Jp5OwoSzdA4lsuBL0bvp6DNrtv3bGO0qg8JvVzOKTAj8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAcXlUnuztOWMxV0h6BHLXgTDjOkQHbn4Nuc/x315A8=;
 b=HEMeh9496C+LF8ZjmokDZR79OWgpKpqY/3QOAVK8K9qkMP2WcYW8lOZXxsRtwkPnGkI0Y3ODvMFmXwrRmpwt45Qr3XcFLbSa8TUDyuSVsdUe1hmW3URnjwsp8bvgnVbE+5DF15TwleU2IWFp3qE0HEyLmtDqw0Z8qjzpfDRArcCvNaKo8ib3RRF3u1FfKaNiPR8rAjQarz/nPSiEO7/vGXOp61C5JS0NO9dDeQQOCtLKOlm9enHaSi7gARApFka6z12ni6gtnZPNhRq+Qr+MXVITDPIq3L6OZxQPEVl2IDJtOkYiu8CuLpf0nLTwDk8VhtLrlsCXHYu9LWha5DG52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAcXlUnuztOWMxV0h6BHLXgTDjOkQHbn4Nuc/x315A8=;
 b=WfnYqNZuma7D5CWlp4BhOLP457x36UKwSrQJJjXEwWiq4RaObnNj1XCaHU05fAxXuKvM3Rrx1vJUABJ8j6jeVVQ9A9kg8czzonxaposoSDd9T0uIvbF6L3EAJagvzP051QAfDgEeS1Fu/GTJIiDgVsIaWRE7PejmkSQa8fHRv4E1Zc+5N2s3lcrSswmfvH/4iuZf70rt4ljk2Ns+T+DRRs39UyVtJD65a+dO3F5d+MkvkFmgfSsDm+bXOtCF7pAD7NNUhSTECOeE2/pJkMylqVF4QFc+mc0EJ40V6glAXkbvNOoJYbtnTSeMR65Ys7JpiGAue7qNtmixT27hFLyqBA==
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:16:38 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::5b) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:16:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:16:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:16:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:16:11 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH net 9/9] net/mlx5e: Fix number of lanes to UNKNOWN when using data_rate_oper
Date: Tue, 10 Jun 2025 18:15:14 +0300
Message-ID: <20250610151514.1094735-10-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 618d7724-c69b-48fa-6282-08dda831cb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CwFXIxraEGjULcI0sXin/xErFEHUsl2VS8JQe80MxFbZMjenFvnXwHhq7Ha3?=
 =?us-ascii?Q?8XXCAnj6DM8XkNhaTT+HnjGpa8WOI1S6d/LFPOTfYr0enR7s5STLVX+hf+F9?=
 =?us-ascii?Q?b3H/d8pKLXkPwWS8Nvhav3M4wuymy78xSqpCE9C6dNg6nIR8aJGojSd/BDZ6?=
 =?us-ascii?Q?6sU5vnZL2aqeJVaWteMkGm7GY4xNFoNs8wzFK9ZZlIPELlVKzy7u3Ooux7lh?=
 =?us-ascii?Q?pljJzbOVbIxHcK0bW/iEGOC4vIyqNL1f07mmRYITobpMzpNcB+y5xfsCvxU+?=
 =?us-ascii?Q?Pfw5NERJpPJmuiVE6oX5+k39I/K4U1PBe+feW/g3uXI59jYUYKDyVo3TqgcQ?=
 =?us-ascii?Q?1YbNtCOSVkmxxpuPHqRuAQC3NOryWsJexI2vhgFORDcvpluwdh7Z0g/E8aHX?=
 =?us-ascii?Q?TceoUxydoBXuHodXuogcwDNDoflXgbEM89pyWVUee1zGVEkmAKtfkf7U/kXO?=
 =?us-ascii?Q?4DL8HFxTWU00owMN/V7YkladJT43UjxLEqsZMpdyfdqNUuN5Jloej3Qqyqg9?=
 =?us-ascii?Q?jYM4BMP0zUKTvXx/sIvXOlOc+LSICnGSvCqegd0PdvpOM/YjPLuf8LxkMEwm?=
 =?us-ascii?Q?JJUXQc7Q+QqfbqPcF2mDU27EO0f+DdaSQI/bBBEVHGgAfizBknTsqRBUDMRx?=
 =?us-ascii?Q?7FhSSXc2pCh3KlhYCDlHRZOylp1GJfg0UyboTVMerylE2fmbrECmuzYokF5M?=
 =?us-ascii?Q?/yTuKqGJkqaAOwW8wG1mLZC8MRLftDKv1ZGJ0DfPORmVhenRJ6ZPxicOe5eF?=
 =?us-ascii?Q?zmn1mOPGWPT+OT1HctrP1d+tC5P0z9V4stz/ZTvSu4sqBG9wFk1PqDsZ72iO?=
 =?us-ascii?Q?uaQkZ0OdkPvqp8tOOCdcQHf6vDLg4Zoyn6n49m1jQF3Et9LkWvGBYWdAIb0e?=
 =?us-ascii?Q?0ncaXrCniWIE2ooSlDosWPO7qtLX2YiBUoDeL3raApihDg/RCLHWwom1H9G9?=
 =?us-ascii?Q?WrUEoUdhTHkRomxDwj1BDBoj0xS58oxnspP0/Wpbp3qyE620/pbGEyAk8zcY?=
 =?us-ascii?Q?HARI4avMIZPt3pjs4K2g4iIARSb3OmfYuAynMC2VUWr6vBz/LV+xqdzhJqa2?=
 =?us-ascii?Q?yBWAiEG1sMiof75OydolfNUbFBMW1mpuehhtnSlHcLmitmcccJ1u6mVzKGWV?=
 =?us-ascii?Q?xL25lD2gc9Yu1Hdf/fkTFqcs6n6e1uvRyKwyv8oPlVJQA6GMYKgKi0t0jgnc?=
 =?us-ascii?Q?i43GP+9EmVzBMMr+nGvlAWoojaFMoi1BV0j63PDk/axCYhMq9NVkXbF0nXZZ?=
 =?us-ascii?Q?zLkzXSiLAoCL63BgCIL8MKqqn0O4bOIsNjDaHtgza0lMfdKPX/iz1w+v6WYE?=
 =?us-ascii?Q?YFNp/Rg9FqsgE7KGtBUTop1khRn+Fn3P2Ks9yS0cWBMZ3pMh39otj8a+tOuR?=
 =?us-ascii?Q?MLLcty4/vdQiV5au2/n3Xw2BaKMWkmrTqid5OJMkpMcMqKHjX+LwABe304XG?=
 =?us-ascii?Q?4K9vkGA8+R/eAy5pl7E5DwbDqwV97ocRkc6Q73GCfEk64V5Yg4z4Zmcjn2Tj?=
 =?us-ascii?Q?3lR7a3hfHFLBHuGPAZX3QzWHCOy7a4TVU6A7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:16:37.6093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618d7724-c69b-48fa-6282-08dda831cb82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376

From: Shahar Shitrit <shshitrit@nvidia.com>

When the link is up, either eth_proto_oper or ext_eth_proto_oper
typically reports the active link protocol, from which both speed
and number of lanes can be retrieved. However, in certain cases,
such as when a NIC is connected via a non-standard cable, the
firmware may not report the protocol.

In such scenarios, the speed can still be obtained from the
data_rate_oper field in PTYS register. Since data_rate_oper
provides only speed information and lacks lane details, it is
incorrect to derive the number of lanes from it.

This patch corrects the behavior by setting the number of lanes to
UNKNOWN instead of incorrectly using MAX_LANES when relying on
data_rate_oper.

Fixes: 7e959797f021 ("net/mlx5e: Enable lanes configuration when auto-negotiation is off")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index ea078c9f5d15..3cb8d3bf9044 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -43,7 +43,6 @@
 #include "en/fs_ethtool.h"
 
 #define LANES_UNKNOWN		 0
-#define MAX_LANES		 8
 
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
@@ -1098,10 +1097,8 @@ static void get_link_properties(struct net_device *netdev,
 		speed = info->speed;
 		lanes = info->lanes;
 		duplex = DUPLEX_FULL;
-	} else if (data_rate_oper) {
+	} else if (data_rate_oper)
 		speed = 100 * data_rate_oper;
-		lanes = MAX_LANES;
-	}
 
 out:
 	link_ksettings->base.duplex = duplex;
-- 
2.34.1


