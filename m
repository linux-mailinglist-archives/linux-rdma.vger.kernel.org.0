Return-Path: <linux-rdma+bounces-4587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 589D4960F47
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 16:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF495B26D0D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F641C8FCF;
	Tue, 27 Aug 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XaA1wWQ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555761CDFAD;
	Tue, 27 Aug 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770566; cv=fail; b=SqWGHJN5TkHfFGy/qJAe7WwOPAtc70w1NpRyd3ideyaHCXTLzxMe5KSB1KYeL6Y1TR2rpqUk5Glmd3/w5Mb3NENZ+0/5hhEBo5y1Bm/VqSWmLtluBOqEHdzNBvOjJJELbOHoePL8qfrMPk5tjzuA9oLUVuZf0mJ3SSZtBKIF5hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770566; c=relaxed/simple;
	bh=L9xuNE9JCMqWYcqTnpTNIKgIecMOSnsxQjWYosco0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qshIv8RB71Ni1uQ+lAwrTe0xPVSCIHH5iweqyNUSleLNUOvo8G+lBt7ve+BCfa/ogoHqJAEmO/FsVqjPTWnpvV7UZDE5wkfXq9AUjmxwXVYkSCzUGQZ9oNPfXW7LVnEI0HrmUFMR1W+zjvWEmRbKMeYB7gvk1otXY/wwYEX+NlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XaA1wWQ5; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQ7y/KUsiip+JO9l9TQ8wGvUeIYSMfufJh6nYGCLuRL8hDuTSodw9OnA2ETE+mr+/uQsje2tKXjk616GbVVjVKfChzO/eT5P/2mWbrjix/y+HiU23fCi1SgOE7Obp9sVcJpcTf75OJr0tC/gTF+h2ZxctKnruz3SG7xWHYGJl2YSBYJe5ejoi+zdkJMGXQygmdHN0MaDAfg+yH0g7KWqpJBrUPxOX0yBODK0QQiYasj36BDDCHOAzoVngZYLUrvh85A7x2Um9vW8QGNwTh3PoD7eMYwciG+7Vm2UwPs7C/VXfOe6dWNWbuhRunkBnJlhB7zbF+3BRs7TNP55Y2DGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqHErOsAroLH6DnfngbUA+OMbmcPMsPHyXb4Il8Qk8A=;
 b=R1weNbpVhHMlVkhV3ydxkZ9HsbJpG6zPSE7uB2ZVTJVkpCNkk1Hd5lOEZofPl2i1uKyUhHndLlptXYmsWgoyUa3zzh5kCjfp3goWNtqhwweSTj+5ILnUW2uvtV/UhER0F3aL8J4TEQrimCItslbipwBB/SbZz3AdBcITD2Rp36DFwq/jnGr1gYzwMZ8QNvE9mmBQdqKS+AOnoU7GyeOtyd+g5Wn6WbHlmCiV0aUHp+uYTGMmdU11HRVIC4IZBxqC9s+SYtoVoutzp6mjNM2B8C0W8hSaNXYybbY2efpt5a3LGJQvoCd2i2Y3zcnJAfBQfOEN9ZZkTQz/lvcsNpf84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqHErOsAroLH6DnfngbUA+OMbmcPMsPHyXb4Il8Qk8A=;
 b=XaA1wWQ5BS1bk7NDjawoiaTsw4S3Rrjg6vcTDK6HP6VluWrX13IaEkoNJVlHbapC0jTpskk/gzFJ/njccNkgMn4xzKMOW97z5PgASIRbfP3YvWqJ5q+ASHvu3xMBLC71bTYvZ5/zfmN/oEM2H36VL7v2NLWY0kDmGZMDYT6G1sExBDbXaXJ8nTXDGEnsxUShqm5Ry+vdKy0+JfdxSVGvNBlvLb75UfMqhfSS4TMvih7+9mM3CnaeguyIo/9OGNPFb+JvOgBQSUJrSs+HuoJ93Tk6j2OEsXpQaTEVBu7JFAAE5VuZzZFE0SBAqhLnv3XCIzlNSJ7b6W7Vv+KCPLPwpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 14:56:02 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:56:02 +0000
