Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9706CFAD7
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 07:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjC3Fjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 01:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC3Fjp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 01:39:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607F5BA6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 22:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73155B825AB
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 05:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93306C433EF;
        Thu, 30 Mar 2023 05:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680154778;
        bh=B2FzuFVK7Xhj0fEzi/tDK6y9048G7TnLIIutpN2s4H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MeCe4cCXMlobgXEdY6JzqGpN0DSbc34MdNAU1z5ykpVKgDvLs+/CqIwvtivbXHUHw
         +Z8IQYJ3EQAwx5kfcBkQHOenG9bOvOKpwKqALDcCSmv5sAidQQgwlhzKMPq507NoH5
         KBVqNkDrDbLOqVOtqoH6AbUPriVBduBhRSEibx2bXHWm3zdYxtq7yZd94sCb/c39T+
         EW7qW+w1oL0ijcss90YNFVv+l/PM6dlOPTpdxMRx1j4lfvm5r2eZj/5a0okeSqN8v0
         e4GDC1RNDAH9DhfLDyBoUPdtqPXfoNQHQ186d+l5CUiTn4i4iVNwr1RXa2azOosORE
         gv8Ha7+38R9eA==
Date:   Thu, 30 Mar 2023 08:39:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     error27@gmail.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix error in rxe_task.c
Message-ID: <20230330053933.GJ831478@unreal>
References: <20230329193308.7489-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329193308.7489-1-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 02:33:09PM -0500, Bob Pearson wrote:
> In a previous patch TASKLET_STATE_SCHED was used as a bit but it
> is a bit position instead. This patch corrects that error.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/linux-rdma/8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain/
> Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Like I said here https://lore.kernel.org/all/20230329191701.GG831478@unrealm 
Why didn't you used test_bit?

Also please fix your commit message and title to clearly say what this
patch is doing. "Fix error ..." is too broad.
https://lore.kernel.org/all/1a6376525c40454282a14ab659de0b17b02fe523.1680113901.git.leon@kernel.org/

Thanks

> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index fea9a517c8d9..fb9a6bc8e620 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>  {
>  	WARN_ON(rxe_read(task->qp) <= 0);
>  
> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
>  		return false;
>  
>  	if (task->state == TASK_STATE_IDLE) {
> @@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>   */
>  static bool __is_done(struct rxe_task *task)
>  {
> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
>  		return false;
>  
>  	if (task->state == TASK_STATE_IDLE ||
> -- 
> 2.37.2
> 
