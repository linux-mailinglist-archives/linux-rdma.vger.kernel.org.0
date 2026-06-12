Return-Path: <linux-rdma+bounces-22159-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id av57NDHwK2pvIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22159-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:40:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AEE67906E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NKse4vnv;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22159-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22159-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541CE32052D5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9537D104;
	Fri, 12 Jun 2026 11:39:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53465374A1A;
	Fri, 12 Jun 2026 11:39:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264392; cv=fail; b=McXa5Vu/dOyuXFsi4tQrLf59MkkDepzJwB0Q3SRnOEKWJ6eRz734p17t1tYDQAE5x70zHwieKWtI4jEfOavr9Zv61tfG6Cm47fr/WzkKGM94UHzZgxc2zVk5tiq/p3SBj45TZvPIvnxjMZFTOMGoAYvyuFPou8ttYNFzuApCqWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264392; c=relaxed/simple;
	bh=M1dOb2bQOboX+CpJ0QXD9c5E4AIxftyGwAY6tfZ9IxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZH4Yt0ia1l0TG7gMVzGKowj28IUlSsSer2OE/djdShF+Smo2oLZZAqL8TF1q2IlhLjhONCCRkHHFyjDMWfDagAJHm8fMjd9Oj4E2TbSE8VUJltyGuX29cyRmJ8qaQ6F9dmLdXEogz4WQajfp1uhaDcsYL1Qd/AxIho+9UIUHM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NKse4vnv; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ/CfIwhTtpdhq4D1COrOKCP0w1Qzao6ad/CdzyZNICOgRJCpTmZqZoCoE5UjiwUid/Y+KvnDTGLNNQ0ZjDhlYODl/d99L86ErVFZ2ucKO+gs5XGvQL218En6w5X9L2VmUNZLyvfVfSnk2teNNTPwGOEEggPqRBzkHJtRYRZpsYOfi2vQElwcFwEmD9lHFti4J50IDQsAE1JhPfyViFQMrcOAT6zE+vXuiQUewIRAncILTLoc8nY8Ker85XdtU/TmyxrRx0co3l9uBatJxJPjuCPbDd/wCNwHXmlCRwmB+QOYaizgttVtFGYWxxPYwdnTEQ8e/4qM1YcEoxyYr8SMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBCXsAQ/jwwIrD0DS0bM4lxGPnGi0S2TIic+YbA4XN8=;
 b=yg1b+lhJKyi+ho9gF5VfRN58AhJwMVR7FsjDNQmrN8jjmwoIGe9dngpTy3d11JsKL8UBz6ZKz+/HL+/JbNMu28DiZfTL5z3E8lpZoN9n2f5HbU6nkWh2Vrp40bxu2z++mtr+PwjeuXceXP+RZEU2lR1cZw8TpQeamQqiDO88jCdejT31Ei+ISkAApVDcag1KWUIJT/aAjN2JRPgevzxRf0XsCk/NTJsaInGSspvmEVVvs859QHCPeftw5Xf5aVg+4K9ytwTR1STkE7aoB3n9QZvfqgcMIw0AH1cGeMwrEmg4i+dyv0TDNT/CSXDej+Ps/mMBBljSNwvzn2y+0RUiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBCXsAQ/jwwIrD0DS0bM4lxGPnGi0S2TIic+YbA4XN8=;
 b=NKse4vnvPSswQVzUtXX3c25zyWeshQpdnk2Kp8kYCcL1J9qUJhhU/auQn8tEaiCKNT1IVnTF34UgRfEJGeOXKfI5WRm/u5uH2zK0TAj4rGyTGVPtepqKZJ6yD3nf8e6znSobEkHAJx5hfQ1GBukQulL4M0CKwYyQ7vwFaQQq2tGbOE0CpJFWGgFtoGBwcd1Uo8xJgbKUs1vrappUJ3+zviuPZUCjlGTjlwFsXistq1I9xneqXo2Q0dvjIEthbouLnqHU91ryt/2wImcx/AXV/trInW71C/TNWtlXgriX1kPj6bKMGxUBibkzyd02WYCID3MY3QwbwYgpvqGY1GKIUg==
Received: from DSSP221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::17) by
 CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.13; Fri, 12 Jun 2026 11:39:44 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:3d5:cafe::81) by DSSP221CA0006.outlook.office365.com
 (2603:10b6:8:3d5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:39:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:39:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 01/15] net/mlx5: E-Switch, skip uplink IB rep load for SD secondary devices
