Return-Path: <linux-rdma+bounces-19153-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCKLCLuV12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19153-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:04:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4813CA0AB
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F85A305F77D
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B363C457A;
	Thu,  9 Apr 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/J3JN1U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19C3C4545;
	Thu,  9 Apr 2026 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735831; cv=fail; b=CtHHfieTRV85r5XzblOeNTMtbWyxmGP2DtiuzcosWpt6cGqwaPZiMjhsRW5vuFVguK1UNiLD8ki7GXMiUKEcxDbZSye6ngBhUlUfZwcqpRm0S/MIjmxQMAaHQUE/6U6Zik7RdKqvtAL8DUnDnCrf4l0CRBAzFNME4CgR6YXGgy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735831; c=relaxed/simple;
	bh=as29X7LP8Jq57dv12RaQRXYVN+1jjl0ltTLg1ZOCzis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXGUnjNtTbCbzz0cmEc8CWGqASsgl6x8qwUyd8Wd5eCjyTxktvcO/6eB8M/+tsX6EDudjf0Qr00Nz6uxUlVqxsMiiKSzXvhPLTuBUDUjhe/kRZctjqXECqiWbbRkrrkTt7Y9q8k/0t0hnj6lmJyovfTBsnwvf1BdLWpdBGGZqRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/J3JN1U; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkpBV5U4OcxI9ZuQQBKtSeS35WKyt33CtvdhlZEysU1RAABuldo+SHYIl7k5h/ppFYahKzJiXBK5aYWUmtjblER0+0quUNE1hn/PrWqqImjGYT4LM/6kA4VJ7u06tCzr+pe+g2Tefo9OVs5V7P8ZRv/QwWMnUaZbH630eNq2dQ/WorbDEf/eFN4DkoFkRlwsYCqRqBtmMxnwJWCIF5z8Iv2H9ikZ7VLSbz0QK5h8bHF/ATGA4SMcHoJxMyCywt5WcBFff7Wg+ooJvNk/CZwbijiuQYcX3rQ8ez4VLhdS1Z5kRkkjME221EB8KLSY49XLB6f141IAaHMJMvbJ6GM76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYlgxT116HxCVLcheG7kAuO+5VR7ToSGbU/tzX9qkog=;
 b=amXf+xkXpgWXvmbz2uBk23o2ALONg/7b1Tgs4GHttxo48IF1X640MCIvL49J07oukfaYvaGvbbi6ano5TUUUt7lGas6k/aOvwjdJiDaCikde4KURXHrGn1GX9LlPduX60QaJ5c5rU84N8UnCKEXUJZX4ch8EkcbNHkKQWuIxHhd4tvTPB2Wz0vPj5VTUeT/wYNwT9zk12Qsn0K7H8scx/Qt+FhNMPd0kocoHTR9U2RZr9SUQlKelmXiTHZEze6sNgrBz32wjf4nbkAfQOn4nBmx4vWpGZqfpVUjUZZABXHELLhNoOFP4G+Hora0OgtdveRMPyFv+/eaahYJH0+MxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYlgxT116HxCVLcheG7kAuO+5VR7ToSGbU/tzX9qkog=;
 b=E/J3JN1UYya1wQ3LcT/BZkJw0lw/aRzJFidHg1lsPjHWDopMs6kXjfAM//tyo9zOa7dqgOW6bFQT0iOzflHmpQfSZpI4swicZ1iX3gqVnCutZZxUJBe4/QYNBixnHtgHxl6/MMQp8ou5I71K+Zes4pwwtXnExF3JDVw4/UnMncK2c7HCVX7rKyXurL/nQh5clSL6nMHTEP17c8t+kbj3pFQa2aRO6mIyWgqEad+fv3mAIh2YdrUTLihjdMIB0EUFxrx9fTWOOkrEHVq8qGxwU+0DjuGlHQzrTSIvvMsLbaEiN3nYsrswGAECVlqjTqh+phuIS0donPqrVFRulX68dQ==
Received: from CH0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:610:e5::35)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 11:57:03 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::4f) by CH0PR03CA0270.outlook.office365.com
 (2603:10b6:610:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 11:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:57:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:56:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:56:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:56:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 3/7] net/mlx5: E-Switch, introduce generic work queue dispatch helper
Date: Thu, 9 Apr 2026 14:55:46 +0300
Message-ID: <20260409115550.156419-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260409115550.156419-1-tariqt@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 49680846-1847-4ef2-c4b1-08de962f1d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UEw0WwxxAbf8H56PkdLepsURhZMsKD5q1Z78gSYOudmI9PhKJuAKAzU/MUBGwmlA32bKkfUMgN+tL/DtCc78O8Oe77xSsGArcbVu0wxjZKjI/yC5ad40mzii/2pXx1PTbSnimkxbKJSg9NLz7ZBr+o8Qx99Nqe7VF5kIq6YCPYYkVFxNf+wOGo0QhotiJzmSmWtDGih+hgDmkpYHVr/mc/CY7+aUW/AKT3vcskr3433GIrmcmf4NoryIeP2OM93DglRvXZw0KeQn/XxhI8Wb06STIRwwyR7eXmvWObNbZ1XgzdFBOCFgED3wbtQGAy5pjHJhx+FRzqoFQcPt356tzPeaMefnLS5AszPLb/hnpJFnG1Sq4OLHRVPFO70qOS9Ki3gpGzXPl4udjDBtkWNmXWyXFRCwSiSY+NcI8O7GV6YMP3VhZzD+QeTJsRORf0Zgstvq/WVLdaDSHCNxBlg+G2LileNkP4+T51J8eaB/5cIZpGGzM6bMYTBSFK5M1hgXj0WGDMqiTtS1I7ZG8qVwCyUHAi0BrmaWeRQU0XW6ZsYTX1udT+TBeUXZoex4Hozx8rN4mYRkrhRB2XPBBSqfJQUYqeO54yIjLfDs12JamF6mtmm1Tb/NDWSMr1YNVMa05J43ra/3FtF6Sj8c//gE0jDjyguvZzW+McO64GSGHPkadLPMPTOheWfBrLIT0LYesfGS7/H80RBBmuT3+bRPDnDKkEhAY9rwnmjpPN5pLRm3u5OwdRRi4NpoWiYCjhf6SgkKej8d5JR/xr4K8tCr+g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g2HvKVZ3ulPqv1qFmNjALkvz5N9/0ioRgszClK1LzJpYKRYPdUQT9Ms4LY1gAu5NHkl2ajW+xDvZKrww4IKYAyuMno3g/FhQX2soKLA7h8W2DxVMP2yBQmZP/7ruiLI6i3D2pEIqgt6WYW3pmaBmmTHe8wezXJUPissYXuFW18Q/5aWym2jZUt7XPLAgPhn3wiVBUCw3MyfyZtayzy+QdkXtbJ+Ze2KiBWgRPPqHC63lEEUrT1u0iYRCTEfSLmBaS4RS5sDwobaPX5ps9r6HVUG0hQToX/73abvFiA6LdbpHiG4yhSSFpul/XRmtKKxORxBLUrLrK5C/ZzO7hgH2wQTk0fFHeEABZj/KUP7jE7HvuPRHIKKCxCki1WV102o/qX36CI4gzYXu+NMEC6fySfLrwTJX/gMG0t7KeEljjomgPrE5Zsbqf28IdfV1tZPL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:57:03.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49680846-1847-4ef2-c4b1-08de962f1d91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19153-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CA4813CA0AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


