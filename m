Return-Path: <linux-rdma+bounces-6001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E949CED8D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9421D1F23F5A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24561D45F2;
	Fri, 15 Nov 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b2PrUWln"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DA51CDA2D;
	Fri, 15 Nov 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683893; cv=fail; b=AyJldBZZRGEs6BwncfvPLZTcVsbi1R+TIQzGCLvjaiNgpmsWA69yTnDA6R8htUSR28r+crC8ykFvopa113KLiZS+C9aqm8uVchXw11e672ZViiXVHlGg33cGlIir7DCSYEoTqwUtEsJ3HKCEdpAJKCjUqJaQA+b/xwtyJsJwmc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683893; c=relaxed/simple;
	bh=4Zc7nzZ3hkznY5B4d2G//xQ/LT3DFxerDoNOEPVEKLI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=u1PMkmqWRpcsyo6GxWxpX/6Crvn0DAIQomrCUKno6Fe3vlUgOALVgQQOs/Xbi+IUl8BuuNZkUMuUZ0V3v7n1xQSWfLU0rpN4uZ+8pHfA126zuzns1MNsjqjRY+N6MNByd9IWF8scWtqAdURmH5SiqlkNYWEzvLPR1QC4r/m+2IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b2PrUWln; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5gtNLSA54lpDnI4W9s8YLjv5FF/cjghPrp6prhBHgHvGjBnvhHalo5JNW4gf75rAIdQvVmAtRPT6iQmjgICSRo28w5ouc5vzB4VDNAyFX0bw7SaHRzfWVzn7BZRiJ5Dc8s2P34pG6VzNHfr5imZ5CH0kHNgpy1W1ahKFFywYWhuPYoFPSCnembGp/86x99LienQkkD+4OY58rTvTMuVTuxSvJpCB5r6kp+yTIuK9DZ0Ve1rJHf/uBPnJDDHoDGzpLwcGube88f+FdUH90BBf07xAC6jV3zsRARpbo1v+hJMPE3exgCPX3nf337NBKRpgC5DW66W2BEBXkXOC/0kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL+JZiYDa9gNqmh0h1XORGZAG7Lrc7A6mQOigJyqkOk=;
 b=ZoAKPU4jsuRBcOtnaeI0Utd9d/9YLtsVWOLpryLHLCo//1CQ+MnZ8H4ND9OnybAAZgW+DBfeB2X2zE7KL36YFyGAfDk6RjWDouOThjvl49F5LIkSAidbtqU6m51tlsqne9BKm0TqVvoPQ43i4gwBBEEBxHqw/qtbvuz9fwE8ckpI6XEA2/xx4P33ygxYh+R27eW76pygAwL0Nw9i4dAzsUsuYsm4kDjb9K1o0UOYY8iKMJv1Zerhi23tyhNcU3Sm6iPQ4CFSpy/Qp1JvEtNrrxQfDnRdP6QgRlOAa1x/zmFsEYOLWyN3yeGc9kfb8HxQObRfW1SUE+06ptJKPJLDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL+JZiYDa9gNqmh0h1XORGZAG7Lrc7A6mQOigJyqkOk=;
 b=b2PrUWlnJDUdPXeWKEi2vhUH24mKF9DdPUtQ2Rxd34HMwVEwP6j0jiE92mr77eRYD0HzHIVZX53mytp4Ts1/DcKbAUS6kKiUukMr2W90d1hjiuniSW8tkoG2XGnwDCVvTZikvUsSZUrvtVwP+5biDG8Ciw4AR6+AoOuBcR1NQimvlmjWtOODE4ERtm4BOJ8snXc3zSA9cZrso2MGS6xinC2Di80enwUJcgxxIWd+fnT/BG9SznGmOXrG5Ilv3R+g2L91o7JN6yQaE1ckUxZMcOLgXMZAax27YDrar4T91u+r+SXOxRFwzMAx9Bus4NbypI6OR25Mzi+vmNzaRoZ/zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 15:18:09 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%6]) with mapi id 15.20.8158.019; Fri, 15 Nov 2024
 15:18:09 +0000
