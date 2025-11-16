Return-Path: <linux-rdma+bounces-14508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40796C61C7A
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 21:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0CB44E6EC4
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61726E6F9;
	Sun, 16 Nov 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t1EYRwJE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3F267B94;
	Sun, 16 Nov 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326028; cv=fail; b=rjIRBH6I/pFEKeQ4ry67Qgd8am/x++CElvRjDUPmY+cmc1uAkXh4GUQfoqSUZAu62zaGZizErld5LIADitK4H6JBJjc1Reo3IsOL949ma+Lb/ZVUDyOapGV0HUwwR2sa5QEeJit8Hf8qCklQdoy9O3MuvxDzW+zoBmp+qBoOXMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326028; c=relaxed/simple;
	bh=l9m0dWYlKce8CSbxZr+/ZWhm0H0O55l1LQcK4y33xj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwe/DbrrbQdEqOorJDXH+zTKyj4ZJv+m5s+oD0Ba1OtNEUkBdvYYLqz0B0rT/uqoMEHfunB59HBJPOX3Ov+NIql0eSi4T7R1CTOVg+Fp2tQTm3GI75ZQmQ6vnWvQw5gBNGK25TrlkCM6KwkX+V4yQ+aUxLAANDnopiU3fFCHaqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t1EYRwJE; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC+Bcb0G+Oengc/r+TevJFumsHWT4F7K/NGAuhD12JJXhQZOKf3HwI+rn+qE/yCLzrk7LBL5QybOP4f+jHOm8uwryRyiwhiZpaC+J4uIQ5XHmgwyYcX7kMh3JG+XHi30ymBxhz2v0KOKaDZXQcPSTcC9x/dsnKkqTuycb41MJZKZ4sm7VYDRQPf9xWlUteEkXIf0bu+SwX8wTgnsc9pJCW/KrSc+aNnQt6EZ7nF+kT0o/orYgv/3dSsIHKrL+c7vfGgosOgCOenK9m3eNxAODuhpW02IueLOa5malJ90n5J1XLcs5eT6Fo7382Q9cAgY4zudwdVlQFVqs2ElG3wrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlTcwsTuGPGz9q9skuxzW+3HFe84PWiFXoAQD8Cb7co=;
 b=fHXuZ/k9zxK3mH4FZzeC4gbkLwQo2MJtXMBXYbcJgSVHbj9UwkWBRh1gZnBuir93zZMlbDo29Gf0i1MW9d/x2eqkE7LF+Jhkb3RMCDbSKrnf3KzC9VOOe5YvJL+5vj3hh0JDf574SLfV7tQ9Ko97k8T+GhrMjGsW7feEYCodG5jSfC2HWIYtvCvEBTNEmRCOZr0oX/1uUh0LTwRe8bF/yIWGY0jp/CGRAOFthtwkbLDzm1ewof22lQLPtuXlDH6JmlQ1tAbylzjtuPUKzN5pEcKjd5N7371hsi+AwfsQQS+L/6lespZF2myF15OFJn7J/4AYnsKdzZ/qcTmCqs0j1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlTcwsTuGPGz9q9skuxzW+3HFe84PWiFXoAQD8Cb7co=;
 b=t1EYRwJEUKVZAR1CjVwiB8Mg89KNsqqR4VVuFGhNlrCvzdKeRY8nMDOnusLiGv5Kjg29wLECNTf6lnutT0N0BUS1h2ycYAbjcW1+BWq7FYZgnsMjMo7l9USeBqWLgztOzMq0xHfW4yPcWCqVySU4f7BXofvxyqxQad3kdZfhrI1JR3rJD6TIGHi7jis4RII45UjMipgAk5sDSNsAujHhEC6vU0UPn0ew5tmuYPUSaqO+X50D3CzjsFPrkjY/rFu2mLKgePwy0BecojJv8629y0OrfvRIIbH0ICDbUDr0NW5WGipU2lfbvhIp9+UXL5k0So4WYAInCPj04/i3Devd0g==
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Sun, 16 Nov
 2025 20:47:03 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::6d) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 20:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 20:47:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 12:47:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 12:47:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 12:46:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 1/6] net/mlx5: Initialize events outside devlink lock
