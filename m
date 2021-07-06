Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8553BD703
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhGFMuq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 08:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240971AbhGFMtQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 08:49:16 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D8C0613DF;
        Tue,  6 Jul 2021 05:46:17 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so21381038otq.11;
        Tue, 06 Jul 2021 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sCjXp3xF1YSalO2+qz5OYyZixLhy0ty98Vfkg+SLNfU=;
        b=NebIVlImsk/VQNEBC9xhHI8KKnEPayGZn2ZyIMxFnPx0YDhqtNAWoIKAXIXd7A6yI1
         Z/ZqdKIIzbjxYaq/e/KIf4Ty2v8ZKxhCT2fZu+d5f+oLC5pZRukodlHjEJ63d9cYEnZH
         Z8FGRRxvPytz47HM1SRivXkHFZHPHo67ltwBZfLhKd4wvK1s2l09//DgjYPbQ2QzlM1w
         UwYRJ80jYqhAcKo/vKem03qSyf3ye/3jPTBdjCxDdMDf4kgNIN0M8pNZTgQviynWgyra
         a1HZFz50KvOSjqacuprw+IsW3+7YMHolQy0dGBV0wg4zyt0xWwtlY8NdkbeuXI9GWgZ1
         H/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sCjXp3xF1YSalO2+qz5OYyZixLhy0ty98Vfkg+SLNfU=;
        b=LtPpDAhwfBkkWJhXJC6cR/kDi6r44ue1dqtbAjU1va1z/ocDAuG33z9T4FREvNlWI7
         poDbWgSawr9Zc0i4IjyRD2UDPSxuiQ1S4Djr+cL5ERFg/l1+ZM1N/ixra9e0j03pnsWy
         dAqji2sUnBZZ8iNWeJDwd8Q2Vf73e07z6kPMRj2DJicFzhVqWcYcUGyngi6ZlJIiOLmp
         CXHWwbhW/D/NUyO/t0zSv5kJMh+RPCFylRy9qWMa6CC8nW5I8j9REf+4iPBKn4/DqdIO
         mBcScR6+guOATPGh5JHoILIQ3stmkWFtmoac12vH328MnFrHe+nHOaaWaeq3m6XiS9XJ
         JRKQ==
X-Gm-Message-State: AOAM531RSg/ETyUKSuxXEFMzXql2GUyRDark+Iyh9gw8j1UK56lezUHB
        D+KTHJV8pXswUKgayuToUx6bbJKfxPQckShyNto=
X-Google-Smtp-Source: ABdhPJzKl+ncA9+SgwqYnKj9X6RvPNw8/DFp4We+uboCS13WvUQF4K4WE0yutJoNe8KTfvhc9SuTE16Alt3g9Wb5p6M=
X-Received: by 2002:a05:6830:159a:: with SMTP id i26mr5598551otr.339.1625575576243;
 Tue, 06 Jul 2021 05:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org> <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <20210706122110.GA18273@lst.de> <YORLTmyoXDtoM9Ta@phenom.ffwll.local>
In-Reply-To: <YORLTmyoXDtoM9Ta@phenom.ffwll.local>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 6 Jul 2021 15:45:49 +0300
Message-ID: <CAFCwf114KEH-kO6w+nmbqKKdaGuqy3iOpHJi=5ZWqT3cgDm4Cw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
To:     Christoph Hellwig <hch@lst.de>, Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 6, 2021 at 3:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Jul 06, 2021 at 02:21:10PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 06, 2021 at 10:40:37AM +0200, Daniel Vetter wrote:
> > > > Greg, I hope this will be good enough for you to merge this code.
> > >
> > > So we're officially going to use dri-devel for technical details review
> > > and then Greg for merging so we don't have to deal with other merge
> > > criteria dri-devel folks have?
> > >
> > > I don't expect anything less by now, but it does make the original claim
> > > that drivers/misc will not step all over accelerators folks a complete
> > > farce under the totally-not-a-gpu banner.
> > >
> > > This essentially means that for any other accelerator stack that doesn't
> > > fit the dri-devel merge criteria, even if it's acting like a gpu and uses
> > > other gpu driver stuff, you can just send it to Greg and it's good to go.
> > >
> > > There's quite a lot of these floating around actually (and many do have
> > > semi-open runtimes, like habanalabs have now too, just not open enough to
> > > be actually useful). It's going to be absolutely lovely having to explain
> > > to these companies in background chats why habanalabs gets away with their
> > > stack and they don't.
> >
> > FYI, I fully agree with Daniel here.  Habanlabs needs to open up their
> > runtime if they want to push any additional feature in the kernel.
> > The current situation is not sustainable.
Well, that's like, your opinion...

>
> Before anyone replies: The runtime is open, the compiler is still closed.
> This has become the new default for accel driver submissions, I think
> mostly because all the interesting bits for non-3d accelerators are in the
> accel ISA, and no longer in the runtime. So vendors are fairly happy to
> throw in the runtime as a freebie.
>
> It's still incomplete, and it's still useless if you want to actually hack
> on the driver stack.
> -Daniel
> --
I don't understand what's not sustainable here.

There is zero code inside the driver that communicates or interacts
with our TPC code (TPC is the Tensor Processing Core).
Even submitting works to the TPC is done via a generic queue
interface. And that queue IP is common between all our engines
(TPC/DMA/NIC). The driver provides all the specs of that queue IP,
because the driver's code is handling that queue. But why is the TPC
compiler code even relevant here ?

btw, you can today see our TPC code at
https://github.com/HabanaAI/Habana_Custom_Kernel
There is a link there to the TPC user guide and link to download the
LLVM compiler.

Oded
