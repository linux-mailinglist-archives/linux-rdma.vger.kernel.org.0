Return-Path: <linux-rdma+bounces-9706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1873A983D5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA0C1882C4E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4C627F745;
	Wed, 23 Apr 2025 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0kP1icg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68F26FA5A;
	Wed, 23 Apr 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397411; cv=fail; b=qFQ98PknA14qfLysrdoPZJ6Xu+PlbfmrmacM0tUiq0aHHSacOZcKDp5/YfLRR5TXMX24jLBccRXwI+U3y9h9zKlAVLm9DWri+vIOIDqtXBkjS2IjOYutdYaPEvgVpefteIBazyAoOxjK7529h6YgqumxGJ6eOqwRQQ+GSqJxg6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397411; c=relaxed/simple;
	bh=HTa5oU/JaRYiEIpV+vDIEhDez5qIUzU+gS2FS3m6sDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqVLMf+nwEiQa4zE48GPKmdhy425Jt5LNXbF3MRdw/4W6TDkn+246TboJgliOOddN7woRUBGI2abFUgtzHtt8DvKkKSUl07+FRrZjLVEelWqCvb8QFV+si32Kd48aZ2Fat6gqep8Eb+FgUapNTZnKUWPXdZTn2R9EWERJGVDo4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0kP1icg; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXzcHnuXblWCOvwR3xZRzD7mJU/siAlowg9cp+lWXokwPBzKwO5DQQvxwzQZ3BBMJk6QE+2JG55s253bfKWFA19Os5yyzDIKrdMCjg+8PDxlvUOGVsO2l/l/d9BZ1i+JVAHh/UlAQUq5h6pNyam1TcIK08/lyCSV9pQj46iHd3sLQ+G3U7Wc9RhAQQ83ZKBSZfSG+K+br+ThpRmUFYP9Ngi9VDn+9LjHqFm80rx0+yrE69UYLkBuB66SeQTnKbj9/g2XyDkTAZRm42sTTFRZyzRyfxAsCoNwjIZhzQYWc/WptsHynDfNek6KxtxudLyWUnVHzTxDbrFvT9eYMgTHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd+baZ+cQ7SFVqbeNhBwzkthKJI3EvwJKeZi0rXd/kM=;
 b=TCqFRxNjB1PbtxabQ7BlPbhyju8aYOV0qnOct3W5DV0PCNWh/Z0MYgxDqgevt2AQGUMbf4zU/p+dnBNhmXLiSrUSryvjUGGBZ2p7a+s43by8Zt+7gYh0cbfJdcJxDj7njcBpTporB9goyICKcu49xaDd+43w1VHxK46MfrLVYHonD8nXMd1xOjlaoHUpzhIxjfMAD8YMEIo3D/JMXUASC8BQ2Ry+XkK0qR9YfWkbHqngXAVVIWNvBpkUmMt3xDjCJSS0yWBN7IOmt0BrEvUaOJ6PlDhXXSEC8jMbWXBKPMG2mOQH/MsWZnA/Nz6mOPMk/KphhsyhyAPtXs6TtXFxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd+baZ+cQ7SFVqbeNhBwzkthKJI3EvwJKeZi0rXd/kM=;
 b=c0kP1icgyMI1W9OuCo0mMYYDK/kNGw/Gt96+CeWMxaGamaZDHRkWbSuIUcLOt4R+pRLuX6z4lW01qejz5VvMetMS0bEFy9zYNYwU5VBgsR/BuQZEQXcFm7qraQsMliWuDc9OieEMX5lzEheNMJpNU07Haw6Vx1aSJ/aZ/3AKkDVAJiiORJeYCYFfb+dvmjsp4XW4E3Nk2nUSISmsq+2U3iJrPpfVYE1l8YuXSx5FMPDjp0EErZ2SAO3Sy7toFtC2a6ia9CE3awLrmA+hwlZuH3GqAiF49qI0L2JNIGlPslaYDLQkZQG9wYIJt4MukUNw+82UEJefX+FtAKZAitis5Q==
Received: from MN2PR19CA0035.namprd19.prod.outlook.com (2603:10b6:208:178::48)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 23 Apr
 2025 08:36:42 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::25) by MN2PR19CA0035.outlook.office365.com
 (2603:10b6:208:178::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 08:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 08:36:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 01:36:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 01:36:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 01:36:23 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Maor Gottlieb
	<maorg@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 2/5] net/mlx5: E-Switch, Initialize MAC Address for Default GID
