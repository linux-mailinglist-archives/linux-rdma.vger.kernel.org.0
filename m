Return-Path: <linux-rdma+bounces-21265-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CRBHwP2FGr2RwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21265-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE9D5CF6DF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A4CC301B90B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D322BE7CD;
	Tue, 26 May 2026 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gNq/GAIf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4E29A9C3
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758590; cv=fail; b=Pyhp6+Z0HWOhPgKQQ3+FKapnXf59LSHRUBY+LwzV2AaLxXZMwobtyiBwkeImRqdLCuUxYeiujwE3juugoejdo33KD3Cr9t+PAxCUsruuu47vYFOG+fl5whrd8bbEIHKv3dB+S2/PFwrTLHBo1dGMsnKe1Oo51cIUEZq22g6slbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758590; c=relaxed/simple;
	bh=dydimFYW4jxWRHG9VxASKou0rQ08V/TGSiJyc24SzTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tuYQa/Dxyuv4ahpAySQbpsb//uMWC826Aw0sXfmrnLd8apeEI/IZ3VkPUhJqEv6kgP97zrARncaYDfWeGL2X1fW1U9AuxIUabHnbXUugBSybVNQbc362guQ69sDK0gttUQSrnSfsjDCmRY74b2VMt4P4BoYVLZ3LinAJLdbmKto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gNq/GAIf; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7qWTW603in6S7jw4GxkbWBJ7HWFuqyHNfGIgVbkV3oJuXH6PymxIJeaKUKfRScKEWmugdOptx63dB5CTrgEzN5/OQNwlvbNJS7MLSuGYGmLy9ky2AlGZ3xicY4t15G9tCGK6N/Qm0+CafX7kPWuKnXWZLKKSDcnV/GdEuwYs5S3725x2GEL7Nav75SE0UB8xVVnYoEXJyTx+dbVdRwo7WX44aPdw70VTGzBeW6rlI137/++w+eHF2YVFwmMgzpQPWXnceeyaSovxPSDgO5PArx3eCFwy3YKm5VtXbCRMSPhI5JEmvpWRaGlgZ5Jww7YbkRX/gcuB2taufMkcvJjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jahQWnMsNQmUfRNllHyqagdjeiBxaBYndqkYUHxtFwM=;
 b=U2txNZOjmYbIZk6MeAxmVHU6Vmu0/+phnSk9x3Mnwik/i103yZIbxO4vj3mzK6aoOZAFtKjRADcCQHyQj/ibaj9DTUipKZGIAOhxNYdeuLJLZ8GP/WaNxNe/7Ut5eSczCJJmf3A9KXSGkvQ9MlaPlTvMz3M7AQST1Fby+G3mviW+NMCScp2xuBrkBMseWCBOIHpffadO7QRUC+7a2Eag4OO1EaWgHFgRtDwy4Rr6Uw62gS4TpzUI8LpIhfQpTmR028LaMPSL/ZZgldlveJ+Zv5/ykRR3QLuBYvYpJ00N1h+7h0kzW+m5lmJahIwaqPV6K6ocDuwjhzlfQWDmfhIv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jahQWnMsNQmUfRNllHyqagdjeiBxaBYndqkYUHxtFwM=;
 b=gNq/GAIfgy1n5fL06HB42ZENKP177T8y5SAmcxtbiq6bwrzoeFq79S7PANTfutt8+45sAKuo/kX7EUn6SwMekhR63uhQ8/q+TK9rPt4psRP2nYTm/YPEjcC1j8YoKK2eOSDjCBui54FFZZ5BlIaHcbjEzalUyTkideG0LOAsk6ekxPoDO+vSklA3ka2OtEg74WksOTW/+C4vyYOAUdlcstiAYSaM0kI3P7ksAkuMtMRVsYto41fU8u/2W3HxGw8hmKJ5BSqItq0OWULqyOmY64l9v0O2ke4HMEgU8e6Jtba7wAoYqY3h/+cUzU/lvzXaCt+3iAyHSwef3tgahmQcyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:22:47 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:22:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v3 2/6] RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into ib_core_uverbs
