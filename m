Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231BE3BDC68
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhGFRir (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhGFRir (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 13:38:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49C4C061760
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 10:36:07 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so22421461otl.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAvpvptXG6sMkQz+gf0B/1SxifjIkdjKCH8sm6hLVss=;
        b=VykMUkCUg7WcIEKsR1v4RBrI2NiKhIwMgV+BRVA0h1SvtWJEdi9m1qCCccVZziliFj
         qBlBMH+TnRCrISUoXKFEYq86K2054AAs5F5INJ5GSJLHKD1Qf4iQDfLSgfcflxvogC6g
         kX++oMx5RF5cu+sGrdeqLrJSxn9RpJvqmO3q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAvpvptXG6sMkQz+gf0B/1SxifjIkdjKCH8sm6hLVss=;
        b=pK9AWt5dU8DfAd5t7f9cyvjK3UD86xWFRFAd7ZeoFibECL62NPDlgsDuOEbpVn9MoU
         zKtbL3ce7BOFxke3EZzFGzJPQoCX4VvhftlegKzHJZv9jOg866q5vemcyUbxqEuONvIg
         ikp52NyCfNmsEHRKNrSPzhAS+B4MVSanVjkpupE342iP8X8DSOvXA2XqM+Ljnf0n7KvF
         dTJsl8ZN+96YgehvLgPHGZhR7/IzHqGiq9v93SIzD5f3xaez9aj7wGnnzXi3BMF7mCgF
         VrvdMoxj7hwi4fQnJfLDQ2LuNaW1o+0G2Yq/3UgBwD/Z5+YSvpRTJEdCaTHlMUqKH6tc
         CnFw==
X-Gm-Message-State: AOAM533dtlxItbeZDsjTLLlM8Htc9alUPOX91MCgR6cjFCIfs6nmsLlm
        ic2Hw+X+xmFejlwvGw+h8pjnyxay0+/mO3F1BzVTfA==
X-Google-Smtp-Source: ABdhPJz36ON+djVou1Lu0bUXqr7/f1L1bt2WJsjaaZuWE3eVLCbRks9b/YMgcJJgp0E9upbbebjDolDn3fGr+cA7dq8=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr16150759otb.281.1625592967188;
 Tue, 06 Jul 2021 10:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210705130314.11519-1-ogabbay@kernel.org> <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca> <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
 <20210706152542.GP4604@ziepe.ca> <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
 <20210706162953.GQ4604@ziepe.ca>
In-Reply-To: <20210706162953.GQ4604@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 6 Jul 2021 19:35:55 +0200
Message-ID: <CAKMK7uGXUgjyjch57J3UnC7SA3-4g87Ft7tLjj9fFkgyKkKdrg@mail.gmail.com>
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

On Tue, Jul 6, 2021 at 6:29 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 06, 2021 at 05:49:01PM +0200, Daniel Vetter wrote:
>
> > The other thing to keep in mind is that one of these drivers supports
> > 25 years of product generations, and the other one doesn't.
>
> Sure, but that is the point, isn't it? To have an actually useful
> thing you need all of this mess
>
> > > My argument is that an in-tree open kernel driver is a big help to
> > > reverse engineering an open userspace. Having the vendors
> > > collaboration to build that monstrous thing can only help the end goal
> > > of an end to end open stack.
> >
> > Not sure where this got lost, but we're totally fine with vendors
> > using the upstream driver together with their closed stack. And most
> > of the drivers we do have in upstream are actually, at least in parts,
> > supported by the vendor. E.g. if you'd have looked the drm/arm driver
> > you picked is actually 100% written by ARM engineers. So kinda
> > unfitting example.
>
> So the argument with Habana really boils down to how much do they need
> to show in the open source space to get a kernel driver? You want to
> see the ISA or compiler at least?

Yup. We dont care about any of the fancy pieces you build on top, nor
does the compiler need to be the optimizing one. Just something that's
good enough to drive the hw in some demons to see how it works and all
that. Generally that's also not that hard to reverse engineer, if
someone is bored enough, the real fancy stuff tends to be in how you
optimize the generated code. And make it fit into the higher levels
properly.

> That at least doesn't seem "extreme" to me.
>
> > > For instance a vendor with an in-tree driver has a strong incentive to
> > > sort out their FW licensing issues so it can be redistributed.
> >
> > Nvidia has been claiming to try and sort out the FW problem for years.
> > They even managed to release a few things, but I think the last one is
> > 2-3 years late now. Partially the reason is that there don't have a
> > stable api between the firmware and driver, it's all internal from the
> > same source tree, and they don't really want to change that.
>
> Right, companies have no incentive to work in a sane way if they have
> their own parallel world. I think drawing them part by part into the
> standard open workflows and expectations is actually helpful to
> everyone.

Well we do try to get them on board part-by-part generally starting
with the kernel and ending with a proper compiler instead of the usual
llvm hack job, but for whatever reasons they really like their
in-house stuff, see below for what I mean.

> > > > I don't think the facts on the ground support your claim here, aside
> > > > from the practical problem that nvidia is unwilling to even create an
> > > > open driver to begin with. So there isn't anything to merge.
> > >
> > > The internet tells me there is nvgpu, it doesn't seem to have helped.
> >
> > Not sure which one you mean, but every once in a while they open up a
> > few headers, or a few programming specs, or a small driver somewhere
> > for a very specific thing, and then it dies again or gets obfuscated
> > for the next platform, or just never updated. I've never seen anything
> > that comes remotely to something complete, aside from tegra socs,
> > which are fully supported in upstream afaik.
>
> I understand nvgpu is the tegra driver that people actualy
> use. nouveau may have good tegra support but is it used in any actual
> commercial product?

I think it was almost the case. Afaik they still have their internal
userspace stack working on top of nvidia, at least last year someone
fixed up a bunch of issues in the tegra+nouveau combo to enable format
modifiers properly across the board. But also nvidia is never going to
sell you that as the officially supported thing, unless your ask comes
back with enormous amounts of sold hardware.

And it's not just nvidia, it's pretty much everyone. Like a soc
company I don't want to know started collaborating with upstream and
the reverse-engineered mesa team on a kernel driver, seems to work
pretty well for current hardware. But for the next generation they
decided it's going to be again only their in-house tree that
completele ignores drivers/gpu/drm, and also tosses all the
foundational work they helped build on the userspace side. And this is
consistent across all companies, over the last 20 years I know of
(often non-public) stories across every single company where they
decided that all the time invested into community/upstream
collaboration isn't useful anymore, we go all vendor solo for the next
one.

Most of those you luckily don't hear about anymore, all it results in
the upstream driver being 1-2 years late or so. But even the good ones
where we collaborate well can't seem to help themselves and want to
throw it all away every few years.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
