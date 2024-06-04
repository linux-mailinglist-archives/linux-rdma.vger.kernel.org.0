Return-Path: <linux-rdma+bounces-2852-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6E8FB9F4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 19:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AB51C22074
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DAB14B071;
	Tue,  4 Jun 2024 17:06:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAC14A0A9;
	Tue,  4 Jun 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520783; cv=none; b=jRJUebQevlIabXkA1tFVNN6UdMMshsvGePvg1w0D/a7CftZ05WE/L8EK27/7K+fxV0Me4VnfoUShEfKe4XWgQk3zOMPqX5AwvmwlDCv9nOzSBN80l+h1iLTdFdl7FNareb8Y0yJhbZHZV5jH6EgfotXNpEcOM77o89aKeR07lpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520783; c=relaxed/simple;
	bh=nMub7fB/QtlS4oR8KJcOZ9lRXmuFltunoQGGtWqHGuY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWhlV64WQjjGtyeVAtuhoQ8RFgj+XMYpwcTlGU/ZdvlsVyOu8zSLw76y4292iGQayQpFKrRnOraZfhKPHdoqkvzQoO/fXasyBGPxF3x9TGdB/nfcbj7HdlVEfEfujTfjqqUo1/feQclPhRAZkaG/nM0jLJMCnD/6tD947LNK8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vtxlz03rpz6K9Sn;
	Wed,  5 Jun 2024 01:04:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C322A140A87;
	Wed,  5 Jun 2024 01:05:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 18:05:56 +0100
Date: Tue, 4 Jun 2024 18:05:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Itay
 Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, "David Ahern" <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, "Jiri Pirko" <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240604180555.000063c2@Huawei.com>
In-Reply-To: <20240604155009.GJ19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240604093219.GN3884@unreal>
	<20240604155009.GJ19897@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 4 Jun 2024 12:50:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 04, 2024 at 12:32:19PM +0300, Leon Romanovsky wrote:
> > > +static struct fwctl_device *
> > > +_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
> > > +{
> > > +	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
> > > +
> > > +	if (!fwctl)
> > > +		return NULL;  
> > 
> > <...>
> >   
> > > +/* Drivers use the fwctl_alloc_device() wrapper */
> > > +struct fwctl_device *_fwctl_alloc_device(struct device *parent,
> > > +					 const struct fwctl_ops *ops,
> > > +					 size_t size)
> > > +{
> > > +	struct fwctl_device *fwctl __free(fwctl) =
> > > +		_alloc_device(parent, ops, size);  
> > 
> > I'm not a big fan of cleanup.h pattern as it hides important to me
> > information about memory object lifetime and by "solving" one class of
> > problems it creates another one.  
> 
> I'm trying it here. One of the most common bugs I end up fixing is
> error unwind and cleanup.h has successfully removed all of it. Let's
> find out, others thought it was a good idea to add the infrastructure.
> 
> One thing that seems clear in my work here is that you should not use
> cleanup.h if you don't have simple memory lifetime, like the above
> case where the memory is freed if the function fails.
> 
> > You didn't check if fwctl is NULL before using it.  
> 
> Oops, yes
> 
> > > +	int devnum;
> > > +
> > > +	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
> > > +	if (devnum < 0)
> > > +		return NULL;
> > > +	fwctl->dev.devt = fwctl_dev + devnum;
> > > +
> > > +	cdev_init(&fwctl->cdev, &fwctl_fops);
> > > +	fwctl->cdev.owner = THIS_MODULE;
> > > +
> > > +	if (dev_set_name(&fwctl->dev, "fwctl%d", fwctl->dev.devt - fwctl_dev))  
> > 
> > Did you miss ida_free() here?  
> 
> No, the put_device() does it in the release function. The __free
> always calls fwctl_put()/put_device() on failure, and within all
> functions except _alloc_device() the put_device() is the correct way
> to free this memory.

The conditional handling of the ida having been allocated or not is a bit ugly
as I think it's just papering over this corner case.
Can fwctl_dev and devnum both be zero? In practice no, but is that guaranteed
for all time? Maybe...

We got some kick back from Linus a while back in CXL and the outcome was
a few more helpers rather than too much cleverness in the use of __free.

Trick for this is often to define a small function that allocates both the
ida and the device. With in that micro function handle the one error path
or if you only have two things to do, you can use __free() for the allocation.

Something like

static struct fwctl_device *__alloc_device_and_devt(sizet_t size)
{
	struct fw_ctl_device *fwctl;
	int devnum;

	fwctl = ida_alloc_max(&fwct ...);
	if (!fwctl)
		return NULL;

	devnum = ida_alloc_max(&fwct ...);
	if (devnum < 0) {
		kfree(fwctl);
		return NULL;
	}	

	fwctl->dev.devt = fwctl_Ddev + devnum;

	reutrn fwctl;
}

Then call device_initialize() on the returned structure ->dev as you know
you ida and the containing structure are both in a state where the put_device()
call doesn't need conditions on 'how initialized' it is.

Still, maybe the ugly is fine.  


> 
> Thanks,
> Jason
> 
> 


