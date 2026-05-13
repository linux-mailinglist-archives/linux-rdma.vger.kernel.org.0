Return-Path: <linux-rdma+bounces-20587-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF5NFSG4BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20587-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:42:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55971538352
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12A823016686
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED44DBD84;
	Wed, 13 May 2026 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mziPDayH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D764DC520
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693620; cv=fail; b=daxUiAulqNsLY6epFt7L+3MmSG2JGXI84OJKfGtfp9jNhBnzFYHyGCVNUA7iSe13k3FQjE0DGfn6EKQrjcwojo2qMvn41UUw5hqTB9p3gn1sBpTFuS0CXbMKk2CG7e4GcbTZQG9gwqY180rSP09iMSXgcdf45y2c9aMEiDwrE2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693620; c=relaxed/simple;
	bh=6BzaNzeccxMgtah5oZ8amoT105wys9lzhxg1zsmepEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b05u4TlY+l9mWiktsEP1mK46ksJLOY6Of1Y1is485o+zg0+hIIHm8HFPgCJu7cILPegAvijvOgf5w10agQMUdGPXLPKaroXqScF6bSEIxh2m89cxb8ukQ/w63JNE+GKkekBP6OhJU3vYJLTzxg0jaCP/iyS07/I+RfPpQS+Wv1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mziPDayH; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaZWyMRwF1/xDaFwTIp5yrPSuIkBKobMbglMslrZ8WY38h4ARO7r+GbrqI+GyYGZnH2fnjoL4nsoEGKRsXi17NXHIU4qUKPpnPSrD7eYO7HLCK+AKzsVh0i3w2Vq0Bk89EnTBnWn6RNTrhOaIccvuI4qCnXxGXJdM71RzEH65aUvd1hP03LN7mV3j/+GSlYt1QaU9+39vvOLmRUHnTSsziwhWVyDOLB8NdP3BndAA5egLXC3ehktrieGwIQdYk1pKn6Ve64PSeSj4c04bDY+bnC13jEYOjjwoii2ntZ+flpMXLNMvqb4wMi2anAFdluIv4RFYR9URcBKNxGXBtcgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMfjD4ZoSax0NBv0eun+HLV91U+Z9GNYW5pBRMVdLss=;
 b=AViqAQ9TKnGYVnSAcUEqK8j1W3gs+QreFta+Ih3wsby2astm+GtGM5Oj+36f8qFWY2AOW6Q7sFq8U4gDzNHbXpnH4T9qKv4GBRHTV2I6ui5w+QZAZoid0tv/KKyiFEMCpd+Qcxd0QwTJ2BfmlVUtiWsCpVi2e5cEdvJnbAlyv5hBJzNjvwcuQzY2lwuPlCnYGCjP6jSmWCWo0SIzhkdjylKfR+vvCPZVF5pXTygHs+w4Y43nc6HA/ci9qzn8hqXjxv13WMf7IocXBq6kABa35Yb1AAfs5+ar9AswQuxoafoNL7T2FEkCJYlj7VebrwpmwhPOnOSR45/YasPBtmpoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMfjD4ZoSax0NBv0eun+HLV91U+Z9GNYW5pBRMVdLss=;
 b=mziPDayHbk9skRy9Z8iNFh2QZctCCRRqmtc0IWe+bSrnLaV5/S7hq/waDAj/wT+wp+3l/3X3mgc2AV06S451TR8xKze8kyaiM1iqv/1E8WX28PM6wqREiaw+uGtXGY+P69lIGTJIJUe/LzJx3fsjhWPgGi8Z+yPcEa9wT1vwe24tL3FgUJiSPFXE8RMu2NFB1hzh5So5sdREjJfDRSi3j7jmuTV3V7VcrZ8tDfQJQRvx5fKo1tmd0OzFBMwrqJdeiD08HcdROd0wyrwDxBre2kDVqTz7mv9dEdcI1OFjfna97/B3jzA96W9HELx7C/RuHU3BLiVcbXZQGxuCKfqRZQ==
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
Subject: [PATCH 6/6] RDMA/core: Move flow related functions to ib_uverbs_support.ko
Date: Wed, 13 May 2026 14:33:28 -0300
Message-ID: <6-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de79288-527f-4dc6-1c17-08deb115bf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jGdAPoCiAxPQooTDuU1gk8AbRSEUSHSH5G0ZoLYNYfeTMh1/jO3R3Q9FXCv+bqy1hnK6ZXV/5xWwPIEuskVRWVDe/osVKVs/MQEcYFB2/gAZklvViYrMJiqUcV1QMNllgPSDw1qyU/D88TQK2txUoiYnBfmVLlf774Y63uVvqrKrMnJ17XNDCbgQvnSijpGlUtO7wVlxKI819Pcg00hvlom7r6Jk7hQwRIs2PABQoAZgp5oKSW4d0HZwumdYxLctHPbmytObTnHa3NgU+QJZQBUEamFUoSamI4QvSAvSQAapkgmxgxNVHyq7Tir+moshSiI9p+ShukpdRWB5/xALXiJY4EVcdlqQTr3+gIuKDaMJbWHB9eDt33odmgLoUKqflvLovVwV0mFg88VqpA5Z3LN8/CFAOK4891Rmzi7HglqxKKEeMOGHGqGVOEii72sXNH0cIkWjx6H8P3ibGMh4zAClfn0EoB5Ni9L1lJaeavJ+3wJCvvxaE+DQu35jjOdOXuvyUN7oqvWTdk0NrJlf4vsGc1+j9uTwFc6KVGoCTY078RNCqvSuzokqgMsZNxoo1fJ6hzTWHoLCfjaEl80yXdLZBZQ4OSrJnoBduwZoLEpyrKClq9bsfPRj4LlC7pBQHjl00aZIckUC0js87UhMvDglsjeGD5vEOzJIWamhfuRkk2qpvtZE3bp/WaEZ9GjN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mt8tQVNGw16YHjl5zt7cwfmCyfezkWk18+Bi7/kyC2pRDUSa6mmHXFrRHgPz?=
 =?us-ascii?Q?V4wYY+vrWTdS6Bz14//raKSa9wSMnovwXmbmA2794xxUv8axjlBX7oLPGJZZ?=
 =?us-ascii?Q?Lh6JKCjcI2J+EtwOUuhcK0lqaTj05yGARPBnPKrRBWuzoxWp43f8IkJPHaa2?=
 =?us-ascii?Q?7cTiOUWZHhMZr0XZAw2Ntyb6oIZjOPdmGOPtF7/PWvWafI0DzfhvlGd8WcWL?=
 =?us-ascii?Q?ILiJNCoMmKq/tQdmSIjj9Scdppi+LkMyiWHd+DsW1CD17KcPbpYsC7XEaSwv?=
 =?us-ascii?Q?6gQqZuARAfIYzrtWUF1Lm9KzUmYkxCi/Hzt422uRfDq6uzyY9Qx+oNmE5VJG?=
 =?us-ascii?Q?z+TWWO7mJxAQhXL3giR/l8jH8rhur80sR4kUa7yGSFJB4l98IcXYXK85ooEf?=
 =?us-ascii?Q?eVjxgultVTru9xxdeUiGus2j2DKzsHnJ/J+Yv7+SG6nBP3fbRSnzXlaMfWfi?=
 =?us-ascii?Q?Orixrn9irWqGbICpG2+ccTXzg8nya1VZcQXziv1omY3ftkmAqA6K4gYfWCtJ?=
 =?us-ascii?Q?fyl85uiDeEgEtYfNq4Py2QwXx11qSQyRvnY21K/N9fQbA5BHTrIHjnavl1Xl?=
 =?us-ascii?Q?LZtIANIRAZy9Z1uljA4eeDLdb5NZoLhUghB0Gcsb0mvpFn1XulZGkjahp3u3?=
 =?us-ascii?Q?YRq/r5R1F30J9Vo6rQ/ZQisx8Vq2TfaLI6ICjxf/YJfLYgNTB7cgkkneIyNL?=
 =?us-ascii?Q?mYPFf2ah+kvYWTO7F2HizufbJkm4XUsbCTDoCJuDyKMCLeAgSli9ibqKWj2Y?=
 =?us-ascii?Q?VaYdNQF2AmO0GXu+Mpnoo7ZO9zV2rgVqgCj9alAAovJYPqLKwcr3nZafxC95?=
 =?us-ascii?Q?nPl6Te212PMjQEyIE4tcZ3cGnuxqwXIIxTyEJtCxDI+twK7NBXwbrXpxMDRD?=
 =?us-ascii?Q?ZLFYVBkTlaBJN//vK6wlyEBl8R5LGu26uyBj3gH959Dq6hUz/Z9ZG/ti9s+o?=
 =?us-ascii?Q?SFF4xWFGs8TscBEUGaNFlmn49nz20q/ZQohdHYhvyR9VE06XnZG1rw4B+zWf?=
 =?us-ascii?Q?8AOmOL+9XDdxzM9vpLs0M8E36ROkyQ2Vh7gJNrRxfXy9L6YanluxdZvxN6wf?=
 =?us-ascii?Q?iCx/z4jAustGkjSGiAJBP+wfk12R+y+fgEvohiVfmmHYQsyX018vWA3yVwa+?=
 =?us-ascii?Q?+NlxhUIvw/LuyP/4uuKTDspBAxSQVo1zf2HtLyL4rXMJ9i3TB7X0yp8/24BA?=
 =?us-ascii?Q?FNqj0RmIbwM1CUdwI9MUg6UvOlJavqxuWbcXPoiv40lNNkRav1KUYj9sBCDs?=
 =?us-ascii?Q?3OGS92egse7Gmy3Fc7yhgh7UzMb/HemzMjKyvTQUDAwzOMWAhZpCrl968LhH?=
 =?us-ascii?Q?YG6u7ZO7uOZ39mz2tDfdFPbRvnzJq37JA9vXbGvOstmmbVk5gZYEmrOmPMKq?=
 =?us-ascii?Q?XFHbGaoIazpBJ8vNcXoLKRn1nj2CpEByQrTpeTzfeFT07JV26TBqcLrz+KEO?=
 =?us-ascii?Q?FTMljQ/WAevpvmvvb8V/Xucy6/EMqEEPODUm2tn/M+YM0r8a7CQhP17yEll4?=
 =?us-ascii?Q?ZPA1Gl0M++fvpjR1BjPVzNQKE/JAmtAsUoa1Av+is4ZROZdZ0t6AbYxkmW9i?=
 =?us-ascii?Q?jbRDPfIjzA9L76+BQ7eDNz1YaLX7UQCjBxQnsHdxKPLPv9PpTptT2kAQa65s?=
 =?us-ascii?Q?Dg/kFLwebwHcVmuDiVfra7imksqEaLPih/AffhO3WdUzz2fKljgPMf7ER3+/?=
 =?us-ascii?Q?/SahVxfEkzqtglaa05V2zC3caOxOnHZDQliVfTe0yG4oreci?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de79288-527f-4dc6-1c17-08deb115bf6f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:30.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEoOtu6B/Zr061OegyoVyR2zJFoZwi0E4auOI/7nWgSt/y+hrGXtN5fo/+aw3Bxr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Rspamd-Queue-Id: 55971538352
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
	TAGGED_FROM(0.00)[bounces-20587-lists,linux-rdma=lfdr.de];
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

