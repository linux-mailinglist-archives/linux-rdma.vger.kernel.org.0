Return-Path: <linux-rdma+bounces-5436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF19A1112
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F681F22A56
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68318BC0E;
	Wed, 16 Oct 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pR3QK2u/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3217CA1F;
	Wed, 16 Oct 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101637; cv=fail; b=ahTDTZU2QpqkIKXUHGfPgoQ9/CbBXGLf1dikXaxSlrOHZimytycd6Ge8QTQsmsJfrPfxu+fN+PXW2r6PutD2frr1vlMDrO7vBbqcI8cpCGHWhQWsYbugwqTvFX6tzeGtYQNftRLXBhlHruwH4ReexhvSV7teG2NBeHON1lD+iOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101637; c=relaxed/simple;
	bh=G3voWbPm6CNjmrkGhtPL12OvDuH4scNhq+snsWa8eQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cWnkzUU/ABnJ6wiEH99Xu1HzHiYmsO29Mib9/nTJhgFWrDbfm5rbjt1FuF//SGgbpbU3bFk78/MnVYK0ey7xVJrcuuBEVAR91oWKoQW3YNQMkG/CnOcytpHeKUCQgAqDOwjkRigv/A6l6rGk43R8ztP7XXL4ibxJcLe9WZtihwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pR3QK2u/; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4u1yv5KrxzNex8LNvOVTVpJUaDXLchK/mRNHZBaKOEM4PalJ5cuFeCfZ9GlOmzEhDZQpn3TB3djPdDLWa83l4ZbJWL+3t9QPj38odjdPNUNp++V7LPqAgu/1NWBFTmxdDXpcB+SvWX7WMzMyCxNDBPZo2xyF3DEYGrCQxWwmMhLHSaeCz44gSM1pu0hUbYZLCNQ/57TgkU5ng85v5wLko5KgCRc18Zv136B/6bx5AMdWinBqo8wLXGUt/BRM4KhIokumFMfgxQPOz0JK++FELGUgt7fnmMm1GTW5I5jy/BMIP2yMxqlTW0Fr3YBNpgOJIYoTJcrZsz59gUSJW5XAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKN5qXhgebMOREQhNJIy5/rJ/djtlmXdjpu8PbzVOAM=;
 b=LbDGXIxoTB4HSU6PdZDi2c9BKCR8rrwulUpNLP08gMEY3MFmFTqGTGlG4l4VnK8p5Y089tbiErFxZSlfvOIrT4G131lxPQ1bT6wxzTSrrH/vo0IroiKpirfos++ruASSLWYFbFfSDHA02P9lWv5eOYvQsl6tFKyeiYm9TBNQXmQCpOrTR+sG8g/CIGaHTArKm+C/OK44vsZUPHPUWKs9bwbxp+zj4lxOiNdZFCKfTuhPeepVz6wG2LC835NkaGzd6IL6oj6K0O/qTSMnPCXiSpb/Xy2uL+MA3+ZFTrsxndkFxhSiCNgwHnQiLMZpzSrpzmbqj4yoYo2LK64sAStUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKN5qXhgebMOREQhNJIy5/rJ/djtlmXdjpu8PbzVOAM=;
 b=pR3QK2u/C54AYhgB0lYghZO7iarHf90XUqhTH29+bqHjn8XcgpLdgXnm7d39+KoOee5PLIesriv5A9bv925aXJ/BeO4LBFwbp1VmGG6gGscDQ0ome6BxYSAC/HH0BFlgan+d2hIePR//A8PsCB6HHAkLtnbyDDnm5lAJ0GsLDGgmTq/PHV/UvXR7Pu8ly/UePzLvJdK7P4b0JFger+thIQqce/HNvETmJJfBQkhSAhC4ngTqqpMHpVG6jQ5dJTrqgY54wY77tu1BljFITgQmK/HED0olgj6BL3Ni2NYJy2O4MHy3O50fQozTL0TnDdCBcfJpkm1iVlj3F5V+3T066Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 18:00:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 18:00:32 +0000
