Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377C62A84C5
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgKERX7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKERX7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 12:23:59 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC43C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 09:23:59 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id c27so1871824qko.10
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2B5gOlL5nEl3XjpJXMg7If7oslzOmLgcHQpHnMqi7Hw=;
        b=C9SYVaVvboE1sfIPHmPX7gvl6UpySnTrFzNjFxz3UU9PoltRnebJp1lAGGxgFK+jUY
         hH2EuRWrxVBu7IenA2OO7GEDJPKQMYJ/h6u6H4cItN52gW2Qp3oHb+FX2saxv4x2efM3
         dIkbh/sWZ/IxXCkGnFmrQNsR5nUGKskdqTfhXQBQ0Oag6Ii2M7NbC/PeER8GLAVajf+4
         uyHlLSd+YrCUGmuqrSDlDuszLEz0Jdtq5vEDaeWazHVQFFLO5hKjBDYStoisxZ5xmObW
         FUic7YJQHNn1Tgp25ObdqwT5FaSQez+ILUc7djoCSNFCNsqOuYHkm6ZEEJ8WCLaC4RJF
         k0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2B5gOlL5nEl3XjpJXMg7If7oslzOmLgcHQpHnMqi7Hw=;
        b=gnaCh3o2aortNu2frkas2nu1orD7KCNYZS42dbB5DvaXrkkbaXOy/8T8r5Gs81xBSf
         STv6H0W5WWKCX1mY/eqg/x4XDTIyFuq0oNJu5bZrWL+K+/DH7p+fnDSKYV4OtLtUPNCs
         tcfiy5jQwWnnSn76Zt5f9674CHwUJYsN94tvFkOFdYbnRoam2LydDozNSmcNmEHUJg2w
         GAfOd6OWvqxZVi6FwxBVlc+GdBIMRb7lCoFduKMtaGaK5mdVCYj0Wy6wwfd6bdoGmfd8
         igYt9YUXruOkAsHQcfIFZRfIx+OPCJkTxCfjvnu+4JVWwYPQEGUgli6w4QOAubWHFpb0
         grUg==
X-Gm-Message-State: AOAM533Ioe3ln+5QYpUyVua5z1tWL1C/haDxbggvuq6ESERPnJJM+a7M
        h/LnjsBQZBWV6YOqJONXMJWsvA==
X-Google-Smtp-Source: ABdhPJyZP8gOea6uCcCox3ZqvL5WisJsd8QV4kBs1sNsfV16ZBsIwlbJYUZDhA73Ep/Bt+jQ7nomOA==
X-Received: by 2002:a05:620a:21c4:: with SMTP id h4mr2759256qka.242.1604597038375;
        Thu, 05 Nov 2020 09:23:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h82sm1404189qke.109.2020.11.05.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:23:57 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaizN-0008S7-4l; Thu, 05 Nov 2020 13:23:57 -0400
Date:   Thu, 5 Nov 2020 13:23:57 -0400
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
Message-ID: <20201105172357.GE36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de>
 <20201105143418.GA4142106@ziepe.ca>
 <20201105170816.GC7502@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105170816.GC7502@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 06:08:16PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 05, 2020 at 10:34:18AM -0400, Jason Gunthorpe wrote:
> > The check is removed here, but I didn't see a matching check added to
> > the IB side? Something like:
> > 
> > static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
> > 			  u32 sg_cnt, enum dma_data_direction dir)
> > {
> > 	if (is_pci_p2pdma_page(sg_page(sg))) {
> > 		if (ib_uses_virt_dma(dev))
> > 			return 0;
> > 		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
> > 	}
> > 	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
> > }
> 
> We should never get a P2P page into the rdma_rw_map_sg or other ib_dma*
> routines for the software drivers, as their struct devices don't connect
> to a PCІ device underneath, and thus no valid P2P distance can be
> retourned.  

But that depends on the calling driver doing this properly, and we
don't expose an API to get the PCI device of the struct ib_device
.. how does nvme even work here?

If we can't get here then why did you add the check to the unmap side?

Why did this code in p2pdma exist at all?

> That being said IFF we want to implement P2P for those we'd need
> somethign like the above check, except that we still need to cal
> ib_dma_map_sg, i.e.:
> 
> static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
>  			  u32 sg_cnt, enum dma_data_direction dir)
> {
> 	if (is_pci_p2pdma_page(sg_page(sg)) && !ib_uses_virt_dma(dev))
> 		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
> 	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
> }

The SW drivers can't handle PCI pages at all, they are going to try to
memcpy them or something else not __iomem, so we really do need to
prevent P2P pages going into them.

Jason
