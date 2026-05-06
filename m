Return-Path: <linux-rdma+bounces-20075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE+NGJBD+2lPYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:35:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C20344DB0AE
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D41B306CFDB
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7604647CC70;
	Wed,  6 May 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KtYabjQ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80947887E;
	Wed,  6 May 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074420; cv=fail; b=m2wvWPZ+hT12z5/NkpA9kx6WZqTt9wRxhsdxXC96wf0Xl/DUuiVmuZoBCI+1V9k3snDWTNRhiyIT5VQEeKnWwrO4I5EKkKH0njIuOWhx11KT7MxBvPXPFlhi8TW8hPj/qNMwSGRQaFXDRa8DZiAwDeVxFVMRt/8GOHHjZJAHoa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074420; c=relaxed/simple;
	bh=qRPLqSmTdL7RgFrpA39YtEfL8GmJqojniB9toq76cd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHPSutWvUyKHa9GP4Gjdprvth/EMu0tSu8pZlIvS/F4QHj86J1kloEcjndy9Kmqsq5n+6aOKFRmbnpi8Q+OKPzYWBiwpRdcORX0CM6aB67tjZzbm5e+b/FTG0I8w/2jK+MHIuiyy/CwE0YlLHFpou8vMkhkYar54BhxoqwDNtA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KtYabjQ/; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foaXuChDLB/3q5FOv+M9zem9ZikbJ957Mn4t9wS8KTB3853MMzmxqcyIYl5zLL6ngWrAMj1alGhsg5iTj3xvErnhyFzteZhI5wqMfMoykL6PHYSbZEwoTOk30RBCx5XqkihStdc+JkOPoV62+c+ituft7Y2LOtJvz+EIA9rU+1Ms7I6PcwxGXUPAkX6+KuYQLCpADQ7zkt3UYJAWbDDqfZ0EIWa4BkcpT6ueTnYhmASC/HiIgGa9ZX8sdVNIh4STangsx12x3htbUhSRhqYdsQ/TnD4lzL3MYoT7sec1W5ixWR46fNy6wv7GM8AcMaZ8UvRoDlIKtWKil6GqR3NclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKAm1Kw0m1lZImrfB9XzU16kod3fBCXGquKUYeNU6xA=;
 b=FiDp2S5bijMn+MBtuTzUPlbxkNYd9NJOtMsr/7VEXrWLi+mH+N6r0eYYHFsGxeh1F5kWtUj8j+Le2amwyqKc6OX1eWF+7+obz9c/c2a+Jxxs1hdb274f7gmwF6TwT3CuG8kvaxFNgVUeD2/45KEMPoPqzlN3zqcYThnK9lnL4osjr0eofPPi44rapqjXF77rhLeZEG1UtjBMAS4NYi+i8hyuMHhmzxJbHqCVzZOEXFA2IokblVW33LD7Og7TAvzig4VcQznDfxNvJ1ClXYlUc5DotGGqO4X0V29KrXmEYXo7bDxM0YWzOtHMWn060u/P6thkbf/GFxcRfGqhh/VrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKAm1Kw0m1lZImrfB9XzU16kod3fBCXGquKUYeNU6xA=;
 b=KtYabjQ/c8zSaEQdaCxDSGCWHCylM+6avun4yWunPWyBpo06/BA1cTKUzgXOqOqhImqst8++JZQ5hqpwGjkCir2acwuiugLlA/2TjVFqGqeNgewvVJ8HN/6SyNs6vE9E3Zp22w/1FF+urVRn4u4enXaui4nS/I4eXMhs1X+HXWudshBl5iqcW+08Sgz9lGTr6Dk9OH43GwzYA2cNTDAVXMf4dFphGAkOmYE1nyOR0s7ytv4HjZ7UOE9w7su0W0w7ws+Iw+1ee55nEhOh/t6C43Q9VCm+cZivAhji740rj+A5uPOwqwmmP4OibDpQKiNzgiu6GWVA+LyunA5RL2xMFA==
Received: from MN0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::6)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:33:21 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::f3) by MN0P221CA0003.outlook.office365.com
 (2603:10b6:208:52a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 13:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 13:33:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 06:32:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 06:32:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 6 May
 2026 06:32:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 1/3] net/mlx5: Relax capability check for eswitch query paths
