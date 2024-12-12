Return-Path: <linux-rdma+bounces-6488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2F9EFF0E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A8916425E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDB1DE2BC;
	Thu, 12 Dec 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QIM3ybkZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F371DB922;
	Thu, 12 Dec 2024 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041701; cv=fail; b=Wcghlbxeh7Kx80d3OLSUmqLD8d8S3Vmrcl3qjrZ2nf5Tm66Q1kvts11IBXglo+rv9SUJ7lHH3yfm8B2YIH6rLo3T/Uzbt3JoZJDEf8a+zYTYoJL+PI8FcOzHKaDDix+1qZYNR4ALLH1a72bn5yNvtnv+W6e6fDpbQdF/ScOU4k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041701; c=relaxed/simple;
	bh=u/CR+HvQavwZV9N0aQqfo4KV5Jrw2vFmJapYu+VMBu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MopZ+LOjC6t7EL8CVDlXmKww2+Su+vmpOr/xaODEkSJxeZAWCom0QNUo8P71cbLGK7aYNzyJui+Oy1PMQms6IoCnijWq9NuPlbXzxcSI7EO5//c5W4Dfq/z/Q2l0na7jEDiPE81kmhyjKBk+rR0oDaBvNSc1IN0Sy3jQD7w4+jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QIM3ybkZ; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o15xD6zjEe1lnpT8JBH7H9yO1hWAsOMx8lFtxsTfYBmNosWYxn+i9YMVEjU0PbGge+ESNwmGSz0+hhPifWoKeHTxEPBCUPKq3yCRsxScMIvsRup8o7ZlOyspRJ/gK46ZFVNyAnkJDqoO+drk1dIACBBzmuWlh/1UzOph08C7WgaPZQlqmmYE+96bzcYULj7mStZl/fotGcvpm0bU4d+adwuYEStewxIJebAthcP9FTddRh0/erG/uUq2H5Sdds1qZLS6m3OA2wTOpKOe2XUT97eoL/G9WjpMF9zQppwz6vcd2KBlPEVgvGMptAnR4vPT8XeO8YPpQE5YMHxnW4C4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29DKQUyW4N1TAyyWKuddTU2DeDvcyT1KV+dB5i5nOB0=;
 b=ls3yCBdokvW6K7QuONM6T4viJjjrspDuC2rwaCjM5mcly70nXsnASWI3L8kNjzWWM3r3FNsM8ZtlDR/3DGu1eCO90ph7si9n7KP70g0m1M4VpFeyrGd0BZSH7OUlyf1+UYMjPyYQfmg0vtnbfPW7qOfI66y8DF8Fa7iy9HktYDjmDVcmW5Xgaf4GdlsldDzVK+2+/aqWBLMwMYa5nBZzyttVw+L5OMBgb1hunyoMt5l+TS13qo55ZR2ifcQoMfvX/gO0OfHE4QznvwGc6IEY15V1IV+aNPdsz4dTYb/3MtrXZ7RRrDIAyA60F68DtWfcP/rTmlZCyPMxjRpVP7szpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29DKQUyW4N1TAyyWKuddTU2DeDvcyT1KV+dB5i5nOB0=;
 b=QIM3ybkZcjd6foGqLSBheMBoPS0I/zSWalycWurxrM7pnBcCZpEkmFM6dEl1Wo8HlEBihecZwNrbE+eTjQrQf6GIRa1RtWkfBGy4Wric+OzDGiB16JOqdTeuGtRuusaAIMrdOMcVpMl5kZz0zw7jncgFXVtIKo8drxw4dVTtMIYwe+DGAFh3Y21LUHYP0bVQhuubshI9iTdeAgm+icuWvOhxrrTqvh3yxVLVHMIiCUY24e9nvU5pZNaahDl8+BPfKKu/4UfD0/Pql/xx8v6plCqeuPZzrraPvHPAJsx8DYlJzEZXMZOsag1KhJkIdK/fk6dr46R+/SJP32VOj4duwQ==
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 12 Dec
 2024 22:14:55 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6e) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:14:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:14:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:14:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:14:45 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Rongwei Liu
	<rongweil@nvidia.com>, Shay Drory <shayd@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next V2 01/10] net/mlx5: Add device cap abs_native_port_num
