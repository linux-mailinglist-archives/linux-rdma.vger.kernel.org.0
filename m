Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67435E71E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 21:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbhDMTbh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 15:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348079AbhDMTbd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 15:31:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E203F613C7;
        Tue, 13 Apr 2021 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618342273;
        bh=eHmFJu4eUTi9ZzT30sEsjQkw4xYtthky3Z91fZVHOEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDXIPyKDCbX9acZ2JSMc7Uxsw8i6wE8q16rx/oYBhKKBBcPzQzZbCdBiglAH7UHpl
         oyQu9Z9vQ20eg0KAAZVfALNY54Zjk2K/M6bUzZvuMhv6mDSRRo9VZIO2Ur/84RIdq4
         n92r8mopWHIMNA14ZwDYJxQHLUYAu5AnRyVXQTjLVcY3TlHqro0bE5k4GE6Va23EKA
         DuyV2STeqRyVohOFZupcoGL7H7KKUDMvCEfFqfiS85vzKhvDQ8dGtziytWtiQqkFKW
         d8PVzFjku4aeS5zct4uRYFvJvKnj4UnTD6b+GlUcxXL8r/dS173FRzcwIFhw5AoogN
         Vh801DzAam8sg==
Date:   Tue, 13 Apr 2021 22:31:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
Message-ID: <YHXxfaLzr7m/hPXG@unreal>
References: <20210406123639.202899-2-gi-oh.kim@ionos.com>
 <YGxXD/TODlXHp2sK@unreal>
 <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
 <YHQ/7MTKGD/UO4pW@unreal>
 <CAMGffEn8AYhtO8WF4sWjPu2uVgZDL4aRiT+sPjqtK6VaGsk3bQ@mail.gmail.com>
 <CAJX1YtZJ3sJy5fu_6v-sbqx3yLsPTh_SbvRQo9Yz1k48KxXpCA@mail.gmail.com>
 <YHSErWp/Bi0kpBty@unreal>
 <1DFC1F4B-FF53-4AA8-B5FB-9F57B378339E@oracle.com>
 <YHU9hZfkNEDy94+s@unreal>
 <CAJX1YtZ9LLqugvQHa77PCxpyoLx-k31bh7eXfxuVWw0NHr6xAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJX1YtZ9LLqugvQHa77PCxpyoLx-k31bh7eXfxuVWw0NHr6xAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 03:11:33PM +0200, Gioh Kim wrote:
> On Tue, Apr 13, 2021 at 8:43 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Apr 13, 2021 at 05:31:24AM +0000, Haakon Bugge wrote:
> > >
> > >
> > > > On 12 Apr 2021, at 19:34, Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, Apr 12, 2021 at 04:00:55PM +0200, Gioh Kim wrote:
> > > >> On Mon, Apr 12, 2021 at 2:54 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
> > > >>>
> > > >>> On Mon, Apr 12, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >>>>
> > > >>>> On Mon, Apr 12, 2021 at 02:22:51PM +0200, Jinpu Wang wrote:
> > > >>>>> On Tue, Apr 6, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >>>>>>
> > > >>>>>> On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> > > >>>>>>> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > >>>>>>>
> > > >>>>>>> Client prints only error value and it is not enough for debugging.
> > > >>>>>>>
> > > >>>>>>> 1. When client receives an error from server:
> > > >>>>>>> the client does not only print the error value but also
> > > >>>>>>> more information of server connection.
> > > >>>>>>>
> > > >>>>>>> 2. When client failes to send IO:
> > > >>>>>>> the client gets an error from RDMA layer. It also
> > > >>>>>>> print more information of server connection.
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > >>>>>>> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > >>>>>>> ---
> > > >>>>>>> drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
> > > >>>>>>> 1 file changed, 29 insertions(+), 4 deletions(-)
> > > >>>>>>>
> > > >>>>>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > >>>>>>> index 5062328ac577..a534b2b09e13 100644
> > > >>>>>>> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > >>>>>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > >>>>>>> @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> > > >>>>>>>      req->in_use = false;
> > > >>>>>>>      req->con = NULL;
> > > >>>>>>>
> > > >>>>>>> +     if (unlikely(errno)) {
> > > >>>>>>
> > > >>>>>> I'm sorry, but all your patches are full of these likely/unlikely cargo
> > > >>>>>> cult. Can you please provide supportive performance data or delete all
> > > >>>>>> likely/unlikely in all rtrs code?
> > > >>>>>
> > > >>>>> Hi Leon,
> > > >>>>>
> > > >>>>> All the likely/unlikely from the non-fast path was removed as you
> > > >>>>> suggested in the past.
> > > >>>>> This one is on IO path, my understanding is for the fast path, with
> > > >>>>> likely/unlikely macro,
> > > >>>>> the compiler will optimize the code for better branch prediction.
> > > >>>>
> > > >>>> In theory yes, in practice. gcc 10 generated same assembly code when I
> > > >>>> placed likely() and replaced it with unlikely() later.
> > > >>
> > > >> Even-thought gcc 10 generated the same assembly code,
> > > >> there is no guarantee for gcc 11 or gcc 12.
> > > >>
> > > >> I am reviewing rtrs source file and have found some unnecessary likely/unlikely.
> > > >> But I think likely/unlikely are necessary for extreme cases.
> > > >> I will have a discussion with my colleagues and inform you of the result.
> > > >
> > > > Please come with performance data.
> > >
> > > I think the best way to gather performance data is not remove the likely/unlikely, but swap their definitions. Less coding and more pronounced difference - if any.
> >
> > In theory, it will multiply by 2 gain/loss, which is nice to see if
> > likely/ulikely change something.
> >
> > Thanks
> >
> > >
> > >
> > > Thxs, Håkon
> > >
> 
> Hi,
> 
> In summary, there is no performance gap before/after swapping
> likely/unlikely macros.
> So I will send a patch to remove all likely/unlikely macros.
> 
> I guess that is because
> - The performance of rnbd/rtrs depends on the network and block layer.
> - The network and block layer are not fast enough to get impacted by
> likely/unlikely.

Thanks for sharing this data. Your input can't truly randomize the code
path execution flows and your instructions cache was filled "correctly".
It was expected.

In most cases, the likely/unlikely is not needed.

Thanks
