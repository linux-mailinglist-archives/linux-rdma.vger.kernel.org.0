Return-Path: <linux-rdma+bounces-12396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB587B0DE9D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5E1C86382
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F128C5D5;
	Tue, 22 Jul 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDJ40aTf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2828C2C4;
	Tue, 22 Jul 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194287; cv=fail; b=a3aNrKnjsmQIDi4uCFTQzvS3E9IunD7hQTWmB2O8oZgSF8fbTr9Q978nz4Q2zT/ZIKIsXglabYR7idzAbmc4jrVB+OzMnvwHtJgsEFsi/Z+BuSmIrWO9L9lzd9+uLyOQo38LLpa4s6KlPQITN985CZiB5zU48/K8u6zXWUBmv+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194287; c=relaxed/simple;
	bh=TJccO/jSBGTmUnNR8Vi/rSyh/pIRh+e5/ij2IP2/Pks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKp/2RV9xJkLoFlfSo//HIDrtFQiJ3Xcduklmyg6OczYgtOH5nb3A+FaWh8Jl+vEc9npKARTwyHnXG0O44xcNEEg1k9N+pdbJxb78jBWBKhqWU+JR9084gImHHZ1DHJ4hnSXdlwnbliGfJT96inogMr9GyM7qthk2u2lQ43ttOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDJ40aTf; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPMBkfXAqcIeaSlU3kyjCwGW9Fdjqt9W8dhS72rjvhN3JVR9IEwhNLJgb5Fj8rq9N6pUdn9LCS4H2g0daOXmqVOFRcgq0jZHHqt1H7a+N+FxDn+AcdRms9tD746qMRGSkD3Hn2aIbUt7qCoLAgPx5el1xQwb/whZf1Z3EAUrUJYMjlrg+VEzeSW5/KUS+iAoxMbN790V7GVhORHJOdjFt/3a1w9j6HlZHjT2mgPPc0m+H/xjVfTr9tO+f2CpY/+Mqchiv3BTVjfBLobq3jHD0SbmSYOkJR9TCryVRfQqw2A4iQ979widEXVTDMwdhe581lybetemYz+nVhP6OOedAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCMjTO/XnrMam6OspOQ4i9ACFILSLvP6WMpsPzskZr0=;
 b=KNLNJYjJ8pVV/VN8KXorbNdBhhnI8HbHzFIz6O2oKE35MV8AXBmfzhRPSbNF6/GqUyEWCciWOHJ3sy/7Cc5CJTuARfLG4flW0/N55ylpbIYYTmtXyaF/IE/JyqH+EtO/dKv86SZaZHPFu+WkoYyrmH1aHJbs1m3w8qcbyCHTuePi1HfICDIoBgchlXGkhkZRHhz1BnmDzN0inw172epr1ZHks41QFf+M5WGy8GCqI3ndXxAChteO6hi48mjfzjbH1CVnr+dwt42HbhZgn29syGP/r8FLH7CKyxp5pNgDjLvx8QNZmy4Mz6nQ3JlN8puPv0F2bRfeXZd6WxW29XUp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCMjTO/XnrMam6OspOQ4i9ACFILSLvP6WMpsPzskZr0=;
 b=tDJ40aTfQhcn2ubzoXqOYJ/b6AntFghdLJnLUTovZqoDtDqdRFNbo63ysJrWzMDOsrPL4im4J3Cpbp5bpV5waFV9T74X2HldW3z5O7pCX1ViVzjY5J1mZABFU469OC4Kx/OunZZ4/tAIbYamUQMF5uUQGbvVx7I3WAgcg7F5+/pKMrp45aSxis6rOUb9IK0gVFmXZ33qlLBMBf36RLY7015//3QdZpmu8QiwEuyPO9u31+JFAOnO5rFmo3a3mS0oRbEINrEjPlcO+6oxXBwQeOUAzlPF5KN6/DGm9ivmJ5pPglGSmB8zMXli7VOcreL+7wAbI6O+dmT7g9IEmYzHzg==
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:24:43 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::1c) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 14:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 14:24:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 07:24:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 07:24:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 07:24:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Feng Liu <feliu@nvidia.com>
Subject: [PATCH net-next V2 2/2] net/mlx5e: Expose TIS via devlink tx reporter diagnose
Date: Tue, 22 Jul 2025 17:23:48 +0300
Message-ID: <1753194228-333722-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
References: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ffe2e1-c00b-436e-0bcf-08ddc92b7fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGpsi+eK0RP+2m6ddQJBCYl76noQDdCWW6VZ0cfd9JCR9U3j3/1wg873gfon?=
 =?us-ascii?Q?qpZB9rre5uHClsaoAHwetZ1qA4dqQDfjDPAuRczlcS5p9Fmcn/G85QLfuC05?=
 =?us-ascii?Q?ypy3Rt14lZSSaoET4zTlP6bf1feHlNN07aWjNgB8T4uKj8NRfmYGXoEksI7N?=
 =?us-ascii?Q?Szm1WEIiNRohCHIU0olMUDCnrzAss/uGJS3eSU9YXZ/XOt4nppRRYFqyuSuu?=
 =?us-ascii?Q?zIjLVlKlpkfTsAx0PIEdfR9MTEqxTgLx8+Neaa5GSmhyTu2rfrhqQkJc+t1k?=
 =?us-ascii?Q?jwCYAeASvTGBIgda3i/1luuSqDoVS9lDYeGsL1pmZPjRVh1SW0kU1p4Ii8eB?=
 =?us-ascii?Q?txuvSLryUmcc2KSRlpYfXfTh/mZoEDnsGyYLI/+CL49HqJOi+FmzT2OxCdIg?=
 =?us-ascii?Q?PN6NZTw8RZEhud1g5Gn6PTpfLp7D9XV5ivUdSX7zILGrR+d0u445BCCcFt5d?=
 =?us-ascii?Q?q3M5DiTPBr4IcA1LE7MnCMbrH1BXWQY+nlRUMmIpf//j7qvgQ8fzmSSxob/Q?=
 =?us-ascii?Q?YYyDX7xN1HpFzxNs2jUtFyHPgU+a8YH5Fk4SaX8WIA77W/x205HmIvPw9p8y?=
 =?us-ascii?Q?G9wbr40434hweetdeXRiCaNIKsZUzTgi2lYlIHN18/lxdJh776wNdTTKGGCa?=
 =?us-ascii?Q?++iDeYGzH5E8/kqywnNiAzPiKD08DOVAHISla33pkFLNOV30x+d6YLwq1ZVT?=
 =?us-ascii?Q?Vp+gKWH16Td7xasUi14LSe/Ah7erC0MIiO4joWyNtt/OAeaG78EctmwhGuwH?=
 =?us-ascii?Q?PSGmkF3/cdZXd1TDEcmWBUfKchLT0Y8x2gUxdysVABvApY675MnmXXMVCgHZ?=
 =?us-ascii?Q?yzsrVfVBzNooLRE/GYz2Qc8gcdbfL4kvtBAMfyxOV4AwE+pMrrMyo5dg/gFg?=
 =?us-ascii?Q?t0fOoPTGw2xITbmKqATSVfdKLJwzTj5nCWl5WdvSfaaWeUx467urFmduWSQr?=
 =?us-ascii?Q?5J4gnCBkKu1nz8nvCM7ZY5+JJXi39IX4CauvzugA7UnZNhYNSYS6KA9CDSLx?=
 =?us-ascii?Q?CNdzyANqEfAlXappVWMH7s02xrKFCPBnAVEaTUd0O5Tq4tGo7KpiwO5vvgNe?=
 =?us-ascii?Q?wGiIVUhzVnmn3lxxCIzt9UPxJweXXkPNPasymyDO+9ecfqKHk8dI5WqBwKUD?=
 =?us-ascii?Q?n+Hp8lmr4sJbE17qQGjcZkjukIIpVjd3HQ2K+zvks992NtnU41QDZ+MVdFiv?=
 =?us-ascii?Q?LmsMCci7L0a1Pf6Ajeu+8ZMRN73NZfh4AoiDTgDZwnd3zj30TDRsyByXuUTu?=
 =?us-ascii?Q?4L1Ft7Qy8rauUN5J7lWATE2oJAsvcMSgUmDk9V8AGVOfMwRa3zcRoVRAAug0?=
 =?us-ascii?Q?CUJXil2Pc5UjXFN3CkTOAoTSAIAwQqCKDrmHmFiheBLpIqRZOgtMmgv/3lx4?=
 =?us-ascii?Q?UVj8righif6g46QBWfo8l7RxNVZmnF5L5hJ72uiB5dVHTkypkPqoAoIkYXKd?=
 =?us-ascii?Q?p6BwE6Hd1NAI5BmUb+rzNMQJJnwQwSs6uPrQDObxeCHBdhHWlIOWYAab3R94?=
 =?us-ascii?Q?dvNZWhNJbVtA66qPIIijOiroZRV189gSInlQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:24:42.1087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ffe2e1-c00b-436e-0bcf-08ddc92b7fd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

