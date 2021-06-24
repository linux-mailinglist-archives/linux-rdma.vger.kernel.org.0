Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897D63B26DF
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 07:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFXFgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 01:36:44 -0400
Received: from verein.lst.de ([213.95.11.211]:53067 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhFXFgn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 01:36:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 02FF167373; Thu, 24 Jun 2021 07:34:22 +0200 (CEST)
Date:   Thu, 24 Jun 2021 07:34:21 +0200
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
Message-ID: <20210624053421.GA25165@lst.de>
References: <20210622152343.GO1096940@ziepe.ca> <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com> <20210622154027.GS1096940@ziepe.ca> <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com> <20210622160538.GT1096940@ziepe.ca> <d600a638-9e55-6249-b574-0986cd5cea1e@gmail.com> <20210623182435.GX1096940@ziepe.ca> <CAFCwf111O0_YB_tixzEUmaKpGAHMNvMaOes2AfMD4x68Am4Yyg@mail.gmail.com> <20210623185045.GY1096940@ziepe.ca> <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12tW_WawFfAfrC8bgVhTRnDA7DuM+0V8w3JsUZpA2j84w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 10:00:29PM +0300, Oded Gabbay wrote:
> I understand the argument and I agree that for the generic case, the
> top of the stack can't assume anything.
> Having said that, in this case the SGL is encapsulated inside a dma-buf object.

But the scatterlist is defined to have a valid page.  If in dma-bufs you
can't do that dmabufs are completely broken.  Apparently the gpu folks
can somehow live with that and deal with the pitfals, but for dma-buf
users outside of their little fiefdom were they arbitrarily break rules
it simply is not acceptable.
