Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002F06535E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfGKIyP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 04:54:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34930 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfGKIyP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 04:54:15 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so10918162ioo.2
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xB7gk9GV4LWD0anuaWOfarGLjo+bG9F97Mtskx4V/Hw=;
        b=WkvGTnj8CGB7fL8BikYeBlqTCQ057+a3pULdM5uKVpcvXnQdFbte3ikKyd7nb3+gjs
         2Ejwwk7QdEBWLQSC8W6u1mG6PA//3+GBQ9BPP+ShensmB0NO1j5leJByivlOExenf/Mk
         KMafUef//v4s8JTxuHUHsbhZkfZ2Pf95N8RWO4ndOwZP3jLSKlhChHDXsr82mOb+NEzp
         i4pX2wBYuoCm5K1eGgDnkssmIZVYb1NMerQ4xbCl74WXA/UJgogS9YSZ3f1dAYbR5dEL
         FAyFsUJQha71pAqbc05epNCeU0/6yRvK6Y/JIyBFshAenxuhWLc83V5mw15GD5iqfa3K
         E9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xB7gk9GV4LWD0anuaWOfarGLjo+bG9F97Mtskx4V/Hw=;
        b=Vh+zJEDS0xctnt/sM2TGXiFb/YewLqo3tJ8PpvtilCdcPz3keb8Rx6McSqnd05uVQl
         orFvo9191baaZ8LUoHYHshQJx40FRdK5MkddCjYC2ydN8tDqQPadvNWZ32++4NxrIn5w
         9YT6dL4ihZuLL4sIg4m4We/SPBR0IYFJJ1wwFWQqqWcUiDUrRAqBal+x8bLT+SWxFr3B
         smolsWX8JNb8GEx/aNPFBK6VRIfP5REYaZLZNDSeYEXuhNrmmQl147hd21p4qIEdcUsj
         5/YZ2DbOKD2vBQVE/FwN3/Zem8HqkeRjPCgD2ki2kQIGXdw0Wln6+xzL2WDhr4HDxR0l
         FesA==
X-Gm-Message-State: APjAAAXE4x9QBQlygBJ7vaRMAwhWo6w3OXPsJFPSn69WjUFhUSitXE9E
        4Cq+dFlJOb5DUijmX36Cjwv4Ex7Hzha09TkgYotn
X-Google-Smtp-Source: APXvYqyWgsLLfKCpK5w/OwXMN+gzsFDhaFJYaKpDGrf45/1NkZTG0xJ1JEyZs0Umaj0wr0weFx59ptW2BSP1BKO30CQ=
X-Received: by 2002:a6b:ce19:: with SMTP id p25mr3186764iob.201.1562835253969;
 Thu, 11 Jul 2019 01:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
In-Reply-To: <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 11 Jul 2019 10:54:02 +0200
Message-ID: <CAHg0HuxZvXH899=M4vC7BTH-bP2J35aTwsGhiGoC8AamD8gOyA@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi,

thanks a lot for the detailed reply. Answers inline below:

