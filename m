Return-Path: <linux-rdma+bounces-2851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9391C8FB9B4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1FE1F2361E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE8149C4D;
	Tue,  4 Jun 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NCxNR91g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BEB1494D0;
	Tue,  4 Jun 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520332; cv=fail; b=X+KinUcpOOTBmkbLBf1mt5p4Lxfgz8rysOo1oP+6z/fdFrMQ95Sk7WW4QzHwtYJ6seJl16duKgsJfQiUq8mOqo75Sg2U5UjgEa6N5fCDlQfF3dxlT7QRIf6HkgsqZwFRyiihsndL04FrA508/G0+WEyVlOiOEdIC1tnKmOVIcJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520332; c=relaxed/simple;
	bh=iVCNm7KucfSyqeUHz4yOSzfifKCH+32aqjhW9OrKwDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CkVqRF8vgpTWOWVSBwWRL/wKyga6CXC2wrGkecwYai79cuGvc3wxJ+nq5aIBv3yIR6Oz4lDoaFZIGhGHV0dXjSqrHPRcdWHsmySmShVLiCnL9mjtcufk2mAc49CSwDjAbl11vUQnjeQBTAJxGsgU9+m4LAns9zCS7Xh+07Nm/Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NCxNR91g; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3rN2riKbjjUy30RQJKmR5K2K84IrXDHqdOyY3tLDGYa8HBo1axLtjcKMHHsmDYpJS3im97lk/KMBgh2E8pLEGlExb+qG9CvHhrpNPUQLITvKc0gFDI9v48eDAXndnUMuLzBQjj1SFED0kXq4sgJ535N/SPGcsomOK1MDkkslgG5oN6Io0pI9CKbGH/7izVlT8KV42R6U9ZEG6S2Zs9XNal8R56F2uuzg1EgnS8bbgnySXejgjDw17BGjy51EV66Ml8LHGSjYien7S5+Nn6xMMe4oE6iY9s7l5I+PE5TdXhNFSgedJT2VOWMQU6xd08rZRIJo/3ppRA8MGi8SWCSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT8a0hIJ02ZJ1nADe0KCHB/TbJQ9izbGTMGobP8TYQM=;
 b=TicqyYbSvkOOLj0A8wkpVPLwoLLHj7v9w9qdxcBBvQSgPhZfylf7sGz/Gx91PZexHZOGst1228GctSDCFJ81FDELQQeC++cENbUFSxTuASBtgrrJpvtBlwrC7trQkOEL1sHrWZgfoAy7p8zFItGp9W6YcLGGV4cW+S+yEfKS1LlWK65DfLbFZTPGPJ9AkA59xcFNlvRd8SfhRcI3F8BXbD/yuOG57A7s5wZXH3uukQlNkJilLUEi8i59AWqbiVqsuQbW9zVFepuCW6HyCjqDTUzGcRpA5TFNMaiRAg5uwSMiM0bKRic1bRXgeSfgE1KzRDrYahkgy00yEd1U84Ejvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT8a0hIJ02ZJ1nADe0KCHB/TbJQ9izbGTMGobP8TYQM=;
 b=NCxNR91gj3Qv/7Wi1YoYK4y5tyjqnodyaKK5D441eTxiO1NmkXWRfTg4qMjpf9CobBSWMsCRSj6ecmgMrzLTsepnEUETpVcNBKgo0YJkrE6QtpFLEONHFtVQoN6sCAprF3E6Sp92kIhBxtr8yIQkUdxyTvPmYMsY4/fe6Fo4iVrZakvCtHc3DFncf1k7aK+VVTDnG7pbGyZlKmhZkZAkkfoo7P0hFHLt8wK9brELwFb1WD8yzmjZWt6ntxM54URAbmCaUvy3Wb9GbRgLQO/IOZuzTOGZkSOXY1qY3OLtopVjKcFN3Y1SO2JeX8RaBnB5Lu22gyxZXUZKLyzDNL2sqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 16:58:46 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:58:46 +0000
Date: Tue, 4 Jun 2024 13:58:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
Message-ID: <20240604165844.GM19897@nvidia.com>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
 <20240604122221.GR3884@unreal>
 <20240604175023.000004e2@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604175023.000004e2@Huawei.com>
