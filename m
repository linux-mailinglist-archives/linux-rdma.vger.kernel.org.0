Return-Path: <linux-rdma+bounces-12387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D0B0D539
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 11:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46403A639C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67BA2D3EF6;
	Tue, 22 Jul 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tewec8AC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011564CE08;
	Tue, 22 Jul 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175093; cv=fail; b=AEtFVG+jkXklcny0uys+cZw1zoD8StYOvsCbItvIAMmjLbl8j1YUJyGvT74wu/J9OUqbUVO8pqs4t8P45KE+HBnuQHi5zUI6cbq3J4NWrE+abJ/HVOBG+GY14wT/oIASpUvwEGMJFoLYe7O6Ko7EtsyNH2XaXTtCHja8/DGpnYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175093; c=relaxed/simple;
	bh=JEf2udjvRBx4s2D1iAYtH3ZMsQVveAUZcvcox60T7WM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MltQidvoDCEGczcThn7d92D0mBCZHsZX9bNRCl+L9dh+aJnytGvQ37utozofcoQkHQOovTq/L22nOa9FrKGYYM9OwdS4QyjoYOuMyxzk0vUDzlTTU0qUQUWhObEL4s28Xlid13ru3lINaULJUiuOeQyLFCuyAwHXbI5I0jdidOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tewec8AC; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dE+JLwPix8ugriT3kz/wGobZPJU3mOhWaJP7GR5NOeA1x1bqLTEqU9dXTQVgawNifU4QZbQwMzenFOnd3J+/p5t46Cr3jJMpE/RPOipkxJeBcvsdoSoYGn4yFrxLtfkJvxMC7p0559oJEimg+KIkpQySm1TGTGCn1BEjlIWjNQOpPnZm3C0dLMR1jN7nl5DyIhrELklDNOVQiHdprvMXDn/SNR0Xm8shOwgGVh+WPf6Z+Gk1Ls65pOPKUFusQmi1js2BqVxVN/FCLJ/kaWMZ1qOJhjPvue3rUUS4BPrb+5WMYMewkiE0SFIcPHBSi9Bz1AumyNwfpPrdSgJdlWDLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIqhe1ozvsIlFysjfhHgQAGOuIHdPwcukiuFCs+WXM4=;
 b=tMVPOOQKZYFFB/lYZ6Cwt2TtZyjGvO1N/3/IbJyDYHnvxT9pC2VgzIwT1QJLY5SemEE+tWU15rNm41IB10OoqKvANrXYOqvZXAu5CczUDYb0+nwYBMKygNFyrQxoFJZIOBYlTFBIW9U0sk0//TvFLocfEzo7CtqwIXvCav3B/LGIPQwSDaZLqLr7z0ui89TxGBppWPt0sxCwFyFJnDSSjo2+VHMNquDhUwN7TlnJH7W/CpfZzmzpejxnZTBL8xLXZczqoKZ0dn+U/qD+p8foCKbGaXisLYYL7TjON0bqH0/ASfRG9xRuqChjVJn4Dc9JFAirLxDErKIen0vR2Cg13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIqhe1ozvsIlFysjfhHgQAGOuIHdPwcukiuFCs+WXM4=;
 b=Tewec8ACcFl6gQbMFud0cxLKYWkCxA9IbjrQEiDAh6K+By0L+wEN7wN6N2KtlhQzT0L0LvvV3AH1LE54XnNqsRDdDdSmf7Z5R7sYsOLrc/Oc8T+EMyoS/hrZi7mmW5NmJ3qqN2QfpX5WPny7ey1mYHf8MpkcMu3Z0YiK7et7tiwoDpj4MISixMQCqII5aZUvf3W0LTxo5j4EEd6aip/JVttBkdlcTgWt8MeUqPSrhrTZJzynPIjxKPaufGpj//w9Xl9ZbdQxjN5Sh5oBwcB2RrWAi9IVgXaZIoU4PVv7lLwMjWJLjeEVo5Ux6EZ7EgEchqUdWoSip+dK3V9yOgTEvw==
