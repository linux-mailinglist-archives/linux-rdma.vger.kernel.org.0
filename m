Return-Path: <linux-rdma+bounces-17251-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICXBHG/HoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17251-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:21:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A60351B04E4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED7703051580
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5F3A783E;
	Thu, 26 Feb 2026 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpAQMn9u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A530B50B;
	Thu, 26 Feb 2026 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144418; cv=fail; b=perjPerVGLZX3ImSZYgoVZY8Rb3q+jFxu29YLaLhG4FmXPRvxJ9Aqq+JDg3Hc5XY3vZRBNYZAoH/97sZnqf8MnKZV3RDs5Ku32vCYAkzzNyE+f+ul9bq+82Pwg3ABOdFjLpF+MfJ+QH4vHH2hxlrcZuZDOnwTHB6wuUqE1HMrvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144418; c=relaxed/simple;
	bh=WKMc8go366rKjYJdlkcM5zzpqvpDpdbD6ZfBtZQp//U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRcyGIb+wBpYIMtYp81ewdiPGBLUAPIsgJ8Q2ci+nm8/PXJmu2ufuznA77by5Ub7WmOz4/FWdtO11QjyqjAycm341nQ83no+D2fA1dQWM1UEdmWUyh4jxoWXJUAo0kda/IDgEnwdwM2AKBzLIIbE+nDgMhgahQGmfAuxYSrQE2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpAQMn9u; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGc6InVcdhRuvzHeqFZWPZD3ilE+DdlKkrK4Hq4bkyqvex09ZAe9bA2UtzoLsb1b2U5Mk3fe9prtTeNuMbK4jC/ucPhsFV0xSW8rbSIeOVy3e4Vr0NeZDUYLPdlJjCM6YYRINU4rct8MeelIbqvprEEBiFeEBoJr2aCEyOvxc/2/A9rWPntUlBs0XJ1VZBm08GgRk2JqSbF9CrADaxjju6vqmLIdfvwrxXu1sjLSzdv312kAjqh+6dWc9uUSAA4YTL5O3TwFWQbKm3MqyukeiVDTpi+Bm182ZAW6aK+8m32uLauswGBiQCk0asloOuHoX1cgAiWhldT4I/ijn0c4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0+RnwIwf2uqmj1dFXgBvPQ1vhYYpOKOtxEx0c4MGrA=;
 b=P52Nm5RLmJE/6bTjgiLb5FYq6M3qBEp95WdgO3ZY95Wul9ZrQ2p34F0XOFiZps652blf/PbCWnxka+XHOUcb4eK8DjowhPDxhAxXgManPNdPmWX29BSNRHQf1jSyz+MK6Hqcf6wYDN+Z1+bFusBlmI5lwzm3uLaomnrnvmSQFrTtoRyY7HNEv6sm+tA+5Ya2Qgn5cs5IKyU+tqO83TF/gIFtwJJnjHAOgd4pai4dnf3NStEC2v70LtC3CqCtJ3HMY/X1JVTOatlOM7R7HN3TZafZ2HeUkJWzxbgEtU6/WnLfbvxtAERQlDkpU07aMPz8bXoyz7hVvl89ECtH6x+JVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0+RnwIwf2uqmj1dFXgBvPQ1vhYYpOKOtxEx0c4MGrA=;
 b=rpAQMn9uSxpy4NxTy9WYMRJK55bwYZiQWRCS58xtCBtANvsDocWeRps/VH+rgGbMTxI8W8qOJhKHEoza+TjpK0/XGjshq/GRf6IbfZ2R4Hto9IHLdaUd1qvvwnO0T81PIS8hNgUDx/Co7xALzOQxiuRHL9hUNFuz/M41gj0S2ZOK8nKJ3lg04fK9D7WSOuOHCdvou1mjdZ8xTz36dkgiMkrA8IBcD6422LwQgTAgrqxIpqVhUCnMwoWvC5NUpsoXZoUFRPOIMhoYvLhSgn00CDSYGFvf9fPqF5Lu9EViAsxcQiL60BD2YtVo6YzvnJ0XmTaYnHMN7izNrPUputllfA==