Date: Sun, 16 Nov 2025 22:45:35 +0200
Message-ID: <1763325940-1231508-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
References: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6834bb8a-c8e9-4a06-661c-08de25514bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XGduDF/9yeACxT1Z8JY0wwW4KBEIu814VhhxwEZAK0TSRMWVSpB0F7/CiVQ/?=
 =?us-ascii?Q?XrZbX4c4bqdOjrG6xFF5k0kMEKjme5ZxtaNt6B4n5SdT9yLmYQGTMse8YK95?=
 =?us-ascii?Q?NAhmWT3qliHHzChGCtwFN3/uzBREXbrhj8INl/23qn/xypz1Z5DxmlV6EFjU?=
 =?us-ascii?Q?wMb8+60gTLs957J+2fudVZak2Nbh12HVTq7tJsyI6g2DGxY30MxGtbvM4Klb?=
 =?us-ascii?Q?TYHeF8I1eFq8i4r3ESl0xRb5H/Rqjv3ujNRQmqZ+WyXmCZ5+bLlCGfo8ABot?=
 =?us-ascii?Q?+9kOSwUFND/Ct4CSXcvxBX7Os/RCoPg7UvSUYacytYN3JWeM/BI032zWP6Wl?=
 =?us-ascii?Q?y6ptNoNDzfA0Mgq+6xmhPNVgSkVieKpOItOOGVDmPabxItbqWGtwtxR4g2dm?=
 =?us-ascii?Q?AJ6obLoClq9JLtzbic0yzcFAO0INgsdgEhSREoDetPXh0M5V/Jr9IBY7SWRZ?=
 =?us-ascii?Q?HloFkTXYBqTrXZg1KR+TpMAJ4wDw0Ubq39KIMqMutc+CRwcZgdHf3uQw4KQm?=
 =?us-ascii?Q?AFUadAo18tYyXpt9YvyDkTdnINl6JM4IZLU58LiX9sByLGYgoSfl+H5J87MA?=
 =?us-ascii?Q?K6VrQEoZVTAtL+x5BRCDX9i7h4r7y9l6HiTnh6T3d1esvI2LYQKBpM3CYzqd?=
 =?us-ascii?Q?o3VSoH0RYZcS/u15hxAKBXRyEdU5kt/4oCTm7OGa8XH/Wh42KbcpM/C+8kun?=
 =?us-ascii?Q?+pLUITsa4FEzdyGktMR4AJUB7zd+GNW7mLmneQ57hwWmsRXf4eVcvViKfao+?=
 =?us-ascii?Q?+VSFUYxvBI/42G2GO7pRZc4C9l2HK8hxMgL4KZftglYG0xvEYtY0NIzkSkOZ?=
 =?us-ascii?Q?RM1Z4JnYYuYm3bacYEZkhz21cODUdiSMDxVNFY8Nr5zpC9U2cvTB6FbPtV6f?=
 =?us-ascii?Q?Jgw9bM5JHp9ULBQ/viOCQi6wiwdcF68Ybnc/ZwjuaysYyZqYSpR5Mj4p5JN2?=
 =?us-ascii?Q?4OVN2IdLWNEOsOzelW2tkF5tVvseqvH6hA9ciYOc2YXWKJKdCP33sj3HCd2M?=
 =?us-ascii?Q?L63Lwc6HxLBkWF1FV8IQEKlMRA58OBX/GeGTaOw1JVAqVi1xdxMAukYg+jko?=
 =?us-ascii?Q?ZZ/Y1jQfqavhlotZqCRtdsI04qfRZonSGi9IcKPRngSG+X7Ewe3kOeKc3EJq?=
 =?us-ascii?Q?DHv/JXplx7fn8BdKmgod0p8NTeOJan0Cb5QMe05GYZsUW3CbPzhPs8lpaYgk?=
 =?us-ascii?Q?RUXC6aPUMyO4kjPZgJRSOjaMmhq4tk2S2qgfFq+7N0UO0xpoQaBrdagidagw?=
 =?us-ascii?Q?wQIks3nJp0IcvgAAOH0lZVta6fc/QbXbftcKkJI/7ZJa6g2u12YYn+kOlqJ0?=
 =?us-ascii?Q?FYgWbA4CjF45fdTXepqxs5Sf+lzN/tDvft02HzYiwxd3HtiVOoZUwaMIjK1T?=
 =?us-ascii?Q?mlJk8bKltbo28nzK8lnQ+twSvxGgF3gDM49etWL88gAe34+sUuI5CevQzC9J?=
 =?us-ascii?Q?6aMxz7j0QKqi+dQS4FERLjeUZk7PRdU4BlwkH++UUSgrHoYszarOFkGqUY0k?=
 =?us-ascii?Q?kOoZk7/YjyRgcLCxthikyPBe+lcQqIU/zGb4jwkhkeVw51YTa6ypN5/rNv5l?=
 =?us-ascii?Q?HxZmEUFL//CuAi+CR2A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 20:47:02.4821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6834bb8a-c8e9-4a06-661c-08de25514bb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

