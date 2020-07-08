Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22909218A33
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgGHOeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgGHOeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jul 2020 10:34:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7EEC061A0B
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2020 07:34:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so3456827wmi.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jul 2020 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QIeEl2eUxfszxmiPFIuGD5Z7T/8od5TwILRWsxV6oDw=;
        b=D3k2+ayC8VxqEYL1HrSW40E1N+qNuiMUY6cpnLe0dF0FZC2dy2C/oAoOyhu0IY8U/M
         7lT+G0XEhuHiB7+yMt3IuTxIavaZgEV0NRz3XoUmlg11LMwpAXm9shRkGbFuynrw2LqV
         KOZYPabA5hbk1kCFCyFbX5nas9F6ggOoS2BGR/ppoJr/8aT1u9hl9d87bYzW4WJ61F6l
         9sf7jNqqoki3HIj/Gj/J3KVgv0m6QdQZsE3lRRM0qn5fDoECPh0lpF9gUAOMHe/0v2kW
         FGZQYoaXFPhdjFvG08OhpH6ohs+AI6iHO+Lw1mUPsnKuCTVG7rcwXMXAGFI6t3p2C3IN
         /jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QIeEl2eUxfszxmiPFIuGD5Z7T/8od5TwILRWsxV6oDw=;
        b=LmK3tt9fDFLDGkxRgYCB4YuFIqahRDyPXD7fZ7XCNItnEz20dyREhN0tQ4OJCngwUK
         nwkJep7ZM/dyf9yBkLpw8gcFV+TnSUUXoGv684ESl8PlxotxuQ3XUr87X085IEVnGLuj
         VLKjFQ6j1g/weQ+1pO+xs15pBahtusGmOpf6TJH7YZA+R7GnMcu7jUCEq3sCaFfBTJYT
         OLUYM7c6P5qnU58XUFzTHSfFUEzL5lYDfsjIDF1dX89vhfZLNqA+JM4QN+9JFAkczO9t
         6Z5o2PhzDMzwvV6g+vTYYR12xfR4APdwRKK0Y4CnOHEoNsCylqiAkdA9Fbv7HVMutWnt
         mDbg==
X-Gm-Message-State: AOAM530f8Z2e19bh6DqWKP0bZS8IYlRmqs0ecwfPoYLyzf08hYsYCOuy
        Ru7wBzt5dvTUswqJEEdnHE+7Nzu2rVqdWEWA9pxWDQ==
X-Google-Smtp-Source: ABdhPJySvtmMxy3zK1ibJGzz7ZbxiOXP6zO/iVxoJvHu/4CXPn/v5Lt4tYYHr63RNiUnCIGV8rRvhlDYyODHpr9jfbc=
X-Received: by 2002:a1c:de07:: with SMTP id v7mr9743311wmg.56.1594218850894;
 Wed, 08 Jul 2020 07:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200702131000.GW3278063@phenom.ffwll.local> <20200702132953.GS25301@ziepe.ca>
 <11e93282-25da-841d-9be6-38b0c9703d42@amd.com> <20200702181540.GC3278063@phenom.ffwll.local>
 <20200703120335.GT25301@ziepe.ca> <CAKMK7uGqABchpPLTm=vmabkwK3JJSzWTFWhfU+ywbwjw-HgSzw@mail.gmail.com>
 <20200703131445.GU25301@ziepe.ca> <f2ec5c61-a553-39b5-29e1-568dae9ca2cd@amd.com>
 <MW3PR11MB45553DB31AD67C8B870A345FE5660@MW3PR11MB4555.namprd11.prod.outlook.com>
 <d28286c7-b1c1-a4a8-1d38-264ed1761cdd@amd.com> <20200708094934.GI3278063@phenom.ffwll.local>
 <14659513-8164-dcae-e4f9-f0a199aee542@amd.com>
