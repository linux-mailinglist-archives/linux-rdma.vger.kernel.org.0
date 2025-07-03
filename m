Return-Path: <linux-rdma+bounces-11880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3AAF80E4
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FB27AC323
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD12F6FBB;
	Thu,  3 Jul 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XBlAHBLW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199A2F85CD;
	Thu,  3 Jul 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568986; cv=fail; b=O1LWCdmhGuZCMcI0Ytf2atskX6TFoE6RfSo1dIU9cFIxfh6+O3eja02m/nDcmz5xk/ikStPgyqkjpWuSa4IIeeeSN0umzDwDg4E6BbOZQx4z3bFCd5nA8SUOsTQHo38T0GNb8srSMHtPKa32P2ggpegYjjl597yoXOZs5RLNiZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568986; c=relaxed/simple;
	bh=1YSBkqv4+1AK9KW1lxuW8ZdPb8La5+Wwxwgxq2ys91E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oH1zkK+6YFh8BnRX6iOt9boFNGuo5yoaL0wA4R390bKVJIVVkP5Iatwi6N+OTQbDjRMT/pUARmjaGwoX6gwKWX9YZka0/ut7d54BneSPCU6FOcPQNyPgoDoixvvBUczOBkB63YRKPwY62XL4N+OobQ/wrtFmkcXVuHAaYl5iKFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XBlAHBLW; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OE0DbyjsMdOp8gSvAkYytFF/009Mk5DsE8oMaNhPCBTIaAd/FQm869jAxhcavXrVwFgEcnErgbCI6g+2zomsYOFUN3++4axQhEscnWWRed7V9xyhBsAK6cY4rqGl+KNgQMe4JzSbH6tTRmYjF6XdPnJFDxhJzrfRg/o+8F4xhWD9k/bCB1tFliTUaTrJcVcMWWxn/lvNLYHZB7LD2F/Fy9dW36IZWjVupiFHl05Wl2xat5yclYLYAf6hCjlKovpFQDdqvKOVMbh/+kROQpQr1Fvt7oFVh+1wJEEpfVDOAwpTPPfQS1B1D9vPTcTyzOws0yY3TE34kvhgDLLEKricag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOQj/ldpO17RnV3Ch9heYWLsCSMxrjCHnu/pz5PkEvc=;
 b=Hi7XeJOuF+smUC5izvbgtPz5TjXARQdv4Pu28NynAmb+WVeU/yYa7S6wYB8QdgT1jv4SXM5WwhbyK9HUdW4fTV23rBwXGQHweIzdZlscrUUYNb5ocTTNRBYFgQuK66XMsRSZ9Xus5gcjJFQY94ETrijsDYO0d7ekPd00+gPj1BBtjEB/EnzFkGwv65ow6lUgHqOjVt3JBrKyqxyoXqMyD/r6Kp6qH5Cwkv3YVN4Hf2xKHntfD8tbyYG2+R6JPWXqKsbE96tjVsbru7wCzsC/dEJrZzgaMi3Yskd/dqUN3TRgkidLl2Es1j/HIgKZa4vgkSQX+NfMUZ0GUVNGqBS7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOQj/ldpO17RnV3Ch9heYWLsCSMxrjCHnu/pz5PkEvc=;
 b=XBlAHBLWNpHVqAgbyb7aMUDJn2B9KDyWBbX9ONPFVKccttZLaDh2Y3bkDsmKQGMeN2/3EdSXFRwiVffWZKqLyKNRb4R8t+PdLn6mg4/iMQQATpEY6s5+fvqXq/5XSmVkQu4RJ8AA/Qd1JUGYzM+J4Z5yXOxB1Cm5MBLmXK8l7eri+hLU3Q4f2Lmp0hl3qgzCABXB1lGCCljHjB3tE5LT6mR9tZUQpwgIcWVANDilULhn5RBa/NB/4y2h2dmW6aA7USUgnLphkuCyk9uVERcx0EOB6q9IWic+qFRx64KPyR3jf9pa0v36GZtWxUFv5XDeRxk/U87JDL+n281k0HVcZg==
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.36; Thu, 3 Jul 2025 18:56:20 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::7f) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 18:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:55:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:55:56 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 00/10] net/mlx5: HWS, Optimize matchers ICM usage
Date: Thu, 3 Jul 2025 21:54:21 +0300
Message-ID: <20250703185431.445571-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 463f65b8-5015-4795-8403-08ddba634bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Esn980kaAd2G2UVfNXZHWuzoGVKZGgF0Y2y+eBgp4YGezlylWON19vCELBwA?=
 =?us-ascii?Q?A2fDAakW14wrRWdW2CcH6mFTZykzryPmfsJHUgYaTckS4A/DCYtMeCpSMRX9?=
 =?us-ascii?Q?jVLyfBbtlqMWJiGHIiG8O72W4/W1FsyxQGPnHu2Rdk6O3e1zCesd7owWPmYK?=
 =?us-ascii?Q?NyCVxfKgbKaDibXwFiGdgoxjIMeePvHpibPeB7cSqdA2tWvMCOaladCbMZlf?=
 =?us-ascii?Q?VtDXqIjwjYk5QY/QG8loKf6TUb9gnqtUnyvlG65dpv6KIK6jKyhoW+K6zYMZ?=
 =?us-ascii?Q?FL66SpLn/ia3pndubGpSk5Z84F7sP5Wj/NpGLk+jonlpYaolMXF6GLjDrZTo?=
 =?us-ascii?Q?rm9da1r2O7YYMTcK8ps59hsR/ZP7oqUN9ymJN3Ql3pB+glmcToFtDP/JFXHa?=
 =?us-ascii?Q?dwIAAJud9CMnCcYQSuO1upE7XgVQI085THae9ULXehZoJY75v0aRZDRkybU/?=
 =?us-ascii?Q?YOdV0SQ0Fi4ouGP4qHE9BbR1cyZ9E2k07maWsqjMB3yG776tiK2zUU2Qmbij?=
 =?us-ascii?Q?0XwlGbGNeHFPdVCiMfWgB0RUAzwpOQcOWn7LeSW/uJ2Ne8hlDMvnBljeORUb?=
 =?us-ascii?Q?ByanhGKMN7Pd+pq+JK1wiZLksBTseQ97rgAphMPmlIpZGSWpUwF1GFA7bitY?=
 =?us-ascii?Q?gqN6KuB2ME6tGIuNn5jL7Pfw4gI02XFtuXKD8wzbsflVOr1p87H5rDpBBPX0?=
 =?us-ascii?Q?qI1xmRydnFVW4LvVZGJb5JrhPVhLpjyUpebcrOR/NXH1NKGS0sPbL6KLjvA8?=
 =?us-ascii?Q?FEt7DDsXl//o+2kpwJBxWbEfsO6CfhhxkFNJsbT6wQH4NBLu58dghGpCnfe5?=
 =?us-ascii?Q?e1y4tWyza3q478oEx0L0Eipe0v2l7dgP0FISpewdkSw3K0+3zFINW1krjzkF?=
 =?us-ascii?Q?iOPGn4lWyEY8o5OCQ4QrOfVQ5Zh7xXUcjoyVZaIQCk/VTl+bh69L7EQfpFcA?=
 =?us-ascii?Q?kRObWluLvrRXGqezpdj0lPYZTJbI1fP/24Pn0/VJIkCXBcF7/OutEXq1aEbF?=
 =?us-ascii?Q?I5rj5a30qWKvOojeFzN76xVuVJ7iOjdsUlA3kT3f3rJAkXh0qvVlCSvO82Mf?=
 =?us-ascii?Q?zUotBn3GOQ0gUbm/MGgtjUtXQwvYIPKMR0fpwdL0+Hnxx1TYdbLnA9leJSRz?=
 =?us-ascii?Q?vrar8y+Am4MuHssWHJ0oULeiJ/p8bRcNQY7iMveN8TF9XMRL6JkdHlkit/Ng?=
 =?us-ascii?Q?NyK5kCE0/OIdSDLDkJ6Gv1NyjVNxDvYaSGtIaWTMdX02Tj4RXmGPOB54vLs4?=
 =?us-ascii?Q?Ud+0mJdjAsQ3lABMxrkrIaf5DtQhyu+SmKQKkUPOAdAqWhjffuhH+NliXJkB?=
 =?us-ascii?Q?G4OqYNoRkRhp69IWH9A9jcJ/PsovtiFj6oor1OM8T376oRiY8JqHRee2lTSy?=
 =?us-ascii?Q?uy+xoMLHoZnRb7xpsTleImKvfR/gvLgvu9EamBd5DIOlrMt/cXExltoWdgcL?=
 =?us-ascii?Q?HL+rmfkhTe9L6mpg2+yi+9a+Q+hivi/F/sKsHXqiMT4/lmXAzWOjrnymqhnQ?=
 =?us-ascii?Q?1XyKKDGrSuGW4RYGN4/NJzcObJ1p59g/lx5y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:18.9161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463f65b8-5015-4795-8403-08ddba634bb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

