Return-Path: <linux-rdma+bounces-16050-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI6NDtt9eGkFqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16050-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:56:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A0915B7
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339593019824
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C52FBDFF;
	Tue, 27 Jan 2026 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aLcdCzTV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBE29D289;
	Tue, 27 Jan 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504024; cv=fail; b=GMkJ+j2vSD6uW4sBHWV/EpAq3jz/V/5LRHdr1CO5pxwGpcTqr51pOgO/dxEjZNomoRCO4Ajj4dOZM/seKXrIwe1aNUbTiYWmZ00jWmcqi86dGq3G1ZG3tlUhDUYE/ndHK837AV+X5Hs6mpLUA+4TkDGgwnup+l22QEvhFtv6Eoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504024; c=relaxed/simple;
	bh=dg/ISSB1raXIJShFUSYzAzgkgINuc1OAGXrYEhgFxIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F8llWohAh0ojqYwsN8AI+DHEMmqqTwWRkbbuSNeWcXvzivMQd362PkZzpUtRIJhNUH3cQ1t7LrkZLkdGiebuR5cEZoFHuShCzOz8OIw4LeVwQRf30/EAZKI86sb2qqgxh1QVZ6SGOZ/oegP4X6w/vSiWqjSHo3vGUQQZqnkKfeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aLcdCzTV; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5+qr+qPV6FlI2+apcyia1p/vE+A9poFWjmJ1OaCIpF1vwwqtKiQ73wezIRpp0tcXNd5wnA+X+jks6E2wYJ/GlMcaipv1sLtnRnCE7cvNtp0f6CDJjt+ZOYwwMEN04IXjGqFDnLvB7LX/ie1p2tQAZ7KB03rTEuuDuzibTN3RL5nhMOs/RKmODUav85a3NribMyou7J+pnDjRu3ZH9PlPueTyVMv6GCzhND1ItWCKB/A9IrHtPpc4uVSwUU+QB01jfugCHRXFSa8Bq3NdV8Wm3yqMIagEY8T7pO0T25/dPitziisdEC6oMLfHCFzM2EMmcu3JtDIARilbH0Qmj0bCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeZoCdI1IF41aA7OhTHUn+yVisuADWxeXwcdXyjCNHQ=;
 b=OkUbvr0pgn2X/VrHnGr5qBTGhDl8/homm7lFCd5n17NSGCpS1CcAyA61gjTGyjj19UcxW9v3+NhpzGk4KmOVoGrAkkmPJuSCspGfjtwX+vFh0i5hdw6fx4rmo0uImUeG5c347cppWiiGnv517B6Ck1n99ITocZB4ixuqI7gRlyAn6royuI3CtyI531ibyR7YbJVYikXQ5JiAiCP4MokH6r6Cq2Lp8TD6DL8QGnT+wIWOjjCRzPTOFb7MVj5c5AWYvscgzPJTTntKg2OnQoIcLfy9qeEE6cP9bvRbKPOAb09UxEXZ/Ro1j9NhfUmsHN/wzn/a1oBCBbgv32TcUkLoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeZoCdI1IF41aA7OhTHUn+yVisuADWxeXwcdXyjCNHQ=;
 b=aLcdCzTVa2K0AsS7LO38PZ7xiHEe4hZqtHBd3yqMIuSIaWS+rYDtDfLPJYxEM+RXUFlFvuiLoI9GjAIiLwoTp5Mi4CRuvC449yYqx5kd3v8l6cBuNVFu7qdZ2sv+6Z5h6SjzZ2wb5uUicTxwLGAUCErv//l8zYizvlD7gfVLL2CZc+FOn8JMFn04/RZjnlBkO/+5Izro8f+q+rD0+V86nbxLHDovU7JECIu0RCNJ9K3OPYbehbdznziOwxsEKduQreodEpuMvgfnT6o3S4MfoGds/BFgfAqHorY6uUi8mUugjpxN5lSnS9Tb6QNxlSGOkoGV1JU0wFb+HJh/Jz9Z9w==
Received: from BL0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:207:3c::42)
 by CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:53:39 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::c3) by BL0PR02CA0029.outlook.office365.com
 (2603:10b6:207:3c::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Tue,
 27 Jan 2026 08:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 08:53:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:24 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 27
 Jan 2026 00:53:13 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net V2 0/4] mlx5 misc fixes 2026-01-27
