Return-Path: <linux-rdma+bounces-19827-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JQAEqgr9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19827-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:27:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF944AA535
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C400C30861E8
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777530FC21;
	Fri,  1 May 2026 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="julTlREs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7B2FD1B5;
	Fri,  1 May 2026 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609110; cv=fail; b=nxtWGcLxaR7lOIHAqvYPICE3BwyDKEpyt4Qqj943ZNEjE7N1/eTquHW9IjU/BZPJ0/BiwQkD1ExhTXh38uCfTS7sCdqYHSsJAmqlu2BhYGI1cmuwrlJzza/yhBF20cIwjs1BQgeE9vf7yYpfYC6uPXYgaWOJgU/Je4kz2M8kQpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609110; c=relaxed/simple;
	bh=iBgOJhsoF/XdffJ+Ih/otQhgNbJuqaASCkQMyD4wAKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfpFX84BN6aL821LSu3LxD8qKDVqIkMeUH5n2scG6zKBvUBFkqRpXY1WoBIEHYHQW+PN9Vrqnau4gVJ8oxpM+HVLh7Fv8SiGE4QEJAQffV0Q0L+O+zTHaiJsXY4IHb+Mpnk301jvGpOSjb7VMw9jDapwxGsrquNW6TbBbpIzNHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=julTlREs; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXURPX01MHU2J9ayn2bS8bWg29/gsL6nukrOoH/25m8pZsv+LEMEMob4cm9BJVh+oVjgVSU+EGcyV7XJUT2dprj91m5Kn4qWUE2oZffvUgtfAKumeYY0IVmR8fzBPm1b2KG/AOlc2CJ1sPslD2f6yjdU5Ad5lB2DxvytLJtjKqEWdIJrbt2OTlmn/4Tv3p2TofRih8Wq3rUbOw2SHi7RgZRQsviajqBPPio0Ca/lv+laZOlikcXiiNoOf3JJ1BPLP3g39Z/N0QbYdnlnemhju093EyPRJ02a27KRjfSelibrbufPA2O7TspKjWXspdzjbJHSgIJiTDV3svrhUpWACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/2dFiuZh4y4sV8OX0bU27/kv47tWg3tYnbtUUS2Zh4=;
 b=f5WIEHfNO7xDXLgHeDpiwiMaTn2M8otN7xoCUM2hZzRj9H7J85QJ1OWLpkPCisjDdMuHyBBfaLzDttk9jwtKqWyZcY3sXMqFazln6AUDIy/HZS12zfFubNEktGv7YZxcdNsho/z4yyv4SrQmGaNzzoTcEzSUqXQbOVepf/p7aLt0jTwrATObFV1IFnClw8ZAFAVQ2YAdR4yXqOrBzgyLg6Y1qHTp+W+0WQcH4A1UcbEqg9NwiKSvo3pejJv5VMVDs/IGHCU+WV0q6cmbww35tMcCtP+GHyoz2bLNW+qgfuXxcaQ7L8x6I8CSNNSr2LaetnjmMSJTGhax4j5+TRbBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/2dFiuZh4y4sV8OX0bU27/kv47tWg3tYnbtUUS2Zh4=;
 b=julTlREslz7jML+UQTwoYM/7QzcxtpvX9Y38o+CZTd5pTrsaYwdV2rsXqgSBgyUIRG4ERcV3llmJKTcIvApB/cvJiASymLCQdpwJvQHyzPiN7QQp9mnVrO6yBHwPOsJ8KT2sC8gSl9DCJ/nWfuGP96lha0iFmQGq2Bo8719cCYiVzHEavYJO61OzlNr0qvTx8ACJnXgqvbSMKrsnve9vvZNC902YVbrV7UQGAOhmYJy5WtySGUsWirFbNCNN95ngJBbyRw8zM+Mmhqfl6gsmptTQI2AFUAfnvzLBqZ0hGFW1GNXkJCSZ9hXbmmxrhemz98g4aFRQkfDQYXhlUkzxhQ==
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 04:18:22 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::13) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Fri,
 1 May 2026 04:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:18:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:18:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:18:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:17:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Gerd Bayer
	<gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 6/7] net/mlx5: E-switch, load reps via work queue after registration
