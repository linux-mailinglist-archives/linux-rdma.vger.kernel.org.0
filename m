Return-Path: <linux-rdma+bounces-4780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83596E627
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0B9B236E0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554AC1AF4D5;
	Thu,  5 Sep 2024 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ivdT0X/b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E2197545
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578500; cv=fail; b=PSblUvSD1c/yO7hLqtTKUwuMX8Qyg7ecXshPWPqVs9hhgM/rkYS5K0xFrzkTeeR8vJiPmcq9x/IdTNGbFwNwZJ989orq/V4KbTgID87JdhnUB21n/mXycCzbh/AShFgJr1ZZewuuwyP0Xihw9bHv/U6okszCA6obB1WuEpvgIH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578500; c=relaxed/simple;
	bh=tam4c+pPSpxcT/MWJlcVHDssY019bs360mC2q29Blio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qaDZFTDs5MtDHtmzb/n2Ul3HvFD4rIBM79znfCE+ybZaUZHo6Jm+57Ob5apWqtM8IPO0FlWjJqASSLrt+VMNS3FZf9sxWxgVMZpoSQ0ZRvwGoISkhX7YgW9br+ehWUaugnjfL8F1wpvGOqDtRwFZg0NDj720WgOyfKYMNQlBDxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ivdT0X/b; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WND241mri1sduIsaGiIBPRy4k2Dx1IZsThuvhwUr9EGG5nqQ2BMOla2WCe/AEIQhneCRMDZ8wIv1bZGBuyVTpqdFghOAeURrjbW/XNOvgla195nVQNaCxmngQ4HDijHfTfADhxFPXA89SRIOOFr48l0YsNpI896OdFkwjvetNQ+Z/pUkBvsTBP3rZOhBHKXjALKt7nIAa3SFiY3FoWiyETedazpUs3HllT+b2mHHjnQgBIcv7imzirAPprt+axKWH+4hs1A9pPY33xjPosWO0Dtu/3AhM8xfaNIh+pa4/xtHA9n9g37lR/gJE2gj6p42oQlk9ZpMpej7PNomqZLBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVcz/BkRZkv5t87ZtUvQ5cXfDg5C6+Yb060rdGunu0U=;
 b=P/hk2079iKfQxZUG2dGZ74zij5VXrYYJLX2QO3W9CLil+fUn9mYAr2ElWs/PCoNINGQRb23X8snHKg0/WMf5x/wW7aKwqxINQlRlzQ+AKYvkIH8jiFKOQq++3FMdeZUI2uJiHICvV82o0MZ9ip66YuIM13Mnfr9TCZ2z8zeLaitmUq/cMQOlPdom4wFbS3Teq/K2OWQlxK/RM2OspFjwI/8HpZyu00EmFR9n1HqlbkLFEfgQE4UMW68CA7PwUHyAipEmEjqeNg7cdPOVIdZ9lt25o829P6QWN3XepxQjBzOUdARLhQAjQI/xu+UKk55etLd679juRutycxgLZBSbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVcz/BkRZkv5t87ZtUvQ5cXfDg5C6+Yb060rdGunu0U=;
 b=ivdT0X/bTCluuAyuvtGe56nf4UuldSmjFpeY83GVUJcgqFn8a56eyvH6AqqFZreyiQPrI1tkLKKAggFyEyVDGasumXenoWCZDc8CPiOqgRHJzAYPldGBSe6Tcc87q7P6CmvMv5UDxvM+J1m3+/86+zUpmN3lYAoAbXDccwXuVn39fMVBmp+vcdJx+gjYEmnHV32v4xh8rvslsTckHV/sV7iQFwKcGKKKZK6jcwdx0/Ta78nUlHtaShjarNMKPBv5JYt/WrxY8edITFr5qGgUye8tqeSWFUqWz686y4D+xXtD2t5UvprTzWezFnTMz+/Hjg0Vt0hegybRWDZWMXXx7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 23:21:35 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 23:21:35 +0000