From: Feng Liu <feliu@nvidia.com>

Underneath "TIS Config" tag expose TIS diagnostic information.
Expose the tisn of each TC under each lag port.

$ sudo devlink health diagnose auxiliary/mlx5_core.eth.2/131072 reporter tx
......
  TIS Config:
      lag port: 0 tc: 0 tisn: 0
      lag port: 1 tc: 0 tisn: 8
......

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/reporter_tx.c       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index bd96988e102c..85d5cb39b107 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -311,6 +311,30 @@ mlx5e_tx_reporter_diagnose_common_config(struct devlink_health_reporter *reporte
 	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
 }
 
+static void
+mlx5e_tx_reporter_diagnose_tis_config(struct devlink_health_reporter *reporter,
+				      struct devlink_fmsg *fmsg)
+{
+	struct mlx5e_priv *priv = devlink_health_reporter_priv(reporter);
+	u8 num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
+	u32 tc, i, tisn;
+
+	devlink_fmsg_arr_pair_nest_start(fmsg, "TIS Config");
+	for (i = 0; i < mlx5e_get_num_lag_ports(priv->mdev); i++) {
+		for (tc = 0; tc < num_tc; tc++) {
+			tisn = mlx5e_profile_get_tisn(priv->mdev, priv,
+						      priv->profile, i, tc);
+
+			devlink_fmsg_obj_nest_start(fmsg);
+			devlink_fmsg_u32_pair_put(fmsg, "lag port", i);
+			devlink_fmsg_u32_pair_put(fmsg, "tc", tc);
+			devlink_fmsg_u32_pair_put(fmsg, "tisn", tisn);
+			devlink_fmsg_obj_nest_end(fmsg);
+		}
+	}
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+}
+
 static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
 				      struct devlink_fmsg *fmsg,
 				      struct netlink_ext_ack *extack)
@@ -326,6 +350,7 @@ static int mlx5e_tx_reporter_diagnose(struct devlink_health_reporter *reporter,
 		goto unlock;
 
 	mlx5e_tx_reporter_diagnose_common_config(reporter, fmsg);
+	mlx5e_tx_reporter_diagnose_tis_config(reporter, fmsg);
 	devlink_fmsg_arr_pair_nest_start(fmsg, "SQs");
 
 	for (i = 0; i < priv->channels.num; i++) {
-- 
2.31.1


