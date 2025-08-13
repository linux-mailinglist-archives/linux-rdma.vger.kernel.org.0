Return-Path: <linux-rdma+bounces-12725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F89B253D2
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 21:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BC304E1C43
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25C30AAB5;
	Wed, 13 Aug 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tPd+H4AJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0B302CA8;
	Wed, 13 Aug 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112845; cv=fail; b=Scrt0zYocYF0+/FyxW2vJJgSmqKNp/WS/HjjbipD9s//WuUmK8N8omrMCUUU/wsMIrUW2wgN8Ypo/Vm0vRS+jhObVEmZt+4NTF9VGWsnb+QFTBL37NQ6T4M8vv8bknn5gVIs5mheTwFSMZR8s+Zaj/jd5lmFQ71NU9Cjuu6EcXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112845; c=relaxed/simple;
	bh=ebd8ToCHV2jAay5gVaAvCRZQbJM180npTCky64CwKDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=na0z4vtsLNCn7ubYV8i8/nbjtfCbPifi6/1xwT8aewJxwS97T6FvNcz3ppXon6GtAw5WCFE3jGCNukPcGEsACHJMQory4QFxvQR37eaU7VKrR4FJVkLxFuy7+KIdL228sDcL/BgCucX1VSOux8CskKcMHkHbbmVvUx7X3LmhcBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tPd+H4AJ; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boqswLZWrJs5/RL7Ul4Ka5ncxIU48iEbaDgaYyg54ks/6H8I4k2JRVGBa5aqsEqZhBXWXPo+ZupGEjP2Mzr7ufa7Jh0Nc1VdXYSuosmop1Jb3aVwq4w39CLLYN7pbsWQsuzhw0aZDGUoeY6EmRcU2O1yTWWcZD0PTZgkiXJaYMHicS5bHHRCr5mo+y8jvx131antH9zWXH9OeZNkpWVQaFRiDtk+eQfUkyMdUSrUhVYqUrBkYj5vRK3SoLorSC1X6FezVpPcB9VL3iJeni2DiEd7UnZDw6kcXLPb1z5UnXSXgVaoUIWdweHb5rtmtk6SKVoNMs1R1O3SGY33vmkMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcT1YycYgFJm9kqlBVRtavZho5/XsJu8XVa5bK3yhHw=;
 b=VRxWOsghxyUXeN8pgjPGw2dpWXVQ+27W1diKxcE0KvWWOc++6BJHgpOtLS4V8Hl5jTXmWNGMPkeiBxFDWYu/GPlbRF2R2SgtucTY7DBnW7HeHES7X3vBjfOpC1E0NBV9xFBPWPM6AR68NAtiltsk84LXf0Tqaeio1D7BJGTfznddGICYlqfgktaCcJ7SHHm3KcwQgxScSMczvntez8W0R8G5PYlW6M6VelEAoJ9WP1OSfOkJDj2P43sW5QWb9zWFW//ocwLTmEMtRg0YvtmC8AMWNhnYsQp29DEbXnW1NKGiGYlRF0yAUDQuV+RmHoVTAfyOffW8Ec+xC+26Oh3YOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcT1YycYgFJm9kqlBVRtavZho5/XsJu8XVa5bK3yhHw=;
 b=tPd+H4AJxTYtAeyLaArvnlWrOsTgX8vtSxbxWf6ctamAH+GBCm0iy/7quyIUSCJKk+Hs9C/NsD4sg3/rJ58xarPXEgOZys6Ju34iAEENfYIA9IkuNByn8g3JZmmXYsQ8Hrf2S/m7bDHNPeJNdJp+Ub1mSoWbShbzW5aD5q0/nQv2c+qKC9/2bdyidun6crtqeLxZD/piRdNg3RPCPBkncMsYb0ruz0g7P646u+NWQUTVCnw5coJsl36R/xx2xOt4NHarwmKNqzwM9jMWTU+6f690hdnMRCw96MhnWmMrRCm2LKfdwAFHuW4Q3lWkESfFCdQRaRtqz+467tcg6iJHiw==
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 19:20:37 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::2a) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Wed,
 13 Aug 2025 19:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Wed, 13 Aug 2025 19:20:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 12:20:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 12:20:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 12:20:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, William Tu
	<witu@nvidia.com>
