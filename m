Return-Path: <linux-rdma+bounces-14699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70DC7DD4A
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C853ABDF7
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D82D8763;
	Sun, 23 Nov 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDse8PdG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B372D7DE1;
	Sun, 23 Nov 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882694; cv=fail; b=GcBrShM5YEzroy27NnnUk+gtMzBw26PPKI05JIBIFtuytkM4q4xTLgkzRgLYmScRxyVWkbZSewxEcVHu0cAlP2NMDVXb6M6WV1bZfHsX8FLexaCTxIuO2VoD45peoVGdKNBR35tGsddNiKbYSlrZGVGkontAk/Mk5Bn6mQIwODc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882694; c=relaxed/simple;
	bh=akdES0X+iKGn4rltOupcPwz7Jf/mU/JyeskXjIgx3P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRdf8yaN9ky/k55qF0aFMLJ+YDJthO3qZHFiQmqWylkPzjSDEG0X+KTM/gmv5D6D/v+kC+7hHPln4D3j4Bnpr1uWCJyBO1DEVcJicrPic8TP8l9pJQb4oE1OgDWxLlwHVtuWhX2/QLcAwhtRSpXxbxWhxKWp9t4U02s+WUbzZlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDse8PdG; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4wyaR4b6RXQaVd4skX/i3ocXQDdyUmOevS11VJmOias4+BKobZisjqVC9/D8ki05i1W2HZdZopjWfcmO/wkH+oZ7QBEijsPyjcyhQTeY6mQgeVM0hsTFY7bQv/I0MFtzX5VUtCEzf7KwHjzt/RjFMFEF1OZbzVlq4kHz6u2dnCiZsMroJQEHzNHXNI2iKe/hJyjvKor498tLO1TY7KJ1StQDMUIgNi3CM2YimNp1iQPp9gsXYoS4WH+rUHtrwmG/qS1s/g8R5fKBaMHDDWPivtz3+QqVTPfqfXVJOS+JEqU54Nqo29yhoJbMqXluCVfbygxaT3FwyyRY1HTUL8Z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTEHFT1VQ+M5GMuB3KgAYIkobtSsghZZ7vtK9OdaRq4=;
 b=En9rH51cN3BOvyDJvcKFxQbCCtiyC4kUrhUAnDb4RKhedEENDiUY4FeT912OTejcynMEL5yP+PHqMwSqVf7vikCru+Nm5U79JqCFxj4/Hmsng9q/EBhmVjvNThUlG9pEBBB3hndTjjvJl0JWNUAWbotPd9nNkpfpHBSPU1ihkHsXP7W2MxgvcyhiquMJdMC3uPcYWYxEEvTQxPkQPXjaOmmSpPl6DVpIWvRjuq0JK/a+a9OSZReWLVTQHHMepOj6wN1MCuN7hxRTul+M/InmQhmHiaI1jRQAVzxYBAFo1n1/ru0HEo3zb8+hLOwXC8wgbVwbPm28sebpaUkkkmoKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTEHFT1VQ+M5GMuB3KgAYIkobtSsghZZ7vtK9OdaRq4=;
 b=SDse8PdGEVr0Y/KUwfcyLfXq7mnmZSnCbB3t7ZLt9q53w6w5V/UZIjzV9anZbnrmVVwvDDMV4VhcFlG3y6Ng0jEU/QRJyLwBw2bdZSsryghAqWgdVvfbz+HKDtNgOZZrKEbrC4ANuIIcizs/2JNKoMvZRVOD0jVflVzrA1n8z0PHtloi1xkwS7NMhzx5KcgIqTgOVVpxL40mceY6CYiWLRNwoz6Adj9xuK/4ZuxlwCySCwmOCerDJF+07+OaOS/TXb+m4haWdtyHhg/BVu7ZME1bDo2I7wLgPyGlFqWQqH5Tt+N2LVUz8/0n7Jsf113v8nhrtP98wdrmVDI+6WIFCA==
Received: from SA9PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:6e::6)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:24:48 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::42) by SA9PR11CA0001.outlook.office365.com
 (2603:10b6:806:6e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sun,
 23 Nov 2025 07:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:39 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:24:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 14/14] net/mlx5: Document devlink rates
