Return-Path: <linux-rdma+bounces-6244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5169E478B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD4167438
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14911A0AF0;
	Wed,  4 Dec 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bDXhyncx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BC1922E8;
	Wed,  4 Dec 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350300; cv=fail; b=c415WkpZaiEcbIhcREFPUBEH8JxQixpJCyc/QJtunm6EGmxvB0W/IjkRVFBrhd6MqkyLceF7UrD64bocqsZ5uv52GFcxj+3BiV8MhNu1uIiKzt7D5T53rvpzlRtERQnUHk+lzZeGk/ZFb0OBO+uO2TFYj7EohbmXoWzQbZplbxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350300; c=relaxed/simple;
	bh=HIeby63zlBVtNEym/1TK6RajyVz1Sc4CtkbCJmkqEfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nO5pxl27FC4Smzhw/SjN2vROa+nhifSG5q879ykQotvC/xWaT/o9NvDLZsBJrHA2Z1qQ6YLQGeiKMxEBeyEdQBY5vqKXKeQLahqDOsew1yuQJwpbOkJ/RiGVnzZ7Ons5WhpnRI4OWuiwmiVQwDju6g+ZP99zVpQCQ4V1EeIgOJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bDXhyncx; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGHeQsSj/T4ADq2vIXWlnXw/4B1w9JZRzXBFubdcrJCYP7H7cnkMXLgoaMy2enZSBnb+wF4NX+/OmG/FgUbCH0Uzg4hw7Z60jVJqSbPQRnIHBJTBkuqZLfJTFcjeVW3ZjaG4iU4o1HWclcX4p9HUuePIFrHnb3T7GxebiNpf1780HVBRL+j+DNj2HAiDhDcW8rWPLg9FlyzutJXXSSqn6kmvlLxLKqYeFPmO55x8CBLPqsXxUUfMfLO5tF6JdzQwsAckPBflV1PFckFX1OpA5YpvVKxZoYmRWgnpvH0sjqUSu65RvT3Tm+b+thSYUtbXpB0cRMSsTzkX/GyHOpXXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B98sCeREJgBNTceVJtAoIDlxW4LsRiUDtglf8xuqaaQ=;
 b=BxjRA3OFprkStXW72KQoqk5QVOFqJ2lK3Mvukzke56RdzxLp+u7ThKlEnEDt2CSIAryFVOnLPA8QCMfZzoTYFmfv1WA3xkbyE7jZ+g1YHKOmo149KXuDEvQveVEGqvEXuhpBIHnTDX/KptDWHrZxP1+iHIuZ+1tKbXx/LNTC+GuAlOwpY0znZOO8GV5hff7uVVt1xtylO7tgmzmrMcDEX8yWZv1Eyi7UU3LWlzUQKPi6sYLAYPHJRVOWDw2BVVtmNMgHb3SnB0Ph0mk55IAR4KVCqzQTjxk4S0UapzdBrzzpBC0Ag6fbmymPeplnDlvP3ArdB1o+v0GxNsvMhFVduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B98sCeREJgBNTceVJtAoIDlxW4LsRiUDtglf8xuqaaQ=;
 b=bDXhyncx0GvT+UklViONGPHgGQo8KMsMKCM/wpC3Ll/7RrslIqOUbHE8dgXyZ6dKC2G09fU2+VBEMlib1f79VWb1CA3UgbS6KITyPoNpDFAQ4HdGOz/YjKDOX0TJWPAxSONpCDHMNDwNXdS3vEE2fLgX94wq2K7NIaEnPtSyR3R1CdtoMzx6VXcIdbkEGbyAPJ2+/qN9O6H5w/l4miHBIq2Dh1s6o+Sgg4SD9QRpIEA80lotC8OLiP8WSsOtE6CrYYTBE1oZRwMkYosoAPPmPBYueh1UCYEzILjeww6W7mBc0GhH5a7RWrQDNoOjxBWmdvJbAmwnK9Rnplbsw0eCRg==
Received: from SJ2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:a03:505::19)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 22:11:35 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::cf) by SJ2PR07CA0020.outlook.office365.com
 (2603:10b6:a03:505::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.21 via Frontend Transport; Wed,
 4 Dec 2024 22:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:21 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next V5 04/11] net/mlx5: qos: Add ifc support for cross-esw scheduling
