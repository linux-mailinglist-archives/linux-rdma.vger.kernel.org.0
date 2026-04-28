Return-Path: <linux-rdma+bounces-19623-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCLzBHhC8Gn1QgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19623-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:15:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BC47D7F0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A670302FB43
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9430ACF2;
	Tue, 28 Apr 2026 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ousLRLzw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637FB2E54BD;
	Tue, 28 Apr 2026 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353089; cv=fail; b=OK2Y0IVrBsDIUWuW+zbJWGgZhnmiAK6OuhAkw9zCNSKPkEqHnKt1qaJVUmAeYIBdLU/Fn7540Q0BAhGY7JxdYBLGP29+oB0J0oDaS7NbU7dhTxc89qhUDg0h1SDi2bWOZAr7/2RdFpUG/J4K9vF0zVnkASyEZHHA0EXXdeHk1rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353089; c=relaxed/simple;
	bh=as29X7LP8Jq57dv12RaQRXYVN+1jjl0ltTLg1ZOCzis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAjIDH8M6+3s7h/0a/8BZU4Bi5UUDXsP09K3NtSHJmpEZ4N0uPzLbaZgKupn7+5n1Nty/PcHu+CluckLNp2QcEN9BprLwEscMktnJii4qE/lN+MURxO+T5SYedn8DKlH6ET3i3jqiPo/3j3CEeCBlpVQnJ8O2HtXs5Wm+utvRfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ousLRLzw; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGTPJs+XKSwvwU6j2iEduhIIB0Wc9hALCMO/qo/3NnS3uH8MDFMSqPwTsfL4Bd1ysIbk989iAogmm/Zh9JXPVq155qyF4RWCD2vsehERy5xHAuYFXNc/aN6CPBCTPcRbkjWH4UdyR8joftGxHcQ34D9p55DJOG5vlt9rU/Isx1zHeZptwwZgCdxrRkxxYbIhvgDzZLwSf50mWkrSyZe+wF19z50lN25TfWXtG9U+JDFqJugoC0P0KsUxn2qM3H/w0cAZb90dG0WVcJTDyEYVre3Tc76qtWlI9mjWg8GeogbPB9TK5dhZequqbWkwv04AMsoc0TBaaakwzmfEunS13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYlgxT116HxCVLcheG7kAuO+5VR7ToSGbU/tzX9qkog=;
 b=XuQRCNVM2GOh9qMnl4SeB/pb9IQjYxMBT/MUC9J1eFW3K+f59sT55p4Udy4+tJ0oCKbI4VhH05sbnvWDN+7KxLdgL2oVfak1p/F/ZSKN9fLiVWof2a8WfD+mfsKtat43i0M1p2p7CmtzYTSvjjewAxHg4nhKOZfkVznX7WvmhI9pxjNDxab28kAqyTVu10wgzslaxQBZ78DMcm19zKP5SKmWElRbxwizPx2XQHZW1daK1n9WGQM5UTYS/vrzM5jEuTx1vc9z2NuHnyDKQ7IRhzkhwN+MQZt7rMVORjhXVGZyH521/wCtg0IYadRZt0yrP4GyoRdM281Pu9KBaeZZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYlgxT116HxCVLcheG7kAuO+5VR7ToSGbU/tzX9qkog=;
 b=ousLRLzw9jSKSDgjia33pIM92dv4fMsqYJOJSAuhHHspC1CqZCHTH6b7gYdKhi+P7J57hrvT6/Ha3auSAovnM7sq3FSr6BKMq+XehjXL8L4pNNgG0iGsltxC/LFsR6zKd0x4cEVH9Mughjcfh6/Ef2QEl9rm9MoOkPPkUTi4HlHFgULjkcvAbF0a2Q9eAVyneSym7H+xqSUE1KAtrYkJTzTRx+J3vU7vwurzjwCih/lYKXSBIcBsoCSar/qRodd2btf1LaliLr4l+a975EbdOhhiqsMQ4NlU1+OsutSeW/MmuDvypBBN0R1fflyRLYfnv4sFgnbdwRNfQzq+9LaMDg==
Received: from BLAPR03CA0048.namprd03.prod.outlook.com (2603:10b6:208:32d::23)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 05:11:17 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::bd) by BLAPR03CA0048.outlook.office365.com
 (2603:10b6:208:32d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 28 Apr 2026 05:11:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:10:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 22:10:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 22:10:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next V2 2/3] net/mlx5: E-Switch, introduce generic work queue dispatch helper
