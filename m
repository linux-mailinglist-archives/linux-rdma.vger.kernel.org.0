Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6412363B26
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 07:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhDSFwk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 01:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhDSFwk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 01:52:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE3C06174A
        for <linux-rdma@vger.kernel.org>; Sun, 18 Apr 2021 22:52:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so39153557edd.4
        for <linux-rdma@vger.kernel.org>; Sun, 18 Apr 2021 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9Kqj0SIpbacTSWIXobu2nBH/kGtCvihRV1cPJE/Vhw=;
        b=QBDkM/uCbw/Sddq7WI5eixja8rBNgQfAmRCVg+iKFYjxdqDsebb3ZDYogtzJSsPe0V
         DjpV4oACrzDr8/DOn+u/xcSxKTWCe7f3ch24ucKIWxgEh5Nf52vtWzGzLWKPSnZtGJZx
         ou8KtY9GVOm+BargoLpWHBmfcjV38mmHkAdVBaldezkZk2oYU1S0ybf2HRhZwgsKHC9N
         MeNr3q6USSoJQzRrZRJfYPiOWu7nE0QqpbyRuuzig/rcJgB4SDF86K/+IvXrQgblsDP3
         3zTiXONqiZGMRZT07QikoHUHv8ttvXgIP5UpzNTiv37RJZ7ESKVcAxNnR6FQI3MK0zWM
         TZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9Kqj0SIpbacTSWIXobu2nBH/kGtCvihRV1cPJE/Vhw=;
        b=calq36QYDiAKP78UoJCEcohb3OeMCXGa6NdyatYqzl8akV1gXX4RYQC1LepLkqC44j
         bv78rMxKyfMwwOymtB/0QK2B/fVAqwIHhm1MkuYNHHZByBOeGmxvOsaY9olPKz3ZMxYL
         0I3RoMO16YRlpg2GIGl0TRygE3YDBm9DaZlQQZQUdYZcwzYcr7wN1x89dXs9/RyKVjnv
         1k9oBjjrnW8EWcH80VPH2rlUygkhPS46rxYRdaa1Ft3CCcHqKtFjO1vSrPPlRIB3VB15
         UvrUOoHqLSpxT8Kgd4qoaLCTBi3aS+fyj2ptXK6QIsSWlGj8K6EgTYebd6FmKvB/tmuM
         SelA==
X-Gm-Message-State: AOAM533oSwTNQnziYQB/nbneWHIY1nQ74CPGXIIdtS+O461mtMQD/WL4
        zqnpGp3Fb1tzJMCyxT4L1d9NMpzjzubkoZUABHzSSA==
X-Google-Smtp-Source: ABdhPJwhaoDuCZGIzPayEcPrlmHJmQ9nskuWBGNrC7P9Gp88PJkramqkokFGYx9VlBV7Rw2+3DTz4OQWOU5R1F/+uqc=
X-Received: by 2002:a05:6402:1d3b:: with SMTP id dh27mr4089846edb.220.1618811529672;
 Sun, 18 Apr 2021 22:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210414122402.203388-1-gi-oh.kim@ionos.com> <20210414122402.203388-14-gi-oh.kim@ionos.com>
 <YHvvdskHgQe9gX09@unreal> <CAJX1YtaN3TmwdOE_8UrRuUU=3cCvtQRBX+DmwvU0Tj3nw-knyg@mail.gmail.com>
 <YH0TBlXxU5cq2eO4@unreal>
In-Reply-To: <YH0TBlXxU5cq2eO4@unreal>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Mon, 19 Apr 2021 07:51:34 +0200
Message-ID: <CAJX1Ytb=nFvfy4KNgHDxHaSp+4z3_Wh5EHXXVgg-dcNU39LAwQ@mail.gmail.com>
Subject: Re: [PATCHv4 for-next 13/19] block/rnbd-clt: Support polling mode for
 IO latency optimization
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, sagi@grimberg.me,
        Bart Van Assche <bvanassche@acm.org>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 7:46 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 07:12:09AM +0200, Gioh Kim wrote:
> > On Sun, Apr 18, 2021 at 10:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Apr 14, 2021 at 02:23:56PM +0200, Gioh Kim wrote:
> > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > >
> > > > RNBD can make double-queues for irq-mode and poll-mode.
> > > > For example, on 4-CPU system 8 request-queues are created,
> > > > 4 for irq-mode and 4 for poll-mode.
> > > > If the IO has HIPRI flag, the block-layer will call .poll function
> > > > of RNBD. Then IO is sent to the poll-mode queue.
> > > > Add optional nr_poll_queues argument for map_devices interface.
> > > >
> > > > To support polling of RNBD, RTRS client creates connections
> > > > for both of irq-mode and direct-poll-mode.
> > > >
> > > > For example, on 4-CPU system it could've create 5 connections:
> > > > con[0] => user message (softirq cq)
> > > > con[1:4] => softirq cq
> > > >
> > > > After this patch, it can create 9 connections:
> > > > con[0] => user message (softirq cq)
> > > > con[1:4] => softirq cq
> > > > con[5:8] => DIRECT-POLL cq
>
> <...>

I am sorry that I don't understand exactly.
Do I need to change them to "con<5..8>"?


>
> > > > +int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
> > > > +{
> > > > +     int cnt;
> > > > +     struct rtrs_con *con;
> > > > +     struct rtrs_clt_sess *sess;
> > > > +     struct path_it it;
> > > > +
> > > > +     rcu_read_lock();
> > > > +     for (path_it_init(&it, clt);
> > > > +          (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
> > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > >
> > > We talked about useless likely/unlikely in your workloads.
> >
> > Right, I've made a patch to remove all likely/unlikely
> > and will send with the next patch set.
>
> This specific line is "brand new". We don't add code that will be
> removed in next patch.

Ah, ok. So you mean,
1. remove unlikely from that line
2. send a patch to remove all likely/unlikely for next round

Am I right?
