Return-Path: <linux-rdma+bounces-15584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3ED2480D
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 13:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B971130F6421
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB635B150;
	Thu, 15 Jan 2026 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKME+4Wy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4716248F73;
	Thu, 15 Jan 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480045; cv=fail; b=YBf6W4nc/C8wHYoO2tpQVSvfyqtP8fjEfXQ2CwFXNrkHNFolaRQ+XuCgv1IjbDvjRO3m+lq/o7xEjLjxf7i+6AExl+UsEm0E8jlzUY4QnAHD4jmBHoQVYrISufkOZxufY0BoNUeHIwwnyL1zUcrtcTG2jSU2hYRCkZNwWSv6sL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480045; c=relaxed/simple;
	bh=PkSqach3Pch4lEsSqSxT5JFf3ApAk5Fd35Tnp00DE4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ALrw7zrWMMQvVpoHcHciNMX5b8Wvn9Jzhcb00BTg9pMuJXFMrexoYQzTiu202EpUXeb21taogLWxgwo7dkJr6c7Q95EPV8m4XZG89GRWyROdgqxJQ2bX2Rki7eCr5dBrrSdAdEWwyuhs/E7YXeomq1Up3EX+FEY9BBEr79pcKuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKME+4Wy; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icQUZ4EUQWH0+mrEoh2EigsAZJ2esjoWr/J04suK3ebCb0Ibc/4GOtUcuPduK4PwH1+hiZAgspiRuEIQW0MynwOHh3wnuqJZjQMXrWVPELfeNhVe2OfOf4UK+h87XZBqf0zcDkxK/BJhr0OCszBzGDx39GCOhLoLOMpn0yN1xMParJzMvfC0Jav414KFd0GMdYvNdqgAjl/XdOcsCJeXmmL+jr72wMBdi451jxz6vr4uko8KrPcyxxKQftslCCvAjZ+epheONm1eWmcZZR8Jd8TN4pKUCTDfsRCdDXPvnr8mCd8qj5JDqTcthDjztNrddprBFAVlYVcCC6mg8w64ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uK0qJkQPIo4s9vcyTKyyzATx6Xvh2ujdaxKy9DUJFk=;
 b=AWWsPuTGipU7ugUBZvZMvBKgKS3Kdw97g3mDNOdE86dUgl+p+VBvxdB7QPQ1S1Su4DvdXpFm6CF5Rwi+vRALBtQP4U+Vv0f/ST15qtbarXqbUFTOJgvsYq9aHC9GF1yAyilEyu0SBAdlVHTPpYosBQUFQhKb4VX6822cyHGsjM7Ai7eZlad+feRVe/ThNKzm0zYEIqBdHbqnm/IYy1bnD6dUb4M2z4NzTDvkT0IfU4yoapYfuxRNQmQPY/ALH5NKHy9EXdZ8jkOdOGFbu7n6EAr5rywGNNFOLMBJboY0JutDyzyrnwaVS5z+UCZAaRSvImdtLjJ4NXMbg/biRYcqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uK0qJkQPIo4s9vcyTKyyzATx6Xvh2ujdaxKy9DUJFk=;
 b=HKME+4WyOFnh07COzW/wGvHAjGYG+z+kcVq8iGbsJInoCRx6S3ZOVSCqMSM88p4/dR27afRy9OS7w9ZcaTi4ndV8PHW01WA6enrvNI/eqXb/c4g33SHt70AFYDAH0jaHe/9WIa9dMOSGLePR3Kj6T5z0DzynQzLQ9jMaZ5e5Ir96pgcVYc9F96fG1b+kcsP/RBokr+MibGXxioU387Xw7UyhRdqM8kR0IZca5CYjX6zc8cZIEA5F7XAVEpEN6osNPkuLTdLLk+CRxcLdhCQwWfpsd/RdXXOQY8bPA5CmFvBJbh/GCKp9ZRhM01ql/PTCfipkdYfqZdJ5ilxN0mdn+g==
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by CH1PPF12253E83C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::606) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 12:27:20 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::15) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Thu,
 15 Jan 2026 12:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 12:27:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 04:27:01 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 04:27:01 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 04:26:58 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 15 Jan 2026 14:26:45 +0200
Subject: [PATCH rdma-next v2] IB/mlx5: Fix port speed query for
 representors
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260115-port-speed-query-fix-v2-1-3bde6a3c78e7@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAATdaGkC/32NTQ6CMBCFr0Jm7RhakARX3sOwqO0gs6DFaW0gh
 LvbcACX7+97O0QSpgj3agehzJGDL0JfKrCT8W9CdkWDrnVXK9XgEiRhXIgcfr4kG4684q3XNBr
 9aqnpoEwXoWKf2CeImw16WhMMJZo4piDbeZjVWfjPzgoV6qa1xtq+V6N5+MyOzdWGGYbjOH5d/
 i0vxAAAAA==
