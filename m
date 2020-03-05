Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98417A686
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgCENiL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 08:38:11 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43081 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCENiL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Mar 2020 08:38:11 -0500
Received: by mail-il1-f196.google.com with SMTP id o18so5014362ilg.10
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2020 05:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiApMWEDHxnOhBvvVyZsuR3dqipfMmsChaKxG3d2+kQ=;
        b=OCfN8uhoUyBu9z3uTzwYl+YzmINVCAzP+LWtoU+4xskqcK7yrikiyqsS6Ll6DvTFv+
         Rqi080TXXTt1gGGAK1Tfj4gV/I4mdBogW9LOCaES1HahaIBz7spKEAHelsCMcptOOzSP
         ffG23d6Ngkt1anlfKwCQJLECBij1RL8FAqHj+uZ9m0eyN/zc0CBLWGoR8DFuTfD/sRr2
         pJ7M4dwuUz9Z/Tnq5lcZHdJ4m0VhaW0se3CvbynVPkyUGHaw9sbBimni9vB40TFzjoF4
         OrzRd6sD6+9Yg4Wjp9S/rRt9m8kzUDAf+4LqmkAxyYq5GlX+atu/xIC5MIVUQPNErTGc
         D5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiApMWEDHxnOhBvvVyZsuR3dqipfMmsChaKxG3d2+kQ=;
        b=f8hXi8FvslE07WKZ7i8qFASiLzgnclKgQrtpJ4CnIq3jYavo2XwwmQ3bb91BOMtglD
         eZV6WwIJkE7XA0H6cpGmz9kViee73FI63IGkBY0ENjKVOBJpKA6KGCPZgkwro4pDOMPT
         RQ9S2gIc3PRyWzlE5mMb4leMrYoVsGGFEY/9JFjPb/svdFKxSUV5tWV/ZghV4f1Xt3U5
         aIhu9D3kpqKoRQ1y9xXTwuiuM+rfuKLsmFZ941hZYzolnyMl/Ksrrr/9hBLHrPrG7VN0
         Y6iY+lwqNxYJUouunjyP1V+2F+UlzxEru8VhGfQskxprwGwDtsvfK20H+y3xwsXm7Zz/
         AXjg==
X-Gm-Message-State: ANhLgQ15R/2GmHfsZW+Px5KYHCTBEQAXE2ZOmvpIM9DlkC115fHImFpy
        UGewTAwPKyk4OWSyVkpV5D3W2sC/7cJ8UxzhynaedQ==
X-Google-Smtp-Source: ADFU+vvBY2rBx4ruOSMcOjobCb0gd4sgwtTXfphEfkID2CT5qwZSrAHBz/aWPj2ijf1E0uoGA8LlSc3GdoX0fLMr/XQ=
X-Received: by 2002:a92:670f:: with SMTP id b15mr8172209ilc.71.1583415490320;
 Thu, 05 Mar 2020 05:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org> <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org> <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
 <20200304164903.GF31668@ziepe.ca> <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
 <20200305132748.GH31668@ziepe.ca>
In-Reply-To: <20200305132748.GH31668@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 5 Mar 2020 14:37:59 +0100
Message-ID: <CAMGffEkYvTit0Zv6HMDaUgo8kLEOLs_8vex7p1qgVeUDUxa4XA@mail.gmail.com>
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 5, 2020 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Mar 05, 2020 at 12:26:01PM +0100, Jinpu Wang wrote:
>
> > We have to admit, the code snip is from null_blk, get_tag function,
> > not invented by us.
> > the get_cpu/put_cpu was added to get/save the current cpu_id, which
> > can be removed around the do-while loop.,
> > we only need to raw_smp_processor_id to get current cpu, we use it
> > later to pick which connection to use.
>
> Be careful copying crazy core code into drivers..
>
> > > You have to do something to provably guarantee the send q cannot
> > > overflow. send q overflow is defined as calling post_send before a
> > > poll_cq has confirmed space is available for send.
>
> > Shouldn't the cq api handle that already,  with IB_POLL_SOFTIRQ,
> > poll cq is done on very softirq run, so send queue space should be reclaimed
> > fast enough, with IB_POLL_WORKQUEUE, when cq->com_handler get called,
> > the ib_cq_poll_work will do the poll_cq, together with extra
> > send_queue size reserved,
> > the send queue can not overflow!
>
> Somehow that doesn't sound like 'provably guarentee' - that is some
> statistical argument..
Could you give an example which meets the "provably guarantee",
seems most of the driver is based on the cq API.
>
> Jason
Thanks!
