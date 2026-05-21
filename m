Return-Path: <linux-rdma+bounces-21096-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIFRFbfoDmqmDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21096-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:12:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA385A3CC9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8338D304252B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992F3BD653;
	Thu, 21 May 2026 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TbN7Ptyc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2933BCD1D;
	Thu, 21 May 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361922; cv=fail; b=Ihyx64t24Wu0rpCp5qfyJ/rLCuJ7zdKxCaviKzC90bA3D0AsnkASKcTsAKKNHOixwczLXXORGWnY5cBqWI++3ctBp4+OfANqNKbpn8FxfGuOYhGMOTB/HKq+ilIO6dkGr1mZ7bM3sXxTdzyvZL15UvaWm88OUX+w6lMWVHh/sfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361922; c=relaxed/simple;
	bh=WOMj/f9JCXPNKJoKiJYlAEBzTlcPbCuygy1kGsFDVWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTUruCzIEfiYKN/Goe5WZMasuvC3RzS4vvMI3t5hRwa9twFgcD5CRBHwL5fSDZdkJvIFFX+xWha+vCPtiW+b6dFduaLnOdwlzeCzu4Kj6ruEzZ1uBtJ+7aE7eGc/ck7G99y5BRYLQyzhTQ3TdVMWIkVzKynadoCznv6ILVRTbmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TbN7Ptyc; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKQgwxakd7HOJrbGBKl8KPr+yx2GOOBp9Q047MMewpz1H1NdSY5iFSzuphCr2n2HoXwr8nx0XdIW1LgNTl6gaNmPbdlYwTXNvMDxAJFGXj8wZvTfYMR30VDmfXjmiaRkAI03R1vjrswsGsmDXN4z2S1noRQPDi+HO2Y0bCYvYsbocmyJ7V5JY/DLlx04Ijt1RObfKNTO4xG9c5g1bB+Fr+5W1tD1h30XQ+V5m4EcMDtmC7DAKpNosqwZ03lq+Ue+KGuS06hDRjAYWiqsPHjtxbJGKj5bn0cJ/YPT4ALTnDy06OXQ7MEDw6CC4tuDaMre13b9OKMTC2IONHvi3ZdYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ31n39s0epIrJBPqYP8TWqfuDhHup9KgpAHvTzQr0U=;
 b=bUOAjxtT9VlKoWiM5bNsj8+zvR6be4/wiqDLvgkOp7sg9oR6Gw5g6C10emQVbzRZFfXDXQM/o/TPrcd0uXMiC7EfDyvwlN5J/WUmPHYCt/so5PVjuGGaIsmo1R2XD4j68RHyTx/gmRTf03qsFxTOPqCKQwDcGFX3NC35juixXSAEFnIULie3/puQofgmRWYLKZDL3GUu7AZ/P+Yxomk30eAOEuDN9FieWF4a5Ac1m380tEpWGx44hKWXgQS0HcyrDnvYQ+iRiW68w+J0omP2xktgWqtzTU3yyt+p1ZlRdaywecbfa6ukATR8gnyy1Y7Gy5iUwYe+IFyWf9Es2hSneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ31n39s0epIrJBPqYP8TWqfuDhHup9KgpAHvTzQr0U=;
 b=TbN7PtycyO6vI30rvsjGu4zRiRQF2nNug2WOa1P13cwruSNuhuiQPfVQ/LLkQAuT8Rm2BoukJ2cOVy3dCrm+HQKnpKUdLv1feqbsamP1wPP/op5d88369UlRrpTgZV6/e73yUFFiIVcjzYWz8rm/ooNXhsT1nsSHuEpi2+upbH5Rtt/WNvwvd6FeR36zu5oRP+OR1vplLfCTWAAoZ7nya/hL1nzJAVNoRUbhOZig8D26jIV+uuRNcclra93mKh4p+XL23qqYWnPTwgiLdT6vo/ljH3JBc6yc6aq6EBU9vfFrfspwu8TKA+sqnN9IQ28wzbjIr+hP7zOBBd6NiHhQnw==
