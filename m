Return-Path: <linux-rdma+bounces-7917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30463A3E6D1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B7C19C47D0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39870265629;
	Thu, 20 Feb 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L5034mWf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A334264F88;
	Thu, 20 Feb 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087682; cv=fail; b=i8KDPWDIwdXCh6TCwaUOqFpquT2NIiORrbOLPG48TBsGqk6zmXeS+vqriFumDGbWep/po705/kYr4Hi5sixCYW+HKbmNtZspBD3dfuZGN6hyLT71vXImJ6IDzZp4kyyjUwYjTJCPtM4sDLnNsKQftYaK9eRZj7uey0nQoDeU6T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087682; c=relaxed/simple;
	bh=qxXimiQ39VFhSV56JieSP1/H9C+qj9mTtxvcakLDaDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=om6BL0NyfVmtyFyci6Fv4xVWGzwynz53ZtUpP0j7SczF1Jg0BzHM9LvezA59Yu4/rgFtK5mRjdfGdyxBzmkbLO7vf1QJgW4HU/nzsCX2KN+CIx5XOvZjQaescVs7UpBIQacYTIryh5pkrPEf1T6lqlZGgkyXewd1YukRKFNH6yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L5034mWf; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcuGofez2Y0IUJ8gGWJSqN2pqMhh20H8NHdZvSvbQ6o+65alKE18dLj9Fu2/txodzr999EVzll3lnQ+YZ8BHaU9NcAfrS1Vf3N5qxAUkbvXhi5htj+2MG2gAfYsewj7CUfSRy19w+/8dzw3uZJH3t/DV/v/N5VzYNm2C3UwMGq3iBV+erMmJa/o3NA0NC55QP7ctUho3tegDaLlZo5OdsaeFOXDfeZzLJzu4sSh3BE2XKrjqkWXVgKAc1dIWHa1j92o0NinJ49hCWCAiVu+jpxraWG/RldCmAWN+ykNVbTucgtEhONFb91huS2IxKiZP/ffBn82sU2iXQWba8DgN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQsvL7UHaAG4lKwhpm3cx/fEcEH7c+zaTWNBSHmsWjU=;
 b=bGxP4D3nkEn8cUn6BmcxfZkEiajTw8dcTEnTn1d5U27WcK+/E8OSMp4+lscOFVNM6Od7BZAw3RmokNebpMqZbJPiHPxyQPDlZqHqmSR0TqG7oYsZxEv0V0RI5KfQwY5h+lAZnyjjZfuvILW6SdXCePWmh/cPoIeE/4CXuENGQ5+iaVu7jZ4a1UyJrLDDuUzugpGhtrs6rq9R9SArDUPwqF/0sujqcksvPB1X4/kygaBteLNBjxdoTbu3I3T29KjzwnpBMojXZNKDkwJH96+e1IMjty1hpvODfgFqOPFwEPqzb69UOb0GJYvOr3QEESWZJdTnn6yohroX7ExGuanI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQsvL7UHaAG4lKwhpm3cx/fEcEH7c+zaTWNBSHmsWjU=;
 b=L5034mWfnfUr+ezCQpWt1AW0nw+Kd2MH6d5VcEtY/CxtHmy6spq97sUDQvjiidqniG9unjAfX+CIVevn+DfcCrB6GB0RkhjnzhQWvNfeUJtr7Uhtxu5CR7eQJNx9J+009YYb+DauuuBFvUkuK/rREU62W7244EZAtcwqm+9iO3CtsHyUyXbJLFJ20Q1xzS/acFnJkvA9SAKrx0TXnaK/NKDUbiipmxAQ8uLk6lJkZb8n0ssad0uSmZaKbvhwvkzU9WOAjNyOIL9iUQlYD1nimPuS3TIfP/Y182lr7JljdqPAcrycYo6L8kOHPpFBAma8pVfshww3idR1UUT9CAqpPQ==
