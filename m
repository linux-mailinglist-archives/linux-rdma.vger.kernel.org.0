Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06D1234A2F
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbgGaRVV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgGaRVU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 13:21:20 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3DFC06174A
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jul 2020 10:21:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r12so25936189ilh.4
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jul 2020 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjnDRWhzh4EQDemiUKG1D36APM9tw49b0yekL5D351Y=;
        b=O6eLa1IixT5kqe1AFaE+bcjnOe1UcPBmwrKRiFbR0M+ApxONaIjOgTgH0qPy1e+mfI
         BrJYF48+BZ9GpnD7otmkXOlDe7LuJF5xrz4fXbebvy9H4yWGNQFWtSAOZy/YzdiydJnI
         a5ogGROvvL52W54SrDcABtpl9OJHBspk06/53PKLOXweg+kONWzZqz92EIoGP7E57tYi
         dfHR0UsbgWj1gmT6XveGJQ9D1sQUndrUnftF4ByLAeHaJktep1m5xer6vWVXk0Hz47m/
         d5I/vhBaQdxcNZBNGoMpqxGjEU+JqlRykRNRCHM9n0pzeWiwocwZ5b35DGHbQpFCf8PK
         vePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjnDRWhzh4EQDemiUKG1D36APM9tw49b0yekL5D351Y=;
        b=X59fig/8VXvBF2IFNk2g5ZpJzJjATRaqkUigXRh8mecQQ5Pc8kAsyUPeCeIQ/jtBMi
         +/E4hPRKzzTyewDoRgsgc1Qpy5iS9gW6zT+3pvIyyzqyWfh0M6q/Pqf+OYdr3Ktu0hx8
         tPLIaDNb9Z6vL0aDArtucRV7G1lx6ydiOCG99tZ6griI63VgGGPxVkF2/pBYAH4k5kcK
         tLuU4CEnFsSurZw8CEgeBVN1mcBDTepQStJcWQjydnNvPeiOZynm8Ipijc5fauFQocEC
         t2PMD1qFpugO+GFTyFkZE/QD9kgtI2LG46D3mnUyGa9bJBDk5T/5cvBVu/Od0ZsjSneZ
         ovUA==
X-Gm-Message-State: AOAM532ZgTUWovv04UvW7tv8AdK19lZdrZ9IGhmvHXnfry8Cegjd3hnB
        aswK8kQkm4oNE1F5+ek68EtbCfnb3GWF3Xw23/t+ow==
X-Google-Smtp-Source: ABdhPJyH2hwJl5Ig5ekwoTRKbYJlGW0zPP/krcQsTHZWN/txgmrTTT+uY5eC/VjlHBlg3SLatIfbujlwpFw3F+gQYbk=
X-Received: by 2002:a92:c608:: with SMTP id p8mr4865557ilm.137.1596216079403;
 Fri, 31 Jul 2020 10:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200730015755.1827498-1-edumazet@google.com> <20200731171714.GA513060@nvidia.com>
In-Reply-To: <20200731171714.GA513060@nvidia.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jul 2020 10:21:08 -0700
Message-ID: <CANn89i+SwhK8XKDqKKvL1svnBWKxv28iKzD2nEf2g0pOO0+0qQ@mail.gmail.com>
Subject: Re: [PATCH net] RDMA/umem: add a schedule point in ib_umem_get()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 31, 2020 at 10:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Jul 29, 2020 at 06:57:55PM -0700, Eric Dumazet wrote:
> > Mapping as little as 64GB can take more than 10 seconds,
> > triggering issues on kernels with CONFIG_PREEMPT_NONE=y.
> >
> > ib_umem_get() already splits the work in 2MB units on x86_64,
> > adding a cond_resched() in the long-lasting loop is enough
> > to solve the issue.
> >
> > Note that sg_alloc_table() can still use more than 100 ms,
> > which is also problematic. This might be addressed later
> > in ib_umem_add_sg_table(), adding new blocks in sgl
> > on demand.
>
> I have seen some patches in progress to do exactly this, the
> motivation is to reduce the memory consumption if a lot of pages are
> combined.

Nice ;)

>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Doug Ledford <dledford@redhat.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-rdma@vger.kernel.org
> > ---
> >  drivers/infiniband/core/umem.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Why [PATCH net] ?

Sorry, I used a script that I normally use for net submissions, forgot
to remove this tag ;)

>
> Anyhow, applied to rdma for-next

Thanks !

>
> Thanks,
> Jason