X-ClientProxiedBy: MN2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:208:236::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbca7d7-353d-4065-d191-08dc84b798fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v+YVahC15HSWFX3e8UYmxlrhzMOQgyfYGXFxOrMUm9C2A0CqsP9WstM8fG8W?=
 =?us-ascii?Q?p3A4+L1obtNBw7EK3s+OwpQjg1WD/kxI3LV7FRTr2RthUcTz8yfIe0s/IUbl?=
 =?us-ascii?Q?0OBNIs2tCsJta2hRiNznZMOti24rBGd4T7Jfg73Cx92oL7YoQfUr9oKvu5vs?=
 =?us-ascii?Q?kNST5pbqoMhkY+pNi1TFRvdPZ/3eH7wZkCpjqv4b+vyTZLPScacoTNxt8IaO?=
 =?us-ascii?Q?9dG1xMOIwnbekImS/E7/ZA9kdXKryQS04MXqou+6qIqImea+nlK/NFctKkxJ?=
 =?us-ascii?Q?+wLn4L+FuBwP6f6raGQJZt1bnKVTmTryB0y9DuyVFIoYwValYd59OyXnsWOC?=
 =?us-ascii?Q?gyOsHkEcLXJ1lk2g7GR3Zn3srG63eDIpOC36/zPbQCBrSNQ0X5Z1Ude5SIzW?=
 =?us-ascii?Q?x/3XnTU8TqJCk2Ron8EwHAwFpaupk7PHUH4CovS2UBNfYuOppu8J8XhGpW/4?=
 =?us-ascii?Q?tnoIs0Xa0vvBUTrpfPl8L4NrVBFwBRiO/lQqmXPQhnZ7cTnw5qitAEDEo4Jt?=
 =?us-ascii?Q?/+YexnOY3CeoFHBFXrRsCU2yvx4jstBib9lYy93i5TEGE6+5zG5tt1XPPpN8?=
 =?us-ascii?Q?KJFSohRuf9xjpePczqXsiGprnpdN4itNNlx4Z5Z/Bynx7tGhOgaPw44bL8Zd?=
 =?us-ascii?Q?xIrwaqtDWz1hXpEI/aK/hR5tkuw5A/nzNloNM2PVXubMqjjEtlz3+ZlSt6rM?=
 =?us-ascii?Q?lkjOZPuucziLwKSDm2o0nAVtPIlc9Muq3jefeRjsNWqWvV4mWm/chTwQN13j?=
 =?us-ascii?Q?ZjwwId/5p3r4cukPOzdRe4n1WoViQHW8qHamdqspXSW1qubRnsAYllNe2cOo?=
 =?us-ascii?Q?6UCvnA4P7MYP0oMXgMlWfEDyrvrXZ0bR6pSuPYmDAvkQ+YP+yqKcvoJZBL9E?=
 =?us-ascii?Q?Xy9+WNsR0wYP4TsQiNS16LhUTodgJIzm65HjEn+vfRQ7wMMmBUFXbX+WHvis?=
 =?us-ascii?Q?ktue1E96BXEUbbtNj75dF5HCFC5HYA0c275DFr3LlVeRjHiy/A/ix1VPXM/b?=
 =?us-ascii?Q?1AQDhFO5ZaMgtYS9Pz0rUmaD64gtIVxM4kjjBim/w8F5oORXUyczvo0wxQ01?=
 =?us-ascii?Q?nByYGBgMTIa7JcNd5lCbwshbItQr+yWXvmZuhFHSZG/C6+FbsXVJFXcmRLjV?=
 =?us-ascii?Q?2ctBfBKdSZQLO3cip0brtU0CNtB6lR6aytJ9cW01gIDdMSy0aM7354psixue?=
 =?us-ascii?Q?o6b7as+X/Iln8p9+V2+ARxrIYR+xqffKMTyK8GWlaVW8Ppzp1nVkx976EtBn?=
 =?us-ascii?Q?a4byEIKkoHr3OnK6yuaCMchh8r22bytubohlNTRQMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/eXrShgu0CPIdbkQIeMvyaksyJuHO0IFkXQOlCFNtU1u4vWXkdw88WH7+6D?=
 =?us-ascii?Q?auQnRg9djNuYnStszC9Jd30gsQ8m6L/OFCkkvIBQj+p3ywCSGV7H+3z2mYg6?=
 =?us-ascii?Q?cZGLqCeUw+LD+YnasRZB1qeJwO0P2pVZLLGBGpzZFmAB5QuPUUagjyzT8oSp?=
 =?us-ascii?Q?JEfHsr9xagLLGCLLMPE4oj+Wkocp0oXWiVN6hgrpT2Lzatzkyz4NBUfAGD33?=
 =?us-ascii?Q?6+2xzBkKPN9TIU80Ecdj7Z3ui0G91E6+TKWPcJf3d+hltgzzodRFn45Qkv6e?=
 =?us-ascii?Q?mpjoTLwVGGCBIu1N1eQKDcjNAKpg4DfS/982lUaDJ8L6PCJwI9oH5nB77lH4?=
 =?us-ascii?Q?L0pzEdcYzaZPWT+ppX+oUDDQ+24Y7M+8EBOJqMzZOaO3ce/6i9OvXY6zzsfU?=
 =?us-ascii?Q?qfugOyOOdMfDaDwPPEMaeR44h58Nj+McsizP0cXj1ZfsxCGDujDopdiA7qxc?=
 =?us-ascii?Q?+pw1/YhVrVCQffP1kXht3IXqB7XggKkQivA7gkSEfSvcqUIP4Hyf5Fj2H8Rm?=
 =?us-ascii?Q?ubh798kHuRVOWemiQChLxogdr4JVbCxiNZqg9yGsh5VoA29+uX7C0PJ0jjMK?=
 =?us-ascii?Q?3Qw5+fmzaIR9YyDQ7VdSRCvFT1Rzfsq7sct/QnM75QXsuhzV4Di4Hm4/Nrv1?=
 =?us-ascii?Q?yAcCRkitMG0gvCXtBCpLVZIfi9MkGtOapQepy71rmf9WKLzk9yOGeQnmjRb4?=
 =?us-ascii?Q?toDYeXuuvaij7BPN5hLbLjdqDvEGlnNKxTFn2hNYzxiuAbZP1AHILOd53GoO?=
 =?us-ascii?Q?wA8c5ylCVK0yb1ety0eV6Ahmo2aPNHi3Zj9lHYO0pmXeQH8b8ooAO2zqP/sX?=
 =?us-ascii?Q?5OLc1GjWcUCDqJhNQmMuVUNHm8chilvr2LbnnLP+QG9t6q4exXyMiPxcymXY?=
 =?us-ascii?Q?V1XcSTe2Ao9zjAUeGudtMOcllNwydq9EBj7A53UU06jsMIY9Anyu6FLGPdC1?=
 =?us-ascii?Q?9pdn5uO4wCyJop9CMRadAm3noSi5YUuOd97aULXiakqoKVa/1MOdZpjS87MF?=
 =?us-ascii?Q?vohidHrNcESnA+UxEjdWkoUUtdPXevJeZrXpnXKvj2ygZ4xOX9Xs38QP07dZ?=
 =?us-ascii?Q?Kaj7P00IxZkigjr6mXJDeh9k2vqlTyFUyLI+Di/GdVXqg9cW2VreLOsmU43K?=
 =?us-ascii?Q?5GW92+8VoHi7gWKKc8BlCXr3HIRrZoaHIbQ2jfvqu8SdCKUdDxcBjcrIgbJL?=
 =?us-ascii?Q?kUSxYYJtWISZX+WROIdeQG5zQw8CP9TXZMpQ41dSHDCfbjgh/APCokOzpX1i?=
 =?us-ascii?Q?VS0zMH4Zh4hbgmLLJt6hE3Bni/L/7MsNn2TS+OsmvHRQYzIMZBVpl6+o/NRc?=
 =?us-ascii?Q?uaXd+iCFZ3SA+1r7YUdAsH2dIsR3GKk8CCmKcpGcTl8hmHFNkUAYg4LE6dtK?=
 =?us-ascii?Q?r+G79TBPYylSBZ9YCmuX63ITp4W63WzxCUV1jS7R7JzkqqzHU8nAfRBRjYZ5?=
 =?us-ascii?Q?uEql0Xl8f3KerSWGRLezSbrMeiVkwxnAvJKf+23Dq4CeIel4IR114kZgf1RR?=
 =?us-ascii?Q?af7wYRgKuup8UVeNtPcFDDpQvgVXMhIAipQguMrvbVQvUuio7zU2HyEh1EoP?=
 =?us-ascii?Q?EymhqLejp0sJZy4eM20=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbca7d7-353d-4065-d191-08dc84b798fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:58:46.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+L4TEpI00Jp3VljAgnNfotyBf3wMO5lGFkGLUXB7rUeUYBhv5T/ddysWeivAaXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465

