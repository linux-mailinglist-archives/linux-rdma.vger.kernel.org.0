Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9A2A6B04
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 17:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgKDQx6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 11:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731453AbgKDQxz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 11:53:55 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EBE206FA;
        Wed,  4 Nov 2020 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604508835;
        bh=2AnCcDgCUl6mvSBgQ/DNDlhMjVmEBjE51au1El1BYuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ufgUb7fUuwShufuwOFMMiN+b9KhxmZPRjeacpooFT3rGtbvfpEYeTIDtR+8qbpybZ
         ViNnVNVez79xeThoXkIgQLPNu1B162vS+R/Iws4UAxxNYredVESg2yvamgQAHpoXqg
         QCtTCOr9+JeAYws//F1IQSU6/a4lEYyRNDJ8N6Ho=
Date:   Wed, 4 Nov 2020 10:53:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 3/5] PCI/p2p: remove the DMA_VIRT_OPS hacks
Message-ID: <20201104165353.GA357989@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104095052.1222754-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

s|PCI/p2p: remove|PCI/P2PDMA: Remove/
to match history.

On Wed, Nov 04, 2020 at 10:50:50AM +0100, Christoph Hellwig wrote:
> Now that all users of dma_virt_ops are gone we can remove the workaround
> for it in the PCIe peer to peer code.

s/PCIe/PCI/
We went to some trouble to make P2PDMA work on conventional PCI as
well as PCIe.

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index de1c331dbed43f..b07018af53876c 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -556,15 +556,6 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  		return -1;
>  
>  	for (i = 0; i < num_clients; i++) {
> -#ifdef CONFIG_DMA_VIRT_OPS
> -		if (clients[i]->dma_ops == &dma_virt_ops) {
> -			if (verbose)
> -				dev_warn(clients[i],
> -					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
> -			return -1;
> -		}
> -#endif
> -
>  		pci_client = find_parent_pci_dev(clients[i]);
>  		if (!pci_client) {
>  			if (verbose)
> @@ -837,17 +828,6 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>  	phys_addr_t paddr;
>  	int i;
>  
> -	/*
> -	 * p2pdma mappings are not compatible with devices that use
> -	 * dma_virt_ops. If the upper layers do the right thing
> -	 * this should never happen because it will be prevented
> -	 * by the check in pci_p2pdma_distance_many()
> -	 */
> -#ifdef CONFIG_DMA_VIRT_OPS
> -	if (WARN_ON_ONCE(dev->dma_ops == &dma_virt_ops))
> -		return 0;
> -#endif
> -
>  	for_each_sg(sg, s, nents, i) {
>  		paddr = sg_phys(s);
>  
> -- 
> 2.28.0
> 
