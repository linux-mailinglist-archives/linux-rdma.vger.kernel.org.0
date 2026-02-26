Return-Path: <linux-rdma+bounces-17253-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMf8Lp3HoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17253-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:22:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F31B0512
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29D7E3055F49
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7247AF5A;
	Thu, 26 Feb 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fxy//qVa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FB4508F9;
	Thu, 26 Feb 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144421; cv=fail; b=SenTYuxy6bIYIiCmb+tSef4XeO8Q+YXXshocWg7cOu/Z81ZTJrkpLVKQqwpCQEARl04fjp3oClkTCCdM1Qf1spxd4B45SMFksSmtSYjFrEyM3eZ3dxLMLKus+KYCnxqtCJcEQNteKcu2mrHKl7L86f83njnoJGtSVqub0pZ4yLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144421; c=relaxed/simple;
	bh=oYv2xG43Vkq/KtZjnynCacHwgKkFdqKemFe+YNYiKMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9J9LbrQvI1MKY/l696pKEkSb8rvVPk/rlzGx/sWA1Mgz/lWAA45Iyg0is9F93yxEk09+rbk+/Dpga8s1eCTtj7O3jtiqqVIRkOYnqU+YrZnc9DcCRqrMobRMUq73VK+nzhKDR3kclyn6b/KHzA0qkb3Z7fsS8lmLPIOP1UvkX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fxy//qVa; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQA6j0abi3Y9JzWbjMjYRH8pUfat/odowJ+PYlP/dKZ7i+SF9GEatb3JwMqi8aNoUkka2Vsx+eGyiKOsSQk5vhNpJvQvHeHhyyWNUUoFM/uyaJfWG1MqZNvyn/F8vise9r/+3ePzFF6cal/zV8wwecRXYV/M8ROhvlzrnU7yVY1w+nhrdalch41q0k4GjbbR/PGwyvDk3tc7noIqYEKuLu3Lu/jOwnacUiu0eFt9UMwnnRq2Hh1aCPS7OleNBISXi0jC5u7uURyInETF1x4emNxFXs0+IOYEHpqP2uJwM1sSfnzhpj6m46CtQjFJ8tXKH1AUwMQt6T4noUzNBkGEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vhi2MBIUo7liQPCdNRdeIhZHUsf6JtcmR+uwlSvu+t4=;
 b=kIGDxzx81U9lbG8RGCxdTS6YRIrVWWVB+OpyIIjtPOobkJlTffUzHy3JHIvtshLgzpubGiUkGrN7P9ZIYl+Ex1jonYIgkxy0fZagq2mSHoBD09M4xVKnuwy+xvDJ/tFOwW9sFIgLVI0GWCCsZ40LoWUzJ1LnBxYLvfbpgJYa63RmyAvKcQwKpKbcZvLESomnjo8Opcohkj6eXEmQ15xDjQmwa3WtsKJN+ikSXeg20fjMzKK9WNnJYqDuFW8XmIe/KWEbpy2Rvq0PMR/rCKcaVazFulIMH6S77lAOubmiTGleAVxz86t+QIKFBNd39C8GnbK3fqRE1vvdv8Pdg2Cx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhi2MBIUo7liQPCdNRdeIhZHUsf6JtcmR+uwlSvu+t4=;
 b=Fxy//qVa6hnLqq40H/aH8vH82hK/Y66HM9GPESerYn4fz++lBiNj5ew09VMMZRuM60fhZq0EW8bpB6dBeFDKIGD33tUTry2mC5CWc/PuuOl/TG4rjY0Uc/KecYeY/xroDlBLAxPYPHBxBoeuyARCwXxHjXraJUyoJHIZJqCn3YBWvPBR8VLavT4ZspsT17HK9T/DdQpoVse7PF6CuLPT4WEaFuMBxNhlrdXa8piIwQ3j65t3k8BkNw5IP+dA777KVhyTUyjSFUpfnNKSYy4W1CPcStqWnVGqQzTWoACFf5rUg6GzT2Y3yftXi+QWYC4PHKENL8rjT7g5A9Xr6/habg==
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 22:20:15 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::c1) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 22:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 26 Feb 2026 22:20:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:56 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:19:50 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH net-next V3 05/10] devlink: Add port-level resource registration infrastructure
Date: Fri, 27 Feb 2026 00:19:11 +0200
Message-ID: <20260226221916.1800227-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260226221916.1800227-1-tariqt@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f0ee65-de83-4eef-2374-08de75853713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	LWYqnuvk0ZnAoa717XohCNRNsZppVuubT4NGA/FzCaa8h+8p7VADCXvEVWxaYTApDUohqHp3Ce4+ANhudKSOKJ2nPat9VSoDxZvVfrEU3rLMsFpLVVa6PfoM0B/wwPbK0kV+EEYjeYedxDzLPgrVcPDSU1qCV+tXtJko+iWjZGQ/jTTrZHlKrqY2wmwg1Xdck8tNE3rPERkAIFkAbM1MfwztQ4oybxfm9OD6oxdD42XQhJ11Nj9wqyD2OlGJAEevrhjFIkeOm6DfBWgngxAdk4jg3cL2z8ghp8l6mzi2xW7i0647LR5B7kuCW5N+WuP4r4JXK1WWwAVIDB3N0S5CsDtCWARcIZN0dObCRzy15jj4h2phrvL1nn5K1GTW7Ta25aGRSqo9e1qGfFG5HiDIhVgWBz3j8amNRDTsbHV+9t8zzKtKJKqGNxAk+D6jA9aRI0gnwCU7+YFqb949WOyqzISYBG+DHHzYvAvGgdSvo5K4Nz6fPhMcFnBJDA9hz7OeUvVtHPrkVHWfAYbKpn0HoZKg5cYInV3I9cPpJYEZKoVMBfqoUFvZuT3/XuZBA0pjUMuCANJQp+WBfQYWp8tEMK1+AF+qHLUsMKpRKxC/Lzvj809B75DgkUr9jFBD9mC60NJ2qbAiyHCHaRYDdjGZWXrbZ8PRA7Y9/FsNsp8vRRcHyWmGztHdfasJivSLUXz0MH7zGdQvmXYkIuHJLaCbmX0hP/D8Dq6sFlHaLOkVE8MOfxzJVj76yRKFxVRPzzQ4DjQrkfzRyliIQQoBaAMUDr1AKnDDOJBwUVoJFTIo0cgykAyT+zY+Xe2ELe3UW4cF4eBSxeimy1I6sT3dU9yQkA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EKEIi6Wy6Uq/gcxcVzSelLwbXhvjjHVRLuATw3FCLg6scB4AlX/BOwHMrKSjRX57pcOzQhdxzPC7Pkf7dtxQCYYlLfUlxz/kifik1wOtVUtvDbHxbCIYyqr+hpDsO1d2kn3UPyX7RaH3wkWfxwa4aXcoN3qGmySf2VlNCQjgVoJyQmdafHi7YzMyUmJSrz7m3SPIShlgKosBUR1/Ph/JUQa+OL1u5laH8U0CN4/IKRZ5teLbegthOSVw8WCaDePE1z3wYOh/94TToKdI6URxYrEIqtzbg5omZleGuojCLYJf/jgOMuqo1JZYCVUGdXXQenJAdJ9p6SrLy//bt3tXoUxHn8pzc+4XzHopuPqZcHdlSUkZixV6ivqjFOlJEavHiqKS973B1qogx+86hsuRjR7mgIIh/LmFPtFGEdUQQLBMZ8V8YOe9ttG2NApH0JVO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:14.6986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f0ee65-de83-4eef-2374-08de75853713
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17253-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2F1F31B0512
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

