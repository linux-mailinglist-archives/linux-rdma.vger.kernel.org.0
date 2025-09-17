Return-Path: <linux-rdma+bounces-13439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C089CB7F6CD
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE825229DD
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC82F39D7;
	Wed, 17 Sep 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3b5Zej9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E031BC8E;
	Wed, 17 Sep 2025 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104830; cv=fail; b=CxI7nEBVl1bJS4BrD4d/HIrMR5G0rtMUIptHRc5c252F8pcgZW8bOaDpYvQDy0Wh84SmSxxybiFUqikaEpWtDsoDcvm2Q/+i3zl28TG94B1iItOCfCufGvN5va+tkr2skoEwyxMSsGHY34JcxgD7iwwZJvy03o060tMHUbRfnhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104830; c=relaxed/simple;
	bh=1kDODcQLGZiwkirWmH0NOb6846Un2NJbhsLhEXfh4mQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K5LgQ8thnChXrngD69jqiRymyzxaXBGwT7sKj7iHqXuR3qjyN90Dt7Fkw/wMVLjh6lo6BYzqxx86JelgxeFE05Qw6a4gdFYOajY7VjHoSBVWBlst4TJF3XM1jUJXY48hJYRx5eS4QKz0898au7HOr8m9E33A1WoECxDT2maPB80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3b5Zej9; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfJrSZVx3hzQw+A3rfSSwjMErJH9WIiiMnU4+sS856EJpNJJeFATHiI+rhXAAeFi6773I7qMcmmblcH0jpoYq/bUIy1jQlQzXy01FcO4MrJ+DaR+pMIkAaFkdWZnjMZ3hij2HjhYvloXV0HiTaDxULOQ5e1sPeKOZq5GbzsKMj0vfNOWk68hLgGpwOzOJGraKfxWtSbUEZorSlMTKpPgkT8TifNPJzRIGs/FYWK28UokXYUkA4oTPjQWHrRi+qbscYwyZwo1x5MwpQKlYxTyhoK2XVWYbntplQkgZ19diGmiusXsivX073yAjomG4Ap9iXWIDKa1rrk1YpevFpmohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRwzKkO176AbTVq/tP0sbbMnDM5WUTvN+VhIZ5XienI=;
 b=Huz4ESXjzLAaK3pM/UlnU2VVOK4TfmP/CRFf3oFkhm+WuDd2fwHUEchkKQkN4i4KDPL7fIkQnO0KI8LLgJdgAC4TgTyesYufXuxOm99JV+o5uFWKXB7yUCdtXh25Ibr7KF1OHc2tzoFhu5t4HniVNFJNbXxkb7b8t0E7BrVerJWZN34EJp8o94UTWi8+UbrhPqQ6NaWdLsjU/jUB1QUW47hfsGY5e+HWEgDAAJBArtiE2cWofM5Qt3Z9IADhMnETPmwLZ2EiN8Ja3da6eeqEmS4wj80XlQeBmVzvMj8zQgOvORtC02dNJWea1V+ammtA4uDxt07CwobNcORY30m9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRwzKkO176AbTVq/tP0sbbMnDM5WUTvN+VhIZ5XienI=;
 b=i3b5Zej9xTZpCgnf6Ag7DExF7bc+jsQo82QQbzD35pzE8+Ok4ev0CFYuky2dyDoajRVevXS0CFKtTQbrBFXyjIOu7pISNY0gWvmlh8ucZiuNZE89qjyDVNZU+F81/i8CZCxfgeSKthSkbrNcYJjJPdpgR0UTjHk3RvLqG4w3fFm7JkamwML10Z5h1PPu77TQDdJbzL68N9QWtzIW/hU1S80yI+XvVeOXYunaQzAURMPNqrHzgu0daSeNP54NJtpafdQuDtKitpP4VlVSrtwL5dINi6kev2Cy62hdUVU1LdulWCoR86IT1eiKEwtgbocd9DZ+DsjfmQHnyI4/NTI8XA==
