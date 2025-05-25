Return-Path: <linux-rdma+bounces-10689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8ECAC343C
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC901757A9
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF951EDA04;
	Sun, 25 May 2025 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UmXlnpZo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4F1F3B87;
	Sun, 25 May 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748173708; cv=fail; b=FD4xSUjo8fdBzz3/dH2jk1xHwQNceQodw9bSqqJ4wV/v9EmThgJKDfo2AF+PcpVVD7zT+b7tgHVhWmkBjZc96ZbuZyIhmIfD00Zwzzg6cbHUpM501veY1MTZ/q+srg+OIt9v6PkhJvM4E/Ad1RyoYhsEOFug1EJ9hXMYB3UNxtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748173708; c=relaxed/simple;
	bh=ZXvORc40euWtYzoM9RV7uqqsUSV8PPlrNfUh/vBWv/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVmQJaIJol5hkvSCbJ7pZkP3dGarnAEk7IfQASGkpYj+GeOInJqk+d0qNX3RDqbIF/N6VdfiRWKu344sIPWRtbLZnvIzzpkXYpo/2V1nFUJQ4gH06avxNkBn/27hedYBy1wv9uIxZjB1IASoh7jC2P9pXRP44mk35TeQJcN+Wq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UmXlnpZo; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGdSEDn5cpaKlzLThVv3OzSKYKuwA+BHKyES0qi53pLExNBPaTH751bV+a9kInrBrj+HEADuXtS6a5N+C3XaKH08Jp4M/j4bmmMoxjMzetjUnWi3GbXPUQ6+k4oPb4Zwtdqx9sEWdLvhT/RXl79o7Ov7HpkW2KroaliMcZ8w/AGedy1p4o4YR293s8KZp6pNMCi1Qb3ra0QkHZxjJWjnUXSXhhtV0yeEmTghGTQ5MyPw5FFZIpT4zFUvVGHEjfMZdzcEWpgsDZLao3OLzmuxNlJQ5Z5iXxryTq2q7sF9PEw4db+dOYz3CsfY5QyQc4HMjV/C1vnRkUe9y9rb5/88pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6CuLR25B3OMon9JGm6TJlO4e5OoklkNXXy1q9LE3yg=;
 b=mElgTPe1cDHBu2VxV7Q4oNIEHuuqqWgWr8On4hRGD6vySDDBMw5SskD3nZl2nFXfT9LiFacv43LKSJZ0QguWB0q3MIV+qyhF3+p2XALT+Ju3TH3HCPeV+AFV0AARUPWB5ej8fBBVZLLi834tjnE86OiZ2VjrY9qxHwhrMojqpmXXugw7BjoCp1jT1F78ysLiUhOGzOZv7/lsi3W+YIQjZ8CsUNl4cbSBZ7oSq+9P/bLnTRG6zvpJXnVlYTbAOv5m2yaWb/UR1TOA889swUrIPFHspAgW/Z+MHetZ6CGEhP4BbvmHMqbBXE+tokYyfYs4FCQXRo+RrWIMPizrR6tphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6CuLR25B3OMon9JGm6TJlO4e5OoklkNXXy1q9LE3yg=;
 b=UmXlnpZobIwL2rtI1Uv03cBp7/Lil7KeVZBk9DoP/TtXpl2s4th1sOWtbwvoAb2hAcESQrUwprYxzdDl1NurqvQonu04y10I7JA4TDr6I4E5vs9XHisygWZmRyOIr2EJmhePuxLDKbSx6D102gbnpDReV+yNIF3BoR/JHIV7yPCQ/os29sPOQeU23vsBzzB7zyAjLw17fzZyyu9vjBR4qMzCvt/rCekIlLymZtX5HqfJjCKKZGweEeO97HZa/jZEcrHf9+3hwdJZnfWokfQctTjTGdd0smkxzFHiJqO9GQmBZ6okn0Jp7WNbPcUDaUfMEokpxlkMYC8P1T4C06sl9g==
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sun, 25 May
 2025 11:48:21 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::43) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Sun,
 25 May 2025 11:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:48:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:48:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:48:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:48:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH net-next 1/2] net/mlx5: Warn when write combining is not supported
