Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254EE6031D0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJRRw6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 13:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJRRw5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 13:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D39B1A3A5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 10:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6677361668
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 17:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E872C433C1;
        Tue, 18 Oct 2022 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666115572;
        bh=7L9FXJjVyfj22Kd2cIlZ6MZU7zJCCETMOAB0C8mNnsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOxXqn5fKc/nPIxrYMVJAGIMyW9RRht+tZ4p4uQ+l0/r/ZchYX4yxfcEdWapIECJa
         ptWRrGm3wFezeqmPYnLm9SRysJo8CRkM0Wc03jL+AK+1eYlKDO5xozeVH7eo+BROy+
         JKOKOV4Du0Fj3eiQI+Aeun/D6SbfLQUuYfUd9+Zgmeug1Xij5bPO+bJL7UHfM3xAGG
         hPqgataA+v+fcZj4XhFcwF0wiiR8k4Lz+lzh0g1PtXbEKfdYxZfXPA9xzSUaCjSGHi
         vwOdwkMBK8JOhG0dluE+wjwGkx8AguRjaoXDED57iM84BS5/QF0Jk2VdofGdsIKUfk
         4oFqc0TDRRG0g==
Date:   Tue, 18 Oct 2022 20:52:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Subject: Re: [PATCH for-next 15/16] RDMA/rxe: Add workqueue support for tasks
Message-ID: <Y07n8G+6va+scr67@unreal>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-16-rpearsonhpe@gmail.com>
 <Y05rCgMya/D7VBV9@unreal>
 <0d612d5f-8faa-0e65-a820-ffaf886b32ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d612d5f-8faa-0e65-a820-ffaf886b32ca@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 18, 2022 at 10:18:13AM -0500, Bob Pearson wrote:
> On 10/18/22 03:59, Leon Romanovsky wrote:
> > On Mon, Oct 17, 2022 at 11:33:46PM -0500, Bob Pearson wrote:
> >> Add a third task type RXE_TASK_TYPE_WORKQUEUE to rxe_task.c.
> > 
> > Why do you need an extra type and not instead of RXE_TASK_TYPE_TASKLET?
> 
> It performs much better in some settings.
> > 
> >>
> >> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
> >>  drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++++++++++++
> >>  drivers/infiniband/sw/rxe/rxe_task.h | 10 +++-
> >>  3 files changed, 101 insertions(+), 2 deletions(-)

<...>

> >> +static void work_do_task(struct work_struct *work)
> >> +{
> >> +	struct rxe_task *task = container_of(work, typeof(*task), work);
> >> +
> >> +	if (!task->valid)
> >> +		return;
> > 
> > How can it be that submitted task is not valid? Especially without any
> > locking.
> 
> This and a similar subroutine for tasklets are called deferred and can have a significant
> delay before being called. In the mean time someone could have tried to destroy the QP. The valid
> flag is only cleared by QP destroy code and is not turned back on. Perhaps a rmb().

rmb() is not a locking.

> > 
> >> +
> >> +	do_task(task);
> >> +}
> > 
> > Thanks
> > 
> >> +
> 
