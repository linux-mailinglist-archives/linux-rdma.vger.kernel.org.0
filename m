Return-Path: <linux-rdma+bounces-3526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79049185CD
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F828655A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E969D31;
	Wed, 26 Jun 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJzxipOs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4D18A94A
	for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415736; cv=fail; b=P3i3GtiVjO/x/PMF1ZVLg0QKH3Ptj+du8AQYxOsvVYHelqysrtHOQZcYeF28qWtxERgNzWSGcaGvh1w4LeCqu6eqmg+f7wU+WaasJ/RXpJvdMJsKyXojkNEscxIyKHnz5TkcQ4+yUnUrAavDvdYV/CNpYCWkMByk7vaxVotlFhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415736; c=relaxed/simple;
	bh=0y6eNS+JyBAjc/n/x0LSxF6dgv2nRZRbzdaysJRDaN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YnnPKdNVusweYY3AISi4Z1B4G90+zxIj89TH6fwoi7IxaO1AZlf4DrdSWyC0jkuflQ0HJ5tT8V/lJL63GqNVxxs+wl4DQDDzm2WudYsOroPvLhuTF2tKYG5PlzxRqYe1ITNJRnhcC1U11mVZlSAXteV5hZ+To+sTonxZXtYoPvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJzxipOs; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEvl+ZMFZfB9aBwbGwMlxI2srFuFrUqhq/g7Nx74wSmkWGguokpsW0rispEJyBjaHwdSDKV1tZ+sVH99Q2+pmqSdOVhigu+ThK4fb2zNoBt4qZ2USHna4eCqSCmluV+IkbFRAuaE1pAxM2LiOfzLSvRWk0tNYL/Iwz90JybRaWeElk4meCXin9Wz0DOAiyefGKPOMJi4WfoBsgQCkTGpS8SbNq/J2huQ/SwIsjUPG6QzGlfSUURH3H1mF9zKwRqrFohb0Mak5PS93cwlwCeeZ+Kg2Fa2GUmTV+D/Ch1q68rgEzMvmAUr+J24vUXvd6pBrVX3QzUjRJqPRtFvXeVreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh+hFsqLFDBMZBIeFK5YI8Mb9zYxqQ72cM6cC8putTU=;
 b=NHJFmjI7E/eo2rqqUnabq57fjqcVwJxvbTqdnLQzYq8x2/Zh3pJbd7zSLevYNf05lMrLHEFESwuu7IQ3Z3pFplYwzTYIbFjdfJnWSoHv1gkCbUq2o2gsjmsKXfEWkruAbWTKsG2rhJcmDj37jkGgzKiCHv3tbJV3bqEDhG8uj4j8sJfg/0IicfWf101B/Ttwjbt1dur7+r+fhJXiewfmGM21IxoUl7dydT+cZB1/DXHqAx8YzYnLoz3vkUim1HXCHRlF/lIzQkJfqxS2m77LA3dreaI881q4bzaJpv5jir23q+lfuZPqmzi8AWhSZTiIKYH1jiXbhkk8GUcyA074Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh+hFsqLFDBMZBIeFK5YI8Mb9zYxqQ72cM6cC8putTU=;
 b=lJzxipOsMNu2lIcqfcdknyEYGh0wdDmesJOmWJPRenD4ZtJwxILbZqGJnVofw/fzPB6RKDXSjyqwry7tXM1UfYGaMMy3lgQVe8liTZNK2aYSo3TP7kgGAwMltv0dm/eB5EB03Momm1Yn/o9WTvx8z1iN8tTjXe79HeTcYHXdmndUx7E8agzgI0te7Z0id5TFXf3UI6HjWftlj/cE8gLj1h9/YdaD3bIMgsqbDv2/MAudAbDCdV0pJk9h8I/YLwKFdWcK+s1QrydNjhXxryivTr99mUBM4/fyjncjzRqj8+sC4wwGcLrFEHF0bXeUj3+6ZNLeHU6Rr0in9dWNEGkdEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:28:49 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:28:49 +0000
