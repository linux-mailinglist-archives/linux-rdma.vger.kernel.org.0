Return-Path: <linux-rdma+bounces-7919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85EA3E6D9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AF0160CE5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D46267F62;
	Thu, 20 Feb 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bolb4cda"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361FB267B79;
	Thu, 20 Feb 2025 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087689; cv=fail; b=FtihsQ5gwOGLSPAgriYb2t/rTnnJa6aJJUqcH1+67jo5HixxdPrQ7s5ZPfZgB/Tm8QACOj+We9uxv0qJJwLWgYWwG/UcFLxKCe5IolvnR84MTSZhYN06MhaEResV+aPY01fDBrts+pWDAJSNuF/cRPIZKkp49gXVsrSu/ZawrdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087689; c=relaxed/simple;
	bh=XX2xf+1VLHtuVF0/NM3JAK7HJwfZ89qqR/rcLw8MGjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A57g+H+32yuJv05kpgZH8e0NsIfgui1lXa49+F3uSjWo+keXonycQonUIWm/h0GeCrYWrQUuJaes1S81E6bVa1qoEBsXaL+ZJtLQ+obGoUsS0Bj2Jc/pPspMLyvD+uLiY4tLbMvcIZ9EwmhJOUd+ICnUb4c8FsRsdlAaH2B14DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bolb4cda; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuuQ2o9CU1ZIifXZ2lQWb7Ve+XDzTYlPcj9MJXnK9e1V0dTt6FUdpkDfyYheXjVX+VB3LcrdJk/vejpOSyet4gaK9uok97p6gQVChkmv9uA+4duNCQgVYXmwiPOlWeFwZsXx9xzqsnQhEskBiQdTRXoX01lDVzF0PDTmjbcEQ5cHAC95kZ1gYlbJyj3WlYmwcdCqD4QLkYgYqLrHNUSVRNOW7YMd+pIqj+8jSGPt4QHnVvGs0eOYgljbtwEncKq/PxLvSIEuH/xKppfdtC4G30SILwnaO6rphpsKqBv8VXvfvoInyCkfrf/znJt2cb31hd9O+RyaxiuHHdZSyk7MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERh26vhimYxKe7eWtjVGSOFky40xypk4OlR5S80xU4o=;
 b=zJhgbVkiVieuYczWXt15AK73mWTO48ICzKEq13yDHPcXB61w6nzQ6QBw2iKYpOr4Hw/LEtcE1LQ8wRqx98UkLPy8ryAr73sy9dWpNglrZz36g3gQAlqDRtSVF/QlmXv/X0ptXy4p0ZC3DCz+28sTq106Jys7oVdHRIIa2hyuawoKf5+ufbGnBLfsBFasJokuSDCFvGGncCKioUTkOvb7uE6o9hThGLmufIxQq2ny5kYCyDAucxKS992huVHFPnKUKgdEe0pMnJU35KLrIU1MJjPexJ58xEirn8q258mOo4O6UXDMQUApFYywlp8QYo7gPLAC8fsRXyT0BPja2klDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERh26vhimYxKe7eWtjVGSOFky40xypk4OlR5S80xU4o=;
 b=bolb4cdaec60rM89c1fRL5yrL0twS10LSJKsbO3ecW0Sy4/GAqouLwVQ9dDlfr4dZzEjmsTSesaO8VdBzqnyicoIvAikbRgiKhcETRUAkp3jQPcfEd0GIB/KeJbb26c5xfzI2cZwOeI8wh+iTWPrnI95L3/IYMZ6R4zOqGP9aYmiNH4Aj49306IHoeWV0Z31ywQBNIbnrz1ReOYGp3lJSpiRIfRoN51Tfn/sZdWVuDHKbN9iehDXkoxvnV+jePqXTawZ56KeGX9Z3WBM2OJ8x1Oj03uEwUcqbe9EvutHK6EbRJoTIi3Hs4f8mjMvWkBT1uRZxgeDUDq/B5UATm3T0Q==
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 21:41:23 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::3d) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 21:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:41:05 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:41:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:41:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Patrisious
 Haddad <phaddad@nvidia.com>
