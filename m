Return-Path: <linux-rdma+bounces-7916-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD8A3E6D0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF2619C48D6
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8C4264631;
	Thu, 20 Feb 2025 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AAJQBof4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAF264F84;
	Thu, 20 Feb 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087682; cv=fail; b=fMzdQI2qExgYe0ZWn072ObckntLulVM9akViFFW9exMoBZejMxet4pp/lqiCm0TUvllI06IHTgsTTiGDC+21v6zBTccqAIECzZlweAYO+hu1Gw8J5PwydOghQkdPLRUifnOn9TwiP8XSvPGsCz2qqwZu6sljZXjPdWUpXJPDuYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087682; c=relaxed/simple;
	bh=QyKm1IsKsVCyshqiXw0T6lfCmWfp7Au++5VDUXpgYKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+vYiFXiEiT42MKUCMDlkFh7C9a411JqxF1hPZSsqBOMSRk+gwQbiwTl9MzTH953jle8YkUNx9wx+oe+5fW7t29Vlv0ey/EIEj+qmsXhNA1WLlJZyAfVS0o4C6iUqNki/HZpF2Ne7uVEiUhcjbc74EPKpfyRQ6np8akxt6Maa8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAJQBof4; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF136L48qzCKsnIYkUWcjlC+nUti8rmXWMQKVRLeAaORGN/1eGJjmw1Fa0sZP4ylonI/QG4N+ZOKSq1TKgu12FsnBRgxkRF1ZE80x31bvgKQLLciksN4wXAM7O21mCtMwC3jv2i3W2NFTwKj9HO2ItsKXEW7imPahZX485Fkaza52ezg3HfWhnpCpklrrqllq+vcvodIFT/MDAb3QFatrDzH3JFCdFAEEVooeQVd8D6SOlfd10wMTkFHpvTWe0iv3ciCm1DuNXEbImx6hCLVTeBZDOeQpdOdmg82l/tHe6qFRTf9rHmLDREC+yWBnMvMFnYXp97luw9myumdpPSnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlB7CJkblbu71GHl37/tYt2PEL3oFAKlAjjQ7yk7se8=;
 b=JY1GgfH5WBz80xKDiHl+xy6pmlazuIwwIha4yw7kKrYjsbFaA/hj4RGriRutEd6GKRwVIBX6Bj3saco9ZryOhmOrW6MzpYK4W998GGy9r6v2HizQw0XdNxGmfEXhGIbBTAQtvGXUiwleFfjLbjClRpE45I5NYHKRAV1nIPsTaX64QF18Sr9QXArt15pcPYAc4BGOZziqioiGvfKGZft8qbVIunpC0c8N7pkJ7fuoyhuaFR1r9f8TaURtkrMM/37FGYUB5T5nbLgVRjtBQr/6MiQoO1Dsx2UdO2NuPmCWKdWQ+fZNnTpys3AVpfXGnIXHi/5A7aOaOe6bcrmp4hjNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlB7CJkblbu71GHl37/tYt2PEL3oFAKlAjjQ7yk7se8=;
 b=AAJQBof4XJFmXVOunT4lcN3VFR6/PIU8B5Onhk00+oGCLH8W+8SSqJ1apBy0xp/+lsYo1dXXfT3kUZ7hnVzGVeKuxjGgZ8r/n2vvlFjdGAwGyue/pry2oHPt129xacz9Woz5aJ1iWo9KwCT4mC5RTWTdDrXPRflQP76aDscKKIjnVNwK+3Xe1qKZmzKNWeGXP0YZWEeMpFmCL9bachp2bK8rh6KbanA5gfy7aowB18hsAJ62t9mizbqROfCqb3jXcKDnVsliYc8Cf1vsHLporK4nN3PHV2+dYRG4X2R/yQq1BDlaXncX8eaV3vo2f7CUnU70oMbtm41dinxha7m7tg==
