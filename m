Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FB2A6B1C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 17:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgKDQyu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 11:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731255AbgKDQyt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 11:54:49 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC7782072C;
        Wed,  4 Nov 2020 16:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604508889;
        bh=ArcQJwinIpORlAmkBGB/AAkFp/7wMyEXpZdR/3J4wBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A2dV6ftbFeL34zkMdFbtruZhBI1rmk5r4E50s63hTH493XEIMYiT1h5F49xpGnXOM
         aiaZlQv4h/qyRD7jYsfpFqZ6bSRgipAJEIknQ1F5HZGFEREF8+Cyj+VjJ1fj/3OHMd
         1/J1Z1wCrb4HIDVlpvH4cYELRmp+oQoKUPLF9nXo=
Date:   Wed, 4 Nov 2020 10:54:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/5] PCI/p2p: cleanup up __pci_p2pdma_map_sg a bit
Message-ID: <20201104165447.GA358343@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104095052.1222754-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

s|PCI/p2p: cleanup up __pci_p2pdma_map_sg|PCI/P2PDMA: Cleanup up __pci_p2pdma_map_sg|
to match history.

On Wed, Nov 04, 2020 at 10:50:51AM +0100, Christoph Hellwig wrote:
> Remove the pointless paddr variable that was only used once.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b07018af53876c..afd792cc272832 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -825,13 +825,10 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>  		struct device *dev, struct scatterlist *sg, int nents)
>  {
>  	struct scatterlist *s;
> -	phys_addr_t paddr;
>  	int i;
>  
>  	for_each_sg(sg, s, nents, i) {
> -		paddr = sg_phys(s);
> -
> -		s->dma_address = paddr - p2p_pgmap->bus_offset;
> +		s->dma_address = sg_phys(s) - p2p_pgmap->bus_offset;
>  		sg_dma_len(s) = s->length;
>  	}
>  
> -- 
> 2.28.0
> 
