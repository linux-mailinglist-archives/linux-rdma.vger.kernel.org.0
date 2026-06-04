Return-Path: <linux-rdma+bounces-21764-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 005XHIRpIWowGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21764-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:03:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C563FAE0
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:03:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="iN7YD/h9";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21764-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21764-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B23BE30C9365
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140C4779A8;
	Thu,  4 Jun 2026 11:47:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7452AD35;
	Thu,  4 Jun 2026 11:47:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573634; cv=fail; b=DXXuIp9lFqMX/p+xRGQPy7HXG3jcKWsAKfv149aWyVfzKDJELVWldsc3lj+AqoiBMAx/Uaqh3ptVEQBvrxs3b/cddAQdSrx+VVruV2SOvH9sNh+AUYITMe7MlXh+qx+TYMLnkD4xQh03Lw1ytPOj/ibVQyd7HgDi9p8CM+l8p6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573634; c=relaxed/simple;
	bh=KQvzP3JHD3SQ7hmQjeRtpsYCW9yOj37uQehDmOpMyKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbyAP5Biq/uSkUtc88kZrVnRLfFpDyXKNqsXNDDUUvID1QIbVvrXYfVnsE8hTp6+U2i0Qaqq5Sba9GASCf5gtLh2f4B5kSdmRLkDBF5Jb0P8YNyyN5qujnx4T10dzudLAAFDnZy2basZh8LmtL0Bqut7NQRtYm6W1vQPHnuBsC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iN7YD/h9; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PePEUm5uvFbUVrsQfn+Y2U1eKqcFpnICxowscey8YBieJuhuR4+lnvpkKk8QpN2E0NpTvPEigS80hPwygqIpIK9QEf0MjdwCYI0gkp4T7OROv3tTZL0TYHQJWgqmo4MHj8pglpWHJaaPgzefwrgmLrFwlVhConkHphRn4dmITbZ2EPxO1I4D6XfFdUXpdJdKI8yCqxBRurPOsSKbfol7juvtUcQNMweaMUqJcyyTOBE2lAPgarIrSqFFFGCNNQjmX6ZPS+7pDrnL+3mQi58Rb+YtTx2AStSbhQM+gyozb5fvAff0E/jNTIXsZPhJ0V5HAxySDqMwN8mkJFej79W3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0weW/g7m1vPAzQ3+5HCE9qXQdI2crDcEyP6+t2UXzM=;
 b=CP5R+tZFKDZxpEh1wYktVbsA6JcvtvhqGjvxYGHfEhwgNiSmIPkke/jkM3sgvO/B0vefhXsQa5EmQ8E5rAhufNZrQMXD31or0eU3PFR5XIwtmWnnvzBIEs/l+uQlcOC1IKiKb+L/9DZokxaZaJJCcWhQItKparc5RkC/QxHj1h8bXrso7APw8vA1JlThraQwNutLWQJ+LWTaUn3tJPgFC+wWhtZY0yfY03DDCcxuAPLnjXqsIozezeo72OPDS2vVEzUFBBRZGGjuVbcHCI+lEQ9q0aMb2Xr+3vYA1hUsRLJfJqZwZ3Fxd8zhvp/h8ghaLWmoH8hl5UF7GKJmxIuNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0weW/g7m1vPAzQ3+5HCE9qXQdI2crDcEyP6+t2UXzM=;
 b=iN7YD/h9eFW15VCIH82LnVE2oY78blg9AL1RwCd9ho7A3R4iji1dKaMXtvxdJMTrqvaEvAWZ7jg7bDDL7ElXWzNVaudKzCsg8jbvHJLkgPyGThMxQ4ufWrCOfDO4XDPXU7kPWPMuAgLAmhro/UO8IROw7pUu+GdHr09w80CEDT5yLhccDGWHewhTtZaWPLi4sxnKT/mtWxfvzrWND34EpL/CuN6dpG37ufr5+kPET4fouU4JRNeK7cbLEIxMYw7uKS1JIE+CTyz9LorLxBdj3BX8v3oFk9XLf+jWfDVAaXF67wI/RU1E4lI0OgiojukZLLIArNo5tmG2Ffs4HhOSTQ==
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:47:05 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::a7) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:47:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:41 -0700
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
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 14/15] net/mlx5: SD, defer vport metadata init until SD is ready
Date: Thu, 4 Jun 2026 14:44:54 +0300
Message-ID: <20260604114455.434711-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fce6336-7d61-4f27-abea-08dec22efffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fdnrZsZj9FlvbkkzBx0rxYBsyBiy7XRh8AKY57e3OIfih93aSaJIgI6jc7FY07nsq8OZiG6+Ibss1BgqKwOGgqarJWKq8gwr6HofCd6eYnv4iqQM+cnb4SEEm/mZLXzOX4PArgSb72PWEgYdIedcWs4kJR897VKhJSchzzMp27/gBGeH7L+SedwM5unyIkyFMxLS8OsbDxt/fhG0c15c9EZIKzsZ4CCL4uhw1IKu73GZxN6Q2/4XECOEcqn+ZIlW4tEi+eKBq32YC8KwTjH3vv672xO7608Uhd0LAynYRtO/wgE8feFBlDmOZ+Da4xGWiG9HJJovecZAfV/iC2gVV7JXv2er7cWHp460sGBJ1dOtI+XCRkOiWH6Jg5TaPk6J5uH78fEJ3D5hdC7cXsqelmjd7jwMeVVDdS04slEa1fNZJCJqqL2JL8OVIZgOzDy0sgad5MWBynjTJhW96Ul7P6kCWnvVTGKF6U7v53Aa9leDsV9+UGem4Ra5Q/SYAoH/hpr8yyw2g08Frz4cl++PT0lK1MGUokpWnfbeMoWqypBz87dkr5MQbUFl54CSMSx4IGsxpBYIUpkizMmK08wwocSFk80VLMvpKgorhxVFjrLdpLyyUk6b7XACsAR1zVRSZEeDl5SE+3LYVGAcBm6nEuwWeDqqOM6t+He4z2F0G1DjB6bX4KcMxE4VyKL+S4hRgRqa3KFMmS6meGxjOqP9YIOJDFXrJEDe4OZomoWqBBU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TPW+6nWueoN697A6URMxrZQOkVQciTnOG+WL/63oSIkkChJvIkKaXwju3VMN0wTfa5Q/j7ceRVtiRu2i+MTBdyYtvF9nUR9lE+avCa8UIjc7sxGq9wEHPkJmWbwDoTiConnEEDKe7V0K/5xJa3LLCqhNyumzM8seLVi6qkbUnU2fJIISLv6vU17yX/GgTNZ1+yVPlA3JZ2fAbcvqf9FTSENP4HoVZXzrAD5z7lP0oo1AHKR6FK0DDfpAJualSpI6nyBG/vVV9ViSc6jTKHjpO+KbfpfdH1AW8hRB6zm/6raNk2vgyKl1d5rGxRAMp2sA9W4ikxRdTHXyHgPeiM68fQHLaxsvOc9F5g94mWAqf781F0+RQR7eCXvdeCuzV1IinKgBea29/cRz9sGZcztJ+nJ5nEyHwiyeL6Z8KKOVH+Oekspfu2z7gtnsHx/y9D6b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:47:04.9943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fce6336-7d61-4f27-abea-08dec22efffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21764-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC9C563FAE0

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
 .../mellanox/mlx5/core/eswitch_offloads.c     | 46 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 16 +++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

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
index 4d3f80bd6af0..503530b0acba 100644
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
@@ -3711,6 +3713,38 @@ static int esw_offloads_metadata_init(struct mlx5_eswitch *esw)
 	return err;
 }
 
