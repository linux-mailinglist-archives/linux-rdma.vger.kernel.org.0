Return-Path: <linux-rdma+bounces-10685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03046AC3420
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A983B9533
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE01F1531;
	Sun, 25 May 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YOSqRC18"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE01F1301;
	Sun, 25 May 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171763; cv=fail; b=Dg7EDGPZtPs+XKaJX9fFq6Yy+M8+ohfvve7rpf3K1PRrZI4vS6moP3cUX3a95ATbHyaw5sB2tpXGnWXZWYXRCywVGbPL2uhyWFiDnKd4ckTQFqVQSdklb9geB1FlATzbOdgJp6c7VxNYVDwV39bdRoWP3FU7zoQOr8c8EAvyfZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171763; c=relaxed/simple;
	bh=an1w57jWoJfssYjefFFfHQRxL0eRV8ZP2hT0GFgadgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhlCm3YH+9UZsqqrIjpTKNlF+YAn6eCXSlQCW0raNs/eI+Yrm1LSEGEsv85mRsWza9ISqweN+k34YuBG3jzdam2f6WBYjr4A3G0P63tRM/6uOuZVhP8jUCH+mRjlbTtVE03KU23XFm+7t7yD33GRQQ2BGeL0//81hLsibOs4Wr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YOSqRC18; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnpNLsJLijjjcKblfiUZrGe+RKjAWvqpIw6GJNKky7YiBC0Oyo/gCZ94Kq6vSK1Kn2MYoZCTZfv7CvkQ3hLvAnki62uEYPjYh3IXIv2EOWUBeQRD7xQJftvsJK229qSCmnf1QBvu6bXbcLuTeYZl7d7Od6efhGkQsOX5eUcnVRbXUuHlPIz/5rUG660TXy4QmMfGF+ctfNwWrIzQxeB2yiQxuEUDFqEXsuYB6ZZpBZ3Oolc177cpUzjBxLvegpqy5YMdeFMExHMjf+/R/NIYXw7XqjcYPqJf3cpG0GyoMmGlcpopUiMPBXP2Eu8k0UZpunuzSV1KVkTwNmg8GQfViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROq0lbKmEBReeOeebbtCthxh1feHH1vYNiKBIN8chzk=;
 b=jTUBSlEncJK04sIw3aJe5mmK3QgOR6aNRIKpoypdzV+3n0qqNmaA1uOLRNGh7F9GMVIgRv+Sbp9emlWAsHeSXx+DC8HQST+uIjqoSsdzlpdhLdwQSu9A+OIpFM8FTC4HKGsB4yclaSmpinKD9xlUYr4l7fHpQmDoWlI0Lpd7Yuj3z/3e2KcH7OjW7i65rxOcKmpzDtwJVk+vz4Bm/S0RhOW0QtqyXxms600Pv6JRVDEQCE9oKZnrpstEu92+2yNQmY9WrAV+c0pyz/+G3CIceMSmFggLcnpXVXomIc3uT+PjCpxxCpHg87nf6lc5nerO/yNsisopQ7UhKqJEdVF5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROq0lbKmEBReeOeebbtCthxh1feHH1vYNiKBIN8chzk=;
 b=YOSqRC18b+Z9l01Q1z5ElM539bSOl2ZzrCdBSpXViehchtRL2xi06TsMctkSfVgVaHRSy58sXbPfZxSPxmvkHMhYulPeu2UeLzvzs0oR9pYOayzs+oVF2qXjjWHPC8X/nfDLL12eYg+nU/ROHZ++0hvHbJTr1FsWW+i4cuUNCdJH+4WCdliw6TulTWUXXzWI8evXfO1QsQy2duQBLYvBH5HkHCcwUdnAMMMtC9LM6TNdQlFQ4HYP930xMruAviHNvtJwu79zp4Vrd5dKb6xDBMYbDHyYGvRbY9aRFJH+2s7b3t+wLX1+KHH8KxndvfZHxgmn6VMM+swWxwKyxy8Mdg==