Date: Sun, 25 May 2025 14:47:31 +0300
Message-ID: <1748173652-1377161-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
References: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 366fabd1-1bd0-47f7-a0cd-08dd9b820c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e8ek54U0r4zpIQyvBckwPmqsOubD7wBK+bx/GYjAVwhutyMn9haZ46YZ3oQj?=
 =?us-ascii?Q?MUKbqDfV7BRBORkgJTD11/rnoTEIDY0ily5gcE2Mw238bKYshSyM13i4X12y?=
 =?us-ascii?Q?AtJJPuXK2GW7IdhvFjbPqKzLm8ZaJ9abvicLSVjs6Tfzb5L9wku/W6QU3dHc?=
 =?us-ascii?Q?2tEqp6js+eIUBBjLo1vB512qG8jWRtqn2MW+5J8F4R/jZWhofI+tSA3SEH1O?=
 =?us-ascii?Q?fx2LzSV+D2x3z7cW5uBoMiU1NEGTSIciyQqKayktC0oWKMFKFPfCKZoWDsfq?=
 =?us-ascii?Q?9hQKsT1W0xymF8TMtzU8hwH5jUzFtLFLKa//SiW8vn5n9444ou1SiowKVB+4?=
 =?us-ascii?Q?UXEMJXrgHcMsLjAyatP1mko8WJ3xOpf2TJWxdd2BOg4mBLhuZwkvOnJ/wm/p?=
 =?us-ascii?Q?uOdkfysCkLxVJ4t4CBNBcTru5tK+s0UiVs1lIYZqI4yZMKVzJzsf+JeAqJme?=
 =?us-ascii?Q?Wzx2EbNgWTKcFC1ghY8WGPkAYh5Fi3/PwGZqtbZPamSQQGQIAuPYmAwLo8Jg?=
 =?us-ascii?Q?OvwPaUJ9n4CphgWnFBwFAfBLHJmeHO+dypUi8hl01Ot+0uMUkTiToZWpsgDF?=
 =?us-ascii?Q?X4JcrOPz/pjDglPwSTsOXZx4JOMQT3dRLcBRU0zInzRabI2tniGfRFrOii9K?=
 =?us-ascii?Q?/skF12Wc/ERFcSgIBnXL/qMUzpv6SmoBWAcPoxFwpgKDudXPoN03pghYEJQp?=
 =?us-ascii?Q?3WXG1zg9991uylEATzGWBqSAeSY33kt+4opX1sGzxK1fTNiSadM72Pxsr6Fv?=
 =?us-ascii?Q?t3tcD6qU6xUTQwMrmtd6Y/caamOQxYAz5Aew3gQT3jxdIPpFgjwJ76TT5+we?=
 =?us-ascii?Q?UObns+qUY9WcaCU517QJzbzUQ9NaK/wa0eCbFy+MAlhR3mMoHbC+f5NgkRe9?=
 =?us-ascii?Q?fQIcq4k1hExeWoGjynfGMzkhurtNEnsREC2OWbkR2RrSaf0KkyT70w5z0UFS?=
 =?us-ascii?Q?3pgpSX8XrEoNOcXFt3n0kwHRHgpOj9u4nFEwNQhOyRvgptf75IYb0ynuUwx/?=
 =?us-ascii?Q?o6LaWBRKuYE5jkqw91k+GtGIl2rXcfDmHSf3jgsuSWTGR4LZy4fTs7UyVdG/?=
 =?us-ascii?Q?d4z/vHJojH3Go+hbDM1YNCsdXetTv5nyQbCpF1piuyEBW1HfCqcC6cWKpTbh?=
 =?us-ascii?Q?fyjmHMl/J7E6E33z0WOi0r9bMQv9j3XJ0SoWZ8UIpT7hNLdzFzIzOB757Z0G?=
 =?us-ascii?Q?LPyY39+udcvo2lliglmp/XDjW3MXuwxWT/FjuT/7FdSX5jBlsc/s14V6ipCZ?=
 =?us-ascii?Q?nLMFcBeEomvJov+N4Qas9bHEWGRDQlTgNUeeeiKfQEXv8VI7k7z3Q7dCjCNB?=
 =?us-ascii?Q?/ZLu/DrANU2NBwTCjqIS+mcYqeCUuDrUQTbU9I/TPQHSLcs+AtKp2cZCh0Hf?=
 =?us-ascii?Q?am9mml/MHpleWkeYGR/tvsoEx3PE5R92KyLIFL0uRg3WP1IHrymjxrxV7PEO?=
 =?us-ascii?Q?6srgZtN4bk50UgOuYH10g6YFlH5V/PDk06X1eOKNJKDqDHo7tkbdLrox98kJ?=
 =?us-ascii?Q?i5j7lbm2g6ME9pECVu9xEUBVcbZb5tgvHRhO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:48:20.7434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366fabd1-1bd0-47f7-a0cd-08dd9b820c33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603

From: Maor Gottlieb <maorg@nvidia.com>

Warn if write combining is not supported, as it can impact latency.
Add the warning message to be printed only when the driver actually
run the test and detect unsupported state, rather than when
inheriting parent's result for SFs.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 740b719e7072..2f0316616fa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -378,6 +378,9 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 	mlx5_free_bfreg(mdev, &sq->bfreg);
 err_alloc_bfreg:
 	kfree(sq);
+
+	if (mdev->wc_state == MLX5_WC_STATE_UNSUPPORTED)
+		mlx5_core_warn(mdev, "Write combining is not supported\n");
 }
 
 bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
-- 
2.31.1