Received: from SN4PR0501CA0027.namprd05.prod.outlook.com
 (2603:10b6:803:40::40) by LV2PR12MB5773.namprd12.prod.outlook.com
 (2603:10b6:408:17b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 21:41:16 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::fb) by SN4PR0501CA0027.outlook.office365.com
 (2603:10b6:803:40::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 21:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:40:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:40:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:40:54 -0800
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
Subject: [PATCH net-next 4/8] net/mlx5e: Move IPSec policy check after decryption
Date: Thu, 20 Feb 2025 23:39:54 +0200
Message-ID: <20250220213959.504304-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220213959.504304-1-tariqt@nvidia.com>
References: <20250220213959.504304-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbfafb2-6ea6-4904-0ed4-08dd51f74e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnFLUU5xWDlHYVFweSszbllMaWZXOTYzdlpJM1psOTduUTVsNUl5ZVBmcDNL?=
 =?utf-8?B?ZmdQMUtNUE16bmF4bTUvVmtuTTloWUgvVFNCUTFrSjRpSGcyWmFhQUJFU2NO?=
 =?utf-8?B?aDdqZFNYcng1NzNya1hqZFFRdzJTODJLckppZ1Z1a05ZZE8zNndTRk0vaUpY?=
 =?utf-8?B?SU13ZGo2UUpFUkZTSWJjZUt6WUdSeHNnQ1Bja3MxWkhtRXFUTmFRTEJlc2Fu?=
 =?utf-8?B?endoSjZYd2I5VUs2cUVob1Q1WGErd3k0SnNlYmhoMXluWkR0QnZhbnBYQ1V5?=
 =?utf-8?B?RG1XUTA1ODJXRGVXTWFGdGNjWlR2N0trdGN1dWNVekJ1Q09nY0poUzBXUlk4?=
 =?utf-8?B?QnIwQ2JvSG9HM2JHRlBJTWJsSVlIczhnRWF6VjNsOG9vTjdxOHhHVGhsSmVQ?=
 =?utf-8?B?QzVzT1c2eEdBdTFNOVQ0Rit6L1p1dXNvR3pZcDYzbXJxamIwVWZWU0NMV1du?=
 =?utf-8?B?NVZCSVc4OVZaeGNrWk1nVmt3ek5PTTFLS1lMT1ZSbFlVY2d2SGhPSjk2WER6?=
 =?utf-8?B?SVJacXRUbmNlNlkrSkxEeG04eDgvaWxtSDFnUEMvSjlNSDk2NzBHMDN5b2NV?=
 =?utf-8?B?TTlUb0lDMWYwSzJxS2JDcTA4Y2txOUtnZFZVL2xvQ2hkRjZEWVI3M0h3a3FK?=
 =?utf-8?B?TWFENDhPYnJRRlB3TEdBaTI1Y25URGNqS053R2pHMU5CSm81dkdDcEp1UDhl?=
 =?utf-8?B?Nld3cGVlZ200Z2RNWjhkTGxYMytTeEdRSDVaS2tQNCtZTVRNbnZkOFZoeW0y?=
 =?utf-8?B?SGY0Tlp0TzRXMDh2SXEzVFBhTWhmSmJ3dmIrV0VkVHdtU0JVQ3EvODBpQlQw?=
 =?utf-8?B?SHNtUTdEMnlORnlJSC9MRW5CQ1lKWWlKc2FScTQvNVQwY1hnaisycmpESTh6?=
 =?utf-8?B?QmlRZWp5SVBQa2xFcXlLNHkwbGdKR1liVGNjRnpxQTZ3YVFlVkY3UmhCZlhS?=
 =?utf-8?B?aVhxRGV1OFd5TEFBd0U4Zms5enlPaXNCVlVVdDR1WkV5WFdQVndkMHQ5QWhG?=
 =?utf-8?B?L1ZaNE5vTTltZS9PVXZZRFN4WGVVVlNLbnJKMjdEQ2tyRjF6aEhDOEY3SEJW?=
 =?utf-8?B?UzM2R21NbStzQTlxSDJTejlhMnM1UndESFlUSThvUWE2eC9JYlJnMFI2MnRY?=
 =?utf-8?B?V05rZEZvUmg0VnRZbEVrV3YrLzZ2U2M4RWNGZkxhaEx6ZWRTQkNkZ3JRWmY5?=
 =?utf-8?B?UnRxU0h2T082M09mQnVneENUakJyTWhnR05LL1BGV3AvTVhpL0NPYnlkU3E3?=
 =?utf-8?B?c2VOTUN6MkRvdFQya0NHNTNXOFdDbDU3VDNnMkEzS3RBY0xtWmw3RUE3OHN6?=
 =?utf-8?B?V3RHV3RESG5iWlpBekFpbHlSdVJOMnBVMWZEa05QeGhoSVlobmlZbzMrbzJB?=
 =?utf-8?B?azRsTjFXQUJrRzZuOUtRMCtZRGJpY1Q1bkl5eUwrdUpuZG5RTWFqMnpIUnBE?=
 =?utf-8?B?T1hCNWloeGtIcDdxQ0xJaDlicjBKRGd0dUd1QlIrcUlicWZQOWdaZXZsNVlN?=
 =?utf-8?B?L2lQenVpaE1lMVpsWmJYazRZNmVqQUdDcy9rVFBNUFBpN3NrNFo0TnZpc0k4?=
 =?utf-8?B?YXdkdk5DRThtekliblQrbllLRHZGWTV5enRuRnBHWnh5M3dqUkpkRWxkTStF?=
 =?utf-8?B?TkY5UTRsOWFmZ1FIZG5FSU1uWUI5K2UveFBqbWtSUXhwUHIySVM0TlVNY3VK?=
 =?utf-8?B?a1dDNXZxYTVhRDZ2ZmhyWTJSbTBZb21MVjh0NjFkU3dieGRxWkpyZHN6TENk?=
 =?utf-8?B?djdEb2ZUM1BDem5aWk1sUDZ6d0Q1eXZmUlZZck05ZElMT2FZSStCa2hvV3Vn?=
 =?utf-8?B?S09VbmJLRDEzYk5ScmF5TWRxNHBMckptREUvSXFOQVRJbkhONzdpSUFmWk0v?=
 =?utf-8?B?K2RPaEZiSmg1bFc0L0FOb2hqS1N6cHZKVzBZU2kwazFDRnlXTVN0aC9WWDlu?=
 =?utf-8?B?S2NYVE1FSEFqbFVJSnI3TmJDVjRmTENGZ0dmZklRQUszV0R1bG5GblhBVEVl?=
 =?utf-8?Q?njz4XFYfCsvaCAeY2UqLYDN9yd8q/c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:16.4396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbfafb2-6ea6-4904-0ed4-08dd51f74e1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773

From: Jianbo Liu <jianbol@nvidia.com>

Currently, xfrm policy check is done before decryption in mlx5 driver.
If matching any policy, packets are forwarded to xfrm state table for
decryption. But this is exact opposite to what software does. For
kernel implementation, xfrm decode is unconditionally activated
whenever an IPSec packet reaches the input flow if there’s a matching
state rule.

This patch changes the order, move policy check after decryption.
Besides, a miss flow table is added at the end for legacy mode, to
make it easier to update the default destination of the steering rules.

So ESP packets are firstly forwarded to SA table for decryption, then
the result is checked in status table. If the decryption succeeds,
packets are forwarded to another table to check xfrm policy rules.
When a policy with allow action is matched, if in legacy mode packets
are forwarded to miss flow table with one rule to forward them to RoCE
tables, if in switchdev mode they are forwarded directly to TC root
chain instead.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 195 +++++++++++++-----
 .../mellanox/mlx5/core/esw/ipsec_fs.c         |   2 +-
 3 files changed, 145 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 1e8b7d330701..b5c3a2a9d2a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -84,9 +84,9 @@ enum {
 	MLX5E_ARFS_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
 #ifdef CONFIG_MLX5_EN_IPSEC
-	MLX5E_ACCEL_FS_POL_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
-	MLX5E_ACCEL_FS_ESP_FT_LEVEL,
+	MLX5E_ACCEL_FS_ESP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL,
+	MLX5E_ACCEL_FS_POL_FT_LEVEL,
 	MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL,
 #endif
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e1b518aedee8..3d9d7aa2a06a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -45,6 +45,8 @@ struct mlx5e_ipsec_rx {
 	struct mlx5e_ipsec_status_checks status_drops;
 	struct mlx5e_ipsec_fc *fc;
 	struct mlx5_fs_chains *chains;
+	struct mlx5_flow_table *pol_miss_ft;
+	struct mlx5_flow_handle *pol_miss_rule;
 	u8 allow_tunnel_mode : 1;
 };
 
@@ -156,13 +158,6 @@ static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
 					 struct mlx5e_ipsec_rx *rx)
 {
 	mlx5_del_flow_rules(rx->status.rule);
-
-	if (rx != ipsec->rx_esw)
-		return;
-
-#ifdef CONFIG_MLX5_ESWITCH
-	mlx5_chains_put_table(esw_chains(ipsec->mdev->priv.eswitch), 0, 1, 0);
-#endif
 }
 
 static void ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
@@ -415,7 +410,7 @@ static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
 	if (rx == ipsec->rx_esw)
 		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
-	flow_act.flags = FLOW_ACT_NO_APPEND;
+	flow_act.flags = FLOW_ACT_NO_APPEND | FLOW_ACT_IGNORE_FLOW_LEVEL;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	rule = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
@@ -596,13 +591,8 @@ static void ipsec_rx_ft_disconnect(struct mlx5e_ipsec *ipsec, u32 family)
 	mlx5_ttc_fwd_default_dest(ttc, family2tt(family));
 }
 
