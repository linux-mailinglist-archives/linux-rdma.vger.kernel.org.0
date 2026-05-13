Return-Path: <linux-rdma+bounces-20590-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFX7LEC4BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20590-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:43:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE1A53837E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F34B302EC83
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98D4DC53C;
	Wed, 13 May 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KUd11vAj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51A4DBD97
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693625; cv=fail; b=E/DfGjaUIidIASQJqSQ78mGkB0+ZqwH18icxZBIjoSbjxL1Tieidb7mhqkMGAmL3ZEcaCIqxjW/rRAPKDUO123GLL20prcsCV1uuuI5hyXK/fPceDCB9rQjffBgyMZu7/GzxjueVCRPuYTv4sH0/6P/a5m5A7G8FDUYb3q6PBd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693625; c=relaxed/simple;
	bh=ptVp9+DavsKZ2y1QPubrRVdXHpDRPtEXexteCTNdEgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVYTL0I/cNT8OS/Lk6ob5XbxoBJxQ/Se8HxEKY41Wz/taj+dyD5PXvZYWXclehwn8h+bXwxQMCVtcjCSUJka4OxUv8I5WTWL+evip4eCBqq98Z61qxZVx+egd6UX26dTyruRBq2uK79kQ9oiTSD14elXaRu/IixHTi20tc50B9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KUd11vAj; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QutZ5RZiRfyiCN5+r5sV/39bNuGb9IMYKeT55Z2AmUQfMdr663zS5pxzBFg+OrHXHJ19qjFnMnDfgK1EmSgA/LWR7sS/gYxShnr2PvaACZlrXbWNHe/b+hwX0bSti49oGHJ22YwlX5os8ljkIv5gEjK3JRjMzDYI+O8syfRrm4H13yyGqEzl+/7AhPLZJ847vIXLUI3Q5QABz0cpGydFU1qBINy+Wthgt/Zv38txk8GRogLyp5+GXrqUFPnmcTUdV907Nc2OIokNB2lwgB64ZBAeKjudjSeUWB2Ki/JMRaJoO7mRkJBx1aPPfTNgzF7r/4YkROkB4kj0bg1asEuW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FaYbF5AXNiYDISbJhpbOh4FY3FIFm8KaY7GhLQMJWo=;
 b=E30SvZiTxF2qtk5mPtdbXWOYeEASWrrEh5I3IEiVIhlt5BFEksF+YKaMmCW1fN/YLhrHg3w1xFp9+hUSvHGkGCWDVpCpspdH727iRpgcjFuO/fXVAK3t7sjbiLLdi1/PSJ7+foZeWwOu+KOD+Sb2xj8wln7nm4lJuz31BGTlrCXDaVTY0cR3OiqO2pFS7UgXMSmxzQOw9UsRgYXc1pc30whboBKz9ryXpvuf058ftZUKTg4llNQLTT3F+6VCRWvCKsZI8QTN+k+jkCNfWyLnGEm/6qJ5eDc955m+kKlUXFtVzaQfH6r614dUquErTF28D3eQQe3epIiAhp7XmipBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FaYbF5AXNiYDISbJhpbOh4FY3FIFm8KaY7GhLQMJWo=;
 b=KUd11vAjFJzy7p0MIQpv6bCfidP8tpKHJWrdkD+QhNHVfPpj2R3a+s7N1hUjg4ZPUk+yaISBhsxXS46v5NBr+DJgLs23yoPy9cxH0V/NvPL3HXkbXWZLGdTe3T6+vUDl7/J7TWQ5ChzOurh78feG6GQlR7j3zIVlW9tR+SQA95CgJp+WuiCUTD5l5vYcV2k92VBmGtPDtgyn2Lw5B7TsPunMKTUyFdGIBDE/MdGKnnk70/pf2EIZIZhhOBxMdCa+USckLm47Rhy8yqJvRjNK0hhHRFAR1WU18PLlAK5QXtcwDuuCmWntOdgxHWv5rb2psMVqvvybO8+JWLVNAkAcaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:33:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:33:32 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 4/6] RDMA/core: Make a new module for the uverbs components needed by drivers
