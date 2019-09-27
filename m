Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B417DC0267
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfI0Jc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 05:32:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37207 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfI0Jc5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 05:32:57 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so14609431iob.4
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0F9BV+w6YlVo6rnMh8c7eadXk4YfSZWOZo9NVbXZgWc=;
        b=CRctnwvQx2HF1XCyaoCBnpneTOIp5SJktILtKhNC2o38Tv4V2in8p7iNqhQgMZJJ6v
         pxQG0YjdMUT73ZV8itpDnBtmVWiq4oDxLArCNDiVbpsOUjHM+xZNoi2jE4clAxiLplnX
         x0+rCGzle0J12J5soDbsmTGrM+yGSJf/7pd0titKHC1rx6sEl8xKgCpS9mCkDH4YrOXg
         g6rBv8XgPHXO5/WK8b0G1t37e/alN2PJm0rlBxD9RMwPnkGPHz6fMIk5MCLOQ79fKGNm
         AblHdNpL5vUqIY83KK8s3gfYg7+CDsMdEh3r1uC0CiIuWFOs1QZOviRnObcxeQEvK5Vj
         B5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0F9BV+w6YlVo6rnMh8c7eadXk4YfSZWOZo9NVbXZgWc=;
        b=s3jpC2/QBgu4/lkwyVcjA1Z1i18E7uJsyUQxz/vJzNqC0ETA+7YpSvA6+eTJCIGaXr
         1g+uhRQvCVNGxynGgDfXFk4WkbiM6+KwtgXRzLDzY3mShjTnV009d/9NEjWNUkuqRfFJ
         mAYYNOcu3s/nDVxBfx6pml6utRqyyHkfA+SGw3cm229Y59UghdtUWPAyl5yQGbJzfMIr
         2gn1L1dSJJ11PKgryOlDPh7i2giEJfAkjTYcw8e/cNTE5ezY4o/6nwJrkljLgnvlxstL
         FhjdfY8f0d/lBZdzjUj5gkSF2ANJtBhHeuwO42pPYRwCKd6dTjCs4scIY8dlFLOv+jLG
         izmQ==
X-Gm-Message-State: APjAAAXOcNznEGhrTYjStYCGirvx/daI6vkUk7vB3tHQnSH/R4u0iVE7
        Havh7ppdcQg56T5gpIg9Bg4fZNScaIrgTWR7/z18
X-Google-Smtp-Source: APXvYqxEynMT037nTVIy/Fgxg5eZt/CD1wNfe2fobSORKFoA55i9jfqmRHpTKL6RPe1JEEhWirf70SOaHQG49SdSwiE=
X-Received: by 2002:a92:1b02:: with SMTP id b2mr3800165ilb.111.1569576775287;
 Fri, 27 Sep 2019 02:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
 <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org> <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
 <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com>
 <e2056b1d-b428-18c7-8e22-2f37b91917c8@acm.org> <CACZ9PQU8=4DaSAUQ7czKdcWio2H5HB1ro-pXaY2VP9PhgTxk7g@mail.gmail.com>
In-Reply-To: <CACZ9PQU8=4DaSAUQ7czKdcWio2H5HB1ro-pXaY2VP9PhgTxk7g@mail.gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 11:32:44 +0200
Message-ID: <CAHg0HuwgPXtaY3XGv0=TjPbmRRdbmOsa7fRYa+n5fGf9K0_xRg@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Roman Penyaev <r.peniaev@gmail.com>
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

On Fri, Sep 27, 2019 at 10:52 AM Roman Penyaev <r.peniaev@gmail.com> wrote:
>
> No, it seems this thingy is a bit different.  According to my
> understanding patches 3 and 4 from this patchset do the
> following: 1# split equally the whole queue depth on number
> of hardware queues and 2# return tag number which is unique
> host-wide (more or less similar to unique_tag, right?).
>
> 2# is not needed for ibtrs, and 1# can be easy done by dividing
> queue_depth on number of hw queues on tag set allocation, e.g.
> something like the following:
>
>     ...
>     tags->nr_hw_queues = num_online_cpus();
>     tags->queue_depth  = sess->queue_deph / tags->nr_hw_queues;
>
>     blk_mq_alloc_tag_set(tags);
>
>
> And this trick won't work out for the performance.  ibtrs client
> has a single resource: set of buffer chunks received from a
> server side.  And these buffers should be dynamically distributed
> between IO producers according to the load.  Having a hard split
> of the whole queue depth between hw queues we can forget about a
> dynamic load distribution, here is an example:
>
>    - say server shares 1024 buffer chunks for a session (do not
>      remember what is the actual number).
>
>    - 1024 buffers are equally divided between hw queues, let's
>      say 64 (number of cpus), so each queue is 16 requests depth.
>
>    - only several CPUs produce IO, and instead of occupying the
>      whole "bandwidth" of a session, i.e. 1024 buffer chunks,
>      we limit ourselves to a small queue depth of an each hw
>      queue.
>
> And performance drops significantly when number of IO producers
> is smaller than number of hw queues (CPUs), and it can be easily
> tested and proved.
>
> So for this particular ibtrs case tags should be globally shared,
> and seems (unfortunately) there is no any other similar requirements
> for other block devices.
I don't see any difference between what you describe here and 100 dm
volumes sitting on top of a single NVME device.
