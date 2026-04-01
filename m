Return-Path: <linux-rdma+bounces-18911-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIh/E5xqzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18911-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:57:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAF37F841
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EFFA307786D
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2642447B403;
	Wed,  1 Apr 2026 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rC+c4EdB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274A331A43;
	Wed,  1 Apr 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069458; cv=fail; b=CDc/rQSlg7Z/jNZ0EmU6UbwJ9V2BA44gmixAlLGH+IEBu6Anedh6y2t5rReUUaXF/iLOAKzqGO4PtjnfrJmwA1p7CZEL58PmK/NebAXsaxiyNJpsYbtCyokmwJrTyer/xHQoFkwzmj0cNXFE7rFme5hTDrKlPc/UxDOTLSUktw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069458; c=relaxed/simple;
	bh=5JAmz16WJ+MWQG0y8uNwgIKv3u9h9778y7vday56gRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaS+gaCvtVl2x+aFwt6s9IUVnCinMT8iPLIGuyXz4KYIJQUCoRVhNkpzRLaMSO+Uc1Md5P6xOAAujJ7RZdGisK6+tqhSeg/6ltiHqzqYNqEhQNPi1czzPhWNnD1OQc/DKwWVHR/+CDfNXPKSjkABtJOBnJx4TVJx4DEsRL9TUPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rC+c4EdB; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5ZmE1Cv49Fk//c2FT1zEjfxbSl8+ok8KnZ6MYcFeOVAassGiHaySioTuWVBCwyAks3kL376n/iik0KtNArTwsNUL2GU3Ib3/rZsRdOk8aIC88YfI89T3pAlmweWRz3m9Qn79+ipv222zzuPSCPr3bTkJIXQyKgr3O3jkmjMMRT8t3GjVXyVek/YVogQJY/zoVZalsngoIxgfWTJM0l6a/7FBga30DIo4vk1HTdFacDrpkcyRU6JIP6Prnib1v+lIEbwLLcBoyHqDFBlsJXqxnTypFgdJZBNBR4hwLu/FLtkRIS2zmGxpB3lo7kDJc7xKVSgctZ6oj8IHXIANBBpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc0HMEbZ3vW90tigxNiYCOF4QxSriaibXJ+1aFADTI8=;
 b=PuX3DqyzGw/bnXqnzq0M/rq8vND9ylp9UM8bLnW4wBNn6+ywjdkFpbZ5g0mVuoKJpGWY4HdLcdLG2d5XggHQk+/WLh1GLbK7oC+GIPphy8LovPWJ1pZ8mB0hFdT2eAX4KR2B2OsyQt79n/pqdG4UjvbrHkDwnPRBSxhIDRQ89d14hL19NhEQywxnuM6zf9GxW3veX0x6Bv3GjGgvVhDB6QWKrrOUTWaRrUWA1l1fkdjmGgy5sEBP2Jf5MnhRtJ6Eo1b7Y4DzpQbFVBqjCmTGwA19vKNe/SmuNT52AXcapeXw/VY1Brz5DnA173oOrpG3kIXVcoli/ElNmeiKMJ1+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc0HMEbZ3vW90tigxNiYCOF4QxSriaibXJ+1aFADTI8=;
 b=rC+c4EdBg3eZBbU6zNIi+cBMsXRwhE3NQGbGvuxOzmRDuhsC/ZEZFkV6LNEBocfdhfOLnPpVc59SJfh45XbB7cUhhWdymfFl2zppQgkZCi1hpx5K2CZ3Hkf1lvKulCEQVhfkk70HwdATkTbcmDqZX2N4F2/9GW4Y4JQAyLBUexY1jSaBKf8ZguZJYrHl7yPWgB/88C0Y67HWxbKtYU3GeLB1nQCyAyrS0vS0mLTiFLjplwTkAfYMwcIvaU5Le9hkZV1vLmnHeq7tSgB/9HEj9ANjXXBg1pNj6ti7sy+wUpqmFXTofKRCgu7urCpafs6NA3YBypP1TdU0+X7zPSvCcQ==
Received: from BN9PR03CA0070.namprd03.prod.outlook.com (2603:10b6:408:fc::15)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 18:50:51 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::2f) by BN9PR03CA0070.outlook.office365.com
 (2603:10b6:408:fc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 18:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:50:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:50:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V4 01/12] devlink: Refactor resource functions to be generic
Date: Wed, 1 Apr 2026 21:49:36 +0300
Message-ID: <20260401184947.135205-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260401184947.135205-1-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8b7bbb-8602-47ef-7f41-08de901f98ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aUEiN+/CRTognrZQ070RIOxZGVEgfRd+LBsK0UN+We2ZqbAmoOhCaiXrHT6S72qU2Y7vVJLGXXb8ykauY4mcXGHxtWfdLceR4tdnWftcPqKFYi13OvI8L1qmWNO5xxtcoYtcULzJJIue9D4ZJeHQwpqjswnTatyUnoeDIMmi5DOwUbjMRkwAbyXtMTJx57MclZ5KdGyLMqkWyva0bSyBKj8T5oEdPLvnb5Zm4B9Ts/NRgg/mda2e+8qkbgasz10tcM2VP+9NU2HJVnSJ2Bsg8TTEW3XUnzMTt/ZQH7RxYOJM9+SEIsnU7txjhcZTX3ObcRAVA7FOR6rwQSAR6ApilnhRkhM09IL+4ciCgU5tTOqgEy1rFIWf+dwpNmVHUIoeqmC3dEmViWZu/XcXOiqiqQ+wYs2RYN3hyJUUs6piZEGfUFPqK/Oj0nOzhbma+KxiNxhlHyzgq4bKpd7yIWU2iMJ7zPsj2M+4jfA64UTL6bEX9/94hKzrEknK58SBIxBjaVugnFjw63OIYWGqHWhHOWW2ZhDqdJSXk0Z+ga1Ml17TCPM4jujrBT324lZBAx3vSINTtTtVNPzVmaZ3PsiYIjsendTNlUmF1o0ThhLGVw4UG0hqPMWoWyfUsavbgAeBNynOuiSl7NCGMUts7PAx8rq7ObNAF/LH/UVsXCowdTG9oawHK57ILUrVCm1hNVs8jSp1WNiB7gRb4IZMVM2xtJRRMUDP8MthywZ8RCaJCMQ8y79QbDG3Ex/58mN8Q/eFfE95KQ4TXpLHOxE4ZVYhMQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	upU7cvWFp9huyq/iAwKBHv6Gnh5T2//H5xNJJNz8XPRL72bScgssFqn+7BtxmoLYzLalqWkIhcxDch8cFsj1Ykf5SqozmLTGMBuVKaF0N68Bq1RtbGWFqH0FOt0MQBwz+i2cHTdKdXG+Tv+ercgkufB8LFRdZoWuvE21e5L9ae68cbLx10rPl2eXjfeaezzCTgATzVjQVFNDhjZE9Ql9sesPnJAL+qzu0MAyJ3SQhQau6cwtf1BCPcgK+ZEHQTsaQX3/R0hHZa/qn5usHGDLnNJGvUPdFvfeyMU9ta0YHoOPZVZgFff9EVlCSIpn9DTPOfEkY2ugCAH5XoPK8s+Hbg9PF5O0bRQqff1T/QAVJ9Nsq9O+fHoF7xyhuOT7MhNunwX6TeghrQiF1Q7U4pujEmfhsKoHfEE4LF1z2h9aV3C24iKWMBdyY9o9FM4GbT3c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:50:51.1239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8b7bbb-8602-47ef-7f41-08de901f98ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18911-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D2AAF37F841
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