Date: Tue, 28 Apr 2026 08:10:16 +0300
Message-ID: <20260428051018.219093-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428051018.219093-1-tariqt@nvidia.com>
References: <20260428051018.219093-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f873f3-1629-42f5-23ec-08dea4e493e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HcreS7IPh6oQvIXnXePci9ECb6u6Yx/OoBTWG/AbpyasdyklCbBVFn04St02fEp3VZdv7tiAnZjZBnWO1R5i4pguxCdFidDIWjvvh0BOFK4jVWzHE0uG1AgFUJqJcZ0ng1kpW7D/hB7TiFdSzfHhk14gPnO8Sq3/BJ0nDVyEUUj0TILAwtfZZTqw+EXTTNDnzcJ7kpeRwVrJrUTpPM/7WZR7eBfn8tfVgVFCdDEL4aMhqzrEFMYotQI15l54cRleXi26Bs3bl+E8YrxYQEi2syeGDsJTfcy870HFXVawemokDFWuP0PUIMwUrfpLMzWYliQFLG/CLFE5mDURcdIxEQcn5bpYw1Lvb6riQ+lNGuChiGWh587oXr1YPi4WVFHmy7c3fzupm5TCi67WkZyhgzMEqSbH7bfQcTMTmeRt0lfCPkv+rqJY/jibSM4XJpCkQ6qBvPjOqSg7J4KKjHOXeSjDidIq6BMhKb1+HVHZTKspNmA6x/VQNs20x4LvA1vsICqrRACeOJgLIAyz97t+eqLw7m6AEu6aEjfKqFpsBT42MdaYE2UVJR6tCnbBOOamSEMPRXG7DY+A2zkXsNOM7zKwnX7kKIooX2h8C59otD89mi0xKMP7pwLLltiqZq1+zDLnaReT5LbI7Ecm2bNrrRXeEa/9tPEBVCK1G45bi3hYB+Uo9abvUwssNsloVV093B/m5wCUFGyD9oagS1AEVdgXs9Sp/qdv90BZZAUi8UjAqF0UZWBW4tk+a0y5A8Y+Pe9hM9gSQiwvaSSR/ZBPiw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xwa1LJOHRJTYwAj1iEw2nECSigART05+Nl0gSVC8jCbjiBAkwM5anskEw4gPP/oD+0iq6Psqozi3dcXygl8soiZHfeTuauD2c4fiA+IyCr+X8kzHd/eJ9NNSne6oFdVdQvI/ZEfaR51URIHT6vvbPbGs10OJgDcVu9lEB0cVPpDivCaz6xuM5a/VF54JQ5xCFT78QtgbRppscjB85UlWwYYnj8rJIT9LEewFJu7SVH3n3mrYVvXfdGlkn8IwJqIBK7qKmQMcB0ZCCnoOpw8GQqX7H8LOW+mQIMOFHVaDXKHE+1kOL2Jdrkp1IUVLJ6PUY6jnsFKBnaYXDv3dpnHDgSlP4Q3gEx0VMUVtwkhlQ2x2dzm5hbGysF3/lDlGhR5xPv8HpwpYf/nKMkDVo3qkoHfFB/3lfA3j0dbpdtcMOg52bKd6vCtoY20gQof/jiY2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:11:17.1691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f873f3-1629-42f5-23ec-08dea4e493e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
X-Rspamd-Queue-Id: 819BC47D7F0
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19623-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

Each E-Switch work item requires the same boilerplate: acquire the
devlink lock, check whether the work is stale, dispatch to the
appropriate handler, and release the lock. Factor this out.

Add a func callback to mlx5_host_work so the generic handler
esw_wq_handler() can dispatch to the right function without
duplicating locking logic. Introduce mlx5_esw_add_work() as the
single enqueue point: it stamps the work item with the current
generation counter and queues it onto the E-Switch work queue.

Refactor esw_vfs_changed_event_handler() to match the new contract:
it no longer receives work_gen or out as parameters. It queries
mlx5_esw_query_functions() itself and owns the kvfree() of the
result. The devlink lock is acquired and released by esw_wq_handler()
before dispatching, so the handler runs with the lock already held.

