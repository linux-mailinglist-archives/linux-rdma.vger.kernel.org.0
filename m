Return-Path: <linux-rdma+bounces-4078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2378B93FAFE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9C7282846
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBCE190043;
	Mon, 29 Jul 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="blFhIv7J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263F18FDC1;
	Mon, 29 Jul 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270144; cv=fail; b=rvhLnQxIAlk/mt9w/PeLM35TMiKtrf9I4/8Jx6j+4pppg3u3AWaUw+yMgRHiXmiZ9IqxvapdAACwmiNxCjzLoQRtfMJRUUrEaK5qA0gJFIziVRpsYm6JAfvLztUBoUEMbiBrPJfMkUMy5O77S/7AGfgsHjNozbb24M1yMPZEHZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270144; c=relaxed/simple;
	bh=5qAkT/E9w2rrxDo213G4FjpFmns8n7zHrFB0PacGWzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fl0STJuF6Ngi90p+pwHPSVxtLmp301jd++OtlnP5SX9ME3lIt0d/2+qZXMtzBJjbXpH0vLWrlY1mUaVRvFAG08kxjCoc7cQB5ZkBSM1Wk4gPxpsS7Dy3trk5MEyDkbyLOFciHZkdcQVYnqIBq/fRz9e9rm7kWySgnagn6lyWyzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=blFhIv7J reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZlKW3Cx0rZxa+Bsv37WppmfsMXh3KHx6iVJE/tdGvMfbM7E+4P/XOSu4NAPLx6VsJNt5uLOzEVavyHrCm2UCDyiIWDslRys7ONwch9TLG119pehhWNQYcOZ4gThKQu3NhPRxX2tOuSecJ7vInzK9EOwN0Bz23pcNdche81D4UEVu5tRHWdC5yMY0H0I7CEgBXMdFylNx7MqQqKvv8GZt9AYKriYqnFn+PUvTDoXOgs2Lnf6B8Nqp2/nMMJDlbh7i5bHuG+IsmupwkRpdrDGOflElI1o8DuxEOkwDI/jZk15mSybtXcAZ9sMD1Y5HbLvoRxLEkasjEMQ26J3noWMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf9oOR5GNl7caTx0P4WOWDKYJNYuvsZquBn3JjWdDsU=;
 b=hiJ2HgVi/RlaoaZULqsqMigzqHtyB6vwVgR3wgQLK/WiOTZBewLAAPR3ATmMIQ2FVNX1i3ZMm3Q8Yuk/qiabwArbwHR3cenj0D1G8BBhdE6IWTi9FRThkPjV0hQ9YYxrhgcZMFUh4tUOs2adtKqp68JgACh7cSDrqkRMRzE4Z5AzAv9Ju5SKUT/8ncERLOKaY3bVHJYZnJINrfOO+IU4PPgmvAdVIarnl531aKDL1d6NqwLxDZc2AJYNNaf0t4A9WegRjHGVTIY4MWpjVhCJpKrZTd1CpkHD5C5hPgRibUFaScn9m4QL6eMElmHT5aBUfku2GMqAWS7YFMYP6FIISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf9oOR5GNl7caTx0P4WOWDKYJNYuvsZquBn3JjWdDsU=;
 b=blFhIv7JCP4OxpGgSBsOwbN+HuPUG35V+0mhYEZ2TxY7jL0/2Jq1spKRNwF1EGh2Lb/1Nrn007U9G72LAhINMIrGR0vRlwcMqbiPD2VPk66vHh/JaZk780ZsmovG5jVdaTHgWBCutNdhJ/3YCmxXxhSTCjMXhGZHzRSjDJDf66T374Tp/Y/hbAVVKHwkAX5Tr1AGA6Ol1DoZMUe0Ryr3tkxosi7beqyfE1SrsblQJI50/mor9PJua+cBdcVsVl2u7pUTFYQonWIZrRFkGtI0YsGXa1oq0V0aR+TZIbxYCibSwujzhH4h+tokElayg2uDMYKZfVCT95UdlTjZ9BXNCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 16:22:19 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 16:22:18 +0000