This series optimizes ICM usage for unidirectional rules and
empty matchers and with the last patch we make hardware steering
the default FDB steering provider for NICs that don't support software
steering.

Hardware steering (HWS) uses a type of rule table container (RTC) that
is unidirectional, so matchers consist of two RTCs to accommodate
bidirectional rules.

This small series enables resizing the two RTCs independently by
tracking the number of rules separately. For extreme cases where all
rules are unidirectional, this results in saving close to half the
memory footprint.

Results for inserting 1M unidirectional rules using a simple module:

			Pages		Memory
Before this patch:	300k		1.5GiB
After this patch:	160k		900MiB

The 'Pages' column measures the number of 4KiB pages the device requests
for itself (the ICM).

The 'Memory' column is the difference between peak usage and baseline
usage (before starting the test) as reported by `free -h`.

In addition, second to last patch of the series handles a case where all
the matcher's rules were deleted: the large RTCs of the matcher are no
longer required, and we can save some more ICM by shrinking the matcher
to its initial size.

Finally the last patch makes hardware steering the default mode
when in swichdev for NICs that don't have software steering support.

Changelog
=========
Changes from v1:
- Fixed author on patches 5 and 6.
Changes from v2:
 - Added patch 4 that does only code refactoring.
 - Patch 5: this patch now contains the functional change only,
   w/o refactoring.
 - Patch 7: tracking flow_source in the BWC rule to resolve issue
   with rule_update of a unidirectional rule.
 - Added patch 8 that does code rearranging to prevent forward
   declaration in the following patch.
 - Patch 9: removed forward declaration of function.

