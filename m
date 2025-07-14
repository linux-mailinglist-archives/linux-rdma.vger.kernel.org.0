Return-Path: <linux-rdma+bounces-12115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF68DB03979
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 10:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE117D77E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543B242D8C;
	Mon, 14 Jul 2025 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKUl+Fy3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16D241CB6;
	Mon, 14 Jul 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481401; cv=fail; b=BLeHUCKTDVBF+CWePJ5uhYBJ/eidN65ilFr4aCmk+SDeClEhzHFhy0rEaafoZdtC9YKkKZvAzU+IBXSj71SF3FJMyWomYjKnPjR7IjaaqFRX825cBwp6dA4iznsou0oNB9PIemoAvvBp6V2dn4x4uPrQXTTZDEoxNO1/+TVFvy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481401; c=relaxed/simple;
	bh=cMhLMyhKkWB+rEqfa0hW9cCO8+ihel0h35EzQHTDZss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y3/QfZiwHLeyzfunZDhNyxWvd+hPGx+Ifw6IiOdxYx5BHqlCDs4sWs4GEd6C3/CH+hJxKQ00A+GAoROKLArHMdyhIJdjPnFazFlB9noy7jGekM7+ubUlnr+rBmzIAt1sJI3c7101nIFIiILvmmDCQb1LgtOZai4ob2s1NVeusnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKUl+Fy3; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2r8LifUqsB+oMgxg0oITE1Oexy7TovpIKXZOqWbr4UAfyXjL8OpzuE6uhSfKx739AxbQWJ5ZYB7vsbBfPPA7yEZlqtZPeIDAnJEI56XlgYFDhYG1YZpmBKRzI3AGeam3VSB8OJ/Qs0KnpTIAQSRVF7M/q6LQeEizY9svTeJrD95s//bxxOT5WOaKfZ/Wnuhnfx1270PA3pF+Yux8W5Pnvc92GgHf/hTdthX42jqCmbW9TyNNBNvy9udCJDhkWtWWe39CTnA7iUlAipr8SMU8sOd6JfjobwG/5DUYLZCaTftnBgBUAA16LkUxzadw9AGm7tlQ9YwWIyTVTeCihnP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjHXte37Mq4DSSqXKZxUTyzZJFLqSOIfp+UsoGzXYmY=;
 b=ugLmxj4f0cs5Gz6PcJcSHa9j5Cw5F22KdGB8vMbdhJtzgB1fFqQdMUrWXkQJqC3IUzTkVkM1e0tulzMnSJkGFlBn/SwhGeacfZsLDMnCakyeBkHAXoN4JeWjEq90+ihuw63Zw92od+VCLhT8izutSA1+58UI6z5SViTAjkMrHTRTN+hTc/zVrqQ5bVayVFvP9xjkbB2DqgMMcLGjqN5oR0qTmbDa1MLQbQlLb/PgXRwsUk2W55zASu5iivrn+OyxCuhmvAGDVLsZc7YCoTcu+gXCdMJ3Xa6awHNIuU5ljDCxSt7wrNdTOh+/qQROvpVSSxsOuV+MM6EP9bA17GH0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjHXte37Mq4DSSqXKZxUTyzZJFLqSOIfp+UsoGzXYmY=;
 b=aKUl+Fy3kMT130l93GP4Qmz+4kFStqNI29q+2xIwzfVqSEusouWBhC7Vdd4Ojx9FwF3JRRikQpo4qHI6p8C+/NnJQndMen5ss1FCJTmg6i4ifHpJFvYV3f8Ko+Myc+O4oKCmvEEY76OtmTiOSwbtnF8wObW6yxs2pviaqU6u7ENnE5FC1YNIQcTT8TvR0ErFOSx6gXYR0TkOklkgBSYn22rCMDqrbITqSAJYbpIj69CQy//qf6NmqwqcoTychqdrz9CYPgdD3tjHTMQ02OhsG1u0oyOXdEOj1KmFIK3hijQYQrKWQqSyUFwy/KOrzp9DMVFNgkvrQwRhsg+4rpayhA==
