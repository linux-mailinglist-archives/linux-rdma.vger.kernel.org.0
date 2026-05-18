Return-Path: <linux-rdma+bounces-20879-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAvZFre8Cmrb7AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20879-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:16:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E27A65674BE
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674593020EBC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69A3CF692;
	Mon, 18 May 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6lQ9srm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A9327204;
	Mon, 18 May 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088532; cv=fail; b=WqhfMh6CoEHPzyUpfOZOSFYyDg34ajE+yoPj2h4wtM8DVoaIBAsZWR88FprPfjO5bkyjABWBP1q9fNjRNYh/2rrUGqqmpXT9l2NjxRJy1iwOclq8aPZyyQPKM7kROV8BLxQ/okZCZr1vyulC6FCAwsj/1ehXiNuGmBukxSOljzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088532; c=relaxed/simple;
	bh=H4hXwnLJFJpfzzGXbiQbvTVznHVhQ8weOqWn+iJaQAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOAIr/E0k42JZbEVohgwvKGMtyRqQvll6NNlko3XzwtlAB2TdpsZWYdICoXk0ISnKszx0mCKTZvmVh7MGXPadTGmYSFrh5SpqtRHuSp22CI/QEYW8lvzaIOZNUYzwMrpPU0IOgEC/Vpfw2heAAYnN7ovwW3aLPqH/E93sJJGEG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6lQ9srm; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kj3G/B2lEZ4CUintPHP0Uf9Q416ihJXCkyMsjXLkJ92pjVOFOvQJyLvD6XyM4oVjyCDhAFHbO8HjuxFF1c3CAIczPS0z/XrioDOVBq1C8Hro6fc8fN643LsFp+mQc016PHf0k/YbDZKSjfEvnXDlaKcSEExcEbSmGSa4Gi7dODB+PByennFpTnDuBUB8/Y73EExk9hRlrwVjjslVCfGrXd5aDPyWFWa8p9Dkt+WcOSPPnFeYcelXsjq6PsX2IGvcmorB1Qxe610yPZ/EEPIYxE7lh9gZWVWwA0AC88soE2U/Py70V0AOmeqNGX+ZYnJMndAOnPdm/n+FU5ImmD17nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqNRFrbQML1SBZp9yspiz/OB9A4G0PM5gmJVxRpoUjQ=;
 b=AGgI43TQNPWH0ODHRn53C5zVrciidIZXP9mK2ubHByg4V6AQHsXSFXWgTlusg4ZvHsUnKqjCVOpozbHQSkpTu4YcF67wILHzaXkYNQyGWiD4mxlpe23qt0+lT9C5/g8gUg3Q9wyjFFxcTkLHQLOQb+RXj0ZZDGeXry4q7lhAXzZlCNnfXNZG/Z4/xN+gZB0ZvngO4xfp3/LrhmENPB1uV6duvYFJWLVWIqjTBcFn57qYK1lB6K3qJn/zg6xNXPUKvHVu0Y1iq2FNqmrrPXX77Agt68pdV8V7xYfLQLRX3smC01K/ZfaIS+E09qrLSwQJnXBiUX47oRt5YtlrhhQYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqNRFrbQML1SBZp9yspiz/OB9A4G0PM5gmJVxRpoUjQ=;
 b=h6lQ9srm0b3p7vSb7eAkKMRKoHsyaiUJObTnfzBQISMDuF+jAUcYJBNonh1skKPqOqQM1NNDV+d7expMbgV+P8iTkKUbTz89Z+Nax9tvjfBQoEcmktcZ73WIWyZvZonhCFIfyTedS6THoygoGNo5PM6JMpiM6dt3M1vFfSD/aP4+POdyBoonlrTzXUORluGYyxnkTqmrtfxkXtO/neRwEEhscafRco6wkfSIt1nTMwEnwuGEPscRWcvz2ZbRZzgoWgLMJ3zKgyB00jAJWa94OmSSXbL268fbEgbPKAR22506gAt3agrhDEMMOMpDzePL6g7yDSiQ8DzDUtkrPbGmCA==
Received: from BL1PR13CA0404.namprd13.prod.outlook.com (2603:10b6:208:2c2::19)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:15:26 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2c2:cafe::47) by BL1PR13CA0404.outlook.office365.com
 (2603:10b6:208:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11 via Frontend Transport; Mon, 18
 May 2026 07:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Mon, 18 May 2026 07:15:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 00:15:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 18 May 2026 00:15:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 00:15:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 3/8] net/mlx5: Use mlx5_eswitch_is_vf_vport() for IPsec VF checks
