Return-Path: <linux-rdma+bounces-14754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7FC83AB0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 08:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E86CF349A1E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152642DC76F;
	Tue, 25 Nov 2025 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TsAscnSB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D22F7AD0;
	Tue, 25 Nov 2025 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054826; cv=fail; b=t1NWthL/Yk0A6Iuohww2vm1Ukwqht0Sq1xqsfNerKJBDjWUYn+CoJJgCtxadKdaDGKr0aywdKFTgm2Gk5bVSmKLko5tHiqXgA63UvfqW0rlj8ztca6ivLWEy14z+fcLPYGlmfbTKbiU+A33upDVnq9w0GFZe7INO4zGQu09/idg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054826; c=relaxed/simple;
	bh=JnL/DAZc4PMfDZeSPN2zXtUC3J9z3OpUHe9GBSiXois=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tj4Ubur3Fy0ES7ph/F0UY/PgplwScwUpEo7RZp91ga8mJB5PillhzPLumuw2sqA32y1b3N3+p3dgDqI1A2SZmFVtq5me4Nj4Q/iXc65pR1BtFgzV5Vyst2wpUSmJU4F3OaRn83djXNmzCkcvgGOdDkEbUCVjvuYtFISQ1ixkXbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TsAscnSB; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzaxnfBV+u80X9v30vfCnQ3ivmibKEMsTdoX2qg/vqS8RN/G9HhCMF/Cf6kEfnTjQoiEa4XhqzNcQqoMH0GL3YOWlxpragQ3gJgZKCyuME35JoWL50tt08WyCbtHQ0TzsnD69hP6zmInGKVFKdktWjoDQjw3jsGFeAB7ZFGlHsMKEV6xEm49xF3eV8Z1r2HKAVQPRJUEu3+jK7q0ZgaWcxanB3TotuupTgjDNuSMsblPJuCwniyKAfFgftWP9N8wGa2+aaIdurXMKHF1uvC39xomKOA6tyIioh5M3VaFbFOqIWCCgpvCIhda0G1vYxTIIX2l72qdHizgVTW+cOdHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvMkMIL8F+FvE/ys1KfIO3v74xOIRggHZLCZHrHj0K4=;
 b=iWpNIufnU75W2nWT60ecvMPOE2zj41KMYFy9h9Ixspmo6ij6uZiMKD3ScbJipBDZQLv7v6oLcANKI9oN73z4nGbhutN/n5G2CDuwMdHBe/1n3O+rdw0l+B+gUPZ5lJt5dxuS1Z9ybzYoNHlnJzvOz/PvGiY11dyFgKaWJNSPLnK0FIuEP45cXNgtwBIDzBrSVDJOiATdtlwEVaDbwpeeTMvfnLGWIN/loTk3zsVbJkhWrEAnzZLZXcUUuogmH+Axy8F/VQSIogQNLxWE5BNGlS515dF00h9X1ZQpOj9wFF9DN50x70U39pqkbQ8EtLoPhzHUvQGSnhnw1H0pHrD3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvMkMIL8F+FvE/ys1KfIO3v74xOIRggHZLCZHrHj0K4=;
 b=TsAscnSBDG/C38gwb4QO7YYRjG+vOLkZHqWkKqAe4rMwvXw4n2arNvaXjE2zYhEXWZJNnWgtrWxHiVSQ+y8/e4CRLc9tazE4Go4gVvDprDzbvWIF7PGQW6Ip3tNnDBRH95K37Kb3I+RNIO+W+XSfOdSQ3qw6Q0UFprLQnNyIsUyGMew4kwtTKu8aqQhhzPdZjFBLT4ejEGdSTklWqhW76jhAckjuNlzcWwOX0lH0+FQt7mIY+EVikdLd+kbHO2VzIvDbEG0lzuYZXCnggx2ahFfvQ3znTQN12iAT7QmZq/qXcZJav08Ee9GT5tUGhfboP+i5AzP1iIYnGqvYASg1Fg==
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:13:41 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ee) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 07:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 07:13:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:13:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 24
 Nov 2025 23:13:24 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5e: Refine TX timeout handling to skip non-timed-out SQ
