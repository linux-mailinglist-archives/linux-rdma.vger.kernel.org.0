Return-Path: <linux-rdma+bounces-21971-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xcrXLg/MJmrekgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21971-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:05:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525D656E9A
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:05:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=N6lILXK9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21971-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21971-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E1343038B92
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD233D0C18;
	Mon,  8 Jun 2026 13:58:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD83C8716;
	Mon,  8 Jun 2026 13:58:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927100; cv=fail; b=rgNT3OwIjj7DrZuVlvrH/ulqlFlO/r39QCY+DUyp6zt+CUcodJuUika1/T9s/sKAdb7YsOIpuz/vgGdyVKu5lFYIO7RjXRjcD18j58f+BxPO14O2J21Qf0ahUSgpxzXfLPrzfnr4SdrblcTrBcpNCiZXY4z8o1yInz2CT141dtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927100; c=relaxed/simple;
	bh=3mOuRt69UmRlKxl1sr2Bf0nHWCAbq48FAXMQEZddQw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jayWrdPXX7Fabl8y8ncnRYyPQRt/VLpwV/E3kDyyNxMGliqcJeA581GmJ+b3blVUD8dADNYfDN4bCHvWg1hTYtQszbPrF46V38nepj7GFYa/FuBQzow1Pcha3nv8MzWNxR39W6+OEliqMdHCbQwq1Vm9gM0zKz/1GerofhmDd30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N6lILXK9; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7bx0hAUZB/qDhaz//ahl06AUuppV4lPB4foDU27tIeDZBo8ayL09jEoZ+ftJu/W7iRvo5MubIP1dCwn/qk70Xx29NvKU9/PEXAhgdEa/HtMCJY+42EIJVutyGbeOaB3boAQoSu7KD61uGmv4/JczksQEtuiYd8C3KWRLKczqOYKw1g1N6hxwnf7h8UCNft7KxoWsa2TNmVnQAMM1lpHYnWR5Mv8iVRjjc3a1IX+TvAZ2ta9KF037VluKBfz4U6hMunY7lqW9vP1ioxMChFaRyers5F17E9S5l02zNjRm8+OuE41ijuaWmAddbX7IxJBLDa6s9YUK8WHt681rNBXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evybPi7JWYNML2noGRUz7zsA+fczd+LvLnRmqSaIoLs=;
 b=qE4e3ZjzS5IYcraJnW3/nMCy9Nf2PYTIVgteAFUyO65Af/3J8t2+Qa7TvR3hq3vKQZyNSie/NQCM6S+A9wiFH+WSo4lVTz24z8FFmFE/sxqaRnUezDwXW/fjdCH48jlDLtNMdDVqs/mqYSZYYoryr6gkT1mDPK7yfLbv6m6BbbE9LQe/ZePkr7KfXA9C9+95rv3UDZatvcDLPIvqiLJHSL9cs0v6iphes6EqVSDs7iKacYxTwpgic+9tH32lBgrlBdFpbYVOGpVljlkwfdIppJ6ZCWxZd+swGcNEC0vwS7b7GXOZC7hE7O+y2TKa/Y8GfBQGMWT5YPTSvvMvCBPktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evybPi7JWYNML2noGRUz7zsA+fczd+LvLnRmqSaIoLs=;
 b=N6lILXK95HEYKzqZdS7llchPYQ+m8f9X/RAVAj10BzQGoDfTO6PObbwqBW47YX5F0gXTU4xBWfDgCZS32KA5t57PXZqBQxOqy7U9K/zXVnX+EzCl5Yvw1Ou3ySBjwHYm+BIE6OPVCKaxtNG5SLQX8WDnGBn3JGqWTbWX862FK62nXZhE4BfPOKBV3GUogw1jzdE7Ee3DJtQSTyPJvByzEvZtJgvL2ZDYYiqiw0GGpo1AMAaOHvCG/ZjavKFBXThrap6KSE1d+Uqh/D02VWsWnK8VN2jsP6pliprkgYlqShjvs8rbJR0PSxnzYiH4VQbs2Wypj/d+k+dbZj6jGnHT6w==
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Mon, 8 Jun 2026
 13:58:10 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::5e) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:58:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 14/15] net/mlx5: SD, defer vport metadata init until SD is ready
