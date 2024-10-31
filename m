Return-Path: <linux-rdma+bounces-5666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F079B801F
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 17:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75131C21AC5
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246FB1A3BAD;
	Thu, 31 Oct 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Krq7VOFd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A801386C9;
	Thu, 31 Oct 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392222; cv=fail; b=ItLzF5GvnOsteSZ892Bs9ODv99saz97fqvF+b+0/iuK9AVoMiadB7GgsC9vn4lyUfnqc5G3EhD9H/F6TB4FlSe4/TZL+dTZvyMr9AS7fUzWjZzw9mcpFsKzn4BXhDfHVXDbKSyruVLRX5r/eU1+Qko6MZarTKKQgYsLJPJAg2qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392222; c=relaxed/simple;
	bh=Jw68SnTPq+4bIIHFTHT/of9E6oXW65dFHVOO+T1LpNI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=s4Cfq5iKN2CUISdXQIGp8/In7ysPoET/hIKAeOhYCEKsPvd3c3T2XBPr3NahXK9wOcVs3W/rLb0BCby9HG7FrKCF3XtUO4Y2ET2LIVYNaGvF6UcE0PftHVx1M5x8t29FaA8jvL6isBQ7kywqsyM4wWICOdqo7rlXkDLb6UyVhwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Krq7VOFd; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYfC4XuwTBi6dreCgmjuDKuLp87h1ZV78wvW0PgVNuD+AvFa/gzZIrxdgGx2TVODkIQ2WWZ0EkQz0PBbECm7NhELPtZ7EA5gzWFAl6OLy1dJcj8RfFOzZIilGnpPM6V4HlqcDpezGXblSo0RHZoy0ijE25Mjg8oQNSjUk3Zg812+a9vjLs49aFrJq2D1XmrcKNfx8yexCWiugZ9M4W8WXRq1MtTz0OJdauHzPM2fS0K0n0UlobSZ+5D+vEVkrvBqELVRC5ag1NVZr1ltlyylX9NApcEDvqSBl2K+3svZDbIe05xnF2KQHx/kA8WyqVqkxaRbYOFmneqwh60U3XGGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+dPNv6xodJvaNBrpZ4NMbD9gj4VqloCBD3RdqZfYhg=;
 b=lyuRtPZ8PhuRZ0nHLI0vfNzgsvm3qp1OopXuuP4P3aeVkIOBW89roaK51c1JrbF8XCCBjtbG+NegWR2UhEV1sEgZfGLwciynVPMgIic7RiuGQfc/RvcJZxF7aYPcYYXmd2NX40klqC90VSCBBPRFTwTPOrO8bKCltR3Dp9o8najfwz1M1r5Em1XMTclMs1VIiDLfZUwxoLydkkJ8cbtG5NqJ2pohEyruTihopcK0zA2k+k9BQOi2Wscfn+fdf1vm1H9uD/eqAvoLDec27PTFwaBOVJG+VSIkGNRg2BVOq/meSdGnWgFCHcrUIsrxJ5jiGAhX8UXQw+XOsY3Q71kAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+dPNv6xodJvaNBrpZ4NMbD9gj4VqloCBD3RdqZfYhg=;
 b=Krq7VOFdFr7xLmKkiQ3Lz8py7HK+Zy9C0j2WD52gfoemUOkAUxyUwyPoaMrduuWc1IUSgtf4QkfUPSd/XXoO4j8q91jE92vl/h5S9At9Rnv20bluMb1j9PMm11idF/alNgSuTk7yXI4OLA6P20ocD4JXYLxRi6hgWLGf4WdY7RMZoMuCMa7VttFJO1sbSX7qU6po7cOzVNB7w1nBPLWX5Hxj8LpBnFkaRv4PXImC2d2KYLiGH5IfnOoJnVXSpE39qbkW90CPTY10T4ZWbkreSj3LnHjMzYZIVkPfNnr2yJo0E8DBintMzIZWEnk1nRa5BmmvzVHBxqAbbKnXp3FpKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 16:30:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 16:30:16 +0000
