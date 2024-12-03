Return-Path: <linux-rdma+bounces-6208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0579E2E8A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 22:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E383B3A4FF
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5328208964;
	Tue,  3 Dec 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfA+fEln"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BB1F6694;
	Tue,  3 Dec 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257817; cv=fail; b=iTKhvHjbaV8Ln5yXL9ZIqKzxr7Y/X7rbhCVP5XJIgsI5aIkMIVlDo7MsflqGFtWyhR8DFKwV0BzZEjXZ4RjuyJvTzluHqeWmS/OAlSnJEWkBU5y9RBEIfJH5o9wDq+osec7BVY/Ti7lWsD1poM25OiYcCQluqZZVdCfFgolkwSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257817; c=relaxed/simple;
	bh=iPsY3JNqyCFs/4cH7DQ5hmTTXOdlkygw4+vYBCb59Hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8rSY+ltKL2QQqgeuHmLp+GD/Unyn+2SilcBzY05K4eh14UGFaxs3NgaMw9uMazcvNnvHjX2YOzZeTEGSHVTfwrnWxb4y0xvIYh5le8u9td4D0rTnGXRv/F/8Rb5Vf4TzK3urwhrlMzTsW3q1F4Miy3FjfhpL48tdOennnybn4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfA+fEln; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a08ZBrrR7fy4V9xgVJ9jgSDJXk9+2xeFL/sUWwKzKeWxe96sC/EUKmVQa5kzf63/aEDI/wDq2sto6zOl7raiXhwxPCB2/svl5q60CoZbkzKwMA5PwG2vm2DBACYZDyZwFOjf9E91we9FXy0u8l+OKI1T4UJxyRaSUA7vWGUoukuhQI6+yGGLoCGe+xpqoEtrxgQRJ2u/xpBYVGk2nvWSnY3gO+KSx/AnKGD41cfd6D4HTVFvXuwOhyAQgWKbuRdJoZMkaPLBbMsG8TteEFAlBmQ2S7Cucp3giV6os44+qnsY6bnEAeOmpy16T+jSmT5yZQpL0+Q/nAJ1m0gg/x+qGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO1I/NziVUCoUdIza2q5d1Az/TBvPj866QaNN+JMi5I=;
 b=kjgoWXtoKLjDQPxEOv5p65/DQcuZvvqohMHE+3HpV3e5CjtgHDjefK32gGkjbrHWXoi5MSAGknyfRDfshySt+Nv7fLQVflJAuSLnZcpOvk+Gjdww17H3mh5btXxK3cdG/T52v1ckP79XlEJ3ObkrZdmZb1TQO6bxGUck3boGQv8+pm2kwk4+AjlAtgSEaAUKaNvvS1coh0+YbKqFaG8wD0jKe7wPt8kVRRUH8+8OauLaj0K10W88tVcTHA1Jb78IEtv9HuOOamrk0MVpAfQZ+bHmrNl6lM1izZclqsz/LB8SR32jaGmz3DTZjq78JqE0Zmk/0J0YnpNu0+2glBRPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO1I/NziVUCoUdIza2q5d1Az/TBvPj866QaNN+JMi5I=;
 b=mfA+fElnXJXoSQdcyF9hFwENcW4zwScwihzxOsC7gg+94uz+VdleqP8AT0xViCTaSsvBJPK5nXLs7fe3PGvPibV25gfkM9/qz3K1/i6ifrJ7dAWr98M4f+jBsndxrmZDog6ouOmgqtesSniznOGMgKdOfhnAhVaD4sPZTH5acLH280bXHrrBxwgq+VEvwXdeJAV86oaz2dVsdqS3lZ7IWAB9xIoSYJgJoiFW2bW5ru9MJxpkIGB5RFo2pxQ/FflH05G0sb3wrxU9xL7HYYcTvjZG/XC1M/cQbboUZ4YSqT6+TtkZ3IFWxIMrGKPIfV/as71tIpDGApGB+/2T9fAZOQ==
Received: from DM5PR08CA0026.namprd08.prod.outlook.com (2603:10b6:4:60::15) by
 DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.20; Tue, 3 Dec 2024 20:30:11 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::2c) by DM5PR08CA0026.outlook.office365.com
 (2603:10b6:4:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Tue,
 3 Dec 2024 20:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:30:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:30:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:30:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:29:58 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH mlx5-next V4 01/11] net/mlx5: ifc: Reorganize mlx5_ifc_flow_table_context_bits
