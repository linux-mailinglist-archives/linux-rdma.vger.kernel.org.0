Return-Path: <linux-rdma+bounces-3663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9A92829E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 09:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD65287F4F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4488144D25;
	Fri,  5 Jul 2024 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="phNk1xRH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF848139D1B;
	Fri,  5 Jul 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164039; cv=none; b=f67Q9TgPQVVYnr1T5fgwkcnnqPXkVM5eRkIuyu6DmwwOGtpFGhTbx/zAl0I6LGsY46CryvAdLseuSCHudrpjthFHTQ5ZhRupcjDaa57W1hjcgSLRZLQnq+U/1DHT0rgxfstZ3g71Hp+ymVB6fMFWorRJK5KBbYwx05eGcmGFufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164039; c=relaxed/simple;
	bh=xLtifxE+kqcKNAFU+XOWtYqz1GUTgsTA2Jtf154doUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjs9BwXSvkg8Oo9EU8J/0NcC/v2YyOpZ7HXgmpenyWJOhWVutOLdZe/pfTJO2OuHmzXgCNnUEPsNAv8GSO2pEwnk6lG5/wlZu8t8fzSqb1KjE6SGwP/vtYo4WlQJ2xRRxtjN+iT9lPmwl0cKUqAbsChHMRf9jrhraaZRGmpig1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=phNk1xRH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mSoRdEvE9ngNNW/Fvl9r4sE1gC92uZ4xSa+Z+FECORo=; b=phNk1xRH8vSfNAwEeEb4OY6vyA
	ZtkfLuMwyfvnFMOX6inCoxL93V43P7K6cstTM+xCzIwh6eHRyGPjQTcWPM9YiMz5o46DXkmL7Xul/
	WwJlktjVAGjlASSYuRtxe3dUI6S4c8oPCsMz6czPit9nRn4fiLHm23nM5B3Xq9O5hgren3A4/eaJ1
	zhRNXsOCq+kZ0227NJee/FSjN0OHaQT4CEFaM9z9S1rhiTpkNDB5ALUsR4xXjXELfRid0WvWUH70x
	dYsrGzcgnBT0jRj/y4qIQhCzQKIUd1bjW/tFq9cROt4E2QAf8X3GN+E8IMjJ4YeaT3cTh1R33GSOV
	cx4P4imA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPdFD-0000000F8lp-2Ilh;
	Fri, 05 Jul 2024 07:20:35 +0000
Date: Fri, 5 Jul 2024 00:20:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Tejun Heo <tj@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v3 1/3] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <Zoeew3RMOoUIMHz9@infradead.org>
References: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
 <20240704163724.2462161-2-martin.oliveira@eideticom.com>
 <ZobVol_trCwtwjK4@casper.infradead.org>
 <310071c8-04b7-4996-a496-614c2bdb8163@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <310071c8-04b7-4996-a496-614c2bdb8163@eideticom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 04, 2024 at 02:43:04PM -0600, Martin Oliveira wrote:
> On 2024-07-04 11:02, Matthew Wilcox wrote:> Seems to me we should actually _handle_ that, not do something wrong.
> > eg:
> > 
> >         if (vma->vm_ops) {
> >                 if (vma->vm_ops->close)
> >                         goto out_put;
> >                 if (WARN_ON(vma->vm_ops->page_mkwrite))
> >                         goto out_put;
> >         }
> 
> Good point.

Btw, sorry if I mislead you with my WARN_ON_ONCE suggestion.  That
was always intended in addition to the error handling, not instead.
(In fact there are very few reasons to use WARN_ON* without actually
handling the error as well).

> 
> > or maybe this doesn't need to be a WARN at all?  After all, there
> > isn't one for having a ->close method, so why is page_mkwrite special?
> 
> Hmm yeah, they should probably be treated the same.
> 
> Maybe ->close should be converted to WARN as well? It would be easier to
> catch an error this way than chasing the EINVAL, but I'm OK either way.

Yes, doing the same for ->close or anything unimplemented would be
nice.  But it's not really in scope for this series.

kernfs really should be using it's own ops instead of abusing
file_operations, but that's even more out of scope..


