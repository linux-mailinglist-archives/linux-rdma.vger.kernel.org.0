Return-Path: <linux-rdma+bounces-15448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50783D118C5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4AA307D817
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24534A771;
	Mon, 12 Jan 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="odI2V/Wk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1C34A3BC;
	Mon, 12 Jan 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210862; cv=fail; b=PgmVK40HvbaJMEsw+jcbEx2D9oHsRi1OBiYNouO9D20ODr6UL++9rk3u2u3Wppbq1tm8FqaSbyEXa5tIseu9Qe4OVlfxXJVtaFXDtIlV0+qOnqv98AV+dr2AiouuQMy6Khl0U+b84vgI2x2AV4heQt7sY/2HBIEFB93SVimCJ/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210862; c=relaxed/simple;
	bh=alg7Tj3Cg290GqhHQT2ZGHJnfixehfOxOlNEd9uYG0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R/rxDk/F6dppECLD9KsiNy0Gh2zcwidbQvTbQBf+5PbWE1/2qzRGzULW9S2zN8N/rwuPIQaCz3Nlno/kA7vXNeiuYNAkvJIrnzFd6NPs+56G2kT9V04Fu5QhIXzca/WTjYbJ0kEhke0PbxgyehXxrIt+jUh6kHPtanYzPgSg/Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=odI2V/Wk; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfDNFLALzkViyYv8YvcjAAoSVWWwEyQnfELJP7QfCpeUXvDhx7rFkBCP0LICJsFJDeW+2ivbw6UuUL5M/kzujj0KDJ7iWzy13jm1TJ44stMkHEk78d+593+619uU3gEIBFPxvjXeu7ypQm97c5koZTihRZ90xBXKH+wwW5kI/e0xTydxkK/OLIih236ThblQXZSzs67a9egf6ViRGvKCvX/oxkL6ohI+TpVWWs+6ilt0JoB3v5MIxirag/16TS1stO5IHLJQVdD+A1s6L/WlxpwssoxqUyDa/ZGwSjPNzg1xKD//q7AuKQImRaKVT794OQgfif7TkjLNfPrWepXJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDOQOQycWa8/cy91l4DfURTbYruprgo1YPTAMgvHp5g=;
 b=rMWWHEW4l710DfoTKVRH7IJSr5WhYkZC10fHb0+c+bjR5oRF14Mxl8vI8NhIjRUFwDkETWKPWfSn7va3P+kMuf23eHxH1g200JbmAawdn1LDDpccZ0e8Ti9/fg4RmIy3318HFvcgHaURVjqjJ56y3r7RPUYsEqheoBewQ0ajKXPDTN3ptRdbGtXSPH15WfRbF7lB387BPfC6XR/5vsqkyA0SzWdJtDtlsgjnjSJJ8XNtCZruBHfc6xbn3MwUGvC/njXVfteByNiA9b4eN+Mcma30FSXO5zinHV/MWHGY9DPqTSE2y0lQr9IbEJZWi4MNHBLZxIscejit9H1XQFJLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDOQOQycWa8/cy91l4DfURTbYruprgo1YPTAMgvHp5g=;
 b=odI2V/Wk592cMsXbDH+gIZHTMbQmEKPpmPj55ewzFJ1wHIvf5B7yMzyS0pr4RYwul3BxvmfsoH49FZfY6juOMjK9SUkj4KrDCNvAZohj1q6SCA75wZICuMZ3baZIEBpv9pT0WLmo98tG0k+gmFmbL4tIaLhmXI7dGikJ7Du0JAxhfO2RwcwVMgzfrjB+P84HvM6rDLVbcLuL2a5WHW6ErEcfDnJ0HwyoPCAtaNroP5E0LmRhbsIhO9xBHnXUz+81TSX1Qwtlp1xpHeR0cnzCNFKFO3y0+xQ+T4YwvmTSqlCghbqSvA0oKixLI2zBjb6ADQHQ1E1T50S+5rTzXRBUGQ==
Received: from CH0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::22)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:40:52 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::8) by CH0P221CA0022.outlook.office365.com
 (2603:10b6:610:11c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:40:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:39 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:40:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 0/3] net/mlx5: HWS single flow counter support
