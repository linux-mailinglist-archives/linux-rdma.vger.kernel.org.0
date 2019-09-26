Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0111BF4A2
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfIZOES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 10:04:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfIZOES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 10:04:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so2611902wrm.12
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XsPuDHi2ynQ6QAj5YbUKfOq/+CyZdo6vP6LPWlV6PSM=;
        b=PnZtH9wuc2r1KEtR1SIstJi6T/KIh+koQEemkl8vn/iZNhXm0A9e3QZlxG4m6ATcis
         sCEOfsBAEWwAZksJ7NIDyRnxd+vpxZXgnEJ8DexMz50jzDV8o2O7zRKa6YAIL1PULIBF
         MMLnrKv+Nj4YGbZS9gSmUgRatgCFR2kIR3uTtWe6VpzawkMyKivDTbr9AQgB+GIsXKBQ
         52g5WiiZyKTzZG3yH3bEkjUyCbyS9ECikfL984T/9hjZqsf1DHwyaYj1qXHshp6HtSQk
         gv676dgOHhLEKSeiWCzF9lYsxfyndNcdVcGycCybu9p5ZXtsXvXRh7fDeSksLz6yI+q+
         jFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsPuDHi2ynQ6QAj5YbUKfOq/+CyZdo6vP6LPWlV6PSM=;
        b=qhCIluhLAi3KL5Nca0Nhw+BxtYZxz+ize5oKAAOTOEs69FhbvL3Qzn5nvdWJt+pVk1
         7bPoX9384WDvJwOajtDwNdjw0dbj6AG56+EjfPFLIJM8TILijyFRq2SuJ8Qo4Fu+iP07
         A9jrRRn7ghCSWdCceuv4qG5UQUL8HidWOm99m+BbnVT/b2KCldeiLMEvXoRJaGKcs1+R
         uSti7GCfYc2IiilnPAOllvRrbnsLYpEq2Zt9XBWwl+W/WGasDr9EBfkSspkqvZ6vy6bQ
         2Bct7Z23kHom+vRI/2GWMz5hbY+joAB+ZNJqzIgP5JoT1TbgSJXExQUUYU7LSYC6nrPf
         Qxeg==
X-Gm-Message-State: APjAAAW981/eLjmr9KRpM8YYipfxDvf8hV78011tgPE7TCjeb/IMYd7K
        ipoPdtonWSUkMxwY/Up5ZA+rObvPoDviG1jbBSba3Q==
X-Google-Smtp-Source: APXvYqxaUx+iFUDoOgqGKKtG58PEuR33vn0t0LA+hMgPq7IMtgJs16X8wi+flQC3CCTdDLnQPwaUmtbhat66puCFKeg=
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr2743974wru.284.1569506654263;
 Thu, 26 Sep 2019 07:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-22-jinpuwang@gmail.com>
 <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org>
In-Reply-To: <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 16:04:03 +0200
Message-ID: <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
Subject: Re: [PATCH v4 21/25] ibnbd: server: functionality for IO submission
 to file or block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry for the slow reply.

On Wed, Sep 18, 2019 at 11:46 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
>
> Same comment as for a previous patch: please do not include line number
> information in pr_fmt().
Ok, will be removed.

>
> > +static int ibnbd_dev_vfs_open(struct ibnbd_dev *dev, const char *path,
> > +                           fmode_t flags)
> > +{
> > +     int oflags = O_DSYNC; /* enable write-through */
> > +
> > +     if (flags & FMODE_WRITE)
> > +             oflags |= O_RDWR;
> > +     else if (flags & FMODE_READ)
> > +             oflags |= O_RDONLY;
> > +     else
> > +             return -EINVAL;
> > +
> > +     dev->file = filp_open(path, oflags, 0);
> > +     return PTR_ERR_OR_ZERO(dev->file);
> > +}
>
> Isn't the use of O_DSYNC something that should be configurable?
I know scst allow O_DSYNC to be configured, but in our production, we
only use with O_DSYNC,
 we sure can add options to allow it to configure it, but we don't