Date: Thu, 5 Dec 2024 00:09:24 +0200
Message-ID: <20241204220931.254964-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 82eefd5b-a5da-4e2f-70b7-08dd14b09d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8EA44L0Fh/cnEFbIVw0GmHHr1ZJGgXJbfwNmIhNAGEPU1uNJqoRhmcCHCLBF?=
 =?us-ascii?Q?pGjKeTetK18yAurzOS5UJXV4oE6I5m7zw8EPMXhG4Tg1+lFZ6i882CqPCsC2?=
 =?us-ascii?Q?+e86/OCVWrairwth6JNvChjd1kL0iDZj/Ofc7Qmupd4YSkEDcaiFFB9WFCes?=
 =?us-ascii?Q?7E7mrlGjwulhF77YXvJ3ruO0znaWpuFkRoqvHqPk2/uE9Cn6p9I1OaSBsQ9a?=
 =?us-ascii?Q?KPwmjMLtRyncTiuHpEmMCxdbGZQFmXKB3pt+qYHa6phC0VcOVOVM28kVc79U?=
 =?us-ascii?Q?hGQVXMSbJV9xVxiOgOyytScaiSgeWINIWAuMFLeMoUOsAzKE+W2NCR8ESqC2?=
 =?us-ascii?Q?yOZ4VLYqJ8CgK5JClhJVjrjqYa4OTV0By16kdp5D8/ulk6U3ppJjbrsO4rsL?=
 =?us-ascii?Q?zWv+7i/YjhAP3Aw2EVV1isobDeXvwOFjs9bAFOdHkiWbsE52QVq/0GQev/1w?=
 =?us-ascii?Q?A1j9Ju01DpTyGfSDUGxpKeBqy7YekWEOoKhXo8U0jjGUG+I4HTUz3XVsSAwm?=
 =?us-ascii?Q?R9I1D4lAcYeqVThMUGat8KwkRz61sETrUbXFou2R64hAN+pQ5a47bXuEE7+e?=
 =?us-ascii?Q?siqrs1tzG7MXPNBjXCqn0FCW+LuUVQ6pGNAsikdW/cH4TmLwOaYZB5QsR3pa?=
 =?us-ascii?Q?Vjh37kCxdASjzxKGmdi/KhUcSSl2hOUrQ65iMBU5WqSsnISYxzFui+RqSAIE?=
 =?us-ascii?Q?eR0D2osQB3sVkyv6ML12rw8Izs0hw6Cfyg+pVLBnsHBlnjUlW68SW+ZBlhhx?=
 =?us-ascii?Q?IySVJJHxbAxIIM97PpKe8z5pESkEihSSvDzVRWMhtQap3/k6+CukRAAKCLdL?=
 =?us-ascii?Q?aQEgMSS7coDX9kGZ2go9lS1ffIOGjgSBTHQmuBZdwJtP17JXMRApcs4rDqJk?=
 =?us-ascii?Q?xdbMNTapJe9ZpW2qCrFUAGSuk4VEJoICjz7V5uBW39bO51TiCi39TlsCUbf3?=
 =?us-ascii?Q?aN2/zxRwmQG34HQkAXjwS5NPrx8MVic4RuEeF0raQrp82TwCetLBJAi/vCZJ?=
 =?us-ascii?Q?shOqLLayI8b6FjSNCaPNlZvJl5kE+qo3QY152t+QZyYI4Zs97HeHfi8qHmuR?=
 =?us-ascii?Q?mCCG6nvCZUSTpziccqNv/cXrCoenjCixDMub0LE3kRMg8q2zwHi8KYbF8WV3?=
 =?us-ascii?Q?tw82UxMIUUk6cRi5Ju86+Mp1v+KT8+Jyu0iI1gbnhA4wsqfmqWuGdJVtTmmP?=
 =?us-ascii?Q?mgWgIiPm3rFhoj7nfkV97Bs9FWf/0UHNxA4oTBquqiB1rOWVp7YKvDNGxYyp?=
 =?us-ascii?Q?7fRJFH8NNBbMLaZh1kTcAC7Itb8PtfpxpZ7uU5DO6HSH+/gJfg6b/NyYwzO8?=
 =?us-ascii?Q?S7Ytio3gKJIpYtjGFoeCqSoMnZjyTjvikfUBi4+qV3MZqpphnWyUoFIpzEPp?=
 =?us-ascii?Q?Ob/rcMkH5j8Z08BeY/cZMgNIfX6WkeZV+g3ebVPsP8UhyXUuSqr6yFfS0fSp?=
 =?us-ascii?Q?gc0OD5eDEXZWEJM9jyN9TeOxi/qzvZPp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:34.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82eefd5b-a5da-4e2f-70b7-08dd14b09d6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

From: Cosmin Ratiu <cratiu@nvidia.com>

This adds the capability bit and the vport element fields related to
cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 8b202521b774..5451ff1d4356 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1095,7 +1095,9 @@ struct mlx5_ifc_qos_cap_bits {
 	u8         log_esw_max_sched_depth[0x4];
 	u8         reserved_at_10[0x10];
 
-	u8         reserved_at_20[0xb];
+	u8         reserved_at_20[0x9];
+	u8         esw_cross_esw_sched[0x1];
+	u8         reserved_at_2a[0x1];
 	u8         log_max_qos_nic_queue_group[0x5];
 	u8         reserved_at_30[0x10];
 
@@ -4139,13 +4141,16 @@ struct mlx5_ifc_tsar_element_bits {
 };
 
 struct mlx5_ifc_vport_element_bits {
-	u8         reserved_at_0[0x10];
+	u8         reserved_at_0[0x4];
+	u8         eswitch_owner_vhca_id_valid[0x1];
+	u8         eswitch_owner_vhca_id[0xb];
 	u8         vport_number[0x10];
 };
 
 struct mlx5_ifc_vport_tc_element_bits {
 	u8         traffic_class[0x4];
-	u8         reserved_at_4[0xc];
+	u8         eswitch_owner_vhca_id_valid[0x1];
+	u8         eswitch_owner_vhca_id[0xb];
 	u8         vport_number[0x10];
 };
 
-- 
2.44.0


