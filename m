Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178B2B6F0B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 23:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbfIRVqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 17:46:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36798 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388135AbfIRVqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 17:46:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so858674pfr.3;
        Wed, 18 Sep 2019 14:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ToE36TXyPvjUmT2q612I/w8lZAj5I/Vf7MAwIwtPbE=;
        b=Zk00P3DMH0DJotVDsgwhKXiY7uHS7iO3vhBkrIE7fk/JK69SmvodlhO4btFvwsjOVc
         CN/f2daXB5v4Msc+0l3Cwhe27NbhFWhjc+FeG5q7KWZ+Y+OMTEgmGeuJtAJRAOwlKI8X
         CYZ89nOwEq6LqQdTMGTV+Ix3nTJG68A9JSTqD7t2nkz62O6RjpuO1W4BCbb27jIoaFzj
         zNOQXQ1Zv1mV9IhkBsL49kKcoZWDDBTEWi3dkqh5ZTM2CgHcH0IVEMnViXnpTy/RKHIm
         oQHwGqRNtlPxxwt5n+hXF3Qm2oMaWOeTxvnTF4+A9Jqp6qOb4dGk8Lk/QuAfApEX5xkj
         hIVA==
X-Gm-Message-State: APjAAAW3vrQi2MW7iARM8M62qeGdki5yJRNeyNaofDXiVHRCA7h3dlCn
        ng9wHA3+qZAWuxnOvDoiyjM=
X-Google-Smtp-Source: APXvYqxhwtY/fEk55nOQQgf6oaUR6FukzEdXiWq8qdn3NQKbx40i578g6LsGGlAf2vYbYksJsbxA9A==
X-Received: by 2002:a17:90a:9a81:: with SMTP id e1mr37824pjp.95.1568843169464;
        Wed, 18 Sep 2019 14:46:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l124sm7581337pgl.54.2019.09.18.14.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 14:46:08 -0700 (PDT)
Subject: Re: [PATCH v4 21/25] ibnbd: server: functionality for IO submission
 to file or block dev
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-22-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org>
Date:   Wed, 18 Sep 2019 14:46:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-22-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt

Same comment as for a previous patch: please do not include line number 
information in pr_fmt().

> +static int ibnbd_dev_vfs_open(struct ibnbd_dev *dev, const char *path,
> +			      fmode_t flags)
> +{
> +	int oflags = O_DSYNC; /* enable write-through */
> +
> +	if (flags & FMODE_WRITE)
> +		oflags |= O_RDWR;
> +	else if (flags & FMODE_READ)
> +		oflags |= O_RDONLY;
> +	else
> +		return -EINVAL;
> +
> +	dev->file = filp_open(path, oflags, 0);
> +	return PTR_ERR_OR_ZERO(dev->file);
> +}

Isn't the use of O_DSYNC something that should be configurable?

