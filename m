Return-Path: <linux-rdma+bounces-22173-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fGwEE6LxK2r1IAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22173-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:46:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ABF679116
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:46:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=X0whO1j2;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22173-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22173-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20FCA303B304
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2745834A3D6;
	Fri, 12 Jun 2026 11:41:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEB3E8321;
	Fri, 12 Jun 2026 11:41:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264480; cv=fail; b=UIZZltxbHjrtwYSu/8J23fzzmbuHpjfQCDOnr4T+kH8APZiZiL+2KABBNBJraWf66gq9Nq7fqJD/rVxy3YAKucTr/qHezKEcKgUtbmCtd4DSvLpCyQv44kW0rn6/0Qd3tUv5y0j+F3mYDRmohvPkSQVFQ9/0SgIaE572X+r83J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264480; c=relaxed/simple;
	bh=THSJk/XKl1yk+XKl8F9SlWs0YzopXoCysOrBVr8LwVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvMjPNIp+3MzitzKhtgxiH1EOklLAfd0x/MC0GcU5NzadTmhCnqLD47tEWGoY2eQdsrL7ajS4wguJ+3zyh7l4EE4rDcIZosmf3GUKuz1+3up8KspLNvyK+xrdVxe0m/kkHAqYVK6qsqy/ADe513IxAmv3L9FoBg5fvRw6tw3uvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0whO1j2; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNqIU80wCokGCFI973N4hCxqlU3ExxiE2Qk7cLlIuqaEACF16/BN9OEz75NVp/FLEcFI35rABMBItOOJRZRQ9eBwQLr3JderLr2nkXSDsXigBGAbcxflU6oNucNbKKt1/gsPC5oaRP5SxHoQdOxgo3Vnhkd1FuH7pWNLrbwLtMVrXBwTTqTXjKMLTZZYWEn/iTfbbHPGRTCbfh/8KXtXD/FdwJUK1YU2pX3/34KFI6RcAhOlRH8O0oq3fcqR5ZLwryD9Edm/O/Y1BtGG6Koe4vRiLXqmP2Sn+cGjoxdiFPIrPOZNkoYXDcWQ7G1H9BbD/o4et7mYAwsKVQKYWBP3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utEXnTKkqCuyhBDbdkguBjaYntrLJX/ii+/s1E7RnlI=;
 b=NBR81Z0fOWcoCOXXINbHOfvUEG79ZbadVr1ISstG9A942J6Dyjry1RbYS/D8PjGGvGfaoOOmpTnKU4TLM957XMqNzsHTWAAfqd/6f3VFYlcpD44wIm6oRQZaEziUpf6O9Nv1nxTtoPjrO1jJPuxMimi2TvZ4xnV64g5GtKIU8ealpPqnx5OfqTeInWEbPPNGF6v2cKJ0D1dKgeHcFcD/955sPOZf68RAGd5+Lnt0zinf0GiwrsAvl6+9mpFUakG0oZR5fyCFqqpTiL0AGuwAqsVfBMKik0eKv8VpZFgxXTavnItHbV/03qYr0rufmUTdQVheLsD/QZ9mH327pcjkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utEXnTKkqCuyhBDbdkguBjaYntrLJX/ii+/s1E7RnlI=;
 b=X0whO1j2QP+GocN9bzVSoP6mtTY3WQ2DIR/01oAsUSGOh3OERp5l0m9TtszKeP2/pTRbGr+2KI1N8RdsEG/YnLR1YbG0Z/6nUH45YKSFmBIKM2BTyWsie7aEdFR1xLoYVLKxinoC+jpV7i/T2d0wg0x9EdBlhK7oXpB4fquOfEAYto0EpqFQcJ5ad93WCrzb2KvviAjyLPsNoYe8hcFnl467gRYB+tW+oJlUe1dt3vNVDdTAWloknPm4IUaPD8M+l/Pt1sRiNYF37dScdcijOUaz8UT7I99IOzLi5MCmoY4mMJZu5dQihMSmvDDMfkIkiRvsNXEG/aRwhO1Ihc0ylA==
Received: from PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::34)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:41:12 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::9f) by PH7P220CA0117.outlook.office365.com
 (2603:10b6:510:32d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Fri, 12 Jun 2026 11:41:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 14/15] net/mlx5: SD, defer vport metadata init until SD is ready
