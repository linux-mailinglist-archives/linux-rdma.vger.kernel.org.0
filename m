Return-Path: <linux-rdma+bounces-14566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D27C6643B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E0D74EBB4F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14653446A5;
	Mon, 17 Nov 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WH9QpXcZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396C322C9A;
	Mon, 17 Nov 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414413; cv=fail; b=pMc+uYz4J+Pc/Wwg6U+voda+qmGzF56wcDqC+F82roZl8BdQnehZS341aa4K8bdjVQrLpM1PV9rBt7RGl+YpItNuWxZ/ZLHr6RlO7kD+bGv2EUNNmHu3irY9gI1ewRuk8T3xqdVydqYEQf4uAXry0UEEHpbHHVjeNigKXy4RYh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414413; c=relaxed/simple;
	bh=Pf16QcSJWOdZAPOHQIIu1FcTltrTbLN2LbnDoL8QYpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qx8kOewnNHu+h4S420Nl4rhI8bus3/cbhENZKdM8RlMiNGmENgvB9ox6wUADFUsUVCKGsoa+KJGUcbajWVG4Sd8gZ7b1T6vnZA6xasL3z4xbDik/SlUybMdv/qVRjr1uzlSp9Wyn1rYZg98cKGKPWjDPoBlXL5SrCOU2kSprkxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WH9QpXcZ; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdGh2QktpXcDg03bO5AQ26l7Dbja+zT3qZwIkPj2Ppcqsd5iRK7PliXhM6p2r7VL1FLXL9R9nxL68LqB4x2E7ZdqVFKEW4hgC7Lpe1sYvVnuV2p2/y/heWCf+CO8pi30/huXEMib5tpw1Kv/hb5z20nIUiWBJS3RoXwSXjxIMdqWKIqcf5YNqZoUjIV41JQyq3GDIBMmK0zAGVLRC+2AKeC+WtsK25oUzzPvS2DXfjsYIVqEq2N0HfrEbhiztS2OKmmLzrSpkCSZTwhir8ubsY0tco+5mGbuKGuSvkbMhomSxPTFpXaqpStZrGq98Gnqh17VEVrgkY9DvpFDu0FvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWkyx/v4Wlm5lKp/m8ffXWetGH5ykWDjIz/3LRW7Qg4=;
 b=rAUWvlPMMlT32uuVZRf5jrYvjPBL24ueUVbXn9bqMuSc8lW0V3FkPqVUv2Gs7zlAc3LQGNCYJqtUVMd31d2dkfq12MwaniGmLrfo4Qe99nndpibkh9mgQO59h2vuvF4KUvMXBwXpjjqTq9qEUMjeLKC3g18d0DYPtIgKx+9rgobgdTzmdAi3DopRdfBZLroYIeQNozvgMQXl7an06j2WgIQbNiuPORrHm8CY58s0i2h04DkDph7BreJGw9TOSRjF0pL32I15dCPeauQSCwjV8IuOFpVvWf15ERyqdHEb7mOwiD/GkwwDMAqoYbojWSu8glrrPdQfA/7jmi9vnm8YsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWkyx/v4Wlm5lKp/m8ffXWetGH5ykWDjIz/3LRW7Qg4=;
 b=WH9QpXcZPYKoE4qMXtjuiLBAp9cEjYFhUztqw/7KKaUyieAgpEeTFljXqJirNv0qCgKBxDkr4hEZ13/PX8D956VHKg6m8beYE/XlG+Mml4+WKOLu2DacOW6c20iTCvtgQTxHp0xASKB+6umnE70wuS/L+TwR17u734vsOS2/yyejSQu6qU9jvGH05g09sKCDRKn/jkGqhrjdTZcwWRIfz2bMIKfaVNr7XqJoj47KDz/qWNQeed1tMW1hEeogLbsVzTj4BrZgsDv5VM0h3rt+MZJ97GvhoNivTz/lPRSRX3bYWvOlt3ohVvC/86a9KKQxWIdEb/dwNvtTz3m7HAEAFQ==
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 21:20:08 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::b1) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 21:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:20:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:19:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 17 Nov 2025 13:19:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 13:19:44 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jay Vosburgh <jv@jvosburgh.net>, Saeed Mahameed <saeedm@nvidia.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/3] bonding: 3ad: Add support for 1600G speed
Date: Mon, 17 Nov 2025 23:19:00 +0200
Message-ID: <1763414340-1236872-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763414340-1236872-1-git-send-email-tariqt@nvidia.com>
References: <1763414340-1236872-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: cf751531-1455-415f-128e-08de261f156a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fKpCREwAlSONUIUR5eWgRiyMUvvkyW5hIIVivcbjKwGoMtigf/Dq4PWqZ3T9?=
 =?us-ascii?Q?jTyXWc2ac5UxDyr8RPLEwlqdeEuGuLQIaSRPjF7K8/qsqaag37e5pojqBi4X?=
 =?us-ascii?Q?o5Bq/9ptK0cpp8pnrzR/oTZ2YPbQ+UyIAX3iBGtv33Spko/wd4ROmdgYBHiz?=
 =?us-ascii?Q?HPvWEh+rDEyKZc27cfTToJJNmoEjfSmxKaHtY4mwEYMcNAiizIg5+BH5Z/Rt?=
 =?us-ascii?Q?4wG4jSLVR0qmasDyfc+zlCwr2Xxby9XgUePJyIDg3wk5jEiKK9Qxwf4cjQoE?=
 =?us-ascii?Q?ToSr3fedSw+y6jI6jjwkslGzUJL+j6befMmhxEl/H/OYgBu0ji+7Xj5a7U8F?=
 =?us-ascii?Q?f4YvRCJr8VHnNcslUqCfnELkyVLEjv2aIqgexsxUlT8DE42x5u7yv6aahCi5?=
 =?us-ascii?Q?vt9gmnwmrbLX0gOE6RbYcGxTxXCNtV58iQeIgRjoOzGaLgeEg24Y/Rjbf4W6?=
 =?us-ascii?Q?K8pgNklg6UJrEcluv5W7ooslK/dlOtBEfck7ygLUcN7tUceZVHIDWntZgFOs?=
 =?us-ascii?Q?h1AT4I7/6cHZ3QCf427CEAUAOPEBmugjbYdyGCC55u7Fae3euh5emtvsx+3/?=
 =?us-ascii?Q?9N1sGyZ48ik6rh7tDQoa5Zrh9MavDSg43C92ntkcC2tm4rQWrGkYAS6zHINx?=
 =?us-ascii?Q?qDnZITHA7gY+hwLZL2lbuigC+xS8Uq/tOoxAxLVys0/G6juhMa3TlPvawH5F?=
 =?us-ascii?Q?y3u5dwN7AAUd5kZXon4Z56gKpCMomb7Ls6pfSLWeBhQyAjv9brta6sCOCuks?=
 =?us-ascii?Q?l/CYbD7Ccgeh6yV/p8x2kRIYfdIurtB+U4lKi1Gd36TrvBgJTkrnk6E6Dk4J?=
 =?us-ascii?Q?Ph4n/f9waD+bZZS84HJ3uTpJbkop3rFdBraM5kLNQvIBmLtzoGzzwz1p3FVD?=
 =?us-ascii?Q?ngU99hm0fOD+szex9YZ4UuXDzk9s10rf5JsUkW8YHQP1APErNkgs0H0SZJRH?=
 =?us-ascii?Q?39BVDVELoylWqcAsFxkstOsbcJSSmLBsU74pv3oCzB6Ibv4JArtWWQtxlCnR?=
 =?us-ascii?Q?ux1AojvEeMyphd7FdvdbW/V90n6C+XiwgF8AOxcXOx+B0VKjMUxGyYAZK2UJ?=
 =?us-ascii?Q?9EIa3hXhQZOgboSvI/ikErcwfNcFRdq1YRuliav3dxVcmsivkFeoIOpBzqRU?=
 =?us-ascii?Q?1Af/flSWGue4+jUHKJno/ud52nrp5L6GZ6XB2G4RHheEK27siFBXvIVP9z7w?=
 =?us-ascii?Q?ih1HtH5pbF71EdlTjUri4Lq9VxUUu/Jv2jDeCTu1GeMs6p7HaPraJtO3lZr4?=
 =?us-ascii?Q?3cZg1C2tllxWR23OAgYbzEoXL0jHIqTAXyBFP6fZ5G6vAFK37zXcIsFgoLhV?=
 =?us-ascii?Q?nOeI6tWvQuyfNpU+YRFwQBNZQkwzLOlV2DlY9K0C+l91uFCYx1Q7VKzpoVoi?=
 =?us-ascii?Q?apXd+7z7+iWmekPxmtlfDM44XGWbPnkTZXBnE4VW9UJAuh+1nQYdPxhFCtlo?=
 =?us-ascii?Q?1EFEZhfWeV5pES5k/j7FnXSyRV6lZZdEzm9FeGwnPSgYlxrkv9qNvwmZU1ms?=
 =?us-ascii?Q?OIdjsswQ+YW7huTfU5FMLepUrcp1axQh95KF7rYS1lOkjCoLG73crthxnLjA?=
 =?us-ascii?Q?p+WIGIrstCcH/6XTgPE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:20:07.6530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf751531-1455-415f-128e-08de261f156a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401

