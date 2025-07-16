Return-Path: <linux-rdma+bounces-12216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F356B077CD
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 16:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4EC50849F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6850E246787;
	Wed, 16 Jul 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAnUNc6U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC723CF12;
	Wed, 16 Jul 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675531; cv=fail; b=XUWCHL/H8Md6xTbT5+uBJ/zEQ8hFaiSh6waxBY7ueFtX8YYovjKOC/0bPyE9sJL5MhNUo25SA280YMJVB+eheGdqOptFLOvbN2B1JRfbQyrkdPQd++Vqr0HbxgCFcVESvD9T5TK7vhacJlQMRcHZv9IvAcYFbA2LqhYMGqw0BJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675531; c=relaxed/simple;
	bh=P+wG7kvP3rpVvSrXm+EDrkmWfwOPKUcvYbpyIqD7k00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AuFXEaga8JbVvAsM7ZK7YYGZtXceQTzN0tb8goHNdWFANag1LXgxOGJyc94+Qwi/sxLhG078n4kMDU+tmn/o64ew/NQJ0ZxoI/u9xkxnPc8AYdbCQ1kYoYekaAFbRIl/GNKkIeob9SUfpIfHrEZABVDMBI9GSwdSkRCIQlfkiMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAnUNc6U; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u14ySKWMRQGN6uVAZ0/faDkG54CFkq0WHG5u2P6khMfhFndiM+HfRc2KpczBB+uNqqriUqw4x4Cs3Ml5xCIieDzxTLvtA6AU8YaosLhiRo5QG5sLStyE4xrmL7ca2eHnSJ/SWIYEQ4a9BxFa6YI3GnxRfJGWOxWSki0mQ+PVXzPp/YCCvvRcayv1ChZOkA4vp7zQtG1kfz0ZwCQYsbwVIY6HnLu3g04skrjJ5PUWoWpEf+D3UA9IxgXlROlCzNPMIG4Yu87u3dbrpLMbWoy2pSMzNfRx/cxIKQNwevaWV/zYzjWixSUZ10/rXFN4az6p9NxRonz1RVX+yz+5TtUBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oMrcEQDM2xKTR99IoBqKv2cbbZWeLto/CoTAnDKBa8=;
 b=eQhMuyDCdyn7Tt9l6+J/ZclMwYo9nrhn3nBKxWDoetqxCJwulhuEfgafFb5igIy23MD9IKchtHodzKHLAi3S1ENgipF2OscvDqjLpzCEtsrWvsJifjWViFu6bslW4HRVgNojSv1N2sb7nb6dP5ypvERGuU/ci5Omh+zp3WDblRjpa/BV1Pmlj6FdIdw0X25p/oasgsx19luGVfERXFFpDuYqlicxNWPhBcRl0ePUv5miqzo+Tjg/GFNWRpg37VXLElwcjqoZEbT/KTEmK3xEZ25mep3l0b44RsdRpMiygGWRZVsxkkWXeRgVxdQsb4LN0gthOqIFuUrl0ghOLYxkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oMrcEQDM2xKTR99IoBqKv2cbbZWeLto/CoTAnDKBa8=;
 b=YAnUNc6UZCEhjOGy5E/mDCd2oZR6lkZYBkACHEchnld9pN5I6XNk9ICofMLDOeMuE3swiaHwLEAaH+CBfqJIPTra84/Hnh/LiBhW1ZHA78zZ1ovk1c3wKBmBauSFWy1Pqosd9Eyl7/KbB6iuzcnjhVx9llP7XnTPIpJvp+WUr0P1Zhp0ZlRwbrRiSR/cnMQyBpusFQt4eou4d7mbBQkIciw2oEoNFNbgcQKSeFkY9uZ3TvCUSJ7/NL8ayocuZaysgBju99R/9aJkTyxJWdp4a29vwDpF2nCPlHbNLzGFLsaEVNZYvexb9j7w9z/WA8b9VKtGHRbBSVS3+ffMHDxADQ==
Received: from MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::27)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 16 Jul
 2025 14:18:42 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::94) by MW4P220CA0022.outlook.office365.com
 (2603:10b6:303:115::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 14:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 14:18:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 07:18:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 07:18:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 07:18:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 0/6] net/mlx5: misc changes 2025-07-16