Date: Wed, 26 Jun 2024 12:28:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH rdma-next v1 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240626152848.GG2494510@nvidia.com>
References: <cover.1719244483.git.leon@kernel.org>
 <d9f70aadfbd0739472988610055ffe102c2a61fc.1719244483.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f70aadfbd0739472988610055ffe102c2a61fc.1719244483.git.leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 82726475-1506-4296-53c3-08dc95f4ad97
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEan7ZJEHuN/Ynb3nJzQ2UNvTqJuOJowce1u+EegaXJkVFMFxahw7r2JNyzS?=
 =?us-ascii?Q?JQn4CQID6bho7qLqEArAmcsjeVD2xZX4Rd4M02kp+2rjYOC31rdZyEIhGTZ5?=
 =?us-ascii?Q?ZhnXXqMYkZ3jZ8birgo4/4Ptp+Sc9+56EczfBZsWAxbobgFmXPYjf7LyPbWb?=
 =?us-ascii?Q?4drG1GixuQ4jOWlUwh/P6si0FOVnGI0RcX43YWnuW+SLgf8SH1+SCky1sKqe?=
 =?us-ascii?Q?p9JiBpEQv+4Y/Dck+4j09WGstKN/IqSTf9Ihk2O1VJ7g720MyGPChbehNJ+S?=
 =?us-ascii?Q?5Sgab8v8YQLgDFqhxTLTafaMu6ZyWifOe8RUQgiRXQtnhZIuLKD+vlJSu2oR?=
 =?us-ascii?Q?GHqJDZcGn5UASnwmsUqNGm7jr4sXAWOXRuvcLQ/p6M04glEOSKm+UsYYYyVF?=
 =?us-ascii?Q?3TVap+mlosG1/cfYrkCuVPSUF+VPXJX2clCDpdi3kcFPuWDuvM1H7N7RjXSb?=
 =?us-ascii?Q?tqHClzBfN9dVEqljr+10RJ4v81Jffu+W61Vxu/a2ROXxHmjhi543t6EhzeoQ?=
 =?us-ascii?Q?g8tCnCqED3502mEg4SAdeRN0xlE1SiKqh4H8NonFiS16jXblBF/EcM33S50V?=
 =?us-ascii?Q?JEOBJHX0+ApDCQFRrPE9kIuHGRVmmsMCgWHlqwV9vHJeFXkL76i34RVlUusY?=
 =?us-ascii?Q?IkKV6oyVf6K1/OFA5td02GAffMqN/I+3+KdMQh8Uek0ZoxwrpYUUWVyh2Qxu?=
 =?us-ascii?Q?wETcYXCrrUSWBK+3F2COMkTuGwcQ+9zGTgtchva+vAPBVViVSu8PPWOypqP8?=
 =?us-ascii?Q?4LsvkWxBsq9iIF1ZhFA5ZGu+VXOATKtbohtBhh90kukJpJoR8ou3ZEvRDicx?=
 =?us-ascii?Q?Li8+Mvnzw69/A2ddvgHAD+mQhfzWah6MLZMBztO8HALmV0wlNoa/w+xv4F8B?=
 =?us-ascii?Q?qIlQBcbcHH9UppQS3l3gfx76EbkpsCymgxmbB1Tivh1hU9jA5IR5lrR1ocBi?=
 =?us-ascii?Q?WP5RMx7pC/a5idx1+iXagBOIsUxzTMdQuUd1h9zpy2bom294G5GyK4Uxs8Hl?=
 =?us-ascii?Q?ZHRR0ik3KpI8aJ/EBK4T5jfbYm4gudh3f5Mdcsq1jphY4dfrreL8uDkbKKkt?=
 =?us-ascii?Q?tRbULY+PJztjwPXNtQF63/Wh4x1q3CDLPR5nSmbRVc+rvlvljXALiYJaM3os?=
 =?us-ascii?Q?Voqi5ANe/OkAz4L8kpFdXaTtL1Bnc6tJyAcLwx6jwkiMTx9R3LO3EouImxor?=
 =?us-ascii?Q?X+/o5mztFeLnV41weCrWRb3LUXDWV8r2CRLf8Y0zgBt+2uKNkCaZFjDfz34c?=
 =?us-ascii?Q?k4Xnavtt/St3CS7NzYk7tNYC2AtbRv9/QaBcTM1tof0qmbZlaI969barTFXf?=
 =?us-ascii?Q?RhlyhSc+zee7tSIedcL6LveQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uci58YKFT6MUFwEJSCrrSyntQYV5vz1iMubWDILw+Pdv4VP86rL+4Tc7L6Hs?=
 =?us-ascii?Q?BPixRKYr+u3tE0GckuVDipl9ucpJ+5nEVYpz/960+ZLyGrXx1r2hsVkiRDk3?=
 =?us-ascii?Q?Xgc+4vGQquxr9l26PBG0O0JMgmfIcq+xzcONUP172h+8/+JRSao91U91/mfY?=
 =?us-ascii?Q?GUI9AGubM2pPElmZ8yZFfh6yqhz3I+M/QZC/45o6/GA67x44qx/QPYWWn1au?=
 =?us-ascii?Q?6FX3rxvhAnO8s5Hyy8ubrI9A2+d7Gm4yUiT4KrY/59cNdpzLC4OuzNCau3j8?=
 =?us-ascii?Q?JT9RdT1IxdpdBG4VaV0Ooaz2JztgaxJZICEo03ptnmO7mriGg/ZZKjQb2fQj?=
 =?us-ascii?Q?T00oOKHCNMPdCPUQtLMIQnwmTsvrugnW+I4x19ZDBn8Ct2MZlZrycO4O0dcC?=
 =?us-ascii?Q?tLvKiaCdEtPdRJLd4BHCGxc2BiO14pgnn94bQqO1P8zbTmQ/D7cTpoIMgRiq?=
 =?us-ascii?Q?svR9dSNRE0K8jHg6htbB+y1P6tFwn3Bc5FQMNaRX2+YFzfdQ0k+ARoLdHLEB?=
 =?us-ascii?Q?BBFWyHwHqcvJIWln1lRAxxlhlecnmoxbdqcGg2AOCdMzh1CZ2slmvP7q/fI3?=
 =?us-ascii?Q?srk0ltG6O13ZbBji98glA9dVrdPYabT8AO6HHLJfCfebsZ82JGW8b2Oi2qJM?=
 =?us-ascii?Q?6BZd986QYi6dj4PNE7ZoHL9Wm9CS5vyHAkBiGYACzeBOdmTw7usNLPdhscmu?=
 =?us-ascii?Q?y9+VHHthkdLdeSlmJFqu8Xc0/kQZTS6D53d7cfVpYaR20qHqvFvg5izItC+m?=
 =?us-ascii?Q?khwYOgvjt49BHXwrA8/4i/a+e99BownGCFktegcA/QgYj6dPj+EfsX0WyOBP?=
 =?us-ascii?Q?xqIMq0xFIV9Hn30bw5VXKUvWEMN7QmeTWKDITi7IYxB3GQd8ty7yTdIzoW+F?=
 =?us-ascii?Q?T7JtUH3B5r8ZZkDSxJqq5dSNO59I2pvoioW5NpkaHHCwL8CnvGzqrVDsyltI?=
 =?us-ascii?Q?tjGBRQDIGuQklsO0gXOTX09K18yTnn7NpDGtLPiqnWw2RebLAtyRzTDTrxFD?=
 =?us-ascii?Q?JJmyCtmtOO2T5bebb3bWpQKVflBHbY683nxRq0iubpRDfg5K+7p35uFq6GKb?=
 =?us-ascii?Q?nfUj8ZTxs4Gg6Y85JAmxGKzJR6k1T8zy2csSRv66yhVUHWHJ5dqsHYQuMqvB?=
 =?us-ascii?Q?XDzegkXTkO4g+CfMI/ulVvAf2YajqWlj+1bXT7JFUme4X3rZ9xWLG+F8hm/1?=
 =?us-ascii?Q?DEtrWJTyC/xG8gdcyIJGo+rTsu3j0dUizEEaCX4KdPKXpYJntNtvssqzVxKV?=
 =?us-ascii?Q?G9DUIVOJtV3H4NiO95wW1zvSRaqoPxRAyO8v+2x15t9wc5W+hLBh2kQJ5S25?=
 =?us-ascii?Q?e3J/ptnerPJFun/lqcaExECNP91N0IFU5CmLZ5JtT8nRO01HVgTidfE8YE7z?=
 =?us-ascii?Q?hQqBj0/Dxn2F0KP++MGNwEmx8Sc4mo1CWpf5Pe37zJeYCe39kENrFST8tozP?=
 =?us-ascii?Q?KHXB2ZD6slVhNzjmS1mhcsNgfonmEY9D87J0lHXc2Lzn3u9Y+rya4spqiQME?=
 =?us-ascii?Q?WmKosJgosZFl0LH8NNb0veQXs5lmgxPwVU9lVMqlCPtFj7zBkZrh/ttZM1n4?=
 =?us-ascii?Q?8RzCpdEPLFwbSXA75XDeK74DNedvii0n8Dd34bg2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82726475-1506-4296-53c3-08dc95f4ad97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:28:49.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJb63qzWREdV6MXUXIAZQWAnUPVl4wO8OzJgov4TfUxCA+AztTIUIXQSzohgTmZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

