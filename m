Return-Path: <linux-rdma+bounces-14736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B90BC82AE1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24F1234AF1F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD75338598;
	Mon, 24 Nov 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LaCrT+8L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE733507C;
	Mon, 24 Nov 2025 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023417; cv=fail; b=Y0pdG6zEap3w+hnvpgE/OdVHGnYaD29lUCJitfNvjhS9OZ1tWdgEffPWNAmxDnWJAx09stA1bmgblqkJOwuqHkIVoMR/ILsFz0psNos6AMSPIrHNbi71OzfKHx7MdfPzOtFTZEjHutZ4uKigt0Zo3GJLdkFSO+AZ9seQrAMR46k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023417; c=relaxed/simple;
	bh=eCQG3S/yOds8JQUOHWixmpPqBLMdmU/S/TtH7v9dU+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lA5rlBCHJaNUAKZO/7nBwiCVggKixwUw4Fcaz3LkRhpZeSa36WZbYrGteyeKEAhlDx2BUcFDW7GXL0mPLwCgaDsjuDKvT3ejYyBU70sZTzCDdPMzcvfaC+BSAegat/FusO1Q9fNiVHNvjbQFIp/SyYYenprccgldN2V9+ais8wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LaCrT+8L; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYD/BtUaRM7l71INqKysEud9tU7jUPky+iMSjzymZU34xtWo0Ijk8BFszs9XsnLbufWMqor57schsAaSf00ydnD9VKpD/3f2YulMWuaNp8xX9hBo131Dfgz669HiFz1Za++hcdos20DYjcRrc9UJjliWLgLy17fNTrdoKPWQRRCkY/j8Xg+Wapr3iXCWV+V3kWz9ErboIrUiWdbepu86GYykGcpsLsBtJ/naQ0Ne7ygNxyTbWaoXXfXkyQviFccly84T+TVZuDzsuPuotiiykZUyoRPvqvWHIajBRMnwpz2uStBiR+obHSoEm7+DCrhe4JAQvTANoTJjJ24xBUGnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=abLph1Pj4Rz9jHmEZK/KRLvvHEYOUw/xHZLiIasd6wsxVsqFeF6zI1bFLHtJaLtiiIgtUqV8ecieyYBnZWH+Wp19xtvv3cfbBWB0wfAHm6+Gp8VczWIfEuBI0BVSzTP+EbAMDnZ1FXmjdV3uwWGv33T8brOLGToCgPMyMMn8pV0/R7M7peuciOEWq6/ODioxo2svuLvHp7wlc3JOTXlNBoBkphOYHlmtxgxm1CfR+8qjiGmAIW1UZHv37FLQlLVOfWBWjPf3pQSkw3zIxlv90nBqmvY/vjZ9lgAWIS+ZDUCP+5K5OBBi3QCTgCoh0x1uGQtclYDfakf1Zo5fDTMFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=LaCrT+8Ll4FBrMxsT6vUvk4tzyp++0k9rIi99PomnCWCi+E2brX8WShVHSg1FEcFYgJyUO2NTZhD4N7K6/9enJzCGaPryyjbdvfobXug0EiIeta+8J6woj93Gw3ecfUMPdgDYrZq3iH0WJzsWEj96brf2Sqir+tulEOYL3MBB0q4WjHmckfjZsk0+BS5h486JuXEaO/0HQP9M7sMoz8tGcVOFjj+20Z60oOK0vHbOoapmPJS+Dh/8o3EyDuIyrv3PRHe+vodH7b3Axg01eMqwcK3Lw3PEA/+HzqhbFueQUXTwhB2CKXf3boAp4AcHbUuiYUMeffTDzBwfNPoFpym+g==
Received: from SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::27)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Mon, 24 Nov
 2025 22:30:06 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::6b) by SA1P222CA0113.outlook.office365.com
 (2603:10b6:806:3c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:30:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:55 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 13/14] net/mlx5: qos: Enable cross-device scheduling
