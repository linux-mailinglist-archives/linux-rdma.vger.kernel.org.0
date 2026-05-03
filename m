Return-Path: <linux-rdma+bounces-19889-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF7fD8+w92k1lAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19889-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:32:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C73404B751B
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2697C303A93F
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F13A3E8B;
	Sun,  3 May 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MVg1fHyD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BE3612DB;
	Sun,  3 May 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840117; cv=fail; b=fvHMiz/ZXLpxhhryfGi7ZAXdjzP2DG0ehd8zd0HYy3+UCBAFjvDTp3zcVbHoZDk1EFZ0Co9/fLsJUCq8riQhEoMY8dJ3PycEdwPNWHQBvxOvlsvfy0IEwTXd/LGVyP6SW4fm2BV1AI/aRHgtN5klK2SDJp31fkPg8l9LIjjmr9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840117; c=relaxed/simple;
	bh=43qS0hS6gF/tkyFcG75DEYeOvGLAWwSOMyI5FpSt5kU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss6hCOwChydT4uc82NoweTzhSrObUbIPaV9sXdwPQNBsD03d7pCn/EyP5X6twRbiYhzjUS2f7Jqf0HgNUjisrq+ZTJwH4HU0X+MwlxkJqRjshqAyDbalov1Paw/dRgUiS+I5Q3NQw6bq1uRkuHpqevZGnfxcczKiUzInaeD9RrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MVg1fHyD; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0iK8YGDXiCsIe29wBsP4mtkK7GRqRgWO+TZflpxsjjlmLrY7AJwz2bkuTUrbpoVjF1US6/OMbbm4SS5rmJeHo2VmlyFmMCmbmTIphaswtYLREjaPTw0XxakadI7iOivXcr79USItj5BOXyTjF6GAVyA71NKcAPMhG3XjPEOGXL235Ar3BV9EFCUh/wy/r9k1p1gRyibhkteMnAzpX4yCpPMYJcteR8GfYwrRsw1uFufhYeW3ndConowxwYtOqP/2Balp+rw3+izFmZZyNxX9LM9NcwM+zmonTv966R4Ka1tCS30Roopmvp4k6NrNEc3ZpqMDkqJDLX9oJ+V5U4pDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqFW/F7p4q63WR9c/U4Zny7Posw8jxQ/hVGHNwozzmE=;
 b=CvSR9wQ1AEzbceVHqHCO+Qxk46cOAUcY8ZqLMD4Gi7/svJ4xfqXRuUOYazB/NIJjkXj6pD02Huw+8JaR7JL9JmTSDxP9uAXhTnNgWR9tcJairTniwEWDBcvZM7MhVzJ0euilvBoqkMG6R9uPFLcy6v89nwQ4sHlqnNDNGG8qAoLMQPSxPwrbHNKGHd9/qlZYocsNMMYj+uVLEVCmqIhgZLl0ouexOHjAlasn988JdRO7Zbbt5qBA2bLLqLpo5w7VQLg5vdiRBk59TR7GtXQq43t7aDHNWq1pVkFSqdQYaGUQbQcwQEZ/gJnEn7JbRBc1P8PC1xTTYDHlCbouoev7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqFW/F7p4q63WR9c/U4Zny7Posw8jxQ/hVGHNwozzmE=;
 b=MVg1fHyD+sOTGphCrdy9A+4kZjfUoJg4YnyNLyMHU6RWxFyYwveaZ7Ucw3tY4Xjj/JfSU6UDolIEYYPU8Gf/PUasHpGx6rOG+mV2Tg1zo/+089S+T187uWCkBbH22Gi8i7ZPT3HwuOsTvsdwIBI5zqyjrSnhy7EjJwac3GnjaZeF0nV2XJw1VJEs8nZtNCtuXNqfbUOGeo1xYmaJGe3wTjf8/k2H8mybLLt0lVlMhODt+HefuTcgM+9dbi/cERa52Y+kGeed7VlAgWNTwQBgWWvo+7CxASdMAbVAZSXsm9iFrNchl5M4JDs0pibH5VxhEMZ88tO3A/+pBRt62gqHDA==
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 20:28:29 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::ba) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 20:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 20:28:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 13:28:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 13:28:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 13:28:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Simon Horman
	<horms@kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 6/7] net/mlx5: E-Switch, unwind only newly loaded representor types
Date: Sun, 3 May 2026 23:27:25 +0300
Message-ID: <20260503202726.266415-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260503202726.266415-1-tariqt@nvidia.com>
References: <20260503202726.266415-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b648c00-a6ed-4c78-c4af-08dea95289ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lrgztK3d3hwjvyg12yWyItyeyURWWFaE19MrpXADiYMAaeeNripgtJ48r4VStsBP7V99IDl2G3BDgieGznuhexrGfkxqjZ0FUTaKhF3rgCGe187QmJuiujIXkQY86cbwmvJWBJpT+4fnfWXh+vlcDQK98Sgi72jLSIGhUsPUkulRvVxc5Lbj0IIMElx/abjIP8HucrzYVxkwn4F7hZqM0oTa2pUuOIb5RLo413Mm3xAbwKXAxX19XGZ3/+XluNFnwXm2E/IlFssd4AeXfUnVdNg/pz25i200cY1oGrH4dd8lwmhDwmMFd/snGJE3toIluvqGQJHvNVgyiW7sOUtzW+DCtBpbfWPlP8i5YzXgxNSIGBR0slL0w4OnwD96q5MRFS5CpY3FD1WIwCvqv6VLjIokAQBgRYS/rckKB0+vyW3F3Ql9RQEEaR/6wsyEapeFAEWz9atKgLuQ8XqhRexYjgjB4+javFgFQ+dExUsC6gvaCrgqK1dFckzZbAwBBdsjrQVtT5MIU9nCIDnIAnh4vLbSSxeHvC70688OgYxagdbmkm2imlcY2JwcoI/ahuoQ+vJwPMR/LTRRu/sYxyDE3U7WTINu6lwlS5yA9pjOrarWCrmNzL1frKjBpDsCi9qjOPJGSK4gCydyfdfMiAJKOrmNRuBMElKjvCBTg6deGLnnXw/UwEfvZRdjQZI2xfIDiuW8zjji/aWkvXOGEwvdxN6N0TAI5DpNOM3QuUM4tb0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S6sTQGcJ7ef23GgVZ44fAAULM988ArbYvTnVM+jEzqKF2LEbef6caMinh76NQGXF4IwXHp5/P9Vgsspmz0iMQ6N3BhW4PgD/Y1Q3ssdIcBOZDVmYz1kUoCLnX8KYcUjRURF04bqnaxu5+20OHrcTX9ChXLzJ0Gxc/3ftTAWc08tkXLrYvS2ardKkhKHXhdlThSc7wj+R3jlxQht2koytr8coXplSgLPpBM1phCN8O9yumcn7JmFJR+VWtgAWK7Z/RIlxwB7Aq1x4ltId2KVrwE5cCt84ro/1shWRu1AND46B6r2TuJQYR47bBMVmif6QdqxgwpulHnlN67MQQU+2FOr56rRnLUyIicjYdANQLWkI4XKPBUAjnk6Nioa9p3lEI0egBdH+V4wV0eWzJi8XY1SCBL4YIScm59VeBtNb8OGRuBg909PDhROeCRmMk24l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:28:29.5315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b648c00-a6ed-4c78-c4af-08dea95289ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-Rspamd-Queue-Id: C73404B751B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19889-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
index a393efaa2fd7..8a7491e9f13d 100644
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


