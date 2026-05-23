Return-Path: <linux-rdma+bounces-21184-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEPEJKHwEGo+fwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21184-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E15BBB09
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6FD9300C302
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455935893;
	Sat, 23 May 2026 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YnwNqal2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A01096F
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495070; cv=fail; b=riZfG1gleCglRzK0tHH+cw8dbANYQ0BJhlRRkpl9EOgb5HBke9Wzm2cSBhYnh45n+r/JfZr6acXQ7ShAR+vfKK1W/EMCpLaZl5B+xwyCRyHxsDnkhoraLX9YBw+YXkuddlsW22jdJoRmnUHRsfzUlZ4lh9XSLsz5cwYxBXPc3v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495070; c=relaxed/simple;
	bh=BGAd26NsUzOic+y0ZfZfkPCkF6zFz+fcMsn5QLDbOWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEfYjm6NloomDySkf9qtCeevVl4SDxGMEkbx+rYcWpndNx/myRNnh+72F/bfXxLep8yfViYBM9QgUFUzmylis96uSCHpwEOGhNmot/P7VchXGFUdnwf1fNJjN7lih/hm5Jwe7WdmAiWBuSHGUWAPXf0Wf4SEhaTGJtKoaArGJ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YnwNqal2; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ss49toaDFQpHaASHX6OIVksbOdOT/cl9zVPE0nZz7Ff3EkPVOzb3gNJXONHdJ5z2IXxwOM4j9cSL5h8+EK+r8Asjhl6umfpeF2hkE2SS/GOYt3bHphom8f2gty16nUlQykBlTP4RyE2MRdij62NZu/+tNvpltJfHTpGEDYirh3A+qYegBsv//Ay46WOXBPJr4nlGHvGQ9P3HMbGQLIwUS6ieb1LjOHJ8IMT8JMlOr0/ZyFdFa/KyF9XaN0SnEd6eCSH+KNGUFMnv9kNH27ER9LKkkne8MMZh4I5sV7+49l7NUjCZVTcnyDCwYAC2nasvu7ecnQPkpQeptoxTjiRu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5vEuT5Nu2KzqXgx49FdnpMKocAzl3uMk9dhbZHcC/0=;
 b=LQ27bbfExRPm1ZBFjLNbbASWyZXpKV4zfnWfYfgSl7E4YyC2INa9DrmB0wnlNOpJzHcRSjXuLsf9l6So5CPPzP7B9xGFY80Bgg7K5BliqLkEsw1kcbZEIyqvsDwy3C8EmZshAxwIrflIfbUfNNl/cHat8cBsdNfg23e7VVQAvbyxKueOOoLIXwETwTa4w0144PRxT31snYtl9FKJBKGXpf1yc/kNaT+Dz4ZE3Ml3aB93+vFBBMmdmWUvvfhxIVvePr+IKcq8nieBvTchGgqnbiQ0dmfPFM4zy70tn7/1M2/PH+y48C8P54dymzCn/wXEQQNLrlvwuDIXaV1zIh9J4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5vEuT5Nu2KzqXgx49FdnpMKocAzl3uMk9dhbZHcC/0=;
 b=YnwNqal2mptkQQ6QneOY885GvE5XrDVZ2iGP7g2ee3SEpsqom1nG8RVYQQD6U1b/eEV1o2ZEOWbF6WvnY6LAwX3x2jjcgnD8RS3VdyjB4FNjOTlqKwFGJbMUguttlDLib7UQQXdv+XpltAV/MNvF9favo2rKwpQEuqEWHbojFEQWcP0GiLSmSujHHmQSbT6j9Hik027HQCJXtSRPeBp6AgA33vmNAAHBV8gwuWUJE9XhxDX8UFg5pR+2ISB1eKOkOa3T1iuodnr/TinwzbM3Uh9pdISLCTAiIoEkX8fXz1TnuSAwIYwqDZ3EHfpRa9OCYJlKD9HH+FieDgs2Q9mDoQ==
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
Subject: [PATCH v2 4/6] RDMA/core: Make a new module for the uverbs components needed by drivers
Date: Fri, 22 May 2026 21:10:51 -0300
Message-ID: <4-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0292.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a259be-6453-4328-98dd-08deb85fc265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|5023799004|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hyZXQ3JQRkxPNVjxm3+ARrRf51t26uKkhhh/6lS/r2fHvnHBGvzHPVS5UFovxci5WQ2ZeXmhZ5p3vU+dhxC2k6uBknkCq/XSmK4hICO0e1TrOhigOBgdzjlXmMprfzwpR17OxCCxdpYFbwRwcMTZ2CWs3aIfya+RxhOzX+jnYpTbSxPBR0E6uQCj7L/zgVwUTPxkbCjufIM60nrJtt4GLJ7Nhd9uxJKdnXpVGTICn7pZzxtJixT+rpHpuBKwToQKlvjUI2gsUuc6CnQEEAj02BpBDji0CRRqLZ5Ph/2JMV7ZsNqj+eYvyFSSTukTRkR5qwNFmEIHq/5o08FTm/FYH8a1AdUcA4BrJBL2t4LOpXP81LlqvJ/9fTvROd6WhrlDOXe4Ym0eNjC9283936TZPbiI0ZFKVeRDda8eF57qsnveU1OQyhhAJMxrTcVTOLasa38ZhbiyW2mRYcmpKsDgRIv+yoq5hP8UwNzMQrjiDhq0Ztx3cA7RCAWv1/tmp98KEzB91N//T9fA55kLCz/m1/UKIKO2cAsLq9YoT0bV8JKr5ryDKQcMAPLnHogZhsQ5pMm9yzC1EegLxahA0NTLxhiR1r1CwhTtt16RJ4NGqhCSuUW6gQ8N7a18aE5qgTlesImrTv2Kd5gZfx+hUEg7fsISdy6/2K9e4HZPQcX8w4AToRVagiBcgNfMsuEv5M2D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqn/PW/m84wmtBM7UHwGTSG7yEfqpHxvU9t6Y6Vw8lCPGU5WCC8zeqWH0q7Q?=
 =?us-ascii?Q?Lcc/59Ya3GHpf2dzH1Wg+Wj4woZmdzajm5VoPWyNVXKmsEsBlJrYekBNk/yb?=
 =?us-ascii?Q?vPwIodvkfjkhImJNfs8thMUGPWSpeMHxoW6+GiY7oq6pCvfUIwFzq6fWEyAl?=
 =?us-ascii?Q?7jYym5tFP+IEGIAStnvoVNZkE5uaaFiP2jX2POM8qdiB6q05FiTrnKa0vUiT?=
 =?us-ascii?Q?lelnMlv6d8HK7puo/UQe6ilWYzwisBqTvn2XnGPDJ4+cMMjiB7+WCfchsdJZ?=
 =?us-ascii?Q?wLjuSAuCa1b99Auw414VXmNNrb50/Odxf32UPqUyu4LW/08Q05+Bq5l4xm61?=
 =?us-ascii?Q?nz1JQaiakrkYkxb03Ix1BIcIaHRYbpgNYhVInYXaw3N0M/V1d4DRdE0aRLEh?=
 =?us-ascii?Q?8IQRfgjRDQoYlpTT26lrC5r9NZIQrfi3wjzR+0lnJuQG6P9PJWH3KoHVPBOq?=
 =?us-ascii?Q?Ah2H1AyMAFV0Iv0ifVraVVbgCqYrDRin86PENeu39/yfJljPfKYel0x+Fj/f?=
 =?us-ascii?Q?XCccgpsbvRtKQm466KN0cFYydB/apRXysyfX+n2gGldGAFSJec+a0FqU+8Dv?=
 =?us-ascii?Q?iFxKh8D5QgG3/Z6agtnbqIK4h8d1TvjVYZEqmyBVFiqqfpYbLtiaNGP1Q3JU?=
 =?us-ascii?Q?OcBiIbZB22jN7gYpWvUo2G2KNASXt4Ou3oiBW4ZMtPUV4pYRzLU/tlJecgdX?=
 =?us-ascii?Q?5ACWwBfXP1jXEuzUQOxOh2S+arfFcLHYzKT92zQVtPrMInyF/JWP5qjWJImV?=
 =?us-ascii?Q?L8RVzYfSmJVLDRtRfjw8WqTZKW9EIhWmqh7315KY7TF5Uqrrx0naD71ARnoE?=
 =?us-ascii?Q?IeO5CqdSL9K9X8sd/BagM8hoDKc13xgClSFYJmknGpbP3XC1EF15sZHvJ2MR?=
 =?us-ascii?Q?WyoboQawpOwyGGzWXnqS71suw3+svGgYqCsVEHjgVXnSZmurLWO7YypOilRe?=
 =?us-ascii?Q?tPFX4A05iHlAx6R4VvChY78G416tM7lit7t2j3BbkSiFSJgve3O3/uTiQ0Cg?=
 =?us-ascii?Q?HnKUS6fbvCjzFE0ZJ/Ne2IOOIN25sjasoMUnqv3AfwWxTYz13o6d6kjLyRtE?=
 =?us-ascii?Q?eSOjzPiwXUlzJz86Txp1CHETDEeLNhsBtXKehr9kFNJ++titDNlTbaPXB/tI?=
 =?us-ascii?Q?f998dl2eudU/g3lPIAUZvlqgmWyZnBRYJlxgY89VrI8mU2ij+AmXA+KowAix?=
 =?us-ascii?Q?sQ0BvSOAfSWxg1c4vEVfxrSII8N9J5U6hzg3/WPm6G0xF74WJcmBI7hxwIeT?=
 =?us-ascii?Q?F7QFyvjyxhQRkyXDSIfrHBX7XZdbc+NTjSjrjjnLtOs49F3nm7G/yQ7FM1zq?=
 =?us-ascii?Q?g0SftV8cMLPbx5vqIgIpr8wA6K7asXApf2/yLllA2+OeV6wt8dg65MkgZeYU?=
 =?us-ascii?Q?1P4HetsfE3iRxAoB8FhRJtL7zBXtlTJpgnkvcULUuJg8Msno6KnAWWd2ZtvB?=
 =?us-ascii?Q?I40ypZ0zHKQcxNrV+E0Xdjty0V/FniX8S7Ld5mwPvZkgfdiXPFg8nKOJjq/z?=
 =?us-ascii?Q?7sn+xzS4GbyeDLYUmFCMLkZ/35yj2TiBnor9ijErjjpuqmwCo8/BL6P7sOpu?=
 =?us-ascii?Q?PJ7W8P0cJ0K0lnqwatE+fmRz5ijHIvmnt1IX1vq+qFqeQMLoYn5S0zyRmXUC?=
 =?us-ascii?Q?N6cd5AD+VQX+uHHnrlKWXaIiy3YA8Q1j9SmqcSklm1Wd7E0hTQEF4G+4zNVn?=
 =?us-ascii?Q?TNut08IZL/Es66qedBnpOnktSgcyqiOtwctHJTR1HWWS7Moz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a259be-6453-4328-98dd-08deb85fc265
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:10:55.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MxD8t7KnOeYLKsFxkXZxndGGeQIITtpf8N2yLe5MXyONZ+/Kr1JK9La0dhOMiv7
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
	TAGGED_FROM(0.00)[bounces-21184-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 7B6E15BBB09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To maintain the split where ib_uverbs.ko should not be depended on by
drivers, add a new module ib_uverbs_support.ko which contains the driver
called functions that are too large or too rare to be placed in
ib_uverbs_core.ko

Start by moving most of rdma_core.c into this module, making some
adjustments to split it from the actual uverbs FD code.

This was not done originally because we lacked EXPORT_SYMBOL_NS and I had
a fear that drivers would abuse this interface surface.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      |   8 +-
 drivers/infiniband/core/rdma_core.c   | 120 ++++++++++++--------------
 drivers/infiniband/core/rdma_core.h   |   1 -
 drivers/infiniband/core/uverbs.h      |   9 ++
 drivers/infiniband/core/uverbs_main.c | 100 +++++++++++++--------
 5 files changed, 133 insertions(+), 105 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index f24f575a011be3..e696bb197b0e1f 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -5,7 +5,9 @@ user_access-$(CONFIG_INFINIBAND_ADDR_TRANS)	:= rdma_ucm.o
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_cm.o iw_cm.o \
 					$(infiniband-y)
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
-obj-$(CONFIG_INFINIBAND_USER_ACCESS) += ib_uverbs.o $(user_access-y)
+obj-$(CONFIG_INFINIBAND_USER_ACCESS) += ib_uverbs.o \
+					$(user_access-y) \
+					ib_uverbs_support.o
 
 ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o cache.o netlink.o \
@@ -34,7 +36,7 @@ rdma_ucm-y :=			ucma.o
 ib_umad-y :=			user_mad.o
 
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
-				rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
+				uverbs_std_types.o uverbs_ioctl.o \
 				uverbs_std_types_cq.o \
 				uverbs_std_types_dmabuf.o \
 				uverbs_std_types_dmah.o \
@@ -46,3 +48,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_wq.o \
 				uverbs_std_types_qp.o \
 				ucaps.o
+
+ib_uverbs_support-y :=		rdma_core.o
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 71e3d58d26e654..b81a1540d0fb59 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -42,6 +42,40 @@
 #include "core_priv.h"
 #include "rdma_core.h"
 
+static void release_ufile_idr_uobject(struct ib_uverbs_file *ufile);
+
+void ib_uverbs_release_file(struct kref *ref)
+{
+	struct ib_uverbs_file *file =
+		container_of(ref, struct ib_uverbs_file, ref);
+	struct ib_device *ib_dev;
+	int srcu_key;
+
+	release_ufile_idr_uobject(file);
+
+	srcu_key = srcu_read_lock(&file->device->disassociate_srcu);
+	ib_dev = srcu_dereference(file->device->ib_dev,
+				  &file->device->disassociate_srcu);
+	if (ib_dev && !ib_dev->ops.disassociate_ucontext)
+		module_put(ib_dev->ops.owner);
+	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
+
+	if (refcount_dec_and_test(&file->device->refcount))
+		ib_uverbs_comp_dev(file->device);
+
+	if (file->default_async_file)
+		uverbs_uobject_put(&file->default_async_file->uobj);
+	put_device(&file->device->dev);
+
+	if (file->disassociate_page)
+		__free_pages(file->disassociate_page, 0);
+	mutex_destroy(&file->disassociation_lock);
+	mutex_destroy(&file->umap_lock);
+	mutex_destroy(&file->ucontext_lock);
+	kfree(file);
+}
+EXPORT_SYMBOL_NS_GPL(ib_uverbs_release_file, "rdma_core");
+
 static void uverbs_uobject_free(struct kref *ref)
 {
 	kfree_rcu(container_of(ref, struct ib_uobject, ref), rcu);
@@ -214,6 +248,7 @@ int uobj_destroy(struct ib_uobject *uobj, struct uverbs_attr_bundle *attrs)
 	up_read(&ufile->hw_destroy_rwsem);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(uobj_destroy, "rdma_core");
 
 /*
  * uobj_get_destroy destroys the HW object and returns a handle to the uobj
@@ -239,6 +274,7 @@ struct ib_uobject *__uobj_get_destroy(const struct uverbs_api_object *obj,
 
 	return uobj;
 }
+EXPORT_SYMBOL_NS_GPL(__uobj_get_destroy, "rdma_core");
 
 /*
  * Does both uobj_get_destroy() and uobj_put_destroy().  Returns 0 on success
@@ -255,6 +291,7 @@ int __uobj_perform_destroy(const struct uverbs_api_object *obj, u32 id,
 	uobj_put_destroy(uobj);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(__uobj_perform_destroy, "rdma_core");
 
 /* alloc_uobj must be undone by uverbs_destroy_uobject() */
 static struct ib_uobject *alloc_uobj(struct uverbs_attr_bundle *attrs,
@@ -420,6 +457,7 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	uverbs_uobject_put(uobj);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_lookup_get_uobject, "rdma_core");
 
 static struct ib_uobject *
 alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
@@ -522,6 +560,7 @@ struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(rdma_alloc_begin_uobject, "rdma_core");
 
 static void alloc_abort_idr_uobject(struct ib_uobject *uobj)
 {
@@ -668,6 +707,7 @@ void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
 	/* Matches the down_read in rdma_alloc_begin_uobject */
 	up_read(&ufile->hw_destroy_rwsem);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_alloc_commit_uobject, "rdma_core");
 
 /*
  * new_uobj will be assigned to the handle currently used by to_uobj, and
@@ -697,6 +737,7 @@ void rdma_assign_uobject(struct ib_uobject *to_uobj, struct ib_uobject *new_uobj
 	 */
 	uverbs_destroy_uobject(to_uobj, RDMA_REMOVE_DESTROY, attrs);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_assign_uobject, "rdma_core");
 
 /*
  * This consumes the kref for uobj. It is up to the caller to unwind the HW
@@ -727,6 +768,7 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 	/* Matches the down_read in rdma_alloc_begin_uobject */
 	up_read(&ufile->hw_destroy_rwsem);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_alloc_abort_uobject, "rdma_core");
 
 static void lookup_put_idr_uobject(struct ib_uobject *uobj,
 				   enum rdma_lookup_mode mode)
