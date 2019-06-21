Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96624EE1C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 19:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFURr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 13:47:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46911 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFURr1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 13:47:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so7712927qtn.13
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UJ7zr3BMlP+D/21QaluO3IJXggd4WWthL7KU1eJt5LU=;
        b=aCfnaPMvDaA78Mv5k5ur7VCixpP5F9r0nrtXoL0bNjrtavhSWpa/Xp37Y9kJAKY7Cw
         BKosLY8jx/OuXb5vEV0atvoLpWrIk6kcWRjuMizj1Wdy4+jfyM2jdOr59/0yzrXlFK3U
         yfmLv4y2Dm496vq2UcfTnb9rycSDhAhPproM54A1In2cWM4tiFiMSvkYk40fvwaGYKcj
         3O97gNacC+AV8g99zW3DGJ2yeH9AloFAPriEF14JOmvBILkvyAoSWq3pfSMg6UsMmUPm
         snbErb0HM55f7U+JUI5NHBGXuZSK21iToYFAXMeWQWtnL84ylNtmk67YrG5HEQGML7iu
         J90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJ7zr3BMlP+D/21QaluO3IJXggd4WWthL7KU1eJt5LU=;
        b=Wz3sLhd78NY8Q1B4i+aVUoDvDfIpmny07XpQzvSIDtVnC/klmsriBVnV3g8QS4sY/8
         1Ot9bREO3WAWbrDSGMYTUkKe1NWMaWDVlTbr/QN5KgShvgVCPKuuxiHBCo/FhmS+a83L
         ginjuwV8IkQsnznwX3DyrVLMoaU3034PCaEhM7romuvX8CpoXLXluM2Cvjfl7I/KtZz5
         moWdCqmXnIap5cWI9XKLFcIOu2XW2jgeK4+eCknk4c2lsTYV2SMenlDp8yiWUTMgkzrX
         caf1fdElE+1culpIspDxtsYkx6UwleJLINKPfc7hGRXGFSCQBloq/hacajgyMCJC7W6x
         uNlw==
X-Gm-Message-State: APjAAAUk5jaaSVxU6vrdeEGNU/v3Duby4EcGAa8Ra30905yHBCDv/4/w
        TKJZatAaA2ewgv9kHZCzTWmKXu8TnwToqw==
X-Google-Smtp-Source: APXvYqzYxwhqo3xvnYyIGJGDhki+8Wa6Yr+9LhNg9yc2Yh32DBFiynlceLoS+GkzjCUfIhiF5T75Mg==
X-Received: by 2002:a0c:d604:: with SMTP id c4mr12256209qvj.27.1561139245935;
        Fri, 21 Jun 2019 10:47:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a11sm1652403qkn.26.2019.06.21.10.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 10:47:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heNdE-0005hb-Pa; Fri, 21 Jun 2019 14:47:24 -0300
Date:   Fri, 21 Jun 2019 14:47:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190621174724.GV19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
 <CAPcyv4jyNRBvtWhr9+aHbzWP6=D4qAME+=hWMtOYJ17BVHdy2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jyNRBvtWhr9+aHbzWP6=D4qAME+=hWMtOYJ17BVHdy2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 01:18:13PM -0700, Dan Williams wrote:

> > This P2P is quite distinct from DAX as the struct page* would point to
> > non-cacheable weird memory that few struct page users would even be
> > able to work with, while I understand DAX use cases focused on CPU
> > cache coherent memory, and filesystem involvement.
> 
> What I'm poking at is whether this block layer capability can pick up
> users outside of RDMA, more on this below...

The generic capability is to do a transfer through the block layer and
scatter/gather the resulting data to some PCIe BAR memory. Currently
the block layer can only scatter/gather data into CPU cache coherent
memory.

We know of several useful places to put PCIe BAR memory already:
 - On a GPU (or FPGA, acclerator, etc), ie the GB's of GPU private
   memory that is standard these days.
 - On a NVMe CMB. This lets the NVMe drive avoid DMA entirely
 - On a RDMA NIC. Mellanox NICs have a small amount of BAR memory that
   can be used like a CMB and avoids a DMA

RDMA doesn't really get so involved here, except that RDMA is often
the prefered way to source/sink the data buffers after the block layer has
scatter/gathered to them. (and of course RDMA is often for a block
driver, ie NMVe over fabrics)

> > > My primary concern with this is that ascribes a level of generality
> > > that just isn't there for peer-to-peer dma operations. "Peer"
> > > addresses are not "DMA" addresses, and the rules about what can and
> > > can't do peer-DMA are not generically known to the block layer.
> >
> > ?? The P2P infrastructure produces a DMA bus address for the
> > initiating device that is is absolutely a DMA address. There is some
> > intermediate CPU centric representation, but after mapping it is the
> > same as any other DMA bus address.
> 
> Right, this goes back to the confusion caused by the hardware / bus /
> address that a dma-engine would consume directly, and Linux "DMA"
> address as a device-specific translation of host memory.

I don't think there is a confusion :) Logan explained it, the
dma_addr_t is always the thing you program into the DMA engine of the
device it was created for, and this changes nothing about that.

Think of the dma vec as the same as a dma mapped SGL, just with no
available struct page.

> Is the block layer representation of this address going to go through
> a peer / "bus" address translation when it reaches the RDMA driver? 

No, it is just like any other dma mapped SGL, it is ready to go for
the device it was mapped for, and can be used for nothing other than
programming DMA on that device.

> > ie GPU people wouuld really like to do read() and have P2P
> > transparently happen to on-GPU pages. With GPUs having huge amounts of
> > memory loading file data into them is really a performance critical
> > thing.
> 
> A direct-i/o read(2) into a page-less GPU mapping? 

The interesting case is probably an O_DIRECT read into a
DEVICE_PRIVATE page owned by the GPU driver and mmaped into the
process calling read(). The GPU driver can dynamically arrange for
that DEVICE_PRIVATE page to linked to P2P targettable BAR memory so
the HW is capable of a direct CPU bypass transfer from the underlying
block device (ie NVMe or RDMA) to the GPU.

One way to approach this problem is to use this new dma_addr path in
the block layer.

Another way is to feed the DEVICE_PRIVATE pages into the block layer
and have it DMA map them to a P2P address.

In either case we have a situation where the block layer cannot touch
the target struct page buffers with the CPU because there is no cache
coherent CPU mapping for them, and we have to create a CPU clean path
in the block layer.

At best you could do memcpy to/from on these things, but if a GPU is
involved even that is incredibly inefficient. The GPU can do the
memcpy with DMA much faster than a memcpy_to/from_io.

Jason