Date: Fri, 15 Nov 2024 11:18:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20241115151807.GA611514@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zYrWsi85CevLEbOH"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f27048a-a6a8-4b0c-d5c5-08dd0588b650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/mnyJJYH/ZJgl36UPbhr5ekyGEDojviu99uPvx9vJ0+8FeA4yC5qLNdfdPP?=
 =?us-ascii?Q?a0RD54PSfaDlJrT/F9ccFjx/9Wf/DftX6ThYKM+PahUZW+mgWZ/EOHtbfgnB?=
 =?us-ascii?Q?qEZEV84EWkY3SrYFhappBY/1EAuqwGtHpdZuArTH99tB+fy1T0buZb3M1JSM?=
 =?us-ascii?Q?05WiYqClRt/lsI+Sh4eV5XRDr/1kewy3Q09uA+MZX5qc2/ywa/2f/HyRUxAB?=
 =?us-ascii?Q?gYyawJRd9yUHOwmJknN2HmQxvokBtD85GOlJGQ6ARgvjlWP6hYq/Zb9d8Wrs?=
 =?us-ascii?Q?PqqRhBb0a2UTfxLyJvH8w1nqvECwuqBkOOL72XMEKQVqWKvc05IIn+IgYUP1?=
 =?us-ascii?Q?xDnQYJpbhTiHO/7f/y2EHRnSKlHFbHBRQzvxV+ryCtiI4aeL/br9CMUAIbXF?=
 =?us-ascii?Q?OfDq1w71PdknVxGGX21ao7JvymBGfAVrJU9KCyeGZ4lEBzZEgNoYV/3Ra0dJ?=
 =?us-ascii?Q?qna3r/XkH8AxvQFNQElpMcT8JYiYPylVSnwtDZfqpMqLQO1YR9D4guITLRUv?=
 =?us-ascii?Q?oqtjnvSN9hZx+ZkpQbij+Z70Yjo6dznosV30T7MZVwOxKcCrspQLsW6AFOwL?=
 =?us-ascii?Q?v0ZanCjaLZ+gtmkOXSJCYnUxxdCW2nTAM1UhnfhrLoqFEr5UWvenYvtuPseu?=
 =?us-ascii?Q?oopeqvvW+f222rwDpQn8OoHTVCK12VWIOT5k6ajWAA5xjL/XmeKpMvBSfKLr?=
 =?us-ascii?Q?m0KanT7QfKd3u9ZdtSaGYkjWZZqo75Hv7/Jtgvk9ogmCCxCmQwbFSdOCgEQl?=
 =?us-ascii?Q?bbMdiRdnp+x5SCtWO2faA5DO4ODmicDYfWUU0M/7z/rBu3YKg8QWCdNTjTJy?=
 =?us-ascii?Q?+rjO6mcRRh+WG6VrgLoz8EnLfzog1Ue0qXkkkTYPSlHMmAg5upYEj8tAJlcy?=
 =?us-ascii?Q?o7zFyyRxfwduE+hDu/TrMzFu4isj/pjSNJjF1Scj6U53UW16Hb4ik/Es2xsH?=
 =?us-ascii?Q?AyOEYBb3bUcSbxwdu/dlgu4yUuWtyd+7UsKlXHPj/j3gIHjKQhYxHVvEACwF?=
 =?us-ascii?Q?bMpDizpbwAO50SHGS9zjS+XKV3XZidX4SHZAjExWaE93Nb3ERfzgg9Q8W7pW?=
 =?us-ascii?Q?1GcdZXXE5OKckavcW5zaaZqfEl+cOHl+8fK5w8pPO6bv6hucsUXNGWFQk//p?=
 =?us-ascii?Q?aoevBapaNwarKTp3b42D/8GamY3mnjZtIp9YYWxsFB4lHHZjTLE7fTFL/iVJ?=
 =?us-ascii?Q?0sHdc0mglanyePnUcLa5KyuJ39Jgvky4xVqop41tuz9gmi1rPqoxwWhr+fGO?=
 =?us-ascii?Q?PLPyjYFKzgAiKkmwHYBkwPczqOogHVHBVHPTZ3FivJXawcMCa+OdoTojBf3t?=
 =?us-ascii?Q?0ew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?byg+UMLHZZ9e+86DkTsUVQK+bfY365dQs8w13PdDxxZl93yPUsdxJAz4+TWG?=
 =?us-ascii?Q?HI0aV0AwXXs9nheS/BIZSOLpcyYx6NswCkrp071gVk044FLjLx88kYm62aj9?=
 =?us-ascii?Q?ezivI62nFtzg3Q7wyu8rf+TDmQEtXQlWEblcG3+XoN/2N5jIsKrpmLQ2gIr/?=
 =?us-ascii?Q?ZtF2EDslIzpNOVywxKPEKH6Oaq2pG/WdGTzJQbRJEkRnsR+gNzCaa5jSo8EM?=
 =?us-ascii?Q?6aodifUaJDjhVzF17+5+TpWfBuBD83qdMh2sQKAhBekL9zSnJNXt4QoYkDU8?=
 =?us-ascii?Q?oQUIO/CvCLXYB15uk/LbbPXDfOp1DkVCp0xUVt4W38oWbpK0xBXSW0uwAR9b?=
 =?us-ascii?Q?NJEgTb/qK+ifhYeKYktJvxpVmAe5nZixmBhD7Ui+M0iGHlZg3/MGIGrlB6q1?=
 =?us-ascii?Q?qktx4ypzXPmUGA1/g0BuA+kgVuMRAgHRb8GRy9l0mqp1UiNBbPi7ZygIViun?=
 =?us-ascii?Q?Nqh3WyqOcyOLnR6J8RdeMs4Baz6iwAd7NvTbtHyMrjkUozQd88yo9SC3FpPd?=
 =?us-ascii?Q?uE/DAaXoNbDpYy0upxPcUvMB5ccFiykrAKhGuWTYoQiYnrsrHQDP2WC3oFog?=
 =?us-ascii?Q?i1VkHUoKJ6ID0ZLROoCGnl2p3w7rR901ox6dEm5TcpawOP2E9z/MO9HxuUVi?=
 =?us-ascii?Q?FyWom4QBb7FFAfB+LzE5EGWAauIqrBwmL3jgBlgVe6Wvpv4S9UMjKQqlIJQ8?=
 =?us-ascii?Q?kCzTIwRdKr6+LArRP/yf73qvED0nvo4bkoaaiMd/5pSXbMPnYJSh7t5YaSxx?=
 =?us-ascii?Q?TwiyOSKHsbEAgv0cfD3j8ExjYIrfNYaIX5yVRwQbFsBdtntLhsoAJk9Ukukj?=
 =?us-ascii?Q?H0p1FrJKz1edsD1KbQWf8k8CEyPNA+dnbrj1IZPqp2LRheWPShQjspD+q1dn?=
 =?us-ascii?Q?isVy8EsYs35J9ecPA9q8tZdXF0e8KoRzJr1UPIarH4+47DB8fSq0gABUR84T?=
 =?us-ascii?Q?cturmBLj0HIWVivj0IsSdmShzARXKDPeSY7uu3Yu9OYbEVlNDHsahyOsbrwo?=
 =?us-ascii?Q?K4gwk0FSV3ZqhtC8A1Cnt9gYzfLxDVVbo3Q+qczLypZqDQsZ+lJFmKd5MSQQ?=
 =?us-ascii?Q?epVsLNEEaph4xqHZQhHl8TnfJ+f1c6Qdn+5M5wbVZ5FmnDWPczmqEiwUuXPO?=
 =?us-ascii?Q?PTR2WlyxOVgj1glbegOEBoJN/NtF3zx/5yxkOUp058+KV2OE6hl6/Q7ATsSI?=
 =?us-ascii?Q?Mg2ePWUoJy1hcWA1+Dp1ewQqzEAdrG8pnmEYaTY8pgIZ2QbCrDkJrFsaJ3EE?=
 =?us-ascii?Q?/h6JILt1WhW4c7oxW05qVaR4YuyPQLfYboF89r93g9Hh/WAlObL/dlrBuaPN?=
 =?us-ascii?Q?MGrOvUtkaWIt9hLhlD9/inq4mTrn8i6PyP6Jv++IQP7peK36kmaw5dASC7wr?=
 =?us-ascii?Q?KqNEOa3PKT2TkJXRc0tD7lw7c1d3i0lpIqwYEAbzjyJMAs+aOq7b8+jUAiVf?=
 =?us-ascii?Q?Z+23aCnJKge17keWBJALkp4Sg4UNZ6SdRZx9sYUjL3mCsNYTWv4cfdA/ONZo?=
 =?us-ascii?Q?mpeUPCgsKD2ygW2Al3efuqhbavjToeG9Ufy+TfdNXiNHnVKQg3ZToJ1x3tHC?=
 =?us-ascii?Q?hNDAgM1yETZ5YmnFc2k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f27048a-a6a8-4b0c-d5c5-08dd0588b650
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:18:08.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY0V8K2D8IJ1DO9ZeCCIoz2EREIACCu+/cnGj28mvkf7xgTEqpTHZsg2ZrZM0Jyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

