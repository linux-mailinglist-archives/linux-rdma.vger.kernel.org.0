Return-Path: <linux-rdma+bounces-14564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37FC66423
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D617635B3DB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F7D321448;
	Mon, 17 Nov 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QQmMxLxk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13663233E5;
	Mon, 17 Nov 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414404; cv=fail; b=BjZQfQB0yEjUHVKfQeaofEsnkOsdXW6WNZeRvn9I3Lse6rQQJrbtkBzCiWdNR8Yo6rsCcTiWJ2ihMnF8SHgTKGjfPnUNRbyHUqGZrDABAgLvHTc8PoxG2nahrvc5T7Rriggm1oO9sgtooN2480lBcnWvdFo6V8y18+2uWV+86Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414404; c=relaxed/simple;
	bh=IekpWTTBRrUlduFljFHpQTzU88sdddSa0VT0TYcQ98E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRRkk3+CwqmgoCl+GJuFiH1YND0axvQlJMLcTa2cbhxR79i9ydZyMEeTfgfHAv1bAhUXHl/7Ae2hYwGb+z4Twh1TorqH2zIvXnB1hieBS2OidViT+FVR6v7a1jg8ncNTysTqol1T3Q0H8LfNoKlwiBSy8lZU1TkIxiCEDOMlFB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QQmMxLxk; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWVXI0rqM3PMnRcBWF4rN3CspP0x+HVhZ5lknoiB6OzfAvhxjn+4+I8PF/a6+SS/n3yFZ1qahXbFL7BjN0dxLllmuJAfU88vclk5ijIx+xaAjBBSJp7JW9g6H6tKckr2bIWug4wwiOozd5s0SOm0/fYtfGx8eQS0qdhVJAbj9gsya3wdB5Aje/R3L0F4kF9Eh42klJHMa+Dp4aUOmyI4Jwa7vjATrt2nxKrSkA5ATkQBhaPPG329OKAQhpFp/TYHaPHkroup2ZmNr0qlr7ZMYQWPS56d5zEMn13NDKp1oqWdnIdQVDT/yJ6zsCanTgW5rH9JteqV+Faqg4bAhkXwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzBAW1EvB0SoyvdYrDmXLE2p+uqDgb5mODTDO8c/7Hw=;
 b=Fss494rK/hfKlzHUaC9erBDSwWjWhpW9Uh7gGuZ/63zAYKPiMgkSHA3fkcd4EteS+otaALU+FcZgTO56XwP/hqxciwvxLkDT1RYXpiTeL8s5llby+ONLenHysq39PmWSFFmuKEtDtfIM1+pEy81sck8ec1DCJEbACde4MUSmEceIgMhWv8+2uxeP+aMTj6V4EK/nzEqG5hnq3v0cIxOlaiFVt4gn74Dqfj5X4+zGLsVgmaPBIg3O31NmlJiltKtf4AIsWnt0G/ERyCfrcmwkrtTyhgB8AcgLbIjl3/7Md/w/unvU5SujawrEzR1roDiQebP3sKUFwoRQNw886Rb6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzBAW1EvB0SoyvdYrDmXLE2p+uqDgb5mODTDO8c/7Hw=;
 b=QQmMxLxkWapMxcnOVd09uuBstsDVGPXK457w2xokcdC5UXaf8m+Ia7fDtdVkGOZ/mLhGmg/P957cH/Fgjfc9L7l8EO2QXwdgDSHykjbpzxvAFhOIYPWHaBPqz7syTSqnu89xUY2PHhX5K7VY8QBFIrIU6GCHSmq0owlfafXGpdLDPJEkZTUoc3OxjFJYt+i/cQ0tLZE8Xf1kAjE3NwCQT1OHKrFDmGHN0XTBohLgOirDpL4Wzcm/NSKYKZuD1ICKWIbVjCeRvCqaa0Dv0SJx4w0AK8FG6BsYgtgnJ4aPKKu1Vsby722VHuPXV+DFi5TlS4J8gHiBNHEf+3QFGRimOw==
