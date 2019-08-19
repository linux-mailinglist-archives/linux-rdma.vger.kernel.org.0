Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026D5923C3
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfHSMsO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 08:48:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42356 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfHSMsN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 08:48:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so1679556qtp.9
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hXyoRZ/OPmAq/R4IK4XmSNA41I7f27DhaRkpyRMhg58=;
        b=lidxZ2MXn47FztqFjEgPtoaIbGo84krWKNVjd3JtBPo+h1ghZ2rmWTkyYtbQsdbuwr
         +toLRp972QCHnAHSKOXQQJq0DjB4bIu4qWTa8ekqCwats6XiYNOXLnEpeo4+8WyN6s64
         zY0qiU2KjYk/T5k5urNZzuRMx4/ZPFQguHdNMlUWsItA90H36J5XDcSFnzLra9odWheX
         A/OVoHHIQCfrwGP/tjuoAigul15vQmADhyVcn/Lgo9i1KY8a5qcJMwaGvV90XodBBbcm
         fNGpu/MG0PcOYA2Am50r1B71CavmdNqINvwHqzNNstlmZLXT8vpkdIKCgALl2jozc2tg
         7/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hXyoRZ/OPmAq/R4IK4XmSNA41I7f27DhaRkpyRMhg58=;
        b=EJEJCWNfUmOJeuG1Ha0bbxKR+/2TqfIfZ+9d705Urt6RBNj+uDPIP+jwHqsb+ygsfB
         5oY3bMPUAQRLknid4MpJNpWaDY/garQTG/B3k1OoCGpGO7DdkIO2P1gZvU06C7Z2QUo0
         wL4le+7dgtgAsSktVEvg26f0Q/NGY9Utd4H69qP1gBExTsqaAa8x32zcnm8jdNwWlLC5
         4CZ+VoHxsENnevUeURGT6r8O3je/NW8Sp4DT1/4Xd1XS+38qpgWM0SJLlAhOBSHAe4Bq
         Pqdm1uqSb/39tnsOk+YGAefGEz/0e7weBF6FUmaAreFyYhX0R38oOkANarnbyspKreps
         kBog==
X-Gm-Message-State: APjAAAXkrSybTYR88J5q2IfXVk+Ejuhyeo962qPa7OWUCDZMzXqrj5d9
        FImxvNUCrFMTYVpAn6SyF6g1iw==
X-Google-Smtp-Source: APXvYqy7aCLh6WGLgVmnufSp70AR7mV5J6qZ4tsYBojKgTie3aIxuM1zJr3WJjyGchEwwHwDNtoWjQ==
X-Received: by 2002:ac8:3449:: with SMTP id v9mr20742232qtb.163.1566218892797;
        Mon, 19 Aug 2019 05:48:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p23sm6841460qke.44.2019.08.19.05.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 05:48:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzh51-00024M-S4; Mon, 19 Aug 2019 09:48:11 -0300
Date:   Mon, 19 Aug 2019 09:48:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PULL REQUEST] Please pull rdma.git
Message-ID: <20190819124811.GE5058@ziepe.ca>
References: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
 <CAMuHMdWp+g-W0rJtVTWEiJpbhcV7GoSkub11fZPMUbhJcxMUNA@mail.gmail.com>
 <20190819121400.GA5058@ziepe.ca>
 <CAMuHMdWbG0G8cK-Y0A+STRaJLYzsGHA9V1jJZsjddejxQ-qwcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWbG0G8cK-Y0A+STRaJLYzsGHA9V1jJZsjddejxQ-qwcg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 02:29:46PM +0200, Geert Uytterhoeven wrote:
> Hi Jason,
> 
> On Mon, Aug 19, 2019 at 2:14 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Mon, Aug 19, 2019 at 12:08:16PM +0200, Geert Uytterhoeven wrote:
> > > On Wed, Aug 14, 2019 at 5:00 PM Doug Ledford <dledford@redhat.com> wrote:
> > > > Fairly small pull request for -rc3.  I'm out of town the rest of this
> > > > week, so I made sure to clean out as much as possible from patchworks in
> > > > enough time for 0-day to chew through it (Yay! for 0-day being back
> > > > online! :-)).  Jason might send through any emergency stuff that could
> > > > pop up, otherwise I'm back next week.
> > > >
> > > > The only real thing of note is the siw ABI change.  Since we just merged
> > > > siw *this* release, there are no prior kernel releases to maintain
> > > > kernel ABI with.  I told Bernard that if there is anything else about
> > > > the siw ABI he thinks he might want to change before it goes set in
> > > > stone, he should get it in ASAP.  The siw module was around for several
> > > > years outside the kernel tree, and it had to be revamped considerably
> > > > for inclusion upstream, so we are making no attempts to be backward
> > > > compatible with the out of tree version.  Once 5.3 is actually released,
> > > > we will have our baseline ABI to maintain.
> > >
> > > [...]
> > >
> > > > - Allow siw to be built on 32bit arches (siw, ABI change, but OK since
> > > >   siw was just merged this merge window and there is no prior released
> > > >   kernel to maintain compatibility with and we also updated the
> > > >   rdma-core user space package to match)
> > >
> > > > Bernard Metzler (1):
> > > >       RDMA/siw: Change CQ flags from 64->32 bits
> > >
> > > Obviously none of this was ever compiled for a 32-bit platform?!?
> >
> > It is puzzling that 0-day or anyone testing linux-next hasn't noticed
> > this in that last 7 weeks are so..
> 
> Fair enough. The autobuilders have become a bit overloaded lately.
> 
> Still, I would expect a commit that makes a last-minute ABI change to
> enable support for 32-bit platforms, to actually compile cleanly on
> these 32-bit platforms.
> To me, this looks like a big red flag...

Again, I don't know why 0-day didn't report anything. I have success
logs from it saying it compiled a tree including siw on i386
allmodconfig - I don't know why you are seeing 32 bit warnings when
0-day is not reporting anything.

Jason
