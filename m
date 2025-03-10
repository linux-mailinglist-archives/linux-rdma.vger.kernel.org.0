Return-Path: <linux-rdma+bounces-8527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF500A59395
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D121891645
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EBD22ACD4;
	Mon, 10 Mar 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAGx2M1t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828822A801;
	Mon, 10 Mar 2025 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608397; cv=fail; b=XU+/5Bo+06uPlqq6OHWSr5jVwaSvXX5V6COFuY9sPXUyvCQdRUegVf3blQY+hbWikEFLkSLIeFoJ+r6WzqvZzl4IdResQ05wKw0iuPydpQCFGOJTu0m6ZWX0tFZs2Q48Jo+JFSvcx/5glVy1FDaPFAXmXpcgeTfSyTkxmCAIuRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608397; c=relaxed/simple;
	bh=4FCY7zxPuVD/RjOSbmxHOnl2tfMSjAVKfuUDBhxDDh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhfsVcdhjg+qxUWjHMI8rkZVuHoxONRgyS5kHqivjP5dEeQwQ0Pq0ZxRTs7MI/PU82aT6XGI33s8JkNO60nvoqnmlE/0VEvfJqNCkJSSYJ3G7iAxzs0O7DTwwl5y5sRd4fo9Nj4rstZwuAYnqSRv/BixMolsqxlHwkyiRYqVhk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XAGx2M1t; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtBQo6+uMfYzhX1L9NoGBCX8vlCFau+GXDIyUbUgbE2w5N8/prZc+xatufqVuRDQT3fe8enUJQFKl3xtsEo/JzVnhAkt9ATAKwz9OEqYLwzw5Y8j4qzunO+IGBBN1jchEVQ1Q/NSlzOgzppfuD7GV2g1mnHZo+UbEgqIwx248JW3+ZJhwlcRlYSz0v0Y9gchM7fnszYNFd3U0yc4Kws1vzgPx9uP+K1TgW4Od3NZ6XtG/1SZOWHtsZb9LZILAUG4rIYOmQ6+9ndIhI2+Ty6IbbL+TByMRmmGJcd5+GfJNA5e3Fe3jZ72ybIAV8ulo6MJ0ONj4EqCy04aekGDlUd4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkaSx5eXLQjoR7q9kuZn5EswxNnvRaE88tmVUKvTaBI=;
 b=pgEtB+zNg96v9AplS5/TwwFr9QzElOHCYtLux7qiu3vZG9oJaYB5IT9DAew37FPGBJtoRxB76gpAyuRcHuGhVWRX5w1D5Saj5Yyok3xgVVvF28rcwIxVJJ6mT4YlkuUPrXmezQw0M0ExzU28wLlSLA1OLno3OAgQYuqgZmu8IY0FIWRpu9YXZKaZTaW41abmPJUCzxtZz5A3jVjYQTBfr8fRIHHKdB3yWtkf9bLDZRIlopu+jPlqOyusk6Gugnld8QOodN43x20pCfd28Z/kVR1s2DCVwwMQa4/5VOzUZz+pXqOgpJyrASue2A/a3farZksdKGsNRAyUOklu9XsSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkaSx5eXLQjoR7q9kuZn5EswxNnvRaE88tmVUKvTaBI=;
 b=XAGx2M1tdm0kXyyM96dh3zY9N0Ibu9ZAp2JLMBKhvXMFzw0m3vpIPteey/TA58jKekK1aoS7M3BU3aSJsjaHViPpWJPr3NCOuL4ZKKSRkCGeYMRsI0fnblqSmt+aJ1ITBVPNDJz9OTk+aZRVwgsrz4wG+7IF0Y617zPWjZpNWmt2zUnYMO221B23dAuZxWu2tb3lIcuApWQWU4Q/zUN2TcHDZapPyeLNHjjrKJ/j3ktVe5/uha+lqAjiln3huDLfMZvMirQ0hwdcgNf9xryhdd7XflDc3VypH/NctvtsSOsJlxH7iFhi9YPh0+VhPCq/78TRhBJLk6PXdaZYkFJzwA==
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 10 Mar
 2025 12:06:29 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::d9) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.17 via Frontend Transport; Mon,
 10 Mar 2025 12:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 12:06:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 05:06:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Mar
 2025 05:06:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 10
 Mar 2025 05:06:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Yael
 Chemla" <ychemla@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-03-10
