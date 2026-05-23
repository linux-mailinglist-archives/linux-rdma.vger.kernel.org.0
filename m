Return-Path: <linux-rdma+bounces-21183-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHHiLqLwEGo+fwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21183-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 739BB5BBB10
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C354301BA7D
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F918AE2;
	Sat, 23 May 2026 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JbblEdr2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF342233A
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495068; cv=fail; b=bOZ/aAW49qUR7ZUzva1WjBtt3wlPfanWFWbRqt/Mvo2c1wF1Yn/j5Hou/4+ocCf45icHyOPipHU1KySq7gCQDerFVyZcB2NwRSVKXKsOUF8g6KeZYhmkUeyHhv0eZ7c6P9fNfjuTGCK0Tnu+S4xfn3X19QX9p+FRCdb2WqjIkFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495068; c=relaxed/simple;
	bh=PYHvaWKVvFaBZ30OeI2eXzOPhNmdm5rTAikc+h73848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QK6jgweiP3hpx3oMPJjZg9qJt9tNf+mzc1kO0qvHL1ukLOjTdciCk14To39vUvbqaEwlHrtEa/fLwmKLyGR+anNHW7lbUYHyotx3rc0sfKxFdekMg4VjChvsSlacKQsU+AgiWtwIzOaOxkTpq/P89Bz/dYL8B9DJSvVT6xTAe3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JbblEdr2; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2Wh3WqgGbtql9T2pzg8LQBI3+0StZq9mfpNbN4bvxYwB/kVLnyBbI67kv5lbqdY2IK8UlpDBcrBFbrWCM2PRMMgIh8ji0hemng0rR7gO5QRJkLFnAagmAjV8/eJXIDiLz3uX2bS/2tVYl4TYPlGxPCO0YkvKxGJMRmVSUH8GkkryMtlPmx+ti/5pHsls04X+WiezYwWqlbI5efkgRgepA+CtQfW0ytQRFct7Gm19c0y+oZYGgspcT/jzxsIMy1oFhBWyz+Z7Io1kig37dP+iOGE8FydryRzVWooa8ARNmmIwRXuTHrEiKUBufWIFxEuNzdK33J0PQ70zEBIvjm75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWOs1Zlvt/PDx5x6doE0uW+9Dfzqm2XP+qlf3j4jJvQ=;
 b=hVuSB6WrHW7IUVYkvqWTSDzg6JBFWlCWfwlP8m4xL/WonWSBJtbx7AL1br4cb5sJbgGfaj+6Vh0YshiX45lgqNEgvnDUVhyiHVU6ygicF0EZ6YEO9Tgx+iNF8w6CRf0dKwfulxVaDKtKMbjarsOq0oCwPXegz1hMWJTwv3ySu+iRu4KJQ2YAb9xL6ATADp9FBKygt0tTWPWix3CsQ9gg43PfSa+wk6PFfAGwm+8wyJe7xBLRDaiPAZgoXeF7dpFf+LMqjfp0dlGlqhn1IB9RwUAhsz8rsh16cTsouElG5lNAcNNM0F3JqiDjFwJRB9AlewwdD97/eM0DUaTYzp2JIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWOs1Zlvt/PDx5x6doE0uW+9Dfzqm2XP+qlf3j4jJvQ=;
 b=JbblEdr2Wm5MTjoFH0MkwN1JVSIWkQVljIigXAgw8cndmtF+kL09RRnbaEHzh6exhNHuUthgXCtL2eSO3ntkPJBe1P623y2gtje/EG9oVRySJ4sbq87mF4f/uy7/4D8tmJxKZzEWDx0vl21ZSK6aXVOJScHOYFoHsAmxWdaQo82DcscdSSRlcl9H4ST+/TkWew25j+nics74VtI7bcNyGhqsUpKZ5FEHjCCY/D5mqjzE0sQmq4nCqFth6Gnr/+16QpGvraMqQnO5bkTsM8KVmG6DxLfsNKAooRPvNi/2fetGMBqs4j2+Uu3DUbrGaBz7z/L0P7O4AzdKmHTa4Sve+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 00:10:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 00:10:56 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v2 3/6] RDMA/core: Remove uverbs_async_event_release()
