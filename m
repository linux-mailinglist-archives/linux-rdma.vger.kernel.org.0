Return-Path: <linux-rdma+bounces-14119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905DFC1C548
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3346E253B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7316D348890;
	Wed, 29 Oct 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZZj1i3v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4C345726;
	Wed, 29 Oct 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752680; cv=fail; b=pvpbYrBMkQcMgconaZD3oCRtU2LLOrnOhuZTylneA5cdrnINCVDlDp0JsK8By7/VK2pjS0IcdTguAa/lXsBRf/AWZN+0HIk9Sm7LxJEiFPy6ioavElYd9W/ITGgueg26rmQMiTvl0vRXgC/zX5tCp1bsZdeFG7Qf14di8L84TYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752680; c=relaxed/simple;
	bh=rG9QRQp2M4q6uoYDJzAHdPgr/qd2q9tw3T1uUTJtV2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfoEoobFEy+1bXiI3sQfx6fRzrKLgeVdgiOL7YyPSKCyn94qZzgP9ZeRlJ9+ghUqR2FTQ0M/YzmMyPpqltkl1GtcfhZi6TCKKl1XvY51Dlu+Z5OU61KOxavFI8flyH1chRZPVBAeECrKfy+stHrUMX4mYOsZdvlZb/9UA5wxRt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QZZj1i3v; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGY9DysUszI6QKL9iMqYuVZuomwKfrfUj5tltqjVtp+RsGGRaEAKiftlk1jugkcgKYrmPm9ffjaRTCd4z8uqf7jpsOTk+3D0ynO9DO0lFkrc720gAmQr7pLuhNHSd72nK9RJCiDByo8aKF3+IK9whEnMkBsrDVTbhpr1GMe3+r1eX/uqhMQUC3OhtOYwIEgueVSwuDUEcQ0gEt6JirCqZJ1uEGULzJpk32XND6O/9wnZ9QFT9Mw20Ngz95ygp5hdWBrYXMU41pNlLHKOsR+mTmmbXTNHKvivFu0/10MxNUPjafXweBZ0RwT7EptQYtJha7vy5DXcoZ9sZYTD7Wwv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIiBGWu6lnYrQN01VQbs06xBDRMd7dM4HYZsRPCD9HY=;
 b=anI/qOSzh1FeQp768/8SHa55HHuDFOIVVeGIHE89+/kx/IM+beYbJmxZ5euLErYa4V6m3XTnzR8bBdNaRO80WLBdjy76dxKxgV1+dtU05/K0NxFS6r6A5JppUatYCJ1KY1NPeRAZVdsxOvFshX4uymxSmUjrZedC5rE2jDFR6rM6E+ReKEseey3InxOq16km3vkZdr1R5GxLY3vtUrL0S1WQamLAavgQIQHXtQo9fL+KKz2RJhBezjIiHLGox+Z7aAXIbpXo788nghuEyAawBAEX0TuQ9rZFhVX9ltvHmNzA8zu+c+TA2FJbT2TLAEayu14U+9rhUZpf9i6OWJ6NCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIiBGWu6lnYrQN01VQbs06xBDRMd7dM4HYZsRPCD9HY=;
 b=QZZj1i3vp0u7TiGdlUHS6OQCaTbemnaJWUEGcKIUi16gz7ifoInJ+jy5Vfu3dxu6f0t8zqMDLjFhniiC01tPxBNyzaJ8hKCEcBTFhpTTq9gIjoSPQIrTzeA6qxjlW4V4Q7wd0PJEhPjlJpBFFwaAnbq5qsMhfsvouPdZYpvGcmCUbez/Wc7pcgXMnvCi1IOuAgZhr8S4ysqUL+AlPpfdHiGOvJwDLo8iSCbJQMnIWnbz9hb8CID0MtOYeskacxklA/hjyr+YeJpZ6nUHcHoYrWDKmXb2A+DLFdxedkzP0XsNoHIbk2ERCrK6opgVkNrJeYfsE3SAQro3o4PJ/B1v8A==
