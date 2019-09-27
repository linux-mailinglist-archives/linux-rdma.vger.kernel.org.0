Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79571C09D2
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfI0QuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 12:50:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43638 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0QuN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 12:50:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id o44so2801144ota.10;
        Fri, 27 Sep 2019 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGVTARxgGg6BP4LgVQ9RlAhGplXptNP5Aazi2ZGYoeo=;
        b=UQiIddH+Ds/315SwyDdyw4lXbosKFCV9ZPFy9PwzSw/qZEPT8TbS+vV/ZVHqLguIiy
         PX9kO26ybc7g887Y8DnNu/VyVVpReTyk/d91ydeSzLD1b0FMnS9EYy739EckVI1sZVhv
         p+aCmBHR9kMVLhbAHLjGt1OdZqKr+bM1lr4PILZBlyVIV5uP3i5GIzYHsQuO/0j1J3jD
         ELmfZo/TKSZK5nSorocRh6Yh3mTSsuAkj90m7naWngduprMJxds/6lLDoX0PsNuTzSs+
         Jv5uMO/+KB9CX1oQfnGpQ/5u6Ia0+tL/wl9e2QxV+zDi42Ms8kC9ARi4aC6FxbPWq7nA
         Zmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGVTARxgGg6BP4LgVQ9RlAhGplXptNP5Aazi2ZGYoeo=;
        b=qeq2XAeHTi7jJvKPyjZE7mzzmo+D4/zklrwaIuuSogkvkrRG4r7imUH5nSYq1CcfMc
         /10Pm28IcAwJXDQEiVXA9OHscKjmsOGK6B/9kMYxpgjFv560tnm0+VuTdaZ0FxQs1kAW
         MHNUB65aosutuL18j87OOhZK5D3XL7joSv26cRlhTe654D1Fc+HUDsQr6C8szSfEQoam
         T7kjg72ihsrDRfwFGab3qHmab8plojObyicnvgo90ZeDb4iXwdj0YHp7D7C6RYRjfbsW
         zPqwZ/sDLw1I3j+eDtjCillgx2BWibxTwUf5tOYeBpp/ViqHFahZgVBluRpmgvM2Iybj
         RhtA==
X-Gm-Message-State: APjAAAWjU3boeKANPbquYDcRZ858yEN0CPodBPNjy9asLRlQoFqdVPrG
        zDH+ffI/qvXHHLZwDkADk8ioXUCfdjIWePbxM/A=
X-Google-Smtp-Source: APXvYqwxL1m3Wbrl918Ano9T+KyPHwsoYpll1pTg1/yEdjlVwGZjHtqGf0lqurgLytaTs4SC5cM8WiwPfQ3ZGnPDf6g=
X-Received: by 2002:a9d:4e0b:: with SMTP id p11mr4317256otf.280.1569603012143;
 Fri, 27 Sep 2019 09:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
 <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org> <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
 <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com>
 <e2056b1d-b428-18c7-8e22-2f37b91917c8@acm.org> <CACZ9PQU8=4DaSAUQ7czKdcWio2H5HB1ro-pXaY2VP9PhgTxk7g@mail.gmail.com>
 <b31be034-eae0-77f7-aabf-92c8f8a984e5@acm.org>
In-Reply-To: <b31be034-eae0-77f7-aabf-92c8f8a984e5@acm.org>
From:   Roman Penyaev <r.peniaev@gmail.com>
Date:   Fri, 27 Sep 2019 18:50:01 +0200
Message-ID: <CACZ9PQWTBiYbjYa=s9+QOWXXr+_hNP5VYP_mC2wi5VJZLTE_kw@mail.gmail.com>
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

On Fri, Sep 27, 2019 at 6:37 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/27/19 1:52 AM, Roman Penyaev wrote:
> > No, it seems this thingy is a bit different.  According to my
> > understanding patches 3 and 4 from this patchset do the
> > following: 1# split equally the whole queue depth on number
> > of hardware queues and 2# return tag number which is unique
> > host-wide (more or less similar to unique_tag, right?).
> >
> > 2# is not needed for ibtrs, and 1# can be easy done by dividing
> > queue_depth on number of hw queues on tag set allocation, e.g.
> > something like the following:
> >
> >      ...
> >      tags->nr_hw_queues = num_online_cpus();
> >      tags->queue_depth  = sess->queue_deph / tags->nr_hw_queues;
> >
> >      blk_mq_alloc_tag_set(tags);
> >
> >
> > And this trick won't work out for the performance.  ibtrs client
> > has a single resource: set of buffer chunks received from a
> > server side.  And these buffers should be dynamically distributed
> > between IO producers according to the load.  Having a hard split
> > of the whole queue depth between hw queues we can forget about a
> > dynamic load distribution, here is an example:
> >
> >     - say server shares 1024 buffer chunks for a session (do not
> >       remember what is the actual number).
> >
> >     - 1024 buffers are equally divided between hw queues, let's
> >       say 64 (number of cpus), so each queue is 16 requests depth.
> >
> >     - only several CPUs produce IO, and instead of occupying the
> >       whole "bandwidth" of a session, i.e. 1024 buffer chunks,
> >       we limit ourselves to a small queue depth of an each hw
> >       queue.
> >
> > And performance drops significantly when number of IO producers
> > is smaller than number of hw queues (CPUs), and it can be easily
> > tested and proved.
> >
> > So for this particular ibtrs case tags should be globally shared,
> > and seems (unfortunately) there is no any other similar requirements
> > for other block devices.
>
> Hi Roman,
>
> I agree that BLK_MQ_F_HOST_TAGS partitions a tag set across hardware
> queues while ibnbd shares a single tag set across multiple hardware
> queues. Since such sharing may be useful for other block drivers, isn't
> that something that should be implemented in the block layer core
> instead of in the ibnbd driver? If that logic would be moved into the
> block layer core, would that allow to reuse the queue restarting logic
> that already exists in the block layer core?

Definitely yes, but what other block drivers you have in mind?

--
Roman