mlx5 uses these as part of the driver implementation, move them to the
support module instead.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      |  3 +-
 drivers/infiniband/core/uverbs_cmd.c  | 76 --------------------------
 drivers/infiniband/core/uverbs_flow.c | 78 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 77 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_flow.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 697468cf88b16f..69f72b63e961ab 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -48,4 +48,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_qp.o
 
 ib_uverbs_support-y :=		rdma_core.o \
-				ucaps.o
+				ucaps.o \
+				uverbs_flow.o
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a768436ba46805..fce6eb18287a19 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2589,82 +2589,6 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 	return ret;
 }
 
-struct ib_uflow_resources *flow_resources_alloc(size_t num_specs)
-{
-	struct ib_uflow_resources *resources;
-
-	resources = kzalloc_obj(*resources);
-
-	if (!resources)
-		return NULL;
-
-	if (!num_specs)
-		goto out;
-
-	resources->counters =
-		kzalloc_objs(*resources->counters, num_specs);
-	resources->collection =
-		kzalloc_objs(*resources->collection, num_specs);
-
-	if (!resources->counters || !resources->collection)
-		goto err;
-
-out:
-	resources->max = num_specs;
-	return resources;
-
-err:
-	kfree(resources->counters);
-	kfree(resources);
-
-	return NULL;
-}
-EXPORT_SYMBOL(flow_resources_alloc);
-
-void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res)
-{
-	unsigned int i;
-
-	if (!uflow_res)
-		return;
-
-	for (i = 0; i < uflow_res->collection_num; i++)
-		atomic_dec(&uflow_res->collection[i]->usecnt);
-
-	for (i = 0; i < uflow_res->counters_num; i++)
-		atomic_dec(&uflow_res->counters[i]->usecnt);
-
-	kfree(uflow_res->collection);
-	kfree(uflow_res->counters);
-	kfree(uflow_res);
-}
-EXPORT_SYMBOL(ib_uverbs_flow_resources_free);
-
-void flow_resources_add(struct ib_uflow_resources *uflow_res,
-			enum ib_flow_spec_type type,
-			void *ibobj)
-{
-	WARN_ON(uflow_res->num >= uflow_res->max);
-
-	switch (type) {
-	case IB_FLOW_SPEC_ACTION_HANDLE:
-		atomic_inc(&((struct ib_flow_action *)ibobj)->usecnt);
-		uflow_res->collection[uflow_res->collection_num++] =
-			(struct ib_flow_action *)ibobj;
-		break;
-	case IB_FLOW_SPEC_ACTION_COUNT:
-		atomic_inc(&((struct ib_counters *)ibobj)->usecnt);
-		uflow_res->counters[uflow_res->counters_num++] =
-			(struct ib_counters *)ibobj;
-		break;
-	default:
-		WARN_ON(1);
-	}
-
-	uflow_res->num++;
-}
-EXPORT_SYMBOL(flow_resources_add);
-
 static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 				       struct ib_uverbs_flow_spec *kern_spec,
 				       union ib_flow_spec *ib_spec,
