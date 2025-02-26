Return-Path: <linux-rdma+bounces-8136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E4BA45F0A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169C67A43FF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1D21B1B5;
	Wed, 26 Feb 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ehylPM6X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5E2192F0;
	Wed, 26 Feb 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572806; cv=fail; b=U+gt6Fn+vJvM8C7CLZRfcT+A9ACB0J95HnWrGOrQaIr9VZKoeJ/a8Ssvy7dkjkD3V4zmHyEYKz8yiDMR4tJGr9fkq0ZOFoJjoCrpuFDFlTlhL1VUbdt7wjueGTigPtJYBTzW/Jr7gwwcQYvZDba2+nq6lEMX7gZmlSF0nj9tKOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572806; c=relaxed/simple;
	bh=N0OqY87cTH7MD2/xN4J/QNoI+JHUFsAjGA1Ed8btgTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m6FNeY03EK9BHm7oe6zjQDvzXnu25ckJXjSUY8aVAuHLa3a4TOugBi6FKmjnfHLXhNYBqmHYjSc2YkbsR+mlLyHfFPVMGvec7QARLhjsnZTKQ0kAHNfg7EQDGX61ki4/QiPRAHRqiOYJwsK8dtVoCD1WMT2oJ18QSNvzw85kqxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ehylPM6X; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n98qBHNRG5V3+fYEZjQfWGXpIUOvoscaQqAsjRKZ+S8jO9tLuWC0nNDz+61VLAAxi2pFjGddj8xHPQNLQMwRy2Xa/scTkxbeASvDxHZ/v8KVT3Ayj+6XtXE8pZK+1JWnfvecNTcY8SG08unD5AKUgJ7NkTCNrGt/GJ9ozKyycZtf5vR8+JY7wbLCl9+5bfSlGyTAgNfp908LT6dT6Dze2uYU0oN+gju81sL+DZ5sr1N5F+eLE2wIWrAOf7YZapPli1gYMWBLnOJdCQbnhsgJ7N22xJNvpql8KdtKnpM0AJydDFAO4yTxuZmDesM2CLTGkjFSMuoSaxh93UVF0z87oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZaoyhA/iMp3zulxy2dTrgMRzcHCqaGrwFSMeh+KHr4=;
 b=Son+XNBXFOn1LimoH7kJK+Z/SqeuOg1jNEOMA2f3EA3z4pc1CvV/jWmas8L9cA6to6cYOWr1vN2kwn+nZQT/6pAF3J52lho+BHL+EVWe/bEIvbM9a9rkaYdHvQIjjmbdjPcbNpxhZVkZzgt35Z0fpiSCGTCCwDndCAyrazSJtV6nXQCGn+WEi2o/pgBJCvNYO2OuKoR5avaZPK0ga440+XyOf2H1o7HCHk978+HyhxK25opHcUE+jSzTsYlhQ5OV8jd8o+F7R7CJDXytLjiWGZSXq7pthsmBeGGrnUW1U77KtKjEosxCtrYOuHaZ/2M4IH6eLSXiH6UyLqSIWuW/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZaoyhA/iMp3zulxy2dTrgMRzcHCqaGrwFSMeh+KHr4=;
 b=ehylPM6X89RXh4eyBw6KRRynNwUlbADlpvGYfZwrptfDhF05dl9QyOM6W5K3TEGAl8GHDVTU2M1NwswSaULaHPPiZC98KdaFF7PzWYnMJXMGN0wJdhYxLVCWi7dVtBUR4DiV4P1VXqoXn0aqnBcs+PZUU/F4fomq2Yt6wS4/GLq9u54iEXRB3fqzLGUS8iUSnYsurQI/hg3EKCJgV4tA1lYCSBc26LU/onJdYVLZhcfqJP1hyagBbGo3HMuHog1LFg3SK3TQVwFF9HzVRXaeus4dnSAf6jtCSU7YrovclidEnoq9eIRJnuJxhKVz7aESpb/RKEGLR24KaDfglemGGg==
Received: from CH0PR03CA0402.namprd03.prod.outlook.com (2603:10b6:610:11b::23)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 12:26:41 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::92) by CH0PR03CA0402.outlook.office365.com
 (2603:10b6:610:11b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 12:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:26:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 04:26:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 04:26:35 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 04:26:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] mlx5: Trust lockdown health syndrome