Date: Mon, 25 May 2026 22:22:38 -0300
Message-ID: <2-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:208:32a::11) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: c3eb8137-9bee-4942-0b3d-08debac54aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	2dnZgtfRbFyRjY0CnaerdUTWrC6RCs5t6/3CUJFFnHubQT0mBAV/Mnv8aK17esGtN0fbNZAIBxo8hDr5vAQDQBdktMD3rkOJhkhNgpLRHcGhbfIsxguvwQqyEj9UIewlxqT0oL6VC9pDZIG9bpsMw8O1H91T+4jjiBypGDg6hcHwnQPaAfGbCB0SfuHibQ+xPM2eMcKavnBb4yxqjWhKZR72/2Cr3T7qRj9Kirv0vmssHM4Vxi++Thh2xNcwSa9aFW/F+9s1Da6bhOgAn7FtC8Dm6eG4rW0wie6q0q9e8orFT4VkG/PSV+HyPpjfPQUbCvHwGx+g1YPbiYXN/H1EyG0Xgx+s+Vfzo/aeuiE5VWR7Frdq+dqRmqmOXAFhmF/DLlG0WrwOZStSBIzmEr0ECxsAhEr6HHQlzCYW6IHOSvOODICfMhrnDD19aqt0NsGE3AJnWjB+dVFYC9s4IodAM33HvHRUll2SRsmmw9G0YYD+IZSDW7kum+CAhRZLguEW2Itegu4F/O3dA4pL+AG8jHPF7V3ySP27xt6Qk44hpA0fFAVecjiyJkvAFyodhb5Yf1VZl2Q9bZZ/MrDqqJ6cL/2Sd+O+tyzS9NsaN74B2AP9FRdGB297naUF43qox4GGaJYvkymN5ku5sU4UmqcoN953X/LIxVa0OgZxMgy/xSLsSzVI48DQ87hLkv5tzY7h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1e5amxz0MebSSIDCYr+FhkKkw78xg7J5klaWv0Sx05CmtasUDDzoNolpJ0R?=
 =?us-ascii?Q?Jt3SQQfXhZRJUrdnAcPw8lgSwQl9FSTBBxjU2b/L479lIlewVyZKpGm3reE7?=
 =?us-ascii?Q?KT59tk+fHAsVm7ji1r9BLYlsbJ50nf9yPdIwN8J6TPxZLnVaCDrpOmK09dX0?=
 =?us-ascii?Q?D8RWcyknU6xNcOtbI8QeZ+IRaE8sKjX73te2oA7gIwF2AsPi48/qDS1IyEcA?=
 =?us-ascii?Q?DbcghvKJHl/CcOCfOpbVWNnziJNYq+p6CPcJiC8yF5lX27U3k292DuLYXksp?=
 =?us-ascii?Q?0SXMAUkOHAvGX4cgzz8RjEi0c/ox09mXjs7V0VzrK46dxGfWPo4TST4V5rsi?=
 =?us-ascii?Q?ZY2tkBUPEBd0v4vu1Dgotv2kWKkxiJtiQh6EjQF41lQyErro9XHWbcaTq8/7?=
 =?us-ascii?Q?4ao5d7jsW0HBy26PCFGJWl9sCiO012Na6vl8o+ia+eDrcKz6I0c3SyfXx/0v?=
 =?us-ascii?Q?1iJho13v4T6DP+P8UcLU8tdEZKLPQBjGO3yzXIucCLaS3jqwH80kvYph9c96?=
 =?us-ascii?Q?qDpzF4WDYPzrdgrIdKIuFnbQKUEEJAdtJBY3nIPaJP4syBDngAX+akoU7A/F?=
 =?us-ascii?Q?gp6OCC3c9lg9jPS37md6WwDK1+flbo0zHY0n4jfeT3MUnub+xno6aqN+7LUt?=
 =?us-ascii?Q?VffafSCyb6oOZNBhbICifNtP2/DJqT0R+eUeEGaOlDi2or4v+02hNlDtHRR4?=
 =?us-ascii?Q?iktznn1RZRnhA3wHCaaJyvCf0QiW2PoZJFYmtQ+heGFTYDNvNuWTYdF9gunI?=
 =?us-ascii?Q?za0Bysex+m8WmOb4wrKX7IwpbOraZgYspJ3YuBYfYIksB6Sk1HYQz5BLfAwX?=
 =?us-ascii?Q?8bMbWk3QEccysFzFt7GoPpZcCpn4ekhrRaJIWX+DPxbwGCelnVJU4IQmr2Dv?=
 =?us-ascii?Q?9o4RRyyMVSOMOdKK42nZJro1MGtpSmlCQbTH6QI89U5tRRBe8ymHsmtrKVV6?=
 =?us-ascii?Q?eZeoANZ6zVYTLhN2ynWQJRvpCSa6/XXrWRX5rM2zX1il+3YTvpvERGIEaCM3?=
 =?us-ascii?Q?44PWG8sPQcdOaBTQrZYpwlX/d/xVfGHBVSeIUNPcKbxqdVtmMROoAKVpqyUC?=
 =?us-ascii?Q?IItuzKzeEE0csdbJZnY1Sb+dm+44VOgg+M0WZWbWYwOpNBNi9o17uDaJXY4A?=
 =?us-ascii?Q?kfmnK58CscgD4Gm1tK8fJhAzPcDngCzimAH4Eb/WBaYYcp+1Neqs8hMCMjww?=
 =?us-ascii?Q?yfCFYD+ssqGS5H/h+W4dbeZvyHQXBoI22QuXwCU1oK95eajQ+1VyxLRDqF8H?=
 =?us-ascii?Q?XgUnamb6jMs5DP8F5omIa2WYxadcC3WSTEjxDkDh0IXDF9FWu2NXI+hdRG5T?=
 =?us-ascii?Q?qAQlM90kTPpJzCVIjElNpMK0ICkMhxmvcHe0eEP0GFbBStrYqQCks56wYEfM?=
 =?us-ascii?Q?+X9guqtDjrtYwebTe3g8RVv5MuUL3StNX+gC4i1rk1H9r6wA7pw3PJcMBeZe?=
 =?us-ascii?Q?emjhqpXPIridEKZVsXjPIwa06O+QgWwt7QxD7gVgm4B/VsB5f2QOb3G++Dgh?=
 =?us-ascii?Q?tQriaGNE3tu5mifO8s4LKIfRsSXZK/7LI2DRuJi16vGqdIaEezhuyxnGYpkQ?=
 =?us-ascii?Q?iyQzssZWAGW03nHN7lW43rcF25W8HQK520tRSnb4cLGAnCVHeSoqfzFzUTB9?=
 =?us-ascii?Q?SL7Z1iYi8u+gtTti56VMvo9poALi42oi+3b63wJSgJQTJ6kVfh/+lCGEkPqN?=
 =?us-ascii?Q?h/caNYrZcLeJzoLcDRYjzUGnhfOPP9/u2ALJE0ycH9HUbxdJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eb8137-9bee-4942-0b3d-08debac54aca
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:22:46.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSyxxCRHdS+Vj2Wt064P0EJevrydJfNIzle+9pyuQxKcfcX7AwDeSuxGVas5rJfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21265-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 0AE9D5CF6DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Not as many drivers need these functions but it does free efa from the
ib_uverbs.ko dependency and follows the general design better.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/ib_core_uverbs.c   | 218 +++++++++++++++++++++
 drivers/infiniband/core/uverbs.h           |  15 ++
 drivers/infiniband/core/uverbs_ioctl.c     | 204 -------------------
 drivers/infiniband/core/uverbs_main.c      |  24 ---
 drivers/infiniband/core/uverbs_std_types.c |   6 -
 5 files changed, 233 insertions(+), 234 deletions(-)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 0acb0d4967cb6b..b4fc693a3bd8b7 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -501,3 +501,221 @@ int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(_ib_respond_udata);