@@ -770,13 +812,15 @@ void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 	/* Pairs with the kref obtained by type->lookup_get */
 	uverbs_uobject_put(uobj);
 }
+EXPORT_SYMBOL_NS_GPL(rdma_lookup_put_uobject, "rdma_core");
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile)
 {
 	xa_init_flags(&ufile->idr, XA_FLAGS_ALLOC);
 }
+EXPORT_SYMBOL_NS_GPL(setup_ufile_idr_uobject, "rdma_core");
 
-void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
+static void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
 {
 	struct ib_uobject *entry;
 	unsigned long id;
@@ -839,6 +883,7 @@ int uverbs_uobject_release(struct ib_uobject *uobj)
 	uverbs_uobject_put(uobj);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(uverbs_uobject_release, "rdma_core");
 
 /*
  * Users of UVERBS_TYPE_ALLOC_FD should set this function as the struct
@@ -878,41 +923,8 @@ int uverbs_uobject_fd_release(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL(uverbs_uobject_fd_release);
 
-/*
- * Drop the ucontext off the ufile and completely disconnect it from the
- * ib_device
- */
-static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
-				   enum rdma_remove_reason reason)
-{
-	struct ib_ucontext *ucontext = ufile->ucontext;
-	struct ib_device *ib_dev = ucontext->device;
-
-	/*
-	 * If we are closing the FD then the user mmap VMAs must have
-	 * already been destroyed as they hold on to the filep, otherwise
-	 * they need to be zap'd.
-	 */
-	if (reason == RDMA_REMOVE_DRIVER_REMOVE) {
-		uverbs_user_mmap_disassociate(ufile);
-		if (ib_dev->ops.disassociate_ucontext)
-			ib_dev->ops.disassociate_ucontext(ucontext);
-	}
-
-	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
-			   RDMACG_RESOURCE_HCA_HANDLE);
-
-	rdma_restrack_del(&ucontext->res);
-
-	ib_dev->ops.dealloc_ucontext(ucontext);
-	WARN_ON(!xa_empty(&ucontext->mmap_xa));
-	kfree(ucontext);
-
-	ufile->ucontext = NULL;
-}
-
-static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
-				  enum rdma_remove_reason reason)
+int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
+			   enum rdma_remove_reason reason)
 {
 	struct uverbs_attr_bundle attrs = { .ufile = ufile };
 	struct ib_ucontext *ucontext = ufile->ucontext;
@@ -953,36 +965,7 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 	}
 	return ret;
 }
