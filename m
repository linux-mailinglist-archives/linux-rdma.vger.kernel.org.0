Return-Path: <linux-rdma+bounces-21179-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B1aOJjwEGo+fwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21179-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9C5BBAEB
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4114C301B15B
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFAB17BA2;
	Sat, 23 May 2026 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q4P0UhnT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9DB640
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495060; cv=fail; b=WA0YAx9GJjZPvN82mgQOGpo/MJ7AoyPRydv1Y81JiXSeh4X3QQMgFb5Qr9fiQfl17mjhH8gArdiMFCRVLqn2xn89qREMrRDAaWGjMEz4RBEPIsb4AaaISN6cj8Yj3c6lYXk0/alv5wfm/h4lbBiRhMqpjOqdFOpX/2+gxoS68wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495060; c=relaxed/simple;
	bh=jphQrTYGq6QHj50h7HUqDZBtEmSmasP0VDDTNauVxoM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EbJefOrj8r/GwBN0T8Y9Dbv3fPcgiAsH1Lh8RfdtSvNiaKd8IXCbhGptkxYSRetXc7tvlSGdQapr3NcWwOAmsAhEyxGUFCDJJWjPyVgOZzXPUM5DRV6EmmFyCjdjV8DiuI2NT0C3LSEodw/A5i5+/M6DPISq639O+U1qWCV/ZDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q4P0UhnT; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB2xhnmh0+ic73gDTwzU/4ITMcKouaKj6NAA501+pIiYTGigdchbnQHfhPfoPD+g5j42OYuUHU9fseKqgJPxPyOFGH/U7ZsTAH+lDPv/Sg1SyPN3rl3kjjowjngj7D9u8m4SQVP/pfpOIvsDSZJ5/a0osY9VQAi3T9WPXq+3MboSgNUaVDon+mMWNlgGVRKTmUV/kteeFXWkmIbZGcdD1UW2mDB7i6OLGfitICiJ7S2cO6WIMhLLpbsUoet08ivzFQn8xQJZlceqpgkWy7NJQm8q9MUNTaQZ4AMwzestZ/9szYnN1XMQs2jIrMMLoTbcZTQ8Wu833hLo4Q5FTNmP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUVG1LGPjVC5VIIWF2p7IKX2Dc2+t+EKGhsfOQxrW88=;
 b=NbqOwg3e7gGkxk60EJcpHp1fubNCs+TVnjeLRp394+LWxdbFLKEleXjDffGBYHKQziqYI/pSLuU4xqUPuh1ze1rMCDv9ieGBD0xCBMfjLPRgS+fwAvXAR72iS06cyOLF8ltmT526bWai4NEfFc8rzhgFJFlBatk/XjX76LvsT7Khcuho3vGd3gm9XXdt9mGTL391z0UTcOHyNBThmdwliBrQqTJRyMk6AaCSoz6Xown0569tN1fztWjjFE5e8Vy90SAvAC/rdEv0H8rmgYVCpQyrgIXnCG+CIdmoDOo/OWdVHEv9AtkTeoSH0OXxds0d5l4XgJUB4WKqNho7Cii99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUVG1LGPjVC5VIIWF2p7IKX2Dc2+t+EKGhsfOQxrW88=;
 b=Q4P0UhnTspi9HG2IvTzA7ELep2QPV9yL3HX4/aOaUY/AEQf2a9/Vzb2gApsJRNW1kBiFVztTq/m3owP/1kqgV0x5IvJ6PvAHSnnawtJwxh+Kx5O1ye13wnDpZ1KuxUmuTBu7sPxjEnH+h6XEVjPByu1V2JmvOMinvKo3jhl2qQdfpQMA+u9dPSiyXbqBM0Ygg7RHjsFRwizvqal6ylCCh7HOZARkTp6POEB98fNIlvbPN/yTPSb6QKLE4HC1ttuc+p3eze2UrVFDZf76Z+fuvLFIy/4OYI4bgeTaE/Vo9kxo1q6DtIeUmvEtljUsbm5WwzzWySP5iW+WayKHOf3s6w==
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
Subject: [PATCH v2 0/6] Remove driver dependencies on ib_uverbs.ko
Date: Fri, 22 May 2026 21:10:47 -0300
Message-ID: <0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 9206d44e-2129-47ba-6092-08deb85fc185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	z9MOkcOj/f/iJg2K3BetoJTq2Uygr+3F+bTwfXf2nMuoKfdfEH7aN3J1oL78QA9I+nnA217skmOBk3MBBVhKgr1kflQNEme8YquVd+TgfrHrB5gxcY4hPvz8x9GHdQxuSEIKv61DbL3EYcNFW9Jm+ORwJLCVkOFgrb2YQPR6VW3jkmmDj34ipRLLSh2tyHCjIVfbyhYX1g7nLO5djQrimM5Nai2D50w9SI+e/Uz0+1UySzBQbGVF+uUvqGWmAJCde3mRB9EZ45IV8hhLw/90TVaPGlJmESyC0mC0TxOujJ8XyeWVp+HYCknzHvWHNLp9SHTMuU/0TTjrRIj5UQAWFP9cj61HVWv6k6R03DyXYfNV83njOSrMREr4N6NxQzHbBrtdLwQE5onaFSnvM81kI1ICD+ESnnRr/5dCAC//T8yyhmXKqVbjW6aE0TjBJcLH9GU6/ma+n7yf1rrpKnlKZTonQ4ygpjkMaOIhVyyojXX+Dfh4EoQXgru0njOe/A92WTNXCmMRc1L+SMVEM8rPDTwXtHBswFN/7AOYXO/DNBwt+5ubv2CiNPxFrB0sumXxwHkjB3wWy5mnRt+hXjo2YBcJV8p7uEhKr+soGHPPXqjXjkSsvB4+LmreS/8GIE23vEido0eGq3iNaaKxtIZmbpPeaXiLbrrOFdrHDBCE/dv96yW+pvCNZ3crp6QgbVdSj1y7xxV9y2Mk5J35t5mdEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIM8YbGqlwm3OAiMjkL5iow9SSysHlx1D56SiFEh9Am7MgMwZWD+hsGHQNpL?=
 =?us-ascii?Q?4Ez4nnVaLLIMa5/76MLX8sMoNze0SqRIQsd8G35DrntadillULMjHmyPjKbG?=
 =?us-ascii?Q?FtgUaYtFgu/h/JwdoSnCNtT/G115vPm07XfuicOCQPPOL9FohsMAVvLkvSV+?=
 =?us-ascii?Q?PvdHaQ00PzuLkvzXxYftULynpyRg/rzJVQMxXyNo3L0t84zHOpJ322QcjGbZ?=
 =?us-ascii?Q?yjTMxb1pPn0qTSAg/MmzyzPPh1lnqnVznq0UM+E3n9UPU1Nvif3qh5Kkc50l?=
 =?us-ascii?Q?+oXg4nNr2StdOocg/6bVtXU8SEDyZoWFsGf+TbKuT9SnRR7dP80/Sz9noLJv?=
 =?us-ascii?Q?9pEXeHJIElvUXwCn4kYD+qzq2YcJVxyo6xm8M6lwKWu7R/ikNsrt9PSWtIlC?=
 =?us-ascii?Q?SHabm5ah9QnH8pM2m/Zen2oRXdDcTtKdCt9RlT7UD+f9w2bpVxSxhdijw2j6?=
 =?us-ascii?Q?7cgFgoTrnZ1LCVDY5YZpOYakDeMjiJgeZCaf4JuyQCT0MvfShagwPD5Y7nu3?=
 =?us-ascii?Q?JEzp10pkMPTSwskQksLJG2F9gQDzkoO4AEBFGyLyFsd1fSe8oGQMWhVCMS/s?=
 =?us-ascii?Q?S3JRSw2jWnkSNZ0IKfDstP5Fc5ABX7V5BPf2ZoWuJmF9TmPIcRfL1oiJsFcU?=
 =?us-ascii?Q?c0pmv272nfx063BLnHkRpSvXf2kCt/lI+LxL/iYMAK/ZHQGfyfY8oWHDIEE6?=
 =?us-ascii?Q?EQvzic+jfH4uwdLq+IHFCE+y/420y2lJIvWUb0aJ13K6EYZYa6Kf3G3EDAkM?=
 =?us-ascii?Q?0O0roluEBxY48Cfn8ompi9N6qeF0NcvkpzbTmWj1u54mgxs3OqMskuR672On?=
 =?us-ascii?Q?HzlWLEplrEwyakZb3GwSSQATTZ1yu4+W57wsqJum3Pn6UqGZmhhEdgooTl24?=
 =?us-ascii?Q?DN2dpO1C4zwMN5Aj9ofS2vEzJuTg4sF1RU5rWcKwl8FZbXS0V9IyW8KU/rYi?=
 =?us-ascii?Q?IT9XNFTQpIuOaDFyfXHr/fsM/MIS4hb4aMKbllwjSD2VUZMr18tsrrbZv8Bp?=
 =?us-ascii?Q?0JYgBtMhawbPsPBDMwx/4gaIr3A/v1M3e/crJb3M/Rt2nmWFsqgqpfMEISyH?=
 =?us-ascii?Q?mcF0Rve0Xkl0eOovJ1ltE+DlJURYRh5mie0SMyXirWrH/iPHJwpAIYMiIWgW?=
 =?us-ascii?Q?HwaJsW+LNyi4tlnzVRc4soyVbXii7U3hQ/AWyeoiy2HrNmxALPMhgDYqCDBW?=
 =?us-ascii?Q?I2oh7egItrn95AdKrkXPTdyFHRPAXC1Kg/22t90vGtDlbylSjsWJCNfw4g/y?=
 =?us-ascii?Q?E4QpO+syPZx8FYGLIvpFnjM/NV0fS4OajRvf5MZU0Kv7qolUXqGJpR8a3cp7?=
 =?us-ascii?Q?H+JwuJhokjf2HlI2LT0LyRFWID9c3yzaX3DBplI+/oqLd4X/WqDM5UyxmDc2?=
 =?us-ascii?Q?iIxK9hXemzKgrVWOPb52UtDKa55Q7VfjPXWcWNvLdn+AAtN4VdUoUQUE0tT4?=
 =?us-ascii?Q?iykBBPcQ9lejEAxKvK+++ArkzQXA9lIhCQ+EWws7ZjW7NikDZHsvuM/z9apS?=
 =?us-ascii?Q?AJoxJ4g/GjJnbnTbwA55kESBb27OC0yvCR5DLaAD6XcXW4kqDodF5ednCCxS?=
 =?us-ascii?Q?WCM5RmOmTk0jUY0BoB2HJNVGOyLPjxV+Ag/zG8o32wM8/wCCFw5CpBo03FJX?=
 =?us-ascii?Q?KD1vTTJW+bNuFmOOy9KTzJ69/mXcFNJHns1qQf+fffo5TsH2BusIUj8GCbVr?=
 =?us-ascii?Q?L3NhOFDDjfzKRJQkexk+rJbzX8cpoEp5Jx9eAAiBn6cevWvd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9206d44e-2129-47ba-6092-08deb85fc185
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 00:10:54.3533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWaPjvuFjjN+T15ExGJ2nvfiHOPYhXRl2hr4LFSs2RdBJZDm4Cy41VxKpIn/I6oi
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
	TAGGED_FROM(0.00)[bounces-21179-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 60B9C5BBAEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The original design was for user facing modules like ib_uverbs to be
independently loadable, if the user didn't want to have those char devs
then they could block the module.

This has slowly gotten degraded over time and right now every driver is
depending on ib_uverbs.ko. Fixup everything except
rdma_user_mmap_disassociate() in hns by moving coding around and adding a
new module ib_uverbs_support.ko to hold the dirver functions without any
of the uverbs cdev code.

After this series mlx5_ib and bnxt_re will use ib_uverbs_support.ko.

v2:
  - Rebase on the rc branch
  - Fix ucaps module mistakes
  - Add a patch to not build ib_core_uverbs.o without
    CONFIG_INFINIBAND_USER_ACCESS
v1: https://patch.msgid.link/r/0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com

Jason Gunthorpe (6):
  RDMA/core: Do not compile ib_core_uverbs without USER_ACCESS
  RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into
    ib_core_uverbs
  RDMA/core: Remove uverbs_async_event_release()
  RDMA/core: Make a new module for the uverbs components needed by
    drivers
  RDMA/core: Move ucaps into ib_uverbs_support.ko
  RDMA/core: Move flow related functions to ib_uverbs_support.ko

 drivers/infiniband/core/Makefile              |  16 +-
 drivers/infiniband/core/ib_core_uverbs.c      | 226 +++++++++++++++++-
 drivers/infiniband/core/rdma_core.c           | 150 ++++++------
 drivers/infiniband/core/rdma_core.h           |   4 -
 drivers/infiniband/core/ucaps.c               |   5 +-
 drivers/infiniband/core/uverbs.h              |  25 +-
 drivers/infiniband/core/uverbs_cmd.c          |  76 ------
 drivers/infiniband/core/uverbs_flow.c         |  78 ++++++
 drivers/infiniband/core/uverbs_ioctl.c        | 204 ----------------
 drivers/infiniband/core/uverbs_main.c         | 127 +++++-----
 drivers/infiniband/core/uverbs_std_types.c    |   6 -
 .../core/uverbs_std_types_async_fd.c          |  22 +-
 drivers/infiniband/core/uverbs_uapi.c         |  13 +
 include/rdma/ib_ucaps.h                       |   1 -
 include/rdma/ib_verbs.h                       |  61 +++++
 include/rdma/uverbs_ioctl.h                   |  13 +-
 include/rdma/uverbs_types.h                   |   8 +-
 17 files changed, 579 insertions(+), 456 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_flow.c


base-commit: 5b74373390113fba798a76b483837029ab010fef
-- 
2.43.0


