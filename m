Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA02B35C6C0
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhDLMy0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbhDLMy0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 08:54:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D9C061574
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 05:54:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v6so18802525ejo.6
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETkXhCFLSt//E9J8zj5uP5vabpPEHIxG4ZTvXxr4d6M=;
        b=WJ400g0zeAMlqhgqwzhwhvHop3rZXxQI/rl/ggdHecZCrsTfHL/nbU1nlcc++dyOGt
         Rchj+YfAIFiq9U0Sr+HfVqsQeWvSqvXUAxc9zq4N8cZweswprHFfllpDYJYF4I8bSGpS
         gnPI2w5lDSpKjYOU4QQl7HiHLcgVbxQNiUgy942Ff5lmm9Dk2JghsLMtIgLYE2TcKer2
         V+CPuBBOM1u4JvyMjPU3gIAkk8LWvHVW92R9NEkgUbU80XzY+Bp2MPNcxOc4wAZJdo8r
         5fVGMTf0i66A1wZpT0XiVkkMuRahj78HR8oXyTFthEWAD73jIhH1O8yU73/uugYNGHO/
         97WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETkXhCFLSt//E9J8zj5uP5vabpPEHIxG4ZTvXxr4d6M=;
        b=aN9cSinP8FIz9WTpg1MM3hB+5lZST3dNFZKHBVjrqFBJf2snjaZOQAQ/ZQdeSbatgt
         QqGKY5nFGWsCHfAwZJnoAAP+rcheTwOiXqsgMGM5vGCZrP3x1da1p8U4FyBCJkAF9Wqd
         Os8kWKUvLGWTXLm9/xEhxLu5ewwbuBF0rd9px1saXpB6MtO+8AEGkF3ECFkHOjrkQGhE
         Nxel2APh/MkVVpwVrznt7Mg4/52GE7Hbv3PvERWgKyD6GT4z39rehXqynBwJV5zUBQmU
         jeAuWpRpv4ypEPpZoyNfPFDPAYtMWswqQXGLa16lKBdLHIrh9ai0SH2RcH6tAEZcHdRi
         tpmg==
X-Gm-Message-State: AOAM533eL3KAiUXd2paABCqXPeLb4fujsJaUeS5GYR4dKN0zJc9FBNC+
        BSTzFWo1kK7M+x+7pOH3ITGiGljrwNrxxOxj0vqHzw==
X-Google-Smtp-Source: ABdhPJz0zoFeDG3d1Asfd0F7CI2xPrm+YW9NOrVpoF4jqz+QqXtTg3dOUEQ4wQYOPvU4FftD/8yQ+OKIpKuh/GkPlek=
X-Received: by 2002:a17:906:c04a:: with SMTP id bm10mr8654645ejb.521.1618232046504;
 Mon, 12 Apr 2021 05:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210406123639.202899-1-gi-oh.kim@ionos.com> <20210406123639.202899-2-gi-oh.kim@ionos.com>
 <YGxXD/TODlXHp2sK@unreal> <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
 <YHQ/7MTKGD/UO4pW@unreal>
In-Reply-To: <YHQ/7MTKGD/UO4pW@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 12 Apr 2021 14:53:55 +0200
Message-ID: <CAMGffEn8AYhtO8WF4sWjPu2uVgZDL4aRiT+sPjqtK6VaGsk3bQ@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 02:22:51PM +0200, Jinpu Wang wrote:
> > On Tue, Apr 6, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > >
> > > > Client prints only error value and it is not enough for debugging.
> > > >
> > > > 1. When client receives an error from server:
> > > > the client does not only print the error value but also
> > > > more information of server connection.
> > > >
> > > > 2. When client failes to send IO:
> > > > the client gets an error from RDMA layer. It also
> > > > print more information of server connection.
> > > >
> > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
> > > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > index 5062328ac577..a534b2b09e13 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> > > >       req->in_use = false;
> > > >       req->con = NULL;
> > > >
> > > > +     if (unlikely(errno)) {
> > >
> > > I'm sorry, but all your patches are full of these likely/unlikely cargo
> > > cult. Can you please provide supportive performance data or delete all
> > > likely/unlikely in all rtrs code?
> >
> > Hi Leon,
> >
> > All the likely/unlikely from the non-fast path was removed as you
> > suggested in the past.
> > This one is on IO path, my understanding is for the fast path, with
> > likely/unlikely macro,
> > the compiler will optimize the code for better branch prediction.
>
> In theory yes, in practice. gcc 10 generated same assembly code when I
> placed likely() and replaced it with unlikely() later.
That's a surprise to me.

Just checked, min gcc requirement is 4.9[1],  debian Buster is using
gcc 8.3, upcoming Bullseye will use gcc 10.2

[1]: https://www.kernel.org/doc/html/latest/process/changes.html
>
> >
> > We will run some benchmarks to see if it makes a difference.
> >
> > Thanks
> > >
> > > Thanks