+/* Deferred metadata init for SD devices: allocate vport metadata
+ * Safe to call multiple times - subsequent calls are no-ops.
+ */
+int mlx5_esw_offloads_init_deferred_metadata(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *manager;
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
+	/* Manager vport don't have a rep/netdev loaded but its ingress ACL
+	 * was programmed with metadata=0 in esw_create_offloads_acl_tables() -
+	 * refresh it explicitly.
+	 */
+	mlx5_esw_acl_ingress_vport_metadata_update(esw, esw->manager_vport, 0);
+
+	return 0;
+}
+
 int
 esw_vport_create_offloads_acl_tables(struct mlx5_eswitch *esw,
 				     struct mlx5_vport *vport)
@@ -4053,7 +4087,17 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_roce;
 
-	err = esw_offloads_metadata_init(esw);
+	/* SD devices defer metadata init until SD is ready and
+	 * mlx5_sd_pf_num_get() can return the correct pf_num.
+	 */
+	if (!mlx5_get_sd(esw->dev)) {
+		err = esw_offloads_metadata_init(esw);
+	} else if (mlx5_eswitch_vport_match_metadata_enabled(esw)) {
+		struct mlx5_vport *uplink =
+			mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+
+		err = esw_offloads_vport_metadata_setup(esw, uplink);
+	}
 	if (err)
 		goto err_metadata;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index d2ed156ed1c6..82ae8c3969fe 100644
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
@@ -1016,6 +1017,21 @@ static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
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


