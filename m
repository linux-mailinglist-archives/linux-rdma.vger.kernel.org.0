Return-Path: <linux-rdma+bounces-14122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2864C1C64D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 18:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54556E7C16
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486534DCF4;
	Wed, 29 Oct 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FlDd2iuS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE434DCE0;
	Wed, 29 Oct 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752709; cv=fail; b=fyxoPh10D13O127gOdNWStXjnVEk+jbaSEZnTYF8pBJVD4Om8cfgOJOgA1BkzOt5BwNfJBatnjGkxpjsHtkPDYI7uiMQWUHKuoYW71Ms6OkOHmSH0qGlDHPqI78WjxLuMozl6vypBG77l/iRyJEUi+6DYPQRV58MloKSBY3j2cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752709; c=relaxed/simple;
	bh=jve5uFoKYmSod6hqV2enw6JoupD9H4f+nH0C11DD1CE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atOZsR6oYJWRTHuvJqu+MCTUB9W+Nz0gyt7tb4fdK7PleJR+FTOBeo7D6uDEb1M3OhvtbhK8rdcg3/Llv+OIRn9OKk1trhDgWzJNboBPsJe1ejXcdrcB7dED1SnLf82Unyz9GQZ564ffKBouPfxjosVwiQyIrVwUDiKEC+HnOKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FlDd2iuS; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK0Lz5mNY3i4Se56OKRF0ggbGyC5hciRkAgfioKiwjkdmNYojtGdZyn8yk4TJJrWMJbKTIc3vFSXmSRoOLGXive6pRDEYkrZjyiPzwozwQTdBC4s2LZ62uKxrRKIdJdwZCFa4SDEHb2mcq64yA9tJxkgFb4MhdhgFe4dANwUyhqAweNB6Zzm8+nvRI0NASPoNacMdWJVBLZN3bCkQFGtgW24vZhLa02LQw2OPXYOPhuklti9VBiNaQcD/lykhfYUFJCiLQUhNj2lfzIMcfECcN7hcORMci0CIRU3FsI/T3u5SNA7cmh0UGkd21kMuwv9xIBIHYwowN2gfPgSza76NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSj2i8M+2/CnPSOSvEDiBFdk5NmVf4GlOUWi3gJnyI8=;
 b=eI7BRxwzej3vorGoPyt6G9dJWNoTNG2sAmpFyf3C+i9w4SG3YkhEHYpHQAK7KCgg/AnxqQPpclJ4L2zsbB02YZS4QWGOtFcU7k2ym0IE1igiUzFri+tJHN20BGKDCnmKT1QT8noZUR0g4cg/f+mpHECtqqSMG0h+4H3wDRkpX3Ks/fqks+As77PFZXVP8eudl8eIH5Z3kQkaa94NlIp2HOi4FG99pcXdSKqo1BsxAB2a6m3DlTz8cdBt1fnUa2J1qxofzILHQGi7TBiVCsLVbpGLJ8PZ6w0JGE92E3RlnrfPLtVVZI1g1XCyfv5saRusxewZhfZxrNnjOfLja+Qb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSj2i8M+2/CnPSOSvEDiBFdk5NmVf4GlOUWi3gJnyI8=;
 b=FlDd2iuSY/arUdJBAYYnIylDuLhmSToMoxq9a457jTIpCE7Fu8yqYHwbPde/WGUigs2kugUCGIoJ9rPb7JxasmEFzwhCJIRdtK9KdjdbhLKVmwXA4O0gUsPm+E3CcpkS8OxxdQqJOZnZPUE5TSDN1DndtvAQr/kWv2MM8s5U4zhHpkuFFmpOB46rBtw8OXrIcEU09lBb2Hl8eBHXhpNwb7LoO1+eq341mH+xKAtcIjWD30U2z2GiHx6Puj6WgUYKWqxRdDL/vQLLkLw7nzvJvxGeFKOnlm3wcZx98RCUrxBAY+9Ypc2u8qe2jRkapuVpOyXB1oNwtau5X6cEM5Hn2Q==
Received: from BL1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:208:256::29)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 15:44:58 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::5e) by BL1PR13CA0024.outlook.office365.com
 (2603:10b6:208:256::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Wed,
 29 Oct 2025 15:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:44:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 29 Oct
 2025 08:44:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:44:37 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:44:31 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 5/7] RDMA/mlx5: Add other_eswitch support for devx destruction