Date: Sun, 23 Nov 2025 09:23:00 +0200
Message-ID: <1763882580-1295213-15-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c57bc89-6e17-4bc6-60e3-08de2a616268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqQUtUSgk+0jaaPaN9/rXpgKx3aFHkGMoqlq9gOyjMi1ASwwI4oEWkBLIyvY?=
 =?us-ascii?Q?uU+n1edqbWTD19bBFfHaB1wqQRGAx51D/e7SHhdoN0jENWgW3R8HLOz64pwb?=
 =?us-ascii?Q?QftRiG7fu05S1eFeeZIuLuN6QFxsj6gzF10vYkdBTRPtf4ljvTdcWXu8e5WE?=
 =?us-ascii?Q?B2TTkqf4EN6g921rlYFajNM7p035L/JjfEIZCcpYPvUJ/HoeE4qfH51OMGiO?=
 =?us-ascii?Q?4ZabWJp7pOSFyGdGpgOsQMFqjc733lfUqJeEMFhFqCup+1ll7DsUpboLGiJA?=
 =?us-ascii?Q?A5lWQrhKLIqv4Qd2iDwN9n3QWhpzoogR+iJlbDeAmt0My0c1Q5DR36BkSNoV?=
 =?us-ascii?Q?/LkrhvE8uWi1/vOHzShg+KujkvcTrG8aF3bAPBmwsP6bPm7thJSCJgeIPdJH?=
 =?us-ascii?Q?JaS3cKoxtsocayfnnIXdRxFDQBHFNseJQRbKvjq13opjLjcPms6alLFfnb7D?=
 =?us-ascii?Q?HksUEq/D6HMOKXy8ifIKc2aYvLbyWb/IRjtWyBryg1E3mzqtmfo4hY0fEv24?=
 =?us-ascii?Q?W99wu7a7UX4qeviarf+KM09ax72k6nI8hUXU3sQx5TmNTKLCjnYOpAGIZA6S?=
 =?us-ascii?Q?c6kkdmBkWiis0N+XzLCFNw6t+Ip3A4IqvNX4p4rJA8HT6rHzc1PJum4OwBuh?=
 =?us-ascii?Q?cbnpY9RdP8mvz9bEKmhkBVp58cEtZB7vfepxmNWoYyo8GMlSpPj3L2/nvypz?=
 =?us-ascii?Q?DGEaAI86SUJoZQ9HPvczwLGtpNkLhuIG+lAuo0g4/c2FB8K2l7UBYDTRCUfI?=
 =?us-ascii?Q?W2vw1YYEdIWCmO3wl9TRWumvZv2Z8JpxjX+JAdfmWTNhW1GqwXlMV8BUAPXk?=
 =?us-ascii?Q?/QQDXJF/UEreNRFLcyv4wjsDsMRY/n/IIm/HIip5G9IpUl1OyPRuVp0sFzCT?=
 =?us-ascii?Q?lRFwQB9iONm1eKxzwyaAO5xaeg0tq7dtP1Topd9trmZTHKQ3oKqmj6PJEpuJ?=
 =?us-ascii?Q?Qol6Jgjwij4VxkKlBHmg4nolbC51pHx6wj8P2y8P1cyVRTp6frWfytbm7vXj?=
 =?us-ascii?Q?lPnXYCxWMCLdUhaKwCHEeVOkXCVsAivezVsaMxwNIpjkfsG328fbi0aeOA/m?=
 =?us-ascii?Q?0FFeLVxj4vjqErXOfeIHgpI89Q86lS0SnU+9xngu8Or/ALxLQ2DBVYQB+OOx?=
 =?us-ascii?Q?LsuuIHrO4vdkhHiam8ROeOCtEQ5UD5wdeVcv9eriy6LsCibrIP5ntke4+mZN?=
 =?us-ascii?Q?TaT7Vr8VuTJRz/vfKN61c2Nt6oBzxX1b2kPfL2rlB7OUzTgftJ4GxzV5JeMz?=
 =?us-ascii?Q?BbxLJUQK38vrLKuGGLimVA+kPLtGcCnr8pKOlVUb2ihTqe8ZRitSWAUIQI8m?=
 =?us-ascii?Q?dxCoNq3A/6LEvvH9VijPj0GJImNsDRDUBY433tMRTWbhcQAPqntRQuz5ErdY?=
 =?us-ascii?Q?SdljXUUcPqAkcRFv43PyRPor1YEW53YvYDJ66+Yomkr4SDFdWE9iCMVsylfz?=
 =?us-ascii?Q?CyD7ednZpSdNEhMfRZRp6gcCPaUxDG+W0y5MW0TKgptxOs5bKX6aKoBa54S6?=
 =?us-ascii?Q?/P8snJfac5hlN09FQ2I1PSHjnyP8h88EYwvXUrnqU6nraX3iG/3qMnIby1DD?=
 =?us-ascii?Q?jzDdKbKKrjCPBJR6rB4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:48.2764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c57bc89-6e17-4bc6-60e3-08de2a616268
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333

From: Cosmin Ratiu <cratiu@nvidia.com>

It seems rates were not documented in the mlx5-specific file, so add
examples on how to limit VFs and groups and also provide an example of
the intended way to achieve cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..62c4d7bf0877 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -419,3 +419,36 @@ User commands examples:
 
 .. note::
    This command can run over all interfaces such as PF/VF and representor ports.
+
+Rates
+=====
+
+mlx5 devices can limit transmission of individual VFs or a group of them via
+the devlink-rate API in switchdev mode.
+
+User commands examples:
+
+- Print the existing rates::
+
+    $ devlink port function rate show
+
+- Set a max tx limit on traffic from VF0::
+
+    $ devlink port function rate set pci/0000:82:00.0/1 tx_max 10Gbit
+
+- Create a rate group with a max tx limit and adding two VFs to it::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Same scenario, with a min guarantee of 20% of the bandwidth for the first VFs::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1 tx_share 2Gbit
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Cross-device scheduling::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.1/32769 parent pci/0000:82:00.0/group1
-- 
2.31.1


