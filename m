Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12738145464
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 13:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAVMbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 07:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgAVMbX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Jan 2020 07:31:23 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC152467A;
        Wed, 22 Jan 2020 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579696282;
        bh=2zPhSxDqKsuBWdx9XRPFjEgiSUfelWblsRtbGYvzjkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSfz5Q5omGbm6QdCBQUjfafs3JMUgMiClrbdGfsfPU3+9NAi16ZAFqu7JPjBq63I6
         dY26v8ZGg7/8BqNO5T1zYG/vawTgLDptmVnh3qyyGEImGPniOj7Uu03b0RwQ+dGjJZ
         blt6LnAAaIIWmIlBY3xDTUhvNox0Sdzb7wZLQOLU=
Date:   Wed, 22 Jan 2020 14:31:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
Message-ID: <20200122123119.GC7018@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-18-jinpuwang@gmail.com>
 <20200120134815.GH51881@unreal>
 <CAMGffE=+wX2h6bSp+ZwTowWq8NOutVnCfXFqxMupZNCGGOh0sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=+wX2h6bSp+ZwTowWq8NOutVnCfXFqxMupZNCGGOh0sg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 20, 2020 at 06:30:51PM +0100, Jinpu Wang wrote:
> On Mon, Jan 20, 2020 at 2:48 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Jan 16, 2020 at 01:59:07PM +0100, Jack Wang wrote:
> > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > >
> > > This is main functionality of rnbd-client module, which provides
> > > interface to map remote device as local block device /dev/rnbd<N>
> > > and feeds RTRS with IO requests.
> > >
> > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  drivers/block/rnbd/rnbd-clt.c | 1730 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 1730 insertions(+)
> > >  create mode 100644 drivers/block/rnbd/rnbd-clt.c
> > >
> > > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> > > new file mode 100644
> > > index 000000000000..7d8cb38d3969
> > > --- /dev/null
> > > +++ b/drivers/block/rnbd/rnbd-clt.c
> > > @@ -0,0 +1,1730 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * RDMA Network Block Driver
> > > + *
> > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > + *
> > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > + *
> > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > + */
> > > +
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/blkdev.h>
> > > +#include <linux/hdreg.h>
> > > +#include <linux/scatterlist.h>
> > > +#include <linux/idr.h>
> > > +
> > > +#include "rnbd-clt.h"
> > > +
> > > +MODULE_DESCRIPTION("RDMA Network Block Device Client");
> > > +MODULE_LICENSE("GPL");
> > > +
> > > +static int rnbd_client_major;
> > > +static DEFINE_IDA(index_ida);
> > > +static DEFINE_MUTEX(ida_lock);
> > > +static DEFINE_MUTEX(sess_lock);
> > > +static LIST_HEAD(sess_list);
> > > +
> > > +/*
> > > + * Maximum number of partitions an instance can have.
> > > + * 6 bits = 64 minors = 63 partitions (one minor is used for the device itself)
> > > + */
> > > +#define RNBD_PART_BITS               6
> > > +
> > > +static inline bool rnbd_clt_get_sess(struct rnbd_clt_session *sess)
> > > +{
> > > +     return refcount_inc_not_zero(&sess->refcount);
> > > +}
> > > +
> > > +static void free_sess(struct rnbd_clt_session *sess);
> > > +
> > > +static void rnbd_clt_put_sess(struct rnbd_clt_session *sess)
> > > +{
> > > +     might_sleep();
> > > +
> > > +     if (refcount_dec_and_test(&sess->refcount))
> > > +             free_sess(sess);
> > > +}
> >
> > I see that this code is for drivers/block and maybe it is a way to do it
> > there, but in RDMA, we don't like abstraction of general and well-known
> > kernel APIs. It looks like kref to me.
> I can try to convert to kref interface if other guys also think it's necessary.
>
> >
> > > +
> > > +static inline bool rnbd_clt_dev_is_mapped(struct rnbd_clt_dev *dev)
> > > +{
> > > +     return dev->dev_state == DEV_STATE_MAPPED;
> > > +}
> > > +
> > > +static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
> > > +{
> > > +     might_sleep();
> > > +
> > > +     if (refcount_dec_and_test(&dev->refcount)) {
> > > +             mutex_lock(&ida_lock);
> > > +             ida_simple_remove(&index_ida, dev->clt_device_id);
> > > +             mutex_unlock(&ida_lock);
> > > +             kfree(dev->hw_queues);
> > > +             rnbd_clt_put_sess(dev->sess);
> > > +             kfree(dev);
> > > +     }
> > > +}
> > > +
> > > +static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
> > > +{
> > > +     return refcount_inc_not_zero(&dev->refcount);
> > > +}
> > > +
> > > +static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
> > > +                              const struct rnbd_msg_open_rsp *rsp)
> > > +{
> > > +     struct rnbd_clt_session *sess = dev->sess;
> > > +
> > > +     if (unlikely(!rsp->logical_block_size))
> > > +             return -EINVAL;
> >
> > unlikely() again.
> will remove.
>
> snip
> > > +static void rnbd_put_iu(struct rnbd_clt_session *sess, struct rnbd_iu *iu)
> > > +{
> > > +     if (atomic_dec_and_test(&iu->refcount))
> > > +             rnbd_put_permit(sess, iu->permit);
> > > +}
> > > +
> > > +static void rnbd_softirq_done_fn(struct request *rq)
> > > +{
> > > +     struct rnbd_clt_dev *dev        = rq->rq_disk->private_data;
> > > +     struct rnbd_clt_session *sess   = dev->sess;a
> >
> > Please no vertical alignment in new code, it adds a lot of churn if such
> > line is changed later and creates difficulties for the backports.
> It does look nicer when it can be aligned. I don't get why backport is
> an argument here.

The backport thing will be problematic once some fix is needed which
will require addition of extra variable.

Imagine such situation, where you will need to add such variable.

     struct rnbd_clt_dev *dev        = rq->rq_disk->private_data;
     struct rnbd_clt_session *sess   = dev->sess;
+    struct rnbd_clt_session *sess_very_long_variable = ....;

You will need to update vertical alignment for all variables and it
can create huge churn out of nowhere. The standard approach is to
avoid vertical space alignments from the beginning.

BTW, Backport for me is stable@ trees.

>
> Thanks