Date: Mon, 10 Mar 2025 14:04:53 +0200
Message-ID: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcb38f5-f488-4ecf-e87c-08dd5fcbfd53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmKSTzGm3RE4hHzyGj8zR+TFqLYDkcXOhcgUR39+YEogkJfeQLSjwa2QOlNK?=
 =?us-ascii?Q?9bJYcPwQA1Kp+WIw7NY6E8qzHT09vNscqFasTeccSJ4Y7i239W0HoLQRd+VV?=
 =?us-ascii?Q?1c1nOE4YrOVQukA+Cc5yYccFoNoo24OsJJbxNIhL5ioG4pzRUYBwujlEcno2?=
 =?us-ascii?Q?jvuh7/fmYZGQB+RWQOw8aC+pf1C1eeKpXdEK0qrRhj8c983YFQoWCPHN1jOK?=
 =?us-ascii?Q?QkInrc4lHDw7K27eQMFBC8R9I60tJbcbQPRzM2fx2mrAxvm5Yv4gRMh9HYyi?=
 =?us-ascii?Q?6VTCJ923hwMARmPeATVgrJyZmKFi7i/JAp+w516XahuKYSyA/fBVJqZkHyBh?=
 =?us-ascii?Q?RNlRiJimR41AZH69QEm5cCGTEWLGxeZINuLJZDNy5S6FyYBmWhEa3Q3nwxEk?=
 =?us-ascii?Q?hA98/dq1CFFc7GJMV3x0hOOiXwkDL3PW4GxyS6smqguhowFxUQvyCbVCch3F?=
 =?us-ascii?Q?EXU2VjJ9UPsLRBBnlv+cMWfHPy8ceWRzXYVlLSG6wH9TmH3OnarNDG0H6L/i?=
 =?us-ascii?Q?+EBR6XvaJzbFcznwWITRtW1Dd97uEprxelXScrfXxz94EvPeYVwGrvr24Da3?=
 =?us-ascii?Q?8K1OBa9ZTkcKUfZM/M0hH/8Ck3Dvi8QYvAhpEmMSamEgqlrxZ3IlgZyFQ+/E?=
 =?us-ascii?Q?LJr1icf/OLaIb3sWUzvCUEevJV5MZWPY5tIRI+azXqrq1SUaqt/rl7ZSRC/M?=
 =?us-ascii?Q?gtDStdPznXJnTaHJ2ivnXOVMu89TGePKtTKkS0eSGHF7SswOQLAfCOSvRsdS?=
 =?us-ascii?Q?koEeUNcDj5NJgdwPbcMZ1dGup0BgW7cqNlfr3qvgZr8E9t9WvgLCRwZZMFk5?=
 =?us-ascii?Q?T+TVkxpLB0fS9gjtge6C2RVawLY0UxxKa4Zy+BDX8rOF6uLoH9zYbHxKYQLN?=
 =?us-ascii?Q?zRLBEI/iGEol2Cqq4vpGKdU2+QtdotmvBNTy+sIEtZIY/EmJwvYCoZOd2GhX?=
 =?us-ascii?Q?a2lS/9GOhX5w0itvDS2lmaU/JftHfp3zSwgLzzNJF70gxGpyixLhkza+eD0s?=
 =?us-ascii?Q?cD5i0I9cv55aJb+x64X95YVpYglmPqesu3P1yuMrAvU1tLxfoUsLJPDUoy4c?=
 =?us-ascii?Q?JcHObNfhtJVlV/uhserj0AG73So+HDpuFKUmlflnI8gRGrkUmVSgjnyucGsD?=
 =?us-ascii?Q?dIrWrEGTvii8XsuFygsNbDHmVXZUwjBo6qFD+BYrz99oysfpDVhwrpNlNDrv?=
 =?us-ascii?Q?jnareQw4PF03fjd61O0LvMlItYEc9Z6X2Df0HozgtIzkldNl2H8SXnefye9G?=
 =?us-ascii?Q?iPS3DDcA5P8dtG2GzmWtL2VL47PCFbuM3FzXhpPAySADB+wlM64ewWJvuzgX?=
 =?us-ascii?Q?F8wZWub+VU+SDC8tKIini+7BGO2jXtFbtBAJSyWJhjT5zZ1cNGZFlT7fsPMB?=
 =?us-ascii?Q?MNPWs9c1M3BjioFpBlWotUoDfUC1pzQeznMcAvq1E0LVM/sCfeyttAymXdda?=
 =?us-ascii?Q?2USfxJPYTX+WrmHPbOLSELWrbbj5mhZ0lGE95lWZKK0Zp+jmJEJ/cu4c6RT7?=
 =?us-ascii?Q?ZW+6PmJJstnFnSE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:06:28.8206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcb38f5-f488-4ecf-e87c-08dd5fcbfd53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

Hi,

The following pull-request contains common mlx5 updates for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit 15b103df80b25025040faa8f35164c2595977bdb:

  net/mlx5: fs, add RDMA TRANSPORT steering domain support (2025-03-08 13:22:49 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to f550694e88b7b13b647777f889e03e544d9db60c:

  net/mlx5: Add IFC bits for PPCNT recovery counters group (2025-03-10 04:31:15 -0400)

----------------------------------------------------------------
Yael Chemla (1):
      net/mlx5: Add IFC bits for PPCNT recovery counters group

 include/linux/mlx5/device.h   |  1 +
 include/linux/mlx5/mlx5_ifc.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

