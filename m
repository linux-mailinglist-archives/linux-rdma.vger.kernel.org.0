Return-Path: <linux-rdma+bounces-15146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15856CD6049
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 452FA3064E72
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F02BDC2A;
	Mon, 22 Dec 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xxj7Klta"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5429BDB3;
	Mon, 22 Dec 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407272; cv=fail; b=Rf+OME5JdfACfQQx4gzXaOReOtYLIoLN+oIPfC3W+IdIcSOJSV4Bz0w+zOpRoqNbWAWdonTQFj0weQPNg91l5dyhM3T9hVbKPHtCFn3sJGBWv3FO87qSdISzjwPknlY/XdEsZtIqLzX2KzwqFTi5S8hYveeOu6SC452uPhriwL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407272; c=relaxed/simple;
	bh=gliEgnJNg0w+oj9CTXHKkAeRY6bbmugmK4xgE6wBxkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZpK8in/WfG/xXCuC9jjfHDu+re/y1kH/msATGsKsUmWNofEd7RtWt/MpGP4kq9CtwPgrn+ApVCsPVw+w3oJpTC56mCvN/wrmQ6HPH2ktCaw65VRQf8EwewlZ80PiFk2ygiheapp81L7lwg8dTCQ4g/klUwkuYl9aPS6ww+rvG+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xxj7Klta; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMjOw8X7iMWGcXnift9oSMFD99PbMxNybgSTNYSHHu1fw9GctolfMgGEzjGrfB8yjzjNFXFz0tQYijVSvuCWgLtXApDgwbIWw3n1mZvWBpvOdETOUTmDv1K9r4SXljXKRxiaZBJfSfVVTZZCwu/p7tjct5qb50NQISZLCAZ7iKRmg4BKHNmCj1X7mU1M1GgDZSLLUypYrEnkUA5q06I0VXcI4Ke5T5e2pmY/c4rAQoJJtOBuQtu4jyEnbRsYA163pKsdGbcKn46O0GMPvaPW4VrdlYeXdV4m7d35E3Cx7ExPS66ytWweJAhij9FD15dI4a5s3w+u4j+Cy6EsfVRPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvrMgn2+wKKcapHXhLpy9IXvny1OP4gsdv9TMDVaoh0=;
 b=L4/6nfbzEW/lPWvNQAnaTcEimBqlbzD1hOoYZTPJd+Wjl/LcqETfbSkPrnZEY8I2OTtQ5R32jxDzrTgx3MtmxEZboB0xKO/wVef/iL6tqeH2z2afCwU8fsU/elD68+YdWXGyMa9Rfou5KAsCXPcReCOD+b7OdSfrASQm10uhL+BcLbPyMkke0uSrBb9dXkpip8+eUL7mWA5mf/UtCSLBwcJB0uIOfjXsZ37tYKbz/iGHCKd9r0nvXV8Qofva+qYmIzo85O0ZGFfbXTv4l/HeHXRPSVieisKi9snibAi9VoNlKKfK5lMYP3K4YEaWk+JiDCzifu8oCaJpWfnOJBekPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvrMgn2+wKKcapHXhLpy9IXvny1OP4gsdv9TMDVaoh0=;
 b=Xxj7KltaF71eENMPkwrmOKKukTuszVvxZ7/FltOydFXrBeW10YVVm1a9l9MM+j1xxXm3RfkpbNZGKpkewntEWtLcFEv/quZjF/QViw8s2nOFMn8L7WcuXPLcRByZCVsBDU0ftP6rql19qDnNHlhFjnA5RddK9FUx0WUt3sRDfqygXbM55lPytzU/yQFMx2Sm/JP5vxI6gW+73mm5gNIoDBsvWjyEQWkGNQ7s52U47UpcSJdHHbj6dmUWcu/6Mul0cZW8sz5Q6/JvdjU/Q5d4js2WUB0VoaOYiE0EN3w23lMzRZ4UgCGKX8+U4GriaWVt+CtkP729Opgs/O8mRW6ULA==
