Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F053A1DDC4B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 02:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgEVArp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 20:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgEVAro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 20:47:44 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB308C061A0E;
        Thu, 21 May 2020 17:47:44 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id g79so3775992ybf.0;
        Thu, 21 May 2020 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1achSWEeCebePnmfJCefzRB6hhApcsEC43Uj0PfEdo=;
        b=WsGRWs81ne4GiEIj2AuIqikvp+lAWF+9c6fBO/yPPFiOxIHXJ/DrPBIMsGpTFaITpu
         9i9UhHdmI5Avjonw3yqrBGbpCzvnrNWyoWx8wJl5tCPlriDkngednvKIudKH2d+WfEQw
         h55ECOkkfEaKHhzsJVUDKS8uWQ4x4Js4Qwy1kvRuhBvMr2bYe9N168YuA0OuiyR28BGT
         mG4pSBmtdc24n52sGqwScHBmyYhwYqVrp16anD7tQUJb178QRxctfifFkBt/dgG8F+5f
         837fbBybst4L3Xxia67k5YB+sNG2kr+a7vmpGCs+Xw/FAV0rtV7r4hiPw3ZsgNa8UeKP
         VvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1achSWEeCebePnmfJCefzRB6hhApcsEC43Uj0PfEdo=;
        b=areGP3zWowwAnDd6KrlLOOS1LyKnlz2+CD1nrxCAUEKznfa+4mhBcSfv61I40lJGAK
         c4QAvpkOsVNAJZyMPM6JRU0PI5npOTeGkfY+rp6maDPOlQrXstYMxNiwUb8Xd4aBqGZP
         NjAyMnGGQiN0OVJHQT1V/QyChgighBODpmBeqmQlqGXV/5bgD+kv+ZkArvJq7XfSacTP
         8LF4Uo+/GsRFjvGnncQe0UPwkKdrYRR1Bw8+Jg2Xlv+DZcUAX8Fncq51ChUjut+jtwDy
         xRnNTeiXcHJXv+nT+ChSJ7w++yayUuuBmRVlcgmHTh3w+3HfpjaIvgOks7wNhZs+tBiZ
         IoKQ==
X-Gm-Message-State: AOAM532IkaXhhDg2nmhIXARbWExHRNx+S/Cc+qbWWOPPib4hy5M3sPS2
        8Whz99uNa2vnlPuioksE12+coWFsueqMJ1t4g5Y=
X-Google-Smtp-Source: ABdhPJzz46XpCwc5jovLm8lmHQ+AD9jyCkktAnl9vTJWUtMKYfZSqeYdgJlRvpqDlK57+i71ZO4Zm6KzcwysMIEomd0=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr19502909ybp.268.1590108463933;
 Thu, 21 May 2020 17:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200520183652.21633-1-rcampbell@nvidia.com> <20200520192045.GH24561@mellanox.com>
 <0ef69e08-7f5d-7a3d-c657-55b3a8df1dfe@nvidia.com>
In-Reply-To: <0ef69e08-7f5d-7a3d-c657-55b3a8df1dfe@nvidia.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Fri, 22 May 2020 10:47:32 +1000
Message-ID: <CACAvsv6TYCaChfsp4LNcVUZ6b0f6F5vDiKqfpzRTVRnRM7373g@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] nouveau/hmm: fix migrate zero page to GPU
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 21 May 2020 at 07:05, Ralph Campbell <rcampbell@nvidia.com> wrote:
>
>
> On 5/20/20 12:20 PM, Jason Gunthorpe wrote:
> > On Wed, May 20, 2020 at 11:36:52AM -0700, Ralph Campbell wrote:
> >> When calling OpenCL clEnqueueSVMMigrateMem() on a region of memory that
> >> is backed by pte_none() or zero pages, migrate_vma_setup() will fill the
> >> source PFN array with an entry indicating the source page is zero.
> >> Use this to optimize migration to device private memory by allocating
> >> GPU memory and zero filling it instead of failing to migrate the page.
> >>
> >> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> >>
> >> This patch applies cleanly to Jason's Gunthorpe's hmm tree plus two
> >> patches I posted earlier. The first is queued in Ben Skegg's nouveau
> >> tree and the second is still pending review/not queued.
> >> [1] ("nouveau/hmm: map pages after migration")
> >> https://lore.kernel.org/linux-mm/20200304001339.8248-5-rcampbell@nvidia.com/
> >> [2] ("nouveau/hmm: fix nouveau_dmem_chunk allocations")
> >> https://lore.kernel.org/lkml/20200421231107.30958-1-rcampbell@nvidia.com/
> >
> > It would be best if it goes through Ben's tree if it doesn't have
> > conflicts with the hunks I have in the hmm tree.. Is it the case?
> >
> > Jason
>
> I think there might be some merge conflicts even though it is semantically
> independent of the other changes. I guess since we are at 5.7-rc6 and not
> far from the merge window, I can rebase after 5.8-rc1 and resend.
> I posted this mostly to get some review and as a "heads up" of the issue.
Both look alright to me, and apply cleanly on top of my tree already,
so I've got them locally.

Ben.

> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
