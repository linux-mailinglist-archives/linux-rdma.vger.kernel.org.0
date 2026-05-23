Return-Path: <linux-rdma+bounces-21182-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KENSKZ7wEGo+fwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21182-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D235BBAFB
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7362E300EDBA
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC323741;
	Sat, 23 May 2026 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ecP07svu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B92F851
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495065; cv=fail; b=dxOtXag0fg/vzQeP1qeb0M6i7gW0heQOXvpWEoAyi32VWWFGCIq1eCCOvShXyY7lTavAbDeR+E0Hqv+OecToDX4e5WS3V1ShJtLnqP8YSkJAGMLsuQeA5/wyg9EyxIfJMNBThxyl1hAaA7QyM+SCSwF4m3M2iGsy2C5i/eQrvlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495065; c=relaxed/simple;
	bh=dydimFYW4jxWRHG9VxASKou0rQ08V/TGSiJyc24SzTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYf0pTs46UtEekEfJ4yERg405CzH1g9HWI3nftTbQg2vQrUyJ5FcB0MPOiAGUgIbjUQhd9fo9DOhm+d6R/keV+rnIC0X9ECWMm2bdL4DpEx8AsP7AD4dlYWLps6DKwMspgZup5JpxEzW5tdxDEim8NawSqq5dxgD0Q5z9UeX/Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ecP07svu; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpVm+Frpijn4yPqburCrtJZe6RwJ97nOInvxHaDmoh5i0fsPQEn40wNk288FcJ+gONc8FBZ6qWL5/U03NiVknerKOFDE1xjkr93jHWhnmL5mEa634TnXfEi9HxKVu9gYJw7AM3QWV7NsrvX6IK2Gpa/yYSg+LVsuRNpbWROulXfhis3w0Bcpd0FUUj1Ku+Y2pY82dmOAd4RgEF9UecQ2S4hRo0Lfs+g8LQ8uXofk94ABV9E7RWvcybKYNYokKvTFSPgD+ZiYAGdpb3ImunTbKZ5veLoZ5oWTEuiRAFFha8g9z1PvcJ9uPqKJjkTA6sEnuzdObIwbG1HKDWGPTfN0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jahQWnMsNQmUfRNllHyqagdjeiBxaBYndqkYUHxtFwM=;
 b=hZUsPZeh/cMBU9pbaEM/abaJWoBtPwGE/AGMeE9w9rffLjy2uS2VGOv/12bhpnWUfXOGV8ye5pho3/0ZHq/NkaK6+aCKVKFS9m2FXESJ0pYHSrudmLRwB3mftx48HWHz6YRvFBD1w8luRSpyw1pBUt4HjxtCqMlM/47ghrqhbV3a5CsRaGwBliSYWbUfLfrhp9DXs1UfDUT/UFdw+5erJ7CODELQmQNhaOlk97K5URqH6xlyXcIByu8xL5dGW6nFLl6QihAn3+zjzhq3MoKK54YZSeWOVk8+pij10RVl6hf0Xgqakhtj1JdoVMQY8dFxIb08aABfdnV1IoYpBcJgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jahQWnMsNQmUfRNllHyqagdjeiBxaBYndqkYUHxtFwM=;
 b=ecP07svuxKZVleXHDx1EB75qsnyZMC+si0+xrkWg/Ypa7iNSquNlhpUaH6ZRdhY2VGmZg49e24SOjRvLj46Ck7iiNVJCdQouvn1KffZSAqWEMRtCD3U/XsNHp8b+8FcUgDpk64x3/kh9KkIjCYSicwjKok+nUuwYgBjjdNeJFWFkzRUg9PfdxdSpFa8d7XDQHLIEq00XJujWX9ZvYovgpSY2Wwa6Nk/LeJTN5ZEtp7pNDV61cFITbIM0aV4FZCr4JZsaap5by3y9WkAPBT94rL996AhPviU5Mj4A6cD8DsBlTRG885gtcomJsJtaDUiHh3mLFKiF08T1UySLYdg4WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 00:10:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 00:10:55 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v2 2/6] RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into ib_core_uverbs
