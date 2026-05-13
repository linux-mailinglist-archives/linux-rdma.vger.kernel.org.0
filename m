Return-Path: <linux-rdma+bounces-20586-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JoUKA64BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20586-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:42:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14AB53833B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E22F300AD8E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656DE4DC522;
	Wed, 13 May 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pf1UpGpi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516CF30F806
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693618; cv=fail; b=RCmhnlxRqWjC4COZslF0xmW0UyRbr+SpZXsGNwwJgwyAQbG6h+UcGIOTPCTrS5VG1N2bUI7ewKnSuo0oBSuTaMyYiKXTFIkJpI58HGPiqhKI7U91ZA32N1lkOiezWGFOReW27HLeorrUNCBtroNJALkeiXzD0iV6j98FrLCREwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693618; c=relaxed/simple;
	bh=uretPZ9QUOL2OFKzScWZ4b2aU/Zz4/4C2KX4iV2EQ68=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sG8rPotl5jvx9vj3LrQbhhk3taTFcCFpWlrfsVgl5u/JKz/gW3f8Q/xEtWqO55o5ei0NTiFmsW/csq9rNeMcLQhNW6QggeyhpupCZmcym1VJ2+ihrdN7c5ckAFF0QO/EePspNBPQzbCzApXicE7cugLWYYmdMmxwy2ljL1beF3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pf1UpGpi; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tsx4Epzr1zDizoSDEAGQyG+nHChwMQh50uNqNLxEg2rjuCT72dFu4JWyd2iDBk/yLNcbH5Qi8dMBQwRzyQIxE61xJNK/N5Op8z5HqN3gPx4qqYfx/eDh41NiL98VZHuITq7pDE1dyDMosF7Tp8FEulVKMC/Rl3OTxSCtlY8Io09Z6Ebp5GGLqeRbt4KUiCJH9+n1R+4at7FN5fQw+4v7Gw4GhKjQ+LkflrBkNuTW8fo+vl3PGbYN+ec8pj79qY2YMzHFjuEzJnRrIZh9DtCLbjuinli8FwgyrR83Qf9KqFi0Ev/ksb2A7FyUMsn4R/WK30XKR8TpDdKhu3gi4sjuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr1z4VJ3JH2JrqpziiHpDSEPlpXXbORkueB+LkZWDLc=;
 b=rXKIwgzgNFfXWzITeoE62LVmx/dbypc+uJwxmGynt9Idduisqp9eNy8zljeJHnmXzf1sd/Y7JQk1h/cTZtvNE0BtiGQYfaWztljF73G8S4DtwQa/bGzL+ZL9QJCKc6lEssZob9LKLlU4Bo/jW9XGaso3/isqRcphhUIqE05oU3rtzZdvSyDBDs2RaFtRqFj1lkPASlVbOTg2Ly7fQdyHbMQIoSCZFzfFGqiZKpi68QQoKaWsVNODA29VtSzovTXGftn9K986quf2XE5TnpclGXAdDlxTllU26RrqkgrTKVCvMixNoLw1DqPaUYijCmP5hI4YS7xseMmtNOnbfnQkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr1z4VJ3JH2JrqpziiHpDSEPlpXXbORkueB+LkZWDLc=;
 b=pf1UpGpiXKSxx9P9lihZv1q62b6T4StLZq6VFGSi7Qb7m6+wyYgiPHp8qtD+8e+w5mFfvfwSenMmBXkfQV9tPdCLKtFN2QGirwTSskJJS0NlanD9MsEWlg350izgeB7D7q1CT9+cQcLKxpM42dMoxBRJ0agV0nGuhuI+vTwUt0Ufnot2kvriVF/AWCrClNBD+3Kefp4ks8KDJO6/hUkAdl2CAq3CBJtYvGlxdbNTi2zLJdJx9voXqY6tYSigcuswFbj+KHPX8+BEFyZiAJDswvJRmVcSo1dY9HhnrYhfd2Fh8HEL6fRLX1pTeCi7x0iejSaNym0n03I3PLT9eQkGwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:33:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:33:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 0/6] Remove driver dependencies on ib_uverbs.ko
