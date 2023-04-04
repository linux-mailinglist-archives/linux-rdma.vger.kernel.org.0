Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D852E6D57D1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 06:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjDDE66 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 00:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjDDE65 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 00:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0CB1BDA
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 21:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEFD761620
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 04:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF2EC433D2;
        Tue,  4 Apr 2023 04:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680584335;
        bh=x3bqxAzEOTD/fZcsNqlfgvywpFjkQaq7j2hliyhPzd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiIfol7axiZa8V7j8hMm+SRkn+YjI7ratFIbKpLd1ngjwj64nvSyW+7Ltb7BawmhK
         DezfTFTco8zF1sqIXBam6s7blYHIIyawg7j4BM9YkN5DV4St0MRE2Zfb+GHrNUvZff
         khWlkNu5GAY0ZwTceBSEoIEF0Jt5JkYk7Yc/79QqfCAijIgojFjg0KxXN6wSxJL7lg
         dSoEk1bg5iq6dJJiqY/29vAqY+IDAPhD/ac75oO9RL17BzBbA8LPpGF/0ILwnK/5/o
         SKYmVJ+jhP1CzKc8LBiWH8y5URc63mQlsI2x+nHwFmHk4pG/I2N9cyDeBrZN6hU+ox
         zDmUWpYs0tTlA==
Date:   Tue, 4 Apr 2023 07:58:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     error27@gmail.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix error in rxe_task.c
Message-ID: <20230404045850.GE4514@unreal>
References: <20230329193308.7489-1-rpearsonhpe@gmail.com>
 <727cd25c-7d8f-73d0-8867-836da29c54b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727cd25c-7d8f-73d0-8867-836da29c54b2@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 03, 2023 at 03:38:13PM -0500, Bob Pearson wrote:
> On 3/29/23 14:33, Bob Pearson wrote:
> > In a previous patch TASKLET_STATE_SCHED was used as a bit but it
> > is a bit position instead. This patch corrects that error.
> > 
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://lore.kernel.org/linux-rdma/8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain/
> > Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> > index fea9a517c8d9..fb9a6bc8e620 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_task.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> > @@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
> >  {
> >  	WARN_ON(rxe_read(task->qp) <= 0);
> >  
> > -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> > +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
> >  		return false;
> >  
> >  	if (task->state == TASK_STATE_IDLE) {
> > @@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
> >   */
> >  static bool __is_done(struct rxe_task *task)
> >  {
> > -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> > +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
> >  		return false;
> >  
> >  	if (task->state == TASK_STATE_IDLE ||
> 
> This patch fixes a bug in rxe_task.c introduced by the earlier patch (d94671632572 RDMA/rxe: Rewrite rxe_task.c)
> which is in for-next. The bug actually has minimal effects because TASKLET_STATE_SCHED is zero and in testing
> so far it doesn't seem to make a difference.
> 
> There is a second patch currently in patchworks ([for-next,v6] RDMA/rxe: Add workqueue support for tasks
> [for-next,v6] RDMA/rxe: Add workqueue support for tasks 	- - - 	--- 	2023-03-02 	Bob Pearson New)
> which is ahead of this one and replaces the tasklet implementation by work queues. This second patch replaces the
> lines lines containing the error with a workqueue specific equivalent.
> 
> There are two ways forward here. We could fix the tasklet version by applying this patch first or ignore the
> error and apply the workqueue patch first. My desire is to get rid of tasklets altogether so I prefer the
> second choice. If we choose the first choice then we need to reorder the two patches in patchworks and
> rebase the workqueue patch to match the fixed tasklet code.
> 
> Please suggest how you would like me to proceed.

I prefer to have small fix first as it is unclear when "RDMA/rxe: Add workqueue support for tasks"
will be merged.
https://lore.kernel.org/all/20230330053933.GJ831478@unreal

Thanks

> 
> Bob
