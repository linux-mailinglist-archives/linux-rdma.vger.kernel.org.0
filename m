Return-Path: <linux-rdma+bounces-11903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A02AF9A60
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 20:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1436A3A562E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E620F076;
	Fri,  4 Jul 2025 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OG9FhpSI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF920F079
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652891; cv=fail; b=Z3cwzf+64wUXCXxrtmphXhEUvjLAZW1zznH1nPRwzb8Py1+B+oDCQZpMwsQ67Z0hPvzHrxNbxMZ/T8/+52qtUyrpKIfDDzYmlStKwsm43AZ/ZehY0vIbv/tYLX8+MonkgfpV1BvLd6S5K3PnYqVWesn6HZH70rc9/e9ItlhZ4Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652891; c=relaxed/simple;
	bh=2ktOpq7pd0pEE6i6PIVbtbyWGvOtv7Tg9PIh7p0n4oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bkzBKewamv5OxFDJ1+pbr/jC4qYCLtI3QJoKpLJzRgc8yjOYP0koWMYp1V/MHDdJ66lqa77mnexpo1CE3He/ehk3bJPskfuzssjwxJ8ucrY3bZVqf0t0p2usO6tSUhwS3OcZhsY8UsEQXn4Vr12M4HUygUnFh8DZCuyvRnCZYs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OG9FhpSI; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crJN7MYnsFSHgAKuWRosHvDsN+c4Xo43VJryZ+ETiAewe4BP05jW6t4ihJnKRgQQBYp4DMekpR/r1QJ2e2UmazrMaQRyN20mByt5akYNYQHv8+6iw+Ros/xiGuTiLAOcvk7qKNRDPGRhu7Wc+NNeQMt59dL5xU1I2qdGfebwdGc7vTt9o2MmqKQi8rv8ODbU/69JUvyVp87Yl0S307+83YLE2E9/9RPzWR4a+YzNVbMXRelgdylpCi8GA6pPMCpY8ynbv6eJsz3DiHa3IHv1rP3IxAOWVpEmiKxtwFOesGBWTbYqkuiCGbyNHBIziejdVkO7ZRVS+EjFyy9vJgLWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpRUABrwdWtTNEo6PilKr6ERpJ6MORgLexQdI8yZTZA=;
 b=xl1KgmmKwIxGntN4bl0AaVdlt2VTXdpPzkNONF7e9Itf9zE2b5eFx27+s98hXfbZn3x0/LQpDFW0oJ/bfuYU98N/XRouSNTodSazsRV53AzUOxHT+q8DPNZCn0ZjXHPg2biDsl9w73trxSVatyR/Adgwc9Dgl24RYiit5uEuYGLeYOcIeMhQqBZoBqwF6VWhpaDHAq+RX4XEoYNODbUfS3YrHjFsPx6aw9sdJm1O5PukwaUp0wa8mvuvf2fIeOg28W4SBossV+2koiHGRPUF/f/iamSY/Ezs3AaRls5YFV5T9ALWp2Lm+DyY9tCKXDOdHvakR53g32IIybKYGTI72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpRUABrwdWtTNEo6PilKr6ERpJ6MORgLexQdI8yZTZA=;
 b=OG9FhpSIET9k08eH6pmZCyM/2GZ+ljsl0yauokHftLQqBhnrXLXWBrlb858VTUit29472D5D64/ZMShEec/M1cuLwNB6X5iXEWSIPSFvohIscXHT/F9KwgxJ5JKxtnls4OjAKo1qPtxAS+zdrUw58W7Bsnasa8aHxfFrBQEFRCCOn/VlO3oGTjwzjTX6pvrDw0K2I1YsBVc9g1z8kMQ71fP6ez+iQYg8wADiEtWtUNUTcZ3ZSKouWWeGoOQiq844bQUgh1VgawPefodYACxeeOSpvybMj+8/3rwO5K9Q/5LsQCmjM6luArPpWdg8lh9vXKkET2Wj78wnV+sxOSwJ1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 18:14:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 18:14:45 +0000