--zYrWsi85CevLEbOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A last minute revert that is causing a regression

Thanks,
Jason

The following changes since commit 76d3ddff7153cc0bcc14a63798d19f5d0693ea71:

  RDMA/bnxt_re: synchronize the qp-handle table array (2024-10-21 13:28:15 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 6abe2a90808192a5a8b2825293e5f10e80fdea56:

  Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan" (2024-11-12 09:53:11 -0500)

----------------------------------------------------------------
RDMA v6.12 third rc pull

- Revert a change to the VLAN logic, this broke previously work ROCE
  configurations

- Fix a memory leak on error unwinding in bnxt_re

----------------------------------------------------------------
Christophe JAILLET (2):
      RDMA/bnxt_re: Fix some error handling paths in bnxt_re_probe()
      RDMA/bnxt_re: Remove some dead code

Leon Romanovsky (1):
      Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan"

 drivers/infiniband/core/addr.c       |  2 --
 drivers/infiniband/hw/bnxt_re/main.c | 27 ++++++++-------------------
 2 files changed, 8 insertions(+), 21 deletions(-)

--zYrWsi85CevLEbOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZzdmLQAKCRCFwuHvBreF
YTT0AP9P/+L0sX71iPpBmCOASviZ/tL1c1sJUCxjWxzB4957LgEA1UEd4wZXjpE6
TyR5lTqI/UkCA68QZcAxVth0AtHxEAs=
=J8c5
-----END PGP SIGNATURE-----

--zYrWsi85CevLEbOH--

