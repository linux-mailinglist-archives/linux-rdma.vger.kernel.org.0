Return-Path: <linux-rdma+bounces-21750-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GChFJARmIWoTFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21750-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:48:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3009563F8DE
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:48:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=cw2lxfNv;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21750-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21750-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47D03306755E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454F43D4F4;
	Thu,  4 Jun 2026 11:45:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E7438FEF;
	Thu,  4 Jun 2026 11:45:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573558; cv=fail; b=Jy9cIf6+M790EQO39gUJMdbPKco8hhKL0COEaIUw5xHe0OY61BaRvknZnRMCWFnXliYgae/UEQseSe6Hkybh0Q25+TMzZuxloEHq30WcsHxEDhGZplQZ+AN3V3r0u13xs+fciBd9Qna7hWF63v53F62EjjJQdIakzXEa6JrjAuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573558; c=relaxed/simple;
	bh=uniS2HCWjGDEtovVNXVHKmyiH68v6Ot4OsXTYbefww0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj4VoKuQkS8QOQo2eM4sZ57vfhD2WRg2gc++Pnnzt58qnNSjeYyzCVjyv1jvXFifhudJv6QZqm4hMBSLFPDrhwaAGxIzejtMKiEWwTWTQeVpNkqS+WIr4sagzZ9afpfx6M6p2zfxj84vcNTz1tWggU74Wcj3IkCZmkOdpE7Qx2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cw2lxfNv; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKM//aPRqLEbvCa++5jW4E0QgGICx222G8J5nEg04vbuxn8uStftLLnmLDyPbRqbZR5VhuyBBD/OtJIe2SPnZ/lgNFMWTbfXfjdqydwEKiXIjKxQ9FM0dBtA6iflwS+qEsdQN0nQ3pxwT1zEaK4DSJ1B2oW94DEKnZCYKCmjyt4E4Qp6+RHswJSORArbujb/gA+1SYZoE3ho7Y3rlvpyucGda1txBMxlmAYnZvosKOqhaP6Y+I/1GpqyEivM4WeflhsMQheaKW9cX2ouRA64Vl9ZbtSCZynhfe5C+QwOAYT3rDEVETo6JdoqM62hYhex2UWytoYDRvoq9G90wi1uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtnTz+coA8yrqJ+gMluWV7GH9ViBzn9vVK2VT1yus0o=;
 b=qfDqRRsuGSVodvmF+0jUb0P3Z9FUGktnD7vOhT4bVzEDbMIfnRuL6jjDBXPU6Ykx7DKz4ykneR6n60rXvwA4ciIf5Cmu4QPJBxZ+PUOg/S2CGEOrGnyQ41qY5aBKJBxQ3sSr0iLMob3ESbB96vkIpimS7NB+Cz4exCidhUr6hfHX0oArs7W6apl49G0R3AYC1NZ7u1UDVOsz1T4wc4YHq4ev4Y1B+gn3KEG78px/PBvClpZ91wouCIWeny/oN0dQ+tRlgTgCgq+LCbG7y9uX1O+G+9mIpy49XDvJep631bTq+R9wy/RxLfR/Eyikbfzqr0eiyJJ3wCRapCAMAFYjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtnTz+coA8yrqJ+gMluWV7GH9ViBzn9vVK2VT1yus0o=;
 b=cw2lxfNvrnOJVkKjFJARr8/5VYAovHZ99z8yPlZwf8T+9vKJLVhCkT9681mrNvzFpL5byZrcxVWbP2ys6ebO1w48EznmsRdvYQMY6Zo/2nrZML+HCGjrb8RCMLA9XS8lhT3fFlgK6YMBwWGP0L624VkPD4ZRzrEQHD0kHZStBxkq4Gb3bUpl6eUhjSaSrUKbLY/DOR2kjYlngL9PuqlK1Cwe8gfwxG6TC9eDTb8F4xPgkE5/xNEdsAcXMNNehoOwmFdlz3NL1G4JcGO2OBF+dMCfuWGKENQUjFZz2U5oP/WVW8hfnFFUzNUDsGAVtFzRQVVj4mo8x0TseOaDGYMIXA==
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:45:51 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::84) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 11:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:45:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:45:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:45:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:45:35 -0700
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
Subject: [PATCH net-next 02/15] net/mlx5: devcom, expose locked variant of send_event
Date: Thu, 4 Jun 2026 14:44:42 +0300
Message-ID: <20260604114455.434711-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e4fab3-fed6-4b21-5aec-08dec22ed376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0uiydLsDRzHyi16ym7U+jH3XuCqN7e1MMHFh/tLGjn3FbYFR7EK1ulU40z2V0GUrPWC1iOLI5UzcQO3ce6LGvmya9k5q342+EAUai1BpivBAgYo8ARIDWC86WT0Rr6hkJJKCf5fXL0PLj7zMNplLf8v9R5vttSQ9GUq2EUdY98J/bgIL4vgoq1DMCrdiBJVtOztQiRlLlYAp2iSB79VaCuGo6HhijDwhJpJaZfrGT+Rt6YAd3tPM3c2+msk+gTAMrwsefb2kGYAO8ROsx2QRvz6NsqP45yQ0IZy6+vZ82SzoOVtifhCfmfYc+NfvEU3BdXNxjG64ysCq9xnKzEcMXlbsRfsQDeDyvPIJqP09TO/haRm9VEQWv0E2BFCF9nE8/Frj7HVDRCKqYSz2+YsjdMUIJ8+M9usDSDHMAzXbV/txjYdRfp2wWBmC9G9ztomF81IlmHTY6wIG02YFT3MNWIo7waVx6UlZrEYvcsCXlGMZ+F0zfszda67av59fTOUKZEmBcss9LIXB1c8OAE4bMUaUM0Ijak1EtzMkZeNRt9/nI668CfS1yWesjDMR3VsKerGrWrpJ4ivFAKkQeBV2raGo3i+ArqOH6UyWkL6X1YhTdvzDB/OQMAZ9xRK4fo/uElUMt+iP0fp378ZNayyUJwvRRiob4uom7j6pyjlR5sUQSTu8tVTUJFcpZTDojbZc+0uydJHXbFJ0uaBu+IKFv2v3EoF3Xs1rsQY/23/Auo4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zHCnFwzuc3e+Ehg52ACt5NIVCCRFgqtXcnTObTNx3hJi2GoWVFyi5qptI3s/9AbmCMceB645RkUazo1PoNQmNmQAob4hd5IZuyY/i4O/Cq6rQNkrgwcy5No1ISK6hZJjvRrmICM1G2BVR+aaLzwitQ7VILfEDDS/1MFYEiE5IXRTxZCfqQLWDseLFHE0He/J+xON4DZ6HIPdJig5NMOyCXRJsMeo5hlEswZBQsCp2CKdeWb5w7JXL4Hhd00hrmXFJLIF+isGq0qse/QGkRIeqPMfvUwt8Hyj2dS66ThiBVsN6sMLwWNkEqhMT16k+GDMea94Rg0Wjy4JVB6WGK2fP05yTlLNpcXTewmsnD2evp3crf7bdjbZzzvZDasf3pL4SuflR4utEp6mIeFSkmWX57PEhH0e9tuDCKY1d8r5R1cNUeAMSVlFWBcpksTQiNdz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:45:50.3335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e4fab3-fed6-4b21-5aec-08dec22ed376
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21750-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3009563F8DE

