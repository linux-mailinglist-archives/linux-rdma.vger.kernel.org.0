Return-Path: <linux-rdma+bounces-11882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3865DAF80EB
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629ED1892A14
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CBE2F3C2E;
	Thu,  3 Jul 2025 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kb0s8FpF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39B2FE376;
	Thu,  3 Jul 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568994; cv=fail; b=Uu1+UXxRTFV8AOgIWBPll68byvhFDSlC8AzUZ1XerGYIX1/+aZad8IWBKz39NpHsih1/XltY7JInPX/IKsTmxxA3lqtid5nYQmtx2Rcmbe+KmQOaDOPtt/a+7bUzTQD+Y1cJ/nxJwTohpK4V872+nAiP0sILiQHS+07/yMRONjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568994; c=relaxed/simple;
	bh=9iuCi0voR0wEwXXeaWg4BLb3h+DZlAYiDUhE3KCNZ80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXizkvJD35jH9OlZpqckQ4ipHgQySdNZXoQNyalZB0aEEwlvqbnw0J5GppEOIL+BJBUYCqQcK0Xm7TTnS1oT06CsenGdSYDJ4edPNe0s7OwwtK6DXXlRVQERYDWXnf10GWsEkykhn7D1uHlifQmIAWUDuqCDM+SLrBEbNGJsvMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kb0s8FpF; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6K8h9ObrH2DzlcDCKsBHSobSqAo4xZ3yMZGHiyaIPuzN7s2VTUm3QPtupEMsC2a+Gq2uOrwiieN4slv58uePmA65H1UsYvnig6AMGUMCSeSxdDGN8X2q02VrchWPSLiQ4eFOAUPCly40MocwArlCLrl1j8u+EaQL6XIbn5H/Q1KG1/W1FSaFMehRte/ByBPbpAIS1wbMRyU1Zh93nssSPxKJMnRwAL7iBaC8b8uF3YsSbIlP3/erkgq5Og8zjD6yKoll81+6mVrmxHNaKU/AHnD332ULW7fgmWa+Ce7LN2ALpbneZB5PrX1QGZ3mxWwkmdADv1ZMRwnmT5GXRpp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBFKve7QIt8PGhuuhv8eUD/NiFexjhTqd7KTxsuC/Wg=;
 b=MNmH6lwg52HDyD9lS9GbtSbjkptVFwwF+XY4aGKpY5wN9AYasAI0nhSblfGYd9g/DRkkvH5zoxHfQbdR8/NbcbSczVo7Te+TAjAcFp5M+s0z5n1nZVZsr9NInZWeeXuTRfHxHyw7p6QORGDRCTzf2G7zYqDeFAB9wnO7XG9iV4/etIWsFxI4CwX6dixCy23ffGOGmCz8eNxFje3uLm1O8AGTaPIR1GXEUjA6mU8xmmbKN1xSoW5Fd8QA4vr8Ixsi/l3e1uLJ3fXFgEeKuMvFlid21RqGRGph55lhGIKL/syd8zav2Yq8VL9H0IBf1arX2jB9LwTp7Bsi0IO3azpjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBFKve7QIt8PGhuuhv8eUD/NiFexjhTqd7KTxsuC/Wg=;
 b=kb0s8FpFgFrdk9xtY4xCr+7CnLEzqSUkztXTFvpszE2U6V4OAsoPmmgdgA6PBU2zAk9Sn4xkm8CZGkmRtuKRFjvjym9z+93XyTggfsmn7I5YLTh61uFAH0cibA+/r5ZcrO8d3O6H5PNnyhLF1KCL40DG70vcQHc5xeMiijhbIa9PZf6itr6sa0bLctaAUh/PuSKCrM7B4dBQdXwgoyWl6aRxNXjpfcaVD9L95O6LxiHzYICp2Xa6NQii348V79v68mgbkCnagsj+CFMZk2VCliNbeTiJdIetkvUANhjUM6O9SXVe0BKInG83UeeL05s2CT4hVCfWDPitcu7vDHe0Vw==
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 18:56:30 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::ab) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 18:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:05 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Vlad
 Dogaru" <vdogaru@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 02/10] net/mlx5: HWS, remove incorrect comment