Date: Mon, 29 Jul 2024 13:22:17 -0300
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
Subject: Re: [PATCH v2 7/8] fwctl/mlx5: Support for communicating with mlx5 fw
Message-ID: <20240729162217.GB3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <7-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726171013.00006e67@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726171013.00006e67@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8a628b-7f46-4ebe-4d69-08dcafea9d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llhbU+l/IbnTT/1R3xaKTgGcki5/eyQDh6M7SYFrMEH1hkhimZVYteuy1UKj?=
 =?us-ascii?Q?ZQO1sGYbKufH55ei1fw8knUpm06fphUF8+Oo8/4blUt5X/EClIXjvIFqY8ii?=
 =?us-ascii?Q?XCuLUYhs+rRqAp5sKrmYDbPy0qtXe0JBZNacSlWsJ+iA8E2obB+KT5IcdChC?=
 =?us-ascii?Q?HAKgFT4QrTRPUWBb0GgmSRPL9iad99XzHCBDqrQW7cWO5Cv00EsNsnv1G2se?=
 =?us-ascii?Q?Aj36/65Uf8U6vH5IxQ4ObyxaPRVLf9BWaIJaytDRSEuLXvyYDccr+1FyYN+s?=
 =?us-ascii?Q?eDvSctwrnsEjy1FQ9uayC7Sxe7GDzkCaBv0gsq6s+IKWoZX+MHkx/RFOrk3c?=
 =?us-ascii?Q?dtOkFdWXvgxCkSLYceZ6SBZOimLfbJf/GjAta3zFlbKeo3e5m5koHCOP84HD?=
 =?us-ascii?Q?fEzBlzeBoq1trb65OMPN/agKFe77nm3ut5sakYHdU4moiN8o3/SZiuns/KX5?=
 =?us-ascii?Q?CCD/9ElZNTjwGbBdkEM13TdPoyG1X/rOABMNhXA3d1u43D7f3aTODuscOh0y?=
 =?us-ascii?Q?06Mhms1Uo4Qhx1YxtwjngAxcwCZcUo6EJCvABqJ8cYhQrodJ+bKPY1WoRzwC?=
 =?us-ascii?Q?8Kg0qO691fQpWIMZWNA2NJuFx3KS0kBiKexn/zFCoXdFyHFeBQGJODOQWkfh?=
 =?us-ascii?Q?9PQ+lf1zOLpxz7qLJnPSsFD6CM73pdKUA7DRcEk9KuAIdDr00HQQGAA2WUrE?=
 =?us-ascii?Q?fSAPaeNIeTE/4xPUi3DTQYjxKV6CDfzgK+aRXSUEHyiYZT+iCpetEBsxcjTp?=
 =?us-ascii?Q?O+EZ/nLMwBUFy8m5BrtuKBOCTlprBVYu4PwufzHvJetXh+nyS9krwlg1Bdd3?=
 =?us-ascii?Q?MqrMV0Nn9TlEzCd0WLTTQSJXAvYNn0wdenT9SXjeGBdaBpAbc8YczXYQ7Qr9?=
 =?us-ascii?Q?w715jQHPCfiT6QXcxF9j3h3W0VwhGjnqEWhpe+FyoSUbJk8UEpJAs388JQ5l?=
 =?us-ascii?Q?jZgGG+I1tW7meBZXI5s2L+IlaPUklp801w2VT6Seqxr6GZmfrmRPiZc9+RW3?=
 =?us-ascii?Q?hJbAWeODp6Ig3saV+EjmtN0qn2Dyf6+ZSNwLkDSMxxmv1EUwJw0a+GDht1/p?=
 =?us-ascii?Q?Cm3QcF/4dob6b9vkDwMuTaHWx3jVltvQ6e9wCy/PJd3Bs/A1YloYz2EmSDmb?=
 =?us-ascii?Q?iOJRPg6NHfTuhreaYHHImSF60IRFhxKBxjmDH/EoBPUkoXlFpXrw/D1As59V?=
 =?us-ascii?Q?w8tlJtHMGozkWYQoHfrxlxrJ53SGf7VttmzQdfhLuzkcD1xGxib82X8gTDda?=
 =?us-ascii?Q?ljEcc6K7DRSTbYSgMkQ+7Qhbmm/ax3Cq5/mkwJSYiSKW4GuBCAozorQNoFXV?=
 =?us-ascii?Q?pAswFZS4ZaDvEk7sS1yxjhHOJm7vIYoClY5PWpTatYCfOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jk+PzsSg2k8nqTkBniQgkCatpSDAqdhuHC8Mo/vzVc0UR2SxZfcF9BqTDhf9?=
 =?us-ascii?Q?RTeRP5uTNX6uhvdRUL0ycQFBtikOeAl1KoRNyEHJvTBCuugkpkhavlYXyRDb?=
 =?us-ascii?Q?7pSdWPJERG8vg1KpDmhGQgKIyiYGRNKS24ij6J30cyrGhB5Ysv0shgvfLyTe?=
 =?us-ascii?Q?fjTfnRj6x9peLfUzTADBtbJrqKWitBK0BWEOeLvAhOQS8OE2VNv41Rt0EUZG?=
 =?us-ascii?Q?+CtQYEy5zIDw3c5ujP/H44xIegKcfc15ni3InJd0JCAC/IC66uvnEzR4B+t/?=
 =?us-ascii?Q?HTEKIOy9RmBjMt204xqqLin46eLpJYrIaANpP94ofbeY04GC7IdPcwurvyx6?=
 =?us-ascii?Q?eV0cVWW3rLSi9rkIbfdpIIJMb7IPE6TFnLSTomE3aajkw8sr/TbIOs+0l3d4?=
 =?us-ascii?Q?qEiQhOHjGLWWVmDyPYn/abAXVS8dUWwpRvrkw2FBlcqvaDTGEbGZHIqyYP/U?=
 =?us-ascii?Q?O3YWPbezO+xqEF7sOBbbeEgaxi51tNXiHO/nyMNOJP+M9CpD6rUp1HigFAgi?=
 =?us-ascii?Q?UGyKA01owZJvtjnjT8lWdVneq8bWPP9Gqal+XmQ1tDPC3dEYvDqyohpQfqxg?=
 =?us-ascii?Q?kqKTVGRPwmSlJUm4RYQtSQyiEpcHB9koS4YGbFoYbFJpwOLxDknLKiGYsyqX?=
 =?us-ascii?Q?clxL5xLA/ZRlsFLLvpnb3FKTzwybH2ROFXsxzWgxUfV/ek0RW4GnZ0IgZQP1?=
 =?us-ascii?Q?DHj4Ei7GQwCWpD+xeN3Q0JMy2piFFaim5uZ5g4R4ptYbB2aNXDSPgUgfdLqS?=
 =?us-ascii?Q?ij/Uv0o9Vd2H7E27SaRHIAVWrHY0khM8/CB6NlE8Hi9hlBCve5A1QqdRIGgE?=
 =?us-ascii?Q?vl+30rsiiL9b0L/CXg9u5GwmcdsDHsf8dS3dGoIUe6GSppbsyNuw2nqgNwJn?=
 =?us-ascii?Q?tRxGBroRA0u47xuTXa7Wu1UGdDXmShgm1AXXeQbvVPw+0gUVxbasvkF45qtv?=
 =?us-ascii?Q?xhrZ/ETaKqZlZSY/kvmm9dr8Euxsir1oB0GoY9i4gpgsJ5yBnBoTqQRa9DHL?=
 =?us-ascii?Q?fVTMTSNbVldiR2RbnfhTlD2z730XDAVZEU4Cc48imyxDEGEBps7pCAIPqvz1?=
 =?us-ascii?Q?92dHRTie1GvT2sZsS6x18i9KJjglCWeYeiMFa3wDo4enTaLUBbkWNmDGdXTs?=
 =?us-ascii?Q?451r/wpFPnT3oVzgWxtBhU6TwOufcH/1iw1EfXFw97dOTlGSkgjYsEdtr203?=
 =?us-ascii?Q?h8+PpFz8yeUWql97pQcHWh/pUu6wyDrgdjHnWTKE49HH1ofVMbvISuDNFWm6?=
 =?us-ascii?Q?EF0gbcdQHdIaC44pKqQvz6OK2aBJ9gJenx3o7yvLYuScSnU/d4qX4JhO+r/P?=
 =?us-ascii?Q?Bg1NHQPpZ2PwNUcaZmTbyrlPmpa1YmxgChde4arMn41MKXXbE+GKY+RCLbUL?=
 =?us-ascii?Q?NJwSts7lQnfBKpSdc3M6+smEIn6pyOFGYVxJjRszz2peC/aEyiOGiz/F4d7f?=
 =?us-ascii?Q?RkCBH4wXhE76p/Jq0g+Tvv5sUaRPF1Um9lAx53M642tVCl48yUL0d3j7xsP7?=
 =?us-ascii?Q?sKi0m2xidTI+EgaNyO2e7MzZr0lhs2hJHtr1DOuwpCQiX8R1ym0mvlZ4uktH?=
 =?us-ascii?Q?iYt97ZNdes9pKqNM2X4T4ud+BRoBnPRJO/86VtTQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8a628b-7f46-4ebe-4d69-08dcafea9d94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:22:18.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvbHd2thIOY3a1dxHofq1btdN4H8bjcp+iYTJSN+gEQ74fAUho+3k//1ZUl/L/L9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