Received: from BY5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:1d0::26)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 10:27:05 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::c8) by BY5PR04CA0016.outlook.office365.com
 (2603:10b6:a03:1d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 10:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 10:27:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 03:26:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 03:26:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 17
 Sep 2025 03:26:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-09-17
Date: Wed, 17 Sep 2025 13:26:20 +0300
Message-ID: <1758104780-642426-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1333abd8-3eff-4979-87cc-08ddf5d4bf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSt1uGG1vfrlWKhv14Af4tZOjd1b2/Cw81hRoDpIGGoruXQHxEZAbtJoU2NQ?=
 =?us-ascii?Q?vPNKnos3ZqQpHwDNpUjD5rRNx2fZFLm2BKiCHASfImGMsGva29Stav1T0R2z?=
 =?us-ascii?Q?eTNfgDjVtQ9fMZQ0vjNoaxspdy7FiH0HNxsGY0D4FIRU5WRqDVwYkt2tUxzz?=
 =?us-ascii?Q?9TpE7MHRvI/6UajbjO5+TmR/Zz90KuIvl9cqSpIWsa5lDfAXM4rephppPQSt?=
 =?us-ascii?Q?3nQF8Zx+BavNkK8S01qq+CB3epSS69eBIK/Gak/zJ4hSeL/c20RICCgxM/vx?=
 =?us-ascii?Q?7BFK1Ow7tkeBoTh9mWPJNI8bDwJZCUk/obdkW93vTapzfz4UKsmnTKQl5VDP?=
 =?us-ascii?Q?M0E7rXCgXxsAnoHXf/BDtDFKNrFw9m3l6SARZq0xMzhbUt29PIawJyyLwKL9?=
 =?us-ascii?Q?XS8TeLNhjYLCEvaLuBf75dMTwSi2SUkf8QXGpVAeYkRWaO/bGQCgPerBTbw7?=
 =?us-ascii?Q?TZHyRXnTPPLeKJXe0CyYYSciJz41oxqinACr1BJ80RQweF+gnV1lKXwsN1LG?=
 =?us-ascii?Q?/OEr6fWZvZj0law5h/wa6U2ZFz8YGrjNwM1b1W/CeciIGcMMrRxpcBXXMmjA?=
 =?us-ascii?Q?uYP99zc4YEVmZr4AzS7J83bK2T918saGD6kGWVWFKwWq4PJUa//XpyrHRkZN?=
 =?us-ascii?Q?DFtHEIB6kSQG9piWBeGLgYeBFMTs+pmVprU9xhZDspRDtdiHd9ZWPTbK/DWv?=
 =?us-ascii?Q?w6WxCjxeuFYotbh25JoZyAjmyqVM8fCdrxtlWfeoAl7JfOupyJMupSPUdbOj?=
 =?us-ascii?Q?Bvo/QNfCQ/TiLTZdAe9aTUpMen3gTl7ZwrEcv2wWJuGnMqdw+F29cO0VtPKk?=
 =?us-ascii?Q?xdI3LnXhz6ErEqTmoOSIj3iujq53NCB/CQe+svs86nUTrUxNpJRkV6hjOJvm?=
 =?us-ascii?Q?s9oovfuV/MP5XN53N7YJQ5UxGcD5Aj/82sUVNIuSegty9MZ9f+nO/Bn0Dg4R?=
 =?us-ascii?Q?9Ru92iKTVW6gNj+/50TrpNb9yksrUA+JBSk+0hsvAFkHqnqKaGVk3fTmHeyh?=
 =?us-ascii?Q?jHX1RDgoc/sdYODdIA1qujH7n5wMUkNr0JUGRxwve4cbIeyQQ2W0b++4BMdJ?=
 =?us-ascii?Q?EvPC1IR3M4GIweyE+wunfJaBGIZbEFFJTM/eyq5Atgb4mOQtMh9YsaOzenM5?=
 =?us-ascii?Q?habYKl7a3b7RVVgdpiMDiDo5XswIeL4D0Y3w4mfQccQzLQTZMafOPVd5DvSM?=
 =?us-ascii?Q?GLvNO8I/tiwN5Ro12b3gUFPf2Z6guyr7KVE+kzugRb4Iw3Q+WB52ZYVHkn+e?=
 =?us-ascii?Q?wetsf9qrSJUNehKcL4GyShTI3XFgnI8ab4XiWiFJ2grSQIpEq4v8oUAj/Y6D?=
 =?us-ascii?Q?/i92R+awM2kYKRreYYTyKMEKRrkdzvLvmyEYvIyQtN+oDnsDxTPm6wZcwWGG?=
 =?us-ascii?Q?Ww63tI0DA1QNslrDGvJvErFr6tVFQhjVi//a6si5mukk+R7Kik14+OtAlyYd?=
 =?us-ascii?Q?hxTwbEJJOzVTq+DdNUu4jgq3SOyZEEiZV14FniiLOclhtH2Wk99qQhc3RrMz?=
 =?us-ascii?Q?/jHlA6c23S/wV/ZdwM5NmABahbV0ZrjXkISU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 10:27:05.2882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1333abd8-3eff-4979-87cc-08ddf5d4bf9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

Hi,

The following pull-request contains common mlx5 update
patch for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit ff97bc38be343e4530e2f140b40cbdce2e09152f:

  net/mlx5: Add RS FEC histogram infrastructure (2025-09-09 04:18:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git tags/mlx5-next-09-11

for you to fetch changes up to 2ac207381c37eebc49559634ce5642119784bc7c:

  net/mlx5e: Prevent WQE metadata conflicts between timestamping and offloads (2025-09-17 04:38:10 -0400)

----------------------------------------------------------------
Carolina Jubran (3):
      net/mlx5: Remove VLAN insertion fields from WQE Ether segment
      net/mlx5: Refactor MACsec WQE metadata shifts
      net/mlx5e: Prevent WQE metadata conflicts between timestamping and offloads

 .../net/ethernet/mellanox/mlx5/core/en_accel/macsec.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c          |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c  | 14 ++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h  | 15 +++++++++++++++
 include/linux/mlx5/qp.h                                  | 16 ++++++++--------
 5 files changed, 31 insertions(+), 18 deletions(-)

