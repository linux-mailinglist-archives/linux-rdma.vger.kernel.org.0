Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142BD390443
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 16:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhEYOr5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhEYOr5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 10:47:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F7C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 07:46:27 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s19so30491814oic.7
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TtKcDXGn0/PIFaGd43L//NEZox84UcYdC/KmhkMuiI=;
        b=ampB2OgbjOnweRapUfR0955mCEgZ14wHIYu0RbgyzKgJht8NAk3SRP517+csHWmmA4
         9BAZkJUMmh1/1WXk4nYrIbGpkl8oAML5rrjVaef+w79WXOepDE6Jpi5jSSjQaDA5ICHz
         TXxCTJg5gbGotA90zBfQuUJaFiFku2yJ0ED/TUSd9nki7VumuoQLfo1ImP0vk+9cb6NW
         +xpjMRmnuvZ1vtnotMmg9RMTRm6xDYNmcUKrngfcoMtkk0hFwD0CdHF5qqBJGWF34NMf
         nryqFc1SRoI/ftzSHrY18ccpZNC5142O6NWYKCBlhb1Rj5Wa7k6aG4bJvz3c/YbqqMMp
         F1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TtKcDXGn0/PIFaGd43L//NEZox84UcYdC/KmhkMuiI=;
        b=V7c10i854pV+44nDoL/p1ZiviPlNzNKXLvDr/xzpfbB+SWMbUONcmFDQZNX2FZwvKi
         0Dxd7U4pDAofv19x+2K6bK4QGuVzmwSMsNyJ7WqQXKBlTY5ogYewKGwYyZ77MeIeCiPL
         kjgTOqINy6wGNdBEtjbqTP2xRmzbuiSQx/Q2wXC93Z+JZKs+tiDqZ0iquz0JK/ZK0d97
         6sJfcJZGmoV5vqUeC3n7Ep3tT67t4PkM31/cZyMzDHAGCFhqwc19I0eA3Xar7lRCdmn6
         XdDgTfd5Sw1k/B1rFKcC+ZqXi8UyvINplhZ0gkp+EBkxO66wozNklown4QgMOmM7Enma
         aBLg==
X-Gm-Message-State: AOAM532rch/8Yc8jOmoMPgenvrPMQuH+1XieU79RfDtFcetBc8STJtQO
        Wi48//3HfHxnqZ4cwzLJMyxwRlvIwLbml4WMmDY=
X-Google-Smtp-Source: ABdhPJzH+6G98qH7eoxMtlsAr4YNM7rYoB4eC3aZsvf/Xc/QmfKOpqP2ruj5IJ1cETZ/Xn3MSxKUpZzNZMQEPb1gxyI=
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr2927153oib.163.1621953986843;
 Tue, 25 May 2021 07:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210525223222.17636-1-yanjun.zhu@intel.com> <20210525131837.GV1002214@nvidia.com>
 <CAD=hENcQBGST3VzusRQ4V51PbzLMPgHQj0QCbqMwSUNe_ajrNA@mail.gmail.com>
In-Reply-To: <CAD=hENcQBGST3VzusRQ4V51PbzLMPgHQj0QCbqMwSUNe_ajrNA@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 25 May 2021 22:46:15 +0800
Message-ID: <CAD=hENfTghNyU80kJP0703V+geaxf9UrN1yZB+J9Qtw0Qz8iow@mail.gmail.com>
Subject: Re: [PATCH 1/1] Update kernel headers
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 9:56 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 9:18 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, May 25, 2021 at 06:32:22PM -0400, Zhu Yanjun wrote:
> > > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> > >
> > > After the patches "RDMA/rxe: Implement memory windows", the kernel headers
> > > are changed. This causes about 17 errors and 1 failure when running
> > > "run_test.py" with rxe.
> > > This commit will fix these errors and failures.
> > >
> > > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > > ---
> > >  kernel-headers/rdma/rdma_user_rxe.h | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> >
> > Huh? Bob? You can't break the rxe uapi??
> >
> > > diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> > > index 068433e2..90ea477f 100644
> > > --- a/kernel-headers/rdma/rdma_user_rxe.h
> > > +++ b/kernel-headers/rdma/rdma_user_rxe.h
> > > @@ -99,7 +99,17 @@ struct rxe_send_wr {
> > >                       __u32   remote_qkey;
> > >                       __u16   pkey_index;
> > >               } ud;
> > > +             struct {
> > > +                     __aligned_u64   addr;
> >
> > > +                     __aligned_u64   length;
> >
> > > +                     __u32           mr_lkey;
> > > +                     __u32           mw_rkey;
> >
> > > +                     __u32           rkey;
> > > +                     __u32           access;
> >
> > > +                     __u32           flags;
> > > +             } mw;
> >
> > There is room for 4 u64's in 'reg' and this has 5, so it is a no-go
>
> What is 'reg'? Where is the definition of this 'reg'? What protocol
> has the definition of this 'reg'?

Got it. Please ignore my comments.

Zhu Yanjun

>
> Zhu Yanjun
>
> >
> > Jason
