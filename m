Return-Path: <linux-rdma+bounces-21957-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kMgCOP3KJmqIkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21957-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:00:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB3E656E12
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:00:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QyThCKbx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21957-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21957-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CF9303E4F1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EC3C1410;
	Mon,  8 Jun 2026 13:57:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8293BCD0A;
	Mon,  8 Jun 2026 13:57:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927026; cv=fail; b=pGtqZEiDrwbcZB+ztXMOvJUtXSQMd75CSqVG9UiCxKRlN2q8QHLoN1NRwCxQH2NvXLH4Q4Qh+Ec6pVglprqFXkvCuRpzrHd38MhM47HDNO/bccLNIkcgDh4dF+3rlEyD+21YqKK1U1joKja+lnKV/fc9+/FbJi/jYyncOc78dy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927026; c=relaxed/simple;
	bh=uniS2HCWjGDEtovVNXVHKmyiH68v6Ot4OsXTYbefww0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCaI5gc1n7KQDPYd1+1lbajgbt7d//f3G0JlVqIAzHTwEoSI6j+TYzwmIKdoioxc63/TpFw97Kn7R+I+vTHt7zyRJzZIKJJx6KGRHty9vxdUucWZmQuw0RumD3hO70nGo86wZgjfpsPIy/j83LJSfmVqqVyPQxY6dpTiQWMS2JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QyThCKbx; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRIwlS+6jL7+uwuLwepy+cC+snCeRQ/0yAwEVH0z7xX+mUO28H4Aykqj8u3wXh1sSCkZiFJzQ5TN+8J+f8j5PpSpPTIvocyRqTH5vg/8WxmqEJjdXBZHdRbnF2V3tOqFmyNiPOJyYzvn8El2tZ/84DE9rysINoAtJURlx1kPmeU9zT50ewqodQtt53vhWMBQk3VnN8VIYCrIo1D5f/c9kK9Q5TP2eFQPYW7d3v1M3e2pkV5LqgGbGeshRcMFPFPYN0ogzNQ6dhnFL3n8l4DM5/sN2YzYzkxEz8wl7a8/Gyz/7afLKApD9PFG8YkIQOT3ZMrwsC40RUZL2adBQAS90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtnTz+coA8yrqJ+gMluWV7GH9ViBzn9vVK2VT1yus0o=;
 b=xw2oLl05z7YFG+mzndbD+bC+kDO7rrEiGmkWDW5UuPjSGeo6YezYPydUtVd5Fa2WYJm4tRacuEiugWFhCJDKt7u1bMjXWwqg7zR9MmNWjt53fsOlw5kzLGoa4FujId3aBjhGi60KbDQr1Vi+aTV+r+MC9/M/vN0RP0Axnf4bovDwKjLuHsO6N/5Je62aGKTTG4DHQjs5kmtXYf3n7V2oWuzx/EWnF6AORyEcK1W5CliZEGk2H28iHmK/XTipfFdtPfY/ix9rCH9xgEu7S6uaIiNpthWr0OOcgp2xDSE0vEvOeQaP+w/q66/0VddV2ZCSqpWb4TZg4GgIpx8KLbQVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtnTz+coA8yrqJ+gMluWV7GH9ViBzn9vVK2VT1yus0o=;
 b=QyThCKbxB2X9dReUxwVELy1jbxR614qXbwjTynwadGvlBxwCFLgXqq6z/32ZGrKMIgD5lagV3GBSYLY158aZVvERd41aHD25PZb9boSzz1EtwGDI0nRwkXfMDGRn46AIUzGU8I3ovQ/GwzosCg3iG/suTOZbJCaKEslWUbh0RkCl6taXSQ3QD/8Psw0jisy1qGD+FWRpV0XucjqVPv8G1JGfPXycJ1jtXMA8NapWaaFuSEClqfqAL1hylY+wF8hPErEMTL7qQGYkhOY3mpYOeDYtbxXzE0jb/G3AgtXwV2SocLa6jM5ypmdJdd8l0bUsZfYmBc3DEkGQxbHrfzfz8A==
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 13:57:00 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::76) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Mon, 8
 Jun 2026 13:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:56:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:56:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:56:37 -0700
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
Subject: [PATCH net-next V2 02/15] net/mlx5: devcom, expose locked variant of send_event
Date: Mon, 8 Jun 2026 16:55:34 +0300
Message-ID: <20260608135547.482825-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdc296f-deb8-4048-e495-08dec565cffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VDJYSM2OXjDHkYvgH/tkj9u/5/k5UWPOY5hpTsB1CjxfHCR1Tk5md6WcAGq3g8mCLK9ow/p5VJEEQtZPIOlRccStUZW828o89QrcRQqm8k8y0j+2CQfbE90ncRItKemFVS69fjCri6FWSEfFiv3WMAddOCVO48iOOMoOwkLhyavVaySdtd5XVTZCDL5nKNLHnvaI6cl5xM434jzZU73YLLULWBuwsYR9yOIDtkZPBOJJBmUwpbZMFflen+A+jnC2EEaLzMtHs6e4mGVfmpwcfkaaSvpjaeREnC2ZPXFCbhc65Y526ajaP2ILqT1vHZuFgxV0GAuvMbD6DrS4gGOdW5mW8EtF1qPjDbrELSY2YtYoObmynydPGS4/P21V8ecXJQlnUJ2PkEDsmsIqEKcbAlP4PMimGqXSaebacrl9IyhEfJwyPv6g3PjPBGFeDBLeUjnXNeNloO9sIysiPAOi2hdM6fTBADQbKcHnewBoLIk9kdGwo0zqLtVSO4Pl0o8kdnkZMxdQQkU78cGINZRw1+49gTq9fmZMe5bcAfM0cyNTDtptGod23cK7F7ddoTieCboz7DLl2c3Nyvk7Ani9+XYy2s00WOR7F3xPE2Ip8X32Nmf52puXgZMkGfVUxhJQip7HWfSJAUep7ljebtGVblRBykcH3Rbs2pU6dl+xYm8PSR4cV7jn6UpSe8sYUYWYNj7yGEu4bV4IRnMoKwc0e7EZuwsgxgSohmEh5x1sfCg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HlIxxxs419zqZ1/hc/DKOtbj/svSioNB1WgcW4pr0CQjklwgFh0AQsbW78U5qE24wed/cq6P/w0ivz1J4iMX8Y4esZiF7vM4GRg/brqynvu0dUgcUEb1wyD5pI5Zq9iHNWfmBQSHT8s6gMAIAATb5Zss/P6NUlgi6NrYWnHOlnbaqz0PVHfkAcn8og5U2PnFzTjtLgg6RQ480jUQCWQLmGbMq6XSzOhNFc0udM3XxiIsX2qxpKdKeEHWunI/4zfXaK31xUXUOliyiGk1NCambuFWzeI7PE5O/5aHRwTE85C+a0/p6fjKE+jLvqZo0UfZV+H7AMxuLUzIVdMFb3d1QXqEBCpov+YZ6P5nJ59rPD4RsgFcB0DTWRWdKoShjovMD/U1fESSxRNJF8NCMx4c9ID32Ryv2tV+s+d7TRXCYbdX+jablQAUpGcdGcc1sQ7M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:00.3214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdc296f-deb8-4048-e495-08dec565cffd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21957-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DB3E656E12

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


