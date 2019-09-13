Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464F4B28F3
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbfIMXqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Sep 2019 19:46:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36501 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388534AbfIMXqT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Sep 2019 19:46:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so19068577pfr.3;
        Fri, 13 Sep 2019 16:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5XaD+IVGTGhhdOdgntWWMCozKECpMxGfAWok06DT4k=;
        b=rQxzas0NpC4aF5Hw8T3DopeSIKsRM6XesAkebnT6T5Q2a0G3MRdlLbbKDT84l8SVkT
         O/NlJ4sXldgEPd11wOa4H6Ur1CxXoEr6GDhCiBAIfbhrcJoYIXrtv1jRNi2WRbkYS+T0
         XAhpdkbRu9NNod6Ogyu2SPNhHu3/vxCJ2c3pFjGtqyJnejxebPxCWbCOv6E7hoZmSgDe
         xC1Z1ymAiWIsa7SMo5r3ZOPcaiNWz55Xt5fRsC1M2C4y72aScAf/NsmUcfSbepB1OFO8
         jxqRg0BBftyW4dIFiAwZ3yFextgd1nfir1WsTepl6WWlwyeyeoggfh/ky6gAH1oQBJq9
         I/0Q==
X-Gm-Message-State: APjAAAUhIAb2iDmw3W2r/58dJqlwbxPkrjAw8CAi3PWcm4Xw+bW9Qip1
        tutCjnN7AxBxE90H5qwvm5g=
X-Google-Smtp-Source: APXvYqys9gG4PmTDvU8c5hhV74a9a8TodD9mU5se3tZDCC+0kJvy3SQEiNUUVDzWYycveCmlPJAb9w==
X-Received: by 2002:a63:d30f:: with SMTP id b15mr45158820pgg.341.1568418377597;
        Fri, 13 Sep 2019 16:46:17 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u4sm6646444pfu.177.2019.09.13.16.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 16:46:16 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-18-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
Date:   Fri, 13 Sep 2019 16:46:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-18-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +MODULE_VERSION(IBNBD_VER_STRING);

No version numbers in upstream code please.

> +/*
> + * This is for closing devices when unloading the module:
> + * we might be closing a lot (>256) of devices in parallel
> + * and it is better not to use the system_wq.
> + */
> +static struct workqueue_struct *unload_wq;

I think that a better motivation is needed for the introduction of a new 
workqueue.

> +#define KERNEL_SECTOR_SIZE      512

Please use SECTOR_SIZE instead of redefining it.

> +static int ibnbd_clt_revalidate_disk(struct ibnbd_clt_dev *dev,
> +				     size_t new_nsectors)
> +{
> +	int err = 0;
> +
> +	ibnbd_info(dev, "Device size changed from %zu to %zu sectors\n",
> +		   dev->nsectors, new_nsectors);
> +	dev->nsectors = new_nsectors;
> +	set_capacity(dev->gd,
> +		     dev->nsectors * (dev->logical_block_size /
> +				      KERNEL_SECTOR_SIZE));
> +	err = revalidate_disk(dev->gd);
> +	if (err)
> +		ibnbd_err(dev, "Failed to change device size from"
> +			  " %zu to %zu, err: %d\n", dev->nsectors,
> +			  new_nsectors, err);
> +	return err;
> +}

Since this function changes the block device size, I think that the name 
ibnbd_clt_revalidate_disk() is confusing. Please rename this function.

> +/**
> + * ibnbd_get_cpu_qlist() - finds a list with HW queues to be requeued
> + *
> + * Description:
> + *     Each CPU has a list of HW queues, which needs to be requeed.  If a list
> + *     is not empty - it is marked with a bit.  This function finds first
> + *     set bit in a bitmap and returns corresponding CPU list.
> + */

What does it mean to requeue a queue? Queue elements can be requeued but 
a queue in its entirety not. Please make this comment more clear.

> +/**
> + * ibnbd_requeue_if_needed() - requeue if CPU queue is marked as non empty
> + *
> + * Description:
> + *     Each CPU has it's own list of HW queues, which should be requeued.
> + *     Function finds such list with HW queues, takes a list lock, picks up
> + *     the first HW queue out of the list and requeues it.
> + *
> + * Return:
> + *     True if the queue was requeued, false otherwise.
> + *
> + * Context:
> + *     Does not matter.
> + */

Same comment here.

