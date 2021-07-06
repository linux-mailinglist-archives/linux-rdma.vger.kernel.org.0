Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBCF3BDDD7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 21:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhGFTMA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhGFTMA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 15:12:00 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B31C061574;
        Tue,  6 Jul 2021 12:09:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so1552594otp.6;
        Tue, 06 Jul 2021 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMq2M4n/8G9joj1/fKzknwNfEb3Och+oaBZy1vpsqNk=;
        b=u5t3SzlPBuZ7kxA4R+Q9uEDCV/k/WI9AahppzXD5e+PtZ6ubJV2HKEseHSj0x5NaYu
         k9zSTwO+7ZLrfYvzFE10Ye4cXIylQ9aU+Irx3QMybgiJ+6KH1MEzuadRNRhCoMSW70jU
         UPmVzcY4Mr0gpgTl2Vr1Dgw/eGKfyFR8G+rppi6rtgYYwsbOrrSdjZiOvay6ZS9SAtcZ
         EsRg/lJDTlkDdKRp9E50obeCJsCG3zkxWq5Zxs5ws6TB6rzJKoFyIghAL+9N4iMdvudx
         nTEfeQACROazrLe6LnLogkA1DbrkE/44HhfrjDt6npDbyU7pGEdhN+WcteCmzK1CyJRt
         Wfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMq2M4n/8G9joj1/fKzknwNfEb3Och+oaBZy1vpsqNk=;
        b=W3+V3k3qQcwAF/KwNrbz4k2+2YMdGv1VL5qwuOJilhzjmtZmeBthgkw5XmEEE7CxCQ
         R+p/EAiIJL/TDvhuhcLaS+5/TZ3inzSa7Sf5GHcLOKON3+fxRzGHK0qXbYFZc27P0UJW
         ZfRI8HSWm/bYAnHmnr7/2XZzobfKrPPQ7JoblbAjKj4Bb4En3ULI8CEWtz54eQb2Teqp
         CNJdNitfPYIhUuKCYfIdKEMaP7LAwvOv1Lp3amsQiMTlJOylspiJyJeAOW10SfqN0AGE
         EGnc5PwcBl6C/qE8vdQCqilNNEySRwNzXkiJdD3yOx0dGs6NvmhlR4o+vtXFCNItVIFw
         SwqA==
X-Gm-Message-State: AOAM532gs2mt0ikUHdM0//k6ikdLxcgJSU3MTVxl+mZpJNZ3iRrCrdku
        G8M2d+Yb//n8R8rRjX3tzeKFMIPhquKUld0J3PU=
X-Google-Smtp-Source: ABdhPJyLpn/Denq9D9uHdx73/8YwQSIZY5Ozg7ZymqbObwdA3ulC3UM5xsQZ0IVJAYJMGH6zXWQRmXGXRh7rAeiRNss=
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr16836757ott.132.1625598559910;
 Tue, 06 Jul 2021 12:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org> <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca> <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
 <20210706152542.GP4604@ziepe.ca> <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
 <20210706162953.GQ4604@ziepe.ca> <CAKMK7uGXUgjyjch57J3UnC7SA3-4g87Ft7tLjj9fFkgyKkKdrg@mail.gmail.com>
 <20210706183145.GT4604@ziepe.ca>
In-Reply-To: <20210706183145.GT4604@ziepe.ca>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Jul 2021 15:09:08 -0400
Message-ID: <CADnq5_My3h=2BK5Kb8FHcDE9NjsXmrAF2auhgnugnmPyHSbb3g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 6, 2021 at 2:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 06, 2021 at 07:35:55PM +0200, Daniel Vetter wrote:
>
> > Yup. We dont care about any of the fancy pieces you build on top, nor
> > does the compiler need to be the optimizing one. Just something that's
> > good enough to drive the hw in some demons to see how it works and all
> > that. Generally that's also not that hard to reverse engineer, if
> > someone is bored enough, the real fancy stuff tends to be in how you
> > optimize the generated code. And make it fit into the higher levels
> > properly.
>
> Seems reasonable to me
>
> > And it's not just nvidia, it's pretty much everyone. Like a soc
> > company I don't want to know started collaborating with upstream and
> > the reverse-engineered mesa team on a kernel driver, seems to work
> > pretty well for current hardware.
>
> What I've seen is that this only works with customer demand. Companies
> need to hear from their customers that upstream is what is needed, and
> companies cannot properly hear that until they are at least already
> partially invested in the upstream process and have the right
> customers that are sophisticated enough to care.
>
> Embedded makes everything 10x worse because too many customers just
> don't care about upstream, you can hack your way through everything,
> and indulge in single generation thinking. Fork the whole kernel for 3
> years, EOL, no problem!
>
> It is the enterprise world, particularly with an opinionated company
> like RH saying NO stuck in the middle that really seems to drive
> things toward upstream.
>
> Yes, vendors can work around Red Hat's No (and NVIDIA GPU is such an
> example) but it is incredibly time consuming, expensive and becoming
> more and more difficult every year.
>
> The big point is this:
>
> > But also nvidia is never going to sell you that as the officially
> > supported thing, unless your ask comes back with enormous amounts of
> > sold hardware.
>
> I think this is at the core of Linux's success in the enterprise
> world. Big customers who care demanding open source. Any vendor, even
> nvidia will want to meet customer demands.
>
> IHMO upstream success is found by motivating the customer to demand
> and make it "easy" for the vendor to supply it.

I think this is one of the last big challenges on Linux.  It's REALLY
hard to align new products with Linux kernel releases and distro
kernels.  Hardware cycles are too short and drivers (at least for
GPUs) are too big to really fit well with the current Linux release
model.  In many cases enterprise distros have locked down on a kernel
version around the same time we are doing new chip bring up.  You are
almost always off by one when it comes to kernel version alignment.
Even if you can get the initial code upstream in the right kernel
version, it tends to be aligned to such early silicon that you end up
needing a pile of additional patches to make production cards work.
Those changes are often deemed "too big" for stable kernel fixes.  The
only real way to deal with that effectively is with vendor provided
packaged drivers using something like dkms to cover launch.  Thus you
need to do your bring up against latest upstream and then backport, or
do your bring up against some older kernel and forward port for
upstream.  You end up doing everything twice.  Things get better with
sustaining support in subsequent distro releases, but it doesn't help
at product launch.  I don't know what the right solution for this is.

Alex
