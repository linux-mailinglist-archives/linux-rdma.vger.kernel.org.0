Return-Path: <linux-rdma+bounces-19103-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mESkFSle1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19103-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:42:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D93B3DC0
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74FBD3018C02
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEFC378D6B;
	Tue,  7 Apr 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8ybywin"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369133783A8;
	Tue,  7 Apr 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590941; cv=fail; b=XK7myjnwFzOPkm4KBK0XrRMOlez2ezz+YxvCGYLy2vlF6wcCM36Cifbpv44igjTS2qSOswtiAMnyvQ9fm3S0mJxraUbs0wUlkOh/HofLOoDmAhbEPwUFzTn/u2Nz5hT/5fh7JX9BIaGHZdlg3+bIpVu4qadSx/uHZEJlI4DJ2d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590941; c=relaxed/simple;
	bh=5JAmz16WJ+MWQG0y8uNwgIKv3u9h9778y7vday56gRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOxHm25FRM33l8Ki825E60xvxUf1N+lnUvoB5oeXaENPWX07PS+OYjT21phEH5oRhRy1rQ5cSgdSXKnRvvno+WhvG6BNq0CSKwcjKZq7vDT//aGLakW9Er76cQBdYmNXk2mLx1QAaFGEMUXXrpTwzmg+0/Uj8hysBMgV+L8pkH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8ybywin; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGfayRq1C+QUReDs2gaZrXJhxp246DBS2owUMv2+E8aEm2KIpZ7xUCCfc/XTCIBX7Pkc2JR/0vZv7dfkqOAdxUZIaGBrH4DW6Xqe/fbX4aRjpaPG0Xh8s7v9tx0/+j7udVVYEtMJxYBDHUA4DvBJfpSfZL++oFQeycNOnQt9GBNRQmGWnNHNYPKPL1QZAV9q6LFoW68IVXg/N0Z3PUwcSyrC3RiiIivojxV9qhQ7HnAXcPxEEz21ip9B5sqwkWZ4gN5w3xWaugvh+J+7KSmAhTDJUib7sON+dLOri9oJvHJ9JEkLj9tsss064fr9x66EGguSjlNNmiepCrQJ9UM8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc0HMEbZ3vW90tigxNiYCOF4QxSriaibXJ+1aFADTI8=;
 b=xYoUqrgiMtPkUUJv6gP2nuOz+xINu9FO1481x7dw22JFKTB8/eQHjxf+suaYWkuly9yNpwePV3hOTtrHzXeCB5n4TGmjXzgtZouoKONJeCFkiGxH+pmV2PN6/eKiETqSs471DB/+VAfczgx+FbnoPEimhjQfPZIDG2ULizDSLl/7lMjSQDk4jKpw6sSgMzJfbcDNngnkiRszYwbbVs9RBGl5HU4ORawt47pkJJ+uiEGML5J5h1eSxjkYUglm82hnUHAn9SCgrXmVhMzXXT49mzCIzZb/+fHh2dJW8LyfPQYs1xEg6P6J9MYXt4XoUu63Dcz8flzQkoUXUCErVmz0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc0HMEbZ3vW90tigxNiYCOF4QxSriaibXJ+1aFADTI8=;
 b=T8ybywin6N8vnwAnTrxbLRPqd2NKaFKsFreAMcMI1mv4YQKTmD1zvsmnu1akxFm0Tj/vlDwEzH2Ea3W3+3+x0EAVT/o9kJDEOCwyYbAxNXg4vTvz6HTHajx3+8rQ+Zx+vf17LZO6FABr2DGG7WEDhMKuwtn3AyACz1hKzo9bRi+5DjMupXyZZint33/cPAF9iJmTzIFrnHb7M87AgA1ueW886fMIZ29zmJs16b6DYlsMR8mAalfR788SOYtnpz0+Iz5lgg5n+/SAh0Hs74dk343zp6iCd5cqM55TsOGFxstsoD7INJUTp8KNUYeQ//i7kGaRRFU3rALUKZ/7Ub+HPA==
