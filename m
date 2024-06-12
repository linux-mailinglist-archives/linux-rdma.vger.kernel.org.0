Return-Path: <linux-rdma+bounces-3072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F5C904DB2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 10:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12121C22F46
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 08:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857016C6BD;
	Wed, 12 Jun 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RzkkBTBA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDD4C63;
	Wed, 12 Jun 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179795; cv=none; b=bm8FfxnjmZyBPovB7Lo7xCLpkPM20AhWtRaX3yiYG3EqMYoDHiyJ2mY5ZHeXOlScOW7dRd9nNrq0JgoRo3LV9iWRih+4qypTLWSObxhQzgp5Ukom9+tB/vd6V8I3i42fqbY0BmhWhabXsFYP3Ioj6xpM6MEMgwf6oFfxG9qHYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179795; c=relaxed/simple;
	bh=LH2QVR8RIElSNdKCwQD7JEh8pcjMKW0aQHLDo1mJV/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3dB9DHnvgFXyW9j8BC0CkltpkyeA8JQXl6Yppig4zrqhdVvNBTV6w+bxedafNcr1W+uAv1Ua2z1fc2mQi00wCvZb8ddaT5GOFsfTbawmKSq7ZsrQdRW/lmPt/Sd3QZdDn6JHc2RjiEXE1VnUj8kulZF6HHkNPAamAL/fCZCGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RzkkBTBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1B6C3277B;
	Wed, 12 Jun 2024 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718179794;
	bh=LH2QVR8RIElSNdKCwQD7JEh8pcjMKW0aQHLDo1mJV/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzkkBTBA235rwtWwycIQj2KqVbizGP8wNzoEnhUb4cLSNRP9uK7hGXKcoL0q4iykq
	 t9N0SiPmsqQsiLntlpTpWYkxZQU3y8l3mrAjBndh7BKHKocqhTEJ/OfeDFP15pqTQ/
	 bvSdTeTNmYUQIldzhRBCA7igwF4H6CcWlAaqxHTw=
Date: Wed, 12 Jun 2024 10:09:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>
Subject: Re: [PATCH v2 1/4] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <2024061242-puzzling-implicit-e64e@gregkh>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
 <20240611182732.360317-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611182732.360317-2-martin.oliveira@eideticom.com>

On Tue, Jun 11, 2024 at 12:27:29PM -0600, Martin Oliveira wrote:
> The .page_mkwrite operator of kernfs just calls file_update_time().
> This is the same behaviour that the fault code does if .page_mkwrite is
> not set.
> 
> Furthermore, having the page_mkwrite() operator causes
> writable_file_mapping_allowed() to fail due to
> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
> enabling P2PDMA over RDMA.
> 
> There are no users of .page_mkwrite and no known valid use cases, so
> just remove the .page_mkwrite from kernfs_ops and return -EINVAL if an
> mmap() implementation sets .page_mkwrite.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
> ---
>  fs/kernfs/file.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