+
+/*
+ * Must be called with the ufile->device->disassociate_srcu held, and the lock
+ * must be held until use of the ucontext is finished.
+ */
+struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile)
+{
+	/*
+	 * We do not hold the hw_destroy_rwsem lock for this flow, instead
+	 * srcu is used. It does not matter if someone races this with
+	 * get_context, we get NULL or valid ucontext.
+	 */
+	struct ib_ucontext *ucontext = smp_load_acquire(&ufile->ucontext);
+
+	if (!srcu_dereference(ufile->device->ib_dev,
+			      &ufile->device->disassociate_srcu))
+		return ERR_PTR(-EIO);
+
+	if (!ucontext)
+		return ERR_PTR(-EINVAL);
+
+	return ucontext;
+}
+EXPORT_SYMBOL(ib_uverbs_get_ucontext_file);
+
+int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
+{
+	return 0;
+}
+EXPORT_SYMBOL(uverbs_destroy_def_handler);
+
+/**
+ * _uverbs_alloc() - Quickly allocate memory for use with a bundle
+ * @bundle: The bundle
+ * @size: Number of bytes to allocate
+ * @flags: Allocator flags
+ *
+ * The bundle allocator is intended for allocations that are connected with
+ * processing the system call related to the bundle. The allocated memory is
+ * always freed once the system call completes, and cannot be freed any other
+ * way.
+ *
+ * This tries to use a small pool of pre-allocated memory for performance.
+ */
+__malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
+			     gfp_t flags)
+{
+	struct bundle_priv *pbundle =
+		container_of(&bundle->hdr, struct bundle_priv, bundle);
+	size_t new_used;
+	void *res;
+
+	if (check_add_overflow(size, pbundle->internal_used, &new_used))
+		return ERR_PTR(-EOVERFLOW);
+
+	if (new_used > pbundle->internal_avail) {
+		struct bundle_alloc_head *buf;
+
+		buf = kvmalloc_flex(*buf, data, size, flags);
+		if (!buf)
+			return ERR_PTR(-ENOMEM);
+		buf->next = pbundle->allocated_mem;
+		pbundle->allocated_mem = buf;
+		return buf->data;
+	}
+
+	res = (void *)pbundle->internal_buffer + pbundle->internal_used;
+	pbundle->internal_used =
+		ALIGN(new_used, sizeof(*pbundle->internal_buffer));
+	if (want_init_on_alloc(flags))
+		memset(res, 0, size);
+	return res;
+}
+EXPORT_SYMBOL(_uverbs_alloc);
+
+int uverbs_copy_to(const struct uverbs_attr_bundle *bundle, size_t idx,
+		   const void *from, size_t size)
+{
+	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
+	size_t min_size;
+
+	if (IS_ERR(attr))
+		return PTR_ERR(attr);
+
+	min_size = min_t(size_t, attr->ptr_attr.len, size);
+	if (copy_to_user(u64_to_user_ptr(attr->ptr_attr.data), from, min_size))
+		return -EFAULT;
+
+	return uverbs_set_output(bundle, attr);
+}
+EXPORT_SYMBOL(uverbs_copy_to);
+
+int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
+				  size_t idx, const void *from, size_t size)
+{
+	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
+
+	if (IS_ERR(attr))
+		return PTR_ERR(attr);
+
+	if (size < attr->ptr_attr.len) {
+		if (clear_user(u64_to_user_ptr(attr->ptr_attr.data) + size,
+			       attr->ptr_attr.len - size))
+			return -EFAULT;
+	}
+	return uverbs_copy_to(bundle, idx, from, size);
+}
+EXPORT_SYMBOL(uverbs_copy_to_struct_or_zero);
+
+int _uverbs_get_const_unsigned(u64 *to,
+			       const struct uverbs_attr_bundle *attrs_bundle,
+			       size_t idx, u64 upper_bound, u64 *def_val)
+{
+	const struct uverbs_attr *attr;
+
+	attr = uverbs_attr_get(attrs_bundle, idx);
+	if (IS_ERR(attr)) {
+		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
+			return PTR_ERR(attr);
+
+		*to = *def_val;
+	} else {
+		*to = attr->ptr_attr.data;
+	}
+
+	if (*to > upper_bound)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(_uverbs_get_const_unsigned);
+
+int _uverbs_get_const_signed(s64 *to,
+			     const struct uverbs_attr_bundle *attrs_bundle,
+			     size_t idx, s64 lower_bound, u64 upper_bound,
+			     s64  *def_val)
+{
+	const struct uverbs_attr *attr;
+
+	attr = uverbs_attr_get(attrs_bundle, idx);
+	if (IS_ERR(attr)) {
+		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
+			return PTR_ERR(attr);
+
+		*to = *def_val;
+	} else {
+		*to = attr->ptr_attr.data;
+	}
+
+	if (*to < lower_bound || (*to > 0 && (u64)*to > upper_bound))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(_uverbs_get_const_signed);
+
+int uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
+		       size_t idx, u64 allowed_bits)
+{
+	const struct uverbs_attr *attr;
+	u64 flags;
+
+	attr = uverbs_attr_get(attrs_bundle, idx);
+	/* Missing attribute means 0 flags */
+	if (IS_ERR(attr)) {
+		*to = 0;
+		return 0;
+	}
+
+	/*
+	 * New userspace code should use 8 bytes to pass flags, but we
+	 * transparently support old userspaces that were using 4 bytes as
+	 * well.
+	 */
+	if (attr->ptr_attr.len == 8)
+		flags = attr->ptr_attr.data;
+	else if (attr->ptr_attr.len == 4)
+		flags = *(u32 *)&attr->ptr_attr.data;
+	else
+		return -EINVAL;
+
+	if (flags & ~allowed_bits)
+		return -EINVAL;
+
+	*to = flags;
+	return 0;
+}
+EXPORT_SYMBOL(uverbs_get_flags64);
+
+int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
+		       size_t idx, u64 allowed_bits)
+{
+	u64 flags;
+	int ret;
+
+	ret = uverbs_get_flags64(&flags, attrs_bundle, idx, allowed_bits);
+	if (ret)
+		return ret;
+
+	if (flags > U32_MAX)
+		return -EINVAL;
+	*to = flags;
+
+	return 0;
+}
+EXPORT_SYMBOL(uverbs_get_flags32);
+
+/* Once called an abort will call through to the type's destroy_hw() */
+void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
+				 u16 idx)
+{
+	struct bundle_priv *pbundle =
+		container_of(&bundle->hdr, struct bundle_priv, bundle);
+
+	__set_bit(uapi_bkey_attr(uapi_key_attr(idx)),
+		  pbundle->uobj_hw_obj_valid);
+}
+EXPORT_SYMBOL(uverbs_finalize_uobj_create);
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index f2e192b51e609c..1563169c65009e 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -263,6 +263,21 @@ struct bundle_priv {
 	u64 internal_buffer[32];
 };
 
