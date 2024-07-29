Return-Path: <linux-rdma+bounces-4083-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1793FC0D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BD91F22573
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65615F301;
	Mon, 29 Jul 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mAXdNPbW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA581DA24;
	Mon, 29 Jul 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272761; cv=fail; b=ePwQ4NTeACZgq9A0o/JI3g7djMAIbRAixtHAXuVowMWvPBYE+xzlFePpg7uAxb7KKPeJEE9IUl/b1UHXGwqGMnOPgNDiyX/wINdn+oTx0nlEtJVak/yzueoH72IcxiGCPAZlMrGTf2GTJivwH8LAIZvHcMVPFiuTejVsrlzdrRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272761; c=relaxed/simple;
	bh=VsTe9i6womu1m2EBQihm2SzEOWLDOndjo4yweK+rWVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dJU8nuAX+HFFvApDRjtI4VczY4q7H00iMEtt3tHo2cGDTmm7KEhueujxxB3H6x93A2q34+vQyeEZ83kkDWv/MHBwD6JQOvJrXAAEQtuZiBbPE02ENSm2ul4EjegHxuI5wBbT/o+2qDtT3+ywAsAUt5Mslfvt9sozZfyqUyDdTrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mAXdNPbW; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ+18oODpZCU3pZzWN6H1vYYZLqq3IHqi4iOhWigeqCwXArDxORHaEcY6pXhtysKoXQl8MLs6oesOjXjtOcsbuA0rk8JdXZmzoS435IUa4TXHG6BEDRhgCg8XlXL8aXj9PYDE8sJy36LwQ7jpyf1U7iv4hLADFakc4BjRHJo04kHWa2B2b61viuRDBEbpe57cW85z3GL5tHRQZKeYVfaP8yG+0MQJyfodaaA5gh/vEFT/KUKKeYgopU6xIWuThoQtOwkutwRxEtqnwB8EVyBW3hWLqEcyM+t+XFEfecXKarV6v4wvg5W4OVEN2PIh033MJGlZE8fXN5Pe+gJR7XIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceLbXwdpk3s7MKsBLriqA0+2kDBA9bwyj1meM4593OQ=;
 b=psFE4qMYjnqeBHW9RmosY1e6EfgF6bnKwtmr/hnHot2E5LZFwVS8+ZIYI6TPbl/TZQJwx0+cKLbAfWUPMScRK2eIGqoD1Rt4gaWy1wjApkWaU7MbOhVIllIMZEpO9K5eEsmpXOdjPHk6fjtbfCwobCi/gq1xuAtSZI+YeIoOYEs1FVsCiymkny0GhXOkhqTGzRjUQsrbH5cv2hZnYZmf6mI5+j7pdPRh7Oiy0txo4x7G+5XZwX7zEmkQGR0rG1OPjDV7iZT7IWbzw3BuEdmCETZVp69P3vXgOWiHSokUl+pUF9IpFmEfHl86B3L1pdGw8UWOjR2ZabycvmDuodxGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceLbXwdpk3s7MKsBLriqA0+2kDBA9bwyj1meM4593OQ=;
 b=mAXdNPbWgP2BnbxCztn74Ui4C9B+RcsJcojQUfFJcciIeDZ5vpTLEulGFVR6zN0yxlPG7VkPELuOXDRN+4pO3nzgsrQbJZRZRrhRtP6hQTtRfArCtyXYwmw1tiCWlFIhmRmg2l+05R5hwHHcJwVXlwQCGvZNznakd1OojL6b1HWMMpFIe9UjNWfnw8/t0Sfn0RCRvSsEtQ4g8OfdIClWygs1qqUWLghYawkPWiT7e+q0bwh8H+YZKgLa2HP9mz3p1M6aZ5R13A4PSXlKent06b09cPf731MyQs/FASkPV3WHIsSdxetXRSlhrFSXV4mQati+MkyznMG2U4r4RGa+bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 17:05:55 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:05:55 +0000
