Return-Path: <linux-rdma+bounces-4105-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFBD941E60
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 19:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63554285EAC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA01A76D3;
	Tue, 30 Jul 2024 17:28:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86681A76B6;
	Tue, 30 Jul 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360495; cv=none; b=P+Aa5Hk9kjLX/JpAnH73ClLY57NcXc7aiuaCU2Et6dcetg+oR3zDmoE6VOLAkNH/Amqa9zLfj4vT10LeYpyCGpJiKANvziqwgFsHiFkSyHjU5gSDnndZpMOKaf0YsnY6VYDL1Inqp6BGf4b4ph11hKN9l37bWBVPiRbSc96DwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360495; c=relaxed/simple;
	bh=7daEbXGSt0R/2I9y22jF33qxuWpoXdUkkONHXI538qk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtdOANu0zDoNYx794lGN22H400XbW1bOINFI/99+msYGe+bi5TZfYBDjwh/grOJd/U5eco3Jz8Wu2UsnKTSHrzlrMOW2ZeaM9yOwB2v05vqz8SFKM4DRze+TObJRCWdo6NkJneXUtQURrj9w8vA7MVQ8Z8AA/xiouDgNqC+AD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WYMZ84m1Vz6K8qR;
	Wed, 31 Jul 2024 01:25:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 056D6140AA7;
	Wed, 31 Jul 2024 01:28:10 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 18:28:09 +0100