Date: Thu, 3 Jul 2025 21:54:23 +0300
Message-ID: <20250703185431.445571-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: acca69b3-7a18-4fca-8f65-08ddba635204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFvR/zOJELLKiGidqWHAKaxjpDjhT2NkBcVOnJ/0v1+Ira6ul0j1Nd7b6Yi2?=
 =?us-ascii?Q?p5/W6CYwiD5usn+9T2Vcm9niBFRkYRpA4KwHDFOiGVKO+aGlBbEcqkCElHWy?=
 =?us-ascii?Q?QPI+iC5Q4M22DVWLx/A7rbk5Aeek7IoXB5WX3tMOhyWwd7b5WWLg8gHj24v/?=
 =?us-ascii?Q?PCDc7t5xGdG6vDb5ToU7eqWGVWfavJ6k5EBsQe7hwdIfZfzhy9Yk8bO6Lp26?=
 =?us-ascii?Q?jDdojEdBvNrkUC72gp2o83MIbznQZ3rd0BrEsC1Lo/8L4Bco19kTmB7IIe61?=
 =?us-ascii?Q?5DeF4oIhJO9okD0xKXLmBNnXRSNbG6k2FAEmsy5Vp4jN3u98zkHKlAHlF0YW?=
 =?us-ascii?Q?/mxjZTt5CiQqd7Ag9yBHZSlC9i5XlMw7ff6rNow7vsmV3X9om1ibYe7hBPmL?=
 =?us-ascii?Q?U/1AZDPmDfzepVilmdb6CNlcj7CRZ5rW0XpiWJfutRBXcXY4+fJ/zReZ0N7a?=
 =?us-ascii?Q?4AU/t5wkxDz3qQ5LQE2p/ofBR4+wdSAZRKU2xfLH0kpUWtB7bg8MwQaZ9TGn?=
 =?us-ascii?Q?EjQnflquYg2/v4R9KNp6e7ZZvNTFvrd8s9f/Xgg6oSSdUBw77Q/VxM39GYid?=
 =?us-ascii?Q?NI+TIcz9KUmtvnPTz4W9d4A8ls0Vb0OpPPJZ+qeLciMoo1NtNfqM/AQOcXyz?=
 =?us-ascii?Q?Siq+HkHm5uCneBChKx/mq7IVTtf1+ILi51NUdR3WcglOpF2zsmN9mVafbRcl?=
 =?us-ascii?Q?ApVOlWTDWHhqPFMhQ13WAgz1JbvklI1IhG45PmbNakCIlcU3ijHsY+4/VFQC?=
 =?us-ascii?Q?b/sdpqz8HuDdaeMOAUqBCR3VHKl1ZGpTH/EdQOWLl10Ogj/xKO03eXIDuWQj?=
 =?us-ascii?Q?vdZPP8lCg4TrFgQoyJmk03x0kUPkUwrhssi7M4ikwyvBT7mF0EJUzdLYbDW2?=
 =?us-ascii?Q?aRLFv0a8HUXNkE89Ek/5+P2Qi+Vsx8aR6DE7MwO/seD/nddYXpodKoR08KFq?=
 =?us-ascii?Q?O3WIHxNJQqcpNgzo3bnxnfOdAHqEj1Mc6fqI60C/sWa85ZKuD6IqluUAhjbO?=
 =?us-ascii?Q?B7GP8pa/P3ZC05UsDw1kWvsbhOhtJ2s7/Mr6m4Ysw33hnMeSsYFOTCl4Imn0?=
 =?us-ascii?Q?UdqMcSnG2LVOQLXxyBv4E5P+NsbyuyAe9C5Em31Qg2be3V4qziTkuTkmEFG9?=
 =?us-ascii?Q?pNYkWF32V9q7r89R/4nVoJv0yD4nnUchvwTfVrYjdZPjRJ3H2saFjgQbsIAS?=
 =?us-ascii?Q?VbhFXgY1iquUolwmwkO9SB36wo/VgapCDDgGf/5tBzydGpCIXIfyMGkCmJ1b?=
 =?us-ascii?Q?19OyeXPzMMn2exDHw3drHtDkY7i4b7xDoJR2eBpb2inhiSVux48VNmx+7tnA?=
 =?us-ascii?Q?ulCKrN7oMK9E5pZ2Aqs/RezqEfFNKiUGu/keFbLhb3m0Kn7cOszzx4dZD8C9?=
 =?us-ascii?Q?2KCxSY152XthzQXKHtY3bImjX3dYxmV0SDLxigvxRuI2hNz0yqZ70t+PlW7D?=
 =?us-ascii?Q?yofWbl4vwbxd5L2YWylH/G1rEzEwYrEFZEcCE/QtT+C+rmsmumpHiFLDOz1/?=
 =?us-ascii?Q?8DLRdNMhRrD6i3xvQEtiDCEa678rrJBvrLUb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:29.5084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acca69b3-7a18-4fca-8f65-08ddba635204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Removing incorrect comment section that is probably some
copy-paste artifact.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 9e057f808ea5..665e6e285db5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -876,8 +876,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	/* At this point the rule wasn't added.
 	 * It could be because there was collision, or some other problem.
-	 * If we don't dive deeper than API, the only thing we know is that
-	 * the status of completion is RTE_FLOW_OP_ERROR.
 	 * Try rehash by size and insert rule again - last chance.
 	 */
 
-- 
2.34.1