Date: Fri, 12 Jun 2026 14:38:50 +0300
Message-ID: <20260612113904.537595-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 7501139b-59f1-486c-5669-08dec8774cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2+aPfPQuWk/6BaZXTs1U/wgfjadKG6IYHpS00WEsuMZPlkH1brAbaA27ADxUPs7mYwr7tArYBmVek3TWilwY0/rYnqHTYiHSwK79jcp8Y0iziCaIkw1hspg7dv05xXAH1+VfR72QeCfmOXcaNxXfNseWyjWM6lSoCVt0JIoU+MEPu+KwVudjgLrRkVowwuyRHFY1Ij2bvSVoLP2+EkQ8SuZ2xkZZ/xitfjS0IOyXv6r+wT0/jP2boRriHl9J2u10MNr0UFZJtsNzFCtiZfTYyXH0DV0SQcTlnd2jBAAUoHPKyisM3gLpIc/d0vzNrjTYJWOG9/++73+/vwCi9G+YP1PrEHxhb5iGhpga9lP81Dn4g731hqfcxaFI7vgZb/adhR/qjQeewi3tgzQh3zDOdaxarpvPmH0JwxNYMSjpWrDfTDsUuGBroXuNgn3XoP6YpoQxhX7KojQVDDonBMm42D6+zUbzJEaFMFT3LfMqQYObJxC63cd/wKAbjZcpA6XjGSxajVx1/M6hLZ0O8E57CRKgsoqb6wxbCOVUErcaSoHr/TwDzxvHfj1i7P1YmcxH/ozGtbEqIHjnZORoFPQ8sCgkZyBBD8OrmGOIGAjc3Ih9B1xFsWW7QsV1Kpu9PWedqchgAoVuxTeZpw+ohNfP+7eAYimwttX0elCKHhxnbhNCz/ZPE5MM0XwiP8DMwUmrxDt3IrdX5TWOUeAw79CqtlHzUGiA0LHlUNt3Aet5/lE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ns0eO6V8mXbHf2iZSqvouou1hvRmvbbn2xPe7qSAUn2gX+Dq5M1dZlUBiBwC/Koe8S4bT5Fswip+B9HwuQU7VT5DG+ATP9Sg8X4LYLy0Zre9fwkn5GXUnwyKrgDm5hePvLh9wVYd4m6iTqkNLm9hzNwerJvuar+pCIdM2cyPM+u5t2e0Q382Ym6gWiRXHk1VqOoYLR/osBz5OcLnpwvobfDUvLAWs2ExHTDgIm4MUAHOdVSJoBiZXrq4g4FePBGh67HkE+GyrYjCJB2rWkD1yAV6rTa0CJ2+QMXUGZStYfH0+iqDxwLkVEU6dID6XqaTZIm2Rq/PkVos+Aid8wZf5fo15htgjPd2yRhxchDvJ/DPtte5bwLnsCCIgLIkJ7ToQ1Qv3NXW9JN4PPj3M+R9lgUlYLSH2EmX53pWc3pUx/ieyw8KEUqxAPzVCI9bl0/G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:39:44.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7501139b-59f1-486c-5669-08dec8774cdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22159-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30AEE67906E

From: Shay Drory <shayd@nvidia.com>

SD secondary devices share the primary's uplink and do not have
their own uplink representor. When reloading IB reps on secondary
devices, skip the uplink and only load VF/SF vport IB reps.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 830fc910a080..12805e80ce57 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3643,11 +3643,19 @@ int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 	if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
 		return 0;
 
-	ret = __esw_offloads_load_rep(esw, rep, REP_IB, NULL);
-	if (ret)
-		return ret;
+	/* SD secondary devices share the primary's uplink and do not
+	 * have their own uplink representor. Only load VF/SF vports.
+	 */
+	if (mlx5_sd_is_primary(esw->dev)) {
+		ret = __esw_offloads_load_rep(esw, rep, REP_IB, NULL);
+		if (ret)
+			return ret;
+	}
 
 	mlx5_esw_for_each_rep(esw, i, rep) {
+		if (!mlx5_sd_is_primary(esw->dev) &&
+		    rep->vport == MLX5_VPORT_UPLINK)
+			continue;
 		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
 			__esw_offloads_load_rep(esw, rep, REP_IB, NULL);
 	}
@@ -4586,14 +4594,23 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
 
 static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
 {
+	struct mlx5_eswitch_rep *uplink;
 	struct mlx5_vport *vport;
+	bool newly_loaded;
 	unsigned long i;
 
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
 		return;
 
-	if (mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK))
+	uplink = mlx5_eswitch_get_rep(esw, MLX5_VPORT_UPLINK);
+	if (__esw_offloads_load_rep(esw, uplink, REP_ETH, &newly_loaded))
+		return;
+	if (mlx5_sd_is_primary(esw->dev) &&
+	    __esw_offloads_load_rep(esw, uplink, REP_IB, NULL)) {
+		if (newly_loaded)
+			__esw_offloads_unload_rep(esw, uplink, REP_ETH);
 		return;
+	}
 
 	mlx5_esw_for_each_vport(esw, i, vport) {
 		if (!vport)
-- 
2.44.0


