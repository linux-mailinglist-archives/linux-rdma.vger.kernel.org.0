Return-Path: <linux-rdma+bounces-20591-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF9XF164BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20591-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:43:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD2953839D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA12A304CABF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4660B4DBD71;
	Wed, 13 May 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bs3C3xA2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EC4DC53B
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693627; cv=fail; b=g5q4dMhHn3sComQLgCGyYZ4lnoHVBqvDtrVUM2mOUVt7eF6VqiO7PZwtP+R3hM+gFpwGbkn/nD5xzoSyZtxhGtO57qNijOtSTQdztv85lCupyUPDA4SEIJhH9nEahVoZIKsphiqAXRGm92YhtB22lyQj3lzPEAtF3F1UN9oQ4vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693627; c=relaxed/simple;
	bh=+1IHqB8C32oYBngdbEjfjzneLAwcidr733c1ScZieWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fU1gBCYburhByx5pJvx7XUvaqKDhKlh+xLSMpEzzqLpS8+vEzFmnpE5wWHGMV4nR+k+ZcQm2vbwBxRr6Aa6Vd7aY8+i3pG/bL8ISb0FKU08AFnJ7PL6Sowf8xERN/gPTK7DR6WVY4uY6LHEbfQHQlHSv3FUNz41qd+5MvqSwt7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bs3C3xA2; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnYEdf/RBkHkhvg/+uTOdmbD6ChVCv6nGlqkCV42yPEznmZsA9G7l0fkfLyuFbKTpf+BCHfS5/rlqm+Cp92cUSsMvzcXFXNeC53BzwDDj4jr9ozSxpSeZXDtnqQ/FCOVgU8XQN0a8LNEAqHqA1FLde35sc2Qw2fHUh7Y34CQU0JWIhbL3r8WomTCU0WbmLhBXVPnqA8qKQ1lGlVu1SDETPG+geooGs6wE+5ENGc9j9ZxY8xui8gfiJPXGzCYRThGQGhJ2HE65X20bTeKQZUk+K+7d5zQnCHmdd5mBMjJ+nbNVdgyTi2j+M9J3Fc2pWT00MAhkoVgSjmBCROmGBSlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8YRMzF4Bie6U+AN4W9ZXaWIS0lMo0pdZ/u+EkXvBMs=;
 b=gfk0wthMV93yhgq+fDhr9krVI7GtsRqswcbLCEfBHNlUP7cDK88eaxHx5lQjw4RZUgcW2nnQ6yOsg7Bz52IRcNMimtPDqJt/0vNBeQhv+X1xJAx8KBsX6gYZg43uVRxfLvMJ4o0vd64g1/Ts/vYLlyLqrSSBuq8aesy1LA1fsKQEhk0NnU5vn55GLSuyj1ddQcHpIyNHWlKfSFus9c1jLxntLZ3SdKcK6A5uAdxy2Eg4J+fg7pLj40z2dd4GAZPAgUjcflkninE8IvpWv3GI61StzQwQLFjPDFaF4NbZ+3m2HWJmfemQr1MGS0toiYQIVemRFpNxChoRQFK+ftJcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8YRMzF4Bie6U+AN4W9ZXaWIS0lMo0pdZ/u+EkXvBMs=;
 b=bs3C3xA2Mj/EjDsr5ToYQ1vRfIioc5hkgn0EhBwMaAmuYzgXo+B1mmg39TgR6im0Wm1ABQluzFTiFXziBag1zcucO5fN9OW+bslp9QXBCjx6tsu7SZ+XbFF4cGCrk69YsR5YGwv3SvfnMNwMeAnepuoT6U4uOUprDZiSq2xwCWv0uSN3f1ZWySifzPkBbR36GR7LlleF8mRXujDslLNo9jYLYCNhIN9ouCeoKqRIgR03/ilSP6JEmNGZNUf6ZYIrNIZbLpkYnwS5+Itji/Pb6xM319SxBvkxAKaY4qRVo++5ZYXtOhoLLD7Gw85EMu/lnisj6zQT7PAFQdWDATnZ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:33:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:33:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 3/6] RDMA/core: Remove uverbs_async_event_release()
