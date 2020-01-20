Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415F6142C83
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgATNsV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 08:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATNsV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 08:48:21 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D47217F4;
        Mon, 20 Jan 2020 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579528099;
        bh=Lk9xioZ7wGQFODQ9BG0Iyfet/Sv+41JQeckzuOuK5fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x54P5FTPshnrLfsUllJ3zYvZ+7xCcjRF4loltFB349MPbxv9Pg7u7teQOcZGXVbOj
         64XY3H6R/ZvkVM+pxOEsWTjmKM1aU/+uhlaqkmkTpLUgXaw38jcCOsSE3mQmGnBKr8
         Mt+uRDXlfWQ4g9nlY+5f4saDJjtGFvmG165qoCrg=
Date:   Mon, 20 Jan 2020 15:48:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
Message-ID: <20200120134815.GH51881@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-18-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116125915.14815-18-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 01:59:07PM +0100, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> This is main functionality of rnbd-client module, which provides
> interface to map remote device as local block device /dev/rnbd<N>
> and feeds RTRS with IO requests.
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 1730 +++++++++++++++++++++++++++++++++
>  1 file changed, 1730 insertions(+)
>  create mode 100644 drivers/block/rnbd/rnbd-clt.c
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> new file mode 100644
> index 000000000000..7d8cb38d3969
> --- /dev/null
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -0,0 +1,1730 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RDMA Network Block Driver
> + *
> + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> + *
> + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> + *
> + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> + */
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/blkdev.h>
> +#include <linux/hdreg.h>
> +#include <linux/scatterlist.h>
> +#include <linux/idr.h>
> +
> +#include "rnbd-clt.h"
> +
> +MODULE_DESCRIPTION("RDMA Network Block Device Client");
> +MODULE_LICENSE("GPL");
> +
> +static int rnbd_client_major;
> +static DEFINE_IDA(index_ida);
> +static DEFINE_MUTEX(ida_lock);
> +static DEFINE_MUTEX(sess_lock);
> +static LIST_HEAD(sess_list);
> +
> +/*
> + * Maximum number of partitions an instance can have.
> + * 6 bits = 64 minors = 63 partitions (one minor is used for the device itself)
> + */
> +#define RNBD_PART_BITS		6
> +
> +static inline bool rnbd_clt_get_sess(struct rnbd_clt_session *sess)
> +{
> +	return refcount_inc_not_zero(&sess->refcount);
> +}
> +
> +static void free_sess(struct rnbd_clt_session *sess);
> +
> +static void rnbd_clt_put_sess(struct rnbd_clt_session *sess)
> +{
> +	might_sleep();
> +
> +	if (refcount_dec_and_test(&sess->refcount))
> +		free_sess(sess);
> +}

I see that this code is for drivers/block and maybe it is a way to do it
there, but in RDMA, we don't like abstraction of general and well-known
kernel APIs. It looks like kref to me.

