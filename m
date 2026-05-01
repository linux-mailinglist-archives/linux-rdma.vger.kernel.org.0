Return-Path: <linux-rdma+bounces-19825-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHAvDiMs9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19825-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:29:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF234AA571
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BE353040441
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A482FF66B;
	Fri,  1 May 2026 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQRj7cqt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A929ACF7;
	Fri,  1 May 2026 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609098; cv=fail; b=sZmKXocx+0DY1+/0rCsXpffwbvV9WNL5yoPbCx4HdEd41CxK5nNAkpMg+qGhTVYwzMP+1JKm1ajnKZRrU4otpo8QnxL+koc0G2rQ8+LmB5OypsPWJBhUMEK1IgeO6AOjH1zbss6Hi+hsKTuRZKMEsI170tIozWPg6Si8DYRPuIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609098; c=relaxed/simple;
	bh=l66hHtKVpxBvGz9836qhT47MRfUtCDdVrrKx+xIPbYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t81HbPC3QLIvpaxM2TqdmnZulXvX83UwK6dj5yC2xd/k+nQoEutJJbCWKOPnhbC2WbUqEXDMHoCojWGEgjNL2PcDDuV3pHHAeevw+HRSSsikaiYpycHhBiqvDj+Jruz9DHgePgTUuyDu/zrDDwro4Wfke8JMCO1kWE35QbnzAkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQRj7cqt; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnVkuPdA7mrQRw4Lca3PjT3frZKpdKpb/YGgQdsLrHOI0gLL5Up+cEUxuDfo1VO5rtSgP04k8ODOD/g2mEy5HHlqK/32h6yEAqVL44EufCLnaK+ViNc3Jax59e/GTJ2KFGELebQHstEjC0L7GBqCZ8lVoMKhAqDF/yC5SoYWH9zRMsmHEma3ryjXJxqLhQSb7X2HszUu/vp4Bp4O87eB0tu8rz84Ew9ivbhXC6lXayF8esqOaj0kN4Nzvm3ZeMvdsecOosbV796X0HQubBkzrI3Y/HpsYqAjaE3gp+1/8xBVu+Ufj8i4OJ/WjS/zBr+JpNR+E/8fr6PQew35Gjz4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwJhjQTMMlNGkts5Zb4PSJpGDpwAbJ6i06E8cH+ae5w=;
 b=D4a8TTruf8HDewj4NHbc5nUXDfZoSQce6XK2bK7AmReTJAsmNH5cUQ5MoYJCI+ueNPgUyQEVIIp8pDO24SFactrBwO/f2qtdUT6+5itBSl7KwhQtmYBP4gkZG9MueWbF37vlrCo96z4cDg4nbZwAyz8Lz4gdkOOR1+u7RjLIGJwTWn6pynui9gw1Xn/XBdkW3D2Cp++kikgxTZAK8CqvM18oXAvH1ajbod65ieMs+W5W80w8m+yXUfX6RlZxzjPRWRq5d4A4s0/9aWh7FWDhCCIKaXURXXp98iMMIwxfgOikHOztRybH6IB5tHUICI/xXt39Bduflbut/u7kSYH01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwJhjQTMMlNGkts5Zb4PSJpGDpwAbJ6i06E8cH+ae5w=;
 b=hQRj7cqtIRbWbe3SkiYJd+lSgoLSQWH7lYCfu/ANnNQGSGsnRjefUiUg+UNexpFO8Z3RLoPSsUQ799STfZLKzmyzgMETXjzp/f0mt7HGUCiN7J/5RsfDrc7OuihuK8sESK+WQxIQBslcsNQbXOfvFQ+2k1khQoRBXoWAQUb66oWPtSXFj6bUcYt44M6PzeX7NMT/ZFryBnEpgY3+Z0ohXWaMl5HKu3OyOp/NfhFTgGpyZkVuoau11wh7nprP8gK+snzZ87VF/clXhf0gP9sBLzJOjKk6SEQVU8pdl0YlyTztO6kV1ox8nUXI1hbRKwMjGVVfBLLGqM0BHY7My2wOrg==
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Fri, 1 May
 2026 04:18:12 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::23) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 04:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:18:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:17:50 -0700
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
Subject: [PATCH net-next V2 5/7] net/mlx5: E-Switch, unwind only newly loaded representor types
Date: Fri, 1 May 2026 07:16:31 +0300
Message-ID: <20260501041633.231662-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: fc394765-8a62-4292-1704-08dea738a875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	usY6XojpEnC7Ai2RkBwxD0skeh/yx+TrEf/oqVsu8kQ361OAH0GeYg7Be5V6yY5N2LMQ1ko/3EFAk1N6NvryPoxIj2/B46xTZ1l9FW92WHmsB/NX5D9SWrnEfRkVrqre8l/FIbtKomYLn1QW9w03o/gm9IYjKF/eayU0BQ/GrdtgxDhNT6OffoTctWIRpp79YsMoYry20qyZOe1pONhRf48wktINuitrioXvOpxvSNyt1g5Gj1Bk0Yhve7lR4dzdk8+SSRhVdhPYKwfP4hvNdL+znVQF+wfUNiJAB8ZqoDRFKQwapaV54JpTMB3Oeoe7aRy/Zdp0zt/Hy/JjCeUyo2q0yAu1EyPCZ0ljVk1WJnybOwJjOrU5jEqaNALto7YsdZ5uL++ftGbWkid96tlMPd4E4TX1C5gkIPdFmQDEN9JtqZNzV87IDfwTweNahoyM6ueQSZPShyuhqtorOe2PHsi9cW+ky8kHBk9pufBabtSq1zwD+e1O8MXKRW9MKthV9yckY8xvk8SiUttVGf4HP2aY14NuVjJ3GoXbN0uQXg8T+FAgOjzs5PDP9lTG2SYYyuScQofBssUDpO+zZANMSTBKRqFUaZWbEjItjhSfFV7TLx683gScmMBZf5bgstu95wgH2v8+nqJcdkW88phgdxSiYF83Bo0JiDDVykU7+2sX3cLSrf0ZV0CixwUc/Ypy4iqUoPFOGnXdJAqoIV7koC0UHUOdulkRfgmnlMJ4vtc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p9mMedaHHuP0kd5QXnzGls05B/nZg61lF2unD4ByQxTXcbKLc10yzFZ6MYdmn0i3H+H44FCmv5JPhNV2Jtyu6ZHxFBBxUlxSsNXe6igrdeCSOUmBvLi2gQG/BXlBRdtXpvmOmFEhSKawK2/7dbsPznLT9aRIs5mqoupy3UyqQwx3MocoHGX1U1mCl67HOfZkMnfj15Gy8DMs4GQxd0wuQLwHWD0tVLnVqzS9RawSA2lHxOoZMeMCxsXj/POxD7GYA/PFxuQaJWtc2RsFD6jIWrygiktWY5f66sldJE2p78VuRGiCfbP5HB3+yoU4TCx2BGwwz0lIxJEnRwYgp1nujUoKS1RYAmx0TCP3Fj7dnzqfl7yfa77sfN88Nx7AntyZnQQqs7OiGBB+mf8OZ1ybOn5yXQOhKvXj2u5uiMkKMDV0vWLFs1oNTKQjaneE/fJY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:18:11.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc394765-8a62-4292-1704-08dea738a875
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
X-Rspamd-Queue-Id: 3EF234AA571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19825-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