Date: Fri, 22 May 2026 21:10:50 -0300
Message-ID: <3-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0291.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1534bed1-b108-4237-de6f-08deb85fc278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gDKKY53C/0r3TbQyCMxeai6YeP0XpLz4G8owSd5rdT+UQ04qq8vq+X99gvw51BUDsHe3WWUq9OM9ewWDCVfdPTdJtP28qQ4Y33oelrowPYMMuo/ytH46aGb7GXU1npSPQHFqavAXtd6aYlVdCwm6CIM/WaPE3Ukqqcd9CrnNJrZpik5NchDtSV414tcXE6VlV2ex8LBCCb886EE5I4fYbkuaVhM1XvHgiJFRGblVpywMFLq4UBIwCVNrDXsqlEBiWn1y6f6ImRa46QW4deU0HjGHhocvpprwpvck2LibuvF+A9Q4c8mrTRal7r/e84O/oNXClamCOgbvcZ3y3MHDTd68Qc/KzJqtniv/2O+0x0agOoiQRh5lM0og4dJ9mgFd3mlZtUa1eqmYgKNfI6yC45jEyIgFqAfpUpypMstXOP1qqaBEHTwHilF7tkvMyFBxpLcrwvXml+qWQLguwL86UvdnvCF8bOUBMRRsvoGRCnLCEO2S3Sj+5AtRTPhg4c4Xb7HVkguaOVeV2LFdjdtJAr4ywoDT/HOD6kKOnhcvgvzPFZc+VVVANDm5VVrBrC11rmfb8XcNAl2T5k9QhWEcuBva2j+mU+IOrwjsTGAUWwJ9nRuYravRDBl6IkqM/vdWVgHtfeUKiem+p9GwMWOAet9jcbt70s1orqNnT70KHjSRQtmYbq408LBLPLl1IZMJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IkP0eXl7U7qlhngS/OgR6fodAFDMpjhwvJQ9TeeK7SW9x5X686gUq0Z2hxIY?=
 =?us-ascii?Q?0rIyd5DP8v/Mi2wE38V7BpluprvYo0fyetFPjrqoREyBD+M4mV2QtACtZZ0C?=
 =?us-ascii?Q?nrvF4xmLAZLDInXpFR59xlN95kEHIFKCkCrm4yq27T4knGmnv7WqAjA381Dy?=
 =?us-ascii?Q?+OypBX1jixXYQOcZ6nwxyAiP7h76BcmEo/GZRUTwLaRFM92ae3dNqQ414g9j?=
 =?us-ascii?Q?QKlTXCV7cZZatnOY1hvcPuphZLJHsIxadcOAQhAETmiFYDT/k+KMlCp3ivJl?=
 =?us-ascii?Q?QKNhHqslS8kwcxxxSb4c+tDVuWyJwbxJlM2mI3OE2OCY1RKWagRYD6kVa+KI?=
 =?us-ascii?Q?jZk5LHOVs4bbYRJ4u9ok67xip97UojF3Mmv3M1F2+Qz2HE3uR0npXptUjchx?=
 =?us-ascii?Q?JUo3jPhhP5dlu4zkB+3/Lf1a9Wki3DIJ8dG5sni41CPoGsUp3guYUG2hi6k+?=
 =?us-ascii?Q?9xcep5thzt3bb6GwWLOjC9NYaC3qws6/9bsJcDEcIdKBm+g6PkfHmwfJ6pgi?=
 =?us-ascii?Q?87Zlb6XWSiXr15DxC553jOOhTQpnnULJJevqmvawqi+2vhH57C0WafqLaMGs?=
 =?us-ascii?Q?Q3YWUzKkhYgE+IwSjUPdxBOb9J4YYXWb1LlO2kcIyp8gM2NSpJN6dVbPO/YA?=
 =?us-ascii?Q?ko5H/Ar7l8Vhvv8r/akskhmzfOZi6uE9PnXaHqmIy/PZMYyhHoRozm5sbbTc?=
 =?us-ascii?Q?sN4TkTg9kI01zbC79N4OtZWCVdHdY3FU4Sw/pG0A3wqzcGUGwDW/QmY8PCgP?=
 =?us-ascii?Q?dFPuzieJRebWzSo3cFsBtO9NsBFVUJE2G9AXYKwx4ZJ7i+/Fsbo0Ejd3NvmP?=
 =?us-ascii?Q?OvBeVTBz65Y+Kdb1jQqgZe1ojT9DFBmlSmH4wcSR42nL9ZQ5jZk9gQom7Prg?=
 =?us-ascii?Q?E+7tIyf0KMvZdq4skARkypz/2G/xqHbWDTRQc0wgmXsiwmElqo92/q+tkAjz?=
 =?us-ascii?Q?G2GiZKvyn+euS4JMi4Bqp+Zq/usqKdQp8rV71S0O2Up72nlcsg90e0AViwmp?=
 =?us-ascii?Q?hf+a9M/YuaJl8D7YkPwkpyDWTDc8rYKrz4R7MtOLTWXQgu+HlFRlWadSRvlf?=
 =?us-ascii?Q?H7q5JDuxAN5KZwz1VL9Bf7FU00enQ/jj6U+cUF7RQQJ4Ty16Z8LQFj6KaEkE?=
 =?us-ascii?Q?FsplLoE/sbUiDIFImEMw0vM1oyEyZWZMFoajTy/hCAYhJexNk+uAmAxuSI/1?=
 =?us-ascii?Q?g5a1A0fFmh7yX1kEsbR9iqYj5dR3O3+Hu1k6t83/e3EsLgLn1kO06L2xu+dq?=
 =?us-ascii?Q?LqPBspBCDFwvl/TZjiz07Cb/vAe23GONy6wgBg2zzWqBcis+PmOUKZg83i1M?=
 =?us-ascii?Q?HQbSZRJdlstiNYMVIGTtcz9fhudQzNIXBQ3SYh/LnQXjaYahgLrYWiA4x75d?=
 =?us-ascii?Q?YN1mfWC4rPmJiAn+KqtTnTRZzZpONKdmXbs6ciaGCXYXErXExwrIB8s1l8cc?=
 =?us-ascii?Q?yVosR55R+/nwGVGSYLF0p4H6SH2e5yFd/oTe3BWRGhJXCAdRbRzVkdA9aWcQ?=
 =?us-ascii?Q?C9VAkHEkULLDnUfFv5O/+zehdRA0lEHTfWA/U3WA/5Vx6KyfB+3M7Z5+TCG4?=
 =?us-ascii?Q?BoTc6XpV/iWrreQfzcvVg6ipQqjMJrJec3lq/8A7n8jxTDm+IC2jMVuyg7PQ?=
 =?us-ascii?Q?AsBg2Fu5crkFGCXYzNRfE8jsq+NAQ/iRG+kT/58xplVpSO+wGlaoaIHpND09?=
 =?us-ascii?Q?7spApNb88k1rw0oM64/V0v7qvB9gM7ADjZ4KHvFPP0rCSudN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1534bed1-b108-4237-de6f-08deb85fc278
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:10:56.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awgev5DWWCCg+qQt9LWK0Eo4S7qZrAu0hpUAhc/3nD/zfDJboxZetdzRKyXJWSYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21183-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 739BB5BBB10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 1563169c65009e..a1de8fe9c90bf1 100644
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


