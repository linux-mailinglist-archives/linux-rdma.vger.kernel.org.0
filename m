Return-Path: <linux-rdma+bounces-21098-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OWhBP3oDmqwDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21098-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:14:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A15A3D0B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30551304FA0A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64D3BD65A;
	Thu, 21 May 2026 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e1woIzb0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06537CD4D;
	Thu, 21 May 2026 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361938; cv=fail; b=ptBKaMiVRADeIOHtkTmCXJhFXnHB6/1YPOuFBzvMP2OD+BnnuRxCFdKhNpsWc79GCNqHm6th1EwuYN24ooQC3bN8FVDJ7ULJwZ/81qhxBbHl95vYlHEmA50s3b/OkCEDfjn7fLPAG6HVeEXFQxau5Ve7aJjyN8BFn1OBAr8/++s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361938; c=relaxed/simple;
	bh=4LtRJg6Se4ZDEK3BNmVvWniEig32OLm0oUOZmHN8B/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACAuPIRSb3JwYj35InDmkdUpQ0PucmYtc+KFjjpxxKudrdYbjEHqyPh05h8KlREYjlHil6zLDO31wARNchI9GL82wky2XAdW4q0ThGPe8llDRxMZas8/RZyCQfg8uE5Clozonmievp98uaTAVJWCeayV0+wLszek543CYIyDXfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e1woIzb0; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqFxX1FuZlzr9mG05AaU1DWvA8Ud8NSMsEXKsl1PFaAIuZ3KfzCgv/Drkte+5dHmdCZF1P02bSNJd8g/dXEGX3jekdODCLi4sOYzDxk6JnsypGVbgAYQMvPHIyAh3WFUsxtOTTCsXGzLOYOpHgw8668TjYHb/BBG9OIoHF90Rvhh5ZGvd5y7oqRIQ2jqVPMRUJJ++d+HusosX3n1acjZoGi9Lc0oqfISeX/TdSx/yEH6WydEOspxRtiaJNQh5oDzi8Be5dSlog2ZddHHqs6VWI1W5FUQQ/xrwZbZMBpniwFZnDKqVOb4A/B678K1iWuNjW1IXgjrpwMvE0eDRAg8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEbdexhiShE3cpxFCIetBXLhCLpyAbUo4bKs79H9WZI=;
 b=IR0TCLQ5CIwm454rVqyS+4Tv58K8W1Yuhla+7kIgmGe2vNvopl4xczpXajie58A5BaJwmy+xVcUYLItlOCJnLzP0poNeFD1GqUp3VvTWeCu8sf4KkVNj2MibDmcMrapTdTbHVfSE+Z83qMhVwRrjitj3vng2B9EKd9HkKvaXqkpd08JukSJmMVXFepEEWR//HP8WiBamF0Ln5RfhMH94fRjGQf9pRmhgXWu/G9RIAtWZb2Un+5SeuvjA2sLkvbXR42CFTNqTZcDk8bkIEO2ty8M2VhN6jZAxQjDPJVMvdHIC7G6nsST/SgWJLRQEYZ414uuoTW7y46TxeMtqji0fIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEbdexhiShE3cpxFCIetBXLhCLpyAbUo4bKs79H9WZI=;
 b=e1woIzb031pfympc+e97QyEOO0gkJMXlAOpBXjXlK6Z/F9qjdXKuOFj4q7f2RGhvFACfMeS0CBKrdG6Hr4hUGqiDR655y55PmfBar6RNSjhj1HHhBKqsqUYVTjm/syi+tyaP5BS6+2jZ7+1oxlfkL41iFCnFH+Lny1joy13m2dnWS/rbXDBK1/Uy843n4slfkzii3TSv5cmlAWcw8HnpqEdHvxiqVakxJ7w061+KniWWDII6iJOGBbUrpf26PtUj6RnDp9yeoDcg8thdGqnoBcc7wS/h+J72R8jxHOtA8zUOqR1QC9ta2OYWjsgdzwQ5WJM0U7o129gePYxHYlf8Ug==