Date: Mon, 18 May 2026 10:13:51 +0300
Message-ID: <20260518071356.345723-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260518071356.345723-1-tariqt@nvidia.com>
References: <20260518071356.345723-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: a8339bb8-05e8-496a-62ff-08deb4ad3bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	puuQal2tYK9s35Xp0ZiH4i9U6r97JjbtW3zaWiCY0E/l4XuYBkGh2ZIsChiiLMCICpggnWo3Xj4toOkBuoNwlfIHjQig+Jz/6UpjliX3Tjpa74jjJmp1gR2vC3vNeQnqTcQGmUL7gnA6spDj3MA9K/ZTwVFj9l4Z8ty97NJNii7aL9BgrTy/8f0QgCA04X38r+9YX1DsQ98hS1wu17MtpJb5aRFndYduW0+Gxg5/1r498OiL6vS2aHTTd2imck4arYrKwdkL7xQi2CfK/df1r02ZFLHC5rwP5SIwyYVoAZByEtiEVDMdW7eG8cMz98CIGVys/1TZxcxKHoQMtizL2aDkgN4wCWPwwAZjKQiH0XdYGlPEMa2wZ2ifEmIJ+++ZXNjg4nt/R0qD7MfY6MS9hzR7/LvJESdF3tNalJhkAAcmQ5+5YyolEgzDBkgWnjcXFYsEDq6VEWT5nZAIaBL6y84aDfK1DxSHvwJ2ILesip3KniROUeyyUlOJedg5PkzuJnvu4qpL5qsX8cGoJd7hK06f0p4LeOSbl/1jDM4aifFxeRTs3uJt518f8OZjiAm3HhVztG0Azy0a0yUoPIfbmf3B0PiQQ/jIb1JQCiMIPORLkFna4Ce7fEjQJndlnvHfNp6vzKgYeNIjIOZOaqzli8fayOv6mPabJQURDq0WcaVNwyvbSd/nRGBMzgSLQV+XT7+Bv8TKzOnaVAw36Q+bBocBfpZbRWW9Wi1PRCVs3EU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AP9axiEydR+c2w4W0fD4wKO2MLij82xtZ6lH+Ai0fZv5coIiTsqC7JFH7cPtIegcuzfPwfp05TT3kAJXsHoAtOeQSjBfA9ysKUGyQXf7Un+5FeXXwPKThPNHI9e0F33zGIxv5UowtBKzH8Idc8DdoDZi1bjxqPwwg3PW1TPbiOHP3adTnQYtSz6iO1fj3Ia7M72g4fFv+meeoJYA3YMOyfEeNyGnveo71//4PmiDCaUWToTsOJbRVAHgxIIxyZ+aUAztoXOZqae16LFeXQPEzdaxOyVATtS6fV0+Gep282Y+bQmIUrNBjD43XwdnfObSQtAtIsV1J43D4Y17bsoAy4znIaPt6gmaIGSnl2ujXcBAsDTXUEJKF6dMVZfciS2ncyz1KuDOCVsDH2Dofk+6iVKS1OVuK4mpwh3PscoiOxpt6YQ9FWVZemEBTWnVuHTZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:15:25.7770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8339bb8-05e8-496a-62ff-08deb4ad3bdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Rspamd-Queue-Id: E27A65674BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20879-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

IPsec eswitch offload operations and the enabled_ipsec_vf_count counter
are intended for VF vports only. Replace the MLX5_VPORT_HOST_PF checks
with mlx5_eswitch_is_vf_vport() to properly identify VF vports, as
preparation for adding another type of PF vports.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
index 4811b60ea430..b830ccd91e62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c
@@ -209,7 +209,7 @@ static int esw_ipsec_vf_offload_set_bytype(struct mlx5_eswitch *esw, struct mlx5
 	struct mlx5_core_dev *dev = esw->dev;
 	int err;
 
-	if (vport->vport == MLX5_VPORT_HOST_PF)
+	if (!mlx5_eswitch_is_vf_vport(esw, vport->vport))
 		return -EOPNOTSUPP;
 
 	if (type == MLX5_ESW_VPORT_IPSEC_CRYPTO_OFFLOAD) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 8b62dde7eb70..9a7de7c9a667 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -958,7 +958,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 	/* Sync with current vport context */
 	vport->enabled_events = enabled_events;
 	vport->enabled = true;
-	if (vport->vport != MLX5_VPORT_HOST_PF &&
+	if (mlx5_eswitch_is_vf_vport(esw, vport_num) &&
 	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count++;
 
@@ -1020,7 +1020,7 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 		mlx5_esw_vport_vhca_id_unmap(esw, vport);
 	}
 
-	if (vport->vport != MLX5_VPORT_HOST_PF &&
+	if (mlx5_eswitch_is_vf_vport(esw, vport_num) &&
 	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
 		esw->enabled_ipsec_vf_count--;
 
-- 
2.44.0


