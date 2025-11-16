Return-Path: <linux-rdma+bounces-14510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419FC61C95
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 21:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6EEB4EA551
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C226ED51;
	Sun, 16 Nov 2025 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aBCFW9cJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AD26E6FE;
	Sun, 16 Nov 2025 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326051; cv=fail; b=FOFkBZ/Wxuy8Jq8dDO2N3Sv81NDQq8n9CZ+6hrBzCV5e69LhYd8tDFaxqwKzIoP8CP7UvK820224CH9bb9yc2212bhKCWK+KN+nJhP+hswE+/7JVtVtQDnwNKHvBHM0FUghPxWasInhzdNPVns9KqxgoAYCpjQP/KeIOjJJUFp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326051; c=relaxed/simple;
	bh=strRhhbgkwaGS2Ex2A4wK5y8dXMdv0iKau1XPa7jv48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUlYzEtRQ+YPcQOn7E37nFqZH/edrpmSZ+MS96unnSHfZTTVm2FzwQ/PkK8pTltatQkKrL6+rcYF2uNhDNTInFackPmRDAjbUqcaFy40f/yIxX2yYPLiB3cIKkgbFubF2a0ZdWXXIxcFm4TR9wlRePGKxfNHeSGiSjh6iAeIUds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aBCFW9cJ; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ0ZPYLwTQWNfdNE/cEMeTohq5+/Gkxmr9zCHdc+/p9vm21liHTlaHOHm872sJm4Xs1TZfU2PZlIdGqPUyS11/9uqMTQZa4Dj/lr22xXDf6QYzvZpt9CV6c0uaKJR7MYv2Gn/Look+T+2ahaVpiFpNnPVBrm+9URK10tOvYavwLhphXr/+hQlSqgWPUordAK/YT8y03wwTerwqR09WEStblsQLqj0CvIlZWHaFn+82iD3sIbYfY/QT2/PvH5y6rlsazUVMGR7NKrvYTdFHK/aUArIe9nzv7c3hT8YKUCtYSu4wt0oALkZfWGy+im5KbWObjeh0NRDJWEwTR5BWvSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uY5nADLhQ1DNlyneMTuJqejq4ZGRHy+5oPIihxKvvI=;
 b=niDyIqKTi182v6yr/5kPFxlxBBH+fAYyL+SgAeRqnDg3axQYOze6k0P4f5wAdJ5cFi+hC4Y6LH1sxpektRa+80gggaVF8EIm9H2F0h4DCVsGM647mewOoVjN7gOjrLHLt2eJ+eLnymuIJQqXqzMT2wJrvgalNc638awkM3hzrGKqpfsb4GzoWRYRH565mO8zgkX+ZljSOK2tbcol+W7iOX1PV0+/P9U6w7QUmTOzPF+PdMfLyTIpxsTulFpNMly31Tdji6IC9wmUXUPuHGSDOTnjGXRfwURNeOsIuUDTDS+sGvBBThfr1xkNe1HD2lc2BqMrHszMCz5MlBnsb3LXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uY5nADLhQ1DNlyneMTuJqejq4ZGRHy+5oPIihxKvvI=;
 b=aBCFW9cJjrsDR4FpliTT3/eZvQq5kBx1tLDJR2tbe64EsViSaLFThN0If5q1yGHao9gOV5ciL75mQhl9OHw0yloZCQGSfZxz1oSHxq4r6ApKXu4a/CwKiNlZwOiCSbzuUXHidxgEmRzxwq1SrofBXsLCdZNuF4rzTSXW1XgyMI18uyKm69MlMG605KAIAJd06RCV3twzNr/mY1L1sFN5oJPuCOWFJni7p9kh1SAtaDvWuNswPUw3NgHm2wRqyDlwyNZCmH/TkIfqhWu5ZTNamW/qqjl6HUpxA5GHfYr/zivtQ0ndCJ0/qIvJUPu3MC8DhHR4f6rraVh+zMEqj6cmCg==
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 20:47:25 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::37) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Sun,
 16 Nov 2025 20:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 20:47:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 12:47:20 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 12:47:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 12:47:16 -0800
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
Subject: [PATCH net-next 5/6] net/mlx5: Move the SF table notifiers outside the devlink lock
Date: Sun, 16 Nov 2025 22:45:39 +0200
Message-ID: <1763325940-1231508-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ce305f-d65a-4a34-2909-08de25515955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n8vehKWeWScWChtySdHNg9sAuyMmJkhcS2gUOFUdN2QpfZ+WBoEfFRg6KF97?=
 =?us-ascii?Q?g5OwhVpGW4p6k/DYMM6uPygzWnfpH/BaKPcdVidW1xfK1fTlkvqtCNd8/0OA?=
 =?us-ascii?Q?AXUy3ynYiPdgyariSGU6mWxEFVu6rAnAydwBgt0nqHVctqlDCtZshtjYk0uO?=
 =?us-ascii?Q?q5ljn/UVeKc+e7GAka0SFYKXgVcHl52sph0QSmXTJ5/RaI6tVyrEcG8qOWmC?=
 =?us-ascii?Q?YdXwuTexDoQWd4Y0gSIKtkYqab28OI++uV+5s5EcFINVpEG6RDgsPANXmCBI?=
 =?us-ascii?Q?+9XwYoD8mznax50kfxOk2BPClyJIBmL0gAgfnhhMMO8tz5vP7XBwxNm7+LCO?=
 =?us-ascii?Q?/o6KCUWDS7TnzNAj29cuPDOpEpCE29+vdIqHFU6kD7KWsOgqkQ5gtQux29HM?=
 =?us-ascii?Q?Dfq+HqAKmDLm9cBXxw47OCIccMqddMfb9nDt2q7suNxO2kiOxSCrkmur6DWu?=
 =?us-ascii?Q?fOoQHT81RNSgyXsAeZ4DppCiZNv6BYhtgDnAJbYzX0+r6Ot5mqFWzxrybwd5?=
 =?us-ascii?Q?P+LKfK5GiUVwt/0okJqD/Lb9Sow66jipPSnG7PHmSuZI00TbvUR43re4f0PK?=
 =?us-ascii?Q?j5QeE57u5NG4/kgoQ/9vnsj/E9emDGtl73JdPSg0FJHJQ+TeCM0DfsnAVFfP?=
 =?us-ascii?Q?Mu4OWiPMuMQYjHvTbn8QL5gpfQg6g6ZbdcKKAucdIiemudrBw/5XeT1PYgNK?=
 =?us-ascii?Q?gmopwZ4TxQvgVQbTJIJ2ipnIVd5WR2VtVXn1LgMcTj+izbkN9IyCmYDHYYE2?=
 =?us-ascii?Q?KkRJnnzp034hkXVzVfUDeMFGvZnhwsnnjovyV6tgdJtsDTpPa7ab/D4d8Ld+?=
 =?us-ascii?Q?nyNaJOKliJ3KqxBw3EQdt6RoHQWocUFoNyE6cbRfYdIRMRJ6jcFLgO9HAMUQ?=
 =?us-ascii?Q?qRwCTYpIZZ6RtTumNLKpbIHqyz2Ch7E5c02oAi/+0ljc/XVW8twNlxQZo0ni?=
 =?us-ascii?Q?/qMhqdUFqSp1U32q+eGhj5Jrq0QltTzx9GS3ZRxVwthhpKSRN+K7p+agCt0X?=
 =?us-ascii?Q?otzfY8H0e/G1GMouOZaxGyMg4m8BeiXSD6BnDEQJ/3RcnlP7hg90VXfbzsqu?=
 =?us-ascii?Q?6vNVB8ekbts93FWzrYPytVhLfaS1bu9z2YOdveVw1Dse3DE+A179qim5XhMo?=
 =?us-ascii?Q?rFNWk6STy8SzmMLuRtINMVhh6HiNuR3vNEN/A+1nXyG2M0bmFowupVpMd7U0?=
 =?us-ascii?Q?32ojZ5YsDsWaiKoUtxqhCY4KA91DcQ922sX95EF9nSj5l4UXkE30Z5vesyzD?=
 =?us-ascii?Q?2wwK5bmPX87RWSAczhSTfFJ5sP52ghzDbs+otrCz5h3C/L0VbxtWvIN5hwce?=
 =?us-ascii?Q?cKJTxa4AUM50mb16obVTx/2wjLIb0Gqv+1fJINAUHkJHz0hJSBetqQYJIj1a?=
 =?us-ascii?Q?Mp3iNdynZKBCAWuGldd3DjX5dXzJvTYe0RacjY79iFqP5DuhKmasebb2Gf/w?=
 =?us-ascii?Q?jcK57zTojx3ySF5zMZ5HZId5Nbz9An+ud/8nxR68dVs1oYDCxbCb3xquKLNN?=
 =?us-ascii?Q?BXQN7vkqZiwG7Q2WtRuyg6r9CCj6CjcHeEjy0spp1anvZyXsg7VW4PiP4FA5?=
 =?us-ascii?Q?q5YVD1KY6R4svY5viXA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 20:47:25.3569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ce305f-d65a-4a34-2909-08de25515955
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

