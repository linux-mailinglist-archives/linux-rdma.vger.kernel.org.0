Return-Path: <linux-rdma+bounces-21180-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM2SJpzwEGo+fwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21180-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D1B5BBAF2
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92DBC3008081
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BF2744F;
	Sat, 23 May 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVCfDAsq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69314EEC0
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495061; cv=fail; b=ZzmgZJQyoej4rfDtnvFa3eMjkCy7yk/6MTps++D/hXJGyepYLfiR81waVu2UywxFHOuP/+YvlT9K5yuPaD6GuAthce3h73CHfjW8T+dUZofyRX9eZP0KE00lDWoy03MjhTtBJLEm/WOmf4Q8LMl+dtF7CbPZrC61RlIRBbMcsL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495061; c=relaxed/simple;
	bh=Xfz2u/pndV/3x4+rymwBZkhJ3MTFCyUpkVJhw3gHOGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkN3UaShL+VeWDKJkV3nFb6MERd6yve8qIHFOYiqDqwCkbcf+kibXnv8TwKYyOLHxK5tx26x6NnO4LrpM+jgK16Oe6b3D8JD5obdV2VqswGCxcNzZpiJAxSk91IqE0MtcEqPfN7T1I2k7rxfwiAMgzKtpmHQj+LChQ8pz+NefAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVCfDAsq; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDkwnQq0E4xz+qOAvv9Tg54Y2b7A/msN4DrCUfIO5+jaoPF9b6deucOX4tSGx3k7S7VJE4l25UTHSHll+cWl/Pi3AOdCfpFHSLRtwCS92lWSGvjEKc6t4a5W35m1PEQ08OY09YyNfQGVov9tiPJ6luA9J5qHiRuBFLWSj2pDCxPkoHKG1NHs3pHiDzSHWimDh4wgmdiIE8NvsxCig73MB2kl764AEJkugIuJ/V1bhnMsClhORvCXbGBKdZHIeykA2oRH10d1tbLM7xlhw9sT9DxUlX1DdUYjllAWtGtPqMRFXn9P3Mq3hS6vjOPzzneuFzDZj8iprVqEMaFFZ9I8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85jss0XSTkr36B9baOPmidKqXP8MabuVWz5c+rRy1rw=;
 b=JZ9GYXcEbAwa1P1WsMLNfCmD0vNvbzbaHAHLrkcZUV9rBR6RS2sRbZp+arjv8MTRmPNz3DN+D98NgMnNrHdZUpAk/u9ZIZVqsnDQVqhc8FK/pxpWOQblEWBrcoMF9jRHefJWXGuGbAQkt+tu4YvSIqfnEHrlbsluEXVnW6SpXnmz97q2eMl/3nt+4FiXbD/ELoAOZQgqJzyiHf2TAYZFfqqDQILD+5TzvKK2bhGkOcgMYc7sYDpn3f7VaA3TXAwRfZ6PYBdnmASBxJvYncfKMjmcY27hDd0qdxGVkZ6I9OPLmVd8azlF96R2o6svzVlgJxTQkaFv/IqcT4aYQSmP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85jss0XSTkr36B9baOPmidKqXP8MabuVWz5c+rRy1rw=;
 b=LVCfDAsqwfW2CSAGD4v303Nh2BtSKLYv4wLYRVwOB8zJ1l2nHbU/g/EaJ3Co2ST3vI4Y/Fv3LyUUYsSfrM0/eQZD6lKdC1LNSIB1BDVcN5KZmYBo+Jh3mVn2djr20App8kxiiNYKPFE+JZCbVBUh2/iC6cJk00jop7WD27YkW5DE7xnsVtYNQfB8R29jmrFMDbs48fPZIoevxpG2Vn4ZZ3WoWBKRAKwNCQ++IjfIEaB07Zrp8kqAnvSpVCAX5ghsjdR9pMAz5N1aOQPTEska7lk2M9mwGdNGJUhWTKrVxe+cAOr4lSCuyukyOrsKMf+g+vwVlFBzIwA8N15z7pHJEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 00:10:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 00:10:54 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v2 1/6] RDMA/core: Do not compile ib_core_uverbs without USER_ACCESS
