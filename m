Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10155285173
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 20:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJFSRS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSRS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 14:17:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18651C061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 11:17:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m13so13175335otl.9
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BJOetl46CjGC6+Kkw6JOJlFGUByWzuh7BqIeDvcnK8=;
        b=C6j3rTxBY21BDxbfLE+NV5OAu3pHtkaFNROONM3Vgpk6WG09CIlA7hK1waBYxhYwfv
         4XbHhcKMRuAv+J2g5E372jYnz8kBZUInj4bPtT+9gvd83XdgeYXrThxPqhKd45R+6wGD
         /okTC4TJiIf01e5/xUdXLVREgXH3YNO5oZaoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BJOetl46CjGC6+Kkw6JOJlFGUByWzuh7BqIeDvcnK8=;
        b=ZlsWSTpJ6OP2fPg94QLraJIqQq2tws1Hu8F1fNPX0zrugoekOcLuNp1VenXVAYsZek
         iPtv3qo4uLQwK4vPMtaMF3uDvA1+BoIlcx5Lg6fbPODDAWIkRX+26eT1hAj0o3/sZRfd
         NEYtJ+qnP7VjcSWqfN1tYGbKfoLTD1lQgDSYeG73qO6iaGWDjRy8KgRdyR6Qt1xgd9Yx
         h84cmiIzm/P4sn+B3FiQRFylBe6lrr3jcE1P6v/nlT2awDABYWeZ6JM5VS+/l59AAmnY
         aKQiACUMRK4Xo7OevIYF/j2dz2ZHyLpFh9bqJJeC2pbBRHZf3Rmtqu9ufHqAOzi46ABE
         P6JQ==
X-Gm-Message-State: AOAM531VpG+dcPVtp2mGAKU1jtmtDLiKnxhlUdmp6Tz+gb30Ow+wnvu5
        WtEKu3Ia5jyosTfD1ztquJdYICxfF+FKcBZkn1ZBYw==
X-Google-Smtp-Source: ABdhPJxn5H27KuaS/cAss3uIX0XQGq12Ct5e5YOmD964NXV0R9TyjYjzKkK9AMs2dlZAqchoRZYTqVvQZKbFQqC8CWo=
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr3918101otr.281.1602008236304;
 Tue, 06 Oct 2020 11:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
 <20201005131302.GQ9916@ziepe.ca> <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201006092214.GX438822@phenom.ffwll.local> <20201006154956.GI5177@ziepe.ca>
 <20201006163420.GB438822@phenom.ffwll.local> <CAKMK7uG1RpDQ9ZO=VxkNuGjGPqkAzMQDgi89eSjDoMerMQ4+9A@mail.gmail.com>
 <20201006180244.GJ5177@ziepe.ca>
In-Reply-To: <20201006180244.GJ5177@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 6 Oct 2020 20:17:05 +0200
Message-ID: <CAKMK7uEN7=QGOJMMf5UwR5Azsk+3-apFjn_hFmoSUTDOh1f85g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 6, 2020 at 8:02 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 06, 2020 at 07:24:30PM +0200, Daniel Vetter wrote:
> > On Tue, Oct 6, 2020 at 6:34 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Tue, Oct 06, 2020 at 12:49:56PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Oct 06, 2020 at 11:22:14AM +0200, Daniel Vetter wrote:
> > > > >
> > > > > For reinstanting the pages you need:
> > > > >
> > > > > - dma_resv_lock, this prevents anyone else from issuing new moves or
> > > > >   anything like that
> > > > > - dma_resv_get_excl + dma_fence_wait to wait for any pending moves to
> > > > >   finish. gpus generally don't wait on the cpu, but block the dependent
> > > > >   dma operations from being scheduled until that fence fired. But for rdma
> > > > >   odp I think you need the cpu wait in your worker here.
> > > >
> > > > Reinstating is not really any different that the first insertion, so
> > > > then all this should be needed in every case?
> > >
> > > Yes. Without move_notify we pin the dma-buf into system memory, so it
> > > can't move, and hence you also don't have to chase it. But with
> > > move_notify this all becomes possible.
> >
> > I just realized I got it wrong compared to gpus. I needs to be:
> > 1. dma_resv_lock
> > 2. dma_buf_map_attachment, which might have to move the buffer around
> > again if you're unlucky
> > 3. wait for the exclusive fence
> > 4. put sgt into your rdma ptes
> > 5 dma_resv_unlock
> >
> > Maybe also something we should document somewhere for dynamic buffers.
> > Assuming I got it right this time around ... Christian?
>
> #3 between 2 and 4 seems strange - I would expect once
> dma_buf_map_attachment() returns that the buffer can be placed in the
> ptes. It certianly can't be changed after the SGL is returned..


So on the gpu we pipeline this all. So step 4 doesn't happen on the
cpu, but instead we queue up a bunch of command buffers so that the
gpu writes these pagetables (and the flushes tlbs and then does the
actual stuff userspace wants it to do).

And all that is being blocked in the gpu scheduler on the fences we
acquire in step 3. Again we don't wait on the cpu for that fence, we
just queue it all up and let the gpu scheduler sort out the mess. End
result is that you get a sgt that points at stuff which very well
might have nothing even remotely resembling your buffer in there at
the moment. But all the copy operations are queued up, so rsn the data
will also be there.

This is also why the precise semantics of move_notify for gpu<->gpu
sharing took forever to discuss and are still a bit wip, because you
have the inverse problem: The dma api mapping might still be there in
the iommu, but the data behind it is long gone and replaced. So we
need to be really carefully with making sure that dma operations are
blocked in the gpu properly, with all the flushing and everything. I
think we've reached the conclusion that ->move_notify is allowed to
change the set of fences in the dma_resv so that these flushes and pte
writes can be queued up correctly (on many gpu you can't synchronously
flush tlbs, yay). The exporter then needs to make sure that the actual
buffer move is queued up behind all these operations too.

But rdma doesn't work like that, so it looks all a bit funny.

Anticipating your next question: Can this mean there's a bunch of
differnt dma/buffer mappings in flight for the same buffer?

Yes. We call the ghost objects, at least in the ttm helpers.

> Feels like #2 should serialize all this internally? An API that
> returns invalidate data sometimes is dangerous :)

If you use the non-dynamic mode, where we pin the buffer into system
memory at dma_buf_attach time, it kinda works like that. Also it's not
flat out invalide date, it's the most up-to-date data reflecting all
committed changes. Plus dma_resv tells you when that will actually be
reality in the hardware, not just the software tracking of what's
going on.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