Date: Fri, 1 May 2026 07:16:32 +0300
Message-ID: <20260501041633.231662-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501041633.231662-1-tariqt@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa39089-19b6-4713-e490-08dea738aeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yTNCBpfpK48xnl3gMXzrJ9D8Adt/QKvwvdhi/BnAoqLZcYLdMXKDXATBQqN8/S2MZYx62yDiYQJGSsQIl0hITkm89FwaNUKchjU0Hf2BHC88jC3vOZGCQf4EydxTE4KE+8rgbWokw2WSBQwAq7qTkpcLjFB5teQ/zIl95uqH9dR3tAo0POo9Lo3VMNFZ0RfF+mILwwF/FYHLossaIZMXvEiN4bJXykzhKC6qU803uyJEIQdphfqJqlDbXLwRWeHjTXo9gvffdnVSJnV3pe3MXnXK7q/U3GdOalR4/pKcGxge/NECgd17ltJtuPpwAqE3d66VDmuUYGjf7RiGZ/9UBUMGDGAnYbZBvyxJFeRtPNN9xSxcLjgPMda17H7CgnXIzlH1k+msW0YdbCUb9HHkycB96EC7Y+8dOL70kJRnmzMm+XCKiKjVpvjeTb4JecFGlflJ/TWzIumpGvSikTm0fi9fS0AbxCribKa2GQDju4tiWuzbSMfafbds0PzKvR08jBEGKgPnlKTcLSYxoiLC6o0HK92GwbnNn/OLXyyOlIoQujOKOLfrYBW54CmRMZPXj6VS2x1JMtMwYpPn1tt0x8iqnoRpIBJ/gFe9B6n77mc0I4J+fWwS7yT6Zg16W87Lja4It7jwxS9ubUQgWmbB0O772c/vIrft1XAQDbeZJZKnAUUNOhXenXy7VTJwVg279T3kS6crp1gjMPzn9ZBgR2WVR1YhE47dXlPzx9AkcG0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+iKBh3GekNDAC3W5QUHk+h7lX5sVSug7k8LAabxW7h3L470Tjl3X+h3L9Bj/n+5A0jyFXzdOK8lIES5+gBkGcb/n2sW2mZTBHKpMEesz3Zv8l8M9Uez5Fib7jqckaX/8kRFOeL5fRLiwIvJhWSYQIilHq1O/dUAwx4FFwI/6MlW0reEImL0vFRjniyXIODy6ZnTNokaxd52asTeqiYfS2VWpTPz8DbE3vL64XoqoTCx9vbFZB5/ACAs/L+WRrhmOLRlE6VkueRhB0+NobY2SAKZyL0zPfkRnEFut5ZI8zp96j7tPHAcfRTZDQzcCpcYD8d6Yyqqr4bZL2Ym7dzKd/7J6+JOEE4uKvcBZFCOCaDgokq1dbAd4hAY5pJCTTTc9hU+8NHKiHJSohoMrrMZ1jVRIqfvPIHCV8kNLecM9W5znuax0hSoTJqhG5d+sFLbC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:18:22.2456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa39089-19b6-4713-e490-08dea738aeb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
X-Rspamd-Queue-Id: DAF944AA535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19827-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

mlx5_eswitch_register_vport_reps() only installs representor callbacks and
marks the rep type as registered. If the E-Switch is already in switchdev
mode, the newly registered rep type must then be loaded for already enabled
vports.

That load path needs to run under the devlink lock, which is not held by
the auxiliary driver registration context. Queue the reload to the E-Switch
workqueue, whose handler acquires the devlink lock, and load the relevant
representors from there.

The unregister path is unchanged and still unloads representors
synchronously while tearing down the registered callbacks.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 8f656253981b..f26d1652dd05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4563,6 +4563,38 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
 	}
 }
 
+static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
+		return;
+
+	if (mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK))
+		return;
+
+	mlx5_esw_for_each_vport(esw, i, vport) {
+		if (!vport)
+			continue;
+		if (!vport->enabled)
+			continue;
+		if (vport->vport == MLX5_VPORT_UPLINK)
+			continue;
+		if (!mlx5_eswitch_vport_has_rep(esw, vport->vport))
+			continue;
+
+		mlx5_esw_offloads_rep_load(esw, vport->vport);
+	}
+}
+
+static void mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+{
+	mlx5_esw_reps_block(esw);
+	mlx5_eswitch_reload_reps_blocked(esw);
+	mlx5_esw_reps_unblock(esw);
+}
+
 static void
 mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
 					const struct mlx5_eswitch_rep_ops *ops,
@@ -4574,6 +4606,8 @@ mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
 		mlx5_esw_reps_block(esw);
 	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
 	mlx5_esw_reps_unblock(esw);
+
+	mlx5_esw_add_work(esw, mlx5_eswitch_reload_reps);
 }
 
 void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
-- 
2.44.0


