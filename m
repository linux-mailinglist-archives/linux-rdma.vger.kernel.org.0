Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8312F28504
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfEWRgw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 13:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731037AbfEWRgw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 13:36:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C892133D;
        Thu, 23 May 2019 17:36:50 +0000 (UTC)
Date:   Thu, 23 May 2019 13:36:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
Message-ID: <20190523133648.591f9e78@gandalf.local.home>
In-Reply-To: <CAHk-=whFJqTOk0mSxJGeh38ZxDksgRaMrNV8hqTngiuokyJzew@mail.gmail.com>
References: <20190523100013.52a8d2a6@gandalf.local.home>
        <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
        <20190523112740.7167aba4@gandalf.local.home>
        <CAHk-=whFJqTOk0mSxJGeh38ZxDksgRaMrNV8hqTngiuokyJzew@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 23 May 2019 09:51:29 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, May 23, 2019 at 8:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I haven't yet tested this, but what about something like the following:  
> 
> So that at least handles the constant case that the normal "roundup()"
> case also handles.
> 
> At the same time, in the case you are talking about, I really do
> suspect that we have a (non-constant) power of two, and that you
> should have just used "round_up()" which works fine regardless of
> size, and is always efficient.

I think you are correct in this.

       act_size = roundup_64(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));

Where we have:

#define MLX5_SW_ICM_BLOCK_SIZE(dev) (1 << MLX5_LOG_SW_ICM_BLOCK_SIZE(dev))

Which pretty much guarantees that it is a power of two. Thus, the real
fix here is simply to s/roundup/round_up/ as you suggest.

> 
> On a slight tangent.. Maybe we should have something like this:
> 
> #define size_fn(x, prefix, ...) ({                      \
>         typeof(x) __ret;                                \
>         switch (sizeof(x)) {                            \
>         case 1: __ret = prefix##8(__VA_ARGS__); break;  \
>         case 2: __ret = prefix##16(__VA_ARGS__); break; \
>         case 4: __ret = prefix##32(__VA_ARGS__); break; \
>         case 8: __ret = prefix##64(__VA_ARGS__); break; \
>         default: __ret = prefix##bad(__VA_ARGS__);      \
>         } __ret; })
> 
> #define type_fn(x, prefix, ...) ({                              \
>         typeof(x) __ret;                                        \
>         if ((typeof(x))-1 > 1)                                  \
>                 __ret = size_fn(x, prefix##_u, __VA_ARGS__);    \
>         else                                                    \
>                 __ret = size_fn(x, prefix##_s, __VA_ARGS__);    \
>         __ret; })
> 
> which would allow typed integer functions like this. So you could do
> something like
> 
>      #define round_up(x, y) size_fn(x, round_up_size, x, y)
> 
> and then you define functions for round_up_size8/16/32/64 (and you

You mean define functions for round_up_size_{u|s}8/16/32/64

> have toi declare - but not define - round_up_sizebad()).
> 
> Of course, you probably want the usual "at least use 'int'" semantics,
> in which case the "type" should be "(x)+0":
> 
>      #define round_up(x, y) size_fn((x)+0, round_up_size, x, y)
> 
>  and the 8-bit and 16-bit cases will never be used.

I'm curious to what the advantage of that is?

> 
> We have a lot of cases where we end up using "type overloading" by
> size. The most explicit case is perhaps "get_user()" and "put_user()",
> but this whole round_up thing is another example.
> 
> Maybe we never really care about "char" and "short", and always want
> just the "int-vs-long-vs-longlong"? That would make the cases simpler
> (32 and 64). And maybe we never care about sign. But we could try to
> have some unified helper model like the above..

It may be simpler and perhaps more robust if we keep the char and short
cases.

I'm fine with adding something like this for round_up(), but do we want
to have a generic roundup_64() as well? I'm also thinking that we
perhaps should test for power of two on roundup():

#define roundup(x, y) (					\
{							\
	typeof(y) __y = y;				\
	typeof(x) __x;					\
							\
	if (__y & (__y - 1))				\
		__x = round_up(x, __y);			\
	else						\
		__x = (((x) + (__y - 1)) / __y) * __y;	\
	__x;						\
})


-- Steve
