Return-Path: <linux-rdma+bounces-17759-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JgyHFSVrmnRGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17759-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:39:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA252364B5
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 088EA3073F93
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925637A481;
	Mon,  9 Mar 2026 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bSkYKTrz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115323EA85;
	Mon,  9 Mar 2026 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048943; cv=fail; b=Q+QlMIo2Fl7nzQ4MRBm2woJht3q5fuQetgmf/zLq3fMW2HkmnppY+ABV9EHDrmKAp0wLphisEMiq0erETAkJo+jpXmi6qXCK1L5n2Qjsml0Gabeysfk4xjy7QcQQeIKlrAqERBu1Sk0lKBpc0V6JowM5YoDoBLu0zGNAX1O6yUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048943; c=relaxed/simple;
	bh=vlfJoTuMrz/wBXQUk/zy51j2Um4MagaKWw+ZjKc4hLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8XhOSF0FSMssSQK821LwfFdbD5vv34XzQWmvJG/vcggRe0qlUtC++Yn2ug4lIvUb7OinqZLKzKclld+PKlowtrYDlFwlpdknOpSmbZg1fh+DjQ0kt9+r0g6HKLAQ8H+HFcgBzMaqWcOGvvmw+/YqE+ms+av03Es8EV1HidOlCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bSkYKTrz; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0AX1beYdduQ2271o4EkzYB8UQ1akALrYvOaV2dAC0Lx99OIAtfowvf1G+oUqAenIl2c6eYcDmvAK3vMG9EvYOYA5VZNqkCK6M/ybSUbh6/ETR6Jcids8qvSUAWVM3Tkjk+CKckgJX9d1Bw0P5zSHpoojfskEASOFVr970WILSo+nvA+xpF2nMwlCpX8ZUCnajUxGDvNmoQ2IO98AOTnSVE+cv4x4t9kbU75KdMt+VgloLkweUVDio8yv4C16SosykCLufqPQS5GMyHpA8h8p0Bo0XseYCduvku371K2rFKa9HyXXAe4pNAhZ/Z7LzgUkwm5wPsV2PzkaavOSOatkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeT8h4IxrcirmcJ6rTVOm7j29W8WtHvw/Ia90iJdNBI=;
 b=QfDQ6bkkLkfOuzOgcFh2g42GeIAn5xSR6p6SSdMwSQWvK6MVyyBCBq4ts7pGmcs+2XrFcEXAQw6xlQCCFpiknFV3gccwf5sSWxbKhPXM9cERPEMO+DiPGJ3HhVZ5wBCDMK6t6k75RJgC0gH044fU9airK4WyNNzOsUCJirPxS4XgMsM6VtFfwGvxp7SLaAjo8IJKUSoTJf4JV/RDNsW9Rbueay4eY9oSXLjssBGZhHG/Gr187MmSGzHEa99cRWbDlmuYh20ZQeasgr8UFbmB8K5pPuGTLU/C3gkykAz3IVlRHmDFscTH4M2qtEgPfNvZ9U3noy7iSpLJ5kIFPaqqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeT8h4IxrcirmcJ6rTVOm7j29W8WtHvw/Ia90iJdNBI=;
 b=bSkYKTrz/B56rU/li4OodeFKuVFaGbiSVGjxI7vxMJt4O2VJ6cxrCozzKCLQBzajQSFYlX3D1bB1eVXSxZwTwEScCyKt7nxV7xtXLWU5uJpFAlsdmrTIFzcaqKG5PYzpRCwQQgo+vww/6rp7NRSGU20JfSMi0I/l1VOEVKsTyicEoTfIcoUYXBNvkqGKrux09ZUTFTJbXNa7B+xgrXqDHbsgzMBsFaQrkSoQm83A/ch8yLftFnm8DsGtI9TUVAXwm8bHYepaJ2YjaxNUfAu8RVg8EpbEIlGsxVb6cYvhUczkYhtaYrZzc+btci7PzOe+Xef0N7JKKeiLcCpBlpA/rA==
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:35:36 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::64) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:35:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:35:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:35:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:35:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 5/9] net/mlx5: E-switch, modify peer miss rule index to vhca_id
Date: Mon, 9 Mar 2026 11:34:31 +0200
Message-ID: <20260309093435.1850724-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5a3521-f93d-4795-d3c5-08de7dbf3789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	2gyCu/CuyNDON43n6c2yPl9Slbvx8aMBVnYSqNWmeaee87yrrmkvC4AzOSEZpWVBya+mYHQ3fqxWuDv8g8JQvIaG4slKcNKHYpuMQeDHhde6WYnsyf+iu7Atmax9dVgIHiPvPG1oY0nqwJEJloeLNvHfjJbkbKwbo3yiUx43+yA6HG1c9cFj8nk0lKe7gcPXkLnstLfHh4iFotXV/kLXo+4ZKC826ckNvV6GSu5Vm6dqIysfpOjE92RG3r9MUM2BHiVUGbjSsxQesChJfVhm0sEjydr+6QgX4hBJmzh/zzXkZCMpofDhY6+Jlh+5kbFXCfWSamAHt6KjJHRbdj7+VSW+BjPSWfDJ747hgC9aUaTZcuu+rgK6ajx/2Gjb09yxGbnO/AkbZyO4aQjRFJuKeFdefiqWabUW+R2mdE3tDoRLMnu2owZztKhGchyVi03FSmndzTzTDCd7tO+Or4607JXXh2bcW4yH/hDXjxvYmlxrfy5VZP+y8oRyOnDi6LxjNkVtQRA7Ro3ToAm1VNGq6BVBx8XRJcSkEn1sOa3Fr7ESxi8I/5mXczMeL9BBWtjElqHjm+PRsPeHRpvM3k+Bc3o+d1Tkrczfdwilb3fzlKBBrk+U5dhI4dYSyFTpsY+DxoT5OgfqWc5qCTo3OJDmrhGOXoJ/33076nU6vyDxj5VfGv7Ieiv73SI1pNqcBZzmA/LKEByxcgx397rOLw4PZ3EZ/Z6aMFJdAtGVQTi9KSLf5NNVu7TTu24UWQMNSqhB0733Fd5Sxn664jwz/G4zXA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LJ4eYW0MQa7+f9QHm3HfkRiuhGvKwS1zzTn5i+QViLKIoOJTGIfwzbL3PXXHBPPlPQmhk96H0fhOSiLREIA4bghzedYIE126TrbOMzr+znYjuAQOrlpQ3oWCSHFBcUCF1AQ3EMJj7c1oyZUbMCMEd6wMczSfaou40l42Zj4QSxXdoOo3hCT7LU8NAJ07otD+JcDTwIZXercChSkTlV6O6cNDAIt3T8eLDrTphgXBx0OIDS1dNU+SLnvVGtBj4WNYS1mynH4l8mYgVQJEkVzBkvKBfmdX2sBUgWVUyyowus4wfoTXSlo/RCAhcH9x/i1YdpFqyoO0RxzU+qtbHrmWdqe48WZ09ZJyvyskMSKoolEgb0Wc7RGtqtDv27ncJjpQ2Kmy338EylHpyD2ybfj6NkughMAfNYijVGyyKsBDPjKx7xqFYsJJYMGNRcz83gfl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:35:35.6187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5a3521-f93d-4795-d3c5-08de7dbf3789
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
X-Rspamd-Queue-Id: CAA252364B5
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17759-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Replace the fixed-size array peer_miss_rules[MLX5_MAX_PORTS], indexed
by physical function index, with an xarray indexed by vhca_id.

