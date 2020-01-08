Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371561344E4
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 15:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAHOWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 09:22:13 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38630 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgAHOWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 09:22:13 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so2792334ilq.5
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2020 06:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4L0Pdx4M+dUNNcTlTOui4h4we5UqnwVlJk4ErC6HCoY=;
        b=QHW2tlQ5jxhRzTYnqyTdODJ7Q5VHZnlneCPt3mEOWi01CGMrIIamgeD6I/zZVWs2Tf
         /JhbtuDYov3ntH8/14x8F2T2YN+COCA2Lxl03iVg6vafuumyJqH8SDtfHVcjB07Op45i
         FavpBedKvoJQVr3s41M27H3cCUCMAZiAUU96TPxMuk7atfsayqPcR17SHKuXyX9eypH6
         iK3MgZiUfbsjll3yY3L0QM/uLTISuQxcsJ2Y8xG+nU9Mmc4+QmM58TgWZy5xMGm9DZzI
         Zr1iqWq904nc7J+60fnqbe5FAus9L/MtPZ3x2jdYUMzZNMf0sP89R8yfNqu4prgj0auq
         V1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4L0Pdx4M+dUNNcTlTOui4h4we5UqnwVlJk4ErC6HCoY=;
        b=i5rxrY7ItGkXOTd48K/BdwyTjW6+2EMiEuqwEwW863roXimKKDb5PaMgb8XOiNRAL9
         Nbg1WUw2OB9ON0eY1utK/sLZ0G6uf/mDAUfZM2ZhYush3EKXjZ/dNwdBnU3O9xlCUTOW
         cMai+wo0lh3JKHLLxC1Zvv9eOXp2VRDq9EAOVnsMqTVYvNVB06ef+zbJvlgLL/ljAbwd
         mTwO4HD0kBhkaCqD7o5b6RWnc9v95Egc41L6R2kxH4WDC3dXvGHlSrSce1wOxyo6nFZn
         WpQlLNQkoNZkN3emldReobsne2H5l63DWBGzIa05fFi/0Gfqmlwf2clgC9kMYZPOLs0w
         XFOg==
X-Gm-Message-State: APjAAAUGFfh11L9Cz/XHcO/K0YeoJeZdyDDF3p4t6/CadwP1Z5uq94e1
        HBYZhsxq2Pb2IOcI9A3uoGWUzzibq649Q6gJyne6Jg==
X-Google-Smtp-Source: APXvYqxE8DTjI/kYFc6Eod07f6NpDAfu9eUS8dRgkrrNH992e7HubiZpVGbeXDu2qQPUdchvf1qJIGa/WLL0E11MHMU=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr3906828ils.54.1578493332379;
 Wed, 08 Jan 2020 06:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-18-jinpuwang@gmail.com>
 <aa7eeeda-b3d7-4a26-9043-53ce8c80eef1@acm.org>
In-Reply-To: <aa7eeeda-b3d7-4a26-9043-53ce8c80eef1@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 15:22:01 +0100
Message-ID: <CAMGffEkYVzFJX2=pur7+_gqOsOSiMLpu08Z7eCVs4N3ruz=QWw@mail.gmail.com>
Subject: Re: [PATCH v6 17/25] rnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 3, 2020 at 12:55 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +MODULE_DESCRIPTION("InfiniBand Network Block Device Client");
>
> InfiniBand or RDMA?
will fix.
>
> > +static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
> > +                               const struct rnbd_msg_open_rsp *rsp)
> > +{
> > +     struct rnbd_clt_session *sess = dev->sess;
> > +
> > +     if (unlikely(!rsp->logical_block_size))
> > +             return -EINVAL;
> > +
> > +     dev->device_id              = le32_to_cpu(rsp->device_id);
> > +     dev->nsectors               = le64_to_cpu(rsp->nsectors);
> > +     dev->logical_block_size     = le16_to_cpu(rsp->logical_block_size);
> > +     dev->physical_block_size    = le16_to_cpu(rsp->physical_block_size);
> > +     dev->max_write_same_sectors = le32_to_cpu(rsp->max_write_same_sectors);
> > +     dev->max_discard_sectors    = le32_to_cpu(rsp->max_discard_sectors);
> > +     dev->discard_granularity    = le32_to_cpu(rsp->discard_granularity);
> > +     dev->discard_alignment      = le32_to_cpu(rsp->discard_alignment);
> > +     dev->secure_discard         = le16_to_cpu(rsp->secure_discard);
> > +     dev->rotational             = rsp->rotational;
> > +
> > +     dev->max_hw_sectors = sess->max_io_size / dev->logical_block_size;
>
> The above statement looks suspicious to me. The unit of the second
> argument of blk_queue_max_hw_sectors() is 512 bytes. Since
> dev->max_hw_sectors is passed as the second argument to
> blk_queue_max_hw_sectors() I think it should also have 512 bytes as unit
> instead of the logical block size.
You're right, will fix.
>
> > +static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
> > +                                  size_t new_nsectors)
> > +{
> > +     int err = 0;
> > +
> > +     rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n",
> > +                    dev->nsectors, new_nsectors);
> > +     dev->nsectors = new_nsectors;
> > +     set_capacity(dev->gd,
> > +                  dev->nsectors * (dev->logical_block_size /
> > +                                   SECTOR_SIZE));
> > +     err = revalidate_disk(dev->gd);
> > +     if (err)
> > +             rnbd_clt_err(dev,
> > +                           "Failed to change device size from %zu to %zu, err: %d\n",
> > +                           dev->nsectors, new_nsectors, err);
> > +     return err;
> > +}
>
> Please document the unit of nsectors in struct rnbd_clt_dev. Please also
> document the unit of the 'new_nsectors' argument.
will do. The unit of nsectors is 512b.
>
> > +static void msg_io_conf(void *priv, int errno)
> > +{
> > +     struct rnbd_iu *iu = priv;
> > +     struct rnbd_clt_dev *dev = iu->dev;
> > +     struct request *rq = iu->rq;
> > +
> > +     iu->status = errno ? BLK_STS_IOERR : BLK_STS_OK;
> > +
> > +     blk_mq_complete_request(rq);
> > +
> > +     if (errno)
> > +             rnbd_clt_info_rl(dev, "%s I/O failed with err: %d\n",
> > +                               rq_data_dir(rq) == READ ? "read" : "write",
> > +                               errno);
> > +}
>
> Accessing 'rq' after having called blk_mq_complete_request() may trigger
> a use-after-free. Please don't do that.
You are right, will fix.

