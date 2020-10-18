Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0242918C1
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Oct 2020 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgJRSGM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Oct 2020 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRSGM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Oct 2020 14:06:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60DFC061755
        for <linux-rdma@vger.kernel.org>; Sun, 18 Oct 2020 11:06:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i12so8303803ota.5
        for <linux-rdma@vger.kernel.org>; Sun, 18 Oct 2020 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVsl1Axinthci9ar7nU6pr8nf93oOM7p1lKKnFskbys=;
        b=CmaAZeigOTVUGcvHTiNeVQ8JXczmVCbe+BXq1uR+3GfDhE9h1O1purZG2Nilm6Xh+B
         KuQ6COjqqls8sLyIJbD7gNNvIN1q5Urjfi+8FWUhmzCblBnYRSU1ZrjRl+72vuNnXPQo
         P/ChD3WGwiEAkWmT62cwi7DTIEXr1I6+BTAIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVsl1Axinthci9ar7nU6pr8nf93oOM7p1lKKnFskbys=;
        b=ubt1/Yl8wYw4mV+6vK79qGrV0bvn6A2sCsT2bCwxLrwxfzmBaNeWmpetG81CR6+FDo
         +r+EMxzZz043oKYsOXcakw6u5Z96ebiKc0n3otoBtPvXOrT77WaEVV5OwH12pr/4zIjw
         5eeZ9jh2jcWcVhCDFGQ4b+10WEdtKMFZ0i6duCdb2Oj7akOTlnKC14Moi0S/t6m+ZKff
         WN6T5aZOfCadDvJLmMqcofByA33WpkSY8y/U97O59qy6Mqbr8hw1ex6Y73ps0S+mFGfF
         HvGsBtrB0tS2V5FdsWU9WlcOqBoD0AjG0K0x6LMAt2qSRGxGHT7+FQ5KHKYspuf4X+XJ
         lQYQ==
X-Gm-Message-State: AOAM531vQVaXFwOV8cExHM+5VtKCLfvAsGcyfOrrgtqIPcmNXSnZ61rF
        I//g9SwoUjreQ5wHq91CBiXB4NDoZXNcUiRiYVFvkQ==
X-Google-Smtp-Source: ABdhPJyKixzQxvE+GzxQcaMU2aZfWmNr+/lmh7CXPMS+AZFRiCTXM6Pe4OwS4J4aBsJ0OG1/00t5O5iRLJTHRvxSQa8=
X-Received: by 2002:a05:6830:8b:: with SMTP id a11mr9322980oto.303.1603044370984;
 Sun, 18 Oct 2020 11:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <1602799365-138199-1-git-send-email-jianxin.xiong@intel.com> <20201016185959.GC37159@ziepe.ca>
In-Reply-To: <20201016185959.GC37159@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 18 Oct 2020 20:05:59 +0200
Message-ID: <CAKMK7uHvvtOQgoG4SLA_y0DmfusjOHd=xeN14Jsq7jC=J58HTA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 17, 2020 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Oct 15, 2020 at 03:02:45PM -0700, Jianxin Xiong wrote:
>
> > +static void ib_umem_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
> > +{
> > +     struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
> > +
> > +     dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> > +
> > +     ib_umem_dmabuf_unmap_pages(&umem_dmabuf->umem, true);
> > +     queue_work(ib_wq, &umem_dmabuf->work);
>
> Do we really want to queue remapping or should it wait until there is
> a page fault?
>
> What do GPUs do?

Atm no gpu drivers in upstream that use buffer-based memory management
and support page faults in the hw. So we have to pull the entire thing
in anyway and use the dma_fence stuff to track what's busy.

For faulting hardware I'd wait until the first page fault and then map
in the entire range again (you get the entire thing anyway). Since the
move_notify happened because the buffer is moving, you'll end up
stalling anyway. Plus if you prefault right away you need some
thrashing limiter to not do that when you get immediate move_notify
again. As a first thing I'd do the same thing you do for mmu notifier
ranges, since it's kinda similarish.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