The current devlink resource infrastructure supports only device-level
resources. Some hardware resources are associated with specific ports
rather than the entire device, and today we have no way to show resource
per-port.

Add support for registering resources at the port level.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h  |  8 ++++++++
 net/devlink/port.c     |  3 +++
 net/devlink/resource.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 48e1ad067836..1ba12ab51e66 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -129,6 +129,7 @@ struct devlink_rate {
 struct devlink_port {
 	struct list_head list;
 	struct list_head region_list;
+	struct list_head resource_list;
 	struct devlink *devlink;
 	const struct devlink_port_ops *ops;
 	unsigned int index;
@@ -1881,6 +1882,13 @@ void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
 			   u64 resource_id,
 			   u64 *p_resource_size);
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params);
+void devl_port_resources_unregister(struct devlink_port *devlink_port);
 int devl_dpipe_table_resource_set(struct devlink *devlink,
 				  const char *table_name, u64 resource_id,
 				  u64 resource_units);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..10d0d88894a3 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1024,6 +1024,7 @@ void devlink_port_init(struct devlink *devlink,
 		return;
 	devlink_port->devlink = devlink;
 	INIT_LIST_HEAD(&devlink_port->region_list);
+	INIT_LIST_HEAD(&devlink_port->resource_list);
 	devlink_port->initialized = true;
 }
 EXPORT_SYMBOL_GPL(devlink_port_init);
@@ -1041,6 +1042,7 @@ EXPORT_SYMBOL_GPL(devlink_port_init);
 void devlink_port_fini(struct devlink_port *devlink_port)
 {
 	WARN_ON(!list_empty(&devlink_port->region_list));
+	WARN_ON(!list_empty(&devlink_port->resource_list));
 }
 EXPORT_SYMBOL_GPL(devlink_port_fini);
 
@@ -1135,6 +1137,7 @@ void devl_port_unregister(struct devlink_port *devlink_port)
 	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
 	xa_erase(&devlink_port->devlink->ports, devlink_port->index);
 	WARN_ON(!list_empty(&devlink_port->reporter_list));
+	devlink_port_fini(devlink_port);
 	devlink_port->registered = false;
 }
 EXPORT_SYMBOL_GPL(devl_port_unregister);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 10043ad26dfd..71f00e580f59 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -613,3 +613,46 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	resource->occ_get_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
+
+/**
+ * devl_port_resource_register - devlink port resource register
+ *
+ * @devlink_port: devlink port
+ * @resource_name: resource's name
+ * @resource_size: resource's size
+ * @resource_id: resource's id
+ * @parent_resource_id: resource's parent id
+ * @params: size parameters
+ *
+ * Generic resources should reuse the same names across drivers.
+ * Please see the generic resources list at:
+ * Documentation/networking/devlink/devlink-resource.rst
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params)
+{
+	return __devl_resource_register(devlink_port->devlink,
+					&devlink_port->resource_list,
+					resource_name, resource_size,
+					resource_id, parent_resource_id,
+					params);
+}
+EXPORT_SYMBOL_GPL(devl_port_resource_register);
+
+/**
+ * devl_port_resources_unregister - unregister all devlink port resources
+ *
+ * @devlink_port: devlink port
+ */
+void devl_port_resources_unregister(struct devlink_port *devlink_port)
+{
+	__devl_resources_unregister(devlink_port->devlink,
+				    &devlink_port->resource_list);
+}
+EXPORT_SYMBOL_GPL(devl_port_resources_unregister);
-- 
2.44.0


