Return-Path: <linux-rdma+bounces-21965-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rTIFKj7NJmonkwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21965-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:10:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F9656F6A
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:10:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rd7h3okf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21965-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21965-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 104E030E69FD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE93C455C;
	Mon,  8 Jun 2026 13:57:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9933CA487;
	Mon,  8 Jun 2026 13:57:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927064; cv=fail; b=pLZXp2e1ffg5Sw7PCDbAYSV3YuMB6O3N/44MRGzlQC6dEwUd7sL3B6s2e35zhDwbha8DyV/OQQR3485iU02a+MUiAwtOHL5XMIGSCBL4A/jiQ+44Hh6icWnShPJODq1dvjvKFVyzHuKlzTQmYqZPSJDEAPZZfmtwyT2FmDCuZVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927064; c=relaxed/simple;
	bh=w4fudAUrsfs8OV+RQdF2wdrGmqtNf8RYS0nHzxWjrc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8NVyPUAzmZIX0iYlMe4TOvJ68s3Pf4r4ma+j7C1sIcMxiE7ir7sOhe8vZ9OrM9mbUe42MsRr9XTZvQoTEcvCL0ucAUVTDn4MtcbFL89JnqKy8j2fmSmZaAHmJViLJQuRTrhoMV5w4r2XHOoxPRjIK1WYn3oSJJTIRmc7DtaMJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rd7h3okf; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGMN9zgv7/HF9cJZJX3VWClwGXBcSwYBA0GAl0fG6IXRXbvsxC4t/qPc4wso/5As7o7nJwhUjw3X9x5KvmsX4Ma8+UK4C+DySmDW61FrH0NzrTbP9lWTjltcABLQHAY02HhN/DEfz8gAxSRfV8EEFyZzdITU+p53g/byyk2TUVlIDth/tFtQcWsxxYNILPSOeVeysvDhaTssCoNseYfmH0/hbxXywH41TvnrM/P/7CuDjLcrcliFi4VNbTP8+k9qSpPtvdx970WdIA4zHc6jbsVyClHDcvkSqw6bmIblcSJ5F+qKZjN4DyuUgtwryBQZkq1oyKSCafBG7GL+dZ+MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQqTVF3YT+eeCFavOzl4T46VlTOHIN6EbNMsEU7zuZ0=;
 b=w0o4L8DePxyvJ6ZzpN2Z6Z6DZuzd5ntXO9oIJZfa8tfuTmmW/HNf2LKFHsI1b7YllRqPn/euFohs3mi5PKbehmWNUjRW+s6F7qfv2krruBtQeNOIJp7XSc+Xd+3BomXEdJ3KyV0nJ2bsLpEeQNpDC+LPblfsWW5aOR21z5CoNxn33AiKIycNsqoSkEZHgBtxsw+1jP34I9C7ATchzTNLCqjhRwVKwOmrVcllzW2uNMRcv0Hk53BH6boZk+WYTSFzr10OkqOH2nhHG1i45umwjNt9PZO9NHhmFnmBZNg/B3VfeLqP02yQ7cjwasr44arC3J4MKrcbhbHAnZz6FV+X8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQqTVF3YT+eeCFavOzl4T46VlTOHIN6EbNMsEU7zuZ0=;
 b=rd7h3okfc9X7AdGmz7WFpC4aGz8yQomqS9m9A40TmiJrHD7xSpjNNsMZ02scVJIV0uBUEpZ/u1Vc0CojK2VOhEcqahTXPuX+5+3tjtVEloJoTk/UgdA3YqZY53oR+NkGvqmSucodWi91FM2Vq5mnAWMl7919FxQsyzknMxlHnPa5dX4i/hzv0Sx5C/GdVh9iJ+wWYlKklirO9ACzNof0FMVGF50CulHOSlMDbajRMzlScEi2gjW1OF75W6GTbiTxkTEUye1xQixjDHjmBVziobbQk40VTkQBc/iWOoAVS+Jz+VFBiCj3cNtBI+ibP8otyE+xni3xdk5c0OtBNIFvjw==
