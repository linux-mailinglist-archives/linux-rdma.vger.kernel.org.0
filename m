Return-Path: <linux-rdma+bounces-13191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CAB4AA8E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D883F343F5C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08131AF06;
	Tue,  9 Sep 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hA/XYDpq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BF2D23A9;
	Tue,  9 Sep 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413565; cv=fail; b=kDbs7O1/lE/SfuxCTWUheCiLkNE6DUytGtAi5HcseGl8uiY7RYK/fBCIRIHDMdEYELSrgIrzCyRslbAIk2sEN3EeEklCX2TeQFRv3yq5nvbDpNT3pP45bTW/0dp5kiuIbUTpiCpmmleeht8Kda3mZxW75OimsQiZw5tF27Cvu8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413565; c=relaxed/simple;
	bh=I86jUwdAG9lp7ibP1PhD76sbxS4P0YjfgvbtdZIPNU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l/FNYrWcbMg9HLRJOdzRlk2hi2mgK2o0Rg8Dw9EkTEZge7ae17gGr2V02FWq9ogg7gbavcpMEkEZEA+kqRmRzm/NhfRyAkEv4rtRCPl5eYa1c81z4RgzqFGA1emp0SeDQGu2cdkWVzX2VsUA/KS1Cidg6sVPEOan++PoDlcEjH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hA/XYDpq; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2Um2VTfQ8593OxnIDzBZtMhruyNZ01lKf7Itrpo/p3C2an3+u7EuRIuV/mtAN6T4wtqOXtmCnOwY7oSdfmiEGIXiHIsRTJod8dSIr6+SMHKaI0N3HWp21KIH3wrdr0OyAjRpZaLwc1svOcgm3NsKmEBWzApeng9suNx3WRrQuTelBHSTUbLZuaobGXYfKcbZbgrT8SsqLrO1XUuKFYitcK2wbr8YL/BcMAPMi3cZ/9jDYMPVTDZ0PIBhq/Ov50ShbYYQvRAG07Kfyt6Tj5SK+AppPPto6rMP9m7/HyaPa7hDnkUrCkX0D3CIlnCTcHZRMKFZsk+m0kPDjG5d8zDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iRQdi5F9EQssE3XAk5Llf/z+4x6iiF9iWMSaAslX7E=;
 b=cT7LSimJZ0ZcN6/dkxdiCwMtI6WneM+BI6JGmH/yWr+p4+dlwU4moX/BxmYofc9eGHynZoqfDdDsblzXjMqxaRXNCu6U1qHlZVQakE/iek4caNPJRxBHMYatsE2VJQzXEBwv7VgsrFRtKSOonGP+Fd8znK1+hIKQfYNArclVIJal/loPBaLzpG59Cfaq1nXQIXhvo/HBWbTOGkUYQ/Euy0s+0E4IzqCA7SF2kvoVr8AnYEcWZMWKqHOGO7oNVd8lbIzNGR2JqKUrG0TwuWrLL4mlOOZLCN6qgABxDiuegpC9toF4UwtvEXBigahHG51/fjbZVgoff8JUAOZDBYx84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iRQdi5F9EQssE3XAk5Llf/z+4x6iiF9iWMSaAslX7E=;
 b=hA/XYDpqNcAYN7BwfI5yO/h76IDkR9+HolhmYp8PjwVpFNeznG7kHzmB6lMlwTu9i6y60MEKl7kln7UpaygXDwSi9dYj61cpnGncRPQ5R6nAgxSmjCtLvD/Jf7Lg4CZi49HBqbECsavtYQ1PLA470iNzuVI4YBs/eMxduUMoJoqMQ8BYZ0Mt1e2CTdObqsaeYk15rOwnTfnvS4grFHe232TAQ2JT90isNBYiXowOTocLgQ2+aFxEzTLNxfqLwfBWV7zvNQfPMrtcidtWLph+0zuSh5uqG8URlvzGA6o3hPS6fn+sJ0aglqObqAfT7NfyxZ7O0DAarzIdxOyk8qXSKg==
