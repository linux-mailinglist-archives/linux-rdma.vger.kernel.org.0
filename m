Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5D363B1B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhDSFqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 01:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbhDSFqd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 01:46:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA413610A1;
        Mon, 19 Apr 2021 05:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618811164;
        bh=SLojhiOvfRCFXjc5NCFL296OziyuGBgPJxxa+RATbBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOQsuv9crLx0GjgrW/f83KOdrUTtjoEK6mgkEE8tB7AbniFaiE/NVu7I3MiFFHnOI
         dyrJxOdSsHRFXhfNJ2rr68GX9o3oqvCQU72V3g37LISkbguk5kr8Z/CCYv1rKEDDJm
         CEbgl+V7CWGswqorOLy9k0XB6NOQCD2EITRdCWksz2Vvm3r5myHau6rAgdcRSA1jD1
         ryKBB9kF+q4lmhVhUcT28Xm5BGiqic66CnhS7E/Oy2fDbB/miV4ZxZGNBCprAQG1Pz
         jEuhTBRlgulUspaxWLT8d5pyjIMnPGE6omLRRVvmkdXqwlju8Bgv+vouO4o7eQG4qX
         KV2zRKPiq86/w==
Date:   Mon, 19 Apr 2021 08:20:06 +0300
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
Message-ID: <YH0TBlXxU5cq2eO4@unreal>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
 <20210414122402.203388-14-gi-oh.kim@ionos.com>
 <YHvvdskHgQe9gX09@unreal>
 <CAJX1YtaN3TmwdOE_8UrRuUU=3cCvtQRBX+DmwvU0Tj3nw-knyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX1YtaN3TmwdOE_8UrRuUU=3cCvtQRBX+DmwvU0Tj3nw-knyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 07:12:09AM +0200, Gioh Kim wrote:
> On Sun, Apr 18, 2021 at 10:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Apr 14, 2021 at 02:23:56PM +0200, Gioh Kim wrote:
> > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > >
> > > RNBD can make double-queues for irq-mode and poll-mode.
> > > For example, on 4-CPU system 8 request-queues are created,
> > > 4 for irq-mode and 4 for poll-mode.
> > > If the IO has HIPRI flag, the block-layer will call .poll function
> > > of RNBD. Then IO is sent to the poll-mode queue.
> > > Add optional nr_poll_queues argument for map_devices interface.
> > >
> > > To support polling of RNBD, RTRS client creates connections
> > > for both of irq-mode and direct-poll-mode.
> > >
> > > For example, on 4-CPU system it could've create 5 connections:
> > > con[0] => user message (softirq cq)
> > > con[1:4] => softirq cq
> > >
> > > After this patch, it can create 9 connections:
> > > con[0] => user message (softirq cq)
> > > con[1:4] => softirq cq
> > > con[5:8] => DIRECT-POLL cq

<...>

> > > +int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
> > > +{
> > > +     int cnt;
> > > +     struct rtrs_con *con;
> > > +     struct rtrs_clt_sess *sess;
> > > +     struct path_it it;
> > > +
> > > +     rcu_read_lock();
> > > +     for (path_it_init(&it, clt);
> > > +          (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
> > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> >
> > We talked about useless likely/unlikely in your workloads.
> 
> Right, I've made a patch to remove all likely/unlikely
> and will send with the next patch set.

This specific line is "brand new". We don't add code that will be
removed in next patch.

Thanks