have a need yet.
>
> > +struct ibnbd_dev *ibnbd_dev_open(const char *path, fmode_t flags,
> > +                              enum ibnbd_io_mode mode, struct bio_set *bs,
> > +                              ibnbd_dev_io_fn io_cb)
> > +{
> > +     struct ibnbd_dev *dev;
> > +     int ret;
> > +
> > +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > +     if (!dev)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     if (mode == IBNBD_BLOCKIO) {
> > +             dev->blk_open_flags = flags;
> > +             ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
> > +             if (ret)
> > +                     goto err;
> > +     } else if (mode == IBNBD_FILEIO) {
> > +             dev->blk_open_flags = FMODE_READ;
> > +             ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
> > +             if (ret)
> > +                     goto err;
> > +
> > +             ret = ibnbd_dev_vfs_open(dev, path, flags);
> > +             if (ret)
> > +                     goto blk_put;
>
> This looks really weird. Why to call ibnbd_dev_blk_open() first for file
> I/O mode? Why to set dev->blk_open_flags to FMODE_READ in file I/O mode?

The reason behind is we want to be able to symlink to the block device.
And for File io mode, we only allow exporting block device.


>
> > +static int ibnbd_dev_blk_submit_io(struct ibnbd_dev *dev, sector_t sector,
> > +                                void *data, size_t len, u32 bi_size,
> > +                                enum ibnbd_io_flags flags, short prio,
> > +                                void *priv)
> > +{
> > +     struct request_queue *q = bdev_get_queue(dev->bdev);
> > +     struct ibnbd_dev_blk_io *io;
> > +     struct bio *bio;
> > +
> > +     /* check if the buffer is suitable for bdev */
> > +     if (unlikely(WARN_ON(!blk_rq_aligned(q, (unsigned long)data, len))))
> > +             return -EINVAL;
> > +
> > +     /* Generate bio with pages pointing to the rdma buffer */
> > +     bio = ibnbd_bio_map_kern(q, data, dev->ibd_bio_set, len, GFP_KERNEL);
> > +     if (unlikely(IS_ERR(bio)))
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
> > +     bio->bi_end_io          = ibnbd_dev_bi_end_io;
> > +     bio->bi_private         = io;
> > +     bio->bi_opf             = ibnbd_to_bio_flags(flags);
> > +     bio->bi_iter.bi_sector  = sector;
> > +     bio->bi_iter.bi_size    = bi_size;
> > +     bio_set_prio(bio, prio);
> > +     bio_set_dev(bio, dev->bdev);
> > +
> > +     submit_bio(bio);
> > +
> > +     return 0;
> > +}
>
> Can struct bio and struct ibnbd_dev_blk_io be combined into a single
> data structure by passing the size of the latter data structure as the
> front_pad argument to bioset_init()?
Thanks for the suggestion, will look into it,
looks we can embed struct bio to struct ibnbd_dev_blk_io.
>
> > +static void ibnbd_dev_file_submit_io_worker(struct work_struct *w)
> > +{
> > +     struct ibnbd_dev_file_io_work *dev_work;
> > +     struct file *f;
> > +     int ret, len;
> > +     loff_t off;
> > +
> > +     dev_work = container_of(w, struct ibnbd_dev_file_io_work, work);
> > +     off = dev_work->sector * ibnbd_dev_get_logical_bsize(dev_work->dev);
> > +     f = dev_work->dev->file;
> > +     len = dev_work->bi_size;
> > +
> > +     if (ibnbd_op(dev_work->flags) == IBNBD_OP_FLUSH) {
> > +             ret = ibnbd_dev_file_handle_flush(dev_work, off);
> > +             if (unlikely(ret))
> > +                     goto out;
> > +     }
> > +
> > +     if (ibnbd_op(dev_work->flags) == IBNBD_OP_WRITE_SAME) {
> > +             ret = ibnbd_dev_file_handle_write_same(dev_work);
> > +             if (unlikely(ret))
> > +                     goto out;
> > +     }
> > +
> > +     /* TODO Implement support for DIRECT */
> > +     if (dev_work->bi_size) {
> > +             loff_t off_tmp = off;
> > +
> > +             if (ibnbd_op(dev_work->flags) == IBNBD_OP_WRITE)
> > +                     ret = kernel_write(f, dev_work->data, dev_work->bi_size,
> > +                                        &off_tmp);
> > +             else
> > +                     ret = kernel_read(f, dev_work->data, dev_work->bi_size,
> > +                                       &off_tmp);
> > +
> > +             if (unlikely(ret < 0)) {
> > +                     goto out;
> > +             } else if (unlikely(ret != dev_work->bi_size)) {
> > +                     /* TODO implement support for partial completions */
> > +                     ret = -EIO;
> > +                     goto out;
> > +             } else {
> > +                     ret = 0;
> > +             }
> > +     }
> > +
> > +     if (dev_work->flags & IBNBD_F_FUA)
> > +             ret = ibnbd_dev_file_handle_fua(dev_work, off);
> > +out:
> > +     dev_work->dev->io_cb(dev_work->priv, ret);
> > +     kfree(dev_work);
> > +}
> > +
> > +static int ibnbd_dev_file_submit_io(struct ibnbd_dev *dev, sector_t sector,
> > +                                 void *data, size_t len, size_t bi_size,
> > +                                 enum ibnbd_io_flags flags, void *priv)
> > +{
> > +     struct ibnbd_dev_file_io_work *w;
> > +
> > +     if (!ibnbd_flags_supported(flags)) {
> > +             pr_info_ratelimited("Unsupported I/O flags: 0x%x on device "
> > +                                 "%s\n", flags, dev->name);
> > +             return -ENOTSUPP;
> > +     }
> > +
> > +     w = kmalloc(sizeof(*w), GFP_KERNEL);
> > +     if (!w)
> > +             return -ENOMEM;
> > +
> > +     w->dev          = dev;
> > +     w->priv         = priv;
> > +     w->sector       = sector;
> > +     w->data         = data;
> > +     w->len          = len;
> > +     w->bi_size      = bi_size;
> > +     w->flags        = flags;
> > +     INIT_WORK(&w->work, ibnbd_dev_file_submit_io_worker);
> > +
> > +     if (unlikely(!queue_work(fileio_wq, &w->work))) {
> > +             kfree(w);
> > +             return -EEXIST;
> > +     }
> > +
> > +     return 0;
> > +}
>
> Please use the in-kernel asynchronous I/O API instead of kernel_read()
> and kernel_write() and remove the fileio_wq workqueue. Examples of how
> to use call_read_iter() and call_write_iter() are available in the loop
> driver and also in drivers/target/target_core_file.c.
What the benefits of using call_read_iter/call_write_iter, does it
offer better performance?

>
> > +/** ibnbd_dev_init() - Initialize ibnbd_dev
> > + *
> > + * This functions initialized the ibnbd-dev component.
> > + * It has to be called 1x time before ibnbd_dev_open() is used
> > + */
> > +int ibnbd_dev_init(void);
>
> It is great so see kernel-doc headers above functions but I'm not sure
> these should be in .h files. I think most kernel developers prefer to
> see kernel-doc headers for functions in .c files because that makes it
> more likely that the implementation and the documentation stay in sync.
>
Ok, will move the kernel doc to source code.
I feel for exported functions, it's more common to do it in header files.
For this case, I think it's fine to move the kernel-doc to the c file.

Thanks,
Jinpu
