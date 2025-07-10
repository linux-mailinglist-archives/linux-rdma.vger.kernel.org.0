Return-Path: <linux-rdma+bounces-12033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3C4B00484
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35398179AB7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BFD27146B;
	Thu, 10 Jul 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+nnewI1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C851E0489;
	Thu, 10 Jul 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155693; cv=fail; b=CHusB9iXHEBGm5hNPNe4Twj9m/qkF0ow6ahBlNydq9ocJTZdWJ2TxJUK8lf/+2kw7lMbflPlo+GGNs/pi07OF9uvHp4vSSMDhA9o8OLFrXgML2hupg167xF0YqUFE/n9uMSfYL8TWmYI1VW/lpSNj8jd5o8LpG6A6rcFNSGhHLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155693; c=relaxed/simple;
	bh=+cEHFoLNAQwecrszm+chf3fkw1Dq874Wf/BA3AJPy3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhNWHbR67OjyvoEP7vlu6dC0XvLoKVD4qcldqLeSohejwV1lPC5IK+2eibbifTlb91rl8dQ9vLymi5kUTCUKvrydgEUfTHhAhZERvWs8W5c3IcAMP1/OPjGkXx4huGhoHTtad+wYT/p6mzSxFG1SM211XICK73vJsO4jkS8SE7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+nnewI1; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1BLuH+UxTlPmeVD8O8MmGvqSOEEYsTp5JjQh8f9U03UEKK/xxB15y3zGl+d76UymDiROHUPvfZ4Ng4syQG/0WO342U4jEZHu4kR3A7LRdMGfwJrrdzxN4J7BewCyOEPWf4QfqDeASuq05KSpSKWH+SebpobmvvT0fuCdwLCpIYopV9zH8Fyvw7bFY4lvcb3SYqColsEG0vko4ZfuRtr5Ia3J843/pHGoShUBXHagz8v94QfAH2d6O6HQctgKv9FMlyLpWp2ycIx7BWFsTgHy+m/H4UBNMNBI+q06/UtK7cMCPQvoNocq8mbAUEUqXEFPzNblfqpFRSwVsG51GmsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dQ4n2I5yLk1+DM/DcGOhn9/O39jRgxfqM8aRiHdMmE=;
 b=jKyPbWWEh7q1B9Dx1ylMpbaiW765jVXBrdo1LBYYvshFjEiMXQa6egkxxJBr+ln3FLJEbyl/dY3VYlYHGcxnxxiHPYQh3skaJRiSh9dDie+ZgxpUr20UIkhhgiGwEa9FrZZse8KYW2zf4oTooWu7T4WWXNYTAYHR6jmCA1o9OJNdPWF7YTP6clvc9CpbfGI6PMA6SDB2ZI7hG6yhY6H8PFl2re+nwDVOPLEVapDL/cA7Kd7lw85k7qc14XF9dIwgE61yCSp9t4xa5qqmUNkN6/tYkhrMaWNJOBMCkvznPAwG1DyIu4i03FDoUN+LkQ+KHKNmGAaeuwHdhK8Mt8yaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dQ4n2I5yLk1+DM/DcGOhn9/O39jRgxfqM8aRiHdMmE=;
 b=Z+nnewI1i3lMUNu7osnn1Bq757XIVOpFLC/aqARbH64rxOut2k01Msz2ih4mp+nnxat2WsW8VIMKV3H0SI12Pi8DRgy+ehnc2LF5VVERGZqy8iX4Z2TybY/RPgeoPEeQVo7YISZ5m4ZUgokzt2sFgdBIjJDhvLm0zKo7+ofyPCnGYEv5iTDZ8zvblbD0e1+B83HcY5U8s5SK0ehvKU0pH/nGdKc/7WwJ6uDapBa3zxO7pjgU11LwQuKaZ8srfhaNp9wEq8fWx36wX6PedrL8jzhs/zaZYhoQWROgKn7Dp7/LTFtSmuoPh7hUfPM7IUGE7S6GbKF2R7W/tYGn7vpTvw==
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 13:54:48 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::2b) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 13:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 13:54:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 06:54:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 06:54:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 06:54:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/3] mlx5 misc fixes 2025-07-10
Date: Thu, 10 Jul 2025 16:53:41 +0300
Message-ID: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: f027200e-f249-47a7-43ba-08ddbfb9558b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2x+ml3Dx1aVw7r29v9JcqVDXfSLSrIDo0Eqad95D6RrhmNViPoH0fQCvEEu+?=
 =?us-ascii?Q?KkJkAouIs/iah6lVrmX9eluJ1NWBqRb5wXzYkhBbixSOWy5ilQNlnHkjIbxC?=
 =?us-ascii?Q?0FnIf61jVNxQqV2mXhOHHUrHqsZZ7yYOf8Sq/rlhWV21eZ0eH6w5PaeOHfA2?=
 =?us-ascii?Q?7PI/+DMXdKCTn63RxaEPoA4DuDf4clGaC+Wf8qqqtFhNgBkGWDanl4yFAMiu?=
 =?us-ascii?Q?1HUQ/o4t4YprcMzF43a5D6C7YbGwfaKzAUoiOtQ7h/d9fJn9NEK+ilJnESyn?=
 =?us-ascii?Q?k8SAtCv9ibvICtKlK3cU6BTUjYqkLkcY9gdhJYbLNQ/R2efwMKGvIW2S1mT6?=
 =?us-ascii?Q?zro6/tUN8ZksQ2KDd1Aqk+d1paPbljidv/1LeK9VLObtbrYRvChHHwnVHnPi?=
 =?us-ascii?Q?411vPbwlvpc2REQj8bH3lJ2IcUhKYE9HFpzRqXHLvfw9LoGnM19VgHtk1iHB?=
 =?us-ascii?Q?UPWm3Pg0zlADIOhLRazUc1InetPCM06J1mFF9vNSngnwKSOfxXdG+7jTfFWm?=
 =?us-ascii?Q?nF6TLzgaVXETjAnF8Wp/I5D034TZz9hUyHl89bVRNqcxfqvkviia1qdEOMzM?=
 =?us-ascii?Q?RoZlw+GWlVzSorz29YgrCD+boYwckCFWh4OfeCsUPOSzg6dBoVPjm8hhogkl?=
 =?us-ascii?Q?Q0U4CtZFjXJW0jd4QiO5cH6hqvoSm5lfzEBwHy3W5+SxJ/Lp1491IkB+klq5?=
 =?us-ascii?Q?XrjIvgCw2VCPOhrK52oWz+A/l4rdeCkuv0o01i1Itkgr3DN1uHI8kL4FFQ4P?=
 =?us-ascii?Q?a5ooa/BciioUHnaedWbC4S0xElN6RGGgWvCfz5MX7E6yOiwQCbk3Zg+kPspm?=
 =?us-ascii?Q?y13MiCVm79D70o8IIY5/5cHb/UQzjskdlfFkl19c1RLpruOmiBWPt/1q9d78?=
 =?us-ascii?Q?NeR8fHTHrRUMMWkgDhU031pXdaQHVFdBwEbGKUK48OSt5xrSGczOwGnQJg1S?=
 =?us-ascii?Q?TfNRkDbYJZ1Ic3Xb4BSk+JWiRdW1sipFLbv+15h21/u9vgCIFZn5zt6WWK3N?=
 =?us-ascii?Q?e9aVl67lYdmrqCi7h4WuuxTuXtSeUxcPg8NqzqL+TZEYIs2k+Mx9rwZ7x8by?=
 =?us-ascii?Q?ltEi9XXYFYpYNFazkiG8AX6aNN5qb++STI9lgUwo3Ph/82/5jTemuzCfDzyk?=
 =?us-ascii?Q?Vf0z2hvvxsfyc1UcYR9VFtjloS/X801BP7elJcvuCAKKp2dKzbVpMSWAdMEG?=
 =?us-ascii?Q?n1xpAaIMHPm7CzophZZw3OdnG5SLdtT7NgqsYGyhIuv52DijOOzG62fAI1Kg?=
 =?us-ascii?Q?cPZFf65lBu+aM4d7MqRQuK+TZL+qJBZHNHePd9KjMWbu25+cQPLJ6G7Y+kXC?=
 =?us-ascii?Q?VRUaGqcDAUVx3xFHZuPC5YxLS1NjZWjZXoEg3uvkoM4hAg143KS2976lvGhC?=
 =?us-ascii?Q?XykVDfODsizVMfOMS/FYFiHeFesazHjYIiqN5KyGkjHhVFiYDPLCT1/AaeK0?=
 =?us-ascii?Q?/MVfuoyVvW/ecJ5wMaji2Wg8majEANt2nNeqhUFxaoYAPC8spLsjNbusTYcr?=
 =?us-ascii?Q?YbyT6xb/LCpxOezSpsC7d5mGsjFHEI9Vu2VR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 13:54:48.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f027200e-f249-47a7-43ba-08ddbfb9558b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

Hi,

This small patchset provides misc bug fixes from the team to the mlx5
core and EN drivers.

Thanks,
Tariq.


Carolina Jubran (2):
  net/mlx5: Reset bw_share field when changing a node's parent
  net/mlx5e: Fix race between DIM disable and net_dim()

Jianbo Liu (1):
  net/mlx5e: Add new prio for promiscuous mode

 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h   |  9 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c  |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 13 +++++++++----
 5 files changed, 20 insertions(+), 9 deletions(-)


base-commit: 0fda5ccf5425c7b92eaca868a3fba8a3c9f8b746
-- 
2.31.1


