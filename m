Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9303F279F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 09:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhHTH0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 03:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhHTH0T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Aug 2021 03:26:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21023C061575
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 00:25:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w6so12038426oiv.11
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5ALr4EA4tA2v978TPeOHUvCmve3hdooJ+JbOY+xBaw=;
        b=e8DhrBaGywh239BR9UQgfCjPecmsIPU8LAS/ZlfifZh0cpL4zFyrZpikEaVhObl4IF
         pozoTQDVklP+HA+yeDTCvsVH4MDujDI65ZCmdG1lpbaPY8SXUM9RnkO2x6mIrJPOBr/o
         18WMB/R0IAUdjnO9eSdJriCYRNe3pfqIq9ePc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5ALr4EA4tA2v978TPeOHUvCmve3hdooJ+JbOY+xBaw=;
        b=gpNoUx6xb25lZb/fu0b3POBVjiI4VG3bWzMXwUFoBJjnJTsNUiBLEHVjptU0CsoN5E
         uoecv4aqLrHQM47q+vSzxWu5ZUVQcR3i4tTycRzseQ8wZWGmT7GFpyXNLQJqz65UFBUx
         3pVh08lvIAuI3d90+o2yMNzk8rQ8SPXnHUFI+5xUsq9nPkX89swrtIqC4VKkpcZIDyEU
         mRaqcp/io8uwPXMKkzmiEq6Wo26/y3toFL1ZT7NnCYKxEGyhntAX6iz9O00FU2swDXBs
         wwB/XXV/nT/Adcr6eXWY33GtDKA+UjDsTQzrcP9JmWZn/7UDwyeVwptYWAVru9/rlto2
         GgNA==
X-Gm-Message-State: AOAM532vvdT5xzU1DV8P0/Jwj4tClnQP4FdoQoksBrou0a/NwWULIKhE
        i7zLqpxM8ajDmnhuWqRcbndd53ajezn3BdPQVRY83w==
X-Google-Smtp-Source: ABdhPJwlex8RkEsRvudtfGWE0C46ujA2iX4BP2ZJ8GsF4Jblfr83G50+9sU0thDn+HWeLg/nFJaZIYC4VGB2Ro+Unmc=
X-Received: by 2002:a05:6808:2116:: with SMTP id r22mr2012118oiw.128.1629444341532;
 Fri, 20 Aug 2021 00:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210818074352.29950-1-galpress@amazon.com> <CAKMK7uGZ_eX+XfYJU6EkKEOVrHz3q6QMxaEbyyD3_1iqj9YSjw@mail.gmail.com>
 <20210819230602.GU543798@ziepe.ca>
In-Reply-To: <20210819230602.GU543798@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 20 Aug 2021 09:25:30 +0200
Message-ID: <CAKMK7uGgQWcs4Va6TGN9akHSSkmTs1i0Kx+6WpeiXWhJKpasLA@mail.gmail.com>
Subject: Re: [RFC] Make use of non-dynamic dmabuf in RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gal Pressman <galpress@amazon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 20, 2021 at 1:06 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Aug 18, 2021 at 11:34:51AM +0200, Daniel Vetter wrote:
> > On Wed, Aug 18, 2021 at 9:45 AM Gal Pressman <galpress@amazon.com> wrote:
> > >
> > > Hey all,
> > >
> > > Currently, the RDMA subsystem can only work with dynamic dmabuf
> > > attachments, which requires the RDMA device to support on-demand-paging
> > > (ODP) which is not common on most devices (only supported by mlx5).
> > >
> > > While the dynamic requirement makes sense for certain GPUs, some devices
> > > (such as habanalabs) have device memory that is always "pinned" and do
> > > not need/use the move_notify operation.
> > >
> > > The motivation of this RFC is to use habanalabs as the dmabuf exporter,
> > > and EFA as the importer to allow for peer2peer access through libibverbs.
> > >
> > > This draft patch changes the dmabuf driver to differentiate between
> > > static/dynamic attachments by looking at the move_notify op instead of
> > > the importer_ops struct, and allowing the peer2peer flag to be enabled
> > > in case of a static exporter.
> > >
> > > Thanks
> > >
> > > Signed-off-by: Gal Pressman <galpress@amazon.com>
> >
> > Given that habanalabs dma-buf support is very firmly in limbo (at
> > least it's not yet in linux-next or anywhere else) I think you want to
> > solve that problem first before we tackle the additional issue of
> > making p2p work without dynamic dma-buf. Without that it just doesn't
> > make a lot of sense really to talk about solutions here.
>
> I have been thinking about adding a dmabuf exporter to VFIO, for
> basically the same reason habana labs wants to do it.
>
> In that situation we'd want to see an approach similar to this as well
> to have a broad usability.
>
> The GPU drivers also want this for certain sophisticated scenarios
> with RDMA, the intree drivers just haven't quite got there yet.
>
> So, I think it is worthwhile to start thinking about this regardless
> of habana labs.

Oh sure, I've been having these for a while. I think there's two options:
- some kind of soft-pin, where the contract is that we only revoke
when absolutely necessary, and it's expected to be catastrophic on the
importer's side. The use-case would be single user that fully controls
all accelerator local memory, and so kernel driver evicting stuff. I
havent implemented it, but the idea is that essentially in eviction we
check whom we're evicting for (by checking owners of buffers maybe,
atm those are not tracked in generic code but not that hard to add),
and if it's the same userspace owner we don't ever pick these buffers
as victims for eviction, preferreing -ENOMEM/-ENOSPC. If a new user
comes around then we'd still throw these out to avoid abuse, and it
would be up to sysadmins to make sure this doesn't happen untimely,
maybe with the next thing.

- cgroups for (pinned) buffers. Mostly because cgroups for local
memory is somewhere on the plans anyway, but that one could also take
forever since there's questions about overlap with memcg and things
like that, plus thus far everyone who cares made and incompatible
proposal about how it should be done :-/

A variant of the first one would be device-level revoke, which is a
concept we already have in drm for the modesetting side and also for
like 20 year old gpu drivers. We could brush that off and close some
of the gaps (a student is fixing the locking right now, the thing left
to do is mmap revoke), and I think that model of exclusive device
ownership with the option to revoke fits pretty well for at least some
of the accelerators floating around. In that case importers would
never get a move_notify (maybe we should call this revoke_notify to
make it clear it's a bit different) callback, except when the entire
thing has been yanked. I think that would fit pretty well for VFIO,
and I think we should be able to make it work for rdma too as some
kind of auto-deregister. The locking might be fun with both of these
since I expect some inversions compared to the register path, we'll
have to figure these out.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