Received: from BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:11:40 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::ef) by BLAPR03CA0047.outlook.office365.com
 (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Thu, 21
 May 2026 11:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:11:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:17 -0700
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
Subject: [PATCH net-next 01/12] net/mlx5: Add satellite PF vport support
Date: Thu, 21 May 2026 14:08:32 +0300
Message-ID: <20260521110843.367329-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: aae04c9b-9123-47a2-24a9-08deb729bba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|3023799007|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	b/e4aC5E0k6ZZxpNooZlY8mxJTl9Z4JhgyzTU5RNFwdgJMktrSc8QRqBQMyxD2s/wD/s1sylvQDqwIe2xnLFAdAKocgSgIxdQ+uM13fAUUCI9UX1Au+P+CGFDKls2iy4+OD0OCjvcP2IngBDk+wxXOB2eBR3vA481Xyk8VHXPGWWkB4JS3TSTTUDeXkYN0MLWA04fXsDKkU2+gdOzzqt4dfcFw5b/WTuuRT55UR474pqa1MzNMxcjkK4LiOhnP98x7hhAclnXXXpuBZiZ/zR/G4gTLpb07TIwnJ1tlDxiLZ5LLPf4gTXOSfoYR1eRLRNstdb+AYxW4lV2gDxiuPFllnJBdM0qVXLcvNipPZ4vJ0CPyT2ETOkbl12ZAgcqBE7wkSsB/KvqIDfLNfjqDOHzTTuVzRvnjEgCb/szIv+lEZAY9Y/W7UQs6QX+2H1DTU8Xtm7bt1XsMj0nxvxkjKwJQy08X2EbCotIy1H4PHyjxwPQVGj3/dE0ILqa4e77/NB/EpCRPBWwTHKPzDbsMfnoTpLZGVIxw5Hct65Hkjg573EVCx+m/wk9DgfLP4S5NsyqjV0kFa1VyCI0YeDK9kfo/IuSfE+zO6AAQuN7+bFkhkVY8SBPY1wvAXZULZ1q0zMxvhNwcjQku/nyiN2Vy7pqDGkvXR+zLsr8XIGe1rQIMk2MUQeQMHi8xnCblqHXVQmUdHXbhYgLPOXxZsiXljM2E2CTSH9blx8rjLTRR33n3A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+Zgip+mCkB/hqil3PaQJEhsgPqK4m/AnvQbxq6ohx3K3xJC7F5eQnu9FS5aCgdHK9FgwKmNxFmrLHI5TcuXop/qU+txsc89S5/n1Jc8uqYOLDE5UML8rcbOvI3/rgLe/17044RJ05eEaYfw0sebVUUwJKDPfaw450d01N5TceC7ygARZTFlovSX7TkCq0MRiisS3hoe2/F3OvanZR1UOlPvJcEvi8UYGX7TRAs+Hf4W/Mpl7nx7A0Wd9HganMZ7xYDJIHqepstr2szFv4hnX1YsmWT1lMEEJruWXwicp2frUJcQzFgGOywWOrgSnGMCDAejevNt+KXM+g5HeXk7Fw5XFq9dtvp2O32JCxvAVKX0G1TVZ/igu6Q3P1BIu1EMejgU8xuTS9KGtXIx44EgaMqdWkRssDUakm7rJwlGff9I7V01CofJ/LYur0IO4ohO1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:11:40.0375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae04c9b-9123-47a2-24a9-08deb729bba1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
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
	TAGGED_FROM(0.00)[bounces-21096-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EDA385A3CC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Discover satellite PFs from query_esw_functions output and allocate
eswitch vports for them. For each satellite PF, create a vport via the
CREATE_ESW_VPORT command using its vhca_id and allocate it in the
eswitch vport table.

When enabling switchdev mode, the ECPF acting as the eswitch manager
activates each satellite PF with enable_hca, loads its vport and adds
a representor. Since satellite PF devlink ports are registered in a
later patch, guard mlx5_esw_offloads_devlink_port() against vports
with no devlink port to avoid NULL dereference during representor
attach.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/adj_vport.c        |   6 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   7 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 159 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  10 ++
 4 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
index 250af09b5af2..ca249b50f830 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -23,7 +23,7 @@ int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev, u16 vport,
 	return mlx5_cmd_exec_in(dev, modify_vport_state, in);
 }
 
-static void mlx5_esw_destroy_esw_vport(struct mlx5_core_dev *dev, u16 vport)
+void mlx5_esw_destroy_esw_vport(struct mlx5_core_dev *dev, u16 vport)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_esw_vport_in)] = {};
 
@@ -34,8 +34,8 @@ static void mlx5_esw_destroy_esw_vport(struct mlx5_core_dev *dev, u16 vport)
 	mlx5_cmd_exec_in(dev, destroy_esw_vport, in);
 }
 
