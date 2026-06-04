Return-Path: <linux-rdma+bounces-21752-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y7uDBfdoIWoDGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21752-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:00:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BCA63FAA1
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:00:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=R33VrTBJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21752-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21752-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 493FF30364E8
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C7436370;
	Thu,  4 Jun 2026 11:46:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869C43E4A9;
	Thu,  4 Jun 2026 11:46:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573582; cv=fail; b=rWZMyNhSMZCcH3H+NSj2KCJj5h7PAEPptJfV9EEqB4u6/V/19oEbyXsR4ZROcCV1Nq53PtJeIG5Z20+URVjwxO/XQsDfdnEIDjPOyEy2R+oLhs7tK+8UXGrwQZrvjXVPfE47y076z842lXEnROseBjhh0/++bYqjLRVXO+hYkhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573582; c=relaxed/simple;
	bh=gHj9tXS7zJoNIqhG83YMOZkG8ZNP4eN6YmXt1ES5MuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTY/HXnm6+fV3p7FBjKKSaFAXew+xugDRacTcSkNN2tpsET9OTrSUN9pRgWtQKGJJKzz1I+Q3dUXbJCPMJAEpCht4gcvquSEDegDRKt1nY3k8fIZuPsTWIjes+jHIVvo4E7sU+1gHXyQImSeoD6iA0iO18EQUTdorSIZdO1Uml8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R33VrTBJ; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ+cozXjmwvNogG5CNo4/w99MTocbFrS0EGvYlAvyFnN0X6P6JDqQide9AoUWF4QtA0ptEQFeUm9Z9cKk+pN5oX74BTTVmsr80odj5mEB5ExH8itLNoRU06lK1rxtyC/9F/K8r5JLJnn/vi4aDlV0wDeNjCbf0ACYs9Dxy+EFEilCwJjUpn67cyUleltOzUq/nAnDZWJLwsbDpa2U7nPnoA+2L3KrEiMASykASOR2jKF3W7eBPFg4WxtIG6Vt96j5SyYH7BpaufhxlEGdww0W1Gn6+ZRYj01xIQUZID+QTV7a9bdf7YUZuYqwgwoCeh6pIxHESAojbIFXwwX4spC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOAVNpXMTyi+3tRn/5WYyakZRiJF90jGgkrGUz9ThOQ=;
 b=fPW5wAY3XVKw0XU0ElU2bi0dBaBzPnYHnbq2OULk5VXOJheDuN8JCS26e4Ug0PV7TQmlFnM2+WPAeV5Xd/ew1SfXzz81s5yaVMRdVPkee4GIgs0VRfQT9jd6TSizVZw6BVIiryUOyrgQ9wj4LeBaZhMIzr8ErmwyCsStgfZ/pwo4y8URmW1nuL+fB6tsTrjlRtg3BU/sJs7934cdMNx4P8A92imBU7vtdrlxYOXQUbixjE6Ae8nw316xTmqXZmZ4PSqRS8+fEF4qpcG0NS3SuRwkNfx/SlEkW9CFKZq2nzuCpp4BUihhiIBOICBQSrNPf7IbSDuwDD4UyPzqgvDNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOAVNpXMTyi+3tRn/5WYyakZRiJF90jGgkrGUz9ThOQ=;
 b=R33VrTBJWOlc1fz6tqQfUkAjuhMgzbLZ39b0Ytmh9S1oK4/9pghGNhkF2zjtXk8sro+yF90glLWEBWLVPNrxzNBi4gQM2zngEkQpsVCnDeejAxCdfZrYQe7a7HjufxcV/ufNjf/4r1wdzgD1uAgDScqy/nREjn/BIj2k4rN0uXDV2Nt8bp2eJHHV5emyYY3iplCiibtimzIN5RLA4j43rv13oX/wTGM59e4lhaw9xPZuxzpZ5jJRmAtaxCW/542A94a61fkxdO4NLZbof7mrBH8EQOV5Oxke3GmhPJLV6ytE/uSS73Ty3jhi8T5KOwJeV5i/vauNH8Uu4TtyicoyMw==