On Fri, Jul 26, 2024 at 05:10:13PM +0100, Jonathan Cameron wrote:

> > diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> > index 37147a695add9a..e5ee2d46d43126 100644
> > --- a/drivers/fwctl/Kconfig
> > +++ b/drivers/fwctl/Kconfig
> > @@ -7,3 +7,17 @@ menuconfig FWCTL
> >  	  support a wide range of lockdown compatible device behaviors including
> >  	  manipulating device FLASH, debugging, and other activities that don't
> >  	  fit neatly into an existing subsystem.
> > +
> > +if FWCTL
> 
> Why not use depends on FWCTL?

This is a "safer" pattern for kconfig if you expect a list of
drivers. You put all the driver kconfig stanza's within the above if
and then they all pick it up correctly and consistently. Otherwise you
have to replicate the depends line.

> > +static void mlx5ctl_remove(struct auxiliary_device *adev)
> > +{
> > +	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);
> 
> So this is calling fwctl_put(&mcdev->fwctl) on scope exit.
> 
> Why do you need to drop a reference beyond the one fwctl_unregister() is dropping
> in cdev_device_del()?  Where am I missing a reference get?

fwctl_register() / fwctl_unregister() are pairs. Internally they pair
cdev_device_add() / cdev_device_del() which decrease some internal
cdev refcounts.

