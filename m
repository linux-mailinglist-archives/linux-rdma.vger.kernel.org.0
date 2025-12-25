Return-Path: <linux-rdma+bounces-15221-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C82CDDD32
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 14:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C3F63068DCF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C8155322;
	Thu, 25 Dec 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KpN3PP2v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275D320A05;
	Thu, 25 Dec 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669275; cv=fail; b=iDmbk9h4DQmxrj/OWGCaWdeOKNatg/XXMaszPN99gbl+y7hebep9AYDX1QclfMPIloFa6pr/H9eUm0q2oQyJQ6Ocu7d4ZkrAU/ON+idW6cf51U7PPDM6BB0KywaH5mySkPMpTj8ZrG29eCNivCUPhb2z7AGdaschRckQLj1qmas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669275; c=relaxed/simple;
	bh=Eim1fB6I/KB8Ze4Ux2b+MmpNsdqK9kLROI/5KesV+PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiLChX0zlJEGpKWdv9+gWtwOcdLWk89wAhP5TFXGuG0b2r0XUPkQxVzIrcem99cFW1kHJhNP7yej/3tDnYRvrPN6OrBM7G7acTPQOSbqiwHx72qXIUUGeNDEpOazI+AFdbrEwv/afoUuzTV6R5dbbLc6qbyEd5xD2cjJ7FL3QdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KpN3PP2v; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0qzHMzcuWP2kXkX/QV9kznnFexKqK9v7UJQNq6MNSKCR5Wc0kqXD5T8/4TaAsah3HT7QLFepsBRHgZULjRtUPG6NHx4EbsAmoPXpwPcGzqwbFBMsJBfaxkd9jwUe2mTP2vsnRax/JlUxYp2ssViBIPHDcZImUQuWsPPXUy3ZK+OCti18ae9flfO9P4dy42yFS/cfZNqhmqEQTbY7vxHEnUDBCpuEaAHYf5WnlTZ5j7So94H1c7VhIqIts4ENma9icZ94/j0b257N+EhoOle4BqQEtnutLwu9IIg4/N8NUkSkskYi7fDSooMYlzBGyhHC8IH+WTE3K2Fcft+QcjBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPvOUvuoMeetqKQ/veluv4TVKg2T3Hak1djtNiKOfo4=;
 b=bF/jpmpDx+w4CKuvmqL2WiJMaS7fz7SpPLxyyDEdLGFf+AIZzQJ8OG8hPHkCXOdgQSWHZnSRF6o/KT/ro8SMc4EKZT0sI5WldTKWoCIbg7drVzbGXdao76sWMH4gXv0h3/ebhZB6+oa38ZfIBvhf9peim++QOi/lyo4Jm1M+0Y3wH2axNSff+j+0VfZr93yojvZKIRX3ZeGG0i5Qtf/CBHYIp4TnSQsexJ/Jb8o7uFWf2snOZbigEAv1ibhOm3ay7LAJfEwSRmCcsk6RrkpI6WeeMX8GOqELtWpeQ5xarqXirfVD2TeGfBYMqn/L3ZbPZHi4kCgwU1ugqikdwEAPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPvOUvuoMeetqKQ/veluv4TVKg2T3Hak1djtNiKOfo4=;
 b=KpN3PP2vYA17iTczdC/wHZYQpHbYXm5swTJrweWAItFXS4/vhB//R9e0Ucwzb5RcPfU84UiA5Ibo5PrcMNz/I8AJInCM0PR2B3NtnS1aX7bsPOrM1U8v8dvnXdpe+UfXdTViBrMTUP4d5IxKmoPcQivr1EY9oVo+Pm37c1ux8b+uFN7hvbqa4jwRW8g6bPWzM6JfQOKDPaliBl2Qc0GhyJbF22VC9aWa+snoR5ETqRrnvHnjCpagE1iNuZm8YAEz3KYealY1Dew84vTlaT80PANJtQ8Vb39X9r35f7KJ59dPMx9NCoIkX5py6GL2qIO34JOaLWGC13g48KSCrdrpng==