Date: Mon, 8 Jun 2026 16:55:46 +0300
Message-ID: <20260608135547.482825-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4696aba2-0efa-4d8d-80de-08dec565f986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pHwIsch88jzxy79d2XHilRPQng5Bo8Nsh45IuFsNoMFhpXisN+n2wJOtS1g3DIEi+4kNh0Vld8/9XYncqNSwcrsjcTy0vhuM2dGBX6Is+5eGxmsJhFpBNsDAdD04rU61S7VSCU0Oh3JqW+3hCJFjnQJ6Mx22VgfEHaZZVPy7MzMxQxJbDR2shhhKk3mRbpQdirhxDZcidS0LTDT53wwpqWXlBAvH4f2LgbOq/kwp7/YoSRZaI+BjgFNhoMRBGBxy5pryJUFfUwj+Ud8wEZCKA/6mi1qkw/LcOtQSILJdpz/PExlBkyHmqrQqeGEAnqoySF61NQFrgzqjg64DLHatzikjKlmVUuRwLBE+IW/UO+RDUE8/9t3ONIEEDRtdcxBygDL6SwodiOaoJtLE2RNwGbgLFyXWI/ftXTI7e55IgflHvTVIw6vR4ifzDEp4u8372FBP/OMbmP5tB31JzioOI1q0iX7rzDAUyINTeeZjvANqASS2CBZYQxrUTorPYRDnSPS049+jEAmSTducl67GYWT/ZCL3+A4MHi3lvoeG+NgqjXtJ3WbjOdInHB81NdgkzamontgNNdqjCLnAwTkYEQsyFBeb1bN7EElF6fRuOIOH0hbPdmDF9SnyL7gwYphlcqDFJesPpjLFCGSg50PME0GwqZtDOhyopALz+/ip/9bXE/oXefSG68XDbBg7cmMbhQVVi2Q2euRFf89UqwLVKk58vqvZYcIKXN7vNwzohBM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iSuy/21L+w4KTuYuUcqJXUcGdUlhnNwN8hzI5uWNV6IrzN7J5Y6G4K5LWL3u2K07T7rolQKZUtYLYVPIcGULmydBHehsQz8cIpbLqMerrRw3CmD68rFoOtzdIy9pmJj4QJMwO1vQYxgW8LwsA8Ikb+hEF/SllTzG6tMEJ4d/cIBo5qlIxDlrxdq3lkeFOzB39IyUR3poX8FtCGrsQZjo49spZpheqQOYPXSBFfY7wCiMJKaFzDJ25Uf7DT/fTUYJ1EG6X8knc9Vx/kUcmIL2Ar1jX3WAAUbnShb3I2vUdOB9r4t3JiWZ2Oth8Z4V7BvBHGyPA15MAWOsoj//pbXrVaopBEfrryCASImsBL4ZTg2kNJt59b/GOV3YFpG22fr29ABN+cNrNvqb2SjujAsAKwzkS+Hm/rt+IiYI0PAUiFMWaW+gzx1WieWq6QCMvMoi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:58:09.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4696aba2-0efa-4d8d-80de-08dec565f986
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21971-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8525D656E9A

From: Shay Drory <shayd@nvidia.com>

Allow SD devices to transition to switchdev before the SD group is
fully up. Metadata allocation requires the SD group to be ready, so
defer it from esw_offloads_enable() until SD shared-FDB activation.

Add mlx5_esw_offloads_init_deferred_metadata() which allocates
per-vport metadata and refreshes the manager ingress ACLs that were
previously programmed with metadata=0. The helper is idempotent and
can be called multiple times.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 77 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 16 ++++
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a5f0774834fe..ecf6a28a1c08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -440,6 +440,7 @@ struct mlx5_eswitch {
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
 int esw_offloads_enable(struct mlx5_eswitch *esw);
+int mlx5_esw_offloads_init_deferred_metadata(struct mlx5_eswitch *esw);
 void esw_offloads_cleanup(struct mlx5_eswitch *esw);
 int esw_offloads_init(struct mlx5_eswitch *esw);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index e87837fbc372..9aec470fe126 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -43,6 +43,7 @@
 #include "esw/acl/ofld.h"
 #include "rdma.h"
 #include "en.h"
+#include "en_rep.h"
 #include "fs_core.h"
 #include "lib/mlx5.h"
 #include "lib/devcom.h"
@@ -3675,6 +3676,7 @@ static void esw_offloads_vport_metadata_cleanup(struct mlx5_eswitch *esw,
 
 	WARN_ON(vport->metadata != vport->default_metadata);
 	mlx5_esw_match_metadata_free(esw, vport->default_metadata);
+	vport->default_metadata = 0;
 }
 
 static void esw_offloads_metadata_uninit(struct mlx5_eswitch *esw)
@@ -3711,6 +3713,70 @@ static int esw_offloads_metadata_init(struct mlx5_eswitch *esw)
 	return err;
 }
 