_alloc_device() / __free(mlx5ctl) above are the other pair.
device_initialize() holds a reference from probe to remove.

It has to work this way because if cdev_device_del() would put back
all the references we would immediately UAF, eg:

	cdev_device_del(&fwctl->cdev, &fwctl->dev);

	/* Disable and free the driver's resources for any still open FDs. */
	guard(rwsem_write)(&fwctl->registration_lock);
	guard(mutex)(&fwctl->uctx_list_lock);
                    ^^^^^^^
                       Must still be allocated

And more broadly, though mlx5 does not use this, it would be safe for
a driver to do:

    fwctl_unregister();
    kfree(mcdev->mymemory);
          ^^^^^^ Must still be allocated!
    fwctl_put(&mcdev->fwctl);

So we have the two steps where unregister makes it safe for the driver
to begin teardown but keeps memory around, and the final put which
releases the memory after driver teardown is done.

This is also captured in the cleanup.h notation:

	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = fwctl_alloc_device(
		&mdev->pdev->dev, &mlx5ctl_ops, struct mlx5ctl_dev,
		fwctl);
                                  ^^^^^^^^^^^^
               Here we indicate we have a ref on the stack from
               fwctl_alloc_device

	auxiliary_set_drvdata(adev, no_free_ptr(mcdev));
                                    ^^^^^^^^^^^^^^^^^ Move the ref
				    into drvdata

	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);
                                    ^^^^^^^^^^^ Move the ref out of
				    drvdata onto the stack

> > +static const struct auxiliary_device_id mlx5ctl_id_table[] = {
> > +	{.name = MLX5_ADEV_NAME ".fwctl",},
> > +	{},
> 
> No point in comma after terminating entries

Sure

Jason