Received: from SN1PR12CA0065.namprd12.prod.outlook.com (2603:10b6:802:20::36)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 21:41:04 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::8c) by SN1PR12CA0065.outlook.office365.com
 (2603:10b6:802:20::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 21:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 21:41:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 13:40:46 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:40:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 13:40:42 -0800
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
Subject: [PATCH net-next 1/8] net/mlx5e: Add helper function to update IPSec default destination
Date: Thu, 20 Feb 2025 23:39:51 +0200
Message-ID: <20250220213959.504304-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf12087-7687-4ee4-3352-08dd51f745e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGtQcVJFRXc1SjI2Zk1icWtXemY2a2lmemhidWNMNFExRVc0Y0xOY1RWUExY?=
 =?utf-8?B?enBCUFl5QUFGa2JqUTlFWDV5OFdFKzd6WFpDREpLUnBXR2xlcmxxK2NrSWNW?=
 =?utf-8?B?Y2kwWTRtKzUvRytscEVkUjNFbFNKbUxCMTlib2tGaUxiWWZIZkR5aDlqRmIy?=
 =?utf-8?B?ZHpvc0I1TEdvOFFvT1FpZXdGZE1DeEFmUXJRQkZaOStHWkJqYitFcDZSeG1U?=
 =?utf-8?B?VWVUKzVoeVpoTGNDb0lxRmZyTElGV1RYTUdIQTR6ekdqRURuNTlYVFpVeHZv?=
 =?utf-8?B?YklBbHpVT253WTNvbzZ0SDY0MzlMM3JsK0JocjE1cVNnNmF2cjhad2hTcHpJ?=
 =?utf-8?B?S1NiNzNmRUU1d2I3TmgwK0p3UlJyMzU2UTNTNjZWWEJsRXp2cnRuem1sRlRJ?=
 =?utf-8?B?c0hwLzhyY0NFbzVLM3ZJdmRBenJja21aaW40WlRRTk1DRzFVdTNkdFFodlN2?=
 =?utf-8?B?TkNGcU9hTzFPUG4wU1BZc2xML3RZa1BXbS9laW5qRHBoTC9pZkp4aVgyOGsx?=
 =?utf-8?B?a3Z5aTlESFR3eFIzQ1VoYkpLTGxSTzhpdWlBQmlTaFpaT3pPcHREUm5CLzlS?=
 =?utf-8?B?QVk4dEQ2QUNkRXZLanlHR1Z4TWlYWmZUUG9TM09jVmlGZFdDRm11YkhPZFU4?=
 =?utf-8?B?MjRkc29ZdXprNVJNOHA5Nk1HU0x6Y0hmcjJJdXQ2cE84S1M0UzNiU1JuMks5?=
 =?utf-8?B?WWlmZC9hSU5NZEhNdEpHV1EzdDRrTXFMakM3a0dUZmw4RWdKQlBHZjRaVzI2?=
 =?utf-8?B?WEZrVTdRN0JieWJqQ25JTXZNU25sdU5NRDBNL3pJTGY0d1c5NTk4MDVsUVFw?=
 =?utf-8?B?b2p1N1pUam5NMkdHTUxraXE5ajBuQm5nR2JGV2NZeHN2V3M3QVJ4MUVCdzda?=
 =?utf-8?B?S1RZOVBYWDl5M2ZRakx1TjQrWFpDL1ZoYVdXOTdQK1liNlZYbTdhMklMM1Rm?=
 =?utf-8?B?NzUvbUhUU2Zjcys4eEJIYVlZRHM0Mk5DaWtGKzVMSkYyZjJIOGU3RXNuMjJM?=
 =?utf-8?B?bVlDb25IQmMxbVdpWDJaY1JhN2FJU1d4d3NTb2pxS0lCeEJrWWxrSnJTNmFi?=
 =?utf-8?B?bXNTTzhPUUZUR2dKZHd0SERHUU84M2dsV1ZoWTIzaG9WWkxnRS9EcmpzVGxp?=
 =?utf-8?B?ZTFkcHE0ekJTN0IvVmV2YTlCZHFnOWExcVpLS2t6b0l3L3pTMEFFb3RMQjV5?=
 =?utf-8?B?anV6SCs5VWREcGtOZzdjM0pmdzVjbnZNQ1JvNmlsQkRyMVpIdlBhQzVEVVJD?=
 =?utf-8?B?SDg4NzYxczd6SHZsYUhWWjg5TjBYbjRoZDhDMVN1Vlczc1ZGZC9MU2l5RWlj?=
 =?utf-8?B?S3h1R2hKZ2dHWElYQmpnVWwvR0ZVV24wb2ZnamhCSUtEa3c2eFVNUXZ6b0hh?=
 =?utf-8?B?a0djQ1N2RDVRVW5hU2RvTis3bFJCbk9LYmhDTDJabUx5Q21xK0lFdkVjU1Bo?=
 =?utf-8?B?RjFhbzU3dTNDWVVaVVJHYWhQcHM1Ykd4bHpVY3A3djZIaVlxYyt1NW5VQldx?=
 =?utf-8?B?ZFVpRFpxWVZQQndhVVNsZjA0YTZjaXVPQ3dqcWliNDE2VXVyQ0ZZRktEajQz?=
 =?utf-8?B?Nmd2MTlGdE1VblpPRkRiaGptVUdia0JFTXBBbTBtL3RSNXZGNktlZGtzYnd2?=
 =?utf-8?B?enowQnhzaG42S2JrdXQyNlNROWJnTlQxZWsyaElTUmMxYUVLZTRXN2w1Zyt6?=
 =?utf-8?B?QlRVZlo1TGJ0ajRyb2s0amhYT3YyeTBHZ1lPUGxkWS8ramVXNGdqd2I2TXdn?=
 =?utf-8?B?b2NOV3poY1pERUQ0SXQxeHdkdnhUS3RrdzI3Mld0MkVxTy8wRGhESnR3eitP?=
 =?utf-8?B?cGFQb01zR0QycGVSR3M0SFFOVXZ2a0JEeHVHMHl0OWpyWHc3dUtwY3d5K3B6?=
 =?utf-8?B?blovbmw3SHN2QXZqUi9NVGNRL1ZyS0ZNR3FuZWNPM3lUclRjUm1TZzN3dGtv?=
 =?utf-8?B?RE50ZDg3cjlva2RlR1JDTlpFdG9MUGo5RDJFWDhIbzA2UStCYzF2RVd4Z2l1?=
 =?utf-8?Q?6ngEi63WUujOQHeduWlcHA51JtHI4I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:41:02.6361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf12087-7687-4ee4-3352-08dd51f745e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

From: Jianbo Liu <jianbol@nvidia.com>

The default destination of IPSec steering rules for MPV mode will be
updated when the master device is brought up or down. Move the common
code into the helper function. It’s convenient to update destinations
in later patches.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e7b64679f121..7f82d530d3e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -493,6 +493,14 @@ static int ipsec_miss_create(struct mlx5_core_dev *mdev,
 	return err;
 }
 
+static void ipsec_rx_update_default_dest(struct mlx5e_ipsec_rx *rx,
+					 struct mlx5_flow_destination *old_dest,
+					 struct mlx5_flow_destination *new_dest)
+{
+	mlx5_modify_rule_destination(rx->status.rule, new_dest, old_dest);
+	mlx5_modify_rule_destination(rx->sa.rule, new_dest, old_dest);
+}
+
 static void handle_ipsec_rx_bringup(struct mlx5e_ipsec *ipsec, u32 family)
 {
 	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, XFRM_DEV_OFFLOAD_PACKET);
@@ -507,8 +515,7 @@ static void handle_ipsec_rx_bringup(struct mlx5e_ipsec *ipsec, u32 family)
 
 	new_dest.ft = mlx5_ipsec_fs_roce_ft_get(ipsec->roce, family);
 	new_dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	mlx5_modify_rule_destination(rx->status.rule, &new_dest, &old_dest);
-	mlx5_modify_rule_destination(rx->sa.rule, &new_dest, &old_dest);
+	ipsec_rx_update_default_dest(rx, &old_dest, &new_dest);
 }
 
 static void handle_ipsec_rx_cleanup(struct mlx5e_ipsec *ipsec, u32 family)
@@ -520,8 +527,7 @@ static void handle_ipsec_rx_cleanup(struct mlx5e_ipsec *ipsec, u32 family)
 	old_dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	new_dest = mlx5_ttc_get_default_dest(mlx5e_fs_get_ttc(ipsec->fs, false),
 					     family2tt(family));
-	mlx5_modify_rule_destination(rx->sa.rule, &new_dest, &old_dest);
-	mlx5_modify_rule_destination(rx->status.rule, &new_dest, &old_dest);
+	ipsec_rx_update_default_dest(rx, &old_dest, &new_dest);
 
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, ipsec->mdev);
 }
-- 
2.45.0


