Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEE199316
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 12:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgCaKGT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 06:06:19 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38529 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaKGT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 06:06:19 -0400
Received: by mail-il1-f194.google.com with SMTP id n13so11510831ilm.5
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/q0b7Kzx09DKHFVq7TZK24FeG5bPBt0tNn1Z3D6a7U=;
        b=SiBhMQCTaHeow+b9MjA7NpkwDE5wxE3JTXi9zvAi6wuMhyy1KDDLVusBE7kBd9MI7K
         eNw2p8xwTfkCdN26TMaUHgBwn0FEtT/PhKUHIPvnVEg+BT7ZLLgHFVcsYNZGcEFAsDqI
         Gtwr8647uU3xLUyuvNAdhaHKG+N/XXGhs/n6RzbMl0EeylLun1qeJZqpqLkqnIgr7wj3
         6IhaKBcCe8+L7q9Aa6mvS11ih5xs1y5OjAbyweLUkN/bOSMSfuoo/iAKzgThR3S+vPGA
         w/Wh8yIGuw6mxu2OMnaT5zYq2+zbLnJ2k8HhqasrTPE8BijyuhSEozDu1aohs4nLw7z8
         M7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/q0b7Kzx09DKHFVq7TZK24FeG5bPBt0tNn1Z3D6a7U=;
        b=W8U1gKFKZcs4ZmjCoK1iF/q86Gmw1KaoVjq89Epuq7IOu41SeQ4CeyalOdZDCtEqgk
         JfTIqfWLz1tdqyFChoddX5X6/JYTKVAraKyDh1f5IvrBJhqRdfwzgeGh83eddQYVuECq
         wtJzSDOvVdMEngrAGk8DvthhAOedG/3+HlrYmBx/Mw1wGhGyEuRu2Zk7j5SXo3y3wMSI
         v3uuuPYVO2Zf9iudg3KRGh10TfH1/0Isgc/j92O3JrTtWREHamBKlR/QXNFvFDa0fPvC
         qjaf1U8094Z07WxZg20k45b74T2qkGPjdhA/Bt89tHB/JbX0JutjEIfYWV/r/WEvnHps
         1jGA==
X-Gm-Message-State: ANhLgQ3JuwNMYqqyJJwfMywKxQMwhMGZIjVreaIm876EL0zU7dJmo4Md
        TARNJUEJEL4CbSoockPiy4prbXlC6GYermO/pWjtLA==
X-Google-Smtp-Source: ADFU+vv6hKaEqso2DnDXTCXoa2/qNjMTc1trXWL3+hEyPk4kS0AY0QrP+wWr1rfIaIl7a2bDlUgRHYalMZB6f9W/lvo=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr15181856ili.217.1585649176303;
 Tue, 31 Mar 2020 03:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-23-jinpu.wang@cloud.ionos.com> <cfe1dba2-04f7-f74d-af90-c70dce4d85cf@acm.org>
In-Reply-To: <cfe1dba2-04f7-f74d-af90-c70dce4d85cf@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 12:06:05 +0200
Message-ID: <CAMGffEkOM9k2A60OHPBbPqRPp09+D5DeThB3iMLFqnLjLc=QAg@mail.gmail.com>
Subject: Re: [PATCH v11 22/26] block/rnbd: server: functionality for IO
 submission to file or block dev
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

On Sat, Mar 28, 2020 at 7:39 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > This provides helper functions for IO submission to file or block dev.
>
> Regarding the title of this patch: is file I/O still supported? Wasn't
> that support removed some time ago?
Sorry, we forget to update it, will fix.
>
> > +struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
> > +                            void (*io_cb)(void *priv, int error))
> > +{
> > +     struct rnbd_dev *dev;
> > +     int ret;
> > +
> > +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > +     if (!dev)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     dev->blk_open_flags = flags;
> > +     dev->bdev = blkdev_get_by_path(path, flags, THIS_MODULE);
> > +     ret = PTR_ERR_OR_ZERO(dev->bdev);
> > +     if (ret)
> > +             goto err;
> > +
> > +     dev->blk_open_flags     = flags;
> > +     dev->io_cb              = io_cb;
> > +     bdevname(dev->bdev, dev->name);
> > +
> > +     return dev;
> > +
> > +err:
> > +     kfree(dev);
> > +     return ERR_PTR(ret);
> > +}
>
> This function only has one caller so io_cb is always equal to the
> argument passed by that single caller, namely rnbd_endio. If that
> argument and also dev->io_cb would be removed, would that make the hot
> path faster?
Sounds good, will do it.

>
> > +int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
> > +                     size_t len, u32 bi_size, enum rnbd_io_flags flags,
> > +                     short prio, void *priv)
> > +{
> > +     struct request_queue *q = bdev_get_queue(dev->bdev);
> > +     struct rnbd_dev_blk_io *io;
> > +     struct bio *bio;
> > +
> > +     /* check if the buffer is suitable for bdev */
> > +     if (WARN_ON(!blk_rq_aligned(q, (unsigned long)data, len)))
> > +             return -EINVAL;
>
> The blk_rq_aligned() check looks weird to me. bio_map_kern() can handle
> data buffers that do not match the DMA alignment requirements, so why to
> refuse data buffers that are not satisfy DMA alignment requirements?
We add the check since 2014 to make sure the data buffer is aligned.
AFAIR we nerver see the WARN triggered.
so will remove it.
>
> > +     /* Generate bio with pages pointing to the rdma buffer */
> > +     bio = bio_map_kern(q, data, len, GFP_KERNEL);
> > +     if (IS_ERR(bio))
> > +             return PTR_ERR(bio);
> > +
> > +     io = kmalloc(sizeof(*io), GFP_KERNEL);
> > +     if (unlikely(!io)) {
> > +             bio_put(bio);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     io->dev         = dev;
> > +     io->priv        = priv;
> > +
> > +     bio->bi_end_io          = rnbd_dev_bi_end_io;
> > +     bio->bi_private         = io;
> > +     bio->bi_opf             = rnbd_to_bio_flags(flags);
> > +     bio->bi_iter.bi_sector  = sector;
> > +     bio->bi_iter.bi_size    = bi_size;
> > +     bio_set_prio(bio, prio);
> > +     bio_set_dev(bio, dev->bdev);
>
> I think Jason strongly prefers to have a single space at the left of the
> assignment operator.
ok.
>
> Thanks,
>
> Bart.
Thanks!
