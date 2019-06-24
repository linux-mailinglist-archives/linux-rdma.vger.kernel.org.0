Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7B50C41
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFXNqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 09:46:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39500 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbfFXNqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 09:46:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so13457301wma.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fHFQYC4IHk3DGA5SJeJSRcnBstbORPkvgUXGBQflcbU=;
        b=dy6wSAbb5K7xDqB+qIUCmnIAgBnIXnelPM2aUTAgaGv7Z/NwA+zSpgAUfMS9EKnB/+
         +jj7JCp465Y0rsmu4RcnTqmWLrwgYq05636vIGBfDYDKB9piVBgk3sYP3vO8O80X5Ppi
         gXr/EmPgtc+YIs7rxsHSu+tsA2DF8jL90FXxaqGLvXS7oLANJUDvhJHNsVoOv99U4/mU
         sWnSluDSDrpB/EEW9PGatqncUzFY2NrOlsDe7sfTqvDPc8e8tDQ6fx1eZaoms2T8YD7x
         GUnijP4PW6FidRXywDiiWKdcmqDowPtjb7eRZz0QEhOw0Zj/S4RIfCuqo0pSkTI13xYP
         kC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fHFQYC4IHk3DGA5SJeJSRcnBstbORPkvgUXGBQflcbU=;
        b=Oevg0Sycu9A2ftXnooKYsA3gAJGBhyFqiDpazbPkAZFd0CPda1BGEP55LSk8fuEAdB
         KiVaAMJPu6743g9iDC/6L3rRjlhJhVcu0QNWvo8XbhpYaCOPcNsWI1TD1gSTVw2Px+Gh
         z0LtLC04s8C1D4E8AMFS9Vy5Y8kQ4KNbQW13skLd0y3xCqEGGIcFRC1hRTmtAuiT13GQ
         3UPQabO4mSCofWHydNkf4fQW5Spa175gNYmEUXn4SsatgTF77OzO4rIpPfzCSq6fnEae
         3xNSVayVR7u6Oip5PRv5KAGGUcdalJMh2+1JOBRwgRE5ShH5wQn0DtvUBXU+NIUBsJP1
         agEA==
X-Gm-Message-State: APjAAAV2xlyiB4TQEZN1Up+CaA1nkotVvucTZvgYUzQSGGsJ2kDD0gMd
        JXWCQGnlxEhSUD8tFMyh/XejcQ==
X-Google-Smtp-Source: APXvYqxH/orChM1UzN6yhkjM24At3V8ziMHSnQNkMtcNe8WEW+S3OTMlvLt8dP4L6baO7ZUaKVoRkg==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr15948959wmb.17.1561384003630;
        Mon, 24 Jun 2019 06:46:43 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id y2sm9626575wrl.4.2019.06.24.06.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 06:46:42 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfPIv-0002E2-9A; Mon, 24 Jun 2019 10:46:41 -0300
Date:   Mon, 24 Jun 2019 10:46:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190624134641.GA8268@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
 <20190624073126.GB3954@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624073126.GB3954@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 09:31:26AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 20, 2019 at 04:33:53PM -0300, Jason Gunthorpe wrote:
> > > My primary concern with this is that ascribes a level of generality
> > > that just isn't there for peer-to-peer dma operations. "Peer"
> > > addresses are not "DMA" addresses, and the rules about what can and
> > > can't do peer-DMA are not generically known to the block layer.
> > 
> > ?? The P2P infrastructure produces a DMA bus address for the
> > initiating device that is is absolutely a DMA address. There is some
> > intermediate CPU centric representation, but after mapping it is the
> > same as any other DMA bus address.
> > 
> > The map function can tell if the device pair combination can do p2p or
> > not.
> 
> At the PCIe level there is no such thing as a DMA address, it all
> is bus address with MMIO and DMA in the same address space (without
> that P2P would have not chance of actually working obviously).  But
> that bus address space is different per "bus" (which would be an
> root port in PCIe), and we need to be careful about that.

Sure, that is how dma_addr_t is supposed to work - it is always a
device specific value that can be used only by the device that it was
created for, and different devices could have different dma_addr_t
values for the same memory. 

So when Logan goes and puts dma_addr_t into the block stack he must
also invert things so that the DMA map happens at the start of the
process to create the right dma_addr_t early.

I'm not totally clear if this series did that inversion, if it didn't
then it should not be using the dma_addr_t label at all, or refering
to anything as a 'dma address' as it is just confusing.

BTW, it is not just offset right? It is possible that the IOMMU can
generate unique dma_addr_t values for each device?? Simple offset is
just something we saw in certain embedded cases, IIRC.

Jason
