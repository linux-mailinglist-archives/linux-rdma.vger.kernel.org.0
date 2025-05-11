Return-Path: <linux-rdma+bounces-10273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D29AB2A8C
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A02316BE09
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D92620C1;
	Sun, 11 May 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbxpOJZE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEE25FA34;
	Sun, 11 May 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992369; cv=fail; b=Nenv48msrGoIy3Se06Zzjutj1BdPhehM4+T+qVCNkRxjTDVwsHLIttkT/KDsuty/VL1SNuoGnWr0mOqT98Tmrt6tSmn/Nd4lzb7+Trl277GLaW+onembvCCRRnExbXmp2Qtpb/cd6vqNLO9e1VGrOdJYHR9flcZ2MOnYeFQmKiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992369; c=relaxed/simple;
	bh=Cz5BAbBVIG41vInMLLwa0vvpMquZMJRGuvLqUaS0Cvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omtwPLQF2nCqVF2duKhLSA/6y4SLQOvN2sE9XLhN52CLLCQ6n319zvBohoSJUQtxdmY93n7U2CiYBlWkLxoDvAOi3onYZV+Oq5F8+PRkkiWo6vQfeDeBSG7i2WFHcOSB/gaPKgfGN/zYzipKeQBXiKsbPwB+5wV7KIdhkermLxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VbxpOJZE; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcZ6+eKs/t/xCPuakMrOO/kiBdX7WvLV/AqTkrkmnkuNW5wtezlCaKDxdbvHCFFvaA1w50CObcptSLoo/Y4Mv3var4HlidhQAayXzaDG4oB2Bez2QkixstLZGMTiB3V9f4ihpbb5AkOy7abvhA+eK2v+4+FGyQWO6TvLgzf1lwXQPkodtNIcJg9vPpPgELS0GJwZxuQM3DdU46t70pZHTJ5wpi3IpX9UykZtG9EfEQtf9k0v60t0x0I+j/VliUuQghSL6fDpdcCo6YW9tXxL36ckDP/XD79pebkd3ovcmkbGnevtM9g0Rg5+da7ajDkN3WWsjJ497JqcmOwYg4Hq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk/fQzjOTQuFh3aMzSr9ZXRgC1h15XDqA5+1H6s85zM=;
 b=dWREy+QAWddtCCSo2FChkTCiDFm/8GppVow9nciOJpa0W49YedtIrmsjU6/lypA6gboKQUS66R7jKDR5GXPQEUKLqsWeHcTma+oDU3Hzz94sneqf1zv6ia/7J/V3tsApJsRrELjkt/7MWIqZ8umEZ3hCW1JBfrohKZhSAX11fa12HwvXp+LLW8Jd/XfQD2ahu+WZ7/1zLty8ANtz1fL/1vaZG/8/2vUDICttn29fEKKgieht4f3UsNZW3osfcLqPnmDnz03BVKMJ78TkFQa0IKWU+y1ssAaIhbtp2YTyGBf53YhUsqyq9TxZejulVfpxcC9PlOF+I3WNlTpnKMZUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk/fQzjOTQuFh3aMzSr9ZXRgC1h15XDqA5+1H6s85zM=;
 b=VbxpOJZEqP2fv96q0EsyzbVe9vUHt0K1lr7ItMrSdj4JYC6EhmfWN9whVifkfmGRbj10T86jxrsdu77aDcE65A50mzr8NB9oTAY2XYQQ6WGpBowp6hr8psybHt9AtIyZkC0BgIGo9NHcnUZ9YHK/GBqV++dBZKtzOXGxEqQcOXptTUQukCr0r4m7xj9VqIaqNrF1VzjcP3DkgbLCT+l8jfk4BD9UfArG1Vxy7sH28Ni4CDym/wWv/Y+y95YTly+cRTvP+VlLjCv5T9BayJhN/mnY0TuRvYgVymdOVfbEYq8BN0vna+5MBBytuwx3RpXUE8bchHrMu3ub8dbCNy2BnA==
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 11 May
 2025 19:39:22 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::81) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Sun,
 11 May 2025 19:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 02/10] net/mlx5: HWS, add definer function to get field name str
