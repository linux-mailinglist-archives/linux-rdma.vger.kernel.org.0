Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4875201AF2
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbgFSTL2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 15:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgFSTL1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 15:11:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E124C06174E;
        Fri, 19 Jun 2020 12:11:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so9394165wme.3;
        Fri, 19 Jun 2020 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=chbWz7xzFy579TbWBa7IgoDaVrcNNu3e+ZV8C+3+5ts=;
        b=olNdwx7EKNULbKgME9rHSKmUDJKGownFmH7K7UdqCiyAe31tms05xsgDMDHl0NOZyn
         e4JT2rb2s3q5lfqM11BP72moDoCJO7fo8XhUHqRhLmM9Rkjt/Mcz6AzymyLaafuA8Ulb
         XTVeNEMS1qKMS0ZFjOH4/+4FZ+XMgy0Z+itG4tjjFKBv1tiJ5h7bNhFkbXDaSQ/Fpz4X
         ea1xDim6+696Be1q0Zr3RvYmOvlbnd3iJrBAwzkYAU7fiPUm1Tydf4L5z5X/RqFkIs6D
         rXFOo0qB32FQo9vj/cdysyW33DCxg/zYBiOMh8UCXO3mP8EhhV49/E8yMaB/+LvgfTFf
         Q3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=chbWz7xzFy579TbWBa7IgoDaVrcNNu3e+ZV8C+3+5ts=;
        b=VdWFgVwlnRqe8zFuiuGj8opy7XaeoK5ZpfZCPIrgo/CuJbrl+ZkrYpPuSiHHZnqd35
         xsxqI6V3EiZW7/QxmLrT3UZ8OZ5bSRQ6GUfiiiaEm4BMlrLnPVel/vYaLr+fs4fil6eb
         QIw34rlQ+/uhxRjSlWG/1Lvw6UQp6zcJjZ++poAgorFrMhmeDrnLsUuIInECsorFvRbd
         eQslSf0/1BAFV2f4gmTk6fTH4hf6MQ7AcqI6qgs5Fc08p9wfO/PyIjULwdvkLHG3amet
         pNbe7PZDlev6biEPgzvs90AmLpk84RiNdTCYtoUKqGpjuaQV4FT2OBTTWQwaSNkBGy23
         Yn8g==
X-Gm-Message-State: AOAM530KAt8ILVAbMWEsY1a5MmdQAlZ3TxgiKMH1KFm+akFgx5eFo4Ja
        Idycx9xCG/P8UURrK5eiYgL2yhbplaXe+6lcFUo=
X-Google-Smtp-Source: ABdhPJwcHFy0tih4Jg9lH/i7Ldu0yNdrmwrIvxAKTo0TP4xm3PszQ+8aXnDybDwn0lmkl3Yy4KGqnVo3R2CnXN9sXgU=
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr5280023wmj.56.1592593883868;
 Fri, 19 Jun 2020 12:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca> <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca> <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca> <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca> <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca> <20200619180935.GA10009@redhat.com>
In-Reply-To: <20200619180935.GA10009@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Jun 2020 15:11:12 -0400
Message-ID: <CADnq5_Pw_85Kzh1of=MbDi4g9POeF3jO4AJ7p2FjY5XZW0=vsQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 2:09 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 02:23:08PM -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 19, 2020 at 06:19:41PM +0200, Daniel Vetter wrote:
> >
> > > The madness is only that device B's mmu notifier might need to wait
> > > for fence_B so that the dma operation finishes. Which in turn has to
> > > wait for device A to finish first.
> >
> > So, it sound, fundamentally you've got this graph of operations across
> > an unknown set of drivers and the kernel cannot insert itself in
> > dma_fence hand offs to re-validate any of the buffers involved?
> > Buffers which by definition cannot be touched by the hardware yet.
> >
> > That really is a pretty horrible place to end up..
> >
> > Pinning really is right answer for this kind of work flow. I think
> > converting pinning to notifers should not be done unless notifier
> > invalidation is relatively bounded.
> >
> > I know people like notifiers because they give a bit nicer performance
> > in some happy cases, but this cripples all the bad cases..
> >
> > If pinning doesn't work for some reason maybe we should address that?
>
> Note that the dma fence is only true for user ptr buffer which predate
> any HMM work and thus were using mmu notifier already. You need the
> mmu notifier there because of fork and other corner cases.
>
> For nouveau the notifier do not need to wait for anything it can update
> the GPU page table right away. Modulo needing to write to GPU memory
> using dma engine if the GPU page table is in GPU memory that is not
> accessible from the CPU but that's never the case for nouveau so far
> (but i expect it will be at one point).
>
>
> So i see this as 2 different cases, the user ptr case, which does pin
> pages by the way, where things are synchronous. Versus the HMM cases
> where everything is asynchronous.
>
>
> I probably need to warn AMD folks again that using HMM means that you
> must be able to update the GPU page table asynchronously without
> fence wait. The issue for AMD is that they already update their GPU
> page table using DMA engine. I believe this is still doable if they
> use a kernel only DMA engine context, where only kernel can queue up
> jobs so that you do not need to wait for unrelated things and you can
> prioritize GPU page table update which should translate in fast GPU
> page table update without DMA fence.

All devices which support recoverable page faults also have a
dedicated paging engine for the kernel driver which the driver already
makes use of.  We can also update the GPU page tables with the CPU.

Alex

>
>
> > > Full disclosure: We are aware that we've designed ourselves into an
> > > impressive corner here, and there's lots of talks going on about
> > > untangling the dma synchronization from the memory management
> > > completely. But
> >
> > I think the documenting is really important: only GPU should be using
> > this stuff and driving notifiers this way. Complete NO for any
> > totally-not-a-GPU things in drivers/accel for sure.
>
> Yes for user that expect HMM they need to be asynchronous. But it is
> hard to revert user ptr has it was done a long time ago.
>
> Cheers,
> J=C3=A9r=C3=B4me
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