Received: from BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::17)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:12:02 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::5b) by BL1P221CA0039.outlook.office365.com
 (2603:10b6:208:5b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 11:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 11:12:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:36 -0700
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
Subject: [PATCH net-next 04/12] net/mlx5: Initialize satellite PF SF vports
Date: Thu, 21 May 2026 14:08:35 +0300
Message-ID: <20260521110843.367329-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ef9c0d-2f12-4c23-ef66-08deb729c83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|18002099003|56012099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LuwahFuhCM72FRd/rWS5omvGNXF0qecDPGuak9FHpuaoTkI9h7pYcabT0LciRMI/HjEM9p4K3GviCmNdiMi92mnB5QyNmDvqfJiNU9xSZNG7rN7pqGzRXMUEyRmxOblPfSEKQAi1PbHoh2QoB9eF81JnhMdcB8RxwYeIVuBKnnGu1dkFeCGPg26boir/QF4I1oIjTc7A2x+L5+mSWTrSLLj0uuVKmx1bE12sHS5IoWbuNZDGN8lgBQhLZGQM7i4/xGUzpuz1vIaPjYmD7UUwc+hZ/KCl7snod/cG16WwanNqha+HJip4NFIna78HOLTESENbHhEd4yXR/kVH3YFpka7k29ZMMVyo35GT9ZLuOZQCkiIVCMStviA5FZKBCb8EnIokr7R5jtAYeEuPqdY0tkcJvz417ujPIqWihWXdII98IZarQibfIre+i3GdxraXOkPaMbTYWKI37/if1AAru/lKqpVRR+TX/JN8NT3t6Ijtn2NYNHeNU9FSMJ11zMouhB+TZAJMhGhflKmndqgxwCf8+uerTrR36+SRqb7y8XCYwe+Xse/Y1uMyVblwQv1RxlA0bh34WVk1p8IPKKZNKiSCikFuzjLZdNCVmnVa2IB6cLyXYxPHPnHgAB92xlVgViUTbHalE954Z50p0Clr6bl7sB3G8xFU3ZMY8gCE1hBp68OyX4RxdLGvuFPm7aowSWY3WhZ8T/xxSmY9O93xqrRZ/BuY0nApzJnb/RqYbA0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(18002099003)(56012099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aQoOkk+dVVdW/g4OAoXr1QaHo9x+SzDk0J8FBkApCFMDpD9mFx+uiMj83kGmMX7gGFOQBvTe0CkBipQ2s4UNzrv2W9Yp0Qc8KktL9MpOJKk1BfgAPhWw0sb2+hMKLUEHb92lcBWPnEuvM4y8NaJaV0osXKCLcyYoUx8HlqYCoapeDHeZQgp/ur/PuKiU5wZ0kwHr3HU8s02oh+DbGmleFkmDU/z9zkcCuXnQ1vDQYhjSKyxgvZj3lv6OsIC2j41aJah3RSbO1fZGFanaThuJ5EE+Y5g10oDLOhCeTUcTj4veN0KywTezv1HSVQQ8P9e7Zz0XQtHyqPwaiUMMzM75VbMKwCu7SwN7VepqRW+35SDRTOGPdCyhekAUD6eVb68xpPvVYCykIYbItKIrK1MtIzt7lUFN8IDAdwGhWSdELecYhkrkPkmPxS/9fSrlegjU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:12:01.2211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ef9c0d-2f12-4c23-ef66-08deb729c83b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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
	TAGGED_FROM(0.00)[bounces-21098-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A90A15A3D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

Extend satellite PF (SPF) initialization to allocate SF vports for each
SPF. For each discovered SPF, query its SF capabilities, allocate SF
vports, and store the host_number for controller identification.

Add accessor APIs mlx5_esw_get_num_spfs(),
mlx5_esw_spf_get_host_number(), mlx5_esw_sf_max_spf_functions(), and
mlx5_esw_has_spf_sfs() for use by the SF hardware table in a subsequent
patch. Also extend mlx5_esw_offloads_controller_valid() to accept SPF
controllers in addition to the host PF controller.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 81 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  8 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 13 ++-
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index f9085b8dc20b..42cdb4309258 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2062,6 +2062,51 @@ int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs,
 					    sf_base_id);
 }
 
+int mlx5_esw_sf_max_spf_functions(struct mlx5_core_dev *dev, int spf_idx,
+				  u16 *max_sfs, u16 *sf_base_id)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	u16 vport_num;
+
+	if (!mlx5_esw_allowed(esw)) {
+		*max_sfs = 0;
+		return 0;
+	}
+
+	if (spf_idx >= esw->esw_funcs.num_spfs)
+		return -EINVAL;
+
+	vport_num = esw->esw_funcs.spfs[spf_idx].vport_num;
+	return mlx5_esw_sf_max_pf_functions(dev, vport_num, max_sfs,
+					    sf_base_id);
+}
+
+int mlx5_esw_get_num_spfs(struct mlx5_core_dev *dev)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+
+	if (!mlx5_esw_allowed(esw))
+		return 0;
+
+	return esw->esw_funcs.num_spfs;
+}
+
+int mlx5_esw_spf_get_host_number(struct mlx5_core_dev *dev, int spf_idx,
+				 u16 *host_number)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+
+	if (!mlx5_esw_allowed(esw))
+		return -EPERM;
+
+	if (spf_idx >= esw->esw_funcs.num_spfs)
+		return -EINVAL;
+
+	*host_number = esw->esw_funcs.spfs[spf_idx].host_number;
+
+	return 0;
+}
+
 u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
@@ -2072,6 +2117,16 @@ u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev)
 	return esw->esw_funcs.hpf_host_number;
 }
 
