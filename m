Return-Path: <linux-rdma+bounces-8679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFEA6010F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911763BB805
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B61F180E;
	Thu, 13 Mar 2025 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sqWp5XQM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28131F0E44;
	Thu, 13 Mar 2025 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893943; cv=fail; b=Sao4gdP3nWJLkAkTHkWKF/RTHTfautCQQjD5YgdWekwclVLwzlk/yTTTUYmuGAn6naCJEFiTBDapEmYBkEdvtOaTIwODDr1Fz+1bfthAAvHXgO2xbF1h3Z6dxgvmzy9tP2suCbEFfTpGnc7+aR2bt20VGL6rNuWgjBtHRzMePAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893943; c=relaxed/simple;
	bh=5eB9vr0RT07eCxtNtgANiwY3dc3KtzTrQrX1VPeD6TA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TWrilgOvsG/gYSD7b9L3qrCxGAGe9EeJKeuH94K7uLdhcsycc8RQIiiiovXxpKigcXcuGKE+nk1+3nm9neZ2obqPnLZy9DyLDRYv4b8O2tyhDFuyh2P1+SwiOeeCfWRl2Cj9YzYdlrOLHJtbEO1c2uJYLpG/jx0ru810fwm0h6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sqWp5XQM; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Phy5Ccj77N3M2dc62eBXmuZRW83sEH7YkGJPxiMRv7W9upOsKLuHQMMU5MKXppkb/HFMZRv5+dzedzgXl2yrCft2qz20GQiduNnXVwURr4ukdsPKbHe7qiREkEKGMSpmJLZPSZdw5u45TVN+XDtqDDSctVNWusICKhh/4yDlODpF6//iHhog7NWlrUNaVk+JzAwG2TKur4ybWPqi+3ZDlnwBnZ9VluTDZxI6gkqUjjQt04dG6dmERboGWCgo3JV9lWBZK3kCIXiZTDgrsDf8gJl7IeOIwvIXz+jwlOjTTCnCWmv6LoCmHlGgYVwZ1ufqFz+9/F5MigccfirVeb47aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5MRLmhBJU8aSTKN0l/nlnPlE/Kob1c+1MwoyVE1foU=;
 b=hAmlDKWvlQ9Vw40vK3b+ACjZ5+2v6vJaI/JP62u/yigRJpaCJ3aPoj4ZuRipLA7Xkja6nBoaAKVb3RYfkQAD2P/LVPt3viJOO5tpc1VswCZt8RWZYTC6mmS3mTw3fO6tYFJWPvergglU0kOzEzt5DOkzD8jAup5kOX0Chi7SDVdftsHtiapmbRo6lt3fFxYGSZ7g4PnkAxvTWvg2Mn+SbqB31aqgMQ4FYPrK8xqe95rMPjsEaK6CdWJByRZg/zFp+ATwnhmDR4u+Rd4HACsnp9ifysINYRGwvrmHWryBuB2Iw244DGHnnrJdZhYgR1Ek9p2iNFqdF9Z/5r2I31zf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5MRLmhBJU8aSTKN0l/nlnPlE/Kob1c+1MwoyVE1foU=;
 b=sqWp5XQM2HPTSUcHiwk9QArQWgXc9xw3a5dGCbveG7kU1nDPaiSaiZ4d5j/g8Nbff1ugbX2CxCBWDrql+geaXOaxbYEvyapQrvy2cLBpnIVbfDoha2IkaRUUF4Fg98WjhUR2R9/YYxghyrFfW2ST1Vg3kaCfszADBEKsc35FjPkuXn+BW4CCuE6UaryHXBWNSS/GPZSfo+6mXWEco7eNlOgejjcdVDuQZaAoDauAu/sYds1wLImrFE9joxxXI29Ah6SDh1Gd2BSvBnef3wdyRfb4xBjunnLMPcUQ/Ws8EfQ8aYZMx/hrQ54NxzcUx3cW9hrH6bHyogY4XqaERt37wg==
