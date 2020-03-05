Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3F17A656
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 14:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCEN1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 08:27:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44167 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgCEN1u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Mar 2020 08:27:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id h16so4065385qtr.11
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2020 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MvBuyEZEAHFv7jhM3pasdNsDbFJObNJqsjSHbozpKrc=;
        b=GyecJldonwpP9YLJzXsXLb1oDI2751drGVPPU88vJd3OUES+CqBgcNLXMNHE/qtb/Q
         V2CKzwDWCxui77bNpfLxjSKE66t47r2bIZVAruGXUli8dcmDXuaxw6bfqi1fopj8wEwd
         PtkQhwjRxiKYTTE35+otBEA+Y5FGhxXq4kp24Bj7X5rZ07V9M1iDHhmwv7wZBwJrrx4N
         ccnqb5qZPbdwVrBo2CbVyACqeV3SsDYkSyH7moEjhQxvwOF/JKpAZdKpy2IlnPaKL9FO
         TgqmkyduhwpgUtk+n+ZDFgv5qoUOjFl80VDbyndDKiwsYKU3u2L8MyjiWpO/M8sTqMnU
         K4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MvBuyEZEAHFv7jhM3pasdNsDbFJObNJqsjSHbozpKrc=;
        b=O8QlL7KE3XLlopHiJZyzpGXhCjYFp2P0YlHRbu4NMDE/P1kiRJR2Cm3L6+B/zbo40r
         Zl06//vNlwMKRQ85zLjKxk97FxOThO1kV8xeLS29V4rfv0ffSS1sOMDi4JpFT25P5dkV
         JniaooHoSa86yXs8F8droXl8LgXSeoN+M2YVehNlyN+tWCDSgXuM9e4qWBzH81LxSmGs
         gfeU9HuUWuIUaU/HQNvPUGghAqgJNz/j4plDQKvDafaTU36UMQQ6BvMXUCwn/7L3/qy6
         +dTO1J7sTfF++MN5jL8LURcHwWIGe/qST9etW+Hy0uDGYlzLSq5/gxgEhRhGNFaHplP5
         CoDg==
X-Gm-Message-State: ANhLgQ1UvB0dihS9/bDqSww7VvOq7DfLbzS8SSIYctV896bEF69BLwSQ
        lSPUd1mUzFm9rsv4n/mgsVZTTQ==
X-Google-Smtp-Source: ADFU+vsF2KbIoUCSZBNZFiKZy8RFdjcP9IgNmppBiyDlzxD5kkcWaLbpFiTzlowscJxyIaKVfjUSlQ==
X-Received: by 2002:aed:2a3b:: with SMTP id c56mr7270435qtd.307.1583414869345;
        Thu, 05 Mar 2020 05:27:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m22sm5296882qkk.94.2020.03.05.05.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 05:27:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9qXU-0004t2-AG; Thu, 05 Mar 2020 09:27:48 -0400
Date:   Thu, 5 Mar 2020 09:27:48 -0400
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
Message-ID: <20200305132748.GH31668@ziepe.ca>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
 <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org>
 <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
 <20200304164903.GF31668@ziepe.ca>
 <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 12:26:01PM +0100, Jinpu Wang wrote:

> We have to admit, the code snip is from null_blk, get_tag function,
> not invented by us.
> the get_cpu/put_cpu was added to get/save the current cpu_id, which
> can be removed around the do-while loop.,
> we only need to raw_smp_processor_id to get current cpu, we use it
> later to pick which connection to use.

Be careful copying crazy core code into drivers.. 

> > You have to do something to provably guarantee the send q cannot
> > overflow. send q overflow is defined as calling post_send before a
> > poll_cq has confirmed space is available for send.

> Shouldn't the cq api handle that already,  with IB_POLL_SOFTIRQ,
> poll cq is done on very softirq run, so send queue space should be reclaimed
> fast enough, with IB_POLL_WORKQUEUE, when cq->com_handler get called,
> the ib_cq_poll_work will do the poll_cq, together with extra
> send_queue size reserved,
> the send queue can not overflow!

Somehow that doesn't sound like 'provably guarentee' - that is some
statistical argument..

Jason