+bool mlx5_esw_has_spf_sfs(struct mlx5_core_dev *dev)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+
+	if (!mlx5_esw_allowed(esw))
+		return false;
+
+	return esw->esw_funcs.has_spf_sfs;
+}
+
 static int mlx5_esw_hpf_host_number_init(struct mlx5_eswitch *esw)
 {
 	struct mlx5_esw_pf_info host_pf_info;
@@ -2198,6 +2253,8 @@ static int mlx5_esw_spfs_init(struct mlx5_eswitch *esw)
 
 		esw_funcs->spfs[esw_funcs->num_spfs].vport_num = vport_num;
 		esw_funcs->spfs[esw_funcs->num_spfs].vhca_id = vhca_id;
+		esw_funcs->spfs[esw_funcs->num_spfs].host_number =
+			MLX5_GET(network_function_params, entry, host_number);
 		esw_funcs->num_spfs++;
 
 		entry += MLX5_UN_SZ_BYTES(net_function_params);
@@ -2224,6 +2281,7 @@ static void mlx5_esw_vports_cleanup(struct mlx5_eswitch *esw)
 	unsigned long i;
 
 	mlx5_esw_spfs_cleanup(esw);
+	esw->esw_funcs.has_spf_sfs = false;
 	mlx5_esw_for_each_vport(esw, i, vport)
 		mlx5_esw_vport_free(esw, vport);
 	xa_destroy(&esw->vports);
@@ -2232,8 +2290,7 @@ static void mlx5_esw_vports_cleanup(struct mlx5_eswitch *esw)
 static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 {
 	struct mlx5_core_dev *dev = esw->dev;
-	u16 max_host_pf_sfs;
-	u16 base_sf_num;
+	u16 max_sfs, base_sf_num;
 	int idx = 0;
 	int err;
 	int i;
@@ -2270,10 +2327,10 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 		idx++;
 	}
 
-	err = mlx5_esw_sf_max_hpf_functions(dev, &max_host_pf_sfs, &base_sf_num);
+	err = mlx5_esw_sf_max_hpf_functions(dev, &max_sfs, &base_sf_num);
 	if (err)
 		goto err;
-	for (i = 0; i < max_host_pf_sfs; i++) {
+	for (i = 0; i < max_sfs; i++) {
 		err = mlx5_esw_vport_alloc(esw, idx, base_sf_num + i);
 		if (err)
 			goto err;
@@ -2295,6 +2352,22 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 			goto err;
 		vport = mlx5_eswitch_get_vport(esw, vport_num);
 		vport->vhca_id = esw->esw_funcs.spfs[i].vhca_id;
+
+		err = mlx5_esw_sf_max_spf_functions(dev, i,
+						    &max_sfs, &base_sf_num);
+		if (err)
+			goto err;
+		if (max_sfs)
+			esw->esw_funcs.has_spf_sfs = true;
+		for (int j = 0; j < max_sfs; j++) {
+			err = mlx5_esw_vport_alloc(esw, idx,
+						   base_sf_num + j);
+			if (err)
+				goto err;
+			xa_set_mark(&esw->vports, base_sf_num + j,
+				    MLX5_ESW_VPT_SF);
+			idx++;
+		}
 	}
 
 	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index abdb4c460b06..88041dd8a39d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -351,6 +351,7 @@ struct mlx5_host_work {
 struct mlx5_esw_spf {
 	u16 vport_num;
 	u16 vhca_id;
+	u16 host_number;
 };
 
 struct mlx5_esw_functions {
@@ -359,6 +360,7 @@ struct mlx5_esw_functions {
 	u16			num_vfs;
 	u16			num_ec_vfs;
 	u16			hpf_host_number;
+	bool			has_spf_sfs;
 	struct mlx5_esw_spf	*spfs;
 	int			num_spfs;
 };
@@ -878,8 +880,14 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport);
 struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u16 vport_num);
 
 int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *sf_base_id);
+int mlx5_esw_sf_max_spf_functions(struct mlx5_core_dev *dev, int spf_idx,
+				  u16 *max_sfs, u16 *sf_base_id);
 
+int mlx5_esw_get_num_spfs(struct mlx5_core_dev *dev);
+int mlx5_esw_spf_get_host_number(struct mlx5_core_dev *dev, int spf_idx,
+				 u16 *host_number);
 u16 mlx5_esw_get_hpf_host_number(struct mlx5_core_dev *dev);
+bool mlx5_esw_has_spf_sfs(struct mlx5_core_dev *dev);
 
 int mlx5_esw_vport_vhca_id_map(struct mlx5_eswitch *esw,
 			       struct mlx5_vport *vport);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index f17db51abe2d..c229a96a111f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3821,6 +3821,9 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb,
 
 bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 controller)
 {
+	const struct mlx5_esw_functions *esw_funcs;
+	int i;
+
 	/* Local controller is always valid */
 	if (controller == 0)
 		return true;
@@ -3829,7 +3832,15 @@ bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 cont
 		return false;
 
 	/* External host number starts with zero in device */
-	return (controller == mlx5_esw_get_hpf_host_number(esw->dev) + 1);
+	if (controller == mlx5_esw_get_hpf_host_number(esw->dev) + 1)
+		return true;
+
+	esw_funcs = &esw->esw_funcs;
+	for (i = 0; i < esw_funcs->num_spfs; i++) {
+		if (controller == esw_funcs->spfs[i].host_number + 1)
+			return true;
+	}
+	return false;
 }
 
 int esw_offloads_enable(struct mlx5_eswitch *esw)
-- 
2.44.0


