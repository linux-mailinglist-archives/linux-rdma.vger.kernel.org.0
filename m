Return-Path: <linux-rdma+bounces-19830-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KMoGjcv9GlM/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19830-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:42:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 100DA4AA5E0
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69F0530151D2
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33ED2F25E4;
	Fri,  1 May 2026 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bRFTLNSx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4481F7569;
	Fri,  1 May 2026 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610546; cv=fail; b=YYDwxxLc2P7mLBdhWxr9+pz04FD7y8QLYG3m3fSQa9ErHEAej9UndEjT8hHiuWIlEvO32DBwDP2xDsUw0R7wC8aZd78tJM1EaZkSsJtGMfSMgz+TxNv3Rk7E0mbQM9iwlBkPXtWm1bQ69636O8IcelA3PuF2Ei96EkffrMy2ctE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610546; c=relaxed/simple;
	bh=RCHrKqw3zvZo/4UpRdZsHHlGQlUkBmitYQXYiJYIs9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lu+EyAwB8XUA0OZP3B91OusOxtctjGytKRRJlfwyI8Y+Gdce8ma68hPDRDs91xFsqwsRw/dA5AM13yEyqkLrFl01tGEiHobizd0c0PCnCnS1FPa8zTOzL9hNGHrCuMIJqoblUsvJAWxPFNyUjUW3Z13IRkvHk5ph8FvX54p47U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bRFTLNSx; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzNYh52/POcyhJyJyoeq4voBu0MMhNdL9vLB95T6G7+E1LuNdzfiPEJW4Ev9+O78FtR7J/vthzpB7n/RYCKZ6ToFAi2/JPzmAmE2sAeht5TBfV4bClzw6T6f0cXqTHFIn/Zx06YlPeR+5D1Y65MMocqL+ZXmqgFS+6tha5RFcf63KIYabWYcKrRIy+ekodSHxBW/ZOoBoAwk7P8lm/dYICyhm3M8oS2/Qf0C0MWg4CtFr645Y5J18edcNhEn9PkyaFlKCzx25HOdRkgb3KCBE7eOLvsCe2KwENbvB72ZnRUfTgxNw4T91+olOCnTDvEAq4HXZCZKSfTZgKXKA0NH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTynscPRszaBJeVUQ2WwsQ1nVuT8Expnep9LsIiFdXY=;
 b=QVDb+sa4temM+E5ezNfSPQadTcJfCyBUnV6cOzctxe8U9LyDYoQ/HAFX/tuCye3HeNjFhAsVlUjvqd5ZU0N8ZHI+8VOoIh6rRKWaHDBnCWZ+U69obicn1ANJDbhvG3NtqEhPaIDwTi23r0wkVGJiFgLd+N3cf5E/nxQYgJgR/HFym7qX1MQ46rZQXizocYGlRF8HxaV4EFLqNR3FOhnNHSV0/EZ+9dnGPdsQe7MjlLd7KI39kRwBKJ9O9Xyc1tlXAtJDHhXHfdXLMXbbiSZXOmhw2go1nA8/tqjaJOLqHB8yvvactKpGPweFmKp91mLbCC5TXgxg3vgCtG/H5QFmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTynscPRszaBJeVUQ2WwsQ1nVuT8Expnep9LsIiFdXY=;
 b=bRFTLNSxpjkUPr1c2pCsc2cxc/KAV1blq+Vsc5O7lcK3Yk5CngaVZRBZAOwO+DsnG32iZdpowcotuJM5u4tOu4/0g56lNZficRT1d53hNLyZvcIu/ti0B928hAUU5AGBSPGhehouRCXwPgDuhAc3A4m9uj3S1FCKdZedxpRaWOa7mHPqwx5nwMCK5yd+J9bXAQT+5bS1Ri5UJAHi8kVmI10LYJ3wkVeRjHCV84PJpUYP9l3128ch67eNwiDF/UyzhwCzfcxSv8U1SsI8C5atVX9KxTbqWhNA8mHeNb302F5OpV5fIfi2Ihs2Bxl4PN4QM7stCJ5+ZXlf3IDpajJ50g==
Received: from BN9PR03CA0219.namprd03.prod.outlook.com (2603:10b6:408:f8::14)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 04:42:20 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::4f) by BN9PR03CA0219.outlook.office365.com
 (2603:10b6:408:f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 04:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:42:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:42:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:42:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 0/3] net/mlx5: ICM page management in VHCA_ID mode
