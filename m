Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0128460
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfEWQ5f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 12:57:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34630 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfEWQ5f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 12:57:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so6167375ljg.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ks/LH2oyTEaijoOzEMOK4qT05od1mgbLgD6IvZvC3ac=;
        b=UrcFcbzEFPGggz1NPXakVDUiIg5mDqTO4045eBb7udfHenM+Veb+rBZ0tlbryVNdJc
         qa5A4P3tgF5XCLb7D69n65wDt2yEO3fr0UKE7SehnvIvMriAPEG9xpGYM5u8gpQLeOdX
         1vpQBx74HKkfDoRasFV6IFoGOt3sYNk7jzZac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ks/LH2oyTEaijoOzEMOK4qT05od1mgbLgD6IvZvC3ac=;
        b=XfiiNj3jQxxYOq7jxMlBLvUgqlJ0frOU6nH6Qhmkuypc8Xj0jLBKRFvCUPk1gXnfdy
         pD34O5lO9QOjOyJX8fSLmvfp3wqiXpXYtS3jZ05LbFZ1JPsqNGKmWlsEsEW//UezxWF9
         sOdAiyznMSm+a+ss7Cez5CbGCgISZYMwr3ca+oN0pkDy9HuRE/r6/+WHxGFHblClXg23
         +zVoJFUBKkhgqQVhC7BeAB85MqYBb7VvdT0bh0h4OTV+octhydd1ojl7rnupAlO6GvX1
         oGrtpCkENjjSpyWbjDoinKKPo1GU26RO6OBGge0Bt3OKj91GurnCYi2b1FDL/dFKbduS
         5xWg==
X-Gm-Message-State: APjAAAXL46Qazpj2i+k4Xa3rUNGneixnfpx9bueiwtv1QASRFyFgBI3r
        kvCz7Fd2jqpmZNJ2p0YIEg1ySCcxCM0=
X-Google-Smtp-Source: APXvYqzHDtSwbdTPuDhLnkymWOZO/IxWLebUT+lBlbRsIdvzmdxWRadBfj+qqhL+qtmxbk1GXVXdAg==
X-Received: by 2002:a2e:824d:: with SMTP id j13mr4889172ljh.137.1558630307669;
        Thu, 23 May 2019 09:51:47 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y4sm2528lje.24.2019.05.23.09.51.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:51:46 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h13so4915228lfc.7
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 09:51:46 -0700 (PDT)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr41221787lfc.54.1558630305849;
 Thu, 23 May 2019 09:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190523100013.52a8d2a6@gandalf.local.home> <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
 <20190523112740.7167aba4@gandalf.local.home>
In-Reply-To: <20190523112740.7167aba4@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 May 2019 09:51:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFJqTOk0mSxJGeh38ZxDksgRaMrNV8hqTngiuokyJzew@mail.gmail.com>
Message-ID: <CAHk-=whFJqTOk0mSxJGeh38ZxDksgRaMrNV8hqTngiuokyJzew@mail.gmail.com>
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 8:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I haven't yet tested this, but what about something like the following:

So that at least handles the constant case that the normal "roundup()"
case also handles.

At the same time, in the case you are talking about, I really do
suspect that we have a (non-constant) power of two, and that you
should have just used "round_up()" which works fine regardless of
size, and is always efficient.

On a slight tangent.. Maybe we should have something like this:

#define size_fn(x, prefix, ...) ({                      \
        typeof(x) __ret;                                \
        switch (sizeof(x)) {                            \
        case 1: __ret = prefix##8(__VA_ARGS__); break;  \
        case 2: __ret = prefix##16(__VA_ARGS__); break; \
        case 4: __ret = prefix##32(__VA_ARGS__); break; \
        case 8: __ret = prefix##64(__VA_ARGS__); break; \
        default: __ret = prefix##bad(__VA_ARGS__);      \
        } __ret; })

#define type_fn(x, prefix, ...) ({                              \
        typeof(x) __ret;                                        \
        if ((typeof(x))-1 > 1)                                  \
                __ret = size_fn(x, prefix##_u, __VA_ARGS__);    \
        else                                                    \
                __ret = size_fn(x, prefix##_s, __VA_ARGS__);    \
        __ret; })

which would allow typed integer functions like this. So you could do
something like

     #define round_up(x, y) size_fn(x, round_up_size, x, y)

and then you define functions for round_up_size8/16/32/64 (and you
have toi declare - but not define - round_up_sizebad()).

Of course, you probably want the usual "at least use 'int'" semantics,
in which case the "type" should be "(x)+0":

     #define round_up(x, y) size_fn((x)+0, round_up_size, x, y)

 and the 8-bit and 16-bit cases will never be used.

We have a lot of cases where we end up using "type overloading" by
size. The most explicit case is perhaps "get_user()" and "put_user()",
but this whole round_up thing is another example.

Maybe we never really care about "char" and "short", and always want
just the "int-vs-long-vs-longlong"? That would make the cases simpler
(32 and 64). And maybe we never care about sign. But we could try to
have some unified helper model like the above..

                  Linus