Received: from CH2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:610:51::21)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:04:49 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::95) by CH2PR15CA0011.outlook.office365.com
 (2603:10b6:610:51::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 09:04:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 02:04:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 02:04:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 22
 Jul 2025 02:04:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [pull-request] mlx5-next updates 2025-07-22
Date: Tue, 22 Jul 2025 12:04:08 +0300
Message-ID: <1753175048-330044-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: de2d7770-21c4-4ad4-9df4-08ddc8fecfe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbXvQ9BPfs+TDrlfQMT2mCOL6aeX4cleoj4pQ47vcpczn2mDV2fRFKmYxS4t?=
 =?us-ascii?Q?7gdt9lMx7wYm2X77KrVEMG1lTVhFhiuKEYbEw0im1X5zvYT2nuGQDLIMQSvV?=
 =?us-ascii?Q?eUHBHeAsEW2PuegqpxxqF9fwCsalMKNr49YhvOzDrNeqYAPkAoBJ4KMAgToV?=
 =?us-ascii?Q?cg8XjCMdl4ZWH2RqJCJhPOdU0vB/b2AQ15Wgp0zLt6tULcS95RIUkwZetr6t?=
 =?us-ascii?Q?guw9y9oNt1SjwBerNRYlNveHNoh/QLeP7A6EBicT3FpQ8JLx0VBOppmYR92p?=
 =?us-ascii?Q?wWZJ9EkT5oKw0Krq9rLqTeuX77ygCHKChPdXqQkz5TgPTJIT2/1B869Sb03Q?=
 =?us-ascii?Q?SmvcdfnNbc/8d6Kfq8MTQxD+eUi+aXgjvIaxvG+xQ2Dp4uPp1sXE8jP8L9VA?=
 =?us-ascii?Q?3Xw4QyuCGkERyTdKtKelckkMMJK6fgKnfoEFn0zvmu8Lv5Xy0bFoIQre9tgo?=
 =?us-ascii?Q?jWaPK9xYLQ7AJ78IF5kBoovwjjKvQjohxwayou7pviuXltLGWyQWPSZv8Npf?=
 =?us-ascii?Q?c+iPL1dYZ0nxlmU0W+P+7idvatWjcJaI/P/YEMcrISs4QMOtW4yTVsspCojF?=
 =?us-ascii?Q?9imSq0nQ61+9B+LjEcbe9/HMFMxImJqvmWoG48zPDKBD13XdAXZQFP++MJfJ?=
 =?us-ascii?Q?SSNf1QunSIfHdp4/sH2vmxQTTtAAvv9yeSc6kyrLcPrlmQdm4dwJX+GL+q/P?=
 =?us-ascii?Q?ERligerhHfzw5CioBsRRiE1ELd5vJ+lJOcFCCtWUuZWGWvbviaxELPeLMQBb?=
 =?us-ascii?Q?15ynCkgd7jZTtlSs3vUigwOBeDBChevomglQO7L7pVA6+zqkNR5LF/T6vArX?=
 =?us-ascii?Q?wDkrt0QxxdRnyE+r3RjBqDZfT6otmjWCdXu8NlkkUAMFptFXJBm3j0kuG3Yy?=
 =?us-ascii?Q?BhpWPe36AMFG3X18ty4fGCqVR9r9cnciHfVqYWSGBaROmkofsmUz1IKV1eZN?=
 =?us-ascii?Q?o8brlWTN7mZ6YFdxQAA5sNIuVH1N4yibeZQI00l8dpi0UQ9qqEPJFmslzMrc?=
 =?us-ascii?Q?PhtsxfYQHpyjdVWkfXDLKbbcRbZ/J1/jQMlT6uFNXhSCrvPjJQj7+U0Br0Wu?=
 =?us-ascii?Q?Usj0aWwwyE6O2rzSywEqX0ihnGihhg+ZHDxW99XrFVEf3V4Y2iyV9ocMly3/?=
 =?us-ascii?Q?Lk81d9PO5g4Uo7yE6elvK2/qB1LjNFfTKXaL+hCZGbt0znJsRavJnokvpfJ3?=
 =?us-ascii?Q?MgySfUP6g3zNrvkHNtB5YcpU+yK0y6ZsU1eZwlXvSW8Esv1NqZZJ+HuuCYaV?=
 =?us-ascii?Q?dm87nU9oJnBhejZ/PQemuDLABA/R70K9tAcyUqYGzOB4LAIojuNXHDJ6jZgp?=
 =?us-ascii?Q?hH9EGPIpR6HuZI5YsO4dtFLJu9AiL29/X9JaCInyv3Zj8+XL2dohXSxRU4lU?=
 =?us-ascii?Q?bWhtbJOICV3QCiM3YfSc8fJy6w0FGkSAqsPYGesf5ns63tBJmnoMqxJztsLa?=
 =?us-ascii?Q?b1tcO1lDrJaApj1upjMvPswbvJnW5IssXvGwo1BBAn5GhYTSr/15TCuUlEm+?=
 =?us-ascii?Q?4xHh51IQ8l0rjbJicGDOVymOnQe6/TGXj33i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:04:49.0062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2d7770-21c4-4ad4-9df4-08ddc8fecfe7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit cd1746cb6555a2238c4aae9f9d60b637a61bf177:

  net/mlx5: IFC updates for disabled host PF (2025-07-13 03:17:30 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 9a0048e0ae14cb7babfd459ec920234e8a2ab86e:

  net/mlx5: Expose cable_length field in PFCC register (2025-07-20 03:02:14 -0400)

----------------------------------------------------------------
Jianbo Liu (1):
      net/mlx5: Add IFC bits to support RSS for IPSec offload

Oren Sidi (2):
      net/mlx5: Add IFC bits and enums for buf_ownership
      net/mlx5: Expose cable_length field in PFCC register

 .../mellanox/mlx5/core/steering/hws/definer.c      | 13 +++--
 include/linux/mlx5/mlx5_ifc.h                      | 58 +++++++++++++++++-----
 2 files changed, 53 insertions(+), 18 deletions(-)

