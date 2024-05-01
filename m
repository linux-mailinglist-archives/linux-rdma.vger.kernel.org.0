Return-Path: <linux-rdma+bounces-2185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECF8B8538
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 07:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C661F22A20
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 05:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463B3F9D5;
	Wed,  1 May 2024 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQxw3065"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C91D68F;
	Wed,  1 May 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714540246; cv=none; b=fqCOUuyFsqrhsM+kCqn+bYnQMDqADFE9LXUB9yo/8uzI2TytCTNibYeA3YHeyG3ld9SmtMa3tJZIByFm/kpqZH59nUPb8WoFtqU0WgTXx/ZROZboVBTBt/g5LlzyHKveCWCbFexTHFLCl7VwQkMxe5BvRwg7O4RERI2GhyNQDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714540246; c=relaxed/simple;
	bh=Bv88zmq3RPg/NvCA06fPuh97Gm9jkIZqCFlN99SZZdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwkL/aGCJTfoohRV6x71mOHizkyhoAssKS2+0cGNZgWHY0kyrxyoZvrAf0x0fBOFlQBWn5GTC+p5deodWlc6fn1iJ7OIIfhJQg1qFzuqw5J/FO3ea0Fd/QFj5OwndNUSrTS8rE3NtviG7uHDfADGnLF/DiYyO+2CEzRCKQpPMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NQxw3065; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZJnNK/MnEG9qMPL1FuqG5TKlT7E9DMRIpWhLMGe3XgM=; b=NQxw3065lxg4fQI2HFvlgUpYti
	lzlbrrDiKLvY44vYon3tjNHAtrlrrycj0S6cn1buHgeE4YA6+aVO7FE0Ty02nWJz6ELsuqaPiUlJY
	Ax5iMe6n526pPWRYCruonTVf47E4t/VzvGghGANyb4GLc4niPnZiqYwsaWpaTSLHGzrfr4I37FIaP
	uLsA5ovN1PODX9uwAnu/aMBo8ng7dB0VNJeoh2w10EavNCqcKRgCdH6ayCJuoXUhbXyDjkoEkGMcF
	IH05qXIOpZdukF0sps1voGXIzh0IFAKC8vBZNFGvDSVa2RuZDSCM45D3QRvYucEPD3PfUWnJHbiIN
	9bbH2Qgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s22Et-00000008apr-1VQ5;
	Wed, 01 May 2024 05:10:43 +0000
Date: Tue, 30 Apr 2024 22:10:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pak Markthub <pmarkthub@nvidia.com>
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
Message-ID: <ZjHO04Rb75TIlmkA@infradead.org>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501003117.257735-1-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +		pinned = -ENOMEM;
> +		int attempts = 0;
> +		/*
> +		 * pin_user_pages_fast() can return -EAGAIN, due to falling back
> +		 * to gup-slow and then failing to migrate pages out of
> +		 * ZONE_MOVABLE due to a transient elevated page refcount.
> +		 *
> +		 * One retry is enough to avoid this problem, so far, but let's
> +		 * use a slightly higher retry count just in case even larger
> +		 * systems have a longer-lasting transient refcount problem.
> +		 *
> +		 */
> +		static const int MAX_ATTEMPTS = 3;
> +
> +		while (pinned == -EAGAIN && attempts < MAX_ATTEMPTS) {
> +			pinned = pin_user_pages_fast(cur_base,
> +						     min_t(unsigned long,
> +							npages, PAGE_SIZE /
> +							sizeof(struct page *)),
> +						     gup_flags, page_list);
>  			ret = pinned;
> -			goto umem_release;
> +			attempts++;
> +
> +			if (pinned == -EAGAIN)
> +				continue;
>  		}
> +		if (pinned < 0)
> +			goto umem_release;

This doesn't make sense.  IFF a blind retry is all that is needed it
should be done in the core functionality.  I fear it's not that easy,
though.