Date: Tue, 27 Aug 2024 11:56:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 02/10] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240827145601.GA335450@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <2-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20240823150207.000000e9@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823150207.000000e9@Huawei.com>
X-ClientProxiedBy: BLAPR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:208:329::30) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfcfe5c-64fb-4ecc-a786-08dcc6a85e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQ3zMc94Ac/Bc/uQ3xz4pDgMw7bbyzDl9KEiNCYFr1dM1VuHtcDneTokAnh0?=
 =?us-ascii?Q?Sdk2JL/aBaMQtV9o8sc70UUDa8xhvEZoQhjDCVZgde7sRbM5BzDOGYYIsjA5?=
 =?us-ascii?Q?riuLYSw728g1FqAp3gDQnWATSqa3saUGPc2++SeZAvdgCcrSR2NP6DqjRS1T?=
 =?us-ascii?Q?apU7sp30yhjpvBzmJaPpxsyKfbDGvtob5w1SdLfpd1L9h19lVCu4JHimNwqc?=
 =?us-ascii?Q?GyEQEhUTAz7JMw1ZkswGOZHcFR87OeQWEXYrU3HJ9byriawJRgof6ovXmN4k?=
 =?us-ascii?Q?LdL9hF8kg5zum2gRTUddRjEgoD5/IFUNBjA1Z1kAw5fwsXgyoyJtbmXh09/d?=
 =?us-ascii?Q?HsShDwSgsZs8BK0mTRI2UiR6s5TH5JQs7wlmtp35tdPpsPqTL2/GIwR4LP3u?=
 =?us-ascii?Q?H60Zi5fdtbn90DhTHUqHT9ngt4EnXq613+hjvtQ2Cpter1sGZ2xRLkJwgq7g?=
 =?us-ascii?Q?LAvXCBRPQqWvwyDaY1tz9fnARu9vSxr//rdWHxQn/XiyqEurOrWb87hSulC4?=
 =?us-ascii?Q?JIBSxC6MbqViim8LMqaKjlXh/bwzUml6l+iczbqwxGBE+Y1dhtH+vXoahQBp?=
 =?us-ascii?Q?GIWicMLNaAH7bwDnJjcS6ykvaiv3Cp53G6GwekeP1AgvYGdYy8btCDPIHjGI?=
 =?us-ascii?Q?ePGaahwgiMOAPmAfUQd1CtZrvNIakQGyPqkYyjF6yoMcdK4q9cab0OQ3g7cy?=
 =?us-ascii?Q?1b7BI28nImkuL31G2/YdrNumN4lNZHBiThGGEi4dl1uc/MpuNlMI9OMdBTIs?=
 =?us-ascii?Q?mAvkLIlySjcZL+K/k0pM6ngtGy2cgDyg0Dbh7q+bMjA6xKKpbthQvqhOWpmF?=
 =?us-ascii?Q?n/wGILr/An4RLQBbx+pasfD6L2kx5Edo/JFEo6EO5vl+HKlycA5coT8H0w2M?=
 =?us-ascii?Q?9IuxXo0wif5cNeuzyfaUP0wXJ1kOut0TYnvnehEVNPeGggz2uxmkAFdakYn0?=
 =?us-ascii?Q?WR1yPBMwf2UwpA4grPoMsdVIjYf4tnfeqJ+2QhBTCUcbv9/r5+SzRpBU9vQ4?=
 =?us-ascii?Q?uRO6hj8h+kgS6I/tEUkPbLgSJjaN9AX/RTaqW/RAeHYDPdK7bwOQLN18DZFL?=
 =?us-ascii?Q?/W7t/nk6WkH7rDTxauEMCHDMnqXCJGJHWzN6OODtN+o5SlhafzpJApxN/oq8?=
 =?us-ascii?Q?/ezhXjj27uAeZvux1tZB8m+Oq34LbS5mW2PlN1eug5jSALCnN4CAG06kiAuy?=
 =?us-ascii?Q?Q0bYh52hDOzdIFy9EOVILV7b61Fthq1vaKLHxLTdgQBARvtPuK8ybSAATsOq?=
 =?us-ascii?Q?hIQnY7hsF2e3MKuRcIeS4hxw1VhXhwUtLfaIWmvo6u6+8LygyICcm0GwKhpi?=
 =?us-ascii?Q?ohMFl+ATFdnzT6VAHJNNRkBq3noTGZfGxyqj+zDSk2xAYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTtB0KkKZiDM/ITaIK2ljcpipYYczwinW9XKrF6NLC4ilIvYXo8wIRXz7ei1?=
 =?us-ascii?Q?svqe7dOaURBfQxTpzpVDN/hZXZAWRXIT8vLk423aOzPM0x5Kr+e8EGvzlpMk?=
 =?us-ascii?Q?BhcWnIem0io6C+Lvt/SNtn0qTklu265z1jugJ1MSCF0nP2O58pq8RzBTEzag?=
 =?us-ascii?Q?6rC0nxWv/HZWhBFaCMEmQ4eunAaHcvrDDI/+7NxriMyFh4Y4IDIoBnEz4rE2?=
 =?us-ascii?Q?MK+wMhfSXF1WE7kFPte/ti6Qj/J7F/B2YJN5qnPSQTpwb6nj9Kh+lMSTNMRf?=
 =?us-ascii?Q?RPu2IF+pJYoME2XAy0wNf8b1EavS7Ex8VhizAJnGoPiEduit5cnMu17aBS72?=
 =?us-ascii?Q?HMJg0tdorx/J+UlDoktU4kAibvcPvQm3w+UYtC9jxToaHKiH6kcA7+29uEkw?=
 =?us-ascii?Q?xeUuwcUoXl2J7fPneeq04+KDeWFAz5+qzY/aodB035qb7KhzX8JGov/3bTKq?=
 =?us-ascii?Q?ujOT0x64QiMllvS4dVEekS5FeyxbRHUwhmOEJyxZ/CbGgdjJK+6OWVzviG0j?=
 =?us-ascii?Q?i9BMOauh/smEdVA/yXHdK2Z01fgCHOYBx29icqR+cF4Ppe5IH1JVbEZ1rh6e?=
 =?us-ascii?Q?K+OnQKpHUAJHjfxSlqt0q6ESrqPmOJf8cmEv4aaSfrqPNNM3aaLuqlBxQvb/?=
 =?us-ascii?Q?9hZv69nbaBNGJ73KLH5yoJwi1hM82P4ympBIlTV8yvlgV5zmqPPSI5Wk5Eq2?=
 =?us-ascii?Q?ITRVcYHq85DN1K/ZD4OQFbwZBFf9NcnnVsGxPDDTNq2Lt7lr27Iyrm7o6kmx?=
 =?us-ascii?Q?Fgo6sAAxyr933aZZHVD2C2+Kxx2Lb3yK7SJ2KpeVr/BnzSgO9mqGMg07EYHq?=
 =?us-ascii?Q?xCc2j8Ds05d9EqSf5knQ5Xsco3Bg85pylhzwCJuuJbKpq4Tm+v97KKIPJ+ZM?=
 =?us-ascii?Q?21GqEMM9YszEtb0wbbSf0oAY/dglgu6dU1dH2Yu89ZDv+50aKFSLr7w8DKbH?=
 =?us-ascii?Q?M1dfX9rf+2ONH7LuIZKE2648d9Pz2kVQ1uH8jUoHN4YxXL5XuUJgeSc7JT9F?=
 =?us-ascii?Q?IaTR6wwvarHxPWsjkoH8seK9Uz8gt5f9FtFdqKY1tqILaiMkzbdq5ZZT1vwn?=
 =?us-ascii?Q?nMdFfkjHOmqQJDSGrcOtiw93hafXZ30dniTnBx60dpHhQrGRMC3KZmFvc7rB?=
 =?us-ascii?Q?dzVK1mHQrwVlZaopetlNDUJy2Wvk10Rs70Zt2G+rIeteAoJuaqOr35x3IFy6?=
 =?us-ascii?Q?SOJiLvTJK4Q7VFf+epWg7CN5fyR+i4uHykPOijd2xI2aQmlvMs22JGUu47Ed?=
 =?us-ascii?Q?EeDdqOdnx/LFne/AF6U7a9rU6hr5CmxthdvX6X8Zh++Qv+i95Qh+BVcPU8Kl?=
 =?us-ascii?Q?oFV/q9tOx9aasFbe6PSVZ1GkFOYmY1stxWOtXIIWw81iyo/Hk9oO1FxP5WzN?=
 =?us-ascii?Q?kLMaBeGlQ7YAPHQoYEFq6nJVSjbFVKRUlsMZ5SdP3nUtO8Mq8AFhn493PcZn?=
 =?us-ascii?Q?EUzbqpqI/Zfh4B3Eu4aUt72zooVtPayd5crJYW06nuN6TWnYa0ufV872nDNt?=
 =?us-ascii?Q?pnhXfYBUR3pME7VpRZmnYvE5djZtNVhDFUo2dJ+CCi2ob8MXzYllLORfVajS?=
 =?us-ascii?Q?TB+bf6E/wDeiPdg/yjaMKB6rk3DzgWcKl6cV7iBp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfcfe5c-64fb-4ecc-a786-08dcc6a85e51
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:56:02.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI9I503Th212gaLyyCQ7ObLRYY5tDjMXMn9CGa6N6tOwl8PIbPAi84M2F1zywCxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On Fri, Aug 23, 2024 at 03:02:07PM +0100, Jonathan Cameron wrote:

> > @@ -71,6 +183,9 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
> >  
> >  	fwctl->dev.class = &fwctl_class;
> >  	fwctl->dev.parent = parent;
> > +	init_rwsem(&fwctl->registration_lock);
> > +	mutex_init(&fwctl->uctx_list_lock);
> 
> If the ida_alloc_max() fails,I don't think you destroy the mutex as the
> device isn't yet initialized / put in the error path.

Right
 
> Whilst i find it hard to care, it's nice to always destroy mutex, or not do it at all.
> Feels odd to only do it if things go well.

Indeed, mutex_destroy is just a sanity check. Still, lets just change
the order then and move the ida up.

> > @@ -26,6 +49,15 @@ struct fwctl_device {
> >  	struct device dev;
> >  	/* private: */
> >  	struct cdev cdev;
> > +
> > +	/*
> > +	 * Protect ops, held for write when ops becomes NULL during unregister,
> > +	 * held for read whenver ops is loaded or an ops function is running.
> > +	 */
> > +	struct rw_semaphore registration_lock;
> 
> Maybe move down to just above ops?

Yeah

> > +/**
> > + * DOC: General ioctl format
> > + *
> > + * The ioctl interface follows a general format to allow for extensibility. Each
> > + * ioctl is passed in a structure pointer as the argument providing the size of
> Pedantic Englishman time:
> passed a structure pointer
> 
> (otherwise I read that as passing an ioctl in a pointer which is weird).

Done

Thanks,
Jason