Received: from BYAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:a02:a8::23)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 26 Feb
 2026 22:20:09 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::6b) by BYAPR03CA0010.outlook.office365.com
 (2603:10b6:a02:a8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Thu,
 26 Feb 2026 22:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 26 Feb 2026 22:20:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:19:45 -0800
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
Subject: [PATCH net-next V3 04/10] devlink: Refactor resource functions to be generic
Date: Fri, 27 Feb 2026 00:19:10 +0200
Message-ID: <20260226221916.1800227-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: aab81cfe-0a41-4c48-0519-08de758533c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	tMCQ2FQzhFv9F4RP4QTxId6PeHn2UlRWBvDPBzWgTviZCGSMQYHGyN7m3ttNJuqpdNqqLuxZipabktzvJ3BnlqzyFXqIP9miTguEN5zGS/+lX39TnjuljyinjF6W37HBYZid2GhZMmxZjRoRD1koVxm6UMv4q5Q6u5XCyBgHMsJe8ZXHyjsYgYq0k9TWBRWqPfVpr7npAWhvvE/0tdJhsxz256Cpn8deG4lHbOjmG5y0Ov0omU4tAfxJAWYdO0nZedfuLy0ox/qVJBy0ItoobX4cR9AvjEOnPt7o/nCXqP7FscHtqyTHOsJxl3B7sVh29m07cydbYMaLVgvju1v1pU64u41pH/tRtsrd8snbDXbOjmtd5gAGHySFIrZd7UyYpNgPzYR2+AelD+4+728xjcVdvA2j9Ey9BT9sITKeR3cpNy8IvWpXk6WLus+5ho4wwu5CTIxgOhB93Qv9ReUlCj93mrQqgq3GPq0815cAsDqGElLNszWV+RiakUyweg7m4CKWht6+AS/ta6FzA+1PVCQqFeddmAmNFHDfCWoNo7ZIIDkpaTPGZ7uuqm1Y2NNFnNz+klg46IsaEMGc+H0YZdRDz3lYALkcQ5xdeLrUyC7PyTbCt7uVE19dGFcRzL7aiktuZ3hFs9S39303IWtsZoEIXCmxHt7Hgf8jVdmE42p56mdlt8Qh3VLkOlA9BB0Sw2FMRRnRRc9AnvoE6V2ahfK6EC4yvh/ac3aemXsiuvDd7uMLr85RwlVwn2mVbXwjt7IClJBZ7tTGj2OMQizVKok2y6j/Hb6+okYLO/JS8bdgcX7OCt8CjtCe3Xzdu0y293KcQaj33aeg8aYGjVdviw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s1DKw50pUhWLvxQCEw2yW4dWHgllfdvF0nWQaA/ujhJ/uo6LSAP1ds7Gwko09FmlmyWcZGUUOrN/UagDrh7UvNEm5HFIYOfiSAts+ae4PNE5cdnSLuwNjruKGzbqZtwZUoYXW9NAlh238I5WFUxuZShIS3tqmKzcOng2iEYeCkiQfLKBMCFoISMozlUpWJFogVzkvmsDE6GwY1Rr1pZrYsANp1Ny5N2E0cUBwpkCmNXASGMvfVp0ADLohpz2FyGnQL5awXOTMEWgGVvKCMvtwiqNMEjaPdKBCAzm8Af4C5OY5t/FohIlYy6Qr76xgh8qkYV9Cd7texQYAuT1fHT02UEUU5ZySg/vl59+HwHX7AX9lk9sXPjz8HFF2VS+7OA0IaTErn5maIPFh4tzsZm7ACNf1+H0oodGokm2iQaLsXh8C6rCuXiqrSyZGz621VE5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:09.1661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab81cfe-0a41-4c48-0519-08de758533c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
	TAGGED_FROM(0.00)[bounces-17251-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A60351B04E4
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Currently the resource functions take devlink pointer as parameter
and take the resource list from there.
Allow resource functions to work with other resource lists that will
be added in next patches and not only with the devlink's resource list.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h  |   2 +-
 net/devlink/resource.c | 140 ++++++++++++++++++++++++++---------------
 2 files changed, 91 insertions(+), 51 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..48e1ad067836 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1875,7 +1875,7 @@ int devl_resource_register(struct devlink *devlink,
 			   u64 resource_size,
 			   u64 resource_id,
 			   u64 parent_resource_id,
-			   const struct devlink_resource_size_params *size_params);
+			   const struct devlink_resource_size_params *params);
 void devl_resources_unregister(struct devlink *devlink);
 void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 5131875482ec..10043ad26dfd 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -36,15 +36,16 @@ struct devlink_resource {
 };
 
 static struct devlink_resource *
-devlink_resource_find(struct devlink *devlink,
-		      struct devlink_resource *resource, u64 resource_id)
+__devlink_resource_find(struct list_head *resource_list_head,
+			struct devlink_resource *resource,
+			u64 resource_id)
 {
 	struct list_head *resource_list;
 
 	if (resource)
 		resource_list = &resource->resource_list;
 	else
-		resource_list = &devlink->resource_list;
+		resource_list = resource_list_head;
 
 	list_for_each_entry(resource, resource_list, list) {
 		struct devlink_resource *child_resource;
@@ -52,14 +53,23 @@ devlink_resource_find(struct devlink *devlink,
 		if (resource->id == resource_id)
 			return resource;
 
-		child_resource = devlink_resource_find(devlink, resource,
-						       resource_id);
+		child_resource = __devlink_resource_find(resource_list_head,
+							 resource,
+							 resource_id);
 		if (child_resource)
 			return child_resource;
 	}
 	return NULL;
 }
 
+static struct devlink_resource *
+devlink_resource_find(struct devlink *devlink,
+		      struct devlink_resource *resource, u64 resource_id)
+{
+	return __devlink_resource_find(&devlink->resource_list,
+				       resource, resource_id);
+}
+
 static void
 devlink_resource_validate_children(struct devlink_resource *resource)
 {
@@ -215,13 +225,14 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 
 static int devlink_resource_list_fill(struct sk_buff *skb,
 				      struct devlink *devlink,
+				      struct list_head *resource_list_head,
 				      int *idx)
 {
 	struct devlink_resource *resource;
 	int i = 0;
 	int err;
 
-	list_for_each_entry(resource, &devlink->resource_list, list) {
+	list_for_each_entry(resource, resource_list_head, list) {
 		if (i < *idx) {
 			i++;
 			continue;
@@ -237,8 +248,9 @@ static int devlink_resource_list_fill(struct sk_buff *skb,
 	return 0;
 }
 
-static int devlink_resource_fill(struct genl_info *info,
-				 enum devlink_command cmd, int flags)
+static int __devlink_resource_fill(struct genl_info *info,
+				   struct list_head *resource_list_head,
+				   enum devlink_command cmd, int flags)
 {
 	struct devlink *devlink = info->user_ptr[0];
 	struct nlattr *resources_attr;
@@ -250,6 +262,9 @@ static int devlink_resource_fill(struct genl_info *info,
 	int i = 0;
 	int err;
 
+	if (list_empty(resource_list_head))
+		return -EOPNOTSUPP;
+
 start_again:
 	err = devlink_nl_msg_reply_and_new(&skb, info);
 	if (err)
@@ -272,7 +287,7 @@ static int devlink_resource_fill(struct genl_info *info,
 
 	incomplete = false;
 	start_idx = i;
-	err = devlink_resource_list_fill(skb, devlink, &i);
+	err = devlink_resource_list_fill(skb, devlink, resource_list_head, &i);
 	if (err) {
 		if (i == start_idx)
 			goto err_resource_put;
@@ -300,13 +315,17 @@ static int devlink_resource_fill(struct genl_info *info,
 	return err;
 }
 
-int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
+static int devlink_resource_fill(struct genl_info *info,
+				 enum devlink_command cmd, int flags)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
-	if (list_empty(&devlink->resource_list))
-		return -EOPNOTSUPP;
+	return __devlink_resource_fill(info, &devlink->resource_list,
+				      cmd, flags);
+}
 
+int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
+{
 	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
 }
 
@@ -338,7 +357,8 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
 		goto nla_put_failure;
 	}
 
-	err = devlink_resource_list_fill(skb, devlink, &state->idx);
+	err = devlink_resource_list_fill(skb, devlink,
+					 &devlink->resource_list, &state->idx);
 	if (err) {
 		if (state->idx == start_idx)
 			goto nla_put_failure_unwind;
@@ -385,26 +405,12 @@ int devlink_resources_validate(struct devlink *devlink,
 	return err;
 }
 
-/**
- * devl_resource_register - devlink resource register
- *
- * @devlink: devlink
- * @resource_name: resource's name
- * @resource_size: resource's size
- * @resource_id: resource's id
- * @parent_resource_id: resource's parent id
- * @size_params: size parameters
- *
- * Generic resources should reuse the same names across drivers.
- * Please see the generic resources list at:
- * Documentation/networking/devlink/devlink-resource.rst
- */
-int devl_resource_register(struct devlink *devlink,
-			   const char *resource_name,
-			   u64 resource_size,
-			   u64 resource_id,
-			   u64 parent_resource_id,
-			   const struct devlink_resource_size_params *size_params)
+static int
+__devl_resource_register(struct devlink *devlink,
+			 struct list_head *resource_list_head,
+			 const char *resource_name, u64 resource_size,
+			 u64 resource_id, u64 parent_resource_id,
+			 const struct devlink_resource_size_params *params)
 {
 	struct devlink_resource *resource;
 	struct list_head *resource_list;
@@ -414,7 +420,8 @@ int devl_resource_register(struct devlink *devlink,
 
 	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
 
-	resource = devlink_resource_find(devlink, NULL, resource_id);
+	resource = __devlink_resource_find(resource_list_head, NULL,
+					   resource_id);
 	if (resource)
 		return -EEXIST;
 
@@ -423,12 +430,13 @@ int devl_resource_register(struct devlink *devlink,
 		return -ENOMEM;
 
 	if (top_hierarchy) {
-		resource_list = &devlink->resource_list;
+		resource_list = resource_list_head;
 	} else {
 		struct devlink_resource *parent_resource;
 
-		parent_resource = devlink_resource_find(devlink, NULL,
-							parent_resource_id);
+		parent_resource = __devlink_resource_find(resource_list_head,
+							  NULL,
+							  parent_resource_id);
 		if (parent_resource) {
 			resource_list = &parent_resource->resource_list;
 			resource->parent = parent_resource;
@@ -443,46 +451,78 @@ int devl_resource_register(struct devlink *devlink,
 	resource->size_new = resource_size;
 	resource->id = resource_id;
 	resource->size_valid = true;
-	memcpy(&resource->size_params, size_params,
-	       sizeof(resource->size_params));
+	memcpy(&resource->size_params, params, sizeof(resource->size_params));
 	INIT_LIST_HEAD(&resource->resource_list);
 	list_add_tail(&resource->list, resource_list);
 
 	return 0;
 }
+
+/**
+ * devl_resource_register - devlink resource register
+ *
+ * @devlink: devlink
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
+int devl_resource_register(struct devlink *devlink, const char *resource_name,
+			   u64 resource_size, u64 resource_id,
+			   u64 parent_resource_id,
+			   const struct devlink_resource_size_params *params)
+{
+	return __devl_resource_register(devlink, &devlink->resource_list,
+					resource_name, resource_size,
+					resource_id, parent_resource_id,
+					params);
+}
 EXPORT_SYMBOL_GPL(devl_resource_register);
 
-static void devlink_resource_unregister(struct devlink *devlink,
-					struct devlink_resource *resource)
+static void devlink_resource_unregister(struct devlink_resource *resource)
 {
 	struct devlink_resource *tmp, *child_resource;
 
 	list_for_each_entry_safe(child_resource, tmp, &resource->resource_list,
 				 list) {
-		devlink_resource_unregister(devlink, child_resource);
+		devlink_resource_unregister(child_resource);
 		list_del(&child_resource->list);
 		kfree(child_resource);
 	}
 }
 
-/**
- * devl_resources_unregister - free all resources
- *
- * @devlink: devlink
- */
-void devl_resources_unregister(struct devlink *devlink)
+static void
+__devl_resources_unregister(struct devlink *devlink,
+			    struct list_head *resource_list_head)
 {
 	struct devlink_resource *tmp, *child_resource;
 
 	lockdep_assert_held(&devlink->lock);
 
-	list_for_each_entry_safe(child_resource, tmp, &devlink->resource_list,
+	list_for_each_entry_safe(child_resource, tmp, resource_list_head,
 				 list) {
-		devlink_resource_unregister(devlink, child_resource);
+		devlink_resource_unregister(child_resource);
 		list_del(&child_resource->list);
 		kfree(child_resource);
 	}
 }
+
+/**
+ * devl_resources_unregister - free all resources
+ *
+ * @devlink: devlink
+ */
+void devl_resources_unregister(struct devlink *devlink)
+{
+	__devl_resources_unregister(devlink, &devlink->resource_list);
+}
 EXPORT_SYMBOL_GPL(devl_resources_unregister);
 
 /**
-- 
2.44.0