Received: from BN0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:e6::23)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:44:32 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::a5) by BN0PR03CA0018.outlook.office365.com
 (2603:10b6:408:e6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 15:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:44:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 08:44:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:44:16 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:44:11 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH mlx5-next 2/7] net/mlx5: fs, Add other_eswitch support for steering tables
Date: Wed, 29 Oct 2025 17:42:54 +0200
Message-ID: <20251029-support-other-eswitch-v1-2-98bb707b5d57@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
References: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e49ee0-c531-4f14-ff8d-08de17020dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkxrMEJkUTE1N3NJaWwxaFgzWnRiSERCTWN3UlRLb1hFaWxtMHR5VnJLQnEx?=
 =?utf-8?B?QnN3dHJQL01pYnFIamNXeDg4MEMrdHg5WXNhakFIMUtaakZwa013SmQ5Q2Zv?=
 =?utf-8?B?MlkzOHlCSjVSdXRKZEk2N3ZYY3UyeUUxRWpWUXU0eC85T1Zya05kQ1FmbVpQ?=
 =?utf-8?B?YWlpYW1vdzYwQi8xcFN0WjNTTFdMc1BtSEJ2eTAxb2FIZ2tLSlgvTW80L1lW?=
 =?utf-8?B?L0xlNUhXaHJ5NVk1SU9EdWhTemhOTTVRRTZETzhacEtTbHB3RkVaSndQVGt5?=
 =?utf-8?B?OXB0RjlsL1lIYjBnU0FYUVBvQjJMRnNXbGt5UCt4ajdvb1FBNDU2dzFhWGxn?=
 =?utf-8?B?anVYOHdaZmdJdHFqaDFnM0wrcjJNcElhbDZEM2R4RE5IRkJhZU5jaUU3a0pZ?=
 =?utf-8?B?QURhVmhKZ2NRTXlOTHBPWVY4cUhubzBaWktEMlBiRU80aThmbnByaHNPL296?=
 =?utf-8?B?KzNpU2RsK3kxYTdzeDVjWlgyZHJMYmRkdmhPYWZ1RUd1cDl6M3RNVnk1SEIv?=
 =?utf-8?B?SG43UHFyZTl0elFRTis1N2xkZDNZV2g0YU5UMkZoc0tCZDBKaEU1QnI0R2Ji?=
 =?utf-8?B?YXZDQ0dyYkN3ZFpBeklqaFZBY29CZ3F6RHdhWTlpYk1sY29objFOZGNkcGdx?=
 =?utf-8?B?aWhNQ3g3dG54WlJqN0FOcERSYXJlWWNBVHU0RlBtYkRReXdqdVNyS3BZSTVC?=
 =?utf-8?B?WE1MVXhHdG83SHg5NzVYWHNtWHZ4UlJjaVE1N0JQcTJIem9sVUxteEhuVzNo?=
 =?utf-8?B?Sk5ORWU0SWxISW9tbHZCUjQ1dEsrb1JncXBDaDBSZVBneVh1RDV0YUlpcEtx?=
 =?utf-8?B?Q3pEdnYxOFBacXh0MEJTejJ4L0FPYlVLOHhxYWdUY01CcUY0L29qRHFCa2F3?=
 =?utf-8?B?UVVlaVZrb3FIM2pyR3lxZHVRS2tReEFxTURiRHFzMEl5WVdmMlNEVkIvcEpm?=
 =?utf-8?B?bzlOL3Jkem5vcStpNkRKV3dvZEYyVDlwRUVqWkh4VG9yYzZDOFZTcTNkcnRL?=
 =?utf-8?B?RTErR01uM2JzY3VNZlVFeUVMSUU2Znl2a1pwRTA4U2VidHNUMmFnT0c3MmIv?=
 =?utf-8?B?dHNoTHc1MnUreDhuMzNwaCtkeXFaOElwMUZBek5iRWQ2aFoyckpETWtJK0RS?=
 =?utf-8?B?elJUVkpVK3V1MkNwZ0lqWmlTYkVwZkp3WlpoblhCZHZpMWFvSm05WEtoeWdl?=
 =?utf-8?B?YW96YmZwTzJqWklscmhrTzJQaXMzMG8vYUJxcXpLa0hrai9zd29idnIvN2VQ?=
 =?utf-8?B?eVhvdi9sQXJYMUhFaG0yS1VJakRXQ2RXbjBiMmpSSm0yR0dOM3p3bFpLQzlN?=
 =?utf-8?B?VVRaT0JqaDI5cFNpVDJQUG5QRVhRUWdBaUswcStMbVhZTEFTSUk4Vm5iN3dW?=
 =?utf-8?B?cHNlaVFJT1JTN01iUHM1NnZlUUQyTUtjWmdhWVRiYzAvcTdtUXZqNEdtT0FE?=
 =?utf-8?B?ZjVkMDc2TkVaREtkWThiNFBiTEY4ZWFBdktlSjNodFBuN3I5eHdBMU5UTzhm?=
 =?utf-8?B?d2NkckhuMjJxcTM1RWF4WjgvMHlQdGtpOXIyT2VJT1dvVk9CRTlKem9zVkRz?=
 =?utf-8?B?UmhjYjBRSFB2R3hjWFVGbWd1eHg5cjlkU0U2aklPUmYrU2o2ckZvalhuVEJr?=
 =?utf-8?B?ZmJnTFVkTFkyeDZjNTh5QUhPWDhxWEl3aDdMRytjQkFkRFVqamRwdWhJQXdl?=
 =?utf-8?B?UGVxSkVmN0NSSmxmaTJCRXRaK0h5MnRtWjlrNk1WNU9QK0Y2WG4zUlZNeDdL?=
 =?utf-8?B?eGNacUdJSGdXMjN3U3BUbm1qalRnWm40aU1BbytBdWYzaGNxVHE3STNxMU95?=
 =?utf-8?B?d3N0SVk1dE5SSnYvYko1TFBYVkM5Y213RDRPbTIxYU5KWmFFMTltdktHLzVW?=
 =?utf-8?B?QlJ0aUxOaCtCWXp6YWk4NFZPdE9LckhHRWZWY3ZaSkZKT2JuUnNWZkc4c0tG?=
 =?utf-8?B?Wlg5QlB1YzFoM2VxR01Qbno1QUZ2Sk54ZnBQK2xVQlVibHlZcXp4WW5VM1l2?=
 =?utf-8?B?ZmRKUUthK0l6Mm9oWk8rV0lGZE4vV3BVQWQ5bC9DRDZhNERaWlNsbndMV3Jt?=
 =?utf-8?B?aGl6aG4yeUFoZnZXQTR6QWZ1dHJnTE5RU2cwbWZBNG8vS0RRNVJ2Q0dqMld5?=
 =?utf-8?Q?z12MXNcWe7fe6x2WR6hKy0c4K?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:44:31.9543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e49ee0-c531-4f14-ff8d-08de17020dc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