Date: Fri, 12 Jun 2026 14:39:03 +0300
Message-ID: <20260612113904.537595-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 39454d6f-f552-4c19-d065-08dec87780b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	za2IbJ6AkouYwdpm78fgxPnrc8NePzxxl+cxf1p7ZY831pGn9evVWSJ22KimMi4uzCjRmS8O+T1hju9oU30EJx3qdme4h9QbwLNVK3MyOgvJNL9LNDTnXALS4WTdPH5T1EV6MpCjzIGGoP9wfsiu9pdiyvhJEBX91khM6P3Xc2tOr7XLx8EscU1iRwab9jzU6QDzKGACvMR1gU3Dvy4bnYJGG6ZPeNabnxS1xekCRP//QODN7O3NRmjKamcTPztsfVzEI3lFG27WqOa2Gjnyw/AnoLFQwN6O22bi26YGqGyYv6Qry91h2zlwK+n7e7DlaPsLHsxfvUMitRkwZpH8kv0ifYli1UreoSn36xZh64UAMezEODtGZNkpgtxE6ctkJkh8RO+hxeemkCAp9jK/q4II+J3zOCEnbVAcl6P+I/FxJnZlon4u1yb8ILS2ef/hOsD7ON6Arin6Y+nK4dwL+aa3MdAPwV9DP++yG8sEkHbMgcMJV/CfpH8cgJoMq1B4wbMPAInDoOZlEnbfHMx0Qc2LDFLayz3ZtK+XncN+4mr5R2Jm7/gD/2rqdjOO9S1mvZNp7MvdWweea04ecMZQ66GyrAALmgxHlt0tkhavldbyz4MPu/hcNpvIj2Kiv1Z2tqknxTpeo5CUYT1HQY6pLHj026itj1aHzPN0X9Gk4c/bJ9OmENdMrAh4nnuxX6LHqcTZ2AxZo+QKuNigFR91QvN7IEzvI/3sJnsZV37fcEE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wAhOGqBPK7zzAYVRPbsYpoDJr8RRgxfizA0plXw57ncIEjR0DYNleM3wNmbLVLYppVjhFw3X0XH0CHFACTkliD4DpbFsFWwjy07va5AGCwWPx1E9sdX6PT/A17yULfTyZdURRgrI/UiyehMgJ4oxi5RG63VGZeCQRjDkXLq29G5a8WlZnSvsTsp0ougQ1gHV168ABPetjUx/9oXoRDx8BG0GPVAUFS9HMvrhTxutf5HX7IIwSTycHwHW6VxRldZO3Ae31Wc3PCvBf8UWOUN1Ges2NBS3ioO4O3zCyg4MrdCuCO5GV4rpQJljMylqzHUjuugWtHUM1jlvWLOLnND912mqmwnUxJ/zyyZBMek3pSEIMV2LKjR8ZO09GYMMInKWScp8c8Oj+PcwY6XtBm12SXS29A/KcG/P+ERXCgnRibXoQTVkSShlwzZuESwXQiY2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:41:11.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39454d6f-f552-4c19-d065-08dec87780b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22173-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64ABF679116

From: Shay Drory <shayd@nvidia.com>

Allow SD devices to transition to switchdev before the SD group is
fully up. Metadata allocation requires the SD group to be ready, so
defer it from esw_offloads_enable() until SD shared-FDB activation.

Add mlx5_esw_offloads_init_deferred_metadata() which allocates per-vport
metadata and refreshes the ingress ACLs that were previously programmed
with metadata=0. The helper is idempotent and can be called multiple
times.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 79 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 16 ++++
 3 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index b2b3150f1f04..fea72b1dedab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -440,6 +440,7 @@ struct mlx5_eswitch {
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
 int esw_offloads_enable(struct mlx5_eswitch *esw);
+int mlx5_esw_offloads_init_deferred_metadata(struct mlx5_eswitch *esw);
 void esw_offloads_cleanup(struct mlx5_eswitch *esw);
 int esw_offloads_init(struct mlx5_eswitch *esw);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4dc190a4e7b2..8fa7e633451c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3675,6 +3675,7 @@ static void esw_offloads_vport_metadata_cleanup(struct mlx5_eswitch *esw,
 
 	WARN_ON(vport->metadata != vport->default_metadata);
 	mlx5_esw_match_metadata_free(esw, vport->default_metadata);
+	vport->default_metadata = 0;
 }
 
 static void esw_offloads_metadata_uninit(struct mlx5_eswitch *esw)
@@ -3711,6 +3712,73 @@ static int esw_offloads_metadata_init(struct mlx5_eswitch *esw)
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
+	mutex_lock(&esw->state_lock);
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
+	mutex_unlock(&esw->state_lock);
+	return 0;
+
+err_acl:
+	esw_offloads_metadata_uninit(esw);
+	mutex_unlock(&esw->state_lock);
+	return err;
+}
+
 int
 esw_vport_create_offloads_acl_tables(struct mlx5_eswitch *esw,
 				     struct mlx5_vport *vport)
@@ -4072,9 +4140,14 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
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
index b35795bac098..2fcccd329eb5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -992,6 +992,7 @@ static bool mlx5_sd_all_paired(struct mlx5_core_dev *primary)
 static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_core_dev *pos;
 	struct mlx5_lag *ldev;
 	struct lag_func *pf;
 	int err;
@@ -1024,6 +1025,21 @@ static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
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


