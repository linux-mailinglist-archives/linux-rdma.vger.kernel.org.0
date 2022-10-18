Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D38E6027BE
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 11:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJRJAY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiJRJAA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 05:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD74190
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 01:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 284C8614E6
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 08:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5C5C433D6;
        Tue, 18 Oct 2022 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666083598;
        bh=8dsXkcP0ne9/QbMpehGM1maj1PjDXH+z3IUoALBvTAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apUJjA8p3U+ErpELpJC/C0E+5OFEblDa7Cjq5WCBmoEHzXC68T50LZK+JYJru+Yqb
         XENVKtDojI8xmVU3ZKiCtbhsP4dSodGRfwjxPNEaVgbOVxFeOLcqaN9TEDS9m3RPQ/
         SLyyWgTV7QRnoYgQSog9p3IVzZkG7kx5gcgH/2t1/wnhbVJ+fLdoihrpSGwMMBBIdB
         LTwly2mPqJE//bSqfj8EHVPLoMzP6seTeko1812Z0YBjSR9sr/3zk5KjK/l5HPmIVx
         6ovBl66xrKr8MAp2iG/B2hShR14bfEPFZahDisYOZTH/oW0nmAD/Gf3wOy3J7YMWEx
         lQyweVR7jcBrw==
Date:   Tue, 18 Oct 2022 11:59:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Subject: Re: [PATCH for-next 15/16] RDMA/rxe: Add workqueue support for tasks
Message-ID: <Y05rCgMya/D7VBV9@unreal>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-16-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018043345.4033-16-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 17, 2022 at 11:33:46PM -0500, Bob Pearson wrote:
> Add a third task type RXE_TASK_TYPE_WORKQUEUE to rxe_task.c.

Why do you need an extra type and not instead of RXE_TASK_TYPE_TASKLET?

> 
> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
>  drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_task.h | 10 +++-
>  3 files changed, 101 insertions(+), 2 deletions(-)

<...>

> +static struct workqueue_struct *rxe_wq;
> +
> +int rxe_alloc_wq(void)
> +{
> +	rxe_wq = alloc_workqueue("rxe_wq", WQ_MEM_RECLAIM |
> +				WQ_HIGHPRI | WQ_CPU_INTENSIVE |
> +				WQ_SYSFS, WQ_MAX_ACTIVE);

Are you sure that all these flags can be justified? WQ_MEM_RECLAIM?

> +
> +	if (!rxe_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

<...>

> +static void work_sched(struct rxe_task *task)
> +{
> +	if (!task->valid)
> +		return;
> +
> +	queue_work(rxe_wq, &task->work);
> +}
> +
> +static void work_do_task(struct work_struct *work)
> +{
> +	struct rxe_task *task = container_of(work, typeof(*task), work);
> +
> +	if (!task->valid)
> +		return;

How can it be that submitted task is not valid? Especially without any
locking.

> +
> +	do_task(task);
> +}

Thanks

> +
