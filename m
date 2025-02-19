Return-Path: <linux-rdma+bounces-7831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B5A3BD3D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6791A189C014
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0181DF968;
	Wed, 19 Feb 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r748Q8XZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446ED1DE4F8;
	Wed, 19 Feb 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965393; cv=fail; b=Ktr3/Z3na7kVGSyHvjcZ6sawVp9A0mRboije6ZoNOQeLwCn+1IRM3cl4PuHlBiQ+EBph9z/mtZ73waz5BfGrd6PBJruYVKws6G0HJo8ex/0pilaOlicjphCvrekBLSm/8W1zDbBql1ze1yPg8m6RRLdjnGVz/CXNF3qScv+eIFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965393; c=relaxed/simple;
	bh=7EievpWwGNB2ZwUyX7lz1jX5Bmg1b2Ghfzw0DSE3EmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwZXFfezRZypgz0dKTs5WIAVNMOCfUc38mWlvBXWvOizHWJuoo6L/qsq65Br/DBlXF2/vyvaMamjZqAnxAJ4hRNiDpOKftqI5Ibjkk/MIHJ0BjbvrtfBJkbKcDSTClMYlpUJo3Hyn4uislKO6vw0QdIokIbfNCL1WBmvvuygy+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r748Q8XZ; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bon8Yu1xILulgioiJCWv2JxOr1RFL5lfhoZRMtXPRdihKQhsxj0JwwUOfBzTArxT1hYvZfWkjcliKbc+bVdPgAuR1oMtEd0slMVNx7wLMb4OVEJu5yf63CokjLUpa39woeszVFj2q6KLYfIk4mqxqq7pCPMqDOGkoNBhNDvgxRc6a4WsR6e/ChjJiuW8cSg/3s05f+L5dnkL5C9rM7fuCJlZkqmltJ/ibEO9F3LNXjSUvJ8JuPsZr5G0kADJdXvwa2V8o4TW3wlZegUlj7dJfBLZDhSYkJsfQYZahbrP8cLLfo1KPLo+ng7+5XmdJGUg5UDMUtcTq73T5m6qdZl++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp196ZbTqndGY0p0E0wfK7Rr2Ue3AOTskVcskl0FwRk=;
 b=gYJ4P2h5a27aFshyC6sZ/0jTOfte9f6kVqz3s+tmTXz0E+6KxkYQShi+t3CsNJI0QWsYx8lrHlHFxY9poFfAn2BVC7P3eCxsKOX1NqVeW3wJmW87Fpimf/m0/cUP4qD9f5peDCaZqSNbHtwL+xs/Wi9KgermlWwLp5SlYJ2hnsNpPVv4XUfRHIRLg2vBOz/hzYomp+uDfbDUZFiDD5Rnezh4W8a68LvNeCb9+SgP9oM2uKYQ7vHIKMhCpvw/Gkzm6xsqoNuSd6KP5iEZkYc6t3rnurmXz5DlBlCJayJY/c4K6T3r2ioow1QysI6kG9OfyYSgbLLJUQe6YAPIgGKvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp196ZbTqndGY0p0E0wfK7Rr2Ue3AOTskVcskl0FwRk=;
 b=r748Q8XZqI6I/+ZZk/tHQXq6f5yZJITzYwFB6gqYxvbV8jIitMtTx9hx0Ieb+3PndXHiu0WUbzEXau3nLfoK2wT+lFHh0DqC3Ff0iWnNNc0UB46KsKxRMkrES4qtCmDOeBbCtGZROHjEYQKAIDg5JoFNbv5ozZ6Nv3gC0uh6+8YgPhPbiC9k1PFh6oe/0MdlwB291FUFb/tmUIqX933+PctFpi/J3+M6NXbdNp6AmRwh/vFedhhJWXEws/q/NzFhvIZL/0Htz5bf7yqQ1uCce48AQvsYhhmJi+aZnqVCIsfFCaGyKXyamM/Hf7rHacj91+lOrHAglF5DK428h7OMoQ==
