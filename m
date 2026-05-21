Return-Path: <linux-rdma+bounces-21102-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNpzC8LpDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21102-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:17:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D945A3DA6
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EF1A306A905
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025363C379C;
	Thu, 21 May 2026 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqIsyyoR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04F3BFE33;
	Thu, 21 May 2026 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361964; cv=fail; b=oQQlWGNMcVVR6t2lHzNRtsGGR/u/aiG5u+jKScvQQwQ1ZXtgvOnuypV6JuEcMm6V+m1oJif3CTAKh4pY+InYJbwi3UyNtarVFHPSNbxYs0qu59CaWUAMiUZNX3zZC4zFbZli/metD9JuZODDGaIc8hitBEiP7bud7uFDnZ9N2N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361964; c=relaxed/simple;
	bh=xwlQnhfDirbmxkyLLk84nXOhoFqNp5RBnPlAuo25dPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qN0/uPeeHEu0bwzQ3PfmTGLGMEpYYWcd/rGlGGUAvnyz1Y4RlFrry6IR6IPj3eB5WyqcgOKW4V9Q6M0TkLulHfmp1QEsHrJ45pNrVZYQnUYoOfjrNupXzpYHYy/L8AOs/MQZnyQhzfLNmRuE2v6KRWPb6UHzE9AUmaMPYbm6+Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqIsyyoR; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4EgIq9zUhwLnuiZ/YKxH4E5BTd9TetTVSYp69FZdJ4FJFxqyczYsO6yVMzt8vqL3qYGQyasHxk+LTF3XqIlnicBfsmYiog/frrigYY51DtK+J4tAW8VQ+napHHuOCEtY03DHObfTcjMehGWbxjwk4e2VSMssi5yuSOJYVhtJNv1RvERi51NORch9ofm78HUaFbxuLGj90in1SC3Rw7Ywv+sWiXOq+U9yPw8jXBy58IaZfLfg/olxc6EEkFzFeLVkKly/Rd63wD2KUj1ofG2BKleXvnTOI0hZaKkfiYnf2aavEBHEZln6lRyf4Ok1ZB0/LOjhIdrHz3AzPOmFTtxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p6LgZHoVKL02lE5EmdufToJlYZ1oyN9d0v+E4NNYHk=;
 b=P+I7TIrT3ahJoRygFWOVU4Wn4mYMHzkZMLiWDdG+9aCKrpyvZw2XqTrLQRCRPxc5Mr2BvxWiK/v+G+6uaSw4lvE+PliI4CLvCOGgDLHQ6pCtGLmwt4W2pQVqTGJVhnEEI+6zfg62kT/kZwh1ZoOhEAZxvkKjXQ7C4cx38u1n3TOHjVX/IyOzVBLc+Jrj31t3ieDwP11oTeF0HFd8lPNPx+3DxYKjS1PdSqVtTpWoTPHiKqboRLcTMIhzOrfxlZbO3dBxiTfoWyEi12RykrBs8eYA4G1xPAiBYVLxJcRF5xUpK/uxoZv4OlK2bCMU+IFyo8tF9hWpsQnD1myEu+yAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p6LgZHoVKL02lE5EmdufToJlYZ1oyN9d0v+E4NNYHk=;
 b=bqIsyyoR5gyfman2I0+9qWMoUWlYn72OR42ygIQ9/YJRtidhTjtaaMN76nJ1iPYMd3/bYAt8Wu5kyebK4sT4IkY1qy1WYZu8jIkLoSimC1NGAioVWP0o5n8n0viO3zAMQpw/rt0x5uutePVgbeHIDL7eX0HOIGBpVjQ7z3To8Q93M02CfwdX41iiE8o2i0ui5/ws4wEwA8GF4MHmHVZk/Ak0uSUKZu/yaCQFdywNE5ojYAjQTbcxP5HZQHWXFpzENkRplxURB8Uye6oqx0x3t14T+f/LOrh1x89pLGH+vavKxLdJk9YwdRLWJ9VVXEr0w2eMDi11HUtlB2zYYV5LFA==
Received: from CH0PR03CA0322.namprd03.prod.outlook.com (2603:10b6:610:118::27)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:12:31 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::59) by CH0PR03CA0322.outlook.office365.com
 (2603:10b6:610:118::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:12:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Shay Drori <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Kees Cook
	<kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 08/12] net/mlx5: Register devlink ports for satellite PFs
