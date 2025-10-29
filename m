Return-Path: <linux-rdma+bounces-14123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7359C1BF1F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30DE6E815D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B41350291;
	Wed, 29 Oct 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AyjsLfsb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561234EF05;
	Wed, 29 Oct 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752711; cv=fail; b=BGLZvioCMrZZMpvHAM7gnWtvUvixh89FfSkulr1uoya0gTDAfevgcdUqZkcknVDtRzoz8XJH3BRSZuhuSsuLIj3YyBkUEYXiQFwY/E6crDTHFqb2zf4SiTR1jeTza8eIVkigtmDyWiScNr28PvXWgbisBXyPzRqO3luV3bjAYSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752711; c=relaxed/simple;
	bh=RsArIT4ksTcgCO+A8E58sHMlXtYTyAYqg3gwCuZfJ6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9ldYc23kYnjsDjwE5qNJWh+4PzfpexEo3ZJSctXsVeAfVuqMQyhH/dwMgEpACxGQ8ZMtpZ4o5cIvMsRFvzhmX/HFYmOO0mw4kKbWQFsbHghYiN7J/fw4e4BbvKzJqO96ggzJl4ErkWcTyuJ0yKMfTy6BHcKPIwmRzn5YMPTGvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AyjsLfsb; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGMJ/pZunczTHPp5Zvvba8o+BOq2nOuHrV3qkC0vdMMbcbTFsvPPc8yxn5a3nkROskhTt6i+qChZrxBra3V/YGH9m+5D/ksT3OHrN3XjZpalyzDeKCliZgQJ26M7zFnNqaJBFX8XbGHC2zqExbL+KSBe13gIWQ0SR3ISLkLVULBuFhVSl1Z8lVVEGTbc8cSGd5301keXaC/6S0Xzon4GWsCipA8rjHouKGJEA67q/low3GDHOHHxgzy0wPskJUnVZeaxC/nwboL5VKy3BVwovGkpIt5ChfbnUM1C7WI1YktTQb2ebLluT7JmCrH1e7F31P0da8g3idfs/A0QEPu+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75IX1+h4KIk8ZvbqCUCBl/epj9QkpGdEFkcFZwQPGGM=;
 b=TJ0nXx1MeJYFkoCxj6s1ts2zvdcgyQW4mW2RZ+V3foIayH288AeNMC2HJnm8lVRn2YmZqQmf7m5XuqZFG5S/LmWWJ0HyzvAupYsK3l3Ldg36sP+oQDlE/tFbRKLlry54RqVd09XBfNih0iYLB9I3KIib5E4xNwDm5CbbtZ+5PzdRXSLrtDmTaM8H6JpjPw0GyOc/yv3486PZ24HgyenyDJKtStjka6BoFUxBF16Dr5p/TURibNNPA/+D06fY8UHW9jU4Axqf9PdFFTJKoqDJqBBpLVv6JQqXz0vvobNZcEUKRf8FQmx0k8XG55kJPMEoWOzZt3pODg5FssaUjBWiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75IX1+h4KIk8ZvbqCUCBl/epj9QkpGdEFkcFZwQPGGM=;
 b=AyjsLfsbg1GCD4qtPgr4kmsk9wvtPpw6YQzvvv85wjj+aDvbKkObWJv2OIor1Vdhi9+tITwfB/0MbsPnoRMeJx7nY2jjIqTuuu9mzKWo2HPXa1G1nNRZapmYb9ejlMxtrYD9HYz7S+OzvTfDj0Up0uwogYA8a/Os7eiTZ2IM/5p+uP0v1WEzTXCXz/5QC9SIU1Hpy7DSdbooHrU2b2O0jdVqfQc5ZC3w3QFASAiXIhtsF+D0ZivfKv0RKTijkFAVd3tSTvUwzQMr31zkEE2ShK/gK48WThnvDjPv2QNC1xxRGL436EgY6IXYN9TzUOB9ApK6NBIdddcg9Aieei/okg==
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:45:05 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::38) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Wed,
 29 Oct 2025 15:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:45:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 08:44:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:44:50 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:44:45 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 7/7] RDMA/mlx5: Add other eswitch support to userspace tables