-static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
-		       struct mlx5e_ipsec_rx *rx, u32 family)
+static void ipsec_rx_policy_destroy(struct mlx5e_ipsec_rx *rx)
 {
-	/* disconnect */
-	if (rx != ipsec->rx_esw)
-		ipsec_rx_ft_disconnect(ipsec, family);
-
 	if (rx->chains) {
 		ipsec_chains_destroy(rx->chains);
 	} else {
@@ -611,6 +601,19 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		mlx5_destroy_flow_table(rx->ft.pol);
 	}
 
+	if (rx->pol_miss_rule) {
+		mlx5_del_flow_rules(rx->pol_miss_rule);
+		mlx5_destroy_flow_table(rx->pol_miss_ft);
+	}
+}
+
+static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
+		       struct mlx5e_ipsec_rx *rx, u32 family)
+{
+	/* disconnect */
+	if (rx != ipsec->rx_esw)
+		ipsec_rx_ft_disconnect(ipsec, family);
+
 	mlx5_del_flow_rules(rx->sa.rule);
 	mlx5_destroy_flow_group(rx->sa.group);
 	mlx5_destroy_flow_table(rx->ft.sa);
@@ -619,7 +622,15 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_ipsec_rx_status_destroy(ipsec, rx);
 	mlx5_destroy_flow_table(rx->ft.status);
 
+	ipsec_rx_policy_destroy(rx);
+
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, mdev);
+
+#ifdef CONFIG_MLX5_ESWITCH
+	if (rx == ipsec->rx_esw)
+		mlx5_chains_put_table(esw_chains(ipsec->mdev->priv.eswitch),
+				      0, 1, 0);
+#endif
 }
 
 static void ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