Received: from BYAPR06CA0052.namprd06.prod.outlook.com (2603:10b6:a03:14b::29)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 13:27:49 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::6b) by BYAPR06CA0052.outlook.office365.com
 (2603:10b6:a03:14b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.12 via Frontend Transport; Thu,
 25 Dec 2025 13:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Thu, 25 Dec 2025 13:27:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 05:27:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Dec 2025 05:27:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Dec 2025 05:27:44 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net 5/5] net/mlx5e: Dealloc forgotten PSP RX modify header
Date: Thu, 25 Dec 2025 15:27:17 +0200
Message-ID: <20251225132717.358820-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225132717.358820-1-mbloch@nvidia.com>
References: <20251225132717.358820-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bc61bb-a288-474d-20d3-08de43b965f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kos5ih2FJyAp/b9iF2W6Jmb/eJT+U9MNUOZOS9RtIpZELi+E24k27rjGS14l?=
 =?us-ascii?Q?buwEjv8tB7g6sdnLePhvrul1qbicpYeCoKiGDHNYc3hW31wXDR88i+Wr4GgN?=
 =?us-ascii?Q?HoU3rDx06/vzgMm5RrUQnCaLqoyg8XUO2nptch32in2xTHoDtsUZJMav1Rum?=
 =?us-ascii?Q?xxi8k+Caq2m7AMWZ8GbnQ/qaVy7hb/QkJ2vn4ETvqKM0FTZlaqZGTJcq1z+G?=
 =?us-ascii?Q?gVTMNvN7kC+JYtREqrXRJcP9u6OwjjMKsbkAW2rc79XTkTtyQFwREwEXy4d0?=
 =?us-ascii?Q?dYRiqye29n/03qnh83ofNmYxCofxcAbPAJK/Q5Dn2AEYigRf7G5qlXn+2QNx?=
 =?us-ascii?Q?GArJ87WTWpXDEfjkIQ/8f4kr+AFGJqvFpMbcff/urFftM7f2I446PQpgsW1s?=
 =?us-ascii?Q?suGYc3kyW0YN7eMReyXt6vtkFhN3Jen81QBBVKIe271VsuT1JXh1FER9P4DO?=
 =?us-ascii?Q?VykZSTXPo/pEfwjAKE89RsXu1FI9AxSN95+0HaUzJDngXMJMXaW3fJCpvXsF?=
 =?us-ascii?Q?6R5jq1Pv2Elv4VyWXx01Xw0oAD+MG67zoO7oJGdcDMrYDexSZFxprmlJ8eVO?=
 =?us-ascii?Q?gMTrud81Aj9AkzOovvWaYL3OiLuq9OMwXd0hdwxhKNqm5Lqip+pTwO/BpPW3?=
 =?us-ascii?Q?AtBiXH/Wl/0haEGR4K2I5SA/HPoq6HkKNC8HMIW9iKqcKdszPO2/9jfNh9ex?=
 =?us-ascii?Q?YFo1qqoJZ13uBOx2ELEK5QTbFQuXpMilskDfswFqktlw2DUdvfXBk5xDI0Op?=
 =?us-ascii?Q?LnBLjCnnDEmm+0WQzBuuJCrlrv/Dufwn+xZtp6Im9w7Pn2XeTNDOUl5SfmIV?=
 =?us-ascii?Q?Fnav4Zz8wluXiqTUu3Dl/4xhB/0H9RvWQoEtNr6D+a/kmiDn5+tMvyjayIdj?=
 =?us-ascii?Q?5S9qILkpbBs+3PFGJGg0YqlZ0A6cep+2X1AVHtTVnQTe5MYw1sKdA1GjXAu+?=
 =?us-ascii?Q?UyFdgFMojlmIF3C7ZOi2E/beHjRQ0nlVe/s2LFsxZDwbSJG2mXG/oIf9/Jea?=
 =?us-ascii?Q?f5IeywiDqt1v55101yfPUWvmwpy1OSmo8VQmhgFweTyIrMAhPKpGTih20sFU?=
 =?us-ascii?Q?hZk/sDpe+YSiDlu79sj8pkDjUkMZJWM4l14PY1PQ/gicVJI2s+uv/T+ffoZm?=
 =?us-ascii?Q?vaZAx8ymelEcf1bDAU38HNvsyu8ARugh6VYHQcYS1EqKaBNp6dKazx6BI4AA?=
 =?us-ascii?Q?Uh/Dr2EYnAK7laZBdABUUJ+V4Z1gBngtw/vt1mDt3VdHZ3qeCdHaqxm7+J4x?=
 =?us-ascii?Q?ga0wAmjwkkDT7Fvl8U3BuZSxCqqIXcKuAm3IsKfg4uWIzgql4zhAqEJ40vH3?=
 =?us-ascii?Q?ClLsjLHCVYGwIlcn56lEMzZR1t9dGPRfx6KRW1GxYGL9DQn9/iUJBVOqfCqO?=
 =?us-ascii?Q?kzp0s5EzuMVFGmmulRwkYKJoJVZXhKPNMdu0TDVVDdh9773UeALd/Mk4eVKI?=
 =?us-ascii?Q?36MmlPKXA7BBJ5A7pOMP+tQd3MLysHmvsR/oG4LJePGkxi4kbZdZ9m+uaN5X?=
 =?us-ascii?Q?Icr+pLfsczr55YPZAnAVh3Qb8EMG8206Lps9WBRrfIJz3jjMrja3No8wBU6o?=
 =?us-ascii?Q?ZBOhSRYlT+8t5KQmkYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 13:27:49.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bc61bb-a288-474d-20d3-08de43b965f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