Date: Sun, 11 May 2025 22:38:02 +0300
Message-ID: <1746992290-568936-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 742e6100-da5d-4845-c67e-08dd90c387a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yxXmseX4rJSDow9RVRtfSrwOX3VAaUOGxcZ48AcmHmYKviCS6/1LJV2BAs2t?=
 =?us-ascii?Q?ghBSKGM7R866rXU0AOhRQX+QxbYguOME00Y51oLAc1lclmTEjGkKULdCxSFd?=
 =?us-ascii?Q?KwJqvCIClA/uJ+a4Z8xt+zs2LMIxoOcU/oVVzvCnqilia0LtzlHLfu7js0Y5?=
 =?us-ascii?Q?aQCISsFPZjv240iG+8W2syCTFMKrPjpPDu2QQ/pn8c76/UFT7/YOqs4FNomU?=
 =?us-ascii?Q?K0NVnthGxQxz1VIWPl/NvmSJjnIr+6qBBBwGJ79Asj5tVciuk8BqsqXGCels?=
 =?us-ascii?Q?0+kXqZIUXFKmSh66ISn6gI0NWt3LORDy9gfhcfwwjOI9xE4h5pobVeB0cRm2?=
 =?us-ascii?Q?megDeynh6qS06fsQ4s9EwGj5+tVO2lWHdYMDiM8yKt6KCNY/IORilPb2fmIL?=
 =?us-ascii?Q?MEM30+tdMq9RyI77tl2ksW3vY8mKrX+l+qbzLhRwZ4ldtaMOTVp1PvkugSOl?=
 =?us-ascii?Q?T1EBOz9Jqblv4kCnKwQWDiBu8A6lwa1dxfj8yTPXyz2FtOZWYGvVk8Qt/zPB?=
 =?us-ascii?Q?ZImbf/bwAcF0A+xUDuPsLDo2BtFGKBKwwyRIfL2opjE+ulTh+KwZrFs1dSEv?=
 =?us-ascii?Q?+2eeXTSUtX89BlH91KZPAUpnkUUD1c4cEOgcwyzVr87nYkZ56XecPI30bzMA?=
 =?us-ascii?Q?UfcOo34s2biOQ//6W7BkjXU96zPUGFAS0utX/ayWnvRbg5s/NvW7NeNZPRWI?=
 =?us-ascii?Q?zLxDUe5PoHDuDm5svoCxVwHOqPu5tzVgwxdqh59ItF0O9ZUbG/uveomCIAz1?=
 =?us-ascii?Q?B7PM28WHI8mzOZOnEvktw5XceJjxqUcE4A49dKUvq69REDOvDLQxDVRnV69Z?=
 =?us-ascii?Q?F6dST/SHru1syYJW2yglfsl0inRS5/sYH3bqqL7xTXhlmHnLClQMDuk8i81k?=
 =?us-ascii?Q?YrDR622FN30UFmUyI4EXRZNjmHfm2AohaV3Omck6HX/NgoNmUhYC+JP82MJc?=
 =?us-ascii?Q?/p4mZU9r0AfivSez609TMzw1RiFYa+I3/dY3D2LrVaCEvGIBX6MjbnLXsTiA?=
 =?us-ascii?Q?69Vzgh4SYvul7Eq1+6v8h0scaFTfWinihU3STNIRvEtsUYrxnxUN68kTjoCD?=
 =?us-ascii?Q?GY3HGodvB0Op4e85bwDJBr1IwQV0kv4QO6hHat0G5wdPxQULJ9bDms0+ShT5?=
 =?us-ascii?Q?bCT6dYWe/feDQsvrgiR35eVfy30cqsvChj6bCP2RFNRD2+myLHb9ZCM0nhs+?=
 =?us-ascii?Q?D16I1GQLMafYvij8/jdZ71Ox46K7dd1lw6lFaLJu6zZn7rAfYS5VecixQztR?=
 =?us-ascii?Q?xUTqp43Sw+7LVV2vzGUi1MPoEqG6AF77+owmMTc8GtSDh/6YB5/w8tpFSOCW?=
 =?us-ascii?Q?WkCfD/so7hvrVBSyv/fk4/DtIneElN0qIbuLXknYL/xuznMTwZkYrM6HW96O?=
 =?us-ascii?Q?A4rB9sf+Hvq9ovwvdZp7VlDozDu0DXs92zHJ/FYYY9uvUdwpku6MVVdUOJDQ?=
 =?us-ascii?Q?AB1dG5z2lVMMiRf3iav7yfnzbExI2TolQInny+NHlhdP0YYfFGdK7pxZcMZ6?=
 =?us-ascii?Q?if8p0+fj2jEgQhRyBt+Bk/xgA4KqQk/Mxwr4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:22.3592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742e6100-da5d-4845-c67e-08dd90c387a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In preparation for complex matcher support, add function for