Date: Fri, 22 May 2026 21:10:48 -0300
Message-ID: <1-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1fbf98-416d-4d03-3499-08deb85fc17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	xqyBQV7bK1ivNhQAohsBRK0XoRWiZFJxBn+oWuAM2oHkJ0+W8eUqunahvPxH6/12xjK7DhhZs7/jPlG5NCz92fNFG4KSW+J7rfFhUwGhX4sIOKFuUfJOyLrBJC+9lsyCRWfx+3Bu3r13P6Oth781xQlJM/P6auNAYwgXGbYUIZTAbmnV/uyXBDMqvIcqWSdcj7tINgXW6OyhMyh20eZmkUrdILXvJ8Q3rXdSAa1IrPXsOFhc0YDKfmLkN0x0Vt4KFkaaZvb3ne5hvOSlUdsZe7oYlMlOxK3BTz0t03ZmE4eNMNqkgaPAD5l5JHbmzIMTvy9Jf6RYsPUXKm/iyxPF7Tog52PrQdgpON6VEKG3biDHKTCPeSGx7E+8EAZTXlnS0e7FHjxapCbUcH6zs8PZx2xxA6H2aUGNWY6YB4aUxv+/nKMY8j7HVyjG6DEflheaONmDYoaJS4Zb+POaiXTCKSiFllyEoakqXH2TeIRb8zheo31CYZgN9/hD+HH/KF4Yy2ZUzxJDe2l7gUIAjxM2FcEfHqhmZ2uZ5jx3lKBNGPyp3WkCgk42sMp/q4Ucl0a9WLnpUvxcvJoVZWO3ebSOevFP3OWfFKM6WhIfhgeJX6vxQofYDPDWAQ5zVkVlZqZ++nt3A2ghcBmvEjVB+ohFh8biTrfVRLi89Ny4ZDwvOCjkjyCovH6Qfmb0n6AIwmMf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6TbHoGr59b43rSbSbnmPU54JQYdO5rMrba0Dy75Do0sn569OcqA6lkTEQi1?=
 =?us-ascii?Q?pGaF1l53drW9dnZ1qVEvB0BfHvUgXXaE19EjwY7HwAMLwpa3wUtCpYZKO/Up?=
 =?us-ascii?Q?uSWDgPW6Mo6husS/n0q9OFRfOm8YdIsxSlMx30WW4ESbXTU7FXVggm0K/ScJ?=
 =?us-ascii?Q?s7hxCTFI7Jck45SdgK7djVKUsaHylBsKZzR+koXiKtEApy8hxX+RncvlK6Qa?=
 =?us-ascii?Q?UDsKgR7QCQBiFTX0D4/CT6k+06ghPpaStVdwLlXguPGph70u9oK/MlN/XBJm?=
 =?us-ascii?Q?HXblPd0nQiW0kOD/57SOFJDOQy8OB7/tyCIqqnSsv+DNw29V7Z6UAcvyd9BS?=
 =?us-ascii?Q?oW0D23cngX6SvFb+cMxyopr28+XXeC/tXX0hXOOmAn9cL2dWYqIJFsOtR55/?=
 =?us-ascii?Q?LAx1ViBRMHDIRUZIhpXPtqbPlLEJqL5+g5XlD/4jKQaI6Kemu+AuK3AzIxa5?=
 =?us-ascii?Q?NuarvD018qDvj9wjUTALXAxCNOujVHVUkz7kUcNj2IUSTUi1qkCGrj9/6v/o?=
 =?us-ascii?Q?/B4beO+23iE019IKBf/8+qI+Jrk9wVGwiSbrvdjyL8KgEp+GkyMD1Tv17oGk?=
 =?us-ascii?Q?RusyicyOnDGojn7bIWSD0A5c2sGzcC0R1IrR2bdyQ+ijDG6QEiBsrnjXeaIy?=
 =?us-ascii?Q?ys7m4KagVXj5xU48gRcGb2wEq7EUY1wv6EwaOJjwIdH0O8vLaCZpnd2mkQ8t?=
 =?us-ascii?Q?2KOH99njHWJgyoOHIua3ZELzOCBjx5T4qTD2pCVnJZup11Qfw7koZSt08aD9?=
 =?us-ascii?Q?YG0GlG3x4jmFgL7rcNPre3vs7jU/i5Jq4d4ltoSIBoKnL4nTKs+ncZ0Kscav?=
 =?us-ascii?Q?8yrVbJP/tS30fsLX6OjI5vgzk8U5290/01lL5Vw+c76bxwsPVizzkJ64+RXS?=
 =?us-ascii?Q?Esbmk4nF/wbDn+dcWASII8Nlv2GjunuXbI4bqbMUqey78idiS8GUXHRiPVKn?=
 =?us-ascii?Q?CN+3NOAM4RmheY+8chQhEWMBCq0TN/WJiMSrnpUGsGQXlBmwXd2lH3jkzOWd?=
 =?us-ascii?Q?VJluLtZon2JP9dwRE+nhKpUVhJRLdfP5dqJjfRCp0rp3l/KorGKQgzYZuXpc?=
 =?us-ascii?Q?AWBdbsFY9V38KlUsVTnPkNOKcqAePvFfnmtSJ60mudoGP98OzJ/9hK/P1bdQ?=
 =?us-ascii?Q?IZLsMsBSf/BizBygOnm0FiUVbtjMPar/ngKvDo66hUX/QkBxlPDxc+XSl78C?=
 =?us-ascii?Q?k8agv73YcYQa/Tsqd4h38DuYci+gfEnOC0X4MmHUaqxuf5wbiv/jFuKJ/uNA?=
 =?us-ascii?Q?sFhU/LRvSSDBiUBK2IowFoVxLrHMgp5mNwvuFIKRd/ayYnsW6TKCfLHXgvqs?=
 =?us-ascii?Q?BJusF1y4Yl/MLjtqmakyfgK2Mt85KuurA1UT/PqLq2HeRTRfmChwWtI7OgZq?=
 =?us-ascii?Q?/QHzfUp8Vsvi2vMpErbYC8d/I8dObwYgjdIud7bsENsvdgVQZhdTGqhblLeR?=
 =?us-ascii?Q?6IxsgW91Cho7vr3+kvD7Dz1GfzyYHN6gDnvc8bhPQ2hUa3fTvJxzRb8rRJbg?=
 =?us-ascii?Q?6z4Wqyeyay/VlpG90YFiK7Z9vpHJig5IZmzETpXfsRJ6CV2Ysdeyl6+KA28f?=
 =?us-ascii?Q?f17Vek+ngxN5Usi1Z+35QFdBGSmfVtTu9Lu0RBke/2uab3NTOB5rbCIvo2rB?=
 =?us-ascii?Q?ygwygAcGl+bpuDUDniZ8LVc2S+J8YLix2gXgoADdX2dKTsaE443etM3RTo+c?=
 =?us-ascii?Q?l49iJFOgAxN3w78AiRYOopO9Qypqx4o1QLJPUqsjqaE/oVKU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1fbf98-416d-4d03-3499-08deb85fc17d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:10:54.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPNIDG1rSMKCCmAQTkK9/Oy6amMTCkkHgn7/QYS6+aTRJkwtZmwV2g91Mnsts1Ox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21180-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97D1B5BBAF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the entire ib_core_uverbs.c from the build if