Date: Wed, 29 Oct 2025 17:42:57 +0200
Message-ID: <20251029-support-other-eswitch-v1-5-98bb707b5d57@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee9b649-02d2-44ff-c720-08de17021d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdKS3dzalFpVGxoR3FuYWZRNGRoNzdiUUp4R3F3QzhKZlhLRkRvbFI0Z1l3?=
 =?utf-8?B?QnB4VG9tYnNwUGo3KzI2SFZCbHR0bFZ2cmdTMVpFd1JMNDU2NjlWVkkwUTVW?=
 =?utf-8?B?OGVPNW1SNHlRVXMzOUZXc1IvNllNTUViVjhVbEZrZldQVHpNOXFpYmhkTVNj?=
 =?utf-8?B?NHh2bVJYZ1RYZkFPR3o3UTk5NTNlRDk3OGZPR2Vha0Zva25oaTRkOW9ROFFJ?=
 =?utf-8?B?OUFsbytGNzl0dUVsNzlraTdSRVZlYUd2TkdMMFAxd2xhWHlBSjlOQ1lrWFo0?=
 =?utf-8?B?WG1oZ0l1Um1kUWY3SE9sYmUveDBrN2xTL2E1T05GVUJlVm9JWElHZDRDQS9J?=
 =?utf-8?B?bnlDQ3hGczRVaHVsYUMrajA5MWFwb2F3VmhDUy9iazBVbFRjVzU2dFl2UFBz?=
 =?utf-8?B?cWdjQWliajhxYVR2eURsQnA2bGh2SE1kZjI2NjdOS0VyR1RRdEZ5LzU3TWZi?=
 =?utf-8?B?WUxxMEJCbnZLeUlLV2RVRGVxSlBSVzB4QlhTT2tHT3REMk1xS0FiT3I1NnpE?=
 =?utf-8?B?bUVXblp1UDRoK2FWTks3QlFaZzZNelErcytSMWE3S01nRUZXdDlSRzVQejQy?=
 =?utf-8?B?RXNCTG9QNXpSbkc1RU84M3ZUWmxXVEJUaHJQUitTWHJDYmNLNkF3REh2UzRv?=
 =?utf-8?B?ZEZVWjA2ZEFsQ2crNGtuL0FBaHZ2UGZ3TFJwQnRJQVlkYlNqUWpDRktyRmVN?=
 =?utf-8?B?aVhlM0l3UWVwQThnZDJ4VGlHTldnRTVscjBEbWRueFBFTTlOMlp4QnhPRHhU?=
 =?utf-8?B?VXdhK3IvdkNGVzE1a1lkT1ZaVDVOTjNvRU9hQjRGNEl5MjE1cmVhNExBMDhU?=
 =?utf-8?B?VlluMVhJMkl0RmhaaDVNM3pWUmtJYVlBVVB4WnRZajQ2cDdESHpkYm16aTFp?=
 =?utf-8?B?b1I4N0ZFKzI2bllUTWFzaWZnN1p5UUxwWU5STzM2Slpoa0xEYWRNWWdUZ3Jl?=
 =?utf-8?B?c3JCTGs3Y3psSWR4VlFrS3ZZZUZFYllBTnlvYW9SdjZSU09mWkRNWklzYnBK?=
 =?utf-8?B?OGFwRGNKUVdKSkNKRExCTGJmNE1YalppM29ETStTeWdPekgyZ2FPVm9kRXhC?=
 =?utf-8?B?SUNpZjAzbEp2a0FTZ2VSNHR6TlFVVzhMZGQ3anRXVDBDamFWTURZTWJiaC9O?=
 =?utf-8?B?MnNBSjBLM3pxd1lVb3lBM283Qm5UcGd1ZWliYlpCZWhLeW5mQ1Y0Um1pU29V?=
 =?utf-8?B?K2lPMzdzMy9QeFFiVDhmMDlLUDNIRmorN0xhRlQ2cmRQVEM2Vk9IYXFPUUFY?=
 =?utf-8?B?U0ZlZWs0dG04VjRTWUpMQ2ZEWWNxMFdDOFFHTG1FK3lDamhnd2Qza3dKN1ZS?=
 =?utf-8?B?UWdhaEF3U295a284SWJTbENSdVZBY3AzcWVNQmducU9LckdPYVVMZm9WcG13?=
 =?utf-8?B?SzNQVzlTUTI2alNYU3NvY1d3ZkNxckY5cFluODAvOXZMZ2lvYkpDTnE4bGZj?=
 =?utf-8?B?YmRwWHVmK1M2ck1KdE9vU245VmNvaEpzRDZtK0xPOS8yMGlpbnlEV2FUbGFz?=
 =?utf-8?B?WlZCL0k0dlFQUy9NdDNiN0REUWRVUFFZajBKWFhzNTlkWW9NUUtLd0lFcmR2?=
 =?utf-8?B?MGZ3S01YWUdYU0pvV0xmcmhxMTdpMDJZWVowL1RIYm5MaElqbGo3K1NuN2xm?=
 =?utf-8?B?blJBeDdSNjNqdmlUZFc0N3A3MklBYXFIaVhFNmJmb0pnMmRvN1lMaW04MXpM?=
 =?utf-8?B?RVJTNitac0xyTjJWeDN3U1duSW5jb291NS9CU0FDeTYvRTNxak44a3JzQkhN?=
 =?utf-8?B?TXBXRWNhalRINzhOdi9uY0grZ0p4Wmd1M2o3dGEzMUE3bWxDYTFFSmxZRkdt?=
 =?utf-8?B?M3I2SDIzaHhuUnZXWGttdmtxWlJXMURxcXhnTTdUaWtJQ0hDYkxHWXdHR0VI?=
 =?utf-8?B?QXNFaHFMYlR0UEhIU3VIcmdhTnJYVHRDUXZRcHR0MjExRTVwWHJyb0xIUHpu?=
 =?utf-8?B?NU5LRjg3RjVaeGJWVm8yT3U0UlJHR0tvUHRWMEw4Q2dGTGFwaVZtbi9sRUJS?=
 =?utf-8?B?OFluZzdQQjdkSkIxUHdtb3dKVGUxMnhLcUdWYkJOS0FXRi94ZjROalpKR2FW?=
 =?utf-8?B?UXdycko4aWhQcTd4czMyTkhDVnc0LzYyeXA0dXA5T1BDM3ordFhJUS9KVTlX?=
 =?utf-8?Q?1dqQdEUV/V3tmJBJBU4C8Hiyk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:44:58.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee9b649-02d2-44ff-c720-08de17021d67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