X-Change-ID: 20260113-port-speed-query-fix-592efa2b4e36
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Roi Dayan
	<roid@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768480018; l=2295;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=KE0mEkZngVaZnop40fBNM5OqfEZtTSZ+e9Ja+E9yQLw=;
 b=X8ArQvZwd2gF0V7cVOyzyN+BRKfIm0eYrq+ekF0Z0nvQYsbpdYLM9K3+jJw3XTA4bQD4KBzf6
 ve5mslzBG2sCNGPdLHF8Kw6DhKu3qHHrxCdxPufPJtNdS0uBX8ML26Q
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH1PPF12253E83C:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d6fad0-0dea-4c8b-9ba3-08de54316daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHNqRHZBdlpIcTVaajFZeW16dW1SYzF4dCsrZHdsZnErUGZUQ2ZzZkRxdS9j?=
 =?utf-8?B?SEJGK0VwTGI3ZUJTQkZxdVdqU3Jrc2NZSjB5b0d5OG9TWnM3VHBoeG1aY1NI?=
 =?utf-8?B?V0NhcEVMVlJRUFFnWWtiNko4YmNzUWpzWjRVQ2l2UTFpUVVneWdGNFBCSHRY?=
 =?utf-8?B?N2tOSkgrYWhZK21ya2d3NUJNa1YvTFk0RWVwVEZ6SWRWaFhCVTJZalF6THBK?=
 =?utf-8?B?aTRvdXdEMm5rZXErWFYxVVgxV3I1cHNPNjAvaEFFVVEzV3N0TzkwZVJwZllu?=
 =?utf-8?B?eWRHOUxCTTZnYk9weCtxOTdQT04rbHg1ZmRxWTFDNWVSQXhNZG9Zc2hxU2lx?=
 =?utf-8?B?ZXJKeVFTeU5PWmhZLzJLQmE5Q1k1RnJ2bUxGaWVTdENMT1RoVUpsdEdmUkd5?=
 =?utf-8?B?dVlVZU52Ui9NWHVuMjRJRU8za1k5QkpSZ01BSzZFN1FSNEU1SEJ6THNNRVJq?=
 =?utf-8?B?QWE5ZG9xNDdVN3R2MlFZMlg2Rjc0eTBGbzBCSHQ5UEtURmErWWJEN2V0Yk5l?=
 =?utf-8?B?MkdQNW5ZbDBmQmZqdnZvQXpwMTRkaWR2VFVnZEsyTDc1dDFJMEs3R3liWHcr?=
 =?utf-8?B?dnJ5MzhEQVBZc09IdS84RTd2VzVMRkFLOXZsdGcvUUQrVks2WVBlQXIxUnBK?=
 =?utf-8?B?UDQwZjZSTnNXSVRXbjZhZzdXcXlFNVE3aElsS0hBakR3Y2p0c011dUJaZFN0?=
 =?utf-8?B?ZnB6SDRheDNMc2ZIdUtvRzNxdEtMeHUzbVBpNlNpUXRDeXNNY1hBa293N2NX?=
 =?utf-8?B?dmhVZzg0QlRtcXRpNGp1VmlkN0ROTlRLeVVESEpLdFp0K2ZHS2cvS1NXV0V2?=
 =?utf-8?B?cUJxQmpTWTZjYW5FcGlKTjVJT2piSE9NcVNKRW9tc0I5dWhpdFNLWGY4d3pi?=
 =?utf-8?B?UERZd2RCLzhOcjlLZFVKc2cwOXRuSzQ1THdRR0V4VW5OUlo0NXhFZWZwT2E5?=
 =?utf-8?B?U2FCaEJLaU51MEJmQU9GeVFMa2FsTTgyVlJZV0l1QiszYlhWUWZ6cDlaOVc1?=
 =?utf-8?B?dktqVXMrRldnSnlqQzlEaEZxQUZYNjlQV3ZHWTA1c3ZIalRpUHJVQVA4V2Er?=
 =?utf-8?B?eVpjeHo5VDlzWlZvSEFzOXBEQTNYaEJFZytWU0FKSFRuQnJiQkNDZ24vUlM2?=
 =?utf-8?B?bGxrMWhNYWQ1WXFVZVhaQUZ4ckJMbk5ya3plaTNPQkVsam54RXAvdXBXcTlP?=
 =?utf-8?B?K2tpTWxJUWZOTWduNHVOU0krVmxjNmhPVFNnWlNRKzBCbDlsckQvYlUvelNk?=
 =?utf-8?B?ZVlnSzY4aHNBRWZWL3pOWTRBV0EyT1BFUE8vVVMxMFZsSlZFdzA5c3c4TFZH?=
 =?utf-8?B?dThERUhIVGZLN09UOVJ3OVNSdG1zUGNzZjdUekQ4YUNEaHROc0xsWnRDRlo1?=
 =?utf-8?B?T1l3eXpWdWl0dk5iemlrNmVGN0dtbTRNUE1VVGtHQjRna2hGaDE2dDFsaFFP?=
 =?utf-8?B?UzlWUXdLaHhXMUh5cFJmd1VvODJ6NnZPUTBuSzZtRzhESDFzNEVxR0ExdG11?=
 =?utf-8?B?ZXdsQ0N6MGcxdkZrc056NGZYdWZJNy9OdklKejVqN1M2K28wZjE4eVduUlZr?=
 =?utf-8?B?OVdqM3N5aEEzTFZHdjJyN1pRTHVLb3Z2WUFjWGZDVFRkUGUwRitjS21VeE9U?=
 =?utf-8?B?SFM3Q0RUU28vY3oydWp0V0RXQjM4S0FHMTJXTFVQSnRQZjhTNHluTkF1VXZW?=
 =?utf-8?B?a1BYaXNmREYvN1ZOdDBVemRhVjNmMHJtUjRiSHRlNkNFT3R5YzBrS3AyRTJm?=
 =?utf-8?B?MUd0M0FYbmN5OFpTOW1XWktOUU1XNEZkYmh3WXV1M1ZmS2U3QUtRSm1ibEhz?=
 =?utf-8?B?TlQ2ZkY0T0tKRnFwRUFSSWVvU0tUeGZjb3hxU1MzZE9sWFcvbmtzcHNQNnU0?=
 =?utf-8?B?eEZuM1lOQlZjWDZlVWsrRTE0WVFHeDdtYk05bGFwUUYySk5HUksvQWRuMXFu?=
 =?utf-8?B?QUZwRDBUWmZXNkcvb3kvRXlDVFVneWxOalJoK0QxdVBZK1VHUUZCMEs3RVZy?=
 =?utf-8?B?cUJ4T3BqbjQybkh5ZDJSaDR6VUJwRGU3NExJOVlEYUFuSGRESzZ4UTN3ZU0y?=
 =?utf-8?B?eHRUVWI0bDBrdDdVb1haK2xLakdJVjFGVFFKaEg3YlR5dTZEcW10czh0N0xM?=
 =?utf-8?B?ZTFUMGNCYXhXbXo3WkM5QlVFbWExcFp0NU9GNHl3d1BqQkZTMjZMdTNOZ1Vk?=
 =?utf-8?B?Sk9xczlzR1U3dU5zNFgzYnJJWE9KcUk0aGZLcllBaVNOeThsQUJ5VDRncU8x?=
 =?utf-8?B?bXNKUnhjSXZnU255UTNPaC82blhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:27:20.1667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d6fad0-0dea-4c8b-9ba3-08de54316daf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF12253E83C

