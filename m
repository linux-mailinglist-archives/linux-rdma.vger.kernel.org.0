Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6761B35C675
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbhDLMli (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 08:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238331AbhDLMli (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 08:41:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89DD161027;
        Mon, 12 Apr 2021 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618231280;
        bh=WaFtiiKmNHgVzq4NDRvrOTKFY1dC8Al+r/vIHscgkJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbHekLOybsMedSNtAcKt+H6OyuTh9a7IeRoBm6HOwFupjU3Fg3mZuBDPDJK7O9JFj
         3ezxqJ43DDxuMCisLNZy+PvAtVNgbqF+AyFmq/MGp3suW0iKg4tP062tv6AD+i8Y+p
         5hDKxavgPxsrrInemYWRN+pEltlJZfxo6PWqCLNnIhxPg/Zp0whBIfywQzPMOV3L/9
         kyQEt69HiBAFBEoHkDBH3M4ydGHB/SMoHzVHy2HJwUYlu3DlnNud/EBLqDqK/ugMfC
         eqY0DHXbbkSBo1MpKoby14y61fK0Gl8SNqsVN/XpZtYB65Ves4QVrCniDgrsSbSgG6
         PXFn8LoZIkGAQ==
Date:   Mon, 12 Apr 2021 15:41:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
Message-ID: <YHQ/7MTKGD/UO4pW@unreal>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
 <20210406123639.202899-2-gi-oh.kim@ionos.com>
 <YGxXD/TODlXHp2sK@unreal>
 <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 02:22:51PM +0200, Jinpu Wang wrote:
> On Tue, Apr 6, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > >
> > > Client prints only error value and it is not enough for debugging.
> > >
> > > 1. When client receives an error from server:
> > > the client does not only print the error value but also
> > > more information of server connection.
> > >
> > > 2. When client failes to send IO:
> > > the client gets an error from RDMA layer. It also
> > > print more information of server connection.
> > >
> > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
> > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > index 5062328ac577..a534b2b09e13 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> > >       req->in_use = false;
> > >       req->con = NULL;
> > >
> > > +     if (unlikely(errno)) {
> >
> > I'm sorry, but all your patches are full of these likely/unlikely cargo
> > cult. Can you please provide supportive performance data or delete all
> > likely/unlikely in all rtrs code?
> 
> Hi Leon,
> 
> All the likely/unlikely from the non-fast path was removed as you
> suggested in the past.
> This one is on IO path, my understanding is for the fast path, with
> likely/unlikely macro,
> the compiler will optimize the code for better branch prediction.

In theory yes, in practice. gcc 10 generated same assembly code when I
placed likely() and replaced it with unlikely() later.

> 
> We will run some benchmarks to see if it makes a difference.
> 
> Thanks
> >
> > Thanks
