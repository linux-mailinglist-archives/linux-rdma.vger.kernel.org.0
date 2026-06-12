Return-Path: <linux-rdma+bounces-22174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ypMlJhbyK2oqIQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:48:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352B67917E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:48:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=moGCl3+n;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22174-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22174-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ECF732F4421
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB413EDE59;
	Fri, 12 Jun 2026 11:41:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C23EDE60;
	Fri, 12 Jun 2026 11:41:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264485; cv=fail; b=Jega52dMiFJW4rIQTnvVZ6pDcJMiO0UDxYKR7/5QVqNn6TQORT0P75M9sDpE7NyuNVCm2fS8+ldK3u+QhtA6ZH8DfO7q3i7F5BstWYmEMAhs7FwT+udgdsz5QA9OvLrQnz/jVqEVHI/BVwZSmTGiB3wbLHEFoicStsU84dpDNYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264485; c=relaxed/simple;
	bh=HdwRxmusMDc9XWY4nNZ6TnRE/NI5PzbRzcGdGDzGPF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edcgDjMck+iIaNwiSP4Lv2t+r1NcmOInG/wcN/bvox6EwWT2WLfnR/jonQ3neIvMkh3iNmttApaqFbiIYbrzutCh3QpR8bBkf8bh6tdxznfd0SLNwUnoJRkTeudPwO2PHYWb2/pkx9+0OcY7smcIyqlX5AdtmYo4xj9lLxFIehg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=moGCl3+n; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykhroLpzdrXO8WYyLSoEooGsc1bmBDEfgGJEt8YbuLsTcDvnbKEsoeMUX4SQ/k6W1Uze07WV1iyrfna62nj5JSpnifglMDkX1RAfYpq/RGZK9W5gG6GM4+JaTEqXWeLZuqfXntU/1Fu74wu/hUFKc+1R6FbNd/dBSVmP417AdJa1616SNHN32KgF2uQXKo5/ZmxyEnk9IOQWu4FxiwampH2UQ7jOgo2kOCOsfj67NQIJ6STO+BxN+GznOcC7fnZuErHlX0RVTZBZ0JSums2xXdhNXsBbAiozcEUzI22P/558Qj5xZJ09k7tFLMscw2g03QAg4FittftWSxbqSKJdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bVq5jvI5XytRuoiSNlcw1TZ7Nvp5oa6G1+AMeyHMqo=;
 b=lmenul5rtu0GM9471rbRZtTtFcoYPMXvWzwtZW+6T3OAfNN2UptaW4rl25VRz/Jnsdfr78v+G2NasV9Ckgkae6CJbTNuyM7u5HZ/AT1RNmqN/CbU6+oUoc2a41IBhAJHrKJd5UIwUkaDI3lLnRUrsfUBNnBAX8ktEV3qYoKQ/IU9YDm0LZLEeWCDO5/l6oU65DsIOJyYE9C84qI1SWcn/a15JXM5XqD1SE9XnEbx+KZwUZJ6X2WMRrgBG1mtTcy1Ur+Bbc5giJFZ16rxfeUeyLz5IIxFp8/jM8RhpaYiwG3mg8hPTWtm4NykX3wTikAABoww9RJPv+IgTdXoA2Q+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bVq5jvI5XytRuoiSNlcw1TZ7Nvp5oa6G1+AMeyHMqo=;
 b=moGCl3+nfG9S12bROXvQn4E8g1CdKKEPVkk3Xut/V2Fy+xi7lg872/PJigxhwdNC3k38PqD9RSf08kwmmHXfNfW3VkxqCfFjHuSlre6UcargCtxRSME4esiu9O6n9sxbAikhRZFs0MstGWLHncqkXjEouVH0FZLGYzr5x67cGdTQ0S5QdLHxncKpqH1BqrOSpUHuvaSAqG2K2HRJYLAhOt5MJieTJdLB6vJ8250iTeq9qHsLVFft0lHXr4dzNEjk7hUh2FDCZrefyFiR8fcOGKg1kBSk9k1lgFDCqV/D5J+724WbQICk+XXie2S+QiSCWKpH9BwuTuqucg5qMa9+2w==
