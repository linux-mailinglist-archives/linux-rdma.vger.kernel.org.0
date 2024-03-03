Return-Path: <linux-rdma+bounces-1191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910B86F43C
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE1F1F212B8
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24076B64C;
	Sun,  3 Mar 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MggU6GTL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331579E1;
	Sun,  3 Mar 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459894; cv=none; b=ev7l8Deox6+eVJsWNJ6pEz7+Y+fm1omuvwNQtbstzV9DHWjfwudad4+3ZDQPly0jZcP0dxOIgFbMSQmZ4nrM6faLlAF1SNji2ZBxdWoyc4j3fAfzJoRFCt2C3ioEmUT6BVDvwPttcaw+Y5FPvItz7sJod+Br7xp6urqCHmmsQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459894; c=relaxed/simple;
	bh=eTxidrkEvIVqgr8XANRDejBX2L+AkB/ifEZiC9erbHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXfOW4koxH34C3AIx+wsVCyvomjn3Ae7e8O+qZiz5LV8eHFtFIzQDtFVCwEjaqUlJZOZjxHR9XharJfLk8BjRvfMl8+E7lb9kgSLsjiSqlG4RSGr6hKNxgg1UA3U9yLtDqUvl1h2bv+PgcMqCmS/hmmL1lu5pnBJPgF2m/jVdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MggU6GTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39975C433F1;
	Sun,  3 Mar 2024 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709459894;
	bh=eTxidrkEvIVqgr8XANRDejBX2L+AkB/ifEZiC9erbHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MggU6GTLSZJZ+CkZLmFA+bL4PY+79XGdvxjha7IyMQBeaaQW1uYtBN2OSgGOMdL+f
	 HJIJML8RjcnTt6rp1UFExeLoNa8NcEFGr5IvpJ6uoRhL6TOtxLVRYdfkLN7Qj36rUn
	 BiCbNuhW9u1XX8OdyFy3EOG1wmootgxpJCmBWgHOXyR9ZD4ysYQD7ynJ5Gb5TaN+K9
	 9K9VOPzoZ+7yR8OHb8d6Dqq1GWU61bzr2cxYWAUc5XEyA16GmGV2iuEuCMMGmKknjL
	 Zlh7OCOnfypC3tBZpKcyhE/eiWavDQqdlx7YnhQtKjwoU7HVTg3/DfeR8fPvsgaSV8
	 6b/8OnDq2DbtQ==
Date: Sun, 3 Mar 2024 11:58:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
Subject: Re: [PATCH RFC] RDMA/cm: add timeout to cm_destroy_id wait
Message-ID: <20240303095810.GA112581@unreal>
References: <20240227200017.308719-1-manjunath.b.patil@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227200017.308719-1-manjunath.b.patil@oracle.com>

On Tue, Feb 27, 2024 at 12:00:17PM -0800, Manjunath Patil wrote:
> Add timeout to cm_destroy_id, so that userspace can trigger any data
> collection that would help in analyzing the cause of delay in destroying
> the cm_id.

Why doesn't rdmatool resource cm_id dump help to see stalled cm_ids?

Thanks

> 
> New noinline function helps dtrace/ebpf programs to hook on to it.
> Existing functionality isn't changed except triggering a probe-able new
> function at every timeout interval.
> 
> We have seen cases where CM messages stuck with MAD layer (either due to
> software bug or faulty HCA), leading to cm_id getting stuck in the
> following call stack. This patch helps in resolving such issues faster.
> 
> kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
> ...
> 	Call Trace:
> 	__schedule+0x2bc/0x895
> 	schedule+0x36/0x7c
> 	schedule_timeout+0x1f6/0x31f
>  	? __slab_free+0x19c/0x2ba
> 	wait_for_completion+0x12b/0x18a
> 	? wake_up_q+0x80/0x73
> 	cm_destroy_id+0x345/0x610 [ib_cm]
> 	ib_destroy_cm_id+0x10/0x20 [ib_cm]
> 	rdma_destroy_id+0xa8/0x300 [rdma_cm]
> 	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
> 	ucma_write+0xe0/0x160 [rdma_ucm]
> 	__vfs_write+0x3a/0x16d
> 	vfs_write+0xb2/0x1a1
> 	? syscall_trace_enter+0x1ce/0x2b8
> 	SyS_write+0x5c/0xd3
> 	do_syscall_64+0x79/0x1b9
> 	entry_SYSCALL_64_after_hwframe+0x16d/0x0
> 
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
>  drivers/infiniband/core/cm.c | 38 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index ff58058aeadc..03f7b80efa77 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -34,6 +34,20 @@ MODULE_AUTHOR("Sean Hefty");
>  MODULE_DESCRIPTION("InfiniBand CM");
>  MODULE_LICENSE("Dual BSD/GPL");
>  
> +static unsigned long cm_destroy_id_wait_timeout_sec = 10;
> +
> +static struct ctl_table_header *cm_ctl_table_header;
> +static struct ctl_table cm_ctl_table[] = {
> +	{
> +		.procname	= "destroy_id_wait_timeout_sec",
> +		.data		= &cm_destroy_id_wait_timeout_sec,
> +		.maxlen		= sizeof(cm_destroy_id_wait_timeout_sec),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},
> +	{ }
> +};
> +
>  static const char * const ibcm_rej_reason_strs[] = {
>  	[IB_CM_REJ_NO_QP]			= "no QP",
>  	[IB_CM_REJ_NO_EEC]			= "no EEC",
> @@ -1025,10 +1039,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
>  	}
>  }
>  
> +static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
> +{
> +	struct cm_id_private *cm_id_priv;
> +
> +	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
> +	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
> +	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
> +}
> +
>  static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>  {
>  	struct cm_id_private *cm_id_priv;
>  	struct cm_work *work;
> +	int ret;
>  
>  	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
>  	spin_lock_irq(&cm_id_priv->lock);
> @@ -1135,7 +1159,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>  
>  	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
>  	cm_deref_id(cm_id_priv);
> -	wait_for_completion(&cm_id_priv->comp);
> +	do {
> +		ret = wait_for_completion_timeout(&cm_id_priv->comp,
> +						  msecs_to_jiffies(
> +				cm_destroy_id_wait_timeout_sec * 1000));
> +		if (!ret) /* timeout happened */
> +			cm_destroy_id_wait_timeout(cm_id);
> +	} while (!ret);
> +
>  	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
>  		cm_free_work(work);
>  
> @@ -4505,6 +4536,10 @@ static int __init ib_cm_init(void)
>  	ret = ib_register_client(&cm_client);
>  	if (ret)
>  		goto error3;
> +	cm_ctl_table_header = register_net_sysctl(&init_net,
> +						  "net/ib_cm", cm_ctl_table);
> +	if (!cm_ctl_table_header)
> +		pr_warn("ib_cm: couldn't register sysctl path, using default values\n");
>  
>  	return 0;
>  error3:
> @@ -4522,6 +4557,7 @@ static void __exit ib_cm_cleanup(void)
>  		cancel_delayed_work(&timewait_info->work.work);
>  	spin_unlock_irq(&cm.lock);
>  
> +	unregister_net_sysctl_table(cm_ctl_table_header);
>  	ib_unregister_client(&cm_client);
>  	destroy_workqueue(cm.wq);
>  
> -- 
> 2.31.1
> 
> 