Date: Wed, 16 Oct 2024 15:00:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20241016180031.GA176045@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KOpAfJfSG1+0Dt1Q"
Content-Disposition: inline
X-ClientProxiedBy: BN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:408:ee::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1cd31e-2376-4ab0-9967-08dcee0c6d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oflrXGifbQTHdJSJuN8o+ZWDZwY4j+rBqQEFA+N+CLjERZkczrGEazHIOuI5?=
 =?us-ascii?Q?TrWVbTv4CoKVTfNt6Bm2tZA3oP73cYsoYAO8IbsnF0DGUFFcjKSI0bFTavyK?=
 =?us-ascii?Q?MSpF80gRuClGz3B+pO8plmefT4nWGVsYIPX/Zkn+JHEIQlbOMS+Sw8tOvYQs?=
 =?us-ascii?Q?QSzf0AWu4WuXKgxYGh0iHj6TGTc1iZqgsry+YI48qTKQmKEwrhmKiLbkjjE+?=
 =?us-ascii?Q?ztk6ySdl9CQTHXvm2PzqTAw7mSn8fvD9OYBJWJv21K3HFR9qQNIMlfBOnN7D?=
 =?us-ascii?Q?ntrJ3Uao7ldnMPYeVEJ9Wd3ODb4KP16REg9VGlvdvIngBFvShOZ7hz8+2SUA?=
 =?us-ascii?Q?fDxQmuinSBIgBHYuSa7/qUS8bpWa6l/gWP2LHZrTe4vnqOZRgFlCUDeP4EMR?=
 =?us-ascii?Q?+qjXUg3wplKy9qShjZmNnOA+jc4hWYzRee//o2yI1li1anu49BdCsa/P84Ez?=
 =?us-ascii?Q?xsUGlFSeCCfGjSUYzl1L20DWsheHsA6+h2xOuGwwSGcy39e9HNZDrbQvpzuO?=
 =?us-ascii?Q?Niy/C9wk8FTbHk0zkaUl/LUNaFVY0nji5I5Bb3Fc4fbUASW/e6sy/iMe01vC?=
 =?us-ascii?Q?xYM42V4C4vdRTo3zQHb66Gnfnb8uskGBSIDj/41M9OfMUYte5stcBuoZMwg8?=
 =?us-ascii?Q?OU0QKmNR+QjVRKg742n4vK7u5948Cf5HOMHsQSZ5ckMzNiDBVrLWDgzlwOHY?=
 =?us-ascii?Q?4YU6mg7E/xOVkZkbmMIgtd433+k2wR9lq7KWvsytnf8L46w+cmN2yUNm3fHm?=
 =?us-ascii?Q?ag8jaSkgHLDyEDXvzTYDMWmyG/tdnhe97en4N//vWCEDW916DY9ElJ+kqQB4?=
 =?us-ascii?Q?mdcRu6dABrvSGqRlROeYzE1s0HJ5N6gLH+HKLywxgL8adaSV76EqY9SnGKIm?=
 =?us-ascii?Q?lbNh+w/FpImpypI8dKMZJ/60xFbElsnt4ueQaROZ3n3vMGcxjrmfwgl3le/j?=
 =?us-ascii?Q?9hc4X8d+CnZa1yXygGGoRT1EF4UyMWuLtoyrhVmq040irbI4Rrfe2V0sB8qt?=
 =?us-ascii?Q?lG6INXuBibdhiaYiC+KItbxF6PTEOEc5sXS6/ecNMP29SMc34oL2HAzipzDz?=
 =?us-ascii?Q?uqt9EsWBDeXybu+CewiME4CDLJ7pxbgwTEX4RfvNAhisaCRfu29gN8/WQwPk?=
 =?us-ascii?Q?Slg1/cB8FufXbGYVh1TUM2mO+YO/bXxgh7U79A2/wKZAzAMkR5MCEcdHyJ2X?=
 =?us-ascii?Q?xx4eeIADlehsqGywTcm1185XlAigvYDs9TiSC9tpifGqCvJNE9b9KOCHrjnB?=
 =?us-ascii?Q?qnTELKWFqw70begr8qBr8Sdb8XGq9b6lgbibVaIU7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gr6vWeO+89V63qBI4jQt9lXPUKfuw2oGldhWeoORc5BvbunirP1Yef5z6z/6?=
 =?us-ascii?Q?stJOGSInswo7EZUJ/yNovsvIbRs6YTCA4wmoR+Vh4K9egXqwtmrKpT3EPUgC?=
 =?us-ascii?Q?nsjlujajIrlMHwdgKaQjAIQg9MsuXl9abX0B1HXqTJIiSN+EpYxgeUz27NzT?=
 =?us-ascii?Q?47spCDwVvxIStQ/4ZoayyA3jiI+Mj14LhQcuOt3XufMK3o6bX/j4QVYEqTmR?=
 =?us-ascii?Q?ibDO4HqkQismj61T/EZKwt5/QAs2nNScwrjJtvG+prJljUpIhYEI4eCoBEQN?=
 =?us-ascii?Q?/8uUte0OV5e/pGqSqg5d4R6mjZP/MSwhzutru+6aE+b+TeunZ1S50rhHuPnf?=
 =?us-ascii?Q?gtdG0hW/NlwZJ6yl4oahm51jJvo+rBigkAH9ilgmBTOQvmkCWWtuiis+3dqd?=
 =?us-ascii?Q?44Gjgh7IAL6XjsGwZB+1pl6EYepvltoUKxSI2QopkP/AMFmrCHI8jbMCneRx?=
 =?us-ascii?Q?5KQHDNIavUCGxZdGkNzewtxIBdGmFpCcRGELJwElVWrPvn3At3lh5ZSD078S?=
 =?us-ascii?Q?aGy7ww1AOEzQpDPZN2pvqI3WGEyB0nrdblImtXCD9oRDNUEMfE63sMvH7ZWN?=
 =?us-ascii?Q?PrjG+To36XcNJ0VTpMF2TgoSx6iEsrcOQ9qvyg2hLWUURD84mSutT0u/RONU?=
 =?us-ascii?Q?J6RVe+8Qqr41L2/OWNsj49yIHsG7w09j8qRgIwRGlWrHEgfiBP3kPbBq9gCz?=
 =?us-ascii?Q?8C+/2mbpYjie4ziLmMP+Q3arAKj7yOf2LJzCjaPlQ3rt9jwU3PvXCU02mi71?=
 =?us-ascii?Q?3aJimVVjqNQOn9rS7PAscXQGGIwmJphhLnveIoc2Vm3iQQqzCif7T+s2OM+v?=
 =?us-ascii?Q?HkizhVPqJBeidkUYhgCzI7fEFEHQKpWHc54gmooUIlcNKruAh3vxi9yOhlSu?=
 =?us-ascii?Q?/1q8mIjP3oZjTjRCeOgewSConsYsC9w25PRnAgs9cPFGYkt1WIQNjeMs/skh?=
 =?us-ascii?Q?FL5LT02SndCjdOUwKzN/4HNSQwVJKO0EfItZmrHCV/CaTdbIyzTDHKQFoRtH?=
 =?us-ascii?Q?mGg4T70bY6EF6DmPLoHxC+/6YCn5K/D0Lh3CxjFwlqfvRQt0f75r0L4nYilt?=
 =?us-ascii?Q?MTlkiPuc9+F87f3ZsHWxgRZLv3aj8glXwm7Lw/4ILoYKjNCk/sJK8g4vCqqA?=
 =?us-ascii?Q?4ayQbn3ftcbyOXxaURLjLqbgk/LVxSZ7mV2hcx278AEdTjqgTqg2sAByvbxV?=
 =?us-ascii?Q?YGRVNYpXSXI8li0AjirtRPCPglaodScUmpdtAbIZ9zTPcPkJbvd8feqRje+B?=
 =?us-ascii?Q?/5TAppNTyM4okB9AH2LXlAbz1PZgBeLIHWfivo6C2nYDl8kTkdCzU2oXeVCO?=
 =?us-ascii?Q?5cm9kPAEIVqRq2ON3MmytRaduAf2YETQXqLHzRQMluAIeM+r4DnxKyVykOtX?=
 =?us-ascii?Q?kkLMSlTILoer+4ZOv0dcb7BmUi8sQ8cgQhn7k4sMFAOmA1qAU9bYRkNR6uGS?=
 =?us-ascii?Q?kKPYc1j7Y9/STKHix5xokU8E9Ue41UA5FxSWfpTAVt4CYM0919EPRbdo4vHI?=
 =?us-ascii?Q?RdCo3INB4kBS8Nmx5JHTTWh4eWTEIhcF2ROmE7wLdanfQFzZiX1n9LBBHxtV?=
 =?us-ascii?Q?v+vW2rHtA/HBUb9LAjo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1cd31e-2376-4ab0-9967-08dcee0c6d8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 18:00:32.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaoCeUSQHMsOFl+54Tdsi33M474uoUoZCzrbejVKI4YjuOvp3Yt8wa37udUkbzim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544

