Return-Path: <linux-rdma+bounces-11518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B8AAE30FC
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B30D188EB82
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047915B0EF;
	Sun, 22 Jun 2025 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/zyoYS9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79866A29;
	Sun, 22 Jun 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612967; cv=fail; b=H3w6tItZmuphEEx+Lc/4olaUjE0frUc5QJI5u9HDEtEjXfFHXcKGg7SrDegmnVBvYcVLONdRlVdv7JAzEU1as2GU1B2D9eAjmngFaVg+6cl7Yi9UTaPJSyuwQhNqMWLzvO4DILN8BD0PD9vnLaMXATfUKwtAWJkR6+pJmk6AAO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612967; c=relaxed/simple;
	bh=DjsNjexi0gu35nJj00j9Ey15MHs69/+PcRqNb7LOXpQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HThdrTzOhFq/GZ11cnqJlBk4Hm0jY/MG83UrP+HBxZfV5JHJijYaea9j2amnALShXDYUjpmXXS/ff+8v3E3SOfx99MEm1K+OCAGtY2Xj4jow1XN/xLZs4I81GxPdZsfs5Ii0UW4z0kaR7oiHfKcU+x45RU/hLmaEPqnkptU6bI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/zyoYS9; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLjj7uGBvS4EbkGNARnLlo9WHx73ZkxP7HyvOpW0jR8BcCT3dj2CSpl+81fBvfKGlivaZ2jV1dlyJuTw8rdVh5MUOBAeehNj78UbU7UqSOQe6F3lNKS0ODI8iL/DXug74HQfWyVoULJoltbmWoWNyUCrMkIgOH/vwWNOw25OjVCywzZyWvbUuL9XasNHmxQToIhhMo9MdKo/k5b6BODHsqDf2F9+Cmg0d7WDOKtQ5Qm3Fd2aoAQjzVAFHYyugi1f7u0+Tnabjvf2q3soG9dMp820WGr/+HfdMrS3X1etWRHGyg+EAY2XDbO3YOsC69vQ2hz3G3aUJFIE9iPhrOPmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLHGlMDndxw8Jpv2Xa6dUtN9WKLRgrkirWsQxwlkr44=;
 b=zVvzEwFN0sFPuYE5JsrjAp6Ty4OVQh3QdkbFqKUqHbnvXX0oAaamP3XEozeCg3UEsiS0g+1QhkrX0kky/zNm0xxMSjZc+e5kOIDmmYus0efzuZkINEe5SujHhQ4KdwScEeDSMELpPF3TzibExdGgGVlohVNTNyTwAPL4MqRrrRIQlhhsFxfpMdwwlfkgAqyz9lMl/AKrP+een4aQtC+/JfTq0L/ywzHH+9gbVhCwO7f2uGnFJ8uhgmMjilMcfdeh8WEno0jH3aIY0AKNZIn8grb3UR1lqG7q60+CKSaxwZC9RGPpw+4l3nc9yffY8z2kKhyAO6ljkuQKmeD1HxzIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLHGlMDndxw8Jpv2Xa6dUtN9WKLRgrkirWsQxwlkr44=;
 b=P/zyoYS9upPw6BrnRwFIpG5xzipdDeZ7FfztAG+eQyHqvPl4P4p2DIo4PNxQJ4pyfl6ID4yNXgrGPvvSDmxc/5nFJm8oKX48a6ex/sg2Q4I9rLCWcPjpnoI1WOv44CwTSVL1B6c/tJ3qnH0yzUeIXXNhvWgE1pDSp0/hcChn12h3jqgEc1eiWaS4dyZSx/Ud3p8zLixloh4uc7GhTAtIBCB25KT6UcXs+wsSieCc93KNWAV4UqbRg0yIUOVxWhN6bAeWsvA2ugWEesJy45xE6Ih/D7wsBWlrHFfklNz/tFL54AxGX+VQv3sGszhbB0LDTfQSciYuSgP3KX46+Wmz7w==
Received: from BN9PR03CA0110.namprd03.prod.outlook.com (2603:10b6:408:fd::25)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Sun, 22 Jun
 2025 17:22:41 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::b0) by BN9PR03CA0110.outlook.office365.com
 (2603:10b6:408:fd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Sun,
 22 Jun 2025 17:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:22:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:22:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:22:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:22:35 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v2 0/8] net/mlx5: HWS, Optimize matchers ICM usage
