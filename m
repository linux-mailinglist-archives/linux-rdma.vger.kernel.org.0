Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B763B2FE6
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFXNYq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 09:24:46 -0400
Received: from verein.lst.de ([213.95.11.211]:54550 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhFXNYq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 09:24:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FB1567373; Thu, 24 Jun 2021 15:22:23 +0200 (CEST)
Date:   Thu, 24 Jun 2021 15:22:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
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
Message-ID: <20210624132223.GA22258@lst.de>
References: <20210622160538.GT1096940@ziepe.ca> <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com> <20210623182435.GX1096940@ziepe.ca> <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com> <20210623185045.GY1096940@ziepe.ca> <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com> <20210624053421.GA25165@lst.de> <9571ac7c-3a58-b013-b849-e26c3727e9b2@amd.com> <20210624081237.GA30289@lst.de> <899fe0ce-b6d7-c138-04b6-4b12405f8d93@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <899fe0ce-b6d7-c138-04b6-4b12405f8d93@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 11:52:47AM +0200, Christian König wrote:
> I've already converted a bunch of the GPU drivers, but there are at least 6 
> GPU still needing to be fixed and on top of that comes VA-API and a few 
> others.
>
> What are your plans for the DMA mapping subsystem?

Building a new API that allows batched DMA mapping without the scatterlist.
The main input for my use case would be bio_vecs, but I plan to make it
a little flexible, and the output would be a list of [dma_addr,len]
tuples, with the API being flexible enough to just return a single
[dma_addr,len] for the common IOMMU coalescing case.

>
>> Btw, one thing I noticed when looking over the dma-buf instances is that
>> there is a lot of duplicated code for creating a sg_table from pages,
>> and then mapping it.  It would be good if we could move toward common
>> helpers instead of duplicating that all over again.
>
> Can you give an example?

Take a look at the get_sg_table and put_sg_table helpers in udmabuf.
Those would also be useful in armda, i915, tegra, gntdev-dmabuf, mbochs
in one form or another.

Similar for variants that use a contigous regions.
