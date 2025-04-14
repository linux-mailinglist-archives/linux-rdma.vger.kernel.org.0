Return-Path: <linux-rdma+bounces-9409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35CA8812B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F633B8C4E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81182C374C;
	Mon, 14 Apr 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwS+RxP7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E002BEC3A;
	Mon, 14 Apr 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635987; cv=fail; b=VzVIg+bQEiHTgqxl6YpSHc/40kTA0qg99dx4Q5k/7OhGqnbbNydrGgnR9aOuS3412ry+DvoColP6YJ8s0TeOxUWo6aHYU4cQX/HoU2Qbfwc8hCd1gMn1w1Wh20LO9/3vAK4QekV1h5WgP8KtsrzruEKjQtHBCvJdHsSYMsR/Gas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635987; c=relaxed/simple;
	bh=u29CIal9zxvtZUwYQgFD4LWtEALUGe8ZlMJTeK42U3w=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IT62MoVtnl4UH/uDVx3nHoNSUhFVFS813Db9stxSjVxqlH3YgUqXFwroDUrO3uh35AARn72xKt7WLOwG5GZegiVXfSu/2pLo01oIJc9HKPO0GfA56AycBdWlJkfbhYdZiFR2rE+eE27xRyQtdKAdz/pz/SKyMCG/EinTp/lR36A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwS+RxP7; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMzDQ8M3dhRSB7xdWGu95B4b4crQqgia8NcSUUI93EE8Xf9R4155J8+L2IheH/eJ40oV6WBCqXzyCsLGginSACfyH5PrqlexZc2q3qK9PWZ4izzjVMfG3yP5uwkEHkAMzNed8JXXY7PFwM4mqt7EyOHvCTXtyQyQE6nLT+kYjrZdLRu2t1uF3S51nyc/MDxaJ038K0x1FjYVF1Qgcn2EpLrbS2zA39O7WQDK7uHgWThH9pFq4fIkcJrajM/zZrqnHtLwLDufPnwNsIJ8rbPm+ZMiI+ZtpWZvzPj169URVzE3wdZlgoJFkGQSk8G9gH8WArTF8ZHLKD5gUIA9CVXnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDdLC2r9LEhRDlVx29ejfXwciLDvhW4QSUcD4DS34x0=;
 b=br4tkKjARI3TlwXfhRRzD2ZSzykmud+xfDlfTFxtOKl/arp3MuiiSSZjekirjURDHlcXMjQUEJo/PaaB/uSJtjiZqCoCRHxxbYFe7zVKoDZDWR25Rxx4czzupKofB1sxjzkdmZxVBn2mtsZTKMl5TQ2Ss9+uZjGW6TBFXyy5brsafOynMj6jumNDTWPZ5jICwrex/weziKEtrxlspwrW7/dfUj6cXbb1xVdMHDsxu9gjTWSDrr73KEQ2otBmgaBTuGNlPk/2Z0PJYc58u76j2KtAyGWizWLSgJ03skn09lSXO2q0D/LzVstDUuLqzV5EIDjh2v5LUc4oLWCngh4qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDdLC2r9LEhRDlVx29ejfXwciLDvhW4QSUcD4DS34x0=;
 b=UwS+RxP7Uv1Oei3z1fVJ+v+1cFI/nRjhmDJg4JxggvoF+yo8Ijck+3RWb9M9YDhffYB95s/NRhVAb9e1IX+6d7YJeKtR/oPRHSYjxFFrRMEbg4oNL+p6mU3PZbxdNKjuu3kE6vxKY8fkdGq0QdBevINL1zRvsEP/H0xfxHsETVdGLlCw+l0ufEpXmq9wmAtavn+h6XyAP+GSUhoO4lRz4KSauktYdkp3wVMS1WVg5lAUk8hzCOA2K5QRXaRZY+p9q2ZIef7k/d6TMnBl5CoSKBD8cXS6wduH2Yv0yBTbkCkT0T/YB9nIPm2EdxPQmygxPfevFM7uypazp0/wvOA44w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 13:06:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 13:06:23 +0000
