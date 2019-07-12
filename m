Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E12662C5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 02:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfGLAWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 20:22:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34040 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGLAWa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 20:22:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so7762767otk.1;
        Thu, 11 Jul 2019 17:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jXZQvwZ+WxHloRkZdb0DMVv7eaNNsxBD6ps2KyCl09Y=;
        b=P6xsbYPqutA2TM1WAD/JWrYqrTyijMZgu6r4uqMgG5+0/ODz7/29rl+dKC8IY0V4vC
         i4+TG6fM3MvXa2MBs/bAiE+kArTCUKJ8o7+rT2ZeXrRCud689T9+8YiNEzgL15GxKh9m
         G3wURS0ib6DvnphB63fm+jMSLBZsOvktqs0D/tovXJylA/PUEa50H+xDEHnA7DM9Efd9
         pQRsYvLWS5F5u9Q/qxDJdprU6Mo7ITU8jRM6bbLOxebWPZJpFcZHFk5PDlbsMEQiG6EV
         MPYpWQF7yfVit5dmZamEBWmMIh0N6kia3kTvVTCMNN28IxRbGUm37co1vYgGqrOeYuSK
         glag==
X-Gm-Message-State: APjAAAX/Fa06j4Ij5f94kxLWMVIEuQLlyLyj8XB2X9ckSfP0l6aM6zaQ
        lZEYyZf6brRJtLFvik3U1Tg=
X-Google-Smtp-Source: APXvYqxzFkcd+fCSstleSDxY7LurqciKea5lf41DlefWqIyWr15+e48X2y5oaegjnRVEng15aayIcg==
X-Received: by 2002:a9d:51cf:: with SMTP id d15mr6137989oth.206.1562890949154;
        Thu, 11 Jul 2019 17:22:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a20sm2539222otl.44.2019.07.11.17.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 17:22:28 -0700 (PDT)
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>, gregkh@linuxfoundation.org
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
 <CAHg0HuxZvXH899=M4vC7BTH-bP2J35aTwsGhiGoC8AamD8gOyA@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aef765ed-4bb9-2211-05d0-b320cc3ac275@grimberg.me>
Date:   Thu, 11 Jul 2019 17:22:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHg0HuxZvXH899=M4vC7BTH-bP2J35aTwsGhiGoC8AamD8gOyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> My main issues which were raised before are:
>> - IMO there isn't any justification to this ibtrs layering separation
>>     given that the only user of this is your ibnbd. Unless you are
>>     trying to submit another consumer, you should avoid adding another
>>     subsystem that is not really general purpose.
> We designed ibtrs not only with the IBNBD in mind but also as the
> transport layer for a distributed SDS. We'd like to be able to do what
> ceph is capable of (automatic up/down scaling of the storage cluster,
> automatic recovery) but using in-kernel rdma-based IO transport
> drivers, thin-provisioned volume managers, etc. to keep the highest
> possible performance.

Sounds lovely, but still very much bound to your ibnbd. And that part
is not included in the patch set, so I still don't see why should this
be considered as a "generic" transport subsystem (it clearly isn't).

> All in all itbrs is a library to establish a "fat", multipath,
> autoreconnectable connection between two hosts on top of rdma,
> optimized for transport of IO traffic.

That is also dictating a wire-protocol which makes it useless to pretty
much any other consumer. Personally, I don't see how this library
would ever be used outside of your ibnbd.

>> - ibtrs in general is using almost no infrastructure from the existing
>>     kernel subsystems. Examples are:
>>     - tag allocation mechanism (which I'm not clear why its needed)
> As you correctly noticed our client manages the buffers allocated and
> registered by the server on the connection establishment. Our tags are
> just a mechanism to take and release those buffers for incoming
> requests on client side. Since the buffers allocated by the server are
> to be shared between all the devices mapped from that server and all
> their HW queues (each having num_cpus of them) the mechanism behind
> get_tag/put_tag also takes care of the fairness.

We have infrastructure for this, sbitmaps.

>>     - rdma rw abstraction similar to what we have in the core
> On the one hand we have only single IO related function:
> ibtrs_clt_request(READ/WRITE, session,...), which executes rdma write
> with imm, or requests an rdma write with imm to be executed by the
> server.

For sure you can enhance the rw API to have imm support?

> On the other hand we provide an abstraction to establish and
> manage what we call "session", which consist of multiple paths (to do
> failover and multipath with different policies), where each path
> consists of num_cpu rdma connections.

That's fine, but it doesn't mean that it also needs to re-write
infrastructure that we already have.

> Once you established a session
> you can add or remove paths from it on the fly. In case the connection
> to server is lost, the client does periodic attempts to reconnect
> automatically. On the server side you get just sg-lists with a
> direction READ or WRITE as requested by the client. We designed this
> interface not only as the minimum required to build a block device on
> top of rdma but also with a distributed raid in mind.

I suggest you take a look at the rw API and use that in your transport.

>> Another question, from what I understand from the code, the client
>> always rdma_writes data on writes (with imm) from a remote pool of
>> server buffers dedicated to it. Essentially all writes are immediate (no
>> rdma reads ever). How is that different than using send wrs to a set of
>> pre-posted recv buffers (like all others are doing)? Is it faster?
> At the very beginning of the project we did some measurements and saw,
> that it is faster. I'm not sure if this is still true

Its not significantly faster (can't imagine why it would be).
What could make a difference is probably the fact that you never
do rdma reads for I/O writes which might be better. Also perhaps the
fact that you normally don't wait for send completions before completing
I/O (which is broken), and the fact that you batch recv operations.

I would be interested to understand what indeed makes ibnbd run faster
though.

>> Also, given that the server pre-allocate a substantial amount of memory
>> for each connection, is it documented the requirements from the server
>> side? Usually kernel implementations (especially upstream ones) will
>> avoid imposing such large longstanding memory requirements on the system
>> by default. I don't have a firm stand on this, but wanted to highlight
>> this as you are sending this for upstream inclusion.
> We definitely need to stress that somewhere. Will include into readme
> and add to the cover letter next time. Our memory management is indeed
> basically absent in favor of performance: The server reserves
> queue_depth of say 512K buffers. Each buffer is used by client for
> single IO only, no matter how big the request is. So if client only
> issues 4K IOs, we do waste 508*queue_depth K of memory. We were aiming
> for lowest possible latency from the beginning. It is probably
> possible to implement some clever allocator on the server side which
> wouldn't affect the performance a lot.

Or you can fallback to rdma_read like the rest of the ulps.
