Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114951430D6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgATRbD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 12:31:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40675 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRbD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jan 2020 12:31:03 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so34473375iop.7
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2020 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BJlqX/66I069N73XeW4rXMR5CUG0kXb0Zp80KRIp8s=;
        b=H5mbDOJRzQ/6FawqIuLtmdHU+itECK8icsEFW0dFD1reax9SYMryb5WeU+QLlGZdVf
         5O6tdiyxf3J1dMLs94LV1qRw1w9dJTRMwF9NrRXRvB5ytDyqdyegKfLbCTNxWRBWkg0U
         z3STG/YOghf7rBnW/uB0G8zEgthqwx4fI3fwFx+cshh3x93ViVBiouliRvl/U84iyOLd
         +cL5TjgX4XMpWpCDxqFYm3SsBbe+wkZw3ignwncO8o/e13VjlUlXpzIpoQExYYIX9b0f
         NzbtOOrb7uXpbdBYo3x+idibhKBuQ3W4YI/JbQIxXGoQFSTJSKvzyLOYIodbgqnkTj/A
         iR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BJlqX/66I069N73XeW4rXMR5CUG0kXb0Zp80KRIp8s=;
        b=sEjyMz4CfyMgQF1/WnLRgk7R3DsnErfVtdZ2M8fv7jllp0EnNxEWryQAqOvaFVMwGP
         u8dvlmkhYp22CpXshsHmSgZUEV2wr6v5rdJ513H5Sn6PBQCvPwW67hXC4oapMjqXTMQS
         tQEzznPRWmJHq787gu7euiqMMoprQ18y23CmKF/J6pDJdbAXkxbxe1KizWApE8uYdAmY
         hYo4d2C89GdBom6Au5npk+bN9FtbFHbJiE88RBxtoaOZkUKYFlE6pMxEgcEATkF8U9w2
         CQRfC2UJ7VCmsOCwZX8EKv5jwClSu7ficFQarS2jTud87kQhyQ6Cs8nG/RXsVDxwUrC3
         VBCw==
X-Gm-Message-State: APjAAAUPiJUhIGM3lqmCvKuR43wlyjRxbSfmTJ/PMrcyJOquz40Sky43
        EmD0lghf8pXvJcWI76rgkhd0rrT/hMLvMtDJx5aijA==
X-Google-Smtp-Source: APXvYqw4b3gNE0fb6oLmVNOv4q89TLRTdSh1RBhpPKd2v7CfGerBbMkxQHjvAGS+pzFIPDjZzblLxoIlRwZSOVYCWoA=
X-Received: by 2002:a02:ca10:: with SMTP id i16mr132059jak.10.1579541462411;
 Mon, 20 Jan 2020 09:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-18-jinpuwang@gmail.com>
 <20200120134815.GH51881@unreal>
In-Reply-To: <20200120134815.GH51881@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Jan 2020 18:30:51 +0100
Message-ID: <CAMGffE=+wX2h6bSp+ZwTowWq8NOutVnCfXFqxMupZNCGGOh0sg@mail.gmail.com>
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 20, 2020 at 2:48 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jan 16, 2020 at 01:59:07PM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This is main functionality of rnbd-client module, which provides
> > interface to map remote device as local block device /dev/rnbd<N>
> > and feeds RTRS with IO requests.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/block/rnbd/rnbd-clt.c | 1730 +++++++++++++++++++++++++++++++++
> >  1 file changed, 1730 insertions(+)
> >  create mode 100644 drivers/block/rnbd/rnbd-clt.c
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> > new file mode 100644
> > index 000000000000..7d8cb38d3969
> > --- /dev/null
> > +++ b/drivers/block/rnbd/rnbd-clt.c
> > @@ -0,0 +1,1730 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * RDMA Network Block Driver
> > + *
> > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > + *
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + *
> > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > + */
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/blkdev.h>
> > +#include <linux/hdreg.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/idr.h>
> > +
> > +#include "rnbd-clt.h"
> > +
> > +MODULE_DESCRIPTION("RDMA Network Block Device Client");
> > +MODULE_LICENSE("GPL");
> > +
> > +static int rnbd_client_major;
> > +static DEFINE_IDA(index_ida);
> > +static DEFINE_MUTEX(ida_lock);
> > +static DEFINE_MUTEX(sess_lock);
> > +static LIST_HEAD(sess_list);
> > +
> > +/*
> > + * Maximum number of partitions an instance can have.
> > + * 6 bits = 64 minors = 63 partitions (one minor is used for the device itself)
> > + */
> > +#define RNBD_PART_BITS               6
> > +
> > +static inline bool rnbd_clt_get_sess(struct rnbd_clt_session *sess)
> > +{
> > +     return refcount_inc_not_zero(&sess->refcount);
> > +}
> > +
> > +static void free_sess(struct rnbd_clt_session *sess);
> > +
> > +static void rnbd_clt_put_sess(struct rnbd_clt_session *sess)
> > +{
> > +     might_sleep();
> > +
> > +     if (refcount_dec_and_test(&sess->refcount))
> > +             free_sess(sess);
> > +}
>
> I see that this code is for drivers/block and maybe it is a way to do it
> there, but in RDMA, we don't like abstraction of general and well-known
> kernel APIs. It looks like kref to me.
I can try to convert to kref interface if other guys also think it's necessary.

>
> > +
> > +static inline bool rnbd_clt_dev_is_mapped(struct rnbd_clt_dev *dev)
> > +{
> > +     return dev->dev_state == DEV_STATE_MAPPED;
> > +}
> > +
> > +static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
> > +{
> > +     might_sleep();
> > +
> > +     if (refcount_dec_and_test(&dev->refcount)) {
> > +             mutex_lock(&ida_lock);
> > +             ida_simple_remove(&index_ida, dev->clt_device_id);
> > +             mutex_unlock(&ida_lock);
> > +             kfree(dev->hw_queues);
> > +             rnbd_clt_put_sess(dev->sess);
> > +             kfree(dev);
> > +     }
> > +}
> > +
> > +static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
> > +{
> > +     return refcount_inc_not_zero(&dev->refcount);
> > +}
> > +
> > +static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
> > +                              const struct rnbd_msg_open_rsp *rsp)
> > +{
> > +     struct rnbd_clt_session *sess = dev->sess;
> > +
> > +     if (unlikely(!rsp->logical_block_size))
> > +             return -EINVAL;
>
> unlikely() again.
will remove.

snip
> > +static void rnbd_put_iu(struct rnbd_clt_session *sess, struct rnbd_iu *iu)
> > +{
> > +     if (atomic_dec_and_test(&iu->refcount))
> > +             rnbd_put_permit(sess, iu->permit);
> > +}
> > +
> > +static void rnbd_softirq_done_fn(struct request *rq)
> > +{
> > +     struct rnbd_clt_dev *dev        = rq->rq_disk->private_data;
> > +     struct rnbd_clt_session *sess   = dev->sess;a
>
> Please no vertical alignment in new code, it adds a lot of churn if such
> line is changed later and creates difficulties for the backports.
It does look nicer when it can be aligned. I don't get why backport is
an argument here.

Thanks