Received: from BL1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:256::10)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:57:32 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::9b) by BL1PR13CA0005.outlook.office365.com
 (2603:10b6:208:256::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Mon, 8
 Jun 2026 13:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 07/15] net/mlx5: SD, support switchdev mode transition with shared FDB
Date: Mon, 8 Jun 2026 16:55:39 +0300
Message-ID: <20260608135547.482825-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af14213-483b-4550-2441-08dec565e2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	7oP0CMcEmVak+iw/cObSiGaXUJjtyqTzcdCWoODfxLKMYu76/r7hxy+as5NGlpWdcbilMQP+ke+RxJ/jm8VLSL82i+1OCSj/LjMxk/si+Y6Afoe3DT4kxMVVH/XU9AQxnPkl44SrSrzRUi95pc6XZuTEEpoj7Rr83aYNjDEwWaEk7BqoZXDQurKUWosJ6yc+fZR5h94CZbDKvKYq8a4xd32VfGOfeOxwGNfGjRhcSlV5/pDtzd3qmorWQLZ83GYOdtxplejNJkr2097UcLddJ2/TGWsO9ltaxUsZ6XQYIEBojonZsBjyN95uVvBNwE5OxDfgPn/rKLyClUTmfJDIWG0+HTCaUG+kf9tggdDk/WTicjFLycR5XZzUmZDyMPFEMi4dFAhozQuMsJg1FclTWUcdJ9Zx5IBRAVzmEB65kCr3gWB6cB6CD6VT8vusF9rwKDiLBE5ij5W95RMtvON/hM7TTIJ6vsR74IfcJkY/psXunUKEVCzjyMoZhfR8SaFZQz2J5q/F1E3p7mc1TsE9MViJNjjJZABaxIsndk/ukohpszfEm5OzXiK+52CYlRhKb3Biy64F4kZN4rT2q+A+qYqyPSXpTXIYi7EjYS7ZxtI9tcphY3CwMAtwGsoQj1mYRTNdLZfmiWS+mYU0uCrP+lJM7TQuXyU/eEMoUQRHFetyfx8jp8TV98rCMn9OKVJmg9R88Pg0v6PY4UVchps4tfXgRopYO8neMwrTpHoyObg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d2cU+/mm7jCXcyfk8U6QY0k2GsMwJniemeTYyVM4E0rfhXPNOdTW1MsPx6wCq5x0LYHiF8A0E5P6yT9aEF2XVX/+ddPdMXaiDiLulkyt8x6Yai2bBQnMheJl6Biqg0t4HoblNpwWGbzP6O0qnAN/87xDwAK+NYJGk7Pcy6jBW+e9tU2BWDWr+xmFkRFehWxJ99fAzfmuTU9/qkXMS0XiEJvssJQLfKZD3YSIvk5W7C8WH/K+O7XYfYKXyYRhuZlPyXyYml1KC4JekqU5IVGO6Q26HValewD+RVcg4hrs5vd2vT/nqXftAtzPESuTtCVmJMVCVOJiKh47ndRh8ulkjywmp5/ATRlbygo2p0jv0R2jLSmatYkqauexub5bqQSWl/zNxhbge9Dk9leabPa3sC65s+A264qsueXVbo+bOmfE/hnAczOyN4SO/F3JN6ha
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:31.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af14213-483b-4550-2441-08dec565e2c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21965-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D68F9656F6A

From: Shay Drory <shayd@nvidia.com>

When the eswitch transitions, propagate the change to SD: secondaries
get their TX flow table root reconfigured for the new mode, and when
all group devices move to switchdev, the per-group shared FDB is
activated.

Shared FDB activation is best-effort - failure does not block the
eswitch transition; the next transition retries.