Date: Sun, 22 Jun 2025 20:22:18 +0300
Message-ID: <20250622172226.4174-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: e5276fd5-f4d3-4e80-c3e0-08ddb1b1645c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wbnL0JGRySXVAE2pwJxodRbCE3NjINAi6ykhCbFMBv1dZZhnHK4Bu+4zBkGA?=
 =?us-ascii?Q?gI/+OYhXUZY1HI3sUNIqNCHkwuOd2yq2twMJ36lXaIJbm0RYQR4vRT13d8cv?=
 =?us-ascii?Q?tZ2wiRnRaX1UU7nHTJGiDd64lU/WGA7M+otbIZ4jN9MVZRT7bxjuTjfbq1+z?=
 =?us-ascii?Q?CowE72OJiRhdDREuKKlhp+txyouh+lVI5hb4hUGX/sfWcGPCoYXJElsZCgu7?=
 =?us-ascii?Q?vxtUi7FexPudYPt1gMWFOoUd67l0xqaVSs4s/X/rRgHEIXfzKPfN2m7+eIze?=
 =?us-ascii?Q?3MBBpbWNLjXbFto0+ftNIt6Sim6iiY9UTZ3XdUo75SuQ7RtIXsABYnEuJ2ng?=
 =?us-ascii?Q?dXrwEEHJmyiT8dm/X+uJn8yKqKksvQQZYHufyE8V0M5bCLW5qicG1QSRV7P2?=
 =?us-ascii?Q?oTBnSHbyQe9vTBRiLnjPgm0fNOxWk+L6+mazQUCpCLY+VolZVYAS/JpLYuZH?=
 =?us-ascii?Q?FKeuyl+1FmX+yvZ3su2ISh13eTbv9udfxDSBEBNfhQrvtgoi0B7t8UlCBEN4?=
 =?us-ascii?Q?0+fCCylkz57u657I8FfxkwCPa+o6b/vgbKgSGsSeVPMVeVAXBCDOxnGLb6oz?=
 =?us-ascii?Q?/RIGaK7RjhpcLm250X3JJzS5mvFeWgNxpZDDYKLEuUi2Gresq3yDaIglAnnW?=
 =?us-ascii?Q?lR3I67DjkoeuPKTd4PoVs9ywBJiiDnVnv4ZiZcRWrUAxrRmlqXDXXzTOLaCG?=
 =?us-ascii?Q?B5mlctKgSua6qzt2+h4cWfPNWQo1QMOCB7xP/rUREzlGSrWqJmvnxu0kt07O?=
 =?us-ascii?Q?aVP1G82K6pUkFBkQ1VZtZYIypXRuxT516+cGdCMeQUcLKKwjSUtUK0+pUfg3?=
 =?us-ascii?Q?qV36YBPS4Gdsiindxw3z+9GQf2w5xb3+PTLqABVaC4ravihNb7lrRvrGQAus?=
 =?us-ascii?Q?RheohN2kWAyB8DDhr0RFF994mcBZ9xVs5mDTvXQY8ypqD2KYllek8OFlfg3i?=
 =?us-ascii?Q?TngcbdpKPcS160Nk2BSypKfOEwyBfHeUOcz6fMb4Y1IdkNrdaDzAj2dK2EYF?=
 =?us-ascii?Q?NEMSHlnH4tPmUujEmVw2ord6kTnv+ZwdnXmNCSD+ayl3XYoOlSzGqCS9Rlbg?=
 =?us-ascii?Q?7DfzTaBNzGKOK8DJHzfsZkJieny5ZAj1A9s86OU29PSriudFViRCpfbs6cO0?=
 =?us-ascii?Q?ihFmJ5BYwbc5SBSIJWlmxSCdDMHohMwN32IipFjkWHG9zdZBZx/DYqe3ykAt?=
 =?us-ascii?Q?0wxNc+CDMKu04K1ArDlWEmy8BGXq3br66ANKsMx9XrAgkkM0glko0hZtYOb4?=
 =?us-ascii?Q?Nc6L67a0ckn7UQcaVG3PMD+A0E3q9icFnyXe2zX6qDJGggPYu7wN67HJsyCl?=
 =?us-ascii?Q?4uML1HTSvXTUny+33opWt4sA5CGBFo8p5IJvWk7ij+9C2tQYT6wShLF6iISG?=
 =?us-ascii?Q?u+w8eSzjSrpBuIjnRTN6lFsisZ7HQOeTUyvlUXjgJ44srCl16Jci9omVJI+W?=
 =?us-ascii?Q?g3Lwr6sdHbzJEEC1nwgl9U1HfWpM3nYHqde/N22S6p2EhYYdtNE8VuhmOXMh?=
 =?us-ascii?Q?WSknY4+iQ3r2luIZyt1nlXtwLNPu1etyi15S/19+v19zXTnLZfIaf8/uXw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:22:40.5778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5276fd5-f4d3-4e80-c3e0-08ddb1b1645c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

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
Changes from v1 [0]:
- Fixed author on patches 5 and 6.

References
==========
[0] v1: https://lore.kernel.org/all/20250619115522.68469-1-mbloch@nvidia.com/

Moshe Shemesh (1):
  net/mlx5: Add HWS as secondary steering mode

Vlad Dogaru (5):
  net/mlx5: HWS, remove unused create_dest_array parameter
  net/mlx5: HWS, Refactor and export rule skip logic
  net/mlx5: HWS, Create STEs directly from matcher
  net/mlx5: HWS, Decouple matcher RX and TX sizes
  net/mlx5: HWS, Track matcher sizes individually

Yevgeny Kliteynik (2):
  net/mlx5: HWS, remove incorrect comment
  net/mlx5: HWS, Shrink empty matchers

 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   2 +
 .../mellanox/mlx5/core/steering/hws/action.c  |   7 +-
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 284 ++++++++++++++----
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  14 +-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  20 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  15 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 166 ++++++----
 .../mellanox/mlx5/core/steering/hws/matcher.h |   3 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  36 ++-
 .../mellanox/mlx5/core/steering/hws/rule.c    |  35 +--
 .../mellanox/mlx5/core/steering/hws/rule.h    |   3 +
 11 files changed, 403 insertions(+), 182 deletions(-)


base-commit: 091d019adce033118776ef93b50a268f715ae8f6
-- 
2.34.1


