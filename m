Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC886648B7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfGJOzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 10:55:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37710 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJOzh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 10:55:37 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so5359907iog.4
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Twe7ecyzjHZ8DMP/2Lr9YSihfBlQIaYCO4YxlwHixEU=;
        b=VFNULUCGYc5C/mAy1+GvgZKxhQSwQiTOI1WdoPQsmr12lST0WDAsEJFENwWY3yf8BS
         gyQk13B6DePfrb6TxztsQro/A3WUX/A4/td/wWY/EoITBAR7yYK9R63UVXcYy8YKzbSd
         LjDqeYr91o8JDuo16+S5UMyOrB7nkX7Clrs0ntg4azgN4qRwsXZvVE4o8n3yHrtF6Ttz
         pYhP5FZ1qg4Go41uK0NsTWxwa2S8LPY6/8gBOiJlbTQn1r9lK1xYHh7zueMAEAkWnT3B
         i99/sD44DWMNIUGOv4CYl8Bqx0yRWGu+Uhy1EU4SvD2fRXN1Wbg1TEN8FAUPL66U2Z4P
         bTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Twe7ecyzjHZ8DMP/2Lr9YSihfBlQIaYCO4YxlwHixEU=;
        b=BMYvvvGuiW7ORiSSclwfn9jPQum8KalEkISOsQh2tpSRHpk1JKTJ7I/xvbHt3rd/p9
         6nrF8UF+G2CPJO9kDfq43WOyikraBzQN307WWbn2gxGRh572ebvL2H8sBihOx9xbQuHH
         BqcWBdGHlKOfLb7/slEjiW6NGYxwBnOyEc7rkqOTZxgF7TpRxNPJzORN/0YvnmX82TUN
         s8Un9Ba/YmXbk4wDcEHFSOGbezhP48W6+0ws21Rey7y9E9ZeJbiGB9dx9TlLK94pIBKq
         qyZJXDm1wiIh/Ix4ZlwftbSeU22X6dqtI3hXmB5P3pfcQ21KmrJcnCHxdxDxmWHg41PU
         RjOA==
X-Gm-Message-State: APjAAAVTNhQmyuV4StHFJKSaH2sv6r49gEXVSot9GZ+Zztc3UGn6xLAG
        WlxSdmsrrcjki12/ZJHXfuhFMMXBVSZCiRZ1ZnLt
X-Google-Smtp-Source: APXvYqwiNFgudvHR7APlwic5M5ARNema/LLFjl4sBRzFWkTW0ZH+V/Dp9giDofxDnT7DsB2uOoUFg67pSqWZ6SFNThU=
X-Received: by 2002:a6b:5b01:: with SMTP id v1mr27601587ioh.120.1562770535816;
 Wed, 10 Jul 2019 07:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com>
In-Reply-To: <20190709110036.GQ7034@mtr-leonro.mtl.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 10 Jul 2019 16:55:24 +0200
Message-ID: <CAHg0Huz=kQtSVthXBpnzt5hos70sMLbdBo1hQRsQXnn4MccWzw@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

thanks for the feedback!

On Tue, Jul 9, 2019 at 1:00 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> >
> > Could you please provide some feedback to the IBNBD driver and the
> > IBTRS library?
> > So far we addressed all the requests provided by the community and
> > continue to maintain our code up-to-date with the upstream kernel
> > while having an extra compatibility layer for older kernels in our
> > out-of-tree repository.
> > I understand that SRP and NVMEoF which are in the kernel already do
> > provide equivalent functionality for the majority of the use cases.
> > IBNBD on the other hand is showing higher performance and more
> > importantly includes the IBTRS - a general purpose library to
> > establish connections and transport BIO-like read/write sg-lists over
> > RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. While
> > I believe IBNBD does meet the kernel coding standards, it doesn't have
> > a lot of users, while SRP and NVMEoF are widely accepted. Do you think
> > it would make sense for us to rework our patchset and try pushing it
> > for staging tree first, so that we can proof IBNBD is well maintained,
> > beneficial for the eco-system, find a proper location for it within
> > block/rdma subsystems? This would make it easier for people to try it
> > out and would also be a huge step for us in terms of maintenance
> > effort.
> > The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top of
> > RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in the
> > near future). Do you think it would make sense to rename the driver to
> > RNBD/RTRS?
>
> It is better to avoid "staging" tree, because it will lack attention of
> relevant people and your efforts will be lost once you will try to move
> out of staging. We are all remembering Lustre and don't want to see it
> again.
>
> Back then, you was asked to provide support for performance superiority.

I have only theories of why ibnbd is showing better numbers than nvmeof:
1. The way we utilize the MQ framework in IBNBD. We promise to have
queue_depth (say 512) requests on each of the num_cpus hardware queues
of each device, but in fact we have only queue_depth for the whole
"session" toward a given server. The moment we have queue_depth
inflights we need stop the queue (on a device on a cpu) we get more
requests on. We need to start them again after some requests are
completed. We maintain per cpu lists of stopped HW queues, a bitmap
showing which lists are not empty, etc. to wake them up in a
round-robin fashion to avoid starvation of any devices.
2. We only do rdma writes with imm. A server reserves queue_depth of
max_io_size buffers for a given client. The client manages those
himself. Client uses imm field to tell to the server which buffer has
been written (and where) and server uses the imm field to send back
errno. If our max_io_size is 64K and queue_depth 512 and client only
issues 4K IOs all the time, then 60*512K memory is wasted. On the
other hand we do no buffer allocation/registration in io path on
server side. Server sends rdma addresses and keys to those
preregistered buffers on connection establishment and
deallocates/unregisters them when a session is closed. That's for
writes. For reads, client registers user buffers (after fr) and sends
the addresses and keys to the server (with an rdma write with imm).
Server rdma writes into those buffers. Client does the
unregistering/invalidation and completes the request.

> Can you please share any numbers with us?
Apart from github
(https://github.com/ionos-enterprise/ibnbd/tree/master/performance/v4-v5.2-rc3)
the performance results for v5.2-rc3 on two different systems can be
accessed under dcd.ionos.com/ibnbd-performance-report. The page allows
to filter out test scenarios interesting for comparison.

>
> Thanks
