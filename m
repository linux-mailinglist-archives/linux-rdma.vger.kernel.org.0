Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0479E396C9D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 07:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFAFEj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 01:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAFEi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 01:04:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C29C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 22:02:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce15so383005ejb.4
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qO+nSlQq423rnpBRRS89Gx0gRqi052i5yeWDm/MyYE=;
        b=B+EmmH+yQ4nsvFyrlnmILUyy6st0OHPLBty2n9bC7G234rmUHDnpmF3CuVSvhhD3Vm
         Mq+heuTeQ3dS7eCmNkLfYoPijowtbCQsBMbzbodnMHksVv5dcTcboKoV6BLk4ZiEf+OE
         s7rEYEa04u3AoY/9SIVXUrwxWQgGPpMJoRRxYL8tx3AZ/e9rRLkl+0/b/IBh2/uqz1/G
         BW2IxsvVSNPmUOIsQJC/6iztfeMAdRFBkVGLIk8Pr1r1nW6mdD6vdLt4u0f4pGI84V6i
         yAjxSvz/wyUBZHik5N/msnJjaUgUWTIxVzDIoygg4niZrunekfx291Db6vgTyo67OfVe
         V/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qO+nSlQq423rnpBRRS89Gx0gRqi052i5yeWDm/MyYE=;
        b=HRG4DeZEPYwRqYDQ/DGtyhmX5cACTWCJ0Icw4p5wMbjieTT99JaTx+M1yiN6ZLrtJm
         aUBvH9+plPYg9V1lg1fnnZyj4UZ8nkHbFrNGxt9t+gUA/5XRr2ktYcYs14KjOjIsuxxG
         wTYs0xFvH/H+iphsc02NJkvY929l0lcMH0/7oTcUO2VocsmTMu4OxwMA2EEJNg6sd/kx
         AyiHAFTfusKfZRAiL0rufj2OSZLuCOTVe/Mp0bYYb5UzjVUtffB2kxWs4ISH5xo+lltS
         UJfZJG4NRjMboQZy+/oMCO7jE3PVZfkuRWd7QWw6utRmSiw6dwZw/i5Lacw0Bx0z20Mx
         Y6aA==
X-Gm-Message-State: AOAM530b0y1bwt9RqKyhhccoWlmQyG4nLfspoEItOtpY3ryIs3CvL5YV
        6SQq5GN2L+lRlZ1WnmRN2wDhMuEpXoqDK7O3iVxu/w==
X-Google-Smtp-Source: ABdhPJwkfutLoNj0uy92SyPi646rFF7vgEpN4w6BeRqeGa5aHArzPl95uZnTWPCLdA7O+T9p6ouy1kU9wTJAt/BcItQ=
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr12163901ejc.389.1622523776553;
 Mon, 31 May 2021 22:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210531122835.58329-1-jinpu.wang@ionos.com> <20210531184331.GL1096940@ziepe.ca>
In-Reply-To: <20210531184331.GL1096940@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 1 Jun 2021 07:02:45 +0200
Message-ID: <CAMGffEni4N-jF+mH1fysVRgJreYxvSDSfpAhrNvWGnoA_5qKdA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Avoid Wtautological-constant-out-of-range-compare
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 8:43 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, May 31, 2021 at 02:28:35PM +0200, Jack Wang wrote:
> > drivers/infiniband/ulp/rtrs/rtrs-clt.c:1786:19: warning: result of comparison of
> > constant 'MAX_SESS_QUEUE_DEPTH' (65536) with expression of type 'u16'
> > (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
> >
> > To fix it, limit MAX_SESS_QUEUE_DEPTH to u16 max, which is 65535, and
> > drop the check in rtrs-clt, as it's the type u16 max.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 -----
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 4 ++--
> >  2 files changed, 2 insertions(+), 7 deletions(-)
>
> I kept the patch as is since the first hunk gets wonky conflicts if it
> is squashed
>
> Jason
Thanks!