Received: from MW4PR03CA0231.namprd03.prod.outlook.com (2603:10b6:303:b9::26)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 11:41:18 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::7e) by MW4PR03CA0231.outlook.office365.com
 (2603:10b6:303:b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 11:41:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:41:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:41:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:54 -0700
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
Subject: [PATCH net-next V3 15/15] net/mlx5: SD, enable SD over ECPF and allow switchdev transition
Date: Fri, 12 Jun 2026 14:39:04 +0300
Message-ID: <20260612113904.537595-16-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e62a8b-15f3-460c-748f-08dec8778489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VAY8ZXt9QflWpYbSru7hOoWD0G99+FCMbK37DDoWdNwIpi/m/9gy21nyWD7mjer0tRemvuFOfo/OWfflLJhM2ja9nnHzruZf0KsMXLSHqb1wyPUuzHbnNOLtXJSNEp+BX+9btuqLeSIl8mP06DnNXya/cTn/za01/reKmcFm8B4By7hoWNjtnPhezokUnKVSSUo4KJwcnH8euIlXIioyK4Hu+mnJsrDo3e+kw5D5+S9HxL7xhkn3UcgA3YwUbcia6hTcmjl6jf5dOSp4FV6zz0dIfsKzh4esuYWb59IuVEhC5gaHjj7OYwN1C1ZgMX9g6wqO7fsQe/Of2hEujFAXyiFbRPdqaneawtU8p8zo398ddh5nEKAPIEpllqAjiR8akhIEDyN0U7uBiSav4Vvd2GmVEkRkaizvhaVIWJ0L1/7Zir9U+5uahAcwS2kLoH3qKzb0FcC9181ntuz6lAMdvvPKwjvNAg31oqEuzhqRJgk2b96GCYMWXXcB22McrWJr481P8RiGQmRmi6en8EsB9Fw3SflL9C5iIjkMfnEc/0kyCw4bX8pwIBw0+GduuWAKKaxBsT/nD4KwTaARi8OcFHPh38RYD9udZkN8vyAaolJEr/+85sQLh6PS+8t6wiBqaHIN7IcISlK2PYZwwdEtLWPanyepRYBOTGGPOSdzNgLhWDqxkHBAOCmZu/n0quiSXtaR0vR3q1KHojdQbcuXPp/2o2w9R4EI7OpPNUNIaIM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5RFE1f/DeK7mwJwWXfg9hmu1kl20MSZlXXQ+aDw6ruR+S1pwdXoZJmc95v3pBOoE2DQcus63ECoojUWrrB3WJkapIWvS72V03VXQ6jFt4WnzBDOdpBo7Xf/7IARkylY9a6SX2Pqf02ecHm/Mr6yF7dZnjK2gtmHiae+bOFsE6FRQ42Orhqr3dIAyj8H6bctovLbBV9ByZcwvFsliwu8JgkV9nOOLk9hxPUhf7F1haz2LTI1Y8032Euk0U1NZtNe/Awq+B/qLl+XEc3ShKzCmZjmI+ISxO+RdcPVXWAwMo7g8sQ8xWFD/lZKj1Dl38OBblD1jxl3OKU2s/4zqg2Frwtd2akls7ZrVvqMaeCH/nvJL7qwB3i8ilBn/nH7svaksFYjDi+hjuhEJZoTPTl0m+iCqkI/8O3L4tT26Mna+lA2nUSxb+jDRdjSgk+q0ywpk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:41:18.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e62a8b-15f3-460c-748f-08dec8778489
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22174-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5352B67917E

From: Shay Drory <shayd@nvidia.com>

Remove the restriction blocking SD on embedded CPU PFs (ECPF), enabling
SD functionality on BlueField DPUs. Remove the blocker preventing SD
devices from transitioning to switchdev mode.

The infrastructure added in earlier patches properly handles this case.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    | 6 ------
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c          | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 8fa7e633451c..907ee83a722d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4472,12 +4472,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS && mlx5_get_sd(esw->dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when multi-PF netdev (Socket Direct) is configured.");
-		return -EPERM;
-	}
-
 	/* Avoid try_lock, active/inactive mode change is not restricted */
 	if (mlx5_devlink_switchdev_active_mode_change(esw, mode))
 		return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 2fcccd329eb5..ee2fdefa1945 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -222,10 +222,6 @@ bool mlx5_sd_is_supported(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_pf(dev))
 		return false;
 
-	/* Block on embedded CPU PFs */
-	if (mlx5_core_is_ecpf(dev))
-		return false;
-
 	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
 	if (err || !sd_group)
 		return false;
@@ -252,10 +248,6 @@ static int sd_init(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_pf(dev))
 		return 0;
 
-	/* Block on embedded CPU PFs */
-	if (mlx5_core_is_ecpf(dev))
-		return 0;
-
 	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
 	if (err)
 		return err;
-- 
2.44.0


