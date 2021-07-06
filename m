Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C443BDA7D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhGFPvx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhGFPvx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 11:51:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28EC06175F
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 08:49:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso21992258otu.10
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Lz1C2Jg0D1JZ1ELvAKDI4J04OIYXO0SeOh8EZaA3Mg=;
        b=VdDtwm/D83TJXUbV95JXQXWh8E3k45oG2fRtUIaudvPnJl1nn8ZENseETR2AfGF7Fh
         Z9CYBStDvLuPedqiTHMmfMEOpCaLTnt3AubNp7t+mogVZyL5uLbWqkXnmu2IapAEZw/A
         e7NU/V4E0AoVg9zPdo1692x8C9W8o3OhPR6UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Lz1C2Jg0D1JZ1ELvAKDI4J04OIYXO0SeOh8EZaA3Mg=;
        b=oA1IBbfHiN1CN/VWaDkEtAXqC4yAaldLLbYQyg9xig2WMxAVGUKlO3HVpjwoTcKgxl
         /IMb/g9fl1yvkmuXJzflx48cwU4UeJtffOtxyjUENLhALvlnqGoriLFMYDrpA3XZre32
         fsUd+BNcQ6CtwaN3W95VEfrll207Pi10AKrcgb3XUSw2wJ+NkXLjMyiLcQH9rUG+2rwm
         8DzTjNpJ8RwUoY8sEZ1aCRUtXOZEW+gud/Gx3wFwzpjZqH3GvF2H1eZsWgXNv8mstIHX
         Logy5wmLwaXGox6SUa0sPXiIviFYnc8JjUrYx9ZmeICky/ahzGo4C3iyvdcieMsyZt0E
         Opsw==
X-Gm-Message-State: AOAM531gxrMQE5Q1JE7UKn4sr6sTWWXjFWEos3AhTX8wO/TcBo8GClrs
        8Ba/97gAF4hQIqFNtTZxg/dLIiAE3IuWnsG0pnPXpA==
X-Google-Smtp-Source: ABdhPJyL0zpOk57gvxAoXPVwnOIH61HfNC4Ne6EU1r5lEUqaZg7uANzEfYAF67zrYyTHpZfkojmnHOlqQHemdgOPDZw=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr15781208otb.281.1625586552803;
 Tue, 06 Jul 2021 08:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org> <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca> <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
 <20210706152542.GP4604@ziepe.ca>
In-Reply-To: <20210706152542.GP4604@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 6 Jul 2021 17:49:01 +0200
Message-ID: <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
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

On Tue, Jul 6, 2021 at 5:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Jul 06, 2021 at 04:39:19PM +0200, Daniel Vetter wrote:
> > On Tue, Jul 6, 2021 at 4:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jul 06, 2021 at 12:36:51PM +0200, Daniel Vetter wrote:
> > >
> > > > If that means AI companies don't want to open our their hw specs
> > > > enough to allow that, so be it - all you get in that case is
> > > > offloading the kernel side  of the stack for convenience, with zero
> > > > long term prospects to ever make this into a cross vendor subsystem
> > > > stack that does something useful.
> > >
> > > I don't think this is true at all - nouveau is probably the best
> > > example.
> > >
> > > nouveau reverse engineered a userspace stack for one of these devices.
> > >
> > > How much further ahead would they have been by now if they had a
> > > vendor supported, fully featured, open kernel driver to build the
> > > userspace upon?
> >
> > There is actually tons of example here, most of the arm socs have
> > fully open kernel drivers, supported by the vendor (out of tree).
>
> I choose nouveau because of this:
>
> $ git ls-files drivers/gpu/drm/arm/ | xargs wc -l
>  15039 total
> $ git ls-files drivers/gpu/drm/nouveau/ | xargs wc -l
>  204198 total

drm/arm is the arm display driver, which isn't actually shipping
anywhere afaik. Also it's not including the hdmi/dp output drivers,
those are generally external on socs, but integrated in discrete gpu.

The other thing to keep in mind is that one of these drivers supports
25 years of product generations, and the other one doesn't. So I think
adding it all up it's not that much different. Last time I looked if
you look at just command submission and rendering/compute, and not
include display, which heavily skews the stats, it's about 10% kernel,
90% userspace driver parts. Not including anything that's shared,
which is most of it (compiler frontend, intermediate optimizer, entire
runtime/state tracker and all the integration and glue pieces
largely).

> At 13x the size of mali this is not just some easy to wire up memory
> manager and command submission. And after all that typing it still
> isn't very good. The fully supported AMD vendor driver is over 3
> million lines, so nouveau probably needs to grow several times.

AMD is 3 million lines the size because it includes per-generation
generated header files.

And of course once you throw an entire vendor team at a driver all
those engineers will produce something, and there's the usual that the
last 10% of features produce about 90% of the complexity and code
problem. E.g. the kbase driver for arm mali gpu is 20x the size of the
in-tree panfrost driver - they need to keep typing to justify their
continued employement, or something like that. Usually it's because
they reinvent the world.

> My argument is that an in-tree open kernel driver is a big help to
> reverse engineering an open userspace. Having the vendors
> collaboration to build that monstrous thing can only help the end goal
> of an end to end open stack.

Not sure where this got lost, but we're totally fine with vendors
using the upstream driver together with their closed stack. And most
of the drivers we do have in upstream are actually, at least in parts,
supported by the vendor. E.g. if you'd have looked the drm/arm driver
you picked is actually 100% written by ARM engineers. So kinda
unfitting example.

> For instance a vendor with an in-tree driver has a strong incentive to
> sort out their FW licensing issues so it can be redistributed.

Nvidia has been claiming to try and sort out the FW problem for years.
They even managed to release a few things, but I think the last one is
2-3 years late now. Partially the reason is that there don't have a
stable api between the firmware and driver, it's all internal from the
same source tree, and they don't really want to change that.

> I'm not sure about this all or nothing approach. AFAIK DRM has the
> worst problems with out of tree drivers right now.

Well I guess someone could stand up a drivers/totally-not-gpu and just
let the flood in. Even duplicated drivers and everything included,
because the vendor drivers are better. Worth a shot, we've practically
started this already, I'm just not going to help with the cleanup.

> > Where it would have helped is if this open driver would come with
> > redistributable firmware, because that is right now the thing making
> > nouveau reverse-engineering painful enough to be non-feasible. Well
> > not the reverse-engineering, but the "shipping the result as a working
> > driver stack".
>
> I don't think much of the out of tree but open drivers. The goal must
> be to get vendors in tree.

Agreed. We actually got them in-tree largely. Nvidia even contributes
the oddball thing, and I think the tegra line is still fully supported
in upstream with the upstream driver.

I'm not sure the bleak picture you're drawing is reality, aside from
the fact that Nvidia discrete gpu drivers being a disaster with no
redistributable firmware, no open kernel driver that works, and
nothing else really either.

> I would applaud Habana for getting an intree driver at least, even if
> the userspace is not what we'd all want to see.
>
> > I don't think the facts on the ground support your claim here, aside
> > from the practical problem that nvidia is unwilling to even create an
> > open driver to begin with. So there isn't anything to merge.
>
> The internet tells me there is nvgpu, it doesn't seem to have helped.

Not sure which one you mean, but every once in a while they open up a
few headers, or a few programming specs, or a small driver somewhere
for a very specific thing, and then it dies again or gets obfuscated
for the next platform, or just never updated. I've never seen anything
that comes remotely to something complete, aside from tegra socs,
which are fully supported in upstream afaik.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
