Return-Path: <linux-rdma+bounces-13136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F94B47A29
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 11:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962D216642A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4122258C;
	Sun,  7 Sep 2025 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uwu3PH/S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390CF217704;
	Sun,  7 Sep 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238059; cv=fail; b=FoZVPixcOGsZmzJm/u8XNEr3IN7EV9RXmuka/zlMgw5y0QpOBo+mCJ15YjET/NvVEb2aN73pZr1JW8KjMk/Feh4ADQPuZzp0zDSQEDFjbRK75/8idaz49Bob4JFpuMGJMqOZSLEvbytsDid983/FHZOsWOlD1YBpNOlDcjugKTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238059; c=relaxed/simple;
	bh=EI/P9KOb0FwfP563gvoyCoLKWVQzpICNslDc83kH8Kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TiRyOkM4mvvSZ1h3y92nHe6/LSgU4cCyKNdit3EoLV5QggJY7kJ+4jrTibiWIn34vrEOqBqFgp+d2vSJX8bnSlBMFR56RSYKiTnJAGhtH5+GG0SrrXmnLJR9icWYAvjjiHPmQK2s+kLfQxakbCIOGWmcnDISpvVcAE/NPqS8IwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uwu3PH/S; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKW4YR6iTzmil/iPuSHuOHdEyIFOP6f016jpcHvaOcKWdSmxFz2Nubucd7UMWY4qbheZGuY0qQtcEUCBDGr8SeIUheIjM1IsJu+JNlfMWA+70cFCGvNaZhce9qUkBgPy9wMjN5qKr2UzorqHNwVwo1QS+p/dIpOj841cH4x1fIEF+84cKOJVDEhfzQgkE4PlH0O998iZRfx9/g/mNfCXujbYEwVUnig8L+ZrQG5Nkzx43zXqkxHQa9DesroGwwkvOhw2nckDGjYA5vV1YxXlzzrLZC9nJmAQ4ArJ5VBOBwl/6gtHKJxMFufLr9ZCizUhCwJtWH897V7uZnpJL5kKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b/CFZ6sfJZfK9jiCqhRb6sINFWhVxggbOAze19PVJc=;
 b=rPDdaG1/EyeJhkZ4DiPWKGHUS5Vse2hm+E42h+LWq69mlpEBAKQvmT9vT4iEIXwGNKz+UxVkVQs5Yk2WeRQzRCJvM39iNshWUq9tvARwhy5c+piBTDooLpDr1Hy2CIrnU360j+yDT1b0qrF0BcUVwwRd6JF9JMIFjQUbS8rPU7+JH4L3CXh3BX7xFIXMIthMkAPmGzny8vqehte78GAhzrvC88tGFk/vouL/dGVCFYr3rXKnH6QjmYYJCJEIQYSNXaiRfeojk3k0nqAyn+2WOwBVBg5Vz6vvZ38WD96pKIq5nfEorNtbvoK5CXtGWz0Zw5trRjdOoC0yqQq362yOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b/CFZ6sfJZfK9jiCqhRb6sINFWhVxggbOAze19PVJc=;
 b=Uwu3PH/SPAhJdFs779eroAA8yoIGz9tFWCaYCgoT9Cd6udhOiY2QKcRr9jgyufTEk+9gx5BmTBijMz3Ckzc0Zb9UkH0x/UeDiPsmt6E+etZytSI9Et9fiM4BwgUC25s3q/VJhGmAut96y7ILsyk33R/k029pg+jcI65PiyluxRpUMGtGCwyOKBwnGWV2k0003MKc8u57xxpte5qyw7rJDJYAzF8cD3w/h14C2dsbRz+sIePgWYWc8OkDNcmLUClvJ81/Lx42hlUldTwYfk3BZeji5TIi4ptq7yfXpc7/7aPloz9P728j7zzts5Bt25j4feeAm+cJqFZGKP4GX81p7w==
Received: from PH7P220CA0157.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::23)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 09:40:53 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::53) by PH7P220CA0157.outlook.office365.com
 (2603:10b6:510:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.21 via Frontend Transport; Sun,
 7 Sep 2025 09:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sun, 7 Sep 2025 09:40:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 02:40:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 7 Sep 2025 02:40:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 7 Sep 2025 02:40:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/2] net/mlx5e: Add pcie congestion event extras