Date: Wed, 16 Jul 2025 17:17:46 +0300
Message-ID: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b3a7f3-5c27-40e2-2dbe-08ddc473a9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VBhZxYzQzUlYykW9SYQYCWcoawNWTzz3XfSpRdAd8GnjVvirH/RRFoL1loZ0?=
 =?us-ascii?Q?tBdya/kYmuAoHiFODcK+NmMd0MQ+q1seXDQSUB5NJG8QydlQ20hkNr+aLRms?=
 =?us-ascii?Q?UD0S3zBg+sSLzZ7pxCSiCMzSlZHJrIM+8Qr/QEv7nlLvmaLU81HMuvCA0Rpr?=
 =?us-ascii?Q?00ylGU6bAZZ5+Dk2PjGzPlTz7qacD0nQvKJk+L+XSCVVPAQE/Jp5pPlQgrZd?=
 =?us-ascii?Q?4TqC3eFpiMyevCybN+lPNkartdqMeh4S5QjiM+CTvzOCbpHpJ8HYdtghX/Nt?=
 =?us-ascii?Q?kBWQQ2DvuaejuKzJpXW8gEIV7Q5NJEFsHtn3W1B5yC8Sgp+8BdeRH2QFYpwj?=
 =?us-ascii?Q?epuCajAPdPoGBw3Gq0NdlaArLq57iU1y+AFbMgsBp2Q9n22hWWdnZOyYxxK/?=
 =?us-ascii?Q?V4KrxF9RjZSr928m/2nk524j8JPWkyJkp90Pt6S+0DsDvrSypz6Xmw6cBcWw?=
 =?us-ascii?Q?NYLGHEAp5iNtU9Ycbs1U+AV3hhaMtBb4c56eIqgfzxFo5QAMD0CRk4qhF8eI?=
 =?us-ascii?Q?ySZtB0Vn7UG8JmsdSFUMp+YzqQmxOsB6Gw3BhESbFjYX5UOzwTEelEDBEkWQ?=
 =?us-ascii?Q?l2JYAQDcf7zv2uyLNcqJmmW3P19TEZ/Gj+s5oh5TBFq05qU1w+bJAOf+s+Hy?=
 =?us-ascii?Q?Ga2cgxpsmqq32RiRGH3Ll3Mz61tk90rSy3rkUPvlRgoTQM9Ew8KtsV+XS1xO?=
 =?us-ascii?Q?vO72fKph5FTmoC/l3U8srUb8l+HCS1fSUwMtTMKDK8SNpxChaAfTftTnJxPY?=
 =?us-ascii?Q?nlkFGghxhE7OIoUpgc3M4YvlGn/X2L6mhystAlUyiRd3Vx8dZisD/BpWiso/?=
 =?us-ascii?Q?b1NRlautdm1PB9s5fJr6cVm8xTr2bJDReVYmX/dG+GMV2e3/hfovzpKYwjdw?=
 =?us-ascii?Q?NrBscbapQUKEKmM9Xy2CHxKi+N00WEbKhVu/0FC9CJiErsjnPlSQZoKvc9H0?=
 =?us-ascii?Q?GmB7u7HZwSkIM3t2JH+CXT4NPmZJwUMj670dVuGwv+ItsB2eChMyaj2F0XDb?=
 =?us-ascii?Q?y8Gw5dLaClMqOvikg1tC/7nHjhrqkTrVyPlf990FSCG/PX5sf/jO9ebQ1Yeo?=
 =?us-ascii?Q?Zjma9R7VP4J8zcLpJ3YbX/ZnIy7FXEklcQelMZtic3KEiTsQEZNisP9DOug4?=
 =?us-ascii?Q?mL/8WKs7g1pB8LAMK7HZfHNmHNRBtNp5Ne570iTTEkfRP63TpkBH40fZ1wMA?=
 =?us-ascii?Q?pbLm9y8O3rYEuAwAZ506ePXbz4TF2AJy5rUxHYEBd1sFBs8SVmmJZNTUfT9b?=
 =?us-ascii?Q?RzAw201leK4fB+TUvMAn+jTmdq5l8+CmTcpd+qT2z4gR1xJRhRMaoT28WrV6?=
 =?us-ascii?Q?WDHz9aSNu70Ig8Azx84Ttf+k+HPzy+IPu8ibhhDjanjO8ATev8JGYg0/p8Qy?=
 =?us-ascii?Q?ib5GGU/cK5krid87gLiKyobJk8I2/QrTB5GLVEYcuJvEC812IBI+GH4sLlKq?=
 =?us-ascii?Q?7QKsxaoplFe4efohz9jkNeuDyBJFpBN+CYLEX1rqTb8/YcpYADxf+0dgouCg?=
 =?us-ascii?Q?qK2k7tw2M/7xJ+jG6PD3DVmiNWDxHxOef89RS9SjMOz1qwqa2xx2ETzNmw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:18:40.6756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b3a7f3-5c27-40e2-2dbe-08ddc473a9ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

Hi,

This series contains misc enhancements to the mlx5 driver.
Find V1 here:
https://lore.kernel.org/all/1752471585-18053-1-git-send-email-tariqt@nvidia.com/

Regards,
Tariq

V2:
- Add review tags.
- Fix RCT style issues.

Lama Kayal (4):
  net/mlx5: HWS, Enable IPSec hardware offload in legacy mode
  net/mlx5e: SHAMPO, Cleanup reservation size formula
  net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
  net/mlx5e: Remove duplicate mkey from SHAMPO header

Leon Romanovsky (1):
  net/mlx5e: Properly access RCU protected qdisc_sleeping variable

Moshe Shemesh (1):
  net/mlx5e: fix kdoc warning on eswitch.h

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 10 ++---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 43 ++++++-------------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  6 ---
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  2 +-
 .../mlx5/core/en_accel/ipsec_offload.c        |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 27 ++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +-
 8 files changed, 41 insertions(+), 54 deletions(-)


base-commit: c3886ccaadf8fdc2c91bfbdcdca36ccdc6ef8f70
-- 
2.31.1