--KOpAfJfSG1+0Dt1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Collected rc patches so far this cycle. A lot of bnxt_re activity,
there will be more rc patches there coming.

Thanks,
Jason

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to dc5006cfcf62bea88076a587344ba5e00e66d1c6:

  RDMA/bnxt_re: Fix the GID table length (2024-10-11 20:49:02 -0300)

----------------------------------------------------------------
RDMA v6.12 first rc pull

Several miscellaneous fixes:

- Many bnxt_re bug fixes - Memory leaks, kasn, NULL pointer deref, soft
  lockups, error unwinding and some small functional issues

- Error unwind bug in rdma netlink

- Two issues with incorrect VLAN detection for iWarp

- skb_splice_from_iter() splat in siw

- Give SRP slab caches unique names to resolve the merge window WARN_ON
  regression

----------------------------------------------------------------
Abhishek Mohapatra (1):
      RDMA/bnxt_re: Fix the max CQ WQEs for older adapters

Alexander Zubkov (1):
      RDMA/irdma: Fix misspelling of "accept*"

Anumula Murali Mohan Reddy (2):
      RDMA/core: Fix ENODEV error for iWARP test over vlan
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Bart Van Assche (1):
      RDMA/srpt: Make slab cache names unique

Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Chandramohan Akula (1):
      RDMA/bnxt_re: Change the sequence of updating the CQ toggle value

