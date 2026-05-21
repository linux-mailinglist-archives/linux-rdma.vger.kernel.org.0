Return-Path: <linux-rdma+bounces-21106-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D3oDXfqDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21106-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:20:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154FD5A3E69
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A297130881C2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD543BBA1D;
	Thu, 21 May 2026 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SEtLeOBy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4203C4577;
	Thu, 21 May 2026 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361985; cv=fail; b=CbdKLWrh07QbAsH2rgWFDIei6Wf6J10GgSlLrf+TCPVTCLl4ylo/xH6Xew/r5n0J9dk+NjbJTtqyqtVY3IGmrdxxBDr6QUfYZZDeWrgUOkFiClBGPfr8JYsIvpLbFgakEHSWfvoAPaoetAl+vlGrkWKTNB5iweP9JhCd5ob2MsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361985; c=relaxed/simple;
	bh=bpmGFwQ8kFV5CIh8owODlOm87Yf6I0RkdTVBGvUDN/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EttuJvrlqNE/V79sw7C+NA/5g/IzBUitq/AxdP2sJ/OxwTKuTBMhX0pv+WF61bzYnh9+qZ+jop/sS8i+E67dpLUeH57wYtHl46rSYuJBt7FHQ47cYT0ltaQ3f9fE6FGryq3+ikSZ/Erl9m+MKLk6WgfC7n0gl3rMFa4nSbBf16w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SEtLeOBy; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIyj0YduavuZuG/WnpfWUtiTTvpZFkH5NdChwmOYiCLeWbcYjsSGisbWgPT1EZyCMe8YglA1aUF8BryBHdlGiXkoxQrxQugBNDa+KtB/kEv7kPBd5F0nz1lj09SZWUz8QQtnWZ8kIQqTOvw5hWhZRNJVfp7gLZ2fW7sm9lXo17AgwWRr0DV4C6v/kv+kzHn34vR20ruan/TBisSsul+mYB9PUAFd9/wtihOXb7KrO7EALcNjfP9LCSRMyNw3Ywq+kRJLRW2/9Lit1vRN2o7rZR08sJR/5LbNUG7s4bL2nG2haEokwW4nUDiJGnS0s23oywN3VDiFHCT6V7kxhfHzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9gP3FxRxnNSI6pJuEvdoGX7fMpABplYGCDS8nfAMow=;
 b=v4bCkkdy2HF4060uQdBe9pwsvPgeoSJG16qk+x9ApFx16AHFgj6whzuwtqtyCsW2v1O13HfVuCwgqNDf70mLt8AE/5VDaHl7isVunDHdgONqnpNRu+4LounV954GGU/dT6AlJIEoBsrMGijyeocHC7KNqlZrfTFB5g2lgr3La3H3IG6qnVXsPWqHELfEj2QsUb8DcAdcncy5ZXHJdV/GmKNg/CByBvYno+D74hLRynlD+Z6Wr2ysQjjgmg3ZKUbbEG29wcCMrf7ykbzLNNL/YchTo/um9yiyzLZmuvv7olIbH+Tmz9Di2DgTEhiLpRoLt/5BDKU3T0vQcN1TAh0ktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9gP3FxRxnNSI6pJuEvdoGX7fMpABplYGCDS8nfAMow=;
 b=SEtLeOByjDUOlBJiUfbudpxn8a8XjtPSgSgaJ5SoPHheaiUQe+ZfsFzKaSHZRzCSmMC1rPiXEpMXPKpGHrTR+0qoLHdDhi5pIEUWBGuAKSHtGNUuFeZYqh0r6LALUUBx/UJKIka+2V/fYwWS4xUA2nvXH6v+ggevVniSaVtR6ieX2KuKJqDFeoZoAvxLobtmsFeNBwY3DEqtoSY+OCaSDlB7Upr+9Hrf+BbL5zK5B7szgh9e/Yt2f/X+apbH6aFPRCiMlgCtD+cbnQ3x/vjjVXBOOtQufu4krFQdtABoQX3BliGzsfyfzJO8BRM819HnmxlclYkjyAAE+sQfqE3N5w==
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::984) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Thu, 21 May
 2026 11:12:51 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::b9) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:12:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:12:22 -0700
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
Subject: [PATCH net-next 11/12] net/mlx5: Add FDB peer miss rules for satellite PFs
Date: Thu, 21 May 2026 14:08:42 +0300
Message-ID: <20260521110843.367329-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be5823d-8fed-4d7f-106c-08deb729e32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|7416014|82310400026|56012099003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	A8MqFl5UEecu1E6N+vh8x9T7JZFxy2yimat/2CLok6tpWssj42r0DxVkICOMPgLpAdjsQBWTxxqrS0jH9aBBubtmmVWwJ/ociCFecwYg9XeDARfGq7Rb6eYB+/urazszArghDrvsbpt1io2v6u9mmiVrSgHI5YtYjIXdwQwRB6DG+I1Pfp0qoTYKZIG0K2fEjPkv2nw+YK0D+kdg5cs0O14CUr8HBOt4nzMiuKU01S/wU6hhY7VhoI0f9k9tK6luBU6wg8PHPddIblDGZM7gmou9DtNQWlOTWUOU1Qpcp6Ysb75Nx0svQvzfKWR/4xS76QPIR9Qm10dJb13sakSQHwjKJIDbVAZVe6wQK/xy9TDdfzbg1iq4mSSo08CRzde5y275HBiU4IY/b+0GMQPb/MEX6yhpCsDDB7QpzNy5D7dGmswaJIJnEMAJFTGNVRE5TvO43g4l+2IC4pNqC8oEBtTGy2tym4T6nesWSM+p1z8aiW1fADz4i5TLhy4Y9EXsVrkHLmiE1CjcngfFafoBKoEuQixI/CZ0MHK2MJoDmyKlAZYEeuW4pCIDFVCBAjq2/tNGPYYeXPAqB55Md0fM4V6ch8GdsV8wFUxw5GV/mSvjEDQL61cQPTG4xKUIOidsaBsHpV6lXw+Sm6c3bN6IsxWAEoIICvykVdyWrycEyFGhX4CUPRomc9eX5rclP+Uuy8j84FsOW+72hLDWmhAg3gq0UiXMSeXuh1awGyYzkKM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026)(56012099003)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kAdYx7Xo44IogNdxqLMFORsCE4yCWbM6lvzVAKvOUQhNMKZzZKe+6HP3RtOZ+UJitmcL1p+YVuxvR1hU4CNqBj8ymcXXrEBS3lcK3chwLnjkxkli7qFfVeULCXR22wTslGuje6e5hDezn4ElCRn7KI78/bbGR3NJJc+QzMIdotrIdLnr0+II6YoH+UxFgsWCCh96BYC3rmj/PhQCclq7KYQYCJU1yLbAcQCXULe6botOVM/TMfjyCPI9yRlB/IRIFZqrG6iLgY0qfB3ek49nThvrlebNAgig3rckvrWod+HloTCup3QUPusunQH43BYK4W6WKL7966da+mBzbLUnqejuJKVYcvqN6/4OfP4PVqObRJdeApXLI3QN6c2hmbl61HGf/3vIgtt9nQmuIhpst7OB/FGtj1TNP5fZHDl4Q3YwHe8yjw6cT1l3KEsyWJwL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:46.4194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be5823d-8fed-4d7f-106c-08deb729e32a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21106-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 154FD5A3E69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Add satellite PF (SPF) vports to the FDB peer miss rules flow.
Introduce mlx5_esw_for_each_spf_vport() macro to iterate SPF vports.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 10 +++++++++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 22 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 1d8e2486d518..c8d6c94a4475 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -790,6 +790,16 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw);
 			  MLX5_CAP_GEN_2((esw->dev), ec_vf_vport_base) +\
 			  (last) - 1)
 
