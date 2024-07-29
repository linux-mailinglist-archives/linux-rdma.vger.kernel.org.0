Return-Path: <linux-rdma+bounces-4082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B293FC0A
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 19:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54711F22923
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BCC15ECFA;
	Mon, 29 Jul 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTFF9UQ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8167603A;
	Mon, 29 Jul 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272668; cv=fail; b=nLmP/1Z8F+qYItkjFg5ee1Th6GO0CQYsas5IYCMhRYU2dhiPwCAYgTVwWGFYniBaXZ4mgwnsVYdTg0rdVPs82bhaEW3A0hq/iSHI7lxvXnZyWur62iEHVVfIdNKI/XWTaXch44duW37wLBenjffofDWXHL59wMONJXDClCjNWcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272668; c=relaxed/simple;
	bh=zjQxJfw9WPgud9dKRh91xUuDjfg1IRwo3hQpoW5orl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YRYNAxUinS5NNVOslo9Myh3v+CXy3C9bHGSb5FWxKBEWXHqY7rq1SsB68GXnPvHSuDKVa1NR5Wqv8UUv5wkm+ypAivChVMvFkMxhqBY/cl/ssp0u/38FaCM1SyrgCWQIqnNpNfnE9B/+R/cavvjWgkDo0kHihe1pZNd6aQc5VKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTFF9UQ5; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxOCt8uVC7OW2BVSM4HXKaruNlyLRvVWlt3RQ9jfv1QuO2gKbQyN0+Mx4oBJbuEswf1G9T7fnBu771/eHM/MyxhEtk01iWCgEjytUTJuTheshgkvPzr/bgqehI9LRG0dCYJyu6p7HCwYTQflYlkN9Bfq4bAm61xgkfN9inXS+jMPXOy9LmXOQXdf3JPYu+XfwLzIaFNRaSTsaCuawCo9Z6Ml+2UScgbzQR3VOJeSsqhn2wNdwGgJJ+znjTJJtSi7jZaINmX0M5tFlb5iS10sMZvz3Rt5Sy+jYrP9+6p2LFxgXHM053eQLsARMjIVp7Y6+Eu9OXl5x6iswX6ujxb//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pTsgAj+zWY5iMvxpUR5DVQhxpI0R3WGx3UaC0ALLZ8=;
 b=OCgLLSy3OsJxFXyyC+6zuK9llLfda81PpY4vwu3+NuubhfugkwaJeKl2jY/oHyTzOyhxejNaHxApcvwTaqp5/IfN/ZHgMVK0AOr70At//QzqOjOpnum9JDTyzqbVUmMCej76XpLEGzIZw9nmp1r4uekgCU2pYQn1jV+s6kC7STnKehRH/zj4y+Z6jNJ6tdRMhZ2iuf4Ei0hIJXpYEoB2IiPFE4jY6xexjwwnIV32LutEokuW6tr67NK6QqOcTaNDiZvjNsPV8clJ1dRGpxhHxcK1drvASjmtwmyYBi04vv3ftAYaOlpUALMKhQu+hLvZnLwWVHtSdf0k0rBNjns1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pTsgAj+zWY5iMvxpUR5DVQhxpI0R3WGx3UaC0ALLZ8=;
 b=MTFF9UQ5MhUNiUdQoMsBhaB6es1wn3N7WEbKVm4f6YHX8rnMiAGM70Xu4vrEoWzvKHU9J5burAp0qylvw0F0iOHX/uK18gIEALdH6IfsdlFbnftzdEWSfZHI2Yxvijs1ea4hqnMe0McsBEoi4oHKgsFcEuKiIfur9wgMV6sAWisk7qZzo4/tviVmQxS9yVo8R1/f9P8oDIgogX4n6+7RwYir0gqGbfJUiHyvU6y3q5UbRLRs+3aQ3KE/h2hDp9qrbJrPFutGySmDQcV4Afqn0SzvEwTTRTAg+/LiuAIvUEWiRHAUsAWfNiPtnOs2AAE+CMHVHBA0gvRM2EoyneiqvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 17:04:24 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:04:24 +0000
