Return-Path: <linux-rdma+bounces-7822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941BA3B737
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 10:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A216142C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E381DF75B;
	Wed, 19 Feb 2025 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rkkpk0+D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EF1CAA7D;
	Wed, 19 Feb 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955583; cv=fail; b=QlHiovx1dWRbGeQGdDHwhirTXfiE7HykO880olU1lDkLzbcNlrNEo7RSQ1F0DMiwG2fr/pnEdtyPEgIgE5Twhlpz71xHppjyfGvg91TL4v9T8WTyP74sQ4Mj2zyJSmRKnSvoPRRh3WsiMW426LQuxPb0827gV4ne37QNjw8P3NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955583; c=relaxed/simple;
	bh=BT2pilI94AuLe9mOXctcoU34sqQgbD4PDbifirUCZuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qokEeoRufWimK+YH6T0c4jr/1jNDnGbh+D/aOuixh0zvWV6zlNcsbybD1tQQiEvwKtZjxXxxAXCpTIesjxhbFnyMRa+9Wv7TpWkWovGwFeDz5r6fYMj2KHlyz7vbHTuGjOS3Rd1tMhH9LJDbDOaeqVg+yqsk28gOQSkB2n5ZKPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rkkpk0+D; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzlYTiHVfZGgx9V8uSR4xiEgRxxvKE6CcbfsPuRV5k2rZMXlp1mloQ0DpYbBgMCeWtNj/HuC33CHvvQqjMFCE7y8ZXt1ravBfzunFoC11WKk1by1beOLqRRWtXN7t9fMcvqIwnLnCBH+RqsxoDOods8jc2niWm9OzBhPrB/EV5+VDHDltP1motSbjdA6gUUBAaIl2uEF59UztLkAH/+UdNAlDfAk3fiKFO9qbmVDU8ktpyVLLpJhdfXqjY9QwmC8IhU8jl6RgodB3zc+Psnqf0dpyDdYn/yiQF8YFDn7xx/JRTlbCu1o4zlPhdDtR2/E7sgiPLO3ZP4t8ecr3i5p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lWxWeUXAytO/5Os00tN1tHiT/IDqx0mJh5wVhnPQNU=;
 b=bPgukYaqFpU8HEo7JbjCHg1kVB5FQ93o3CDPw/UgBzsH+bw3ad9hpB3ILq6pBmTyMe95KiTl3o/EL7eD8SRxC9ilGN/fPp9+lzvuYukeUK+syWjQxNzNgYb9DcA7Nj53aWHSHgepkLBbdrUgD4x5l/8mOJKUPCgF7Knvbh/ge/Bv2SAgnOtz7LTTCQ0XHnj0eevlXgbQ3aelHlAHqf7igvVuqIo5DEYLO2xW+V5ZqgM23Nz8POk233TZRbZ1WtYP063/9s/JbKeqh5Fva/J/covhfciGZzF6Pjlx+8vGIryYEd/1y/vIwFxvefYNcezu3RBKINltyb/sOoYgbvd1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lWxWeUXAytO/5Os00tN1tHiT/IDqx0mJh5wVhnPQNU=;
 b=Rkkpk0+DFLWDQdk5JkXVlwSBCk7QtAtV25dRTrTWkdMhGDj3qXrzkGgN+YQoAH4gXXCMJnGmKd9kntOs+JXHB2NMrcur84/6hwaZ1ARFQVFeZKYrwF40Oe9d24TWKCc/49WMQVRiV6LMm9bEBfVYYR1a075FcAD8BZyDTxToMnT/INMIJLrDh4Ve/7QDjPQJL0h+XzUb6aW5hlrLypQGXuap4FbTqjaYWdJvF3M79Ow9CDGDCUxO4h7sCW0TfxnaWS4uDtAD7CuZcmue5w54nFcL4/a4XPANa9QVWlrpLZbTyEN4DgIppyTCr2lIvJa/9TXsQi+v1ni/JiLblo+J7A==
Received: from BN9PR03CA0617.namprd03.prod.outlook.com (2603:10b6:408:106::22)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Wed, 19 Feb
 2025 08:59:36 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::3c) by BN9PR03CA0617.outlook.office365.com
 (2603:10b6:408:106::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 08:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 08:59:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 00:59:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 00:59:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 00:59:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leonro@nvidia.com>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH mlx5-next 0/2] mlx5-next updates 2025-02-19