Date: Thu, 5 Sep 2024 20:21:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: leonro@nvidia.com, linux-rdma@vger.kernel.org, saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH rdma-next 1/8] net/mlx5: Expand mkey page size to support
 6 bits
Message-ID: <20240905232134.GC1358970@nvidia.com>
References: <20240904153038.23054-1-michaelgur@nvidia.com>
 <20240904153038.23054-2-michaelgur@nvidia.com>
 <20240904161839.GM3915968@nvidia.com>
 <9ef3c49c-9e38-4d0c-be54-4a3c0b93375d@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef3c49c-9e38-4d0c-be54-4a3c0b93375d@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:91::36) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ed6139-6d61-4bdc-12a2-08dcce017bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w8YZ7RqA7AM2Q2yE4fGo1jX2aeHFHLsHsDAuMVCSZKj2RhTSwQShi0Q5v/Hu?=
 =?us-ascii?Q?YVfMUBE9Khki/hDsrWTTLXAdm8GlHJlRM4vqp6+J4wnf7wW8ep4/AqUDdOy2?=
 =?us-ascii?Q?ij2g2xrBku3B57Qy2FSNNf4lr/mPxpxF0Q6LBknpgucU6dKA/35LO7wDB+5+?=
 =?us-ascii?Q?r3oFc1yEKAosOMcgU4o2uITugQm3ECZWCfomJLQ2gpVmptiAHgEXIYvcvUKf?=
 =?us-ascii?Q?+py7rmN2ESJBAe0TsTP8MLw8HwU7s/vUBnWnK9tPC4ijtcjoJj0fWQzvc882?=
 =?us-ascii?Q?+zHyMys0REBMnnA2r4DiGddc5CR8KwS0aAJVApaEgYRpsiwUrFAMIzeLqwdi?=
 =?us-ascii?Q?t67M1rQWyicP8jFuLTOZQGtwxRj717QgBAzGCIxUTGk2iS4qj1OL0A0GVVrb?=
 =?us-ascii?Q?NboYnAEcTfe39+f4ySy20tA3msa4RPS5Oma6oR9zMUoEQBBHt2PWt2d4oOPE?=
 =?us-ascii?Q?Jb2IzhDBzs6R3QDKwN9PdX0lY+mIh2r/dL3EK1Fjmz1SZCJQ75q76g42yTYf?=
 =?us-ascii?Q?VoxYPGu5TETYl7TVpoDs2W/2ac9z3hyelJy2a5zhEjZeh0eh8ctZEYti4zNc?=
 =?us-ascii?Q?FWRHwWpB4VdpW/RTG1SREQm2bXAaCdcVMKFHx4A9Iol1NPKN+t9a42L52+uq?=
 =?us-ascii?Q?fesiObyRWvDkz6eLnJMVIq0Mr+l+Wcwu91+OKxebsbw5o7ywYhC3RFmSUnLn?=
 =?us-ascii?Q?lUwFntML4KSrKJmCyF2ke8rWt+MdX28LqQ+1SmctJpM7LU/aJNAwvPabne+D?=
 =?us-ascii?Q?UZuTdrmABw1b1iua2jvJsbU1WkDCEOEXAE3LYs3TzoE/yfLWZogDs3Wka15i?=
 =?us-ascii?Q?rwJ33FzPh5XxAHUP/LYcLjWTHGU+CO6/vzQZnaIJBYn74g1F06swoYrWJXIs?=
 =?us-ascii?Q?7j3dKOsOJ2k2lgKDk6KN7IVMoMgEIciQ09FKmbP2zJ1Sokh3ozb6nphHKQzV?=
 =?us-ascii?Q?AE7TPl86szh5Xm0IEQj+BlL2Q43bHkicp/jAePcqNyD1Idtlm2oCwo2nb/9s?=
 =?us-ascii?Q?tgqMrIeZn4zK7IBA6pK/PARuCd0j4xGDgulxneyAYv7SkC9Tqu4H3o5cMr1Z?=
 =?us-ascii?Q?jODzvbGC0gHfjeAV3NN2C2yS5oBWbtjuPGq1t+nRMnlOyujwzLb4c0zKlLUN?=
 =?us-ascii?Q?d/VHg2j+FZZ1D4UDGJINlyJ1aStrTk/j2f5wJ0o7fAqtp62OwfuEf3XuSACA?=
 =?us-ascii?Q?D9s5NXtL4zaJDP5tEfxQrFwsplmZBbRdb/I6D7/MJURyFxBQFouELYPwD1/E?=
 =?us-ascii?Q?7RwAWYqazw5bMkdFL5QnkDvp1JVk2++ejgqDzIf1wFLk76GqAgKnfff3Sm0z?=
 =?us-ascii?Q?VMh5pGbumrHd5g+6iwaYkM4PTFEszmvViKqj1jVuDunZYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXVbUzctAcscOb5vPfW93oGTktQ99sJlvR/4e6vB/yByGBPf2c2kQIeaOtFb?=
 =?us-ascii?Q?BikG9gnpXcgiavZ5q4tnt9yUEs/sXddDlJJYMf4N9TgiZK5ziNIzv5oTi4zT?=
 =?us-ascii?Q?vsntTE5eXf0B8oIZRkzjEcHQ36kyr28X6ygc72rP+6bIvV+Og3wLyiTiBmPv?=
 =?us-ascii?Q?R45GOQz8B/voYUedx1SV6FOB8WwA26N+hoioOBKVBVbUwyB0E28zCSeteZXL?=
 =?us-ascii?Q?huPWys4+zYkaBiTBxu4uJcPgJumectF4m5EwwuWJBuq5dNDescaFzsw+Smsq?=
 =?us-ascii?Q?4yf/apt0edHbLtdu7PCfQqRwZ+3Czd0Se6avjB2yfxJfLodKx6CspW46xnIM?=
 =?us-ascii?Q?oxR2encXGqXv1d5LfRF7ejADHOJhXY8D+z0HeI8RQnxD/fNRvm9IK4j1NeRb?=
 =?us-ascii?Q?Kt5cTb4nj+LjaQVJVMgxNClyayvo86EYskoryEY99omFqSNH3sT3EWTV4rR9?=
 =?us-ascii?Q?RMy4zZ+OXtXD+NDQQjzrGWf8EHmJrrfCKlx56QQR1oiM5YoKLn8xqGGDCUlN?=
 =?us-ascii?Q?56RgIzvKae4+ExJnjbwxb8d1prRhIBZW/exkhAjTgJ4GUkMAElUOO/u8yDTk?=
 =?us-ascii?Q?qwLw9sNR81eqheHaN2ZcuwUTSkmY56M1h9VvBEgpW8HReb4rT/cgXqLnnsfv?=
 =?us-ascii?Q?B4dSCkNhLt8DgXkrC5+jw2RESTl7yjIcsPCAoXCyEB27bT5KwNexqlth+rBF?=
 =?us-ascii?Q?/T8sEr0dt5cUtxq8q8D0XyEQ8KJd3wQeTTJu7Bua+HI17xnMiOsDhR/WpohY?=
 =?us-ascii?Q?zJR2hsAOMguPm4ebJ0/zK4GA/ZWZOOTHKWQldr+tPcTNudD870gx+LKwrjVp?=
 =?us-ascii?Q?rDCMHeEgck3iYSQk3F6fkzGfs6UY6PDaUBzMCPJDyG4mNPIe3eFVANHA9fyj?=
 =?us-ascii?Q?I1eU1T0Jdd2xIc9U4cwpGg6ABYFLvvZH36omnMzS1NCNq0xPQrH4hQKsX/7B?=
 =?us-ascii?Q?fFLHFl5t/GbRxps4uG5zFnbfqgBj4YEWnLfbadGMLHOwenR76LcDs6WocKwQ?=
 =?us-ascii?Q?WbTSyOPp6ZzsvRFT/ELtr4lPH/jHvytCAJTbOKDr+UdrQ5vlZbwgrzAy3hsh?=
 =?us-ascii?Q?IKnptWacC4xtAnFu/pdRFoHLAP+0svqVyQgDptmVYTFHbkrWKvbSIYsQa3m0?=
 =?us-ascii?Q?pIyqDw2Ux2X40x6XApuHw2foeFEG/vGVBfZgM2NqPKz0D9LgpIQyzvsG7iZA?=
 =?us-ascii?Q?paP+IfO3cG6um4Jwf9JvaF8CV6UlFKzrzKEJhGdyWp2Ti5j5YlB0YJvpPJV6?=
 =?us-ascii?Q?RIw3vhzlW4JgFG8nDL7j7eO5b6ysSY5MPB5FvS2r3vXsVtHJbDwL3rklLKVY?=
 =?us-ascii?Q?9eBjwiRmBLVGTi/hMMwhZgnC7x0GXhC2guo6NCbDAGN4DZ0K5uIhdnXzJZxn?=
 =?us-ascii?Q?OEmMFsop+V5QRI5XBAb6ugh7jUvUOyQpkEeoZ6p62FyJ3uQIITQzI3pEWgfy?=
 =?us-ascii?Q?RRCDg92/v31Xn+hAlOs5HgDg1ZanNpPzi0MUNvbWoQ6J8wYWzmhHcmp14nVt?=
 =?us-ascii?Q?cypvhYHGYiTJwBlE2tko2jwav3M3VHFiadOoSMGjdtHcRqUfKRSJcqG5VNN5?=
 =?us-ascii?Q?gWuq/Pk94IeE/MamZ7tQW5kW0fmhDeQ5tOvkVIM9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ed6139-6d61-4bdc-12a2-08dcce017bea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 23:21:35.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuvqupD13Mit0/r39AHIMaYjwAO/gRCUEONlbOauD49WNBD2I46oQARh7l0tHEFq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

