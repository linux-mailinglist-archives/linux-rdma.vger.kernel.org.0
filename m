Return-Path: <linux-rdma+bounces-21101-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL79NnnrDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21101-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:24:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4583B5A3F94
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC52830E17E4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25043C1F36;
	Thu, 21 May 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SVq4WSLh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5ED3AC00;
	Thu, 21 May 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361959; cv=fail; b=X/cAiQozXf4F3K9I95TuESMJ01rP/mPvy0kwld3H+ljRh7Varz+65nLDMFaj7frseQtSsS79o0CBuD9KcPRyZNeFl45HU0MukFcnkejZ1Eh8HN21UkY6a42CsQcoFadDquCyOj750OYQ3IjcchBoEDObeMOgstG5CGby9FCCiy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361959; c=relaxed/simple;
	bh=Eumh9LvpMy8aXHhAjtResdFiRMRSv5Tyb+pgHeyPbfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8J3UHDRmmy6uYc3K8eSRqT4I2XDMCSbzwbOFXFR0EeNLw4ypInoddR08tdGZgvjbmOREYh+gUVDjxvFmp1/BvLgGtBP6Q+5F7DB3TKwaZro1IVbJglNmqR2vr/voaNFanMRYsuupTaSontphkkno6N6MaC0xVhv6IGvnXerOX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SVq4WSLh; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6jrtrIAotoLvhOZY8Ar8ohsvBWlk97nTBhIspWhCHs0Ege10tvNPZ5fwqx4DLniuRtgwAUgbwS5CM294SONy2gZI3xnOvxcxc23lGsLsg7expW3p0/WpjCaG7+yUF4KP9tkxF2Lq0mmWyHR3bLxUeIIhxXTYmHWpG3/f9qcyhTOevJrjIIumMB4eCnme0I1xSpjJOjTTOBDFDzgcpnRJMYR7P0YAGBryTLakm64biSrJerCyAA1I1YYLKp4OoZeeP3nrucoC9GXolvQMRn3CmpmMVijQCal09jlv/zQfWeG1DaTtuRS6G/TuyDDUmg7XaeNC4/2f8XIcuxdPFqu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAIbSKGWSPZnGhM11kn04WUmVGAUZaQqADNqfCsfDIg=;
 b=Jdy7iIWNcHpveaj744yzNL6uA2+XzSoxJpWe2xQ2u+yeYmHbCvnnpzWKbWoPHS/AdML97VFr16GlaHfPvnXLqcD7wKFvfE7qQAfl0G+ACKtDkHFBBChthSLOL64hVIJVQLBw5NeSzRIHZ9tLZSAPll+hz/E3wnb+yipCmW1NFPL7FDm1KlgTT93SEQzmpN9EulAKwcpUqN0akaeQlhdoLtLYbZosQPFAVgDb3uV3KqezMuY8AeyQh9TpwlsmW0oJ3Tw44UOLwhALD/nQi1vGLjtd2gdJXTdMfqRWOeBagHXlwxHJxSkNrqgguXoL0FjcaFfFcNzaiI9gk7EhvChE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAIbSKGWSPZnGhM11kn04WUmVGAUZaQqADNqfCsfDIg=;
 b=SVq4WSLh07eZyvwe1tqxrJKgqk7SEn0DXpfZTWCqT1U6eaOyOFd9nC79Tf8dMyyqjWLiq9VBC0uHrG3HjVz7eUbGixUuq6EjtoPTstyvlMl412UPwZO3Ja31QwaNleIhFz0K0XMz/ND2sXQW0V/6PWfwiT+CtC1eY64Zwb6il/h0KU44TH0CFJu2xp24XoBtRfGlnC964hbNgQiPl75Qg0bXtWgD2kMEMzXK8hIMMYlPdiBwEDC92whuiydZwio9KV3q17Hwf3Bo0MAMMQca0jZmuzk80w6b/eo74FIlc4LGGoucgBmWBUjsld52SgSdOapu4SrNK0fRAUa8CphUCQ==
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 21 May
 2026 11:12:16 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::65) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Thu, 21
 May 2026 11:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:49 -0700
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
Subject: [PATCH net-next 06/12] net/mlx5: Expose PF number from query_esw_functions
Date: Thu, 21 May 2026 14:08:37 +0300
Message-ID: <20260521110843.367329-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SAWPR12MB999140:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b72a59-3a6f-405c-1f43-08deb729d13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|22082099003|56012099003|3023799007|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ImPWDt+xhsx4Jt3mcrvgWmQHhVUECdBdGGJGeCVKeYQHEkku6RR6Oir+7rQ/sgizZsfmVE3/bAnxfVCm1ufnidkEa0jDHgD0GdySJOfe6QIMcF128oIx5GWhYSdoDTPZbOVNiuzy6GH+DzD00M5F3RkI4Iqc02L12T+wnSio5pj49HVjLLBpBPdqTSpCVjbC8gF/4X2AIu+k/8qMy9uUId/9yRPrsMzPldPTNVMqvqADT6+Ipqt9VKZEPctZ15ZksJGOanIh57rHxRBWtql9GPRo8cLHCmYo8eKBVS0YhKexo1M2nTbSh1PGbwqgkK+8cYdv/yPP9z8Anbl7U1QfKydsrxGLg153+qsEdCuL6ePzc8+fEYP+ksAchA+REH7MS9qu+/AHMaR9jz04/uJ6sNEiC4w650TvYyL3UZiDN/96kc0RmAgjFfdJs0YX9qGzL4T7HQuBR4CKA+5p433OWgbkrQ5DkLa9OGm+dhvediuFploq2NUxlM4gPs8pzSzu8VO/z6w2kNTHwkHJK8+CQgEU8LrmByhNJq7+ZqJ3ECqqw3h2DeIISsAy5g5Lrz/Aad2Wk+aZx90yAqvip4duoofa9d4id+Vmy7I/o2xH4NZtl04ZhtMrRM+xlY85AaOHUFHLvulS8ZGMpbbiv8VulD2HxWnRipIIGo/haiyqSZqLkEZ+pvyXEXp5zuhZX4XbLp+vDd7tz9AjEUwMC1Mxd/LN6GYH8yFQH+u5dxt1KuE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(22082099003)(56012099003)(3023799007)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zUw3emYwApGoKOVqjmriY6rM2f6gyokgceemjWEtQ42zYVuHt/V+sqsVopcZKShbCwDyOfkkO2UV86yu5THwZ6bYk5cDnddGvWCS0h2/nTMYE5ougJbYqaqdQQPDraTimoCL6O0CQC+Q6jJLgSxsS+7piSW+Zj6Qauj4ap3/MP/23q5CWP2NBrt169ZdIm5MTljCCWypd2A8P3HgRbxpTjjep4mXXJ5uPpZJcgW1BfHwndt2NQ1N7yRGS+AvJuClhSefMNgkIRYUilZv4QiixAzETmj3YciiWX3uJ1ACS8lBsvdu6hwhrxgu3MQE53I7cXs9dS4xPmdvOeDzSNn+KoEI0ALmELGax/knkMARANKiCN2rG6Q8aDBgdN2Fs2wCRW4+qN27fm7y0D6m+5SBJbALrMvml/pdi7K1gmi6GlMfYWOR7YsIfv2qoOolay87
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:16.3310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b72a59-3a6f-405c-1f43-08deb729d13d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140
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
	TAGGED_FROM(0.00)[bounces-21101-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4583B5A3F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Extract pci_device_function from the query_esw_functions output for both
the host PF and satellite PFs, storing it alongside the existing
host_number field.

Add mlx5_esw_get_hpf_pf_num() helper that returns the host PF's actual
PCI device function when the new query format is supported, falling back
to PCI_FUNC(dev->pdev->devfn) for older firmware. Use it in devlink port
attribute setup so that host PF and VF devlink ports report the correct
PF number rather than the ECPF's own PCI function number.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  4 ++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 22 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 ++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index e723f05cd4d3..d5f0101aa966 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -37,6 +37,8 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		controller_num = mlx5_esw_get_hpf_host_number(dev) + 1;
 
 	if (vport_num == MLX5_VPORT_HOST_PF) {
+		if (external)
+			pfnum = mlx5_esw_get_hpf_pf_num(dev);
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_pf_set(dl_port, controller_num, pfnum, external);
@@ -49,6 +51,8 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		if (vport->adjacent) {
 			func_id = vport->adj_info.function_id;
 			pfnum = vport->adj_info.parent_pci_devfn;
+		} else if (external) {
+			pfnum = mlx5_esw_get_hpf_pf_num(dev);
 		}
 
 		devlink_port_attrs_pci_vf_set(dl_port, controller_num, pfnum,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 42cdb4309258..8e2ac759d1f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1157,6 +1157,8 @@ mlx5_esw_host_pf_from_net_func_params(const u8 *entry, int num_entries)
 					      entry, pci_total_vfs),
 			.host_number = MLX5_GET(network_function_params,
 						entry, host_number),
+			.pf_num = MLX5_GET(network_function_params, entry,
+					   pci_device_function),
 		};
 	}
 