Received: from PH8PR20CA0005.namprd20.prod.outlook.com (2603:10b6:510:23c::13)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:46:16 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::89) by PH8PR20CA0005.outlook.office365.com
 (2603:10b6:510:23c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:45:57 -0700
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
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 06/15] net/mlx5: SD, expend vport metadata for SD secondary devices
Date: Thu, 4 Jun 2026 14:44:46 +0300
Message-ID: <20260604114455.434711-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: ea445f79-b522-4b51-8727-08dec22ee2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mzqWgeNqoc/ktNQNT/RA1DIp6KLeQg5yhQfqMjQ4m1ZrLgMGVPQdK0zxEzfmOtpRwXHKoS/Mz5Q4IvNwwmWXvybrIpVkKTwhIqbvcx+lbqOif+cImya8LFR2QTh/YB5ma3QZtHHXSh1hNIQU6QRSWt4JF76KA2rJwNvrEmghVp6AyckA6oLkvEKGjPx9OCihLcYzQaYQG8X7ivbcK9X7s8GYwu1id0Zv1iuDnIb6opFkAEMkUVz6mQw/GYCCRzlrWvbGM79jzOkNsY/geb6ewG0OelLR42SH1/Y8VjF3CqS7nR+OU1sRT4EEYx4IppbFiVl1ioPMndsmp+LHg4K+ApThLbMpzkEkGwI3FImKJJea1qk8/MysomvU4O+p+rp9j0FioJ8Lu+4ZkNDPZZNqA0BUJ4USaS+6Bna+iZARReX8BtlE542NM7itpLoQIfP611w3yX0t3sXZgg+hBU9iPNxuc2u1SL8TLMZ/wRIAiPadFTm58lHPg+siuPH0NGEUzR1g0Jqa89k+FLyqFCxis+HThUCgUVUqMl5lSchKQmv1Lpjtl1hhZLRUPSnH6SirDl6jKlf8b4ejoXkSxdLuGd/yTKizR+fF11JacWCB8tRYnIUv4X0PIh955/D0ylWLToXfF82VVGYLQmERFSFMgBvp6jvosQrLKd9N2BsgFShegsP7xTJgsGN3LvgJ/dtmzyJYRW1J3pP6bQDJT3M3qQzHHnmNON/tzZgOvOt/6l0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I+/4PB8zWY4FajWKyEzvDe6aF/4pVoGxzRQ2dc4G1NdsWMeMDeQ+MAUxi+f9gsvKYJ+KxXGp9ehIaUfZMuDW4IIiyIrKjyr2lmCkBQEZUHhr/fip+hLBIhHXEA61LUDKG/euqy87YDU9o3QrhYJVR4EDtlO2xVMRHvFhQMGKPnm65knJVoSGBaxNxr6cqcuuuEQ18O2ICWX+/PeBCsdwtJx0GF92BLLuQGIdzA0sfjhsmeEjGCdrZ1RJCUnt2C5dplX6NwaLKSVbnV1f9/zdA/nsKE59RU/cLLs6LxTZA61eEhicDH6ijYzUVbqR3SwduHEjPpH02EPZv+dbwKT4iRCGyekPdI01zmIjdkgPCwQLqMShhOl6yn39cz9AIV8vzJgJnw8Sx4m6wAhDOMZQhbqMJrzq2YI4m39aUFvlpzJ3BpRvP+Y331p1+uhAntNu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:16.3454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea445f79-b522-4b51-8727-08dec22ee2f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21752-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60BCA63FAA1

From: Shay Drory <shayd@nvidia.com>

In Socket Direct configurations the primary and secondary PFs share the
same native_port_num. The eswitch vport metadata encodes pf_num in its
upper bits to distinguish vports across PFs. Without SD-awareness, both
PFs generate identical metadata, causing FDB rules to steer traffic to
the wrong representor.

Add mlx5_sd_pf_num_get() which remaps the pf_num for SD devices.
Use it so each PF in an SD group produces unique vport metadata.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     |  6 +++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 21 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 12805e80ce57..366531d8ef02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3472,12 +3472,12 @@ u32 mlx5_esw_match_metadata_alloc(struct mlx5_eswitch *esw)
 	u32 vport_end_ida = (1 << ESW_VPORT_BITS) - 1;
 	/* Reserve 0xf for internal port offload */
 	u32 max_pf_num = (1 << ESW_PFNUM_BITS) - 2;
-	u32 pf_num;
+	int pf_num;
 	int id;
 
 	/* Only 4 bits of pf_num */
-	pf_num = mlx5_get_dev_index(esw->dev);
-	if (pf_num > max_pf_num)
+	pf_num = mlx5_sd_pf_num_get(esw->dev);
+	if (pf_num < 0 || pf_num > max_pf_num)
 		return 0;
 
 	/* Metadata is 4 bits of PFNUM and 12 bits of unique id */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index afad05a1e3fe..8b1f3a25d80d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -85,6 +85,27 @@ bool mlx5_sd_is_primary(struct mlx5_core_dev *dev)
 	return sd->primary;
 }
 
+int mlx5_sd_pf_num_get(struct mlx5_core_dev *dev)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	int pf_num = mlx5_get_dev_index(dev);
+	struct mlx5_core_dev *pos;
+	int i;
+
+	if (!sd)
+		return pf_num;
+
+	mlx5_devcom_comp_assert_locked(sd->devcom);
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		return -ENODEV;
+
+	mlx5_sd_for_each_dev(i, mlx5_sd_get_primary(dev), pos)
+		if (pos == dev)
+			break;
+
+	return pf_num * sd->host_buses + i;
+}
+
 struct mlx5_core_dev *
 mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 011702ff6f02..7a41adbcee71 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -12,6 +12,7 @@ struct mlx5_sd;
 
 struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev);
 bool mlx5_sd_is_primary(struct mlx5_core_dev *dev);
+int mlx5_sd_pf_num_get(struct mlx5_core_dev *dev);
 struct mlx5_core_dev *mlx5_sd_primary_get_peer(struct mlx5_core_dev *primary, int idx);
 int mlx5_sd_ch_ix_get_dev_ix(struct mlx5_core_dev *dev, int ch_ix);
 int mlx5_sd_ch_ix_get_vec_ix(struct mlx5_core_dev *dev, int ch_ix);
-- 
2.44.0