From: Cosmin Ratiu <cratiu@nvidia.com>

The commit which added RX steering rules for PSP forgot to free a modify
header HW object on the cleanup path, which lead to health errors when
reloading the driver and uninitializing the device:

mlx5_core 0000:08:00.0: poll_health:803:(pid 3021): Fatal error 3 detected

Fix that by saving the modify header pointer in the PSP steering struct
and deallocating it after freeing the rule which references it.

Fixes: 9536fbe10c9d ("net/mlx5e: Add PSP steering in local NIC RX")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 38e7c77cc851..9a74438ce10a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -44,6 +44,7 @@ struct mlx5e_accel_fs_psp_prot {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *miss_group;
 	struct mlx5_flow_handle *miss_rule;
+	struct mlx5_modify_hdr *rx_modify_hdr;
 	struct mlx5_flow_destination default_dest;
 	struct mlx5e_psp_rx_err rx_err;
 	u32 refcnt;
@@ -286,13 +287,19 @@ static int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	return err;
 }
 
-static void accel_psp_fs_rx_fs_destroy(struct mlx5e_accel_fs_psp_prot *fs_prot)
+static void accel_psp_fs_rx_fs_destroy(struct mlx5e_psp_fs *fs,
+				       struct mlx5e_accel_fs_psp_prot *fs_prot)
 {
 	if (fs_prot->def_rule) {
 		mlx5_del_flow_rules(fs_prot->def_rule);
 		fs_prot->def_rule = NULL;
 	}
 
+	if (fs_prot->rx_modify_hdr) {
+		mlx5_modify_header_dealloc(fs->mdev, fs_prot->rx_modify_hdr);
+		fs_prot->rx_modify_hdr = NULL;
+	}
+
 	if (fs_prot->miss_rule) {
 		mlx5_del_flow_rules(fs_prot->miss_rule);
 		fs_prot->miss_rule = NULL;
@@ -396,6 +403,7 @@ static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
 		modify_hdr = NULL;
 		goto out_err;
 	}
+	fs_prot->rx_modify_hdr = modify_hdr;
 
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
@@ -416,7 +424,7 @@ static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
 	goto out;
 
 out_err:
-	accel_psp_fs_rx_fs_destroy(fs_prot);
+	accel_psp_fs_rx_fs_destroy(fs, fs_prot);
 out:
 	kvfree(flow_group_in);
 	kvfree(spec);
@@ -433,7 +441,7 @@ static int accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs, enum accel_fs_psp_ty
 	/* The netdev unreg already happened, so all offloaded rule are already removed */
 	fs_prot = &accel_psp->fs_prot[type];
 
-	accel_psp_fs_rx_fs_destroy(fs_prot);
+	accel_psp_fs_rx_fs_destroy(fs, fs_prot);
 
 	accel_psp_fs_rx_err_destroy_ft(fs, &fs_prot->rx_err);
 
-- 
2.34.1