From: Yael Chemla <ychemla@nvidia.com>

Add support for 1600Gbps speed to allow using 3ad mode with 1600G
devices.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_3ad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 49717b7b82a2..1a8de2bf8655 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -76,6 +76,7 @@ enum ad_link_speed_type {
 	AD_LINK_SPEED_200000MBPS,
 	AD_LINK_SPEED_400000MBPS,
 	AD_LINK_SPEED_800000MBPS,
+	AD_LINK_SPEED_1600000MBPS,
 };
 
 /* compare MAC addresses */
@@ -300,6 +301,7 @@ static inline int __check_agg_selection_timer(struct port *port)
  *     %AD_LINK_SPEED_200000MBPS
  *     %AD_LINK_SPEED_400000MBPS
  *     %AD_LINK_SPEED_800000MBPS
+ *     %AD_LINK_SPEED_1600000MBPS
  */
 static u16 __get_link_speed(struct port *port)
 {
@@ -379,6 +381,10 @@ static u16 __get_link_speed(struct port *port)
 			speed = AD_LINK_SPEED_800000MBPS;
 			break;
 
+		case SPEED_1600000:
+			speed = AD_LINK_SPEED_1600000MBPS;
+			break;
+
 		default:
 			/* unknown speed value from ethtool. shouldn't happen */
 			if (slave->speed != SPEED_UNKNOWN)
@@ -822,6 +828,9 @@ static u32 __get_agg_bandwidth(struct aggregator *aggregator)
 		case AD_LINK_SPEED_800000MBPS:
 			bandwidth = nports * 800000;
 			break;
+		case AD_LINK_SPEED_1600000MBPS:
+			bandwidth = nports * 1600000;
+			break;
 		default:
 			bandwidth = 0; /* to silence the compiler */
 		}
-- 
2.31.1


