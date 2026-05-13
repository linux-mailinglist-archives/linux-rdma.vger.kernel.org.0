Return-Path: <linux-rdma+bounces-20588-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP3kDjC4BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20588-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:43:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508A538360
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3F67301FDF1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07D4DBD66;
	Wed, 13 May 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KtBYX4Ep"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492A4DC52E
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693621; cv=fail; b=cxzAc38ZlvrLG4HttRjlwR1Q8zvvZ1pA45TxgTefaPwzfTOZkFVs/WS2y9CUqQXf3AK6p/OJyFjWqqgwUmALZAdPJGKnTrJCa7KecgTMyAKtvU3IjuOG0extFo18TamRORIff713M+cAjq31LacxTzB0Snw5KUSGkpzSVfG0YkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693621; c=relaxed/simple;
	bh=h1kyK9Df+ZaGozH6ahdJ86dN05xbxusu/xptzHL3zKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b4y9TQMu4kpkRDOi0PenpYvDjsjtSYID8UkBa1PJ09OyXpiumpHaH8SdY39FR8VPIKql20EZoU1nKxGCz2nmfk+upjaaUOeyZb3SnyCtf//jEXdX1+mlyMrIYL4HFtlqCTljdugK1ubc4OBVm6Qk03HiWI2f7CTdfpMn9mPNz7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KtBYX4Ep; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6q7wYRg0B1RmcTq/zGvf/5HU6CALptEP0azNgkzauPebzQXfWxLqOuW1ceLm4DXWb+eLwQD/OT8qO6O4/GhHKGmaR238XLsgD4i8/T/LFIcOvzT7LQItfzJeu9TLO23HHWdpuoWjco22M03clMa0H+I+71SfvdQLyf6vdLykDXprZDWhdTzV0qf2btaAKaPUEUxH0OZPmQ4hE+yUhFgSmQSK1LzAaOPJ/ZB3cz/QbKcb/k0PyqVjeb+Vt8DFA0n/JN9b18GvsnZdxHNjs2SbS5Qoei0iWR3hYa0VQFy+mcO9TMxKQuFxV/I91UyT0OwxZi/KH6uRj+kg6GOoo/pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeGHNn16ZGP4CwnrdR/94+TZslxQfXCEAYfDOFiCMC0=;
 b=RRNjAwOKhuq33W3VyN0BldO181rLpC0xQdOz3kh+M50zziZvKLfR1tw+lVZlKLygKzns+XnOywimR3fZwxpJkJBCKT/Fnthz+DD0GZMcpetdaGUs4KkKrA0WCszv6w/SgIjotrfsyiLpGTRtBbmg8iHWzlXK1ZKpg37+LBUY8kjQEp5zwlcDR2g8MKwnmVBLN9TS2W1FdWZWJC6D02e4L8pxbl8IbG3OjafDwjYelT40aY9M3H5r8boGJW2Rt9GPueQEJEaZGzTVO7cDNao+pkLnBUR0tOxFPFA82WTY8MiaRD7VdafTspgNd3CasWIxistBs2NTvfwGixdvPTEf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeGHNn16ZGP4CwnrdR/94+TZslxQfXCEAYfDOFiCMC0=;
 b=KtBYX4EpGmEXjp1g3ICKucHxzla7uYNstLekTrnTrq8HZuE7fSX2RCT6SyPFddd8goY33n35pG/SmcXWKCYizMyeCSpjZzp+GL60cTESLayXm6iFrbqFvUi34iie9gU481IV6DcLH0fOPuFSjoWSZmYnVUhdEYKciszQzNLhL5onpGgJlWU3aLB3p3a3D2iMNF5n8YIr39KiC9L2A7wZ7hNKEUU3j2GjWtxgiSlORVMpe4d2nd98MEHt1kf03jmq8r7JdtGI2SqQVXS8l3ZQfMFD3vj6cC4pUBF6j101ndKI2pjnrPmsg3VILbnoJts5IvBQM5uKNCU2Ou+Ue1enTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:33:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:33:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 5/6] RDMA/core: Move ucaps into ib_uverbs_support.ko
