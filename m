Return-Path: <linux-rdma+bounces-19749-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LA1FAJ48mmsrgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19749-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 23:28:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251749A970
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 23:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6424B3018D73
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288A3AEF50;
	Wed, 29 Apr 2026 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGFr7k2U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A95474F;
	Wed, 29 Apr 2026 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498101; cv=fail; b=jzZyXHJK58Q4jWTiDHgHrFXTpBqlZ/1J4L3O6vlMpMBr9uDtNJG9MuKgWTGGCqFudELKYZbl+sqPvK1Af7ggY56Qop1muZ7AgLSA37t2xvVWlXPtCJM2aaiI/xs1pPuBZJ+SlKn+FWN693XQCAsPYk87VTy52xVp/ZAa8E2cGnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498101; c=relaxed/simple;
	bh=uJdGudF8965nWbxrALuRhZrII5o8w/8CnA16sa//ed4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k3zgcpFgXlh778ihCT1/hY6fSbnH5WJZbfVoSRGu5quOhQ5uCQZaDBxnc6T4TkE3QSiqjSlvWIuXQO1xQoK6t2HtVgbdRsrsS70q6xpaSwdFTpiOdynTPyvpgczRxtc/hhKNUzxmWinQqZ0FTS0suQqXPUGuB2mJeKuZQbUTEmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGFr7k2U; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu9E5S3kSsARV8pnIyiviEhpAEfTdHD25tJDV70/nCCQfYSx1O2qeyrQ4f2sphNIoiLFH/sv6Gs2wNOe23ryPNPtt2fAhLzxbySCXBSppSMtbSurOuDAzvtMyGcVYdAzj2fQq8sv6OBCTcHAmPt9SaJeurKMLymEPnXopVtedSluTYVurbkLB3l1H8jT6E8IIC9sPSh3hQ0sqcY9OPMZasj/ULq38Y+hS7Vi7hjqU6oOEubU2JfXAaO6l3BICUIkn9/0fSEbPFHrp5Wy/rZumCBTe1HQEZHiyxVCE9ipqr1EojTMXyYruU6XfjlRbUvfu3PUnD/3gtMIr7cSctGbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZMVo29jYNDUUUHIetXU94p+TvdumYWbgicRHGDhHNA=;
 b=GURbPCdorqn1gCtPeKj1uCz/tbulTwp3gevAyED77UBn3cYADp+xSaFVoySP8WuDIa/zDCU6KHHmw5P+g4lGyep5mcv3wmYfSi0zeRJWBL/5TeIPiGVwXIDAmXxF2jUrX9SZ7SOtWEFT7etWvwk6Af9WmODf/Ykke/1k6LhzmFUC8u8i/HaM1zZuhe6aKZ0celQ9Qnqz6eFK0uMRuBUA4mzFyBp0k9ASWTz8UCsgSOjRIBLxmPjNI7C4kGiMh3D9eD/75HiUnws1retrGxqkWjNbxvgGjjrNTY/j23O3EXxiYPJHv8QExyV4t3YisKBsNc1Y0IBxHiJ3NvJx/l006A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZMVo29jYNDUUUHIetXU94p+TvdumYWbgicRHGDhHNA=;
 b=fGFr7k2UD1LXW4tv3dLQO4vjKpMS7iinaIVqQKqyZ/tF34HW4qF9oIJK274kuXjdoq8nl9X/MQTDnhlAafPn4xSim6ns55a8+F3FboOk1GWOrHAFmX643PQbsw+NQp60EL1WfBCI/CbMV0kKARoPTB/67iE7zCqKcn5Zx7srIFOZddP5aCr7CB20z3/0VaJVXswK1Mt1xSeYD28kQ5FUpRZO88ZCs660YbDqa5lVj0jvtweiemqzqbvAZm3q9x4hEVBnVliKFDnIpz/153IfWrO740Frih0r/tsYHmbfz4OeSouTo+AAtPYefF3T0tqgXtdgleX7zD6jiTUSYkRcwg==
