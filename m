Return-Path: <linux-rdma+bounces-5606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB139B5BB4
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 07:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD71C20E5B
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 06:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515E1D0F5C;
	Wed, 30 Oct 2024 06:28:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10619BA6
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269683; cv=none; b=inqYTg+GKNK+Haglo0Crkboigb+w5iZOEJ6c0zc82rBXd/CqVaqjdm0zyYmTpWthjFIeQMxumT9dy/Sfavp5ui0oQisdT5UgiP3V5JXzL5NN4U5WNgtn5lCOef3+c1yi0zvDSIY76x4sRApud+89ip9BIaPkN5xeWKO7oAIbnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269683; c=relaxed/simple;
	bh=Ltd8f8IMVYI3OZ31xE34WWtcyO+NEMfItcdt2JNzv68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEADQISYQ/1USjVUaoytWI6l3ccIv4kyLs1MGs5H1gCKAY6arQ7FC9u4oLj5H6OAIu7llLsw1hcoaxLbdVP3+ItGcUo6Vf0bJvc+HEOW62VjAlqor9TgYrohlPPgvphgCnipirp3rh1XNylDLmZfa1DzNbIqc6JPW4Vmb/r4f0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost ([10.193.191.23])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 49U6RlCL027091;
	Tue, 29 Oct 2024 23:27:48 -0700
Date: Wed, 30 Oct 2024 11:57:47 +0530
From: Showrya M N <showrya@chelsio.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: Iser target machine hits kernel panic while running iozone
 traffic with link toggle on initiator
Message-ID: <ZyHR435i370qrIuI@chelsio.com>
References: <20241028062246.10997-1-showrya@chelsio.com>
 <2108afcb-1bfa-48b4-b1bc-42dac83b6229@acm.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2108afcb-1bfa-48b4-b1bc-42dac83b6229@acm.org>

On Monday, October 10/28/24, 2024 at 23:02:17 +0530, Bart Van Assche wrote:
> On 10/27/24 11:22 PM, Showrya M N wrote:
> > case 1: Reverted commit e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()") and kept a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()")
> > 
> >          Before 'commit a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()"), cm_work_handler() takes single lock to delete the work and checks for
> >          list_empty. After the commit, cm_work_handler() now takes separate locks for each operation.
> >          However, there is a scenario where cm_work_handler() processed all the work in the worklist and is waiting to acquire the lock to check if the
> >          worklist is empty. Meanwhile, cm_event_handler() may take the lock, check the same condition, add new work to the same worklist,
> >          and queue this work, assuming the worklist is free. Since cm_work_handler() is still processing the same worklist, it will continue
> >          to process the newly added work as well, since cm_event_handler() queues the same work, this can lead to reprocessing of the same work, resulting in below error.
> 
> I do not agree that commit e1168f09b331 can lead to processing a single
> work item twice.
Hi Bart,
tested the below patch, the same issue persists.

Here are some debug logs, where we can see pwq_activate_work() triggering for the same work item that is in cm_work_handler().

At [2608.281945], we observe that the number of works is ONE. At [2608.281947], the log indicates the list is empty.
Meanwhile, cm_event_handler() intervenes, adding work to the same worklist. At the end, __pwq_activate_work is also
activating the same worklist, triggering WARN_ON_ONCE(!(*wdb & WORK_STRUCT_INACTIVE)); in __pwq_activate_work().


[ 2608.281933] cm_event_handler: &work->work 000000004183c37b if
[ 2608.281939] process_one_work: work 000000004183c37b pwq 000000006c3c00e4
[ 2608.281945] cm_work_handler: begin _work 000000004183c37b no. of works 1
[ 2608.281947] cm_work_handler: empty 1 _work 000000004183c37b
[ 2608.282517] cm_event_handler: &work->work 000000004183c37b if
[ 2608.283159] cm_work_handler: count 1 before lock _work 000000004183c37b
[ 2608.283161] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.283451] cm_event_handler: &work->work 000000004183c37b else
[ 2608.284200] cm_work_handler: count 2 before lock _work 000000004183c37b
[ 2608.284204] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.285225] cm_work_handler: count 3 before lock _work 000000004183c37b
[ 2608.285229] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.285486] cm_event_handler: &work->work 000000004183c37b else
[ 2608.286210] cm_work_handler: count 4 before lock _work 000000004183c37b
[ 2608.286213] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.287149] cm_work_handler: count 5 before lock _work 000000004183c37b
[ 2608.287151] cm_work_handler: empty 1 _work 000000004183c37b
[ 2608.288161] cm_work_handler: count 6 before lock _work 000000004183c37b
[ 2608.288164] __pwq_activate_work: work 000000004183c37b
[ 2608.288170] ------------[ cut here ]------------
[ 2608.288172] WARNING: CPU: 1 PID: 69 at kernel/workqueue.c:1681 __pwq_activate_work+0xa6/0xb0

Thanks,
Showrya M N

