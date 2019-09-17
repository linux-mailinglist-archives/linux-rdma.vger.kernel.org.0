Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D371BB4D0D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfIQLj5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 07:39:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43653 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfIQLj5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 07:39:57 -0400
Received: by mail-io1-f65.google.com with SMTP id v2so6699633iob.10
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GM5dAw36g0uZRkNYW0MZh7KdhJ4BQOzcGzfoUekvZ7k=;
        b=PNuAb0Gv7jvIEflNfG3Kvie1iHDGlpxJqcxAiZsQ9s5LE5fUiLI0SMQKnhASq7Hxwq
         GbRKFZJpXPGciqw57n/p6zyBLykfJiyoFu2Higrx18OQE/fHCuCN4BEwbH3AMkut0bT5
         URLL7/bfnSNTiWD4Gg6A7QK4IoD4N3/guDNU50bfvF551oM7r2TKiWBG5xQBdryvSJAi
         1RESQZLbfCcFJLpL/DLyWSn70Q7bd/Axdo4LqLvXYYTzidO21/R2+frdzW1clWti4YB/
         ToTsdpCBccxXlfXndq62GPBe1GONZGWTfYzpzWoMBPKSVajLSqpI5GiqXPJSxZT7s2SA
         UQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GM5dAw36g0uZRkNYW0MZh7KdhJ4BQOzcGzfoUekvZ7k=;
        b=PdYEWcXUmR9KNhJVtgtv5M0z69KbIYgqBL0kOGOVubsuQuSvJICN6KKRm2Z6ugdL1a
         9jDFoIxAZPKW2HQ2NhYnylGVTHbaObw6y5C+NVGLX+5F0YEvjJ0KQ3JpFc/nNTv4hC+s
         m71D/yLq+Bvjgur7N19vmW/JUg4Y8/1miShQAFU5hwF6PjSVPSiVE5b7bjV7Zi5323n3
         LsGPIMTCCQhxL/z7853EflfJrSdtlyH70+f9pVahz0fe5AqtfwObvgTkombkvg1RdI35
         c4MBBoFNaceHHhqITFLUT1qQuUdQT1Thm6/VjI4RIeI7dSXW/ObPfkoeQ7NJ32uGPrg7
         mvIA==
X-Gm-Message-State: APjAAAUdjGDVrNkK4D5gztwIcIVvSl3Q/VJCp4I2+xKB6P0yUF32umy/
        GswHvu9cqcy33anp9i23t/8k8re8lhRqXy4BqHJYjW1o62OP
X-Google-Smtp-Source: APXvYqwjtz3gnRg8Iv1L+2X4q2YjLK6ljbEgDL7zghLihEP+Lxkt6Lv9ODzAUZ1gB1IH227EQ8B6vAmL49UxEGBLZCw=
X-Received: by 2002:a02:a909:: with SMTP id n9mr3598934jam.57.1568720394697;
 Tue, 17 Sep 2019 04:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org>
In-Reply-To: <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 13:39:43 +0200
Message-ID: <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
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

On Mon, Sep 16, 2019 at 6:46 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/16/19 7:17 AM, Danil Kipnis wrote:
> > On Sat, Sep 14, 2019 at 1:46 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 6/20/19 8:03 AM, Jack Wang wrote:
> >>> +/*
> >>> + * This is for closing devices when unloading the module:
> >>> + * we might be closing a lot (>256) of devices in parallel
> >>> + * and it is better not to use the system_wq.
> >>> + */
> >>> +static struct workqueue_struct *unload_wq;
> >>
> >> I think that a better motivation is needed for the introduction of a new
> >> workqueue.
>  >
> > We didn't want to pollute the system workqueue when unmapping a big
> > number of devices at once in parallel. Will reiterate on it.
>
> There are multiple system workqueues. From <linux/workqueue.h>:
>
> extern struct workqueue_struct *system_wq;
> extern struct workqueue_struct *system_highpri_wq;
> extern struct workqueue_struct *system_long_wq;
> extern struct workqueue_struct *system_unbound_wq;
> extern struct workqueue_struct *system_freezable_wq;
> extern struct workqueue_struct *system_power_efficient_wq;
> extern struct workqueue_struct *system_freezable_power_efficient_wq;
>
> Has it been considered to use e.g. system_long_wq?
Will try to switch to system_long_wq, I do agree that a new wq for
just closing devices does make an impression of an overreaction.