Received: from SJ0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:a03:3a0::13)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Wed, 29 Apr
 2026 21:28:14 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::f2) by SJ0PR03CA0248.outlook.office365.com
 (2603:10b6:a03:3a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 21:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:28:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 14:28:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 14:28:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 14:27:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Parav Pandit <parav@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Kees Cook <kees@kernel.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Or Har-Toov
	<ohartoov@nvidia.com>, Simon Horman <horms@kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [pull-request] mlx5-next updates 2026-04-29
Date: Thu, 30 Apr 2026 00:27:47 +0300
Message-ID: <20260429212747.224411-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: f4535c04-4dd8-4a9f-9a00-08dea6363898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uOg2UiQIh4L9Shyf+4M8w2zUng/48IAT7zsAO9ErwAfISFna3yP4gCJP8W7I11BM+BDkHcjSbBL/Y9g0VKHjQD8UI0EjyfeqDALCpA+LpPQJYw6drdzEFpUAGkL1waPbCIJZJ2lEVzFmIGolURsSMjTu9RAkCEcBv+PL8NTkZ99AadJsSfn0lS2OVWTnY6KIowO6MRFvSAny7VUZHdC8GdkuldlX6zJDNh6r64+NUJI1KuBwNxANzUuKoSPnMLT1Px4F5FGnJNHBVTcjSPXP7T/UWTNahjPblXaUQOOfiFC4ggg2Um6jI9GTYwPwfxXHZ+SOOqCqi5SFraEp39MTlCoCSsGnnJ8Kfi0PfRsA9QnPI82TG4XukLuqCgzbnQCk7P1V4KVtkBbBLwU1gGxqMWwzxugm7YUX5VgqEXWnVMtyDjf+NH7UEVueWhTk3lMsZAObszCq2mEGM2pAEjCGCxVxVNBte5khxRwAmYzaSmjkmd8LbDRplW2aaW/kouvl1DNOBth4XsfHxZgOrwbyPMbKmDde4yHHVtnzyyZHK+YkBiLvAcCqZP/jh0/6d76o61qC91afkBsMMjp7+sLioOGYS1mLJOEjIm9EjXv6CMw/FusEn9wvt7XhVFgS2tA78seb2pdFdCdsoGVn1WtMNkuOphM8pOymDltrj7EaKF4QAgzsCsg5TPeDiqRyjsp78vFXHtlGFITefnopmK72Sp04qyS4aJGrWuS6eXIOPV+nkURFHFpbneZs+jeF4VbcgucAIkMcybO5wOLPbMZHmw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e4J5r6k2YQ9kPt55HMBRt84VCwfnOz1cuOejNSzwzMMnPX4RWSFQNJRXexlQdIvvhuqehzxqr7UVFX+J3YJJAvX74HHKoYiJWhsSZCYe5mDM11WHmL3PHayEvTESSK7bKsewGiQ/HSOjk6SZqI/Mat3C8jEw6knSrO3yv+GbFvFuMV4QKmQR2dtG2R0mqX6LeLgu4bJh4MzTWE+FCdHj5yXgAvCpawTrelcCZ3OhSLjAhVrC4QiEVfVgvuZ+euDaJFYiFmOsHLWKjoR8SqSurR9Wmv0Avfu726Y9HXwYvIDgeuY7sWl3w60CDN9mKtBQ/F3xasL6zffuBzdgpQkRWm5Sn0Mnuy7TyQqRmB0aTYGGeOckdewTOtxfY+Mmyh7xoaYdrBk2VS/Z5q0wsSq4zstjU1RCbiKmeCy1XtQF+r4x1QDcL9NN2BG0RFWnQ9jw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:28:14.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4535c04-4dd8-4a9f-9a00-08dea6363898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A
X-Rspamd-Queue-Id: 6251749A970
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19749-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 02c54621e81ccdc1907e2d735bcda751f2caade1:

  net/mlx5: Extend query_esw_functions output for multi-function support (2026-04-29 16:28:30 -0400)

----------------------------------------------------------------
Moshe Shemesh (4):
      mlx5: Rename the vport number enums for host PF and VF
      net/mlx5: Add function_id_type for enable/disable_hca cmds
      net/mlx5: Remove unused host_sf_enable field
      net/mlx5: Extend query_esw_functions output for multi-function support

 drivers/infiniband/hw/mlx5/counters.c              |  4 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |  7 ++-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 36 ++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 42 ++++++++-----
 .../mellanox/mlx5/core/sf/mlx5_ifc_vhca_event.h    |  8 ---
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |  7 ++-
 .../mellanox/mlx5/core/steering/hws/vport.c        |  2 +-
 include/linux/mlx5/eswitch.h                       |  2 +-
 include/linux/mlx5/mlx5_ifc.h                      | 73 +++++++++++++++++++---
 include/linux/mlx5/vport.h                         |  4 +-
 12 files changed, 130 insertions(+), 59 deletions(-)

