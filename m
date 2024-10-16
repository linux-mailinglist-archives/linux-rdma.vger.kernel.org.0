Return-Path: <linux-rdma+bounces-5417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798429A004F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 06:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C821C22A45
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 04:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88618784A;
	Wed, 16 Oct 2024 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MqV+qFQc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62121E3BA;
	Wed, 16 Oct 2024 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054173; cv=none; b=BbfcUbIr8B/AdlVlNt6lEAik7UmusMJ9SjO5kxtuevhYesM70jCo6QibxWJ5JcjVXNlA6xK1eogyQGrFE+c9y3GJxrPj+32UTV60YhdgWaJk0kulrGadACZatN3N9IgHA8EkhyJ8PHoW/zXTd2aerjLxWOuGbbPXXKbSo9luz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054173; c=relaxed/simple;
	bh=Adbl6w953OfpERFTN55CnQalmSrAYMmE+cfg4wAl82E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIvmEpLG+eBJyr0MvrKNglWNybQz6D5Lb5j30pdAYt/mQ8oDz99ckHE6D6o0pD0CP3eyE9hxN++GJnK2tF327WJ8DGzWMJRXWBNP0rbXaOVI3SEuVL4l0yiLzWh092pjoZxZjVgpdFQIqI4UTuKK41k451vqYc5J60bxXWr6m1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MqV+qFQc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kxyPD5bG6ZQ9YWFtuWdz5TSG4aAx8Z8FeonMRrsbG2Y=; b=MqV+qFQc92N3CL/ic5ApcrdMw2
	c24JnpTSRS5PAr8laq3vclDbHiC6L0/MRDr8JVgE/EsQukR0EE6g4rPwEJaEdUlUpBkE/+wzFpauT
	bxG6GsG9/5BgqmfpGX1IO5RqAZswJUoLsESFQJIToTz03iIPPK2sqTVnXcvte/MAYAQakMxzxd7BA
	3+1XPhuEQERK61zayh0nfC8QteteaigVzouwtESK8HIdZOl2kU2aoBGFwfM31U+5stL/bkQpOCl0S
	u5Pac120Gt8yJfbhXtDYfv+Qkv2ytyAtql74XxyRz4n9kNfBgwcwFdcDgkAF4fFX3QpdfCEn3t35Z
	mbbl8dww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0vyU-0000000AWGS-1PeP;
	Wed, 16 Oct 2024 04:49:30 +0000
Date: Tue, 15 Oct 2024 21:49:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-mm@kvack.org, herbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, jgg@ziepe.ca, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, dri-devel@lists.freedesktop.org,
	apopple@nvidia.com, bskeggs@nvidia.com,
	Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <Zw9F2uiq6-znYmTk@infradead.org>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015152348.3055360-2-ymaman@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The subject does not make sense.  All P2P is on ZONE_DEVICE pages.
It seems like this is about device private memory?

On Tue, Oct 15, 2024 at 06:23:45PM +0300, Yonatan Maman wrote:
> From: Yonatan Maman <Ymaman@Nvidia.com>
> 
> hmm_range_fault() natively triggers a page fault on device private
> pages, migrating them to RAM.

That "natively" above doesn't make sense to me.

> In some cases, such as with RDMA devices,
> the migration overhead between the device (e.g., GPU) and the CPU, and
> vice-versa, significantly damages performance. Thus, enabling Peer-to-

s/damages/degrades/

> Peer (P2P) DMA access for device private page might be crucial for
> minimizing data transfer overhead.
> 
> This change introduces an API to support P2P connections for device
> private pages by implementing the following:

"This change.. " or "This patch.." is pointless, just explain what you
are doing.

> 
>  - Leveraging the struct pagemap_ops for P2P Page Callbacks. This
>    callback involves mapping the page to MMIO and returning the
>    corresponding PCI_P2P page.

While P2P uses the same underlying PCIe TLPs as MMIO, it is not
MMIO by definition, as memory mapped I/O is by definition about
the CPU memory mappping so that load and store instructions cause
the I/O.  It also uses very different concepts in Linux.

>  - Utilizing hmm_range_fault for Initializing P2P Connections. The API

There is no concept of a "connection" in PCIe dta transfers.

>    also adds the HMM_PFN_REQ_TRY_P2P flag option for the
>    hmm_range_fault caller to initialize P2P. If set, hmm_range_fault
>    attempts initializing the P2P connection first, if the owner device
>    supports P2P, using p2p_page. In case of failure or lack of support,
>    hmm_range_fault will continue with the regular flow of migrating the
>    page to RAM.

What is the need for the flag?  As far as I can tell from reading
the series, the P2P mapping is entirely transparent to the callers
of hmm_range_fault.

> +	/*
> +	 * Used for private (un-addressable) device memory only. Return a
> +	 * corresponding struct page, that can be mapped to device
> +	 * (e.g using dma_map_page)
> +	 */
> +	struct page *(*get_dma_page_for_device)(struct page *private_page);

We are talking about P2P memory here.  How do you manage to get a page
that dma_map_page can be used on?  All P2P memory needs to use the P2P
aware dma_map_sg as the pages for P2P memory are just fake zone device
pages.


> +		 * P2P for supported pages, and according to caller request
> +		 * translate the private page to the match P2P page if it fails
> +		 * continue with the regular flow
> +		 */
> +		if (is_device_private_entry(entry)) {
> +			get_dma_page_handler =
> +				pfn_swap_entry_to_page(entry)
> +					->pgmap->ops->get_dma_page_for_device;
> +			if ((hmm_vma_walk->range->default_flags &
> +			    HMM_PFN_REQ_ALLOW_P2P) &&
> +			    get_dma_page_handler) {
> +				dma_page = get_dma_page_handler(
> +					pfn_swap_entry_to_page(entry));

This is really messy.  You probably really want to share a branch
with the private page handling for the owner so that you only need
a single is_device_private_entry and can use a local variable for
to shortcut finding the page.  Probably best done with a little helper:

Then  this becomes:

static bool hmm_handle_device_private(struct hmm_range *range,
		swp_entry_t entry, unsigned long *hmm_pfn)
{
	struct page *page = pfn_swap_entry_to_page(entry);
	struct dev_pagemap *pgmap = page->pgmap;

	if (pgmap->owner == range->dev_private_owner) {
		*hmm_pfn = swp_offset_pfn(entry);
		goto found;
	}

	if (pgmap->ops->get_dma_page_for_device) {
		*hmm_pfn =
			page_to_pfn(pgmap->ops->get_dma_page_for_device(page));
		goto found;
	}

	return false;

found:
	*hmm_pfn |= HMM_PFN_VALID
	if (is_writable_device_private_entry(entry))
		*hmm_pfn |= HMM_PFN_WRITE;
	return true;
}

which also makes it clear that returning a page from the method is
not that great, a PFN might work a lot better, e.g.

	unsigned long (*device_private_dma_pfn)(struct page *page);