Date: Thu, 31 Oct 2024 13:30:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20241031163014.GA71683@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7w1bS95ZX4U7Wicb"
Content-Disposition: inline
X-ClientProxiedBy: BN1PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:408:e3::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1e8a44-8da2-4301-8dfa-08dcf9c94d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xfBtk7XaYhOVDgZsmMjff4uiJlvX6SGBfyafxiTkUaOVlI/Gj6mG9rVOD010?=
 =?us-ascii?Q?S4qpFN4t13ypuOcA6bIYeD1/WiarYmL/rxlKqAec5zVbgnRp7RW7aX3SuMpC?=
 =?us-ascii?Q?2W8CZSSRaWLQu3qyQaxlWAuCS8lZsG3nvKNXMfQpWmbY/Ic7YkxqKZ69hbNB?=
 =?us-ascii?Q?emSzELQ6eSh/zkFDQW8BgnvPZdnLQX+mxN6xopPxUXFbvn9fAcp1U86bpkcv?=
 =?us-ascii?Q?miT+ADzWWCrwuc0y5yf4qgMgHfidDVIjYHNCgTC3sJXtzMAv+XPFBXDSLM4O?=
 =?us-ascii?Q?dDGxmaRknKRC2yXw5TQQtJ2JU277JUMVTQ4RMBJFicTMEWomkdpXwG3vT/JW?=
 =?us-ascii?Q?QExh//TCDdhb9cap3zUG5OwvVJUOkxAvBo8mJwYan0LAQl3ZfaW6UlTJQAw6?=
 =?us-ascii?Q?14vtKZP6uLW/W+vikmH2k1pZgIsqDe+JKmXE9li8r2ZEzho7xxVwxrIBXgYH?=
 =?us-ascii?Q?LxMiw8UGDIE+jVEVs+VvSMWZPMUQTODvqeutIitbmzYbDMmCRCA26Z7fQiSP?=
 =?us-ascii?Q?8gd2K3Yb+xeb4dOFUDrKJ4npqmHrvBSf8ysUR9+OahOL3pVg6lr4DGkw3l8g?=
 =?us-ascii?Q?nsCDkJ0/GBI+an6NY4SOH9w6k+aUti8Xu9fwo2aZLIs+7/ixytFXUmd8mlax?=
 =?us-ascii?Q?/y0rJcssTeN69ijmfayQH07kSDX7xVuTfegjcRG94xmCRHXr8eorbcmFYvEc?=
 =?us-ascii?Q?CQ64sYrqcWNBWkj9/JJo/cSfYssDT0MJ3BBOPn977umsK7Lj6oLRZOPkINBn?=
 =?us-ascii?Q?VPsdwQvYtSDBGnnnkhmzSjU4ppzh+vJAIyavTY/H9C97szB02v+ecWVAEWvP?=
 =?us-ascii?Q?g8AxLZbzQLCEKWuF6iTyPtR40W7rMnkq1YCWVS++AJYTLjVAuJAkqvRnv7ID?=
 =?us-ascii?Q?IzvSXJ5loR0PIa2LFXe3FTnBqeHz1amf9yrgt0EVcVEz7i0quZPvNW3G2Hv9?=
 =?us-ascii?Q?AKZ5julk+m1mu58qFLd0sSJrF3af1gnW0YnoeHLpISwMKO75/HehcdYBGKWp?=
 =?us-ascii?Q?VaDiD+S0jyJHgWxRtxEmaqxtWFmjXufVz4YEOo9b5zj+XS1nrcpXZ6PJWXHX?=
 =?us-ascii?Q?NISiB++9igFQVuRBwm4XHQPvPOKPF+IxPap3d6m0g/zs8tHtfmVJHwrBI6Pl?=
 =?us-ascii?Q?cV4b1A3Yz6y1s++Ozb+bxldOnv9mccRuW0/fvrA2XpIrlRqdpVFoE1Ygf8gW?=
 =?us-ascii?Q?s9q9RT5kPMgO1yebv16GBPNfLIA4yeKqpMjOTvB3ilqtZmVG1dMmvHcGBc2+?=
 =?us-ascii?Q?9QutgyFNgnKcIUSadgK+4x+lCgloTAKX0tIH/QORVCOqm/SciRLVgnGPo/6Q?=
 =?us-ascii?Q?JX2VDt/QgTJRbmb4TNZuUjYh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dhg0Q6b5koTDdoIqfdJTIiOoQK3IwFOvB9gks4zz657UEDxjJkv/+J7ivQbq?=
 =?us-ascii?Q?wsvYFTNLiuZCt/X/dKvrYQGlTmFP9JURYOws8mRFKSJN2c2YvvuW6UkX7m34?=
 =?us-ascii?Q?2lHJL/HlsIZp6zm8VoGddJvFgHR3I9j3FDiS3BNAiNEWBzhkqml8EZMQm+9/?=
 =?us-ascii?Q?4IeRwpXqHaJNLtwCcpIm8Hzx3Np9WBz75woW8cUGylAyGphGmojpo/2hgAz/?=
 =?us-ascii?Q?89oY0ru2hwIPKON52zzYczysWZ3uhPsZimPeggkhQA0hZKShC17vIHf8v9VG?=
 =?us-ascii?Q?TY2UaS4lh1WLiUdtDF7+LFsaUhqowqDFEx3ysfBOLwtMsZzFyXSCRZKfX9cF?=
 =?us-ascii?Q?x39/YbO1SMov+DJM/mooT6pmufk3WwKkWQV6GEiLp/HYxmQsQDVeTmYCxVVF?=
 =?us-ascii?Q?PbrlYV+xCmtAdmG1KcSVIEHtqK1BzRdBjMu6DwJ1TKBo28iePBHLAuOKvB+b?=
 =?us-ascii?Q?/vTj1NUMsu8jUTpWoMVKwLLeGqHUR688enTBbk8JDC6qXiMuXyjyxfgY0XrE?=
 =?us-ascii?Q?avaN2XoPAOKaTnqiVtb5gBYI1lTzVeDgJYRC0LlYWyVOdPvf5UgAk++oQ9iP?=
 =?us-ascii?Q?ImInUt5fMn9zSeX5j59GDM9Fd6ZPk1tdaLgYQkahH9ZOyDMnuZoIxdX0MbTZ?=
 =?us-ascii?Q?Yy0MUszobESXvKOklA+6TerGGYNXUxtJsAz9TUpj2bn5VMt8FDnqpRNXpmHp?=
 =?us-ascii?Q?WZ4dQbjgopG57hJBMvgWaki1m35vi5fgyhcSG0ZjhJ5oNsF/+AXaKsixGCTA?=
 =?us-ascii?Q?xXjticzWaxKOzkKfOlo8qtnEOz+cAXfg3mSbnmWWRs0GxxBij0oT2aU3H9rg?=
 =?us-ascii?Q?9tR0g+3po3sXpfj1vtcntd/mCjS0U5flWqtHqELepj0zpnZ3IGZWq5sb0NEG?=
 =?us-ascii?Q?dJHfkqllDM2wUUDJWV++8Nc+a/9NKSpTDeeeSIHMHIvFJw83wf7xkvAt/ceX?=
 =?us-ascii?Q?xUuEOBumou5OR+CnFQzYSrSk2a3j2tDIbPlKxWqdLlia+GEPilEy1IL5LLAX?=
 =?us-ascii?Q?yhykWrZtIabz70ZoEzMBQxJD85ntTFjUiaSTve4FJryLbDBpRcvHD3xhBhlV?=
 =?us-ascii?Q?NSxOTUsRL1K/pr8QFaM9S+Y4GSGy1pob9L3lfNUGQn09QkW05XgQWmXYSWp/?=
 =?us-ascii?Q?Jun2h2fkkVjvTw2s23xdsUor/zig62nPuVK5dn8FLa/3zd305cS7lwCraZEP?=
 =?us-ascii?Q?W+FEzoM/TV4eH3UnrnGDlrSNsBGme1px+mBaEwfEQwNB3A/BFt2EaimXCETd?=
 =?us-ascii?Q?W2ch2Z+fVdoehbIzKvYPwTwiPYRlIZYb9665q1RM7U771CTURHCsKpV+ud5A?=
 =?us-ascii?Q?M9WoBGGat2y9mcZmT9X0kOTuBmw+KsgnWyKuoT7fgJ+hldrEYw1NmV9U3Xwp?=
 =?us-ascii?Q?pJtqeT7kYPV8jUvudIGeDCaWPe7ttM5Sf6YkPiAlESmKBG3P0nboa/xFqM4B?=
 =?us-ascii?Q?g/JKPtJ9rAFD5VPg9ifWlKQVFDj+6fiO8QgSry6MGpZWjyoby3+igHUCnOCm?=
 =?us-ascii?Q?UFQDkfEEQV1mh9OJwcKyWrtFd+5xHw9/tF1uNmcZwfDm6yZ+L07Nqk4tE1ZF?=
 =?us-ascii?Q?tAAUooKm5Ga10w8QwdY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1e8a44-8da2-4301-8dfa-08dcf9c94d1f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:30:15.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWqcCxdeIlGD7qKTuQetDYwMGv6p5fUPvMp/cW+pYLa1rMsQycZqqb0JADu9RXTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

