Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F644EE34
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfFURyP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 13:54:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45805 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFURyO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 13:54:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id m206so5235904oib.12
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWe7JksCarDHmhen9C6EallwqzcNZ3VFsoR3OU1kFs4=;
        b=As84DIw2X46ExupdWbzau6JXRpfTr7Tvcr3DD71THl2AN+TnXs0Ix3/5NguTZ90GAz
         ekIGjYs3rGIAaU4Zuhl2b4EC6neLHHrPVvKddYVZchq1kXmnav7PduMCSelt4uRqkhBs
         H6p2Pp58HhLk/LXcpDOvizAOu5AHmWbnz/KsTZgVWJrU6fecK457WQGr88aTmThOzoDo
         kIbZw6EA5L0scx+eGkbpDNANsnLPNtIWwS38tDIBjYdLir4joVLYIfAPI245qWV0YPLa
         EaVu5FdkVKrQyA3imM8SjFY32qBhtVTtiyaBMdTtwU7Qw8VwBekQT0lKHFzrqw/XiED8
         oIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWe7JksCarDHmhen9C6EallwqzcNZ3VFsoR3OU1kFs4=;
        b=NQ2Xlp1YOVFfMsE74QtAD5Yj2E+jT4Sn0UyfMcUfnrkvFWW3VLUSJ6JHJ3DxsMZpEJ
         Y7TW3X/yLjxusMaC22Y3U7YGoIprc/Kin9dXrchusxmMeriqoSbJkG/cq7Q1aki4Rrgz
         db5hWUUdwfSeSENNb4HX44/vI18tfw/4oqe0XSh0NA5Rd3N5384hJHpTG7IQEj1Bjg1M
         gl6rTGRGYXqHXJASKkAARwF5Y7iNoboq/QRIKiCMl9kXCRgDOyxePEY9PCT8AQeJ98kj
         /O2V+HarfPkGgdW1/B1P558qxu8FbVgtz49gzFfLEq+YtH9Dcx315O98NiDUUrJE0aiX
         zPkA==
X-Gm-Message-State: APjAAAV1fKDSqCH3uT9UFYk9DTfxGJY9n1Z6LTYmyG7D3fKeTFUbCGv7
        Ftq4WD0gHTA+0dk/emBBdYKuaW+Ze7JJ+PF5pvTDsA==
X-Google-Smtp-Source: APXvYqxXNEbZxH2OdZlBe/PUqIOg67j/c0SHGrDk007xE/yb3KKMifeBH5RBDM8Vp5lM8PAB7JeI8idaR7EqqO3oB4Y=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr3352429oih.73.1561139654054;
 Fri, 21 Jun 2019 10:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190620161240.22738-1-logang@deltatee.com> <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca> <CAPcyv4jyNRBvtWhr9+aHbzWP6=D4qAME+=hWMtOYJ17BVHdy2w@mail.gmail.com>
 <20190621174724.GV19891@ziepe.ca>
In-Reply-To: <20190621174724.GV19891@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Jun 2019 10:54:03 -0700
Message-ID: <CAPcyv4h6CjzxbWLg3upmUiaYQ2eqP-ZyHxMBfh6kkQpwHX9HWg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 21, 2019 at 10:47 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jun 20, 2019 at 01:18:13PM -0700, Dan Williams wrote:
>
> > > This P2P is quite distinct from DAX as the struct page* would point to
> > > non-cacheable weird memory that few struct page users would even be
> > > able to work with, while I understand DAX use cases focused on CPU
> > > cache coherent memory, and filesystem involvement.
> >
> > What I'm poking at is whether this block layer capability can pick up
> > users outside of RDMA, more on this below...
>
> The generic capability is to do a transfer through the block layer and
> scatter/gather the resulting data to some PCIe BAR memory. Currently
> the block layer can only scatter/gather data into CPU cache coherent
> memory.
>
> We know of several useful places to put PCIe BAR memory already:
>  - On a GPU (or FPGA, acclerator, etc), ie the GB's of GPU private
>    memory that is standard these days.
>  - On a NVMe CMB. This lets the NVMe drive avoid DMA entirely
>  - On a RDMA NIC. Mellanox NICs have a small amount of BAR memory that
>    can be used like a CMB and avoids a DMA
>
> RDMA doesn't really get so involved here, except that RDMA is often
> the prefered way to source/sink the data buffers after the block layer has
> scatter/gathered to them. (and of course RDMA is often for a block
> driver, ie NMVe over fabrics)
>
> > > > My primary concern with this is that ascribes a level of generality
> > > > that just isn't there for peer-to-peer dma operations. "Peer"
> > > > addresses are not "DMA" addresses, and the rules about what can and
> > > > can't do peer-DMA are not generically known to the block layer.
> > >
> > > ?? The P2P infrastructure produces a DMA bus address for the
> > > initiating device that is is absolutely a DMA address. There is some
> > > intermediate CPU centric representation, but after mapping it is the
> > > same as any other DMA bus address.
> >
> > Right, this goes back to the confusion caused by the hardware / bus /
> > address that a dma-engine would consume directly, and Linux "DMA"
> > address as a device-specific translation of host memory.
>
> I don't think there is a confusion :) Logan explained it, the
> dma_addr_t is always the thing you program into the DMA engine of the
> device it was created for, and this changes nothing about that.

Yup, Logan and I already settled that point on our last exchange and
offered to make that clearer in the changelog.