+/* Deferred metadata init for SD devices: allocate vport metadata and
+ * refresh the ingress ACL for every vport whose ACL was created with
+ * metadata=0 in esw_create_offloads_acl_tables() / esw_vport_setup().
+ *
+ * No Rep is loaded at this point ==> no Rep net-dev exists, so no need
+ * to take rtnl lock.
+ *
+ * Safe to call multiple times - subsequent calls are no-ops.
+ */
+int mlx5_esw_offloads_init_deferred_metadata(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *manager, *vport;
+	unsigned long i;
+	int err;
+
+	if (!mlx5_eswitch_vport_match_metadata_enabled(esw))
+		return 0;
+
+	manager = mlx5_eswitch_get_vport(esw, esw->manager_vport);
+	if (IS_ERR(manager))
+		return PTR_ERR(manager);
+
+	/* Sanity check: skip if metadata was already initialized */
+	if (manager->default_metadata)
+		return 0;
+
+	err = esw_offloads_metadata_init(esw);
+	if (err)
+		return err;
+
+	/* Manager vport doesn't have a rep/netdev loaded but its ingress ACL
+	 * was programmed with metadata=0 - refresh it explicitly.
+	 */
+	err = mlx5_esw_acl_ingress_vport_metadata_update(esw,
+							 esw->manager_vport,
+							 0);
+	if (err)
+		goto err_acl;
+
+	/* UPLINK is never marked enabled but its ACL is programmed in
+	 * esw_create_offloads_acl_tables(); refresh it explicitly.
+	 */
+	err = mlx5_esw_acl_ingress_vport_metadata_update(esw, MLX5_VPORT_UPLINK,
+							 0);
+	if (err)
+		goto err_acl;
+
+	mlx5_esw_for_each_vport(esw, i, vport) {
+		if (!vport || !vport->enabled)
+			continue;
+		err = mlx5_esw_acl_ingress_vport_metadata_update(esw,
+								 vport->vport,
+								 0);
+		if (err)
+			goto err_acl;
+	}
+
+	return 0;
+
+err_acl:
+	esw_offloads_metadata_uninit(esw);
+	return err;
+}
+
 int
 esw_vport_create_offloads_acl_tables(struct mlx5_eswitch *esw,
 				     struct mlx5_vport *vport)
@@ -4053,9 +4119,14 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_roce;
 
-	err = esw_offloads_metadata_init(esw);
-	if (err)
-		goto err_metadata;
+	/* SD devices defer metadata init until SD is ready and
+	 * mlx5_sd_pf_num_get() can return the correct pf_num.
+	 */
+	if (!mlx5_get_sd(esw->dev)) {
+		err = esw_offloads_metadata_init(esw);
+		if (err)
+			goto err_metadata;
+	}
 
 	err = esw_set_passing_vport_metadata(esw, true);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 9ff62c134c2a..d74a5a2862cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -988,6 +988,7 @@ static bool mlx5_sd_all_paired(struct mlx5_core_dev *primary)
 static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_core_dev *pos;
 	struct mlx5_lag *ldev;
 	struct lag_func *pf;
 	int err;
@@ -1020,6 +1021,21 @@ static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
 		goto unlock;
 	}
 
+	/* Initialize vport metadata for all group devices. This is deferred
+	 * from esw_offloads_enable() because mlx5_sd_pf_num_get() requires
+	 * the SD group to be ready.
+	 */
+	mlx5_sd_for_each_dev(i, primary, pos) {
+		struct mlx5_eswitch *esw = pos->priv.eswitch;
+
+		err = mlx5_esw_offloads_init_deferred_metadata(esw);
+		if (err) {
+			sd_warn(primary, "Failed to init metadata for %s: %d\n",
+				dev_name(pos->device), err);
+			goto unlock;
+		}
+	}
+
 	err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, sd->group_id);
 	if (err)
 		sd_warn(primary, "Failed to create shared FDB: %d\n", err);
-- 
2.44.0


