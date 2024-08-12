Return-Path: <linux-rdma+bounces-4316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0194E6D2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 08:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B4A282861
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 06:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEC14F9DB;
	Mon, 12 Aug 2024 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBSJz0mG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5F1537D6;
	Mon, 12 Aug 2024 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444694; cv=none; b=Yxl7f9b5YU7jGKPaxWQIiNsKB761by11uu/gFnJB3BZrV6jD8pekGZhgXeO1wYyK2veLd7E2BztFeZDiCrgyPdG7WptahCuFFXd1pr2XRp5KCiS0uc8VFJ8DI+fuD3LGMRp/6/f0g7WqRKohTNNmxCnThmBU2qr1nVJ5tZ5BU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444694; c=relaxed/simple;
	bh=YZPbBCNCNyl4ICx7FrNvj2HMt9tV6wDMzaPlydINxAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prwFTyqNg8sQdkkpsr7pXwwv0+4kLtuCYO4AAphRE4tNbdnise2N97CdTWa1s3XDTuLDnIkZd1tijiZKbn0K+e+fCyoe2W96+tchSkASJArdGhRGXNQ01PDBIa28cnTS9D3JXnuw/hQC8KJs5ZRF7E4NaHJf58ZAtT+Q/D/or6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MBSJz0mG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ulRAiGkS5n4S+P7CQGT1jtN5nIy1RM3sOKQEtCLBjro=; b=MBSJz0mGNUK08tYYjvzkweF6Es
	yQokYQStOm/bZB1vzTHzdYvytJW5+Uo5W76I5bkgf9QBXSUG4NctY4BfQV+8W1vU3K6z1w7cQsdSQ
	ITkLPJDQWSVuFYIffaZ1j8bZ8hHFRDiI32orZk+0NkX8DRh2hij1UtCUU0d2Fs/G8JokSwGR9HC9j
	y39H3gcx15Ll3UzRW5hfDCSbeeeejkwILKUAEuQpsurgTs7+hQKi6bb1NX2VlqXfodrybZgD3UOkR
	eWNumbUhIZwY8M90ygU+3cwF0eiZs8oazutm8F6pC202ITESlBqOnSvtYfaAhUd8jiEE6JThBALcr
	OmUwIMUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOh1-0000000H2sT-0g43;
	Mon, 12 Aug 2024 06:38:11 +0000
Date: Sun, 11 Aug 2024 23:38:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <Zrmt01OTCRywW55v@infradead.org>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-2-martin.oliveira@eideticom.com>
 <2024080933-jazz-supernova-9f3a@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024080933-jazz-supernova-9f3a@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 09, 2024 at 07:37:49AM +0200, Greg Kroah-Hartman wrote:
> >  	 * It is not possible to successfully wrap close.
> >  	 * So error if someone is trying to use close.
> >  	 */
> > -	if (vma->vm_ops && vma->vm_ops->close)
> > +	if (WARN_ON_ONCE(vma->vm_ops && vma->vm_ops->close))
> 
> So you just rebooted a machine that hits this, loosing data everywhere.
> Not nice :(

Huh.  if you are stupid enough to set panic_on_warn you get to keep
the pieces.  And our file systems are reliable to not use data on
an unclean shutdown anyway.

Pleaee stop these BS arguments.


