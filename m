Return-Path: <linux-rdma+bounces-3653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E3927B84
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 19:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FC31F239E3
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F781B374D;
	Thu,  4 Jul 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cYDhpaEp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47A1B373D;
	Thu,  4 Jul 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112561; cv=none; b=WTvsDzCwa+fiaOzyM+QwxedqKdOLUYvcBXEGuHxlkVgbdy+JqRYmOIRr8V+nYWJWoSToDglebjpQ9m/gvtU2uZ2q2tgv6YbzUF8e8AfuEy64QLAGcLBGZ2QPApkqgI9c4Eeo6NzllxXQXdZLeZvrHI/E+tKPR2IWCmKJcfj9Ghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112561; c=relaxed/simple;
	bh=PMbpOjeTPJIQ+ym2vhhuRkSdYi3dqwlIAbf+Z6clYtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiK8aQ0lhJZKr0+k1Qq9IBAQYBDHxbrDpY2X3uqgPT1g/87y5CDhiFX8P8ZE2dwa6cUnXA3+QCKOr0V9pvt7GyWIRvZBCKgDYJgmNUUF52Kr+9dr7zTFSN6Nf581KoHVVqDifi5QfDDJmZBqVJR2desZqI4I4l+M4dR783HS4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cYDhpaEp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GY7/X0M+gI9Jpp0bI//NE3lhiuxlSU8pX2nOGe9YRDw=; b=cYDhpaEpztN5af7E8bRP9PpO7G
	4OAsGGjv+rfnfSemDBe6UVLQzgP55uV1g8yICN1AjG6ampErvcJctrgTK+Je5AxYk7Jk60pSkytEY
	8YvfsAtotDFCTYpFy4tfzpvoPWnf/8ZCtW2RRG8cK5oAt8GvSUDfp2HJlVDg8cI1NjCw1UAibXipJ
	VQk0dDZaG974XJw1MWnZ9htTsrO2uQh2d4e3jsTexzxRlZXrlL7vlM4VByzgPQmky/HSe4k9eJXjF
	95lnPkVRjwC6V8rtNzMtNxYzhiEZdDcwPqRTEKNrQryELD/9BdYjK5oWPJOBHwqASbpiWmiuL1Do/
	VjPke0jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPql-000000033Fn-03Ps;
	Thu, 04 Jul 2024 17:02:27 +0000
Date: Thu, 4 Jul 2024 18:02:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v3 1/3] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <ZobVol_trCwtwjK4@casper.infradead.org>
References: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
 <20240704163724.2462161-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704163724.2462161-2-martin.oliveira@eideticom.com>

On Thu, Jul 04, 2024 at 10:37:22AM -0600, Martin Oliveira wrote:
> @@ -482,6 +459,8 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (vma->vm_ops && vma->vm_ops->close)
>  		goto out_put;
>  
> +	WARN_ON(vma->vm_ops && vma->vm_ops->page_mkwrite);
> +
>  	rc = 0;
>  	if (!of->mmapped) {
>  		of->mmapped = true;

Seems to me we should actually _handle_ that, not do something wrong.
eg:

	if (vma->vm_ops) {
		if (vma->vm_ops->close)
			goto out_put;
		if (WARN_ON(vma->vm_ops->page_mkwrite))
			goto out_put;
	}

or maybe this doesn't need to be a WARN at all?  After all, there
isn't one for having a ->close method, so why is page_mkwrite special?

