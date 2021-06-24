Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52F3B2A12
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhFXIPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 04:15:01 -0400
Received: from verein.lst.de ([213.95.11.211]:53546 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231705AbhFXIPB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 04:15:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01CD167373; Thu, 24 Jun 2021 10:12:38 +0200 (CEST)
Date:   Thu, 24 Jun 2021 10:12:37 +0200
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
Message-ID: <20210624081237.GA30289@lst.de>
References: <20210622154027.GS1096940@ziepe.ca> <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com> <20210622160538.GT1096940@ziepe.ca> <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com> <20210623182435.GX1096940@ziepe.ca> <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com> <20210623185045.GY1096940@ziepe.ca> <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com> <20210624053421.GA25165@lst.de> <9571ac7c-3a58-b013-b849-e26c3727e9b2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9571ac7c-3a58-b013-b849-e26c3727e9b2@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 10:07:14AM +0200, Christian König wrote:
> The key point is that accessing the underlying pages even when DMA-bufs are 
> backed by system memory is illegal. Daniel even created a patch which 
> mangles the page pointers in sg_tables used by DMA-buf to make sure that 
> people don't try to use them.

Which is another goddamn layering violation of a subsystem that has no
business at all poking into the scatterlist structure, yes.

> So the conclusion is that using sg_table in the DMA-buf framework was just 
> the wrong data structure and we should have invented a new one.

I think so.

> But then people would have complained that we have a duplicated 
> infrastructure (which is essentially true).

I doubt it.  At least if you had actually talked to the relevant people.
Which seems to be a major issue with what is going on GPU land.

> My best plan to get out of this mess is that we change the DMA-buf 
> interface to use an array of dma_addresses instead of the sg_table object 
> and I have already been working on this actively the last few month.

Awesome!  I have a bit of related work on the DMA mapping subsystems, so
let's sync up as soon as you have some first sketches.

Btw, one thing I noticed when looking over the dma-buf instances is that
there is a lot of duplicated code for creating a sg_table from pages,
and then mapping it.  It would be good if we could move toward common
helpers instead of duplicating that all over again.
