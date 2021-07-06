Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7843A3BDA1D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhGFP2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGFP2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 11:28:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00824C061760
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 08:25:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l11so13717909pji.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBvoTSBcOt78f+hoOE9oCqUZer2JVIUIWKm+LE7tBB8=;
        b=X163Xk+G02T/FYeziNGDwCPOc6BLNJpmRANJZemVrSobPquSFvpYvLg7I+/xXol03F
         kgToG/GWqTW22vdfS86rrDbHG+VIoJpV7F3ia6ZGlrrWTBFKBlA1qJfDU2QYjFMxw9bn
         18zM+SC3OK5PBTSWnVn9GnFtpVk1NhRB4WRRd6zVs3M5rR6QpNocNXBiV7EL2h8le3Ow
         jvZU/A0iyEbkwxC5Yua5tblx9J0ejeZ7v4lloFM8eg/sgExGmReJOD+eEQ6g9p7ckBea
         AQnNsdBTVeckFCBTYdf84UR54cEJl3YU8s6gAghdvxWN3OAHAx/OxyzWsnveJxZQA+4F
         K0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBvoTSBcOt78f+hoOE9oCqUZer2JVIUIWKm+LE7tBB8=;
        b=dAqcDTZ6YMc0VDQRD2pt8VZtc8dDu4LqlB/aj1NWVfU4ijkXgLjsv90mrenu4KMeao
         qp5p6n8n7pJ79PcUOOfrqySkQY8Lxo6cQXE8ia+16bjoO+AzNpDbqpflr+1/is0WYunn
         t8BItwK0Jp1IzzKer9cJP729bm3y4wtbSsK92jX7kfN/vHLY5tkm4Rakt8F8D4r5bveB
         P/L1rV4ad1k1vGE1DpId9D/QS4upRaBwlIEi+wRu76KHjkymrNkiSyjj6GrpVzwdEBpp
         g9AfhExO4lZehfxc85yDsXpRHchKjwmgDFMycoxbeYMFqxaD2VbptcIlSROP8wqb/Azo
         wnYw==
X-Gm-Message-State: AOAM5300bKexO/zkyqQtQ977krtMCBhf4wRM1iBJrlNvK93kz4AaehOW
        KrJXO4jLjXffcX0FHwD49C52OA==
X-Google-Smtp-Source: ABdhPJxrcXwOAFPmP3ClDrDAEt0u9Z/9YZvGne/AXypBqtfhopbFKVCe78sZDR5N+5fl5a1I4tI3yA==
X-Received: by 2002:a17:90a:8417:: with SMTP id j23mr1072739pjn.210.1625585145462;
        Tue, 06 Jul 2021 08:25:45 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id m18sm17872288pff.88.2021.07.06.08.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:25:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m0mxC-004SbX-Ps; Tue, 06 Jul 2021 12:25:42 -0300
Date:   Tue, 6 Jul 2021 12:25:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706152542.GP4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca>
 <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 04:39:19PM +0200, Daniel Vetter wrote:
> On Tue, Jul 6, 2021 at 4:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jul 06, 2021 at 12:36:51PM +0200, Daniel Vetter wrote:
> >
> > > If that means AI companies don't want to open our their hw specs
> > > enough to allow that, so be it - all you get in that case is
> > > offloading the kernel side  of the stack for convenience, with zero
> > > long term prospects to ever make this into a cross vendor subsystem
> > > stack that does something useful.
> >
> > I don't think this is true at all - nouveau is probably the best
> > example.
> >
> > nouveau reverse engineered a userspace stack for one of these devices.
> >
> > How much further ahead would they have been by now if they had a
> > vendor supported, fully featured, open kernel driver to build the
> > userspace upon?
> 
> There is actually tons of example here, most of the arm socs have
> fully open kernel drivers, supported by the vendor (out of tree).

I choose nouveau because of this:

$ git ls-files drivers/gpu/drm/arm/ | xargs wc -l
 15039 total
$ git ls-files drivers/gpu/drm/nouveau/ | xargs wc -l
 204198 total

At 13x the size of mali this is not just some easy to wire up memory
manager and command submission. And after all that typing it still
isn't very good. The fully supported AMD vendor driver is over 3
million lines, so nouveau probably needs to grow several times.

My argument is that an in-tree open kernel driver is a big help to
reverse engineering an open userspace. Having the vendors
collaboration to build that monstrous thing can only help the end goal
of an end to end open stack.

For instance a vendor with an in-tree driver has a strong incentive to
sort out their FW licensing issues so it can be redistributed.

I'm not sure about this all or nothing approach. AFAIK DRM has the
worst problems with out of tree drivers right now.

> Where it would have helped is if this open driver would come with
> redistributable firmware, because that is right now the thing making
> nouveau reverse-engineering painful enough to be non-feasible. Well
> not the reverse-engineering, but the "shipping the result as a working
> driver stack".

I don't think much of the out of tree but open drivers. The goal must
be to get vendors in tree.

I would applaud Habana for getting an intree driver at least, even if
the userspace is not what we'd all want to see.

> I don't think the facts on the ground support your claim here, aside
> from the practical problem that nvidia is unwilling to even create an
> open driver to begin with. So there isn't anything to merge.

The internet tells me there is nvgpu, it doesn't seem to have helped.

Jason
