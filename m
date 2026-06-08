Return-Path: <linux-rdma+bounces-21979-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qeJHJ0oAJ2rqpQIAu9opvQ
	(envelope-from <linux-rdma+bounces-21979-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 19:47:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A7659620
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 19:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VQlnfToi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21979-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21979-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B426A31ECFEC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C03C9EEB;
	Mon,  8 Jun 2026 16:44:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCC32B111;
	Mon,  8 Jun 2026 16:44:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937062; cv=fail; b=SO2T1jvOVvzYBfhG8MoOW2JYzOzVRV5b5eC1oluWkQ1Xw8TnpLqIiHBBZaMlrBSay9zEVghcGBMHQoe/5mGWdnq2+kQpai7eATHMUsZlxH+WdRHJpH/DDElFm384M29yBah4oXuXn2DKWuCOO+RPSle1cEA1GoGzMOcwt49lxvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937062; c=relaxed/simple;
	bh=CNKU8V2XQtYhOTNdbrSR1NEeH96+jzB0REb8TQ4fiQA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dOnH/fbs7qCy7fud6EIFSxvztDr+mVLxitMpewY2zN08bOOHZB7pNmqpP8eNO4YZCLhtmDe966fT+nbS/2sFc35fgqWjy8nYBJe3sXGLxM7vJhns1ZUJMikkgjScWc/l8J5f051xxA8LMYlmU4oacsVd0mrjOrGyN81PVal8avU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQlnfToi; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtU3jewLe5cmlis4vbrmDMcYV7H28OEiZhUJpJs0/bH74Pj5edF1nfAiZyoPrOovpuPDvHIU1bOMX+/3B3rMqWhP5O7sj9jIYtfzhfS5jnDj32mdJTnTN82+CpUM59wqGZtToBjfojVGRmh68hE5sd4qnBZcm8+a+fIdtEZ7jiFPpBzco+P8Tpc7MNnEog3dR3cZwr8PhtgRWDYSpmMsDIelZSkAdtWPBszeASi9Q0h3eOhhoklax1/Cr12f/TWdrQ5sV9FjYB8QO1Nyk9+3zhn+Oo3nvyPJLYFxXz/6DaZGA/3B+N42J0L7KaxOrIKx7QdalekAFzyxL/rYMb1kCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9X7sNRqedxSzchQGQ/O7bDo2Lzsd2NtqX0HWzAv3RM=;
 b=NqqVt9Vaj73Xlak1EdRilwIf9izrO9o1AyXKuu6iTr6zs1bfiylSu8uPcUcLvKuPb5fJkwfLjl5WqAYCZCzqfVRY4ZBdXEJo1lqq89Q2BMsb4R1ip1F283av7a9PDeYLzP594MH9+1NtifijIs/BBlK/2zzSeaW4Y9xBDAymUNARP+8sBlGjzycD8eS2XulIC65ryKaxNDPuB6WxJCae9T7+Y3zyXK7Z92RgopdHr3ysb2t++WYWqjTv7Rni62K+2YtBy0nagICgGJiDqlMGAIvPBrpSqaGQlp9Hq6OL1P78KXy6kYL9FQWXj9HTh78G2jmT6WKhpuAyWzfO6Zm97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9X7sNRqedxSzchQGQ/O7bDo2Lzsd2NtqX0HWzAv3RM=;
 b=VQlnfToiyOWOaR+7K9y3bSxRJk/uu11SFF6gtMFMCTaKounpSDdIoL0YuMZJT5E3M0MEMAiqEATcurbDMkH4lMaugh6XTSytVSF0u6aulQlNBghxd7lj64wB/jUBWStBzECwzMaPnKmge0qqA/i3kq4ig5zTZaOVbysQ2mnsn/LlRG82vz0OlipflxSAxUjLO8dlVsEOTzkVHT8GTgkCxuj/ZQ+tBCIPMS/iQIxUUmT/t9GtwxTnJyU2Fp/qnYbRUcDtj3EkdHhHVr6uo/0rx6xoethuD7jqOp7G+4sRiWvhykJNdW9m3XVAQH3C9be5dX8+hlScDlCi5S3rftbLIg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 16:44:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:44:16 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	linux-rdma@vger.kernel.org,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	patches@lists.linux.dev,
	Philip Tsukerman <philiptsukerman@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA: During rereg_mr ensure that REREG_ACCESS is compatible
Date: Mon,  8 Jun 2026 13:44:15 -0300
Message-ID: <0-v1-06fb1a2d6cf5+107-rereg_access_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0707.namprd03.prod.outlook.com
 (2603:10b6:408:ef::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: bde4dc1b-ca06-4ff1-0784-08dec57d2dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1uz+PwIL+xPYNtd9XyG/yhrcEL38z8BF8NBhFA5K8YoHC9zFFhi8M5TbKrBj3j8gEGwBYEWZ6uxmau6ZnxsMXsDTxOx5zXuAczcZz01rl3peYNJ8z9ja3CghxrxCm+zY1ar/jszeBzQDiy9YS9hRsKbEqeBN8t1+xOFZUnPIPSxDTrho4I4m2xH/KZaCJ3+AN15fY5CvqGiKANWJ3xI3SEk+ZyZvIkoEIATW5ie2RUIrncOKhZMrhBatkETzGPTF+mCHywRfiYUj2cOL3PYOPqhN4D8U4+YPPuoSEcPQ+N8bfO409noGUi12/KjDTX3OuLNvOz0tf46XSEQrBy2oG33ZfXTVLhjsi7adICm5gR28gx3Ubh8eWqcBSFiUOrzhHOIV2LFBRDVeq7bv7d52WT27WYjKxl2I8eNU6S5HMkYKxvfTQOpTlU4p3xb0fJcbM06tQhWH8XrO/zBRahMQAuuvra8qfZz9i3FEuvBKTobxJpcjVMjd2/I5LSXOeWemOZMeWpIAOS42PvoD/E2KwVkqtyl8WV+mbuZSSfgXZ+hZudnDDrHDG1BIHSdA6BGKOTl0blEVrPsIKVbxOdN25YQwkQ/qzP3Yc3sANF6qsegkVmWjzAqTGqyrgq0Xep5rK/DPWuTnqr49MgQhkGOJ5+WsJPieKJmP8f63PzmESP4A/UR5kS5nAkiIyGO6g1dm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(5023799004)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Rrva1t5eC9GBNs9xx4TOvx8zSNuIrLxwF1Yy0VrE93F9uKnaxCXjbuq9ITV?=
 =?us-ascii?Q?1pUaxSH2GTsr5KA/LRoANMA86q5WyeHVYA6tCyeD/lcTHZPbEeauvllUh1Ss?=
 =?us-ascii?Q?qJr8MV0984WN2d8FAMdgrOczjMTyIz4hh92tIbeshQIYehQaK1R7x/uDNm70?=
 =?us-ascii?Q?Kx6E8Ge/xgOvITd9cqMkcaIXcJ+OBGT/uJBwelZLb+KUO+I5u5TPH5iSY+i1?=
 =?us-ascii?Q?xjlC3QYJbAsq+Gn6IlIFXwI5xT6ineaY9083C77UFfnEXAxCRwPBmB3FyFfw?=
 =?us-ascii?Q?UY2fQmKQhW95d1KOPNf8VXbBy4DxvG1A1JfNL73iejOsxbiJQGClJ1zH07Ok?=
 =?us-ascii?Q?chrHwlGibKo5i/Mu9YdFdXJlc/sPYdDr1XluABzzz6Z5sB3DihMv1QjeExL0?=
 =?us-ascii?Q?I3lZ/4YI6dNdRmMA0iRsMSYZ6JidksA/8h8fD09tn7NlMX4ouDzVj3Mm/8Rl?=
 =?us-ascii?Q?KgZ0SXjcFFBn9NxjyyGwKjcheBdsg/X+rGBnuG1f5CX/gaw/6wnhpmkVbXen?=
 =?us-ascii?Q?yDS4Jj3QcODgrJT3vpD+hhieHeE8oSq/nQZ1h0rGOhhRTW2kZB4V3OBE3w15?=
 =?us-ascii?Q?UXrcltKZbuvGbVdENd4DKTJj673zp9Nb1ikMynz94jdLgLh+TMCU+dJlrBPp?=
 =?us-ascii?Q?4AqX9g9mFxDu3ZR21/t5dx5Wu6n2C6XksLybi+w9lGfk6JcVYEZIykURQrTk?=
 =?us-ascii?Q?OUQHszQuJLHaWEEeKt89Tl3ESBAurIaHMy66Y/BQTXcBfjeVQH+7vtCx4xF0?=
 =?us-ascii?Q?yfQCiTXH8OgbNO/FyuCu2mMt3SOidvTtCxJ9zZZdxqJMciLeiKjPDYF52LQk?=
 =?us-ascii?Q?19PefDceh9Oke88RLkZiWIGLwF63fqoyy2f/HdgwB9u0vNlqT2PDEqwUPa+b?=
 =?us-ascii?Q?35sl/WKcE81W61epVU3j5OYA0M1hLcAGJoTlWfXtwCq7X/d9aveRjAjhvgWo?=
 =?us-ascii?Q?AaLk3ZyrOgXhM6iJ6uYdRI/XTa1PxmjbgorPv4B9/UoXHv70lFpETyReFuvx?=
 =?us-ascii?Q?Dl1tAFNNXLIr6rBLAw8UUtZ4WPeayWF2wSIGErNfXvjFHEbrCTiEdOT5d+Bm?=
 =?us-ascii?Q?ASyyYW2pqEf8d0afWnuNB6nrxYK+cnvcLrv+kA3hxTbD368a907r3aQIp9X6?=
 =?us-ascii?Q?xGkqjxHasWkIZLFadKrdntUYma7URn9d20iXExVgfoKQdCXlQSQq4nuu+U6E?=
 =?us-ascii?Q?ncvfxwclY3J+atJ9+OIOoZMagP6CB0jrByW5OELvipWOHYETc2yU1bmt4vse?=
 =?us-ascii?Q?3MjjQ8351ECtRKYXcI5p7Jn+RI2bpzvaHRjBpxFLfAovp1AXEO5HCAGFaEiI?=
 =?us-ascii?Q?dreFiZ/JlpUyDW05VuQ32MLFg7RYnRS6GFkNf/HbXn+1Os0VjH+OVuwSgM6Q?=
 =?us-ascii?Q?SdlT40eZ5Go8uprT+NTkrcm93Vkp9Nu4CcJMIxPxa3bGDNBCH49RDLn2NuHs?=
 =?us-ascii?Q?yDJc9Tdp7lkWNVMQvkyB4lLqHARuyOVRjxTu6ul1ZBfx99Fetb+3oP1RaoGe?=
 =?us-ascii?Q?cCRjHqCD0FLuneK3HodO5/oDpKL9tr/SCp5j8tz/9oQHQIm+ZzU3cysEDI4I?=
 =?us-ascii?Q?tynTH+waCZdHZON9Nbho8ZjJwizOQxn+72bpxbgoOfEKnvnWZwpc+l6vlUyW?=
 =?us-ascii?Q?xMgdz+X0+pQaSXHvSbxuz8+CS2UGBg1MeNcjNX9nq/tOk8fF4FY++pmdjG0m?=
 =?us-ascii?Q?8eorD554ej+qdxQ1cxpsrEwommcFs8Lwkn+RPBB3yT8WDw4e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde4dc1b-ca06-4ff1-0784-08dec57d2dde
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:44:16.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrsjCL2PP02bQGzMtvQNrER7LUJClpELGvmvPWOqv6fR368my7bVoLJQ/PlclT3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,kernel.org,lists.linux.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21979-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:huangjunxian6@hisilicon.com,m:krzysztof.czurylo@intel.com,m:linux-rdma@vger.kernel.org,m:tangchengchang@huawei.com,m:tatyana.e.nikolova@intel.com,m:yishaih@nvidia.com,m:zyjzyj2000@gmail.com,m:akpm@linux-foundation.org,m:david@redhat.com,m:leon@kernel.org,m:patches@lists.linux.dev,m:philiptsukerman@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[hisilicon.com,intel.com,vger.kernel.org,huawei.com,nvidia.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F4A7659620

If IB_MR_REREG_ACCESS changes from RO to RW then the umem has to be
re-evaluated to ensure it is properly pinned as RW. Since the umem is
hidden inside each driver's mr struct add a ib_umem_check_rereg() function
that each driver has to call before processing IB_MR_REREG_ACCESS.

mlx4 has to retain its duplicate ib_access_writable check because it
implements IB_MR_REREG_ACCESS | IB_MR_REREG_TRANS by changing both items
in place sequentially while the MR is live, so it will continue to not
support this combination.

Cc: stable@vger.kernel.org
Fixes: b40656aa7d55 ("RDMA/umem: remove FOLL_FORCE usage")
Reported-by: Philip Tsukerman <philiptsukerman@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c          | 16 ++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_mr.c |  4 ++++
 drivers/infiniband/hw/irdma/verbs.c     |  4 ++++
 drivers/infiniband/hw/mlx4/mr.c         |  4 ++++
 drivers/infiniband/hw/mlx5/mr.c         |  4 ++++
 drivers/infiniband/sw/rxe/rxe_verbs.c   |  5 +++++
 include/rdma/ib_umem.h                  |  8 ++++++++
 7 files changed, 45 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 786fa1aa8e552b..4b055712b0d0db 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -332,3 +332,19 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		return 0;
 }
 EXPORT_SYMBOL(ib_umem_copy_from);
+
+/*
+ * Called during rereg mr if the driver is able to re-use a umem for
+ * IB_MR_REREG_ACCESS.
+ */
+int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags)
+{
+	if (!umem)
+		return 0;
+
+	if ((flags & IB_MR_REREG_ACCESS) && !(flags & IB_MR_REREG_TRANS))
+		if (ib_access_writable(new_access_flags) && !umem->writable)
+			return -EACCES;
+	return 0;
+}
+EXPORT_SYMBOL(ib_umem_check_rereg);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 896af1828a38de..25bfd3970f5b6e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -300,6 +300,10 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 		goto err_out;
 	}
 