Date: Wed, 13 May 2026 14:33:26 -0300
Message-ID: <4-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:208:32a::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 450175f2-4515-49fe-c3e4-08deb115c04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	ZjCvspbH+aKUzA9LW7Wq96a6dACCHR6mataSiKhhHN7ADSRJzHTPdN6TsjB27WdVHXHWohu0OhlLXX4oc0BXPkdJMHA23wBG6e3CXASQzthZZWrVZ5ykLIcCOV2SJL6wZPE56+Dk6LDYkYByHopydX/xc7/nBmOsfWJ0dYgxc6HtvkUZByauBhhSi8b0xomSrHbXcJhx5ylQHWM7YkAW7s3at7a+Z3iZ3UZdwE39C/kTT2AUu3Qz7iGew7PNI8H11s1W9hnopqvhFt3vN6UaeVZn/2KrAEgD+wrD2rVo1w1LfobxYAiERWsL5VZsiEAdLdb/y/wccMqeEvkvsWgJgQM1c2sJ2ghGKllBX3m5al4bBmP+UbVtuXeSyxNxSLHu5O1WAN/gJq5uydNgERGJ3Hy/su4nj9bkUAHMmwnoLaD8mUQ4HAXNAtYngSSMBzdGqFc7GN6MxMPYFSR+0qjuho9Aph6+Nqpc0yhtDT6yWIuHdP+ImABtNAGg4qAJ3fJnAwLLTdoVKa7Vn25iJbGcWC1H+BTMvUhxPdooGeoVlj/slDnd0puNiS46Hem8H4IDYcD2CnLBnyI8di6n2XKC6TVtTK8PLSOme8YlDjEiGOF8ItSL8MwnxQAEnAOjwcJt9ucpzYRU6pQTAKn7VM10DL2/UHV1Khc7LyL8opzJ9m0sS8OgOL/9BfVx96UezCvc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbBVwZAKJtFfdMxb2TZL+IgLriUHoTajjpVj7dwVeNve6Vlq/cfxjnvQP+xJ?=
 =?us-ascii?Q?8uFsovQho6iOZ69mgUNqgTa8MIDfTytA8FhCl7/ST3znmF83fTEDmKqGqhLQ?=
 =?us-ascii?Q?ZSDmaJxCOKNcRdAjKR03QO2588Cizi5edxhOUymD4tuSIXbcll+W6dXzxXza?=
 =?us-ascii?Q?H6ukIzD93G8HzLVK2QmxNa6k7fQCE8a4ZgzyhfkFen50zpV34GEZUBlfHx6a?=
 =?us-ascii?Q?uo7XgSX5YeL5UJp2iDuhbAlHOUSLMmBe1a+Eol2965l8ug7chjFsVanCYK2A?=
 =?us-ascii?Q?G+mWeiiPUIux09QRKZNGvz+p7ryh/BDyYsrTKlv/KSN/QV5bh4j+lIax8HyW?=
 =?us-ascii?Q?5FJ6q+lx220itAnS3mOj5yeKf+ZKQca0OtI5gP6NJYZsY0TTUzq0I0l4I9Wl?=
 =?us-ascii?Q?HgXcQSCYXy3PTR02NZLARWV5d2aPaBYN/WiAXT2vWc0Ft9yD9HJ8FYTfVHG8?=
 =?us-ascii?Q?VzaclkKt7fU0yVg7eHtmYIW3A0bjFfuIrifcGVq8D1j9hRAQaizojTwUFX0X?=
 =?us-ascii?Q?l2As1ze5mefs6NSFqokLmra2uJl7p5+6+sEPxhyA1N8wdAKo2wE8olkdn3QR?=
 =?us-ascii?Q?+7l94Cfnohsy294Oh0zYWNr2lHV/sck+zzIBNrbHMEmNscrsoOYppoV3bxOO?=
 =?us-ascii?Q?OAiamMHCBG08CKKxSyHE7vhPi/Ndbkq6qZGK3oU59xjGLwXdIhN+LpPefTA5?=
 =?us-ascii?Q?vNJnAg/9qZGJkGO2vxGL+bS/YwPJ91zz5jhYsAetf4HZKQFTqLvrXTN4cbUK?=
 =?us-ascii?Q?fsDlmecxyn7kDmq7A4zVCdxwuTHfbNCOIAlKVLwza7O6SIo3c+c1niK3wG2Y?=
 =?us-ascii?Q?SisEiwTaoWWtd3suxGje7ZrPRYX0OOWnIkBA0VaoUv2szUynu1zRnZf7v/zA?=
 =?us-ascii?Q?m7qXi/yR/6Cwb3qVGoIWo+50SldQry4TEUF8QR4y1ojrLEyg6utJizHMf/Cw?=
 =?us-ascii?Q?6MvoRHw7Cbh0BIZ0r7fpzTlye6OAgt8joWOYvwuJAE4JhUhfTO3fBjlGy3Dw?=
 =?us-ascii?Q?THsJtRKkVKUtJXrUwNOWQyMIMFND3oyTCL79QiCWwhXEF7G+h/dTzsvTulZa?=
 =?us-ascii?Q?pW0h3Fq2lweWGlSzbnAT/9gLuUzuznoTi3TkLFdR8olmAbtVLyhtW7PS55TD?=
 =?us-ascii?Q?gqFakSm7+lyNDANMfs10kgJB6FZgnDIMpycfBamqeejXD7VXT0L22lqT+tLB?=
 =?us-ascii?Q?BIXxWgnI2+tsqbLX5LDnxV6xOAqQobmY/U1uYuIRE4Ol/TMu3ZZU4EX59JAS?=
 =?us-ascii?Q?LG3ec+QFLWCdIelvnMkRVesuAxaGRi0ovKyUFaXoHeHZfw/nIG6UyIX4tAWf?=
 =?us-ascii?Q?NPDahA6uVG6VHCXyenbo8TWvSN7/sXZxt7seFbmNySn+DcPOLdBaf/mOkAFU?=
 =?us-ascii?Q?ZVPUUAq6JfNKJ4BSzK02VQvkhUTu6Iv71+uYBRGXaDwJRwBjnSSP6SUb7Wjp?=
 =?us-ascii?Q?d2ph+l4HKNotUlJjUL4h/qKJxlXcfGldml6XyWCwfrQ+hSRsdeYDZFYC3tIq?=
 =?us-ascii?Q?RgvWvGm9fVE58d5vNleSPfiFQTFgV3YIYYLcXMHeLz5ex6WXSM9S+mgHqSXz?=
 =?us-ascii?Q?4H6uVqUPIeZcnndGFRe0aBEfWsXE2khW8Kavg8ZetncS0hkRlVYYwhs5Svkd?=
 =?us-ascii?Q?5BHxVno6QJQmC4qHb17E0a2vmXrsJMmLY5xZiF3myfbnl088VCyfmKbM/4At?=
 =?us-ascii?Q?RzMj1B83xNbjmUpVDMNGHA7V9m3p2MRPUuY/PutrABR4YrfM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450175f2-4515-49fe-c3e4-08deb115c04e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:31.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2QhQJ+AFknPFgxx5t9Aw3jAMpfaQcxvrwXmzBOP6+PDtklP/S7KInI3MYmt6l0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Rspamd-Queue-Id: AEE1A53837E
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
	TAGGED_FROM(0.00)[bounces-20590-lists,linux-rdma=lfdr.de];
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

To maintain the split where ib_uverbs.ko should not be depended on by
drivers, add a new module ib_uverbs_support.ko which contains the driver
called functions that are too large or too rare to be placed in
ib_uverbs_core.ko

Start by moving most of rdma_core.c into this module, making some
adjustments to split it from the actual uverbs FD code.

This was not done originally beacuse we lacked EXPORT_SYMBOL_NS and I had
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
index dce798d8cfe67b..6bdb220f89c0b1 100644
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
@@ -33,7 +35,7 @@ rdma_ucm-y :=			ucma.o
 ib_umad-y :=			user_mad.o
 
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
-				rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
+				uverbs_std_types.o uverbs_ioctl.o \
 				uverbs_std_types_cq.o \
 				uverbs_std_types_dmabuf.o \
 				uverbs_std_types_dmah.o \
@@ -45,3 +47,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
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
index 269b393799abbc..d6656d14eebaa4 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -70,7 +70,6 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile);
-void release_ufile_idr_uobject(struct ib_uverbs_file *ufile);
 
 struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs);
 
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 31ce2e77fa3a64..280fa99860a1de 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -360,4 +360,13 @@ static inline void ib_uverbs_dmabuf_done(struct kref *kref)
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


