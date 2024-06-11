Return-Path: <linux-rdma+bounces-3066-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1E90438E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3151C23CB3
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E114F9F7;
	Tue, 11 Jun 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="CRhMG4bp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B7147C86;
	Tue, 11 Jun 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130486; cv=fail; b=uqLeYgIdaZfXtdU/7mWK4bz2yV1eMGdfYwSXSwxKJogKhZwM835UXslWk/8fX9+KOiV2tNZRj3AWZ1xOt88ReoqopmBxlESAfzgpPtvSzDYbBOEwxJyBfVIa5iNR0ls0tCt7S7YV3vS6pJLENLC1Jxrwn5CLDotZaQse274ICbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130486; c=relaxed/simple;
	bh=atHZqae9kzn87AB3VAIOD/XZMyO7dUntqQvQGCcjWF8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MNFEhtbv31mcKDK+WBGnCyEqzZDTAo54YMrIBG3vzZ6vrobLI0aNXpzxPO99vrjS3TKYOi+yDt+Ji2LN3rkb3ucsZUxfnlq3sRfkFeMd33k/sOF457XhxaF3abqIBfJcrK1el2fT8zjaH8MFKYuHknrjczINpfn5tgnLYZKviYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=CRhMG4bp; arc=fail smtp.client-ip=40.107.94.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzOWC5g/sPxRb0ClOJXwN68gezB2elw9leno8e01ZNwiXmuFWdH/DkthcdR0dzAVfhOfkUrfa/88W9ArWSFewQSuXc5YOZpCzr+4xgKF3Aw9w4ImCTYeK48DBnFXOZxgFk8rJIvlZ28g7sVanCIezUVFhAD/s+u3GGp+x9A9R6cEzfejRxZ1fGAsCNMRVznEB8qORm1uDnH7d8NyvC0O1OEaycUShoMKYdd+eD7gC9xaASktuz9KSucXQp/9por7cseGMOwWlUG8lovKN8sAwMSdhV70ARFxy8iv5BXc93lbzgZ+UehvXl7QxpCR+u7PyfymMAeN50tCvoxglccP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjLkmzIbMtCa3airoHY8lJUtkcakCj6KysSjGRc8sJY=;
 b=bnoNEqNjQXrELxLhkQcceGfv2XONb2alGwouzBm5EUkCufgOHTpaPTus16bgFUdfjNhHh22FIu+q7uyhPzUXltXqQf12pST8ZXAZlLpIjpQDXRg+xxy2NwtpxlJztK23651/sCJNL7BAxyHk9AaPW002KNLQOKmgw3C+DZHZpH0Oo54CGmPB8qN4Fvtpgt3R+sSCd877MdIE4SsGnmp7RRTRdkdznl2I4Y9/wUdgT5HvHG5228X7IY42g7w6Gn6TwI5AyUzv+pSd5qJZAAjcbC+xgbVuHgjEHI1Ww67+6rFLHC8VwrpWo+xY3Qcp/WdG+S6L3LkbC1qg9DSDsMg9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjLkmzIbMtCa3airoHY8lJUtkcakCj6KysSjGRc8sJY=;
 b=CRhMG4bp33ZIHoWQFD+Cq89EPdwPH7urP97RmDj5JllvXVbLzKlugpSrvGTUMEHHWiQmv6EzOz3KTqGRnUWneP0jIY3Me0uNC5mAdN1j9c7BUPu6IvEYzquq/HHw9+s4R330VFZO3FtMvUC4t5dXl9uzNC9kOlZh36YZRrDi7C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by BL1PR19MB6105.namprd19.prod.outlook.com (2603:10b6:208:39c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:27:59 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:27:59 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>
Subject: [PATCH v2 0/4] Enable P2PDMA in Userspace RDMA
Date: Tue, 11 Jun 2024 12:27:28 -0600
Message-ID: <20240611182732.360317-1-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|BL1PR19MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3697d3-42e6-49c9-9296-08dc8a443879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zGPVNt+G5bdXLBsoRG8HY1RK5j7TINUboCa+TCwNSwsmRL25NDWBHbOsKA/I?=
 =?us-ascii?Q?S855kKofbNiyex2DEC96g2IlVPo3GdnK2O11vYdeF9WsAwclgOEraO4oKvT8?=
 =?us-ascii?Q?CQTvAFh7Dz2BP1XKlzHUQbVqoFX3st+4oMybILGD9r5Kel9u3v+a9ny456Op?=
 =?us-ascii?Q?gfV/4H0TNVGqDM2MbgcoF1FxAdBiPZfK9LzEcNc3qPQL7t/9zXDT/iTY8CPJ?=
 =?us-ascii?Q?W3dHGEAEoP5OTI7vzWE5w1fDl4LYBnUgP6EFonbLgSg6uXKo0m7B1B3tQBkw?=
 =?us-ascii?Q?/rMG1mRgr5sYk/oxtFwKWu02e93/WCj/E2mE8U0QbM9sLsPpuQ0jC/0F6O+X?=
 =?us-ascii?Q?PvVP2oKDFMLUXxX/VWc+0xY72q460Sb6Zwmq6DRlhCQqsULOn9yOk8lv30xu?=
 =?us-ascii?Q?YlR1SH7KJWBKzp1GcN3zi8EAWzps2e8BUi6vwH+7pvFRMJIt0b2XsZVpTAIP?=
 =?us-ascii?Q?0ivbazR8U6CBBdYC2BaZDlks2QaggUDrqRFDJiPOc1v5I01rZ/2L8dEXjhZE?=
 =?us-ascii?Q?iA8BT9gLHK6Dv+uN7XOTg5a1mdpg6sqslxaYHivgOj8rUOvWAs3th3eNHOHS?=
 =?us-ascii?Q?zpkMgic759hpUTJ7nRHaFXedmTShY97Q/kW8X2y5i/m4B4fDuuAhxZj2m+tj?=
 =?us-ascii?Q?3ON2V65D3rgBLKY9ldPCrF/B5FjRMNR2Vo2lGqNHj+k8CYwibqQa+KEuqn9F?=
 =?us-ascii?Q?3O6DQJBg8jF9mrA5+xZvYWL807BKeT3MdTlAb1joLovaP5CMyS4gfpUM8piB?=
 =?us-ascii?Q?MGOpOC4MJOnghmacml9tjL9Bg2gZihOX6lPjUgmzA4GMIVUqtsytHmj5MqLM?=
 =?us-ascii?Q?0zJW5/gUNz5m1TrRB5Tvn3DxkcvXO5twYySwpsVWHC5R9nPMd3s6NlrEowM0?=
 =?us-ascii?Q?8ZlkYuUxKcaBbvhXwsrGFH0eXgdLjWJ70NEDGEDND1rMcJA/yXnzA3x1/GOl?=
 =?us-ascii?Q?hSmStqggkjZ6rlxlqqXkE1U+eJS2tBBKKBdtPNRUm6rSIEcDw+hESqryBk04?=
 =?us-ascii?Q?uDDkVCOE7StAdLg38CfjpSrDL5YXahmk/doC4+YfntvlMCiTAYbIJyor78iN?=
 =?us-ascii?Q?6e7ZSoPlfzQJBSGB7sFbuXEUpj8f6Lw5NgHzlAueeFFWRSMwLG3wdzU2XgP4?=
 =?us-ascii?Q?Xx4E4xob0ciCM0Q7JjNnU3asoMSJB1u2KB/A8moNjL+mE/W0qOdYL50fGbEN?=
 =?us-ascii?Q?tcaWutZXTb8EkLgnSR3THuItx0uTr77M44hZ1DHX+uAeanY8zNDw10KJpwl1?=
 =?us-ascii?Q?nfWfuiwPxzNFQLV8gIIspjmYK3niAtIh5w5dROANDFA7pCbrP8qZZLe8CcSm?=
 =?us-ascii?Q?gjvfIbj0AB+nSSsIoq/K5Fowk48+tpZBF7pwwYcCufZhf9Cs15n9O/tj9COJ?=
 =?us-ascii?Q?sL1l+YQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqQ/1UR1g0cV6eRqHfYWvnD8nr9BcpMyYjXrBs6xNjh/2iov87KmDJKAg65C?=
 =?us-ascii?Q?Tn5Ds2P4XNHMNSsqeJkGP41R6sUzUJpRbbkX4NDVWOneAWPl4a1NnYx/x73O?=
 =?us-ascii?Q?LYff/Q0urqcptd5MneVEYhqDA5unZcw2/tItm+x591yaZ3k/QKPbn2ftr8iR?=
 =?us-ascii?Q?OfiVsBrv5DBetWqCrlSv+v7BLDThPc13Vb0Q/nFOPCnTtvLZVPwR6R8vikEB?=
 =?us-ascii?Q?6O78xbCaOnkzWVknaT9ulhL5tbOBd65plORNXuIZcd5wMWz1Pn70h1m+60U0?=
 =?us-ascii?Q?uFY3R1yqWbfb1/zSIdwJ0F6dciSU97SW8ekQWd7os43/0pL2ywvbOPP7ou85?=
 =?us-ascii?Q?ujGuX2UPZpUV7qnE29IhlpRjnCWiwRSc6mSCi7qTqJr5VKsj0mcVeOE0feqJ?=
 =?us-ascii?Q?l/YN4gOtlEq00R38dnwbQElPYCE06b8PkLuXlw58AmmPLRNu0L6Ae1o1/Lv9?=
 =?us-ascii?Q?+s2/UnB2y8SQLWmC4CcNugybXqGhmv0K/NaO6tyo0yieECuivJ982l6KnDq/?=
 =?us-ascii?Q?xViecCr88ipCLugBUEi8YlWgEAMBYU9MxNrSHKs4ggTfHPbKFd1T3hOFIeEM?=
 =?us-ascii?Q?706mJNVH50dDdGURDvPVUGPM5/2JZOc+bNpGwQF3Zpn60gfueR4rQ85dmffB?=
 =?us-ascii?Q?LzU64WKgBK9IbRGBBuO8xcHreVFSYEUtx3WETSJEFPdneSA1YCVHR27Tj1qx?=
 =?us-ascii?Q?fOnzB83TKBJEUZkzAvzxkXBpzzJ0xaHBr+HGsNZdXUr0wpvsjfvEDALC96S+?=
 =?us-ascii?Q?dc9oSxfnSZh9DWnQNe9Q4xS0OlVNEB6n4sBuDDUrZ4TC+iG9DltN7aMmCLjc?=
 =?us-ascii?Q?LO/IAjtJ+ENfS8Qw8uuxUVbdPXvhVAW2hCAvdxTmAMwZDUawUz/NtAJnmux6?=
 =?us-ascii?Q?qbb9wP3nYNfYR0FEj0uh6PcueTqnxu5MW9R/64VTvtWIAUoUZl8S/XZAHwOm?=
 =?us-ascii?Q?8+Dl/DhAZ7tQNTiOAvrQzOPrOn+QPfOy3ihe2Xd2oUinnoAJXiv3H20QnzjT?=
 =?us-ascii?Q?7MqaKLnnG9Slhc/r0HEjoQxmit48zYRUtQRQ7U9o+gDScTHZatEVOdgMfxgt?=
 =?us-ascii?Q?+WN/2ZBGIQafFHKButjrQ58IjeHS+pu8iP+hD6FPUqE7cBNQJWGPhJ2yqlLW?=
 =?us-ascii?Q?9e2FbHmCUbLWt2hUhQuCzx1eT4G42Hx3FXadTwraId6MZn/8ja1TLYtne4OW?=
 =?us-ascii?Q?hdbD17RytbT0o4SnqfjmQ7hxTRdan+4jkmXTe//OzTykvolJf4FC+h5u+Vxu?=
 =?us-ascii?Q?Yrmu8Uk+VxkKgyeYwkAE/ur4IZWp+Dx7m9zOujC+zh/Lcy9Ndub+2t7TEuai?=
 =?us-ascii?Q?ECAbhVp7FXkujM2ZUs065PT+oE3Qq1QBD0gH8qFERCENfGv40Cvs9NXqqutF?=
 =?us-ascii?Q?2/l5peWTmcBIlSHh5glWevR++YnRbgxQyp4mcHbmSyfflKZBqEoB3r5nEMro?=
 =?us-ascii?Q?uqLhbBtzDZouUUnmlJV4hLrUEsnBGbR81RqjdzANBo23uTTobX/cKXwJ8vv4?=
 =?us-ascii?Q?nC2EOhPABfbcD/huoozjcSvf8HE1qDHHEZsONtLR59LvwoJgEHcq8W9Jo/vJ?=
 =?us-ascii?Q?wjdLfsny2lhCEaQNHO8DZkxDJfOqg1JU7nhBGFhd44YTzWoJRb8b7W4YY1d4?=
 =?us-ascii?Q?Fg1BvgUhJf1GfK0r/rNbQR0=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3697d3-42e6-49c9-9296-08dc8a443879
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:27:59.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tUYkeiieGtgSPAcBLM6376e0G2oZZju+vIyO2rHb+eiTTIwgop2qjmvLuvpgYBl8JbZPSC8vHyIUkIQxPwB6aaX88NlbwppRrG5W7p31Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6105

This patch series enables P2PDMA memory to be used in userspace RDMA
transfers. With this series, P2PDMA memory mmaped into userspace (ie.
only NVMe CMBs, at the moment) can then be used with ibv_reg_mr() (or
similar) interfaces. This can be tested by passing a sysfs p2pmem
allocator to the --mmap flag of the perftest tools.

This requires addressing three issues:

* Stop exporting kernfs VMAs with page_mkwrite, which is incompatible
with FOLL_LONGTERM and is redudant since the default fault code has the
same behavior as kernfs_vma_page_mkwrite() (i.e., call
file_update_time()).

* Fix folio_fast_pin_allowed() path to take into account ZONE_DEVICE pages.

* Remove the restriction on FOLL_LONGTREM with FOLL_PCI_P2PDMA which was
initially put in place due to excessive caution with assuming P2PDMA
would have similar problems to fsdax with unmap_mapping_range(). Seeing
P2PDMA only uses unmap_mapping_range() on device unbind and immediately
waits for all page reference counts to go to zero after calling it, it
is actually believed to be safe from reuse and user access faults. See
[1] for more discussion.

This was tested using a Mellanox ConnectX-6 SmartNIC (MT28908 Family),
using the mlx5_core driver, as well as an NVMe CMB.

Thanks,
Martin

[1]: https://lore.kernel.org/linux-mm/87cypuvh2i.fsf@nvdebian.thelocal/T/

--

Changes in v2:
  - Remove page_mkwrite() for all kernfs, instead of creating a
    different vm_ops for p2pdma.

--

Martin Oliveira (4):
  kernfs: remove page_mkwrite() from vm_operations_struct
  mm/gup: handle ZONE_DEVICE pages in folio_fast_pin_allowed()
  mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
  RDMA/umem: add support for P2P RDMA

 drivers/infiniband/core/umem.c |  3 +++
 fs/kernfs/file.c               | 26 +++-----------------------
 mm/gup.c                       |  9 ++++-----
 3 files changed, 10 insertions(+), 28 deletions(-)


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.43.0


