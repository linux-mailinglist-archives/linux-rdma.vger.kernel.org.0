Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11212850B9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 19:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFRYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFRYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 13:24:44 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186EC061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 10:24:42 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 16so5768696oix.9
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKKopYNcjNeFpv6TLCvBYUo3phBxS/bzVk3ny8U3SZ4=;
        b=Ywzegx7iJlmxeVjVZylTidxr8VgvtygwAsLLUcnt9O5nTCCs6I2rKesGxA6F19rGvi
         UravkjBt8BIXUX4j75kb74n5qmm7iOVZZwiuoAEcuxHJbniAoU8uPchZp6IHOGjcoBlX
         1QK4XEVHCT1DG5yR53rfHgCYShrIyLE8nZYAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKKopYNcjNeFpv6TLCvBYUo3phBxS/bzVk3ny8U3SZ4=;
        b=JW3qbU0MOCCQOlVzjsZzzx/YBR8L5ZVzIjakSbbyCYr5s/WWMQhzhuoIYPX97vE68m
         tsFoHzt8Rc7brzBio6BWkcMfc2ePrGdlDjUz8f5kQOIZ7rEtzF3N6AQFObTRAd2HBTby
         sb0xr7Tq0r3Ab68ecVOrtJRazmA+X9+96Zi2nuWz861QvNEvSWNT3dRrJWqmWECK5JMD
         jEstgyE/3WVxxugaoc3lVN98XT4QmBqBfXFqST91Lz9ZNkSgKQ0A5D/bb1nO999OJfvX
         tZvhvfprjD87NRkZHxSO2GdTuhRc1Eoos4AMxKoMxLPZ6AGFT+m6B++qE3IoNRSq5z29
         6hAA==
X-Gm-Message-State: AOAM532AmH0SIPRzUodSYaj3IsQ0SxuDWMZJnpkACkhxmJYcxa7n0pzH
        9aOHk04cfQChQV5VpH/bKi36z1iYohBS/bVautBL3Q==
X-Google-Smtp-Source: ABdhPJwMRUDWMR5gv6uevejjE1dEUzVSRSA7mRuyKG9aJA0erHylD0SSdUS6tuHF6wQyEztNveufIUanB12QJiWFzXA=
X-Received: by 2002:aca:6083:: with SMTP id u125mr3479076oib.14.1602005081922;
 Tue, 06 Oct 2020 10:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
 <20201005131302.GQ9916@ziepe.ca> <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201006092214.GX438822@phenom.ffwll.local> <20201006154956.GI5177@ziepe.ca> <20201006163420.GB438822@phenom.ffwll.local>
In-Reply-To: <20201006163420.GB438822@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 6 Oct 2020 19:24:30 +0200
Message-ID: <CAKMK7uG1RpDQ9ZO=VxkNuGjGPqkAzMQDgi89eSjDoMerMQ4+9A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 6, 2020 at 6:34 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Oct 06, 2020 at 12:49:56PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 06, 2020 at 11:22:14AM +0200, Daniel Vetter wrote:
> > >
> > > For reinstanting the pages you need:
> > >
> > > - dma_resv_lock, this prevents anyone else from issuing new moves or
> > >   anything like that
> > > - dma_resv_get_excl + dma_fence_wait to wait for any pending moves to
> > >   finish. gpus generally don't wait on the cpu, but block the dependent
> > >   dma operations from being scheduled until that fence fired. But for rdma
> > >   odp I think you need the cpu wait in your worker here.
> >
> > Reinstating is not really any different that the first insertion, so
> > then all this should be needed in every case?
>
> Yes. Without move_notify we pin the dma-buf into system memory, so it
> can't move, and hence you also don't have to chase it. But with
> move_notify this all becomes possible.

I just realized I got it wrong compared to gpus. I needs to be:
1. dma_resv_lock
2. dma_buf_map_attachment, which might have to move the buffer around
again if you're unlucky
3. wait for the exclusive fence
4. put sgt into your rdma ptes
5 dma_resv_unlock

Maybe also something we should document somewhere for dynamic buffers.
Assuming I got it right this time around ... Christian?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
