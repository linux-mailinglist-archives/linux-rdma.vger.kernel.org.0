Return-Path: <linux-rdma+bounces-2882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C954A8FC9B9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321E3B2207B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44511946D3;
	Wed,  5 Jun 2024 11:07:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53750191475;
	Wed,  5 Jun 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585663; cv=none; b=TBWvBdRX6Lb4yANAxdahtoM1RMdek+FcNrncT1p97c09s2NgH546ab9UmW7vOaGRlI/sMxCx+5+SFtEOHzZ36EiH8wTRwX6czWtBNsjszCVExUAt/Pm72vzoECtkY7cnVrlOv43suOVe1UaXclyqYAbGbOdcf3gl8V7Ae0YUiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585663; c=relaxed/simple;
	bh=fo7ouCkAbGykUNk6urigkRnK5QxRhvkX5PVDaVaCz44=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3enlAoBjGAZr7QP7w0u+3qiSBbzilPq0b/Ww7eV56wHbBI9tyWuDLT5ZY+MjzxdLnUhWxmjHaXEvGWjK6YNMjv+0I7LHx2tQTT/oExGiCT9v9VnqWcN0vvELdha71Aw4lDjfPE9o41MSaheXhmFl3bs6Fjhwwfunu9fXKK+Ang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvPhS4M8Wz6JBCy;
	Wed,  5 Jun 2024 19:03:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C50991400C9;
	Wed,  5 Jun 2024 19:07:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 12:07:38 +0100
Date: Wed, 5 Jun 2024 12:07:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Dan Williams
	<dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, "Christoph
 Hellwig" <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240605120737.00007472@Huawei.com>
In-Reply-To: <20240604165844.GM19897@nvidia.com>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
	<20240604122221.GR3884@unreal>
	<20240604175023.000004e2@Huawei.com>
	<20240604165844.GM19897@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 4 Jun 2024 13:58:44 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 04, 2024 at 05:50:23PM +0100, Jonathan Cameron wrote:
> 
> > > > >   static int fwctl_fops_open(struct inode *inode, struct file *filp)
> > > > >   {
> > > > >   	struct fwctl_device *fwctl =
> > > > >   		container_of(inode->i_cdev, struct fwctl_device, cdev);
> > > > > +	struct fwctl_uctx *uctx __free(kfree) = NULL;
> > > > > +	int ret;
> > > > > +
> > > > > +	guard(rwsem_read)(&fwctl->registration_lock);
> > > > > +	if (!fwctl->ops)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	uctx = kzalloc(fwctl->ops->uctx_size, GFP_KERNEL |  GFP_KERNEL_ACCOUNT);
> > > > > +	if (!uctx)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	uctx->fwctl = fwctl;
> > > > > +	ret = fwctl->ops->open_uctx(uctx);
> > > > > +	if (ret)
> > > > > +		return ret;    
> > > > 
> > > > When something is wrong, uctx is freed in "fwctl->ops->open_uctx(uctx);"?
> > > > 
> > > > If not, the allocated memory uctx leaks here.    
> > > 
> > > See how uctx is declared:
> > > struct fwctl_uctx *uctx __free(kfree) = NULL;
> > > 
> > > It will be released automatically.
> > > See include/linux/cleanup.h for more details.  
> > 
> > I'm lazy so not finding the discussion now, but Linus has been pretty clear
> > that he doesn't like this pattern because of possibility of additional cleanup
> > magic getting introduced and then the cleanup happening in an order that
> > causes problems.   
> 
> I saw that discussion, but I thought it was talking about the macro
> behavior - ie guard() creates a variable hidden in the macro.
> 
> The point about order is interesting though - notice the above will
> free the uctx after unlocking (which is the slightly more preferred
> order here), but it is easy to imagine cases where that order would be
> wrong.
> 
> > Preferred option is drag the declaration to where is initialized so break
> > with our tradition of declarations all at the top
> > 
> > struct fwctl_uctx *uctx __free(kfree) =
> > 	kzalloc(...);  
> 
> I don't recall that dramatic conclusion in the discussion, but it does
> make alot of sense to me.

I'll be less lazy (and today found the search foo to track it down).

https://lore.kernel.org/all/CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com/
Linus:
> IOW, my current thinking is "let's always have the constructor and
> destructor together", and see how it ends up going.

Not set in stone but I've not yet seen a suggestion of the opposite.

The example from Bartosz that got that response was
Bartosz:
> void foo(void)
> {
>     char *s __free(kfree) = NULL;
> 
>     do_stuff();
>     s = kmalloc(42, GFP_KERNEL);
> }
> 
> Or does it always have to be:
> 
> void foo(void)
> {
>     do_stuff();
>     char *s __free(kfree) = kmalloc(42, GFP_KERNEL);
> }
So option 2.

Jonathan

> 
> Thanks,
> Jason


