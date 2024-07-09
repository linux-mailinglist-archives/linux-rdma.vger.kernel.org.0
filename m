Return-Path: <linux-rdma+bounces-3769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3B92BD0A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0D9B22E0F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814119D087;
	Tue,  9 Jul 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PNUrmg7m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FD19D076;
	Tue,  9 Jul 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535695; cv=none; b=RAwuM+Yx5lR03mDuMI2qYBpS0mZU+1NxA0/1wxjKfH4vrVX6X3rL3nC1eTiN5clg6UsmzNjQW0nWsOg0eRHSgUePZ+Kmoxxp3SEm2Hx+60l6YHBmR3uzBmm89uXZlMDVw71HYvDyt8eR4lYzK/Z7unT5WgQwZm5MOcQjLRKTbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535695; c=relaxed/simple;
	bh=RBGNqoGZ83w+eqL0eQQIia9r9WEn3fSMYCGg19iJVpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8Tzv/o61XKTG8qVITkBJdUQnf8CE6mlRgdwFk0EFIWcabsHAhz/DLOeEsJpfmCf3ttt6nN+MNYKlj2E0sRwpaFHYSHAj68n8EDV5zU0Nk5ayhYcEIa52HixdpeGb9jRCV47Bx1ndv51lTqwfB/qPGG3yRCoYh27e9US84khnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PNUrmg7m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ixPgUW2T4tXOs4aEeHspyZiL/y/SECkwdKfsz5YppK4=; b=PNUrmg7mTfVTPtsWmgtYB0RtCI
	+0LDV8xLaeQqGA+Onn0WbeqUWiGg7uGpTH/ImPKzJTsINKGRYlZIx9HD0o44/VxeTB0j4Rs+orUbP
	cB1qDdU2/yQXaeWbbAU38nphaqTuvUAKvbWg280ejLpZTi7CNmuJq3VzJJTYk3gUxkdjnvHe2Nhnh
	tiVmqeesgVndidkl4CeZB3DCsIJhmZEJ8MjdO2fHos4KZOKsNEnf1sfJ1yMpsttUwZYrO+q+jK1RS
	iVd1vzsx26M49iVtGAxosJFOR5k1iLNuQYOMUfO1lz//PqchV/ohqFWZQ+zi5qMow2ILOxaeV0OFJ
	nfOWqBNA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRBve-00000007yWA-0o2O;
	Tue, 09 Jul 2024 14:34:50 +0000
Date: Tue, 9 Jul 2024 15:34:50 +0100
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
Subject: Re: [PATCH v4 1/3] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <Zo1Kig5y-ggl0g_e@casper.infradead.org>
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
> -	/*
> -	 * It is not possible to successfully wrap close.
> -	 * So error if someone is trying to use close.
> -	 */
> -	if (vma->vm_ops && vma->vm_ops->close)
> -		goto out_put;
> +	if (vma->vm_ops) {
> +		/*
> +		 * It is not possible to successfully wrap close.
> +		 * So error if someone is trying to use close.
> +		 */
> +		if (vma->vm_ops->close)
> +			goto out_put;
> +
> +		if (WARN_ON_ONCE(vma->vm_ops->page_mkwrite))
> +			goto out_put;
> +	}

This is stupid.  Warn for both or neither.

