Return-Path: <linux-rdma+bounces-3756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E092AF66
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 07:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87CB1F21A5C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F912C52F;
	Tue,  9 Jul 2024 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XDqYKgsI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB04D8BB;
	Tue,  9 Jul 2024 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502680; cv=none; b=O5reOLvMf5Q5OwQHDK4k7ArcGcFB3uDxbTFcC05sIN9IHn3bLDf3aeXW7MuYzWwB+07qzN/k12x2MkhC3SIDEFA+GCX+bdLrcIH4/tCsQeHeJnbPf+IB6T3kypvtywW09q1AgZFp2GLtkBE7I2UlwhafuCO+XlGUkMQvcDc16GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502680; c=relaxed/simple;
	bh=4tizSs2TAz0RtnGGO1qTakHRK5xJiSrgMw06tNFDBRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doINVKSFpgQY+suw8TFBQajwBUdeEqydP/cOgkAMSgVX73NPjE8T/jBLBoyhXkluuzR+oKdiW0jYSXv5uM7yZnhm0jB2T8Hep41ORrive5cCirdJRWKfal3yjTMcWnre9GHjURWbk+hlx++wtiflL3421fkVUKLoew3qV2pw8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XDqYKgsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AFAC32782;
	Tue,  9 Jul 2024 05:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720502679;
	bh=4tizSs2TAz0RtnGGO1qTakHRK5xJiSrgMw06tNFDBRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDqYKgsIjcET2kG1gBOUaqJpVZRjnWrfe/SliV+a6cDFnihfT2gV17xgJBP/01gLl
	 KBHufVqFyunnGuPTq+OvlHH2V0IuFokKYmXxwNZ6Kl6NojikK6lbLLQonmlYHil3e0
	 h9DrFrcyO9g+jAUgHYWyvHHmvafZKTrKlMgmSCDs=
Date: Tue, 9 Jul 2024 07:24:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v4 1/3] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <2024070927-expand-carless-0680@gregkh>
References: <20240708165714.3401377-1-martin.oliveira@eideticom.com>
 <20240708165714.3401377-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708165714.3401377-2-martin.oliveira@eideticom.com>

On Mon, Jul 08, 2024 at 10:57:12AM -0600, Martin Oliveira wrote:
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
> just remove the .page_mkwrite from kernfs_ops and WARN if an mmap()
> implementation sets .page_mkwrite.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
> ---
>  fs/kernfs/file.c | 40 +++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 29 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