From: Patrisious Haddad <phaddad@nvidia.com>

When building a devx object destruction command for steering objects add
consideration for other_eswitch argument to allow proper destruction for
objects that were created with it.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 8b506417ad2f..d31d7f3005c6 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1225,6 +1225,11 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 			 MLX5_GET(create_flow_table_in,  in, other_vport));
 		MLX5_SET(destroy_flow_table_in, din, vport_number,
 			 MLX5_GET(create_flow_table_in,  in, vport_number));
+		MLX5_SET(destroy_flow_table_in, din, other_eswitch,
+			 MLX5_GET(create_flow_table_in,  in, other_eswitch));
+		MLX5_SET(destroy_flow_table_in, din, eswitch_owner_vhca_id,
+			 MLX5_GET(create_flow_table_in, in,
+				  eswitch_owner_vhca_id));
 		MLX5_SET(destroy_flow_table_in, din, table_type,
 			 MLX5_GET(create_flow_table_in,  in, table_type));
 		MLX5_SET(destroy_flow_table_in, din, table_id, *obj_id);
@@ -1237,6 +1242,11 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 			 MLX5_GET(create_flow_group_in, in, other_vport));
 		MLX5_SET(destroy_flow_group_in, din, vport_number,
 			 MLX5_GET(create_flow_group_in, in, vport_number));
+		MLX5_SET(destroy_flow_group_in, din, other_eswitch,
+			 MLX5_GET(create_flow_group_in, in, other_eswitch));
+		MLX5_SET(destroy_flow_group_in, din, eswitch_owner_vhca_id,
+			 MLX5_GET(create_flow_group_in, in,
+				  eswitch_owner_vhca_id));
 		MLX5_SET(destroy_flow_group_in, din, table_type,
 			 MLX5_GET(create_flow_group_in, in, table_type));
 		MLX5_SET(destroy_flow_group_in, din, table_id,
@@ -1251,6 +1261,10 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 			 MLX5_GET(set_fte_in,  in, other_vport));
 		MLX5_SET(delete_fte_in, din, vport_number,
 			 MLX5_GET(set_fte_in, in, vport_number));
+		MLX5_SET(delete_fte_in, din, other_eswitch,
+			 MLX5_GET(set_fte_in,  in, other_eswitch));
+		MLX5_SET(delete_fte_in, din, eswitch_owner_vhca_id,
+			 MLX5_GET(set_fte_in, in, eswitch_owner_vhca_id));
 		MLX5_SET(delete_fte_in, din, table_type,
 			 MLX5_GET(set_fte_in, in, table_type));
 		MLX5_SET(delete_fte_in, din, table_id,

-- 
2.47.1

