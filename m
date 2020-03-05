Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2E17A6C8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCENy6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 08:54:58 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43316 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCENy6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Mar 2020 08:54:58 -0500
Received: by mail-qv1-f66.google.com with SMTP id eb12so2424607qvb.10
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2020 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6shA/MnYAo64Iv5nNYwoW40lynjB702RbgFxOYlHj2Q=;
        b=Q1P/g+wM9TAuJRxT1OM8LC1VO26zCTX1t3mMVBWgsuEFH+kp9TXP1E7IihdcBzTcG4
         23txlMlVQ10BsN5iNh0FvFdY+jJauX9XYLoe3EdTcKZ+qT3ghLp+EZyKJlIi/HGd0qv+
         euwnkS1EvnM6pKJ8Yc4aCudQny584wRqPEIhyulAPq9cVqg1ZWpZefM3exWWSeR+o+dU
         rWPuqDaBHUCs9Xa7rudNAwZ4EsXQtxkz9pCEAYwtpCEAhyOd8JAPJHDEOWNCUcx3CikT
         zCU0RaBvtCdc2l9OrthUALIbUMAsAY/sc73wchRhmF1u3LPQSIFfIa3NpR2k7gZz4BZA
         /gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6shA/MnYAo64Iv5nNYwoW40lynjB702RbgFxOYlHj2Q=;
        b=kRq0vciwcK6uplNfHGu+Wp7+c8ToKsiU3b2TTsCSKvuRzp1hcrvacvlvF93Au1CK45
         0GhQQ7Vk7m8h1KpZis7iEML6bo1wBL7xJZx072hjYT+8bvVbXWqQOOXtiW0jEZKNRskT
         BpF7WLlkvp29tLNHL9YEb9yf1LXdUUDpoL5J1uryRe+hVGLVzgfL6vegNI5Nqh4Xq54F
         CU3TBF5eT6M7I9ulDcFojqt+bF9Q8d3msR4K5DzGBYudiszDI/ThqtNZgkicoAc2Arjm
         pbBJA1XzkBXVZH36xewwiBmsJ2SHw9/OsHhqDMFj3WjwFCqTf6ZYQWKAByvRu4Bs3TF9
         NGAQ==
X-Gm-Message-State: ANhLgQ0IL3Dt91GyrtWj0uTkwcxd1Zjps2fj2lftVyU0BuMSPCLEXUYh
        HQgojfAOJuM0CBY2/a0UnOcFmw==
X-Google-Smtp-Source: ADFU+vvS68RTysru2IhFJZQRzpof/V4eDEbpw9z05fwXzj39bktxl0rtF7uWkg8rjyFsXiElRPIpSg==
X-Received: by 2002:a0c:ca94:: with SMTP id a20mr6313765qvk.150.1583416496798;
        Thu, 05 Mar 2020 05:54:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w204sm3081864qkb.133.2020.03.05.05.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 05:54:56 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9qxj-0005JD-Of; Thu, 05 Mar 2020 09:54:55 -0400
Date:   Thu, 5 Mar 2020 09:54:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
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
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
Message-ID: <20200305135455.GI31668@ziepe.ca>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
 <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org>
 <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
 <20200304164903.GF31668@ziepe.ca>
 <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
 <20200305132748.GH31668@ziepe.ca>
 <CAMGffEkYvTit0Zv6HMDaUgo8kLEOLs_8vex7p1qgVeUDUxa4XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkYvTit0Zv6HMDaUgo8kLEOLs_8vex7p1qgVeUDUxa4XA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 02:37:59PM +0100, Jinpu Wang wrote:
> On Thu, Mar 5, 2020 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Mar 05, 2020 at 12:26:01PM +0100, Jinpu Wang wrote:
> >
> > > We have to admit, the code snip is from null_blk, get_tag function,
> > > not invented by us.
> > > the get_cpu/put_cpu was added to get/save the current cpu_id, which
> > > can be removed around the do-while loop.,
> > > we only need to raw_smp_processor_id to get current cpu, we use it
> > > later to pick which connection to use.
> >
> > Be careful copying crazy core code into drivers..
> >
> > > > You have to do something to provably guarantee the send q cannot
> > > > overflow. send q overflow is defined as calling post_send before a
> > > > poll_cq has confirmed space is available for send.
> >
> > > Shouldn't the cq api handle that already,  with IB_POLL_SOFTIRQ,
> > > poll cq is done on very softirq run, so send queue space should be reclaimed
> > > fast enough, with IB_POLL_WORKQUEUE, when cq->com_handler get called,
> > > the ib_cq_poll_work will do the poll_cq, together with extra
> > > send_queue size reserved,
> > > the send queue can not overflow!
> >
> > Somehow that doesn't sound like 'provably guarentee' - that is some
> > statistical argument..
> Could you give an example which meets the "provably guarantee",
> seems most of the driver is based on the cq API.

You are supposed to directly keep track of completions and not issue
sends until completions are seen.

Jason