Date: Mon, 29 Jul 2024 13:35:13 -0300
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
Subject: Re: [PATCH v2 3/8] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20240729163513.GD3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <3-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726161503.00001c85@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726161503.00001c85@Huawei.com>
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b035ac-76f2-42c7-7626-08dcaff07f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AP0QTwc1d6RgGb8U7WHdS5HKTJ5oAZWyYzrhcQf8VovCb/ZBCF7i8Vk/dics?=
 =?us-ascii?Q?UlRwuT2S5QiqojD9us2JWQhBOUTLIVijaMvQmeZgFgKenVjYWy7fseOTs0uw?=
 =?us-ascii?Q?cdIOTLhOYRx6+Wl9slakFaOFezuQ6C4auLP5KuC5Nx8pRdDeKVD5KHN7Q2Hm?=
 =?us-ascii?Q?WFANlBrzwsCXJGdoEzWMmSP0PiFCapMaNvBlRp65ZQqaIqcbqc8Ycoyn/ko4?=
 =?us-ascii?Q?pW1h7CuF2AhWZwUcCG2UQxOtSPki8Uc9nTubR1i97A/Z+yl+6zaf3hi/Z9a0?=
 =?us-ascii?Q?4xDXN26/aGqWSRmoVSDc6ElRo2DkUN5qgChZmRGilOqkczM6wBSUZH9Wmb43?=
 =?us-ascii?Q?wssqd57tc4nlvo3CstgHr2nS9Jv6zit6LfpwiEixsscZ2SoqQIxpQwPBOjaI?=
 =?us-ascii?Q?31SOgOjwryH63IcJV/658Llkvp0C7N9OUH3YUTvwRR39G4WFG4pF+rTD9oQA?=
 =?us-ascii?Q?GOBk7trRp460PfOCHMhW0kRwuZfB++N+rjDZqKF7gtRe8pPHRBv9VF7fpMyD?=
 =?us-ascii?Q?YGkzNYCLfF9x7HEZ4valvvNRpSJMXMy5TcJZzEM6zukv4zPVtmrOgN7LL8W0?=
 =?us-ascii?Q?AeFq/XcCIqrJ5U7MfT9OhNMfNY/A2KpI5gwXxVbjdIhDafQ39rIzN19QBWPn?=
 =?us-ascii?Q?wcr5YNBC8Nz+9P1XfPNzyAcBXcTkg98asc3B1AZ1TqHCPocfktTNs17bN2yx?=
 =?us-ascii?Q?HegN+umEyiA15x4PYizj5qJnnugOpRxKl9GTtaGDdHik+0vicgLGjkO1pfgN?=
 =?us-ascii?Q?/yAFyO3NjP6R7WbXVoT3Qr3MjtibiO2YNUiCnxA8xXD23aUpVsVshz18ArZE?=
 =?us-ascii?Q?Jo4G8x1hN028T8H5zDostfpzbDB5dXgSyzVwyMWUTiGp/dHX7ltdZlbk+t3E?=
 =?us-ascii?Q?l9m+MsochPVhUjeZj6Qr62TzTu+Kdnnrj5Xyp+C731A+MQP9CQmGVYtGnBqd?=
 =?us-ascii?Q?N1nL9zruJD7aa/mWk3pzCuSNPEjYHIfhTpS2RqB6WcMhqT0pG2eFT/JypEYk?=
 =?us-ascii?Q?SqaOd1v3kJFc/fsOxqjmfCojwyFSb0WRs+6BoZBJDrP3NHBYaLw9pCuIGNQI?=
 =?us-ascii?Q?uBuZagPQ2xDKwy45z3P3JTwx0uVVjHpdU4EFtjnitEk03E9Nc6nNt847Y0QX?=
 =?us-ascii?Q?yOb94wSTHt3AODmTKz3Ofg9iAQ4lEQOGJTlTrt0r1crUuzyuk+gdrxsHga9C?=
 =?us-ascii?Q?8BNSyzWpIGcoVg3hRcg4MwDLEwBti2YQ3dq+uBQ7REFMisYVcE4IQ+fuaznO?=
 =?us-ascii?Q?8jwy6MQGLc0OnGuQqGjNdV2b2b+U8ZCbvaIvo0Yz0H6HTfV0eRP7el6cqppE?=
 =?us-ascii?Q?wKwwCXA5iDyZfZYYiaWckkVN9iGrFvbXTXAZIEEyocSzIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uDyStxw3Z8v0UhosRbQelUUHj5jrxNkq7WeAG/rTrfSM+JN3KmLNYeEkpfLm?=
 =?us-ascii?Q?SXMZXEw/rcbgJZSBkDrVVo8iTyQjhdvDFfpvblIWVbls2+M/g+3dpk0RdIx8?=
 =?us-ascii?Q?C0SvQO4qe5k7BmtEttXri/g+sCx5b1rXAXyvcf3viFNAg+YHpj2/rRSuH7NW?=
 =?us-ascii?Q?CeO+cbmvl3Bb8JJKm1a2BWeTmQFT1IhGVTOWq+Cjplgnn4KKrfI83EIgqmt9?=
 =?us-ascii?Q?L01C6s2QZhRMMGXYG8N+Rg15nHzCL8PiwhjKTEfsnxLduzSy/huzTtwJiaWD?=
 =?us-ascii?Q?eSJx0ig/1n3OREcgAko5BdctlgOr1wK0ndpQy1TEoPdfTfCbtBd0ezBh5K4D?=
 =?us-ascii?Q?iAoI8Ne5TN/pJqDdIadI0ZS82CZyZLNQlRNs7qXhWo5JMiPEvDrOjVfx0hDP?=
 =?us-ascii?Q?DL7Lu9RH/BNfM0/ShEsxOc/9az+U3dyv6m8YQNGv/66q/FpLoeh+C1S9PoCf?=
 =?us-ascii?Q?x7HlX6orBNdk9l7/VDOyHUkmSwR3X5mhx7qH+qIXq93+9/yqlxOHamn1hexA?=
 =?us-ascii?Q?zP9GB884FhG23AFHyGCHX3jCIWA0jPtLPpaE/wLU+EH9zqD2s8gaC6m3a6xV?=
 =?us-ascii?Q?syF0/QGR5XrXZkEg60yvi0SaVWysCiiVq2K2u7FXKYEv/1NC2KC3HlEmyH5/?=
 =?us-ascii?Q?p4ESzg3Ie8d6+WJp3t74WpFy3cYnP17+rHEs5508t2MC2TY4VL+3R75on+xw?=
 =?us-ascii?Q?1Y5BIGHmwa99FJTu3jyPks6wujUho7KRSOzhqtVqhYwKLbll1SYJDDkkUAGy?=
 =?us-ascii?Q?rRgrQDXDzGQXenCn8l+VnsME656/aGtWYNmsJTU32/R41t8bhxl69zteb87Y?=
 =?us-ascii?Q?MmHBoL2+YYtvzpuqBLnAnFlbgEMbhXfviGYXWwmKahOodq8V0vL+VKgR9bfB?=
 =?us-ascii?Q?G7lewlrNNlgo+gkWy9ZeqgHUOYlFFQb+Xn0eiU+T9uk7XKUqm6BUxgNZAM67?=
 =?us-ascii?Q?PZ6aU5EhE7+T4jWFjSxhmk7QuAi+tEi5/hE+uALTvKC+OnSG1qAr9ajQNfmI?=
 =?us-ascii?Q?NnvsjPNuL2Ok3rbVCyf9UoPK4n6yHawpLg3BSb+k7VJ56SAcUig6WYd0TVXx?=
 =?us-ascii?Q?s6Ur6QnQ294pR1gnIKoavr2nvsLYUmS5IvYJpiI3xemeZ676zZOp+SmvgBW8?=
 =?us-ascii?Q?5ne/g7ZY6QBcMvyf/dUzkKoT1Zz2JBCblSRv7yppHWriVDwnADnw56ggwD8M?=
 =?us-ascii?Q?RZ5VHvjxQaIWvSwtICXOlJx2YdzWSu7lCLarW/eIeZsSbUqYmb6vhcNe1UuA?=
 =?us-ascii?Q?v22eVcbfHDJcJipwkZhssUW0m5UL/OpecmcLnwLGtOxsV1E5nRFKQSoBJXR8?=
 =?us-ascii?Q?hMqG3PQsg6lL4C/vWCfcSeV7JKX49raU7yvFhBr+IQet/S9ysxvyDvb2ej59?=
 =?us-ascii?Q?ohqVUumZWSLr/cJe+4nEqb9zGdCCasG5QgrAXMd+3AIWDoqHFg1IHSwBDOq7?=
 =?us-ascii?Q?iGDC4JvXfgUHEkJ8gP42m8uSWc7QkzMMGbSlLnWdtHQfmaK/NSmJmWqnpbdY?=
 =?us-ascii?Q?SAyB55gYimIeosus9cQf3R8OG7IHe0abP3UNMs5T+rgU2NqIH9HQrc58+VOh?=
 =?us-ascii?Q?UxjyiOjudULiSv0FTowsTMT50BJxr4vvleFyKQ8+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b035ac-76f2-42c7-7626-08dcaff07f1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:04:24.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TTCuxirco7jVjwXaQn7vkA+b++iabYf/r79tUA4kl4+gKBqGzAiE/eFv8mwamCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