+/* SPF vport numbers are not contiguous, iterate via the spfs array
+ * and look up each vport in the xarray.
+ */
+#define mlx5_esw_for_each_spf_vport(esw, index, vport)			\
+	for ((index) = 0;						\
+	     (index) < (esw)->esw_funcs.num_spfs &&			\
+	     ((vport) = xa_load(&(esw)->vports,				\
+		(esw)->esw_funcs.spfs[(index)].vport_num));		\
+	     (index)++)
+
 #define mlx5_esw_for_each_rep(esw, i, rep) \
 	xa_for_each(&((esw)->offloads.vport_reps), i, rep)
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 59446c444570..355d27934fb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1231,6 +1231,19 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		flows[peer_vport->index] = flow;
 	}
 
+	mlx5_esw_for_each_spf_vport(peer_esw, i, peer_vport) {
+		esw_set_peer_miss_rule_source_port(esw, peer_esw, spec,
+						   peer_vport->vport);
+
+		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
+					   spec, &flow_act, &dest, 1);
+		if (IS_ERR(flow)) {
+			err = PTR_ERR(flow);
+			goto add_ecpf_flow_err;
+		}
+		flows[peer_vport->index] = flow;
+	}
+
 	if (mlx5_ecpf_vport_exists(peer_dev)) {
 		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_ECPF);
 		MLX5_SET(fte_match_set_misc, misc, source_port, MLX5_VPORT_ECPF);
@@ -1299,7 +1312,11 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_ecpf_flow_err:
-
+	mlx5_esw_for_each_spf_vport(peer_esw, i, peer_vport) {
+		if (!flows[peer_vport->index])
+			continue;
+		mlx5_del_flow_rules(flows[peer_vport->index]);
+	}
 	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
 	    mlx5_esw_host_functions_enabled(peer_dev)) {
 		peer_vport = mlx5_eswitch_get_vport(peer_esw,
@@ -1343,6 +1360,9 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 
+	mlx5_esw_for_each_spf_vport(peer_esw, i, peer_vport)
+		mlx5_del_flow_rules(flows[peer_vport->index]);
+
 	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
 	    mlx5_esw_host_functions_enabled(peer_dev)) {
 		peer_vport = mlx5_eswitch_get_vport(peer_esw,
-- 
2.44.0