Received: from MW4PR03CA0268.namprd03.prod.outlook.com (2603:10b6:303:b4::33)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Wed, 19 Feb
 2025 11:43:06 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::9b) by MW4PR03CA0268.outlook.office365.com
 (2603:10b6:303:b4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 11:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 11:43:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 03:42:50 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 03:42:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 03:42:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: Separate extended link modes request from link modes type selection
Date: Wed, 19 Feb 2025 13:41:12 +0200
Message-ID: <20250219114112.403808-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250219114112.403808-1-tariqt@nvidia.com>
References: <20250219114112.403808-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd27a76-de09-40be-8f90-08dd50da9310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iV5sD5tSq3/B+KMvlugIi2wmfajFycgF3r8YnNlnvD26tffpJqQaqZhrEq3g?=
 =?us-ascii?Q?sJ/xaq1fS9U6mqVcvW4XQHPjyG4t2zRiXk4ZXM3lPqKnE1pwWIx/UzjOeWFb?=
 =?us-ascii?Q?icLYqz/fQzxz6npWysn+gyHS2FyrTy99PrIlhk93MyeUFSueHpgk0YS800y4?=
 =?us-ascii?Q?z6CGVOLIBWLlf56bmYcUqTzbr0xkX0ke+La5LHJgAwddvgIaTMwwIcvSLOLZ?=
 =?us-ascii?Q?0l/qicrnzvdGin+f63THj8AUkj0w7XutnxphTsrwphMKXqzcv8z6YJ0M4Ti6?=
 =?us-ascii?Q?1h0ZrQyyLYBvoWldJjrr5MAd2C0mpJtcWwoSyyQSKXyalnK2BGze4sgfVcqS?=
 =?us-ascii?Q?WFvAG2rdX6F+9pAeZhua+FAStLHd5APlBPvLmuV2Nt6YQOezq9epJnDEKzZP?=
 =?us-ascii?Q?9Op6KlpDWlwosa/iDprxkjEGI89rqUlEmNkXya8UbGp7V5Hvk7kD7Z6g1xIo?=
 =?us-ascii?Q?Wt7TDmM1J4OjzWfXZD8PdgbE3CLCg1Zhgt7u11DguFIeDnI5yNX8SqwGq0lM?=
 =?us-ascii?Q?MBor3h5zFHeWnXKCOVwLUbqDc5khEoLOopgXjErs9knRBfQSVanh2jO7r60q?=
 =?us-ascii?Q?dEkxTDArp0HOT/moyd3rgTOgx7XV8xu/itY9PNPFt3tg4tp/HSw7Lq72dhxL?=
 =?us-ascii?Q?d+QdOx5ey/LALCmhDQCZdE0QQV9GurWXJUljrAgZAUqV3PURvdEo5Qceoth+?=
 =?us-ascii?Q?mMSqhSe6liHITyktwFXB3JNOsOwt5HXp+0tI61L5jXPQYm3rVBLCTjn2S4ZC?=
 =?us-ascii?Q?xOiFVZLyNpEAY7jUzWDwehtP+WT8GOC/gvYxnORPbE3nunL09VkDATRuqZgf?=
 =?us-ascii?Q?vXK5sh5maD7GBb3LkL9alzNP/0jsVcWNJ4956Fq+JT6ZzxcmvLCoVDFcikSm?=
 =?us-ascii?Q?LmVMc8ntqQ+AQpR3aJpyUVxWNWHJfebaf/iz9/jbqq+x77jDd9TaRG7wiVH3?=
 =?us-ascii?Q?OssPFZ3qrngZcZ+PQizMU/Hhq0K8TeiOghU/YSTDGxUDuvgSozNbKMgp6jR2?=
 =?us-ascii?Q?X26U6TiDNtj7PI9G/JEplbW9n31oMv9LeOFTUiNmZswKmCLohrYVdRBgekSV?=
 =?us-ascii?Q?M3Aes9xfdc9JSMU7w7/eLq7CKvgMdEftszjDMnIE7p8SzST0/E9MLA77WetE?=
 =?us-ascii?Q?zY1evb6F2q5F7ROJUsQnBGe8GVzsWMENA/B1W3QVhRaxBJe7olfhqJTTDs3X?=
 =?us-ascii?Q?2xGn5BG6KG8LmuEc+hAQkOpAv8unfEawiMd248s1q6VuHt8MXgdExl6Swg3b?=
 =?us-ascii?Q?LOerkK4jsLYrWt/86XPf1w1d5YJLdhHgbTk1/YH8YfSlsYqfO8D6+ak2tvct?=
 =?us-ascii?Q?rY8oK+ezngWBwpGdOc9E6zLiTHyBBKyuPg6qBqR+R7XdOhbgu1ZOVWEi/RRr?=
 =?us-ascii?Q?dOdTp8c0o9OcDheI9RxLNN4QB7op68aMcK5hla35GypCkSCDu2DlePaSRoYH?=
 =?us-ascii?Q?C39rfyBDAXxTo/MyfjHNyKshjoPLlsZgUMijwz9IlZS/dzPZ4Ob6jcvmlwsH?=
 =?us-ascii?Q?oMrIwlLL+xOqoLg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:43:05.5344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd27a76-de09-40be-8f90-08dd50da9310
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618

From: Shahar Shitrit <shshitrit@nvidia.com>

The function ext_requested() serves two distinct purposes: it checks
if extended link modes were requested, and it selects whether to use
extended or legacy link modes.

This change separates these two purposes. Now, ext_link_mode_requested()
is used directly for checking if extended link modes are requested,
while the selection of extended modes is handled independently based on
the autonegotiation status.

By making this distinction, the logic for determining whether to select
extended or legacy link modes is clearer.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 712171dd07c7..1bf2212a0bb6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1344,13 +1344,6 @@ static bool ext_link_mode_requested(const unsigned long *adver)
 	return bitmap_intersects(modes, adver, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
-static bool ext_requested(u8 autoneg, const unsigned long *adver, bool ext_supported)
-{
-	bool ext_link_mode = ext_link_mode_requested(adver);
-
-	return  autoneg == AUTONEG_ENABLE ? ext_link_mode : ext_supported;
-}
-
 static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 					    const struct ethtool_link_ksettings *link_ksettings)
 {
@@ -1360,6 +1353,7 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	bool an_changes = false;
 	u8 an_disable_admin;
 	bool ext_supported;
+	bool ext_requested;
 	u8 an_disable_cap;
 	bool an_disable;
 	u32 link_modes;
@@ -1376,10 +1370,11 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	speed = link_ksettings->base.speed;
 
 	ext_supported = mlx5_ptys_ext_supported(mdev);
-	ext = ext_requested(autoneg, adver, ext_supported);
-	if (!ext_supported && ext)
+	ext_requested = ext_link_mode_requested(adver);
+	if (!ext_supported && ext_requested)
 		return -EOPNOTSUPP;
 
+	ext = autoneg == AUTONEG_ENABLE ? ext_requested : ext_supported;
 	ethtool2ptys_adver_func = ext ? mlx5e_ethtool2ptys_ext_adver_link :
 				  mlx5e_ethtool2ptys_adver_link;
 	err = mlx5_port_query_eth_proto(mdev, 1, ext, &eproto);
-- 
2.45.0


