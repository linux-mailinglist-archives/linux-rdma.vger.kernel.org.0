Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5793AE994
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhFUNE2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 09:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhFUNE1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 09:04:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8026600D4;
        Mon, 21 Jun 2021 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624280533;
        bh=i0BoGd9phtcsE2N4w5S/NNcCyOLvsVmvubKDwfPIMew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9ZvxmN6kzyMcupSt5ch1urOqDBkE0Yg6zpYbUkiJjCrqT/WAfP0GZcwtdCxyIhN5
         VJf2oNP6LasPeV9faVnguB0ItTYTqoiIi/KT6Spd+x7CVZUlDVNtQ1gqJ8z8De0PSa
         aehoznUR6BHHlVGF7/uMhhG8Rm1/YXbxpCs5Xms4=
Date:   Mon, 21 Jun 2021 15:02:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomer Tayar <ttayar@habana.ai>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <YNCN0ulL6DQiRJaB@kroah.com>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:
> On Fri, Jun 18, 2021 at 2:36 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> > User process might want to share the device memory with another
> > driver/device, and to allow it to access it over PCIe (P2P).
> >
> > To enable this, we utilize the dma-buf mechanism and add a dma-buf
> > exporter support, so the other driver can import the device memory and
> > access it.
> >
> > The device memory is allocated using our existing allocation uAPI,
> > where the user will get a handle that represents the allocation.
> >
> > The user will then need to call the new
> > uAPI (HL_MEM_OP_EXPORT_DMABUF_FD) and give the handle as a parameter.
> >
> > The driver will return a FD that represents the DMA-BUF object that
> > was created to match that allocation.
> >
> > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > Reviewed-by: Tomer Tayar <ttayar@habana.ai>
> 
> Mission acomplished, we've gone full circle, and the totally-not-a-gpu
> driver is now trying to use gpu infrastructure. And seems to have
> gained vram meanwhile too. Next up is going to be synchronization
> using dma_fence so you can pass buffers back&forth without stalls
> among drivers.

What's wrong with other drivers using dmabufs and even dma_fence?  It's
a common problem when shuffling memory around systems, why is that
somehow only allowed for gpu drivers?

There are many users of these structures in the kernel today that are
not gpu drivers (tee, fastrpc, virtio, xen, IB, etc) as this is a common
thing that drivers want to do (throw chunks of memory around from
userspace to hardware).

I'm not trying to be a pain here, but I really do not understand why
this is a problem.  A kernel api is present, why not use it by other
in-kernel drivers?  We had the problem in the past where subsystems were
trying to create their own interfaces for the same thing, which is why
you all created the dmabuf api to help unify this.

> Also I'm wondering which is the other driver that we share buffers
> with. The gaudi stuff doesn't have real struct pages as backing
> storage, it only fills out the dma_addr_t. That tends to blow up with
> other drivers, and the only place where this is guaranteed to work is
> if you have a dynamic importer which sets the allow_peer2peer flag.
> Adding maintainers from other subsystems who might want to chime in
> here. So even aside of the big question as-is this is broken.

From what I can tell this driver is sending the buffers to other
instances of the same hardware, as that's what is on the other "end" of
the network connection.  No different from IB's use of RDMA, right?

thanks,

greg k-h