> +/**
> + * ibnbd_requeue_all_if_idle() - requeue all queues left in the list if
> + *     session is idling (there are no requests in-flight).
> + *
> + * Description:
> + *     This function tries to rerun all stopped queues if there are no
> + *     requests in-flight anymore.  This function tries to solve an obvious
> + *     problem, when number of tags < than number of queues (hctx), which
> + *     are stopped and put to sleep.  If last tag, which has been just put,
> + *     does not wake up all left queues (hctxs), IO requests hang forever.
> + *
> + *     That can happen when all number of tags, say N, have been exhausted
> + *     from one CPU, and we have many block devices per session, say M.
> + *     Each block device has it's own queue (hctx) for each CPU, so eventually
> + *     we can put that number of queues (hctxs) to sleep: M x nr_cpu_ids.
> + *     If number of tags N < M x nr_cpu_ids finally we will get an IO hang.
> + *
> + *     To avoid this hang last caller of ibnbd_put_tag() (last caller is the
> + *     one who observes sess->busy == 0) must wake up all remaining queues.
> + *
> + * Context:
> + *     Does not matter.
> + */

Same comment here.

A more general question is why ibnbd needs its own queue management 
while no other block driver needs this?

> +static void ibnbd_softirq_done_fn(struct request *rq)
> +{
> +	struct ibnbd_clt_dev *dev	= rq->rq_disk->private_data;
> +	struct ibnbd_clt_session *sess	= dev->sess;
> +	struct ibnbd_iu *iu;
> +
> +	iu = blk_mq_rq_to_pdu(rq);
> +	ibnbd_put_tag(sess, iu->tag);
> +	blk_mq_end_request(rq, iu->status);
> +}
> +
> +static void msg_io_conf(void *priv, int errno)
> +{
> +	struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;
> +	struct ibnbd_clt_dev *dev = iu->dev;
> +	struct request *rq = iu->rq;
> +
> +	iu->status = errno ? BLK_STS_IOERR : BLK_STS_OK;
> +
> +	if (softirq_enable) {
> +		blk_mq_complete_request(rq);
> +	} else {
> +		ibnbd_put_tag(dev->sess, iu->tag);
> +		blk_mq_end_request(rq, iu->status);
> +	}

Block drivers must call blk_mq_complete_request() instead of 
blk_mq_end_request() to complete a request after processing of the 
request has been started. Calling blk_mq_end_request() to complete a 
request is racy in case a timeout occurs while blk_mq_end_request() is 
in progress.

> +static void msg_conf(void *priv, int errno)
> +{
> +	struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;

The kernel code I'm familiar with does not cast void pointers explicitly 
into another type. Please follow that convention and leave the cast out 
from the above and also from similar statements.

> +static int send_usr_msg(struct ibtrs_clt *ibtrs, int dir,
> +			struct ibnbd_iu *iu, struct kvec *vec, size_t nr,
> +			size_t len, struct scatterlist *sg, unsigned int sg_len,
> +			void (*conf)(struct work_struct *work),
> +			int *errno, bool wait)
> +{
> +	int err;
> +
> +	INIT_WORK(&iu->work, conf);
> +	err = ibtrs_clt_request(dir, msg_conf, ibtrs, iu->tag,
> +				iu, vec, nr, len, sg, sg_len);
> +	if (!err && wait) {
> +		wait_event(iu->comp.wait, iu->comp.errno != INT_MAX);

This looks weird. Why is this a wait_event() call instead of a 
wait_for_completion() call?

> +static struct blk_mq_ops ibnbd_mq_ops;
> +static int setup_mq_tags(struct ibnbd_clt_session *sess)
> +{
> +	struct blk_mq_tag_set *tags = &sess->tag_set;
> +
> +	memset(tags, 0, sizeof(*tags));
> +	tags->ops		= &ibnbd_mq_ops;
> +	tags->queue_depth	= sess->queue_depth;
> +	tags->numa_node		= NUMA_NO_NODE;
> +	tags->flags		= BLK_MQ_F_SHOULD_MERGE |
> +				  BLK_MQ_F_TAG_SHARED;
> +	tags->cmd_size		= sizeof(struct ibnbd_iu);
> +	tags->nr_hw_queues	= num_online_cpus();
> +
> +	return blk_mq_alloc_tag_set(tags);
> +}

Forward declarations should be avoided when possible. Can the forward 
declaration of ibnbd_mq_ops be avoided by moving the definition of 
setup_mq_tags() down?

> +static inline void wake_up_ibtrs_waiters(struct ibnbd_clt_session *sess)
> +{
> +	/* paired with rmb() in wait_for_ibtrs_connection() */
> +	smp_wmb();
> +	sess->ibtrs_ready = true;
> +	wake_up_all(&sess->ibtrs_waitq);
> +}

The placement of the smp_wmb() call looks wrong to me. Since 
wake_up_all() and wait_event() already guarantee acquire/release 
behavior, I think that the explicit barriers can be left out from this 
function and also from wait_for_ibtrs_connection().

> +static void wait_for_ibtrs_disconnection(struct ibnbd_clt_session *sess)
> +__releases(&sess_lock)
> +__acquires(&sess_lock)
> +{
> +	DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
> +
> +	prepare_to_wait(&sess->ibtrs_waitq, &wait, TASK_UNINTERRUPTIBLE);
> +	if (IS_ERR_OR_NULL(sess->ibtrs)) {
> +		finish_wait(&sess->ibtrs_waitq, &wait);
> +		return;
> +	}
> +	mutex_unlock(&sess_lock);
> +	/* After unlock session can be freed, so careful */
> +	schedule();
> +	mutex_lock(&sess_lock);
> +}

This doesn't look right: any random wake_up() call can wake up this 
function. Shouldn't there be a loop in this function that causes the 
schedule() call to be repeated until the disconnect has happened?

> +
> +static struct ibnbd_clt_session *__find_and_get_sess(const char *sessname)
> +__releases(&sess_lock)
> +__acquires(&sess_lock)
> +{
> +	struct ibnbd_clt_session *sess;
> +	int err;
> +
> +again:
> +	list_for_each_entry(sess, &sess_list, list) {
> +		if (strcmp(sessname, sess->sessname))
> +			continue;
> +
> +		if (unlikely(sess->ibtrs_ready && IS_ERR_OR_NULL(sess->ibtrs)))
> +			/*
> +			 * No IBTRS connection, session is dying.
> +			 */
> +			continue;
> +
> +		if (likely(ibnbd_clt_get_sess(sess))) {
> +			/*
> +			 * Alive session is found, wait for IBTRS connection.
> +			 */
> +			mutex_unlock(&sess_lock);
> +			err = wait_for_ibtrs_connection(sess);
> +			if (unlikely(err))
> +				ibnbd_clt_put_sess(sess);
> +			mutex_lock(&sess_lock);
> +
> +			if (unlikely(err))
> +				/* Session is dying, repeat the loop */
> +				goto again;
> +
> +			return sess;
> +		}
> +		/*
> +		 * Ref is 0, session is dying, wait for IBTRS disconnect
> +		 * in order to avoid session names clashes.
> +		 */
> +		wait_for_ibtrs_disconnection(sess);
> +		/*
> +		 * IBTRS is disconnected and soon session will be freed,
> +		 * so repeat a loop.
> +		 */
> +		goto again;
> +	}
> +
> +	return NULL;
> +}
 >
> +
> +static struct ibnbd_clt_session *find_and_get_sess(const char *sessname)
> +{
> +	struct ibnbd_clt_session *sess;
> +
> +	mutex_lock(&sess_lock);
> +	sess = __find_and_get_sess(sessname);
> +	mutex_unlock(&sess_lock);
> +
> +	return sess;
> +}

Shouldn't __find_and_get_sess() function increase the reference count of 
sess before it returns? In other words, what prevents that the session 
is freed from another thread before find_and_get_sess() returns?

> +/*
> + * Get iorio of current task
> + */
> +static short ibnbd_current_ioprio(void)
> +{
> +	struct task_struct *tsp = current;
> +	unsigned short prio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
> +
> +	if (likely(tsp->io_context))
> +		prio = tsp->io_context->ioprio;
> +	return prio;
> +}

ibnbd should use req_get_ioprio() and should not look at 
current->io_context->ioprio. I think it is the responsibility of the 
block layer to extract the I/O priority from the task context. As an 
example, here is how the aio code does this:

		req->ki_ioprio = get_current_ioprio();

> +static blk_status_t ibnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
> +				   const struct blk_mq_queue_data *bd)
> +{
> +	struct request *rq = bd->rq;
> +	struct ibnbd_clt_dev *dev = rq->rq_disk->private_data;
> +	struct ibnbd_iu *iu = blk_mq_rq_to_pdu(rq);
> +	int err;
> +
> +	if (unlikely(!ibnbd_clt_dev_is_mapped(dev)))
> +		return BLK_STS_IOERR;
> +
> +	iu->tag = ibnbd_get_tag(dev->sess, IBTRS_IO_CON, IBTRS_TAG_NOWAIT);
> +	if (unlikely(!iu->tag)) {
> +		ibnbd_clt_dev_kick_mq_queue(dev, hctx, IBNBD_DELAY_IFBUSY);
> +		return BLK_STS_RESOURCE;
> +	}
> +
> +	blk_mq_start_request(rq);
> +	err = ibnbd_client_xfer_request(dev, rq, iu);
> +	if (likely(err == 0))
> +		return BLK_STS_OK;
> +	if (unlikely(err == -EAGAIN || err == -ENOMEM)) {
> +		ibnbd_clt_dev_kick_mq_queue(dev, hctx, IBNBD_DELAY_10ms);
> +		ibnbd_put_tag(dev->sess, iu->tag);
> +		return BLK_STS_RESOURCE;
> +	}
> +
> +	ibnbd_put_tag(dev->sess, iu->tag);
> +	return BLK_STS_IOERR;
> +}

Every other block driver relies on the block layer core for tag 
allocation. Why does ibnbd need its own tag management?

> +static void setup_request_queue(struct ibnbd_clt_dev *dev)
> +{
> +	blk_queue_logical_block_size(dev->queue, dev->logical_block_size);
> +	blk_queue_physical_block_size(dev->queue, dev->physical_block_size);
> +	blk_queue_max_hw_sectors(dev->queue, dev->max_hw_sectors);
> +	blk_queue_max_write_same_sectors(dev->queue,
> +					 dev->max_write_same_sectors);
> +
> +	/*
> +	 * we don't support discards to "discontiguous" segments
> +	 * in on request
               ^^
               one?
> +	 */
> +	blk_queue_max_discard_segments(dev->queue, 1);
> +
> +	blk_queue_max_discard_sectors(dev->queue, dev->max_discard_sectors);
> +	dev->queue->limits.discard_granularity	= dev->discard_granularity;
> +	dev->queue->limits.discard_alignment	= dev->discard_alignment;
> +	if (dev->max_discard_sectors)
> +		blk_queue_flag_set(QUEUE_FLAG_DISCARD, dev->queue);
> +	if (dev->secure_discard)
> +		blk_queue_flag_set(QUEUE_FLAG_SECERASE, dev->queue);
> +
> +	blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
> +	blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
> +	blk_queue_max_segments(dev->queue, dev->max_segments);
> +	blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
> +	blk_queue_virt_boundary(dev->queue, 4095);
> +	blk_queue_write_cache(dev->queue, true, true);
> +	dev->queue->queuedata = dev;
> +}

> +static void destroy_gen_disk(struct ibnbd_clt_dev *dev)
> +{
> +	del_gendisk(dev->gd);

> +	/*
> +	 * Before marking queue as dying (blk_cleanup_queue() does that)
> +	 * we have to be sure that everything in-flight has gone.
> +	 * Blink with freeze/unfreeze.
> +	 */
> +	blk_mq_freeze_queue(dev->queue);
> +	blk_mq_unfreeze_queue(dev->queue);

Please remove the above seven lines. blk_cleanup_queue() calls 
blk_set_queue_dying() and the second call in blk_set_queue_dying() is 
blk_freeze_queue_start().

> +	blk_cleanup_queue(dev->queue);
> +	put_disk(dev->gd);
> +}

> +
> +static void destroy_sysfs(struct ibnbd_clt_dev *dev,
> +			  const struct attribute *sysfs_self)
> +{
> +	ibnbd_clt_remove_dev_symlink(dev);
> +	if (dev->kobj.state_initialized) {
> +		if (sysfs_self)
> +			/* To avoid deadlock firstly commit suicide */
                                                             ^^^^^^^
Please chose terminology that is more appropriate for a professional 
context.

> +			sysfs_remove_file_self(&dev->kobj, sysfs_self);
> +		kobject_del(&dev->kobj);
> +		kobject_put(&dev->kobj);
> +	}
> +}

Bart.