From: Cosmin Ratiu <cratiu@nvidia.com>

Move the SF table notifiers registration/unregistration outside of
mlx5_init_one() / mlx5_uninit_one() and into the mlx5_mdev_init() /
mlx5_mdev_uninit() functions.

This is only done for non-SFs, since SFs do not have a SF table
themselves and thus don't need notifiers.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    |  7 ++
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  | 90 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/sf/sf.h   | 11 +++
 include/linux/mlx5/driver.h                   |  3 +
 4 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 843ee452239f..0c3613ef39b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1833,8 +1833,14 @@ static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_sf_hw_notifier;
 
+	err = mlx5_sf_notifiers_init(dev);
+	if (err)
+		goto err_sf_notifiers;
+
 	return 0;
 
+err_sf_notifiers:
+	mlx5_sf_hw_notifier_cleanup(dev);
 err_sf_hw_notifier:
 	mlx5_events_cleanup(dev);
 	return err;
@@ -1842,6 +1848,7 @@ static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 
 static void mlx5_notifiers_cleanup(struct mlx5_core_dev *dev)
 {
+	mlx5_sf_notifiers_cleanup(dev);
 	mlx5_sf_hw_notifier_cleanup(dev);
 	mlx5_events_cleanup(dev);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 2ece4983d33f..b82323b8449e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -31,9 +31,6 @@ struct mlx5_sf_table {
 	struct mlx5_core_dev *dev; /* To refer from notifier context. */
 	struct xarray function_ids; /* function id based lookup. */
 	struct mutex sf_state_lock; /* Serializes sf state among user cmds & vhca event handler. */
-	struct notifier_block esw_nb;
-	struct notifier_block vhca_nb;
-	struct notifier_block mdev_nb;
 };
 
 static struct mlx5_sf *
@@ -391,11 +388,16 @@ static bool mlx5_sf_state_update_check(const struct mlx5_sf *sf, u8 new_state)
 
 static int mlx5_sf_vhca_event(struct notifier_block *nb, unsigned long opcode, void *data)
 {
-	struct mlx5_sf_table *table = container_of(nb, struct mlx5_sf_table, vhca_nb);
+	struct mlx5_core_dev *dev = container_of(nb, struct mlx5_core_dev,
+						 priv.sf_table_vhca_nb);
+	struct mlx5_sf_table *table = dev->priv.sf_table;
 	const struct mlx5_vhca_state_event *event = data;
 	bool update = false;
 	struct mlx5_sf *sf;
 
+	if (!table)
+		return 0;
+
 	mutex_lock(&table->sf_state_lock);
 	sf = mlx5_sf_lookup_by_function_id(table, event->function_id);
 	if (!sf)
@@ -407,7 +409,7 @@ static int mlx5_sf_vhca_event(struct notifier_block *nb, unsigned long opcode, v
 	update = mlx5_sf_state_update_check(sf, event->new_vhca_state);
 	if (update)
 		sf->hw_state = event->new_vhca_state;
-	trace_mlx5_sf_update_state(table->dev, sf->port_index, sf->controller,
+	trace_mlx5_sf_update_state(dev, sf->port_index, sf->controller,
 				   sf->hw_fn_id, sf->hw_state);
 unlock:
 	mutex_unlock(&table->sf_state_lock);
@@ -425,12 +427,16 @@ static void mlx5_sf_del_all(struct mlx5_sf_table *table)
 
 static int mlx5_sf_esw_event(struct notifier_block *nb, unsigned long event, void *data)
 {
-	struct mlx5_sf_table *table = container_of(nb, struct mlx5_sf_table, esw_nb);
+	struct mlx5_core_dev *dev = container_of(nb, struct mlx5_core_dev,
+						 priv.sf_table_esw_nb);
 	const struct mlx5_esw_event_info *mode = data;
 
+	if (!dev->priv.sf_table)
+		return 0;
+
 	switch (mode->new_mode) {
 	case MLX5_ESWITCH_LEGACY:
-		mlx5_sf_del_all(table);
+		mlx5_sf_del_all(dev->priv.sf_table);
 		break;
 	default:
 		break;
@@ -441,15 +447,16 @@ static int mlx5_sf_esw_event(struct notifier_block *nb, unsigned long event, voi
 
 static int mlx5_sf_mdev_event(struct notifier_block *nb, unsigned long event, void *data)
 {
-	struct mlx5_sf_table *table = container_of(nb, struct mlx5_sf_table, mdev_nb);
+	struct mlx5_core_dev *dev = container_of(nb, struct mlx5_core_dev,
+						 priv.sf_table_mdev_nb);
 	struct mlx5_sf_peer_devlink_event_ctx *event_ctx = data;
+	struct mlx5_sf_table *table = dev->priv.sf_table;
 	int ret = NOTIFY_DONE;
 	struct mlx5_sf *sf;
 
-	if (event != MLX5_DRIVER_EVENT_SF_PEER_DEVLINK)
+	if (!table || event != MLX5_DRIVER_EVENT_SF_PEER_DEVLINK)
 		return NOTIFY_DONE;
 
-
 	mutex_lock(&table->sf_state_lock);
 	sf = mlx5_sf_lookup_by_function_id(table, event_ctx->fn_id);
 	if (!sf)
@@ -464,10 +471,40 @@ static int mlx5_sf_mdev_event(struct notifier_block *nb, unsigned long event, vo
 	return ret;
 }
 
+int mlx5_sf_notifiers_init(struct mlx5_core_dev *dev)
+{
+	int err;
+
+	if (mlx5_core_is_sf(dev))
+		return 0;
+
+	dev->priv.sf_table_esw_nb.notifier_call = mlx5_sf_esw_event;
+	err = mlx5_esw_event_notifier_register(dev, &dev->priv.sf_table_esw_nb);
+	if (err)
+		return err;
+
+	dev->priv.sf_table_vhca_nb.notifier_call = mlx5_sf_vhca_event;
+	err = mlx5_vhca_event_notifier_register(dev,
+						&dev->priv.sf_table_vhca_nb);
+	if (err)
+		goto vhca_err;
+
+	dev->priv.sf_table_mdev_nb.notifier_call = mlx5_sf_mdev_event;
+	err = mlx5_blocking_notifier_register(dev, &dev->priv.sf_table_mdev_nb);
+	if (err)
+		goto mdev_err;
+
+	return 0;
+mdev_err:
+	mlx5_vhca_event_notifier_unregister(dev, &dev->priv.sf_table_vhca_nb);
+vhca_err:
+	mlx5_esw_event_notifier_unregister(dev, &dev->priv.sf_table_esw_nb);
+	return err;
+}
+
 int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_sf_table *table;
-	int err;
 
 	if (!mlx5_sf_table_supported(dev) || !mlx5_vhca_event_supported(dev))
 		return 0;
@@ -480,28 +517,18 @@ int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 	table->dev = dev;
 	xa_init(&table->function_ids);
 	dev->priv.sf_table = table;
-	table->esw_nb.notifier_call = mlx5_sf_esw_event;
-	err = mlx5_esw_event_notifier_register(dev, &table->esw_nb);
-	if (err)
-		goto reg_err;
-
-	table->vhca_nb.notifier_call = mlx5_sf_vhca_event;
-	err = mlx5_vhca_event_notifier_register(table->dev, &table->vhca_nb);
-	if (err)
-		goto vhca_err;
-
-	table->mdev_nb.notifier_call = mlx5_sf_mdev_event;
-	mlx5_blocking_notifier_register(dev, &table->mdev_nb);
 
 	return 0;
+}
 
-vhca_err:
-	mlx5_esw_event_notifier_unregister(dev, &table->esw_nb);
-reg_err:
-	mutex_destroy(&table->sf_state_lock);
-	kfree(table);
-	dev->priv.sf_table = NULL;
-	return err;
+void mlx5_sf_notifiers_cleanup(struct mlx5_core_dev *dev)
+{
+	if (mlx5_core_is_sf(dev))
+		return;
+
+	mlx5_blocking_notifier_unregister(dev, &dev->priv.sf_table_mdev_nb);
+	mlx5_vhca_event_notifier_unregister(dev, &dev->priv.sf_table_vhca_nb);
+	mlx5_esw_event_notifier_unregister(dev, &dev->priv.sf_table_esw_nb);
 }
 
 void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
@@ -511,9 +538,6 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 	if (!table)
 		return;
 
-	mlx5_blocking_notifier_unregister(dev, &table->mdev_nb);
-	mlx5_vhca_event_notifier_unregister(table->dev, &table->vhca_nb);
-	mlx5_esw_event_notifier_unregister(dev, &table->esw_nb);
 	mutex_destroy(&table->sf_state_lock);
 	WARN_ON(!xa_empty(&table->function_ids));
 	kfree(table);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
index 3922dacffae8..d8a934a0e968 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
@@ -16,7 +16,9 @@ int mlx5_sf_hw_notifier_init(struct mlx5_core_dev *dev);
 void mlx5_sf_hw_notifier_cleanup(struct mlx5_core_dev *dev);
 void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev);
 
+int mlx5_sf_notifiers_init(struct mlx5_core_dev *dev);
 int mlx5_sf_table_init(struct mlx5_core_dev *dev);
+void mlx5_sf_notifiers_cleanup(struct mlx5_core_dev *dev);
 void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev);
 bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev);
 
@@ -58,11 +60,20 @@ static inline void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev)
 {
 }
 
+static inline int mlx5_sf_notifiers_init(struct mlx5_core_dev *dev)
+{
+	return 0;
+}
+
 static inline int mlx5_sf_table_init(struct mlx5_core_dev *dev)
 {
 	return 0;
 }
 
+static inline void mlx5_sf_notifiers_cleanup(struct mlx5_core_dev *dev)
+{
+}
+
 static inline void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 {
 }
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index a51bea44d57c..7dbef112deaf 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -622,6 +622,9 @@ struct mlx5_priv {
 #ifdef CONFIG_MLX5_SF_MANAGER
 	struct notifier_block sf_hw_table_vhca_nb;
 	struct mlx5_sf_hw_table *sf_hw_table;
+	struct notifier_block sf_table_esw_nb;
+	struct notifier_block sf_table_vhca_nb;
+	struct notifier_block sf_table_mdev_nb;
 	struct mlx5_sf_table *sf_table;
 #endif
 	struct blocking_notifier_head lag_nh;
-- 
2.31.1


