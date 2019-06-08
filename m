Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27239A01
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 03:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfFHBP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 21:15:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42939 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbfFHBP0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 21:15:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so4417910qtk.9
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 18:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h6Z9rr6zGxumR/45vmaME9IJ083vX8f0km+kn2uW+c8=;
        b=bRrQYKB2zE6/wWU/OjS2kqvu2AoxAnZ/cCuCgPmbOeWj+HhbWbKLaCaogL0rqmZe0R
         BtruNkxj/Zi/NgK7luDutuRW7H758gt9Eu6yTyut/4xnbnV7w3i473DBuvfoey1s+Ay5
         XmK6BJ9hHcTUZl8lDhdBJ2IGvsrZUQbNiv03egVplE5XTDlTBUMw8lj/AuEbwkeC1oeK
         YAnG/BpSduK8thlJPaUbYi8ZQC2H3u8Rg78tXDXasJ0Kh/NDiNEG3VMZKRfJqN2PpXZr
         jtsX+FFxZSKZrB8lKqNa9CPoPomNmQIdreS92pKoIQ9qgTGc0r+xReuWGWSNMTsCofLP
         CCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h6Z9rr6zGxumR/45vmaME9IJ083vX8f0km+kn2uW+c8=;
        b=k3ifRB15UewghV5hnJZmTsQ5lAYb6vVb07v6XU606dPpGZ7mGcbSLaVPQcidmx15yz
         huGV3fPH+B6JX8y9U0LCCyJX+bJS5Eg2megx4sxkcbJp1Q3yTu2YLUn2b4ZOlih/LDW2
         U7JU6fLR/znmsO2bGdfbXaLKY4NPkNclU8WWIO3/HUSGYFxPUMBw4xfvvJnG8DM+7KXm
         KWdkJ0d2uHuAEpbtOootazi7a4ll8Rmf/++XDRY/Ti+1Cd86Yy46WjOH3RYDL6ZNcXFz
         Y0Qigxd1NvBFU2VfGVjV3ISt6QHAB1ksvAEytXKd28qJ7h3AltDKYJHmZKBCksh33N9J
         H6+g==
X-Gm-Message-State: APjAAAXqW6pIcslrIusWJLsrJu0rFCOZJg0EuGeL+O/JGvfNkLxp0CLF
        EKZ1b/7/tnRqECWHKArQ9/Lv+g==
X-Google-Smtp-Source: APXvYqxlijcObZVobH5DV858Z4pTZYEKltcFNld56zqPC5gVgwHJRZ7Ay2DmCcFxie8ytW1foI+w9w==
X-Received: by 2002:ac8:2d69:: with SMTP id o38mr35025897qta.169.1559956525671;
        Fri, 07 Jun 2019 18:15:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f34sm2160045qta.19.2019.06.07.18.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 18:15:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZPx6-00023t-KY; Fri, 07 Jun 2019 22:15:24 -0300
Date:   Fri, 7 Jun 2019 22:15:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 08/11] mm/hmm: Use lockdep instead of comments
Message-ID: <20190608011524.GA7844@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-9-jgg@ziepe.ca>
 <CAFqt6zakL282X2SMh7E9kHDLnT9nW5ifbN2p1OKTXY4gaU=qkA@mail.gmail.com>
 <20190607193955.GT14802@ziepe.ca>
 <CAFqt6zZbQmPq=v9xtgHfc5QCy4Vk8pjWgTOY0+TyFgHmEnWTsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZbQmPq=v9xtgHfc5QCy4Vk8pjWgTOY0+TyFgHmEnWTsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 02:32:23AM +0530, Souptick Joarder wrote:
> On Sat, Jun 8, 2019 at 1:09 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sat, Jun 08, 2019 at 01:03:48AM +0530, Souptick Joarder wrote:
> > > On Thu, May 23, 2019 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > >
> > > > So we can check locking at runtime.
> > > >
> > > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > > >  mm/hmm.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/hmm.c b/mm/hmm.c
> > > > index 2695925c0c5927..46872306f922bb 100644
> > > > +++ b/mm/hmm.c
> > > > @@ -256,11 +256,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
> > > >   *
> > > >   * To start mirroring a process address space, the device driver must register
> > > >   * an HMM mirror struct.
> > > > - *
> > > > - * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
> > > >   */
> > > >  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
> > > >  {
> > > > +       lockdep_assert_held_exclusive(mm->mmap_sem);
> > > > +
> > >
> > > Gentle query, does the same required in hmm_mirror_unregister() ?
> >
> > No.. The unregistration path does its actual work in the srcu
> > callback, which is in a different context than this function. So any
> > locking held by the caller of unregister will not apply.
> >
> > The hmm_range_free SRCU callback obtains the write side of mmap_sem to
> > protect the same data that the write side above in register is
> > touching, mostly &mm->hmm.
> 
> Looking into https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/tree/?h=hmm,
> unable trace hmm_range_free(). Am I looking into correct tree ?

The cover letter for the v2 posting has a note about the git tree for
this series:

https://github.com/jgunthorpe/linux/tree/hmm

The above rdma.git is only for already applied patches on their way to
Linus. This series is still in review.

Thanks,
Jason
