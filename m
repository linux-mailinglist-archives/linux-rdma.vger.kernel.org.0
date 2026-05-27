Return-Path: <linux-rdma+bounces-21355-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO+XKePrFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21355-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:04:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D25E491C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CD853075C00
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0C405C49;
	Wed, 27 May 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mp/yuCSg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127C3F58FE;
	Wed, 27 May 2026 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886552; cv=fail; b=HLJXCTt6QYx2yAyTsjaM4XghMRvEpfa/A8ETsPFi0A2g4d1laLNQviRTEEki94h9DSHKfIKF0fbb3hKHDatCU1gmSkkXmeZB4lUydP5FvI3RoijtLigm0Vc60tgKrgVmfQpY/Ri+jEp1TQeKc15/El+eQJP2cJP0/INwUekFDjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886552; c=relaxed/simple;
	bh=u+SEIVpOj3Gf79Ylprfc5kmueLEfNDYnXxOc3+s/VNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fj9w9keuysffu61b8d15f8GVgAQvaiTWIIyfA+M313Kq2qs1oK1GQYKWH8SwqrEIMnsWTThR/yjjJGiYM9AiSJ4kmPdapiBSUpM2jhYbdOjwi/Gvm9W8oxkUxDZKDgCjCAY9Kb+KpYXGqtf8GKCBCFyj1rlrvCNBZMiropZaXSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mp/yuCSg; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISdPSkbnXcLoMWD3mP3PnntRJPVw6vZyV8JWJV+yfWetMvshUWmC1gMxOFV7B8Cteeh2nAM/fan34Xp1kBul/2QNY/p/1wlPFM38Pl5pY+uuGDPl2qz8ri7UaFFR4Cg2gBjCvVzsgIi/BLRJ+GoUHVTpg5hG3zMTtnJUselnYBUPAUOXi7oEwZ0XHPP4S8Ae88GZ0qKwP/YlKI0J1myhv2fQUb84WDX1h0ret/62v3TMeWv47HCaRMHOm/ecGTyFYdGvXi4I5XqgjqkD8yu8DfLxrAffPkCeB+lcgvn1RmOLwO1StCuSwCKUcrfBqIMvzE3Ls2BcPvrrV2v4pA/7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hvmj+R1F8Y6pmfg41BEb8ne5v0EuRUUYWQWCscmH7I=;
 b=TOI5KfN1Ggyc+lJ0oV0GTjdm53pLyDXppsLzvdHZ8vdkmBGQT4wO3Svg1mYurYjl30p3iSjY9yf5M96+XFzp3Y04rDlSDKbn5dXYACFqGB8bUoJPTJYBQmliNnJe8MOZPMpfHgJ6ljehZ3wc41fnQTBpzSpebDjQv3mWSSoy6zzfUZQndWIv0KxC8gKirVHm6imUTMUV65QT3xaBkG262iM7yG3PZYB4tyNavEyF37fEYDa52U5G5Zm2e8J/FK+XVbL+J8SAOABiDoyz7hMikn9Lg7rDFAHqtRJdmMkM5rKoHBXbcfF6VDrPG57fpru1Q7wSl6ee6yjS4LSsZmqetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hvmj+R1F8Y6pmfg41BEb8ne5v0EuRUUYWQWCscmH7I=;
 b=mp/yuCSgAtvpYEO7wIaHZeDvg8YX8KovDW7PxJvy3YHwsY3DH0wNoR23b2eCBgb6CVapo+Pixon2exgNlzT4DvZBtNDhtNS5IIakGGmCxxEdpUBhk2zhCcP5sXH32XkzU7vw1bX9jI8goNDtYBgX+A8eKR7lGFdjlwVfhKxMrMVzBK/IVT71V0K+XXtuoyR16UG8wCbZlFUwRzyVytyHnSjU9Kdb8PO0mib4592yljeHh0qNfqZpGg7PzUFLOi1OBPJONpzZ5B78jBKOJ23kithiSutF55DUFjbmp6hMfm03cD+g/PRnkRvS6MY9l/va5vsXpMNZzs0FdhZBUiDIfg==
Received: from BLAPR03CA0160.namprd03.prod.outlook.com (2603:10b6:208:32f::25)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 12:55:44 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::1d) by BLAPR03CA0160.outlook.office365.com
 (2603:10b6:208:32f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 12:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:55:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 04/13] net/mlx5: LAG, replace peer count check with direct peer lookup