Date: Tue, 30 Jul 2024 18:28:08 +0100
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
Subject: Re: [PATCH v2 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240730182808.00003af7@Huawei.com>
In-Reply-To: <20240729170553.GE3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<20240726160157.0000797d@Huawei.com>
	<20240729170553.GE3625856@nvidia.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jul 2024 14:05:53 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jul 26, 2024 at 04:01:57PM +0100, Jonathan Cameron wrote:
> 
> > > +struct fwctl_ioctl_op {
> > > +	unsigned int size;
> > > +	unsigned int min_size;
> > > +	unsigned int ioctl_num;
> > > +	int (*execute)(struct fwctl_ucmd *ucmd);
> > > +};
> > > +
> > > +#define IOCTL_OP(_ioctl, _fn, _struct, _last)                         \
> > > +	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                        \  
> > 
> > If this is always zero indexed, maybe just drop the - FWCTL_CMD_BASE here
> > and elsewhere?  Maybe through in a BUILD_BUG to confirm it is always 0.  
> 
> I left it like this in case someone had different ideas for the number
> space (iommufd uses a non 0 base also). I think either is fine, and I
> slightly prefer keeping it rather than a static_assert.

Ok. Feels a little messy to me. But fair enough I guess.


> > > +	if (!uctx)
> > > +		return -ENOMEM;
> > > +
> > > +	uctx->fwctl = fwctl;
> > > +	ret = fwctl->ops->open_uctx(uctx);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	scoped_guard(mutex, &fwctl->uctx_list_lock) {
> > > +		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
> > > +	}  
> > 
> > I guess more may come later but do we need {}?  
> 
> I guessed the extra {} would be style guide for this construct?

Maybe. Not seen any statements on that yet, and it's becoming
quite common.

> 
> > >  static int fwctl_fops_release(struct inode *inode, struct file *filp)
> > >  {
> > > -	struct fwctl_device *fwctl = filp->private_data;
> > > +	struct fwctl_uctx *uctx = filp->private_data;
> > > +	struct fwctl_device *fwctl = uctx->fwctl;
> > >  
> > > +	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> > > +		if (fwctl->ops) {  
> > 
> > Maybe a comment on when this path happens to help the reader
> > along. (when the file is closed and device is still alive).
> > Otherwise was cleaned up already in fwctl_unregister()  
> 
> 	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> 		/*
> 		 * fwctl_unregister() has already removed the driver and
> 		 * destroyed the uctx.
> 		 */
> 		if (fwctl->ops) {
> 

Good.

> > >  void fwctl_unregister(struct fwctl_device *fwctl)
> > >  {
> > > +	struct fwctl_uctx *uctx;
> > > +
> > >  	cdev_device_del(&fwctl->cdev, &fwctl->dev);
> > >  
> > > +	/* Disable and free the driver's resources for any still open FDs. */
> > > +	guard(rwsem_write)(&fwctl->registration_lock);
> > > +	guard(mutex)(&fwctl->uctx_list_lock);
> > > +	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
> > > +						struct fwctl_uctx,
> > > +						uctx_list_entry)))
> > > +		fwctl_destroy_uctx(uctx);
> > > +  
> > 
> > Obviously it's a little more heavy weight but I'd just use
> > list_for_each_entry_safe()
> > 
> > Less effort for reviewers than consider the custom iteration
> > you are doing instead.  
> 
> For these constructs the goal is the make the list empty, it is a
> tinsy bit safer/clearer to drive the list to empty purposefully rather
> than iterate over it and hope it is empty once done.
> 
> However there is no possible way that list_for_each_entry_safe() would
> be an unsafe construct here. I can change it if you feel strongly

Meh. You get to maintain this if it flies, so your choice.

> 
> > > @@ -26,6 +39,10 @@ struct fwctl_device {
> > >  	struct device dev;
> > >  	/* private: */
> > >  	struct cdev cdev;
> > > +
> > > +	struct rw_semaphore registration_lock;
> > > +	struct mutex uctx_list_lock;  
> > 
> > Even for private locks, a scope statement would
> > be good to have.  
> 
> Like so?
> 
> 	/*
> 	 * Protect ops, held for write when ops becomes NULL during unregister,
> 	 * held for read whenver ops is loaded or an ops function is running.

That does the job nicely.

> 	 */
> 	struct rw_semaphore registration_lock;
> 	/* Protect uctx_list */
> 	struct mutex uctx_list_lock;

> 
> > > +/**
> > > + * DOC: General ioctl format
> > > + *
> > > + * The ioctl interface follows a general format to allow for extensibility. Each
> > > + * ioctl is passed in a structure pointer as the argument providing the size of
> > > + * the structure in the first u32. The kernel checks that any structure space
> > > + * beyond what it understands is 0. This allows userspace to use the backward
> > > + * compatible portion while consistently using the newer, larger, structures.  
> > 
> > Is that particularly helpful?  Userspace needs to know not to put anything in
> > those fields, not hard for it to also know what the size it should send is?
> > The two will change together.  
> 
> It is very helpful for a practical userspace.
> 
> Lets say we have an ioctl struct:
> 
> struct fwctl_info {
> 	__u32 size;
> 	__u32 flags;
> 	__u32 out_device_type;
> 	__u32 device_data_len;
> 	__aligned_u64 out_device_data;
> };
> 
> And the basic userspace pattern is:
> 
>   struct fwctl_info info = {.size = sizeof(info), ...);
>   ioctl(fd, FWCTL_INFO, &info);
> 
> This works today and generates the 24 byte command.
> 
> Tomorrow the kernel adds a new member:
> 
> struct fwctl_info {
> 	__u32 size;
> 	__u32 flags;
> 	__u32 out_device_type;
> 	__u32 device_data_len;
> 	__aligned_u64 out_device_data;
> 	__aligned_u64 new_thing;
> };
> 
> Current builds of the userpace use a 24 byte command. A new kernel
> will see the 24 bytes and behave as before.
> 
> When I recompile the userspace with the updated header it will issue a
> 32 byte command with no source change.
> 
> Old kernel will see a 32 byte command with the trailing bytes it
> doesn't understand as 0 and keep working.
> 
> The new kernel will see the new_thing bytes are zero and behave the
> same as before.
> 
> If then the userspace decides to set new_thing the old kernel will
> stop working. Userspace can use some 'try and fail' approach to try
> again with new_thing = 0.

I'm not keen on try and fail interfaces because they become messy
if this has potentially be extended multiple times. Rest
of argument is fair enough. Thanks for the explanation.

> 
> It gives a whole bunch of easy paths for userspace, otherwise
> userspace has to be very careful to match the size of the struct to
> the ABI it is targetting. Realistically nobody will do that right.
> 
> Thanks,
> Jason


