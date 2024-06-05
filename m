Return-Path: <linux-rdma+bounces-2921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A50468FD95D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 23:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C581F24A3A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419715FD08;
	Wed,  5 Jun 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT8g+35C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FF15FA6B;
	Wed,  5 Jun 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623902; cv=none; b=UXhw/42YTobchWnxjJYycDbXz+E/bDhRTV6SVGBybnqWjT8nLHpIcG5lka9GX+2btT4sSts1b2GUIqyF8czTNAQ7Oot3HMA9MStOp378FXrqDIsgZ4k7+twz0Nze3KqDoYt50bd+63zf8O+S/Pb08+Iagusrg/qGKC2TWn509Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623902; c=relaxed/simple;
	bh=CVFMj08n3jx14fA4p4rVO8oNP2YJkFvLHwp+4lE/nJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pfxxyhCIkrw+8BMIKo6M7h30BwHMZKABbaqg4UddbxSWxoKoPvLqdKup1kfo5n73u0I5Q9ARndY39Hu29fsZkUzgZRzNGkjmpmjAMYP3KenIVMGVdBPB24CP+eBuLKW6CFiTeWHrYDf6MbzIxU6/hNw8bvv9qYZ/26V+XbofXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT8g+35C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9E4C2BD11;
	Wed,  5 Jun 2024 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623902;
	bh=CVFMj08n3jx14fA4p4rVO8oNP2YJkFvLHwp+4lE/nJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FT8g+35CiFMlqdW45S1xvzcyh6rKx+CgS1WwjYzIADHjLKkvfngN74AXw7nrcOHNp
	 W/jTuM7rBD2tO/ss+up8NPfPp1AZQpaG6whs2KMNyRsFLFZoMjqPTlGQ8t4hrwJeZS
	 E3EtLD1WTLPWUouYrWzY9FwX38uX5LzwsPYcp/IX8m8T3Iq98c2VnukCiS/L/hYZu0
	 v2nuSygn69PZ4lUFigqffS3vhHrMngjxVJ2n5iSti6Z547E4IC7e5FBpyPYiW6XEFn
	 7jEBrGrhmjFYUkOwaoHkYJ1FLJD67eL3hatO1/UBa1dmULLixBRhE9em/5wFOtPZ4f
	 ocIB2a3M5WPmw==
Date: Wed, 5 Jun 2024 16:45:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 3/6] PCI/P2PDMA: create VMA without page_mkwrite()
 operator
Message-ID: <20240605214500.GA781636@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605192934.742369-4-martin.oliveira@eideticom.com>

On Wed, Jun 05, 2024 at 01:29:31PM -0600, Martin Oliveira wrote:
> The P2PDMA code does not need (or want) a page_mkwrite() operator on its
> VMA.
> 
> Furthermore, having the page_mkwrite() operator causes
> writable_file_mapping_allowed() to fail due to
> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
> enabling P2PDMA with FOLL_LONGTERM use cases.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>

Fine with me, but please s/create/Create/ in the subject to match
history of the file.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4f47a13cb500..ac07053abfea 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -171,6 +171,7 @@ static struct bin_attribute p2pmem_alloc_attr = {
>  	 * to be very large.
>  	 */
>  	.size = SZ_1T,
> +	.mmap_allocates = true,
>  };
>  
>  static struct attribute *p2pmem_attrs[] = {
> -- 
> 2.34.1
> 