Date: Wed, 13 May 2026 14:33:27 -0300
Message-ID: <5-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aca63ac-178f-4ca4-7cf1-08deb115c032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4wp4ybcrrkBewmwAH41hcmeqk9Mxqm08qLNn1DNDSKeMJuEJGDVGcRlFe5YJ+pwX09shaWTYycZHcUhQZZHT5PpazMaU3EEHYCuwrn4JmZJwWFaKBxgYOEKSGN1pFMgvsBj0RV0cdaj1skof8gxZ2SdWy7qRybKRYdbDmYTBco5ziCs9dkNuuUO28OlxQ2Y7/gGK5ntVwoP4lW43wyeL1LNV2Ye1gc/XDY2eq0FyQI4mgDUlWae+lU93HCUKHKPF1pX3f92xmhEb8Zroc06+Apjp/eZZynuPrZ9VB8JujNiBRSAvIHFAGe9UhLdcsZrYoDK71R0A9vZvV9jwd8DIB7G04vYNuZOZeuixI7Jb28ofxDg2/89ydBB2tpPphkMmypSmCQNalwIcFK+awn56qLJxXJPe+JPcRSnjFF38xcgCdkvm4hE9lj6c544G8Bejj7Xk5m/KtxPw+GuWVT/S1vXIxTea8zPsIiGlMdNyHW0IxF6vV8bLbGiAxMz5Lv/rPlrkmdLnC833iN6sh48217BpoYm0BQnXULR5G/Styt6KAorUOu8dUDl9jFXqW18+IUesV35GOm6mKt8dQQZdp+/2io3QiPxb1YB9nUawjHMcgDNQE8c8wqRk8s2YQgB6upV2YXYB6OpMxXTfRAHeII41qIRovW05GhH01xfDIJt2/j7cMmKDRueqySWpoBPU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/2QLBSNoyA9xiOXU8r67qnAQyPvNKmWSDi6njbtJfqeccA0fsdyGabCqVJb2?=
 =?us-ascii?Q?zh4c4nY1vNrQIQoTxo/txzFG8nXrdWXxN7dlRxQiTqahW5enReyeHKDvtfMH?=
 =?us-ascii?Q?9QZ2iTX5+fAP5grRiTd9aQHpZYk7IDTZD9xhtMchVnQeQJFuhSNl59nlEGwG?=
 =?us-ascii?Q?o78yQpTbW2MACgULwLuAOdyPFk3+hC+BzJEtYybBtFoBl5DutQZHz5TBeuMU?=
 =?us-ascii?Q?Wc1OA9JpLye4XkxTRMCeqsUc7GkP2gG6rNLHe7Jq8+TW3vy6ghjqj5PiQTtd?=
 =?us-ascii?Q?ALU2W0tjcUa2CuxtnoSR/xo1CAwjx5Ydk9TzmVmzKbsCEDLESb7kg4pMoqa6?=
 =?us-ascii?Q?wUucIV8ifq36Ek9U83k/NwV3ph6Cr94O8osY1Aaid4nUEbPJIjIhx9JbaHPb?=
 =?us-ascii?Q?ekowMYFoTbqjbOYwMbLhjKyytiQqa8Ycv5lz7Qq1R/dJgEuxFLme2OzY4bJK?=
 =?us-ascii?Q?6wn7AHXC4mNE7wUR09oh2+mVtmQtR+cfdXQTck3q7Tmw01b6jTLhDdvh4Be/?=
 =?us-ascii?Q?om4lAkWvV0VkC3u/FK201wor7iGcbS7PncgYqBGGmdHSeMVXzq+SH+4+YZHb?=
 =?us-ascii?Q?5oXuqsbKJPJsqbfAMOC5fYRaX13sa2chbAcASS0+vv34C5L0/25epiP9AQ0B?=
 =?us-ascii?Q?DOctGzDbF2xupEXY8UzNhyz/RI02EePRaAZxFPZ7RikTf1lhj1ULyaS9mu5a?=
 =?us-ascii?Q?VZ7A3MAWQ7ZlKve35zCcmjepJTneW8TomBHzGzT8YIprB8lLDa2Ghq8jaela?=
 =?us-ascii?Q?aVDiNWBLIlLnFsdkxCbmQlthiLPHg622t1gSc+zUnqi3ei1jAKeNr9iillGu?=
 =?us-ascii?Q?roSiUySQDjgH0TILHJb87MBf+qSL9EGHjzfAB+kpKHy7ywnrSzTfcLa0dzqs?=
 =?us-ascii?Q?gDlQ8gJvNEOlH9TZBZLS2jmghdJc7iD2XXAp3nj4JVjRohuyHHcx/YJxEtin?=
 =?us-ascii?Q?6O+iWD9GFmWHzNMJJPtx9rt9vyypPyE+pSrgkZlGpdZbL2Z0gYI/54inw+mC?=
 =?us-ascii?Q?17Hdv6KTOjfAaXNK4+wGg2wuabDATX7vq0oMcsr0urvoPo+oyURQxO3GqHDd?=
 =?us-ascii?Q?A0AyEK2ySskFecRpPasTga9JY3lHiaE3IFGDw7TOJQhamTuNVyHoxqYB5+5u?=
 =?us-ascii?Q?yj622xdtDxaH1mBemV3WG2CHtX219tG0yJicqQ30fEMryB/b+Q2ewXmuCbm6?=
 =?us-ascii?Q?WuTk67zB8naoOSRbsW29x6eaypagnuY8rwvMxJpbqNgDM5WGYUDluYV5kWvM?=
 =?us-ascii?Q?2MfrvK9/esRc0orzbVOW/z8XJzySANLCFD3OMJQLCMdXCRCidvPeDYhtSPun?=
 =?us-ascii?Q?SDSvmaUeWd/UY6MBrpEHIUFelK6iaP+Lf+k1z6732veIxM4teucfuHqtqAO3?=
 =?us-ascii?Q?Y5UnW7P03Zk9fS9YhxwwSqDREXy8w4qDr9Sj13caVjZlmIbhq+8yarQiDaVt?=
 =?us-ascii?Q?DYmwMLXaWPf0ueLxJpmQL4r6+ISkK1hVKMfpF9gYausO+g1DSXD3aYtqTreu?=
 =?us-ascii?Q?IC1ks9qIQr6pHynbN6QNELyEEUHPZMAGJeFNHeAX9pkezrEp+Ud/tW2wyjsT?=
 =?us-ascii?Q?MdV2wQk7aoEW7G3J9u+gyPX3JoOup2qE40xNUH6npDiS4rCqQ6vxR2zFufOb?=
 =?us-ascii?Q?psRmDEXX/Iwxk10UdNFryCngavwT0MICrpP/LW8GInOileOHPXQ4ehNM7l2/?=
 =?us-ascii?Q?f7zLYeEI0GZjhlOqmrcCRQM91iBXciC/i46kVnqFFUow2mx8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aca63ac-178f-4ca4-7cf1-08deb115c032
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:31.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7ZqrkZ4iewe4Wlzis64F8rln1rIioU7ESBvb7N8FOG1zTiCy8fbHCKjLutqzZGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Rspamd-Queue-Id: 3508A538360
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20588-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

