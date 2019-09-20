Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C7B8CE3
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408206AbfITIaK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 04:30:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41069 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408194AbfITIaK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 04:30:10 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so14246622ioh.8
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2019 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cfWuNy3xibIXl+j47fWfRq14jBulXO0LL+BHoT7mRk=;
        b=Qz6XxsGb+h6rTjluc/X3rSMVnQG6U9CcXmMFEcVOa8mcPyLF5AvYN3M9I2CU1+wGYC
         N1zFWY2CxCk4mCYlXYMC5WePGdbKo+rvjJSvOUspoZ20pbnQjVMU4U2j7pAztrT0MD2d
         eGva8Fjf47rJIosmdxDWRivxQYXPkhWotpYJc19FThOcWr3GbisX0E3dzk0PjhmKv0bi
         F4yP0YAKCOyX7JQ55HoSbmZwfdhkxP2nYYm4/zfALhu9RIL+dnru8oBGidj6znEIidt5
         dsvbg2k69UqEp1eJfXGCvmHhR/+2yv7HLpTC6Pf2eKt2wmMkG3e28Dzb4lc5S1RuuKgz
         H4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cfWuNy3xibIXl+j47fWfRq14jBulXO0LL+BHoT7mRk=;
        b=TABqGq5YjKQz66akL6WGtN7izRGs3FI3divxbSfqwlisTlLV6slqo1tmqww/yY4Gx8
         e5JZShMpptkgVP3DEDDjLOu4Xqj8qVbmuJBquN8DuRA3AeegharcGjzYco39p8f8QM1i
         741aHMwxj9GeTClNaKd5nEN15jAAR4Q+HYvVl5T6mTv9sQc2RLMosdM6MIV2RbFNUNaj
         lSB9IcpfCpBV1+IvYecPYDCwt4/8aITNklkuHB8N4Yx3clMUBgTYHhTK4rZcq+d8KHcB
         sz4bdZp/vDo3K9vWOSoQ6aFUu7aAKVDwqtb/KR/8/TyRnSa4jT72rnVAezssK5G9q2ld
         2foQ==
X-Gm-Message-State: APjAAAVrKG6NHLmOTd8Kr5uFTn8hQzR38TQ6VBQQgpu2xoOJKstXpJ5L
        dWXXI+iGBhqCbmDLEZCVxlQt3XH+Oloo5w11LePQ
X-Google-Smtp-Source: APXvYqyYPlrTcpvJV+pdTyQWm2sPaWvfIN3T+LGpf3psCx84ynJyhnC4v76Nkcme3sq5h87l0rGSzvrIeJnGIp9Vvb8=
X-Received: by 2002:a6b:db0a:: with SMTP id t10mr18421833ioc.300.1568968209207;
 Fri, 20 Sep 2019 01:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com> <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
In-Reply-To: <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 20 Sep 2019 10:29:58 +0200
Message-ID: <CAHg0HuzsbGMmk-_ooTMDKQJYuAdAVrOvW-tzWgN-NNX7tcGgxA@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Roman Pen <r.peniaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 18, 2019 at 5:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/18/19 12:14 AM, Danil Kipnis wrote:
> > I'm not familiar with dm code, but don't they need to deal with the
> > same situation: if I configure 100 logical volumes on top of a single
> > NVME drive with X hardware queues, each queue_depth deep, then each dm
> > block device would need to advertise X hardware queues in order to
> > achieve highest performance in case only this one volume is accessed,
> > while in fact those X physical queues have to be shared among all 100
> > logical volumes, if they are accessed in parallel?
>
> Combining multiple queues (a) into a single queue (b) that is smaller
> than the combined source queues without sacrificing performance is
> tricky. We already have one such implementation in the block layer core
> and it took considerable time to get that implementation right. See e.g.
> blk_mq_sched_mark_restart_hctx() and blk_mq_sched_restart().
We will need some time, to check if we can reuse those...

> dm drivers are expected to return DM_MAPIO_REQUEUE or
> DM_MAPIO_DELAY_REQUEUE if the queue (b) is full. It turned out to be
> difficult to get this right in the dm-mpath driver and at the same time
> to achieve good performance.
We also first tried to just return error codes in case we can't
process an incoming request, but this was causing huge performance
degradation when number of devices mapped over the same session is
growing. Since we introduced those per cpu per devices lists of
stopped queues, we do scale very well.

>
> The ibnbd driver introduces a third implementation of code that combines
> multiple (per-cpu) queues into one queue per CPU. It is considered
> important in the Linux kernel to avoid code duplication. Hence my
> question whether ibnbd can reuse the block layer infrastructure for
> sharing tag sets.
Yes, will have to reiterate on this.
