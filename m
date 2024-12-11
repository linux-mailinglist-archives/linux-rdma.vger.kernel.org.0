Return-Path: <linux-rdma+bounces-6448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C739ECD96
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3B81885B6C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5D237FCF;
	Wed, 11 Dec 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EKG52fG8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357F232373;
	Wed, 11 Dec 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924680; cv=fail; b=fKWKFkoR6Vv91/t31LtTmnT+po7JNoygG69tMyYcfgDkEVYF1eiLDCKcO3Ks9O0ElpxAo+J3lSvoWZJzqqN8ZcF6B6M2J0Drb4eZOIK/KtE44LyO3rVl0fnAj24HiVqF9PwT87GJbh30LXNo8g8mYvo2jTCMuFo9zwPP/+UzP9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924680; c=relaxed/simple;
	bh=aWKf5/Q6RnlbgvQFNKB5VuTrt2h+npwPoKmkNPJF+dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QACtAAbpRyDodnCD8a2+TsNFw+n+O9j2+D5C1x2FA3y1ne+y92SPgqAE3xv1atP1G/Z23hP/oOHaX944uqKYXRUjdCX32mEO8TI8i6ryrnjnsiL+p0pTtu/rIq68qU5XSDvHZfEp7EnHKmREtq0ZTTWIaLtxetYDmViCZ0y8Y+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EKG52fG8; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRNvjMbPYcTz7BEYxMpItB9dsOCINSpf3TeJzEUh/kKd9S42YhqII1ERwoxLvmVVUSwCutrj9c+5m0LdEs0DBkDmNLUHxOzYGpi5JQm4sNe5NzDfD9orQxnQcxEVQ+Pgt79JYQAwNTCYaejCPg6wEJJquVhEvSgW96otmFQefaTBoIunctixheJczKwS5cwsUoW/R942ZltQdnrSDqeILgcKa9d4GneZoF+jVK51XE0zbmymxDoAQAMfGG8oq17xdnGKjMQAa7dVh+TACpZhN+fVHUnS+7jdOEjlBlkX811T9KqQKWgyZi0gvhyPv1yM9uYJsYUpDjtKunTdgmU2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpo7erPFocH51Ue6EtyETfLULcHuF9tgK7tlzC9NL3s=;
 b=ANR4lpWeLxg+kzihHJR0wHK1MnXMIrwgscHMJRZ9s2mdS9YD7F8YgIZK4gP2sQJ744jGZCGFey0wP0UmS1S76J5vQUyCItqvflu+ZMR1KHnmG5FuF7m7LdE1Fz7lB1faIYppVTe5KExgC9lCKGNqtA9Dg9twPc0R1AtjdvBDUTnjOKK/oUvy47rINummd5S9wAIUDWeVqPxXtJY7y9udrC77/SToc8v4vRuZodBjEnvCcKr0TJAL8+/ar8FsxeQ0ThEwYTYigSB5lrFjS5g/lBwOuFuKRyrijOqN2K8wQ8Ywj0AW3CiHGcNKWD6k/hoNZYSR0QEWymx/7KWoRyGZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpo7erPFocH51Ue6EtyETfLULcHuF9tgK7tlzC9NL3s=;
 b=EKG52fG8htMzSlECykJy6yn0zL6El9TjPpNJa0L7B8SKz4lyuhvolIxq1NxhwIIUj0JlTZHz8119S9E3wD/HvJU1qPESigL5A7dOvXAhwN6UEvQBWQGG9tT+DXpaY5nK0v/tyCT8PLgSGmjaXrlz2Ww1vn1lZz1rvsLes0hKELmb9Q3p2o+SyNM0629PUn2HYzCrOQ0adOoTHqFjYt0sv9FNYWn8TVmR+YmzJ6IwR88Y0CED8kGbF/ahjXFcHCsWHngdeor3w+ug57S1gGEbheNUIHXDgRHEpCxpApKAeaFdTY9CAXz0+XPdlIzwJuavhGG7MgmWfx7iux1DF9Su5w==
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 13:44:34 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::d2) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Wed,
 11 Dec 2024 13:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:44:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:18 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:44:15 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 11/12] net/mlx5: Remove PTM support log message