__esw_offloads_load_rep() may return success without invoking the
representor load callback when the representor type is already loaded.

On a later load failure, mlx5_esw_offloads_rep_load() unconditionally
unloaded all previously iterated representor types. This could unload
representor types that were already loaded before this load attempt.

Track which representor types were actually loaded by the current call and
unwind only those on error. Also restore the representor state back to
REP_REGISTERED when the load callback itself fails.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d4ac07c995b9..8f656253981b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2786,13 +2786,28 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
 }
 
 static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
-				   struct mlx5_eswitch_rep *rep, u8 rep_type)
+				   struct mlx5_eswitch_rep *rep,
+				   u8 rep_type, bool *newly_loaded)
 {
+	int err;
+
 	mlx5_esw_assert_reps_locked(esw);
 
+	if (newly_loaded)
+		*newly_loaded = false;
+
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
-			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
-		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
+			   REP_REGISTERED, REP_LOADED) != REP_REGISTERED)
+		return 0;
+
+	err = esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
+	if (err) {
+		atomic_set(&rep->rep_data[rep_type].state, REP_REGISTERED);
+		return err;
+	}
+
+	if (newly_loaded)
+		*newly_loaded = true;
 
 	return 0;
 }
@@ -2822,22 +2837,27 @@ static void __unload_reps_all_vport(struct mlx5_eswitch *esw, u8 rep_type)
 static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	struct mlx5_eswitch_rep *rep;
+	unsigned long loaded = 0;
+	bool newly_loaded;
 	int rep_type;
 	int err;
 
 	rep = mlx5_eswitch_get_rep(esw, vport_num);
 	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
-		err = __esw_offloads_load_rep(esw, rep, rep_type);
+		err = __esw_offloads_load_rep(esw, rep, rep_type,
+					      &newly_loaded);
 		if (err)
 			goto err_reps;
+		if (newly_loaded)
+			loaded |= BIT(rep_type);
 	}
 
 	return 0;
 
 err_reps:
-	atomic_set(&rep->rep_data[rep_type].state, REP_REGISTERED);
-	for (--rep_type; rep_type >= 0; rep_type--)
-		__esw_offloads_unload_rep(esw, rep, rep_type);
+	while (--rep_type >= 0)
+		if (test_bit(rep_type, &loaded))
+			__esw_offloads_unload_rep(esw, rep, rep_type);
 	return err;
 }
 
@@ -3591,13 +3611,13 @@ int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 	if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
 		return 0;
 
-	ret = __esw_offloads_load_rep(esw, rep, REP_IB);
+	ret = __esw_offloads_load_rep(esw, rep, REP_IB, NULL);
 	if (ret)
 		return ret;
 
 	mlx5_esw_for_each_rep(esw, i, rep) {
 		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
-			__esw_offloads_load_rep(esw, rep, REP_IB);
+			__esw_offloads_load_rep(esw, rep, REP_IB, NULL);
 	}
 
 	return 0;
-- 
2.44.0