Subject: [PATCH net-next 6/8] net/mlx5e: Add num_reserved_entries param for ipsec_ft_create()
Date: Thu, 20 Feb 2025 23:39:56 +0200
Message-ID: <20250220213959.504304-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220213959.504304-1-tariqt@nvidia.com>
References: <20250220213959.504304-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2fe45d-5839-4212-97bd-08dd51f751da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgA23NzTjpdpZrz19RbwcFY/McrRVspF5F9ahbPZvtrgGkgEOYZaL4wMIh+3?=
 =?us-ascii?Q?hI1934TasXtvSHSaLkEL6yjzCpQ0UAXZxMqje2nL0ZiGuITZBx967/H5ZUa+?=
 =?us-ascii?Q?3/CLghYrqg2yFTapiWMQaH9lwppAHd3GqASymwjjvQAyzrQmaT1yCZzzaC/A?=
 =?us-ascii?Q?G/afVJE2xf5acqs4fu1r4rOIsAfacAdyNBX/+PKJNWHVZZMzBRcmTpVsc8Of?=
 =?us-ascii?Q?wMcRgwiPXAsnd76Ou0z5af8LLeW0MgMkDEPdl8hrpgVd1ksPGzuzjyT9QmpY?=
 =?us-ascii?Q?9l4zhzJ4zykTDUBdIjnzVeklUve8vskMIZsArQIUcfmhZrQc10UsJluOspjY?=
 =?us-ascii?Q?c0DIDdYMNEsWD+R3dPL1UKcJ0mhgaUValroHrQ6mkKaMEehxvKOGv+pfXUaZ?=
 =?us-ascii?Q?XEcj32rzrHMywGvaqyjMYCiYXJfmHRJofxzpQbJ47lMwHVPb5BnuFx6tE+GB?=
 =?us-ascii?Q?7FJUgR+6NgghZv+QoJm+AcMPDprq/yOwxsSR8fcLHsuIolPwvB2pTtmbxUR/?=
 =?us-ascii?Q?1hRrndQp/QAavA+kEQaZbeHfF81IPHmgsWgZVTUVsxgGs4Gko0Z3jjcUdQmN?=
 =?us-ascii?Q?eu8h38sP9wO1wzephlmap0cBEZJNy3/Ex1/Y/DjzgFVFhgQ20KTDY2/hghk7?=
 =?us-ascii?Q?LZm/NWPjkNQeZoKD0SeCE7U+bFqie/iCcqRnt/8EUNxFtxCqtEau6YLsWqEQ?=
 =?us-ascii?Q?u0EKQZmJuRascVcKLd0UD1P23vdPcc2pZ9u8+lIa64yrY83m+oTwphmEgo+8?=
 =?us-ascii?Q?5ZzdD7CtWOho7MgBTuIHdI/CXH9OJG26Kn+TaVOcLlLyXWKxyteV3LX/J4vA?=
 =?us-ascii?Q?IcU38Ny7VkhsLWorTjmZ3skUPxrL0cOweYFfNMQQhCFqSxi6P/AMqLTaGKjG?=
 =?us-ascii?Q?7Ujt6rKJqOFhdfB/RpT8V8/f/RvJIxw83kTUQGPPkCvh6N3W9zANA1qcwY6I?=
 =?us-ascii?Q?3GMI1XMaxnTgfz9wzyESdd3Uv5WCHMl8iN3FEYVm9eZnRVyq4A7qpZrRPPUR?=
 =?us-ascii?Q?L+EZ3Pung+LRuuKeElMGUjWGY9PAyMeZ6ij2MIAVh3UTyiB2r4K7n+oJVedK?=
 =?us-ascii?Q?CaJnfZr+Oycm5+XDcfBv/Lx249oHk3Pt8hnqAfSRsrw2Y9us8TawiVeYMZsc?=
 =?us-ascii?Q?X5OypmTNWfg1lWIgtkQAy6E+iUkUVqQgdg/YcfzRHqslJwMOvGVZN3BLfHT6?=
 =?us-ascii?Q?6TQrpEXJl5Q0WhxUjsa/in/+Qh21flQhhqDynaN6mOHIiw61lThO5J20PTlq?=
 =?us-ascii?Q?/npI2xtlC3N2Pu0o08sLBxS2Rhan3hF8oVKfqUH0+wutAyO0XXLzzN+rJNY9?=
 =?us-ascii?Q?tmDQGhsuKIQ5k6vJkf88Mrf502G8MpJ6tIy+nlep2EhAGqJ/HxWDTuoZesA5?=
 =?us-ascii?Q?sjivtzSePKzULo8H8tncmTBVdh/8/NAaJUHIIwnHu3gEC/tTrC9Kypd5HrBW?=
 =?us-ascii?Q?Yv2NRUJG5INuRsYlM6B6WjeAEDqcTyPkFf8KmUWWe6SEpq3nPBNNiM66tiRi?=
 =?us-ascii?Q?LB6uvWr/gFC1swI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:22.7280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2fe45d-5839-4212-97bd-08dd51f751da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574

