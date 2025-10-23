Return-Path: <linux-rdma+bounces-14030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F9C02A5B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC581A6172F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375433DEED;
	Thu, 23 Oct 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3trElot"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E974322C9D;
	Thu, 23 Oct 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238742; cv=fail; b=Qww+l3HCMtlfYD0nOirm8kxWRHcjcGEior6Jvo/e+kesjr5+p+jwo9mq0ZL9t8C3d+ewlLJiIofv1rCxTVl/FM7tn3Wci+1jhUqACZHvWqRzufBuRBBUlrdtJpqqXLCxtWAbs9B2mzXeFniJOLSIfk6Q1lmvVPPeWJ6LL17V/TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238742; c=relaxed/simple;
	bh=R99v5Ua+uEZHopaE6irteFr/G6AgWEn4ZzBOMDhuH8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWU+xuAPchyenFAOihdowu+F7/Ju+SIhxKEAoU9KJD4bWO8gkHOFXh6cdYrTYpL9Bk1jWllHYr5QVOA0V+oTWi+rOzNvzgFv/IYVYaTDNrX+ziwxFADjN6YbCak1PS3nAXfCHNLxBoqmdQJt9/lSKc1KSNUpxusPvdn/kePTCnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3trElot; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC4pQT5/oZQp0nADfnuHiRl27aFb3jLZLYAcr3p9+N6EVRmmXwgfEDopPUy+G7QDXOLfE7+RuQIhYt3XZTdwFdFoYkCzFmM4K8iJbHcwtqDdy133W0lB8u/xdROmPFONH6IEswOFtp/QBCLMbx4PAjwbYY07iKmyfxbH/AisS3wEOmpbEApVnqEThodB1hGIoDyfgMN8FKUVWSm+S/botRqoI9gQ+98CjpaSrohUp9KRiab6YL3vBD6i5nu8r6uDfbks3I5hVSzZxmsTq73ctk04MMnFYnjGz0mQHgaw0cRnZdr9eGWmNWQPvr0YxsgVM+GiGS9hDnWVLyZO52S37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZE3FlVbVNkRlgwHcDRLTLRrjkegvQIvyene/gJeqMY=;
 b=ggWPSbCA/lfoaNbAQ455DLb5ecOGhE7GRJxwJptKRnrD/1t2X2TY6UVZwwoUi9tH7aZUsSInFs8tWSkYepS45MGv0h2Fa+haURa2CWwfwXP/VnanHW+46bnyXaNG+jU7p5MPszGfBBbDadvh1ingQ89u40OTHRgpqfQAeCBFGcuLjIHo9Ff0q1zf4KLG61BsxZBIzAyHun0S0XY/WjqaQ2OQSnDxUHCNTVK9vq0P261ZfUeSLRUCp+WY9fl4KAy5p+umoUROM+W01CXsOEG6lGkigdwRPC2YIZJ4yA3+e7JsaYijpxshnGR3qsGMwAM/JAe9ul0FPuvTyHC60d6vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZE3FlVbVNkRlgwHcDRLTLRrjkegvQIvyene/gJeqMY=;
 b=P3trElotsDUj+iDerQBTc1JZd2W0vj/ViMZS61EP5xRQ570DLPIm++xkg8D32t4kj8Cb/oCbjfx78NXH3DGf5+Mxgf89PPF+yrsg924HG2DodhKhcrrjPJdvHTmxe2zo+2gF/0Gt/hjeUmRpSKFIEHmTmlm/Ulr5bzfEav3N8/6yZrVU1KDluGsEE/s7dQM40qm2gagC1jnMVCh0E3u09WLZ/sMChvqpX1L2xJn4AFFRU/3oXUFLasX1Ri8rm/wocydY/2enekqqYPVNoXy+ekyg+OH/luQlI2Vj67r9bYvuijLoKcH7b6Hve2z9+nIYN8YcE6m42PiTOczZQ4EKXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:58:57 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:58:57 +0000
