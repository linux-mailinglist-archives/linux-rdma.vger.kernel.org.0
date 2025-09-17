Return-Path: <linux-rdma+bounces-13457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D9FB7F5C8
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC4C1C26B06
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFA2FFF9C;
	Wed, 17 Sep 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtOwKQVY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B229ACD1;
	Wed, 17 Sep 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115715; cv=fail; b=dURD+XstEPyVc0PrTt9log37r3LMYmOyNmY339bpcbJVzdCOsxFIoZ+7iyKrVhCf8eIKRR36+68dpNn9VtG8m+dg3mq5c0jvKkl3NOM5kVOPRfwi13ck2hgR/Dm2axk0Dn15c2cSQWYIekEl+eROWxJh6OVT5r61OCfhMocAitE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115715; c=relaxed/simple;
	bh=5sxgxzM4drHRAnK7nMS2yTx3iUztGpAe45tnI4KJfM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaR0pMRkHmnrFa6ExGDpqOqCxpzbqiIIIXCbE2jfey7R8ye/PauEBH2FpogdUMWpBvSy78use4kx/JIRdRU/lDe9xhrCrvqow+pIY4NgRcjLkHuvNdLq90XZMaqCNlTt0+dFWLt2dFMT45w2ATAEZgoNvUIm4uWlVwRa5rK2t2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UtOwKQVY; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZUNNmJ84jAdly4ffQw+MEeNwMkP0Ggo13ktCoywm6zlECEOMPl/Y9pI7GevYbaIACDhsihDYi3thNeb5gyLB8DQcUZLVlYlFk6aqdYg+vT42HeHHCgiLmB41uet8F2/bxt5srqeTaQ2ckFS5C+IwwjRiVv8qtHp9vR70wrabCyb60A/Eh+3fSSRUy5Jm9CWHzAHu4ipIlcfaUd/aBHcft8WHPxfcQs5ocnmlrUa/FoGSzl8ZUE2OWziB6wgsvnuyLQZ9M4iMmGaiSd9fF1AXiHL9Ijasl6tGF/Gw/WrHVCALReB5KU2eRNk6Zu9EeOmoMlNbzb3IvAhvM5HdY1x4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzlm+SpWkniIJCrg3tut3iZYX+LXqgInWtrEGlP+fVo=;
 b=i8gYBnFiJJPiP4oqQtOy5i8MmAmdSH0OYfDUWD7rM1VQqIyuBa1gpXWlWJM8zFHgp1FKbXyw+p5SOBDE6Twc+ik3YACTVFQEqD2nXCyz937wbEKPGSMBas02FPDFupn9XsKliakeooCg+wxxRAw9lBbweodyCFCZHErifkXCMyPFY4W6WTX2wcvC4tKHbbgC+fj88mCL8N04CskFxQ7eQ3Im9Pc+VxsWoAECVYdXadofuNuf8MNzZpLaj1NFneM7Mouq/KWujzuEZKe6Mbu+4hpD183GkQBVqKzbAmIRPet4EZNngUKk1ift2TmTlHAEPcj30A332CiRu1vbIQiPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzlm+SpWkniIJCrg3tut3iZYX+LXqgInWtrEGlP+fVo=;
 b=UtOwKQVY73CWIpx1wPJypBZWhR7frKxxlY9nd9bc3femULn2yWLtDPLnJIZfQGZ7WkVySh5vCp1AJ8cdc3kuNMcj5nbk/uxNbYfeGa0YJtg+8NAvhhFwQoeVWQF+lMuj//ri2BSs8e7VNn1KuWmvtiz/57sDkxc7eUyERv20mBJRdo+oOgvetUp9u3bzSfF8B4M2YS4b+GiQ/85fDo/l73UOkp3ModHUDHYnrmYI+xPlJgTSY2ucKHF5MFLyrAOiuqmkimT1kQ6r8Lpzw2xjCgOpAFNC8ud3hszD5kjtdyxQxa2T/5s4UdPV0lNvQGG+JheXkmEm87Jg5ZzVkp3jrg==
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 13:28:30 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::78) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 13:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 13:28:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 06:28:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 17 Sep 2025 06:28:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 06:28:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Akiva Goldberger
	<agoldberger@nvidia.com>
