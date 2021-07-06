Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3928E3BDAE6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGFQKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 12:10:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1AC06175F
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 09:07:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q23so25041697oiw.11
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/d4XeaSNsVFlRZLAg8ZLZgaOUGNlKetyWckEAHUwuk=;
        b=f8dtLu2S3sJkSa9ZSHeuZep5p+/9fucE28hhiRStm3/kTJF5pTTLjufnGsshWPsReU
         sFoXOfLWKXyR0MqHTYAI1P/1tSDs/Z+hXT0+kZeRKZQRFpopyYIqJp1KFyNWIf1sbbbh
         MoJw7B3g6qMCsyWaOODx7tdFuro/50BL7StMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/d4XeaSNsVFlRZLAg8ZLZgaOUGNlKetyWckEAHUwuk=;
        b=jPOcPZnwI/XBGBsSNrmpN0yEeQ0ili3EdoiFbIqXJUPg0nHJNKpK5jgM2x2WffynCx
         1+GMvm/ugf3bL298xY2/0uIwhivCpMPrzLoVHIPLJlZcrXqkQT6Mt+WiXkjka9rhnDJh
         v7kKoWDBOeoeYFu8PdIisXvwkAVnaqrrNDqW45z2r3X9PDTemRgNyIXju50e9N7pYdyY
         n46+LctNmLLFLyJG0f0N5JDcpd9TSSLYgdqB76DogqmbKcjvsG3E90qX9izHriORE/Es
         5lNsK9KplDjHagtv49j7HqU1Qq7XZ3unZIdiQ/A77JScoM7BuQlgYZmH60oepWdoqHjf
         jc+g==
X-Gm-Message-State: AOAM533iMsVi4HR00J3sAjPnHBoz/qZg9WQvmnLQTeUaH2XgfcTnH+5H
        glzavzPpZ4duKqOOEvzwSV0aCiJQD5sPZzhoUg6fVQ==
X-Google-Smtp-Source: ABdhPJyni2s1akvYMUuRqmzUdWsnoOqSRFuCqyMWJzwLyK6OBSwh9Okh9BIirnjonQbsC2vx54cSUlgVRGLUS1EfrOA=
X-Received: by 2002:aca:5793:: with SMTP id l141mr1008420oib.14.1625587648875;
 Tue, 06 Jul 2021 09:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org> <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca> <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
 <20210706152542.GP4604@ziepe.ca> <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
In-Reply-To: <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 6 Jul 2021 18:07:17 +0200
Message-ID: <CAKMK7uGvO0h7iZ3vKGe8GouESkr79y1gP1JXbfV82sRiaT-d1A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 6, 2021 at 5:49 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> On Tue, Jul 6, 2021 at 5:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > I'm not sure about this all or nothing approach. AFAIK DRM has the
> > worst problems with out of tree drivers right now.
>
> Well I guess someone could stand up a drivers/totally-not-gpu and just
> let the flood in. Even duplicated drivers and everything included,
> because the vendor drivers are better. Worth a shot, we've practically
> started this already, I'm just not going to help with the cleanup.

tbh I think at this point someone should just do that. Ideally with
some boundary like please don't use dma-fence or dma-buf and stuff
like that so drivers/gpu doesn't ever have to deal with the fallout.
But way too many people think that somehow you magically get the other
90% of an open accel stack if you're just friendly enough and merge
the kernel driver, so we really should just that experiment in
upstream and watch it pan out in reality.

Minimally it would be some great entertainment :-)

Also on your claim that drivers/gpu is a non-upstream disaster: I've
also learned that that for drivers/rdma there's the upstream driver,
and then there's the out-of-tree hackjob the vendor actually supports.
So seems to be about the same level of screwed up, if you ask the
vendor they tell you the upstream driver isn't a thing they care about
and it's just done for a bit of goodwill. Except if you have enormous
amounts of volume, then suddenly it's an option ... Minus the fw issue
for nvidia, upstream does support all the gpus you can buy right now
and that can run on linux with some vendor driver (aka excluding apple
M1 and ofc upcoming products from most vendors).

drivers/accel otoh is mostly out-of-tree, because aside from Greg
mergin habanalabs no one is bold enough anymore to just merge them
all. There's lots of those going around that would be ready for
picking. And they've been continously submitted to upstream over the
years, even before the entire habanalabs thing.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
