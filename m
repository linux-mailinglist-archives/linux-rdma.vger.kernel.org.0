Return-Path: <linux-rdma+bounces-3750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4764D92A7B1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D04282049
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143A146D6D;
	Mon,  8 Jul 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="EtvkJSjc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40116146D45;
	Mon,  8 Jul 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457865; cv=fail; b=PdrZDOpaCPxVMRthHld++IP1Y8A5q1YgMm58Yc+UBaKyAwINNw76MByJy6p0WzQ3JdJWui03NiIOPReR94ay3Y/2RTbp65oggZRon6WM/A9B42ToIYbqqaBnO7l7CVLQvuXUoRfF1aZyTTL+lwG3TCRs1Pxo0j0ChNL3w9bZCsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457865; c=relaxed/simple;
	bh=pXJqPEa4VJ0jf4js54tl012183UXE1yUjkWbfLaApGw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l+DThEbxktuJ96jP3HX0toqnF/MyG3ngtz9jjrFRkES2jexPZJlb3BYZCXcmZq77w3cY4Sbq6rGZPAduKngK/dpeN5FHcDsJjs2gLAb23fg3+k8mJ3QmV5lOLmosWRQ5gVRXOqz6WjdsFvjLyg2eYRa/i7ctzFtqTXr4ivNCkPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=EtvkJSjc; arc=fail smtp.client-ip=40.107.92.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPLy//ygiqduHkk4qnLRHBVvxi3RLaqW4U4+MmXysLJCHtBQ/casuMaas8HTChHS6kwMIxjCflHatpkULTSClEA/PPUM+uUXYtzxVgp2ZIC+vJEVeemOAuQTL/20ZtVE19ef6CP6by0AtVvpqrdGFAx+rraBkrjg+Erk9viHfxSvVj807R/hmzA/YyWTg5AzDaRUsr2T/db0M9cnlzNMp6kHyMSPhMmPgmEHnf4CYZgk1E32x/sS3wM49WvGp0b9/ma0XEjzSu5BjMw4VgQTXuYYRffxrrYBbLVHe/Il6l2l8Eb+XaJ2o/AtZLNYWSzvQV+dFQBqWMFyELTxSCPFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwHU0+f3eZPAD6XFLlWvYxFwBJQpaASLsoXRhKff3Tc=;
 b=KGqn6kllFCrhOYsEmGslL4QURDiIU3nQQYHVxpl/G/C0kTYumqimFb0Ac7R3SVMumvbJs7A5Sh+82XUblqwTogxDMf40c7Us3+Hn3BrYvkD3oP/zscwkokxrlDYFmFn0fA5bx4NOgbUvT9WYLGUipjHt1DPeo5yd4npHJKc7dY4Ivdv2mvJvV7P3FD1PyAvmGV76QqVRFt59mE0GZ0q1yEUv3CaMnwupOx4yPdy3N17UvnaVgIYJg5ivUoCW2dsU411eo9ApJz/mVkqkCdS6KH0SrpLlamoTmLPGrDYvOymXcZnIzUDJDzT08LH7Mb3+Wb/3BjJYkagMzNcog5ULzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwHU0+f3eZPAD6XFLlWvYxFwBJQpaASLsoXRhKff3Tc=;
 b=EtvkJSjcksnkP18K7BkU7ATbnH13B7bFBIGG7VuuQgInUtPLPSyViZTtyCfDhWH403xyNyZKCfv8XRPPbiBqKpRpAVRGGjZyKmR5NpJUMb2MXbntjnndK4/wqy66dEme7aNjjAvg9R38VDywHAHj2SIY62azhYgtjlPZxdOuQDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11)
 by BY3PR19MB5028.namprd19.prod.outlook.com (2603:10b6:a03:361::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:57:39 +0000
Received: from DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4]) by DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:57:39 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: [PATCH v4 0/3] Enable P2PDMA in Userspace RDMA
Date: Mon,  8 Jul 2024 10:57:11 -0600
Message-Id: <20240708165714.3401377-1-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To DM6PR19MB4248.namprd19.prod.outlook.com
 (2603:10b6:5:2b0::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR19MB4248:EE_|BY3PR19MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 752ba691-ab09-407a-0a5f-08dc9f6f1369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3eR+bCmVg3+Z+y431Fe2kkGxtLBkT7allSdIS0Zu+Fusd197NKr5iYbZvf7?=
 =?us-ascii?Q?ukwfYwYwqkRdK9xbGdX90aJ4Of3z9roYkH11avNInEU/IPYfEQYWimcPypMc?=
 =?us-ascii?Q?KynYumdzAM/IvYGB/nNmPBaGt3ADIkZWgGtFnYhqT2Hd5HmLR8w6reRaYL3b?=
 =?us-ascii?Q?QZNiXvLKHXCZ26/e6mVGL/r8OpKG5mrbI7KgSm/G/y1l4kowza+bnCuf/IMm?=
 =?us-ascii?Q?EbPfKGWD5IM9af3Cf8pRyv6Jo8uRmlLCVcfmDFsjacXnCArgW2BGXqSksoRW?=
 =?us-ascii?Q?ZTDhklsn1MFLJfhOktOWUCbS3QeIoR/3kuv/MA2yGSUfccCHcdv2g2Dj2fka?=
 =?us-ascii?Q?TsaUVcr5xyY529rCmseqghVypMTnCQRbv3sv9tYhV8UhFMhMXHHfsklP3R/v?=
 =?us-ascii?Q?96wR2CsuihI27nbiPRlLnpjhmZ99aJ/Vbf24ph+NrPTIuI/oaty09Nq/7iMK?=
 =?us-ascii?Q?9Ui+nnmOVGZi+hFBNyJTnorf9+jxsI0ZUfsUnQgy1cX6riqCKZn+lUh0vq4B?=
 =?us-ascii?Q?wJt3v7ZCJHTfVG6YEkEAhgNWwE6RtgYMpYPyuoZhGWsddj23lBqULGo7oE/v?=
 =?us-ascii?Q?bruBiV6X1DSrYbTx6rxl7l6mzMtuDkBuMmfe4ENFwHWP+EOyGmb2lkngbbpD?=
 =?us-ascii?Q?T0Y+nRdtHuEsmDdAqSEOHK3bExWF3i1Bq/oETPjOHdLNiGGeD7TwXpUZTGZK?=
 =?us-ascii?Q?x87+ysAv21d+necbJMTWveySNpxS8d8ZGvbljNcKXpIG7342b9GCxnhLMeWS?=
 =?us-ascii?Q?6JeH8sD/TaEWX1mz1B1zmgLiyd7KVUf7BazcdIDyxlhjiWWikiHadRPgMgEX?=
 =?us-ascii?Q?kTxOI8a/Kmis6yA5QJ66RmykGDEiU6v6EmlW0L/Xzh6YgZ700PRXT259koWQ?=
 =?us-ascii?Q?inBgdAlmNOFjgnrKB0SoD4i7a+ErPFwkbuAzFUFn1BaiyxAuxM+fe+6lMGDr?=
 =?us-ascii?Q?vRHmbJ2UVi+VviBpZ4+idhvU39qTifNghD/ZkGFDlduaJBhgfs5GVMWOHJ8O?=
 =?us-ascii?Q?vm052Fw8TwbgzSsu/VttBBUp9TN6qpXmclkm1ktAD7YiJPyEPMdSe+a8PYwW?=
 =?us-ascii?Q?aFSa/bowj98LeMkuRl7FW6Mu8t/1wQyKo33P4pCSMhBshXYu1an3NYP8XvXb?=
 =?us-ascii?Q?a0AKsXeVj0bIV8sSuMEE6tNwbSQ/k9775LuKC3t15x4ThPugZELzG4NVe6Sh?=
 =?us-ascii?Q?+mm5/UbfOZDrvsJUB32WTrrtaJulqW4fxIz3BfRVp6fIfG3WF3H7lL3dm482?=
 =?us-ascii?Q?stqIHU+zUPRTXeyZW9olQAaBd8zid//i92cyy4b+YsfPqve6neyK30tvVH8O?=
 =?us-ascii?Q?NKqXlPMZPZOT+A8/Z1U0e+WP7k0+pKoNzbLXokwYgLaBwFGd2JNZpdH1npuP?=
 =?us-ascii?Q?MD/smxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4248.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44Q7Uuu20Vbs+vcdzN1AamvmILZGLCDcA5U9D2qzOFKnSh7KSn3BjKIbw8ST?=
 =?us-ascii?Q?ogg59JpoWShdpN4V73tk5XI+fCZNX7C3uFDYRLB0p5Et3kizchLvAtdP6gXn?=
 =?us-ascii?Q?k1tPfqXg6lx0Fo1zusOvak88bIPNMwKlO4hY+DJNHHRFkMYBMuXGQHX0+L93?=
 =?us-ascii?Q?Z0wFr4G1PWSxklCm/vFIaI2IbAHF+mnHkfRx3AOwuhKcUtR+go9kVFpf3Bue?=
 =?us-ascii?Q?ZuOkHTaTINv/NYRH6yRe1wNI/3DQl/f0FVhdrRm+9Qn687eMna/lYwmmtVVQ?=
 =?us-ascii?Q?q2XK1UW0QOpVB5R5gOXSJEg3yRF00Scb/obm+dfWbgbSGvL3sFCkmnUZfIN/?=
 =?us-ascii?Q?XNvn1upBcpqRLIhJMatETcxxbEBK9DgRFuhv3H7PIcTqbhtSF+d/PMilx90+?=
 =?us-ascii?Q?rwQewYRgxAGYHtIAIPggHP6jUrdmpvmZtrsChYYyG8KH+GiLLNfpf0O9OFvR?=
 =?us-ascii?Q?hPezN2sU8kwY/5aP0PA5zYGWn7wvek0gm7bUx60Q6m4GGihLGksXdXSbmJQs?=
 =?us-ascii?Q?0Z9HcI4J0GHa9G/i6mHgjynZ46y1F2w/7+jIj/GUfJFULDwATXQQw1x/+ZJ3?=
 =?us-ascii?Q?/cBKDFX7cQnfdAVAtDKgfgDV57TULezUbdS94TrpIwpdtOZGnhNK3y+oXEo6?=
 =?us-ascii?Q?d3+5L5QW1jqEm5j9Epm++rgYXmwmkA/gQRF2n4WiGz6rv0/Nmn1oQOMs7qQG?=
 =?us-ascii?Q?hizktn8DRAPr3TY6iTw3daHLPbsfFhs5kTOQZdcudnLM4jxM/OijszBrz7Zd?=
 =?us-ascii?Q?bXVfpPXXwfVTk0m2V3cQqmBU237XhUENgQ6zkW1Dp0+Jk1yANSgjgrD13X0e?=
 =?us-ascii?Q?g6t3azPGAsTzBeQa+1xHKyN1ZTj02fp6tk9ipVz+QA5dUqtfIJPjQ9QSW6hm?=
 =?us-ascii?Q?aCPhMKm935MaBFmKbV8NLGOUy1Tcfmb70stjV8D7rgOPCmogzo/T+1izIuX4?=
 =?us-ascii?Q?00qhzue/l4LnX3hhJwhe1bMDfvVOqzFtiX5a4Fy/7XhyBC2JyMaffOJhMBhH?=
 =?us-ascii?Q?ZWrGYbHVg6X8HtEdH6DU3pZZcySMYf6+IVSzZKm9U9wPFK5C8kt8TKewwvno?=
 =?us-ascii?Q?E01fniKvzM3ROks/nbmhp0/8jPU/TJDSJR8LbeQ52tv/ciE+R/sMM/i5Y4yG?=
 =?us-ascii?Q?Nyhki8/pqExQ/HEHGUcPIqHZjlcp1spUGHt3Pb00tI32mOhfiNbRVZM7Ys13?=
 =?us-ascii?Q?016+JGGZX5KxqvoHcx+jdO4ax7tf37NN07UkUBxX0JCWOcIAXS87YXo7emLN?=
 =?us-ascii?Q?AiSEpO8qyCAMdqyPnNkzMmtOnKVbKVNC5suTERmJ7OFUxvnIjFBpEQlGciDG?=
 =?us-ascii?Q?X9J4QOZUodKJHInZlLKUs6OhPGANnMWPTzEYQ02lX30QYOMBe8DKbHId3YRt?=
 =?us-ascii?Q?Hng6lpfu87uROG8D1/2wmOznKuiFhUqod93HNPVPpLL1JpkO9w2YrTczW9wM?=
 =?us-ascii?Q?uWnfXkvJExzL5ww2kHzPlKVK0sqvkvMvkTs2BfddQcxvnL3PkReKoZHaOH+C?=
 =?us-ascii?Q?Ksxm7nRYBa2ukACQ8CRRNfZQeEAKD7d2d/7jSPpr77yXGrYFYFa6dRj1DO1h?=
 =?us-ascii?Q?YzRo5YPY/cf7sZMSncMCQUXm7XKHomffRnvW9n5d1r8A7YPxjnIo9zfZ3xPL?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752ba691-ab09-407a-0a5f-08dc9f6f1369
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4248.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:57:39.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4R5uoC6PrRYOyxllpt1X7dzKkXIzrAZj+uBIMX92tf1mDcZyLl6/gmdgFxbqxFdbKd8Mqo0Lpb05BJbTcz0LPrQ0RWsBn9QiKc/lcgnTvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5028

This version of this patch series fixes the unhandled WARN issue from
v3. Everything else remains the same. Thanks to everyone who provided
reviews and feedback!

Martin

Original cover letter:

This patch series enables P2PDMA memory to be used in userspace RDMA
transfers. With this series, P2PDMA memory mmaped into userspace (ie.
only NVMe CMBs, at the moment) can then be used with ibv_reg_mr() (or
similar) interfaces. This can be tested by passing a sysfs p2pmem
allocator to the --mmap flag of the perftest tools.

This requires addressing two issues:

* Stop exporting kernfs VMAs with page_mkwrite, which is incompatible
with FOLL_LONGTERM and is redudant since the default fault code has the
same behavior as kernfs_vma_page_mkwrite() (i.e., call
file_update_time()).

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

Changes in v4:
  - Actually handle the WARN if someone sets ->page_mkwrite

Changes in v3:
  - Change to WARN_ON() if an implementaion of kernfs sets
    .page_mkwrite() (Suggested by Christoph)
  - Removed fast-gup patch

Changes in v2:
  - Remove page_mkwrite() for all kernfs, instead of creating a
    different vm_ops for p2pdma.

Martin Oliveira (3):
  kernfs: remove page_mkwrite() from vm_operations_struct
  mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
  RDMA/umem: add support for P2P RDMA

 drivers/infiniband/core/umem.c |  3 +++
 fs/kernfs/file.c               | 25 ++-----------------------
 mm/gup.c                       |  5 -----
 3 files changed, 5 insertions(+), 28 deletions(-)


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.34.1


Martin Oliveira (3):
  kernfs: remove page_mkwrite() from vm_operations_struct
  mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
  RDMA/umem: add support for P2P RDMA

 drivers/infiniband/core/umem.c |  3 +++
 fs/kernfs/file.c               | 40 ++++++++++------------------------
 mm/gup.c                       |  5 -----
 3 files changed, 14 insertions(+), 34 deletions(-)


base-commit: 256abd8e550ce977b728be79a74e1729438b4948
-- 
2.34.1


