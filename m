Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F928321859
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 14:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBVNTy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 08:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhBVNRm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 08:17:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1172564E29;
        Mon, 22 Feb 2021 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613999820;
        bh=r10yyqwyhJKisPQ1uugfFzUwXNcLDKYOFc9JuZxFl0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ps+dllbkGhdAjzMp89Fka0xg0WQEpRzB0kIA1JsL5mHhJYKGzhtZbsCWkDxl5Jd1d
         HAV9Z8QbTuTgu0i7ptkuvhbwOh4MC9iYXSvwh4c6WyD156bnUKIa/gc6X3vUzZYmDv
         pWp4aJasrzX+6GbqWDJPwJR67198td6d47R5PVIsyaUjJEZuc3b4agaupgY6ulrAMt
         PxJQPWGb4YAHnLQou18zyUAq4Mzsqc0nfyujI4nm/leGJwibxmGt0yCiXixI20NGMT
         /y1qRcWNCYug9JWQyRO0czw/564upxaNmHMx9UpVDXdXyv855Wxe5T+YrJ4VVhJ7KF
         LpZKBIaOyCaSg==
Date:   Mon, 22 Feb 2021 15:16:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCH 1/2] RDMA/rtrs: Use new shared CQ mechanism
Message-ID: <YDOuyLMjl6jYMDEA@unreal>
References: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
 <YDH8ckNx/sEPlePt@unreal>
 <CAMGffEk7Qn9W+tjvb4S-aHs7N0DtkwNRR76X3Lf6zjfRujTP5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEk7Qn9W+tjvb4S-aHs7N0DtkwNRR76X3Lf6zjfRujTP5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 11:31:55AM +0100, Jinpu Wang wrote:
> On Sun, Feb 21, 2021 at 7:23 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Feb 19, 2021 at 12:50:18PM +0100, Jack Wang wrote:
> > > Has the driver use shared CQs providing ~10%-20% improvement during
> > > test.
> > > Instead of opening a CQ for each QP per connection, a CQ for each QP
> > > will be provided by the RDMA core driver that will be shared between
> > > the QPs on that core reducing interrupt overhead.
> > >
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
> > >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 10 +++++-----
> > >  drivers/infiniband/ulp/rtrs/rtrs.c     | 11 +++++++----
> > >  4 files changed, 18 insertions(+), 14 deletions(-)

<...>

> > >       err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
> > >                       max_send_sge);
> > >       if (err) {
> > > -             ib_free_cq(con->cq);
> > > +             ib_cq_pool_put(con->cq, con->cq_size);
> > >               con->cq = NULL;
> > > +             con->cq_size = 0;
> >
> > It is better do not clear fields that not used, it hides bugs.
> > Other than that.
> I feel rewinding on the error path by resetting the cq_size is the
> right thing to do.

It is the right thing to do if down the road you have an access to
cq_size with if (..) check. Other than that, it is not right thing to
do.

Thanks