Received: from BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::17)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 17 Nov
 2025 21:19:57 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::97) by BL1P223CA0012.outlook.office365.com
 (2603:10b6:208:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:19:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:19:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 17 Nov 2025 13:19:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 13:19:34 -0800
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
Subject: [PATCH net-next 1/3] net: ethtool: Add support for 1600Gbps speed
Date: Mon, 17 Nov 2025 23:18:58 +0200
Message-ID: <1763414340-1236872-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b27483-7202-4df7-9f32-08de261f0eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KUoBjIec/kHqAfjFPIDe5q0sNQQbUvisQ5n+iUnqYeSJi4sfu/Df1lf8FL8h?=
 =?us-ascii?Q?mknxWP90JObM1bPkVlq1kf7IacaOmUEuwcqO62JR6CKgBUu4c7UM38eA3lXB?=
 =?us-ascii?Q?zbQTySoVeJGlO6CNBpYp80L1pTKMFyKEkJ6MJlpUechZkytOnm5EJVv5Mh5H?=
 =?us-ascii?Q?8eh6w1UjyeG7NxUZIZUwSpatxGuSbq06xbRSEgJ67dJN1qzlLjxb61uFohbH?=
 =?us-ascii?Q?NVpESDy58Br3Rik4jy0rBiX6sQrtct/FMmylJtcPVN24yB+l2WSg75LT6ejT?=
 =?us-ascii?Q?ibbJwV690GL8IPbBpwOEO3XNH1K5gd+APyITNsND9sl9Ms+kHXhSI60/p/4R?=
 =?us-ascii?Q?vvNjbzw+KscqAl0NaxnGZ2I6E4jhtJwL5TNBw+qgJtb7Jb7bOj0a1hZxu8Sf?=
 =?us-ascii?Q?3FrUVo1sgit4vCpxhZHjEQSEkIbu2i9g8UgN2jXONyWbnfPM0JkXethBWYtj?=
 =?us-ascii?Q?F0Xq116OQAMGYVcArvULPW0O9QhqAvy8oGWXoBSIwbAnj4eTFG6PZElWF2N7?=
 =?us-ascii?Q?TqcQMI088agIUJ4a4SQm7ullGO9UcuVdoINcPmrajVG/D1DMT1tvcWepPuy/?=
 =?us-ascii?Q?VkdTmSatdKUesd5NCPHnt1fTsla6fxh2yk7lk8wVjcY/1njgvW2LPemaFsSR?=
 =?us-ascii?Q?1SyWjvVWVkpRzTZI1qhkQgeLcpJ4BjGfoAAOtWre6N2kHZFP7Nd2tzEs/Bar?=
 =?us-ascii?Q?0Ca/2mHaEjQh9xPEL3ZGWFQ4P/VGVoZ3wJrd2FCL62jFvIlaBPiimtf//YhZ?=
 =?us-ascii?Q?CeGW/XqZpSbgs0VpxbQOczwrMQwKss0arIy31NfqCpA3UgAo8iPhrgSErS0m?=
 =?us-ascii?Q?fe+Ub0hX4DiZndCez8Gwbg/fnJfE5lHxOjRweYR32EVAFZciNZQDkULfoyGB?=
 =?us-ascii?Q?DrXtfwloBKSHFKh36yLaBxDnIQh2bu4AZYMtZe9tLwFruJv2A2cX2ERSMpZY?=
 =?us-ascii?Q?FQWRRLLUUj3XRFCmEEV45KRbg77NcFjsKP75pWhFRxlKgMNu3CGZzdNH6GVb?=
 =?us-ascii?Q?HTVHdeweZKp3xtQDXk0QwglNr/bJWrWgTVkh5gUWNZXAVA0RmJIxsaoIwr1H?=
 =?us-ascii?Q?9my0ftJI3DWhS4VYOodySpNEDfYlDaticbu4vZBE/kYNLZjDEzQZY1Eg6Xgb?=
 =?us-ascii?Q?tWPy8RRzPFh56cie2xkZ2xIgCP7+S4Qdq6A+8fy4DCEcOXWShkm06tVkC5PD?=
 =?us-ascii?Q?PG9s4T4oHux1pxEDBiMnOqEhvsFdRsNiNgGtF+BrWwfToXx1lRQsDl1YaAgu?=
 =?us-ascii?Q?hEJ/I3hNSLQ955VQpDBsV5LpD/Uel1YKc4cnZ4smUYwMQJ4ZdVE4Pe3GnpnZ?=
 =?us-ascii?Q?VAO73lOp/j+bPolx2YTfrq11+T9glfiwzek16KdlfDfWdPSEYKBBrsxoTzX3?=
 =?us-ascii?Q?VP5HK2FmtT7QulhvLcnQ9uc0hFJ3Zw7FfT5iGi/QV1qU1OUYb0KUX4qDze8N?=
 =?us-ascii?Q?meKTrsI/T4TpwI62ycjl6aHKPJ2ENzfGBniTqQMBRLMe05e+X7X7E0WHCro0?=
 =?us-ascii?Q?9MbGW6sEjgxzARnj4oSdbGH4BXQ1OX8UGIJKa1QeW4kCw3Gzf+3yEwJ6xVoV?=
 =?us-ascii?Q?11uZfUQeFypCGcJMol8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:19:56.3655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b27483-7202-4df7-9f32-08de261f0eaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

From: Yael Chemla <ychemla@nvidia.com>

Add support for 1600Gbps link modes based on 200Gbps per lane [1].
This includes the adopted IEEE 802.3dj copper and optical PMDs that use
200G/lane signaling [2].

Add the following PMD types:
- KR8 (backplane)
- CR8 (copper cable)
- DR8 (SMF 500m)
- DR8-2 (SMF 2km)

These modes are defined in the 802.3dj specifications.
References:
[1] https://www.ieee802.org/3/dj/public/23_03/opsasnick_3dj_01a_2303.pdf
[2] https://www.ieee802.org/3/dj/projdoc/objectives_P802d3dj_240314.pdf

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/phy/phy-core.c   | 4 +++-
 include/uapi/linux/ethtool.h | 5 +++++
 net/ethtool/common.c         | 8 ++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..f5705c75505d 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -17,7 +17,7 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 121,
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 125,
 		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
 		"If a speed or mode has been added please update phy_speed_to_str "
 		"and the PHY settings array.\n");