> +struct ibnbd_dev *ibnbd_dev_open(const char *path, fmode_t flags,
> +				 enum ibnbd_io_mode mode, struct bio_set *bs,
> +				 ibnbd_dev_io_fn io_cb)
> +{
> +	struct ibnbd_dev *dev;
> +	int ret;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (mode == IBNBD_BLOCKIO) {
> +		dev->blk_open_flags = flags;
> +		ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
> +		if (ret)
> +			goto err;
> +	} else if (mode == IBNBD_FILEIO) {
> +		dev->blk_open_flags = FMODE_READ;
> +		ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
> +		if (ret)
> +			goto err;
> +
> +		ret = ibnbd_dev_vfs_open(dev, path, flags);
> +		if (ret)
> +			goto blk_put;

This looks really weird. Why to call ibnbd_dev_blk_open() first for file 
I/O mode? Why to set dev->blk_open_flags to FMODE_READ in file I/O mode?

> +static int ibnbd_dev_blk_submit_io(struct ibnbd_dev *dev, sector_t sector,
> +				   void *data, size_t len, u32 bi_size,
> +				   enum ibnbd_io_flags flags, short prio,
> +				   void *priv)
> +{
> +	struct request_queue *q = bdev_get_queue(dev->bdev);
> +	struct ibnbd_dev_blk_io *io;
> +	struct bio *bio;
> +
> +	/* check if the buffer is suitable for bdev */
> +	if (unlikely(WARN_ON(!blk_rq_aligned(q, (unsigned long)data, len))))
> +		return -EINVAL;
> +
> +	/* Generate bio with pages pointing to the rdma buffer */
> +	bio = ibnbd_bio_map_kern(q, data, dev->ibd_bio_set, len, GFP_KERNEL);
> +	if (unlikely(IS_ERR(bio)))
> +		return PTR_ERR(bio);
> +
> +	io = kmalloc(sizeof(*io), GFP_KERNEL);
> +	if (unlikely(!io)) {
> +		bio_put(bio);
> +		return -ENOMEM;
> +	}
> +
> +	io->dev		= dev;
> +	io->priv	= priv;
> +
> +	bio->bi_end_io		= ibnbd_dev_bi_end_io;
> +	bio->bi_private		= io;
> +	bio->bi_opf		= ibnbd_to_bio_flags(flags);
> +	bio->bi_iter.bi_sector	= sector;
> +	bio->bi_iter.bi_size	= bi_size;
> +	bio_set_prio(bio, prio);
> +	bio_set_dev(bio, dev->bdev);
> +
> +	submit_bio(bio);
> +
> +	return 0;
> +}

Can struct bio and struct ibnbd_dev_blk_io be combined into a single 
data structure by passing the size of the latter data structure as the 
front_pad argument to bioset_init()?

> +static void ibnbd_dev_file_submit_io_worker(struct work_struct *w)
> +{
> +	struct ibnbd_dev_file_io_work *dev_work;
> +	struct file *f;
> +	int ret, len;
> +	loff_t off;
> +
> +	dev_work = container_of(w, struct ibnbd_dev_file_io_work, work);
> +	off = dev_work->sector * ibnbd_dev_get_logical_bsize(dev_work->dev);
> +	f = dev_work->dev->file;
> +	len = dev_work->bi_size;
> +
> +	if (ibnbd_op(dev_work->flags) == IBNBD_OP_FLUSH) {
> +		ret = ibnbd_dev_file_handle_flush(dev_work, off);
> +		if (unlikely(ret))
> +			goto out;
> +	}
> +
> +	if (ibnbd_op(dev_work->flags) == IBNBD_OP_WRITE_SAME) {
> +		ret = ibnbd_dev_file_handle_write_same(dev_work);
> +		if (unlikely(ret))
> +			goto out;
> +	}
> +
> +	/* TODO Implement support for DIRECT */
> +	if (dev_work->bi_size) {
> +		loff_t off_tmp = off;
> +
> +		if (ibnbd_op(dev_work->flags) == IBNBD_OP_WRITE)
> +			ret = kernel_write(f, dev_work->data, dev_work->bi_size,
> +					   &off_tmp);
> +		else
> +			ret = kernel_read(f, dev_work->data, dev_work->bi_size,
> +					  &off_tmp);
> +
> +		if (unlikely(ret < 0)) {
> +			goto out;
> +		} else if (unlikely(ret != dev_work->bi_size)) {
> +			/* TODO implement support for partial completions */
> +			ret = -EIO;
> +			goto out;
> +		} else {
> +			ret = 0;
> +		}
> +	}
> +
> +	if (dev_work->flags & IBNBD_F_FUA)
> +		ret = ibnbd_dev_file_handle_fua(dev_work, off);
> +out:
> +	dev_work->dev->io_cb(dev_work->priv, ret);
> +	kfree(dev_work);
> +}
> +
> +static int ibnbd_dev_file_submit_io(struct ibnbd_dev *dev, sector_t sector,
> +				    void *data, size_t len, size_t bi_size,
> +				    enum ibnbd_io_flags flags, void *priv)
> +{
> +	struct ibnbd_dev_file_io_work *w;
> +
> +	if (!ibnbd_flags_supported(flags)) {
> +		pr_info_ratelimited("Unsupported I/O flags: 0x%x on device "
> +				    "%s\n", flags, dev->name);
> +		return -ENOTSUPP;
> +	}
> +
> +	w = kmalloc(sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	w->dev		= dev;
> +	w->priv		= priv;
> +	w->sector	= sector;
> +	w->data		= data;
> +	w->len		= len;
> +	w->bi_size	= bi_size;
> +	w->flags	= flags;
> +	INIT_WORK(&w->work, ibnbd_dev_file_submit_io_worker);
> +
> +	if (unlikely(!queue_work(fileio_wq, &w->work))) {
> +		kfree(w);
> +		return -EEXIST;
> +	}
> +
> +	return 0;
> +}

Please use the in-kernel asynchronous I/O API instead of kernel_read() 
and kernel_write() and remove the fileio_wq workqueue. Examples of how 
to use call_read_iter() and call_write_iter() are available in the loop 
driver and also in drivers/target/target_core_file.c.

> +/** ibnbd_dev_init() - Initialize ibnbd_dev
> + *
> + * This functions initialized the ibnbd-dev component.
> + * It has to be called 1x time before ibnbd_dev_open() is used
> + */
> +int ibnbd_dev_init(void);

It is great so see kernel-doc headers above functions but I'm not sure 
these should be in .h files. I think most kernel developers prefer to 
see kernel-doc headers for functions in .c files because that makes it 
more likely that the implementation and the documentation stay in sync.

Thanks,

Bart.