-static int mlx5_esw_create_esw_vport(struct mlx5_core_dev *dev, u16 vhca_id,
-				     u16 *vport_num)
+int mlx5_esw_create_esw_vport(struct mlx5_core_dev *dev, u16 vhca_id,
+			      u16 *vport_num)
 {
 	u32 out[MLX5_ST_SZ_DW(create_esw_vport_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(create_esw_vport_in)] = {};
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 8a79764345e7..0730f0c883fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -253,5 +253,10 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 	struct mlx5_vport *vport;
 
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	return IS_ERR(vport) ? ERR_CAST(vport) : &vport->dl_port->dl_port;
+	if (IS_ERR(vport))
+		return ERR_CAST(vport);
+	if (!vport->dl_port)
+		return ERR_PTR(-ENODEV);
+
+	return &vport->dl_port->dl_port;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 206911817a04..e75925a99852 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1517,8 +1517,11 @@ int
 mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 				 enum mlx5_eswitch_vport_event enabled_events)
 {
+	struct mlx5_esw_functions *esw_funcs = &esw->esw_funcs;
 	bool pf_needed;
+	u16 vport_num;
 	int ret;
+	int i;
 
 	pf_needed = mlx5_core_is_ecpf_esw_manager(esw->dev) ||
 		    esw->mode == MLX5_ESWITCH_LEGACY;
@@ -1548,14 +1551,14 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 	/* Enable ECVF vports */
 	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
 		ret = mlx5_eswitch_load_ec_vf_vports(esw,
-						     esw->esw_funcs.num_ec_vfs,
+						     esw_funcs->num_ec_vfs,
 						     enabled_events);
 		if (ret)
 			goto ec_vf_err;
 	}
 
 	/* Enable VF vports */
-	ret = mlx5_eswitch_load_vf_vports(esw, esw->esw_funcs.num_vfs,
+	ret = mlx5_eswitch_load_vf_vports(esw, esw_funcs->num_vfs,
 					  enabled_events);
 	if (ret)
 		goto vf_err;
@@ -1565,13 +1568,36 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 	if (ret)
 		goto unload_vf_vports;
 
+	/* Enable satellite PF vports */
+	for (i = 0; i < esw_funcs->num_spfs; i++) {
+		vport_num = esw_funcs->spfs[i].vport_num;
+
+		ret = mlx5_eswitch_load_pf_vf_vport(esw, vport_num,
+						    enabled_events);
+		if (ret)
+			goto spf_err;
+
+		ret = mlx5_esw_pf_enable_hca(esw->dev, vport_num);
+		if (ret) {
+			mlx5_eswitch_unload_pf_vf_vport(esw, vport_num);
+			goto spf_err;
+		}
+	}
+
 	return 0;
 
+spf_err:
+	while (i-- > 0) {
+		vport_num = esw_funcs->spfs[i].vport_num;
+		mlx5_esw_pf_disable_hca(esw->dev, vport_num);
+		mlx5_eswitch_unload_pf_vf_vport(esw, vport_num);
+	}
+	mlx5_eswitch_unload_adj_vf_vports(esw);
 unload_vf_vports:
-	mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
+	mlx5_eswitch_unload_vf_vports(esw, esw_funcs->num_vfs);
 vf_err:
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
-		mlx5_eswitch_unload_ec_vf_vports(esw, esw->esw_funcs.num_ec_vfs);
+		mlx5_eswitch_unload_ec_vf_vports(esw, esw_funcs->num_ec_vfs);
 ec_vf_err:
 	if (mlx5_ecpf_vport_exists(esw->dev))
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
@@ -1589,13 +1615,22 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
  */
 void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 {
+	struct mlx5_esw_functions *esw_funcs = &esw->esw_funcs;
+	u16 vport_num;
+	int i;
+
+	for (i = 0; i < esw_funcs->num_spfs; i++) {
+		vport_num = esw_funcs->spfs[i].vport_num;
+		mlx5_esw_pf_disable_hca(esw->dev, vport_num);
+		mlx5_eswitch_unload_pf_vf_vport(esw, vport_num);
+	}
+
 	mlx5_eswitch_unload_adj_vf_vports(esw);
 
-	mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
+	mlx5_eswitch_unload_vf_vports(esw, esw_funcs->num_vfs);
 
 	if (mlx5_core_ec_sriov_enabled(esw->dev))
-		mlx5_eswitch_unload_ec_vf_vports(esw,
-						 esw->esw_funcs.num_ec_vfs);
+		mlx5_eswitch_unload_ec_vf_vports(esw, esw_funcs->num_ec_vfs);
 
 	if (mlx5_ecpf_vport_exists(esw->dev)) {
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
@@ -2065,11 +2100,105 @@ void mlx5_esw_vport_free(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 	kfree(vport);
 }
 
+static void mlx5_esw_spfs_cleanup(struct mlx5_eswitch *esw)
+{
+	struct mlx5_esw_functions *esw_funcs = &esw->esw_funcs;
+	int i;
+
+	for (i = 0; i < esw_funcs->num_spfs; i++)
+		mlx5_esw_destroy_esw_vport(esw->dev,
+					   esw_funcs->spfs[i].vport_num);
+
+	kfree(esw_funcs->spfs);
+	esw_funcs->spfs = NULL;
+	esw_funcs->num_spfs = 0;
+}
+
+static int mlx5_esw_spfs_init(struct mlx5_eswitch *esw)
+{
+	struct mlx5_esw_functions *esw_funcs = &esw->esw_funcs;
+	struct mlx5_core_dev *dev = esw->dev;
+	int num_entries;
+	const u8 *entry;
+	const u32 *out;
+	int err = 0;
+	int pf_type;
+	u16 vhca_id;
+	int i;
+
+	if (!MLX5_CAP_GEN(dev, query_host_net_function_v1))
+		return 0;
+
+	out = mlx5_esw_query_functions(dev);
+	if (IS_ERR(out))
+		return PTR_ERR(out);
+
+	num_entries = MLX5_GET(query_esw_functions_out, out, net_function_num);
+	if (!num_entries)
+		goto out_free;
+
+	esw_funcs->spfs = kcalloc(num_entries, sizeof(*esw_funcs->spfs),
+				  GFP_KERNEL);
+	if (!esw_funcs->spfs) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	entry = MLX5_ADDR_OF(query_esw_functions_out, out, net_function_params);
+
+	for (i = 0; i < num_entries; i++) {
+		u16 vport_num;
+
+		pf_type = MLX5_GET(network_function_params, entry, pci_pf_type);
+		if (pf_type != MLX5_PCI_PF_TYPE_SATELLITE_PF) {
+			entry += MLX5_UN_SZ_BYTES(net_function_params);
+			continue;
+		}
+
+		if (!MLX5_GET(network_function_params, entry,
+			      esw_vport_manual)) {
+			esw_warn(dev, "Satellite PF without esw_vport_manual is not supported\n");
+			entry += MLX5_UN_SZ_BYTES(net_function_params);
+			continue;
+		}
+
+		vhca_id = MLX5_GET(network_function_params, entry, vhca_id);
+
+		err = mlx5_esw_create_esw_vport(dev, vhca_id, &vport_num);
+		if (err) {
+			esw_warn(dev, "Failed to create satellite PF vport for vhca_id 0x%x, err %d\n",
+				 vhca_id, err);
+			goto spfs_cleanup;
+		}
+
+		esw_funcs->spfs[esw_funcs->num_spfs].vport_num = vport_num;
+		esw_funcs->spfs[esw_funcs->num_spfs].vhca_id = vhca_id;
+		esw_funcs->num_spfs++;
+
+		entry += MLX5_UN_SZ_BYTES(net_function_params);
+	}
+
+	if (!esw_funcs->num_spfs) {
+		kfree(esw_funcs->spfs);
+		esw_funcs->spfs = NULL;
+	}
+
+	kvfree(out);
+	return 0;
+
+spfs_cleanup:
+	mlx5_esw_spfs_cleanup(esw);
+out_free:
+	kvfree(out);
+	return err;
+}
+
 static void mlx5_esw_vports_cleanup(struct mlx5_eswitch *esw)
 {
 	struct mlx5_vport *vport;
 	unsigned long i;
 
+	mlx5_esw_spfs_cleanup(esw);
 	mlx5_esw_for_each_vport(esw, i, vport)
 		mlx5_esw_vport_free(esw, vport);
 	xa_destroy(&esw->vports);
@@ -2123,6 +2252,22 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 		idx++;
 	}
 
+	err = mlx5_esw_spfs_init(esw);
+	if (err)
+		goto err;
+
+	for (i = 0; i < esw->esw_funcs.num_spfs; i++) {
+		struct mlx5_vport *vport;
+		u16 vport_num;
+
+		vport_num = esw->esw_funcs.spfs[i].vport_num;
+		err = mlx5_esw_vport_alloc(esw, idx++, vport_num);
+		if (err)
+			goto err;
+		vport = mlx5_eswitch_get_vport(esw, vport_num);
+		vport->vhca_id = esw->esw_funcs.spfs[i].vhca_id;
+	}
+
 	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
 		int ec_vf_base_num = mlx5_core_ec_vf_vport_base(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a5f832ed2251..19419799a26d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -349,11 +349,18 @@ struct mlx5_host_work {
 	void (*func)(struct mlx5_eswitch *esw);
 };
 
+struct mlx5_esw_spf {
+	u16 vport_num;
+	u16 vhca_id;
+};
+
 struct mlx5_esw_functions {
 	struct mlx5_nb		nb;
 	bool			host_funcs_disabled;
 	u16			num_vfs;
 	u16			num_ec_vfs;
+	struct mlx5_esw_spf	*spfs;
+	int			num_spfs;
 };
 
 enum {
@@ -666,6 +673,9 @@ void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw);
 void mlx5_esw_adjacent_vhcas_cleanup(struct mlx5_eswitch *esw);
 int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev, u16 vport,
 			      bool connect);
+int mlx5_esw_create_esw_vport(struct mlx5_core_dev *dev, u16 vhca_id,
+			      u16 *vport_num);
+void mlx5_esw_destroy_esw_vport(struct mlx5_core_dev *dev, u16 vport);
 
 #define MLX5_DEBUG_ESWITCH_MASK BIT(3)
 
-- 
2.44.0