>
> > +static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
> > +__releases(&sess_lock)
> > +__acquires(&sess_lock)
>
> Please indent __releases() and __acquires() annotations.
ok.


>
> > +static int setup_mq_tags(struct rnbd_clt_session *sess)
> > +{
> > +     struct blk_mq_tag_set *tags = &sess->tag_set;
> > +
> > +     memset(tags, 0, sizeof(*tags));
> > +     tags->ops               = &rnbd_mq_ops;
> > +     tags->queue_depth       = sess->queue_depth;
> > +     tags->numa_node         = NUMA_NO_NODE;
> > +     tags->flags             = BLK_MQ_F_SHOULD_MERGE |
> > +                               BLK_MQ_F_TAG_SHARED;
> > +     tags->cmd_size          = sizeof(struct rnbd_iu);
> > +     tags->nr_hw_queues      = num_online_cpus();
> > +
> > +     return blk_mq_alloc_tag_set(tags);
> > +}
>
> Please change the name of the "tags" pointer into "tag_set".
ok.
>
> > +static int index_to_minor(int index)
> > +{
> > +     return index << RNBD_PART_BITS;
> > +}
> > +
> > +static int minor_to_index(int minor)
> > +{
> > +     return minor >> RNBD_PART_BITS;
> > +}
>
> Is it useful to introduce functions that encapsulate a single shift
> operation?
can be dropped, althrough it's common to do it this way, plenty of
examples in kernel tree.
>
> > +     blk_queue_virt_boundary(dev->queue, 4095);
>
> The virt_boundary parameter must match the RDMA memory registration page
> size. Please introduce a symbolic constant for the RDMA memory
> registration page size such that these two parameters stay in sync in
> case anyone would want to change the memory registration page size.
>
> > +static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
> > +{
> > +     dev->gd->major          = rnbd_client_major;
> > +     dev->gd->first_minor    = index_to_minor(idx);
> > +     dev->gd->fops           = &rnbd_client_ops;
> > +     dev->gd->queue          = dev->queue;
> > +     dev->gd->private_data   = dev;
> > +     snprintf(dev->gd->disk_name, sizeof(dev->gd->disk_name), "rnbd%d",
> > +              idx);
> > +     pr_debug("disk_name=%s, capacity=%zu\n",
> > +              dev->gd->disk_name,
> > +              dev->nsectors * (dev->logical_block_size / SECTOR_SIZE)
> > +              );
> > +
> > +     set_capacity(dev->gd, dev->nsectors * (dev->logical_block_size /
> > +                                            SECTOR_SIZE));
>
> Again, what is the unit of dev->nsectors?
The unit is 512b, I will remove the multipler, in most of the case
logical_block_size is SECTOR_SIZE.
>
> > +static void rnbd_clt_add_gen_disk(struct rnbd_clt_dev *dev)
> > +{
> > +     add_disk(dev->gd);
> > +}
>
> Is it useful to introduce this wrapper around add_disk()?
will remove the wrapper.

>
> Thanks,
>
> Bart.
Thanks Bart.
