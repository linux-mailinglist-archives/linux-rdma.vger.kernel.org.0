Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A227F29AFA
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389292AbfEXP07 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 24 May 2019 11:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389079AbfEXP07 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 11:26:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 899612133D;
        Fri, 24 May 2019 15:26:57 +0000 (UTC)
Date:   Fri, 24 May 2019 11:26:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Roger Willcocks <roger@filmlight.ltd.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190524112656.5ef67c6c@gandalf.local.home>
In-Reply-To: <e4e875f0-2aa5-89f4-f462-78bedb9c5cde@filmlight.ltd.uk>
References: <20190523100013.52a8d2a6@gandalf.local.home>
        <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
        <20190523112740.7167aba4@gandalf.local.home>
        <e4e875f0-2aa5-89f4-f462-78bedb9c5cde@filmlight.ltd.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 24 May 2019 16:11:14 +0100
Roger Willcocks <roger@filmlight.ltd.uk> wrote:

> On 23/05/2019 16:27, Steven Rostedt wrote:
> >
> > I haven't yet tested this, but what about something like the following:
> >
> > ...perhaps forget about the constant check, and just force
> > the power of two check:
> >
> > 							\
> > 	if (!(__y & (__y >> 1))) {			\
> > 		__x = round_up(x, y);			\
> > 	} else {					\  
> 
> You probably want
> 
>             if (!(__y & (__y - 1))
> 
> --

Yes I do. I corrected it in my next email.

 http://lkml.kernel.org/r/20190523133648.591f9e78@gandalf.local.home

> #define roundup(x, y) (					\
> {							\
> 	typeof(y) __y = y;				\
> 	typeof(x) __x;					\
> 							\
> 	if (__y & (__y - 1))				\
> 		__x = round_up(x, __y);			\
> 	else						\
> 		__x = (((x) + (__y - 1)) / __y) * __y;	\
> 	__x;						\
> })


-- Steve