Received: from DS7PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:3b7::14)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 14 Jul
 2025 08:23:14 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3c) by DS7PR03CA0099.outlook.office365.com
 (2603:10b6:5:3b7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Mon,
 14 Jul 2025 08:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 08:23:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 01:23:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Jul
 2025 01:23:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 14
 Jul 2025 01:23:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-07-14
Date: Mon, 14 Jul 2025 11:22:37 +0300
Message-ID: <1752481357-34780-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CH1PPF93AB4E694:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ad1d55-f1f8-4b5c-156d-08ddc2afada3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GyEHsXNzMIEoyo9eyA/fUBw106luByhFyhI2zvjdzGW/OH5Ud2KWtSQIt+H9?=
 =?us-ascii?Q?p1w3Xkx7IsXKwedI9R/LL6H8SRD+O4roaGXkkOhLlTEkYZcynEl3llsdX1T8?=
 =?us-ascii?Q?36aMlBdSnHnzivY1OPHHmfon+VGdClRglxtU6/QPyEijM4cVGQVJ2PwSj9uA?=
 =?us-ascii?Q?g2f+ofaaAIzXSpPIP6+oWZOCO2+Sngps4IjRbBY0oNjCnYb0ohj0Y/5HYa8d?=
 =?us-ascii?Q?5VblWDtexeXCMRLtKvHa4/daeESoq5VlPafm7v22rCJI2sk1+BZiPwBzaAVe?=
 =?us-ascii?Q?/1rE7tBLGUvqLD5xPaMECpwuND8eJwRv9LJxPF6ZsYF7Qc055//cqale2HLa?=
 =?us-ascii?Q?YGB4ASWd5d4gB6yWJxS84kZu9HUJnfpBG7aAtp1UZFgNS9tmJNFUaDbwNYNb?=
 =?us-ascii?Q?Lr+G9D/EgQ9KvglRwGNhi3i4xv3v4CFabE3Pvd90H4V64HqABUABpzHAGE3L?=
 =?us-ascii?Q?rnAImUQnTIqD3lN/wdjIpgBr7hlWTh0VLjCqA3TUV98CxZIAvkteSjPOsmE1?=
 =?us-ascii?Q?5E6pKKzugeBsZ0JQsQpNkNyJb2DLtjGiN9bIHllpfAyfhtiQSw6dz3pPZfLN?=
 =?us-ascii?Q?/Z62RutL7CrBTjcNwkQgu65sA4xafmsfYzUr37aogjT/0L6Vw9K9b4bxdoVR?=
 =?us-ascii?Q?3qcinxsaGC3b4tSXKwfG+FgTeVtUf8arapJodAS0rePMID5WzECYsFzy2vFh?=
 =?us-ascii?Q?OD4QOb6B7pSXBXz3yA/KwnRumCstcvasNe1/ZudyC6JSzQ1Om2tqapWH6v98?=
 =?us-ascii?Q?3xhQgB9FSgd6Udey/hOSWvmNHD5pNHPCegGx7omKuUmWvIcWHti5M2DI6Md0?=
 =?us-ascii?Q?Ctufe89eSul9IlNMRk4sKnuxJWuP9t7xT7GrrFpWnOKqWDyPxyy22M2aV4lZ?=
 =?us-ascii?Q?d3kZ2/jYYNpfvjccFVfWWm/Vd2wrMTNKE9aESf+9ymUZrGa1d1pnUmjHanwU?=
 =?us-ascii?Q?vR1yRC4gmGqRAe/GS++xG4g38J0B16WVW/aVht9klBqFAnqDro5znUi/YZIl?=
 =?us-ascii?Q?P0uykm4Hl1ARxvR4GuwxbsEuWKg+VWz+UiMwLBysH0rv7nh7kU/UTdCdqrCt?=
 =?us-ascii?Q?98ZC7SR3R8MWxuhUaTZaC8n4sWnvrT0XTG7nNdL/SgEVE1ctQjqWuvaiTfNa?=
 =?us-ascii?Q?Gq0od/bTRzRxeeloQVqnLbdHvEsB2DbkDiuI47XUg39hMbfFTsvWMMeqOswg?=
 =?us-ascii?Q?Afx27kJStMvozYtIXz1AQMnKscunecGGeL/a/f2jL1ZBg+zF91wSsu78w4X8?=
 =?us-ascii?Q?tt8sv4FlJLEwYEHLNsBeWRrfRL117IojlTmlfbRmXCSV5PvQaZtVCixkUNhX?=
 =?us-ascii?Q?jbxIHPm3x3wd2mpm/loBHtAR5uUlGWRemBrcHHR0q2V0jwJ8PsScMqeNxMfW?=
 =?us-ascii?Q?bu38U0IlHcZdU29ESq0d7D3gkDPVax5ET0jj27KIQFXdKYlzgnjljF30MrIg?=
 =?us-ascii?Q?YTfhz8ZFUxLne0yShaujYstbD/FlOBTwfAgCqE2+y4j9OaAQyugXwY7QTPVk?=
 =?us-ascii?Q?jiN7zTMBPayw4TZZw6YTVGFFTMqAPssF5oiV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 08:23:14.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ad1d55-f1f8-4b5c-156d-08ddc2afada3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit 70f238c902b8c0461ae6fbb8d1a0bbddc4350eea:

  net/mlx5: Check device memory pointer before usage (2025-07-02 14:08:23 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to cd1746cb6555a2238c4aae9f9d60b637a61bf177:

  net/mlx5: IFC updates for disabled host PF (2025-07-13 03:17:30 -0400)

----------------------------------------------------------------
Carolina Jubran (1):
      net/mlx5: Expose disciplined_fr_counter through HCA capabilities in mlx5_ifc

Daniel Jurgens (1):
      net/mlx5: IFC updates for disabled host PF

Edward Srouji (1):
      RDMA/mlx5: Fix UMR modifying of mkey page size

Michael Guralnik (1):
      net/mlx5: Expose HCA capability bits for mkey max page size

 drivers/infiniband/hw/mlx5/umr.c |  6 ++++--
 include/linux/mlx5/device.h      |  1 +
 include/linux/mlx5/mlx5_ifc.h    | 11 ++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