Date: Fri, 4 Jul 2025 15:14:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-next 1/2] RDMA/uverbs: Add a common way to create CQ
 with umem
Message-ID: <20250704181443.GQ1410929@nvidia.com>
References: <20250701231545.14282-1-mrgolin@amazon.com>
 <20250701231545.14282-2-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701231545.14282-2-mrgolin@amazon.com>
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 72347520-3678-4ad1-3786-08ddbb26a77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgbK+g3H+oSkRM+cs/ILJ8rcWo8yzsIeegpKwD5xSXPirHiFcnmkUKdHBLuU?=
 =?us-ascii?Q?iJC6DQUSoLHO6S5xrDs2m520PFU425IPDHpCf4W/vM6gB3VYvfBA7ovm6QA1?=
 =?us-ascii?Q?nAdVjNqywBesgF8MfxH9PViTweSeJDuf/5zZeoMZtql5ulBbcwqLAATv1eOS?=
 =?us-ascii?Q?J843cTV8xv9Yxo+Ve2rWRKQOUR63+zhWPUpYrfMOmRl52HvrVF1UDHSeRIlH?=
 =?us-ascii?Q?gLIkCQz+VDN7h67/agxayspiwUwCfOa3ky1NHricQjEZufnYXxMbeVpxiPPa?=
 =?us-ascii?Q?wjz5qCFTdeT4r+Vk0qrwzybyCqecud0cwoBsquc+1+1hVUvprGZUH5WAsgWI?=
 =?us-ascii?Q?IpCQyUq2xG0mkjzW+ZEHfpzcgraSl+U54Yw1/LK3ocqBVB6BI42E3GzU12NI?=
 =?us-ascii?Q?9K+R5k6Qe4HP1lsUZqOV/AG386x5AQ17akLTqi0puqFWoLWN+30qtCRV2SqU?=
 =?us-ascii?Q?J3MLCd1aEAjFtNoYzWUwJXluMct0jeTOhD9CDg5w/922mNl+QYPWDsnZHocT?=
 =?us-ascii?Q?wEEfWKlPICOfGgPrJQI7H5CkXMpvLGR1+OfDThdWTl3+j9dMU1/QLs2pfvMU?=
 =?us-ascii?Q?IKEq2sGXs74f6YAkWvhqkSWo2yrP692YkVPJ1FvQr/nKOkX/zNjUUe0CM0PC?=
 =?us-ascii?Q?bRsCtSxtsqcSU70yzc5sxEJfRGtLg4DUzZNtLijdpo09BjsKrs8bg280LX/W?=
 =?us-ascii?Q?1+bNQtbcBMJpnNtNHgw6eyy3tHa2troxXbosZn5uJ0YUQ2GcfHYKNIJQq6ll?=
 =?us-ascii?Q?MTHtqTR8tdUHCmLsq9p9zaLjFwgJvlzeeDA6jNWDkWP8bTmX50vmOuRdbQum?=
 =?us-ascii?Q?sfzMTKijZByrS/cp4wSTBJCFxIfi3Uzt+y6/x6NU6jPv4fvT6e8JGv9EKXcL?=
 =?us-ascii?Q?EcZEFbYjTszPSfiGnUv0q66Dh5tg+qbls6IASPDDVwp8NUqGoiAgKBAVmdIy?=
 =?us-ascii?Q?YsgCxU3h6xuMqA6SYvBMKliNVPRg5StGAujWkgw4xI63jXVi4NCAiwupnRcY?=
 =?us-ascii?Q?xSM6/GBnc0+aL6z0BvqCwnTdrPUptu3REmX9rjwIQu3nnNGmicbgK+jNgD5s?=
 =?us-ascii?Q?gxIQaH+FYQGi94fvltjDmP3PIrKuGfVXE40BhbLQnWILX8faErdB04gaIGoF?=
 =?us-ascii?Q?pWfzzl/WfnuxGHnygpYZ5hMMog0VtzcqhcJn9uKDjXQW++yKIP7mpuuDNJAH?=
 =?us-ascii?Q?V/Vm7ThyQnqCqjK2cF3lZYTSJ/3H4M8h35nFjDJEF0AR2YEHcAU2eQElBqGZ?=
 =?us-ascii?Q?zUHllLOATld4I4DfqVhHordlmFYur5j1zGlru+EjUCatJ5SVaC23GXRG4TpG?=
 =?us-ascii?Q?unyO6JOMys/hgvIx6HsAoxFisaiBe1tCkCl4Pf9u1xPDTSX39nWtr/H9CzBe?=
 =?us-ascii?Q?16PHi1+I8grMbzN48RuM97mk/4xvSuCZmnVxzmsvd+0HjtaGkvr+zFHDEeZC?=
 =?us-ascii?Q?yigY+OfmcVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fw1p+B5L7AAWJmPJGKQxaWygIZI+oNmPhdjv2/KsjDJtlXGAe4yFJr0mOpw2?=
 =?us-ascii?Q?gkM81+3FjbjCH3RIDx1g9QOOzoKf4l6k8Xyn4P2DJ+kjM/2/iwrbkym4uNdC?=
 =?us-ascii?Q?RS9gqFqMyDjeBo8f6tA43HY+FBXGBlelP3/VWG1jYF91mUB50FHmJtFh07fF?=
 =?us-ascii?Q?G+ZVmYYP3DhLMHhuCDpL4I4UoP0wt7dJ/+3VdDAg0c11rEmkHGt0iDJoBgFo?=
 =?us-ascii?Q?vb/qjPq8mGIjHiMYWCTsFhge1FaCA6BwvQc6zD3oodAkRgo3grJwtYFtW9j8?=
 =?us-ascii?Q?ewl3BFlrs+bJfY5NIxScfq9ZMBD+AqIdADJoGwVwpMN7qyDjnuyvcaeDz4aF?=
 =?us-ascii?Q?MdEdGFWN6pPqcwIH0afCqWJ2BSZ26SvXFfKN1ivHg32IlE9WfDgJqN/2NToT?=
 =?us-ascii?Q?OLXfILjJMM3kNa7TvPKFnF6DAx/rISdMwItd3neYNWJT/zcBtuRqQ45rgdCg?=
 =?us-ascii?Q?HLUN2mcVAXWgvg2bgPIGmo1/0Z3neuPqhj65vvrSjRSX7f6kTB/3d6EEZpO5?=
 =?us-ascii?Q?CS/WfdJtY2otSDbjqaETK1dsIaYMS8nkqpaxKj1hgVBuYOJcrsv0ysp7Fezs?=
 =?us-ascii?Q?EHLuE86veWZ8t2riaFsW419ZfZqOqhvSNw7hQlGH6su5SRhrCsUkvjZ4l1lZ?=
 =?us-ascii?Q?tK7QwiKSQI9mRlDk+nA57N1bbJ2mvzwmR6vpp+pY2HGxSdON4J5xFHCeS68Z?=
 =?us-ascii?Q?AnRgyNpVR/3xqw03+FjVGmlUC+SX7Mvtv6q8HXgsd+NaJQMwyPo4ZaK1RqzI?=
 =?us-ascii?Q?tdRIOFwjWJv1IdLCkJ3BCyQWH63fiPzMRCUsQwsscOq4FycGpqDA5TUPRAAZ?=
 =?us-ascii?Q?5HYyEsaNrxgNvPSq4rMc4LjfHU+SrKaIBu2fnwtqQWpB68+lGukF4c3i9d2U?=
 =?us-ascii?Q?9ImjvNCkN2SNZvE/tHyp8rv2rafKdLR1/zSB8zX3z/t3La62+uBxeGoWSDJf?=
 =?us-ascii?Q?6x/y5sOtFMYdG+3Ik34O61FyLqlMk27g+RruRG4EWBwN8HyEIX4JZIOzr+nJ?=
 =?us-ascii?Q?61t6vmikjiDIbZInhazZBEb364eTiBjAZ5zNBxViehGzADSLiRa5wpIwD13V?=
 =?us-ascii?Q?fYihQGeQP1T6e9vWdCujr/wceugmF5V810WX1jz1nGoO9gbF5kpbUYZyrGas?=
 =?us-ascii?Q?0YyllhHDBF+l2MoT4GsCZS6mzIcNfMym/NBIlZFF+/yGS/5v14M4JQDrOHkF?=
 =?us-ascii?Q?LrTRPrAOmxMXsj/orZaeg1ABTECMVvDw//0QFLN3dopjY/kSNYo2HsbWHCBA?=
 =?us-ascii?Q?9DuayhdD+9ZqOZF/mnef5A6+srImyBRSTUAzauUNP51q5L7vYYwkzeLdc1PZ?=
 =?us-ascii?Q?OgrXltbJDMKALEexRJKX8Vp8EIF2hCxmjBrho7PqdasFJH908yG2mgB5WCt6?=
 =?us-ascii?Q?g31ztAxA/9rBu2QEc92scQ+uI82wCD8XkYMuitdsmahOkCgNtCi4u7qydp8X?=
 =?us-ascii?Q?VtN428reI+fVYNakD44IWdp7CrM8ZfXZcBvZyxCVQuIZptj2v3nMbSRlZWV+?=
 =?us-ascii?Q?tzqA8i74j+D2issRZewpPjIRHklYXH9FcB1k/YHCsAIPyn4RDfMtFtRDxKag?=
 =?us-ascii?Q?AH1meqUsY/NUsJTekX4SVsOOO1ImrYz+AfRpQY2F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72347520-3678-4ad1-3786-08ddbb26a77d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 18:14:45.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDOtDvB+48GvI2KRNZI47G//HItZEOM9/sYslcE0AMpLyFEkux7bJfrLEvwaw8eq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510