Received: from BN9PR03CA0697.namprd03.prod.outlook.com (2603:10b6:408:ef::12)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 19:42:14 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::7b) by BN9PR03CA0697.outlook.office365.com
 (2603:10b6:408:ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:42:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:41:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:41:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:41:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Carolina Jubran
	<cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Parav Pandit
	<parav@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Shay
 Drori" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V5 01/12] devlink: Refactor resource functions to be generic
Date: Tue, 7 Apr 2026 22:40:56 +0300
Message-ID: <20260407194107.148063-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
References: <20260407194107.148063-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b37a25-6f5d-4f97-a2dc-08de94ddc4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dsGwY8uA7k1OT9jy87Kq+ZvM4r/HORICRCTdlGZEp+YBPokWVsv/doLX129rSac5IhO2kzjGPG+UMKeLXGFoD2DnQ7JgXPgjNk7fHQ2xJD3PtHHUeNODalhooiohPDpkgR4a4/suHOtCNSkFtZluBtlkAlZrKxhkxKJXNOwW5+4KzLAgxBv5E6csylIxVjdtJmkmJS+8mag28mcGxmbB7qZD/lyus9YEKS+OeJrA0aFo8RhrkuvGrGyY7vy4ZAzTfuyRe7my4O53GgzeVfpgdxvWZfGIzjBJWH0wAYmbTD6FkWoj7lhzXKU31yr06S6mXrADPYD4pk5jbbke9q860kqPV2mgnkb3M9958rO5XbfLWyPh47fyya7DY9K/VcuROqTOBJ8dWSEmCoQeNZUFhzQR7dtAFxxq8gOUBELBeki1RV/oIcjCzoEyiKwyJdkJel+e/6vXdmAutAdSB48mtqSYv6gge/Ij/QODW83z2pFS/3FFKfjpfuT/EGDU7hIY3gdfrddjQx8e+Xqnaa8upxfN7ux01OlVmBj06otgLdpD/vqutI0/XsI2Zk+Kx9lqyrK8WALdxU1wm9zmttEudbYkoaROinC8Cabj9d9SAwNySa74Yu+Xz1yUq1dVanxB/ioONpOUg3xaAPVjO2zE2B3dJ6WbMD7RfwHrWn99esY0yhuLysWuIjCYI0I2+rrX1oDBD6crJeDMJL184eakOeTezxGD0EMg9KPSf9h8FJqdy9r8qMGptT+dlY7VdUZrDFFfWgnVQft0GZVUKguimw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6utZsKdWVyopq4YOpkvOAZ6LrvPsu8YLjQc9huGrmd+CnjitfvsbYQf/++0hqeY1uoXH/BuHoaDEAio7qP9lK/C/MxBr/k/AEyxmFoNmUQrlSGQx3giW14rPcIxeONCFrKSAQEn8/2lBAoXhJjeLW/UdGGb3LZxW9blGJ1NotLYVaKYZiVmTyPkj+Q3Slao+bTk6ExvRXYu120+YuHOxcxUjuRu0/yRYqVFB2QssssNXhfVq4/KHzf1dqLpHQ4fEdPoa4mxXE52PDFc0mRM7O2QmDh8TKp6/8vm86iuWea+/1dBqE6vWjVygCFTUzATJmJP1DZMFRc3TZsBKoZHDakiF6wP3fm6vZluCGpF3CMK8sKhn3hriv2EyQXnomBljLnJ1AlHMHp578qh0gAKMdcyAJLrWyWCmstxejoIKJjy5hJPh0poClWVxhvHQtrqj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:42:14.1653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b37a25-6f5d-4f97-a2dc-08de94ddc4cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19103-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 130D93B3DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 net/devlink/resource.c | 114 ++++++++++++++++++++++++++---------------
 2 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 3038af6ec017..f5439d050eb0 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1885,7 +1885,7 @@ int devl_resource_register(struct devlink *devlink,
 			   u64 resource_size,
 			   u64 resource_id,
 			   u64 parent_resource_id,
-			   const struct devlink_resource_size_params *size_params);
+			   const struct devlink_resource_size_params *params);
 void devl_resources_unregister(struct devlink *devlink);
 void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 351835a710b1..ee169a467d48 100644
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
@@ -314,26 +324,12 @@ int devlink_resources_validate(struct devlink *devlink,
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
@@ -343,7 +339,8 @@ int devl_resource_register(struct devlink *devlink,
 
 	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
 
-	resource = devlink_resource_find(devlink, NULL, resource_id);
+	resource = __devlink_resource_find(resource_list_head, NULL,
+					   resource_id);
 	if (resource)
 		return -EEXIST;
 
@@ -352,12 +349,13 @@ int devl_resource_register(struct devlink *devlink,
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
@@ -372,46 +370,78 @@ int devl_resource_register(struct devlink *devlink,
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


