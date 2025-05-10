Return-Path: <linux-rdma+bounces-10247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D1AB253D
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4E71B6499E
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5CC1CBEB9;
	Sat, 10 May 2025 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hVK3XUfc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A45475E
	for <linux-rdma@vger.kernel.org>; Sat, 10 May 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746909943; cv=none; b=YJ5EFbMVwHMyaQcq1T4CWEjbpeuV7HJA+W/hKUG0zsgsDAgtsL3HkC+0i3Zy1FF4gEn+/pVHsltkl36IEBcoxpn5Yo0cF0al2uXKv1+0yv3YK6AuTiFwsUfxwkrHjoqVrhyKGjqBXr1LmjN/aOt85P84pnDkfOP75JVLSu2KpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746909943; c=relaxed/simple;
	bh=mNtQBV8goMK4uNtF9rTybAtb8P4+Vx9OfCo72KVqLXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X12CVAoK87BxiGY4SOK8MKQ/UEe1hyi7RPkAAdA6Tx8XkkXtX5J+gjzXxsEj/Hqp2atSGO0/dD+iOs3sG6FNIBERhuljXKl3qiCymMTLb4ZcuTnEgSexk5jdK2qjSZWycqBGQZc5MdCRL9dwbmEVxDH4OcYVz32lTqO3R6Venbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hVK3XUfc; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94db186c-24fe-45d8-bf88-badcc3fe9695@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746909938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJW4PzbE4nc9FmF8nXivqrwezqx/nDf6gnGtdgCu0lY=;
	b=hVK3XUfcntHZ2FcapVz51c+26pFdDZKeYjarzI5Je72A2AQmm5BjYWJQS1q/fA9WrlKTvE
	zs45jrIAFrnWKG0ANdQ1UIKXrrR3oj7U7qdwLWw4SYERo8+spje3yzJ+GpUwzi9z+x5h/z
	NAX0A/cVH1NyoT+fZpZouscFFx8OOUA=
