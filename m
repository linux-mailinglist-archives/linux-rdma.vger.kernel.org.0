Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603206CF2F1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjC2TRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC2TRu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:17:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91785260
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4305961E07
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 19:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278A8C433D2;
        Wed, 29 Mar 2023 19:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680117459;
        bh=A5YD1C/eq0LVgwx7ngI3b5iThn2ZDfCZJjVuD1orGR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0eXkf5BFYkON8JlJJPqp3jHK7c+sYpq9y1vxLbexMWd048vghr6YA1D/ttmS5AXI
         KcyoWyNTUuuwjz2j6viXrTXsJTrbVpX2W5JPIc8ncYxNY91oCHdsxSmPIE/N2bktEr
         PqaZl2h36wsoW1PXgqiNvxtSQyDmKHFSSIHYnCPVPNyf5uG1ok3rtAmMfyD/JMvpo0
         kZNP8ZYtfB3G5udDhHHK1hw9uPj3HIJ6FujyFXf+IyU5fZGM9e4H+BraOX2MkhkoBK
         C0qXiGr4NUWtxmiHwKCnFrrrQ82ckt4kPxnmN+EmS5YMqdEd2YTyucOPXSxfazI1DV
         lrqY3BZN15FBg==
Date:   Wed, 29 Mar 2023 22:17:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Carpenter <error27@gmail.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Properly check tasklet state
Message-ID: <20230329191735.GH831478@unreal>
References: <1a6376525c40454282a14ab659de0b17b02fe523.1680113901.git.leon@kernel.org>
 <e74f86fa-7332-8503-0660-4568c730c5df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74f86fa-7332-8503-0660-4568c730c5df@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 02:15:30PM -0500, Bob Pearson wrote:
> On 3/29/23 13:18, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Fix the following smatch error:
> > 
> >   drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
> >   warn: bitwise AND condition is false here
> > 
> > Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://lore.kernel.org/all/480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> > index fea9a517c8d9..48c89987137c 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_task.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> > @@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
> >  {
> >  	WARN_ON(rxe_read(task->qp) <= 0);
> >  
> > -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> > +	if (task->tasklet.state == TASKLET_STATE_SCHED)
> >  		return false;
> >  
> >  	if (task->state == TASK_STATE_IDLE) {
> > @@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
> >   */
> >  static bool __is_done(struct rxe_task *task)
> >  {
> > -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> > +	if (task->tasklet.state == TASKLET_STATE_SCHED)
> >  		return false;
> >  
> >  	if (task->state == TASK_STATE_IDLE ||
> 
> Leon, This is not correct either. I am about to fix this. -- Bob

Sure, no problem.

Thanks