> +
> +static inline bool rnbd_clt_dev_is_mapped(struct rnbd_clt_dev *dev)
> +{
> +	return dev->dev_state == DEV_STATE_MAPPED;
> +}
> +
> +static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
> +{
> +	might_sleep();
> +
> +	if (refcount_dec_and_test(&dev->refcount)) {
> +		mutex_lock(&ida_lock);
> +		ida_simple_remove(&index_ida, dev->clt_device_id);
> +		mutex_unlock(&ida_lock);
> +		kfree(dev->hw_queues);
> +		rnbd_clt_put_sess(dev->sess);
> +		kfree(dev);
> +	}
> +}
> +
> +static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
> +{
> +	return refcount_inc_not_zero(&dev->refcount);
> +}
> +
> +static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
> +				 const struct rnbd_msg_open_rsp *rsp)
> +{
> +	struct rnbd_clt_session *sess = dev->sess;
> +
> +	if (unlikely(!rsp->logical_block_size))
> +		return -EINVAL;

unlikely() again.

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
> +	dev->max_hw_sectors = sess->max_io_size / SECTOR_SIZE;
> +	dev->max_segments = BMAX_SEGMENTS;
> +
> +	dev->max_hw_sectors = min_t(u32, dev->max_hw_sectors,
> +				    le32_to_cpu(rsp->max_hw_sectors));
> +	dev->max_segments = min_t(u16, dev->max_segments,
> +				  le16_to_cpu(rsp->max_segments));
> +
> +	return 0;
> +}
> +
> +static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
> +				    size_t new_nsectors)
> +{
> +	int err = 0;
> +
> +	rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n",
> +		       dev->nsectors, new_nsectors);
> +	dev->nsectors = new_nsectors;
> +	set_capacity(dev->gd, dev->nsectors);
> +	err = revalidate_disk(dev->gd);
> +	if (err)
> +		rnbd_clt_err(dev,
> +			      "Failed to change device size from %zu to %zu, err: %d\n",
> +			      dev->nsectors, new_nsectors, err);
> +	return err;
> +}
> +
> +static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
> +				struct rnbd_msg_open_rsp *rsp)
> +{
> +	int err = 0;
> +
> +	mutex_lock(&dev->lock);
> +	if (dev->dev_state == DEV_STATE_UNMAPPED) {
> +		rnbd_clt_info(dev,
> +			       "Ignoring Open-Response message from server for  unmapped device\n");
> +		err = -ENOENT;
> +		goto out;
> +	}
> +	if (dev->dev_state == DEV_STATE_MAPPED_DISCONNECTED) {
> +		u64 nsectors = le64_to_cpu(rsp->nsectors);
> +
> +		/*
> +		 * If the device was remapped and the size changed in the
> +		 * meantime we need to revalidate it
> +		 */
> +		if (dev->nsectors != nsectors)
> +			rnbd_clt_change_capacity(dev, nsectors);
> +		rnbd_clt_info(dev, "Device online, device remapped successfully\n");
> +	}
> +	err = rnbd_clt_set_dev_attr(dev, rsp);
> +	if (unlikely(err))
> +		goto out;
> +	dev->dev_state = DEV_STATE_MAPPED;
> +
> +out:
> +	mutex_unlock(&dev->lock);
> +
> +	return err;
> +}
> +
> +int rnbd_clt_resize_disk(struct rnbd_clt_dev *dev, size_t newsize)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&dev->lock);
> +	if (dev->dev_state != DEV_STATE_MAPPED) {
> +		pr_err("Failed to set new size of the device, device is not opened\n");
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +	ret = rnbd_clt_change_capacity(dev, newsize);
> +
> +out:
> +	mutex_unlock(&dev->lock);
> +
> +	return ret;
> +}
> +
> +static inline void rnbd_clt_dev_requeue(struct rnbd_queue *q)
> +{
> +	if (WARN_ON(!q->hctx))
> +		return;
> +
> +	/* We can come here from interrupt, thus async=true */
> +	blk_mq_run_hw_queue(q->hctx, true);
> +}
> +
> +enum {
> +	RNBD_DELAY_10ms   = 10,
> +	RNBD_DELAY_IFBUSY = -1,
> +};
> +
> +/**
> + * rnbd_get_cpu_qlist() - finds a list with HW queues to be rerun
> + * @sess:	Session to find a queue for
> + * @cpu:	Cpu to start the search from
> + *
> + * Description:
> + *     Each CPU has a list of HW queues, which needs to be rerun.  If a list
> + *     is not empty - it is marked with a bit.  This function finds first
> + *     set bit in a bitmap and returns corresponding CPU list.
> + */
> +static struct rnbd_cpu_qlist *
> +rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
> +{
> +	int bit;
> +
> +	/* First half */
> +	bit = find_next_bit(sess->cpu_queues_bm, nr_cpu_ids, cpu);

Is it protected by any lock?

> +	if (bit < nr_cpu_ids) {
> +		return per_cpu_ptr(sess->cpu_queues, bit);
> +	} else if (cpu != 0) {
> +		/* Second half */
> +		bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
> +		if (bit < cpu)
> +			return per_cpu_ptr(sess->cpu_queues, bit);
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline int nxt_cpu(int cpu)
> +{
> +	return (cpu + 1) % nr_cpu_ids;
> +}
> +
> +/**
> + * rnbd_rerun_if_needed() - rerun next queue marked as stopped
> + * @sess:	Session to rerun a queue on
> + *
> + * Description:
> + *     Each CPU has it's own list of HW queues, which should be rerun.
> + *     Function finds such list with HW queues, takes a list lock, picks up
> + *     the first HW queue out of the list and requeues it.
> + *
> + * Return:
> + *     True if the queue was requeued, false otherwise.
> + *
> + * Context:
> + *     Does not matter.
> + */
> +static inline bool rnbd_rerun_if_needed(struct rnbd_clt_session *sess)

No inline function in C files.

> +{
> +	struct rnbd_queue *q = NULL;
> +	struct rnbd_cpu_qlist *cpu_q;
> +	unsigned long flags;
> +	int *cpup;
> +
> +	/*
> +	 * To keep fairness and not to let other queues starve we always
> +	 * try to wake up someone else in round-robin manner.  That of course
> +	 * increases latency but queues always have a chance to be executed.
> +	 */
> +	cpup = get_cpu_ptr(sess->cpu_rr);
> +	for (cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(*cpup)); cpu_q;
> +	     cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(cpu_q->cpu))) {
> +		if (!spin_trylock_irqsave(&cpu_q->requeue_lock, flags))
> +			continue;
> +		if (likely(test_bit(cpu_q->cpu, sess->cpu_queues_bm))) {

Success oriented approach please.

> +			q = list_first_entry_or_null(&cpu_q->requeue_list,
> +						     typeof(*q), requeue_list);
> +			if (WARN_ON(!q))
> +				goto clear_bit;
> +			list_del_init(&q->requeue_list);
> +			clear_bit_unlock(0, &q->in_list);
> +
> +			if (list_empty(&cpu_q->requeue_list)) {
> +				/* Clear bit if nothing is left */
> +clear_bit:
> +				clear_bit(cpu_q->cpu, sess->cpu_queues_bm);
> +			}
> +		}
> +		spin_unlock_irqrestore(&cpu_q->requeue_lock, flags);
> +
> +		if (q)
> +			break;
> +	}
> +
> +	/**
> +	 * Saves the CPU that is going to be requeued on the per-cpu var. Just
> +	 * incrementing it doesn't work because rnbd_get_cpu_qlist() will
> +	 * always return the first CPU with something on the queue list when the
> +	 * value stored on the var is greater than the last CPU with something
> +	 * on the list.
> +	 */
> +	if (cpu_q)
> +		*cpup = cpu_q->cpu;
> +	put_cpu_var(sess->cpu_rr);
> +
> +	if (q)
> +		rnbd_clt_dev_requeue(q);
> +
> +	return !!q;
> +}
> +
> +/**
> + * rnbd_rerun_all_if_idle() - rerun all queues left in the list if
> + *				 session is idling (there are no requests
> + *				 in-flight).
> + * @sess:	Session to rerun the queues on
> + *
> + * Description:
> + *     This function tries to rerun all stopped queues if there are no
> + *     requests in-flight anymore.  This function tries to solve an obvious
> + *     problem, when number of tags < than number of queues (hctx), which
> + *     are stopped and put to sleep.  If last permit, which has been just put,
> + *     does not wake up all left queues (hctxs), IO requests hang forever.
> + *
> + *     That can happen when all number of permits, say N, have been exhausted
> + *     from one CPU, and we have many block devices per session, say M.
> + *     Each block device has it's own queue (hctx) for each CPU, so eventually
> + *     we can put that number of queues (hctxs) to sleep: M x nr_cpu_ids.
> + *     If number of permits N < M x nr_cpu_ids finally we will get an IO hang.
> + *
> + *     To avoid this hang last caller of rnbd_put_permit() (last caller is the
> + *     one who observes sess->busy == 0) must wake up all remaining queues.
> + *
> + * Context:
> + *     Does not matter.
> + */
> +static inline void rnbd_rerun_all_if_idle(struct rnbd_clt_session *sess)
> +{
> +	bool requeued;
> +
> +	do {
> +		requeued = rnbd_rerun_if_needed(sess);
> +	} while (atomic_read(&sess->busy) == 0 && requeued);
> +}
> +
> +static struct rtrs_permit *rnbd_get_permit(struct rnbd_clt_session *sess,
> +					     enum rtrs_clt_con_type con_type,
> +					     int wait)
> +{
> +	struct rtrs_permit *permit;
> +
> +	permit = rtrs_clt_get_permit(sess->rtrs, con_type,
> +				      wait ? RTRS_PERMIT_WAIT :
> +				      RTRS_PERMIT_NOWAIT);
> +	if (likely(permit))
> +		/* We have a subtle rare case here, when all permits can be
> +		 * consumed before busy counter increased.  This is safe,
> +		 * because loser will get NULL as a permit, observe 0 busy
> +		 * counter and immediately restart the queue himself.
> +		 */
> +		atomic_inc(&sess->busy);
> +
> +	return permit;
> +}
> +
> +static void rnbd_put_permit(struct rnbd_clt_session *sess,
> +			     struct rtrs_permit *permit)
> +{
> +	rtrs_clt_put_permit(sess->rtrs, permit);
> +	atomic_dec(&sess->busy);
> +	/* Paired with rnbd_clt_dev_add_to_requeue().  Decrement first
> +	 * and then check queue bits.
> +	 */
> +	smp_mb__after_atomic();
> +	rnbd_rerun_all_if_idle(sess);
> +}
> +
> +static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
> +				     enum rtrs_clt_con_type con_type,
> +				     int wait)
> +{
> +	struct rnbd_iu *iu;
> +	struct rtrs_permit *permit;
> +
> +	permit = rnbd_get_permit(sess, con_type,
> +				  wait ? RTRS_PERMIT_WAIT :
> +				  RTRS_PERMIT_NOWAIT);
> +	if (unlikely(!permit))
> +		return NULL;
> +	iu = rtrs_permit_to_pdu(permit);
> +	iu->permit = permit;
> +	/* yes, rtrs_permit_from_pdu() can be nice here,
> +	 * but also we have to think about MQ mode
> +	 */
> +	/*
> +	 * 1st reference is dropped after finishing sending a "user" message,
> +	 * 2nd reference is dropped after confirmation with the response is
> +	 * returned.
> +	 * 1st and 2nd can happen in any order, so the rnbd_iu should be
> +	 * released (rtrs_permit returned to ibbtrs) only leased after both
> +	 * are finished.
> +	 */
> +	atomic_set(&iu->refcount, 2);
> +	init_waitqueue_head(&iu->comp.wait);
> +	iu->comp.errno = INT_MAX;
> +
> +	return iu;
> +}
> +
> +static void rnbd_put_iu(struct rnbd_clt_session *sess, struct rnbd_iu *iu)
> +{
> +	if (atomic_dec_and_test(&iu->refcount))
> +		rnbd_put_permit(sess, iu->permit);
> +}
> +
> +static void rnbd_softirq_done_fn(struct request *rq)
> +{
> +	struct rnbd_clt_dev *dev	= rq->rq_disk->private_data;
> +	struct rnbd_clt_session *sess	= dev->sess;a

Please no vertical alignment in new code, it adds a lot of churn if such
line is changed later and creates difficulties for the backports.

Thanks