Date: Thu, 21 May 2026 14:08:39 +0300
Message-ID: <20260521110843.367329-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260521110843.367329-1-tariqt@nvidia.com>
References: <20260521110843.367329-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e0b3cf-5a54-43a8-09b2-08deb729da32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700016|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	2yX6uDyDBLPpdE3xULneWjur5enAFs+ZWNegM0i/QmU2cuJZozfb5sjjV9YGcLy3es9erx2M0gydVzlbOVzNg25bUpexb+sKSMr6S+/7xeCniXxQ476uTLHHI5zgA6wsCD/aFZQd/hFWK9RD8IU+TvEj/YHtOWe7jKW5KePlllwjxU4YJ0pa5b0xyO3M8IoXpO7JxxyuPJPN2IL85SiHuqzQp93q/tozFSwF4BxPHfcoIu3Ce9lH31kcJovZzOaTFVOfonY6RwzCaMbAQ9qMHKT4kPiXFXMIuS9aMZgnE7J1Fwf79PmsHr7b6uUh+GhztsqlHGdrJa9Vg4Xe+SPcra8Y4dTgVgEAn2I6Q1PM7K5jbT/z3Mu8k2k62udgBxh3s3rWeMifMBd4hTlUqmVN29WYp4jj0WhLXdtdeNTrlsz4y1ZCdDEW4/kAV8O3gnvkY9cvjZ2tGujJa3166FG4gYqXRKbHoavtn+XGn5nTLT9b3XzwXc6dN+WJbYLCr8A3wbnPonfibQqTPQikwsJqiRWiSUneAjnNFz9zf1l/7BCInW3F6kSdG3Iinl6N+4ufNEP7bIiIaDMpFOcapKfPKAkr9rXhsJVXhNMQmxNLAdqnPFes5H2hjVm6cFWeJ0NGDWbDsIrAcNDJdnH2xmW/KorURNucGrWUIZl8eOzJOz0/H7n4qG9fitb2jYrVv+EsIqfx3Zqai45DFE5FqKwliDcLCUo6JN0L30UcE0SqOhs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700016)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SQj2LItuCVYVr4vkwSBGYh6eJYMsNaUeVYRRaQlQ1E5h28GYYHPbscuRJug1aDD2S3JvpxuvIs4DzaPeHtw0KL1q9OhHi3Lv0y6vwbEkvp7BSDnDLglBulOYR3CZsdKVOy4n2CehDwA62i7jQcScMq9EmqHiCv1YZCEOt9a6fTbH7CEsCVsKdIlmjZk15KRCUmHxJuGQAB00sE7qOan4TMerFwgNpaNsAFGK51anaavVNKAmHdjwGYaNQ4Jy+hV43ORCRutXhLyHUc8iQQCAlMZwdTpjh7XFRZm8bkUWETKRP1Oxa7N+H7WW6WDDrVT04C2JEnIBJ9DVeHYMvUNvECzb/fmunzIYJza4MN+QjrDyZjWqqQKho06S3rTDArvrkO/Nxl6VDlfjhBUpaYQiN3av9wHI18vOM7PajZlPZX452Tfg9b9ZPL5sjc2+MpAA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:31.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e0b3cf-5a54-43a8-09b2-08deb729da32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21102-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 00D945A3DA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Include satellite PFs in mlx5_eswitch_is_pf_vf_vport() so they receive
the standard PF/VF devlink port operations. Update
mlx5_esw_devlink_port_supported() and devlink port attribute setup to
register SPF devlink ports with controller number and PF number.

Add mlx5_esw_spf_vport_to_idx() to look up the SPF array index by vport
number, and mlx5_esw_is_spf_vport() boolean wrapper to identify
satellite PF vports.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     | 13 +++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index fddb108bcbff..05d89769b917 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -16,7 +16,8 @@ static bool mlx5_esw_devlink_port_supported(struct mlx5_eswitch *esw, u16 vport_
 	return (mlx5_core_is_ecpf(esw->dev) &&
 		vport_num == MLX5_VPORT_HOST_PF) ||
 	       mlx5_eswitch_is_vf_vport(esw, vport_num) ||
-	       mlx5_core_is_ec_vf_vport(esw->dev, vport_num);
+	       mlx5_core_is_ec_vf_vport(esw->dev, vport_num) ||
+	       mlx5_esw_is_spf_vport(esw, vport_num);
 }
 
 static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *esw,
@@ -64,6 +65,16 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_vf_set(dl_port, 0, pfnum,
 					      vport_num - base_vport, false);
+	} else if (mlx5_esw_is_spf_vport(esw, vport_num)) {
+		int spf_idx = mlx5_esw_spf_vport_to_idx(esw, vport_num);
+
+		controller_num = esw->esw_funcs.spfs[spf_idx].host_number + 1;
+		pfnum = esw->esw_funcs.spfs[spf_idx].pf_num;
+
+		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
+		dl_port->attrs.switch_id.id_len = ppid.id_len;
+		devlink_port_attrs_pci_pf_set(dl_port, controller_num, pfnum,
+					      true);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index f734f9364b2c..8bee014140b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2651,10 +2651,29 @@ bool mlx5_eswitch_is_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 	return mlx5_esw_check_port_type(esw, vport_num, MLX5_ESW_VPT_VF);
 }
 
+int mlx5_esw_spf_vport_to_idx(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	struct mlx5_esw_functions *esw_funcs = &esw->esw_funcs;
+	int i;
+
+	for (i = 0; i < esw_funcs->num_spfs; i++) {
+		if (esw_funcs->spfs[i].vport_num == vport_num)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+bool mlx5_esw_is_spf_vport(struct mlx5_eswitch *esw, u16 vport_num)
+{
+	return mlx5_esw_spf_vport_to_idx(esw, vport_num) >= 0;
+}
+
 bool mlx5_eswitch_is_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	return vport_num == MLX5_VPORT_HOST_PF ||
-		mlx5_eswitch_is_vf_vport(esw, vport_num);
+		mlx5_eswitch_is_vf_vport(esw, vport_num) ||
+		mlx5_esw_is_spf_vport(esw, vport_num);
 }
 
 bool mlx5_esw_is_sf_vport(struct mlx5_eswitch *esw, u16 vport_num)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index f85be8e39953..7da1a888aa7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -798,6 +798,8 @@ struct mlx5_vport *__must_check
 mlx5_eswitch_get_vport(struct mlx5_eswitch *esw, u16 vport_num);
 
 bool mlx5_eswitch_is_vf_vport(struct mlx5_eswitch *esw, u16 vport_num);
+int mlx5_esw_spf_vport_to_idx(struct mlx5_eswitch *esw, u16 vport_num);
+bool mlx5_esw_is_spf_vport(struct mlx5_eswitch *esw, u16 vport_num);
 bool mlx5_eswitch_is_pf_vf_vport(struct mlx5_eswitch *esw, u16 vport_num);
 bool mlx5_esw_is_sf_vport(struct mlx5_eswitch *esw, u16 vport_num);
 
-- 
2.44.0