This decouples peer_miss_rules from mlx5_get_dev_index(), removing the
dependency on a PF-derived index and the arbitrary MLX5_MAX_PORTS bounds
check. Using vhca_id as the key simplifies insertion/removal logic and
scales better across multi-peer topologies.

Initialize and destroy the xarray alongside the existing esw->paired
xarray in mlx5_esw_offloads_devcom_init/cleanup respectively.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 20 +++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 6841caef02d1..96309a732d50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -273,7 +273,7 @@ struct mlx5_eswitch_fdb {
 			struct mlx5_flow_group *send_to_vport_grp;
 			struct mlx5_flow_group *send_to_vport_meta_grp;
 			struct mlx5_flow_group *peer_miss_grp;
-			struct mlx5_flow_handle **peer_miss_rules[MLX5_MAX_PORTS];
+			struct xarray peer_miss_rules;
 			struct mlx5_flow_group *miss_grp;
 			struct mlx5_flow_handle **send_to_vport_meta_rules;
 			struct mlx5_flow_handle *miss_rule_uni;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 1366f6e489bd..90e6f97bdf4a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1190,7 +1190,7 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	struct mlx5_flow_handle *flow;
 	struct mlx5_vport *peer_vport;
 	struct mlx5_flow_spec *spec;
-	int err, pfindex;
+	int err;
 	unsigned long i;
 	void *misc;
 
@@ -1274,14 +1274,10 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		}
 	}
 
-	pfindex = mlx5_get_dev_index(peer_dev);
-	if (pfindex >= MLX5_MAX_PORTS) {
-		esw_warn(esw->dev, "Peer dev index(%d) is over the max num defined(%d)\n",
-			 pfindex, MLX5_MAX_PORTS);
-		err = -EINVAL;
+	err = xa_insert(&esw->fdb_table.offloads.peer_miss_rules,
+			MLX5_CAP_GEN(peer_dev, vhca_id), flows, GFP_KERNEL);
+	if (err)
 		goto add_ec_vf_flow_err;
-	}
-	esw->fdb_table.offloads.peer_miss_rules[pfindex] = flows;
 
 	kvfree(spec);
 	return 0;
@@ -1323,12 +1319,13 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 					struct mlx5_core_dev *peer_dev)
 {
 	struct mlx5_eswitch *peer_esw = peer_dev->priv.eswitch;
-	u16 peer_index = mlx5_get_dev_index(peer_dev);
+	u16 peer_vhca_id = MLX5_CAP_GEN(peer_dev, vhca_id);
 	struct mlx5_flow_handle **flows;
 	struct mlx5_vport *peer_vport;
 	unsigned long i;
 
-	flows = esw->fdb_table.offloads.peer_miss_rules[peer_index];
+	flows = xa_erase(&esw->fdb_table.offloads.peer_miss_rules,
+			 peer_vhca_id);
 	if (!flows)
 		return;
 
@@ -1353,7 +1350,6 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	}
 
 	kvfree(flows);
-	esw->fdb_table.offloads.peer_miss_rules[peer_index] = NULL;
 }
 
 static int esw_add_fdb_miss_rule(struct mlx5_eswitch *esw)
@@ -3250,6 +3246,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
 		return;
 
 	xa_init(&esw->paired);
+	xa_init(&esw->fdb_table.offloads.peer_miss_rules);
 	esw->num_peers = 0;
 	esw->devcom = mlx5_devcom_register_component(esw->dev->priv.devc,
 						     MLX5_DEVCOM_ESW_OFFLOADS,
@@ -3277,6 +3274,7 @@ void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 
 	mlx5_devcom_unregister_component(esw->devcom);
 	xa_destroy(&esw->paired);
+	xa_destroy(&esw->fdb_table.offloads.peer_miss_rules);
 	esw->devcom = NULL;
 }
 
-- 
2.44.0