On Fri, Jul 26, 2024 at 04:15:03PM +0100, Jonathan Cameron wrote:
> On Mon, 24 Jun 2024 19:47:27 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > Userspace will need to know some details about the fwctl interface being
> > used to locate the correct userspace code to communicate with the
> > kernel. Provide a simple device_type enum indicating what the kernel
> > driver is.
> 
> As below - maybe consider a UUID?
> Would let you decouple allocating those with upstreaming drivers.
> We'll just get annoying races on the enum otherwise as multiple
> drivers get upstreamed that use this.

I view the coupling as a feature - controlling uABI number assignment
is one of the subtle motivations the kernel community has typically
used to encourage upstream participation.

> >  static dev_t fwctl_dev;
> >  static DEFINE_IDA(fwctl_ida);
> >  
> > +DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
> 
> Why need for a new one?  That's the same as the one in slab.h from
> 6.9 onwards. Before that it was
> if (_T)
> 
> I was going to suggest promoting this to slab.h and then found
> the normal implementation had been improved since I last checked.

Same, now it is improved it can go away.

> > +/**
> > + * struct fwctl_info - ioctl(FWCTL_INFO)
> > + * @size: sizeof(struct fwctl_info)
> > + * @flags: Must be 0
> > + * @out_device_type: Returns the type of the device from enum fwctl_device_type
> 
> Maybe a UUID?  Avoid need to synchronize that list for ever.
> 
> > + * @device_data_len: On input the length of the out_device_data memory. On
> > + *	output the size of the kernel's device_data which may be larger or
> > + *	smaller than the input. Maybe 0 on input.
> > + * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
> > + *	fill the entire memory, zeroing as required.
> 
> Why do we need device in names of these two?

I'm not sure I understand this question?

out_device_type returns the "name"

out_device_data returns a struct of data, the layout of the struct is
defined by out_device_type

Jason