+static inline int uverbs_set_output(const struct uverbs_attr_bundle *bundle,
+				    const struct uverbs_attr *attr)
+{
+	struct bundle_priv *pbundle =
+		container_of(&bundle->hdr, struct bundle_priv, bundle);
+	u16 flags;
+
+	flags = pbundle->uattrs[attr->ptr_attr.uattr_idx].flags |
+		UVERBS_ATTR_F_VALID_OUTPUT;
+	if (put_user(flags,
+		     &pbundle->user_attrs[attr->ptr_attr.uattr_idx].flags))
+		return -EFAULT;
+	return 0;
+}
+
 long ib_uverbs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 
 struct ib_uverbs_flow_spec {
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 2552a7efe2fbe2..6a78288e27a1c7 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -58,50 +58,6 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
 	WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
 }
 
-/**
- * _uverbs_alloc() - Quickly allocate memory for use with a bundle
- * @bundle: The bundle
- * @size: Number of bytes to allocate
- * @flags: Allocator flags
- *
- * The bundle allocator is intended for allocations that are connected with
- * processing the system call related to the bundle. The allocated memory is
- * always freed once the system call completes, and cannot be freed any other
- * way.
- *
- * This tries to use a small pool of pre-allocated memory for performance.
- */
-__malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
-			     gfp_t flags)
-{
-	struct bundle_priv *pbundle =
-		container_of(&bundle->hdr, struct bundle_priv, bundle);
-	size_t new_used;
-	void *res;
-
-	if (check_add_overflow(size, pbundle->internal_used, &new_used))
-		return ERR_PTR(-EOVERFLOW);
-
-	if (new_used > pbundle->internal_avail) {
-		struct bundle_alloc_head *buf;
-
-		buf = kvmalloc_flex(*buf, data, size, flags);
-		if (!buf)
-			return ERR_PTR(-ENOMEM);
-		buf->next = pbundle->allocated_mem;
-		pbundle->allocated_mem = buf;
-		return buf->data;
-	}
-
-	res = (void *)pbundle->internal_buffer + pbundle->internal_used;
-	pbundle->internal_used =
-		ALIGN(new_used, sizeof(*pbundle->internal_buffer));
-	if (want_init_on_alloc(flags))
-		memset(res, 0, size);
-	return res;
-}
-EXPORT_SYMBOL(_uverbs_alloc);
-
 static bool uverbs_is_attr_cleared(const struct ib_uverbs_attr *uattr,
 				   u16 len)
 {
@@ -113,21 +69,6 @@ static bool uverbs_is_attr_cleared(const struct ib_uverbs_attr *uattr,
 			   0, uattr->len - len);
 }
 