From: Or Har-Toov <ohartoov@nvidia.com>

When querying speed information for a representor in switchdev mode,
the code previously used the first device in the eswitch, which may not
match the device that actually owns the representor. In setups such as
multi-port eswitch or LAG, this led to incorrect port attributes being
reported.

Fix this by retrieving the correct core device from the representor's
eswitch before querying its port attributes.

Fixes: 27f9e0ccb6da ("net/mlx5: Lag, Add single RDMA device in multiport mode")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v2:
- Replace unnecessary NULL check and fallback for
  mlx5_eswitch_get_core_dev() return value with a WARN_ON().
  In this flow, the function cannot return NULL unless there is a driver
  bug elsewhere.
- Link to v1:
  https://lore.kernel.org/r/20260113-port-speed-query-fix-v1-1-234cacc991fa@nvidia.com
---
 drivers/infiniband/hw/mlx5/main.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e81080622283..8ea01edfaf45 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -561,12 +561,20 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	 * of an error it will still be zeroed out.
 	 * Use native port in case of reps
 	 */
-	if (dev->is_rep)
-		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
-					   1, 0);
-	else
-		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
-					   mdev_port_num, 0);
+	if (dev->is_rep) {
+		struct mlx5_eswitch_rep *rep;
+
+		rep = dev->port[port_num - 1].rep;
+		if (rep) {
+			mdev = mlx5_eswitch_get_core_dev(rep->esw);
+			WARN_ON(!mdev);
+		}
+		mdev_port_num = 1;
+	}
+
+	err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
+				   mdev_port_num, 0);
+
 	if (err)
 		goto out;
 	ext = !!MLX5_GET_ETH_PROTO(ptys_reg, out, true, eth_proto_capability);

---
base-commit: 325e3b5431ddd27c5f93156b36838a351e3b2f72
change-id: 20260113-port-speed-query-fix-592efa2b4e36

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