CONFIG_INFINIBAND_USER_ACCESS is not set. These functions are only used to
support uverbs and are never callable even if they happen to get linked
in.

Provide inlines for the missing ones to return errors to further push code
elimination in drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile         |  3 +-
 drivers/infiniband/core/ib_core_uverbs.c |  8 ++--
 drivers/infiniband/core/rdma_core.h      |  3 --
 include/rdma/ib_verbs.h                  | 61 ++++++++++++++++++++++++
 include/rdma/uverbs_ioctl.h              | 13 +++--
 5 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index dce798d8cfe67b..f24f575a011be3 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -11,13 +11,14 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o cache.o netlink.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
-				nldev.o restrack.o counters.o ib_core_uverbs.o \
+				nldev.o restrack.o counters.o \
 				trace.o lag.o iter.o frmr_pools.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
 ib_core-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
 ib_core-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
+ib_core-$(CONFIG_INFINIBAND_USER_ACCESS) += ib_core_uverbs.o
 
 ib_cm-y :=			cm.o cm_trace.o
 
diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 8a0e6fa2a52837..0acb0d4967cb6b 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -398,7 +398,7 @@ EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
  * The struct ib_device that is handling the uverbs call. Must not be called if
  * udata is NULL. The result can be NULL.
  */
-struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
+static struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
 {
 	struct uverbs_attr_bundle *bundle =
 		rdma_udata_to_uverbs_attr_bundle(udata);
@@ -415,10 +415,9 @@ struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
 	return srcu_dereference(bundle->ufile->device->ib_dev,
 				&bundle->ufile->device->disassociate_srcu);
 }
