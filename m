Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452183B26E7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFXFm1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 01:42:27 -0400
Received: from verein.lst.de ([213.95.11.211]:53084 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhFXFm1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 01:42:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5BF4867373; Thu, 24 Jun 2021 07:40:04 +0200 (CEST)
Date:   Thu, 24 Jun 2021 07:40:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Tomer Tayar <ttayar@habana.ai>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to
 export FD for DMA-BUF
Message-ID: <20210624054003.GB25165@lst.de>
References: <20210622154027.GS1096940@ziepe.ca> <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com> <20210622160538.GT1096940@ziepe.ca> <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com> <20210623182435.GX1096940@ziepe.ca> <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com> <20210623185045.GY1096940@ziepe.ca> <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com> <20210623193456.GZ1096940@ziepe.ca> <CAFCwf13vM2T-eJUu42ht5jdXpRCF3UZh0Ow=vwN9QqZ=KNUBsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13vM2T-eJUu42ht5jdXpRCF3UZh0Ow=vwN9QqZ=KNUBsQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 10:39:48PM +0300, Oded Gabbay wrote:
> hmm, I thought using dma_map_resource will solve the IOMMU issues, no ?
> We talked about it yesterday, and you said that it will "work"
> (although I noticed a tone of reluctance when you said that).
> 
> If I use dma_map_resource to set the addresses inside the SGL before I
> export the dma-buf, and guarantee no one will use the SGL in the
> dma-buf for any other purpose than device p2p, what else is needed ?

dma_map_resource works in the sense of that helps with mapping an
arbitrary phys_addr_t for DMA.  It does not take various pitfalls of
PCI P2P into account, such as the offset between the CPU physical
address and the PCIe bus address, or the whole support of mapping between
two devices behding a switch and not going through the limited root
port support.

Comparing dma_direct_map_resource/iommu_dma_map_resource with
with pci_p2pdma_map_sg_attrs/__pci_p2pdma_map_sg should make that
very clear.

So if you want a non-page based mapping you need a "resource"-level
version of pci_p2pdma_map_sg_attrs.  Which totall doable, and in fact
mostly trivial.  But no one has even looked into providing one and just
keeps arguing.