Date: Wed, 19 Feb 2025 10:58:06 +0200
Message-ID: <20250219085808.349923-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1764df-f8e2-4e6d-ef3e-08dd50c3bbf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhlD9MvtjGYNVAoURdyggR3zcraj1vD74MqrN8ynHy3c4Y+LMMa4qWo7gbAQ?=
 =?us-ascii?Q?KUTDIYYQpd11vPlHi1sZInl8BqTe5FF91t1T9esumKfenJBGZdJlfuzUzvbN?=
 =?us-ascii?Q?Y0p3Ho19rcAge9+g3Vos/sMdvYm8s25cIRqd0/Yu4NynA/wgakg58iRTFkro?=
 =?us-ascii?Q?kDiW3KFkcW1YXFnl60T+lH2+iWHKz8haeBGwOkZjLs1yK9Kk1YGqshAv1Epg?=
 =?us-ascii?Q?Neg6v/Ogw5QUYtnqYgrGejJsqfDpuRZUEYAQ7FzUXXSKHfJF0d4hRJpVDi1p?=
 =?us-ascii?Q?eiMjDmYjeCh79pEUMg5GSSCm5H2kvQl7pR05kmyxA8kJMgYxPqC2F9bXjm1/?=
 =?us-ascii?Q?xD4DrLhbf+o2OfROLI2Yqa6WdszXf5OS4V8uAqG0x/NfYBguCd2OjUygBl5I?=
 =?us-ascii?Q?1d7RZmvu2TDwJ2CeDG2iA9Z7rpsN/cm/MvRcKUlkzC5NN0ugD49y8kqk9xYu?=
 =?us-ascii?Q?7LVxtm9Gw0XEEwJtiRu9jcwsLonEFC3yd5MXxL9x2R9TIMxfdgfL6Gr8BSk7?=
 =?us-ascii?Q?ojXO8dLOz0N7CmoAAmxAtuOaWMGOGxm+27Xvd5wDIB8OEhq6kOmipI+Xtrbx?=
 =?us-ascii?Q?kGQz31ESGxsU0hDVzLYvRydxfqSiJkxR4K0D4cmBXWfjP78jLYHCKbpJNcyZ?=
 =?us-ascii?Q?hbD90SCTL9jI5uqLiP8h0SXu4XAgLmSxRaAChtJ+X7l4f31fE30QDc8ansPZ?=
 =?us-ascii?Q?0gRLUJNMEcAdjiMa/0pOxDYAiZPM4XxtQ53W3fIZfo0igMEY7bfOJvfwPlm+?=
 =?us-ascii?Q?M+hJJdTGha80Bn3JQ5t9GSypgomUsl2QXrYKlac9YpfiTtkdUVxs8227urGp?=
 =?us-ascii?Q?7Jy1aG8sjYdDqb0YyWuKRTs+fnuoiwrNhSAjCRsWIy1Q7dxEM/OuD42sUF2a?=
 =?us-ascii?Q?DSIhMg3s2Q65R8UT5rW/C8Tt2S7Pwp8e0r8x0cg1ESf8qhibCMrgtSc+JdKT?=
 =?us-ascii?Q?aDJ7ozkjZu07bA6qK5NApNu78QsVn5ZLzpgZTmiflXlSOTm2KZvpaAI3c88m?=
 =?us-ascii?Q?mL/3QgT1SZZGErXbltv7VvXXIJO5KxRyTexuJsKgAgMt0GC24anxZS4jsuOz?=
 =?us-ascii?Q?E1zTSq76OmXOHntSQNn4uUiT+mzdJlEwz9D8kvJdG3R6w+ZKWW4yFSgw/EQy?=
 =?us-ascii?Q?zaKMce+eSxt9KPPqTzoJoCRC+/ZcQ3ntKN77rA/Ewlo1zGAHivU1OD2h+EUi?=
 =?us-ascii?Q?E8IDol9wXiOq7iLVXCJMRLszh6I7ZGJq/K3XDNNRMP7x37v2FNQE4JViHUQw?=
 =?us-ascii?Q?/PP+6t9rkdq+gvCpk6f8evKvNfDWuvMUG8dkRQH49gAcXAhoru7Unndwoej9?=
 =?us-ascii?Q?S5TvAI8RTEUrvfqMYgEHSjLV/NZ19IJdVGnteBz9f0azDHkzZxNzEb8VbSgo?=
 =?us-ascii?Q?dW/CgdMZqoSFmo3zlqNPyTEohOyBSPIqyEAKpgrJMxTtvg8mephPcoUJJLhe?=
 =?us-ascii?Q?scN60h8AxSRageJzKtITzLqXf/LKuy7NDGgJB59CP9Xy2MRykz//WHgV9n+u?=
 =?us-ascii?Q?7e+K1BdkV/b0trM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 08:59:35.7011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1764df-f8e2-4e6d-ef3e-08dd50c3bbf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

Hi,

This series contains mlx5 shared updates as preparation for upcoming
features.

Regards,
Tariq

Patrisious Haddad (1):
  net/mlx5: Change POOL_NEXT_SIZE define value and make it global

Shahar Shitrit (1):
  net/mlx5: Add new health syndrome error and crr bit offset

 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.c    | 6 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_ft_pool.h    | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 3 ++-
 include/linux/mlx5/device.h                             | 1 +
 include/linux/mlx5/fs.h                                 | 2 ++
 include/linux/mlx5/mlx5_ifc.h                           | 1 +
 7 files changed, 11 insertions(+), 6 deletions(-)


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.45.0