>
> >> A more general question is why ibnbd needs its own queue management
> >> while no other block driver needs this?
> >
> > Each IBNBD device promises to have a queue_depth (of say 512) on each
> > of its num_cpus hardware queues. In fact we can only process a
> > queue_depth inflights at once on the whole ibtrs session connecting a
> > given client with a given server. Those 512 inflights (corresponding
> > to the number of buffers reserved by the server for this particular
> > client) have to be shared among all the devices mapped on this
> > session. This leads to the situation, that we receive more requests
> > than we can process at the moment. So we need to stop queues and start
> > them again later in some fair fashion.
>
> Can a single CPU really sustain a queue depth of 512 commands? Is it
> really necessary to have one hardware queue per CPU or is e.g. four
> queues per NUMA node sufficient? Has it been considered to send the
> number of hardware queues that the initiator wants to use and also the
> command depth per queue during login to the target side? That would
> allow the target side to allocate an independent set of buffers for each
> initiator hardware queue and would allow to remove the queue management
> at the initiator side. This might even yield better performance.
We needed a way which would allow us to address one particular
requirement: we'd like to be able to "enforce" that a response to an
IO would be processed on the same CPU the IO was originally submitted
on. In order to be able to do so we establish one rdma connection per
cpu, each having a separate cq_vector. The administrator can then
assign the corresponding IRQs to distinct CPUs. The server always
replies to an IO on the same connection he received the request on. If
the administrator did configure the /proc/irq/y/smp_affinity
accordingly, the response sent by the server will generate interrupt
on the same cpu, the IO was originally submitted on. The administrator
can configure IRQs differently, for example assign a given irq
(<->cq_vector) to a range of cpus belonging to a numa node, or
whatever assignment is best for his use-case.
Our transport module IBTRS establishes number of cpus connections
between a client and a server. The user of the transport module (i.e.
IBNBD) has no knowledge about the rdma connections, it only has a
pointer to an abstract "session", which connects  him somehow to a
remote host. IBNBD as a user of IBTRS creates block devices and uses a
given "session" to send IOs from all the block devices it created for
that session. That means IBNBD is limited in maximum number of his
inflights toward a given remote host by the capability of the
corresponding "session". So it needs to share the resources provided
by the session (in our current model those resources are in fact some
pre registered buffers on server side) among his devices.
It is possible to extend the IBTRS API so that the user (IBNBD) could
specify how many connections he wants to have on the session to be
established. It is also possible to extend the ibtrs_clt_get_tag API
(this is to get a send "permit") with a parameter specifying the
connection, the future IO is to be send on.
We now might have to change our communication model in IBTRS a bit in
order to fix the potential security problem raised during the recent
RDMA MC: https://etherpad.net/p/LPC2019_RDMA.

>
> >>> +static void msg_conf(void *priv, int errno)
> >>> +{
> >>> +     struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;
> >>
> >> The kernel code I'm familiar with does not cast void pointers explicitly
> >> into another type. Please follow that convention and leave the cast out
> >> from the above and also from similar statements.
> > msg_conf() is a callback which IBNBD passes down with a request to
> > IBTRS when calling ibtrs_clt_request(). msg_conf() is called when a
> > request is completed with a pointer to a struct defined in IBNBD. So
> > IBTRS as transport doesn't know what's inside the private pointer
> > which IBNBD passed down with the request, it's opaque, since struct
> > ibnbd_iu is not visible in IBTRS. I will try to find how others avoid
> > a cast in similar situations.
>
> Are you aware that the C language can cast a void pointer into a
> non-void pointer implicitly, that means, without having to use a cast?
Oh, I misunderstood your original comment: you suggest to just remove
the explicit (struct ibnbd_iu *) and similar casts from void pointers.
I think an explicit cast makes it easier for readers to follow the
code. But it does say "Casting the return value which is a void
pointer is redundant." at least in the "Allocating Memory" section of
https://www.kernel.org/doc/html/v4.10/process/coding-style.html and
seems others don't do that, at least not when declaring a variable.
Will drop those casts.