Date: Mon, 14 Apr 2025 10:06:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250414130622.GA399879@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WqPtcm6UamhslFgw"
Content-Disposition: inline
X-ClientProxiedBy: BN9PR03CA0470.namprd03.prod.outlook.com
 (2603:10b6:408:139::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 128a0951-4ec9-4964-0b3b-08dd7b55280d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TkyNQEOA2tn+IpdHko15vyQzc4G2r+KtNcvT1idHge9bIVyZ6xX2HnY1O93J?=
 =?us-ascii?Q?UYTVTKqcxf3fot6RJBAar7Th3HD4rzsXxRvCOZm0f7E7s/pI1UsAp+BZ0MZ4?=
 =?us-ascii?Q?j/LB2iOEeLMfwh3ZYHC7BnnmVZGYQ35moCSqLvIOIZR+c9Wpu3x4q6Rp04CM?=
 =?us-ascii?Q?H+3LrO1xpsdLLGIdt7rve0U5JIkZC77ddRbIFtOMFBciG3uv76dXcgcXaEoz?=
 =?us-ascii?Q?+rxv/e06JggnHA73Bn9oz25e+bdXTkRzr5zu4BJLCaxJESgGKd9Sic/UDM5r?=
 =?us-ascii?Q?IYYTro+kft+rjCvEizxA/JeV2g96Ke0mwP9DQjTxa2xCsI/zTZkYQSVv5GgC?=
 =?us-ascii?Q?UupMM/aWWKK3kxwxrX5aFU+zhoAXObk11z0sz0o1hpMjIaM6vbfLQ2BbRis1?=
 =?us-ascii?Q?u3LsRBohfdedRXivHWkUC+xLLuWpi5gfTO5YTd5uICDiyTJBkjZ2YILtaETo?=
 =?us-ascii?Q?pE0oeJz8Ozzc0BlcRJLbVpqkCDm55zV5EB3z5CBbroc+lS2lBLg7zC1cZyIJ?=
 =?us-ascii?Q?BPjtjLQBBNtx2WyqcIn8oLDJmf7wJOLx/Z+5H0eonZzwZuPz275obUOQJORr?=
 =?us-ascii?Q?ZDmp92p/svL8ix4g3oSWZ54mqnSiaQkTCIwfwDkz2DBs9nX9s3fC39Hxqeht?=
 =?us-ascii?Q?5ftFolTHtBsRSk6OUobxER/uw4FrsG6nCohlFR/PPgqkrbwd0IVe4otwsEjU?=
 =?us-ascii?Q?08xp87YU1/ShBHwk0tEjs3Z8HFapNvr/zDCPxSMnbfSK+CBCqXWMvqGtO2Ly?=
 =?us-ascii?Q?8uYD35c6dlmVZdc2UKhXjKQ/sGUAXM8hNYK5n9JZmTJqBbBsVTud4HAQDqEW?=
 =?us-ascii?Q?Eu+JJ8/Nam/Ycq3sseiiUQ8WdUbGOFqPiBJuI1Dy81cYx0Vfh3I8LXdNhKPa?=
 =?us-ascii?Q?LsBBwlsUFTD+8yjShDC8eEiMWfYajS11AtRfAkoSHL2hr5qy7afZS3nQAZZm?=
 =?us-ascii?Q?HoH26Doar3AraM6II18v9y0n53q4ot2SIzWdOLU1QP7wKRlXu/1JJsWVu9zy?=
 =?us-ascii?Q?cMP3nkn20oh7RKDXw2GA3+7pevzR24m8hqT/pMS6d54jIkvah9UXy4jRN4MA?=
 =?us-ascii?Q?QpfJR6vucIOxodMZSOOcd+gtXDdeT7cpcByHnn0WMHb0lH+Jhpbobgl4MlBO?=
 =?us-ascii?Q?evTyH0iJqI0MJ+ZByOwaUvdHfKq+sCyxBH4mdCLxK2T2zjr3NgiIKJuuJhwo?=
 =?us-ascii?Q?ImLcr/P2uSitSAnbMEYgagFxIrNuspecjDXDHD/APkEswN2xM0kcrXr6REAT?=
 =?us-ascii?Q?8au4m5AYH/OhQSKOgO+smmPF4zdgFJp/mhztVkYXepgS26A1Hkyx3qva/Ehs?=
 =?us-ascii?Q?9QKW3/y92AMwhs2yLa/uDtxRfjMbNB1NgaNu1wwj7VFDO5Uz5mLcaw9RzDCA?=
 =?us-ascii?Q?jKr5Bkzjk4WiMgNzdElK/46hxKkgf0X5sFUL6cIggZhxZz0CO7/s2SAhhClE?=
 =?us-ascii?Q?W+Qos51mKyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7ZhBG1TyOvtIDzLtvpQX1sVnJDMA+hImns5vvigMMr/KSDTyA80hDxc2lih?=
 =?us-ascii?Q?Oi8kQOkYbvmOhGPHcq4FSCCgzwzLtfoXU5OAyS2DFdeWnlD6TqumHmqwRKUD?=
 =?us-ascii?Q?WeAqzQsrhQWkGEYzAkVgmbI0HuxUy267Jh2lAZjgJwCpmjl7yDlJYteo/RsS?=
 =?us-ascii?Q?a0Zs+koH9X/VUI5xXw74Ds95Gu7a8CY4xnYFK8gbY4ZArAe99WPh7nCSf6gl?=
 =?us-ascii?Q?ilEd1I1d1hWBHallXi6YuJpbd6NVEn8GE0KrX322gH49k7+hgAAB6UUP+f1G?=
 =?us-ascii?Q?WXAAOzFbc1kqdYjKSQo+Ah9Srog5sLSa9zboxGGhWMhEpb0tQYstmU03P8bX?=
 =?us-ascii?Q?hCSQNdwgADBSdwua0MDB4L6ZmA3D9scF6oC8LDxotIe5mf+4s47GEm24U7dc?=
 =?us-ascii?Q?DEr1W5+cohDWyXUmmDFK7o582lizdlD9hxwUcUWmVxbdDIntsooeqpP2O0HI?=
 =?us-ascii?Q?YMsDwh1a/vWJCkAtfJGHgMXTnbvOaA5l9ODI9UrjW5DPPb5otBDCFECJK9C+?=
 =?us-ascii?Q?fQ3NP62X3PH+tFMevHEhDJCm+xpLls14Bvfo8ujSXI/L4HX+jwzRq+umhXyb?=
 =?us-ascii?Q?cWxZ5fYKpwqVLcvZf3ApfBxKKEYFAQDdQvCA3iq1VUzXAfwBADT5Od31XlSv?=
 =?us-ascii?Q?TXF+YYBGA7EWBBUlYQjw4VKTzIioEmdTYs+pJ4KbMhwg3ykQfEdB+JlsTcKv?=
 =?us-ascii?Q?lhuRsyh1u0j5f260REhyF8LQQQezQZXY8hG3jfSlJlOllu7XBB/Tutk09hXJ?=
 =?us-ascii?Q?L8KlQRWePuffMuxn8WNZK22v0LEz3UpDqt7SLlZk6vEAU7jgOeb96OMsEaA4?=
 =?us-ascii?Q?QMtdIM9aw4TjYJVAHZS0/1wI53apdgLG4bML2NVf5Rd9N+EJ8cFyXonNg9sk?=
 =?us-ascii?Q?AgB9mUeQqfX/ou7rkMzfrwJzxiYdF+xZWhoLr4E58KSf40HNSa5Hpj4rZ+Oy?=
 =?us-ascii?Q?Hw+grnDeRtF+2aZh0oeBAIdwnRu2AEu7J4lN9fW3A7X/2XSHu04SYxYgljq9?=
 =?us-ascii?Q?rVwi39QjQA47ACMcKCIGkQjiY5vJOUWQ5wZNsmgb2qPgTIPTbZB1+qYk5m43?=
 =?us-ascii?Q?1tw1d5chE4h+FeXbDWHohxFjqyczdibdcVlpCjLkiE93rY6A90Y640uOpe/x?=
 =?us-ascii?Q?+20h/fODXBUarjsjO3kGueGncqrtPPXIXKwo0+XaYhK/P7/FM8xnzTUHwl1j?=
 =?us-ascii?Q?Pk64E5THoodxRq7ApYeN0FYJvhANfNE2zB/TYtZSc7f3VcUZwqcWSUOQKbM7?=
 =?us-ascii?Q?YVw/MLdcmJPHrjTu0DvlZE4PZvMG82CkNIiAruSIKrjx1o39RMjHW0EVHd6Z?=
 =?us-ascii?Q?nQP8GMyF7ABuWIkIPCjvEd7CgDNTl8zDofY81TGj/C0F/s6J1+WK3yOewMhJ?=
 =?us-ascii?Q?SGhBcHdBoONt7+fKjH1AnhoGeumgFNrJ1dHKcAKCXvCreIYJIPk75FeFt1ta?=
 =?us-ascii?Q?5ixPq54mzpuOcOzVnOCj+JKyaTJYbK+DnC6msc62o0k/Ub6ExBxSVbTcHCDA?=
 =?us-ascii?Q?ztqWQ7qvkGZj+minRPEnIMmm7jAGrD1p1Wg1cyz+G50IP3XO2UW1ncyQ2kAI?=
 =?us-ascii?Q?d2lLeR13KrtSoVgUCMYpJGp2eWvA4MC2DMqDp+t9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128a0951-4ec9-4964-0b3b-08dd7b55280d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:06:23.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfQv0zj9Dsjuh5/Xcxxtx5pyVrq4N1kNBujcOErgIhtl0Re39JnQdFh9MkgmE139
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

--WqPtcm6UamhslFgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Grab bag of fixes for rc

Thanks,
Jason

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to ffc59e32c67e599cc473d6427a4aa584399d5b3c:

  RDMA/bnxt_re: Remove unusable nq variable (2025-04-10 14:47:55 -0300)

----------------------------------------------------------------
RDMA v6.15 first rc pull request

- Hang in bnxt_re due to miscomputing the budget

- Avoid a -Wformat-security message in dev_set_name()

- Avoid an unused definition warning in fs.c with some kconfigs

- Fix error handling in usnic and remove IS_ERR_OR_NULL() usage

- Regression in RXE support foudn by blktests due to missing ODP
  exclusions

- Set the dma_segment_size on HNS so it doesn't corrupt DMA when using very
  large IOs

- Move a INIT_WORK to near when the work is allocated in cm.c to fix a
  racey crash where work in progress was being init'd

- Use __GFP_NOWARN to not dump in kvcalloc() if userspace requests a very
  big MR

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/ucaps: Avoid format-security warning

Chengchang Tang (1):
      RDMA/hns: Fix wrong maximum DMA segment size

Kashyap Desai (1):
      RDMA/bnxt_re: Fix budget handling of notification queue

Leon Romanovsky (1):
      RDMA/bnxt_re: Remove unusable nq variable

Li Zhijian (1):
      RDMA/rxe: Fix null pointer dereference in ODP MR check

Mark Bloch (1):
      RDMA/mlx5: Fix compilation warning when USER_ACCESS isn't set

Sharath Srinivasan (1):
      RDMA/cma: Fix workqueue crash in cma_netevent_work_handler

Shay Drory (1):
      RDMA/core: Silence oversized kvmalloc() warning

Yue Haibing (1):
      RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()

 drivers/infiniband/core/cma.c               |  4 +++-
 drivers/infiniband/core/ucaps.c             |  2 +-
 drivers/infiniband/core/umem_odp.c          |  6 ++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 10 ----------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  2 +-
 drivers/infiniband/hw/mlx5/fs.c             |  2 --
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 14 +++++++-------
 drivers/infiniband/sw/rxe/rxe_loc.h         |  6 ++++++
 drivers/infiniband/sw/rxe/rxe_mr.c          |  4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c        |  4 ++--
 include/rdma/ib_verbs.h                     |  7 +++++++
 11 files changed, 33 insertions(+), 28 deletions(-)

--WqPtcm6UamhslFgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ/0ISgAKCRCFwuHvBreF
YXsdAQCMEB2oSJ0YmNQC1Sq2zndWtZRxVho/DmivQOMVL4a3oQD/f460bcAAu164
cv/lvTjvCtLeWCP+wNZwZPOQpmU1JgI=
=RQEX
-----END PGP SIGNATURE-----

--WqPtcm6UamhslFgw--