From: Cosmin Ratiu <cratiu@nvidia.com>

Move event init/cleanup outside of mlx5_init_one() / mlx5_uninit_one()
and into the mlx5_mdev_init() / mlx5_mdev_uninit() functions.

By doing this, we avoid the events being reinitialized on devlink reload
and, more importantly, the events->sw_nh notifier chain becomes
available earlier in the init procedure, which will be used in
subsequent patches. This makes sense because the events struct is pure
software, independent of any HW details.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 34 +++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index c904696cbc3a..612fc4de9d3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1010,16 +1010,10 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 		goto err_irq_cleanup;
 	}
 
-	err = mlx5_events_init(dev);
-	if (err) {
-		mlx5_core_err(dev, "failed to initialize events\n");
-		goto err_eq_cleanup;
-	}
-
 	err = mlx5_fw_reset_init(dev);
 	if (err) {
 		mlx5_core_err(dev, "failed to initialize fw reset events\n");
-		goto err_events_cleanup;
+		goto err_eq_cleanup;
 	}
 
 	mlx5_cq_debugfs_init(dev);
@@ -1121,8 +1115,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	mlx5_cleanup_reserved_gids(dev);
 	mlx5_cq_debugfs_cleanup(dev);
 	mlx5_fw_reset_cleanup(dev);
-err_events_cleanup:
-	mlx5_events_cleanup(dev);
 err_eq_cleanup:
 	mlx5_eq_table_cleanup(dev);
 err_irq_cleanup:
@@ -1155,7 +1147,6 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_cleanup_reserved_gids(dev);
 	mlx5_cq_debugfs_cleanup(dev);
 	mlx5_fw_reset_cleanup(dev);
-	mlx5_events_cleanup(dev);
 	mlx5_eq_table_cleanup(dev);
 	mlx5_irq_table_cleanup(dev);
 	mlx5_devcom_unregister_device(dev->priv.devc);
@@ -1833,6 +1824,24 @@ static int vhca_id_show(struct seq_file *file, void *priv)
 
 DEFINE_SHOW_ATTRIBUTE(vhca_id);
 
+static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
+{
+	int err;
+
+	err = mlx5_events_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "failed to initialize events\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void mlx5_notifiers_cleanup(struct mlx5_core_dev *dev)
+{
+	mlx5_events_cleanup(dev);
+}
+
 int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 {
 	struct mlx5_priv *priv = &dev->priv;
@@ -1888,6 +1897,10 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	if (err)
 		goto err_hca_caps;
 
+	err = mlx5_notifiers_init(dev);
+	if (err)
+		goto err_hca_caps;
+
 	/* The conjunction of sw_vhca_id with sw_owner_id will be a global
 	 * unique id per function which uses mlx5_core.
 	 * Those values are supplied to FW as part of the init HCA command to
@@ -1930,6 +1943,7 @@ void mlx5_mdev_uninit(struct mlx5_core_dev *dev)
 	if (priv->sw_vhca_id > 0)
 		ida_free(&sw_vhca_ida, dev->priv.sw_vhca_id);
 
+	mlx5_notifiers_cleanup(dev);
 	mlx5_hca_caps_free(dev);
 	mlx5_adev_cleanup(dev);
 	mlx5_pagealloc_cleanup(dev);
-- 
2.31.1


