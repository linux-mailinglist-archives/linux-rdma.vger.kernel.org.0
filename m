Return-Path: <linux-rdma+bounces-10515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DFFAC0491
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 08:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE64A1F42
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C022173F;
	Thu, 22 May 2025 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZlyZLlj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0051990C7;
	Thu, 22 May 2025 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895343; cv=fail; b=KsCJwDXk6Xwz3V4NCoh5tjKNewq5mqQfYu/WHzsKUm+xsZPNUmubfRb4BjVcLNoFDSe2LKz3KhHgbD5NKfXPVs7cL/ja1csDtgMhVVxcBgRaSNghm6bGXTPqkoTTNHGiwRPO07XoHWSJN9da3FPp8Y80s48ykO+W9jtL8yD1GFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895343; c=relaxed/simple;
	bh=LZNQtUhKsOlnHWtdcrxjIo+JU+w6sboKxXP8Qum+Tr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fOkkDuifGU9YADUPOCbPwkGhEpWbUcX+OHtQ8RXUS69J8ln0FTfA2J9qBWovCY3VVixgooqMmT0plV1u4YgO+3QqNKmwFUEJwQZLGEPL5TwC3ZQWHik7Y0nKnrfw8yglefLdgY+JzKJqfYrBAsoqVVJ0UKGtJHj1YhqfhCXfdSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZlyZLlj; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2/A6tQ8EGUMcY2b2Xz/gqD3tChJyYTi2d65Wk0UiznpiHfOPmWhVwCCYvpSlQ/YCDoi9pZGluCKqQoSbnkIfbyL7jSzoIiRyown14rgWyyTZgiVKRG+CZXAgIT7vMw4eqIAu29y25qxZOFFFYh5YInz+D/Ie2wKmwdN+9qo59nAkscw7sYXZIwMqZWKkkAIlLdWGzNpCgs3PFYIu5q1C7xuAYo88zLR9U3mq2GEwCPg42R85J7B9O/tzgZE8wbRiDVHV+mPL4It1Sm5+dQGEnMRb4RXZ2is2xv0zKlK4V8z6ri4AEilYJM1cWl5tV4MCABOzaoR5VvIOgoI9u2VYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/iDrqnf4+Q2Gi3cwskTW7J1v7xGEED0hdvJOEwJ/+M=;
 b=R4KOX70iAd/TJit4Ts/OfspHLxU+LWTBxTIFY5YjfaYvCj2athg3RTx0NwzZip8lB83yFR7E/NyPnAUtZOGzlMJBslmShJAfucXSJjx6zdVpK/Txc9bdlWlr2u/kPY1g9zf0FpIxnnEyr8q9DRSCsx0Wi8r+Ugzebspeh4Z2IMIzfiwA+AoqByDLhrC2Z1NAKpxlJyAs1ohkq5AgHpJcNWk4fKdAOyz78diIczC6fI2z89FnJIJaI6tiXZmFqh9GbIAVTNpgGfSkz3nONkrOH9mKW1U0dUEXR8pdujyPNb0NgPcf6wEnuxYp85IK0wJjf00fnEeV/odEewHspM522w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/iDrqnf4+Q2Gi3cwskTW7J1v7xGEED0hdvJOEwJ/+M=;
 b=RZlyZLlj70f239cKtUU1eSzQpychc0o4BdxN3dYC/iWam+4X+vLcJ59gBCviF/TpKaDpLEZn/33hVugJ/kqO4Db+/yO8wi63xGwIIPpHoX6YcpBJumwTbHkfno6fRaq/z+MpzXM2W+on2niIxUKLe34sQyG82ym4e64eRXnAgVvkR5sCmVCZ80SHy5MXkfDBCt3hD+Bp5nZBgoUDnZ8Hk9Xudj43FKbm76o4DR1ULOM3yCUDG8IflY5jJhR3L8E1kga9it3W1EnSI1C2V1OH2RivBxH78AAnPt94cBxxKSqo0f0JdjT3jqLGVOPUYUQXZh9LittDzHYUvHCiAZRF8g==
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 22 May
 2025 06:28:57 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::64) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 06:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 06:28:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 23:28:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 23:28:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 23:28:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net 0/2] mlx5 misc fixes 2025-05-22
