Return-Path: <linux-rdma+bounces-22160-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dfy8NWTwK2qBIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22160-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:41:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6767907E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:41:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DckMNKQF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22160-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22160-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAC93139849
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2E3876B5;
	Fri, 12 Jun 2026 11:40:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4037D104;
	Fri, 12 Jun 2026 11:40:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264402; cv=fail; b=tYnATC+9AJJFD4b76Tl1u8ixW9BX/WrCDAWfNjLlvu0ak1m1bx1BirBfp1dTDV7ZIYNQYU4BKCpt0DLIsvBnVM7NMWUbW5qLbLeYtsRt2qRx06u2OKjy57hXPr31xKrCyZGag3SXuKarJC+EtprmO8x+XK6rRCFpSnN9672eqMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264402; c=relaxed/simple;
	bh=uniS2HCWjGDEtovVNXVHKmyiH68v6Ot4OsXTYbefww0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rS7PMBczb9quNmz+9y7NGSi017Ae8hd0gSYl3zTVe7KRGY0uqeHYi5nKjp5TuvYVPCF6sgtc8XO+M/G5ZNXyGxuWfLEfT3kWAY2cqlbVBrT3tC6Rn6EwDSl1QQm7Bgu8EquI8mrAY80F07Kb6E+ui7TNGsBb1OHukEZMl67c/aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DckMNKQF; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzTf/yWeFsf8I3A6+Nt4E4HLurLpsVB/BekTx7ZnxRW23UfWZpk4sHU8ka83Q8G0MeiW0HBFLO0VJGibKxlETTUp2QK11htJpzCj0yb/mvll1LJxKBtYU1U7p62ifH+5IGvEf48QxxqjNT8AsIGMktFJExpRGM18OrjbHh2n4HBUysQzxvOBQXd2Ry0T3m+iQvyIkIRwKXU5vosRzTV6TufA5CyjrOiZZoAe/Se6YLM9QWjZwaIrEJ/g7rvlykvCC++gmZpfp1vPz8WBkbpJdBSQjOX/KsyEwZ5kGNe95DBKyQAba/YA+mp8JjkOEmQzq03ewG1ZyAKxvAxvzrbIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtnTz+coA8yrqJ+gMluWV7GH9ViBzn9vVK2VT1yus0o=;
 b=j89nu3jDKx650Ds1oChO3WfOARX+SAq5r89yee1v9eeBNEV5+lxumE2JuXZM6WOZTS+8CNGCeX/5mGyZGhZXKy25se5I3Ul9IbB70/47Q5VuahXej8AnKuLxD4P9L3+8tsFFW1i7UEzeFks6iM6Gz5AH79s1rQUPsczoymt7nKGCDDUheusenSd96S+SR/Rj59brutRmu9DlCbV8cVpS3qwvTFLTlr7YKDsn8UUzaRVCDBPfz0LRRPfm/+pb+3D9gitERJlhr1zvRIqV0jSIlNntjskNsNKVLawQRF2A9yCoGk7p+Mhq2kHI5+ZRHCssuk6Pnp9uUQi//fk1LJTK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtnTz+coA8yrqJ+gMluWV7GH9ViBzn9vVK2VT1yus0o=;
 b=DckMNKQF3rf3IyX5NsxwINoSZyPzyc0pmfG8qIKO1dUXvIQ+wPATiydHB5m7+1Wy8EdNleLkZip32scC6hUHWi8YYDgTJvbnoSWN57t/JnbaPpqRysotYc7m9R96dTIZ+N9UR4xk0ntnUgbJPfx647mHdTPWO5d2oFasa+v3McLcm/R3ezZH3wAFWvyxB2RqKlh1p7khb+RUdhxIXhge/96Wu7Rd0SEeWx1euC2GcSzrNqKd8v9xdvT/NecgAvs51DFP/Xh67T7bgQztXPSu8T+n4dQ5vJU0ZtVZ7r1vlvw3RQhZ4OyTWhQ7ZPamzP1JDNCY8A2grtxU5ly90XOKbg==
Received: from DS1PR04CA0009.namprd04.prod.outlook.com (2603:10b6:8:44f::11)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:39:55 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:44f:cafe::68) by DS1PR04CA0009.outlook.office365.com
 (2603:10b6:8:44f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:39:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:39:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:39:30 -0700
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
Subject: [PATCH net-next V3 02/15] net/mlx5: devcom, expose locked variant of send_event
Date: Fri, 12 Jun 2026 14:38:51 +0300
Message-ID: <20260612113904.537595-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c3f033-842e-4a64-64c4-08dec8775302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	HGX/BKGn7wdEf80eRFQr0Ge8xgec4mhhsukktgGEGobQz6mduASt8OoPZLjHNQ5JEEH6WO2jvJkXeEKYDDNGE4jQXtihQuKM6/XBgyA0V1FtkgNiYfD894RAltzcXnrTeB/+/ZWPxeEn4mPvfQ8UnfWZAV+n+D2dHDhq5AqvdhGMwpz4d0QcjB+Ijn6s6UFGMA3DNE4vxjWJ0IuRuFDthmrcEAS5xsBO/mL5/Il4xhaSGxh12ci9dvrNnVlKAO8dP/p8b098R3I2VqSNwGaeo03Vn02ikFgdDTdNkJ3wBRhcV6kqQpBoA0q7y+tcj4v3GPX34SAk/AFVqx+QK4rIW3CUPdqzQuGa0tgmm3ph1FflP4HEXH35L1WkA3oM+Fk/6UEqcI9VDpWZ/Y3XdGemdFNGPQbzV2xG5wNE+H5HjcqAwMOM/va6dOBFLWukuwi802INKZ1KFGW56D6U1WKLUdkCvmfxlMK5LORNleCaV/gnO2wp30470wd5noSNvV1zNMZ506HuIWUjW11cI0bZ8s9YfZJPSIbZB5IueLh+r00uUYTWJp6WeFQMRVrBVu9KSGSuH/2W7OhGqLY2pkcf2p7XM6TkY+tlIMry6PbwU2+Lu9w5SHhOox2aUzK6OGnohuKsGYq6LGhC671FuZuazIBtRi1OwOaO0KXNaHY43HEbLB5Bach+EPA2juvZCf9ujKj2UQcbBA3E94dRtpVxsCAMicGyAShtvfls7RtOrio=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1MZevZ9c2RiQeyK+bqLfZhxgeLNieTGj3huCkZikrJSPI7rspJQhMPPZB6rn7BMbJ2sIJgVu7GfXsPfTc7J3AcsJ4i/08e6UchtBd6IA851EOr0Cby+en/umnVAwE5Gg+UE4kXshl+wpjbG+MEs6YFGwODewovgigDEuSyl6cwjFWiMD4Nzrhtsa3Em5axeNLEXL9rDO8kqC28ZvoEkChqXBTExAdUPkMI1wB9ECYNJF04nkNMcNY6rYRwqmQS2QGDSk/TNGIWYbidNoT8uP17zCTlKA7GoqVNjEKur91/y20krisBBx8y++UZgXVOWyhX19PkJSs6QwhN2igzB33DM5KJP25hv4vAiue7sll/3XJUI6/TU2y6DjGBK3TFG/r1/EkVpQTpEjPFvaHkChTdvZrAuwUVpdx0NSdqmrti0Co/LePp+YyiYDzdvLRWfQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:39:55.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c3f033-842e-4a64-64c4-08dec8775302
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22160-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37A6767907E

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


