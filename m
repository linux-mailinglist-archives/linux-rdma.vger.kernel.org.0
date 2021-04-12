Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD06D35CF86
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 19:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbhDLRe7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 13:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239298AbhDLRe7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 13:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 621F36121F;
        Mon, 12 Apr 2021 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618248881;
        bh=X4vHobQGMf5yS8EZZFI9B97njb3wMr6W5r0ESrF0RH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtBQiOzzR77bG1BUDCJ4H8wTpZ0H3J0MsrXln+iKYvnInaHFSc/l0LOWlH8Nz3au7
         aRgTlT4yELRjmT0yqg89hzed+F+Yy8qtjZdEqSVenwze6Gi9tOzQbUIhg2Ni7ZtvPR
         T1N5RVX34qsFsVXDB9dfZ+vBMYTeTdpg5WRc2RYwB/j7daaxCVgX8yHwqHcz92Zmer
         CmrPc3zmG3BpXFCusL0uNiSUzoyDd7OjUk12eZC00KwXW40YEfjJ00IFGVdmiqx8u6
         dxBkZMjYGs+xc/Sf64zxt/ifU3iOXj7SxNowK9JQZ+9OTkUvNEOLoZI4Sj1wpw+yav
         bNkqlcEsIGuWQ==
Date:   Mon, 12 Apr 2021 20:34:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
Message-ID: <YHSErWp/Bi0kpBty@unreal>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
 <20210406123639.202899-2-gi-oh.kim@ionos.com>
 <YGxXD/TODlXHp2sK@unreal>
 <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
 <YHQ/7MTKGD/UO4pW@unreal>
 <CAMGffEn8AYhtO8WF4sWjPu2uVgZDL4aRiT+sPjqtK6VaGsk3bQ@mail.gmail.com>
 <CAJX1YtZJ3sJy5fu_6v-sbqx3yLsPTh_SbvRQo9Yz1k48KxXpCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX1YtZJ3sJy5fu_6v-sbqx3yLsPTh_SbvRQo9Yz1k48KxXpCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 04:00:55PM +0200, Gioh Kim wrote:
> On Mon, Apr 12, 2021 at 2:54 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
> >
> > On Mon, Apr 12, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, Apr 12, 2021 at 02:22:51PM +0200, Jinpu Wang wrote:
> > > > On Tue, Apr 6, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> > > > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > > >
> > > > > > Client prints only error value and it is not enough for debugging.
> > > > > >
> > > > > > 1. When client receives an error from server:
> > > > > > the client does not only print the error value but also
> > > > > > more information of server connection.
> > > > > >
> > > > > > 2. When client failes to send IO:
> > > > > > the client gets an error from RDMA layer. It also
> > > > > > print more information of server connection.
> > > > > >
> > > > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > > > ---
> > > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
> > > > > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > > index 5062328ac577..a534b2b09e13 100644
> > > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > > @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> > > > > >       req->in_use = false;
> > > > > >       req->con = NULL;
> > > > > >
> > > > > > +     if (unlikely(errno)) {
> > > > >
> > > > > I'm sorry, but all your patches are full of these likely/unlikely cargo
> > > > > cult. Can you please provide supportive performance data or delete all
> > > > > likely/unlikely in all rtrs code?
> > > >
> > > > Hi Leon,
> > > >
> > > > All the likely/unlikely from the non-fast path was removed as you
> > > > suggested in the past.
> > > > This one is on IO path, my understanding is for the fast path, with
> > > > likely/unlikely macro,
> > > > the compiler will optimize the code for better branch prediction.
> > >
> > > In theory yes, in practice. gcc 10 generated same assembly code when I
> > > placed likely() and replaced it with unlikely() later.
> 
> Even-thought gcc 10 generated the same assembly code,
> there is no guarantee for gcc 11 or gcc 12.
> 
> I am reviewing rtrs source file and have found some unnecessary likely/unlikely.
> But I think likely/unlikely are necessary for extreme cases.
> I will have a discussion with my colleagues and inform you of the result.

Please come with performance data.

Thanks
