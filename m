Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB511A0F59
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgDGOfc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 10:35:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34129 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgDGOfc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Apr 2020 10:35:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id i186so1841915qke.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2020 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y4xgURPmRjyibn/2qSCq97LYNObKcToBBtf2Gfwy2qo=;
        b=Yiz1k2a+d2vyPRjl1p6OB1s3oRmhJRa5DG4YZ0H+AUV/Saew9NegKF2jh3r9qjam78
         eeCCWMtYLfMCzWLSg34uIuIw/eM9kAT3TyDKzV1z12eiQSGmu9bfWj0DNIzs8Dh4Dhkt
         IiAOSad+g2vsRib0Yzm63lmrmtW2zEryv/nfJH+nGBiOgdmVgieyrwDVT8ifojzyHprH
         UE2SQ7lFdx+OXV8o1S8lPdxxByTJoRk5+9ziWySKynVZT45eG7mLsPbiIWGApTgi0bFx
         eGhKgqlK6SmCr/aq00Z8LaHBayOZZIOFH8bSxVwKxfumKLVY6ImglmWKO/aK1QgP9sPl
         Cigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y4xgURPmRjyibn/2qSCq97LYNObKcToBBtf2Gfwy2qo=;
        b=E+WcQdtkOMmcmuK5lE9jxs5uZ4WN6IEiyddnxRRdAds3+67GQwhd9e+fZXzSMHXaRv
         NllheLFfjeOlez53ycd9vriZn+gMLfqdBBvhMuPj6rOdsYA7J8BBPgIWHyxbmD6dFlfJ
         pqC32yg89p5SkkuueQfnpP511qByWVDnE0rrqNE6n/b7iUjxee/OjZwxY4vlxUJX+9As
         fUQZO3YirAL8gQVvmaU1ayF3Vhh/S4hWzpeOnsgqojI4dGRmCqb1QRZ6FrZfCqupYOlu
         lqt5fIwvs1DGde9f0tAxucFckT6SLcFYwH2p5iJu4aLQk9StgBBikHH82etf3CtXzkBn
         C36g==
X-Gm-Message-State: AGi0PuZHQjD2iS8O0Qy/ra0hYgkUFw3i4eyrKseWumV1FylUO6v++C8Z
        HDwrToDOXKddRDC3IAoL2F5F3w==
X-Google-Smtp-Source: APiQypKmGGXSajztBQhxLq8UQIvrySAvflfXyKfiybSPc1r2BxzTEDdWHUHv27/JoHEv5QYkPHlEVQ==
X-Received: by 2002:a37:4b97:: with SMTP id y145mr2601556qka.167.1586270129635;
        Tue, 07 Apr 2020 07:35:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 60sm16925154qtb.95.2020.04.07.07.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 07:35:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jLpK4-0000lj-Ij; Tue, 07 Apr 2020 11:35:28 -0300
Date:   Tue, 7 Apr 2020 11:35:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        syzbot <syzbot+9627a92b1f9262d5d30c@syzkaller.appspotmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in ib_umad_kill_port
Message-ID: <20200407143528.GV20941@ziepe.ca>
References: <00000000000075245205a2997f68@google.com>
 <20200406172151.GJ80989@unreal>
 <20200406174440.GR20941@ziepe.ca>
 <CACT4Y+Zv_WXEn6u5a6kRZpkDJnSzeGF1L7JMw4g85TLEgAM7Lw@mail.gmail.com>
 <20200407115548.GU20941@ziepe.ca>
 <CACT4Y+Zy0LwpHkTMTtb08ojOxuEUFo1Z7wkMCYSVCvsVDcxayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zy0LwpHkTMTtb08ojOxuEUFo1Z7wkMCYSVCvsVDcxayw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 07, 2020 at 02:39:42PM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 7, 2020 at 1:55 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Apr 07, 2020 at 11:56:30AM +0200, Dmitry Vyukov wrote:
> > > > I'm not sure what could be done wrong here to elicit this:
> > > >
> > > >  sysfs group 'power' not found for kobject 'umad1'
> > > >
> > > > ??
> > > >
> > > > I've seen another similar sysfs related trigger that we couldn't
> > > > figure out.
> > > >
> > > > Hard to investigate without a reproducer.
> > >
> > > Based on all of the sysfs-related bugs I've seen, my bet would be on
> > > some races. E.g. one thread registers devices, while another
> > > unregisters these.
> >
> > I did check that the naming is ordered right, at least we won't be
> > concurrently creating and destroying umadX sysfs of the same names.
> >
> > I'm also fairly sure we can't be destroying the parent at the same
> > time as this child.
> >
> > Do you see the above commonly? Could it be some driver core thing? Or
> > is it more likely something wrong in umad?
> 
> Mmmm... I can't say, I am looking at some bugs very briefly. I've
> noticed that sysfs comes up periodically (or was it some other similar
> fs?). 

Hmm..

Looking at the git history I see several cases where there are
ordering problems. I wonder if the rdma parent device is being
destroyed before the rdma devices complete destruction?

I see the syzkaller is creating a bunch of virtual net devices, and I
assume it has created a software rdma device on one of these virtual
devices.

So I'm guessing that it is also destroying a parent? But I can't guess
which.. Some simple tests with veth suggest it is OK because the
parent is virtual. But maybe bond or bridge or something?

The issue in rdma is that unregistering a netdev triggers an async
destruction of the RDMA devices. This has to be async because the
netdev notification is delivered with RTNL held, and a rdma device
cannot be destroyed while holding RTNL.

So there is a race, I suppose, where the netdev can complete
destruction while rdma continues, and if someone deletes the sysfs
holding the netdev before rdma completes, I'm going to guess, that we
hit this warning?

Could it be? I would love to know what netdev the rdma device was
created on, but it doesn't seem to show in the trace :\ 

This theory could be made more likely by adding a sleep to
ib_unregister_work() to increase the race window - is there some way
to get syzkaller to search for a reproducer with that patch?

Jason
