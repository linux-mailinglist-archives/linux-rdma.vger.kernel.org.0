Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009032A8576
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKER6S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgKER6S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 12:58:18 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D18C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 09:58:18 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id c27so1983672qko.10
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IV2pMAD0GDkCc858XzaHv7E4h3K+d+uW6Iv2k0uw7L8=;
        b=E1HBlRXYwbDvEdNlW4RmkR7rTF1T1GLQXH1l6KDVxZadZr6pW2rmQlTxGBBVRuROLf
         yi3XZGVa7/ZfRjpI2YW5sUs3BbknwOQL2gGRoLqZixEj7lh7JDdZTYjcQT0QxDvXCqYv
         d8sQLyr8J1r5mlty6l39ypIuuYAhvrht+miISyAhXZWienxSWr5xZ6xhY/UwYYExZVk4
         eUnzv/UqYLRYKEPSxdVPsxZezSeeMmKqUM9YfPkKpT+W2w85lrT0Jo8bmeK2rUn3xAqI
         QDyxBcvY8IOa+RqgsRlDZnjd8jh+EtbKJWHLeljDmllAoV2ZNTd+c5g8cxbbZp2QWdf1
         8Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IV2pMAD0GDkCc858XzaHv7E4h3K+d+uW6Iv2k0uw7L8=;
        b=hDq9btNziG+pNvkudMPm8zmephcvHFah5VXKBEP36YnPkygpsd1uUZVuSl8c2pvXgq
         6l5kqNZxNtJNVdHf6LwCqev8U9DEaPSfqQjLi9Hke0HCxZWQvHGcAld0TVmvit1fLnLJ
         rerb2H05zvAwX25geQcIm4PMYTUhybsQ0LRFwCb42uM2CXfCdc2y4lFmZalt2Bz8Ya9M
         AarnSKFawQwrjpcCzgdxuDEVlJlAsc7Y+tf8Yf6iLqJOhCocZfFCf5z0AA49jBwnRUYW
         W4+rufz6/uFoqagsGSapP3pvtu8fzqvXD1KxdUM4PKpwvFU0t/Oo6qUbDWsxGzYkWVL1
         Odrg==
X-Gm-Message-State: AOAM533nVblvuwY+Ggj86wEo0LdBlTLPTmpG7AUgdntma4m9caFYXgRt
        79mIBAXdio7isAAYEret1G/Ebw==
X-Google-Smtp-Source: ABdhPJxiXODJ6wdpxteKHXxL3pwnTfgdrXuumCF525zWmopkS6fq/JQpD8tKfMhxXjHU8eEOclMa9A==
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr3033099qka.119.1604599097354;
        Thu, 05 Nov 2020 09:58:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f1sm1246044qtf.68.2020.11.05.09.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:58:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kajWa-0009LK-68; Thu, 05 Nov 2020 13:58:16 -0400
Date:   Thu, 5 Nov 2020 13:58:16 -0400
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
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201105175816.GH36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de>
 <20201105175253.GA35235@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105175253.GA35235@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 01:52:53PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> > @@ -1341,7 +1322,14 @@ int ib_register_device(struct ib_device *device, const char *name,
> >  	if (ret)
> >  		return ret;
> >  
> > -	setup_dma_device(device, dma_device);
> > +	/*
> > +	 * If the caller does not provide a DMA capable device then the IB core
> > +	 * will set up ib_sge and scatterlist structures that stash the kernel
> > +	 * virtual address into the address field.
> > +	 */
> > +	device->dma_device = dma_device;
> > +	WARN_ON(dma_device && !dma_device->dma_parms);
> 
> I noticed there were a couple of places expecting dma_device to be set
> to !NULL:
> 
> drivers/infiniband/core/umem.c:                 dma_get_max_seg_size(device->dma_device), sg, npages,
> drivers/nvme/host/rdma.c:       ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);

Don't know much about NUMA, but do you think the ib device setup
should autocopy the numa node from the dma_device to the ib_device and
this usage should just refer to the ib_device?

Jason
