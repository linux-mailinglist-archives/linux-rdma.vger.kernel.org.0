Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC541199211
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgCaJXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 05:23:16 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42447 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgCaJXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 05:23:14 -0400
Received: by mail-il1-f195.google.com with SMTP id f16so18713051ilj.9
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMKrxTqmA4TIgiRiGbI08pf4Uf7w5UYJg1vK2q1M7KM=;
        b=SJQlURFjp+nE6c3sftlMWUTb9afVFkxLgvVQkSr7f02p7DL6EJIFxUaFRVtfUllPPI
         8/gl6Irw6J8OENf/viifdIUg9ZLeCBhA9TuG3YOKlXG6ORBjYOELAUzYZCCr6+bINTT0
         TISdeILyuR8ihLDJDsDyppfm0x0p4TnJ2P3Y2KLXXaHFia2TS7tfX4vH7xg8miaWLJkv
         9jP+lmZcY96jEIz0cxZJ5mde6+1LuMTH5BZXnQMKn+CtwS1b6DL78gTf1jCaoX164NIX
         zVvhLdAD3oW9r9T4UoCBiU1jonBxJeJxcVC2DRrFQyd6/04gQjv7hmN5oiKyj41+usU2
         1yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMKrxTqmA4TIgiRiGbI08pf4Uf7w5UYJg1vK2q1M7KM=;
        b=OUeByqY6zHFo0x+SW32TBdC+JuWBA8TsbpxOT5Ey92NSZ3haPMWeRwJnV1fgztR7sx
         n1uDVs3k7tREABSwU3O9D0FQTTmmRdNO/btzQbIxb5xHe61cBnvWn3rf/756WtX+HQxO
         4IyhwCExi4ShhDFgHIyZlTgIBgdoFwucrei8WzOeA0epwnvW1IOBAR6kb0rRXwHPp1Ej
         Dct2Lu+Eg2d6mLiIfM1AhtAkXJ58mWDmJstJu0IQNH3sWYs3D9YkCupUtgGIKbIH6OIn
         neZlWutpVUc+W0RBqvUUMFGWOu1pJkUmsNal2TxmosQd98DAdE38rdrnHgpqxL3QVMaX
         k0RA==
X-Gm-Message-State: ANhLgQ2VD56pJUoYF2DZJznTDu0igKNdik+NSGl1/gukjEZk9zDgYqB7
        Xl5pHDkbHbdr5syHf7X5wf0GO9q8pDlUEHfPoNS7jw==
X-Google-Smtp-Source: ADFU+vuO8ajXQCMTWxpmGRjSItjIdQPahaER/2osrhijUEnTNwBYrIoftbPbfmIwmFjLYycctz4zh7pXqaQY05NE0cM=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr15047023ili.217.1585646593722;
 Tue, 31 Mar 2020 02:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-19-jinpu.wang@cloud.ionos.com> <198cd2da-cbf8-17b0-3ee5-5dec366a43e2@acm.org>
