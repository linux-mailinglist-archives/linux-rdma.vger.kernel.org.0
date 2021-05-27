Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2516A392AB4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhE0J1z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 05:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbhE0J1y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 05:27:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30FBC061574
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 02:26:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f12so5418859ljp.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpii1sDx8QQz+caYuzp9XPtbKulyfWpR5gjq56j7G1c=;
        b=b6VQDvQ68pJxSi2emR9u5ryt/mEMZ/WiJ7OUKLsK+0HDLOWLmMSAaVFHP+SEfQutW2
         qKdBU16hMiGYTZAcbtKHwmvZzLKQPnl8KJ2/oGKGy32Vc7/8ywmUO7cpalQsuP66xHyl
         ocEwt+HDwhcAYyvkJGXBohUTpowMikpiLlmQDR4EwxhTev5RZiN9kQckEHhDcekUcvT9
         EZAC7RXSN+hs9B0CkYtNgybBQ15LX1fod7mCVxoQseuTPCKzwHf4EGQYgd3ZP1GUAq7X
         vYvKaAN8DinAsjTmnFu6u+NqXiXyDUrAXegLGU++O9wRBZpTrVuk9UxiF7gQww0c4dkq
         ny7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpii1sDx8QQz+caYuzp9XPtbKulyfWpR5gjq56j7G1c=;
        b=KmtQFo4AHU89pvhPaQ+9es2PimvT54nRBlrnarO963ZnBCu6+fRPeA0b6quOufwD9h
         2Nx821tO0tH7NDLB2AmWDs41YFmHz7BXVP+0v2QN6OYfvkmur7crqQjIb1AG5GLA2wkT
         4tjPTe0cbJdbmyoTpWMTAO6ziwkuOvRLjpFw5uqx0hVejkKygzX4wgDEQt1BqGsYY9/E
         xcvOI2tSkdvpE4TfZNqAtf7kupKz/sDeykl2y95rLjSPNc7vMWzIOtlmb1NfQZWGs4j9
         sy2lKTrbWePg/hboL38qehjWpg0dXjN+Nl9deUFPBccQ5S0zWYdnQYGw05Riw20CHey4
         tRoQ==
X-Gm-Message-State: AOAM5335cmjgNbJSIFcqV/Pworzl8MohOmPmXr3qC11Gq6QEX9aNyz2U
        7wwC7wId58abeto5oT0uSR6KNYOE68nk3rJecbdK9A==
X-Google-Smtp-Source: ABdhPJxxVber0A38/08Vt/ZyIlSi6xjIJAUG40Yc/yOb895u0C6xY9QH8apaq8ftBW++XiA05iql/2guEM5qrZfq6zQ=
X-Received: by 2002:a2e:9346:: with SMTP id m6mr1873492ljh.150.1622107579986;
 Thu, 27 May 2021 02:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210517091844.260810-1-gi-oh.kim@ionos.com> <20210517091844.260810-4-gi-oh.kim@ionos.com>
 <20210525201823.GA3482566@nvidia.com> <CAJpMwyg+SZjaYOi4z01gjphzzvVsG74dKkXzLQHG94=R5Lx3Dg@mail.gmail.com>
 <20210526160736.GB1096940@ziepe.ca>
In-Reply-To: <20210526160736.GB1096940@ziepe.ca>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 27 May 2021 11:26:09 +0200
Message-ID: <CAJpMwyi=16apTfO-urWX3Ooy-7xJ_KYt8gLZ66H6wEVeBJx=Ow@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 03/19] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 6:07 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, May 26, 2021 at 11:28:41AM +0200, Haris Iqbal wrote:
> > On Tue, May 25, 2021 at 10:18 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Mon, May 17, 2021 at 11:18:27AM +0200, Gioh Kim wrote:
> > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > It was difficult to find out why it failed to establish RDMA
> > > > connection. This patch adds some messages to show which function
> > > > has failed why.
> > > >
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > index 3d09d01e34b4..df17dd4c1e28 100644
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > > >        * If this request is not the first connection request from the
> > > >        * client for this session then fail and return error.
> > > >        */
> > > > -     if (!first_conn)
> > > > +     if (!first_conn) {
> > > > +             pr_err("Error: Not the first connection request for this session\n");
> > > >               return ERR_PTR(-ENXIO);
> > >
> > > You really shouldn't be printing based on attacker controlled data..
> >
> > I want to make sure I understand correctly. Did you mean that an
> > attacker can bombard a server with such connection request, which can
> > lead to uncontrolled prints, and possibly DOS?
>
> Yes
>
> > If so, would a ratelimited print be better?
>
> Probably

Alright.. Will change this print to a ratelimited one, and send the
updates patches.

Thanks.

>
> Jason
