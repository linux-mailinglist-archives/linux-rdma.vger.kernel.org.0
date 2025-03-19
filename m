Return-Path: <linux-rdma+bounces-8830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805AFA68E7D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526CA3B5FCB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFCC1BD9CE;
	Wed, 19 Mar 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uKG35/6k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68B1A3BD7;
	Wed, 19 Mar 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393077; cv=fail; b=dG0mwmPyts7OzFghFan5kpydmNN5t9615y+UIuA5i6VRGku3E9JuUXtRwe9e3DxR5pZs7Ps5T0S1xVRpJquyz/VUbSfvX/KY3Hn3f73yhOtQZ59BtZpVlHg9p4+MseqiPvMqTdPHVpiuuWc4l6xNNPOQ9TrWTClMNsmNC2Vl4c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393077; c=relaxed/simple;
	bh=o9fXNHfvLBcps8WN449XVdVds8ip7n0P9L8E1ADs0A8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNEzjWXdqky3vja8YnitsESS1O8nsiJRjFviPpmtinIzuWMqYRp/IGvDxhlLCdtlHIuYd03PrJds5gxxsNAbC3kjAfE+Zn5nhBdITnwrErk5Jrcvv2pJsit0oUDICyDRTyIArWFo1NScMuW1KNB2SQHTBB7Zd1tdzR+FHfOYriQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uKG35/6k; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBmBzIUIS+1iXDTXe82G5jg7pi6FxF6BvuO+WrtnOGCaxrqCxyi/L52VJeyI9vKOVmqHi9x/b4dik2wXFDPkIzZ4e0Pmt7SjO2a+YHJcBDw9cNMN+FaBtRMZ5kUUeW99GtRlNT2N7x3u7VhvmeTTW21QgbYgl8YVP1gNNa/uM6k0sgpguOFoY3k3RYyULZU5R8z/6z3sdvxtPhuMhc0aa3+15hW1RNFSd2a9EC5iR30M1qYNEVNUDHNlKDS5D8WmZH8n5VgEq+xmgTGaw4OZUaw5wD4t7+8z8imvXEHT67CCBnj4hB3CHwpA4XnALGqJ7AGGm8QrL2vdj8iuQTZKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glkx5+j1v7qW6MksTGM72hVaaZHQNumHfW+B91DP43E=;
 b=O7tD1Hz8QiMxBcqVsen9dSxH1zuN7mTeYnRRWAkzBSOWpwlPVEJ4Xr/s9oxudC8qZ+GsTeY7+N1+nSO/jp8taw6kyJCnoF4O6mtgrT9G/Sd2GsZNy/YMdLooyfD98d8esa/Sw0ys0UTa2JAegfsScranwWfW0+CVVBNSlPe335hoYvdH+vSfqI/AhBdBfPSOBxsND9rGA1nbnRflwY+77/UrBS+NJPyPJ66AebaENmtn3ivSHlGJG0e+FZaKMxTF8ZKcYcq4wb/ZQ/zM/0mQlXuRM/zJgICx2AwZIMMSQAMr7u6Pvrdaqbo0U70i0zlESuviNR5K5djLa9CnPUdrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glkx5+j1v7qW6MksTGM72hVaaZHQNumHfW+B91DP43E=;
 b=uKG35/6kz79v4zKjxhCpIaJTGlwFbOmlBHiJQrzdObs4SaTbbYkTY8DGXDEuYUs5vakk4PzTKwBmdhfKL9tIID20tgb1k4b8VfASbBnH+1i4qFVYsPsPhmGqkeAMhAuJMvpiuMPhmZGni10tdZSg8IRsuDVJ1QXlhSGYNuRbwlfv122VDgP3HRUoVDblTWB4ofK+4tJbLNEy9Vr3HXnwhCEZ7bkVF3TvhdERfvDfNHztsM1eY7eWRC5FhZnsrYs/A1g/zaGOQBhDp/n/tnMDBadBmdifJKeAWFGqmaoL5ep22mGp/bkXAAi/iOv4eEp3q3dVez9sNMYPpnQ8oTt4aw==