Date: Tue, 25 Nov 2025 09:12:56 +0200
Message-ID: <1764054776-1308696-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
References: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d988bd-c3a8-454f-89df-08de2bf22969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXQ4YUxxRVlCT0wweDV5Z283ei9SVjJqdUR5bGFHVk5BT3kvY2V5NzhseVJs?=
 =?utf-8?B?NzlhZDRZRkhoaG9ZL2g2TjNCR05GK1F1cjhEdWdBWFFLZEpZbnJ1ZzcxUnJN?=
 =?utf-8?B?c1NDN1BuQ1FzMTVvUnFzQmRzU0hOWVhqK2RCSkJ5dHRid243dHU2UitZbTQy?=
 =?utf-8?B?RG1zczdqRE5QWVlxUi9yQWFLWlptWGtlOEJFQk9EWjhVUlZZNHJlT3MxcHoz?=
 =?utf-8?B?MWdjUEhyUGhlNlZULzYyT2w1OXNFSlhYSUtybTFKYWlpMnJCS2FJc1RWWXpX?=
 =?utf-8?B?YjVqVWJOaU8vVGIvZGJkOEhZc05mTHFvYXNsNEYwUXQ0Q3JsbnQrNHl4QVVD?=
 =?utf-8?B?N3laaEhOM1JUVmE5cC82bThOK3pjN0Y5NW5qbk5tWXgvWnE4aWVVSXpxbFB6?=
 =?utf-8?B?SUphdzdLMzFsSlRycmZiZGZBLzBmSE1uTkhobkc3QnlRSERjS0Q0TW1uZmwv?=
 =?utf-8?B?ZDlXOUFYekhvU1prL0xuS1hrVnNtMjhiMnNPclhjekwyRWVOVTNlSFlHN1M5?=
 =?utf-8?B?K256dTY2U2R5RWNQc2NVbkdrZDh6UytvbGFqaGsxNTJYbEJ2WU1sYUlFdVhH?=
 =?utf-8?B?ZFBVeXBPL0U5WDI3SGpOTDFNYjZsMElZQjMvMVlNaG1PU3BhT0o5UXBHM29X?=
 =?utf-8?B?NCtmWWkxN2tFUDVFWUpRZStXM1lON0NDUWhudnJDRGhrZHh6NUh4OWJBc0pY?=
 =?utf-8?B?dmoySmM3aEhLZ1BwU2x5SS9FWG1KNXZLQXVFczJGVWFIN210ZHcxSk8xZ0Js?=
 =?utf-8?B?SlA1Y01VN1JnaGtoVE02bUZ5OFYzZjJOZEQwUVFnT0Z0SFlwaHNHYkMyS3pr?=
 =?utf-8?B?Qkd0UWF2cFNOeDF6cUlBWmtEd0U3dTlOYVd5SmJ6ME1UVmlwVVo0MEVFZ0ls?=
 =?utf-8?B?cHhvYXIwTFhSZHJUbzRqQnJ3NWw5R2tRQ2J6OTRqWHFCM25XZisvRjFUamht?=
 =?utf-8?B?SVJ3WWlYZVorWDBDQ3BOQUZ4NjJZTUFFTmR4VTNKRSttRHFyNzI0K2JlcEhh?=
 =?utf-8?B?VFZSRVI0Wnc0M1V6b1NqcGRYYmIyMFgxYmM0SEszREtucnVudlFXRWNudlNM?=
 =?utf-8?B?YXNjS2Fna05JaVJ4TjZKTzNTOFM5RGtLaHF0WFRpYXNza3h6V05zbW9BWWU1?=
 =?utf-8?B?enhVT0RZdlZkS3MydStsdVptQm5BQTdUSzBHNm5nNEIwR3ZlZ0lLOFRQTkY5?=
 =?utf-8?B?RXBrTWtFU0lnOXhoamlVZ29DNnRYaHFqM0NZRmxFVXRnVkx6eFJSRGg2WG5y?=
 =?utf-8?B?M0k1SXJoMmNhaWp5VlRFa2JUZlRmclRiaTk3Skg0eXhiM0VtMlo5MExCWncy?=
 =?utf-8?B?cjg3bGtIN0RsV2NJMWxqZFQzTElmU2xZeFd0OUNFRG40Mkd2WEg0dWlNeVQ1?=
 =?utf-8?B?K2tJZGIwbW9JdURjQ3JjSjYvYkc1U2pkRHdGWXpDVlVZUTEveko4Wlh5TGV2?=
 =?utf-8?B?SUN3NjdLbW9NaGtYQmxQUTdxOWszcjlpTVVGY1ZNU1prWVFTZlpTQkFKNE11?=
 =?utf-8?B?OU5BNmdVNHZXZjFrMUJnb2s2TUVsazN1QjU5N3BuSkswa2tUODJWZ2pnRWYz?=
 =?utf-8?B?ZnVCRVFxeVpSQWlsd3ZBYTZqUW05b0czb1ZMNUVkYnpwQTM4bnIwNzZHcGxI?=
 =?utf-8?B?Nmc4MTFBSTQyWjRxZGF1Z3ZjYlNSUkdtbXB4dS91Rk1FMEVydEpqZHJxbXpL?=
 =?utf-8?B?bWlwSEF1U2M4bEdrNk1POUMybFhNc3VhdWdDVDkvTHFGdDZGWVY0cUUrcS9Z?=
 =?utf-8?B?NUFSdXFEU1UzVjBtYnliV2t1MjlOM2VVaU85TWVQNFloMy9nanZRR2hjOGpp?=
 =?utf-8?B?Tnc4UGhMY0tWeExnb3VvRmVxNG1UMEZCeVpoOEEzS0JQYXhxSUg2OStlVW9L?=
 =?utf-8?B?WXBNNFdBdk54WlhxZ2MyKzFEa0FzbVpJVmFJV1RKanRQbkRkbUVQWEFxaG1B?=
 =?utf-8?B?NzRKbWFpNlc1anlRV2lXT1NvM0pYcjg5M1VmelE1ajczbzBONVR5dXl3Z2Rl?=
 =?utf-8?B?NkJ4RGFZclc4ejhuU2pLbTRBN0ZqUHFkeW1nOUdWN2ZmaDFTTGx1d3hmZ016?=
 =?utf-8?B?Z1BBQ3ZISEtKMW9zd09zb0ZwbEdhV1VZYUJlYlFRdWFhSkQ4NmlXTjJ3cTM0?=
 =?utf-8?Q?yXvg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:13:40.9395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d988bd-c3a8-454f-89df-08de2bf22969
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

From: Shahar Shitrit <shshitrit@nvidia.com>

mlx5e_tx_timeout_work() is invoked when the dev_watchdog reports a
timed-out TX queue. Currently, the recovery flow is triggered for all
stopped SQs, which is not always correct — some SQs may be temporarily
stopped without actually timing out. Attempting to recover such SQs
results in no EQE being polled (since no real timeout occurred), which
the driver misinterprets as a recovery failure, unnecessarily causing
channel reopening.

Improve the logic to initiate recovery only for SQs that are both
stopped and timed out. Utilize the helper introduced in the previous
patch to determine whether the netdevice watchdog timeout period has
elapsed since the SQ’s last transmit timestamp.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e537df670758..cd146df29ada 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5139,7 +5139,7 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 			netdev_get_tx_queue(netdev, i);
 		struct mlx5e_txqsq *sq = priv->txq2sq[i];
 
-		if (!netif_xmit_stopped(dev_queue))
+		if (!netif_xmit_timeout_ms(dev_queue, NULL))
 			continue;
 
 		if (mlx5e_reporter_tx_timeout(sq))
-- 
2.31.1


