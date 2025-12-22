Return-Path: <linux-rdma+bounces-15151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55846CD6070
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E6B6305FA98
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA8A2C028B;
	Mon, 22 Dec 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsWBYofv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F51EDA3C;
	Mon, 22 Dec 2025 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407302; cv=fail; b=Iyw5RbccIgbnnki7FLqnhf4/EV86jw6rQk85wMSjW+GCZmio09lqLY7hGh12xK/IHtUKoN50U/IXdEkODvHWuW2NGJqSIytMYufluWjOctaqNgaw5yI4gaotSDzWmj+oaqvKDlqGdVTkebQ2+RJMJOoUGmZP1WRZ8v8UjXcWRrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407302; c=relaxed/simple;
	bh=XPVaMNsxjBAtnXX+mjpw4qTymt+SfIv4N/Uv1RfeGk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eKNlRVg4724DgQoSuvO2zPfr902oIVxrs+VXt5QRSRLAe9RoLge/jJnYH/ox28YgJSRLz1uEiXic8yNjYbh9KlkXq5FYAYdDGY53N/St/1nG2frpoHHZG3ymOzEcceM8b+i+98ygMSY/pfTRFvor1V07lXXmKzZ0FcWpfzXf5gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GsWBYofv; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9rIZo1MtnMN6FJIN2EoZj462Vae3me/fpPV8PouSdY0cipvFnFzLdwDdDeOxY8O/GnRWihdxyySeT1hFBzO3iBUP0KRHAcjjzYUVz7xKBFksw7l3JCOQvciiZw60WBPNi2ebTdXzJnEW+vv1r8D7UyMtHSm36nmPvqvdjs7KuNbEJ/7sQCkkamH5rUguKKir9PdKUWRLxdngRtcqDxG7w8+fw3cfqehZvhR6Jjtx0GcPvVR2sFlA7WGv1YwbS6nvND+duY6ZC6lFkGZkMY0GNO8wrpcfE0LU+rs2UoXhxiTQxKz+J5YZ9biwXageycLji93ivhwEbbQ/XsqzQFW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwlHW22r7ylwENxh7Ea/L3XxNPCKXWR4f460AUrWkP4=;
 b=ptJxQ2BoVtwAsl490n1w64areqjZLB17LPfOUqmQ5NQPLXgzejxhhKrM/XOpWUAw2sZRmciiYaxmUCq+MPcYeGT8JAz0OYggTlLX4ZMuILY47gzda1b1boauUfPn2J9L9DmaEA+UiZyKmSsgTOcR0UBXz/RXm1FduzaEE8xozxC4JupTbKoWts8qMeFj3wF7J/feRopGO7jAh9DkRskxFaz97+BuGQ4XbznidM8Fdhs+2Lgs8gWg1+XYjhWuYlz7roIwVfE3QWAI2XqyG3rmrz+acP5MAdiwmQPOAGDkg9w6OMBJaRb5Hw3WLrCNHny49TtJKYvYV9hLGMiDWLm/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwlHW22r7ylwENxh7Ea/L3XxNPCKXWR4f460AUrWkP4=;
 b=GsWBYofv0dsGBgksvC7S2MKu8LYsK7AZl7jKCLANGyzT0ow8kSfRk88DOEPeS59Zo1XM3qJ2Nv3t33zKqymh5yrpE636UgeNNL6EetTbEoFqiJm1HL0rMOyk/cuuvw6YQ1OkcTxjpp9mEdbvKybrC8ziDQTZI+OJ3kDFckuL7Wp8/Tp8D01UIpPb0YCiIBjn4sDMtGPwZVPBXBLxfMeBj6D75fvVGI/64gF0/WLtKbMR/3h/ElUwT5Zj2ouTu30Nttoz2s13aqhRqBsutA/phFSn7859VJmOX7EOy1ochfi5uMHbiLLrOcMiXCwV37PRHEEup4YDf8gLitknm/FoRw==