Subject: [PATCH net-next 0/2] net/mlx5: Support disabling host PFs
Date: Wed, 13 Aug 2025 22:19:54 +0300
Message-ID: <1755112796-467444-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d6a161-b4f6-4eb0-8b74-08ddda9e7bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZmv7fRzGWMWJ/afE5XF9xEZPj+QDxkDO7E581pyQQ+05OB4qABKy3oPNyLT?=
 =?us-ascii?Q?r2dWNHaetrmRKxJqE4d1mAnT5Pzho2zCl7LisYj0pEFB1VScrzjHHFdmHC+X?=
 =?us-ascii?Q?Yi8lThz7POWgQsPFuCCem9JxP9kfa9gwFALNvaiZOClX40tougI/m80Iy2Zf?=
 =?us-ascii?Q?LHAqLEOsjs++HAb1ktn2DGTHw8qwmn/GRAlrYL2d2B6pOBFQiPyIBWeJwMl0?=
 =?us-ascii?Q?ZGixQ6aCtl3xF1Cirh6cUsTAUuZuv9WE37HH2ERwX8DBGIyPdkvrT/cbpXtk?=
 =?us-ascii?Q?+rUapiiQsKKCKo/8jBopcrFo6WZv1bEeADQuRFY5+HwcnTCmOPXMVwo6Fokm?=
 =?us-ascii?Q?1PApwqL86xoWSBfYqspV3oOQ63R+UZUObwhhlHAieH6gH485xgZSXvo/Ubo5?=
 =?us-ascii?Q?USvk1CH1HtGNmbtTWEw/S1z1yBq8iY6UIE06HWMnt+FAV23jh2NI8cENcD0X?=
 =?us-ascii?Q?y6sXrm4RqfjLi0dRLCPUInTTSMIbXl5u5DS++eTfZILtFpJZ7D//9ro/Nt+X?=
 =?us-ascii?Q?inRFA5aWEoRmzcNlT3FyTHS42WD2oY+VDOJHKs0rrYd8nvLJTPYnESpv+icb?=
 =?us-ascii?Q?v+/oIjVl1XGYszKDu3Y0JLIpVhVoEFGiwwMkzOV2yNdGAlBBb21mWgF9KUGY?=
 =?us-ascii?Q?5zUYHuhsAPv5HioX3Puee1o3jDItcd/7aBSIgVoqDMcjUqEpRNj3PceKRayq?=
 =?us-ascii?Q?J0Iw4LUVONCK9nNyCi8exrQt7RIf0MrHtWKFXx1i6Auorm6rEZJvbXeFbcZE?=
 =?us-ascii?Q?OaWrh9RloAsl868Y9Pl+aRSGZWZ6ZxrQlfjcUop+UgkbbzM08lFOFAI+V+Fi?=
 =?us-ascii?Q?44wgtoONiCOsNSE2L8PH4w291AGG7bVkaH4nmFIxpm9tokfQL2EgKawfPH0L?=
 =?us-ascii?Q?LZi4DrOcBU0EZGuBFvoPTtdPIfBsEKullCVGELissq7CsUYDdNjWEmCe3j7/?=
 =?us-ascii?Q?98EOdMGxk8c4jRWPzIBbq3CPpE6GuJ3QAg7yFxVv+IX0RghdFWFNs9AWV54p?=
 =?us-ascii?Q?y5LN1DmJHr2wnVUWngjsLE4nmPHz6MCNvv5BwnUTOdFfG5vqyuEdsAPrnz0K?=
 =?us-ascii?Q?3usH0/c5TrBV+DtMm2ncEM/3v8mQwGzATVTdaYg3PN8ToaHd6PMebXJ6D/Hq?=
 =?us-ascii?Q?nq1cehvlmKzKaqLOr/S2OcCzhbKHU1fwDgkGvkGvU7lGxxIyh6/4I0SLkSoI?=
 =?us-ascii?Q?2n7d8BQsQB1BhANPZmXFCJh5dZXO5o6I2mcOpVWEawkIeQy+aIBVWwJ9VD2n?=
 =?us-ascii?Q?Et0ON9SSqcBRy+zWGDArHrZNPPZYpWnLFI3JpFkxgeQA1p60XO23dzduFAD5?=
 =?us-ascii?Q?MdyAv3O82aB+VK9muuVvpWcbNhsWKLQwcrwEJUrnXxi+Il9jYvrGksI+XXo7?=
 =?us-ascii?Q?ySUgbzPzs7QM929m18RN+37M+6aEZZfROMqonlCpOIi5owLjpLqB4yVft9jH?=
 =?us-ascii?Q?LxdUojsHFCN0ALHdiJmIhxiiSR9DCTCmi44FnKhmYp7txjASHU5aEw9nD1LE?=
 =?us-ascii?Q?hScN/HgYTuLmHPGoJ2OEMErsT9oO+sf+uPcq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:20:37.4551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d6a161-b4f6-4eb0-8b74-08ddda9e7bf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357

Hi,

This small series by Daniel adds support for disabling host PFs.
If device is capable and configured, the driver won't access vports of
disabled host functions.

Regards,
Tariq

Daniel Jurgens (2):
  net/mlx5: Query to see if host PF is disabled
  net/mlx5: Support disabling host PFs

 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 85 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  8 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++---
 3 files changed, 90 insertions(+), 37 deletions(-)


base-commit: fdbe93b7f0f86c943351ceab26c8fad548869f91
-- 
2.31.1