From: Shay Drory <shayd@nvidia.com>

Factor mlx5_devcom_send_event() into two functions:
- mlx5_devcom_locked_send_event(): performs the dispatch (and
  rollback) with comp->sem already held by the caller.
- mlx5_devcom_send_event(): unchanged wrapper that takes comp->sem,
  calls the locked variant, and releases it.

This lets callers bracket multiple event broadcasts under a single
held write lock, eliminating the gap between consecutive dispatches
where peer state could change.

Will be used by a downstream patch.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 29 ++++++++++++++-----
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  3 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index d40c53193ea8..96b4f06d6184 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -287,9 +287,9 @@ int mlx5_devcom_comp_get_size(struct mlx5_devcom_comp_dev *devcom)
 	return kref_read(&comp->ref);
 }
 
-int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
-			   int event, int rollback_event,
-			   void *event_data)
+int mlx5_devcom_locked_send_event(struct mlx5_devcom_comp_dev *devcom,
+				  int event, int rollback_event,
+				  void *event_data)
 {
 	struct mlx5_devcom_comp_dev *pos;
 	struct mlx5_devcom_comp *comp;
@@ -299,8 +299,8 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 	if (!devcom)
 		return -ENODEV;
 
+	lockdep_assert_held_write(&devcom->comp->sem);
 	comp = devcom->comp;
-	down_write(&comp->sem);
 	list_for_each_entry(pos, &comp->comp_dev_list_head, list) {
 		data = rcu_dereference_protected(pos->data, lockdep_is_held(&comp->sem));
 
@@ -311,12 +311,11 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 		}
 	}
 
-	up_write(&comp->sem);
 	return 0;
 
 rollback:
 	if (list_entry_is_head(pos, &comp->comp_dev_list_head, list))
-		goto out;
+		return err;
 	pos = list_prev_entry(pos, list);
 	list_for_each_entry_from_reverse(pos, &comp->comp_dev_list_head, list) {
 		data = rcu_dereference_protected(pos->data, lockdep_is_held(&comp->sem));
@@ -324,7 +323,23 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 		if (pos != devcom && data)
 			comp->handler(rollback_event, data, event_data);
 	}
-out:
+	return err;
+}
+
+int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
+			   int event, int rollback_event,
+			   void *event_data)
+{
+	struct mlx5_devcom_comp *comp;
+	int err;
+
+	if (!devcom)
+		return -ENODEV;
+
+	comp = devcom->comp;
+	down_write(&comp->sem);
+	err = mlx5_devcom_locked_send_event(devcom, event, rollback_event,
+					    event_data);
 	up_write(&comp->sem);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 316052a85ca5..d5c60c03e55c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -46,6 +46,9 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 			       void *data);
 void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom);
 
+int mlx5_devcom_locked_send_event(struct mlx5_devcom_comp_dev *devcom,
+				  int event, int rollback_event,
+				  void *event_data);
 int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 			   int event, int rollback_event,
 			   void *event_data);
-- 
2.44.0


