Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A63789CB
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhEJLbm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 07:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhEJLHL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 07:07:11 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE94C06135A
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 04:00:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v5so20245442ljg.12
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvIwyPyGeGc51FR8LPSjqBV9Q82W7cWA1wpEti0+zUM=;
        b=VHU6IQrPHeCzGOfV6WPqnCs/YYAJkFrVGVPDG18jlnH4f8AU/iePyVdRczXB90VFq4
         as5+5A/ACsd+XeuXL2+XJJhegs48J8E7O3tLMmOoZIcYfe0llSZr1Vm8XHvavxVtAiER
         0Yd6brNw+Em2VFMHac/K+zve8e6dIFkGIyTbJTe6QIIwj404HCQdbiQlJ+9kYKAS2o/O
         TOzxYwqrHCURTnuEU8A7Mp3QSmlddbAVGT71mqXJkVM3ntM/ChF4MwgQmGCrF5oiEUiw
         uAcvPNOD5uEjH1EOviWQ+aXKnZMT/tgEH6x0jfk3Wf1vW7ZyCyEn7BHSxzIJGvaEWa5F
         Ha5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvIwyPyGeGc51FR8LPSjqBV9Q82W7cWA1wpEti0+zUM=;
        b=QVJKYRZZQPgCFL4uFFf+KjaQLl6hFCWPZWiisQ14OrGVu+LZp2x4H04n9dt9cv7PrI
         G7ww/oPmBVO29kBYAo4VQf6Dh2weK99K4hv7ilMgviXrShO9qefZRwOWp1PSTM21mEF5
         3/s3l8hut5UH1gl1MKXyxePPUYVb5i3nvbd5Boof4en/mFdYVkybUa0bSnNeQdEPkWeZ
         uZjWZ+6TFrlqOBRUJyAtSGn7icKK4Xci1yyoAxzQpqu/FmrwcKE4G2w4cj1j/rr4YNnP
         RN1nH0sRZWJdsRv8sE7FCp2ZJ8l610ggH326gOz8SYb8ciKzCGtx+snXe0+mWRQAz1su
         xlpg==
X-Gm-Message-State: AOAM531Hv+yKgP9v9IPEpUzMRFJMCTcIG31iRGQ939l51jJ/kzbAHZ7r
        I/tZIoPM3dDbNgAPwO6o62NgViqRq2FSMENEfteVig==
X-Google-Smtp-Source: ABdhPJys4Bd/tN8EIzdale7OXwYOpPQu1cZEaqplb0sTnf+3oLZ9dU3QsLvTgl3BrjMvgqrD/VyfN88vSwxJyq81sMQ=
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr11756581ljn.489.1620644443908;
 Mon, 10 May 2021 04:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210503114818.288896-1-gi-oh.kim@ionos.com> <20210503114818.288896-4-gi-oh.kim@ionos.com>
 <YJfGcFlJCHrf2quT@unreal>
In-Reply-To: <YJfGcFlJCHrf2quT@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 10 May 2021 13:00:33 +0200
Message-ID: <CAJpMwyiXbqTK-pB=nQ4sfzXeeo8=dd5KJVZ_57apGF5cbpM5dA@mail.gmail.com>
Subject: Re: [PATCH for-next 03/20] RDMA/rtrs-clt: No need to check
 queue_depth when receiving
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 9, 2021 at 1:24 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 03, 2021 at 01:48:01PM +0200, Gioh Kim wrote:
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > The queue_depth size is sent from server and
> > server already checks validity of the value.
>
> Do you trust server? What will be if server is not reliable and sends
> garbage?

Hi Leon,

The server code checks for the queue_depth before sending. If the
server is really running malicious code, then the queue_depth is the
last thing that the client needs to worry about.

>
> Thanks
>
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 930a1b496f84..0c828ea0f500 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -1772,12 +1772,6 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
> >       }
> >       if (con->c.cid == 0) {
> >               queue_depth = le16_to_cpu(msg->queue_depth);
> > -
> > -             if (queue_depth > MAX_SESS_QUEUE_DEPTH) {
> > -                     rtrs_err(clt, "Invalid RTRS message: queue=%d\n",
> > -                               queue_depth);
> > -                     return -ECONNRESET;
> > -             }
> >               if (!sess->rbufs || sess->queue_depth < queue_depth) {
> >                       kfree(sess->rbufs);
> >                       sess->rbufs = kcalloc(queue_depth, sizeof(*sess->rbufs),
> > --
> > 2.25.1
> >