Date: Wed, 26 Feb 2025 14:25:39 +0200
Message-ID: <20250226122543.147594-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c20878-85ae-4b7e-908c-08dd5660d2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bd9CJcyGH4xkAyQj7HDSqd6suij03X9jbgAv943Ldp0Wc2gx4vUpHXYtWYN?=
 =?us-ascii?Q?gbWih4BCVfAhXaLJcOkjoGrx/t9WbH5Dq+hw9x8j1VekXvw9qoRGD3PkBeBx?=
 =?us-ascii?Q?VJxtdyo87AkIEGXSwDu+wKfQ1r4Q51PyXbXNRUKBpqCGyW678SyqWxf45prX?=
 =?us-ascii?Q?7Mf8Q5JPNoZH2sMiCALZ8rdfqhO4eNjhZS0PFAoaxofW1ct8kDDECxypPeuQ?=
 =?us-ascii?Q?+e7AN1xbhI+wGKgReiJDIjUk42VGv7PDPGHesVs8CqmVqy1WGD+4wxQCOmS+?=
 =?us-ascii?Q?L9gU981+fRkfrobGEsE/PlFvAi2iTzcZ5RMXe9p8canaZEWens+AyM4JzSno?=
 =?us-ascii?Q?JY7WUV3AoenVLkVZxXlTZ5p7rMuw98qNiVWRsNMxVzPoPoR/f+7cGkuLSNCM?=
 =?us-ascii?Q?6LfgRMJGMl1yAIRljWxxpohsAu7iD0EU17iHhqX/MwLKyD2AEy+JmhkHGR7F?=
 =?us-ascii?Q?aUizFIG2sHX8M4RcuqLu0o5fUXQgGKZTelKLywndVaAu0rKOAb7jxlfYBVGI?=
 =?us-ascii?Q?aeV9H1Sl9hT9ZoExZnA7oFcggKk74XNKPC/H3g0thJ9AEi2Z4Ewfl4V75vCn?=
 =?us-ascii?Q?QSjKdxEpMKVRDsIoV7ZnmmrsTqLh5FZfjz/7iHP7K4T2g3ZodedmlddpeBVY?=
 =?us-ascii?Q?unTtouQVhGFPcd5DTk1ApcEBOaHotWkDmRYS3NLUjMT5whacNCKcFzxgt5TZ?=
 =?us-ascii?Q?ag/2064pP4v+iF53j00JZZyykR/ZWgzS7iiJjfXKpOKbaY5Q6NHsyVchOjrp?=
 =?us-ascii?Q?0baGH1x6SwqKvb2uy8KrUxyZz326cvF+fTyEQ8znYPbMesr5GSdrSCn+uUn2?=
 =?us-ascii?Q?W55lNFLvSvu4IZ2XA54Mwcs7IYhdCzsS84g8HeoG5E0cRBQs7dYA/JKxTrom?=
 =?us-ascii?Q?a9zBy4IdJeTG7Y+Oxm+TeTBLYtl9gyw6VgEEKKsA2M6X41whdQckUiJtuVTZ?=
 =?us-ascii?Q?JgqHJf5B9tHVuO2NiQruwwz3x7S7JcVZAhC9ixry6I1EXJHC+cWR+wtSFpnf?=
 =?us-ascii?Q?/NthS8NQf//OxZigkf5os1sSs8gnPVRFl4UwhmFNKOyW3/KOxCYjP9dNL/4m?=
 =?us-ascii?Q?hHEoD9B7yvmPONHqHvZYaW9WSipp1Z7keXwXp26VU0Sdr8i/JlC6z71xZBWO?=
 =?us-ascii?Q?sp75R329EliewKXY4aKQ98VeSbj9JH8fG1vPAiBb6ZZ+2lYqJBVncux6yi+6?=
 =?us-ascii?Q?IQ+4gDL0IQoHlf0W7e7qz6hw0bgDQ9zMEJpTeW/LomyocOVCGmHs9TnA1qDC?=
 =?us-ascii?Q?s3i8HVEUDs//yDt76eFfN3lbcQEFreFmM0T7+vpJvVqwILMWqsg+X5xRKOVg?=
 =?us-ascii?Q?SYKvX52I/8i/ELs9XTbLhVVyRx2fEA9OFWDY9FRN+2x4w30qyFKhE+AeNEm+?=
 =?us-ascii?Q?ds9XpcIn89nhkDEq3jysK4/xxgDZFeu4Ago7YO7pHVGhDnRLwm1PIn/1vZ7T?=
 =?us-ascii?Q?GGSyqMwGh6a9otYGSf4NpCcp1gFXSGuNHeau2P+frxaa6Tx0soVYIEt93Pf5?=
 =?us-ascii?Q?n10PDR6Qi+UbM94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:26:40.6970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c20878-85ae-4b7e-908c-08dd5660d2b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B

Hi,

This series introduces a new error type in the health syndrome,
specifically for trust lock-down.  Additionally, it exposes the CRR bit
in the health buffer, which, when set, indicates that the error cannot
be recovered without a process involving a cold reset. We add The CRR
bit value to the health buffer info log and update it to be logged on
any syndrome.

Regards,
Tariq


Moshe Shemesh (2):
  net/mlx5: Avoid report two health errors on same syndrome
  net/mlx5: Log health buffer data on any syndrome

Shahar Shitrit (2):
  net/mlx5: Expose crr in health buffer
  net/mlx5: Add trust lockdown error to health syndrome print function

 drivers/net/ethernet/mellanox/mlx5/core/health.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


base-commit: 91c8d8e4b7a38dc099b26e14b22f814ca4e75089
-- 
2.45.0