@@ -685,6 +696,14 @@ static void ipsec_rx_sa_miss_dest_get(struct mlx5e_ipsec *ipsec,
 						  family2tt(attr->family));
 }
 
+static void ipsec_rx_default_dest_get(struct mlx5e_ipsec *ipsec,
+				      struct mlx5e_ipsec_rx *rx,
+				      struct mlx5_flow_destination *dest)
+{
+	dest->type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest->ft = rx->pol_miss_ft;
+}
+
 static void ipsec_rx_ft_connect(struct mlx5e_ipsec *ipsec,
 				struct mlx5e_ipsec_rx *rx,
 				struct mlx5e_ipsec_rx_create_attr *attr)
@@ -692,10 +711,105 @@ static void ipsec_rx_ft_connect(struct mlx5e_ipsec *ipsec,
 	struct mlx5_flow_destination dest = {};
 
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest.ft = rx->ft.pol;
+	dest.ft = rx->ft.sa;
 	mlx5_ttc_fwd_dest(attr->ttc, family2tt(attr->family), &dest);
 }
 
+static int ipsec_rx_chains_create_miss(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx,
+				       struct mlx5e_ipsec_rx_create_attr *attr,
+				       struct mlx5_flow_destination *dest)
+{
+	struct mlx5_flow_table_attr ft_attr = {};
+	MLX5_DECLARE_FLOW_ACT(flow_act);
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_table *ft;
+	int err;
+
+	if (rx == ipsec->rx_esw) {
+		/* No need to create miss table for switchdev mode,
+		 * just set it to the root chain table.
+		 */
+		rx->pol_miss_ft = dest->ft;
+		return 0;
+	}
+
+	ft_attr.max_fte = 1;
+	ft_attr.autogroup.max_num_groups = 1;
+	ft_attr.level = attr->pol_level;
+	ft_attr.prio = attr->prio;
+
+	ft = mlx5_create_auto_grouped_flow_table(attr->ns, &ft_attr);
+	if (IS_ERR(ft))
+		return PTR_ERR(ft);
+
+	rule = mlx5_add_flow_rules(ft, NULL, &flow_act, dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		goto err_rule;
+	}
+
+	rx->pol_miss_ft = ft;
+	rx->pol_miss_rule = rule;
+
+	return 0;
+
+err_rule:
+	mlx5_destroy_flow_table(ft);
+	return err;
+}
+
+static int ipsec_rx_policy_create(struct mlx5e_ipsec *ipsec,
+				  struct mlx5e_ipsec_rx *rx,
+				  struct mlx5e_ipsec_rx_create_attr *attr,
+				  struct mlx5_flow_destination *dest)
+{
+	struct mlx5_flow_destination default_dest;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_table *ft;
+	int err;
+
+	err = ipsec_rx_chains_create_miss(ipsec, rx, attr, dest);
+	if (err)
+		return err;
+
+	ipsec_rx_default_dest_get(ipsec, rx, &default_dest);
+
+	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PRIO) {
+		rx->chains = ipsec_chains_create(mdev,
+						 default_dest.ft,
+						 attr->chains_ns,
+						 attr->prio,
+						 attr->sa_level,
+						 &rx->ft.pol);
+		if (IS_ERR(rx->chains))
+			err = PTR_ERR(rx->chains);
+	} else {
+		ft = ipsec_ft_create(attr->ns, attr->pol_level,
+				     attr->prio, 2, 0);
+		if (IS_ERR(ft)) {
+			err = PTR_ERR(ft);
+			goto err_out;
+		}
+		rx->ft.pol = ft;
+
+		err = ipsec_miss_create(mdev, rx->ft.pol, &rx->pol,
+					&default_dest);
+		if (err)
+			mlx5_destroy_flow_table(rx->ft.pol);
+	}
+
+	if (!err)
+		return 0;
+
+err_out:
+	if (rx->pol_miss_rule) {
+		mlx5_del_flow_rules(rx->pol_miss_rule);
+		mlx5_destroy_flow_table(rx->pol_miss_ft);
+	}
+	return err;
+}
+
 static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		     struct mlx5e_ipsec_rx *rx, u32 family)
 {
@@ -718,12 +832,6 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	}
 	rx->ft.status = ft;
 