-static int uverbs_set_output(const struct uverbs_attr_bundle *bundle,
-			     const struct uverbs_attr *attr)
-{
-	struct bundle_priv *pbundle =
-		container_of(&bundle->hdr, struct bundle_priv, bundle);
-	u16 flags;
-
-	flags = pbundle->uattrs[attr->ptr_attr.uattr_idx].flags |
-		UVERBS_ATTR_F_VALID_OUTPUT;
-	if (put_user(flags,
-		     &pbundle->user_attrs[attr->ptr_attr.uattr_idx].flags))
-		return -EFAULT;
-	return 0;
-}
-
 static int uverbs_process_idrs_array(struct bundle_priv *pbundle,
 				     const struct uverbs_api_attr *attr_uapi,
 				     struct uverbs_objs_arr_attr *attr,
@@ -616,57 +557,6 @@ long ib_uverbs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-int uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
-		       size_t idx, u64 allowed_bits)
-{
-	const struct uverbs_attr *attr;
-	u64 flags;
-
-	attr = uverbs_attr_get(attrs_bundle, idx);
-	/* Missing attribute means 0 flags */
-	if (IS_ERR(attr)) {
-		*to = 0;
-		return 0;
-	}
-
-	/*
-	 * New userspace code should use 8 bytes to pass flags, but we
-	 * transparently support old userspaces that were using 4 bytes as
-	 * well.
-	 */
-	if (attr->ptr_attr.len == 8)
-		flags = attr->ptr_attr.data;
-	else if (attr->ptr_attr.len == 4)
-		flags = *(u32 *)&attr->ptr_attr.data;
-	else
-		return -EINVAL;
-
-	if (flags & ~allowed_bits)
-		return -EINVAL;
-
-	*to = flags;
-	return 0;
-}
-EXPORT_SYMBOL(uverbs_get_flags64);
-
-int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
-		       size_t idx, u64 allowed_bits)
-{
-	u64 flags;
-	int ret;
-
-	ret = uverbs_get_flags64(&flags, attrs_bundle, idx, allowed_bits);
-	if (ret)
-		return ret;
-
-	if (flags > U32_MAX)
-		return -EINVAL;
-	*to = flags;
-
-	return 0;
-}
-EXPORT_SYMBOL(uverbs_get_flags32);
-
 /*
  * Fill a ib_udata struct (core or uhw) using the given attribute IDs.
  * This is primarily used to convert the UVERBS_ATTR_UHW() into the
@@ -707,24 +597,6 @@ void uverbs_fill_udata(struct uverbs_attr_bundle *bundle,
 	}
 }
 
-int uverbs_copy_to(const struct uverbs_attr_bundle *bundle, size_t idx,
-		   const void *from, size_t size)
-{
-	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
-	size_t min_size;
-
-	if (IS_ERR(attr))
-		return PTR_ERR(attr);
-
-	min_size = min_t(size_t, attr->ptr_attr.len, size);
-	if (copy_to_user(u64_to_user_ptr(attr->ptr_attr.data), from, min_size))
-		return -EFAULT;
-
-	return uverbs_set_output(bundle, attr);
-}
-EXPORT_SYMBOL(uverbs_copy_to);
-
-
 /*
  * This is only used if the caller has directly used copy_to_use to write the
  * data.  It signals to user space that the buffer is filled in.
@@ -738,79 +610,3 @@ int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx)
 
 	return uverbs_set_output(bundle, attr);
 }
-
-int _uverbs_get_const_signed(s64 *to,
-			     const struct uverbs_attr_bundle *attrs_bundle,
-			     size_t idx, s64 lower_bound, u64 upper_bound,
-			     s64  *def_val)
-{
-	const struct uverbs_attr *attr;
-
-	attr = uverbs_attr_get(attrs_bundle, idx);
-	if (IS_ERR(attr)) {
-		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
-			return PTR_ERR(attr);
-
-		*to = *def_val;
-	} else {
-		*to = attr->ptr_attr.data;
-	}
-
-	if (*to < lower_bound || (*to > 0 && (u64)*to > upper_bound))
-		return -EINVAL;
-
-	return 0;
-}
-EXPORT_SYMBOL(_uverbs_get_const_signed);
-
-int _uverbs_get_const_unsigned(u64 *to,
-			       const struct uverbs_attr_bundle *attrs_bundle,
-			       size_t idx, u64 upper_bound, u64 *def_val)
-{
-	const struct uverbs_attr *attr;
-
-	attr = uverbs_attr_get(attrs_bundle, idx);
-	if (IS_ERR(attr)) {
-		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
-			return PTR_ERR(attr);
-
-		*to = *def_val;
-	} else {
-		*to = attr->ptr_attr.data;
-	}
-
-	if (*to > upper_bound)
-		return -EINVAL;
-
-	return 0;
-}
-EXPORT_SYMBOL(_uverbs_get_const_unsigned);
-
-int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
-				  size_t idx, const void *from, size_t size)
-{
-	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
-
-	if (IS_ERR(attr))
-		return PTR_ERR(attr);
-
-	if (size < attr->ptr_attr.len) {
-		if (clear_user(u64_to_user_ptr(attr->ptr_attr.data) + size,
-			       attr->ptr_attr.len - size))
-			return -EFAULT;
-	}
-	return uverbs_copy_to(bundle, idx, from, size);
-}
-EXPORT_SYMBOL(uverbs_copy_to_struct_or_zero);
-
-/* Once called an abort will call through to the type's destroy_hw() */
-void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
-				 u16 idx)
-{
-	struct bundle_priv *pbundle =
-		container_of(&bundle->hdr, struct bundle_priv, bundle);
-
-	__set_bit(uapi_bkey_attr(uapi_key_attr(idx)),
-		  pbundle->uobj_hw_obj_valid);
-}
-EXPORT_SYMBOL(uverbs_finalize_uobj_create);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index f5837da47299c1..15d8387718c050 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -91,30 +91,6 @@ static const struct class uverbs_class = {
 	.devnode = uverbs_devnode,
 };
 