Note: the existing mlx5_get_sd() guard that blocks switchdev for SD
devices is intentionally retained. It will be removed once all
supporting patches are in place.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     |  12 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 137 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |   7 +
 3 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 366531d8ef02..915571a1586c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -46,6 +46,7 @@
 #include "fs_core.h"
 #include "lib/mlx5.h"
 #include "lib/devcom.h"
+#include "lib/sd.h"
 #include "lib/eq.h"
 #include "lib/fs_chains.h"
 #include "en_tc.h"
@@ -3164,6 +3165,9 @@ static void esw_unset_master_egress_rule(struct mlx5_core_dev *dev,
 	vport = mlx5_eswitch_get_vport(dev->priv.eswitch,
 				       dev->priv.eswitch->manager_vport);
 
+	if (!vport->egress.acl)
+		return;
+
 	esw_acl_egress_ofld_bounce_rule_destroy(vport, MLX5_CAP_GEN(slave_dev, vhca_id));
 
 	if (xa_empty(&vport->egress.offloads.bounce_rules)) {
@@ -3182,6 +3186,9 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 	if (err)
 		return err;
 
+	if (!mlx5_sd_is_primary(slave_esw->dev))
+		return 0;
+
 	err = esw_set_master_egress_rule(master_esw->dev,
 					 slave_esw->dev, max_slaves);
 	if (err)
@@ -3401,7 +3408,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
 		return;
 
 	if ((MLX5_VPORT_MANAGER(esw->dev) || mlx5_core_is_ecpf_esw_manager(esw->dev)) &&
-	    !mlx5_lag_is_supported(esw->dev))
+	    (!mlx5_lag_is_supported(esw->dev) && !mlx5_get_sd(esw->dev)))
 		return;
 
 	xa_init(&esw->paired);
@@ -4306,6 +4313,9 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	mlx5_esw_unlock(esw);
 enable_lag:
 	mlx5_lag_enable_change(esw->dev);
+	/* Shared FDB activation is creating LAG which is changing reps. */
+	if (!err)
+		mlx5_sd_eswitch_mode_set(esw->dev, mlx5_mode);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 8b1f3a25d80d..9ff62c134c2a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -5,6 +5,8 @@
 #include "../lag/lag.h"
 #include "mlx5_core.h"
 #include "lib/mlx5.h"
+#include "devlink.h"
+#include "eswitch.h"
 #include "fs_cmd.h"
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
@@ -33,6 +35,8 @@ struct mlx5_sd {
 		struct { /* secondary */
 			struct mlx5_core_dev *primary_dev;
 			u32 alias_obj_id;
+			/* TX flow table root in switchdev (silent) config */
+			bool tx_root_silent;
 		};
 	};
 };
@@ -669,6 +673,29 @@ static void sd_secondary_destroy_alias_ft(struct mlx5_core_dev *secondary)
 				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
 }
 
+static int mlx5_sd_secondary_conf_tx_root(struct mlx5_core_dev *secondary,
+					  bool disconnect)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(secondary);
+	int err;
+
+	/* Idempotent: skip if TX root is already in the requested state. */
+	if (sd->tx_root_silent == disconnect)
+		return 0;
+
+	if (disconnect)
+		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
+	else
+		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary,
+							 sd->alias_obj_id,
+							 false);
+	if (err)
+		return err;
+
+	sd->tx_root_silent = disconnect;
+	return 0;
+}
+
 static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 				struct mlx5_core_dev *primary,
 				u8 *alias_key)
@@ -688,7 +715,8 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 	if (err)
 		goto err_unset_silent;
 
-	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id, false);
+	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id,
+						 false);
 	if (err)
 		goto err_destroy_alias_ft;
 
@@ -707,7 +735,7 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
 	struct mlx5_sd *primary_sd;
 
 	primary_sd = mlx5_get_sd(mlx5_sd_get_primary(secondary));
-	mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
+	mlx5_sd_secondary_conf_tx_root(secondary, true);
 	sd_secondary_destroy_alias_ft(secondary);
 	if (!primary_sd->fw_silents_secondaries)
 		mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