Date: Wed, 13 May 2026 14:33:22 -0300
Message-ID: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e4405d0-9b4d-48ee-7bd3-08deb115bf54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y0Y/cnahSsGjjE3CROf9LnBWsrtv64enlH2Lnu+GJMTk1VK1T1gw9NuSgSsrK3GZucpvi63YjI2fHaRuzT17ICkAPTljZXkP5vXuhG8sTYAsIHBZRKyvtAxBiv4Z2+xzmyR5YxQgAb6Oz3Zm0EETYhLiGo5Cu8kjK1LmHeLEpMYD1x1UF731F92KJIN46b5GPmFbX9wqXMZ5kSBt4prLnND71ujpuvp7ju63BWH0ao3UnikJO5Jc9/+AvBnlsMTB41ytfvFFlisU39vNZg7q3O4v6D9t/HMpkmUuD54Y2RKYZbikzxp9G4MjFX+C7UhED1T69QgahgzgAv2asdb7lLhn7sSarn/osJNJvQFsHZWeeCJov0SVQDFCQ11agWZgXibh3Ys5GyUc3mNjpxtJmzgkKmFa6EDmxbuJBaQCrhqnXyYs8JeBVmKlEH0TptSW0md8p29j4FU77Ls2ABPyyqrFSFGC+tdbp3/Z1D+gnM0nUfa+/nA8fRuEmMyteLxzIVZQRaW6Gcr87j1kCasqFh9RfpFjaztET0RHUd0eFygh6Z8b6rrQfSykNqUdPmVh+FPZK9XbQm2/JM/hy5BMPv9AZ7sIOQ42ZOzobxmOJDB9MlWeL5lzB5TI5fmknNB9DJmuvje+cLfDZl8S69x2GmgjCyll1ptcXsU0qz+Vu0alxYsCHg9jBD+EfigFLmRZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GfkzP/PJNFuQ4E/BBYgRPe8MM7lOqzkg7ziBHIOcGxapcbr3hZ3kSGGF55zn?=
 =?us-ascii?Q?tWM/jVat6H6bfkg/nNvqXMgaOdj1uNQTbKj+2AqSpcvegtZxzfILeGS1b7NF?=
 =?us-ascii?Q?h41N2nwhH6Sl9GnAY7ZA1x0OEKI/jkF/agpure34Q4B9CQALSLlq5AG5cshV?=
 =?us-ascii?Q?sms5BcrekFIPW1BO/0iXPTYCdUKO/70mHsrGr8pcWB/BhaUKOil8JAhEGC/y?=
 =?us-ascii?Q?9zDqMXv2uurShImb231icaNGULem6FkF0DgWmrWPfCMvzzRfn9iX78TZ491r?=
 =?us-ascii?Q?x7Tbun67SoX6ZprWYBe45Xw+WTSRtTHJOpJ0zpxbEGiW7zjgyorI1hi6a6wi?=
 =?us-ascii?Q?P88sMVUH0spv9NOohQl3KPtjXIgghXAaYW1cDnpqQq1YVHVd3khW+6N4jg92?=
 =?us-ascii?Q?Zj++h5o7EPnnlDnuFW6012rQZG2qF1aqq4xjPCG1IUxVTizGYkxmTtnz6FWz?=
 =?us-ascii?Q?LfstdB9bPfCvNHczhJixuw6kJUIIWSrZEbcJDcIXsjuGdYyJNik1koabdu8B?=
 =?us-ascii?Q?mzTDwcrc5RY0fC+VU16Q09oEB/KszMjyFbqIQxQQFPcb8rkC+jfRid526mK4?=
 =?us-ascii?Q?B7Z23F9MarYK/pUS8x6OQrjRxPYUEK0xENGG/ZFh++1hbdJ5gFiw8PwapzGc?=
 =?us-ascii?Q?a4Q+y07aWOdk/yO6jUSqG8dr/kVNGMQ/1AdCMjFZfbYQD2coQDrSLNc2yhFY?=
 =?us-ascii?Q?k7cx6+n2O6FPI/AIb+cXCXZ3uDdB70J0ozU2Ze4TV0YyfG6FCYktcBTDBTF/?=
 =?us-ascii?Q?fWha5r6+duLDMvgajHkYbA/6Phl8/RFK/Juwgs6V1kujO1YE7YJDKMdydGJH?=
 =?us-ascii?Q?HpvtY/zyOJdyPNyNLBvgXFKIRea4pdRw/h9E8xtbudMbJuux5Z4SAqqkeLMm?=
 =?us-ascii?Q?CYACon5UiAVoSereA0YEK+1HdCZKOV17/sojFAy9CRbQ2uxbWpijpOZNRxfc?=
 =?us-ascii?Q?5RVEJG1F+zKcjChNjCDUiVcwUUxpOvDYrZNnsOMH2bWKdJo0ABDs9ewPjz2x?=
 =?us-ascii?Q?SBNH4So9KEzx0WnnYQGH/foJidQx6Ef0V5yUdcBEwdm3o8kCfwCeBSIvSjOl?=
 =?us-ascii?Q?GyJrDFjjVL3jlut5Qf3KMF/S1Wz6yMQyh0xktY3HzlZ37O4vS7JDGgVHA6qI?=
 =?us-ascii?Q?OAHejJjQE3Z5NslqzIiiDqRkanPP5ALVtOJtKOoTw8V+wKb2WspR/iZ+H9hc?=
 =?us-ascii?Q?gUA4y1a0RrzbEDMPKSWr3T3GnByv1RiaEWQE9h6mtd33wy0kk4v3niNdpb0s?=
 =?us-ascii?Q?8+kqNo4ZgKBvf0dqQgtrw6Pu20eNVzDUNUUviGlta+MJQQ4P1+Q/b0fyqjGT?=
 =?us-ascii?Q?Spm4WV8N6r/kLSqJCl4q/puwtYp1lG9CU/FLbqn5mXOpDSr6zct/xNncSSre?=
 =?us-ascii?Q?GK77rv0ezg5VtpQtbVqvpqjoSTztzZCuUENQbjnhPd4zMuRhhbXO7bxiAq1j?=
 =?us-ascii?Q?d9QBHYRdtzcZEXwMv2WSlVEoouiZ8ML5aDKGPGr17rHwH05tQMyIwUA1WR3Q?=
 =?us-ascii?Q?iQj1x80NLVwiG+KFr+iEdwNB1l4gRcJ7tuAb3sqQDq9wxSYrr2fNUqBpG3sb?=
 =?us-ascii?Q?lnEjxWcaRx71xao1MIZo2fV8BO/nd40/u8eiLeZA9JrasdFTokoUQzdPNL9b?=
 =?us-ascii?Q?e3uUQbXnan3BERXFd67vR9X3VXhbK8MlJHGgH+uYduFeflv/V3/xY05MSFVn?=
 =?us-ascii?Q?TQ/qABXqxcJtFPG79bSZpbkXratDVlpRwaznpGu9/1UkI7rb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4405d0-9b4d-48ee-7bd3-08deb115bf54
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:29.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jc2Nt06vM1+1e6fXLPweCYauzKBvoLGE4kOeitWVnciWnbkFTA7DApbA7LoiRXl6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Rspamd-Queue-Id: C14AB53833B
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
	TAGGED_FROM(0.00)[bounces-20586-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

The original design was for user facing modules like ib_uverbs to be
independently loadable, if the user didn't want to have those char devs
then they could block the module.

This has slowly gotten degraded over time and right now every driver is
depending on ib_uverbs.ko. Fixup everything except
rdma_user_mmap_disassociate() in hns by moving coding around and adding a
new module ib_uverbs_support.ko to hold the dirver functions without any
of the uverbs cdev code.

After this series mlx5_ib and bnxt_re will use ib_uverbs_support.ko.

The first patch should go to rc

Jason Gunthorpe (6):
  RDMA/core: Move the _ib_copy_validate_udata* functions to
    ib_core_uverbs
  RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into
    ib_core_uverbs
  RDMA/core: Remove uverbs_async_event_release()
  RDMA/core: Make a new module for the uverbs components needed by
    drivers
  RDMA/core: Move ucaps into ib_uverbs_support.ko
  RDMA/core: Move flow related functions to ib_uverbs_support.ko

 drivers/infiniband/core/Makefile              |  13 +-
 drivers/infiniband/core/ib_core_uverbs.c      | 305 ++++++++++++++++
 drivers/infiniband/core/rdma_core.c           | 150 ++++----
 drivers/infiniband/core/rdma_core.h           |   1 -
 drivers/infiniband/core/ucaps.c               |   6 +-
 drivers/infiniband/core/uverbs.h              |  60 +++-
 drivers/infiniband/core/uverbs_cmd.c          |  76 ----
 drivers/infiniband/core/uverbs_flow.c         |  78 +++++
 drivers/infiniband/core/uverbs_ioctl.c        | 326 ------------------
 drivers/infiniband/core/uverbs_main.c         | 127 +++----
 drivers/infiniband/core/uverbs_std_types.c    |   6 -
 .../core/uverbs_std_types_async_fd.c          |  22 +-
 drivers/infiniband/core/uverbs_uapi.c         |  13 +
 include/rdma/ib_ucaps.h                       |   1 -
 include/rdma/uverbs_types.h                   |   8 +-
 15 files changed, 628 insertions(+), 564 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_flow.c


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.43.0