Date: Mon, 29 Jul 2024 14:05:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240729170553.GE3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726160157.0000797d@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726160157.0000797d@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c602f44-4e5d-400d-ef37-08dcaff0b589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYr3OVJCQLK1SE9STPOHvpIMKdAeISIPKpUlZezd9kjiusOwId+3erDivuNH?=
 =?us-ascii?Q?atTXyeZ7ya0058Et2Uon3E0g+Ct5rdEP0AeYfMtQKmvCTXqxi2tL1ATTBwEY?=
 =?us-ascii?Q?ZXL6UHPf5cs126vCkOPfBT26q+QXB3iEnRqvErKSrdUSHqvyXxS9HrZPOFRG?=
 =?us-ascii?Q?B88t2TPlgFlrWfS/GP62Ib15RoQGwJfza/WFdhyJD1IRX6xUImrqvF5bl2ZE?=
 =?us-ascii?Q?HeJUZn70zG92dWwilTaJrZ3rzlhcwShKM4tvvcElDTbIm7WhAqk2XmhXI/b+?=
 =?us-ascii?Q?M2DiNKc3Rs6515ttkxUt6iYX4a+hqO+Jl5JNCbyePRJZzYQDq8zJS1ZG+t8T?=
 =?us-ascii?Q?mQd/lCfcajwwfjD8QgWCrfwLolyKCPlEoP8v3saEZoLpEv/TBK9T7LEFSfjq?=
 =?us-ascii?Q?aG/7HXjO0hcePtndOjdddy1iaVNqZ1L9p66J6SIYuibeXJ9T/K0qpkkr4Ww+?=
 =?us-ascii?Q?fJgP0ybOuC+dGc097dzJKB57BgVRPIchQdDSsZFdOQOEYczCj1Q7JPUnSzuv?=
 =?us-ascii?Q?VIfc4RRR1IR9XFC1DbS8kbkarop4AV0KBZG8sMVIOu++psfhOrJGRmNwJsLZ?=
 =?us-ascii?Q?63Fm0KhWwXEoZuZRu4501gW59TT4Mg5xhiyqcuhyH/BYs0ilCLy4Q+xb+kze?=
 =?us-ascii?Q?Ul2atnE6y0nw1otgVgPUktGtnlyllvwFRESPJuGH4EkSmkQ7VGbpnPtBGjOI?=
 =?us-ascii?Q?KWqf3KifawV505fAXRhNnKEiJSBAS+E0+qp6nbDs4+JGKLwFEECD5tDKEdaS?=
 =?us-ascii?Q?snjA4QPypv05hhWfH60vhmVSK4Hx6VAOzCSRBKoLiPPPpOXnWuevDaz2Qzmx?=
 =?us-ascii?Q?1MM+ziwvlB2bQDLAQZ+ajKN5/zoKCUux/IolHrGWRH67tlhqfp/1x0MZmHbj?=
 =?us-ascii?Q?KVaLSaQ3sHtv28jRU4yY6azzBPsZ+T26FLWx/JeCq0wuGoLeIquTzRY3m+sN?=
 =?us-ascii?Q?1CaUV3dIV1SaDDlD/rgcud0La3DwkmuNFvF4ShfHQcU5nPu7asR1HBGp2Y36?=
 =?us-ascii?Q?AzPBl1fb1om0/EA53y1pmMSTie3kN1RO1SnASK72+J4PjiROjB58HJti11ec?=
 =?us-ascii?Q?MSoZFqPOY/AlkUECPk28R/47ycS9/3yIH3QJPTc/zB/gDYpwy5XOGNT1N1eH?=
 =?us-ascii?Q?h6CvO6xynrPD4n2xamPACreTN1/oKuTxYoT9oqICdBZbgeYNhlTfiXBJrT1Y?=
 =?us-ascii?Q?wcXw1lkI95rqcl1aUmGRRo5BQS84jHLVHPH8WgLcbiTnvlKssJWtVln/YF7P?=
 =?us-ascii?Q?uxqgIhtuxuO79P8xlAKMwsNA53p55ffvioUdnp/sZ248TPZR68jynJCGqyMe?=
 =?us-ascii?Q?s6BFj9N2+s5RhNgT1iUSWAEuS3f/1VTeQj17JNZwLxDAaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?srNhLUZxHWdc+qMTkhKz5ZN+ziSNbXOkCIgtnb+1UWTYhvHvnNJRv5/tLliA?=
 =?us-ascii?Q?EedzCN918QlsEwNVXgGF9WPj9QJthIDw8wEeIx1WPWrYsTEsrJVuPtZV25M6?=
 =?us-ascii?Q?ECs4JUHj5B2M2umxS+e253Cg7pw+Qd4MPFXQfuear5ZcSDF/LgLW5BGWGGDW?=
 =?us-ascii?Q?8IErISZ9ryChxN/Vf0n0uIdoL+WCwe0xjDdI3Zw7UBvdB1iG39Ktaz9BJWer?=
 =?us-ascii?Q?PFkEknEK8+IT+V/o6eCnfQUun9NUyTENFrgMpva0mOrNvfGEXBYojagjV6PM?=
 =?us-ascii?Q?GkKOXmY2g8KyXN0qrFAXC+ZVhtLmrL9EBTGHCwUCTNOGXqnxvuWUmQWdr8WW?=
 =?us-ascii?Q?Holl9rHhsHibGg1T3fyqVsRbRUBPL5AeFb/5HcjWzBIS4RcnCQaz8iSLYW5Y?=
 =?us-ascii?Q?A0VKMGqdcjYXpC7HGzzger9WA5BlHluo9yWEZdNSMjmjdCVRSF/h+8W48JMl?=
 =?us-ascii?Q?53rVzgjP6MsHuLH5ZSTuEW+WVrmar+XAa/bK0F/kvhLt3p3fleWUE8N+uzxE?=
 =?us-ascii?Q?cIWxT6NFluyNhDunqtN86YDo1mpwiRzlsAdhb9Qdpmu0uhmyZ1Y5j7EC53uf?=
 =?us-ascii?Q?Mhkr4PKJ0ozbCm4k+OhTjO9z39LcrJeYfGVRfPBfR7lykzGeGPDt7BSX97wn?=
 =?us-ascii?Q?kJpxtuLjbq98w3gqcTwPW5wdpKDD2047Br1FmF5pAy9a3DAX8CQI9vQaXOMa?=
 =?us-ascii?Q?QH1lU0W3k5D/3c7akZhedPsmdTtlstjmPdXqN12xEvbyc0CieUQwWjSofmhE?=
 =?us-ascii?Q?G8FMwwRgSzuUlZbQ9urMCXb3sCCAPa6Ljp7sLR+QgqnqFsl2MID8d6HVx0je?=
 =?us-ascii?Q?0zz1KE4kMa/0v7Ro3at2nb3k7q6LMfdGTOq6pHlnPUxml68OGbEW7k63Q/Zh?=
 =?us-ascii?Q?y/dQM1fcpIKolQ5g+usFIvG1NFvGNzmv0haZH0WSCco3PaIsh8aY96vVER1k?=
 =?us-ascii?Q?KcMLVzdibxWlDTPO0gAUeyGBEfSEppsPGA1/d/zh3eJ20QMG0A55bF0rtBHw?=
 =?us-ascii?Q?eVEROubNdErBtXdRJ0p1/HeHFRhxxZ7R1WLrkp8PUVS/e7TKSnVQsBbt+uS7?=
 =?us-ascii?Q?EqtflInEkS2/uoPpnBTyvK2fmYv6shtcvAbLV3XaM+qSpza/d31ugagA3+54?=
 =?us-ascii?Q?VNIXem7CLD/4so5eli586Ho8Z8k5UrOB8jNGbElnTzdkPiFSQUr2fThUhUpG?=
 =?us-ascii?Q?V3oGik8c3u64KtPmCm0p2GDwPxzazQq0iN6rApkUXdixtVKtp7HXLw/VQ8fo?=
 =?us-ascii?Q?711LuH2rIn1XVWDgvhuD8XDpagvywEZg632kBdKwDarxh7X81+/jMD5t+ILd?=
 =?us-ascii?Q?yWMAwEbBSWCnpqi/QAetdjV9tGAy788XpeF7Rw3GhLGxujQ6F3X72WaqQaQd?=
 =?us-ascii?Q?pY5XCNRnwT07t+ho51M/G1yLlLoDuTsY5g6NX9gSnrzYD14v67/PaSxApVfy?=
 =?us-ascii?Q?3xvyJny28bU0GqaY3F6XylwXNgSXxMFT9RzdQ6/khUKNpbGhMJr3e4bMQCtL?=
 =?us-ascii?Q?v4VawzPZ30/eMI2r5NxFJvOSf76OM08xY48SE3Ne8p3kXsuYwNJqDPjml8GL?=
 =?us-ascii?Q?7IXliSSzfos/1dV2la7Pwzd20hS7iEFXKzwtxQGq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c602f44-4e5d-400d-ef37-08dcaff0b589
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:05:55.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDQmT5ecrOwBE0oXpnhYssKPD3jelepRc4sRXtEDMrvyyG0kvh6f9JoXchoYEz2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

