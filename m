Return-Path: <linux-rdma+bounces-12547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E546EB165BA
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4750118C7C76
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8012E0B6A;
	Wed, 30 Jul 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sj91vzyc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74733267733;
	Wed, 30 Jul 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897532; cv=fail; b=hhwR7pDfvkd0Nls6PFRyeEFyCipvxiqQ6qMRXqqaY2UTtbY6Vp6vvD/nTuAOzS5CQafgn3w9LDqHkWHCLWpm3xYwn55CT7e1TimqWhtA0mgBEsvT6NVIWcx/fRFcV4/6Ss6CreCDf4HHGXKnSoDhfU9hnauYqvf9qw2E3K8PZtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897532; c=relaxed/simple;
	bh=ojvr0JI9rbZMU0fzZP1OjAbNFfWfYeGMiGG70LiJ+5s=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=O7apvZrQmhTF17zInl1kLjiWNsJDQiGKFy8ZbK6uaQpyGPca0ZGFALiliSjt+Z+tkay9MElkXeSHhH8TiOAg8C/sOGMg37ViUBVE4HKYQxCE+d6LpAsJdxAUXpZm0oeF98ycxkieuRqIsQ3bwUyXKINAb6Z6GmTlb8NZ+n4Bvzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sj91vzyc; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiiZ0iI3jJXo7iwnjxCzhZjZicBy5r/AqG5oodYsgnWcnc7hiAVMBmHbRT9fX1u0EcLqvotWU64dl6oJ0hw9D4lT/+LevNFGXloqlaViHpYR2NNAt/x3bKYUB5JEzLk6NjBnwhHkZogJHk8aUQiK8QK8BvsNpA9v5i8NKX4zoasrad0e/2Uh64K48xPWQy83kw/rcdO4eNLULFh86armWbjtv0P8u+sFXs/unBljJusJyIcQ9q/IWoXJzpJRLdQ3YzAH2GnbuWRsTPwrtXISacRcRRYAFffePuhd2KmAmf7d0pCku0RRhyPVECN2h9ZR0j21fz7ng0dhFQIupicLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRPfBdSc49L5I+xgYvDY51c++uM9qu0MXkv4+wSv30w=;
 b=tJ0wD0UvAjdc+I3OT72wnbFzZIaHG8JYFPt4eb7Ocw32xdt9AMiZcobjmqA5SaGLiTVf1HNQ808D7qS28Bje0bWQQchsV+fN8NtK0ifnm1TKDUmoRSf0KzYN4AJA72JfoGkdSXEapsE/Fm0mO/er90aKBb0p3fGq6G8Fy7bycK4EnrtWlzigQv9BKp7YwvxSHoW2SaKgx6Amqq+fd5mUr8M48xKnqKBtlvj6bm/UIp500SPQZz8cBFwTxR8Gdp59slQDu4d02GSSCHDX45P+0sLYUSelbXMwVlxu3qLv5tPcOJnjaY8/82m+WsZuZpS6Gd73fzmm7e8XEK2QQNcHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRPfBdSc49L5I+xgYvDY51c++uM9qu0MXkv4+wSv30w=;
 b=Sj91vzycFcpYLpA2lgyhPvsrSPBU9P0+iY6fwZbEe+t3yY93qkysVjiJKhnoSGixb+o28G8gTL3lU/TeQp0L7mL/efrwFEUK5BjE27A4EC5v+TnWas/J/8gkrVyw9uGjoTEru55EaStuXAA3GwC3+RttKqC5kP8IBvw6OPA0ZVcNWDzN2MeVh/nUu5mryxWfYMetyLFeCGVdoxjpjMUUVD29RxArBW7hZbeREv9gMyVBMbzN6O/TgWsUzMylTCYH6LJqAno5lAEtOfciwbaFRGhOMY1mGrlzaAVmAcWFSnj+wn0/omVRkRrZ3bl13SKeoWNjWtPwsK8lHQuPIV7R6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 17:45:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 17:45:25 +0000
