Return-Path: <linux-rdma+bounces-9664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750EA96437
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249FA1885B43
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5225C1F8722;
	Tue, 22 Apr 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5+XhFOZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22B1F5849;
	Tue, 22 Apr 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313974; cv=fail; b=O4vns+KECfEUntDyAbIOTkrZX7R1nqMQs6p7RDYBVt2d4D39Ge2hzWSBhtwoZzxyPM1EbF9e4PmNwxIgVTWuwpgzPeqpfXGCWPPO5YPOmlxvuS8PF+5W4XohXeL/IKu40TdUJ+9okuRCKmXbsL11HbFX/CRd4zYlTYLzS/cAm0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313974; c=relaxed/simple;
	bh=2yItZvuKYdSZmAjMPoSFuny+ApmyZ9Fz2MaqIhOl80g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rGJ9MUZCStye2w593pwEjdny1kLwpM72DO0Zo8wVkZLomVvucF2QtHnuChpsL0SUvgtbI0lKtKRZTOalhnR33lX0p0T381UlwCKInlwtVNKiMuBIj1KuQmtodmRT4Y8P8Fhpitp3fKZykejYaFDQqo8Cbe6RV4k7up/vHFepXJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5+XhFOZ; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBK4KTMcZL41L4sMBnlBjDpq5BEbfdgVXHVZCvZ9EsVbjSYGC+M6WOMhnKi66sZno3ZgmzjpkT0SRGBnQgxM6BlNym3qGpkWTMVZSdCpyV1NOQN8jGKyqVrFYGpulD35jSAuftsH74QfLw7T6Jh49Nfl98CoJKUMy6vuOH9VOrXFKUG4DrfjpyY8wx6MHUq/bWK0QJmJbpRlhKG8B7AcIes7hfaGge599Yg8hkvQInMPlS+gnnI2YhrgSYjupsEN6/MleCMiEDJkGWt6kgqYy5oNOAIglt85gRNZ2PXo/5z84rv3rCIiocQf+XGAyySjM3UyOWCW+cCA6ml1d3iM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISb0AWY0Q2hvqcCYeGNJF8pXNhs/egWmRvmIPVFRHM4=;
 b=ZBwadDNcU5aPqNhRu4PZsBLXcALwBukNy0m9pf4ZCsTGiVEzBy27Mzu/LgRHMaMSmDrCPPFJB0ot6Epih4uDXVW8x/AtxtBHYJiIPD3g9RsHZbSCy2944isxsYvEy6F5nyo1fOtKWCbBeWdg8E1h2zWRhj8mgdp0hYtiMQHB7G7b6hfvhSslXFsqlaH6wGcbaEm+Iu+rjxqPvhtLWtVve0EzqCDgscrfmhoirCn2Ybz8fkWxaPcF3ZtZHUZXkMbJ11qMEc3PULiNfvBhvAJ8wAH3wllAcosDMDkI+zXB2UR8S15m+z89oJJOkDXtUoCvdJqHNWxUBRFyZptte//xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISb0AWY0Q2hvqcCYeGNJF8pXNhs/egWmRvmIPVFRHM4=;
 b=I5+XhFOZdeK2V3DdwCpLfBnbVTFCL3ZsLfp365+98IuDkWMxWsKOttDx62klnIhnXhXBoakzNg9PPNrIWWrS88v661XXkIYJ8SIUj+pdzVDUAbJEbMv2eTPMfwbJU7ceIKnpy3IQ4R262NiB+WwUcdqULl6Xt+acW99V5PRhOnjB2cDws9Lge6aRsiyLYlt4RsT3X7sSQU6nrprj4ZaNXnqXp+Zzm89bj/c84JMcYUOTqjia+oIiRvMpdnbmqTgmcrKw6HcD3Kc4jL8aRO0xH/nIcqktZmWRwFWtVTDqD/A6vLc75MGyKxjnP8rvIkUFPB7hnQiVFtiiBurZVyo4kA==
Received: from CH2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:610:53::14)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 09:26:08 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::54) by CH2PR17CA0004.outlook.office365.com
 (2603:10b6:610:53::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 09:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.1 via Frontend Transport; Tue, 22 Apr 2025 09:26:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 02:25:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Apr
 2025 02:25:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 22
 Apr 2025 02:25:45 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 0/3] net/mlx5: HWS, Improve IP version handling