Date: Fri, 1 May 2026 07:41:53 +0300
Message-ID: <20260501044156.260875-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: f5373bd3-21f8-40bb-98cf-08dea73c07db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zKxz3UJXdiOAITuKvbQhz0LsVLD4AajPaXDErUsyOfuxf+eh+wBRY9Do1aKAceeSZPUsQWyE+PpZwVpW+IvpNuatGLCUmwHnSpwXB9x8zwrqmPNWOe1zBMEjH2W7jMZv24/C6zMxIBvcRddzRaSu/hb4Vn6d6BUBzKsnydofy9NsJBzBXE5JDtDYp458ACsAbnw9NulXany41Wrvqfsod1iJ5dtmZp6sBwi4zIv17HR1jnjVelipvancD640j0m3FA299THoBq5rUz1z3jkPYhY/cwHSFOXRtveFnMESN0XaE4pdXtVHLctjgPHo91o/uup5pqfXGitHefJ8Oaa4c9eqWrpFlFrWIUlh4zMD8p0tXVAA2aSrJIvgmn5NQQvdlJ9b/c0Nz0UF/nyraSt5EEjTxwf0ijPAJrsq/eUQ4ENUDlTC4NyFNcsuzF/oEyiAW+X2/mpDXG+be+QZ66Gc5/J/bhtcxDJhaOCLlCBF6Q6B2/Q2lVNzPapoyjF143IaeIOm5qfg6UtSFVnRMcHAVunS8FxaCUcqnUz9QyFlbzvqgjn5U4oJtX5CiQk/k6Y/+lnH4uDuDy6D64wMqSrZR9TOuGKB42rRTAX3gY3q52+pihvr/0FjOkEwYtxuSogrXOt2Votsx+is+PbkPQtjZj0Ou7+SLUrnTvrMvwQWHdJ4Pxz6/sOgwctAVrI11icFqcEgCB3k6yLcLg2wG85ziUDAP4XajMnf9iXVMv2stY8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TnGqds/L3sZVABESHFrwNpo6ptKTyYux1t5XIWebJSeh1LfIOW8mC4LFqTyo+OhCyKk7AaZO+kAgUU2SaOpFR1FX9MirJN/OirUb6wtubCJKsL0xhXWcLwoS+Ovq358pKex7wL+A4z/yUccNoZeZi/40qsBGrlp556ge4Ndt2+1Zu5D5ghoAJFSKp5XAU3fZYwrab4WNGbhX5rFlX2c7dWhmkiXOexAzpGAvPx0ipH77cmIyHTSkT6vX4XRzFGCEcqAoZfrSjvg8GwiCvq4VyMF9sEh+5mQBFQcHIneS25X9X3tBFqP63/7QL7MqvrkwWZfflDWHE3ilHtRQyUUET4A75RZo63Mi+NBA7t7g5Tn3ySSPvZm/3QmVSf7XLsHCR3oc+MZaJ4g8YLfwWBF8P07+2rRzyvYPhPR5x5gMv8jO39KGp3ZTOODlqXddiYsk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:42:20.3072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5373bd3-21f8-40bb-98cf-08dea73c07db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
X-Rspamd-Queue-Id: 100DA4AA5E0
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19830-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

Find detailed description by Moshe below.

Regards,
Tariq

This series adds driver support for the VHCA_ID page management mode.
When firmware and driver support this mode, ICM (Interconnect Context
Memory) page management uses the device vhca_id as the function
identifier in MANAGE_PAGES, QUERY_PAGES, and page request events instead
of the legacy function_id + ec_function pair.

Background
Firmware can operate page management in two modes:
FUNC_ID mode (current): Function identity is (function_id, ec_function).
This remains the default and is used for boot pages and when the new
mode capability is not set.
VHCA_ID mode (new): Function identity is vhca_id only; ec_function is
ignored. This aligns page management with the vhca_id-based model used
by other firmware commands and simplifies identification on SmartNIC and
multi-function setups.


Moshe Shemesh (3):
  net/mlx5: Relax capability check for eswitch query paths
  net/mlx5: Make debugfs page counters by function type dynamic
  net/mlx5: Add VHCA_ID page management mode support

 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  39 ++-
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  48 +++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   7 +
 .../mellanox/mlx5/core/eswitch_offloads.c     |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  10 +-
 .../ethernet/mellanox/mlx5/core/pagealloc.c   | 226 ++++++++++++++----
 include/linux/mlx5/driver.h                   |   9 +
 8 files changed, 289 insertions(+), 66 deletions(-)


base-commit: 4e37987362bcac8909f2d4b4458f3aa645e41641
-- 
2.44.0