Date: Thu, 23 Oct 2025 13:58:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
Message-ID: <20251023165854.GA742380@nvidia.com>
References: <3-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
 <d594cdf2-5aab-4539-8d44-f7e57770df72@arm.com>
 <20251023145434.GJ262900@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023145434.GJ262900@nvidia.com>
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e6977e-d3cc-428b-d8f3-08de12557470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2yEwHtqPySWvqcJrey9EEidWQiXtn/UmWmWhs3rSTPCd5bQ6/dSRiDVmkdC9?=
 =?us-ascii?Q?2Qi6L2EMgyr95tToOlkugHECpKlXmNIhWUKzwGqqf95WX9bjm0vKYGUqyHWf?=
 =?us-ascii?Q?qIypQf9BX26fr0QDrmlraOG6j78QmUZbAarhD6UySS1iiUBosCUJWFMZv4Wz?=
 =?us-ascii?Q?PkvyAqMBVErJPGd2zpmt1uchr/iOQoo8oImHBL27eAvTy8Up+E2R93GwSXO1?=
 =?us-ascii?Q?hMQXfAI8Ij9iX1p+lvVzPKTQtEepoau2QUTBt+w+csjOBMgomziiT2H31MpE?=
 =?us-ascii?Q?7HuM0PI4Oktz0QqAuayni4sWWGt7wICi8pFckN1HTb3DLhCbswwIDri4zobG?=
 =?us-ascii?Q?IDgF845G/wROm60U2PqVeJcXj38wfv1C6IWkY3SZ2y6XHpcSe5F0Wg0A6Mr2?=
 =?us-ascii?Q?Tw3eg+jfnpZDUmEdVXr0WKpxgrW2n48qrUGiVTJERj1p3a2shEx0Rqf8X5bX?=
 =?us-ascii?Q?8uvJVMFUg0amw+FCrtowrpJU8IVUoyhn8deUfkpyy7Ins7TwY8vsCvVDFM0S?=
 =?us-ascii?Q?o+fne7F/nXTZnq7UrsgC8Vp3H9WxKMdoDhPI35/1cwwn4dhwPfaCEPv4abxI?=
 =?us-ascii?Q?SPX8p1LCKon8kjga+Pd+/m0ws7HQCpGgO4EYilgUdfqfqtZ+eYVYWEyxYsTh?=
 =?us-ascii?Q?Lqwqd6mXbFt+h/jw8qBoc1DoN316B298OMLLsdfzdjpZ9v5SwWlNz3yOs6Uj?=
 =?us-ascii?Q?r+ASsGirCT/91nTB4IQ8KOjtANffFVd8ME/kNKnMgj2kfB45NRaZ78KjJpaX?=
 =?us-ascii?Q?IYgrongNgam7Ci+ERlsLgMmQVRHLqk9xfyVLwz8wRF0zz+TGOcVwd07RxICz?=
 =?us-ascii?Q?I35P1hc5RrMh9GWa2taHohfpVfeOE5L0qQM8ziC6SdqEFNJ/lTWjVOCwdgC+?=
 =?us-ascii?Q?Fh87k4PYouj1v5yrHxf9G4VkjQzD8LZPiBtPFNJp50AtJGt2RC/eIFTqM8Wb?=
 =?us-ascii?Q?PEi3UwxEqrVYTj41D0AS1EKCccq+NXYNN2ph2t0gztWZCYBj2rYk3vjUbC90?=
 =?us-ascii?Q?koFuU0din8O7u1oAB8RxCKiPWKkeTu8cyZcr7/IIIhUXc9Vh850krGVzdfKC?=
 =?us-ascii?Q?YhFqAopbkDOGrD+mGDw7xXPV9TUizn1digLV+kqAGRD2ohQxSLQuYuI9KsAg?=
 =?us-ascii?Q?Dp9kSxYh5Ozt/ESiuRrOUNf0rata9NFMpDsBbmYpzMFYp7qNrpI7JqpbIWwv?=
 =?us-ascii?Q?UorlCQwR3/zKNw2EILFtevDyGLhjKANaUnj6ELkH2rVJIAHc9FahzhA3brgO?=
 =?us-ascii?Q?6G8G208HSnpIZMTXwkMZt3D2xamcZQcW/ZLsTAS/qRcd/1Sn3zrDGW4EaoIe?=
 =?us-ascii?Q?3mbINN0aSqlTN6ohrH4H121OMeKuO53l0+mHXuQMBvdWNAVfVbGJtkdi/DWf?=
 =?us-ascii?Q?Bc3MZhtrJfjvPQXZp91d8LjFM/quUM1bFxULOMCEOgDkAN84Bz/D1ilI4U6W?=
 =?us-ascii?Q?bjn9TbqpUO12vU9NgWPAy3eZgSDZuz1H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?azKN5s2ZQgKO1dtbB+rO20FAZmVop5ewEQUza4jYJ57cG5NJhyp6EN3FQ+iB?=
 =?us-ascii?Q?VwuLTOpEOX3qa4W8TheQVuZD6T//Q13exPJW7dY8VQkeFzwDFDM9EfA9k56y?=
 =?us-ascii?Q?9yUjJskkXwEJdCDnqgdfd7En9Xirt/u/HCceGtE3eZb1ck4eOaszSpl+NCH5?=
 =?us-ascii?Q?XreotVpSR1s80ipNIkcfPlNBRu5OCNBedT223Jl/L5m30lXgFMbHN1NxvoRO?=
 =?us-ascii?Q?eQ6XUOaqskOH+1d9MEhXjx2E4sF1GkAsEOgsUuvn7aNUP/3Z4whJQfhBvjwi?=
 =?us-ascii?Q?TxGYKwKVbiZQGbWW0DmFHefz3eACrBfX86pgaJvetBEydQoDxsnespmH0y5u?=
 =?us-ascii?Q?fYld67NnXJKIacKlccrrnWI7w2dErX9uEV3nhB6l+/Ad0NiDuK5h6UBVjb7h?=
 =?us-ascii?Q?dwOR2fTqFmxQu2Tp3x9Ns38xo/cAdYQfCtMCgFDLTTImE6ykh9wroMQPjP48?=
 =?us-ascii?Q?WnWmBdiE1pfVW0PptwQp+1LTNLKsyVi+8YG4bnR2Xj9Px6SJKnhy0WJC2Ntf?=
 =?us-ascii?Q?zFD+105w/z8Q+8WK0Py61q9owp0IkFaez8NzG32UKsoYyyjJLsTCVknhq+v4?=
 =?us-ascii?Q?ICQJTzKQT7dnuvS6nySXHs0ZwhVw8IitTGns1etxGajrtJZXgZIiHW0Cw++f?=
 =?us-ascii?Q?ODmrwq5FRUVfc2YMOyUipIDr/rtWJhQEEekqLpcgqj/AEaTIVXQrU/F/Sobw?=
 =?us-ascii?Q?np+WSVVTwreuj5K80ePTJW1YPtARzmSHZvCMw6vFoB1XAptfflsKqgpUWVBV?=
 =?us-ascii?Q?tbLuY2SVOaMXho/dpUn0rgT+2WhKiyhnBrgFk1staKbE2TXAsCfWY3D071oT?=
 =?us-ascii?Q?wldy88/472++/eA0P59UcXXl7Tn2ksklfxerAcs//4aUv6C+poU8A4iAmbZP?=
 =?us-ascii?Q?V0MA9Xd4uWb8czun4+YNn9L9QVCZ/0QrMZjnr5oylLg3/8TzGIOcAtYn1SrF?=
 =?us-ascii?Q?NS8tcmOjkAJ/qputICJrd2Ife6uAbehmk5M0e8bRn+q6D6stzSsRZyiZ8X32?=
 =?us-ascii?Q?Xx7AaHHw6+NnouF8kBNVypoc8lQ3GlTM7StFhdG2w3VZgVCvN6Xru/qMRyz7?=
 =?us-ascii?Q?Cb/TruNQfR60Sf775fL2zBCQ/zPUclbG85Of2M+lRd40YxW9x0SF7tGPwcFT?=
 =?us-ascii?Q?4pvrioTQP19AQekEPixoB6uWwTka4W6whG98VM4PlraQTZ7FfK9lbHl5IDO8?=
 =?us-ascii?Q?89sTyjzdwxTYqe0ORoIuQth6MNAswNVFGJfFV29NbtD9Ka1Pmj5s6H+Zr5qZ?=
 =?us-ascii?Q?CHvhx8tD7KoLXkP++zAjTVUcFev7AjPH5pzpA6C0ZpA+y6jaVHqU7CZnoDGO?=
 =?us-ascii?Q?ErcYArAwMxXNj+0Lg+7lsmq4p5mo916AtV3jFsnhoT9VLSnBaFXArW42mo6K?=
 =?us-ascii?Q?wDu4p1IoDRzxqgMiKLhpCXqm109JFikHQFZtfLIRHqaRJ4uqHkXQRbgEDzPX?=
 =?us-ascii?Q?AZXVNcQhLWkKlFbAn0RLFJUJ41ROOM7DHf+50UpMmd1p6P+WcggEv9RkLKVM?=
 =?us-ascii?Q?fsEhZZlQgZxdRsFreTdNpQ5NXvCMDexQS2vMEpy7hggINAJJPHQJfYprSjSO?=
 =?us-ascii?Q?pON8xUwkvs+KUjM3TL9F7rk7zWVhqvWvmmEfTiRj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e6977e-d3cc-428b-d8f3-08de12557470
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:58:56.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWZn2SwiTaWoQNOpqTur4nWLipkVemN3asW2PuFvx7VHHouB7tAxNwKp8EhaTXfN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027

