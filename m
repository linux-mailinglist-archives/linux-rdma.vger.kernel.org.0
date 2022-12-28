Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934126584C8
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Dec 2022 18:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiL1RC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Dec 2022 12:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiL1RBy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Dec 2022 12:01:54 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC661D670;
        Wed, 28 Dec 2022 08:56:14 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so10142057otk.8;
        Wed, 28 Dec 2022 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+R92PbFmlBj4t4DrSjeaiJBB9gZ3lqqk4fhnsbu8/fA=;
        b=fZfTUj0POFwDJutPxOK5BxGZwgVcTvxtscgPK6rBRVjuNbKne/wG/VxJbhIrGYm+t7
         u2f8PO2ZtrO59UE5idBjN3iD0gRPfcUangYBvPocwTyeDolpz6bRiv/0iuQ0Dgt5aKOn
         /YMlzbZuC4sJO3sqeZFt0rD8GHsUSHXf6t4dID0ibdEAZBQwIpOOSIWMJGVJM0S2mYWO
         kPbn05Wd1PJY0oBAr3ZJ2/o7wLXsc8f3PyvwAbA5vSsjP9EQ3w9UM64/CJSKhPhNPlBq
         N5R4lcfMti6y2dKTYo1xCVOS5fgl3POEAV6ZmiefBZUInyK+joVM15KquTK8v7tFrH81
         Z/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R92PbFmlBj4t4DrSjeaiJBB9gZ3lqqk4fhnsbu8/fA=;
        b=C7FSiKw5iRu9G/Kg8G1lkjODqvpZoskkgulsXCv1w6lyeHUEQZ5RZCL9NJeBWubRQj
         6DnTAFEMzvNLK9d+D0SszwB6mq9Jgz/Mk/6GV9tXO7HDRASKLcaZKvdP1Dc/a+18nY8w
         9BzBN0rlA8ZlurU1xNJBFNnPrc47y+ClweW0LSlNr6Xfcc5sjhK8VbCFX6CsldE+5QDp
         1OuX1nQ1f5fzd+tIskUZIQskcef4/evSWuG+ti3TorvIli+u7rBMMrdjQZSeqijo44dG
         6qaqvJwvQgvsYduR5hJiFHDq4IRw5wSpS3Zwv1LriY473kVk8kgy/y5QYeHBxxSHqAwJ
         8dWA==
X-Gm-Message-State: AFqh2kqtJiKarng9nhxPvtRwT5pNeCVDZ27/JbaCNCKCtgRpm425kzh6
        533NhVQ8XH7G0tvtAJpYE4KCkh6o59TUBQ==
X-Google-Smtp-Source: AMrXdXsXo0wUNII3yTW1Xb5EMt1CAJtuHtzATYS6sxFvpj3UVawsHJ7RrcbWbumVv93g6gwfihm4Lg==
X-Received: by 2002:a05:6830:3108:b0:677:dfa:54ff with SMTP id b8-20020a056830310800b006770dfa54ffmr16393717ots.22.1672246573510;
        Wed, 28 Dec 2022 08:56:13 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:3347:31ff:4084:1cc5? (2603-8081-140c-1a00-3347-31ff-4084-1cc5.res6.spectrum.com. [2603:8081:140c:1a00:3347:31ff:4084:1cc5])
        by smtp.gmail.com with ESMTPSA id a16-20020a0568300b9000b00670763270fcsm8002465otv.71.2022.12.28.08.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 08:56:13 -0800 (PST)
Message-ID: <53a2fca7-d98a-acef-8b18-d36a5a16d176@gmail.com>
Date:   Wed, 28 Dec 2022 10:56:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v3 1/7] RDMA/rxe: Convert triple tasklets to use
 workqueue
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
 <d2f6b3aca61fe1858a97cda94691eece6b0e60bd.1671772917.git.matsuda-daisuke@fujitsu.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <d2f6b3aca61fe1858a97cda94691eece6b0e60bd.1671772917.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/23/22 00:51, Daisuke Matsuda wrote:
> In order to implement On-Demand Paging on the rxe driver, triple tasklets
> (requester, responder, and completer) must be allowed to sleep so that they
> can trigger page fault when pages being accessed are not present.
> 
> This patch replaces the tasklets with a workqueue, but still allows direct-
> call of works from softirq context if it is obvious that MRs are not going
> to be accessed and there is no work being processed in the workqueue.

There are already at least two patch sets that do this waiting to get upstream.
Bob

