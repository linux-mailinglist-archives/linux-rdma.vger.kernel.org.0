Return-Path: <linux-rdma+bounces-20592-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHP/Nym2BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20592-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:34:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ACF5381D0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34E4F300CE9A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114A4DC52D;
	Wed, 13 May 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fKbhlIT5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B14DBD70
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693629; cv=fail; b=hK3CuwFE+eM/Gr9+KQ9EirsfEt6rHql2/zXLtKxqZsKBEGLekJoLQTUIYL7CnCil27Njj6fdzolTy3mAdj6ozsgbpj3uZuRSCsADRY3iXOpkw80VAvd0IuDdovmYQP/J3H0L0bXX+bc49kxcFOREi8fo039+6tWoE7u01WbgqF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693629; c=relaxed/simple;
	bh=rQrfymBl6J6Nz2cnGdmyOwoKbz/gKqRUWBSrPSV2f5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAlHGlXg+xOqRxbBn6fSNYBCwl9fcPpAnhJ2+tMcyd1joP6GiBYY8t1tJgYHslDPwDZYIfJpYqiT21ucnh8nWXWRsfMpaVh4X3/Kp997c1y2FKzEDZ+U/NG/Tqv2MkehNz5U0GmcbiXbcPQpaoZxqdhEBg4wv9AC6kfn4LXlbYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fKbhlIT5; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhGITJwD47pBNx1hB3SaF8PQB/pFPA5CoVS9/UPRe+wFFABtdYF/IBLup92YtR0C3NjCwh5IZW7HuOW1oBTXjMhQ2uGDFVb1EI8IRQidKDO6nfICDwCyhA/siPFpFkfS4svx4lpOdVVc5Scj99SxHfgUYJT7F8M790wB56aYhZd5QkLkE8tA8uQWFb2nggmRCMI7rES93qeJ7QBAlf5J/TpzYJb9bX7/8ta20eF0Vnq5qN69mv9iba8apjhNZH0BIqL3I8blIB2NpxRTnLOdK4P+f8xOz6emRbYY+lMRjauCqwaB/KEBK374kCdJ4p4GirLF0UcjSOTv0t56UGyEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW6WvDn1CQiE0z/TQg5AnTCs7Me0ijixV9XtB9MkxIc=;
 b=iov4rTo6oGV3rndcm9GA+Mm42bHf1N+VnxbHSXzEIOY8X9tx0hqSqs1gQf3hQK9RCRMr0BndGwrcaAU2fQi2AYjg5++UHkBd/O/zxEmaw6WSPNvRuslKKPEmGIWN2H9jgj4KjW4gwUoz3yn/DF5eJ6qC5cFcELO/nJCQ5ri7UgSlUpCNaxjLVCgnl1RgyPfmD4NGUcpMD2jcTcl4aUmZqCrNa/p8/b8cth/V1J3n/LFVSVTEDbk78UD84YJ170qz3t8BZ9oQ/BmVYPkqHBaJJntlJ+NOkTTIhicbS5Oj8oVqC2xUBa00v4GrxrgvjYBGO+1BfvvNUokv23Vj62udBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW6WvDn1CQiE0z/TQg5AnTCs7Me0ijixV9XtB9MkxIc=;
 b=fKbhlIT5dUY03zxW7MgtEi9KIAWWr8YdVniQWKbODK+zqKEoVOXxfBHV+ZWpPU4C07dBH5KopKZNfY4LFzwaL8VQfmA4nMMmn5gVD1JCIs1PThzcb0uyo/PkJNHLc4Jdih5wPjcN3XQeZwAjQdsdYrB+eacBy8fw7MFBX7ceZrqdWzxicUII0H6vHJDo6XJ6Afg3ocDqXLd24c3x6dtnq5c05FREZNvyJdv9tBlZPNt4u9EN2gl9F7YktPy1pn++3rTbsIbiBnskDQOzJ5fKvHLWM6XLj0XCkV7rPFnT9wCKlLq5R+4+xw1MVSuuB+TWB7Ub0dG4SoNlvg8VUJiMag==
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
Subject: [PATCH 2/6] RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into ib_core_uverbs
Date: Wed, 13 May 2026 14:33:24 -0300
Message-ID: <2-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:208:15e::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: cb334a4b-0012-4121-93fb-08deb115c046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	NLiQzBWdTMaSAycVacVCgMHO/P/KkIYZSztvBe9ujtuuv+2uzFZQLANJneM1YSXI1Ibv3E1YfbugyZPBq/QBKlnVHndAeVTg4sDA1nnb6mabO5JZG0cw5kaelY+cS0vzX29Eszu4qQ06O9imfkjUKuw7DRyf/eiSFWk4qdUPnmeQgUtvV7+L02q3jccadqj7GeOVINmPfHbnu+d7j/Sg9FRJSwTAdRyvhjYpOeCH8wFZvnX8Ix7gNR7jEN9zhnhiQPS+e/8+djbMlaLhFLiEtXWSVZgip2rctX64GD/gpDnQ/r4ht2Af1i6+znHcTUsfx/8Pz/59fquGPgwfkafeMtHW/Tp6kub6uC1ZUup5FP7m2AaCweuzIe2BZZ1omUt3b/5vEMlcoMggsvJvrP5Tx7q+Ok73n/Vzxcg885gsBXj7pBiiil+mcpsOVyootQqgeCnZHJjZ0/LJ2Zq7TQP3f8HObrkN4nLVb+i0Cjrs99nO2vxOuz/aKiiS0C1XE7O5Qg5TpEdNWrvjnLlGJKefQuRZG8gVhWd+O1i158/FvdZEG+xhU1dTRs6+YEGL0ODSYSBMeLa8A8yyDPSQRMxdNQUFw8+NBQqoPI1scfHTSj7fTOd7HalpGKzCho0UGxwXzxaKE4HkC1ALUPZU7HC9C8KRmQ0vnEsd5ujqRiPT50HR4YBIytD/yT/4Vj9HqRkW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLN2O4fevnQB1R+Ag+wbD3J7tmvusqwvKfB3hxDWW0Dv2miGFNSZi/ZnR/2e?=
 =?us-ascii?Q?pBq/+r/OOHdTz2JxhTiOj4uMaLcuaFZAJEemDFXouJO0u/+P/MwaJjN1gQWj?=
 =?us-ascii?Q?nly58stSjhrfE0sOz5Ah8IA5MJ/yLOcsEr0jbHqn/XkjU/nV7btCd+yaO2hb?=
 =?us-ascii?Q?B3iif1iMDZx/xSFqeWQXIvoucntQss/goblF4KnrPrD9LeW6u2hjXj8yutuv?=
 =?us-ascii?Q?nBR0PnZ56cCMck5p+q7d6SwJA9X9x6706a/4qLCEHaud7AE8DROvQk6Mal+2?=
 =?us-ascii?Q?CBwORQuslZOEKehpZWcg50H9wkxBzRaRJtarDLR6LgX8WB+OmjNR6YlO0cTw?=
 =?us-ascii?Q?fndU8ncxWVNEtM5Ec8DyedGBvZcwX+pnU64Oma6fn/1hOlORAufLYTIyV/Nf?=
 =?us-ascii?Q?mFkxZQh0mFEeng6L0xH2BjBMcUKYM/GaeKyTDuFMrpvGYVi/gtAmaphceQWc?=
 =?us-ascii?Q?7e4Ks6C4HW6Vq0TqdtaOqQs8f9N4AFG4I8EU9oZyvWo3fj7x68vONHOvyzMX?=
 =?us-ascii?Q?6kF9z+TGz4U5mVhgm//W7J7sA6HFhkWaKimeSy0PgZ7inR/HvJGVD3QWcKHZ?=
 =?us-ascii?Q?+VNSDTE9RxYRmpracZujCo0IWt35nj9kQ/rDO/7w93FcPEY398NXhlM2cRWY?=
 =?us-ascii?Q?TcF4Ik/2RU4Q5+BbGLY9Pd6AnH6vtJPO9Sf4u1PrLlGHq0KfY5umJ+Uabp4F?=
 =?us-ascii?Q?dq0fnvnMpUBgkLh+9rcoblY/T5AgGnGF2hQC6uzMtOujvQ0rLj6UFZwHtE82?=
 =?us-ascii?Q?mZ1W5g9s4fyhtUG7jEUPjUe2KPN9mSVH908HJFmu1Gq1nvI8D2zTSQ7Ylb0o?=
 =?us-ascii?Q?PuVCdI1vXrdY1p/28lsqRLpswH9sAkfu6KrG+IO6uwjAXwvTfXnEAgj7C528?=
 =?us-ascii?Q?P2uqVUgjtiaKVspstUU6TW0tkhWdFdoEXhuebZqwNgkkN3ajBTtL5rcpgmFt?=
 =?us-ascii?Q?0OWyqo1tH9GyKm7cglokGA913FvxRLax8rAVG+xYCP28TyPpBP8U+mWsVYn/?=
 =?us-ascii?Q?mx6WyQX8/HGaYviovULxt7gsMhY++vqj0P4ycyONZt3iaVK7Kmfy8dA3MKA3?=
 =?us-ascii?Q?heBLr75cVgSJbVdzy5nljdhl0qsLYBhTDGMdrR7BwmHrsoYRkX6XeaHsQKTz?=
 =?us-ascii?Q?jMjRs6L6JScheS4GRJJHvR6lUQ2lzcNeG4friKw1PX6/pzPwnhWfSIN6ruv2?=
 =?us-ascii?Q?Yf4lGS3TaqSW5n+6AZjJqVrhVZgzOIxU24d2WKJAmHGhFtwPDaqVIPbRIeNg?=
 =?us-ascii?Q?lwEoddCpyNRe2qE4FoQXGkvJ7YEnmsp+9w+kWrda1U6qoIB7RhbcRpoK2lpa?=
 =?us-ascii?Q?DkEwm4X+WRh9RVxZLLp+AFu9xGtgXCHFH7hv+w1xYJFbdR2obFLTxNacYqgV?=
 =?us-ascii?Q?UmmZo62cGJNZPFOltzafjS9q4CRJb/ia5i0Q7v/F3To0g2uEntPAiq9wqKyU?=
 =?us-ascii?Q?PDOI97SMu6o6VqWuOlbRk9doRgPB/V+AwSsxQQX4tqR5SjzWMeElQC2HgjVx?=
 =?us-ascii?Q?mGX8YqzcFYwxYRB9KpT73DqT7rB3kJ2fC3UauNVjWLBdQiSheDaJ/+4zIzFT?=
 =?us-ascii?Q?aSCG6sdgNJ/aVMIY2Tab4iJWqL5fPvscT6AGAWpzEcuF+uo+pMdXUE6aBJWj?=
 =?us-ascii?Q?tzp/X2MMtaFcJd4N3hNwlskbjGZ7U0uhoVGIKokPqkP3A1czdKPpOsffAHRW?=
 =?us-ascii?Q?d2fhTTnrnPa1EiuWSXik3pyynzC8jrJ5t4sUWfceWxFo4StO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb334a4b-0012-4121-93fb-08deb115c046
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:31.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Hyd74OCrHH+rLIwEOfmwbyQc54ki2J/Mtki3JL+UjuA2ex2rD0sSWB8ckmlWMyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Rspamd-Queue-Id: 83ACF5381D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20592-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index c94d03857318eb..11e43a711207e6 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -503,3 +503,221 @@ int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
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
index a74a2dff1301ed..e353e195a49c74 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -264,6 +264,21 @@ struct bundle_priv {
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
index 33feb88d652b6a..0e67de0fff570d 100644
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
@@ -614,57 +555,6 @@ long ib_uverbs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
@@ -705,24 +595,6 @@ void uverbs_fill_udata(struct uverbs_attr_bundle *bundle,
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
@@ -736,79 +608,3 @@ int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx)
 
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