diff --git a/drivers/infiniband/core/uverbs_flow.c b/drivers/infiniband/core/uverbs_flow.c
new file mode 100644
index 00000000000000..1528a294f7f85f
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_flow.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+#include "uverbs.h"
+
+struct ib_uflow_resources *flow_resources_alloc(size_t num_specs)
+{
+	struct ib_uflow_resources *resources;
+
+	resources = kzalloc_obj(*resources);
+
+	if (!resources)
+		return NULL;
+
+	if (!num_specs)
+		goto out;
+
+	resources->counters =
+		kzalloc_objs(*resources->counters, num_specs);
+	resources->collection =
+		kzalloc_objs(*resources->collection, num_specs);
+
+	if (!resources->counters || !resources->collection)
+		goto err;
+
+out:
+	resources->max = num_specs;
+	return resources;
+
+err:
+	kfree(resources->counters);
+	kfree(resources);
+
+	return NULL;
+}
+EXPORT_SYMBOL(flow_resources_alloc);
+
+void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res)
+{
+	unsigned int i;
+
+	if (!uflow_res)
+		return;
+
+	for (i = 0; i < uflow_res->collection_num; i++)
+		atomic_dec(&uflow_res->collection[i]->usecnt);
+
+	for (i = 0; i < uflow_res->counters_num; i++)
+		atomic_dec(&uflow_res->counters[i]->usecnt);
+
+	kfree(uflow_res->collection);
+	kfree(uflow_res->counters);
+	kfree(uflow_res);
+}
+EXPORT_SYMBOL(ib_uverbs_flow_resources_free);
+
+void flow_resources_add(struct ib_uflow_resources *uflow_res,
+			enum ib_flow_spec_type type,
+			void *ibobj)
+{
+	WARN_ON(uflow_res->num >= uflow_res->max);
+
+	switch (type) {
+	case IB_FLOW_SPEC_ACTION_HANDLE:
+		atomic_inc(&((struct ib_flow_action *)ibobj)->usecnt);
+		uflow_res->collection[uflow_res->collection_num++] =
+			(struct ib_flow_action *)ibobj;
+		break;
+	case IB_FLOW_SPEC_ACTION_COUNT:
+		atomic_inc(&((struct ib_counters *)ibobj)->usecnt);
+		uflow_res->counters[uflow_res->counters_num++] =
+			(struct ib_counters *)ibobj;
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	uflow_res->num++;
+}
+EXPORT_SYMBOL(flow_resources_add);
-- 
2.43.0