Date: Wed, 29 Oct 2025 17:42:59 +0200
Message-ID: <20251029-support-other-eswitch-v1-7-98bb707b5d57@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CY3PR12MB9701:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fcb044-7129-4b69-9c48-08de17022169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME9uRVpLNmdISGZ0d0hGTGt5MFVLazJ6MUQ1ZHdUdS9aaVpTRXNqM2FTK09N?=
 =?utf-8?B?SjI2QjN6SSt3emY0cDJydFl3N2dyWE1XZXZScVNzMTFEK0JnMXc3K0trZDVU?=
 =?utf-8?B?VTVJNVVTTFlFSDFlVE4zUTVRSnBtMHB0MjRDSk1TUkwvNngzOE1rTE9KVVNs?=
 =?utf-8?B?MEIvcUFOVWZvanJ1eldjRVh0L1lUR2dmZ0RmNnF5Vm1PVkVqeG1PYnBsa1Nw?=
 =?utf-8?B?QS9DQzM5OTNZKzZoRWxmQTdsdUM4Uy9BRTdwU0EwTWQ0S3lDZnZzK3NnS05T?=
 =?utf-8?B?Rk1vaWxJbUVDcmQ3a0ZUaEU2V1lNTk1hQTl0WGFHS3ZHZmlPekEyMUxCWmhJ?=
 =?utf-8?B?MXBEeUFMQTBmcU5rRDhvaFZKZEZ5QVdXK2FoeS9xN3NBMHgvVGozaHQrODRR?=
 =?utf-8?B?ZkpzeGJPWlplWS9XMWxCOEEreDBvcG1DYU4vanBnVVZDODNUL05ZaEs5RHVw?=
 =?utf-8?B?UlZLMi9xQzBpQ0g4WVRBcVJVanBpT25ISkRNMUM1RDFRMGZ0cHdxNlZGMTdl?=
 =?utf-8?B?WE5wM1pzRWJhcEpoL21yOXkrNnJKUVI4SHFUNGxIK1MyWVo4K2lhVEFTZGRH?=
 =?utf-8?B?akl4OFBVbVBocTBqWThRQk10ZEtHQU5aUVFnZHpPQlh6UzJHck1OOTNOZXlJ?=
 =?utf-8?B?QW5XT1k2ZURjTHdFOVhWbUN6bm15Smc2YndldVpWK3lxWGUvU1l3bDBobloy?=
 =?utf-8?B?M0ZvcEdzMCswR1FQazZKNkFNSnllS2JqS1JMRHBZVVEvblVzVVB0NnlrNkZ0?=
 =?utf-8?B?NjY4MmRlL0s5Z3RWOU54TzRockhBcHRNaHVuZ1pETnZsWXdva0lSWnE5VzVJ?=
 =?utf-8?B?bG1WRm9MVWsxWFJuTzBOMVl1VlNKKy9hck5aeXpEVGZGRlhZNU44N3FvSFRy?=
 =?utf-8?B?QlFzZjhUMlBKN1lsNnE4a2NuYy9MV3BpTlZ1cmxyR2NJdDFDUlhySGVVMHlp?=
 =?utf-8?B?eTlHMTNVRnRPb3Z2bmJZaGhlUGUvYldCMmNzY09hSjZmdWp3NWZwOEkyWXJw?=
 =?utf-8?B?ZXdVbGg4alVVcE1GTGsxSTVLVndMYjRXd0l6L0k3RVJSU2FSQml1L2lnaUNJ?=
 =?utf-8?B?Z09MdWRkbXBPY1pxNE0wMSt0SWVhQmZDajY1UFl0bmVPVjF4TWNJYVBYdUVE?=
 =?utf-8?B?Nzh6d3lRNWdKaEJhVVd3SmRUM2VaSEhkM3d4WmtLdFRPdElFV0xNZkNDS2dX?=
 =?utf-8?B?OEUvQ2M2VXJldDk2NisrL3dPS2RoTk5BQkVQNFFNL003WEVkR1Q3TEsybU9Q?=
 =?utf-8?B?TUN6VncxTG1aQm1zdFZ5VHBuaUxyNjU2cFcxZlRidHFhNFRRZFM3M3RVR0FE?=
 =?utf-8?B?UXl4Z09Kekp2OUVuelZTaU94RFVtblFnZkNobkJrTW1VUDVjY3lMMmVRRTUr?=
 =?utf-8?B?bXYxbjJIMnZFaTJuaFBDd1lSUnl5d2xmTlVudTJ3bzdYRVpScjBrWlJTeC9H?=
 =?utf-8?B?bW8wdW80enhqUmlqOVJEek80L0xuR0cxdmlTenZocEo5bDBQNlV2Kzc4VkJz?=
 =?utf-8?B?TXRYQ0kvV1Vxajh1SExoTUxqSnBWbmY0bkJqbHgvUldWYjVGYktIY1NncytC?=
 =?utf-8?B?YUlZaERTS2xMbkt6WXBnTVNnT1ZjKy9OM2l1MFYzTmpmVGQwd1pWQjRYOFN2?=
 =?utf-8?B?OUR5SzNMZG5sclVOazFYMTZJRHRkakJNaVgwRyt4TmlxeU5abU5SV0xOeWhv?=
 =?utf-8?B?MUxUUERnK0VsWjJkWWV1RHVydk9wYlI3UjRuTXhQcExVczhieGJ3OGEyS1lt?=
 =?utf-8?B?QVN1c1JQTjkwc0pibUNQZUZKekxYajBSYURGenBHTlRkYi9tTnJzeCs3SGhR?=
 =?utf-8?B?RllvZkkzZVpyMGdNWGJESkdYbWcySkRqYlZwdHkvOFFtQm9rd0RGUTkrTzA3?=
 =?utf-8?B?NkJJYVRuOE9wRWNhZzdqbmpkQ2QrM2VrZW82L05nMHI3RFBhYTI2ZDM3aUgx?=
 =?utf-8?B?TjhmY003MkRLTVVnMzJQc21EUnRTTFZHSWNoT01NSkpaWEN2Sno5Q1A4T2RE?=
 =?utf-8?B?TTZIeHRUbWhPMG9rZGhJb0hsem5TWEtZZlZGazJlSlN6eU5HYnVOT2xVTUp6?=
 =?utf-8?B?ZXVpNHhuNlJOSEYxQ3NqazVhQkZ6ZjQvZ2paTzU0YnVRelhqd2NSbytxcFMv?=
 =?utf-8?Q?DBi2Do+9uqo33/sELDyZq1TxI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:45:04.9353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fcb044-7129-4b69-9c48-08de17022169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9701

