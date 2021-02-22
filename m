Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FDE321A00
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBVOQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhBVOOk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 09:14:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3828C061574
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 06:13:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r17so3236112ejy.13
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 06:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gq9Cx8kU923oJvkfHz4SrIeheCXGfX6iiAIcoYCjlx8=;
        b=Hj8TRny2vXSmhZdRlOXHIc6/xkybpW2ixU9Rs7l5Pvqek230A/LLY+fhG5jKqaagd7
         j8Jf4t8VRch85vS6L1YavOJ3mjCrriINLS1YFyuEkzMj9qdmbLGvnv/Npy+0PtRXkSzP
         pzRLDSR6aQTbL2x3a44ZCfW2kmYz0RiRH9zEJBxC8xm6AUF+ODPK8kr0aCaaD55CrJoF
         /VoEu9YHupbEBzAYdDBzZm1oqhlmMtNgqtm3gVi/pIQBraAel6gmTf/oFwiW6FxNtBAu
         M/qzJdgLg3m9jupeQ+3GJAEUZ4Oe2nzuePg9IEY7aUUA4nAF/tVB1wCpiVRO/VVv/CyG
         KXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gq9Cx8kU923oJvkfHz4SrIeheCXGfX6iiAIcoYCjlx8=;
        b=KqW6kgBf8yoOA9LzIEl1eeIWSF9PLKXeR88R0AMmfSq5pASwNBXH/2ZDx4qtHAmSyu
         7UPpNDDOTdjC3tX/mEy3c471zJi7PixEQKEBWV/OdWnZiJilxqmi9B1zRB2I0BId6yUu
         g4hKpfHwkpZPErUOVP15XmiT4lvv/PpIhYHt9I42BjzlOLKaEgaPa25LdwTkHq57J0iO
         SX1wYzs2HCwWm3S4s/95Udg4uGmmT+xMaxg/cQ4ynKcoTzvTlar4bwYKprcuar6pONla
         KuuRezl0TC0BBzmNhXWtDo4fLX+WKwxFUY1+jET+lQlSH0oH41ytJVL+7dh8pb149ICm
         IvHg==
X-Gm-Message-State: AOAM532N6Hbq8Az4TOq6A3OqQw1GBt1sSSf8NTNUSAHWX6gzT/oHS6Zz
        0PkDtExwJrJhJAtvBElBWHNikledSb4s4XHUHMcDHw==
X-Google-Smtp-Source: ABdhPJzv2gOqKTtU0uGIpRLvmhOMKj8SECVyDeyAJ0dyfsEc49qZrsdY81bOE+3DjewBEjbpw+02vx50/COBWgAW8rE=
X-Received: by 2002:a17:907:760a:: with SMTP id jx10mr12065161ejc.212.1614003236631;
 Mon, 22 Feb 2021 06:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
 <YDH8ckNx/sEPlePt@unreal> <CAMGffEk7Qn9W+tjvb4S-aHs7N0DtkwNRR76X3Lf6zjfRujTP5g@mail.gmail.com>
 <YDOuyLMjl6jYMDEA@unreal>
In-Reply-To: <YDOuyLMjl6jYMDEA@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 22 Feb 2021 15:13:45 +0100
Message-ID: <CAMGffEnbGOQU2FhQug3KqgpQPrbOmhztGrTYs4v1eX0w-cUhjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rtrs: Use new shared CQ mechanism
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 2:17 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Feb 22, 2021 at 11:31:55AM +0100, Jinpu Wang wrote:
> > On Sun, Feb 21, 2021 at 7:23 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Feb 19, 2021 at 12:50:18PM +0100, Jack Wang wrote:
> > > > Has the driver use shared CQs providing ~10%-20% improvement during
> > > > test.
> > > > Instead of opening a CQ for each QP per connection, a CQ for each QP
> > > > will be provided by the RDMA core driver that will be shared between
> > > > the QPs on that core reducing interrupt overhead.
> > > >
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
> > > >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 10 +++++-----
> > > >  drivers/infiniband/ulp/rtrs/rtrs.c     | 11 +++++++----
> > > >  4 files changed, 18 insertions(+), 14 deletions(-)
>
> <...>
>
> > > >       err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
> > > >                       max_send_sge);
> > > >       if (err) {
> > > > -             ib_free_cq(con->cq);
> > > > +             ib_cq_pool_put(con->cq, con->cq_size);
> > > >               con->cq = NULL;
> > > > +             con->cq_size = 0;
> > >
> > > It is better do not clear fields that not used, it hides bugs.
> > > Other than that.
> > I feel rewinding on the error path by resetting the cq_size is the
> > right thing to do.
>
> It is the right thing to do if down the road you have an access to
> cq_size with if (..) check. Other than that, it is not right thing to
> do.
>
> Thanks
Double checked, will remove the cq_size clear lines in v2.

Thanks!
