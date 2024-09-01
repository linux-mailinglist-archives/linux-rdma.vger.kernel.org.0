Return-Path: <linux-rdma+bounces-4673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDF967414
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 02:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139352826D0
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 00:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577118E3F;
	Sun,  1 Sep 2024 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJ7O0dOn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627A4A0C;
	Sun,  1 Sep 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152124; cv=fail; b=XqkHkzIt2J3PAdeQmFMrTCeOXY/WKDi+IcLZ46iHmBfrKYV41Vo3X8YvBveDKWfcTvzTWMW7X8DYhwlFceqsjD9BcI3IzfhpIasjmSL1fxAYwBPUGlDzjpTSWg9scF6SZ/B5d2CNq6Pg2GUfCiw09W+pP1MgwMvx86Av9Q1Mbd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152124; c=relaxed/simple;
	bh=Dys5Bor1G0q8rDEIRPvMRWqOMP7x2fEpn1YvoRSGdpM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vw3ErpqSDSdxGYeViqaihdp9tZRopMdPyqFnBRu5xtGTRIbWJOevaBJ1JXUg4KYhZZEHPh4wTOkhur9baCv7Zo0pJ6k+psqUsT6elVOtOvjvH5PbefvlYdvcwWmb+59ka/gnQ70TCBtKxH1uz+zBh6PBHO1y+7cGGJ66292gp3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJ7O0dOn; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMtzEMexK9K5yAcBEdcaD00tUpbINU+zLd24K4En0N1OsrV/dqKCXnJmxuSOh4OHDYt6DPtLdwy4k3AXIh0OLIRFBcudaSIGoKJYXadjlfy1iWAXwKDB1gFgA+rjsfH8ybcDceokjNh4c95dnMCfRKGKNSL7e85Q7ZVjJHTmpobBDr/+OhM1n7wzk+7P5SHyhcgNuXT7LtzVXE3DWAnvWUKCUMwsKGKKveETx8jrvN813TRpjzS0GlamDjOj1YFm9X3sGPBGIAtblfDWY6P4XiZAzxR/XIAbqfxhkmqZGdsiiOj0QoP4Qo+aDlGXqUGH+tnkSUstNEa4OZ9wSR3BXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW66ERXIjr1360/kKv1fZ9hPB+rs5hoiP38QXALOZf4=;
 b=pnm6sUU+yCe5H6/BLSK2vvChOrDIMjii/7D5Xd1AOhx9OeNuhc+PgfLoFL+ku51V8FoM0dQrlBkEEbE80ZLB9y4jh/kIJyW0eTUsmkTbax3HusSIf2S5HPvIRifZpH1IgHT3AwdcUjo3iXushXOcmtzHj3yz8pCtNgoP4XEcjKhmx3ZXlcG7rQZLYJVdJrlgOApG8BGebtF+DMhohkrXJF/S56tZrSNDV1vZYG5YS6ZiPzus9VdrABJVFZyW51clX8wp+8m0NPuyECX/47zsW2IJFkwO5Toz8GQg0KPspN9imsWBSYo9a7RUpjOLRufJy1rSMyHNPtses3Vc18+j9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW66ERXIjr1360/kKv1fZ9hPB+rs5hoiP38QXALOZf4=;
 b=iJ7O0dOnRG/0nFXTKbaLB3Ui+OsskoXLT8EBT6C5P5a44GSUCv1gp1P7ddmciCrOHVpmFq6ppilaH6ClAOcgrgDDvbPEC5DKHdsWjn8PXUoXhaMt+4tsHbTThQS13OYlSYQ/KjPOW9E1b6+c1HzefNmbNu34zNy4IvgX02/MuAD8CUUx7VpMaE6vXHXYzMLGezv5c0h2k0n9CEUz8nGl0silezgzMOCWHmNR3oW6J5FMBhI/NBuwx1XRnXduv3ST9TBImza5VMq3PEP6n8sU6Ue2zsBGFj1mPjb/CrVNbaYEWKGE9xljnSQ9bXaSF8w6TwCu0yW3stPsoTbUc/QSbg==
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Sun, 1 Sep
 2024 00:55:19 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::41) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 00:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 00:55:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 31 Aug
 2024 17:55:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 31 Aug 2024 17:55:17 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 31 Aug 2024 17:55:15 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [RFC iproute2-next 0/4] Add RDMA monitor support
