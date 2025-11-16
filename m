Return-Path: <linux-rdma+bounces-14503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B81C61B7A
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05C83AF5CA
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C1265CA7;
	Sun, 16 Nov 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DeC2VY6D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0A2472BA;
	Sun, 16 Nov 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320346; cv=fail; b=J63Vg3HEslz7xPPzJsSRlTu6odTmIWTgghLcVdNbqvFf2yjBWZJ4xLyvb0ak0IrgRxWx5j9ddweRopTzhe+ighsaANlewcbFsedizPms3PqqJJMAJ1Sh10uVNuxg2xItb0NuXiQvdcs1HQlKe+KPP6ryx9v/3YFqM2BeYIJ/NcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320346; c=relaxed/simple;
	bh=BBBhpz6pMYqk3RrKAjGmicmY9xp4fujqrLpgA4fh1lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MLmV0ImuJnhSOk7bpDmQOos5TGhZ4rRgTpxvDfxQigRQYGMiOW0yNpPeWkMJGWBixfjvCgQbQXBbxkIlRwCiGbCtkzZC+CwNf0evzp7/n2NlXLYydizoL1sW0TSo/6HEdEBizNc6spA2Z4I1Eq/eqa7DWqRGDp+g+RUGro0gVwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DeC2VY6D; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRkaVkxpqjUV6kEN9h3L1P2hVRj5nWjsCGCpyLm2T8vLE9cjiASO74+YBsbaw2tcRRA2veOjFtU3M+zTOAy5UuCEY9Nakzpc6F3zmGUs4WyqomQqGQ3sSfjUdi3DB3vTjWoLNFZCy13+HcSAHqs6HPTJSvwj66bj7pBlIOGhpCG2ZIA43LJToBDhkTy5LnxVVJ6ss9o4tEOGySOvSi9Uu4lugCwJYCnaYqSt8L1ENngVN2bsKWA8XkQaIO6jXsvSFvNDMFCgmFYWLVdMpzHsU6gE2dXNNCnR+O3HXBcGcnn6cA6O+SiG9N4rRJIay7sqGhJt+R0acEZ+fnVeRg1HvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keufDu5yKCoU60Jdb5zy80/UnW5v2xVcoMbo6VHmD9c=;
 b=p1Yhzytodgk+3y5e5pyHdjgO5Yx3Fvl+jdzwIhBMt5zvZe4FChkDfWWZrLOLk9ArbezcZ7XbiccrRCj4biGz6Y8Qboo4Fm0JsswFAIlIu9CA+pLFky0+Zt6ly/EFiUgO+wqRLWhtqhj2TaZtKZYfxKLS8DoJ+8UR45qsq8GgrX0SI96k9D6EPISNZsWV9/q/1Y+QuCBAhI46NltUGfrcl0rSEyJuUDtIMLdguOGx0Y441D/yXeaVTqC4Kz1erOWwaBbwDIqygU5sxfNbqNYevt/2YSOGc7V+9Rpbo/Ob5rE7hvDgSk2qpPOI2OKTGh5Nf5nsSR3Vec+Y74M3aXx2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keufDu5yKCoU60Jdb5zy80/UnW5v2xVcoMbo6VHmD9c=;
 b=DeC2VY6Du1cDM7rQEucIWylsIiQrEmSmQWC7z09j/bTcmFqFVhTiRVhe5ccvdISCf+aGZV0xG4Qo7frkpzDWWbX5Pg/SuQSeKPbJzp7B668v1eKdAMlaE5iWfw3aGKNsmYSwU/vPkNo9KpxaLMHWH/6U2fbUuubvpClZkV9Iewnv4eN4X2/JOSqVmfJXz1DWpTAcmnPfl7F95iWbHPgMsbf8GFLmcTaJWoVQzSdxa6sQ9kTlVcXREWu8UpUuezQA+mLCMxjzuKCTq+Kq/66yzKVvf/XIWpzFSBM9kFj6IzaPrV3IjkxVqFzIw3F4QTURdbitEihn7GdBibaoWZGu9g==
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 19:12:19 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::95) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Sun,
 16 Nov 2025 19:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Sun, 16 Nov 2025 19:12:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:12:06 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:12:06 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:12:01 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:27 +0200