Date: Fri, 22 May 2026 21:10:49 -0300
Message-ID: <2-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:52c::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 390ca7f6-38d7-46e3-b77f-08deb85fc17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fnqNwiATwYA9+7HNsRVv3xDtVOgtIy8cm93CJzd3eLuvZqtFG3K89VGR72A79ywo/ggPI2DeUyWJJF4mka6Eo8OAJBA2XeqHj6QavVIOE8pFZNRovKbQPcjK+GwQWWzhQXShUrhw7r4oA92+CrxEMSQlyVZY6dMK05I/75To8bcgCzj8IlCbNG01hHOsSNodgM7keEmwM0qG13Wn6tam+Li3m3svABILb7YhZjkMwGbRUnl3hvNG3ljeR7W/TYTN0xNDZ1C8pkmQSPZFBb3rsCmZ792vgaoz1ycvwXkyP9GSzqgK3fr/jhku+T1LRTswuxOxr551m34Fv0N1LcH7cGYbJNJ48Iqzp4BAu7NFlNg62DKIiCOsGF4xciNf6KEZmpYzLijyNkc3WDJ1lz3elTluHrNjEabAN6LnOLd4nkr7U1qZ40VrhpJ++Y9xsbkq9bwfiTCx4f4bXvA7bjpzdn6BiCwgr3um/xWjw0TN2W5E9p+dMj5xpZlBzMQzmmefl2Qzuk17Tcphmwd0tMUHSPSvecAc+6pKkhQCA0hQK3D5HCX15BRG0tkh7BCAk2DWF17RvWJ2xw/QAIfFiCh6v9n4r9gRN35F7RqakIEC7WEM7uhhun6zpnGzcez1DuWGpNfCHfOihv8ZYbzRq1JCH0yi3hWH0I95pXmq31/okarFnV4HyM8Y7LH5G3UToox0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBopt/eidL2N4aAxlYG9tlNwldIWp6Wf3WzIcvrhwbgX3WqaeaVYZebgMRbG?=
 =?us-ascii?Q?BL90nDbRndXBiC6Rna9tDT9acdgLOZngbNZILaa/Y2auclsYRgAcqz8uOwHy?=
 =?us-ascii?Q?XBlutZFhyS+EVWwiJ0rSVykEIEIjDKbDFqHUGYitVTfiVhlfS34KgJmALnV5?=
 =?us-ascii?Q?zw3+oxVzafAv2cWo357mg91obWE8kaxh6FRphWFi6TqB3+KqXFLhTMISp7c4?=
 =?us-ascii?Q?3NkayZD87uy+NiVU8lwbZJdkp4xVCHZuyjZFSzPFsmrOKbJELoMgRDDmntS7?=
 =?us-ascii?Q?LNI/sNEFKDvaqzQaoLRHo2w1n8UjuhEY0Uvv4lzFajgdybS5gx6Cyme2IlB6?=
 =?us-ascii?Q?RMMWtcIZ+szIcmIBilT6BUJPa6aHdIXS2XnvdyvSo2I5JXRJYW85JwtcPhgJ?=
 =?us-ascii?Q?K16vmGDk5a1VvknETg2dSFdW5/5ONBl6K+hBTTZ6pp9ktqt3Z9ncI5lTovx9?=
 =?us-ascii?Q?S6n3dsL8zQcQwHPMbTrkMa+VwzjkllRpnuKhJK8AhyDnGh6n7KmWYiNMT/AN?=
 =?us-ascii?Q?4HiU03WoFYDolJD7HsAsoVEEB/r3T2TaZlbP2pwxjjm4CzqqveQTd4cMv9Xm?=
 =?us-ascii?Q?CvWEGJd58NNKG+05oz5EC7i3oQcNkrQDagz/OptIfEsRj5kEYdYigOVuB9yC?=
 =?us-ascii?Q?vhbl9isPIlZDwuifQeaIfBTPimdwDjOwDoltQSKSV4LdrY2l/qcm9Tx4pBAO?=
 =?us-ascii?Q?xG74PSv6ZyeA3lvj1S4149GYrjQbfM1rIteZjCWUD3STRnTqEwcKRGV86mgA?=
 =?us-ascii?Q?GDqi7ZhxkkviiqFkdQiVbMmwa09rZNM9rojyXN/1xaQP1XG6778ciUZ4S4K7?=
 =?us-ascii?Q?dnojGlQLIGDO493EHbaf7NzwaBZwJGxHepyugmxF0aVTmR5Jh5b4a625xnpu?=
 =?us-ascii?Q?wXIyHD5j9PwAklegllw3z2NVbvY3Tm26VklfRSY2ruN3wdjW/sHHjNFLEQju?=
 =?us-ascii?Q?2gi7Q0G/jUfJgsI9iAQdzZ51nExrUaygWd3Ho6s8s4UCWhw3RBXYtki/WvsU?=
 =?us-ascii?Q?korjWTtqhgN9eWvej7ptdpQDFByFc9lq2BdIiBbbx0xYglk7b9OoaPy7vLJa?=
 =?us-ascii?Q?wpAJCl49MCf0OguK19cWaR9w34Ob/Yax4AQk1156CyPiuoDuyMdxyLRckya4?=
 =?us-ascii?Q?gruIBgYk9mY9roThO5GKZub+XWD4rGR2Ll6WmWMxFSNHVUSPnXqaYOW3IjVB?=
 =?us-ascii?Q?vh9mOEvUWALcyOvVM7pj9F7YHAyXKwkin75TOZAslntLSGFdzCMDfiIGLpbS?=
 =?us-ascii?Q?joNaOfUQWFKddWXxKOL2/2zDs3feh5ruNRoGoxC86Zw9dDdJE+ChOpVOodwG?=
 =?us-ascii?Q?hI+cww8cyde+P+li2RBeCFaeZoCI0/m03pk+A94UEwQlz8BCROnIGmlDtkPR?=
 =?us-ascii?Q?nYDANdYKfaqS1G3nRBFDvdVtUFxr0leOlGzMH7J8IbRtW2da865DVvrk5rbs?=
 =?us-ascii?Q?ADkb1NEOYZq2gD38dc8gQ0jOOb177V/Dus7JIEoGASmmaxeQKq6fIzR3xk68?=
 =?us-ascii?Q?rL8jgTrcJEUWhs1xzZyBZNG/HwuE7hvwhOIXXGQTUNSACMO0KUiB9Uc5mKCJ?=
 =?us-ascii?Q?UnkRqkQIe5Dr2L93Sh4Ttw3h6N8swR8GXeUiEcTNN1cP8hPyVUWk2kNpTNJj?=
 =?us-ascii?Q?G49shLkEggmRerbb2WjkpgMMzISDrt/qY6YvFDm9k8sa0Q7SHUN6Xwsp9YgY?=
 =?us-ascii?Q?XM3q3vrrdad7J9prEkMUEjv3u233wLXxKMRCZvlSwiaM37dQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390ca7f6-38d7-46e3-b77f-08deb85fc17d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:10:54.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EedB+HQebo0UEGzegBjMHR5gXeFsizUg78pisuY8QqYMfMyeZWv8r8TEtjMyiDf+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21182-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 45D235BBAFB
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