From: Jianbo Liu <jianbol@nvidia.com>

Add parameter for ipsec_ft_create() to pass the number of the reserved
entries when creating auto-grouped flow table. It's used to create
table with pre-defined group(s) which may have more than one rule.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c        | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e72b365f24be..2ee4c7bfd7e6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -141,11 +141,12 @@ static void ipsec_chains_put_table(struct mlx5_fs_chains *chains, u32 prio)
 
 static struct mlx5_flow_table *ipsec_ft_create(struct mlx5_flow_namespace *ns,
 					       int level, int prio,
+					       int num_reserved_entries,
 					       int max_num_groups, u32 flags)
 {
 	struct mlx5_flow_table_attr ft_attr = {};
 
-	ft_attr.autogroup.num_reserved_entries = 1;
+	ft_attr.autogroup.num_reserved_entries = num_reserved_entries;
 	ft_attr.autogroup.max_num_groups = max_num_groups;
 	ft_attr.max_fte = NUM_IPSEC_FTE;
 	ft_attr.level = level;
@@ -818,7 +819,7 @@ static int ipsec_rx_policy_create(struct mlx5e_ipsec *ipsec,
 			err = PTR_ERR(rx->chains);
 	} else {
 		ft = ipsec_ft_create(attr->ns, attr->pol_level,
-				     attr->prio, 2, 0);
+				     attr->prio, 1, 2, 0);
 		if (IS_ERR(ft)) {
 			err = PTR_ERR(ft);
 			goto err_out;
@@ -857,7 +858,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (err)
 		return err;
 
-	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 3, 0);
+	ft = ipsec_ft_create(attr.ns, attr.status_level, attr.prio, 1, 3, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_fs_ft_status;
@@ -869,7 +870,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (rx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
-	ft = ipsec_ft_create(attr.ns, attr.sa_level, attr.prio, 2, flags);
+	ft = ipsec_ft_create(attr.ns, attr.sa_level, attr.prio, 1, 2, flags);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_fs_ft;
@@ -1095,7 +1096,7 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 	int err;
 
 	ipsec_tx_create_attr_set(ipsec, tx, &attr);
-	ft = ipsec_ft_create(tx->ns, attr.cnt_level, attr.prio, 1, 0);
+	ft = ipsec_ft_create(tx->ns, attr.cnt_level, attr.prio, 1, 1, 0);
 	if (IS_ERR(ft))
 		return PTR_ERR(ft);
 	tx->ft.status = ft;
@@ -1108,7 +1109,7 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		tx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (tx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
-	ft = ipsec_ft_create(tx->ns, attr.sa_level, attr.prio, 4, flags);
+	ft = ipsec_ft_create(tx->ns, attr.sa_level, attr.prio, 1, 4, flags);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_sa_ft;
@@ -1136,7 +1137,7 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		goto connect_roce;
 	}
 
-	ft = ipsec_ft_create(tx->ns, attr.pol_level, attr.prio, 2, 0);
+	ft = ipsec_ft_create(tx->ns, attr.pol_level, attr.prio, 1, 2, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_pol_ft;
-- 
2.45.0


