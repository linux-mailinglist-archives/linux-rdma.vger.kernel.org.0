Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E783C625023
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 03:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiKKC23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 21:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiKKC21 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 21:28:27 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F42CD
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 18:28:23 -0800 (PST)
Message-ID: <88c2203f-9192-9b28-e7d0-484a1ec932ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668133701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8tE9Q34CdabyY0Ja/nEmLcV8IPOqRevFwaLw+IlNCE=;
        b=dvIKmV/uNZM+xweovwGpov3PGurXU/dOQI1vUArSBI2F3H86gJ429F/WHcddyOIU65yUTj
        1bsJfTizUDnUpeWUrH3A3pLkYKpXp09U5YBv01vvQC7FM9A02w9bE0JObiieJO4MnAkyRn
        z41wMH08JVcoUhjirKJmrHxhvBtUI50=
Date:   Fri, 11 Nov 2022 10:28:17 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3 01/13] RDMA/rxe: Make task interface pluggable
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Ian Ziemba <ian.ziemba@hpe.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
 <20221029031009.64467-2-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20221029031009.64467-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/10/29 11:09, Bob Pearson 写道:
> Make the internal interface to the task operations pluggable and
> add a new 'inline' type.
> 
> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_qp.c   |   8 +-
>   drivers/infiniband/sw/rxe/rxe_task.c | 160 ++++++++++++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_task.h |  44 +++++---
>   3 files changed, 165 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 3f6d62a80bea..b5e108794aa1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -238,8 +238,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>   
>   	skb_queue_head_init(&qp->req_pkts);
>   
> -	rxe_init_task(&qp->req.task, qp, rxe_requester);
> -	rxe_init_task(&qp->comp.task, qp, rxe_completer);
> +	rxe_init_task(&qp->req.task, qp, rxe_requester, RXE_TASK_TYPE_TASKLET);
> +	rxe_init_task(&qp->comp.task, qp, rxe_completer,
> +			(qp_type(qp) == IB_QPT_RC) ? RXE_TASK_TYPE_TASKLET :
> +						     RXE_TASK_TYPE_INLINE);
>   
>   	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
>   	if (init->qp_type == IB_QPT_RC) {
> @@ -286,7 +288,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>   
>   	skb_queue_head_init(&qp->resp_pkts);
>   
> -	rxe_init_task(&qp->resp.task, qp, rxe_responder);
> +	rxe_init_task(&qp->resp.task, qp, rxe_responder, RXE_TASK_TYPE_TASKLET);
>   
>   	qp->resp.opcode		= OPCODE_NONE;
>   	qp->resp.msn		= 0;
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 0208d833a41b..8dfbfa164eff 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -24,12 +24,11 @@ int __rxe_do_task(struct rxe_task *task)
>    * a second caller finds the task already running
>    * but looks just after the last call to func
>    */
> -static void do_task(struct tasklet_struct *t)
> +static void do_task(struct rxe_task *task)
>   {
> +	unsigned int iterations = RXE_MAX_ITERATIONS;
>   	int cont;
>   	int ret;
> -	struct rxe_task *task = from_tasklet(task, t, tasklet);
> -	unsigned int iterations = RXE_MAX_ITERATIONS;
>   
>   	spin_lock_bh(&task->lock);
>   	switch (task->state) {
> @@ -90,28 +89,21 @@ static void do_task(struct tasklet_struct *t)
>   	task->ret = ret;
>   }
>   
> -int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
> +static void disable_task(struct rxe_task *task)
>   {
> -	task->arg	= arg;
> -	task->func	= func;
> -	task->destroyed	= false;
> -
> -	tasklet_setup(&task->tasklet, do_task);
> -
> -	task->state = TASK_STATE_START;
> -	spin_lock_init(&task->lock);
> +	/* todo */
> +}
>   
> -	return 0;
> +static void enable_task(struct rxe_task *task)
> +{
> +	/* todo */
>   }
>   
> -void rxe_cleanup_task(struct rxe_task *task)
> +/* busy wait until any previous tasks are done */
> +static void cleanup_task(struct rxe_task *task)
>   {
>   	bool idle;
>   
> -	/*
> -	 * Mark the task, then wait for it to finish. It might be
> -	 * running in a non-tasklet (direct call) context.
> -	 */
>   	task->destroyed = true;
>   
>   	do {
> @@ -119,32 +111,144 @@ void rxe_cleanup_task(struct rxe_task *task)
>   		idle = (task->state == TASK_STATE_START);
>   		spin_unlock_bh(&task->lock);
>   	} while (!idle);
> +}
>   
> -	tasklet_kill(&task->tasklet);
> +/* silently treat schedule as inline for inline tasks */
> +static void inline_sched(struct rxe_task *task)
> +{
> +	do_task(task);
>   }
>   
> -void rxe_run_task(struct rxe_task *task)
> +static void inline_run(struct rxe_task *task)
>   {
> -	if (task->destroyed)
> -		return;
> +	do_task(task);
> +}
>   
> -	do_task(&task->tasklet);
> +static void inline_disable(struct rxe_task *task)
> +{
> +	disable_task(task);
>   }
>   
> -void rxe_sched_task(struct rxe_task *task)
> +static void inline_enable(struct rxe_task *task)
>   {
> -	if (task->destroyed)
> -		return;
> +	enable_task(task);
> +}
> +
> +static void inline_cleanup(struct rxe_task *task)
> +{
> +	cleanup_task(task);
> +}
> +
> +static const struct rxe_task_ops inline_ops = {
> +	.sched = inline_sched,
> +	.run = inline_run,
> +	.enable = inline_enable,
> +	.disable = inline_disable,
> +	.cleanup = inline_cleanup,
> +};
>   
> +static void inline_init(struct rxe_task *task)
> +{
> +	task->ops = &inline_ops;
> +}
> +
> +/* use tsklet_xxx to avoid name collisions with tasklet_xxx */
> +static void tsklet_sched(struct rxe_task *task)
> +{
>   	tasklet_schedule(&task->tasklet);
>   }
>   
> -void rxe_disable_task(struct rxe_task *task)
> +static void tsklet_do_task(struct tasklet_struct *tasklet)
>   {
> +	struct rxe_task *task = container_of(tasklet, typeof(*task), tasklet);
> +
> +	do_task(task);
> +}
> +
> +static void tsklet_run(struct rxe_task *task)
> +{
> +	do_task(task);
> +}
> +
> +static void tsklet_disable(struct rxe_task *task)
> +{
> +	disable_task(task);
>   	tasklet_disable(&task->tasklet);
>   }
>   
> -void rxe_enable_task(struct rxe_task *task)
> +static void tsklet_enable(struct rxe_task *task)
>   {
>   	tasklet_enable(&task->tasklet);
> +	enable_task(task);
> +}
> +
> +static void tsklet_cleanup(struct rxe_task *task)
> +{
> +	cleanup_task(task);
> +	tasklet_kill(&task->tasklet);
> +}
> +
> +static const struct rxe_task_ops tsklet_ops = {
> +	.sched = tsklet_sched,
> +	.run = tsklet_run,
> +	.enable = tsklet_enable,
> +	.disable = tsklet_disable,
> +	.cleanup = tsklet_cleanup,
> +};
> +
> +static void tsklet_init(struct rxe_task *task)
> +{
> +	tasklet_setup(&task->tasklet, tsklet_do_task);
> +	task->ops = &tsklet_ops;
> +}
> +
> +int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
> +		  enum rxe_task_type type)
> +{
> +	task->arg	= arg;
> +	task->func	= func;
> +	task->destroyed	= false;
> +	task->type	= type;
> +	task->state	= TASK_STATE_START;
> +
> +	spin_lock_init(&task->lock);

About this spin_lock_init, I rembered this commit 
news://nntp.lore.kernel.org:119/20220710043709.707649-1-yanjun.zhu@linux.dev

Can this spin_lock_init be moved to the function rxe_qp_init_misc?
So this can avoid the error "initialize spin locks before use".

Zhu Yanjun

> +
> +	switch (type) {
> +	case RXE_TASK_TYPE_INLINE:
> +		inline_init(task);
> +		break;
> +	case RXE_TASK_TYPE_TASKLET:
> +		tsklet_init(task);
> +		break;
> +	default:
> +		pr_debug("%s: invalid task type = %d\n", __func__, type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void rxe_sched_task(struct rxe_task *task)
> +{
> +	task->ops->sched(task);
> +}
> +
> +void rxe_run_task(struct rxe_task *task)
> +{
> +	task->ops->run(task);
> +}
> +
> +void rxe_enable_task(struct rxe_task *task)
> +{
> +	task->ops->enable(task);
> +}
> +
> +void rxe_disable_task(struct rxe_task *task)
> +{
> +	task->ops->disable(task);
> +}
> +
> +void rxe_cleanup_task(struct rxe_task *task)
> +{
> +	task->ops->cleanup(task);
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
> index 7b88129702ac..31963129ff7a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.h
> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> @@ -7,6 +7,21 @@
>   #ifndef RXE_TASK_H
>   #define RXE_TASK_H
>   
> +struct rxe_task;
> +
> +struct rxe_task_ops {
> +	void (*sched)(struct rxe_task *task);
> +	void (*run)(struct rxe_task *task);
> +	void (*disable)(struct rxe_task *task);
> +	void (*enable)(struct rxe_task *task);
> +	void (*cleanup)(struct rxe_task *task);
> +};
> +
> +enum rxe_task_type {
> +	RXE_TASK_TYPE_INLINE	= 0,
> +	RXE_TASK_TYPE_TASKLET	= 1,
> +};
> +
>   enum {
>   	TASK_STATE_START	= 0,
>   	TASK_STATE_BUSY		= 1,
> @@ -19,24 +34,19 @@ enum {
>    * called again.
>    */
>   struct rxe_task {
> -	struct tasklet_struct	tasklet;
> -	int			state;
> -	spinlock_t		lock;
> -	void			*arg;
> -	int			(*func)(void *arg);
> -	int			ret;
> -	bool			destroyed;
> +	struct tasklet_struct		tasklet;
> +	int				state;
> +	spinlock_t			lock;
> +	void				*arg;
> +	int				(*func)(void *arg);
> +	int				ret;
> +	bool				destroyed;
> +	const struct rxe_task_ops	*ops;
> +	enum rxe_task_type		type;
>   };
>   
> -/*
> - * init rxe_task structure
> - *	arg  => parameter to pass to fcn
> - *	func => function to call until it returns != 0
> - */
> -int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
> -
> -/* cleanup task */
> -void rxe_cleanup_task(struct rxe_task *task);
> +int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
> +		  enum rxe_task_type type);
>   
>   /*
>    * raw call to func in loop without any checking
> @@ -54,4 +64,6 @@ void rxe_disable_task(struct rxe_task *task);
>   /* allow task to run */
>   void rxe_enable_task(struct rxe_task *task);
>   
> +void rxe_cleanup_task(struct rxe_task *task);
> +
>   #endif /* RXE_TASK_H */