Date: Tue, 27 Jan 2026 10:52:37 +0200
Message-ID: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CH1PR12MB9598:EE_
X-MS-Office365-Filtering-Correlation-Id: dc40e2fc-f8d3-4091-b0ad-08de5d8190cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ib/7qOY4SQ0HJV8OmWC/Qg6zPv+5agWA64tL+KvTuq5LmrUxkdNqyU1S2q5?=
 =?us-ascii?Q?9Cyt48/+kQ7/3Almd+fyresAVsVyRPn8aKFgqrfhOLBnLG9GfCOblWK2zWfW?=
 =?us-ascii?Q?5RVP5Ma0864q4TILZZrn9HkIHobX/GcHeNrOPD5bzxwYocyNss9MHd7fjBsL?=
 =?us-ascii?Q?bsf0LRwzDmMOl+G/q9w7xr+/jwhs9O3qvLU5bUcnh26xm9U+MD+MjEPJg7tn?=
 =?us-ascii?Q?wv+oOX26oRk9J0z2j1OYvAoQc6GxqHCBM+rnt7neoyXTXVRH291SCFO+/R9B?=
 =?us-ascii?Q?vnRTcWr1ja3l04rL4aj7RK6nBfDGZIx9n+reOLSKEc7QS42TEaatMTlIzclj?=
 =?us-ascii?Q?9cTOzHaco9SGOUjsVKCHx9siPgR9lxH8vjpOMaZ0+cFFz9UNxRMCCIg1Tn+9?=
 =?us-ascii?Q?zP78yCi5hdctJGeuJYIKsxEy+ouPgtxVJ9lY0x6dcqSIxho4hnxy1si9e1cr?=
 =?us-ascii?Q?2aYraweP3Rwu4Can8m8j3Z1ZL1JOwyCy4JCeQ8HY7dmTANVVcMtsjVfKS/c+?=
 =?us-ascii?Q?1rIRJ7o/4m9XKWYSrh/D9KuFjpfD3OJFtqcRFyanysiyGMqwvu+RnOi3Nxes?=
 =?us-ascii?Q?O1Pv6yaiYEVl4MR5SjSy9g7S7cG6sp+EBmIDE7bhrIcWcDefabgbOgAEfboR?=
 =?us-ascii?Q?pTTsvpKIRx2nwmyM/Mw0NID6t524tCRVnIn9g5ECxOXRN7HiQ26xVbBtHVp/?=
 =?us-ascii?Q?znk967up6h4JkvAhUErZS1q42FYYK0VC4M22vpgUwX99cKA+q5VLhUMNNKoe?=
 =?us-ascii?Q?jgZcawfnO3U8IDX1umXSFcJyopRz4Z8njDuu9Got2OgPAuj1wM6+Z96uKKbo?=
 =?us-ascii?Q?YIPNTiIAwzdY5pEPS52HM11sJKMSPTa0TYJFmnPLrw/yo/DFB40aBJ7FIBN2?=
 =?us-ascii?Q?ES4cgUrv3PvOc4PNocHfEEttGK2mco8LAbJnRMYLiBQL/h2vFCiR0uRy0l8O?=
 =?us-ascii?Q?6F64YT1WJZAFXffCw8clZwmlVJROWmn/UNADCeJrvOJYIYpsVcIYLJrTRarf?=
 =?us-ascii?Q?q5m5TkZTwPcHUlApctHfD1PneZHEWUGtq4zKGana8U3QotMsj32V8oxhJi+M?=
 =?us-ascii?Q?kVGMEi/MkuIpQHtQ2sXZ1u/B2M6PgnZrfAzX3rXYGgconUQDRhbKTNbqUxkx?=
 =?us-ascii?Q?J3rR1OVFbQEW0xSZFf3Ve7SDM/uYNTKna9kSvBeEZhMWliTA9KgkdzMjJUCG?=
 =?us-ascii?Q?I5ydzl9Rh+TslOHUs/UZ2I8yPlubFKejX6JxcfYXhzN1fcIRyT1813PWDt4c?=
 =?us-ascii?Q?HhNiov86Tyzs8G3ef1k2RL4NAUSeawn6iqqWzY37N9RILNb+0133b3VydFBw?=
 =?us-ascii?Q?RbnKCKKbEcMWU6fZv0r76frFBS8bttSOzoWbUL7Iye6Bqo+SOcJqt/cY7dmM?=
 =?us-ascii?Q?zmfO8p3aLVZko0EHGL1+zW+bQPLiQgbG1CmOlJE4Bc+JMhOFhFkbrJ2+8FxO?=
 =?us-ascii?Q?1gKzcBSiaU9TrGxzYT9sw1q3iRQNv9PH/qy3C9V5kH76IB/qdWy6dA8N4ON7?=
 =?us-ascii?Q?h4W3IpCJzQGMG8ZRxFOGkvmR3D2O9uQi0h6T48jf8VpXRf8FKHqg8j79TGJc?=
 =?us-ascii?Q?GUQjERkKhzTjh8yWXYq2KU0fOjoDkXL90OpPPLAuveliI5ybAOhusHwC5ch8?=
 =?us-ascii?Q?8XPdhKam4TLJLfV4fZRgKrO2Q6PqYaWkWOXdNL5+brpyfqRXZzbdZKlscZW9?=
 =?us-ascii?Q?d5uMuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:53:39.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc40e2fc-f8d3-4091-b0ad-08de5d8190cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9598
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16050-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CD5A0915B7
X-Rspamd-Action: no action

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.

V2:
- Fix issue in patch #4 (AI-generated review).
- Add review tags (Simon).
- Link to V1: https://lore.kernel.org/all/20260120081654.1639138-1-tariqt@nvidia.com/


Cosmin Ratiu (1):
  net/mlx5: Fix deadlock between devlink lock and esw->wq

Jianbo Liu (1):
  net/mlx5e: Skip ESN replay window setup for IPsec crypto offload

Parav Pandit (1):
  net/mlx5: Fix vhca_id access call trace use before alloc

Shay Drory (1):
  net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect

 .../net/ethernet/mellanox/mlx5/core/debugfs.c    | 16 ++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c |  3 ++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c    |  6 +++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h    |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c        | 12 +++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 14 +++-----------
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h  |  1 +
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c  |  1 +
 9 files changed, 42 insertions(+), 15 deletions(-)


base-commit: 165c34fb6068ff153e3fc99a932a80a9d5755709
-- 
2.40.1