On Tue, Jun 04, 2024 at 05:50:23PM +0100, Jonathan Cameron wrote:

> > > >   static int fwctl_fops_open(struct inode *inode, struct file *filp)
> > > >   {
> > > >   	struct fwctl_device *fwctl =
> > > >   		container_of(inode->i_cdev, struct fwctl_device, cdev);
> > > > +	struct fwctl_uctx *uctx __free(kfree) = NULL;
> > > > +	int ret;
> > > > +
> > > > +	guard(rwsem_read)(&fwctl->registration_lock);
> > > > +	if (!fwctl->ops)
> > > > +		return -ENODEV;
> > > > +
> > > > +	uctx = kzalloc(fwctl->ops->uctx_size, GFP_KERNEL |  GFP_KERNEL_ACCOUNT);
> > > > +	if (!uctx)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	uctx->fwctl = fwctl;
> > > > +	ret = fwctl->ops->open_uctx(uctx);
> > > > +	if (ret)
> > > > +		return ret;  
> > > 
> > > When something is wrong, uctx is freed in "fwctl->ops->open_uctx(uctx);"?
> > > 
> > > If not, the allocated memory uctx leaks here.  
> > 
> > See how uctx is declared:
> > struct fwctl_uctx *uctx __free(kfree) = NULL;
> > 
> > It will be released automatically.
> > See include/linux/cleanup.h for more details.
> 
> I'm lazy so not finding the discussion now, but Linus has been pretty clear
> that he doesn't like this pattern because of possibility of additional cleanup
> magic getting introduced and then the cleanup happening in an order that
> causes problems. 

I saw that discussion, but I thought it was talking about the macro
behavior - ie guard() creates a variable hidden in the macro.

The point about order is interesting though - notice the above will
free the uctx after unlocking (which is the slightly more preferred
order here), but it is easy to imagine cases where that order would be
wrong.

> Preferred option is drag the declaration to where is initialized so break
> with our tradition of declarations all at the top
> 
> struct fwctl_uctx *uctx __free(kfree) =
> 	kzalloc(...);

I don't recall that dramatic conclusion in the discussion, but it does
make alot of sense to me.

Thanks,
Jason