On Mon, Jun 24, 2024 at 07:00:10PM +0300, Leon Romanovsky wrote:
> From: Akiva Goldberger <agoldberger@nvidia.com>
> 
> Changes the create_cq verb signature by sending the entire uverbs attr
> bundle as a parameter. This allows drivers to send driver specific attrs
> through ioctl for the create_cq verb and access them in their driver
> specific code.
> 
> Also adds a new enum value for driver specific ioctl attributes for
> methods already supporting UHW.

I was going to pick this up but it doesn't compile:

../drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c:156:15: error: incompatible function pointer types initializing 'int (*)(struct ib_cq *, const struct ib_cq_init_attr *, struct uverbs_attr_bundle *)' with an expression of type 'int (struct ib_cq *, const struct ib_cq_init_attr *, struct ib_udata *)' [-Wincompatible-function-pointer-types]
  156 |         .create_cq = pvrdma_create_cq,
      |                      ^~~~~~~~~~~~~~~~
../drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c:814:46: warning: shift count >= width of type [-Wshift-count-overflow]
  814 |         ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
      |                                                     ^~~~~~~~~~~~~~~~
../include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
   77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
      |                                                      ^ ~~~
1 warning and 1 error generated.

Didn't get all the drivers? Don't have all the drivers turned on in
your kconfig?

Jason