@@ -936,6 +964,111 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 	return &primary_adev->adev;
 }
 
+#ifdef CONFIG_MLX5_ESWITCH
+/* All SD members must have completed esw_offloads_enable (i.e., reached
+ * mlx5_esw_offloads_devcom_init) and become eswitch-peers of the primary.
+ * Until then, mlx5_eswitch_is_peer() returns false for the not-yet-paired
+ * member and shared_fdb_supported_filter would reject. When all PFs transition
+ * in parallel, only the last one to finish satisfies this gate; the earlier
+ * ones return 0 silently here.
+ */
+static bool mlx5_sd_all_paired(struct mlx5_core_dev *primary)
+{
+	struct mlx5_eswitch *primary_esw = primary->priv.eswitch;
+	struct mlx5_core_dev *pos;
+	int i;
+
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		if (!mlx5_eswitch_is_peer(primary_esw, pos->priv.eswitch))
+			return false;
+	}
+	return true;
+}
+
+static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	int err;
+	int i;
+
+	ldev = mlx5_lag_dev(primary);
+	if (!ldev) {
+		sd_warn(primary, "Shared FDB MUST have ldev\n");
+		return;
+	}
+
+	mutex_lock(&ldev->lock);
+
+	if (ldev->mode_changes_in_progress)
+		goto unlock;
+
+	if (!mlx5_sd_all_paired(primary))
+		goto unlock;
+
+	/* Check if SD FDB is already active for this group */
+	mlx5_lag_for_each(i, 0, ldev, sd->group_id) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->sd_fdb_active)
+			goto unlock;
+		break;
+	}
+
+	if (!mlx5_lag_shared_fdb_supported_filter(ldev, sd->group_id)) {
+		sd_warn(primary, "Shared FDB not supported\n");
+		goto unlock;
+	}
+
+	err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, sd->group_id);
+	if (err)
+		sd_warn(primary, "Failed to create shared FDB: %d\n", err);
+	else
+		sd_info(primary, "Shared FDB created\n");
+
+unlock:
+	mutex_unlock(&ldev->lock);
+}
+
+void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode)
+{
+	struct mlx5_core_dev *primary;
+	struct mlx5_sd *sd;
+	int err;
+
+	sd = mlx5_get_sd(dev);
+	if (!sd || !mlx5_devcom_comp_is_ready(sd->devcom))
+		return;
+
+	mlx5_devcom_comp_lock(sd->devcom);
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		goto unlock;
+
+	primary = mlx5_sd_get_primary(dev);
+
+	/* Secondary devices need TX root reconfiguration */
+	if (dev != primary) {
+		bool disconnect = (mlx5_mode == MLX5_ESWITCH_OFFLOADS);
+
+		err = mlx5_sd_secondary_conf_tx_root(dev, disconnect);
+		if (err) {
+			sd_warn(dev, "Failed to set TX root: %d\n", err);
+			goto unlock;
+		}
+	}
+
+	/* Try to activate shared FDB when all devices are in switchdev.
+	 * Shared FDB is optional - failure here doesn't fail the transition.
+	 */
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)
+		mlx5_sd_activate_shared_fdb(primary);
+
+unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
+}
+
+#endif /* CONFIG_MLX5_ESWITCH */
+
 void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
 		      struct auxiliary_device *adev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 7a41adbcee71..cb88bf34079a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -45,6 +45,13 @@ mlx5_sd_get_devcom(struct mlx5_core_dev *dev)
 }
 #endif
 
+#ifdef CONFIG_MLX5_ESWITCH
+void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode);
+#else
+static inline void
+mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode) { return; }
+#endif
+
 #define mlx5_sd_for_each_dev_from_to(i, primary, ix_from, to, pos)	\
 	for (i = ix_from;							\
 	     (pos = mlx5_sd_primary_get_peer(primary, i)) && pos != (to); i++)
-- 
2.44.0


