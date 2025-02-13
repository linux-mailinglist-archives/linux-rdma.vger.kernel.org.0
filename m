Return-Path: <linux-rdma+bounces-7752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1204A34E58
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A318B16B03A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4014A245AF9;
	Thu, 13 Feb 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7TPx8se"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6B207DF5;
	Thu, 13 Feb 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474340; cv=fail; b=BYtRfymRdXEaHo7IJ+EkHatka4WxkHtJAssp22bqr+7BqUOoWx4av5IB5+dxZM4oTUCCr4y4M4Dc4AP4AUERxpnfMajEkwlwAGc7jhAsbYxng0Yr43i/YNxQ0G1gMkqEFESBlJP5v66lrmWmDd76BE5H8LaMvfP62+PcVzZeIFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474340; c=relaxed/simple;
	bh=G4E44Ex1Y5ANWhAOqxMonGXwK5XCd7TUYKdiI2ZGPIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xzo16v4a7+d9JYqtQ+IAbT9QEXwYdEm2HoYkv0C4FQ8+FX1IVicJE38RZFG0talyG0X+zUiEsZbNsiFDSYrq8t1ZIFU1avfRaOS+CD7fuqiy59fpVJh8uaP37fHOowAF1qSrsysA5uu08trjwU0cnnMQ5QdYGnqX/xO/LwgN+C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7TPx8se; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5w/MZTWwPJh8h7N0gYTThu37wR4NrJfBpKWDxehTT8VpwmImsK6aHQDQw/RHA7aqB9yoqNuHSOoidxgVF3w2PzKC926Gwej8VooS2jaLhrNQrnpBTL5zGD9ZXkx090HMDcgCh2YJFoYimM5jABahJYnXD/nmndcTbBSfswj6Doy3CMHVD5kzWAEuRM9zjhyZP3io1CsonB422Jihi0RFQtjKZd4jZHwZafajcNvSPUkZhsZIG+6ESUde6dTR0HxrSoJbzNkPDMowub6TNm1sm8ob8aS+O9hhEI33Lr4jMdtKHAU8t2+kf0C176ot9Gl/Bk48GT0U14brL2+knO4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW7wJs7daKw/kj6HEXWqLmI0nmG0mVEF0fwDf0/Iqrc=;
 b=PM3NBqCjndqWai/Pvp1o0CpZrUFje265WmSO5w/PtfhOzW9Aw3XlPuIk0uQup8V1eiBGAGoPzt9dNmJ0hqy556BUiWaL7M1TJm0dtngwEeP4AvYX0phJoiGRr/LVP3yqE/5y5v419MDhTGirfn9g9/WI+n8W15IfDS2aZzR2rHaJ/AEUBaG3IWh7+e1o45IemDguM3YqOlIh4HNHGDKkFoi5Nm5QKEW34fdNC9ccTI5J2D9pGVJ0oaZCnzch9mq16V87vtY5xWMb80hmxUS2StKqHJACzG78NKWkVrnTMD8pwfPQB8NuDJVgAa9Pjyc0BuY+99HzjLF2+QIDkzklCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW7wJs7daKw/kj6HEXWqLmI0nmG0mVEF0fwDf0/Iqrc=;
 b=G7TPx8selZoNQqYEnIVGkMNH/cAroqYIrbp+McbyIrLpwisMN9tGMn7wpRqcFcKfZbInT1yc+KkWDKKXCkav/ICwrKSQkPZgefm1lEdcP0DLD+IV7ET4cuBHlmFEnkxoujYkZzQefp6Hk6qTzy7u2Ez71aAaTc9o1Vbn9XRSgIm3Piw3ULYBDtAhcYBINKRVgZNaiLd4625OFCZGYFn0nM8bbuyLBowDcXjQwi4XjzXDk31Esms4/dAxQJVButxEvhiAqMnkJbZopfAp01EmYtx66PHenUYJXexfE7rgZOiHzuhw5Daq/QkTwiF50/dL1coeQdpcbdQ7oGikC77hxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 19:18:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:18:54 +0000