Date: Wed, 13 May 2026 14:33:25 -0300
Message-ID: <3-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d21a42-0fab-48ec-c4ef-08deb115c108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mQOKfrXsvMnvM0uUYjDKsadn2Rr9iXouTyEfU14VkhuFfMJ0E4dU5lyjo/m7dXeOyB/p0YmaY4O9OvyCNQaGJXPznLasw/DC3PwutXBYr8AyouFqOO+9BYRXWMVbcYX5S7kphFGx9WaAGt7LjW/6wGweETHH5mAixsD2IzHDfpLP15QE9TX56orLtm3qiD2fDi6hj4L+tcatdM903Sb5g59L2GYrxWsJIy6lostnBxAqbIT0ZZo5tU4vzP3fQDNR9un2u7Fo4gXtb87HGd9dwQcgcnzcm+wznZRUhto89XfHJP50FI+WZEvQmtqEFRxxRESPe4AfJKtxjYd2+YvuUGJ+TWOzdYYITX+U5JSXn5+pb1rhbp4fdwT+gK8qjJ3VoWOIOTDj2AbZoIg9fi+QvZ1+HX1EFO63fAkrYQEm8fi+vQgnzY2QCRumlGiZj/18p4xyod5izjNWSr5a+zp5OWN1Qyl8nAfwqSVksP0kD7zittfKaLU5hCaRxCX6MhoGSzrPGk5G05jvI2qgfw4VBeyzA0/L/YUiA+H1cEfNyniSl4vCds4kezyyQuJNZ3VgJGNnUAT1EUBfUzvV5gmzA5yCdmu4EzsLDMDcODdAHdGCjRpniJQU+i41sDxFl8JQ5SZ3uWxeTxUCvgV8yQyqvN2Wa3fQfLCVRu/gNBLzWEm2Npet2hqYAKb8Ny0/L/JJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jMvYR+T93sTINAk+UatCWCav8c9Vv8DvF2MeD78ZvT1kUyve3oz06nF2qHq8?=
 =?us-ascii?Q?/aM/qGgZToE7AvMgcO+/4k4qrbsMO2v/nqKzTCReADMol3i05NIJW/P6fQmU?=
 =?us-ascii?Q?33vrhVFh35hEsEEnXNQWmKGIbUCbjBtVHssqgKfxNq1HW/QgEEVb9ew56CqF?=
 =?us-ascii?Q?/y9BpKtA2Bgnmk4fJBExm85SVXLp6u/7q6Q1G+MkmA3gzhIdZYtPY84chRJz?=
 =?us-ascii?Q?0sAITqRYUyR1P3JmzwTjn+mKdD5kNYwVg+LUQOli5ZUpYYz8WVhUTv7UNmcA?=
 =?us-ascii?Q?YbNVqtkNahJjx62ufngKlkTWkHbdfB5TvAH2qGlSbDKcrcdIsx+0P1cUbefA?=
 =?us-ascii?Q?kV//eRUJBbaBDltq8cwjq+cC76BnQhZM0Sj9fkXpyFO/OfMD1LFTX5NoiuMU?=
 =?us-ascii?Q?9ao+0pC5dow/NDr59xUqUEHDBjolB9mK1rQ+bKSPyeZWdmJSznMXS8/RAY4x?=
 =?us-ascii?Q?On/XzrnElqLjAzKC325R6ZdEE6c8k6CfLXr4WsvlLL3QT94+9GoITUoINbae?=
 =?us-ascii?Q?bpB7g2kqani+gudGWbvgbLhje4zfFLPaBzvn9FvtaLNvOWmrCIc47XRW1quu?=
 =?us-ascii?Q?xYzQ41C1N0InQFme8mmhfmedVO7ZrGbcJLp/XYKeOy+lWMnww2gANzeZvkJI?=
 =?us-ascii?Q?mlS4fp4g2SVPUxRe2eC27iJhl+8j+/W26/f88bFCIWKgst9ZiEDZPh0ENMqI?=
 =?us-ascii?Q?JVm3hAcWWof0sNoBzgA/QNLrPSO+2Sj08mPSqBNCTKGCXdf2ghh5R6MApMTk?=
 =?us-ascii?Q?82woXditqofPL+CBYjcVCOoDOBtWq/5LuJKnxASdc+zTbB4Nath7GeD6c8k5?=
 =?us-ascii?Q?bkiBpcuozopNO9GPaq07X8F1B8khIKJwKnjq3+ROeRT9qqZ6tk0X3goJUSkS?=
 =?us-ascii?Q?6fKuDJRP8kMSk8zVqVeOoQQ8AjbHdm/CKrwL7+7KYEQYF8aEgmDDqFNxj3/m?=
 =?us-ascii?Q?Lx0kpA4JdgtpXE6c5DFN7LOoS9iBvGL6+eniS/ZW5MPH8cZmfOHX/NfUR3JL?=
 =?us-ascii?Q?4B6gxxjCq3EuZcD6Tc2DV52fBM7nYNYXBlR+U3DiB85xEYPIyRponwslLGRt?=
 =?us-ascii?Q?PjyX9NUoZk+HjDegxNJ3VOclQg6kmbocFg4ynnreaWv8F5+/Vtvi/tA9m9hm?=
 =?us-ascii?Q?TJYu0/JmUFmQmJ4v2rwjquIan1MG3nGJZ10veNq9an1anZMr1VkPa68Ihf9l?=
 =?us-ascii?Q?PNcJRBY6u/9gjQuCVUgEQhm06RbrexS042/4NzeN4wg22bNGQUCSX5BA8Qhv?=
 =?us-ascii?Q?G+PIjWk9EqEstOk8z1Z+gYMHgCNduj8D0D9yrHeLer9PgicBeE1ZVEr0wSlU?=
 =?us-ascii?Q?znfYaH00ZjXvXEZxvNbhtFEEsi90FZEO+9zez+H+ha+P3DvWh6I9BGHU66i8?=
 =?us-ascii?Q?sW/WWQXu/CT2suQjQoA+q9stVRkWUEvAfKaYAy3N+lpsMaS1hXlVRSLHAwkn?=
 =?us-ascii?Q?9yr3wRiXD5iMpEAXO66opPJKlkjLDW+Y6m+V1gujnm4tZNEiahXsEOaOK2DI?=
 =?us-ascii?Q?8mi9AbQT3xXB6k4nbg0yuiU7ZrZ1qG4oEZ6ftKkkZY89eWQ6p1aljH+9/AUf?=
 =?us-ascii?Q?Tn1r678rq4+iYVhe+5HbxCBmXqTdG6ImNYZ7XCZq1WCKtpiSf0l8UkRDn7dG?=
 =?us-ascii?Q?SegL/ei62fQcKkJwXgga12S/PhynwBzeS1oaeVr3L/iXoIOcvqvDzqNDQsKr?=
 =?us-ascii?Q?6Sk77K903iDRvTmgv4Y1Dh8XPI95ZZJPyfrhFmIcf6Zso3Dp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d21a42-0fab-48ec-c4ef-08deb115c108
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:33.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TbUAV0SvZ5qMfMgG1qUFlu19VlZWoRD1sMjfYBC0z0BcfUfdbQ49u8EGt5ygdf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Rspamd-Queue-Id: 5DD2953839D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20591-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