Update mlx5_esw_funcs_changed_handler() to use mlx5_esw_add_work().

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 77 +++++++++++--------
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 0c3d2bdebf8c..e3ab8a30c174 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -336,6 +336,7 @@ struct mlx5_host_work {
 	struct work_struct	work;
 	struct mlx5_eswitch	*esw;
 	int			work_gen;
+	void (*func)(struct mlx5_eswitch *esw);
 };
 
 struct mlx5_esw_functions {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b2e7294d3a5c..23af5a12dc07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3655,20 +3655,15 @@ static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 	mutex_destroy(&esw->fdb_table.offloads.vports.lock);
 }
 
-static void
-esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
-			      const u32 *out)
+static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 {
-	struct devlink *devlink;
 	bool host_pf_disabled;
 	u16 new_num_vfs;
+	const u32 *out;
 
-	devlink = priv_to_devlink(esw->dev);
-	devl_lock(devlink);
-
-	/* Stale work from one or more mode changes ago. Bail out. */
-	if (work_gen != atomic_read(&esw->generation))
-		goto unlock;
+	out = mlx5_esw_query_functions(esw->dev);
+	if (IS_ERR(out))
+		return;
 
 	new_num_vfs = MLX5_GET(query_esw_functions_out, out,
 			       host_params_context.host_num_of_vfs);
@@ -3676,7 +3671,7 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
 				    host_params_context.host_pf_disabled);
 
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
-		goto unlock;
+		goto free;
 
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
@@ -3686,54 +3681,70 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
 
 		err = mlx5_eswitch_load_vf_vports(esw, new_num_vfs,
 						  MLX5_VPORT_UC_ADDR_CHANGE);
-		if (err) {
-			devl_unlock(devlink);
-			return;
-		}
+		if (err)
+			goto free;
 	}
 	esw->esw_funcs.num_vfs = new_num_vfs;
-unlock:
-	devl_unlock(devlink);
+free:
+	kvfree(out);
 }
 
-static void esw_functions_changed_event_handler(struct work_struct *work)
+static void esw_wq_handler(struct work_struct *work)
 {
 	struct mlx5_host_work *host_work;
 	struct mlx5_eswitch *esw;
-	const u32 *out;
+	struct devlink *devlink;
 
 	host_work = container_of(work, struct mlx5_host_work, work);
 	esw = host_work->esw;
+	devlink = priv_to_devlink(esw->dev);
 
-	out = mlx5_esw_query_functions(esw->dev);
-	if (IS_ERR(out))
-		goto out;
+	devl_lock(devlink);
 
-	esw_vfs_changed_event_handler(esw, host_work->work_gen, out);
-	kvfree(out);
-out:
+	/* Stale work from one or more mode changes ago. Bail out. */
+	if (host_work->work_gen != atomic_read(&esw->generation))
+		goto unlock;
+
+	host_work->func(esw);
+
+unlock:
+	devl_unlock(devlink);
 	kfree(host_work);
 }
 
-int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type, void *data)
+static int mlx5_esw_add_work(struct mlx5_eswitch *esw,
+			     void (*func)(struct mlx5_eswitch *esw))
 {
-	struct mlx5_esw_functions *esw_funcs;
 	struct mlx5_host_work *host_work;
-	struct mlx5_eswitch *esw;
 
 	host_work = kzalloc_obj(*host_work, GFP_ATOMIC);
 	if (!host_work)
-		return NOTIFY_DONE;
-
-	esw_funcs = mlx5_nb_cof(nb, struct mlx5_esw_functions, nb);
-	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
+		return -ENOMEM;
 
 	host_work->esw = esw;
 	host_work->work_gen = atomic_read(&esw->generation);
 
-	INIT_WORK(&host_work->work, esw_functions_changed_event_handler);
+	host_work->func = func;
+	INIT_WORK(&host_work->work, esw_wq_handler);
 	queue_work(esw->work_queue, &host_work->work);
 
+	return 0;
+}
+
+int mlx5_esw_funcs_changed_handler(struct notifier_block *nb,
+				   unsigned long type, void *data)
+{
+	struct mlx5_esw_functions *esw_funcs;
+	struct mlx5_eswitch *esw;
+	int ret;
+
+	esw_funcs = mlx5_nb_cof(nb, struct mlx5_esw_functions, nb);
+	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
+
+	ret = mlx5_esw_add_work(esw, esw_vfs_changed_event_handler);
+	if (ret)
+		return NOTIFY_DONE;
+
 	return NOTIFY_OK;
 }
 
-- 
2.44.0


