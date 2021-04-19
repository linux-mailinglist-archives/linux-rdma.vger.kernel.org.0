Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEEA363B49
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhDSGJw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 02:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhDSGJw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 02:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68E1961077;
        Mon, 19 Apr 2021 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618812563;
        bh=2fIYWtfedDBCFmMMlSLoZEawqMMpRf3JEH3Zx0rFw5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkZCK0voGTWwncj1FIy3GQWxvHiC80Lb4v/tEhcCPaaadbeGaxZNjxaSS8xOVo2JH
         jZUz9c9jHFZTQf+2UCDtdsYq3EpwipPbx68lZnHGD6cuD+fHvYq4SWpHRGG6v7VbTL
         o1S5fG6/39mzcee5SamR1JNWRq4v1xDZbX2C1OMMBHk2EpKYum7/J7x2xgh/9TORuA
         iWkRoWxVZVgWyMFvBe4wbIyEtXC7Ik9qLtqWJgAGQmqL8yvoAjIcWnaqh45RU1kNFp
         66xsi4XapqxERAmW3mOyCXaX7VkvC88WS/ZYn2kGt13SpsX3A8m3rxI9WlJeDGWDek
         WM4ADzkGorSpQ==
Date:   Mon, 19 Apr 2021 09:09:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, sagi@grimberg.me,
        Bart Van Assche <bvanassche@acm.org>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCHv4 for-next 13/19] block/rnbd-clt: Support polling mode
 for IO latency optimization
Message-ID: <YH0ej9ZplTrkA156@unreal>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
 <20210414122402.203388-14-gi-oh.kim@ionos.com>
 <YHvvdskHgQe9gX09@unreal>
 <CAJX1YtaN3TmwdOE_8UrRuUU=3cCvtQRBX+DmwvU0Tj3nw-knyg@mail.gmail.com>
 <YH0TBlXxU5cq2eO4@unreal>
 <CAJX1Ytb=nFvfy4KNgHDxHaSp+4z3_Wh5EHXXVgg-dcNU39LAwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX1Ytb=nFvfy4KNgHDxHaSp+4z3_Wh5EHXXVgg-dcNU39LAwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 07:51:34AM +0200, Gioh Kim wrote:
> On Mon, Apr 19, 2021 at 7:46 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Apr 19, 2021 at 07:12:09AM +0200, Gioh Kim wrote:
> > > On Sun, Apr 18, 2021 at 10:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Wed, Apr 14, 2021 at 02:23:56PM +0200, Gioh Kim wrote:
> > > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > >
> > > > > RNBD can make double-queues for irq-mode and poll-mode.
> > > > > For example, on 4-CPU system 8 request-queues are created,
> > > > > 4 for irq-mode and 4 for poll-mode.
> > > > > If the IO has HIPRI flag, the block-layer will call .poll function
> > > > > of RNBD. Then IO is sent to the poll-mode queue.
> > > > > Add optional nr_poll_queues argument for map_devices interface.
> > > > >
> > > > > To support polling of RNBD, RTRS client creates connections
> > > > > for both of irq-mode and direct-poll-mode.
> > > > >
> > > > > For example, on 4-CPU system it could've create 5 connections:
> > > > > con[0] => user message (softirq cq)
> > > > > con[1:4] => softirq cq
> > > > >
> > > > > After this patch, it can create 9 connections:
> > > > > con[0] => user message (softirq cq)
> > > > > con[1:4] => softirq cq
> > > > > con[5:8] => DIRECT-POLL cq
> >
> > <...>
> 
> I am sorry that I don't understand exactly.
> Do I need to change them to "con<5..8>"?

No, I just removed not relevant text and replaced it with <...> in
automatic way :).

> 
> 
> >
> > > > > +int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
> > > > > +{
> > > > > +     int cnt;
> > > > > +     struct rtrs_con *con;
> > > > > +     struct rtrs_clt_sess *sess;
> > > > > +     struct path_it it;
> > > > > +
> > > > > +     rcu_read_lock();
> > > > > +     for (path_it_init(&it, clt);
> > > > > +          (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
> > > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > > >
> > > > We talked about useless likely/unlikely in your workloads.
> > >
> > > Right, I've made a patch to remove all likely/unlikely
> > > and will send with the next patch set.
> >
> > This specific line is "brand new". We don't add code that will be
> > removed in next patch.
> 
> Ah, ok. So you mean,
> 1. remove unlikely from that line
> 2. send a patch to remove all likely/unlikely for next round
> 
> Am I right?

Right