Date: Tue, 3 Dec 2024 22:29:14 +0200
Message-ID: <20241203202924.228440-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
References: <20241203202924.228440-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: abbfdf2c-7390-4467-3154-08dd13d9493e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lL19uq44g88gkegTZHRVOzOUtL6KvKOOFM2WizTwZrg7Oh2hPc6L1OUf7gzR?=
 =?us-ascii?Q?gbBteBx/dFgBmAj0iZTczxlPEramIrgkXkTFSadiXLb2Z81jr8wzKVO90QYw?=
 =?us-ascii?Q?JqXr0O8nr4JfElKRwg/Us68OFalO8U1hhDVT/eokFtaVoYeumK5iviNxOA/R?=
 =?us-ascii?Q?1+tAtwIeO2uWsJzjEQt4D3yOEDMzbr6CgTBR8UdG78XRUmyHs6XhNMwddNHJ?=
 =?us-ascii?Q?u4/VqwXu9ZCcGq7ZMYnH0+aZKYiV+EPARbX/ukKwkOsWrjR2ujx5mz2omP2B?=
 =?us-ascii?Q?ItDKQNn2/dEDET3ZHa2jad4XJ/f2S4+trVIYyJZ++wwEfliHzZig8cEKNPde?=
 =?us-ascii?Q?+AXjYdMOhTQTaKAkpd1Szq0ragoer4DAPRHF1fbNO1IvNrUcOIK0f+gR/U4w?=
 =?us-ascii?Q?BG3m0fQGl4T9GOJ+r2/5g8jszYp9J9i7CXeerVjKVA8XsWBweCH7IYjtego7?=
 =?us-ascii?Q?yWTV+QRI3IMeD8k7/U1lOfhLRyIyUsW6bd/3nvUgjNhdTSw0hyni5BFxY7al?=
 =?us-ascii?Q?eUKvc56Hw/FC/Z6rE20hDsIOlz2q0GHUMv6XgM+fwaCQCJy4JRTEFpzdmP8e?=
 =?us-ascii?Q?Nr1IpoamLZjKd3I2oEioMWiMs7+sgVSyyyzrCLFiSaq98uYA7x/UTmEgwNwY?=
 =?us-ascii?Q?vYJITVf9b69rle+gAwV9MS5/e2tnTfOmN6EXycargYxFu2ra8lzsZjhwgZfA?=
 =?us-ascii?Q?qlHkzf6VW+RL1D5KIP+UjtcsAI3fIU2QwgDZZWilX6Rv/EvnuqR4bX+Q9eIj?=
 =?us-ascii?Q?q7YjDjVoThqzdiYdIJzhJLS7JNZ6ADSrFTGNJMxEQBWaayFedbQ58tjY8Vtl?=
 =?us-ascii?Q?f77Q6f1I5ZHMQDYro4pIsnd6Ou4VXa8JI6jKFA7Xllnaun/ZIoGQid70kvyb?=
 =?us-ascii?Q?bmIRvXRLmN6Wr5JmUHSZpctE523pM96oUhjBt1EXp84LzGGFAtSw8MZBpUay?=
 =?us-ascii?Q?4mwzCPhdSA9tVl+9YH8o2+hxM6cx/rDe3f+CMWyg8IZukZ0r9C4OBghDMDc9?=
 =?us-ascii?Q?1FfB8Z8tFOTOcZ3xTevVzgWKy0NaJ3SYv7ZPGJXslCv9G+2I9Pen4SDtBkM2?=
 =?us-ascii?Q?l+gSk/YSfP87nnhgzXkxAuMau4t2gx+hWAoklYfkqnyRjT+S4ZrreQ35HBD4?=
 =?us-ascii?Q?ryQfn0/DZ/p1ycXdZEiGJErDZk55Skef6xP2JfqsPQFzvZm+f4t12tdYn+/2?=
 =?us-ascii?Q?bLGCHIKe5rMuoFDbWYFW3AUHTvNbXPAei2cygpbBK6BdaepLGP39TqzUmBIR?=
 =?us-ascii?Q?rRFU9xfu8imaiOKYNXMUhxxqy3UWtaKhlAo6GUBbuOD3Z6phJ9u4EdnoG1gp?=
 =?us-ascii?Q?khUkw4EgKDAEETM7egZtimPMIzHs/NM01CKjeOElPxANi1VTqDVNtOIQZFBY?=
 =?us-ascii?Q?AqYG6t6TtZkh1GMRXVpW63mTzWNzhjPka2PG/M5UFc12FtnXiGeWwG0ClS3o?=
 =?us-ascii?Q?88OGDNlvdZWHu/p+yVAtM8b/n2Jy0PkA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:11.2872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abbfdf2c-7390-4467-3154-08dd13d9493e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

From: Cosmin Ratiu <cratiu@nvidia.com>

The nested union at the end is not in the same style as the rest of the
code, so un-nest it to make the style uniformly applied again.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4fbbcf35498b..f3650f989e68 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -6324,6 +6324,20 @@ struct mlx5_ifc_modify_other_hca_cap_in_bits {
 	struct     mlx5_ifc_other_hca_cap_bits other_capability;
 };
 
+struct mlx5_ifc_sw_owner_icm_root_params_bits {
+	u8         sw_owner_icm_root_1[0x40];
+
+	u8         sw_owner_icm_root_0[0x40];
+};
+
+struct mlx5_ifc_rtc_params_bits {
+	u8         rtc_id_0[0x20];
+
+	u8         rtc_id_1[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
 struct mlx5_ifc_flow_table_context_bits {
 	u8         reformat_en[0x1];
 	u8         decap_en[0x1];
@@ -6342,20 +6356,10 @@ struct mlx5_ifc_flow_table_context_bits {
 	u8         lag_master_next_table_id[0x18];
 
 	u8         reserved_at_60[0x60];
-	union {
-		struct {
-			u8         sw_owner_icm_root_1[0x40];
-
-			u8         sw_owner_icm_root_0[0x40];
-		} sws;
-		struct {
-			u8         rtc_id_0[0x20];
 
-			u8         rtc_id_1[0x20];
-
-			u8         reserved_at_100[0x40];
-
-		} hws;
+	union {
+		struct mlx5_ifc_sw_owner_icm_root_params_bits sws;
+		struct mlx5_ifc_rtc_params_bits hws;
 	};
 };
 
-- 
2.44.0