From: Patrisious Haddad <phaddad@nvidia.com>

Allows the creation of RDMA TRANSPORT tables over VFs/SFs that
belong to another eswitch manager. Which is only possible for PFs that
were connected via a create_lag PRM command.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index c8a25370aa79..d17823ce7f38 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1874,7 +1874,7 @@ static int mlx5_ib_fill_transport_ns_info(struct mlx5_ib_dev *dev,
 					  u32 *flags, u16 *vport_idx,
 					  u16 *vport,
 					  struct mlx5_core_dev **ft_mdev,
-					  u32 ib_port)
+					  u32 ib_port, u16 *esw_owner_vhca_id)
 {
 	struct mlx5_core_dev *esw_mdev;
 
@@ -1888,8 +1888,13 @@ static int mlx5_ib_fill_transport_ns_info(struct mlx5_ib_dev *dev,
 		return -EINVAL;
 
 	esw_mdev = mlx5_eswitch_get_core_dev(dev->port[ib_port - 1].rep->esw);
-	if (esw_mdev != dev->mdev)
-		return -EOPNOTSUPP;
+	if (esw_mdev != dev->mdev) {
+		if (!MLX5_CAP_ADV_RDMA(dev->mdev,
+				       rdma_transport_manager_other_eswitch))
+			return -EOPNOTSUPP;
+		*flags |= MLX5_FLOW_TABLE_OTHER_ESWITCH;
+		*esw_owner_vhca_id = MLX5_CAP_GEN(esw_mdev, vhca_id);
+	}
 
 	*flags |= MLX5_FLOW_TABLE_OTHER_VPORT;
 	*ft_mdev = esw_mdev;
@@ -1908,6 +1913,7 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_namespace *ns = NULL;
 	struct mlx5_ib_flow_prio *prio = NULL;
+	u16 esw_owner_vhca_id = 0;
 	int max_table_size = 0;
 	u16 vport_idx = 0;
 	bool esw_encap;
@@ -1969,7 +1975,8 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 			return ERR_PTR(-EINVAL);
 		ret = mlx5_ib_fill_transport_ns_info(dev, ns_type, &flags,
 						     &vport_idx, &vport,
-						     &ft_mdev, ib_port);
+						     &ft_mdev, ib_port,
+						     &esw_owner_vhca_id);
 		if (ret)
 			return ERR_PTR(ret);
 
@@ -2033,6 +2040,7 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 	ft_attr.max_fte = max_table_size;
 	ft_attr.flags = flags;
 	ft_attr.vport = vport;
+	ft_attr.esw_owner_vhca_id = esw_owner_vhca_id;
 	ft_attr.autogroup.max_num_groups = MLX5_FS_MAX_TYPES;
 	return _get_prio(ns, prio, &ft_attr);
 }

-- 
2.47.1