On Fri, Jul 26, 2024 at 04:01:57PM +0100, Jonathan Cameron wrote:

> > +struct fwctl_ioctl_op {
> > +	unsigned int size;
> > +	unsigned int min_size;
> > +	unsigned int ioctl_num;
> > +	int (*execute)(struct fwctl_ucmd *ucmd);
> > +};
> > +
> > +#define IOCTL_OP(_ioctl, _fn, _struct, _last)                         \
> > +	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                        \
> 
> If this is always zero indexed, maybe just drop the - FWCTL_CMD_BASE here
> and elsewhere?  Maybe through in a BUILD_BUG to confirm it is always 0.

I left it like this in case someone had different ideas for the number
space (iommufd uses a non 0 base also). I think either is fine, and I
slightly prefer keeping it rather than a static_assert.

> > +static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
> > +			       unsigned long arg)
> > +{
> > +	struct fwctl_uctx *uctx = filp->private_data;
> > +	const struct fwctl_ioctl_op *op;
> > +	struct fwctl_ucmd ucmd = {};
> > +	union ucmd_buffer buf;
> > +	unsigned int nr;
> > +	int ret;
> > +
> > +	nr = _IOC_NR(cmd);
> > +	if ((nr - FWCTL_CMD_BASE) >= ARRAY_SIZE(fwctl_ioctl_ops))
> > +		return -ENOIOCTLCMD;
> 
> I'd add a blank line here as two unconnected set and error check
> blocks.

Done

> >  static int fwctl_fops_open(struct inode *inode, struct file *filp)
> >  {
> >  	struct fwctl_device *fwctl =
> >  		container_of(inode->i_cdev, struct fwctl_device, cdev);
> > +	int ret;
> > +
> > +	guard(rwsem_read)(&fwctl->registration_lock);
> > +	if (!fwctl->ops)
> > +		return -ENODEV;
> > +
> > +	struct fwctl_uctx *uctx __free(kfree) =
> > +		kzalloc(fwctl->ops->uctx_size, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
> 
> GFP_KERNEL_ACCOUNT seems to include GFP_KERNEL already.
> Did I miss some racing change?

I'm sure I copy and pasted this carelessly from someplace else
 
> > +	if (!uctx)
> > +		return -ENOMEM;
> > +
> > +	uctx->fwctl = fwctl;
> > +	ret = fwctl->ops->open_uctx(uctx);
> > +	if (ret)
> > +		return ret;
> > +
> > +	scoped_guard(mutex, &fwctl->uctx_list_lock) {
> > +		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
> > +	}
> 
> I guess more may come later but do we need {}?

I guessed the extra {} would be style guide for this construct?

> >  static int fwctl_fops_release(struct inode *inode, struct file *filp)
> >  {
> > -	struct fwctl_device *fwctl = filp->private_data;
> > +	struct fwctl_uctx *uctx = filp->private_data;
> > +	struct fwctl_device *fwctl = uctx->fwctl;
> >  
> > +	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> > +		if (fwctl->ops) {
> 
> Maybe a comment on when this path happens to help the reader
> along. (when the file is closed and device is still alive).
> Otherwise was cleaned up already in fwctl_unregister()

	scoped_guard(rwsem_read, &fwctl->registration_lock) {
		/*
		 * fwctl_unregister() has already removed the driver and
		 * destroyed the uctx.
		 */
		if (fwctl->ops) {

> >  void fwctl_unregister(struct fwctl_device *fwctl)
> >  {
> > +	struct fwctl_uctx *uctx;
> > +
> >  	cdev_device_del(&fwctl->cdev, &fwctl->dev);
> >  
> > +	/* Disable and free the driver's resources for any still open FDs. */
> > +	guard(rwsem_write)(&fwctl->registration_lock);
> > +	guard(mutex)(&fwctl->uctx_list_lock);
> > +	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
> > +						struct fwctl_uctx,
> > +						uctx_list_entry)))
> > +		fwctl_destroy_uctx(uctx);
> > +
> 
> Obviously it's a little more heavy weight but I'd just use
> list_for_each_entry_safe()
> 
> Less effort for reviewers than consider the custom iteration
> you are doing instead.

For these constructs the goal is the make the list empty, it is a
tinsy bit safer/clearer to drive the list to empty purposefully rather
than iterate over it and hope it is empty once done.

However there is no possible way that list_for_each_entry_safe() would
be an unsafe construct here. I can change it if you feel strongly

> > @@ -26,6 +39,10 @@ struct fwctl_device {
> >  	struct device dev;
> >  	/* private: */
> >  	struct cdev cdev;
> > +
> > +	struct rw_semaphore registration_lock;
> > +	struct mutex uctx_list_lock;
> 
> Even for private locks, a scope statement would
> be good to have.

Like so?

	/*
	 * Protect ops, held for write when ops becomes NULL during unregister,
	 * held for read whenver ops is loaded or an ops function is running.
	 */
	struct rw_semaphore registration_lock;
	/* Protect uctx_list */
	struct mutex uctx_list_lock;

> > +#ifndef _UAPI_FWCTL_H
> > +#define _UAPI_FWCTL_H
> > +
> > +#include <linux/types.h>
> 
> Not used yet.
> 
> > +#include <linux/ioctl.h>
> 
> Arguably nor is this, but at least this related to the code
> here.

Sure, lets move them

> > +/**
> > + * DOC: General ioctl format
> > + *
> > + * The ioctl interface follows a general format to allow for extensibility. Each
> > + * ioctl is passed in a structure pointer as the argument providing the size of
> > + * the structure in the first u32. The kernel checks that any structure space
> > + * beyond what it understands is 0. This allows userspace to use the backward
> > + * compatible portion while consistently using the newer, larger, structures.
> 
> Is that particularly helpful?  Userspace needs to know not to put anything in
> those fields, not hard for it to also know what the size it should send is?
> The two will change together.

It is very helpful for a practical userspace.

Lets say we have an ioctl struct:

struct fwctl_info {
	__u32 size;
	__u32 flags;
	__u32 out_device_type;
	__u32 device_data_len;
	__aligned_u64 out_device_data;
};

And the basic userspace pattern is:

  struct fwctl_info info = {.size = sizeof(info), ...);
  ioctl(fd, FWCTL_INFO, &info);

This works today and generates the 24 byte command.

Tomorrow the kernel adds a new member:

struct fwctl_info {
	__u32 size;
	__u32 flags;
	__u32 out_device_type;
	__u32 device_data_len;
	__aligned_u64 out_device_data;
	__aligned_u64 new_thing;
};

Current builds of the userpace use a 24 byte command. A new kernel
will see the 24 bytes and behave as before.

When I recompile the userspace with the updated header it will issue a
32 byte command with no source change.

Old kernel will see a 32 byte command with the trailing bytes it
doesn't understand as 0 and keep working.

The new kernel will see the new_thing bytes are zero and behave the
same as before.

If then the userspace decides to set new_thing the old kernel will
stop working. Userspace can use some 'try and fail' approach to try
again with new_thing = 0.

It gives a whole bunch of easy paths for userspace, otherwise
userspace has to be very careful to match the size of the struct to
the ABI it is targetting. Realistically nobody will do that right.

Thanks,
Jason

