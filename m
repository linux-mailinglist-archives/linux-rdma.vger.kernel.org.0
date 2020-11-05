Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F622A8103
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgKEOeX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 09:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgKEOeW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 09:34:22 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA42C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 06:34:20 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id d1so755334qvl.6
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 06:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RNmi4P8WYl4GQETrYJxETS32iCzFa9Xv1b6hiJTCjLI=;
        b=d1AhRiIAMURRnc2p19hIinkgrZ6DW3hWA8vDhq/FL2ROPM9EIi7JcPpv2eyODMprbv
         4tsGNhNZb3TGymM+rZ2KZpf7GleHIlpZRPJ1UsjK/hXagRZWDUJmcrYQVfHeR+tkTLcM
         yLJj9NoZf/Q3nZOoW/UjmUerXb3f8wc8oTFVeaBD9eIeWidRa76hIGSkix04wBZ5ymWQ
         WtnJL/Rr3jLHyWCeww/F9fNpKvr2iFh5jmrA2Fggtp5vL3Txcy1VsPqbFyvUl5S5XEEa
         yLfPujs8ZYzi44/IC4MYGlUYRGZLZCYfVKyDCGS3sayP4ntGQRdP/uL9pLPQCddX+lOL
         +xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNmi4P8WYl4GQETrYJxETS32iCzFa9Xv1b6hiJTCjLI=;
        b=LsC9ClFqeuW/2laSM6n0n1kyrtkMzWC5/qgA2YYcShWVqJyRmsOqWUTCwMNBIbo3bP
         moI2lZPvgkYUrsz6AwNidjYEWZjdzkZVy9ffQwxxw9oYmWkNmumPaq9+atYEzQOxH35x
         TREHGzVxtFNonz3bTwqD3rI7u5b/MHCMhxl7JXUKKg7Dd8Lv4QjbHkKVoeVaEWZ8CZHI
         dIedsdLltW1E9C59DOeEq+7YpKxSYgGLix7EStfj5mrqPjEPiUnT7wICYhB4q+pZ95sU
         TA+84EULwoDJSNbPfjlC1ihUmgVuKER5JcOXO7K0Bl7JozkmN3H8ysh/AoQ+jHViKzy+
         JlXw==
X-Gm-Message-State: AOAM533+XKP3Fdn5ucRg+iWJBc0x+i+ia1eFGKEBCINpaR5XtZGsqmLS
        YninMGMxXUw8obGhLTkpwnlPJg==
X-Google-Smtp-Source: ABdhPJw0ST1B67vguCBdvn7ezsqBPCcqlyF/5YAxBY/HhZbjhQWUMpnKjhTf+w+TlD6Fi1I60TlRyQ==
X-Received: by 2002:a0c:8d05:: with SMTP id r5mr2332295qvb.31.1604586860101;
        Thu, 05 Nov 2020 06:34:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d18sm1115165qka.41.2020.11.05.06.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:34:19 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kagLC-00HNlu-Vc; Thu, 05 Nov 2020 10:34:18 -0400
Date:   Thu, 5 Nov 2020 10:34:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105143418.GA4142106@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105074205.1690638-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 08:42:03AM +0100, Christoph Hellwig wrote:
> Now that all users of dma_virt_ops are gone we can remove the workaround
> for it in the PCI peer to peer code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>  drivers/pci/p2pdma.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index de1c331dbed43f..b07018af53876c 100644
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

The check is removed here, but I didn't see a matching check added to
the IB side? Something like:

static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
			  u32 sg_cnt, enum dma_data_direction dir)
{
	if (is_pci_p2pdma_page(sg_page(sg))) {
		if (ib_uses_virt_dma(dev))
			return 0;
		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
	}
	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
}

I think the change to rdma_rw_unmap_sg() should probably be dropped in
favour of the above?

Jason