Received: from DM6PR21CA0008.namprd21.prod.outlook.com (2603:10b6:5:174::18)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 25 May
 2025 11:15:53 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::8d) by DM6PR21CA0008.outlook.office365.com
 (2603:10b6:5:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.4 via Frontend Transport; Sun,
 25 May 2025 11:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:15:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:15:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:15:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:15:32 -0700
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
Subject: [PATCH net-next 1/4] net/mlx5: HWS, fix missing ip_version handling in definer
Date: Sun, 25 May 2025 14:15:07 +0300
Message-ID: <1748171710-1375837-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
References: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d03e02b-9f9c-47be-7eb0-08dd9b7d82e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fz1bVE3Lp2t9+cXvgBDgw1LBGdhFlgbYDDJmamJhWZ/+VFpSAn6y95MnTsTv?=
 =?us-ascii?Q?dpzF+nLGbl59UB4zqvNXEOycbxzU8UeDEuriBrAnh7eWPrI6AIpRP62oUfSR?=
 =?us-ascii?Q?xUDVhhqa5Ww6tzQ9RHwn0kBmnIs5EZGoRPVOc3HEF4upMt6Di+ntBmw32xQb?=
 =?us-ascii?Q?tZa4SjoGYVOUHaB5WoulV85FGUnA52HjKAgOw5Cm7ssMQwAkorO223pV/BHH?=
 =?us-ascii?Q?TIpF4Wam76YcRUDV/fakoXD05eij5ZS2D4zviH8PQ4yKeceIby2ZhAT1T0hI?=
 =?us-ascii?Q?HBloxtsS5b4WThDo/1EbsbuhMF8Fxl8WHvcusPUQ+j7mgSAPEnP0ssuyip65?=
 =?us-ascii?Q?87odXHSQR5eP4BDeSLXK2fjv4ojIbp8fScL37THzJMwntO1MFbWXfhsTrJF7?=
 =?us-ascii?Q?xDS+ogHw8s6JAPoeY/i83rD/CM497JdNk2zkwTkqBnI03Dbayv0al1y9xGI6?=
 =?us-ascii?Q?uwlImf8IoJCPUWvDnueEotp++BmJGCqIlpk50mElJpKAJ0c26lFGrOonkH07?=
 =?us-ascii?Q?q32vjDpGYWskfsxrRN7ZNKu4lq9HjQV+eAmByCHOnIri39bJ8/ppyqPUDm1Q?=
 =?us-ascii?Q?K2S0wnXuW0hJwhxyfGmDkLdbf6LJeBbUFbX7vU0vv++cgOKBoCLJnl5QpBe4?=
 =?us-ascii?Q?cvOlGZtlbO9XZS4K51iB3kkR1LOnBiAgnHxIeiRn+9qNFgOvZwcZ1zlRkl/E?=
 =?us-ascii?Q?o3eXozpTbWrnshRywH8+CzMQ64P2K8oNUkBk1LUAVN6Zpdp+0ekiXqomUA/u?=
 =?us-ascii?Q?YbhAJ+roak9ORcbdSTj1Ahig6lagCUifmJQp/fZn/jAIVog72d+uhfyi7d1J?=
 =?us-ascii?Q?WDKrmps6xumHYWEXMRhC1rRhc5zZlQAVqhDeEZpRgEP7hXJzyCqfZ/E+wyVN?=
 =?us-ascii?Q?WAm2p0tL6xh5/z4bgc1okOpx1wuLYM/+NHq7ewgJOF+4eWzN24x+LrPvCgtq?=
 =?us-ascii?Q?j3IRSHCp4m7pVJqqe5kQwOXG+I/vEyhwZpr2Lcuf5/GOaqgMU+Ls8xfnSw7e?=
 =?us-ascii?Q?Ueg/1QluNKoIDx8L6221iKccoscueOnpfCW4RPLdeX46l0/i5z+X8awpA4x+?=
 =?us-ascii?Q?+wEdKXIM6ed9Sr9s6bAZRi+a5f5vR90tCtkZNxcSKv6QsJjGqcqfManIzy6B?=
 =?us-ascii?Q?bJnuLjbWrcduoo23Xg7DFTHpjs+OeHat4QxIZGkPQ9jqBCOjGN+/b04NqbmQ?=
 =?us-ascii?Q?70CuuW0iuU0bcyXrrZ300YYuUf3LB6sOtK8O102/LzylFncm8RbzN3y/XV6V?=
 =?us-ascii?Q?QEmPRXzUIcMmGk2znfIxiDrZA9oPebt3dfCz6S+fglQn59HK+1ga1uY2L1Lk?=
 =?us-ascii?Q?0fbQltYptUSN6PVb/EFC/QTRIiKQieE+YpGsV+cEKx9Pjj9yIWI7T3Rm83b5?=
 =?us-ascii?Q?X1JV0hPBiP26dOgB1wH/UGfUxyKUGmP2RNC8l/nbAPxvY8mf2+GmtXepvzyW?=
 =?us-ascii?Q?Kzh+gK1shIwo4L7CTqQADqy+zQGRKwc3YWJZzJKmtoQRI1k4yTndvMSIX8OO?=
 =?us-ascii?Q?Asq6tFVVh+ik8Mr1FTDz22RTEMfM4/aWG+Av?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:15:52.4151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d03e02b-9f9c-47be-7eb0-08dd9b7d82e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fix missing field handling in definer - outer IP version.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index 5cc0dc002ac1..d45e1145d197 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -785,6 +785,9 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 	HWS_SET_HDR(fc, match_param, IP_PROTOCOL_O,
 		    outer_headers.ip_protocol,
 		    eth_l3_outer.protocol_next_header);
+	HWS_SET_HDR(fc, match_param, IP_VERSION_O,
+		    outer_headers.ip_version,
+		    eth_l3_outer.ip_version);
 	HWS_SET_HDR(fc, match_param, IP_TTL_O,
 		    outer_headers.ttl_hoplimit,
 		    eth_l3_outer.time_to_live_hop_limit);
-- 
2.31.1


