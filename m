Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A372C29C96
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbfEXQ7U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 12:59:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43538 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390720AbfEXQ7U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 12:59:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so9294045oth.10
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEsvEvFjlwXN7UDcC7wBfcVN0ngYDlTviwk40lFh0VE=;
        b=F+JKEfzZoisl55BG48UjSnmshBQgO9/0HkQVAr6Vyzhbpu8ZE5OYQdCLS2r7gg5Fet
         xsFTm/CY0rb9DvK2SU4u8wLrvEc5OpWNJcfbSDisSY2sMAlLWvWz1GZjZ2H3Uqu7oCCF
         IQMwHXKRFilGrj1cyLDjSwk6YUEP2rgdWgWYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEsvEvFjlwXN7UDcC7wBfcVN0ngYDlTviwk40lFh0VE=;
        b=C/l7opffqByv87U4k+dej6I/+jE5JHTypJxCEN2FgItGzELjLCbTXK+r0X8S00Iz5s
         M3bzN0X5Q9hYi3a9/bx2P68eoT+rvHVE7AvUijwdefzmjDAqO3Gd/cDOuaRjuNyTxoYC
         wNtIhOttvInwk+ao632R+Q74pEqxFz5JR4cHcwZJGB6heYCxuLaXq/gS4VNxPYE4WLQ3
         DhnDjoMebj+FEPzAaeD0IOtNs3gE2uIzudYmsvDXZrf9ZT5+eGCoM3TmuCXhvXGWl1H2
         rL6PRIfDxpkdrms7U5HHSOTbuCdF1VXbaZ5+nqAMYmP/hhbzWFJJ17EDbbxN77vwLTYb
         5Leg==
X-Gm-Message-State: APjAAAVFINr2anHrgHNSIfOhjEhXsfUZNvVSlMqaVc6tiiKDiftXVoiS
        DKg4ld8tnZYvLUILDsEjeo0xeJxxeekoR49Ro7jYYQ==
X-Google-Smtp-Source: APXvYqyPbMvtr56mDew3jzxBkjA+50maDgvK6bd7zBN/VZAbXpM4qVtqYD8AqQh52rPXg2kktDPJwMkBLyw2j0YmSis=
X-Received: by 2002:a05:6830:16d2:: with SMTP id l18mr29769854otr.303.1558717159283;
 Fri, 24 May 2019 09:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190523154149.GB12159@ziepe.ca> <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca> <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca> <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca> <20190524064051.GA28855@infradead.org>
 <20190524124455.GB16845@ziepe.ca> <20190524162709.GD21222@phenom.ffwll.local> <20190524165301.GD16845@ziepe.ca>
In-Reply-To: <20190524165301.GD16845@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 24 May 2019 18:59:07 +0200
Message-ID: <CAKMK7uHODeVX4DHdM-w2xkqCmN71MaQH1ZiRZcPN38Hhy0A-sQ@mail.gmail.com>
Subject: Re: RFC: Run a dedicated hmm.git for 5.3
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 6:53 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, May 24, 2019 at 06:27:09PM +0200, Daniel Vetter wrote:
> > Sure topic branch sounds fine, we do that all the time with various
> > subsystems all over. We have ready made scripts for topic branches and
> > applying pulls from all over, so we can even soak test everything in our
> > integration tree. In case there's conflicts or just to make sure
> > everything works, before we bake the topic branch into permanent history
> > (the main drm.git repo just can't be rebased, too much going on and too
> > many people involvd).
>
> We don't rebase rdma.git either for the same reasons and nor does
> netdev
>
> So the usual flow for a shared topic branch is also no-rebase -
> testing/etc needs to be done before things get applied to it.

Rebasing before it gets baked into any tree is still ok. And for
something like this we do need a test branch first, which might need a
fixup patch squashed in. On the drm side we have a drm-local
integration tree for this stuff (like linux-next, but without all the
other stuff that's not relevant for graphics). But yeah that's just
details, easy to figure out.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