-
-/*
- * Destroy the ucontext and every uobject associated with it.
- *
- * This is internally locked and can be called in parallel from multiple
- * contexts.
- */
-void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
-			     enum rdma_remove_reason reason)
-{
-	down_write(&ufile->hw_destroy_rwsem);
-
-	/*
-	 * If a ucontext was never created then we can't have any uobjects to
-	 * cleanup, nothing to do.
-	 */
-	if (!ufile->ucontext)
-		goto done;
-
-	while (!list_empty(&ufile->uobjects) &&
-	       !__uverbs_cleanup_ufile(ufile, reason)) {
-	}
-
-	if (WARN_ON(!list_empty(&ufile->uobjects)))
-		__uverbs_cleanup_ufile(ufile, RDMA_REMOVE_DRIVER_FAILURE);
-	ufile_destroy_ucontext(ufile, reason);
-
-done:
-	up_write(&ufile->hw_destroy_rwsem);
-}
+EXPORT_SYMBOL_NS_GPL(__uverbs_cleanup_ufile, "rdma_core");
 
 const struct uverbs_obj_type_class uverbs_fd_class = {
 	.alloc_begin = alloc_begin_fd_uobject,
@@ -1020,6 +1003,7 @@ uverbs_get_uobject_from_file(u16 object_id, enum uverbs_obj_access access,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(uverbs_get_uobject_from_file, "rdma_core");
 
 void uverbs_finalize_object(struct ib_uobject *uobj,
 			    enum uverbs_obj_access access, bool hw_obj_valid,
@@ -1052,6 +1036,7 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 		WARN_ON(true);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(uverbs_finalize_object, "rdma_core");
 
 /**
  * rdma_uattrs_has_raw_cap() - Returns whether a rdma device linked to the
@@ -1081,3 +1066,6 @@ bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs)
 	return has_cap;
 }
 EXPORT_SYMBOL(rdma_uattrs_has_raw_cap);
+
+MODULE_DESCRIPTION("InfiniBand uverbs objects");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 55f1e3558856f1..b626d3d24d087d 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -70,7 +70,6 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile);
-void release_ufile_idr_uobject(struct ib_uverbs_file *ufile);
 
 struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs);
 
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index a1de8fe9c90bf1..c64dd6b94e1067 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -359,4 +359,13 @@ static inline void ib_uverbs_dmabuf_done(struct kref *kref)
 	complete(&priv->comp);
 }
 
+int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
+			   enum rdma_remove_reason reason);
+
+static inline void ib_uverbs_comp_dev(struct ib_uverbs_device *dev)
+{
+	complete(&dev->comp);
+}
+
+
 #endif /* UVERBS_H */
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index a937d276c5c076..ab6f1e3cb47a18 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -61,6 +61,7 @@
 MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("InfiniBand userspace verbs access");
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS("rdma_core");
 
 enum {
 	IB_UVERBS_MAJOR       = 231,
@@ -165,42 +166,6 @@ void ib_uverbs_detach_umcast(struct ib_qp *qp,
 	}
 }
 
-static void ib_uverbs_comp_dev(struct ib_uverbs_device *dev)
-{
-	complete(&dev->comp);
-}
-
-void ib_uverbs_release_file(struct kref *ref)
-{
-	struct ib_uverbs_file *file =
-		container_of(ref, struct ib_uverbs_file, ref);
-	struct ib_device *ib_dev;
-	int srcu_key;
-
-	release_ufile_idr_uobject(file);
-
-	srcu_key = srcu_read_lock(&file->device->disassociate_srcu);
-	ib_dev = srcu_dereference(file->device->ib_dev,
-				  &file->device->disassociate_srcu);
-	if (ib_dev && !ib_dev->ops.disassociate_ucontext)
-		module_put(ib_dev->ops.owner);
-	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
-
-	if (refcount_dec_and_test(&file->device->refcount))
-		ib_uverbs_comp_dev(file->device);
-
-	if (file->default_async_file)
-		uverbs_uobject_put(&file->default_async_file->uobj);
-	put_device(&file->device->dev);
-
-	if (file->disassociate_page)
-		__free_pages(file->disassociate_page, 0);
-	mutex_destroy(&file->disassociation_lock);
-	mutex_destroy(&file->umap_lock);
-	mutex_destroy(&file->ucontext_lock);
-	kfree(file);
-}
-
 static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 				    struct file *filp, char __user *buf,
 				    size_t count, loff_t *pos,
@@ -985,6 +950,69 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	return ret;
 }
 
+/*
+ * Drop the ucontext off the ufile and completely disconnect it from the
+ * ib_device
+ */
+static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
+			    enum rdma_remove_reason reason)
+{
+	struct ib_ucontext *ucontext = ufile->ucontext;
+	struct ib_device *ib_dev = ucontext->device;
+
+	/*
+	 * If we are closing the FD then the user mmap VMAs must have
+	 * already been destroyed as they hold on to the filep, otherwise
+	 * they need to be zap'd.
+	 */
+	if (reason == RDMA_REMOVE_DRIVER_REMOVE) {
+		uverbs_user_mmap_disassociate(ufile);
+		if (ib_dev->ops.disassociate_ucontext)
+			ib_dev->ops.disassociate_ucontext(ucontext);
+	}
+
+	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
+			   RDMACG_RESOURCE_HCA_HANDLE);
+
+	rdma_restrack_del(&ucontext->res);
+
+	ib_dev->ops.dealloc_ucontext(ucontext);
+	WARN_ON(!xa_empty(&ucontext->mmap_xa));
+	kfree(ucontext);
+
+	ufile->ucontext = NULL;
+}
+
+/*
+ * Destroy the ucontext and every uobject associated with it.
+ *
+ * This is internally locked and can be called in parallel from multiple
+ * contexts.
+ */
+void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
+			     enum rdma_remove_reason reason)
+{
+	down_write(&ufile->hw_destroy_rwsem);
+
+	/*
+	 * If a ucontext was never created then we can't have any uobjects to
+	 * cleanup, nothing to do.
+	 */
+	if (!ufile->ucontext)
+		goto done;
+
+	while (!list_empty(&ufile->uobjects) &&
+	       !__uverbs_cleanup_ufile(ufile, reason)) {
+	}
+
+	if (WARN_ON(!list_empty(&ufile->uobjects)))
+		__uverbs_cleanup_ufile(ufile, RDMA_REMOVE_DRIVER_FAILURE);
+	ufile_destroy_ucontext(ufile, reason);
+
+done:
+	up_write(&ufile->hw_destroy_rwsem);
+}
+
 static int ib_uverbs_close(struct inode *inode, struct file *filp)
 {
 	struct ib_uverbs_file *file = filp->private_data;
-- 
2.43.0


