Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB912F1F1
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 00:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgABXzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 18:55:12 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51803 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgABXzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 18:55:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so3898130pjs.1;
        Thu, 02 Jan 2020 15:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v32dZ+udumyuAMaUwzeqF4n4dG5pFYVxWDgOUZcjg8s=;
        b=GWbnSItrVo3+1V65UEjj9FagUPd7KwCDLbJ8cnctDfsjAimkEvo90mK0QB+SPup4Qo
         RrOrHItpbTon+RGp/JSes8GG1QbY63srjyOxhUWg0y0i+rkWxBZjiQS9xgfbOIkg2/dS
         VX91fDhcVomkbX9F2ky3vXDaRURMy7tFxP/zitwBFvVkAY8gvX6UaJa+zfznEy9JrYqe
         GOb5tpjmTVf2qA2Xk0Nqzn9mJYN4LGUDqQ16Uue2VUJfioj+NkcZVFe1MKshBJ5tlzb2
         dm2UBlMWuIOKZM7ZlepBqfePwaRsDTH2mbbximvQGSF1UgRydowXsMQIDOxLGWfckYRu
         K/Uw==
X-Gm-Message-State: APjAAAVpiOWQUIE2KV+RLi0exuqPhpU1P4tlFokAzsBBQgWZVLMKd4xD
        zpJ0vuVCGRxU2wKvLHff+OA=
X-Google-Smtp-Source: APXvYqz6HOhDUkQa9FuUo1lgEnHg1dXHGBYG1h3gfqOTRlfONHO/96b7CXA2Srvirya3mEb0D584KQ==
X-Received: by 2002:a17:902:7586:: with SMTP id j6mr82611460pll.299.1578009311288;
        Thu, 02 Jan 2020 15:55:11 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d4sm12300120pjz.12.2020.01.02.15.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 15:55:10 -0800 (PST)
Subject: Re: [PATCH v6 17/25] rnbd: client: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-18-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <aa7eeeda-b3d7-4a26-9043-53ce8c80eef1@acm.org>
Date:   Thu, 2 Jan 2020 15:55:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-18-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +MODULE_DESCRIPTION("InfiniBand Network Block Device Client");

InfiniBand or RDMA?

> +static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
> +				  const struct rnbd_msg_open_rsp *rsp)
> +{
> +	struct rnbd_clt_session *sess = dev->sess;
> +
> +	if (unlikely(!rsp->logical_block_size))
> +		return -EINVAL;
> +
> +	dev->device_id		    = le32_to_cpu(rsp->device_id);
> +	dev->nsectors		    = le64_to_cpu(rsp->nsectors);
> +	dev->logical_block_size	    = le16_to_cpu(rsp->logical_block_size);
> +	dev->physical_block_size    = le16_to_cpu(rsp->physical_block_size);
> +	dev->max_write_same_sectors = le32_to_cpu(rsp->max_write_same_sectors);
> +	dev->max_discard_sectors    = le32_to_cpu(rsp->max_discard_sectors);
> +	dev->discard_granularity    = le32_to_cpu(rsp->discard_granularity);
> +	dev->discard_alignment	    = le32_to_cpu(rsp->discard_alignment);
> +	dev->secure_discard	    = le16_to_cpu(rsp->secure_discard);
> +	dev->rotational		    = rsp->rotational;
> +
> +	dev->max_hw_sectors = sess->max_io_size / dev->logical_block_size;

The above statement looks suspicious to me. The unit of the second 
argument of blk_queue_max_hw_sectors() is 512 bytes. Since 
dev->max_hw_sectors is passed as the second argument to 
blk_queue_max_hw_sectors() I think it should also have 512 bytes as unit 
instead of the logical block size.

> +static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
> +				     size_t new_nsectors)
> +{
> +	int err = 0;
> +
> +	rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n",
> +		       dev->nsectors, new_nsectors);
> +	dev->nsectors = new_nsectors;
> +	set_capacity(dev->gd,
> +		     dev->nsectors * (dev->logical_block_size /
> +				      SECTOR_SIZE));
> +	err = revalidate_disk(dev->gd);
> +	if (err)
> +		rnbd_clt_err(dev,
> +			      "Failed to change device size from %zu to %zu, err: %d\n",
> +			      dev->nsectors, new_nsectors, err);
> +	return err;
> +}

Please document the unit of nsectors in struct rnbd_clt_dev. Please also 
document the unit of the 'new_nsectors' argument.

The set_capacity() call can only be correct if the unit of dev->nsectors 
is one logical block. Is that really the case?

> +static void msg_io_conf(void *priv, int errno)
> +{
> +	struct rnbd_iu *iu = priv;
> +	struct rnbd_clt_dev *dev = iu->dev;
> +	struct request *rq = iu->rq;
> +
> +	iu->status = errno ? BLK_STS_IOERR : BLK_STS_OK;
> +
> +	blk_mq_complete_request(rq);
> +
> +	if (errno)
> +		rnbd_clt_info_rl(dev, "%s I/O failed with err: %d\n",
> +				  rq_data_dir(rq) == READ ? "read" : "write",
> +				  errno);
> +}

Accessing 'rq' after having called blk_mq_complete_request() may trigger 
a use-after-free. Please don't do that.

