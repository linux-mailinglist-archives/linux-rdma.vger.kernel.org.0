Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90066B3E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 12:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfGLK6p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 06:58:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39577 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfGLK6p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 06:58:45 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so19402073ioh.6
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+3fd2zHMOyIWuoG2jZcMi83f1rKIExq3w7kl21HtFk=;
        b=Tm3aqK4AmkWF0z8BGjr2tOkqkxqYW1NY6Jra/clVlDv4cVEmd8wig2JB7H+jCBl+x1
         BGgLaGmY2XbFi+5B+lcnsOC7xCBNFhDC325wtXNtAzt6MMegV3DoX+a6DdJYbTMV2r1b
         E0ceVK4ljCXOtuhxC3eBnWgq6uGSKF31Y6IGHhosw3V8qqSZIJRW4LGC3QFC9n4kOBjE
         JUQnrlKb8eFgpgGE4WDLMU2B12FnoVatyPzCiNwFIiobOZVDxwp7RoigIpsigcz7OSeH
         +HjwpjVrnJvuCj3hs8J/1p4Vi/fDoZmT4qLt01yNSqO596qnesi7wyto1DsHb9d88Wej
         7INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+3fd2zHMOyIWuoG2jZcMi83f1rKIExq3w7kl21HtFk=;
        b=oGFrk2w/ZuhH9V4DR2jV+lNRaM/cjjMlvCXp5k0ahHOyAnvViAl6VWrjJ/8j+lmvYa
         0K6nTzfIr2b9iqsWOoN83a4JH+SoYny1ThOIKIcfAghHLoVJqPCuu1oIB32V7AMUy0nJ
         XugV6JYBKDOKErby+90aQXwfOcSoT701xaKVjIEor+bRFBv1XR7TWa05+/r5L++dH5mA
         4EpeZ6SZLG9B9qDl1fhOWcwi5g2PpYWrN7NtaxKJ9kjn8KsGwYFKdR7QxV6coVhgiq2W
         8QYYMT7RYsNABh5clRm4pl3NGrVTF2qaJ4MfrMDzvEgKnWjuUaAORnWalg7yWWbr51qJ
         j1Cw==
X-Gm-Message-State: APjAAAVb1Tge+VWtQDQ7G943KbtcVmyJFHEXSS2gLTgIIVZWynMD/Ejo
        Ie8fV4DV/Ag7TQEwQhKdfLFq1U5n4hggSYKwz+Ia
X-Google-Smtp-Source: APXvYqxPnwKKgjUWw452crE9EdyzyT52l0dIR+2xUAo5Ik9nM9WgSTx+L1pF1XyuIioApoBVo5KJ4JpBpFmg/B0SqMY=
X-Received: by 2002:a5e:881a:: with SMTP id l26mr9938653ioj.185.1562929123791;
 Fri, 12 Jul 2019 03:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me> <CAHg0HuxZvXH899=M4vC7BTH-bP2J35aTwsGhiGoC8AamD8gOyA@mail.gmail.com>
 <aef765ed-4bb9-2211-05d0-b320cc3ac275@grimberg.me>
In-Reply-To: <aef765ed-4bb9-2211-05d0-b320cc3ac275@grimberg.me>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 12 Jul 2019 12:58:31 +0200
Message-ID: <CAHg0Huz93nUTYA8PcXOLaunBF0CT6yc-DcD8EhRJkw+GGL8c7A@mail.gmail.com>
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

