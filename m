Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF09F50D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfH0V1T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 17:27:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43817 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0V1T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 17:27:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so210845pfn.10
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dORKsa24CPlzONt8GkpEJmy5cgog5+v4B7b48TayOmE=;
        b=nlkQCqlrck9aDbUTfU3CWlCdu6TLRNvsh6KR2X92W6GvTwR6AqAinXCIHSB/UnnGrY
         SajnEjW0Tqve6lhnOdFa7OmT77RqUHoR3wCizuIHkWEqX2Zeo5GrV8nfKkzDr5pIV2NQ
         I/u7CLOKjWvEzDKRiqf244odsk1Wk1txvu+pClpOoD/WVwg95z5zckHo2tT84zGTo5Gg
         iBQr442MHY57rvvFnhoY5hPjaIh4hmgg3rCecQTiZaT6npNhGIy1qPZiu+Z0j/KnjqyU
         4/wdx6qjtdWPYY6QC2fyxg3tKFqsjA9iAlojGPL/San5FlIV6cCMHq9271ZuTWgrcKTS
         6ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dORKsa24CPlzONt8GkpEJmy5cgog5+v4B7b48TayOmE=;
        b=AB3AisTb+yPHgH/KYbTg56ElTFKFn/LRWTkrMYTLZeWxLRr0TRjA/U2o+IwNIlCmtA
         Ux8jtMxmdUW1uwCZMHTpsSkC6JjT1GCntEVBmyR6fym8tmRl9EDRJkD33PZx1Li0Jc/W
         VIidS/yOBTyiquJNAsBwUj8Msz7dFtmt/4ZGHGjlqd/SNXXuPsuwcB/t+DVnJc8Nlwbk
         8o3xPUgTXxUD8iM3rYulEByoaCjyo7F6TOQ7gce2pU8MfJn1We3g7XL7M0nyNc/WUclj
         /4jEYjNpm/q8SB05S8UX6R7R6esICOoV09xOsOAjE9RD5kOU2GUbSyz+Wyh4dIzxeGuQ
         5bGw==
X-Gm-Message-State: APjAAAV0MvM3yb4MTdzmMos3kULSW17OQHChC6Lswszi4SRCDVAHOKD0
        bSzZ0FeNTeB0J+5i9u2lupAlJiCHcdOdAsa86cF1gV+a/dH7yg==
X-Google-Smtp-Source: APXvYqzG090bvyFL/VemnFAypRwAgpOeNcqIVdhr0dWYTGUxFKJSzWYN8aOqtHpECNarsykUq6u7+WhmUbnbVtmXcJA=
X-Received: by 2002:a63:60a:: with SMTP id 10mr432471pgg.381.1566941237865;
 Tue, 27 Aug 2019 14:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190711133915.GA25807@ziepe.ca> <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca> <20190711173030.GA844@archlinux-threadripper>
 <20190823142427.GD12968@ziepe.ca> <20190826153800.GA4752@archlinux-threadripper>
 <20190826154228.GE27349@ziepe.ca> <20190826233829.GA36284@archlinux-threadripper>
 <20190827150830.brsvsoopxut2od66@treble> <20190827170018.GA4725@mtr-leonro.mtl.com>
 <20190827192344.tcrzolbshwdsosl2@treble>
In-Reply-To: <20190827192344.tcrzolbshwdsosl2@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Aug 2019 14:27:06 -0700
Message-ID: <CAKwvOdk3UTT5jUTuG_wRizdpUtgv3qFB3w3NCtJ7ub5DnptYRA@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 12:23 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Aug 27, 2019 at 08:00:18PM +0300, Leon Romanovsky wrote:
> > On Tue, Aug 27, 2019 at 10:08:30AM -0500, Josh Poimboeuf wrote:
> > > On Mon, Aug 26, 2019 at 04:38:29PM -0700, Nathan Chancellor wrote:
> > > > Looks like that comes from tune_qsfp, which gets inlined into
> > > > tune_serdes but I am far from an objtool expert so I am not
> > > > really sure what kind of issues I am looking for. Adding Josh
> > > > and Peter for a little more visibility.
> > > >
> > > > Here is the original .o file as well:
> > > >
> > > > https://github.com/nathanchance/creduce-files/raw/4e252c0ca19742c90be1445e6c722a43ae561144/rdma-objtool/platform.o.orig
> > >
> > >      574:       0f 87 00 0c 00 00       ja     117a <tune_serdes+0xdfa>
> > >
> > > It's jumping to la-la-land past the end of the function.
> >
> > How is it possible?
>
> Looks like a compiler bug.

Nathan,
Thanks for the reduced test case.  I modified it slightly:
https://godbolt.org/z/15xejg

You can see that the label LBB0_5 seemingly points off into space.
Let me play with this one more a bit, then I will file a bug and
report back.
-- 
Thanks,
~Nick Desaulniers