> +static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
> +__releases(&sess_lock)
> +__acquires(&sess_lock)

Please indent __releases() and __acquires() annotations.

> +{
> +	DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
> +
> +	prepare_to_wait(&sess->rtrs_waitq, &wait, TASK_UNINTERRUPTIBLE);
> +	if (IS_ERR_OR_NULL(sess->rtrs)) {
> +		finish_wait(&sess->rtrs_waitq, &wait);
> +		return;
> +	}
> +	mutex_unlock(&sess_lock);
> +	/* After unlock session can be freed, so careful */
> +	schedule();
> +	mutex_lock(&sess_lock);
> +}

How can a function that calls schedule() and that is not surrounded by a 
loop be correct? What if e.g. schedule() finishes due to a spurious wakeup?

> +static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
> +__releases(&sess_lock)
> +__acquires(&sess_lock)
> +{
> +	struct rnbd_clt_session *sess;
> +	int err;
> +
> +again:
> +	list_for_each_entry(sess, &sess_list, list) {
> +		if (strcmp(sessname, sess->sessname))
> +			continue;
> +
> +		if (unlikely(sess->rtrs_ready && IS_ERR_OR_NULL(sess->rtrs)))
> +			/*
> +			 * No RTRS connection, session is dying.
> +			 */
> +			continue;
> +
> +		if (likely(rnbd_clt_get_sess(sess))) {
> +			/*
> +			 * Alive session is found, wait for RTRS connection.
> +			 */
> +			mutex_unlock(&sess_lock);
> +			err = wait_for_rtrs_connection(sess);
> +			if (unlikely(err))
> +				rnbd_clt_put_sess(sess);
> +			mutex_lock(&sess_lock);
> +
> +			if (unlikely(err))
> +				/* Session is dying, repeat the loop */
> +				goto again;
> +
> +			return sess;
> +		}
> +		/*
> +		 * Ref is 0, session is dying, wait for RTRS disconnect
> +		 * in order to avoid session names clashes.
> +		 */
> +		wait_for_rtrs_disconnection(sess);
> +		/*
> +		 * RTRS is disconnected and soon session will be freed,
> +		 * so repeat a loop.
> +		 */
> +		goto again;
> +	}
> +
> +	return NULL;
> +}

Since wait_for_rtrs_disconnection() unlocks sess_lock, can the 
list_for_each_entry() above trigger a use-after-free of sess->next?

> +static size_t rnbd_clt_get_sg_size(struct scatterlist *sglist, u32 len)
> +{
> +	struct scatterlist *sg;
> +	size_t tsize = 0;
> +	int i;
> +
> +	for_each_sg(sglist, sg, len, i)
> +		tsize += sg->length;
> +	return tsize;
> +}

Please follow the example of other block drivers and use blk_rq_bytes() 
instead of iterating over the sg-list.

> +static int setup_mq_tags(struct rnbd_clt_session *sess)
> +{
> +	struct blk_mq_tag_set *tags = &sess->tag_set;
> +
> +	memset(tags, 0, sizeof(*tags));
> +	tags->ops		= &rnbd_mq_ops;
> +	tags->queue_depth	= sess->queue_depth;
> +	tags->numa_node		= NUMA_NO_NODE;
> +	tags->flags		= BLK_MQ_F_SHOULD_MERGE |
> +				  BLK_MQ_F_TAG_SHARED;
> +	tags->cmd_size		= sizeof(struct rnbd_iu);
> +	tags->nr_hw_queues	= num_online_cpus();
> +
> +	return blk_mq_alloc_tag_set(tags);
> +}

Please change the name of the "tags" pointer into "tag_set".

> +static int index_to_minor(int index)
> +{
> +	return index << RNBD_PART_BITS;
> +}
> +
> +static int minor_to_index(int minor)
> +{
> +	return minor >> RNBD_PART_BITS;
> +}

Is it useful to introduce functions that encapsulate a single shift 
operation?

> +	blk_queue_virt_boundary(dev->queue, 4095);

The virt_boundary parameter must match the RDMA memory registration page 
size. Please introduce a symbolic constant for the RDMA memory 
registration page size such that these two parameters stay in sync in 
case anyone would want to change the memory registration page size.

> +static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
> +{
> +	dev->gd->major		= rnbd_client_major;
> +	dev->gd->first_minor	= index_to_minor(idx);
> +	dev->gd->fops		= &rnbd_client_ops;
> +	dev->gd->queue		= dev->queue;
> +	dev->gd->private_data	= dev;
> +	snprintf(dev->gd->disk_name, sizeof(dev->gd->disk_name), "rnbd%d",
> +		 idx);
> +	pr_debug("disk_name=%s, capacity=%zu\n",
> +		 dev->gd->disk_name,
> +		 dev->nsectors * (dev->logical_block_size / SECTOR_SIZE)
> +		 );
> +
> +	set_capacity(dev->gd, dev->nsectors * (dev->logical_block_size /
> +					       SECTOR_SIZE));

Again, what is the unit of dev->nsectors?

> +static void rnbd_clt_add_gen_disk(struct rnbd_clt_dev *dev)
> +{
> +	add_disk(dev->gd);
> +}

Is it useful to introduce this wrapper around add_disk()?

Thanks,

Bart.