Date: Wed, 23 Apr 2025 11:36:08 +0300
Message-ID: <20250423083611.324567-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423083611.324567-1-mbloch@nvidia.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 035a99b4-2323-4266-0168-08dd8241f8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LUqY+1hmBGApUTYNqXa1enWLYWkjyCSzc/bfBlk1deV9sekIXHxuL4qWXxm?=
 =?us-ascii?Q?UwhaU7CW4f4JpNgJ6QI1JTIqZ32d3KuSc40JyDIq8nOridU5ANBVJhF5lcTY?=
 =?us-ascii?Q?yEOaVEqtxxAO47TnXbfvKieLoiiAN6jGZ/6vy+mKXX4uyftHZusAcnEXVx2c?=
 =?us-ascii?Q?ITxtQFBGFlkfdjkVZS3wYaNOkUB6IlHeicVk5mMe3W/Yt0x5P6IczK+jzUMa?=
 =?us-ascii?Q?7g4vxhVlmq7SXf2L2TOBPza9l+7/PXSuzsj3rjypD2qT2cSq8XEoKBtYczw9?=
 =?us-ascii?Q?VqcgFB+ABHqzISypWqn3ebND7a2DIWgYKvr/PcVJKH9du0uNX0tffqkp52GD?=
 =?us-ascii?Q?kV30GID/YbXqhWaH+yyO4Wj2Bl4QN8bPVtUZKlrvrCKcLPMr0V+ZmT3w1p2H?=
 =?us-ascii?Q?v45AokvvKrs++RZ4JgytuUlqeDM/10tRys6/flEqnruP2ArgpdIZtqGJryKa?=
 =?us-ascii?Q?+7oMQuT9udKFD6yIPVLNL9enYWEtSk78MyMPKpAW5KlO7ZsT1/T27e1EyW/f?=
 =?us-ascii?Q?doXy1IdaLBWytVef1D3zeumqN8nH+Qyg1BZ6Ij5QykEsgeJNuXDVX98D1bdy?=
 =?us-ascii?Q?yq+E8F221EHtMdXTVPJFMXBXTydKf+QUAPOhWPn8HD0H4o+L3xo2jA8zSDta?=
 =?us-ascii?Q?glSc33M2Cos2LRcPwiplEngLdlRusjmXzLQRFm6IvFmfhQT2y16tXxXdUD/I?=
 =?us-ascii?Q?0Nm6kBKxPvlMCeV13jFhzAzJXqRs18v3DNQdvEFhJZgOVMBbJzvQBzTQJq05?=
 =?us-ascii?Q?xLeqKwBZmwh8AY+mBP2VCWyuuxn1EHRQfX7NM/Dv3CxetcdFGOL53f7TWtpR?=
 =?us-ascii?Q?9vlYRjQP/7RWAx0rf1xrTrUHfJY4NZJ4rI9zPtUQl9Zg+d0x+rwx0sBOcgk8?=
 =?us-ascii?Q?qRhdxLUabIcaB+jnInpXGT774Ya5tNdOzG8pyv+3B6gNYpIDs0gkNQW55NMx?=
 =?us-ascii?Q?g3kMoYwMSCdTW4lPIxNWrewScqx++gViDcBkRRBh7U5lyitXplqPIw/yv+sg?=
 =?us-ascii?Q?TeJQ9ymQH+3kuAWYlOqld6lj9UpWKRh3BTSPIVwkRgiN4aPkDl9nBYtL9rlc?=
 =?us-ascii?Q?PENMaYjT43ZKTbOKqpbW8slENSfgF/toPERiMyfz/wkWsGMJZ8/XKkPYPaFZ?=
 =?us-ascii?Q?Jla9Me5fI7dMPrT0G/Rmh6SbaI77dS9nesChLPuj83A2ceQ/Fv0ZqojtbNXR?=
 =?us-ascii?Q?jkwweP644IeKVecBIqXf3z4Ng17Gbx56PEpEniY9WpWHJpbvSOXKoUd0QR7j?=
 =?us-ascii?Q?ltpDu1fwtTtarwKVFtqigRQ4Wyh2CO5GUK5/4sJXY7aURMcin99iNxjwcwGd?=
 =?us-ascii?Q?r0Q6ifT5E+WEs/Hw80Id1WpVOgD7XhE7uUf8xge7g6pJMIdqIA2yzrEMP4o4?=
 =?us-ascii?Q?+qbedLg0plC+oBs6SFVwGDMTUaKARx/GQzGjqMI+HJ5V2E1cNUqmUXB+Tln/?=
 =?us-ascii?Q?ZCgleMw26/ny05tsffPubZeM52fekl/owrKKEoEra9Xi7F1zi4ZDTI1JsOfo?=
 =?us-ascii?Q?G4ClIO0H40Fqzyc2HBNn8vOaLzaKhiz+7Cfl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:36:41.2920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035a99b4-2323-4266-0168-08dd8241f8ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

From: Maor Gottlieb <maorg@nvidia.com>

Initialize the source MAC address when creating the default GID entry.
Since this entry is used only for loopback traffic, it only needs to
be a unicast address. A zeroed-out MAC address is sufficient for this
purpose.
Without this fix, random bits would be assigned as the source address.
If these bits formed a multicast address, the firmware would return an
error, preventing the user from switching to switchdev mode:

Error: mlx5_core: Failed setting eswitch to offloads.
kernel answers: Invalid argument

Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index a42f6cd99b74..f585ef5a3424 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
@@ -118,8 +118,8 @@ static void mlx5_rdma_make_default_gid(struct mlx5_core_dev *dev, union ib_gid *
 
 static int mlx5_rdma_add_roce_addr(struct mlx5_core_dev *dev)
 {
+	u8 mac[ETH_ALEN] = {};
 	union ib_gid gid;
-	u8 mac[ETH_ALEN];
 
 	mlx5_rdma_make_default_gid(dev, &gid);
 	return mlx5_core_roce_gid_set(dev, 0,
-- 
2.34.1