--7w1bS95ZX4U7Wicb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A few small rc updates, two are recentish regressions.

Thanks,
Jason

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 76d3ddff7153cc0bcc14a63798d19f5d0693ea71:

  RDMA/bnxt_re: synchronize the qp-handle table array (2024-10-21 13:28:15 -0300)

----------------------------------------------------------------
RDMA v6.12 second rc pull

- Put the QP netlink dump back in cxgb4, fixes a user visible regression

- Don't change the rounding style in mlx5 for user provided rd_atomic
  values

- Resolve a race in bnxt_re around the qp-handle table array

----------------------------------------------------------------
Leon Romanovsky (1):
      RDMA/cxgb4: Dump vendor specific QP details

Patrisious Haddad (1):
      RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the usage of control path spin locks
      RDMA/bnxt_re: synchronize the qp-handle table array

 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 38 +++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 drivers/infiniband/hw/cxgb4/provider.c     |  1 +
 drivers/infiniband/hw/mlx5/qp.c            |  4 ++--
 5 files changed, 28 insertions(+), 21 deletions(-)

--7w1bS95ZX4U7Wicb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZyOwlQAKCRCFwuHvBreF
YZb4AQDMZcQ6LUcjyGpYLaS1DF4H6HXg4w+ZcYs1obW5OrlXNAEA3ulMMycNpDCc
YdDEbwA3Io3Tex4f+0E5IxaqqfSbgQk=
=tWo9
-----END PGP SIGNATURE-----

--7w1bS95ZX4U7Wicb--

