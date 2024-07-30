Return-Path: <linux-rdma+bounces-4104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60E941D48
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 19:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE221C2376D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC918C336;
	Tue, 30 Jul 2024 17:15:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE018A6DD;
	Tue, 30 Jul 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359707; cv=none; b=uMNjC6bQOPZuZDa5+InYwu+vGGkw2UAeZ/TywAEe6Q++VUo5xJo/RF8WGW5tKQ4NSlWardiTYqJXZ8yBlNT7/9wOU9ZBlAlqjbDTqFvqkhzg90na7RRK5XPA8Q83M3+KPvNO+I4dFMxPzGM5lWez7MuM7xrtp1H44oafPmeAbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359707; c=relaxed/simple;
	bh=gBg5+KZL7H8xd5TqmtpjPdibVkxz0gSUgYQbeHeYzlc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU145bMB4LqScC6Mu9rfPRqB9bBweNXgS5mt9y/ThQjAHUXVfR8qWtKslTh5X1Y97JFoWjV7lF+Iai/27WlWRbc8X6XmGDN5XdxOdPYGZ/X+6kufPJTk5kZSat7KsAscysjYTkkZL/ylVBWGRn4NYIg7qmInyURK9NGBcDXJCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WYMHj63Mwz6K9Ns;
	Wed, 31 Jul 2024 01:13:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A330F1408F9;
	Wed, 31 Jul 2024 01:15:01 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 18:15:01 +0100
Date: Tue, 30 Jul 2024 18:15:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Jakub
 Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, "David Ahern" <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, "Jiri Pirko" <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v2 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240730181500.00004733@Huawei.com>
In-Reply-To: <20240729173038.GF3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<20240726153042.00002749@Huawei.com>
	<20240729173038.GF3625856@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> 
> > > +/**
> > > + * fwctl_alloc_device - Allocate a fwctl
> > > + * @parent: Physical device that provides the FW interface
> > > + * @ops: Driver ops to register
> > > + * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
> > > + * @member: Name of the struct fwctl_device in @drv_struct
> > > + *
> > > + * This allocates and initializes the fwctl_device embedded in the drv_struct.
> > > + * Upon success the pointer must be freed via fwctl_put(). Returns NULL on
> > > + * failure. Returns a 'drv_struct *' on success, NULL on error.
> > > + */
> > > +#define fwctl_alloc_device(parent, ops, drv_struct, member)                  \
> > > +	container_of(_fwctl_alloc_device(                                    \
> > > +			     parent, ops,                                    \
> > > +			     sizeof(drv_struct) +                            \
> > > +				     BUILD_BUG_ON_ZERO(                      \
> > > +					     offsetof(drv_struct, member))), \  
> > Doesn't that fire a build_bug when the member is at the start of drv_struct?
> > Or do I have that backwards?  
> 
> BUILD_BUG_ON(true) == failure, evaluates to void
> BUILD_BUG_ON_ZERO(true) == fails, evaluates to 0
> BUILD_BUG_ON_ZERO(false) == false, evaluates to 0
> 
> It is a bit confusing name, it is not ON_ZERO it is BUG_ON return ZERO

Ah.  That indeed got me.  ouch.


> 
> > Does container_of() safely handle a NULL?  
> 
> Generally no, nor does it handle ERR_PTR, but it does work for both if
> the offset is 0.

Ah.  Good point, I'd neglected the zero offset meaning it is really
just a fancy pointer type cast.

> 
> The BUILD_BUG guarentees the 0 offset both so that the casting inside
> _fwctl_alloc_device() works and we can use safely use container_of()
> to enforce the type check.
> 
> What do you think about writing it like this instead:
> 
> #define fwctl_alloc_device(parent, ops, drv_struct, member)               \
> 	({                                                                \
> 		static_assert(__same_type(struct fwctl_device,            \
> 					  ((drv_struct *)NULL)->member)); \
> 		static_assert(offsetof(drv_struct, member) == 0);         \
> 		(drv_struct *)_fwctl_alloc_device(parent, ops,            \
> 						  sizeof(drv_struct));    \
> 	})
> 
> ?
> 
> In some ways I like it better..
Seems more readable to me and avoids entertaining corners of the previous approach.

Jonathan

> 
> Thanks,
> Jason