Kalesh AP (7):
      RDMA/bnxt_re: Fix a possible memory leak
      RDMA/bnxt_re: Add a check for memory allocation
      RDMA/bnxt_re: Fix out of bound check
      RDMA/bnxt_re: Return more meaningful error
      RDMA/bnxt_re: Fix a possible NULL pointer dereference
      RDMA/bnxt_re: Fix an error path in bnxt_re_add_device
      RDMA/bnxt_re: Fix the GID table length

Kashyap Desai (1):
      RDMA/bnxt_re: Fix incorrect dereference of srq in async event

Qianqiang Liu (1):
      RDMA/nldev: Fix NULL pointer dereferences issue in rdma_nl_notify_event

Saravanan Vajravel (1):
      RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the max WQEs used in Static WQE mode
      RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop

Showrya M N (1):
      RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES

 drivers/infiniband/core/addr.c              |  2 +
 drivers/infiniband/core/nldev.c             |  2 +
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    |  6 ++-
 drivers/infiniband/hw/bnxt_re/main.c        | 47 +++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c    |  5 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h    |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c  |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c   | 21 ++------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    | 11 +++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  1 +
 drivers/infiniband/hw/cxgb4/cm.c            |  9 ++--
 drivers/infiniband/hw/irdma/cm.c            |  2 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c       |  2 +
 drivers/infiniband/ulp/srpt/ib_srpt.c       | 80 ++++++++++++++++++++++++-----
 15 files changed, 133 insertions(+), 61 deletions(-)

--KOpAfJfSG1+0Dt1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZw//PQAKCRCFwuHvBreF
YcHgAP9Ctw6p0PHAXEt/IWq2DqMyA9v7Ppy0oYcfBhKvO5wkLAEA0oh6ecdAZTbE
g4mX24x/WCnZXQA1O0bjnG8FwqfHWAE=
=pu2i
-----END PGP SIGNATURE-----

--KOpAfJfSG1+0Dt1Q--