Date: Thu, 22 May 2025 09:28:04 +0300
Message-ID: <1747895286-1075233-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 158b164a-4d0b-4957-6e91-08dd98f9ee02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBN58JoZeUWHZp1t5hNw8LvW+HBZbTKljq6sKljEj10FcPuUjLVI++9U6GXD?=
 =?us-ascii?Q?eW9zPFnhkCXAKiXpEzgleeTeUU+XC6e16VP5y5V+3TmQAKc0lN5U8+8+fPLe?=
 =?us-ascii?Q?I+GNb3vZDfghBTVEko783t2ku4g68mOSG3Q8Yhpf4tb0EUC1HYHhCtgJzXMu?=
 =?us-ascii?Q?KhVIryg6UOEoyE6LLHUHN54wo0B8mNw7cCIBiWe++k5RmKvbcJEs7P1v5/iK?=
 =?us-ascii?Q?+9GstyHK2Zlndiov+3mI/JpoqE5q84hTlULonM6aL1A7CeUtNRJ1gaxrsnmi?=
 =?us-ascii?Q?jZbL+GD1lt2/7JoffgW4hufZkLVU5r/uEJmzV71JbDNUDq0v3yTB0VYNsAHq?=
 =?us-ascii?Q?pNm3qrtWGfPRf0BG0/0Uh8Nb/AZ5bxla24HS5psUf8mHZQiKCaF5e+KK8J0u?=
 =?us-ascii?Q?BJGdRitdHChpZgFQ7T1UkBjni63x5I1FwgFA7trvqfu3o5/IZWWwNHabA3TU?=
 =?us-ascii?Q?jn9vAXIRnSEBt0GES4sBvFv0pg/7GBVPThKSRDr2AJLu2s7YJwxA3I9Qa4rs?=
 =?us-ascii?Q?W9Y8GNLAVo0z1oEdXZ8ZCn5R+GRxu+i6rPP//06/i3Q1+AAqv/02Jwd8huYB?=
 =?us-ascii?Q?XQo2sp4M3/ujiAto6LtrrogrSNUg9l70wCJxYhM/cYSpRG3IiugSLve/7XF0?=
 =?us-ascii?Q?ciWFe4l2UsCX1EkqBVX9LKUl8c/0LZz7WLpqVI61nkJ8X7VBatxvNE+hoNCZ?=
 =?us-ascii?Q?OvmgEy3bKzvfqsS4vzEFlLDQ8CvSDHh9//J+WmrREnIEOsaxlkG07/B+d0vK?=
 =?us-ascii?Q?vJ/0QQi8O7xnvpBTtEl5lwYefnzLzuj9blKnetKHSZ03+HdC1Xtfq1E9kH5m?=
 =?us-ascii?Q?LV3V2eFaNp84k7/PZovadtyYnGZFJ+uYr/NKhS5bCLO80iLpWi2Nwn88DlS+?=
 =?us-ascii?Q?fCDtRgx7y7Bh+P7nr297bHy7KcOt1KKuKJHSgeaGPKhLYVwjgY+fTDvLxSr/?=
 =?us-ascii?Q?2oDM1rF4UfHIvjojSQY55IegdsPvkxkx7JrJslo3NGmPC2pG+4malNciqeM0?=
 =?us-ascii?Q?lM1JHAtRb+YYT0VqmS001moAYdOPMaKt6nloCvSwhjquWBi5CkDm9fKbsxlT?=
 =?us-ascii?Q?D7ovoNNq5pGuD/dXTtqYkzyPSsbp/H7SwKS1P+hSpPu0kU0ySmD7YppstVvn?=
 =?us-ascii?Q?bylIroMFSuT87HE6+upXZGfA0wiyVllpNyJ28Rcdx/BqZZzuVgxAGXlXKWLW?=
 =?us-ascii?Q?yDZmBa3PFwRvtTFXemN1f2evfEFnipb2/8Zcd5vcsAtN79/SQa5x5cyrjKQh?=
 =?us-ascii?Q?MlcDE2pc0YZBgdFdbvCFwwcWZeLVdpnKpNgXFmyTJswn8nr9tlSLk9iRNiVQ?=
 =?us-ascii?Q?M8JLyFlII238EDczZubQu61qJqttiP+otOfeluGlMmPdgHI6pVf0SpK4oYQU?=
 =?us-ascii?Q?wG1eELw9oUmdobp2JyVIzjVo6G4UXMqVCJpIkoLqaBRgukYEIoIHt3fJg2kU?=
 =?us-ascii?Q?fawToze0TtwAKfk7UUhgVnEUqnWs9cm+HOWCPNZbktFmAJ4R+CSn0PWkRBFi?=
 =?us-ascii?Q?M4B03/79grvpyTwaP4TUkrMRoOf5sTHtf8Yl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 06:28:56.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158b164a-4d0b-4957-6e91-08dd98f9ee02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

Hi,

This small patchset provides misc bug fixes from the team to the mlx5
core and EN drivers.

Thanks,
Tariq.

Jianbo Liu (1):
  net/mlx5e: Fix leak of Geneve TLV option object

Moshe Shemesh (1):
  net/mlx5: Ensure fw pages are always allocated on same NUMA

 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c     | 7 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)


base-commit: 407e0efdf8baf1672876d5948b75049860a93e59
-- 
2.31.1