On Fri, Jul 12, 2019 at 2:22 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> My main issues which were raised before are:
> >> - IMO there isn't any justification to this ibtrs layering separation
> >>     given that the only user of this is your ibnbd. Unless you are
> >>     trying to submit another consumer, you should avoid adding another
> >>     subsystem that is not really general purpose.
> > We designed ibtrs not only with the IBNBD in mind but also as the
> > transport layer for a distributed SDS. We'd like to be able to do what
> > ceph is capable of (automatic up/down scaling of the storage cluster,
> > automatic recovery) but using in-kernel rdma-based IO transport
> > drivers, thin-provisioned volume managers, etc. to keep the highest
> > possible performance.
>
> Sounds lovely, but still very much bound to your ibnbd. And that part
> is not included in the patch set, so I still don't see why should this
> be considered as a "generic" transport subsystem (it clearly isn't).
Having IBTRS sit on a storage enables that storage to communicate with
other storages (forward requests, request read from other storages
i.e. for sync traffic). IBTRS is generic in the sense that it removes
the strict separation into initiator (converting BIOs into some
hardware specific protocol messages) and target (which forwards those
messages to some local device supporting that protocol).
It appears less generic to me to talk SCSI or NVME between storages if
some storages have SCSI, other NVME disks or LVM volumes, or mixed
setup. IBTRS allows to just send or request read of an sg-list between
machines over rdma - the very minimum required to transport a BIO.
It would in-deed support our case with the library if we would propose
at least two users of it. We now only have a very early stage
prototype capable of organizing storages in pools, multiplexing io
between different storages, etc. sitting on top of ibtrs, it's not
functional yet. On the other hand ibnbd with ibtrs alone already make
over 10000 lines.

> > All in all itbrs is a library to establish a "fat", multipath,
> > autoreconnectable connection between two hosts on top of rdma,
> > optimized for transport of IO traffic.
>
> That is also dictating a wire-protocol which makes it useless to pretty
> much any other consumer. Personally, I don't see how this library
> would ever be used outside of your ibnbd.
Its true, IBTRS also imposes a protocol for connection establishment
and IO path. I think at least the IO part we did reduce to a bare
minimum:
350 * Write *
351
352 1. When processing a write request client selects one of the memory chunks
353 on the server side and rdma writes there the user data, user header and the
354 IBTRS_MSG_RDMA_WRITE message. Apart from the type (write), the message only
355 contains size of the user header. The client tells the server
which chunk has
356 been accessed and at what offset the IBTRS_MSG_RDMA_WRITE can be found by
357 using the IMM field.
358
359 2. When confirming a write request server sends an "empty" rdma message with
360 an immediate field. The 32 bit field is used to specify the outstanding
361 inflight IO and for the error code.
362
363 CLT                                                          SRV
364 usr_data + usr_hdr + ibtrs_msg_rdma_write ----------------->
[IBTRS_IO_REQ_IMM]
365 [IBTRS_IO_RSP_IMM]                        <----------------- (id + errno)
366
367 * Read *
368
369 1. When processing a read request client selects one of the memory chunks
370 on the server side and rdma writes there the user header and the
371 IBTRS_MSG_RDMA_READ message. This message contains the type (read), size of
372 the user header, flags (specifying if memory invalidation is
necessary) and the
373 list of addresses along with keys for the data to be read into.
374
375 2. When confirming a read request server transfers the requested data first,
376 attaches an invalidation message if requested and finally an "empty" rdma
377 message with an immediate field. The 32 bit field is used to specify the
378 outstanding inflight IO and the error code.
379
380 CLT                                           SRV
381 usr_hdr + ibtrs_msg_rdma_read --------------> [IBTRS_IO_REQ_IMM]
382 [IBTRS_IO_RSP_IMM]            <-------------- usr_data + (id + errno)
383 or in case client requested invalidation:
384 [IBTRS_IO_RSP_IMM_W_INV]      <-------------- usr_data + (INV) +
(id + errno)

> >> - ibtrs in general is using almost no infrastructure from the existing
> >>     kernel subsystems. Examples are:
> >>     - tag allocation mechanism (which I'm not clear why its needed)
> > As you correctly noticed our client manages the buffers allocated and
> > registered by the server on the connection establishment. Our tags are
> > just a mechanism to take and release those buffers for incoming
> > requests on client side. Since the buffers allocated by the server are
> > to be shared between all the devices mapped from that server and all
> > their HW queues (each having num_cpus of them) the mechanism behind
> > get_tag/put_tag also takes care of the fairness.
>
> We have infrastructure for this, sbitmaps.
AFAIR Roman did try to use sbitmap but found no benefits in terms of
readability or number of lines:
" What is left unchanged on IBTRS side but was suggested to modify:
     - Bart suggested to use sbitmap instead of calling find_first_zero_bit()
  and friends.  I found calling pure bit API is more explicit in
  comparison to sbitmap - there is no need in using sbitmap_queue
  and all the power of wait queues, no benefits in terms of LoC
  as well." https://lwn.net/Articles/756994/

If sbitmap is a must for our use case from the infrastructure point of
view, we will reiterate on it.

>
> >>     - rdma rw abstraction similar to what we have in the core
> > On the one hand we have only single IO related function:
> > ibtrs_clt_request(READ/WRITE, session,...), which executes rdma write
> > with imm, or requests an rdma write with imm to be executed by the
> > server.
>
> For sure you can enhance the rw API to have imm support?
I'm not familiar with the architectural intention behind rw.c.
Extending the API with the support of imm field is (I guess) doable.

> > On the other hand we provide an abstraction to establish and
> > manage what we call "session", which consist of multiple paths (to do
> > failover and multipath with different policies), where each path
> > consists of num_cpu rdma connections.
>
> That's fine, but it doesn't mean that it also needs to re-write
> infrastructure that we already have.
Do you refer to rw.c?

> > Once you established a session
> > you can add or remove paths from it on the fly. In case the connection
> > to server is lost, the client does periodic attempts to reconnect
> > automatically. On the server side you get just sg-lists with a
> > direction READ or WRITE as requested by the client. We designed this
> > interface not only as the minimum required to build a block device on
> > top of rdma but also with a distributed raid in mind.
>
> I suggest you take a look at the rw API and use that in your transport.
We will look into rw.c. Do you suggest we move the multipath and the
multiple QPs per path and connection establishment on *top* of it or
*into* it?

> >> Another question, from what I understand from the code, the client
> >> always rdma_writes data on writes (with imm) from a remote pool of
> >> server buffers dedicated to it. Essentially all writes are immediate (no
> >> rdma reads ever). How is that different than using send wrs to a set of
> >> pre-posted recv buffers (like all others are doing)? Is it faster?
> > At the very beginning of the project we did some measurements and saw,
> > that it is faster. I'm not sure if this is still true
>
> Its not significantly faster (can't imagine why it would be).
> What could make a difference is probably the fact that you never
> do rdma reads for I/O writes which might be better. Also perhaps the
> fact that you normally don't wait for send completions before completing
> I/O (which is broken), and the fact that you batch recv operations.
>
> I would be interested to understand what indeed makes ibnbd run faster
> though.
Yes, we would like to understand this too. I will try increasing the
inline_data_size on nvme in our benchmarks as the next step to check
if this influences the results.

> >> Also, given that the server pre-allocate a substantial amount of memory
> >> for each connection, is it documented the requirements from the server
> >> side? Usually kernel implementations (especially upstream ones) will
> >> avoid imposing such large longstanding memory requirements on the system
> >> by default. I don't have a firm stand on this, but wanted to highlight
> >> this as you are sending this for upstream inclusion.
> > We definitely need to stress that somewhere. Will include into readme
> > and add to the cover letter next time. Our memory management is indeed
> > basically absent in favor of performance: The server reserves
> > queue_depth of say 512K buffers. Each buffer is used by client for
> > single IO only, no matter how big the request is. So if client only
> > issues 4K IOs, we do waste 508*queue_depth K of memory. We were aiming
> > for lowest possible latency from the beginning. It is probably
> > possible to implement some clever allocator on the server side which
> > wouldn't affect the performance a lot.
>
> Or you can fallback to rdma_read like the rest of the ulps.
We currently have a single round trip for every write IO: write + ack.
Wouldn't switching to rdma_read make 2 round trips out of it: command
+ rdma_read + ack?