Date: Tue, 22 Apr 2025 12:25:37 +0300
Message-ID: <20250422092540.182091-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: da02b8cf-a3e5-472f-a12d-08dd817fb677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6EQW9mB008EHBkKu2Vkc0IbK/DZW6eg1Re2Ewr8lYUfMq06Fby9LBYbiTSv?=
 =?us-ascii?Q?4WLNiudIvrVn0K/m/8ZtU8B26TiN5UqJ1BBRyJ5xcbdrCAaCfwaQ+CLil81J?=
 =?us-ascii?Q?5oQN2FLmKW+qWeXdP0CXBVlxaFfVvBJ9PFyj63FIvxYeEjJKJZs46i7kSn/x?=
 =?us-ascii?Q?Xg165tO1hUTsJYzEYSvTT1NtWo7StJuJZDMuRTBHA1t8kzvPCS5oOcdHzjsu?=
 =?us-ascii?Q?6KH+TpaqGZVE3UKU8udNBCgSMzvsDpEAoa5Tf1WhHm6YcPpQrsLe5dNvm5cx?=
 =?us-ascii?Q?J0IS6GxTnhuYdDIrduM+iXRdUjew1A/gGrFz76WKpIK0KH3yEOR1wpWhdcGh?=
 =?us-ascii?Q?guHvUcHjueEw01ia147HNcmp5pmKwj9NMRjhFI/kqS79gHgMg96l8QUMzKpn?=
 =?us-ascii?Q?wbzP2RJef1iXNkb01coQ4qDPKRxnaG/j8YZMOg2esk/jeAAc6OJk1238SsHK?=
 =?us-ascii?Q?FbB9ggPBMZl1UhRhwDuPB1SLwOPX7uVrD+PRez7RlqZL9179kcjHTm/MeyBS?=
 =?us-ascii?Q?qCNptlejw7J/m1XZBwJGonSrbTLITG/OMTBvEPxt1YGaIn1TQY0FcQX14wYz?=
 =?us-ascii?Q?d8p4TYWNQNNJefIvQFYATJE3U2c9+ajQ8umuNQEbJTjZdHUhFgiz+1qIRMxp?=
 =?us-ascii?Q?T8AkoZ504VD+nN501zMrfV+exKS9KIA4C0VcSAEoqiLvE47UR9q0cRYk1ddH?=
 =?us-ascii?Q?7utay9WzdVzuPAsqGKf0SDHhaAgXI4Dm9GpqPJ74HUfgcnFJu0PhmoAYzqUZ?=
 =?us-ascii?Q?GzxG0HIymzHRPkW7/9Q5LAr/KtGZC1CQ4uIfg+DF0phfcYxFooe0r3xxzzT2?=
 =?us-ascii?Q?TfIvo8jkfCFwXIf5VF6S8JLv3pw4pj+A17ENHY38y0iEZDpaM9jf1dLQ73Tl?=
 =?us-ascii?Q?Z+xxtmI3+4wPpQY5+UUT5kyOx/+QW5kw1dtM1oDveUJXAIrhkoA7K45z/0ck?=
 =?us-ascii?Q?B2eV4YXe3fqYzhiRbdqSGOgQXklflmHFDJxondOG1dV2nENonn/snx8uToh4?=
 =?us-ascii?Q?Kp8Fg0upABI6weJ12lL8zufmPEJH3gioxrPbqHDwa9hrgUdOMyluYXvH7fVR?=
 =?us-ascii?Q?yb+yMo7z4Yxc+zvldJt4Jg/pkGJ5uvviNiClbXlHq7CIxjsK+CBkaffjXet6?=
 =?us-ascii?Q?D4wkZ4Vg6KESOUWpGp0QWexTNvFM5gLY+dcdGAeNQ3jVirBVoZfc6Bj5otB+?=
 =?us-ascii?Q?hWNo7TozZIaNkUrVezCvTy8vZ9iX1iyFZM8U4OI8evYdqqMV1rfe/RuoaQt8?=
 =?us-ascii?Q?wi5voWRjulf7/Q9qXkErrc9/IvpmOn8NEM2VLsb4kQR9aJy1+YImarJTyngN?=
 =?us-ascii?Q?+hJyKnB5X0Ey6RHmp1cptvmefGOX1EjArBtWrHtifbF1NMvUroHLNld20WeP?=
 =?us-ascii?Q?f8ZYmcZWpvFzdQADNoDHWKHhJrUSq4iMExCn6NrfCgJljXkhQX5aqVzgPbJi?=
 =?us-ascii?Q?iHsVQ+Kevnzvr+dL37m6LO3z5toPEIkIAPHA0maAsJJ0QvQZhSJ4iAFhZtmj?=
 =?us-ascii?Q?Rx9bYucydQScknJLaHwdUqwh3CnG2CVsbL8o?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 09:26:07.6959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da02b8cf-a3e5-472f-a12d-08dd817fb677
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481

This small series hardens our checks against a single matcher containing
rules that match on IPv4 and IPv6. This scenario is not supported by
hardware steering and the implementation now signals this instead of
failing silently.

Patches:
* Patch 1 forbids a single definer to match on mixed IP versions for
  source and destination address.
* Patch 2 reproduces a couple of firmware checks: it forbids creating
  a definer that matches on IP address without matching on IP version,
  and also disallows matching on IPv6 addresses and the IPv4 IHL fields
  in the same definer.
* Patch 3 forbids mixing rules that match on IPv4 and IPv6 addresses in
  the same matcher. The underlying definer mechanism does not support
  that.

Thanks,
Mark

Vlad Dogaru (3):
  net/mlx5: HWS, Fix IP version decision
  net/mlx5: HWS, Harden IP version definer checks
  net/mlx5: HWS, Disallow matcher IP version mixing

 .../mellanox/mlx5/core/steering/hws/definer.c |  78 +++++++----
 .../mellanox/mlx5/core/steering/hws/matcher.c |  26 ++++
 .../mellanox/mlx5/core/steering/hws/matcher.h |  12 ++
 .../mellanox/mlx5/core/steering/hws/rule.c    | 122 ++++++++++++++++++
 4 files changed, 216 insertions(+), 22 deletions(-)


base-commit: 07e32237ed9d3f5815fb900dee9458b5f115a678
-- 
2.34.1