mlx5 uses these move them into the support module from ib_uverbs.ko.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      | 6 +++---
 drivers/infiniband/core/ucaps.c       | 6 +++++-
 drivers/infiniband/core/uverbs_main.c | 1 -
 include/rdma/ib_ucaps.h               | 1 -
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 6bdb220f89c0b1..697468cf88b16f 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -45,7 +45,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_async_fd.o \
 				uverbs_std_types_srq.o \
 				uverbs_std_types_wq.o \
-				uverbs_std_types_qp.o \
-				ucaps.o
+				uverbs_std_types_qp.o
 
-ib_uverbs_support-y :=		rdma_core.o
+ib_uverbs_support-y :=		rdma_core.o \
+				ucaps.o
diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
index 948093260dbda1..ce1750a0f90a45 100644
--- a/drivers/infiniband/core/ucaps.c
+++ b/drivers/infiniband/core/ucaps.c
@@ -51,7 +51,7 @@ static const struct file_operations ucaps_cdev_fops = {
  *
  * This is called once, when removing the ib_uverbs module.
  */
-void ib_cleanup_ucaps(void)
+static int ib_cleanup_ucaps(void)
 {
 	mutex_lock(&ucaps_mutex);
 	if (!ucaps_class_is_registered) {
@@ -66,6 +66,7 @@ void ib_cleanup_ucaps(void)
 	ucaps_class_is_registered = false;
 	unregister_chrdev_region(ucaps_base_dev, RDMA_UCAP_MAX);
 	mutex_unlock(&ucaps_mutex);
+	return 0;
 }
 
 static int get_ucap_from_devt(dev_t devt, u64 *idx_mask)
@@ -265,3 +266,6 @@ int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
 	mutex_unlock(&ucaps_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(ib_get_ucaps, "rdma_core");
+
+module_init(ib_cleanup_ucaps);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index ab6f1e3cb47a18..3ccf58e96aedeb 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1350,7 +1350,6 @@ static void __exit ib_uverbs_cleanup(void)
 				 IB_UVERBS_NUM_FIXED_MINOR);
 	unregister_chrdev_region(dynamic_uverbs_dev,
 				 IB_UVERBS_NUM_DYNAMIC_MINOR);
-	ib_cleanup_ucaps();
 	mmu_notifier_synchronize();
 }
 
diff --git a/include/rdma/ib_ucaps.h b/include/rdma/ib_ucaps.h
index d9f96be3a553f8..b629c99117d8fe 100644
--- a/include/rdma/ib_ucaps.h
+++ b/include/rdma/ib_ucaps.h
@@ -14,7 +14,6 @@ enum rdma_user_cap {
 	RDMA_UCAP_MAX
 };
 
-void ib_cleanup_ucaps(void);
 int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask);
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int ib_create_ucap(enum rdma_user_cap type);
-- 
2.43.0