Date: Sun, 1 Sep 2024 03:54:52 +0300
Message-ID: <20240901005456.25275-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 18406376-dc93-4818-00d5-08dcca20c005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3GiAVZMV5RiE6zkAbAt/+Wus/PQkcd943npg8cfSfNWqwSQSc4pAJmB3nTRI?=
 =?us-ascii?Q?ND96yQpyANnsePXFQi6QPbykMDSofoTK/0OSKCyR/k8Q1QKbM2umu6W4vTfm?=
 =?us-ascii?Q?mhtUPClK0j4YhoBc8o0V/ty+XasvG9LEPAPSuAnibIP1j59NeeYDwNbXkdrL?=
 =?us-ascii?Q?SMuK7HOjH5Xj5ydvDbHUq3wzlxx1XXsj2BGvcCR6P4BY/NwyMiGJ4UAF+dMi?=
 =?us-ascii?Q?rCDPZ/s3tCx0Lc1yorNwgtwrMpwdoSEy208LlUo3hwRmRgD8W2bl03rRzASH?=
 =?us-ascii?Q?9kvrdsp4hG0XcBD4jK+9fMuTztd3H7/PYbZwdJFuEB6XEV0dwdb6KT1O5oJV?=
 =?us-ascii?Q?Ciza4VL6+s3ZR3cL+V+vIwuASXVydQgOXKo4nl83yXukyj+CxHLmZk4hZCds?=
 =?us-ascii?Q?WTH6O7+XnrrtCbfpmrRAKPw/MrtUPqnw+hN3QUOvMj1KJNeHKxwxtU/OuaDc?=
 =?us-ascii?Q?J3w56g+6vwCdE71NIm1GabvLJCXufXzNr0WXZCsSejUNbOfdE09Bb/qI82HG?=
 =?us-ascii?Q?jhWH1kU6YYH8HZXJXnTK+DmHomueGXYa683XeRhpBLYjwva6ZhPviurqIU3O?=
 =?us-ascii?Q?7J/NucCa6as6QQG3GBirNSEbRb3BcckQ6pqpZgmEQtMXJQN2gJ1WAtCkpKYi?=
 =?us-ascii?Q?nW8XSauzzbIor34Gzm/9+T8YbU9/gfDOM0s4aimw0qg99/kJtQA3DWg++PGr?=
 =?us-ascii?Q?Ka1c8l9AJ2UCTpbDA4zIk15j5ZvoTSf+oj1p92vNjr3OK74+IM3z4d9/5qpC?=
 =?us-ascii?Q?56ivqTquWe3ZNYSDs92fYdbL8LvvYKXg2l+NQUM1LNU+p5l2Dz7QQpLTI6xW?=
 =?us-ascii?Q?JAuTlJyWhnfEh54+zC+juEF/sXkjwksOrZbMTdruULBBENzACPDF4aotsBnc?=
 =?us-ascii?Q?ztCL1Hs3SF6Jt8jBD+ouNj8aKWDGIQMZTSmtocP9cm2oftnnG5eN5zSyQs/3?=
 =?us-ascii?Q?dWZ+tHo2u6QXOIpPu2nKvFCTJ0ZJd3Tg0UZs94hxPegIppK1D9SpOKHAsC7C?=
 =?us-ascii?Q?u7xiFmiBdTNfVOXSOflngrHTSSw7t+lExJ+kX3pLBuNNGd9lwtAPzg6uU82C?=
 =?us-ascii?Q?Tbb2s925yxERntZ3I47OG1/PFaMuCIXLlEXH+SL5skwheYnAWpjfq6G8lwdb?=
 =?us-ascii?Q?70qVjJHao2iEZa+uGcV+5E8skfScwFLPiFe2QOTBIVgcYetLZl2CM1xaNkeI?=
 =?us-ascii?Q?CwIHmpkF1V6VWioN2ER4U6fBQl0xo9Em7nyfZLE/OHg3K5emsepQ08siVS9e?=
 =?us-ascii?Q?Wem0qjDRvkfEgN+5mtF0iSH4Lw+gsCMMPaL3coheu6zIcEI4L88ukpHdQ1jW?=
 =?us-ascii?Q?HYC+SVjCD0Tx2jxjoxDjJbCSp4GgUyEJeIxHjHI+ZRP1b8lDO08on3vF/iUi?=
 =?us-ascii?Q?NXte126SN0xYOIWnNRaV0hJG9SwSGCsPtdkMt9eYPPs6dDJ+VkEMcVRbASbX?=
 =?us-ascii?Q?1VgbhvIqA5KyUygwA0JG4jFVGbwjk3Nl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 00:55:18.8304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18406376-dc93-4818-00d5-08dcca20c005
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

This series from Chiara adds support to a new command to monitor IB
events and expands the rdma-sys command to indicate whether this new
functionality is supported.
We've also included a fix for a typo in rdma-link man page.

Command usage and examples are in the commits and man pages.

Update of uapi header is not pointing to a specific kernel commit since
the kernel part wasn't accepted yet.

Chiara Meiohas (4):
  rdma: Update uapi header
  rdma: Add support for rdma monitor
  rdma: Expose whether RDMA monitoring is supported
  rdma: Fix typo in rdma-link man page

 include/mnl_utils.h                   |   1 +
 lib/mnl_utils.c                       |   5 +
 man/man8/rdma-link.8                  |   2 +-
 man/man8/rdma-monitor.8               |  51 ++++++++
 man/man8/rdma-system.8                |   9 +-
 man/man8/rdma.8                       |   7 +-
 rdma/Makefile                         |   3 +-
 rdma/include/uapi/rdma/rdma_netlink.h |  17 +++
 rdma/monitor.c                        | 167 ++++++++++++++++++++++++++
 rdma/rdma.c                           |   3 +-
 rdma/rdma.h                           |   1 +
 rdma/sys.c                            |   6 +
 rdma/utils.c                          |   2 +
 13 files changed, 266 insertions(+), 8 deletions(-)
 create mode 100644 man/man8/rdma-monitor.8
 create mode 100644 rdma/monitor.c

-- 
2.17.2