Received: from MW4PR03CA0088.namprd03.prod.outlook.com (2603:10b6:303:b6::33)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:04:32 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::3d) by MW4PR03CA0088.outlook.office365.com
 (2603:10b6:303:b6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 14:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 14:04:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 07:04:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 07:04:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 07:04:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Amir Tzin
	<amirtz@nvidia.com>, Aya Levin <ayal@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5: fw reset, check bridge accessibility at earlier stage
Date: Wed, 19 Mar 2025 16:03:00 +0200
Message-ID: <1742392983-153050-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
References: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0201ca6b-7cde-42ab-e3c7-08dd66eef91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5FXnxGSEulYY4+X93W3Mo+Jh407n+o8REoAU/wWuidQcRl4keX08cvyJ3r8i?=
 =?us-ascii?Q?wJCVI0bMdnFF++D48AnYaaImyg+S5Gx0iMV7bkVxcelf34Im1S1K5vHJ7iQ3?=
 =?us-ascii?Q?/iV64YHuQwzUxfvUkAjXw+Md6K5MrPjmWFbuuv1WBkSiDPlO1Anp1tdul7Qo?=
 =?us-ascii?Q?lst2n0lyWPNnb35p4cG0z1kIXAlQQxqxfcIn+HMHQ0vX4EhRYPD+0ZjoE5eu?=
 =?us-ascii?Q?KgdI+bkxGJ+zG52VE91UyvQLKCwOOj3fTFWdk4rmsSoKe0HWEOomyITDFQBo?=
 =?us-ascii?Q?6XtEdL5+bVaWHLnBmv8X78ol8tOsDfqUwM+C+zussuNzK0BXnfy4+eDUo923?=
 =?us-ascii?Q?PH4e8EDNTNfQEDdVhLAUDnfCxOhwVWAE6pqOM++xpQkt3OStJAngUOExOMQ7?=
 =?us-ascii?Q?DTj1mg0OZMRWc7GhFxq8DoRxUq7DDyGAD/+eX4r/zz5srhopDLkNn97L1MxK?=
 =?us-ascii?Q?7VLZhn5V6OpttXgbJa5WOZ/0TT9FL5bxmm6aTSdE9ZjXjZuoLbKkF5fozpiQ?=
 =?us-ascii?Q?J0ylBvwMd+czKLk/SHnYaZpOh8R6l/jMG9Oi3jbIiHJn3xiqPZJ+2Ox7XDLA?=
 =?us-ascii?Q?A8OAT78jf2eDmM5KX9AwpTMTEWfhmrtfDAOmG+/V8k4OfhpSOQ5JP8LT6gGF?=
 =?us-ascii?Q?/DmLaCEvfqXCDRwqei1wHsoRHgWWWra6raJXWZBfEftr0o476D36dNxN215i?=
 =?us-ascii?Q?rexj3Bi/cCNppXIW63GFE1q3wt9jQo4fZ6IymVXo2EiPUsWJWjrZK3i91G+k?=
 =?us-ascii?Q?SMIk429QcoKVGLwPClzpVtQUGHe7L+P8XkD14YG+2hVZMJ0eT1uziO+hl/6L?=
 =?us-ascii?Q?Mc+VP+fgOzEXmd6WhEMHOI/LUs18Lc+ICBS94RBGdNq8JlCb2gDqQVmkKbSl?=
 =?us-ascii?Q?39Y5MwYE80Jec4k79HdL+EVUtqZr7F3w5MtzAEof/1q+UbITekK4qJhlPc9x?=
 =?us-ascii?Q?KeStgN8zCG7Jtnub72K71xKnDMBR5i3pW/+dTs+zTzYzB352xNvAFchZhmrI?=
 =?us-ascii?Q?jHfWoWJ6WzPttULCbMylHI2XKKvbinLA0vApii4uDwRl5p6ZMqiZlLEy/wW3?=
 =?us-ascii?Q?y3yOr1mbdReuT0NKRsCjh7mm2A0b31j0YpsgpzA+iWI4vmPKLpNeIhcHn/Zm?=
 =?us-ascii?Q?8IlhJRlFd5AmfdQoln6ECDW49zAzTmHDGY330HcSFuK1tWuCeBjrY6qhhYaO?=
 =?us-ascii?Q?0eBgJY4BbIzuTs+jFfpHBOeVCxYPB+kG2f1s5z05e4afI3wwV3o0521z0+OQ?=
 =?us-ascii?Q?3GbkQQv16tPjFk3pL0kw3hF58ua94is1Mh7ZLKwIeJMUKImqFSMnvLFTneo5?=
 =?us-ascii?Q?z+7NwWX1KN7fh2/38mSX492z46JoYv7ZzvoX6bqitcEAeK7nV9/+43cF2cxo?=
 =?us-ascii?Q?ImYygnVf2K4PlKko8dOweW6rawRswWajPh6Wbv3oe5tecXrvfKCpDf8kYhWe?=
 =?us-ascii?Q?161AEvQDFGlMYYVs1QJNYFZHu71hTSSxv1LS68L3vG9GxaUWkPiit6Vjd6Al?=
 =?us-ascii?Q?KSqY77Ky4hBtFPU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:04:32.3407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0201ca6b-7cde-42ab-e3c7-08dd66eef91f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

From: Amir Tzin <amirtz@nvidia.com>

Currently, mlx5_is_reset_now_capable() checks whether the pci bridge is
accessible only on bridge hot plug capability check.  If the pci bridge
is not accessible, reset now will fail regardless of bridge hotplug
capability. Move this check to function mlx5_is_reset_now_capable()
which, in such case, aborts the reset and does so in the request phase
instead of the reset now phase.

Signed-off-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fw_reset.c    | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 566710d34a7b..6830a49fe682 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -345,15 +345,12 @@ static void mlx5_fw_live_patch_event(struct work_struct *work)
 }
 
 #if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
-static int mlx5_check_hotplug_interrupt(struct mlx5_core_dev *dev)
+static int mlx5_check_hotplug_interrupt(struct mlx5_core_dev *dev,
+					struct pci_dev *bridge)
 {
-	struct pci_dev *bridge = dev->pdev->bus->self;
 	u16 reg16;
 	int err;
 
-	if (!bridge)
-		return -EOPNOTSUPP;
-
 	err = pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &reg16);
 	if (err)
 		return err;
@@ -416,9 +413,15 @@ static int mlx5_check_dev_ids(struct mlx5_core_dev *dev, u16 dev_id)
 static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev,
 				      u8 reset_method)
 {
+	struct pci_dev *bridge = dev->pdev->bus->self;
 	u16 dev_id;
 	int err;
 
+	if (!bridge) {
+		mlx5_core_warn(dev, "PCI bus bridge is not accessible\n");
+		return false;
+	}
+
 	if (!MLX5_CAP_GEN(dev, fast_teardown)) {
 		mlx5_core_warn(dev, "fast teardown is not supported by firmware\n");
 		return false;
@@ -426,7 +429,7 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev,
 
 #if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
 	if (reset_method != MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET) {
-		err = mlx5_check_hotplug_interrupt(dev);
+		err = mlx5_check_hotplug_interrupt(dev, bridge);
 		if (err)
 			return false;
 	}
-- 
2.31.1


