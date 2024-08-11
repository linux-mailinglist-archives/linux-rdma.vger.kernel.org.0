Return-Path: <linux-rdma+bounces-4306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92394E088
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A49F2819FA
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B9219E0;
	Sun, 11 Aug 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftHBMIeA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF51CAAF;
	Sun, 11 Aug 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723365121; cv=none; b=irsc3sVmWhMOZRR5nArG7qxzQ7XLx5dRfYgZePomNguN03DpFXcNtu/g17ounkY61+wBANzDMYncU9BevpsKLGqyzDSlwi7SjEr+evnEVm7mP9qWD8V9SoIYGVgYHNGnKyXPlKpqO5cCqa/8BJ36Jy1rVJVk2X6vDUlupD0KfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723365121; c=relaxed/simple;
	bh=zLtDOM7PQ8iLss9xVrpNuIEalRTzz+iItddnV7DhAnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxB8OOcR+DbtCyQc3gIFhwdNHehtyg2wEOOwEDyvmJCtZWy10Wa6whoZ0DtHAxJirl7/bhLM4lKcRUlh+N1azw+yZK/bN3z263vEm+2Z+zTN68Z5nc0oZJlb9VpMHGkhWOxVqtpeNn9dpjVfEzHqmlU/Zdw+cid4CWkTbbDoP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftHBMIeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76943C4AF09;
	Sun, 11 Aug 2024 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723365121;
	bh=zLtDOM7PQ8iLss9xVrpNuIEalRTzz+iItddnV7DhAnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftHBMIeABzDSuJnmpzkyW86O9e3QD3QBU6PlGfguePd6wfRA4Fuz4M70NCgKtoICL
	 jjdvLFzEB2nH1T8P60paJkE71bSTrJur5H1ekQjJphmcf+PRn9K9mlZBltX3GzySXb
	 vMlpOgi/MnK222BMJjVDlHkVGDn7Lz0oto3i6hJ8=
Date: Sun, 11 Aug 2024 10:31:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 1/4] kernfs: add a WARN_ON_ONCE if ->close is set
Message-ID: <2024081141-cattail-kick-3ff5@gregkh>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-2-martin.oliveira@eideticom.com>
 <2024080933-jazz-supernova-9f3a@gregkh>
 <a9468d88-c2e9-431c-a2bc-847ce9743729@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9468d88-c2e9-431c-a2bc-847ce9743729@eideticom.com>

On Fri, Aug 09, 2024 at 09:41:48AM -0600, Martin Oliveira wrote:
> On 2024-08-08 23:37, Greg Kroah-Hartman wrote:
> >> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> >> index 8502ef68459b..72cc51dcf870 100644
> >> --- a/fs/kernfs/file.c
> >> +++ b/fs/kernfs/file.c
> >> @@ -479,7 +479,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
> >>        * It is not possible to successfully wrap close.
> >>        * So error if someone is trying to use close.
> >>        */
> >> -     if (vma->vm_ops && vma->vm_ops->close)
> >> +     if (WARN_ON_ONCE(vma->vm_ops && vma->vm_ops->close))
> > 
> > So you just rebooted a machine that hits this, loosing data everywhere.
> > Not nice :(
> 
> Well, apologies for that, but there's no way to know what every single machine
> out there is doing...
> 
> However if this machine is using ->close when that's clearly marked as
> unsupported then shouldn't we fix that?

return an error properly?

