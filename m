Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F96BEF19
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfIZJ4C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 05:56:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38512 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfIZJ4C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 05:56:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id m16so1556732oic.5;
        Thu, 26 Sep 2019 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7QiJenNKxBa3/26UANfbTTYekrIvyL4x477K5pCRuA=;
        b=pEYTOCcm1DEqg3InE5EGDE7EUod3egkoekuRL+gIIAx/ENObwO8RJRqKcjgOv5oBZr
         Y868etL8PzrzwloN89W5ZvdHKzspjhBOIdWfgGF4DL0EaLlwdWtGnzRZlchLrMLZvHAA
         ZlJQPzHmQs1IX513OPcGQ6PGxcZshGlaodi8GxMXqCi6I5/xmedZsOw2LLGCBj1Ezlay
         WmW2sqx/HQUz7U5OwMx0f6YB/mDsaPa4u3l5lzm9M7FeGBfmsKCoeS9PVTThO10PV4W/
         pxPCsKglBTWirRWF+p0+sEXwD48Tfz4AG1zu/rd1NGGQQy0gjK0urt1NCdML+lCVtVBh
         PdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7QiJenNKxBa3/26UANfbTTYekrIvyL4x477K5pCRuA=;
        b=ehje4FW1alzkaiEbQqYo30pPUKyAdgwY593PuF/AWXHng8PfN8j1mIUJEJ6wswsRui
         MyH1F7AU5/FuqQhfbOzAwMWCFlH3i+aqpWv0UKFmz37nVeOqs/wZrXsZzu4R0hBIUpnO
         HMtTKiHYEOagm0Hr5ulLCEmhuKVzX1MEllRFUM5zn+GNXjGfUeteQJy1UnPjLFC9d5g0
         mE7FG/vnO/Tu2ZzUrs0J265MrG9ygfn9WdtOfCFvpT/6O2lxnddUvn4jXcyVoCDGfr5L
         3gnDDx43DuF6blksjrWCBOOSOB4RLX1PP4SxCRbJjZmrU2RQC1iV/zwmbjRNpz1DDnrq
         Ylig==
X-Gm-Message-State: APjAAAVbNU7ICSLQDiZ69KPQ2SEquI9VWMboBnHImYEjmR38gOid6gZ0
        DnJ0suAmmQgjJhQxBwtIRL8sYn+L0iRq6Q+k1xE=
X-Google-Smtp-Source: APXvYqzNH1fW9xKBKe6Z3YY60fwvZHmm384uLRC+kPxdxa6fbO3MLQW251lNrni7PIHWCYhj91MQpvFQr1LACnvcfHo=
X-Received: by 2002:aca:3ed7:: with SMTP id l206mr1944265oia.25.1569491761364;
 Thu, 26 Sep 2019 02:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
 <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org> <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
In-Reply-To: <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
From:   Roman Penyaev <r.peniaev@gmail.com>
Date:   Thu, 26 Sep 2019 11:55:50 +0200
Message-ID: <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 26, 2019 at 12:26 AM Danil Kipnis
<danil.kipnis@cloud.ionos.com> wrote:
>
> On Wed, Sep 18, 2019 at 5:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > Combining multiple queues (a) into a single queue (b) that is smaller
> > than the combined source queues without sacrificing performance is
> > tricky. We already have one such implementation in the block layer core
> > and it took considerable time to get that implementation right. See e.g.
> > blk_mq_sched_mark_restart_hctx() and blk_mq_sched_restart().
>
> Roma, can you please estimate the performance impact in case we switch to it?

As I remember correctly I could not reuse the whole machinery with those
restarts from block core because shared tags are shared only between
hardware queues, i.e. different hardware queues share different tags sets.
IBTRS has many hardware queues (independent RDMA connections) but only one
tags set, which is equally shared between block devices.  What I dreamed
about is something like BLK_MQ_F_TAG_GLOBALLY_SHARED support in block
layer.

--
Roman