On Thu, Oct 23, 2025 at 11:54:34AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 23, 2025 at 12:24:01PM +0100, Robin Murphy wrote:
> > On 2025-10-22 6:12 pm, Jason Gunthorpe wrote:
> > > report_iommu_fault() is an older API that has been superseded by
> > > iommu_report_device_fault() which is capable to support PRI.
> > > 
> > > Only two external drivers consume this, drivers/remoteproc and
> > > drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
> > > now protect against accidentally mix and matching the wrong components.
> > > 
> > > The iommu drivers support either the old iommu_set_fault_handler() via the
> > > driver calling report_iommu_fault(), or they are newer server focused
> > > drivers that call iommu_report_device_fault().
> > > 
> > > Include a flag in the domain_ops if it calls report_iommu_fault() and
> > > block iommu_set_fault_handler() on iommu's that can't support it.
> > 
> > This isn't a domain operation though; depending on how you look at it,
> > supporting a legacy fault_handler is either a capability of the IOMMU driver
> > (that would be reachable via domain->owner->capable) or a property of the
> > iommu_domain itself that the drivers can set at allocation time (basically
> > this same patch just with the lines in slightly different places).
> 
> That's right, the issue is:
> 
> void iommu_set_fault_handler(struct iommu_domain *domain,
> 					iommu_fault_handler_t handler,
> 					void *token)
> 
> We can't get to the iommu instance starting from a domain pointer
> 
> Do you think we should change the above signature to include a
> struct device *?

Reading this again, it is easy to move it to the domain->owner, which
is an *ops* pointer. It would still be driver global and not
per-instance. Lets try that then

I like adding a iommu_paging_domain_alloc_flags() option too..

Jason