-	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[1].counter = rx->fc->cnt;
-	err = mlx5_ipsec_rx_status_create(ipsec, rx, dest);
-	if (err)
-		goto err_add;
-
 	/* Create FT */
 	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
 		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
@@ -741,51 +849,33 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (err)
 		goto err_fs;
 
-	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PRIO) {
-		rx->chains = ipsec_chains_create(mdev, rx->ft.sa,
-						 attr.chains_ns,
-						 attr.prio,
-						 attr.pol_level,
-						 &rx->ft.pol);
-		if (IS_ERR(rx->chains)) {
-			err = PTR_ERR(rx->chains);
-			goto err_pol_ft;
-		}
-
-		goto connect;
-	}
+	err = ipsec_rx_policy_create(ipsec, rx, &attr, &dest[0]);
+	if (err)
+		goto err_policy;
 
-	ft = ipsec_ft_create(attr.ns, attr.pol_level, attr.prio, 2, 0);
-	if (IS_ERR(ft)) {
-		err = PTR_ERR(ft);
-		goto err_pol_ft;
-	}
-	rx->ft.pol = ft;
-	memset(dest, 0x00, 2 * sizeof(*dest));
 	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest[0].ft = rx->ft.sa;
-	err = ipsec_miss_create(mdev, rx->ft.pol, &rx->pol, dest);
+	dest[0].ft = rx->ft.pol;
+	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest[1].counter = rx->fc->cnt;
+	err = mlx5_ipsec_rx_status_create(ipsec, rx, dest);
 	if (err)
-		goto err_pol_miss;
+		goto err_add;
 
-connect:
 	/* connect */
 	if (rx != ipsec->rx_esw)
 		ipsec_rx_ft_connect(ipsec, rx, &attr);
 	return 0;
 
-err_pol_miss:
-	mlx5_destroy_flow_table(rx->ft.pol);
-err_pol_ft:
+err_add:
+	ipsec_rx_policy_destroy(rx);
+err_policy:
 	mlx5_del_flow_rules(rx->sa.rule);
 	mlx5_destroy_flow_group(rx->sa.group);
 err_fs:
 	mlx5_destroy_flow_table(rx->ft.sa);
-err_fs_ft:
 	if (rx->allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(mdev);
-	mlx5_ipsec_rx_status_destroy(ipsec, rx);
-err_add:
+err_fs_ft:
 	mlx5_destroy_flow_table(rx->ft.status);
 err_fs_ft_status:
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, mdev);
@@ -1957,8 +2047,7 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	flow_act.flags |= FLOW_ACT_NO_APPEND;
 	if (rx == ipsec->rx_esw && rx->chains)
 		flow_act.flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
-	dest[dstn].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest[dstn].ft = rx->ft.sa;
+	ipsec_rx_default_dest_get(ipsec, rx, &dest[dstn]);
 	dstn++;
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, dest, dstn);
 	if (IS_ERR(rule)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 4bba2884c1c0..3cfe743610d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -10,9 +10,9 @@
 #endif
 
 enum {
-	MLX5_ESW_IPSEC_RX_POL_FT_LEVEL,
 	MLX5_ESW_IPSEC_RX_ESP_FT_LEVEL,
 	MLX5_ESW_IPSEC_RX_ESP_FT_CHK_LEVEL,
+	MLX5_ESW_IPSEC_RX_POL_FT_LEVEL,
 };
 
 enum {
-- 
2.45.0