Date: Fri, 13 Dec 2024 00:13:20 +0200
Message-ID: <20241212221329.961628-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241212221329.961628-1-tariqt@nvidia.com>
References: <20241212221329.961628-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b91d8c-1073-4301-8bab-08dd1afa6803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N7U6skmVChAIEGJUtg2Ehs+5RbRxobf8ectQkrKLZdewkpeGf1ngS9YcZcBQ?=
 =?us-ascii?Q?VqChYgQ90TWGAgL+QKLK7H3lL3Rt3xG+eZm9FTm2nykaSX2rfyoDkvjUNSy6?=
 =?us-ascii?Q?ODa8Pb0vQL1MvKt4anGPKyQswwVqZ2Z8FeDU6Ts2nVg3b8hI7Bz6/PyclkV5?=
 =?us-ascii?Q?G5ohStaPJEyjGOQ/CzPhzV7QhGtsrzLLoRRMtUvrfqCVPK2Z7rXTNiFeGay/?=
 =?us-ascii?Q?FQH8Y2920QVhg5HF+XTBVhduuakL9Jrq2j51U+fziid1i9sq8KpF4LiY9gwO?=
 =?us-ascii?Q?JRJt/GgeWP/wF7w80YpuxzX//cMPcZ5CEOTyTU3059dH6QfIkoHsThnazw/c?=
 =?us-ascii?Q?VsYjCQgMrnbWEDqBiWbaKMczK4aZr4l+vfkUNZ+hIeNZ/aifBbLWtaFvXaw/?=
 =?us-ascii?Q?gak8PRlIJe3rYdpANPq0FYo1xKt7ruAmA8deLqx1fiPOa/EBUytC+QGgU+nt?=
 =?us-ascii?Q?hro2fMeEJTwaYyEElGGXN5DWuydmOnf6HUP7nu27eFXVkEvvgWFnU6BqMxNh?=
 =?us-ascii?Q?6EZ78mWrNz9oJDCjSb3FWh0xJ0z9mygLGRbKQYNK94WAjAb7QHEzj4UKayER?=
 =?us-ascii?Q?tjmkKEJE5Y49/MOjiNxtB9Eu//dTzZhXcgM+nYfWc3BlSh7yu64+lQAVFDOw?=
 =?us-ascii?Q?rfGdVlLI2KQYSRHNIMcIu3GcLobOI/inhHW9+jvd/BfDwvIG5njy/KuP8QvO?=
 =?us-ascii?Q?6la6PNkvwv8jBeettUk6n7buiy6Nzv0hD3k2icGwpitX9+I4A66yG+4mWbu3?=
 =?us-ascii?Q?ZM4NpRqNV6m7FwPzpkvigmYnVnpxAWsCmS7F2pQg1ooBrKe+QcSzoMXazUHY?=
 =?us-ascii?Q?eGnbArv1cKHGBy1bEBfR05Qiflju+IJQICeKFk3QzENkVkZr8EfJpt0aWfXb?=
 =?us-ascii?Q?O5svxcpyFcL//iRlQ7+sYE3kZStFRapu73mIhfZpOD6Hqgco+5DSCvuau5t/?=
 =?us-ascii?Q?UrDu4IEJACOZ7iHytCoK8KrZYJkOtbZ0zQjUPzsn8biZvsHnfoBsh6VPV12W?=
 =?us-ascii?Q?WeIZsg5IcjGAuvE5pvdiulQVVtn0nZqR0Mnmg6gUvcA1SK6nhUP8z3CC2N+J?=
 =?us-ascii?Q?9zRg3yQ5hZRszrHLIo09D0WkoNJX5yZk3cOP460/3PzCXrP30kTwEq4B+AXh?=
 =?us-ascii?Q?cN0x86L/vZNJkhvP7X6colh6PoMyjTJMRpMUbNQNvw+VHfIYQEsZDOTj+fDV?=
 =?us-ascii?Q?WXJ0Z7rYxMMOLvOaElzQdu75ohXfm3oDZj1FZa2aqbZgs2abrwE19jiX2J1f?=
 =?us-ascii?Q?7hF0xJdLxw1Oy1jfhhkq373aPF/Zr56hfNP8l9clSzhl1aF9LPPMkHKKRZXJ?=
 =?us-ascii?Q?4vyapmECOICmGoM9V34qvrfdLzwyapAb8LlsnRy6xIUslTif2mvKJNTz01Vc?=
 =?us-ascii?Q?0JHl9/UhBMnRXMvzQXWV2ghfWQOHUzEH7DNZYnVWj9SJVLGSqen8c+bF5e4o?=
 =?us-ascii?Q?KmGG9nfIV8kuXMwTXEld3ArfCG5Meidq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:14:54.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b91d8c-1073-4301-8bab-08dd1afa6803
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463

From: Rongwei Liu <rongweil@nvidia.com>

When the abs_native_port_num is set, the native_port_num reported
by the device may not be continuous and bigger than the num_lag_ports.

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5451ff1d4356..43b3cb4bf8d1 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1599,7 +1599,8 @@ enum {
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x6];
 	u8         page_request_disable[0x1];
-	u8         reserved_at_7[0x9];
+	u8         abs_native_port_num[0x1];
+	u8         reserved_at_8[0x8];
 	u8         shared_object_to_user_object_allowed[0x1];
 	u8         reserved_at_13[0xe];
 	u8         vhca_resource_manager[0x1];
-- 
2.44.0