Date: Thu, 13 Feb 2025 15:18:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 07/10] fwctl/mlx5: Support for communicating with mlx5
 fw
Message-ID: <20250213191853.GH3885104@nvidia.com>
References: <7-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <daca71bd-547d-406c-83d8-05f8508703b2@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daca71bd-547d-406c-83d8-05f8508703b2@intel.com>
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f48f16-2a9d-49ff-8cc0-08dd4c634199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1oPsDfuYQBjNWzc+McRWwnna/4PSGArr4aLn1gl4hrkGEXLvyHewe8RrwpO?=
 =?us-ascii?Q?PNcfPF4/fcjt83YVULNFMmRe3SNVAl1rVfzu+/chgNVdzUSeQ11TwcVwxwN1?=
 =?us-ascii?Q?YO4RwSOjiE7KFKP+UjKZZKjolp2rppU1iBTUptJ5X6PoaELCSwpvQYySVKeD?=
 =?us-ascii?Q?+8Nk243Es31JdEwvqcu/3aP24p0cWnE1b+3yjLbHKbfBLVRFQag22FANbjW7?=
 =?us-ascii?Q?IUMmRk8leQ+MVgQoNmtCGGgXg06Kj5wcjtRSCqpJv5H9lRNph3Ecn1FNRxiI?=
 =?us-ascii?Q?U+5aPDbmNZZp/PrGVQzhL/RE6xDXe7V4kxfOO1qBsq1HtL4gqOTAuttyDRf9?=
 =?us-ascii?Q?Yq4e3auZgXYkQhDrLT9xMDfkDNOl1UAqsbzIoocI4jNM4KB8MTKmtik80y1z?=
 =?us-ascii?Q?b4IhTVPfAmbLGfxJFFpFMCJ7QX/2I1+pXX9CAJV7gFXkZz0/4wGOvBN31cCQ?=
 =?us-ascii?Q?KXpb0H8qoHa8WH0mZTTIGV+DtQctQjbgCD2WLo6SX6cmXus+ZzEZ7PtNUm5h?=
 =?us-ascii?Q?OWsD8O4NZj6ml9BQ/QojizezYbA8SKdLSh/W69yguhAxCTOEByDY3U8t+4ht?=
 =?us-ascii?Q?LYLu0ldWoDHn28vL+60s+nGMjCDIyY/Z81QHvuOC7Zc0JFaKgzRcwKhwJJck?=
 =?us-ascii?Q?9tquwcAcX/pNOAAa5itIa6NvpWWTz4G+Zl+sbno9uhPHHb28mau2bXOparlE?=
 =?us-ascii?Q?kSKdWqJ/nMgZ67haXiUUk5euHDGDcMZOX9AOlJVq3KXzKTy7iOoiEHqx4i+h?=
 =?us-ascii?Q?eW6tFTUENNcspciirHS2NLuvtpPv/g2rse2fzAkifOtaBYW2Z8oFj8lofijR?=
 =?us-ascii?Q?00wV3sk9KT7/+R7aYT4q/pIXjHFsU3cQO+Q80P/aL2RGvDpbrbMMdeklfam/?=
 =?us-ascii?Q?nUXpQWFakvPUFvxApluXf1U+G1qERSe6sGLZxdnSAzHO7ugLVszUM2vtUSLx?=
 =?us-ascii?Q?WiXkvCVySrQRAUVZLGsV+07w6W2gzyXHahsli8iU3Pt8o4pTWk9W/+L7addh?=
 =?us-ascii?Q?pVeChqtAfFUvQPNPLZi/IHd/B2VIK+qWspWSfGgp8sZFWrYqVi3aDSufYTex?=
 =?us-ascii?Q?PwCLpL14JXljWnubqctLYzDPpkNaiwD1iNrfJkRfZTrz8cKF/D4rsIZps6Hy?=
 =?us-ascii?Q?0ZPdiDc9SKlCA7y6kCh6nbQ482qYEe7ELN8q56MJ53dtjHmVjYSNppwJAMnI?=
 =?us-ascii?Q?uz0x5TjnK5FmE+c6lGqYYBrJHumlt6pV8JuX9+PbY6sd69BdDKoeARqfkqj0?=
 =?us-ascii?Q?HQJ8r9lRvtHQmkamfYzSQvKTPjmjrZM3N/QYlRzzb+OiOQHD1YmATv8eVazw?=
 =?us-ascii?Q?6yPifvzk7/UrKcc/FW3vgNTVxOLZ33wVnu6EB6Fav3qqUvYr3R66BFlAweEI?=
 =?us-ascii?Q?wscPS/urEtk493Yh9gbpxBIkNK2S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbODgbLxKRHswY3vPsfsygOgJGzde3vKVzxpdayV4otZ6GGBkN5ALax7UhD0?=
 =?us-ascii?Q?SRa/7ScH09Or8sweWuF6UtKXqwJ8tP+GK3RHg6qGFYFIBdXgSFh6KItywkC4?=
 =?us-ascii?Q?D4Xt02J07S8bowW+UNW0CQWGyvZVeg4Gi7p9bm57Ydzyqyq8oagfooNN+0Qx?=
 =?us-ascii?Q?w+woQvbmfta0crA0jvo+BgyyPmy3c/VDC7BJY312X803mGSo5m9iE32kHMph?=
 =?us-ascii?Q?mxmFzEzBjD2pHRO480XWB7nSGSU/HGcYxNIE99EOg9+e7fBGcGfEHcjN8efI?=
 =?us-ascii?Q?vy3qUSwi/O+hllWTwyrWaoBGeh2hgeaItsXyA0LEAcxp15VPD6SA/fBKjRSJ?=
 =?us-ascii?Q?U33TTDeh6wO6Xef2W/vs+1H0mS3cNEQ6n9nzanzgAxA6P21DpaE/0C1NbWKx?=
 =?us-ascii?Q?P1FcDG21BuafwfnG9f2GrvfAy25EcrAcbvR+aN3FEPXnBa+gH01nZ3KA36Q3?=
 =?us-ascii?Q?hYiRcc+p+uive1j6nwLAVkL8nwZHxGCGyBGC6N46O8jKIRbTSxBW8ls4rr+y?=
 =?us-ascii?Q?qcsdgfqWGPcbvmWWmHEQ0xbGBDxArDtHU7eG3A17azO2uraJf9T1W8F6T0YN?=
 =?us-ascii?Q?/bqDVAtKFR33kDom6HAk8MnK3zTm0lI2lrjef1Icyn3NDHMIGMpply5YGkxM?=
 =?us-ascii?Q?vK7Mb7sYpu/+MWSbMJnLukUGkiRV0VX4900eHkNTr5mK1mLCbotK+xtAGmko?=
 =?us-ascii?Q?gD0sqm/U1LSc+sVVGKfUZ7usPS0xXPiGWzZoql+/sGEiw+vS9+CfDkx+NGmf?=
 =?us-ascii?Q?O9Uin4CuhYklPx5mYdogFLKTZduEwNvTcsArM1GQPyCLx3sad3Ky1qrDK+vR?=
 =?us-ascii?Q?HXokBMtVD2lqQNRVPDho8xYn6o3Yw7rEVQK4sAAq07cdoF7VyIWA8ytI+bMy?=
 =?us-ascii?Q?SL68Y7UzviECxA9GxXMD5HULGzKewLly7QMbVlZ12i2I/Z7UiQNInsv58Gzo?=
 =?us-ascii?Q?vT4cOmNAm+5y4UIUkNR+6qrEkQfNzBAny7XwTzwVeanHFWfnZ1JtZWHfs/UY?=
 =?us-ascii?Q?JssMD9ZwieZRi1GZQqjDMlKTudcy5CnhCjBQS64PvbloBHZu0zUL9i6pyhO6?=
 =?us-ascii?Q?JUIiquHMIer9kXjdZKUZtJ+C2FZzUlE9YpNsc7W/jNDpAk15Opo7QjhsmM9c?=
 =?us-ascii?Q?Mb8RFwULA+GZ3yYCbqK9IX4cZWKMi6cL1JF4F62rG/cJe5A/VHUDGN5afpaD?=
 =?us-ascii?Q?pcSDolpepp1Gg4kzU9I1fnLYxKX3Pcsc5HKYjvp5ruTt1mU1hO7VqpTsK6n4?=
 =?us-ascii?Q?/Xx3FgvNtbpb0qTIj0vDFkSUK/2ivVpjpcbxDqks/b8Mn7RbJFg110e3knYd?=
 =?us-ascii?Q?ShE8/kKEM2aiIy8OvGEShPSyLF+GZbjEsydyv1ujKjZ7PEJXdlZAHjcJ+CJn?=
 =?us-ascii?Q?t84s4bsaEmsQms9l1Ibv4DBoHowzWqFh3y272eTjDV7/MXu9BpOFKVG53Dl6?=
 =?us-ascii?Q?GT2+j5VfsrX5tDbo8wWMnhJpaUnR3l6LSdjY6NP7UtMOy/35tFM6JeZBFW9S?=
 =?us-ascii?Q?FfwxGtPOv5U3PbR/JMY10s8Saa1HvtS6V4rDq/JxVOlBnFPIspdCnbYNkJKr?=
 =?us-ascii?Q?fbEM8uYmX5DiWSpSsT5h2mAMgv0ViL0aH18puWMu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f48f16-2a9d-49ff-8cc0-08dd4c634199
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:18:54.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFfkQEtYpqyYO2gRQyMd7aqdWsfdHzKjU+SLOB0SpWQVamyVmjQrXq8k0qsBxR0D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201

