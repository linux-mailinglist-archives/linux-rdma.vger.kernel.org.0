Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFE140DDC5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhIPPTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhIPPTA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 11:19:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBBC061764
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:17:39 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so8788805otf.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBnm1KnUuxtdGKyRhrgjabbAZKUXf06dsPW76/EUyyY=;
        b=ryTAILdz68SeBnV2MBGf+pL5CIn3Ex9mqX2WODAPIOkjrY/AWOOe+FhRrP52sZWquP
         DhnrQl2k6vIeYtkHPfWgC8fe90GIpbwnBkXa6jbftxNW+UgmjwUmLY9TMJZjTYAvcWOt
         WSP/RhKcDKvgorgUUKoLQU+8folRyPOyIUnuzrszKexzFU4CXKl6NP3bkyEu052Sjc1I
         A5QMIZZdaldNo+j9smdX/wW+kzwwP1Z9nkFjZVGgFsd0wkuuegs4YdL98SHoSs8lCWu9
         HGIlYkVz6+64QMXZx42H3oXJAdR1JK3UQ2XGOj6sSo1NnmuRNMRrV4R1drNzxCezO+6F
         8h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBnm1KnUuxtdGKyRhrgjabbAZKUXf06dsPW76/EUyyY=;
        b=nORKLL6T5A3Y8CBlOfJNWz7+tTkn/27ThT1DDW3KABSorKgW+7TxmSc57vGkPyEbK7
         md/du76TgOZD9ggNm7asjogAsOpME6WZgcMQgIVZV3xlaEiNZkXyz8tKoBAwLNIk92fN
         /NpAEVLv9GuWi2Kwyhrzx7UjZCB4ykTDPnSZtLaQ4nseqxPrhoP6+DwBsHH0zNJD/EY0
         v6+jUd9Xi5smIbjwXzOWjYv74wW4l8t6O7VqK0+OplL1sslIIidSWbfRNbV8JlWdC50w
         YD405b3n25U+2o8Aqh5te1avdDS0D/Tlw91nQLzXt3SswV5hq7DExmkIP1EHBA00N4Q+
         8Dyg==
X-Gm-Message-State: AOAM532ICTZBjoStWMzDySsXYJ7zUoN36WbzuI9eVJuYf+oRv+JUH4rI
        HJkYG0+q2JjAZGQky/WXk4YeJKf03zNafnnMqPes2Q==
X-Google-Smtp-Source: ABdhPJyu2fcPZf9f1J1IWu4N2nRRbfaeE+o0ynvcode8xsPWpsEgNskqC469m+MUdhJG2CImcmWnipIkaw+N/APy5Qk=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr5211766ote.319.1631805459058;
 Thu, 16 Sep 2021 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ffdae005cc08037e@google.com> <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca> <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
 <CACT4Y+ZrQL3n=N2GOfJ6vLNW2_4MdiwywXvZpQ=as_NbJ8PXjw@mail.gmail.com>
 <CACT4Y+ZrXft1cMg0X48TrvbLj0moCb5nyWs1HG0WAZkpKmiBaA@mail.gmail.com> <20210916150850.GN3544071@ziepe.ca>
In-Reply-To: <20210916150850.GN3544071@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Sep 2021 17:17:27 +0200
Message-ID: <CACT4Y+bSb8ck4C-Uc2E-2xP=W_r-2i3KUSnqfHr=Z7GB46+CAg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 16 Sept 2021 at 17:08, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Sep 16, 2021 at 04:55:16PM +0200, Dmitry Vyukov wrote:
>
> > > I noticed we also had 2 KCSAN reports that mention rdma_resolve_addr.
> > >
> > > On commit 1df0d896:
> > > ==================================================================
> > > BUG: KCSAN: data-race in addr_handler / cma_check_port
> > >
> > > write to 0xffff88809fa40a1c of 4 bytes by task 21 on cpu 1:
> > >  cma_comp_exch drivers/infiniband/core/cma.c:426 [inline]
> > >  addr_handler+0x9f/0x2b0 drivers/infiniband/core/cma.c:3141
> > >  process_one_req+0x22f/0x300 drivers/infiniband/core/addr.c:645
> > >  process_one_work+0x3e1/0x9a0 kernel/workqueue.c:2269
> > >  worker_thread+0x665/0xbe0 kernel/workqueue.c:2415
> > >  kthread+0x20d/0x230 kernel/kthread.c:291
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> > >
> > > read to 0xffff88809fa40a1c of 4 bytes by task 11997 on cpu 0:
> > >  cma_check_port+0xbd/0x700 drivers/infiniband/core/cma.c:3506
>
> This has since been fixed, cma_check_port() no longer reads state
>
> > > and on commit 5863cc79:
>
> I can't find this commit? Current rdma_resolve_addr should not trigger
> this KCSAN.
>
> > This does not immediately explain the use-after-free for me, but these
> > races suggest that everything is not protected by a single mutex and
> > that there may be some surprising interleavings.
> > E.g. rdma_resolve_addr checks status, and then conditionally executes
> > cma_bind_addr, but the status can change concurrently.
>
> It is true, they weren't, however I've fixed them all. These hits look
> like they all from before it got fixed up..

Then sorry for false leads.
The second commit was from https://github.com/google/ktsan.git kcsan
branch. I am not sure if it's still present or was rebased. But either
way it's even older than the first report on upstream (we used ktsan
tree before switched to upstream).