> 
> As counterparts to tasklet_disable() and tasklet_enable() are missing for
> workqueues, an atomic value is introduced to prevent work items from being
> scheduled while qp reset is in progress.
> 
> The way to initialize/destroy workqueue is picked up from the
> implementation of Ian Ziemba and Bob Pearson at HPE.
> 
> Link: https://lore.kernel.org/all/20221018043345.4033-1-rpearsonhpe@gmail.com/
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       |  9 ++++-
>  drivers/infiniband/sw/rxe/rxe_comp.c  |  2 +-
>  drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  2 +-
>  drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  2 +-
>  drivers/infiniband/sw/rxe/rxe_task.c  | 52 ++++++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_task.h  | 15 ++++++--
>  8 files changed, 65 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 136c2efe3466..3c7e42e5b0c7 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -210,10 +210,16 @@ static int __init rxe_module_init(void)
>  {
>  	int err;
>  
> -	err = rxe_net_init();
> +	err = rxe_alloc_wq();
>  	if (err)
>  		return err;
>  
> +	err = rxe_net_init();
> +	if (err) {
> +		rxe_destroy_wq();
> +		return err;
> +	}
> +
>  	rdma_link_register(&rxe_link_ops);
>  	pr_info("loaded\n");
>  	return 0;
> @@ -224,6 +230,7 @@ static void __exit rxe_module_exit(void)
>  	rdma_link_unregister(&rxe_link_ops);
>  	ib_unregister_driver(RDMA_DRIVER_RXE);
>  	rxe_net_exit();
> +	rxe_destroy_wq();
>  
>  	pr_info("unloaded\n");
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index 20737fec392b..046bbacce37c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -773,7 +773,7 @@ int rxe_completer(void *arg)
>  	}
>  
>  	/* A non-zero return value will cause rxe_do_task to
> -	 * exit its loop and end the tasklet. A zero return
> +	 * exit its loop and end the work item. A zero return
>  	 * will continue looping and return to rxe_completer
>  	 */
>  done:
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index a754fc902e3d..bd8050e99d6b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -112,7 +112,7 @@ enum rxe_device_param {
>  	RXE_INFLIGHT_SKBS_PER_QP_HIGH	= 64,
>  	RXE_INFLIGHT_SKBS_PER_QP_LOW	= 16,
>  
> -	/* Max number of interations of each tasklet
> +	/* Max number of interations of each work item
>  	 * before yielding the cpu to let other
>  	 * work make progress
>  	 */
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index ab72db68b58f..e033b2449dfe 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -471,7 +471,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
>  /* move the qp to the reset state */
>  static void rxe_qp_reset(struct rxe_qp *qp)
>  {
> -	/* stop tasks from running */
> +	/* flush workqueue and stop tasks from running */
>  	rxe_disable_task(&qp->resp.task);
>  
>  	/* stop request/comp */
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 899c8779f800..2bcd287a2c3b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -830,7 +830,7 @@ int rxe_requester(void *arg)
>  	update_state(qp, &pkt);
>  
>  	/* A non-zero return value will cause rxe_do_task to
> -	 * exit its loop and end the tasklet. A zero return
> +	 * exit its loop and end the work item. A zero return
>  	 * will continue looping and return to rxe_requester
>  	 */
>  done:
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index c74972244f08..d9134a00a529 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1691,7 +1691,7 @@ int rxe_responder(void *arg)
>  	}
>  
>  	/* A non-zero return value will cause rxe_do_task to
> -	 * exit its loop and end the tasklet. A zero return
> +	 * exit its loop and end the work item. A zero return
>  	 * will continue looping and return to rxe_responder
>  	 */
>  done:
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 60b90e33a884..b96f72aa9005 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -6,6 +6,22 @@
>  
>  #include "rxe.h"
>  
> +static struct workqueue_struct *rxe_wq;
> +
> +int rxe_alloc_wq(void)
> +{
> +	rxe_wq = alloc_workqueue("rxe_wq", WQ_CPU_INTENSIVE, WQ_MAX_ACTIVE);
> +	if (!rxe_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void rxe_destroy_wq(void)
> +{
> +	destroy_workqueue(rxe_wq);
> +}
> +
>  int __rxe_do_task(struct rxe_task *task)
>  
>  {
> @@ -24,11 +40,11 @@ int __rxe_do_task(struct rxe_task *task)
>   * a second caller finds the task already running
>   * but looks just after the last call to func
>   */
> -static void do_task(struct tasklet_struct *t)
> +static void do_task(struct work_struct *w)
>  {
>  	int cont;
>  	int ret;
> -	struct rxe_task *task = from_tasklet(task, t, tasklet);
> +	struct rxe_task *task = container_of(w, typeof(*task), work);
>  	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
>  	unsigned int iterations = RXE_MAX_ITERATIONS;
>  
> @@ -64,10 +80,10 @@ static void do_task(struct tasklet_struct *t)
>  			} else if (iterations--) {
>  				cont = 1;
>  			} else {
> -				/* reschedule the tasklet and exit
> +				/* reschedule the work item and exit
>  				 * the loop to give up the cpu
>  				 */
> -				tasklet_schedule(&task->tasklet);
> +				queue_work(task->workq, &task->work);
>  				task->state = TASK_STATE_START;
>  			}
>  			break;
> @@ -97,7 +113,8 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
>  	task->func	= func;
>  	task->destroyed	= false;
>  
> -	tasklet_setup(&task->tasklet, do_task);
> +	INIT_WORK(&task->work, do_task);
> +	task->workq = rxe_wq;
>  
>  	task->state = TASK_STATE_START;
>  	spin_lock_init(&task->lock);
> @@ -111,17 +128,16 @@ void rxe_cleanup_task(struct rxe_task *task)
>  
>  	/*
>  	 * Mark the task, then wait for it to finish. It might be
> -	 * running in a non-tasklet (direct call) context.
> +	 * running in a non-workqueue (direct call) context.
>  	 */
>  	task->destroyed = true;
> +	flush_workqueue(task->workq);
>  
>  	do {
>  		spin_lock_bh(&task->lock);
>  		idle = (task->state == TASK_STATE_START);
>  		spin_unlock_bh(&task->lock);
>  	} while (!idle);
> -
> -	tasklet_kill(&task->tasklet);
>  }
>  
>  void rxe_run_task(struct rxe_task *task)
> @@ -129,7 +145,7 @@ void rxe_run_task(struct rxe_task *task)
>  	if (task->destroyed)
>  		return;
>  
> -	do_task(&task->tasklet);
> +	do_task(&task->work);
>  }
>  
>  void rxe_sched_task(struct rxe_task *task)
> @@ -137,15 +153,27 @@ void rxe_sched_task(struct rxe_task *task)
>  	if (task->destroyed)
>  		return;
>  
> -	tasklet_schedule(&task->tasklet);
> +	/*
> +	 * busy-loop while qp reset is in progress.
> +	 * This may be called from softirq context and thus cannot sleep.
> +	 */
> +	while (atomic_read(&task->suspended))
> +		cpu_relax();
> +
> +	queue_work(task->workq, &task->work);
>  }
>  
>  void rxe_disable_task(struct rxe_task *task)
>  {
> -	tasklet_disable(&task->tasklet);
> +	/* Alternative to tasklet_disable() */
> +	atomic_inc(&task->suspended);
> +	smp_mb__after_atomic();
> +	flush_workqueue(task->workq);
>  }
>  
>  void rxe_enable_task(struct rxe_task *task)
>  {
> -	tasklet_enable(&task->tasklet);
> +	/* Alternative to tasklet_enable() */
> +	smp_mb__before_atomic();
> +	atomic_dec(&task->suspended);
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
> index 7b88129702ac..9aa3f236e886 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.h
> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> @@ -19,15 +19,22 @@ enum {
>   * called again.
>   */
>  struct rxe_task {
> -	struct tasklet_struct	tasklet;
> +	struct workqueue_struct	*workq;
> +	struct work_struct	work;
>  	int			state;
>  	spinlock_t		lock;
>  	void			*arg;
>  	int			(*func)(void *arg);
>  	int			ret;
>  	bool			destroyed;
> +	/* used to {dis, en}able per-qp work items */
> +	atomic_t		suspended;
>  };
>  
> +int rxe_alloc_wq(void);
> +
> +void rxe_destroy_wq(void);
> +
>  /*
>   * init rxe_task structure
>   *	arg  => parameter to pass to fcn
> @@ -40,18 +47,20 @@ void rxe_cleanup_task(struct rxe_task *task);
>  
>  /*
>   * raw call to func in loop without any checking
> - * can call when tasklets are disabled
> + * can call when tasks are suspended
>   */
>  int __rxe_do_task(struct rxe_task *task);
>  
> +/* run a task without scheduling */
>  void rxe_run_task(struct rxe_task *task);
>  
> +/* schedule a task into workqueue */
>  void rxe_sched_task(struct rxe_task *task);
>  
>  /* keep a task from scheduling */
>  void rxe_disable_task(struct rxe_task *task);
>  
> -/* allow task to run */
> +/* allow a task to run again */
>  void rxe_enable_task(struct rxe_task *task);
>  
>  #endif /* RXE_TASK_H */