Moshe Shemesh (1):
  net/mlx5: Add HWS as secondary steering mode

Vlad Dogaru (6):
  net/mlx5: HWS, remove unused create_dest_array parameter
  net/mlx5: HWS, Export rule skip logic
  net/mlx5: HWS, Refactor rule skip logic
  net/mlx5: HWS, Create STEs directly from matcher
  net/mlx5: HWS, Decouple matcher RX and TX sizes
  net/mlx5: HWS, Track matcher sizes individually

Yevgeny Kliteynik (3):
  net/mlx5: HWS, remove incorrect comment
  net/mlx5: HWS, Rearrange to prevent forward declaration
  net/mlx5: HWS, Shrink empty matchers

 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   2 +
 .../mellanox/mlx5/core/steering/hws/action.c  |   7 +-
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 529 ++++++++++++------
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  15 +-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  20 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  15 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 166 ++++--
 .../mellanox/mlx5/core/steering/hws/matcher.h |   3 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  36 +-
 .../mellanox/mlx5/core/steering/hws/rule.c    |  34 +-
 .../mellanox/mlx5/core/steering/hws/rule.h    |   3 +
 11 files changed, 526 insertions(+), 304 deletions(-)


base-commit: 5f712c3877f99d5b5e4d011955c6467ae0e535a6
-- 
2.34.1