-/*
- * Must be called with the ufile->device->disassociate_srcu held, and the lock
- * must be held until use of the ucontext is finished.
- */
-struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile)
-{
-	/*
-	 * We do not hold the hw_destroy_rwsem lock for this flow, instead
-	 * srcu is used. It does not matter if someone races this with
-	 * get_context, we get NULL or valid ucontext.
-	 */
-	struct ib_ucontext *ucontext = smp_load_acquire(&ufile->ucontext);
-
-	if (!srcu_dereference(ufile->device->ib_dev,
-			      &ufile->device->disassociate_srcu))
-		return ERR_PTR(-EIO);
-
-	if (!ucontext)
-		return ERR_PTR(-EINVAL);
-
-	return ucontext;
-}
-EXPORT_SYMBOL(ib_uverbs_get_ucontext_file);
-
 int uverbs_dealloc_mw(struct ib_mw *mw)
 {
 	struct ib_pd *pd = mw->pd;
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index 13776a66e2e43a..e160786e1df164 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -165,12 +165,6 @@ uverbs_completion_event_file_destroy_uobj(struct ib_uobject *uobj,
 	ib_uverbs_free_event_queue(&file->ev_queue);
 }
 
-int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
-{
-	return 0;
-}
-EXPORT_SYMBOL(uverbs_destroy_def_handler);
-
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_COMP_CHANNEL,
 	UVERBS_TYPE_ALLOC_FD(sizeof(struct ib_uverbs_completion_event_file),
-- 
2.43.0