> 
> > case 2: Reverted commit a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()") and kept e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()")
> > 
> >          After 'commit e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()")', cm_event_handler() calls queue_work() whenever work is added to the worklist.
> >          if the work is added while cm_work_handler() is processing the same worklist, cm_work_handler() may process the newly added work as well.
> >          Since cm_event_handler() unconditionally calls queue_work(), the same work can be reprocessed, leading to below error.
> 
> The above doesn't sound correct to me either. cm_event_handler() calls
> list_add_tail() and queue_work() while holding cm_id_priv->lock.
> cm_work_handler() obtains cm_id_priv->lock before it checks the list
> with pending work items. Hence, the order in which cm_event_handler()
> calls list_add_tail() and queue_work() doesn't matter.
> 
> > I am in favor of reverting above commits and restoring the previous
> > code, since these commits are about code rearrange. Please let me
> > know your views on it.
> If anyone can point out anything that's wrong with these commits I'm
> totally fine with reverting these commits. However, I haven't seen any
> evidence so far that there is anything wrong with either commit.
> 
> > Here are the logs from crash file:
> > 
> > [21088.907704] ------------[ cut here ]------------
> > [21088.907710] WARNING: CPU: 8 PID: 134019 at kernel/workqueue.c:1680 __pwq_activate_work+0x90/0xa0
> > [21088.907814] Call Trace:
> > [21088.907816]  <TASK>
> > [21088.907818]  ? __warn+0x7f/0x120
> > [21088.907823]  ? __pwq_activate_work+0x90/0xa0
> > [21088.907826]  ? report_bug+0x18a/0x1a0
> > [21088.907831]  ? handle_bug+0x3c/0x70
> > [21088.907834]  ? exc_invalid_op+0x14/0x70
> > [21088.907837]  ? asm_exc_invalid_op+0x16/0x20
> > [21088.907844]  ? __pwq_activate_work+0x90/0xa0
> > [21088.907848]  pwq_dec_nr_in_flight+0x28f/0x330
> > [21088.907852]  worker_thread+0x23d/0x350
> > [21088.907855]  ? __pfx_worker_thread+0x10/0x10
> > [21088.907857]  kthread+0xcf/0x100
> > [21088.907861]  ? __pfx_kthread+0x10/0x10
> > [21088.907864]  ret_from_fork+0x30/0x50
> > [21088.907869]  ? __pfx_kthread+0x10/0x10
> > [21088.907871]  ret_from_fork_asm+0x1a/0x30
> > [21088.907878]  </TASK>
> 
> > [21088.907888] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > [21088.907960] Call Trace:
> > [21088.907962]  <TASK>
> > [21088.907964]  ? __die+0x20/0x70
> > [21088.907970]  ? page_fault_oops+0x75/0x170
> > [21088.907977]  ? exc_page_fault+0x64/0x140
> > [21088.907983]  ? asm_exc_page_fault+0x22/0x30
> > [21088.907991]  ? process_one_work+0xbf/0x390
> > [21088.907994]  worker_thread+0x23d/0x350
> > [21088.907998]  ? __pfx_worker_thread+0x10/0x10
> > [21088.908001]  kthread+0xcf/0x100
> > [21088.908006]  ? __pfx_kthread+0x10/0x10
> > [21088.908010]  ret_from_fork+0x30/0x50
> > [21088.908015]  ? __pfx_kthread+0x10/0x10
> > [21088.908018]  ret_from_fork_asm+0x1a/0x30
> > [21088.908025]  </TASK>
> 
> The above may indicate a use-after-free of struct iwcm_work. Does the
> untested patch below help?
> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index 7e3a55349e10..700e60bac909 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -141,6 +141,8 @@ static struct iwcm_work *get_work(struct 
> iwcm_id_private *cm_id_priv)
>   {
>   	struct iwcm_work *work;
> 
> +	lockdep_assert_held(&cm_id_priv->lock);
> +
>   	if (list_empty(&cm_id_priv->work_free_list))
>   		return NULL;
>   	work = list_first_entry(&cm_id_priv->work_free_list, struct iwcm_work,
> @@ -151,6 +153,8 @@ static struct iwcm_work *get_work(struct 
> iwcm_id_private *cm_id_priv)
> 
>   static void put_work(struct iwcm_work *work)
>   {
> +	lockdep_assert_held(&work->cm_id->lock);
> +
>   	list_add(&work->free_list, &work->cm_id->work_free_list);
>   }
> 
> @@ -158,6 +162,8 @@ static void dealloc_work_entries(struct 
> iwcm_id_private *cm_id_priv)
>   {
>   	struct list_head *e, *tmp;
> 
> +	lockdep_assert_held(&cm_id_priv->lock);
> +
>   	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list) {
>   		list_del(e);
>   		kfree(list_entry(e, struct iwcm_work, free_list));
> @@ -172,11 +178,14 @@ static int alloc_work_entries(struct 
> iwcm_id_private *cm_id_priv, int count)
>   	while (count--) {
>   		work = kmalloc(sizeof(struct iwcm_work), GFP_KERNEL);
>   		if (!work) {
> +			guard(spinlock_irqsave)(&cm_id_priv->lock);
>   			dealloc_work_entries(cm_id_priv);
>   			return -ENOMEM;
>   		}
>   		work->cm_id = cm_id_priv;
>   		INIT_LIST_HEAD(&work->list);
> +
> +		guard(spinlock_irqsave)(&cm_id_priv->lock);
>   		put_work(work);
>   	}
>   	return 0;
> @@ -200,7 +209,9 @@ static int copy_private_data(struct iw_cm_event *event)
> 
>   static void free_cm_id(struct iwcm_id_private *cm_id_priv)
>   {
> -	dealloc_work_entries(cm_id_priv);
> +	scoped_guard(spinlock_irqsave, &cm_id_priv->lock) {
> +		dealloc_work_entries(cm_id_priv);
> +	}
>   	kfree(cm_id_priv);
>   }
> 
> 