-EXPORT_SYMBOL(rdma_udata_to_dev);
 
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
-uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
+typedef int (*uverbs_api_ioctl_handler_fn)(struct uverbs_attr_bundle *attrs);
+static uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
 {
 	struct uverbs_attr_bundle *bundle =
 		rdma_udata_to_uverbs_attr_bundle(udata);
@@ -502,4 +501,3 @@ int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(_ib_respond_udata);
-#endif
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 269b393799abbc..55f1e3558856f1 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -151,9 +151,6 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
 			      unsigned int num_attrs);
 void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile);
 
-typedef int (*uverbs_api_ioctl_handler_fn)(struct uverbs_attr_bundle *attrs);
-uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata);
-
 extern const struct uapi_definition uverbs_def_obj_async_fd[];
 extern const struct uapi_definition uverbs_def_obj_counters[];
 extern const struct uapi_definition uverbs_def_obj_cq[];
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0ba4..5a20c7ceceaa28 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3101,6 +3101,7 @@ void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 void ib_set_device_ops(struct ib_device *device,
 		       const struct ib_device_ops *ops);
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		      unsigned long pfn, unsigned long size, pgprot_t prot,
 		      struct rdma_user_mmap_entry *entry);
@@ -3138,6 +3139,66 @@ rdma_user_mmap_entry_get(struct ib_ucontext *ucontext,
 void rdma_user_mmap_entry_put(struct rdma_user_mmap_entry *entry);
 
 void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry);
+#else
+static inline int rdma_user_mmap_io(struct ib_ucontext *ucontext,
+				    struct vm_area_struct *vma,
+				    unsigned long pfn, unsigned long size,
+				    pgprot_t prot,
+				    struct rdma_user_mmap_entry *entry)
+{
+	return -EINVAL;
+}
+
+static inline int
+rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
+			    struct rdma_user_mmap_entry *entry, size_t length)
+{
+	return -EINVAL;
+}
+
+static inline int
+rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
+				  struct rdma_user_mmap_entry *entry,
+				  size_t length, u32 min_pgoff, u32 max_pgoff)
+{
+	return -EINVAL;
+}
+
+static inline void rdma_user_mmap_disassociate(struct ib_device *device)
+{
+}
+
+static inline int
+rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
+				  struct rdma_user_mmap_entry *entry,
+				  size_t length, u32 pgoff)
+{
+	return -EINVAL;
+}
+
+static inline struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get_pgoff(struct ib_ucontext *ucontext,
+			       unsigned long pgoff)
+{
+	return NULL;
+}
+
+static inline struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get(struct ib_ucontext *ucontext,
+			 struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline void rdma_user_mmap_entry_put(struct rdma_user_mmap_entry *entry)
+{
+}
+
+static inline void
+rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
+{
+}
+#endif
 
 static inline int ib_copy_from_udata(void *dest, struct ib_udata *udata, size_t len)
 {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index c89428030d61ae..9d7575d999e121 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -668,8 +668,6 @@ rdma_udata_to_uverbs_attr_bundle(struct ib_udata *udata)
 	(udata ? container_of(rdma_udata_to_uverbs_attr_bundle(udata)->context, \
 			      drv_dev_struct, member) : (drv_dev_struct *)NULL)
 
-struct ib_device *rdma_udata_to_dev(struct ib_udata *udata);
-
 #define IS_UVERBS_COPY_ERR(_ret)		((_ret) && (_ret) != -ENOENT)
 
 static inline const struct uverbs_attr *uverbs_attr_get(const struct uverbs_attr_bundle *attrs_bundle,
@@ -902,6 +900,8 @@ int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 			       size_t kernel_size, size_t minimum_size);
 int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len);
+int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
+				    u64 valid_cm);
 #else
 static inline int
 uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
@@ -971,6 +971,12 @@ static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
 {
 	return -EINVAL;
 }
+
+static inline int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata,
+						  u64 req_cm, u64 valid_cm)
+{
+	return -EINVAL;
+}
 #endif
 
 #define uverbs_get_const_signed(_to, _attrs_bundle, _idx)                      \
@@ -1051,9 +1057,6 @@ uverbs_get_raw_fd(int *to, const struct uverbs_attr_bundle *attrs_bundle,
 	_ib_copy_validate_udata_in(_udata, &(_req), sizeof(_req), \
 				   offsetofend(typeof(_req), _end_member))
 
-int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
-				    u64 valid_cm);
-
 /**
  * ib_copy_validate_udata_in_cm - Copy the req structure and check the comp_mask
  * @_udata: The system calls ib_udata struct
-- 
2.43.0