@@ -55,6 +55,8 @@ const char *phy_speed_to_str(int speed)
 		return "400Gbps";
 	case SPEED_800000:
 		return "800Gbps";
+	case SPEED_1600000:
+		return "1600Gbps";
 	case SPEED_UNKNOWN:
 		return "Unknown";
 	default:
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 8bd5ea5469d9..eb7ff2602fbb 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2077,6 +2077,10 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
 	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
 	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
+	ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT	 = 121,
+	ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT	 = 122,
+	ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT	 = 123,
+	ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT	 = 124,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
@@ -2190,6 +2194,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_200000		200000
 #define SPEED_400000		400000
 #define SPEED_800000		800000
+#define SPEED_1600000		1600000
 
 #define SPEED_UNKNOWN		-1
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 55223ebc2a7e..369c05cf8163 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -233,6 +233,10 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(800000, DR4_2, Full),
 	__DEFINE_LINK_MODE_NAME(800000, SR4, Full),
 	__DEFINE_LINK_MODE_NAME(800000, VR4, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, CR8, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, KR8, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, DR8, Full),
+	__DEFINE_LINK_MODE_NAME(1600000, DR8_2, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -422,6 +426,10 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(800000, DR4_2, Full),
 	__DEFINE_LINK_MODE_PARAMS(800000, SR4, Full),
 	__DEFINE_LINK_MODE_PARAMS(800000, VR4, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, CR8, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, KR8, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, DR8, Full),
+	__DEFINE_LINK_MODE_PARAMS(1600000, DR8_2, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 EXPORT_SYMBOL_GPL(link_mode_params);
-- 
2.31.1