Received: from BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) by CH2PR12MB4296.namprd12.prod.outlook.com
 (2603:10b6:610:af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 19:25:38 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::d4) by BL0PR1501CA0025.outlook.office365.com
 (2603:10b6:207:17::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 19:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 19:25:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Mar
 2025 12:25:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 12:25:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Mar 2025 12:25:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yael Chemla <ychemla@nvidia.com>
Subject: [PATCH net-next 0/4] mlx5e: Support recovery counter in reset
Date: Thu, 13 Mar 2025 21:24:42 +0200
Message-ID: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f788e26-0115-4dbf-b176-08dd6264d541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7Hz3C0EZrEjBc24cBmcSQ3devmvtsdUS4x/Le/wbmdmjAmePTm0rTurnCgX?=
 =?us-ascii?Q?sX/Qg+yz+DZ94qGTQb2zmfV0y4GAdhOKu8CvrBMDyMw12HjGWEhZgPSrLtfY?=
 =?us-ascii?Q?hpMpngA267IwMuSGPxkU2N+emDX3m/fnPVglKgOuc4aX7aVFPPpE2tOvwgzA?=
 =?us-ascii?Q?fBWVjIxYaLmGT2DP7FEB3+t66nSiukc+rjnIpNLf4AO3SFOgKaq5K54t0aCu?=
 =?us-ascii?Q?LGrHuzjbEfZEHl3WBwv6Ecmw53dhCxzXHR+jcRz6ADJZujCelLxStgE+nGrH?=
 =?us-ascii?Q?aD5kunpZ9pTnBH18r7AKL7kruCc1SSEReqAIJeWdTNi/95czzNm8GDJ/EAoH?=
 =?us-ascii?Q?6+j/2aACUYhm8Tn8WYOrHavAz74zUT9qiPOdJiNJ8rbiQAnv51WfCxxy1q4L?=
 =?us-ascii?Q?XB4TtKcrXLNz1UhmyR3kXe30CCQOLCyJrYSkD//BGE7KfO5dc2X6NssPIdvQ?=
 =?us-ascii?Q?V8ndIj+IXTCwULILAOfzA4gY3pYhM7OmU85DodtZz9pEHSyjZkjQxH5ik6OY?=
 =?us-ascii?Q?2/BIxFgNmKo2WH9rULx2Ec0P7Fpbai/f6/ITygZLd14UR4/wqprA8IFn0iRq?=
 =?us-ascii?Q?QpTg3W7R01CVunDOsUPWnBUkXID7R9ro1V56ZvSwQ5mqAqlUW/NtS1yF/xE5?=
 =?us-ascii?Q?R6Z9Igi5hKaY8MfdF4Ub5yyj9ThAfDwpWifHHvymZId+YuT0/6mfQOXPLA07?=
 =?us-ascii?Q?JCjPqwRw2hBoCPoAW7mGqVVGbKZt0V83pSUqGPJFUZERViI0c4A98CZBr+Z0?=
 =?us-ascii?Q?kPOTAtF9JCgLS2IV+BbdNc6B0KkJeoY2ceOi6pP42zXJzdM/ErRY0Aj9yEkl?=
 =?us-ascii?Q?sDz7iULtH0YJwF+SEKMSyQs18/s6DOxV3Er9xvRKgJuiVInTbEP2mCWlQpHv?=
 =?us-ascii?Q?iZE7gQeevKAfNNh5hNJGzh4NDnK/tLsbLzlgVv80VuWQwXlq2i94Nivg2j4F?=
 =?us-ascii?Q?EshVc1pRpsbyItnAgue1daoHT6Y7NmS9t/PCMOKjRNQBmjkyUrOQZ1LJxxnW?=
 =?us-ascii?Q?M8gVmsYJaDpBmI6YMd/eormw54Sc3x1BnIjq2Lr/Tu4BDvM4SwyfikiuZBwW?=
 =?us-ascii?Q?puXgg+crRBR+jQkF8p1AFJkk63GmXqfz1qEYVjc6R/FwDRF1ASm/TyF+mvCm?=
 =?us-ascii?Q?m8H7uzzHUINv9XO6LzOrVjaeDOW7tH8M/uSCsqJMYVrCUot/LpjmLCnoWNqZ?=
 =?us-ascii?Q?YkYquE6GuahsNP/6mbhACkYm+p530ulYTbgmN06oD/Xgn40crmoXNlCjwM5j?=
 =?us-ascii?Q?TnS8KrliNCBwW8D+JKSPhP982Tfjy+2hu05yEgRvhC3dwglmTMuCQjVexibw?=
 =?us-ascii?Q?V0Y02pQ0XeC1CfypfYgIonUNy3IBdbSBRNvFhDefbSb3O0uFDlyB1uoMlCeY?=
 =?us-ascii?Q?AXdrkcEsK32x7ktjKU+kZRYy0/Bxg7lMHnc+JTdub7bHjtWAMOTocdI3vEuM?=
 =?us-ascii?Q?z7IEllf+H034NG0GN6f28uUW97NZeq5Rxhvb0lt1vILqpZYYcpWv2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:25:36.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f788e26-0115-4dbf-b176-08dd6264d541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296

Hi,

This series by Yael adds a recovery counter in ethtool, for any recovery
type during port reset cycle.
Series starts with some cleanup and refactoring patches.
New counter is added and exposed to ethtool stats in patch #4.

Regards,
Tariq

Yael Chemla (4):
  net/mlx5e: Ensure each counter group uses its PCAM bit
  net/mlx5e: Access PHY layer counter group as other counter groups
  net/mlx5e: Get counter group size by FW capability
  net/mlx5e: Expose port reset cycle recovery counter via ethtool

 .../ethernet/mellanox/mlx5/counters.rst       |   5 +
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 119 ++++++++++++------
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   4 +
 3 files changed, 91 insertions(+), 37 deletions(-)


base-commit: 89d75c4c67aca1573aff905e72131a10847c5fda
-- 
2.31.1