Date: Wed, 11 Dec 2024 15:42:22 +0200
Message-ID: <20241211134223.389616-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241211134223.389616-1-tariqt@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf8cc62-ea52-4c0c-4456-08dd19e9f19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?It92eBuYyVQee4lOnebY94jwz1XW1Sxj+zZWWd7COKRh4bFnkoLV+VImoNDS?=
 =?us-ascii?Q?ukRugyGLzozebmfw/5O72fYqYoHG7GxyTXI+vOS6Qf8yaKX3flFhbL7mEgtN?=
 =?us-ascii?Q?rSQAyhzvVPFcWYbI5GbDSMpE/69wfnTJYnvITnqRCxEpa6g1M3G5A6oeVA/l?=
 =?us-ascii?Q?ZkRSmTUuooyLNUHXoDdCffTcnyM4MldkvQ83ydSn6yp7mDCToZN/ESeWhux3?=
 =?us-ascii?Q?ihn7aHa62Aca1UXcLUaZlR5zQ2e3T04zKqfk/D9pRFH+J2YPcwJLmSzsCSCa?=
 =?us-ascii?Q?+Gqbq5IheyFXVWxEm2KFiknOFnCSK4Fso1XhsSNwA/geLCRPMRJkNyYM+gDV?=
 =?us-ascii?Q?fXW1pEGOWGV5nEwe+kgkMFEHZ0bru2SEWY1/9Q7z07AO8RFJmVOvaaq4Mmuu?=
 =?us-ascii?Q?AJqC6XGjEFX9aRRNWV7GnZI8Hnv4lyzHOS6YW3R2FXNJNa0ABJA7xRutLlLJ?=
 =?us-ascii?Q?4Q2pTr83lxGe/gNsWBvL31JtvIWp2ZmiPwUW+UOF2CexD4LSYaZx6fHXw/RS?=
 =?us-ascii?Q?9dkkOpZ9PRGIKcKHZDl/QkKjUFwiZLksQQcb5Y9WnSfkJ3gFJD94vsuiAwRS?=
 =?us-ascii?Q?r3kylusVAmO0++mklq67fwFYxs51ravlhrqLUk3P6SVeoIChhasWN1FciKN2?=
 =?us-ascii?Q?Zhn6RirCdJmhInBlasWB3usbhjWfTX5ex2PBPLK/iJ0eFqd6/cPqbosAnu/b?=
 =?us-ascii?Q?IGfQX47TDo6DOEImRIlFi2CSjgltvaT7wAZR/7sLUF9TUogChSY3VtyxO505?=
 =?us-ascii?Q?zyPWRrx+sMuzBejPP5sGpvnoNB0lLGK6r7a4zJahgJe132/J0vJQL4KjTgR/?=
 =?us-ascii?Q?GeWCv3eWiuYyk7GPutA39aWFicYKv4/wUWvasx6W8GLb0t3eFCZPzFovHmqw?=
 =?us-ascii?Q?7kX/Zdi+fTYCAY6wHovjr6UyRDQKnhYqmoeSNykMfysjOYgg2pknWBf9klEW?=
 =?us-ascii?Q?yuXMQPmG94GWQEBwX0xndqMP7OdhM7QtBCtUlLZuCLpKMV0Hg419bCXQLCWk?=
 =?us-ascii?Q?3QezXqyITVbytZiihiwSg+23XajRuYFECgNMoIvscDaDQFnM20UGgPm0wdwt?=
 =?us-ascii?Q?Z4zqbzMzGn+FvZWXpUuEzClzRtT4Vx/GwRLMfgOtJjpeH5VU7RPwHF/zHCyB?=
 =?us-ascii?Q?gqA1v6ttW50tyRdBX56976Tp+oHNEbrfV5V7t+ZuudfpVz+nOMGcP7qiFGJc?=
 =?us-ascii?Q?XgozVKkEdYYCcPgoP6d87kI2zRaNLWxQgbNo1kuA6YFohK8vpkJ4bsuWGK9y?=
 =?us-ascii?Q?J3LHfXiJFAtdU2wyF/n8od2CWhxwGzMPHJ0JdgDhWjqK3/ex4+R4N913ikdq?=
 =?us-ascii?Q?ILBEjUHs2qD1onPbFU7eGRffUc+abWjd6uOHcak8QlqUkhrOa1YdI6GEKfXD?=
 =?us-ascii?Q?LphGrCkUcmR0ycWpEOstPKAc+uSTLF9Vc200Jip9lah/OIxo2N73NKPi4PdM?=
 =?us-ascii?Q?cIYroBSCIubCqlAXyo32NmSi5xiAU1xQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:44:32.7231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf8cc62-ea52-4c0c-4456-08dd19e9f19d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581

From: Carolina Jubran <cjubran@nvidia.com>

The absence of Precision Time Measurement support should not emit a
message, as it can be misleading in contexts where PTM is not required.

Remove the log message indicating the lack of PCIe PTM support.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 869bfecdd8ff..a108d8c726f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -945,9 +945,7 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 
 	mlx5_pci_vsc_init(dev);
 
-	err = pci_enable_ptm(pdev, NULL);
-	if (err)
-		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
+	pci_enable_ptm(pdev, NULL);
 
 	return 0;
 
-- 
2.44.0