Date: Sun, 7 Sep 2025 12:39:34 +0300
Message-ID: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f8d78c-b72d-40c5-726c-08ddedf2a28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JbYcq3L5zWLXocYoTN0HwMqR0Lms8xuCW8Ua4pZEw604lsBHFSN0J9g1LEGl?=
 =?us-ascii?Q?APC80PYdZXmfb/KJjReFpysLv/szvyH4UgtMQO79jaglMcdb1bR6slT8WsP7?=
 =?us-ascii?Q?ZjB6lbZ7Ker8sD+usFQpPC7wOBu6AT/aDKbGRcF4xdzTVe/oMJluRhpO2eVV?=
 =?us-ascii?Q?/8ti35frSk/pm+IH+4jf2H8aEcq8P3Je1UszfYvecd9ds+hvCRSri6uoDNS9?=
 =?us-ascii?Q?UR/lMDXaTxWQE/3tmHM1sNExns87T3dTiuoF1rOoyNa0Oc1pwVAkdk73+ASS?=
 =?us-ascii?Q?i8dpjniPXw9F84RsWlkXZBwicbFu9vNpiWELXYqPtDg/f9//kEHaUmbiBQVY?=
 =?us-ascii?Q?u/Th68UfStTumfQrM99e4ui62N7vXa5l+TtNrzDGvdmZpXITgkH5JkYEtsCJ?=
 =?us-ascii?Q?lDAM1eQqyWY63B/AIbfRErKy/UPWAdVHv7ZL0tVurpDza9KDds1dI3nUxV7W?=
 =?us-ascii?Q?OZXJsunUNMCttpePX4KEKZ+GmMwBQrqPxUYXO9PGg1ntLERvKpqTsGCddqD/?=
 =?us-ascii?Q?Xq7YK+OzOZExv+d1e9HZmg9m5QelbGGuiQB5vS6EbZ7egGvy+74kIXCnQlLk?=
 =?us-ascii?Q?maT5L0Jh5j+xngYLp29d7Nq3ZdeZomuxdaeNsVKgIznrGBYaTDdND5oEdAAx?=
 =?us-ascii?Q?HjBQcvgfLkJHL/8AMIOcrELzA7GcsPrjWJKGH/MDy+lBGPnaZSmr2XaG1Eb8?=
 =?us-ascii?Q?wGI2PzeGwHIBuvzT++Y6VDvwii3wguFx2QTIKfbLezW+58TFHaQJFrKTyyh0?=
 =?us-ascii?Q?P7cyg0jqDA18XVY3GA+PBN0551iJPHzDnXPfE0bF1J0JXe9NzziPoRkjRuZT?=
 =?us-ascii?Q?4ojKj+bzzAOTwF9VA3ZFh7IrW4plnrUDV/SS7qwyObvybeiYpADg1wSM5UAx?=
 =?us-ascii?Q?YrVSmKz7BfXuY3glIQZb2qVb/XOYm9QmWveh8VeRJZ7QRlB7J15DXwwCujZP?=
 =?us-ascii?Q?O+A3s09dFN5cvseW+VNqVtxaftuOdoNqKx4TsUanb2VKR88X/JssyotNMPqO?=
 =?us-ascii?Q?XrZq0b/LQJ6i42Sj4XCVtJyPNOdlHQiXN5RDiGccA+ict8pI9WBKAVi9wkU6?=
 =?us-ascii?Q?5KXfJMYGnVrXXWuU+rvo4Or8znHpW1T6yIh3wGvaqinh9HAGaOLi13NvGEXq?=
 =?us-ascii?Q?EOuOHY/cU71zjzQyfAqpGmMLKqy39HSsfAQPu0epuZDnuOm99dG+xbU0iiMv?=
 =?us-ascii?Q?euL33b5D6ujtWYM0zzH98ZhNzcN/BIWoMBqrk5dGSIaOiOxBKejeCbRKd2eq?=
 =?us-ascii?Q?3+5p3Ea9NvivoVv2c1aPtAHKseHaGljnWOAZNXJfGCE4UyUfmYusi9kTFjy5?=
 =?us-ascii?Q?9nN60uk0XRpjsifqmy4KISyMll/KcHryCoqJEBEnx4SarB1sXbW3PHdj6R4y?=
 =?us-ascii?Q?q2jfK1Z+U5qa0oEUanDsSljPgB8rqeUMHzO1yzQ9XBJbFsbG43qcjPi/Ic1N?=
 =?us-ascii?Q?ILv4cLZePni5JB5bDgIn7VJidAl5ie1/ICPFQ51MRAqEbw8pJs8XlVFPFnIS?=
 =?us-ascii?Q?/Jz15ejqA40lwXZB7p1hxdPe5iBlrDmJ9FN1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 09:40:52.0627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f8d78c-b72d-40c5-726c-08ddedf2a28e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667

Hi,

This small series by Dragos covers gaps requested in the initial pcie
congestion series [1]:
- Make pcie congestion thresholds configurable via devlink.
- Add a counter for stale pcie congestion events.

Regards,
Tariq

[1] https://lore.kernel.org/all/1752130292-22249-1-git-send-email-tariqt@nvidia.com/

Dragos Tatulea (2):
  net/mlx5e: Make PCIe congestion event thresholds configurable
  net/mlx5e: Add stale counter for PCIe congestion events

 .../ethernet/mellanox/mlx5/counters.rst       |   7 +-
 Documentation/networking/devlink/mlx5.rst     |  52 +++++++++
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 106 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +
 .../mellanox/mlx5/core/en/pcie_cong_event.c   |  79 +++++++++++--
 5 files changed, 238 insertions(+), 10 deletions(-)


base-commit: c6142e1913de563ab772f7b0e4ae78d6de9cc5b1
-- 
2.31.1