On Thu, Sep 05, 2024 at 11:48:30PM +0300, Michael Guralnik wrote:
> 
> On 04/09/2024 19:18, Jason Gunthorpe wrote:
> > On Wed, Sep 04, 2024 at 06:30:31PM +0300, Michael Guralnik wrote:
> > > +#define mlx5_umem_find_best_pgsz(umem, dev, iova)                              \
> > > +	ib_umem_find_best_pgsz(                                                \
> > > +		umem,                                                          \
> > > +		__mlx5_log_page_size_to_bitmap(                                \
> > > +			MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ? 6 : \
> > > +									   5,  \
> > > +			0),                                                    \
> > > +		iova)
> > This can go in a real static inline function now.
> Ack.
> > Isn't is mlx5_mkx_find_best_pgsz ? It is only for mkc right?
> 
> Yes. It was written to be generic but mkc users were the only ones calling
> it.

Well, more than that, it hardwires details about the mkc layout inside
it with those open coded constants.

> > > @@ -4221,8 +4223,7 @@ struct mlx5_ifc_mkc_bits {
> > >   	u8         reserved_at_1c0[0x19];
> > >   	u8         relaxed_ordering_read[0x1];
> > > -	u8         reserved_at_1d9[0x1];
> > > -	u8         log_page_size[0x5];
> > > +	u8         log_page_size[0x6];
> > ?
> > 
> > Why is this change OK without more changes? Doesn't it move
> > log_page_size forward by 1 bit?
> 
> The reserved_at_1d9 is the new MSB of log_page_size that was not exposed in
> ifc so far.

Oh wow, I never noticed this ifc scheme has a scrambled bit ordering..

Jason