Subject: [PATCH rdma-next 6/9] net/mlx5: Drop MR cache related code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-6-5eb3c8f5c9c4@nvidia.com>
References: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
In-Reply-To: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=2798;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=3J4qpnxMA8HKsxpZtqS+dUreZzf9GInptD77rgoSPcg=;
 b=lE5/2hEqGgHjkHq5PX2X867MfL/2CFV9d21EdApdt6QBdjEF7pueAjpK0XamuddMipfwNNyy5
 5SVLzQZzdMhDfnN/6M2WMWspCQu0adf2eIxwqM7IFnu1ntJXXX2z6Tm
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f292ff-28d3-41c8-31bc-08de25441004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2w0VU1xZmtnY2tvdkxWNVdDL3pxcndFRDhwdWYvSTlSMVRtbnIwVjJJWk5R?=
 =?utf-8?B?RnJsbFNiVVVBVkhBZGdBRGNwcEpZNnFBRTAvTmhyL0t6M3NHQzdxK0VhcXcv?=
 =?utf-8?B?b2hFM3NGaGpPcWxJdlhpcGEyalJxT0RDRkVhMldTeWNXQ1Z1WXczZXNqWmx0?=
 =?utf-8?B?Z1BtaU03UDY4UHMvend5S1JQR3JUSk1qSS9sRWRkb3IrcFEvaDZmTTYvTXJa?=
 =?utf-8?B?VnVBaGRlcWZXTHl6bGt5alRuMXdybGZDZk9NT0RCSTFpTjdxOCsxTEw1dzNp?=
 =?utf-8?B?OWlBLzRUaGRzRWtpVUJjV01ma0RXbU90TitjMEtkSnRuRXV5MDZnd3plVi9i?=
 =?utf-8?B?YTBOTTlUczh0STB4eXFNM0F3dm5aVXlIeFoyU1I0UFVvVGdQVmEyOWlKbCty?=
 =?utf-8?B?NjlCdlBPaGZJVzBuUExIREdJejBvUkZ2UDhEY3N0Q2tvd0lnN2RzaU0rYzZR?=
 =?utf-8?B?NkdMZjcyYzJsZFQ0TkMwSEFlb2JoSk5KRWh6dnh2dGxvakd3NCs2bTdPSGpQ?=
 =?utf-8?B?aWRzbUFqTy9xejBscGlsd2lGZWpKdVQwemc0NHBLREUrU2NtcmxpWXU1Z2o5?=
 =?utf-8?B?NUk3dkdyU25PcnJFci9VMHEvUVM4M25IaVYwNHQ0UlVFYzVBOTUrMzVad1ZX?=
 =?utf-8?B?OUpXNjZHR1J5cWdqdjdRajhLdEJJVGd5UFpNNUZFNFU4M0pFRXpQL2t1U20w?=
 =?utf-8?B?SmwzTi9vVnFRdGdaK2JIa3Z1TTFNY00zQUhtV0VMS0pPb1RzdmVKZWlSRGg0?=
 =?utf-8?B?TUpadmxHaktlVy9kY0hWN1ZpU01GUWpRUFRKeVUzSlFlRGdLL25yVU80M2xh?=
 =?utf-8?B?QThGMzNnUHY4MHdoc0R1dVdvWWZDc1JsMUhyVXY0bUR2ZWdqZ0xFQU5JblF1?=
 =?utf-8?B?akxKM0VlWjZEYmQvTGhsMlhyQjlmYVlMUzlDYWlkQm55cCt0Q01pelFhSGxQ?=
 =?utf-8?B?UnJIdkhweDcrMm41OFJzeHRlWktMT1pkWlJBTnhURmMvSnJqSVZzdWhpOE4w?=
 =?utf-8?B?dy9XelV5RktBenVraDdvemRPcGdnTEcwVVZHNzJuNitCYmxtbHFpZndwWUtE?=
 =?utf-8?B?azdMVVhqSEE5bzFjWFR5a0VVL0d2T1VESU5GdyszbkpGSytocGl2MUp0bXRG?=
 =?utf-8?B?a0ozTXl4MWZrL3RSK0VoaVIvelJHZFVCR2FFTXphWWlCWWtNY0Rtc3JyaVZQ?=
 =?utf-8?B?WVRERlk4dVBQVm5vVVlsZi9tbUtFempQS0ZNSmxtV1lFdmV0VWFIR3l5NVJU?=
 =?utf-8?B?aGF5WW9kYnRUSitzbjhxN1BPTEVhalJiQjF5YVZiNVJuWjVnbnYrb0p5SnZQ?=
 =?utf-8?B?cGhYOGp2bkQ1WERQK205Zmd4eWRVLzRhR2grUWV1MUNwUkRrclBFQTZuUDZE?=
 =?utf-8?B?Q3BNcDVtQVhzZHNqeEtBcVVnN0FoRW1ka1NRQmpGYlZDa2J2ekk3cTBPZFhF?=
 =?utf-8?B?NGVCcGtuK3dBVTZKNmNCckdNRFJUSXhkR0R2ZU16Q1NCVGhsbkJ1TWYyODdW?=
 =?utf-8?B?NFl4dkpVdHdUOG9kaFNqamQyQjc2SVI5YVNDK25kMkJDalJqbEtUdHcvOFpk?=
 =?utf-8?B?V2dGQU5NU1JEWDZWRTg3NVNjUmhSVWtmUVlKRUx3OUFpK05jYWdHUUluR3BU?=
 =?utf-8?B?eUZFK3lyRDB5QVNUWSszaXdmRlpNckpXZWZhUkp4SnJHb3JCRkNZYUFRU3Zq?=
 =?utf-8?B?QmJRWVA3Z0p2aWZNYUl3ZU1HK0xuU2t2QzhkL2lnZWRTSDgrRjduZUlCeFVt?=
 =?utf-8?B?S1plUnAxZjZSK3UxOFhTdzdoajV6UlNrOXNlSlhDN0NQdTlDeGwrWFNzYldZ?=
 =?utf-8?B?TkhNZ2s0cW5pTERGVGdDb1lQbWh2MkJSbGd2TjBZUTI4clZSTUFOY3l1RWFE?=
 =?utf-8?B?Z2Z2KzNxTEQ5bVFTRUp3N2pUYVkxZ1A5TVY5MU1oWlRTMmhjay81aUZaL0FV?=
 =?utf-8?B?YStYQm9KRC9mUlduSVdkYSswaml0R3JFd28vVnBTWkQybHZ5bkRHKzkwRzR3?=
 =?utf-8?B?ZlNmQzRIZXA2THJidlphOXluRUxObWJBN0x2UmZQMWFBV0VIbi8xRnpKUjVK?=
 =?utf-8?B?NDNxU0ppd2RacHpOdXloRlVtdVVsVWpWdHdIQT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:12:18.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f292ff-28d3-41c8-31bc-08de25441004
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084

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
index df93625c9dfa3a11b769acdcab1320a6a4aeb4b0..cb2a58c789e992f8b06e9108c3ecc41e14276d65 100644
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
index 5405ca1038f9ea175ea5bc028e801bb8d7de9311..975cd8705a58f68f2ff101b72c893b8a882b2806 100644
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
2.47.1