In-Reply-To: <198cd2da-cbf8-17b0-3ee5-5dec366a43e2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:23:02 +0200
Message-ID: <CAMGffEk1WA114u4KR8_UAUoUvpafshZkhxEYuxg6UcQpZid0qQ@mail.gmail.com>
Subject: Re: [PATCH v11 18/26] block/rnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 5:45 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
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
> > +             mutex_destroy(&dev->lock);
> > +             kfree(dev);
> > +     }
> > +}
>
> Please use the coding style that is used elsewhere in the kernel, namely
> return early to keep the indentation level low.
Ok, will fix the coding style.
>
> > +enum {
> > +     RNBD_DELAY_10ms   = 10,
> > +     RNBD_DELAY_IFBUSY = -1,
> > +};
>
> How about removing the RNBD_DELAY_10ms constant and using 10/*ms*/ instead?
Sounds good.
>
> > +enum {
> > +     NO_WAIT = 0,
> > +     WAIT    = 1
> > +};
> > +
> > +static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
> > +                     struct rnbd_iu *iu, struct kvec *vec, size_t nr,
> > +                     size_t len, struct scatterlist *sg, unsigned int sg_len,
> > +                     void (*conf)(struct work_struct *work),
> > +                     int *errno, bool wait)
>
> Are the NO_WAIT and WAIT perhaps values that are passed as the last
> argument to send_usr_msg()? If so, please use a proper enumeration type
> instead of 'bool'.
You're right, seems better to just remove the enum, "bool wait" is
self-explained.
>
> > +static int rnbd_client_getgeo(struct block_device *block_device,
> > +                            struct hd_geometry *geo)
> > +{
> > +     u64 size;
> > +     struct rnbd_clt_dev *dev;
> > +
> > +     dev = block_device->bd_disk->private_data;
> > +     size = dev->size * (dev->logical_block_size / SECTOR_SIZE);
> > +     geo->cylinders  = (size & ~0x3f) >> 6;  /* size/64 */
> > +     geo->heads      = 4;
> > +     geo->sectors    = 16;
> > +     geo->start      = 0;
> > +
> > +     return 0;
> > +}
>
> Is the "& ~0x3f" in the above function perhaps superfluous?
yes, will remove.
>
> > +static void rnbd_clt_dev_kick_mq_queue(struct rnbd_clt_dev *dev,
> > +                                     struct blk_mq_hw_ctx *hctx,
> > +                                     int delay)
> > +{
> > +     struct rnbd_queue *q = hctx->driver_data;
> > +
> > +     if (delay != RNBD_DELAY_IFBUSY)
> > +             blk_mq_delay_run_hw_queue(hctx, delay);
> > +     else if (unlikely(!rnbd_clt_dev_add_to_requeue(dev, q)))
> > +             /*
> > +              * If session is not busy we have to restart
> > +              * the queue ourselves.
> > +              */
> > +             blk_mq_delay_run_hw_queue(hctx, RNBD_DELAY_10ms);
> > +}
>
> I think the above code will be easier to read if RNBD_DELAY_10ms is
> changed into 10/*ms*/.
ok

>
> > +static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
> > +                                const struct blk_mq_queue_data *bd)
> > +{
> > +     struct request *rq = bd->rq;
> > +     struct rnbd_clt_dev *dev = rq->rq_disk->private_data;
> > +     struct rnbd_iu *iu = blk_mq_rq_to_pdu(rq);
> > +     int err;
> > +
> > +     if (unlikely(dev->dev_state != DEV_STATE_MAPPED))
> > +             return BLK_STS_IOERR;
> > +
> > +     iu->permit = rnbd_get_permit(dev->sess, RTRS_IO_CON,
> > +                                   RTRS_PERMIT_NOWAIT);
> > +     if (unlikely(!iu->permit)) {
> > +             rnbd_clt_dev_kick_mq_queue(dev, hctx, RNBD_DELAY_IFBUSY);
> > +             return BLK_STS_RESOURCE;
> > +     }
> > +
> > +     blk_mq_start_request(rq);
> > +     err = rnbd_client_xfer_request(dev, rq, iu);
> > +     if (likely(err == 0))
> > +             return BLK_STS_OK;
> > +     if (unlikely(err == -EAGAIN || err == -ENOMEM)) {
> > +             rnbd_clt_dev_kick_mq_queue(dev, hctx, RNBD_DELAY_10ms);
> > +             rnbd_put_permit(dev->sess, iu->permit);
> > +             return BLK_STS_RESOURCE;
> > +     }
> > +
> > +     rnbd_put_permit(dev->sess, iu->permit);
> > +     return BLK_STS_IOERR;
> > +}
>
> Would it be possible to use the .get_budget / .put_budget callbacks for
> obtaining / releasing a "permit" object? I'm asking this because it was
> really tricky to get the .get_budget / .put_budget calls right in the
> block layer core. See also commit 0bca799b9280 ("blk-mq: order getting
> budget and driver tag") # v4.17.

Will check if we can use .get_budget/put_budget call back.
>
> Thanks,
>
> Bart.
Thanks Bart