On Tue, Jul 9, 2019 at 9:46 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Hi Danil and Jack,
>
> > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> >
> > Could you please provide some feedback to the IBNBD driver and the
> > IBTRS library?
> > So far we addressed all the requests provided by the community
>
> That is not exactly correct AFAIR,
>
> My main issues which were raised before are:
> - IMO there isn't any justification to this ibtrs layering separation
>    given that the only user of this is your ibnbd. Unless you are
>    trying to submit another consumer, you should avoid adding another
>    subsystem that is not really general purpose.
We designed ibtrs not only with the IBNBD in mind but also as the
transport layer for a distributed SDS. We'd like to be able to do what
ceph is capable of (automatic up/down scaling of the storage cluster,
automatic recovery) but using in-kernel rdma-based IO transport
drivers, thin-provisioned volume managers, etc. to keep the highest
possible performance. That modest plan of ours should among others
cover for the following:
When using IBNBD/SRP/NVMEoF to export devices (say, thin-provisioned
volumes) from server to client and building an (md-)raid on top of the
imported devices on client side in order to provide for redundancy
across different machines, one gets very decent throughput and low
latency, since the IOs are sent in parallel to the storage machines.
One downside of this setup, is that the resync traffic has to flow
over the client, where the md-raid is sitting. Ideally the resync
traffic should flow directly between the two "legs" (storage machines)
of the raid. The server side of such a "distributed raid" capable of
this direct syncing between the array members would necessarily
require to have some logic on server side and hence could also sit on
top of ibtrs. (To continue the analogy, the "server" side of an
md-raid build on top of say two NVMEoF devices are just two block
devices, which couldn't communicate with each other)
All in all itbrs is a library to establish a "fat", multipath,
autoreconnectable connection between two hosts on top of rdma,
optimized for transport of IO traffic.

> - ibtrs in general is using almost no infrastructure from the existing
>    kernel subsystems. Examples are:
>    - tag allocation mechanism (which I'm not clear why its needed)
As you correctly noticed our client manages the buffers allocated and
registered by the server on the connection establishment. Our tags are
just a mechanism to take and release those buffers for incoming
requests on client side. Since the buffers allocated by the server are
to be shared between all the devices mapped from that server and all
their HW queues (each having num_cpus of them) the mechanism behind
get_tag/put_tag also takes care of the fairness.

>    - rdma rw abstraction similar to what we have in the core
On the one hand we have only single IO related function:
ibtrs_clt_request(READ/WRITE, session,...), which executes rdma write
with imm, or requests an rdma write with imm to be executed by the
server. On the other hand we provide an abstraction to establish and
manage what we call "session", which consist of multiple paths (to do
failover and multipath with different policies), where each path
consists of num_cpu rdma connections. Once you established a session
you can add or remove paths from it on the fly. In case the connection
to server is lost, the client does periodic attempts to reconnect
automatically. On the server side you get just sg-lists with a
direction READ or WRITE as requested by the client. We designed this
interface not only as the minimum required to build a block device on
top of rdma but also with a distributed raid in mind.

>    - list_next_or_null_rr_rcu ??
We use that for multipath. The macro (and more importantly the way we
use it) has been reviewed by Linus and quit closely by Paul E.
McKenney. AFAIR the conclusion was that Romans implementation is
correct, but too tricky to use correctly in order to be included into
kernel as a public interface. See https://lkml.org/lkml/2018/5/18/659

>    - few other examples sprinkled around..
To my best knowledge we addressed everything we got comments on and
will definitely do so in the future.

> Another question, from what I understand from the code, the client
> always rdma_writes data on writes (with imm) from a remote pool of
> server buffers dedicated to it. Essentially all writes are immediate (no
> rdma reads ever). How is that different than using send wrs to a set of
> pre-posted recv buffers (like all others are doing)? Is it faster?
At the very beginning of the project we did some measurements and saw,
that it is faster. I'm not sure if this is still true, since the
hardware and the drivers and rdma subsystem did change in that time.
Also it seemed to make the code simpler.

> Also, given that the server pre-allocate a substantial amount of memory
> for each connection, is it documented the requirements from the server
> side? Usually kernel implementations (especially upstream ones) will
> avoid imposing such large longstanding memory requirements on the system
> by default. I don't have a firm stand on this, but wanted to highlight
> this as you are sending this for upstream inclusion.
We definitely need to stress that somewhere. Will include into readme
and add to the cover letter next time. Our memory management is indeed
basically absent in favor of performance: The server reserves
queue_depth of say 512K buffers. Each buffer is used by client for
single IO only, no matter how big the request is. So if client only
issues 4K IOs, we do waste 508*queue_depth K of memory. We were aiming
for lowest possible latency from the beginning. It is probably
possible to implement some clever allocator on the server side which
wouldn't affect the performance a lot.

>
>   and
> > continue to maintain our code up-to-date with the upstream kernel
> > while having an extra compatibility layer for older kernels in our
> > out-of-tree repository.
>
> Overall, while I absolutely support your cause to lower your maintenance
> overhead by having this sit upstream, I don't see why this can be
> helpful to anyone else in the rdma community. If instead you can
> crystallize why/how ibnbd is faster than anything else, and perhaps
> contribute a common infrastructure piece (or enhance an existing one)
> such that other existing ulps can leverage, it will be a lot more
> compelling to include it upstream.
>
> > I understand that SRP and NVMEoF which are in the kernel already do
> > provide equivalent functionality for the majority of the use cases.
> > IBNBD on the other hand is showing higher performance and more
> > importantly includes the IBTRS - a general purpose library to
> > establish connections and transport BIO-like read/write sg-lists over
> > RDMA,
>
> But who needs it? Can other ulps use it or pieces of it? I keep failing
> to understand why is this a benefit if its specific to your ibnbd?
See above and please ask if you have more questions to this.

Thank you,
Danil.
