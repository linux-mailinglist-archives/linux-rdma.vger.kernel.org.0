Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC25B5DD3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 09:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfIRHOa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 03:14:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38142 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfIRHOa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 03:14:30 -0400
Received: by mail-io1-f65.google.com with SMTP id k5so13768423iol.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2019 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Fe8lMz3nu3DkuRuqTBMWyNe1rSmwdNbpffxzroPwu0=;
        b=g4lkSKMDPbz0rhxB9Wxt1e6dOJhHvTKiAY1fCX4KWuuHAhVWGAHQy4MCzDimN/bU4l
         +Mwg6zYLkAA5Kbe1h+LB3/n2WauvbVuois5/p2AGu0o1f+6ksKYsiQAKSf3q5j+E4ykv
         vkXYRTkApLv7EolCqwbkobRpJdR6+NJzi5AtT6x0eIMjfLizs5i8aQ5r+XHKHwNJzjaY
         HnoFJ4rc7ew6Nqy8XDS9gCeFKoAxwEn5lZV2JxGSI8SAF9Ajc+M8v2reAeZmqdyKe580
         65EUTY/gxCJsJr1Eu2ehD3fQKmhI1iCqqg71OD6Y6poGkALX2PbiYadUptRnayYhEBzy
         NDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Fe8lMz3nu3DkuRuqTBMWyNe1rSmwdNbpffxzroPwu0=;
        b=PJWNmCkfb1NsbcE/nAYj6xVReOajD/dZALX1KKlFmE0KALj2yV4DxaFHx8Xlfs0Yor
         5RNf4WsTp8HI0QLD/kTNVoygUMzy/2w8iRP2PA7XQAWQP5tIyMCG50GmLqMqdmX/Cc1w
         xh/tNd+WyR27F9UyQNYPssBgnAXMukdivU0GcpyHKnhbtZUeThGDhicKhE34YdN9xKL9
         DhbcRq0u18F9vmIYGlwo43+NMvq3Oek41xDxRIB2C+XsZm16QxSHttVV7YT9N7xkM02E
         zUEOiC9/aNtuRcH6s4+hBZubs4CKEAE8HTAW/zJi7BUHkMp6lncJeobutVdqkxF9c5Ra
         ZLcg==
X-Gm-Message-State: APjAAAUgug8Z+7gWHDfXa+yn+LVNBsc0SSu35dhAe8o90YZkpZsFd1Ib
        PkfuYNZP8sP601Vm9TJwgn0cnUVgPOw4i0pwAPBM
X-Google-Smtp-Source: APXvYqy1oH15fLM5dvwG2VuUPETsK4JOqyeoe29W9SYdiTP0kTddTohlesNb9igimtNFq+pJneymroWDSSh0voLHiCc=
X-Received: by 2002:a05:6638:5ba:: with SMTP id b26mr1707022jar.57.1568790869085;
 Wed, 18 Sep 2019 00:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
In-Reply-To: <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 18 Sep 2019 09:14:18 +0200
Message-ID: <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
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

> > > On Sat, Sep 14, 2019 at 1:46 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >> A more general question is why ibnbd needs its own queue management
> > >> while no other block driver needs this?
> > >
> > > Each IBNBD device promises to have a queue_depth (of say 512) on each
> > > of its num_cpus hardware queues. In fact we can only process a
> > > queue_depth inflights at once on the whole ibtrs session connecting a
> > > given client with a given server. Those 512 inflights (corresponding
> > > to the number of buffers reserved by the server for this particular
> > > client) have to be shared among all the devices mapped on this
> > > session. This leads to the situation, that we receive more requests
> > > than we can process at the moment. So we need to stop queues and start
> > > them again later in some fair fashion.
> >
> > Can a single CPU really sustain a queue depth of 512 commands? Is it
> > really necessary to have one hardware queue per CPU or is e.g. four
> > queues per NUMA node sufficient? Has it been considered to send the
> > number of hardware queues that the initiator wants to use and also the
> > command depth per queue during login to the target side? That would
> > allow the target side to allocate an independent set of buffers for each
> > initiator hardware queue and would allow to remove the queue management
> > at the initiator side. This might even yield better performance.
> We needed a way which would allow us to address one particular
> requirement: we'd like to be able to "enforce" that a response to an
> IO would be processed on the same CPU the IO was originally submitted
> on. In order to be able to do so we establish one rdma connection per
> cpu, each having a separate cq_vector. The administrator can then
> assign the corresponding IRQs to distinct CPUs. The server always
> replies to an IO on the same connection he received the request on. If
> the administrator did configure the /proc/irq/y/smp_affinity
> accordingly, the response sent by the server will generate interrupt
> on the same cpu, the IO was originally submitted on. The administrator
> can configure IRQs differently, for example assign a given irq
> (<->cq_vector) to a range of cpus belonging to a numa node, or
> whatever assignment is best for his use-case.
> Our transport module IBTRS establishes number of cpus connections
> between a client and a server. The user of the transport module (i.e.
> IBNBD) has no knowledge about the rdma connections, it only has a
> pointer to an abstract "session", which connects  him somehow to a
> remote host. IBNBD as a user of IBTRS creates block devices and uses a
> given "session" to send IOs from all the block devices it created for
> that session. That means IBNBD is limited in maximum number of his
> inflights toward a given remote host by the capability of the
> corresponding "session". So it needs to share the resources provided
> by the session (in our current model those resources are in fact some
> pre registered buffers on server side) among his devices.
> It is possible to extend the IBTRS API so that the user (IBNBD) could
> specify how many connections he wants to have on the session to be
> established. It is also possible to extend the ibtrs_clt_get_tag API
> (this is to get a send "permit") with a parameter specifying the
> connection, the future IO is to be send on.
> We now might have to change our communication model in IBTRS a bit in
> order to fix the potential security problem raised during the recent
> RDMA MC: https://etherpad.net/p/LPC2019_RDMA.
>
I'm not familiar with dm code, but don't they need to deal with the
same situation: if I configure 100 logical volumes on top of a single
NVME drive with X hardware queues, each queue_depth deep, then each dm
block device would need to advertise X hardware queues in order to
achieve highest performance in case only this one volume is accessed,
while in fact those X physical queues have to be shared among all 100
logical volumes, if they are accessed in parallel?