On Thu, Feb 13, 2025 at 02:19:38PM +0100, Przemek Kitszel wrote:
> On 2/7/25 01:13, Jason Gunthorpe wrote:
> > From: Saeed Mahameed <saeedm@nvidia.com>
> 
> In part this is a general feedback for the subsystem too.
> 
> > +FWCTL MLX5 DRIVER
> 
> I don't like this design.
> That way each and every real driver would need to make another one to
> just use fwctl.

It is not mandatory, drivers could call fwctl_register() directly from
a pci probe function. That is just very undesirable for a secondary
subsystem like fwctl for reasons Leon explained. We want loose
coupling controled by modules and driver binding, not strong coupling
where if you load, say, mlx5_core, you get a million other modules
automatically pulled in as well. Users should have control over this.

> Or the intention is to have this little driver replaced by OOT one,
> but keep the real (say networking) driver as-is from intree?

The design of the FW interface would have to be really off to motivate
an OOT one. IMHO you are more likely to see an intree fwctl driver and
maybe an OOT netdev or something.
 
> > +++ b/drivers/fwctl/mlx5/main.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> > +/*
> > + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> 
> -2025

Time flies, thanks

> 
> > + */
> > +#include <linux/fwctl.h>
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/mlx5/device.h>
> > +#include <linux/mlx5/driver.h>
> 
> this breaks abstraction (at least your headers are in nice place, but
> this is rather uncommon, typical solution is to have them backed inside
> the driver directory) - the two drivers will be tightly coupled

It is part of the auxdev methodology. These headers pre-exist for all
the other mlx5 family aux devices to use.

> >   enum fwctl_device_type {
> >   	FWCTL_DEVICE_TYPE_ERROR = 0,
> > +	FWCTL_DEVICE_TYPE_MLX5 = 1,
> 
> is that for fwctl info to be able to properly report what device user
> has asked ioctl on?

Yes.

> Would be great to embed 32byte long cstring of
> DRIVER_NAME, to don't need each and every device to come to you and
> ask for inclusion, 

I think we want people to have to ask though, don't we? We don't want
to make it easy to write OOT drivers.

> that would also resolve problem of conflicting IDs (my-driver-id
> prior-to and after upstreaming)

Yes it would, but I suggest people get their driver posted before they
start shipping it :)

Jonathan had suggested using a uuid IIRC for the same reason.

Jason