+	ret = ib_umem_check_rereg(mr->pbl_mtr.umem, flags, mr_access_flags);
+	if (ret)
+		goto err_out;
+
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	ret = PTR_ERR_OR_ZERO(mailbox);
 	if (ret)
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 17086048d2d7fc..8cd4275328052e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3803,6 +3803,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	ret = ib_umem_check_rereg(iwmr->region, flags, new_access);
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (dmabuf_revocable) {
 		umem_dmabuf = to_ib_umem_dmabuf(iwmr->region);
 
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 650b4a9121ff6d..6747bca3067770 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -209,6 +209,10 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
 	struct mlx4_mpt_entry **pmpt_entry = &mpt_entry;
 	int err;
 
+	err = ib_umem_check_rereg(mmr->umem, flags, mr_access_flags);
+	if (err)
+		return ERR_PTR(err);
+
 	/* Since we synchronize this call and mlx4_ib_dereg_mr via uverbs,
 	 * we assume that the calls can't run concurrently. Otherwise, a
 	 * race exists.
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3b6da45061a552..fb40b44496f47a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1179,6 +1179,10 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	err = ib_umem_check_rereg(mr->umem, flags, new_access_flags);
+	if (err)
+		return ERR_PTR(err);
+
 	if (!(flags & IB_MR_REREG_ACCESS))
 		new_access_flags = mr->access_flags;
 	if (!(flags & IB_MR_REREG_PD))
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4d4891dc28846b..4cf04a44189c64 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1319,6 +1319,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_pd *old_pd = to_rpd(ibmr->pd);
 	struct rxe_pd *pd = to_rpd(ibpd);
+	int err;
 
 	/* for now only support the two easy cases:
 	 * rereg_pd and rereg_access
@@ -1328,6 +1329,10 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	err = ib_umem_check_rereg(mr->umem, flags, access);
+	if (err)
+		return ERR_PTR(err);
+
 	if (flags & IB_MR_REREG_PD) {
 		rxe_put(old_pd);
 		rxe_get(pd);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 2ad52cc1d52bdd..49172098a8de14 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -156,6 +156,8 @@ void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
+int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags);
+
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
 #include <linux/err.h>
@@ -230,5 +232,11 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
 static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
 static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
+static inline int ib_umem_check_rereg(struct ib_umem *umem, int flags,
+				      int new_access_flags)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_INFINIBAND_USER_MEM */
 #endif /* IB_UMEM_H */

base-commit: 323c98a4ff06aa28114f2bf658fb43eb3b536bbc
-- 
2.43.0