Instead of having an alternative fops release always use the standard
uverbs_uobject_fd_release() and route the special async behavior back up
through uverbs_obj_fd_type ops pointer.

This removes a dependency where the technically lower level rdma_core.c is
referring to a symbol from uverbs_std_types_async_fd.c.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c           | 30 ++++++++++++++++---
 drivers/infiniband/core/uverbs.h              |  1 -
 drivers/infiniband/core/uverbs_main.c         |  2 +-
 .../core/uverbs_std_types_async_fd.c          | 22 +++++---------
 drivers/infiniband/core/uverbs_uapi.c         | 13 ++++++++
 include/rdma/uverbs_types.h                   |  8 ++++-
 6 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 5018ec837056ff..71e3d58d26e654 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -465,8 +465,8 @@ alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
 
 	fd_type =
 		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
-	if (WARN_ON(fd_type->fops && fd_type->fops->release != &uverbs_uobject_fd_release &&
-		    fd_type->fops->release != &uverbs_async_event_release)) {
+	if (WARN_ON(fd_type->fops &&
+		    fd_type->fops->release != &uverbs_uobject_fd_release)) {
 		ret = ERR_PTR(-EINVAL);
 		goto err_fd;
 	}
@@ -846,13 +846,35 @@ int uverbs_uobject_release(struct ib_uobject *uobj)
  */
 int uverbs_uobject_fd_release(struct inode *inode, struct file *filp)
 {
+	void (*release_cleanup)(struct ib_uobject *uobj) = NULL;
+	struct ib_uobject *uobj = filp->private_data;
+	int ret;
+
 	/*
 	 * This can only happen if the fput came from alloc_abort_fd_uobject()
 	 */
-	if (!filp->private_data)
+	if (!uobj)
 		return 0;
 
-	return uverbs_uobject_release(filp->private_data);
+	/*
+	 * uverbs_disassociate_api() can NULL type_attrs after disassociate, but
+	 * it won't if release_cleanup is used.
+	 */
+	if (uobj->uapi_object->type_attrs)
+		release_cleanup = container_of(uobj->uapi_object->type_attrs,
+					       struct uverbs_obj_fd_type, type)
+					  ->release_cleanup;
+	if (release_cleanup)
+		uverbs_uobject_get(uobj);
+
+	ret = uverbs_uobject_release(uobj);
+
+	if (release_cleanup) {
+		release_cleanup(uobj);
+		uverbs_uobject_put(uobj);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(uverbs_uobject_fd_release);
 
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index e353e195a49c74..31ce2e77fa3a64 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -203,7 +203,6 @@ void ib_uverbs_init_event_queue(struct ib_uverbs_event_queue *ev_queue);
 void ib_uverbs_init_async_event_file(struct ib_uverbs_async_event_file *ev_file);
 void ib_uverbs_free_event_queue(struct ib_uverbs_event_queue *event_queue);
 void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res);
-int uverbs_async_event_release(struct inode *inode, struct file *filp);
 
 int ib_alloc_ucontext(struct uverbs_attr_bundle *attrs);
 int ib_init_ucontext(struct uverbs_attr_bundle *attrs);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 15d8387718c050..a937d276c5c076 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -338,7 +338,7 @@ const struct file_operations uverbs_async_event_fops = {
 	.owner	 = THIS_MODULE,
 	.read	 = ib_uverbs_async_event_read,
 	.poll    = ib_uverbs_async_event_poll,
-	.release = uverbs_async_event_release,
+	.release = uverbs_uobject_fd_release,
 	.fasync  = ib_uverbs_async_event_fasync,
 };
 
diff --git a/drivers/infiniband/core/uverbs_std_types_async_fd.c b/drivers/infiniband/core/uverbs_std_types_async_fd.c
index cc24cfdf7aee66..671f510bca496f 100644
--- a/drivers/infiniband/core/uverbs_std_types_async_fd.c
+++ b/drivers/infiniband/core/uverbs_std_types_async_fd.c
@@ -32,14 +32,9 @@ static void uverbs_async_event_destroy_uobj(struct ib_uobject *uobj,
 					NULL, NULL);
 }
 
-int uverbs_async_event_release(struct inode *inode, struct file *filp)
+static void uverbs_async_event_free_event_queue(struct ib_uobject *uobj)
 {
 	struct ib_uverbs_async_event_file *event_file;
-	struct ib_uobject *uobj = filp->private_data;
-	int ret;
-
-	if (!uobj)
-		return uverbs_uobject_fd_release(inode, filp);
 
 	event_file =
 		container_of(uobj, struct ib_uverbs_async_event_file, uobj);
@@ -50,11 +45,7 @@ int uverbs_async_event_release(struct inode *inode, struct file *filp)
 	 * release. The user knows it has reached the end of the event stream
 	 * when it sees IB_EVENT_DEVICE_FATAL.
 	 */
-	uverbs_uobject_get(uobj);
-	ret = uverbs_uobject_fd_release(inode, filp);
 	ib_uverbs_free_event_queue(&event_file->ev_queue);
-	uverbs_uobject_put(uobj);
-	return ret;
 }
 
 DECLARE_UVERBS_NAMED_METHOD(
@@ -66,11 +57,12 @@ DECLARE_UVERBS_NAMED_METHOD(
 
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_ASYNC_EVENT,
-	UVERBS_TYPE_ALLOC_FD(sizeof(struct ib_uverbs_async_event_file),
-			     uverbs_async_event_destroy_uobj,
-			     &uverbs_async_event_fops,
-			     "[infinibandevent]",
-			     O_RDONLY),
+	UVERBS_TYPE_ALLOC_FD_RELEASE(sizeof(struct ib_uverbs_async_event_file),
+				     uverbs_async_event_destroy_uobj,
+				     uverbs_async_event_free_event_queue,
+				     &uverbs_async_event_fops,
+				     "[infinibandevent]",
+				     O_RDONLY),
 	&UVERBS_METHOD(UVERBS_METHOD_ASYNC_EVENT_ALLOC));
 
 const struct uapi_definition uverbs_def_obj_async_fd[] = {
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 31b248295854bd..4e2e556c8119b5 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -718,12 +718,25 @@ void uverbs_disassociate_api(struct uverbs_api *uapi)
 		if (uapi_key_is_object(iter.index)) {
 			struct uverbs_api_object *object_elm =
 				rcu_dereference_protected(*slot, true);
+			const struct uverbs_obj_type *type_attrs =
+				object_elm->type_attrs;
 
 			/*
 			 * Some type_attrs are in the driver module. We don't
 			 * bother to keep track of which since there should be
 			 * no use of this after disassociate.
+			 *
+			 * release_cleanup is the exception because
+			 * uverbs_uobject_fd_release() needs it. In this case
+			 * the module reference held by the fops will guarentee
+			 * the type_class remains valid too.
 			 */
+			if (type_attrs &&
+			    type_attrs->type_class == &uverbs_fd_class &&
+			    container_of(type_attrs, struct uverbs_obj_fd_type,
+					 type)->release_cleanup)
+				continue;
+
 			object_elm->type_attrs = NULL;
 		} else if (uapi_key_is_attr(iter.index)) {
 			struct uverbs_api_attr *elm =
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 6a253b7dc5ea66..5a07f9a6dcd1f6 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -147,6 +147,7 @@ struct uverbs_obj_fd_type {
 	struct uverbs_obj_type  type;
 	void (*destroy_object)(struct ib_uobject *uobj,
 			       enum rdma_remove_reason why);
+	void (*release_cleanup)(struct ib_uobject *uobj);
 	const struct file_operations	*fops;
 	const char			*name;
 	int				flags;
@@ -190,7 +191,8 @@ int uverbs_uobject_release(struct ib_uobject *uobj);
 
 #define UVERBS_BUILD_BUG_ON(cond) (sizeof(char[1 - 2 * !!(cond)]) -	\
 				   sizeof(char))
-#define UVERBS_TYPE_ALLOC_FD(_obj_size, _destroy_object, _fops, _name, _flags) \
+#define UVERBS_TYPE_ALLOC_FD_RELEASE(_obj_size, _destroy_object,	\
+				     _release_cleanup, _fops, _name, _flags) \
 	((&((const struct uverbs_obj_fd_type)				\
 	 {.type = {							\
 		.type_class = &uverbs_fd_class,				\
@@ -199,9 +201,13 @@ int uverbs_uobject_release(struct ib_uobject *uobj);
 					    sizeof(struct ib_uobject)), \
 	 },								\
 	 .destroy_object = _destroy_object,				\
+	 .release_cleanup = _release_cleanup,				\
 	 .fops = _fops,							\
 	 .name = _name,							\
 	 .flags = _flags}))->type)
+#define UVERBS_TYPE_ALLOC_FD(_obj_size, _destroy_object, _fops, _name, _flags) \
+	UVERBS_TYPE_ALLOC_FD_RELEASE(_obj_size, _destroy_object, NULL,	\
+				     _fops, _name, _flags)
 #define UVERBS_TYPE_ALLOC_IDR_SZ(_size, _destroy_object)	\
 	((&((const struct uverbs_obj_idr_type)				\
 	 {.type = {							\
-- 
2.43.0


