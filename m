Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A86BC0185
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfI0Iwu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 04:52:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32774 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfI0Iwt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 04:52:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id o9so828114otl.0;
        Fri, 27 Sep 2019 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viPyc6txsVnn9ZEJNFT6H54DEyJqpwoqVakjY1bNS08=;
        b=WvXYluVmDXywwLPRJBTFK9ab3x3ibDevvChfnKdeRmGQmQ2QQfoz6ORo9waSkK5nG+
         3FEvgjlk9DlgSnnYWoroorbExyrI6e2RM46dBJPoSCdJPhdX9WNRMOwn2r7JfwJwEXUU
         xEqTVzG3/THZbxRIz7Elwc8jWgjej6WgR9Tb0mwMSaso36fZDnW7jc2v6UI8zSyg4+fZ
         DT2+s6HbGnM8uM1fhMyRJtrj/4bJ0lneoAtN0rC9ARakXp5jNjqsi/ek7OBY0eL/o9qx
         u9/TfXiICOqeNVYDwFFLIi36byFoc2raHDgmWaQ65l3L627PMkjhcAigHM5is1qAFZW7
         C9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viPyc6txsVnn9ZEJNFT6H54DEyJqpwoqVakjY1bNS08=;
        b=XAAvchk/6SWGPfwAFU4qWEg0HYGoXLDoywT8Byn7YT5o7wTfPNufHswCSKx3fD9CWs
         AZPe6xq2LSKjkTMH9dktRGQrsrbsXlvBPqEBbkHakCUBH24HmJg+Fn/UhciE9dZKfONF
         4cEeEl19gOsoP31mcntagiXQsUmRXRPMOVOUly8C/YcH+OIUhc6ddzLKQHrV4zxJqF+a
         0+N4UeZMvVqReMjtN5VP8q/lq6woGcdRenk5QjpQqGq9+caYjnaKnnSuMZL3xi9A/Rr2
         70LPseYaDI25A40LlX+EMADI9H6pjDUpVeMZcVfJT5MAdJj+2NaDTpBkTeuH+UBEKYDh
         jaxQ==
X-Gm-Message-State: APjAAAWMqVcUeIDsyMmlqv8U1PvHMdVb2j+Z1TJdNM1M08mDmGxICCJa
        Tx1t7NkJqxlvyjxPKc2GGaInSmFyMxsMwSR0qGE=
X-Google-Smtp-Source: APXvYqwBIw1mFQ7BPjJBAweb0uTnGzbRswJ1ti/c8F91tUghSHryYMY8eQSYg3ZlLb64fVgE2WmMeF0t+ydfOKgcdMw=
X-Received: by 2002:a9d:7207:: with SMTP id u7mr2270486otj.59.1569574368808;
 Fri, 27 Sep 2019 01:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
 <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org> <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
 <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com> <e2056b1d-b428-18c7-8e22-2f37b91917c8@acm.org>
In-Reply-To: <e2056b1d-b428-18c7-8e22-2f37b91917c8@acm.org>
From:   Roman Penyaev <r.peniaev@gmail.com>
Date:   Fri, 27 Sep 2019 10:52:37 +0200
Message-ID: <CACZ9PQU8=4DaSAUQ7czKdcWio2H5HB1ro-pXaY2VP9PhgTxk7g@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
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

On Thu, Sep 26, 2019 at 5:01 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/26/19 2:55 AM, Roman Penyaev wrote:
> > As I remember correctly I could not reuse the whole machinery with those
> > restarts from block core because shared tags are shared only between
> > hardware queues, i.e. different hardware queues share different tags sets.
> > IBTRS has many hardware queues (independent RDMA connections) but only one
> > tags set, which is equally shared between block devices.  What I dreamed
> > about is something like BLK_MQ_F_TAG_GLOBALLY_SHARED support in block
> > layer.
>
> A patch series that adds support for sharing tag sets across hardware
> queues is pending. See also "[PATCH V3 0/8] blk-mq & scsi: fix reply
> queue selection and improve host wide tagset"
> (https://lore.kernel.org/linux-block/20180227100750.32299-1-ming.lei@redhat.com/).
> Would that patch series allow to remove the queue management code from
> ibnbd?

Hi Bart,

No, it seems this thingy is a bit different.  According to my
understanding patches 3 and 4 from this patchset do the
following: 1# split equally the whole queue depth on number
of hardware queues and 2# return tag number which is unique
host-wide (more or less similar to unique_tag, right?).

2# is not needed for ibtrs, and 1# can be easy done by dividing
queue_depth on number of hw queues on tag set allocation, e.g.
something like the following:

    ...
    tags->nr_hw_queues = num_online_cpus();
    tags->queue_depth  = sess->queue_deph / tags->nr_hw_queues;

    blk_mq_alloc_tag_set(tags);


And this trick won't work out for the performance.  ibtrs client
has a single resource: set of buffer chunks received from a
server side.  And these buffers should be dynamically distributed
between IO producers according to the load.  Having a hard split
of the whole queue depth between hw queues we can forget about a
dynamic load distribution, here is an example:

   - say server shares 1024 buffer chunks for a session (do not
     remember what is the actual number).

   - 1024 buffers are equally divided between hw queues, let's
     say 64 (number of cpus), so each queue is 16 requests depth.

   - only several CPUs produce IO, and instead of occupying the
     whole "bandwidth" of a session, i.e. 1024 buffer chunks,
     we limit ourselves to a small queue depth of an each hw
     queue.

And performance drops significantly when number of IO producers
is smaller than number of hw queues (CPUs), and it can be easily
tested and proved.

So for this particular ibtrs case tags should be globally shared,
and seems (unfortunately) there is no any other similar requirements
for other block devices.

--
Roman