In-Reply-To: <14659513-8164-dcae-e4f9-f0a199aee542@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Jul 2020 10:33:58 -0400
Message-ID: <CADnq5_PGszgU=h2UdL1nRFnyLaBEk7pgxQkNS8otwK-SF22Qrw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 8, 2020 at 10:20 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 08.07.20 um 11:49 schrieb Daniel Vetter:
> > On Wed, Jul 08, 2020 at 11:38:31AM +0200, Christian K=C3=B6nig wrote:
> >> Am 07.07.20 um 23:58 schrieb Xiong, Jianxin:
> >>>> -----Original Message-----
> >>>> From: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>> Am 03.07.20 um 15:14 schrieb Jason Gunthorpe:
> >>>>> On Fri, Jul 03, 2020 at 02:52:03PM +0200, Daniel Vetter wrote:
> >>>>>
> >>>>>> So maybe I'm just totally confused about the rdma model. I thought=
:
> >>>>>> - you bind a pile of memory for various transactions, that might
> >>>>>> happen whenever. Kernel driver doesn't have much if any insight in=
to
> >>>>>> when memory isn't needed anymore. I think in the rdma world that's
> >>>>>> called registering memory, but not sure.
> >>>>> Sure, but once registered the memory is able to be used at any mome=
nt
> >>>>> with no visibilty from the kernel.
> >>>>>
> >>>>> Unlike GPU the transactions that trigger memory access do not go
> >>>>> through the kernel - so there is no ability to interrupt a command
> >>>>> flow and fiddle with mappings.
> >>>> This is the same for GPUs with user space queues as well.
> >>>>
> >>>> But we can still say for a process if that this process is using a D=
MA-buf which is moved out and so can't run any more unless the DMA-buf is
> >>>> accessible again.
> >>>>
> >>>> In other words you somehow need to make sure that the hardware is no=
t accessing a piece of memory any more when you want to move it.
> >>>>
> >>> While a process can be easily suspended, there is no way to tell the =
RDMA NIC not to process posted work requests that use specific memory regio=
ns (or with any other conditions).
> >>>
> >>> So far it appears to me that DMA-buf dynamic mapping for RDMA is only=
 viable with ODP support. For NICs without ODP, a way to allow pinning the =
device memory is still needed.
> >> And that's exactly the reason why I introduced explicit pin()/unpin()
> >> functions into the DMA-buf API:
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fel=
ixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fdrivers%2Fdma-buf%2Fdma-buf.c%=
23L811&amp;data=3D02%7C01%7Cchristian.koenig%40amd.com%7C6d785861acc542a2f5=
3608d823243a7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637297985792135=
311&amp;sdata=3DbBrkDynlACE9DAIlGntxXhE1unr%2FBxw5IRTm6AtV6WQ%3D&amp;reserv=
ed=3D0
> >>
> >> It's just that at least our devices drivers currently prevent P2P with
> >> pinned DMA-buf's for two main reasons:
> >>
> >> a) To prevent deny of service attacks because P2P BARs are a rather ra=
re
> >> resource.
> >>
> >> b) To prevent failures in configuration where P2P is not always possib=
le
> >> between all devices which want to access a buffer.
> > So the above is more or less the question in the cover letter (which
> > didn't make it to dri-devel). Can we somehow throw that limitation out,=
 or
> > is that simply not a good idea?
>
> At least for the AMD graphics drivers that's most certain not a good idea=
.
>
> We do have an use case where buffers need to be in system memory because
> P2P doesn't work.
>
> And by pinning them to VRAM you can create a really nice deny of service
> attack against the X system.
>

On the other hand, on modern platforms with large or resizable BARs,
you may end up with systems with more vram than system ram.

Alex


> > Simply moving buffers to system memory when they're pinned does simplif=
y a
> > lot of headaches. For a specific custom built system we can avoid that
> > maybe, but I think upstream is kinda a different thing.
>
> Yes, agree completely on that. Customers which are willing to take the
> risk can easily do this themselves.
>
> But that is not something we should probably do for upstream.
>
> Regards,
> Christian.
>
> >
> > Cheers, Daniel
> >
> >> Regards,
> >> Christian.
> >>
> >>> Jianxin
> >>>
> >>>> Christian.
> >>>>
> >>>>> Jason
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