Received: from DM6PR11CA0045.namprd11.prod.outlook.com (2603:10b6:5:14c::22)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:41:06 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::1f) by DM6PR11CA0045.outlook.office365.com
 (2603:10b6:5:14c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:40:55 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:40:54 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:40:50 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:36 +0200
Subject: [PATCH rdma-next v2 01/11] RDMA/mlx5: Move device async_ctx
 initialization
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-1-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=2149;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=CuNVDDfMMvTp2yh8yxj24ow88KTjzjlhN+AReFQaHNs=;
 b=G1Uoc2UmxiLkrIuJ4AJbfniJqQtTTw1B5atMZmjowll0LA3p2aGolA6R4mtS3CdXKYuPctI8n
 +9Yekref/MODQnD8cgj+BlQ2HOKLeA3+LiExFlbF2b0rxYfRy2pt4Uk
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e521a8-e1f1-41d7-4c64-08de4157603c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0hhSlB5dXlNaWFzdThrVjZRUG9naEhYL0s0bG5EUW9pM05vMjdEOEZMa3ll?=
 =?utf-8?B?MlRBeklYT1czY3NQamxwL1ZtempRUzFtK0t6YjdEU1YvRHBNVDRQYXNFVEJD?=
 =?utf-8?B?T0EycUMrR2lkc0ViSzBIeEZsanhHS2RuVHB0UWlYUFNINEJGQ2phNnNZRmtk?=
 =?utf-8?B?UGlVZEZINmc2SlYzMXNUeGtKWnJSL29Ka2NoREtqYjkzUHp3NXhhc2hzQ2Fr?=
 =?utf-8?B?aEFHOW1Kb2Q4SnJrb1d6QVp3VWg2cW1DdDNQbXVOYTVPLzA3YlpOQUdCNUxP?=
 =?utf-8?B?RE9waGF6R2RldHJWYUxRa0JGdVpxd0xSWHBiVGJxQU1wNjF4OG9ZaGdoY1J4?=
 =?utf-8?B?QWgvckZ5YStGaFhIRmxUaE9ZNHVGRFZZNis5RXdXRGRVRE9PTXI1RlYyL2lv?=
 =?utf-8?B?WUcrVEI2T3lCcTR2YVJjQ2VyUHBhVE9EQkxiWVFnZHlnSTRSZjg3QktUVjRs?=
 =?utf-8?B?SThvd2V0WVlMLzc4L3hkWERrTy9MUk9jVnh5ZitxNUY3RFBTWnRnekpaeGda?=
 =?utf-8?B?VnR2cjdZRTF4RUNJclZ3RUxVQmZ0U1pIdFk3K3pVNjhUcE5uVDRkQUhnU1lS?=
 =?utf-8?B?NjJHT29VT0pYa0hkajNtbWFLSzNZdCthMC90UUZIV0wrNXd0bEF2MklHcmRj?=
 =?utf-8?B?bjB0VTlVb0pUbTJONHF4WFY5bVB5K3RUMHBDWm1IVG9LejNsVFdscjNocnNq?=
 =?utf-8?B?cWRvd0lKUUdPVW9na093RWVKRVhxTDY3NHpBdHVSbmY2Yk8raUl1YlFYN1dw?=
 =?utf-8?B?Q0JQWVBMREFrTDZtUnNZakxLSXNzaTA0ZXN4dXlRR0xSL0dab2lqWDhMWjNU?=
 =?utf-8?B?ZXZ0aWYwdzk4STNOandBNWRqa2JQVGcwVHlPUUpEcW93SHRiM3NkTEZQaWpO?=
 =?utf-8?B?a3RqcTUwQ0E4SjZGZGNIclp1NXl0ZmdRenV2djdDRUgyK0xNZVVJZmZZeVNo?=
 =?utf-8?B?enE4aVdvU29WVUx4SFJSLzZYZFhhRE45S1lkMVk5a1NDWEV2TXlTNGowbXZw?=
 =?utf-8?B?VERKVXorUFpVTXhiQWVnSjVNVDBHVlprdFFHQnhzMnNwQmJiZmJmQWRvOE9T?=
 =?utf-8?B?S1JFNVdPcFdIbG1pWGlXRkI4eXNFK1JnVUo1V3FzL1NJM242d1Q1MG91Y2Ny?=
 =?utf-8?B?ZDRHWlVWajl2Q2lVSTFXd1pGaVAvbyt1U1VNUFJ3Vk55WVA4U2RUaUE1cnpy?=
 =?utf-8?B?TzhpTnQ5VGpwaVVzRTdhWStLTjJyTDNzSEtNcEZMSHJoOFY2Rm5ScE03Zzl0?=
 =?utf-8?B?b0EvRXNiS1IvaW9rSmVSOEx2QWNNcUswS01SeVcraDRDTktiSXY3dzNHUFoz?=
 =?utf-8?B?eUlHbURsRmRoSWFqeGdFZi80bFZMdUZpeVhSWWE2RmJFeHdlb0Z1cXorTDVX?=
 =?utf-8?B?c2tEdFJYVDhYdHZzVFllaUtMNGxHOTExR0hYTVpNRW5RY0Vvb1ZBaDVISUo3?=
 =?utf-8?B?Y2VMU2dnNEJDNjlwQU54cFJvL3V0NXkrQVoyUk5iNTNBTDRWL2cwcExrNXVC?=
 =?utf-8?B?QTNxWjdQaUFRc0htYnA3RllDOWs3OXlXTjdjaVlEZ2g5YXpSMEE0MWlDQnAw?=
 =?utf-8?B?KzY2aDlab3pvMmxmaWRsWjVFd3VtbnQzRFBYWFQ0bG82OWpIb2xmSmEwZkZQ?=
 =?utf-8?B?OHNxdzNnSTM0UXhBREVrVUtiQml1NVZDdjc4Mm9wU2hhN1JzZzJiamdrV2RS?=
 =?utf-8?B?UStLMW1MdUZNcFNUMkE2WXpDMzlJZ1JyN0pOejdyb0hOS3dFSHR3c2xlSmc2?=
 =?utf-8?B?VFdxWkVBMTM4VHd5eENVaWd1dU9YRExNQnJMK01Idi90RElVS1N2Rk9XRzBr?=
 =?utf-8?B?N1NpcitFU0d5ZnYwdElZeE1oSnBsRmwrQjFjRW1QbjUxejFPNXphWFp5MklC?=
 =?utf-8?B?ZnNvdTVJR1A1NXBiR0dxbC9UOXNDSW5sS3kxTmZMRmZZeFN1ajA0aHhyd2No?=
 =?utf-8?B?bUxvS1o2amdjRUdNRTBWTjR2RTgvNVJnZGFwRnhnOUdUUEZtYS9kRUxMNzJD?=
 =?utf-8?B?UjBsZ3NCQ1pDdHlnNExmR0pNN0d3TkpuOUxuQllvQkdCbEZRdnpqdFM2MHNa?=
 =?utf-8?B?TGlLVWxIZFRYdTM3ekNxODJ6TjJDOHhONEFjaTJtSUhmUWJCM3BUTmlaS3U4?=
 =?utf-8?Q?kok2dF900cYbzE0Opwdaz2ww/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:06.4120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e521a8-e1f1-41d7-4c64-08de4157603c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827

From: Chiara Meiohas <cmeiohas@nvidia.com>

Move the async_ctx initialization from mlx5_mkey_cache_init() to
mlx5_ib_stage_init_init() since the async_ctx is used by both the MR
cache and DEVX.

Also add the corresponding cleanup in mlx5_ib_stage_init_cleanup() to
properly release the async_ctx resources.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +++
 drivers/infiniband/hw/mlx5/mr.c   | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 90daa58126f4..629d09fd08bc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4160,6 +4160,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 {
+	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 	mlx5_ib_data_direct_cleanup(dev);
 	mlx5_ib_cleanup_multiport_master(dev);
 	WARN_ON(!xa_empty(&dev->odp_mkeys));
@@ -4225,6 +4226,8 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err)
 		goto err_mp;
 
+	mlx5_cmd_init_async_ctx(mdev, &dev->async_ctx);
+
 	return 0;
 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 325fa04cbe8a..56687add34f7 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -979,7 +979,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		return -ENOMEM;
 	}
 
-	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
 	mlx5_mkey_cache_debugfs_init(dev);
 	mutex_lock(&cache->rb_lock);
@@ -1041,7 +1040,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	flush_workqueue(dev->cache.wq);
 
 	mlx5_mkey_cache_debugfs_cleanup(dev);
-	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
 	/* At this point all entries are disabled and have no concurrent work. */
 	mlx5r_destroy_cache_entries(dev);

-- 
2.49.0


