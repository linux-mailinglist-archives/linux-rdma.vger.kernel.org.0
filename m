Return-Path: <linux-rdma+bounces-4106-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F6941EE2
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 19:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350F3B24F04
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C5C189915;
	Tue, 30 Jul 2024 17:34:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EF166315;
	Tue, 30 Jul 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360886; cv=none; b=N42gYNsJ08CR2ACvUWK0QKtuWu5Guc7v/7dZ1yCm/FMfVn7Qga+XtVw4GXmmlHolEEftlua4dkiQvou2+RE4N2aBIVKRIf6QF/L+Tk8vKQZS3/UNeXFG9LQioyF1c8+9r4aCmeZLrh6mlAjSrNPc4SlMbeXVtFtrPNBRhe2LLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360886; c=relaxed/simple;
	bh=IjT0k+OgZaf4w+AiOVwzunIw2usu0Ze/wZgJAFfEWsk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCb/fYdA15row+ZkiH83yP7IseZ5STuzvk7Ezf5qqx/IbmhJNLbAOU6d4iJM2bNt7jF5t4BoWu2dfApg/sUphUceEqa0IRQeeV7wqUPy/+5Hb7nP/bTNKDwU01dJTlTvACCtD96ne6r9DQH9WwyHdVHug5Y17MtwyCUMx4xdbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WYMjm4hWdz6K606;
	Wed, 31 Jul 2024 01:32:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5279A140133;
	Wed, 31 Jul 2024 01:34:42 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 18:34:41 +0100
Date: Tue, 30 Jul 2024 18:34:41 +0100
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
Subject: Re: [PATCH v2 3/8] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20240730183441.00004672@Huawei.com>
In-Reply-To: <20240729163513.GD3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<3-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<20240726161503.00001c85@Huawei.com>
	<20240729163513.GD3625856@nvidia.com>
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

On Mon, 29 Jul 2024 13:35:13 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jul 26, 2024 at 04:15:03PM +0100, Jonathan Cameron wrote:
> > On Mon, 24 Jun 2024 19:47:27 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > Userspace will need to know some details about the fwctl interface being
> > > used to locate the correct userspace code to communicate with the
> > > kernel. Provide a simple device_type enum indicating what the kernel
> > > driver is.  
> > 
> > As below - maybe consider a UUID?
> > Would let you decouple allocating those with upstreaming drivers.
> > We'll just get annoying races on the enum otherwise as multiple
> > drivers get upstreamed that use this.  
> 
> I view the coupling as a feature - controlling uABI number assignment
> is one of the subtle motivations the kernel community has typically
> used to encourage upstream participation.

Hmm. I'm not sure it's worth the possible pain if this becomes
popular.  Maybe you'll have to run a reservation hotline.


> 
> > > +/**
> > > + * struct fwctl_info - ioctl(FWCTL_INFO)
> > > + * @size: sizeof(struct fwctl_info)
> > > + * @flags: Must be 0
> > > + * @out_device_type: Returns the type of the device from enum fwctl_device_type  
> > 
> > Maybe a UUID?  Avoid need to synchronize that list for ever.
> >   
> > > + * @device_data_len: On input the length of the out_device_data memory. On
> > > + *	output the size of the kernel's device_data which may be larger or
> > > + *	smaller than the input. Maybe 0 on input.
> > > + * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
> > > + *	fill the entire memory, zeroing as required.  
> > 
> > Why do we need device in names of these two?  
> 
> I'm not sure I understand this question?
> 
> out_device_type returns the "name"
> 
> out_device_data returns a struct of data, the layout of the struct is
> defined by out_device_type

What is device in this case?  fwctl struct device, hardware device, something else?

I'm not sure what the names give over
fwctl_type, out_data_len, out_data

The first one can't just be type as likely as not out_data contains a
type field specific to the fwctl_device_type.

I don't feel that strongly about this though, so stick to device
if you like. I'll get used to it.

Jonathan
 
> 
> Jason