Date: Wed, 6 May 2026 16:32:37 +0300
Message-ID: <20260506133239.276237-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260506133239.276237-1-tariqt@nvidia.com>
References: <20260506133239.276237-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: a39212c8-331f-4b35-7eba-08deab740a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	D6tvWoRn5rsILQScaH/pZgwtlJhoL5wHydRtPZhOTBThUbthunu9SBFfXaBnVEbU9nzLTCDMXauCicrCfeiEAI5zMf7Z+kkMGfhXHHEhD6NqwJCjVoNDNTdLz4+EA2D6m8cU8641GkZvjbYSvsmdzBm+8/YsaYbgRT0lZTKq4fcVNYnTFOGW85f8SVNr6KiJn0WhiV7xu9gNi6xiTMIq3wqJVCm4dr3qB/zwggHwuho7NGBhhMuzvF14khiO36hINIM38TENmzUY/6XNEj0RSQJHWMUt5rARrj2PVqE46egFaajT5k4w5OL22eRVaxeT+2XrkXYE3bgRFSfLdyLrDSnrFYZEHV7zb9gvV7t1dp99aOVIyW3O2UVnKpTHKEzjlIerIDXAAh8hDYwWIWUTbc/Hf24WPM2dJAbNcgdfzdhPSL6l14+jxYMVQUPG5Ff4vk5pTqFvjKIx5Z6YkoyXs9Twupvr18E6dnEjPrMnYonufU3V68ffwsEAsBkuIzYkLqkkOg4aYkg/0lAHle+/+DftADV+aW9fFvn+a7pp+CPFrRYmQIGccd06akwhwX3oY4OeaxAi5I83G5p+TTdJU1X9rQMauQ9LGLf6AiM0FVYEOLQsd4k+mZckvyx8rrsqNczu0Mxd9u9Ejm7lk9BmG9C2fwPMfdB9wMfeQQzyDSq1b+3/AITvyb6Q38ho7NJhELSRCIvbkecYqmmemwKV/LQ8EXG9RF0P4K8o+JQQfnY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	heD0EzfRfiHaoCcoPgqa5pPWoPic5i36QOUGDFc87xcTqsFNbUTWfEx0a2M3+m1wyZnWOQHGr6Q3jDtuX6x0SX3tURDcVRmA8A6WPP+Cj6X/p46b5Gz5KCsBJAQRqLdfwzxVfSHpnvrxHVZo46LUmlXPT3UW8q2MGuTD0b5F5+Ns987u9mxptZvI+AjAIknD7gYBRpiquqnVZDeLdnu+eUS+FSEMKH3xdyLJQfOZtN7KBK5Cr4vAko+8svsnYbX3Cv9V8gdj8O/Lo9ugVFv4ZV2ZmiTX6QDt5T7e5R0O8pkz3aO8NbmyH+SJ9FYhXx2ZMdygdSUeBNhOSvH9h4hpElsByf/N652S/7Kytkde8t513ajH3fR84O0SwrFFMU5XAFx1deMVpf9Fm3/QUQ8iurGAAOZgouXn5AbPL2dNPWqyN2HRMwAviAfwfgl/5dV8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:33:20.8876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39212c8-331f-4b35-7eba-08deab740a4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
X-Rspamd-Queue-Id: C20344DB0AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20075-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Several eswitch functions that only query other functions' HCA
capabilities or read cached vport state are guarded by the
vhca_resource_manager capability. This capability is required for
set_hca_cap operations but query_hca_cap of other functions only
requires the vport_group_manager capability.

Relax the capability check from vhca_resource_manager to
vport_group_manager in the following query-only paths:
- mlx5_esw_vport_caps_get() - queries other function general caps
- esw_ipsec_vf_query_generic() - queries other function ipsec cap
- mlx5_devlink_port_fn_migratable_get() - reads cached vport state
- mlx5_devlink_port_fn_roce_get() - reads cached vport state
- mlx5_devlink_port_fn_max_io_eqs_get() - queries other function caps
- mlx5_esw_vport_enable/disable() - vhca_id map/unmap

Functions that perform also set_hca_cap (migratable_set, roce_set,
max_io_eqs_set, esw_ipsec_vf_set_generic, esw_ipsec_vf_set_bytype)
retain the vhca_resource_manager requirement.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  6 +++---
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 14 ++++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
index 8b12c3ae0cf7..4811b60ea430 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -12,7 +12,7 @@ static int esw_ipsec_vf_query_generic(struct mlx5_core_dev *dev, u16 vport_num,
 	void *hca_cap, *query_cap;
 	int err;
 
-	if (!MLX5_CAP_GEN(dev, vhca_resource_manager))
+	if (!MLX5_CAP_GEN(dev, vport_group_manager))
 		return -EOPNOTSUPP;
 
 	if (!mlx5_esw_ipsec_vf_offload_supported(dev)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 66a773a99876..e0eafcf0c52a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -806,7 +806,7 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
 	void *hca_caps;
 	int err;
 
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return 0;
 
 	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
@@ -938,7 +938,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 		vport->info.trusted = true;
 
 	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
-	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+	    MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
 		ret = mlx5_esw_vport_vhca_id_map(esw, vport);
 		if (ret)
 			goto err_vhca_mapping;
@@ -976,7 +976,7 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 		arm_vport_context_events_cmd(esw->dev, vport_num, 0);
 
 	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
-	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
+	    MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		mlx5_esw_vport_vhca_id_unmap(esw, vport);
 
 	if (vport->vport != MLX5_VPORT_HOST_PF &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 69ddf56e2fc9..392d8f364db6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4677,8 +4677,9 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 		return -EOPNOTSUPP;
 	}
 
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support vport group management");
 		return -EOPNOTSUPP;
 	}
 
@@ -4753,8 +4754,9 @@ int mlx5_devlink_port_fn_roce_get(struct devlink_port *port, bool *is_enabled,
 	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support vport group management");
 		return -EOPNOTSUPP;
 	}
 
@@ -5076,9 +5078,9 @@ mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
 	int err;
 
 	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
-	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager)) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Device doesn't support VHCA management");
+				   "Device doesn't support vport group management");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.44.0