On Tue, Jul 01, 2025 at 11:15:44PM +0000, Michael Margolin wrote:
> Add ioctl command attributes and a common handling for the option to
> create CQs with memory buffers passed from userspace. When required
> attributes are supplied, create umem for driver use and store it in CQ
> context.
> The extension enables creation of CQs on top of preallocated CPU
> virtual or device memory buffers, by supplying VA or dmabuf fd, in a
> common way. At first stage the command fails for any driver that didn't
> explicitly state its support by setting a flag in the ops struct.
> 
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/core/device.c              |  3 +
>  drivers/infiniband/core/uverbs_std_types_cq.c | 82 ++++++++++++++++++-
>  include/rdma/ib_verbs.h                       |  6 ++
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  4 +
>  4 files changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 468ed6bd4722..8b0ce0ec15dd 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2667,6 +2667,9 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>  	dev_ops->uverbs_no_driver_id_binding |=
>  		ops->uverbs_no_driver_id_binding;
>  
> +	dev_ops->uverbs_support_cq_with_umem |=
> +		ops->uverbs_support_cq_with_umem;

This seems to have turned out quite nice!

I might just suggest a tweak to streamline this flow

Add:

+       int (*create_cq_umem)(struct ib_cq *cq,
+                             const struct ib_cq_init_attr *attr,
+                             struct ib_umem *umem,
+                             struct uverbs_attr_bundle *attrs);


Instead of the uverbs_support_cq_with_umem

Then the core code would check the two ops and if only umem is present
it will insist on the new attributes, if it is not present it will
refuse them otherwise it will call the correct op.

In the driver the create_cq would obtain the umem from the private
attrs and then call create_cq_umem() in the same way

So it becomes quite easy to just reorganize the drivers to support
this.

Jason