@@ -2103,7 +2105,6 @@ int mlx5_esw_spf_get_host_number(struct mlx5_core_dev *dev, int spf_idx,
 		return -EINVAL;
 
 	*host_number = esw->esw_funcs.spfs[spf_idx].host_number;
-
 	return 0;
 }
 
@@ -2117,6 +2118,17 @@ u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev)
 	return esw->esw_funcs.hpf_host_number;
 }
 
+u16 mlx5_esw_get_hpf_pf_num(struct mlx5_core_dev *dev)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+
+	if (mlx5_core_is_ecpf_esw_manager(dev) &&
+	    MLX5_CAP_GEN(dev, query_host_net_function_v1))
+		return esw->esw_funcs.hpf_pf_num;
+
+	return PCI_FUNC(dev->pdev->devfn);
+}
+
 bool mlx5_esw_has_spf_sfs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
@@ -2127,7 +2139,7 @@ bool mlx5_esw_has_spf_sfs(struct mlx5_core_dev *dev)
 	return esw->esw_funcs.has_spf_sfs;
 }
 
-static int mlx5_esw_hpf_host_number_init(struct mlx5_eswitch *esw)
+static int mlx5_esw_hpf_info_init(struct mlx5_eswitch *esw)
 {
 	struct mlx5_esw_pf_info host_pf_info;
 	const u32 *query_host_out;
@@ -2142,6 +2154,7 @@ static int mlx5_esw_hpf_host_number_init(struct mlx5_eswitch *esw)
 	/* Mark non local controller with non zero controller number. */
 	host_pf_info = mlx5_esw_get_host_pf_info(esw->dev, query_host_out);
 	esw->esw_funcs.hpf_host_number = host_pf_info.host_number;
+	esw->esw_funcs.hpf_pf_num = host_pf_info.pf_num;
 	kvfree(query_host_out);
 	return 0;
 }