Subject: [PATCH mlx5-next] net/mlx5: Add uar access and odp page fault counters
Date: Wed, 17 Sep 2025 16:27:58 +0300
Message-ID: <1758115678-643464-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b358bdd-99f2-48ae-347f-08ddf5ee1781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1j19e7WmiBP541KKNUFPuIfBqFdQ+w3Lx5/4DlJYsp4+RChbiUVyv4H08Lwm?=
 =?us-ascii?Q?H5eSWaaxo9uT7oiS6KVdS9cOymlfQx/mylwGpJDl7CGSyGn7/JvI2YsO+VeK?=
 =?us-ascii?Q?K20nOciyu4zl1m6Xw/7N7Q6jTvgntM3JUHWBNbEBIZsV/E8vdqWBw512KdF3?=
 =?us-ascii?Q?mRKQ+XN9/nfKQZHAS5WSO+v7dTSimvxV4JGd3hwO98lSRZ8/pT6ImOihZMGK?=
 =?us-ascii?Q?kvUPj+gnHnA7dQojV4IOmAruiD/zGiFeLQC9JZgZrjKYdCfTnBkOHWl6/4Mo?=
 =?us-ascii?Q?J3GZk1o+b4Ci5zKlBFDQMVVZzWNk/Gpgmu9Lu2/4XykDV847Fp3Xn0b5OVJO?=
 =?us-ascii?Q?/UmBrEFIHryUe+FyHKEs/H60YOrhJpiaBuryO5z+9ZrSWiUmVO1U4JQfb7Lj?=
 =?us-ascii?Q?pJao5SnG3p4kFiWCv5/+bHpxMIGZmnF0DwHf6o/M08WlJ2tbiqdenEsIFReK?=
 =?us-ascii?Q?xEJKOzB8BXbaACpqw/cY7TrKim66bkY7nyk8WQtZSSrBd1gMQbGXkHopQWE4?=
 =?us-ascii?Q?PyKo6k7AKyvV117yN/xhVLwA7Q0I5V43gfuwWxXn50c6SnFiivLx+F1dGgDj?=
 =?us-ascii?Q?Ato0x1Xmlb3cceATPB1gy+YZJe2o9nIJmLJOLOWNUmtVngLZBxI9dVSlkfNr?=
 =?us-ascii?Q?jSebmGIXPKcFHXWD60VUNk6gxnHDv/d9KtOPELCSgBwseARWDmurF4KWWULf?=
 =?us-ascii?Q?55hupz2mLcp86F7xz8r+kra9AcYvu099O8azisdeukhvsQEw9HY3Mke2hWS8?=
 =?us-ascii?Q?Kw+NIfAiwV81hb/Mmcy1L4flOJAiggZHPXxnyhl9nMAvLqduqXnbamN+W7KI?=
 =?us-ascii?Q?du5isG7r4o92zPVK8DXiD6QW4+xiYqXDJLerXffSNcXzaF33+bNgUVWjPztO?=
 =?us-ascii?Q?i54YueO4uOC6jsO251+ciMIN9DGclVJQ8DC+XPCc+/DMX6FhxxbHO+KJ+C/B?=
 =?us-ascii?Q?4vrI1A3+jm8uPWrXa5d/EUOyF7kdK97fL124e4fvC63b9gzOlCP/yvxsRv7X?=
 =?us-ascii?Q?/rfCKeooiIiIMOA5vvhCTBF+mlfEYsp0+JW/EXQ7dE0sKFo2V1rLD1NvZA84?=
 =?us-ascii?Q?8eXPz80UeJdr5CZBtjegwK5PhzhMl9iUTYBpq5Jl0NQL0LQjuyyU1xssuoHT?=
 =?us-ascii?Q?6ogBdmlXbk/CBEHIRQvAOCTH/8iyz0JhAAt1CffgWWVMQCsAcgoGe2BHuZqB?=
 =?us-ascii?Q?07TweenwZKqNaI3ElyjGyQ8SPw1ENkULUtJ/LzyroD3Z9YUtQYcPHPnp89Ii?=
 =?us-ascii?Q?pukEbzvQQTJqgfe2gUgGGmJHEDbF1nPYF9/DWGbqwG2FqICbJL8/DywPrSkr?=
 =?us-ascii?Q?aZCu/jHK2VExsBQ5oDu7vf1N27iCPUtgZ16Ke2BlVLP8JgnG7vo5/JFIxqCK?=
 =?us-ascii?Q?tdBRvDNz+u2C2QU7UxrCORnR/bBIyDcFoz1zoC5ktHC/T6sUfPHMy/dejbB3?=
 =?us-ascii?Q?ijG3QDWaKthwgmfS9881ZEghYZYMGzHq+jQo8EimsFFHlSGd8i8U6DNDo7es?=
 =?us-ascii?Q?KUKkgvXJzLHkAi4nAgkBHZjnGtBQSVbhKlAR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:28:30.1669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b358bdd-99f2-48ae-347f-08ddf5ee1781
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

From: Akiva Goldberger <agoldberger@nvidia.com>

Add bar_uar_access, odp_local_triggered_page_fault, and
odp_remote_triggered_page_fault counters to the query_vnic_env command.
Additionally, add corresponding capabilities bits to the HCA CAP.

Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 097b1b7ada63..0cf187e13def 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1958,7 +1958,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         log_max_rqt[0x5];
 	u8         reserved_at_390[0x3];
 	u8         log_max_rqt_size[0x5];
-	u8         reserved_at_398[0x3];
+	u8         reserved_at_398[0x1];
+	u8	   vnic_env_cnt_bar_uar_access[0x1];
+	u8	   vnic_env_cnt_odp_page_fault[0x1];
 	u8         log_max_tis_per_sq[0x5];
 
 	u8         ext_stride_num_range[0x1];
@@ -4019,7 +4021,13 @@ struct mlx5_ifc_vnic_diagnostic_statistics_bits {
 
 	u8         handled_pkt_steering_fail[0x40];
 
-	u8         reserved_at_360[0xc80];
+	u8         bar_uar_access[0x20];
+
+	u8         odp_local_triggered_page_fault[0x20];
+
+	u8         odp_remote_triggered_page_fault[0x20];
+
+	u8         reserved_at_3c0[0xc20];
 };
 
 struct mlx5_ifc_traffic_counter_bits {

base-commit: 2ac207381c37eebc49559634ce5642119784bc7c
-- 
2.31.1