From: Patrisious Haddad <phaddad@nvidia.com>

Add other_eswitch support which allows flow tables creation above vports
that reside on different esw managers.

The new flag MLX5_FLOW_TABLE_OTHER_ESWITCH indicates if the
esw_owner_vhca_id attribute is supported.

Note that this is only supported if the Advanced-RDMA cap-
rdma_transport_manager_other_eswitch is set.
And it is the caller responsibility to check that.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 31 +++++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 18 ++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h |  1 +
 include/linux/mlx5/fs.h                           |  2 ++
 4 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 1af76da8b132..ced747bef641 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -239,6 +239,10 @@ static int mlx5_cmd_update_root_ft(struct mlx5_flow_root_namespace *ns,
 	MLX5_SET(set_flow_table_root_in, in, vport_number, ft->vport);
 	MLX5_SET(set_flow_table_root_in, in, other_vport,
 		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+	MLX5_SET(set_flow_table_root_in, in, eswitch_owner_vhca_id,
+		 ft->esw_owner_vhca_id);
+	MLX5_SET(set_flow_table_root_in, in, other_eswitch,
+		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 
 	err = mlx5_cmd_exec_in(dev, set_flow_table_root, in);
 	if (!err &&
@@ -302,6 +306,10 @@ static int mlx5_cmd_create_flow_table(struct mlx5_flow_root_namespace *ns,
 	MLX5_SET(create_flow_table_in, in, vport_number, ft->vport);
 	MLX5_SET(create_flow_table_in, in, other_vport,
 		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+	MLX5_SET(create_flow_table_in, in, eswitch_owner_vhca_id,
+		 ft->esw_owner_vhca_id);
+	MLX5_SET(create_flow_table_in, in, other_eswitch,
+		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 
 	MLX5_SET(create_flow_table_in, in, flow_table_context.decap_en,
 		 en_decap);
@@ -360,6 +368,10 @@ static int mlx5_cmd_destroy_flow_table(struct mlx5_flow_root_namespace *ns,
 	MLX5_SET(destroy_flow_table_in, in, vport_number, ft->vport);
 	MLX5_SET(destroy_flow_table_in, in, other_vport,
 		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+	MLX5_SET(destroy_flow_table_in, in, eswitch_owner_vhca_id,
+		 ft->esw_owner_vhca_id);
+	MLX5_SET(destroy_flow_table_in, in, other_eswitch,
+		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 
 	err = mlx5_cmd_exec_in(dev, destroy_flow_table, in);
 	if (!err)
@@ -394,6 +406,10 @@ static int mlx5_cmd_modify_flow_table(struct mlx5_flow_root_namespace *ns,
 		MLX5_SET(modify_flow_table_in, in, vport_number, ft->vport);
 		MLX5_SET(modify_flow_table_in, in, other_vport,
 			 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+		MLX5_SET(modify_flow_table_in, in, eswitch_owner_vhca_id,
+			 ft->esw_owner_vhca_id);
+		MLX5_SET(modify_flow_table_in, in, other_eswitch,
+			 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 		MLX5_SET(modify_flow_table_in, in, modify_field_select,
 			 MLX5_MODIFY_FLOW_TABLE_MISS_TABLE_ID);
 		if (next_ft) {
@@ -429,6 +445,10 @@ static int mlx5_cmd_create_flow_group(struct mlx5_flow_root_namespace *ns,
 	MLX5_SET(create_flow_group_in, in, vport_number, ft->vport);
 	MLX5_SET(create_flow_group_in, in, other_vport,
 		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+	MLX5_SET(create_flow_group_in, in, eswitch_owner_vhca_id,
+		 ft->esw_owner_vhca_id);
+	MLX5_SET(create_flow_group_in, in, other_eswitch,
+		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 	err = mlx5_cmd_exec_inout(dev, create_flow_group, in, out);
 	if (!err)
 		fg->id = MLX5_GET(create_flow_group_out, out,
@@ -451,6 +471,10 @@ static int mlx5_cmd_destroy_flow_group(struct mlx5_flow_root_namespace *ns,
 	MLX5_SET(destroy_flow_group_in, in, vport_number, ft->vport);
 	MLX5_SET(destroy_flow_group_in, in, other_vport,
 		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+	MLX5_SET(destroy_flow_group_in, in, eswitch_owner_vhca_id,
+		 ft->esw_owner_vhca_id);
+	MLX5_SET(destroy_flow_group_in, in, other_eswitch,
+		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 	return mlx5_cmd_exec_in(dev, destroy_flow_group, in);
 }
 
@@ -559,6 +583,9 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 	MLX5_SET(set_fte_in, in, vport_number, ft->vport);
 	MLX5_SET(set_fte_in, in, other_vport,
 		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+	MLX5_SET(set_fte_in, in, eswitch_owner_vhca_id, ft->esw_owner_vhca_id);
+	MLX5_SET(set_fte_in, in, other_eswitch,
+		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 
 	in_flow_context = MLX5_ADDR_OF(set_fte_in, in, flow_context);
 	MLX5_SET(flow_context, in_flow_context, group_id, group_id);
@@ -788,6 +815,10 @@ static int mlx5_cmd_delete_fte(struct mlx5_flow_root_namespace *ns,
 	MLX5_SET(delete_fte_in, in, vport_number, ft->vport);
 	MLX5_SET(delete_fte_in, in, other_vport,
 		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_VPORT));
+	MLX5_SET(delete_fte_in, in, eswitch_owner_vhca_id,
+		 ft->esw_owner_vhca_id);
+	MLX5_SET(delete_fte_in, in, other_eswitch,
+		 !!(ft->flags & MLX5_FLOW_TABLE_OTHER_ESWITCH));
 
 	return mlx5_cmd_exec_in(dev, delete_fte, in);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2db3ffb0a2b2..87e381c82ed3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -939,10 +939,10 @@ static struct mlx5_flow_group *alloc_insert_flow_group(struct mlx5_flow_table *f
 	return fg;
 }
 
-static struct mlx5_flow_table *alloc_flow_table(int level, u16 vport,
-						enum fs_flow_table_type table_type,
-						enum fs_flow_table_op_mod op_mod,
-						u32 flags)
+static struct mlx5_flow_table *
+alloc_flow_table(struct mlx5_flow_table_attr *ft_attr, u16 vport,
+		 enum fs_flow_table_type table_type,
+		 enum fs_flow_table_op_mod op_mod)
 {
 	struct mlx5_flow_table *ft;
 	int ret;
@@ -957,12 +957,13 @@ static struct mlx5_flow_table *alloc_flow_table(int level, u16 vport,
 		return ERR_PTR(ret);
 	}
 
-	ft->level = level;
+	ft->level = ft_attr->level;
 	ft->node.type = FS_TYPE_FLOW_TABLE;
 	ft->op_mod = op_mod;
 	ft->type = table_type;
 	ft->vport = vport;
-	ft->flags = flags;
+	ft->esw_owner_vhca_id = ft_attr->esw_owner_vhca_id;
+	ft->flags = ft_attr->flags;
 	INIT_LIST_HEAD(&ft->fwd_rules);
 	mutex_init(&ft->lock);
 
@@ -1370,10 +1371,7 @@ static struct mlx5_flow_table *__mlx5_create_flow_table(struct mlx5_flow_namespa
 	/* The level is related to the
 	 * priority level range.
 	 */
-	ft = alloc_flow_table(ft_attr->level,
-			      vport,
-			      root->table_type,
-			      op_mod, ft_attr->flags);
+	ft = alloc_flow_table(ft_attr, vport, root->table_type, op_mod);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto unlock_root;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 8458ce203dac..0a9a5ef34c21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -205,6 +205,7 @@ struct mlx5_flow_table {
 	};
 	u32				id;
 	u16				vport;
+	u16				esw_owner_vhca_id;
 	unsigned int			max_fte;
 	unsigned int			level;
 	enum fs_flow_table_type		type;
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 6ac76a0c3827..6325a7fa0df2 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -71,6 +71,7 @@ enum {
 	MLX5_FLOW_TABLE_UNMANAGED = BIT(3),
 	MLX5_FLOW_TABLE_OTHER_VPORT = BIT(4),
 	MLX5_FLOW_TABLE_UPLINK_VPORT = BIT(5),
+	MLX5_FLOW_TABLE_OTHER_ESWITCH = BIT(6),
 };
 
 #define LEFTOVERS_RULE_NUM	 2
@@ -208,6 +209,7 @@ struct mlx5_flow_table_attr {
 	u32 flags;
 	u16 uid;
 	u16 vport;
+	u16 esw_owner_vhca_id;
 	struct mlx5_flow_table *next_ft;
 
 	struct {

-- 
2.47.1

