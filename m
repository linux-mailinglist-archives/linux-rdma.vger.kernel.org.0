Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B6835C620
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhDLMXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbhDLMXV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 08:23:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847FCC061574
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 05:23:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r12so19930642ejr.5
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqYwmrLwEQsRMBU9fBsVCvlo7LgzB6UWR81xARTlXHY=;
        b=jPL+eUJAG0Ry72Mk/5QhQt4x50n4pjkso3sezvYf/vmn/bSVTjKY9aS3S0QSLItBbM
         yqmWSKiriZABFSZ5d/VueTioTBWPr6mmI0f6f4vgXDCdr7GmW//c+pg7MutrAtMWtBSk
         DkiMCXZCwRF34BNslgnyQXE1KmI8sYh411Jzt5BXWJpv05EygB+G5g6nFR9zmtsXiC+W
         Rs/+0si2WEPkXaO+zLgmtiAdygELQYAVzymbMnJiPZ5TmhnhS4Lg/jv8iugMX0X19OQE
         kjguobfRXbruvRbQoD5Om2A26lJcfN0A0/PkPfLQ8PBvtuCxSRiNh9REbZsg8tJ5CWmm
         VpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqYwmrLwEQsRMBU9fBsVCvlo7LgzB6UWR81xARTlXHY=;
        b=nc7P0x4nGMVWghAPZYK+6H/esw/kCt8tlMRBIwLcb0C/zgSrQBsHg37+Kn1NHrI8OA
         M8kLICUKwBkR+vuASFJW1tDrZX0aVfLDJZo7BjmD8U0IRy3a7BUfNTZwARCGrISYOQY7
         D420zq5Cp8WSenQIPTyEz8sIJYwym+NLlPHo2/zUME2LedKZc8KLugYR3n/jXTeYWAGs
         FiC8S/QXC4Vtpv2TJMHx3A15SJYu2qtCQCaCxwHEmTVLgo4Q6rZNZvYvi4ExHlHZQ4/h
         m6f3mkprL+irObyFvjRY+QyorgQkOztvnyYOco8bYiuJwrF7hCr3R0CBb+qzDAZhlTmU
         mZug==
X-Gm-Message-State: AOAM531lWCQmjNkPRK+sgHzZjJR3agI5jZ/6A44te89EjyLOWUP2ZfCd
        i9tELg7tZAJKaC/b8NWtzp5NfVlhqLp3LaGRfFUJ7Q==
X-Google-Smtp-Source: ABdhPJx9vqJTFw6pehHeu2SlJzqZOUv7mRaYsjgfpysuS0Jfn3UbC3x1gq3vVoTnJe7JZPS2mksPcEoc5wfO+QSVUUY=
X-Received: by 2002:a17:906:c04a:: with SMTP id bm10mr8555586ejb.521.1618230182201;
 Mon, 12 Apr 2021 05:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210406123639.202899-1-gi-oh.kim@ionos.com> <20210406123639.202899-2-gi-oh.kim@ionos.com>
 <YGxXD/TODlXHp2sK@unreal>
In-Reply-To: <YGxXD/TODlXHp2sK@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 12 Apr 2021 14:22:51 +0200
Message-ID: <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
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

On Tue, Apr 6, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > Client prints only error value and it is not enough for debugging.
> >
> > 1. When client receives an error from server:
> > the client does not only print the error value but also
> > more information of server connection.
> >
> > 2. When client failes to send IO:
> > the client gets an error from RDMA layer. It also
> > print more information of server connection.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 5062328ac577..a534b2b09e13 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> >       req->in_use = false;
> >       req->con = NULL;
> >
> > +     if (unlikely(errno)) {
>
> I'm sorry, but all your patches are full of these likely/unlikely cargo
> cult. Can you please provide supportive performance data or delete all
> likely/unlikely in all rtrs code?

Hi Leon,

All the likely/unlikely from the non-fast path was removed as you
suggested in the past.
This one is on IO path, my understanding is for the fast path, with
likely/unlikely macro,
the compiler will optimize the code for better branch prediction.

We will run some benchmarks to see if it makes a difference.

Thanks
>
> Thanks