Received: from CH2PR20CA0030.namprd20.prod.outlook.com (2603:10b6:610:58::40)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:35 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com (2603:10b6:610:58::4)
 by CH2PR20CA0030.outlook.office365.com (2603:10b6:610:58::40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11
 via Frontend Transport; Mon, 22 Dec 2025 12:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:22 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:41:18 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:42 +0200
Subject: [PATCH rdma-next v2 07/11] net/mlx5: Drop MR cache related code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-7-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=2686;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=PZPwlm1In6pCXXLnpgD3jxuRsS7mz6vJM2o4hPHwzW8=;
 b=88KpABGhY2talc3AgkMaQq89YvOeLW2jFsV96PpXXsVmjw86SJt+SHObqLYaaxcIvdyhM0Dw9
 bzBhF4M1hIJAfTU35UP/JGW2CtrwFtwYFgGCx58gSXNjl7uAyol2r0+
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2101ccba-c2f6-4552-8040-08de4157718c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjA5NHFPWmlKejlmYVExTUxBWkE4S2NqZXY1MldneUd4cEd6MXU2MHA1Y0Fk?=
 =?utf-8?B?QXBkaGNMUkk3cEN5WVFCQVljM0pYeUhkcWZkd3dNb1E1NnNpRTFZVTRJaUZz?=
 =?utf-8?B?cVkvUTJjNTAxMGJGa0diVEpkdUhUZkowT3hvd0d5NFRsak5kQng3dlNHb3o3?=
 =?utf-8?B?Y1RCMlJaQ0JoTURqYWVFMG1ncmhNRFMrek5aR2lEcXlBbXQ0U1RFMGpNNVEz?=
 =?utf-8?B?cVNBSnZRRlRNNCtuY1hOZTlRZGlhOXcyZjZ4WkJINVh6SUdqTDZKU3dFTllT?=
 =?utf-8?B?aTA3NW01R3B6dmZNZGw1V2RkbFlYZjA0V1pIUHIvZTJ5RjFHdlZYYXpldzVG?=
 =?utf-8?B?Y0xHVENyR1ptMC9FYVY0ZHBWa2RtdXpKTVh5alp6WmVNb016Y1VTNWxMMmpt?=
 =?utf-8?B?QjhobDlYd3NhWFpsRFNTelNGcEEvcmdnR2R3OFluQ1VEcFdnV0pyVDJialV6?=
 =?utf-8?B?eU1iRWJoWkR2M2R2dkxpK3prOGNRVWt3NWxxUzEwdUIrZUMxMnlGTHB0dlhP?=
 =?utf-8?B?enloalVyUmVpek5DaGRTcmhGRm9FbmNjL245bEZQYmhuRGtvY1RCdkF2QlF6?=
 =?utf-8?B?dWE0c0JQdzdKOTlqdUtkbEI0TWxFcFVvNTlaaGlPaEtyMC80ZFpaOGVMZ0tD?=
 =?utf-8?B?ZTd1a09Cd3dCczE4bmRpSWxSTXVDRjNxNThEaTdUalBoa2lEcThtY1BpR3Jv?=
 =?utf-8?B?enNXNi8vdnBxQ2xaOUptZzNlRy9UaWFJTDZWYndLUUxOSHM2ZGc0TWFRanNm?=
 =?utf-8?B?ZnFZNHdWSHZkdFdVK015NzBKYWN6NUlZeUgrczkxdlBWTnJ0ejM2QmVPY1I2?=
 =?utf-8?B?TlZWeE51Q2hPUG5QemlPWmNuNXRUS1BmdHkwMnNxVFBDVGFNQ1hVRktiUEVU?=
 =?utf-8?B?YVhXeXpCcXVab1RuL1BodGVNbllvWGRwcmlQeDQxaHk3SGtwZ2h4aWRjZFN3?=
 =?utf-8?B?M1NzSHJOVzhlaWJWWEgram5rRHZsNGM3alhRTTcwdmJKU2NRMXRWczlNZnJv?=
 =?utf-8?B?eVZpdC9Ia1lrTEc1dWp0Ylc3RFZ1YXZWUlhmVDNDc01IZndtekh6RlM2dDB4?=
 =?utf-8?B?YWVSRzBMMFgwM2ZyNk1odk0vYkRWZ3ZGYUNLbDFxS3ZXdytGSDV4ZjZTU3lZ?=
 =?utf-8?B?dUJmWk5UbUxYdVJnT1JHK3hpSXRBQTNwYTJVNVl4Lyt4NTdtc2RJWEZBdVZr?=
 =?utf-8?B?S1MybmowWHZ0ODdyd1pOU0w4WllTV3hWdDNvRjdiL2QydzJ2UXB0a3h3US9r?=
 =?utf-8?B?UlMrL2tVcG1obmpWRkdXWlpGQll4OG8wVEVRVnRKOGY1dStoYnJHSTFuSVFN?=
 =?utf-8?B?U29JRmFjWGZiTksrTHpzOVlUaXpOcTlQMXVRVFFsd3REczU3R1ZMeHVocWZY?=
 =?utf-8?B?bXlQTjlNQlhKRE5tZ2dIWWorSGo1R2xaUTRQRGdGdWdRcDdsb1dQVXVqYkhC?=
 =?utf-8?B?ZXVvY3ZXbFRrd1JLZXNsNVgrYXA4cGpuYU1GRCtYeTU2SDdCRDBvN2wyc2o5?=
 =?utf-8?B?V0V5ZWdkOXRUMzcrd2pmQjlJcWFoTFVJUHdLYk1JdU9IbVEycnBxWEZURDY1?=
 =?utf-8?B?T1BqUjE4aEw4anFmWkRHT2xoWmxqcDNsTlBpeTQ0eDNITW4yczF2MWttcDBG?=
 =?utf-8?B?N2hqNEZzaHQ4TUc2U2htd0JqVjFhSTJZMjl1TUJJVWhDa2dvYzlJYndDSFZN?=
 =?utf-8?B?WkoySnVVaFl6d3JZZlF6aVJZdDYwVlVKUzFzMkRsdUFBUnIvTUhxdWZ4VjZm?=
 =?utf-8?B?azRlTUhPMlFFRURJM3FBQW54UE5EZHN1UzJ4blMyZU5pZ082b3ZqRVUzK1pn?=
 =?utf-8?B?VlJuajQxODV0a0NUQkxXUklFWVRBczlGQitiN25Tb2MxUkp4SGZmc2NxSnpE?=
 =?utf-8?B?TGJsYTVnQnR6TFYyTGQzZEFHRm5RUnNUaW9MZDFVdDRnWFNjWmJLSHpxMXl6?=
 =?utf-8?B?NFpRYVpSdG0zbkhCZS9RdmZ1Q25UY2xva2VLUkk4ZnVMTzZTcTA0QTduSlFS?=
 =?utf-8?B?T3pidHk2d1UxV3ZOaUhNQzJCZGdpdi96UGd0NmorSTZtdHRFWnZlRll1UnF6?=
 =?utf-8?B?eUR5WUVpZFB3ZVdYZEora2x1b24xZ3hEZU95ZjJTelBtUlhYU0FTRGJ4ZFhq?=
 =?utf-8?Q?NMY8cbVPoQNMDQpSD5c9QukXn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:35.4716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2101ccba-c2f6-4552-8040-08de4157718c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

From: Michael Guralnik <michaelgur@nvidia.com>

Following mlx5_ib move to using FRMR pools, drop all unused code of MR
cache.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 67 +-------------------------
 include/linux/mlx5/driver.h                    | 11 -----
 2 files changed, 1 insertion(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index df93625c9dfa..cb2a58c789e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -110,74 +110,9 @@ static struct mlx5_profile profile[] = {
 
 	},
 	[2] = {
-		.mask		= MLX5_PROF_MASK_QP_SIZE |
-				  MLX5_PROF_MASK_MR_CACHE,
+		.mask		= MLX5_PROF_MASK_QP_SIZE,
 		.log_max_qp	= LOG_MAX_SUPPORTED_QPS,
 		.num_cmd_caches = MLX5_NUM_COMMAND_CACHES,
-		.mr_cache[0]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[1]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[2]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[3]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[4]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[5]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[6]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[7]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[8]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[9]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[10]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[11]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[12]	= {
-			.size	= 64,
-			.limit	= 32
-		},
-		.mr_cache[13]	= {
-			.size	= 32,
-			.limit	= 16
-		},
-		.mr_cache[14]	= {
-			.size	= 16,
-			.limit	= 8
-		},
-		.mr_cache[15]	= {
-			.size	= 8,
-			.limit	= 4
-		},
 	},
 	[3] = {
 		.mask		= MLX5_PROF_MASK_QP_SIZE,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 5405ca1038f9..975cd8705a58 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -699,23 +699,12 @@ struct mlx5_st;
 
 enum {
 	MLX5_PROF_MASK_QP_SIZE		= (u64)1 << 0,
-	MLX5_PROF_MASK_MR_CACHE		= (u64)1 << 1,
-};
-
-enum {
-	MKEY_CACHE_LAST_STD_ENTRY = 20,
-	MLX5_IMR_KSM_CACHE_ENTRY,
-	MAX_MKEY_CACHE_ENTRIES
 };
 
 struct mlx5_profile {
 	u64	mask;
 	u8	log_max_qp;
 	u8	num_cmd_caches;
-	struct {
-		int	size;
-		int	limit;
-	} mr_cache[MAX_MKEY_CACHE_ENTRIES];
 };
 
 struct mlx5_hca_cap {

-- 
2.49.0