Date: Wed, 27 May 2026 15:54:18 +0300
Message-ID: <20260527125427.385976-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b266b51-02ca-4e64-40c5-08debbef4406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	dOG42C6G70/8hdn68c+V25lfn8ujselU6h3n7psMrXDw7qpliyySg+PSCLYF6ZG80J9sZF9sn3ct5tdKKu/iHvv+Czr7v6DMvoDFGKv54BCeInDR6QrT023fS4107vRawZNtObyRg4nWOQOoiWLs0QflO1L9TE1cvRUnq0VhYLmx224rA5rTfI4nrUdnlq/UvDiaRIgYbg4xUUH59yjeXEImAg4AxSvBbyto8qpwFf4cZEFPA0XtlUYPYzAJeW1pY0zHE6N9cuPW5Ht06XNhPrMTTPWLr+VER/BKX093nJ+wfplJ80ipqt9Aq8fSJN4SFhOJwBngoAXcQwjQxmi4q4iMtivdeqqiNpvpjkTnNNkqXkEeJCRHM1HwLQgEshDLLf2lsGH/zzXmgkOIj4oEx7EzxjFLqWzauVeHkPlpJjQa1WqNnbVumeB0JH9aPPFOhl+mjr4gyQXroimM9L8ufTS3vCi157EdpRS/QzHPFAeQ7PwMcm5P+jt6jyg/F6lp2b2KZBtRnRFE8TE4AOm4EoQsN8TY1D98VMJvBZjz1aAA5+1nEkb4d+3d/zmv+/7gcDDJ3BVaVbtLWO058eewNIejsl3knhQaRppuMoRATKr44CRGF5n928RXl5ik01iHx8VszbD7EkEk96iOsL0utGU5SvofJ6SvVs6GHfbRbfcFASsKWTMa1883Om3q6BjRfzDROO5BuegH8/YptLiMBryK/KkMOy3PEVQc+PxeOrw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iQGyqBnDWIMyG1lmO9YGC4kIDsyj7x4aEu/2+UtsXUVwMyWFs7eJLQQvKlWfzT1ekzfr4bFXfhjyOpQzwb/L/oCBtTaJu3asnc46qHdBRh9B0HY/xXCYHXFP+xTf+XbMy0KASBikM079OzywrdCf4483kNnvlEWUQGQN/6ew+/lETnpjWag1Fc6pR+4RmoF9kGyUPYt0aaxVGcGvU/eNMAJes6KVRyQvhCLUYKpAbv/x1MP4nCqrSVAvInyQOuutiUaGMeAfyznhIUDUWyTEe6Ymm/X0MiSWw8n/4jsW43pYg/vQmyIe9A3Xzs3IfYVDcF5basxlK59Qn6sUAqadkV2JGraZ56ZY7DvAm+jJswJMT16j3eaI3EsTkC+kYKU7ntrHPEx6/862BLzfg7gf0BSUOXreDvLEwq+hMR66BS1sEWl1nWg+IbPAdSs774J6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:55:44.4069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b266b51-02ca-4e64-40c5-08debbef4406
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21355-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 450D25E491C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Replace mlx5_eswitch_get_npeers() count-based check with a new
mlx5_eswitch_is_peer() function that directly verifies the peer
relationship between two eswitches.

This change prepares for SD LAG support, which is a virtual LAG that
does not have num_lag_ports capability and cannot use the count-based
peer validation.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h   | 11 ++---------
 .../mellanox/mlx5/core/eswitch_offloads.c       | 12 ++++++++++++
 .../mellanox/mlx5/core/lag/shared_fdb.c         | 17 +++++++----------
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8a94c38f8566..94a530d19828 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -955,6 +955,8 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
 int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
+bool mlx5_eswitch_is_peer(struct mlx5_eswitch *esw,
+			  struct mlx5_eswitch *peer_esw);
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev, bool from_fdb);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
@@ -970,13 +972,6 @@ static inline int mlx5_eswitch_num_vfs(struct mlx5_eswitch *esw)
 	return 0;
 }
 
-static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw)
-{
-	if (mlx5_esw_allowed(esw))
-		return esw->num_peers;
-	return 0;
-}
-
 static inline struct mlx5_flow_table *
 mlx5_eswitch_get_slow_fdb(struct mlx5_eswitch *esw)
 {
@@ -1058,8 +1053,6 @@ static inline void
 mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					 struct mlx5_eswitch *slave_esw) {}
 
-static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw) { return 0; }
-
 static inline int
 mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d9683d3ea0e7..d65f30bb2f80 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3296,6 +3296,18 @@ static int mlx5_esw_offloads_set_ns_peer(struct mlx5_eswitch *esw,
 	return 0;
 }
 
+bool mlx5_eswitch_is_peer(struct mlx5_eswitch *esw,
+			  struct mlx5_eswitch *peer_esw)
+{
+	u16 peer_esw_i;
+
+	if (!mlx5_esw_allowed(esw) || !mlx5_esw_allowed(peer_esw))
+		return false;
+
+	peer_esw_i = MLX5_CAP_GEN(peer_esw->dev, vhca_id);
+	return !!xa_load(&esw->paired, peer_esw_i);
+}
+
 static int mlx5_esw_offloads_devcom_event(int event,
 					  void *my_data,
 					  void *event_data)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
index e5b8e9f1e6fd..b5cbe3409720 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -10,7 +10,7 @@
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev;
+	struct mlx5_core_dev *dev0, *dev;
 	bool ret = false;
 	int idx;
 	int i;
@@ -19,6 +19,7 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 	if (idx < 0)
 		return false;
 
+	dev0 = mlx5_lag_pf(ldev, idx)->dev;
 	mlx5_ldev_for_each(i, 0, ldev) {
 		if (i == idx)
 			continue;
@@ -27,19 +28,15 @@ bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
 		    MLX5_CAP_GEN(dev, lag_native_fdb_selection) &&
 		    MLX5_CAP_ESW(dev, root_ft_on_other_esw) &&
-		    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
-		    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
+		    mlx5_eswitch_is_peer(dev0->priv.eswitch, dev->priv.eswitch))
 			continue;
 		return false;
 	}
 
-	dev = mlx5_lag_pf(ldev, idx)->dev;
-	if (is_mdev_switchdev_mode(dev) &&
-	    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
-	    mlx5_esw_offloads_devcom_is_ready(dev->priv.eswitch) &&
-	    MLX5_CAP_ESW(dev, esw_shared_ingress_acl) &&
-	    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
-	    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
+	if (is_mdev_switchdev_mode(dev0) &&
+	    mlx5_eswitch_vport_match_metadata_enabled(dev0->priv.eswitch) &&
+	    mlx5_esw_offloads_devcom_is_ready(dev0->priv.eswitch) &&
+	    MLX5_CAP_ESW(dev0, esw_shared_ingress_acl))
 		ret = true;
 
 	return ret;
-- 
2.44.0