Date: Mon, 12 Jan 2026 11:40:22 +0200
Message-ID: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a8640b-de1c-442c-1684-08de51bead2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1haZ80cT0dwObDhaJJuZl4BvpqUOuHj0+EsaqSU9jNBAM1AUQdcwamnDcosX?=
 =?us-ascii?Q?n/4xRydlGorNY3pqo27hZaJgAvRgfhSEWisyYNaTV4lG/pjFHqhmZYV+7tFT?=
 =?us-ascii?Q?SzIqsELiiFt4uMkcnBChUodNDAEfpwzgpBhZIO/jZpi8QnJQoMe6X2VzpA4u?=
 =?us-ascii?Q?0I/KEioL7bT106TDBygtlOc3ixwxMgoDSsnMKhpJjjZ5Tl5+VxvwO3uhx21J?=
 =?us-ascii?Q?ldywOO3FIPvr70xFKbM0FMJHfyghHz9vnFQ3PwI5SvNImEO6oc0kOCTXHzEt?=
 =?us-ascii?Q?P/INnGiZqKy0LBbV6CB4jO2B/98ypuz+n6BtFbTlgbScMEswlgYAE+yE8PIe?=
 =?us-ascii?Q?gJsnrJQavhgSX+FkafFPIMtTmdMsdghK5988t4VwFYDlthfSKSKCVw23uSI0?=
 =?us-ascii?Q?1V0xcIBMq6AFIg99Z1E8eAG70cx3phiX7E6oGz/KmHqQ1HOdxjap24kgIzCF?=
 =?us-ascii?Q?5PLPIKJbTAnLdBxIb8uEOe2G1lYsEbVZrRrNwiwnfcOfp21SUYtSbUEmC+q3?=
 =?us-ascii?Q?EJmqtC+gxKlJpFbgnXaap12hOvm6Vu5/HuEzJYuieQtNNoa5silX2TUNrIug?=
 =?us-ascii?Q?ThLd7xPtpatME1FebA8rfXhV9vVAnS/fvntHeoFgSIa+FatkG2TPbMs2eckz?=
 =?us-ascii?Q?dznCwYGeWUvS/ahihFJsgOAN86hQsV/RzuxpVwK/aFQi8NsAnQ7oRWQRn9m5?=
 =?us-ascii?Q?Pwx4faHngDmbT5SCDpCbDKQbk9ZNfpIgGD7duTNJXoJmIv0gGHS/wUpDkpJG?=
 =?us-ascii?Q?9McPyCTDj/murNBTeG8h32q+bqpFXDfiWYyZ8+cjBCW7yzr8N9PASFVehdL6?=
 =?us-ascii?Q?bnQkeEwxEmEhiEAMSCA8Gf56fRgKtuz1inmOFvWRBx+4AJtJimXQM2j+7ZkW?=
 =?us-ascii?Q?PrnrNzvFIwJIJHLc+8NpdBaWxYyv1SMKhHQcIImWHSQh/LehLn7SYhyugHoq?=
 =?us-ascii?Q?OpVLs7OBEixF/+OCBWLcg1CkFTBhHitgK11/80/alBfTi5pV0SO0mXdfeCt1?=
 =?us-ascii?Q?JsPvk4T3feqPzJNOtLnMsvbb0quavgJAgp/gI3n/o24IOLJza1Q/vxNUXWuH?=
 =?us-ascii?Q?uQDrGIvcVnvssq1ffsWu0klzypY3gUMEcs1f8by5DEMOs2pVrIYldhipSOD/?=
 =?us-ascii?Q?sedUmNJxUOZKVycfcF/a0eQbgA1xEEJSpykt+8vmvxqYVHuPm9AU4dmk+ObT?=
 =?us-ascii?Q?iMh9okPs9MDtXo6ppOpuTTpNnDcC1a/HBHF78eOPOSL0dgyv2QOX77bfl3ZE?=
 =?us-ascii?Q?aH5TqIQT3AZHOW04U/IVwZV68tVLCXCFOEMvDXsdlF1tXE1U0hueOYlZ20/j?=
 =?us-ascii?Q?XQXxlE9cKueAr5kN1PXBQt2xLVaCFmwnXNA3u9K1uCy7CnvDYX92qWsrajMf?=
 =?us-ascii?Q?Bte4wvqBGABKYyY0U0Tg3dzhb6tWDqzhXok1aLLKD7J5Mi9F4wsGPkfJGSMM?=
 =?us-ascii?Q?a1/MVlzKzr8TpyN1axONN1RpYYNP1aXwVhg68M8UBvs+h1kTJKaec23tzo3a?=
 =?us-ascii?Q?WMHH11gsFnfCSckYnlmi35LCw8gWLuxsz6qN6roZmNSCYu2AVkR/rt6Mdg8W?=
 =?us-ascii?Q?KLr2I5dNZZbenQBXILI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:40:52.2386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8640b-de1c-442c-1684-08de51bead2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798

Hi,

This small series refactors the flow counter bulk initialization code
and extends it so that single flow counters are also usable by hardware
steering (HWS) rules.

Patches 1-2 refactor the bulk init path: first by factoring out common
flow counter bulk initialization into mlx5_fc_bulk_init(), then by
splitting the bitmap allocation into mlx5_fs_bulk_bitmap_alloc(), with
no functional changes.

Patch 3 initializes bulk data for counters allocated via
mlx5_fc_single_alloc(), so they can be safely used by HWS rules.

Regards,
Tariq

Mark Bloch (2):
  net/mlx5: fs, factor out flow counter bulk init
  net/mlx5: fs, split bulk init

Moshe Shemesh (1):
  net/mlx5: Initialize bulk for single flow counters

 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  3 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 47 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 16 ++++---
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  5 +-
 .../mlx5/core/steering/hws/fs_hws_pools.c     |  8 +++-
 5 files changed, 55 insertions(+), 24 deletions(-)


base-commit: 60d8484c4cec811f5ceb6550655df74490d1a165
-- 
2.31.1