converting definer fname to str, which will be used in following
patches.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/definer.c | 212 ++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/definer.h |   2 +
 2 files changed, 214 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index 1061a46811ac..5cc0dc002ac1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -158,6 +158,218 @@ struct mlx5hws_definer_conv_data {
 	u32 match_flags;
 };
 
+#define HWS_DEFINER_ENTRY(name)[MLX5HWS_DEFINER_FNAME_##name] = #name
+
+static const char * const hws_definer_fname_to_str[] = {
+	HWS_DEFINER_ENTRY(ETH_SMAC_47_16_O),
+	HWS_DEFINER_ENTRY(ETH_SMAC_47_16_I),
+	HWS_DEFINER_ENTRY(ETH_SMAC_15_0_O),
+	HWS_DEFINER_ENTRY(ETH_SMAC_15_0_I),
+	HWS_DEFINER_ENTRY(ETH_DMAC_47_16_O),
+	HWS_DEFINER_ENTRY(ETH_DMAC_47_16_I),
+	HWS_DEFINER_ENTRY(ETH_DMAC_15_0_O),
+	HWS_DEFINER_ENTRY(ETH_DMAC_15_0_I),
+	HWS_DEFINER_ENTRY(ETH_TYPE_O),
+	HWS_DEFINER_ENTRY(ETH_TYPE_I),
+	HWS_DEFINER_ENTRY(ETH_L3_TYPE_O),
+	HWS_DEFINER_ENTRY(ETH_L3_TYPE_I),
+	HWS_DEFINER_ENTRY(VLAN_TYPE_O),
+	HWS_DEFINER_ENTRY(VLAN_TYPE_I),
+	HWS_DEFINER_ENTRY(VLAN_FIRST_PRIO_O),
+	HWS_DEFINER_ENTRY(VLAN_FIRST_PRIO_I),
+	HWS_DEFINER_ENTRY(VLAN_CFI_O),
+	HWS_DEFINER_ENTRY(VLAN_CFI_I),
+	HWS_DEFINER_ENTRY(VLAN_ID_O),
+	HWS_DEFINER_ENTRY(VLAN_ID_I),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_TYPE_O),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_TYPE_I),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_PRIO_O),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_PRIO_I),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_CFI_O),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_CFI_I),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_ID_O),
+	HWS_DEFINER_ENTRY(VLAN_SECOND_ID_I),
+	HWS_DEFINER_ENTRY(IPV4_IHL_O),
+	HWS_DEFINER_ENTRY(IPV4_IHL_I),
+	HWS_DEFINER_ENTRY(IP_DSCP_O),
+	HWS_DEFINER_ENTRY(IP_DSCP_I),
+	HWS_DEFINER_ENTRY(IP_ECN_O),
+	HWS_DEFINER_ENTRY(IP_ECN_I),
+	HWS_DEFINER_ENTRY(IP_TTL_O),
+	HWS_DEFINER_ENTRY(IP_TTL_I),
+	HWS_DEFINER_ENTRY(IPV4_DST_O),
+	HWS_DEFINER_ENTRY(IPV4_DST_I),
+	HWS_DEFINER_ENTRY(IPV4_SRC_O),
+	HWS_DEFINER_ENTRY(IPV4_SRC_I),
+	HWS_DEFINER_ENTRY(IP_VERSION_O),
+	HWS_DEFINER_ENTRY(IP_VERSION_I),
+	HWS_DEFINER_ENTRY(IP_FRAG_O),
+	HWS_DEFINER_ENTRY(IP_FRAG_I),
+	HWS_DEFINER_ENTRY(IP_LEN_O),
+	HWS_DEFINER_ENTRY(IP_LEN_I),
+	HWS_DEFINER_ENTRY(IP_TOS_O),
+	HWS_DEFINER_ENTRY(IP_TOS_I),
+	HWS_DEFINER_ENTRY(IPV6_FLOW_LABEL_O),
+	HWS_DEFINER_ENTRY(IPV6_FLOW_LABEL_I),
+	HWS_DEFINER_ENTRY(IPV6_DST_127_96_O),
+	HWS_DEFINER_ENTRY(IPV6_DST_95_64_O),
+	HWS_DEFINER_ENTRY(IPV6_DST_63_32_O),
+	HWS_DEFINER_ENTRY(IPV6_DST_31_0_O),
+	HWS_DEFINER_ENTRY(IPV6_DST_127_96_I),
+	HWS_DEFINER_ENTRY(IPV6_DST_95_64_I),
+	HWS_DEFINER_ENTRY(IPV6_DST_63_32_I),
+	HWS_DEFINER_ENTRY(IPV6_DST_31_0_I),
+	HWS_DEFINER_ENTRY(IPV6_SRC_127_96_O),
+	HWS_DEFINER_ENTRY(IPV6_SRC_95_64_O),
+	HWS_DEFINER_ENTRY(IPV6_SRC_63_32_O),
+	HWS_DEFINER_ENTRY(IPV6_SRC_31_0_O),
+	HWS_DEFINER_ENTRY(IPV6_SRC_127_96_I),
+	HWS_DEFINER_ENTRY(IPV6_SRC_95_64_I),
+	HWS_DEFINER_ENTRY(IPV6_SRC_63_32_I),
+	HWS_DEFINER_ENTRY(IPV6_SRC_31_0_I),
+	HWS_DEFINER_ENTRY(IP_PROTOCOL_O),
+	HWS_DEFINER_ENTRY(IP_PROTOCOL_I),
+	HWS_DEFINER_ENTRY(L4_SPORT_O),
+	HWS_DEFINER_ENTRY(L4_SPORT_I),
+	HWS_DEFINER_ENTRY(L4_DPORT_O),
+	HWS_DEFINER_ENTRY(L4_DPORT_I),
+	HWS_DEFINER_ENTRY(TCP_FLAGS_I),
+	HWS_DEFINER_ENTRY(TCP_FLAGS_O),
+	HWS_DEFINER_ENTRY(TCP_SEQ_NUM),
+	HWS_DEFINER_ENTRY(TCP_ACK_NUM),
+	HWS_DEFINER_ENTRY(GTP_TEID),
+	HWS_DEFINER_ENTRY(GTP_MSG_TYPE),
+	HWS_DEFINER_ENTRY(GTP_EXT_FLAG),
+	HWS_DEFINER_ENTRY(GTP_NEXT_EXT_HDR),
+	HWS_DEFINER_ENTRY(GTP_EXT_HDR_PDU),
+	HWS_DEFINER_ENTRY(GTP_EXT_HDR_QFI),
+	HWS_DEFINER_ENTRY(GTPU_DW0),
+	HWS_DEFINER_ENTRY(GTPU_FIRST_EXT_DW0),
+	HWS_DEFINER_ENTRY(GTPU_DW2),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_0),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_1),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_2),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_3),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_4),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_5),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_6),
+	HWS_DEFINER_ENTRY(FLEX_PARSER_7),
+	HWS_DEFINER_ENTRY(VPORT_REG_C_0),
+	HWS_DEFINER_ENTRY(VXLAN_FLAGS),
+	HWS_DEFINER_ENTRY(VXLAN_VNI),
+	HWS_DEFINER_ENTRY(VXLAN_GPE_FLAGS),
+	HWS_DEFINER_ENTRY(VXLAN_GPE_RSVD0),
+	HWS_DEFINER_ENTRY(VXLAN_GPE_PROTO),
+	HWS_DEFINER_ENTRY(VXLAN_GPE_VNI),
+	HWS_DEFINER_ENTRY(VXLAN_GPE_RSVD1),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_LEN),
+	HWS_DEFINER_ENTRY(GENEVE_OAM),
+	HWS_DEFINER_ENTRY(GENEVE_PROTO),
+	HWS_DEFINER_ENTRY(GENEVE_VNI),
+	HWS_DEFINER_ENTRY(SOURCE_QP),
+	HWS_DEFINER_ENTRY(SOURCE_GVMI),
+	HWS_DEFINER_ENTRY(REG_0),
+	HWS_DEFINER_ENTRY(REG_1),
+	HWS_DEFINER_ENTRY(REG_2),
+	HWS_DEFINER_ENTRY(REG_3),
+	HWS_DEFINER_ENTRY(REG_4),
+	HWS_DEFINER_ENTRY(REG_5),
+	HWS_DEFINER_ENTRY(REG_6),
+	HWS_DEFINER_ENTRY(REG_7),
+	HWS_DEFINER_ENTRY(REG_8),
+	HWS_DEFINER_ENTRY(REG_9),
+	HWS_DEFINER_ENTRY(REG_10),
+	HWS_DEFINER_ENTRY(REG_11),
+	HWS_DEFINER_ENTRY(REG_A),
+	HWS_DEFINER_ENTRY(REG_B),
+	HWS_DEFINER_ENTRY(GRE_KEY_PRESENT),
+	HWS_DEFINER_ENTRY(GRE_C),
+	HWS_DEFINER_ENTRY(GRE_K),
+	HWS_DEFINER_ENTRY(GRE_S),
+	HWS_DEFINER_ENTRY(GRE_PROTOCOL),
+	HWS_DEFINER_ENTRY(GRE_OPT_KEY),
+	HWS_DEFINER_ENTRY(GRE_OPT_SEQ),
+	HWS_DEFINER_ENTRY(GRE_OPT_CHECKSUM),
+	HWS_DEFINER_ENTRY(INTEGRITY_O),
+	HWS_DEFINER_ENTRY(INTEGRITY_I),
+	HWS_DEFINER_ENTRY(ICMP_DW1),
+	HWS_DEFINER_ENTRY(ICMP_DW2),
+	HWS_DEFINER_ENTRY(ICMP_DW3),
+	HWS_DEFINER_ENTRY(IPSEC_SPI),
+	HWS_DEFINER_ENTRY(IPSEC_SEQUENCE_NUMBER),
+	HWS_DEFINER_ENTRY(IPSEC_SYNDROME),
+	HWS_DEFINER_ENTRY(MPLS0_O),
+	HWS_DEFINER_ENTRY(MPLS1_O),
+	HWS_DEFINER_ENTRY(MPLS2_O),
+	HWS_DEFINER_ENTRY(MPLS3_O),
+	HWS_DEFINER_ENTRY(MPLS4_O),
+	HWS_DEFINER_ENTRY(MPLS0_I),
+	HWS_DEFINER_ENTRY(MPLS1_I),
+	HWS_DEFINER_ENTRY(MPLS2_I),
+	HWS_DEFINER_ENTRY(MPLS3_I),
+	HWS_DEFINER_ENTRY(MPLS4_I),
+	HWS_DEFINER_ENTRY(FLEX_PARSER0_OK),
+	HWS_DEFINER_ENTRY(FLEX_PARSER1_OK),
+	HWS_DEFINER_ENTRY(FLEX_PARSER2_OK),
+	HWS_DEFINER_ENTRY(FLEX_PARSER3_OK),
+	HWS_DEFINER_ENTRY(FLEX_PARSER4_OK),
+	HWS_DEFINER_ENTRY(FLEX_PARSER5_OK),
+	HWS_DEFINER_ENTRY(FLEX_PARSER6_OK),
+	HWS_DEFINER_ENTRY(FLEX_PARSER7_OK),
+	HWS_DEFINER_ENTRY(OKS2_MPLS0_O),
+	HWS_DEFINER_ENTRY(OKS2_MPLS1_O),
+	HWS_DEFINER_ENTRY(OKS2_MPLS2_O),
+	HWS_DEFINER_ENTRY(OKS2_MPLS3_O),
+	HWS_DEFINER_ENTRY(OKS2_MPLS4_O),
+	HWS_DEFINER_ENTRY(OKS2_MPLS0_I),
+	HWS_DEFINER_ENTRY(OKS2_MPLS1_I),
+	HWS_DEFINER_ENTRY(OKS2_MPLS2_I),
+	HWS_DEFINER_ENTRY(OKS2_MPLS3_I),
+	HWS_DEFINER_ENTRY(OKS2_MPLS4_I),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_0),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_1),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_2),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_3),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_4),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_5),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_6),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_OK_7),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_0),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_1),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_2),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_3),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_4),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_5),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_6),
+	HWS_DEFINER_ENTRY(GENEVE_OPT_DW_7),
+	HWS_DEFINER_ENTRY(IB_L4_OPCODE),
+	HWS_DEFINER_ENTRY(IB_L4_QPN),
+	HWS_DEFINER_ENTRY(IB_L4_A),
+	HWS_DEFINER_ENTRY(RANDOM_NUM),
+	HWS_DEFINER_ENTRY(PTYPE_L2_O),
+	HWS_DEFINER_ENTRY(PTYPE_L2_I),
+	HWS_DEFINER_ENTRY(PTYPE_L3_O),
+	HWS_DEFINER_ENTRY(PTYPE_L3_I),
+	HWS_DEFINER_ENTRY(PTYPE_L4_O),
+	HWS_DEFINER_ENTRY(PTYPE_L4_I),
+	HWS_DEFINER_ENTRY(PTYPE_L4_EXT_O),
+	HWS_DEFINER_ENTRY(PTYPE_L4_EXT_I),
+	HWS_DEFINER_ENTRY(PTYPE_FRAG_O),
+	HWS_DEFINER_ENTRY(PTYPE_FRAG_I),
+	HWS_DEFINER_ENTRY(TNL_HDR_0),
+	HWS_DEFINER_ENTRY(TNL_HDR_1),
+	HWS_DEFINER_ENTRY(TNL_HDR_2),
+	HWS_DEFINER_ENTRY(TNL_HDR_3),
+	[MLX5HWS_DEFINER_FNAME_MAX] = "DEFINER_FNAME_UNKNOWN",
+};
+
+const char *mlx5hws_definer_fname_to_str(enum mlx5hws_definer_fname fname)
+{
+	if (fname > MLX5HWS_DEFINER_FNAME_MAX)
+		fname = MLX5HWS_DEFINER_FNAME_MAX;
+	return hws_definer_fname_to_str[fname];
+}
+
 static void
 hws_definer_ones_set(struct mlx5hws_definer_fc *fc,
 		     void *match_param,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
index 5c1a2086efba..62da55389331 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
@@ -831,4 +831,6 @@ mlx5hws_definer_conv_match_params_to_compressed_fc(struct mlx5hws_context *ctx,
 						   u32 *match_param,
 						   int *fc_sz);
 
+const char *mlx5hws_definer_fname_to_str(enum mlx5hws_definer_fname fname);
+
 #endif /* HWS_DEFINER_H_ */
-- 
2.31.1