Received: from CH2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:610:55::24)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 9 Sep
 2025 10:26:01 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::20) by CH2PR18CA0044.outlook.office365.com
 (2603:10b6:610:55::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 10:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 10:26:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 03:24:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 9 Sep 2025 03:24:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 03:24:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [pull-request] mlx5-next updates 2025-09-09
Date: Tue, 9 Sep 2025 13:24:20 +0300
Message-ID: <1757413460-539097-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 291a86af-44bf-4f06-5359-08ddef8b45ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aWCAmrUb06sta2BpF9aUmYlPuNzoXHooTQC85rDdwd+KTCmTIrVZQwUV1ugp?=
 =?us-ascii?Q?Vca4HsRIrImas3C2ATujA6EcgjVV5cb2JpkxaqwuZdjOkx595ZQU8m+AaJLZ?=
 =?us-ascii?Q?nHvO/8IGURIN6tpz0boNpfhujyrMh8IwL1yhW5ljEzDc/S3OKgwywq4RETs1?=
 =?us-ascii?Q?+hrJfgxUYGQ3mz0Sh+h+gYvutekHSodMOxGajCA0zt4xKBQ6EwfLR732GgZ/?=
 =?us-ascii?Q?xLssbChl47fzBqKNCT0rbWkXcX9Fa2FrXkpCgKpTGwkhDXS+A4rgeKhLHqhb?=
 =?us-ascii?Q?0pYKbtwBJlYIsXM0qp47pxPBfhOcAcsL7V+Qv9eYt5xV6IYBMFkzXkX7L3ih?=
 =?us-ascii?Q?YvlYhclehjFAwx7WqUfZgA9HDUtlCFGYA0IBA7UcQqpigQN6Nhu6IEm/SQDP?=
 =?us-ascii?Q?xaNnWpVXgMhn4V70wGmibfZxTvMocUHxq2eLXxSY+DdZT+Rh8gcRn9Vp3BnZ?=
 =?us-ascii?Q?2s4ALRWLmp2ta3e1E/oC/xk7d4EvEOCxs0YPrBK/YfHNy89iyEANcr9JWVfN?=
 =?us-ascii?Q?aer3Sd77vPmRZa5Ersq9cMrDpylm1qwetT2B8NGFAhGU8wXJa5DlL4SVF4RO?=
 =?us-ascii?Q?4zvQMu0QCSPK84rZW0JduoQoRw0fBVtbZNzaQQeXaOL2duao61x0SqmMwA8U?=
 =?us-ascii?Q?Ssf3RR6KZ5hsPar1vEkKf9pp/MQQCetSOtfkQPP18xC8lfKlEjvn61QKP9Kp?=
 =?us-ascii?Q?QmmH5gndLJTaFN97B9TlA6n8eHkeVVpd53a6CEO5+gRyPd9HkUnZ+yLo3+zy?=
 =?us-ascii?Q?7D0M8MtwTizdkW+aovY6C0sfWW/ivkzC2KxkBOx1L/+oHqErT/+5dHNCqIJb?=
 =?us-ascii?Q?LpLRvTGBQ7+Tlpyj2Om+W7ss6B6ijxGvkcDftecwr5FuEnEyTQncDSby02vl?=
 =?us-ascii?Q?UAoJsgpYRlsWSIdDOIXj3K3dL93s9ALy81BLMJ7snuHGxo2kFNh/FNY0Ildv?=
 =?us-ascii?Q?/8SHolFDEQqvNyOk5BnEhkU4aSiVPqQkWnPPPnH93q90CTWbPdSGXK1RdJ7i?=
 =?us-ascii?Q?uuh4aK45xpXHV0b3PlwZ/rQHh837s1JSWLdSD0wKlVpzABLU9pQ890vnjbUm?=
 =?us-ascii?Q?MhdnVuArI+2E7qFN+tLhAXgZpghP/gwIHzrttsyN6O73Z5GQiBs09hBgNYdz?=
 =?us-ascii?Q?hn2XZ8IxJzJBE6nQ4pouB/qI1xH0uWFwYal+j1jbQRCw9WaIM10+zgYit4jm?=
 =?us-ascii?Q?o5Rfhp2C7LIKCRCDsfK0s02bj4Nydkoz7N7oCCKsrzK6GMBUFAAy6YWLB0Tw?=
 =?us-ascii?Q?2E8L89L/SwWgGj8lihDZChw2RGrfHHZ48AUNj3CFN/6REs/Mn2vGMhCsfXNE?=
 =?us-ascii?Q?FqtWoUylQdMzUzXd8tBOOpDLzI/gIOH/kpvBqUlf0HaBBxyAFC5nBn2PZ4Rv?=
 =?us-ascii?Q?G4UBJelXQX0rzYOCPN3K4MSYeF7VMCR4G3xyOy/uDnQOH7dC4twkUKJTojJk?=
 =?us-ascii?Q?AaMj/k7DG5spJCHdsQpZEZXuTydzGhRTt9y6X6YmNUeCsLYdfiIDw+Z2CFG/?=
 =?us-ascii?Q?Cu83k8K7pCRAJEE5cRXSxL+M1jvJmSmPW8Sl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:26:00.5973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291a86af-44bf-4f06-5359-08ddef8b45ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113

Hi,

The following pull-request contains a common mlx5 update
patch for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit 04a3134f88a4bd03001a3093144819523cfca99e:

  net/mlx5: Add PSP capabilities structures and bits (2025-09-02 23:08:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git tags/mlx5-rs-fec-ifc

for you to fetch changes up to ff97bc38be343e4530e2f140b40cbdce2e09152f:

  net/mlx5: Add RS FEC histogram infrastructure (2025-09-09 04:18:19 -0400)

----------------------------------------------------------------
Carolina Jubran (1):
      net/mlx5: Add RS FEC histogram infrastructure

 include/linux/mlx5/device.h   |  1 +
 include/linux/mlx5/driver.h   |  1 +
 include/linux/mlx5/mlx5_ifc.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