@@ -2255,6 +2268,9 @@ static int mlx5_esw_spfs_init(struct mlx5_eswitch *esw)
 		esw_funcs->spfs[esw_funcs->num_spfs].vhca_id = vhca_id;
 		esw_funcs->spfs[esw_funcs->num_spfs].host_number =
 			MLX5_GET(network_function_params, entry, host_number);
+		esw_funcs->spfs[esw_funcs->num_spfs].pf_num =
+			MLX5_GET(network_function_params, entry,
+				 pci_device_function);
 		esw_funcs->num_spfs++;
 
 		entry += MLX5_UN_SZ_BYTES(net_function_params);
@@ -2297,7 +2313,7 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 
 	xa_init(&esw->vports);
 
-	err = mlx5_esw_hpf_host_number_init(esw);
+	err = mlx5_esw_hpf_info_init(esw);
 	if (err)
 		goto err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 88041dd8a39d..03c7582d7b95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -77,6 +77,7 @@ struct mlx5_esw_pf_info {
 	u16 num_of_vfs;
 	u16 total_vfs;
 	u16 host_number;
+	u16 pf_num;
 };
 
 #ifdef CONFIG_MLX5_ESWITCH
@@ -352,6 +353,7 @@ struct mlx5_esw_spf {
 	u16 vport_num;
 	u16 vhca_id;
 	u16 host_number;
+	u16 pf_num;
 };
 
 struct mlx5_esw_functions {
@@ -360,6 +362,7 @@ struct mlx5_esw_functions {
 	u16			num_vfs;
 	u16			num_ec_vfs;
 	u16			hpf_host_number;
+	u16			hpf_pf_num;
 	bool			has_spf_sfs;
 	struct mlx5_esw_spf	*spfs;
 	int			num_spfs;
@@ -887,6 +890,7 @@ int mlx5_esw_get_num_spfs(struct mlx5_core_dev *dev);
 int mlx5_esw_spf_get_host_number(struct mlx5_core_dev *dev, int spf_idx,
 				 u16 *host_number);
 u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev);
+u16 mlx5_esw_get_hpf_pf_num(struct mlx5_core_dev *dev);
 bool mlx5_esw_has_spf_sfs(struct mlx5_core_dev *dev);
 
 int mlx5_esw_vport_vhca_id_map(struct mlx5_eswitch *esw,
-- 
2.44.0