Date: Wed, 30 Jul 2025 14:45:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250730174523.GA152963@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxwz9qI/HlrWS9Hk"
Content-Disposition: inline
X-ClientProxiedBy: YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 15db19b4-450d-412e-3644-08ddcf90dcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pulkFNpSPwKddMR948cEH25yt0NeDaEUynLowqrnjFfXStMn60rpjAjQ4pj3?=
 =?us-ascii?Q?zRkjsU+Z7vk0TUgHLPRsILEAEzFs+6ImRENQCQ0C9ykEap4AFZ9ZtbdK2fHq?=
 =?us-ascii?Q?51RbBrlV3pwuIH9enEba240hlIEBUe+YwW6e0TKOVQwmQ3MnfKf4yFo62bKG?=
 =?us-ascii?Q?twaGk9qpwtc/j1M21DqBuFXtUdBCU9u2hDFHLbxUssjsSgf49dB7u/TDzT5J?=
 =?us-ascii?Q?CmNUqbaWYQq4Zvrc9tbNWZOKgSYz5P+Qr0Ck8MHNjxT7kbhW40BsZ9XFbZ4y?=
 =?us-ascii?Q?nyM/YoKqPz48dXZBkYnafWUEnFdUxDLAK3TtO67FQiKFqCqIx6kyGqOvKTlF?=
 =?us-ascii?Q?5jaO/lIkaUYY4MD0iyBIWc0GxzCL26bjLvAufveIUmRl0bmjHCF5aNmcp7i3?=
 =?us-ascii?Q?Z3xZlV1Pu6a5xQuapMIq1OIFlcvsZVpjPNYVezlCdUdw/g/F0J0qFv77bmdP?=
 =?us-ascii?Q?5ijxqVBdGnX3DbeLCSj6g82YrbPzKF9tm0Yax1mr6tyvt1DYyKHvZc6ZFUm0?=
 =?us-ascii?Q?FyGqpmMzGT2/hgA+ZylE7GSHxpVjDVVHXOVGVU8EWzn+KjmyhkVfSoNnwbSh?=
 =?us-ascii?Q?LN2a0tLhE3Z8JgWdBrqWxcR3luoUovWEsJ8j3jcBYLj8WOifFW5uFjJEwST6?=
 =?us-ascii?Q?/uYukIOuyuGztwE3daXwPIYHDuXd9kFilEXYG24QxBdw8f0Ti2EJshWQWudx?=
 =?us-ascii?Q?8Mhd3ophfMkNhJ/rkXMODdU4nIexlgVcDUFCYs1RvVuWlEV1EfGWX7VIfNf+?=
 =?us-ascii?Q?f9MIo18veZ6HWjFvo95s+7YBqLqUW3q5Sm+82sOzRPR4HYX4DOp9/xF5jRii?=
 =?us-ascii?Q?8V5Chpvdq1hRuZtAFetmmGR+wBwwV+/ptLJQXrACbhhv8pJmHtJR/e5btcso?=
 =?us-ascii?Q?aLjFA9loI9ObRTKAfGCJVDjkrcM306CBbsMzVCteA1ydDU+mJC+88PpiOVOU?=
 =?us-ascii?Q?bVgKswaBfc7YbVYSSYeCe0KxdCsRd/GOkiGkh0VQfCVW8k7TLHCvNOrFXZeb?=
 =?us-ascii?Q?B1N0zgJ/gCFZUzTOALLJ+J6//Xvmr3bv+yzUO91/6dknOWYcmE9kbQEC92+5?=
 =?us-ascii?Q?khPUIp+Wsl8JBdgN0ed2C8A3YPlUgEcbJO7tB82cb7R0Qmw3vj3uWRgrhL8s?=
 =?us-ascii?Q?1rw28a5tingtDImwUCynvYHmkR9rgut6wsJQm2vVVeEk6lcGUEyQGzSG1F4C?=
 =?us-ascii?Q?RktcMQr4MC/+57Afb/zBcBrRnui4BkWVzlb16auE1HHjOFKZz6Q5NSmFz1lf?=
 =?us-ascii?Q?4tNqIRwjQdPXh89TZ19Ryuq7Qbh8VSrLjElJ9419hM6MYT5iKEL6tuuYNinz?=
 =?us-ascii?Q?ku81aLBRqJEDAcsQr2ejbUAwchreqcERCF6DUDEfn9t2fqp/rNSLVNcbkmkX?=
 =?us-ascii?Q?3Q/S3BRGOMHqgXCTYJFAtzr2LYQKGoUuI8UtwdSg/ESLgPsaIYmjqAc4ZrUu?=
 =?us-ascii?Q?ImWUJ997DvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2EYjSVJy7Yo+omVsiyYhPMoY7/9CNYkLIV4rhcBeyrObIqKM1t9lcg+Vv+d9?=
 =?us-ascii?Q?sTgFTjIT8N6v8OuiQveT9GWmp5fUkZ+w67QgDazN9bjt/LRRf7vWFaNvzDdH?=
 =?us-ascii?Q?LvFBzwObIM6egFgjuMN+1BAMKfIVSsJpInC4RQ+qMCUov74OkNFl7QOal1A2?=
 =?us-ascii?Q?nDvyO3NEq5BKZvWIUuIdd/IpMemlq83BXV6y1TgQ4VcPioM1iUH8pLIlewnU?=
 =?us-ascii?Q?7q5muJso9S/Y38InUvQgTCIVQKGrYGQMdaShfKl3WD9h2hCNa+B2CAQi/iOw?=
 =?us-ascii?Q?Bp18iR/49KDOkHwQDcBnm0nWBVtRRlomGJVoxFYUhqSsDrEwIXSet31a0isd?=
 =?us-ascii?Q?pY0nNe6sJ/NKjdnbhATEQJC4lAF7kw+vUzLwr1fce62MgL234vtOZpbo00C+?=
 =?us-ascii?Q?9NTTLoiaVglxciT9fr4N7SQjUkwQBQA+R2b3qN3piddbYAYnSX3KUrWSD/zG?=
 =?us-ascii?Q?fZwfGLZC7xyZJpWpPbT27QR7g4QfPriy9V6u4ZxNpJn4Sf6OBJjOlIDTwLCv?=
 =?us-ascii?Q?3iZSZLFfDcsF61aeha/yER3T71xCy1oE6TojqHJxddvtqY4JbcH89w0zdH2u?=
 =?us-ascii?Q?d5I3N77jyt4aLx2yyoviuD8qPljISYPUedvmTktBCuJGullTQvLAqCAsJVsY?=
 =?us-ascii?Q?AZ2dezdbgH1kIFRnB4XSUKZ4maJHhT2nMFRyg/t/I5RpUTtXudySkNqED1ae?=
 =?us-ascii?Q?vECU+crcTqtOqFAjK5jveUi32zTS8H9yjWIu8XeMwmFHQC8TsBNMyhgDDZLc?=
 =?us-ascii?Q?hi05lHzMtuzsZo+tp/6jsxMgPAoRwWzdbN3jfkCi5Cp/vlIIi8csDeKsch/O?=
 =?us-ascii?Q?uxuIKLWQJPFp4MQvoYT1zvhcyNNc0SNn+cGtAjqzstQuyD2H2ZQ9HRGLNft3?=
 =?us-ascii?Q?DSN3uTPnVsuIKNYXT97lIt1GizyHiL8ppMjqDc0nVP1fmjvJK/MQ5ONlaV8E?=
 =?us-ascii?Q?qY6lizVCerrB1wJk0grTgiMFqUD9pBsr2w7TPXdT0qLan66RGOb2k74YB4Co?=
 =?us-ascii?Q?PfQ1EM4bDxCR2peccbI96rCRNf1xlaZwE9zNDtwClN532zFNdFcdWxNiNfLw?=
 =?us-ascii?Q?Gs5zgT8WzqaoVJmRi7Mx3ArDMp/vBrMu/3vXaTnSC1Zad1YLX5UdpVKWX+Fh?=
 =?us-ascii?Q?VUU3WiEpeY4uubbiTWaxEZXH+0LDkM8SN/b66lO4x/VNaWavToS/6bavI2QZ?=
 =?us-ascii?Q?T1E6MnHrMRCrv7V5fbAr0qHO19FxiKELSoVdjLDdKpObxJt6BJctxGCB5ff0?=
 =?us-ascii?Q?L0lnRlX1a+KsEg2b6eik/+ZIdbTwAy1vKwIs2teLDv6m04c3RIKhUsKRHMkn?=
 =?us-ascii?Q?0VKJaWlPX8CsfjrKtaqdRdx33Mi83kVdooqhKAx/Oa3WgG7i720jz89g7BJl?=
 =?us-ascii?Q?IPFuV482y2Xm5vmmGFHadLU7k8ZFb3RnyfiP1J8Khpu2qyleSWqeoBeBu365?=
 =?us-ascii?Q?CUwr5v8qF1ffKAUw1GjGBLBiF8k3mgQBZ2TbHuHVYMx4zIbOAS7t50m5H8kY?=
 =?us-ascii?Q?pCP1PTjpCFCy5jxZ+qAD/sXFOT98GhE2eV8196+MoF14qIWH0OS9sTRE/EsB?=
 =?us-ascii?Q?oHas2uL8KA+H0+LZHes=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15db19b4-450d-412e-3644-08ddcf90dcf7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:45:24.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FW6XCpGK+4OsGFWgqvzOIQ7F9SOeXQJoYcXlgtcH+mT85kGow074hN9GE96O3UUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