Date: Sat, 10 May 2025 22:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/iwcm: Fix use-after-free of work objects after cm_id
 destruction
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org, Bernard Metzler <BMT@zurich.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Steve Wise <larrystevenwise@gmail.com>, Doug Ledford <dledford@redhat.com>
References: <20250510101036.1756439-1-shinichiro.kawasaki@wdc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250510101036.1756439-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/10 12:10, Shin'ichiro Kawasaki 写道:
> The commit 59c68ac31e15 ("iw_cm: free cm_id resources on the last
> deref") simplified cm_id resource management by freeing cm_id once all
> references to the cm_id were removed. The references are removed either
> upon completion of iw_cm event handlers or when the application destroys
> the cm_id. This commit introduced the use-after-free condition where
> cm_id_private object could still be in use by event handler works during
> the destruction of cm_id. The commit aee2424246f9 ("RDMA/iwcm: Fix a
> use-after-free related to destroying CM IDs") addressed this use-after-
> free by flushing all pending works at the cm_id destruction.
> 
> However, still another use-after-free possibility remained. It happens
> with the work objects allocated for each cm_id_priv within
> alloc_work_entries() during cm_id creation, and subsequently freed in
> dealloc_work_entries() once all references to the cm_id are removed.
> If the cm_id's last reference is decremented in the event handler work,
> the work object for the work itself gets removed, and causes the use-
> after-free BUG below:
> 
>    BUG: KASAN: slab-use-after-free in __pwq_activate_work+0x1ff/0x250
>    Read of size 8 at addr ffff88811f9cf800 by task kworker/u16:1/147091
> 
>    CPU: 2 UID: 0 PID: 147091 Comm: kworker/u16:1 Not tainted 6.15.0-rc2+ #27 PREEMPT(voluntary)
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
>    Workqueue:  0x0 (iw_cm_wq)
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x6a/0x90
>     print_report+0x174/0x554
>     ? __virt_addr_valid+0x208/0x430
>     ? __pwq_activate_work+0x1ff/0x250
>     kasan_report+0xae/0x170
>     ? __pwq_activate_work+0x1ff/0x250
>     __pwq_activate_work+0x1ff/0x250
>     pwq_dec_nr_in_flight+0x8c5/0xfb0
>     process_one_work+0xc11/0x1460
>     ? __pfx_process_one_work+0x10/0x10
>     ? assign_work+0x16c/0x240
>     worker_thread+0x5ef/0xfd0
>     ? __pfx_worker_thread+0x10/0x10
>     kthread+0x3b0/0x770
>     ? __pfx_kthread+0x10/0x10
>     ? rcu_is_watching+0x11/0xb0
>     ? _raw_spin_unlock_irq+0x24/0x50
>     ? rcu_is_watching+0x11/0xb0
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork+0x30/0x70
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
>    Allocated by task 147416:
>     kasan_save_stack+0x2c/0x50
>     kasan_save_track+0x10/0x30
>     __kasan_kmalloc+0xa6/0xb0
>     alloc_work_entries+0xa9/0x260 [iw_cm]
>     iw_cm_connect+0x23/0x4a0 [iw_cm]
>     rdma_connect_locked+0xbfd/0x1920 [rdma_cm]
>     nvme_rdma_cm_handler+0x8e5/0x1b60 [nvme_rdma]
>     cma_cm_event_handler+0xae/0x320 [rdma_cm]
>     cma_work_handler+0x106/0x1b0 [rdma_cm]
>     process_one_work+0x84f/0x1460
>     worker_thread+0x5ef/0xfd0
>     kthread+0x3b0/0x770
>     ret_from_fork+0x30/0x70
>     ret_from_fork_asm+0x1a/0x30
> 
>    Freed by task 147091:
>     kasan_save_stack+0x2c/0x50
>     kasan_save_track+0x10/0x30
>     kasan_save_free_info+0x37/0x60
>     __kasan_slab_free+0x4b/0x70
>     kfree+0x13a/0x4b0
>     dealloc_work_entries+0x125/0x1f0 [iw_cm]
>     iwcm_deref_id+0x6f/0xa0 [iw_cm]
>     cm_work_handler+0x136/0x1ba0 [iw_cm]
>     process_one_work+0x84f/0x1460
>     worker_thread+0x5ef/0xfd0
>     kthread+0x3b0/0x770
>     ret_from_fork+0x30/0x70
>     ret_from_fork_asm+0x1a/0x30
> 
>    Last potentially related work creation:
>     kasan_save_stack+0x2c/0x50
>     kasan_record_aux_stack+0xa3/0xb0
>     __queue_work+0x2ff/0x1390
>     queue_work_on+0x67/0xc0
>     cm_event_handler+0x46a/0x820 [iw_cm]
>     siw_cm_upcall+0x330/0x650 [siw]
>     siw_cm_work_handler+0x6b9/0x2b20 [siw]
>     process_one_work+0x84f/0x1460
>     worker_thread+0x5ef/0xfd0
>     kthread+0x3b0/0x770
>     ret_from_fork+0x30/0x70
>     ret_from_fork_asm+0x1a/0x30
> 
> This BUG is reproducible by repeating the blktests test case nvme/061
> for the rdma transport and the siw driver.
> 
> To avoid the use-after-free of cm_id_private work objects, ensure that
> the last reference to the cm_id is decremented not in the event handler
> works, but in the cm_id destruction context. For that purpose, move
> iwcm_deref_id() call from destroy_cm_id() to the callers of
> destroy_cm_id(). In iw_destroy_cm_id(), call iwcm_deref_id() after
> flushing the pending works.
> 
> During the fix work, I noticed that iw_destroy_cm_id() is called from
> cm_work_handler() and process_event() context. However, the comment of
> iw_destroy_cm_id() notes that the function "cannot be called by the
> event thread". Drop the false comment.
> 
> Closes: https://lore.kernel.org/linux-rdma/r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c/
> Fixes: 59c68ac31e15 ("iw_cm: free cm_id resources on the last deref")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I do not have hosts to reproduce this problem. I just applied this 
commit in upstream kernel and built the kernel successfully.

I read through this commit. I think that this commit looks good to me.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/core/iwcm.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index f4486cbd8f45..62410578dec3 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -368,12 +368,9 @@ EXPORT_SYMBOL(iw_cm_disconnect);
>   /*
>    * CM_ID <-- DESTROYING
>    *
> - * Clean up all resources associated with the connection and release
> - * the initial reference taken by iw_create_cm_id.
> - *
> - * Returns true if and only if the last cm_id_priv reference has been dropped.
> + * Clean up all resources associated with the connection.
>    */
> -static bool destroy_cm_id(struct iw_cm_id *cm_id)
> +static void destroy_cm_id(struct iw_cm_id *cm_id)
>   {
>   	struct iwcm_id_private *cm_id_priv;
>   	struct ib_qp *qp;
> @@ -442,20 +439,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
>   		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
>   		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
>   	}
> -
> -	return iwcm_deref_id(cm_id_priv);
>   }
>   
>   /*
> - * This function is only called by the application thread and cannot
> - * be called by the event thread. The function will wait for all
> - * references to be released on the cm_id and then kfree the cm_id
> - * object.
> + * Destroy cm_id. If the cm_id still has other references, wait for all
> + * references to be released on the cm_id and then release the initial
> + * reference taken by iw_create_cm_id.
>    */
>   void iw_destroy_cm_id(struct iw_cm_id *cm_id)
>   {
> -	if (!destroy_cm_id(cm_id))
> +	struct iwcm_id_private *cm_id_priv;
> +
> +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> +	destroy_cm_id(cm_id);
> +	if (refcount_read(&cm_id_priv->refcount) > 1)
>   		flush_workqueue(iwcm_wq);
> +	iwcm_deref_id(cm_id_priv);
>   }
>   EXPORT_SYMBOL(iw_destroy_cm_id);
>   
> @@ -1035,8 +1034,10 @@ static void cm_work_handler(struct work_struct *_work)
>   
>   		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
>   			ret = process_event(cm_id_priv, &levent);
> -			if (ret)
> -				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
> +			if (ret) {
> +				destroy_cm_id(&cm_id_priv->id);
> +				WARN_ON_ONCE(iwcm_deref_id(cm_id_priv));
> +			}
>   		} else
>   			pr_debug("dropping event %d\n", levent.event);
>   		if (iwcm_deref_id(cm_id_priv))


