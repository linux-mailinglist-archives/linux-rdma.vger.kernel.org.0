Return-Path: <linux-rdma+bounces-3004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274AC900C63
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9957288677
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2614B94A;
	Fri,  7 Jun 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYrXTcVt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387C139588;
	Fri,  7 Jun 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787886; cv=none; b=itrrWQ03OYdY3ckAzalCB7zV7/xaYUQqrJBWnbpxbRnIGMWmKtaGCxkQR6Hve1Fn4/i7rYJlaEkC1/CfPiLS7fEKh/CnqZPh1D/yXLBjK1BC8XQqvAH1nGhJ86rYEvrkbDiGhKhXePiozSstA0c2r52JnYVNHA61MLntvWEHUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787886; c=relaxed/simple;
	bh=l2TuVuG5EfkG98JENqnCwFuIerVqcUyCRo5aD5PVxpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/sn/4e2wqt1SIvnOm8BllnkY3WgLVwjbXgw0jFtQhFcH4uynMtf3tbALOBSILdc3TIsy1UJD7PLGZyOxy2sTMrtdvt6eAf7WDo3K/4y+iQ0qFLOFKFPIIAwjZcAhh3bgCe2Yx9cIu0NnCANBR8YCqdu2zpHjc4JHGJPx1qhBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYrXTcVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE86C2BBFC;
	Fri,  7 Jun 2024 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787886;
	bh=l2TuVuG5EfkG98JENqnCwFuIerVqcUyCRo5aD5PVxpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYrXTcVtp+1UVrzguQzrm278C0/EpbOO3MlDJqNv1hK0Bedkt7ZbaWgfHzWaHoi3D
	 /9V4Kd7tpSIK/SWejp6BOcYOVyjvSjQWT1wycjFkeubwHKddtzBkQQ2Po4ruKLmdTx
	 YwULqF186a190ebh5hC/cFAZqwgjgrjtkja6MvaA=
Date: Fri, 7 Jun 2024 21:18:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/6] kernfs: create vm_operations_struct without
 page_mkwrite()
Message-ID: <2024060755-stimuli-unworthy-61a8@gregkh>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
 <20240605192934.742369-2-martin.oliveira@eideticom.com>
 <2024060658-ember-unblessed-4c74@gregkh>
 <ZmKUpXQmMLpH8vf5@infradead.org>
 <69dc6610-e70a-46ca-a6e9-7ca183eb055c@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69dc6610-e70a-46ca-a6e9-7ca183eb055c@deltatee.com>

On Fri, Jun 07, 2024 at 10:16:58AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2024-06-06 23:03, Christoph Hellwig wrote:
> > On Thu, Jun 06, 2024 at 10:54:06PM +0200, Greg Kroah-Hartman wrote:
> >> On Wed, Jun 05, 2024 at 01:29:29PM -0600, Martin Oliveira wrote:
> >>> The standard kernfs vm_ops installs a page_mkwrite() operator which
> >>> modifies the file update time on write.
> >>>
> >>> This not always required (or makes sense), such as in the P2PDMA, which
> >>> uses the sysfs file as an allocator from userspace.
> >>
> >> That's not a good idea, please don't do that.  sysfs binary files are
> >> "pass through", why would you want to use this as an allocator?
> > 
> > I think the real question is why sysfs binary files implement
> > page_mkwrite by default.  page_mkwrite is needed for file systems that
> > need to allocate space from a free space pool, which seems odd for
> > sysfs.
> 
> The default page_mkwrite in kernfs just calls file_update_time() but, as
> I understand it, the fault code should call file_update_time() if
> page_mkwrite isn't set. So perhaps the easiest thing is to simply not
> add a page_mkwrite unless the vm_ops adds one.
> 
> It's not the easiest thing to trace, but as best as I can tell there are
> no kernfs binary attributes that use page_mkwrite. So alternatively,
> perhaps we could just disallow page_mkwrite in kernfs entirely?

Sure, let's do that.