--zxwz9qI/HlrWS9Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Usual basic set of driver updates. Some common code improvements for
DMA Handle, MAD flow control and namespacing.

There is a small merge conflict, resolve it with:

$ git rm drivers/infiniband/hw/qib/qib_sysfs.c

Ther are now three new drivers on the list, hopefully some will come
through on the next cycle.

Thanks,
Jason

The following changes since commit 9a0048e0ae14cb7babfd459ec920234e8a2ab86e:

  net/mlx5: Expose cable_length field in PFCC register (2025-07-20 03:02:14 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to ee235923d205c6de73bf5035f3cdcaee22f3291c:

  RDMA/siw: Change maintainer email address (2025-07-24 03:20:47 -0400)

----------------------------------------------------------------
RDMA v6.17 merge window pull request

- Various minor code cleanups and fixes for hns, iser, cxgb4, hfi1, rxe,
  erdma, mana_ib

- Prefetch supprot for rxe ODP

- Remove memory window support from hns as new device FW is no longer
  support it

- Remove qib, it is very old and obsolete now, Cornelis wishes to
  restructure the hfi1/qib shared layer

- Fix a race in destroying CQs where we can still end up with work running
  because the work is cancled before the driver stops triggering it

- Improve interaction with namespaces.
   * Follow the devlink namespace for newly spawned RDMA devices
   * Create iopoib net devces in the parent IB device's namespace
   * Allow CAP_NET_RAW checks to pass in user namespaces

- A new flow control scheme for IB MADs to try and avoid queue overflows
  in the network

- Fix 2G message sizes in bnxt_re

- Optimize mkey layout for mlx5 DMABUF

- New "DMA Handle" concept to allow controlling PCI TPH and steering tags

----------------------------------------------------------------
Arnd Bergmann (2):
      RDMA/core: reduce stack using in nldev_stat_get_doit()
      RDMA/siw: work around clang stack size warning

Basel Nassar (1):
      RDMA/efa: Add Network HW statistics counters

Bernard Metzler (1):
      RDMA/siw: Change maintainer email address

Colin Ian King (1):
      RDMA/mlx5: remove redundant check on err on return expression

Daisuke Matsuda (3):
      RDMA/rxe: Implement synchronous prefetch for ODP MRs
      RDMA/rxe: Enable asynchronous prefetch for ODP MRs
      RDMA/rxe: Remove redundant page presence check

Dan Carpenter (1):
      RDMA/rxe: Fix a couple IS_ERR() vs NULL bugs

Dennis Dalessandro (2):
      RDMA/qib: Remove outdated driver
      Maintainers: Remove QIB

Edward Srouji (1):
      RDMA/mlx5: Optimize DMABUF mkey page size

Junxian Huang (5):
      RDMA/hns: Remove MW support
      RDMA/hns: Get message length of ack_req from FW
      RDMA/hns: Fix accessing uninitialized resources
      RDMA/hns: Drop GFP_NOWARN
      RDMA/hns: Fix -Wframe-larger-than issue

Kalesh AP (2):
      RDMA/bnxt_re: Fix size of uverbs_copy_to() in BNXT_RE_METHOD_GET_TOGGLE_MEM
      RDMA/bnxt_re: Use macro instead of hard coded value

Konstantin Taranov (1):
      RDMA/mana_ib: add support of multiple ports

Leon Romanovsky (7):
      Add multiple priorities support to mlx5 RDMA TRANSPORT tables
      Merge branch 'mlx5-next' into wip/leon-for-next
      RDMA/uverbs: Add empty rdma_uattrs_has_raw_cap() declaration
      Optimize DMABUF mkey page size in mlx5
      RDMA/mlx5: Fix returned type from _mlx5r_umr_zap_mkey()
      RDMA/mlx5: Fix incorrect MKEY masking
      RDMA support for DMA handle

Li Jun (1):
      IB/iser: Remove unnecessary local variable

Mark Bloch (3):
      RDMA/core: Extend RDMA device registration to be net namespace aware
      RDMA/mlx5: Allocate IB device with net namespace supplied from core dev
      RDMA/ipoib: Use parent rdma device net namespace

Mark Zhang (2):
      RDMA/core: Add driver APIs pre_destroy_cq() and post_destroy_cq()
      RDMA/mlx5: Support driver APIs pre_destroy_cq and post_destroy_cq

Markus Elfring (1):
      RDMA/cxgb4: Delete an unnecessary check before kfree() in c4iw_rdev_open()

Michael Guralnik (1):
      RDMA/mlx5: Align mkc page size capability check to PRM

Michael Margolin (3):
      RDMA/uverbs: Add a common way to create CQ with umem
      RDMA/core: Add umem "is_contiguous" and "start_dma_addr" helpers
      RDMA/efa: Add CQ with external memory support

Or Har-Toov (2):
      IB/mad: Add state machine to MAD layer
      IB/mad: Add flow control for solicited MADs

Parav Pandit (9):
      RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
      RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
      RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
      RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
      RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
      RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
      RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
      RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify
      RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA counters

Patrisious Haddad (2):
      RDMA/mlx5: Add multiple priorities support to RDMA TRANSPORT userspace tables
      RDMA/mlx5: Refactor optional counters steering code

Selvin Xavier (1):
      RDMA/bnxt_re: Support 2G message size

Shiraz Saleem (2):
      RDMA/mana_ib: Add device statistics support
      RDMA/mana_ib: Fix DSCP value in modify QP

Thomas Fourier (1):
      Fix dma_unmap_sg() nents value

Vlad Dumitrescu (1):
      IB/cm: Use separate agent w/o flow control for REP

Yishai Hadas (8):
      PCI/TPH: Expose pcie_tph_get_st_table_size()
      net/mlx5: Expose IFC bits for TPH
      net/mlx5: Add support for device steering tag
      IB/core: Add UVERBS_METHOD_REG_MR on the MR object
      RDMA/core: Introduce a DMAH object and its alloc/free APIs
      RDMA/mlx5: Add DMAH object support
      IB: Extend UVERBS_METHOD_REG_MR to get DMAH
      RDMA/mlx5: Add DMAH support for reg_user_mr/reg_user_dmabuf_mr

Yury Norov [NVIDIA] (7):
      cpumask: add cpumask_clear_cpus()
      RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
      RDMA: hfi1: simplify find_hw_thread_mask()
      RDMA: hfi1: simplify init_real_cpu_mask()
      RDMA: hfi1: use rounddown in find_hw_thread_mask()
      RDMA: hfi1: simplify hfi1_get_proc_affinity()
      RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c

Zhiyue Qiu (1):
      RDMA/mana_ib: add additional port counters

luoqing (1):
      RDMA/hns: ZERO_OR_NULL_PTR macro overdetection

wenglianfa (2):
      RDMA/hns: Fix double destruction of rsv_qp
      RDMA/hns: Fix HW configurations not cleared in error flow

 .mailmap                                           |    1 +
 MAINTAINERS                                        |    8 +-
 drivers/infiniband/Kconfig                         |    1 -
 drivers/infiniband/core/Makefile                   |    1 +
 drivers/infiniband/core/cm.c                       |   47 +-
 drivers/infiniband/core/counters.c                 |    2 +-
 drivers/infiniband/core/cq.c                       |   12 +-
 drivers/infiniband/core/device.c                   |   47 +-
 drivers/infiniband/core/mad.c                      |  468 +-
 drivers/infiniband/core/mad_priv.h                 |   76 +-
 drivers/infiniband/core/mad_rmpp.c                 |   41 +-
 drivers/infiniband/core/nldev.c                    |   24 +-
 drivers/infiniband/core/rdma_core.c                |   29 +
 drivers/infiniband/core/rdma_core.h                |    1 +
 drivers/infiniband/core/restrack.c                 |    2 +
 drivers/infiniband/core/uverbs_cmd.c               |   13 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   87 +-
 drivers/infiniband/core/uverbs_std_types_dmah.c    |  145 +
 drivers/infiniband/core/uverbs_std_types_mr.c      |  172 +-
 drivers/infiniband/core/uverbs_std_types_qp.c      |    2 +-
 drivers/infiniband/core/uverbs_uapi.c              |    1 +
 drivers/infiniband/core/verbs.c                    |    5 +-
 drivers/infiniband/hw/Makefile                     |    1 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   10 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |    2 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   28 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    3 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |    2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |    1 +
 drivers/infiniband/hw/cxgb4/device.c               |    3 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |    1 +
 drivers/infiniband/hw/cxgb4/mem.c                  |    6 +-
 drivers/infiniband/hw/efa/efa.h                    |    5 +
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   17 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   53 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |   11 +-
 drivers/infiniband/hw/efa/efa_main.c               |    1 +
 drivers/infiniband/hw/efa/efa_verbs.c              |   91 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c          |    9 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h          |    3 +-
 drivers/infiniband/hw/hfi1/affinity.c              |   96 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   21 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   18 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  134 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   16 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   32 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  120 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |    4 +-
 drivers/infiniband/hw/irdma/verbs.c                |    9 +
 drivers/infiniband/hw/mana/counters.c              |   78 +-
 drivers/infiniband/hw/mana/counters.h              |   18 +
 drivers/infiniband/hw/mana/device.c                |  120 +-
 drivers/infiniband/hw/mana/main.c                  |   13 +-
 drivers/infiniband/hw/mana/mana_ib.h               |   30 +
 drivers/infiniband/hw/mana/mr.c                    |    8 +
 drivers/infiniband/hw/mana/qp.c                    |    2 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |    1 +
 drivers/infiniband/hw/mlx4/mr.c                    |    4 +
 drivers/infiniband/hw/mlx5/Makefile                |    1 +
 drivers/infiniband/hw/mlx5/counters.c              |   30 +-
 drivers/infiniband/hw/mlx5/counters.h              |   13 -
 drivers/infiniband/hw/mlx5/cq.c                    |   19 +-
 drivers/infiniband/hw/mlx5/devx.c                  |    6 +-
 drivers/infiniband/hw/mlx5/dmah.c                  |   54 +
 drivers/infiniband/hw/mlx5/dmah.h                  |   23 +
 drivers/infiniband/hw/mlx5/fs.c                    |  121 +-
 drivers/infiniband/hw/mlx5/fs.h                    |    8 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |    3 +-
 drivers/infiniband/hw/mlx5/main.c                  |   13 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   99 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  116 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   32 +-
 drivers/infiniband/hw/mlx5/umr.c                   |  301 +-
 drivers/infiniband/hw/mlx5/umr.h                   |   13 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |    6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |    3 +-
 drivers/infiniband/hw/qedr/verbs.c                 |    6 +-
 drivers/infiniband/hw/qedr/verbs.h                 |    3 +-
 drivers/infiniband/hw/qib/Kconfig                  |   17 -
 drivers/infiniband/hw/qib/Makefile                 |   17 -
 drivers/infiniband/hw/qib/qib.h                    | 1492 ----
 drivers/infiniband/hw/qib/qib_6120_regs.h          |  977 ---
 drivers/infiniband/hw/qib/qib_7220.h               |  149 -
 drivers/infiniband/hw/qib/qib_7220_regs.h          | 1496 ----
 drivers/infiniband/hw/qib/qib_7322_regs.h          | 3163 --------
 drivers/infiniband/hw/qib/qib_common.h             |  798 --
 drivers/infiniband/hw/qib/qib_debugfs.c            |  274 -
 drivers/infiniband/hw/qib/qib_debugfs.h            |   45 -
 drivers/infiniband/hw/qib/qib_diag.c               |  906 ---
 drivers/infiniband/hw/qib/qib_driver.c             |  798 --
 drivers/infiniband/hw/qib/qib_eeprom.c             |  271 -
 drivers/infiniband/hw/qib/qib_file_ops.c           | 2401 ------
 drivers/infiniband/hw/qib/qib_fs.c                 |  549 --
 drivers/infiniband/hw/qib/qib_iba6120.c            | 3533 --------
 drivers/infiniband/hw/qib/qib_iba7220.c            | 4596 -----------
 drivers/infiniband/hw/qib/qib_iba7322.c            | 8475 --------------------
 drivers/infiniband/hw/qib/qib_init.c               | 1782 ----
 drivers/infiniband/hw/qib/qib_intr.c               |  241 -
 drivers/infiniband/hw/qib/qib_mad.c                | 2450 ------
 drivers/infiniband/hw/qib/qib_mad.h                |  300 -
 drivers/infiniband/hw/qib/qib_pcie.c               |  598 --
 drivers/infiniband/hw/qib/qib_pio_copy.c           |   64 -
 drivers/infiniband/hw/qib/qib_qp.c                 |  454 --
 drivers/infiniband/hw/qib/qib_qsfp.c               |  549 --
 drivers/infiniband/hw/qib/qib_qsfp.h               |  188 -
 drivers/infiniband/hw/qib/qib_rc.c                 | 2131 -----
 drivers/infiniband/hw/qib/qib_ruc.c                |  314 -
 drivers/infiniband/hw/qib/qib_sd7220.c             | 1445 ----
 drivers/infiniband/hw/qib/qib_sdma.c               |  999 ---
 drivers/infiniband/hw/qib/qib_sysfs.c              |  731 --
 drivers/infiniband/hw/qib/qib_twsi.c               |  502 --
 drivers/infiniband/hw/qib/qib_tx.c                 |  566 --
 drivers/infiniband/hw/qib/qib_uc.c                 |  521 --
 drivers/infiniband/hw/qib/qib_ud.c                 |  583 --
 drivers/infiniband/hw/qib/qib_user_pages.c         |  137 -
 drivers/infiniband/hw/qib/qib_user_sdma.c          | 1470 ----
 drivers/infiniband/hw/qib/qib_user_sdma.h          |   52 -
 drivers/infiniband/hw/qib/qib_verbs.c              | 1705 ----
 drivers/infiniband/hw/qib/qib_verbs.h              |  398 -
 drivers/infiniband/hw/qib/qib_wc_ppc64.c           |   62 -
 drivers/infiniband/hw/qib/qib_wc_x86_64.c          |  150 -
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |    4 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h       |    1 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       |    5 +
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |    1 +
 drivers/infiniband/sw/rdmavt/mr.c                  |    5 +
 drivers/infiniband/sw/rdmavt/mr.h                  |    1 +
 drivers/infiniband/sw/rdmavt/vt.c                  |    2 +-
 drivers/infiniband/sw/rxe/rxe.c                    |    7 +
 drivers/infiniband/sw/rxe/rxe_loc.h                |   12 +
 drivers/infiniband/sw/rxe/rxe_odp.c                |  192 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |    4 +
 drivers/infiniband/sw/siw/siw_qp_tx.c              |   22 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |    7 +-
 drivers/infiniband/sw/siw/siw_verbs.h              |    3 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    2 +
 drivers/infiniband/ulp/iser/iscsi_iser.c           |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    5 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |    5 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c   |  164 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    2 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    9 +
 drivers/pci/tph.c                                  |   11 +-
 include/linux/cpumask.h                            |   12 +
 include/linux/mlx5/driver.h                        |   25 +
 include/linux/mlx5/mlx5_ifc.h                      |   14 +-
 include/linux/pci-tph.h                            |    1 +
 include/rdma/ib_umem.h                             |   25 +-
 include/rdma/ib_verbs.h                            |   65 +-
 include/rdma/restrack.h                            |    4 +
 include/uapi/rdma/efa-abi.h                        |    3 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   36 +
 153 files changed, 2869 insertions(+), 49167 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_dmah.c
 create mode 100644 drivers/infiniband/hw/mlx5/dmah.c
 create mode 100644 drivers/infiniband/hw/mlx5/dmah.h
 delete mode 100644 drivers/infiniband/hw/qib/Kconfig
 delete mode 100644 drivers/infiniband/hw/qib/Makefile
 delete mode 100644 drivers/infiniband/hw/qib/qib.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_6120_regs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_7220.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_7220_regs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_7322_regs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_common.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_debugfs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_debugfs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_diag.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_driver.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_eeprom.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_file_ops.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_fs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_iba6120.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_iba7220.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_iba7322.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_init.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_intr.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_mad.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_mad.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_pcie.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_pio_copy.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_qp.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_qsfp.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_qsfp.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_rc.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_ruc.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_sd7220.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_sdma.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_sysfs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_twsi.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_tx.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_uc.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_ud.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_user_pages.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_user_sdma.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_user_sdma.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_verbs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_verbs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_wc_ppc64.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_wc_x86_64.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c

--zxwz9qI/HlrWS9Hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaIpaMQAKCRCFwuHvBreF
YRdgAP9C3tr89BRHCdFvmq3z/7nooacbI4byVdC62QK4WO/JwgD/X5my54jAMKHz
16lR97c14EBXhH/GKPMkdO+ZxqQEjgo=
=v4uH
-----END PGP SIGNATURE-----

--zxwz9qI/HlrWS9Hk--

