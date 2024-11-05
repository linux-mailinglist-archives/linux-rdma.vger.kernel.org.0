Return-Path: <linux-rdma+bounces-5775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA99BD57E
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 19:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843F51C22D17
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01B1E906B;
	Tue,  5 Nov 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV3al8eh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED817BEB7;
	Tue,  5 Nov 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832994; cv=none; b=ee62gao2ofDK3+k9Zf2qY1KHpLwMtdTcB/6F5j055GeXtQsN41rYrLzglTBDVxPdMppQq/k1BSNWvWS1BgN1WFvOX+rjOdG1ZL5UmqGHvhW1SnqvvgrpZaqR9cDklXb9SkVJvhPq4C8XZaZAHVZ0dn89zFhWsspP5o2llpo795w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832994; c=relaxed/simple;
	bh=c/J5SfUIJ9hQst/+9a2BMM/+0T0QUgD6O198Li/u3mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDzcFQjvgO3gn2LCu+fH6eKxygDgg4yQv7hDs1EqIim9RUkndsaeVIGVSeLLSILatf4v7GqMy/1t8uUJUb42O8vQ04BVl0aLQylWFv2qki3E3jAVp0cT+30AtlyzBsgfmyb9axAsw/ptnp5JEj93cPbx06uLbGNFh2Q4Jj3pzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV3al8eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8A9C4CECF;
	Tue,  5 Nov 2024 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730832994;
	bh=c/J5SfUIJ9hQst/+9a2BMM/+0T0QUgD6O198Li/u3mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qV3al8eh5yGBIlvCge0rhsVraqUXO27A+aqiSVDZA5tCLYlWKWOGLDWFSgGOgNTOI
	 Qn8OtFnHkRoQYja3H6tOBkwfekfawfjTrTb6F6H8Y+4edPtaRGEFIVHeQJjx08X2Ir
	 xhFjsiY1wnGeOFfcSYgT1ifE9JSch6vBOiiSy9ra3xO3171ANU33EbGatSuJmpmGzP
	 b12JaYiD9ZIQeavoZfoWbaDpOZ7Cc38rfDrOkoMP3UCmH7/hGj+1J0BZuLemgfERjL
	 CNlimFcs6Hfgo9mRCKxQk0N5bmI2k9YBeL6ds57lLI6iaPd35BIjN3GO9qaAjuinHC
	 AB1DoBGjv6nQA==
Date: Tue, 5 Nov 2024 10:56:32 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] mlx5/core: Schedule EQ comp tasklet only if
 necessary
Message-ID: <ZypqYHaRbBCGo3FD@x130>
References: <CY8PR12MB7195C97EB164CD3A0E9A99F9DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241031163436.3732948-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241031163436.3732948-1-csander@purestorage.com>

On 31 Oct 10:34, Caleb Sander Mateos wrote:
>Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
>to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
>whose completions don't need to be processed in tasklet context, this
>adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
>time spent on the tasklet_trylock() in tasklet_action_common(), with a
>smaller amount spent on the atomic operations in tasklet_schedule(),
>tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
>TCP completions are handled by mlx5e_completion_event(), which schedules
>NAPI to poll the queue, so they don't need tasklet processing.
>
>Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
>overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
>to be processed in tasklet context, so it can schedule the tasklet. CQs
>that need tasklet processing have their interrupt comp handler set to
>mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
>don't need tasklet processing won't schedule the tasklet. To avoid
>scheduling the tasklet multiple times during the same interrupt, only
>schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
>queue was empty before the new CQ was pushed to it.
>
>The additional branch in mlx5_add_cq_to_tasklet(), called for each EQE,
>may add a small cost for the userspace Infiniband CQs whose completions
>are processed in tasklet context. But this seems worth it to avoid the
>tasklet overhead for CQs that don't need it.
>
>Note that the mlx4 driver works the same way: it schedules the tasklet
>in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.
>
>Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>Reviewed-by: Parav Pandit <parav@nvidia.com>
>---
>v3: revise commit message
>v2: reorder variable declarations, describe CPU profile results
>
> drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 +++++
> drivers/net/ethernet/mellanox/mlx5/core/eq.c | 5 +----
> 2 files changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
>index 4caa1b6f40ba..25f3b26db729 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
>@@ -69,22 +69,27 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
> static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
> 				   struct mlx5_eqe *eqe)
> {
> 	unsigned long flags;
> 	struct mlx5_eq_tasklet *tasklet_ctx = cq->tasklet_ctx.priv;
>+	bool schedule_tasklet = false;
>
> 	spin_lock_irqsave(&tasklet_ctx->lock, flags);
> 	/* When migrating CQs between EQs will be implemented, please note
> 	 * that you need to sync this point. It is possible that
> 	 * while migrating a CQ, completions on the old EQs could
> 	 * still arrive.
> 	 */
> 	if (list_empty_careful(&cq->tasklet_ctx.list)) {
> 		mlx5_cq_hold(cq);

The condition here is counter intuitive, please add a comment that relates
to the tasklet routine mlx5_cq_tasklet_cb, something like.
/* If this list isn't empty, the tasklet is already scheduled, and not yet
  * executing the list, the spinlock here guarantees the addition of this CQ
  * will be seen by the next execution, so rescheduling the tasklet is not
  * required */ 

One other way to do this, is to flag tasklet_ctx.sched_flag = true, inside
mlx5_add_cq_to_tasklet, and then schedule once at the end of eq irq processing 
if (tasklet_ctx.sched_flag == true). to avoid "too" early scheduling, but
since the tasklet can't run until the irq handler returns, I think your
solution shouldn't suffer from "too" early scheduling .. 

Acked-by: Saeed Mahameed <saeedm@nvidia.com>


>+		schedule_tasklet = list_empty(&tasklet_ctx->list);
> 		list_add_tail(&cq->tasklet_ctx.list, &tasklet_ctx->list);
> 	}
> 	spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
>+
>+	if (schedule_tasklet)
>+		tasklet_schedule(&tasklet_ctx->task);
> }
>
> /* Callers must verify outbox status in case of err */
> int mlx5_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
> 		   u32 *in, int inlen, u32 *out, int outlen)
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>index 859dcf09b770..3fd2091c11c8 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>@@ -112,14 +112,14 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
> 	struct mlx5_eq_comp *eq_comp =
> 		container_of(nb, struct mlx5_eq_comp, irq_nb);
> 	struct mlx5_eq *eq = &eq_comp->core;
> 	struct mlx5_eqe *eqe;
> 	int num_eqes = 0;
>-	u32 cqn = -1;
>
> 	while ((eqe = next_eqe_sw(eq))) {
> 		struct mlx5_core_cq *cq;
>+		u32 cqn;
>
> 		/* Make sure we read EQ entry contents after we've
> 		 * checked the ownership bit.
> 		 */
> 		dma_rmb();
>@@ -142,13 +142,10 @@ static int mlx5_eq_comp_int(struct notifier_block *nb,
> 			break;
> 	}
>
> 	eq_update_ci(eq, 1);
>
>-	if (cqn != -1)
>-		tasklet_schedule(&eq_comp->tasklet_ctx.task);
>-
> 	return 0;
> }
>
> /* Some architectures don't latch interrupts when they are disabled, so using
>  * mlx5_eq_poll_irq_disabled could end up losing interrupts while trying to
>-- 
>2.45.2
>
>