Date: Tue, 25 Nov 2025 00:27:38 +0200
Message-ID: <1764023259-1305453-14-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: afc76db8-9104-404f-de47-08de2ba90409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/4HR7YbNZcWqL8gW8dPicYZ1Vas6vlW+zr+UBmGxaKZDJBRiqlLQj+NCBe5L?=
 =?us-ascii?Q?565iwWHNLKsz7/wUvO9jeWU5AwJrvf6B7w3CQsyiTny0BgbMTRpJobnkDTVJ?=
 =?us-ascii?Q?0wJ6K8TRTH2Fiblf2eFoHob0D40n/dmOBgnG/fX7M7zxqBNO9C9e2sDAUt/0?=
 =?us-ascii?Q?WTvlbhLV9v6w1LzPSClSjM4pKJe1vc27Y8YFnJkySrF+Gd4nWDJ1xUsgCKua?=
 =?us-ascii?Q?JNg6RlJcg0OQwsSG6kOjHyKgtGZBcLSTLXcEpwSGmthcpdrbADWjziog18jw?=
 =?us-ascii?Q?3Qa4w34viXflsrfy7yhbBz5lwrulQYH3erEeaZ9gWI+aaMiHQmGzCHZbdCct?=
 =?us-ascii?Q?ex9gl9zstf4uLfKlPchJoYcgeYuqqYtmyWA4o0+GiMvpDs2BstwlkefhYHCQ?=
 =?us-ascii?Q?s5pilGnd5fAj1cEQHf5DarVKigjWMjMHNQwj6sgscdP/UyHo0khkDUSbg1mV?=
 =?us-ascii?Q?8K/pKM9WTC4CTsz5D9rkQwfb+IZTXwV2dLFtUusj/2CSQ+PKvKA+yMZ8aKYJ?=
 =?us-ascii?Q?kXkGlCkqiKMtjet8EwYuUTC3y0RkfOIYF89tSPzM93psoXcAmP6tL/vkuxUW?=
 =?us-ascii?Q?KonNdLfdmdBGIpT40mVVU2/cet+eb9CnCsbxQaJ33BvpB8d4n4ZxizZMzyk+?=
 =?us-ascii?Q?IjFF3j1VqRS2eMXHSuTn1KVyXBa+SeoiwEhfBxS6Zh1vd8TCdR/AYvfzydMt?=
 =?us-ascii?Q?FKoptrE5JXAoMc2GZb2MChecNMy9+9BdgDILcn3O6T81XB/z//C0Bdqzdy51?=
 =?us-ascii?Q?h/ehVcBlopCJObEdHp0XWTI1xeLjvhWUO6JdQZyqPqUuUfjNd4L0gfpDr56L?=
 =?us-ascii?Q?2vPk7w6XFIweCpx4PAme8Vya/LVPAIg5S5E+BRZKZWPw2Vz/sg5fj+3O0JMw?=
 =?us-ascii?Q?dOHldrDNGvqdXwe6kEYKhElrouYnM4KMz5LiJdrawnnvqi/3rzJ8LaEssRPl?=
 =?us-ascii?Q?17pT20nKRxqXUaUznGXaZ6s5UOabwPt6u0ZeGkB4u/VoLHuvYS5gD3a8hJ2V?=
 =?us-ascii?Q?8thBKUzcznFVDm+n8UZnQwZSg/I84t/sYCQn1DtwS5OGjMPL+7bSm1sSSbWK?=
 =?us-ascii?Q?unvZIycndQScXlMYuK4r7RC0wiFX0avuXjhCZi4Kx1bbGzZfEkzEMSgsMFnk?=
 =?us-ascii?Q?heoiQFps1V5NALSoTRr9svtGg9HiAYJ4SkT+0G1YvN4hi6+788tJp+/4+W90?=
 =?us-ascii?Q?kC7sZSkW7MmsouR2DBYrYjfzhn7BT376RszjH2CHpoguOKahmFGloHQ0ZY1d?=
 =?us-ascii?Q?L4c3I1F5O6Dkur8UCaFGGLPRdzixtWh8n6HMGMYVmcsFKu6KYSS9CwrqjbPu?=
 =?us-ascii?Q?IYPXhPv0k286cfbjr0Iuyl7MlyY9vDP2hPu2LukGok8xedHPSxpoyLjP8pFI?=
 =?us-ascii?Q?fPdDaiYLPDAqHkAqQEqRhS0vsxj3OarLonRTXKUKuCNr7IKQqWXJU/5w1Wid?=
 =?us-ascii?Q?2IF2cK3MxuDcuqjKoHa1iu/WY/nNqCG4rYdkhfFabjhh6wQOtKCxjLW5gyNK?=
 =?us-ascii?Q?mtGSNW5huvum+f+wGTP8HUBac3QL2lSGM9KwyAGeHII1V9KdEHSL0BW1RRqZ?=
 =?us-ascii?Q?jKJ53U46RBfv+BamEBM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:30:04.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc76db8-9104-404f-de47-08de2ba90409
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030

From: Cosmin Ratiu <cratiu@nvidia.com>

Enable the new devlink feature.
All rate nodes will be stored in the shared device, when available.
The shared instance lock will additionally be acquired by all rate
manipulation code to protect against concurrent execution across
different functions of the same physical device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 887adf4807d1..343fb3c52fce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -380,6 +380,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
-- 
2.31.1


