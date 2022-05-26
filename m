Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5753528E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348293AbiEZRdh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348292AbiEZRdg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 13:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05333DA74
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 10:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5177C60F9C
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 17:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB75C385A9;
        Thu, 26 May 2022 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653586414;
        bh=vNaUOyi6KHg6/mhnmsDq3D6BQNOCBHTXZfxaR1rb+HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/uvAamnABS7oCMFUdpB/0mTYLuONmR1s4uRdk1N9xTFCXvWq4I5s026LLrQxlIFR
         G80BGaWiu7VxEOdjNX1Vk/ip0mpNR+ybp0sdB1EVvshLvQveMojw/4bzlvPK0ZnOZx
         E2kWPiaxtBN+CWOY1PnhmhIfmy4feVtu1ZRB8LfzyKFdSa6esHLzcOyuit1Nd6gNvS
         DPc5mUkirSZMhTgXbavcgasaiYH98oVoQca/LnMVBXEfsOpN1S8GPhpUA7z6lZ/s+N
         bV3bk3y+o0arfLJ/Ad9VYOyIeFkEDS8cjrQ+4ZFabitFt6uFQcuLM/7Sz2h+DmbLIy
         zNofp+JXFUYIg==
Date:   Thu, 26 May 2022 20:33:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add a umr recovery flow
Message-ID: <Yo+56peBOmZj7Lm/@unreal>
References: <6cc24816cca049bd8541317f5e41d3ac659445d3.1652588303.git.leonro@nvidia.com>
 <20220526143212.GA3078527@nvidia.com>
 <Yo+q4KQ2JU92XZlh@unreal>
 <20220526172132.GL1343366@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526172132.GL1343366@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 26, 2022 at 02:21:32PM -0300, Jason Gunthorpe wrote:
> On Thu, May 26, 2022 at 07:29:20PM +0300, Leon Romanovsky wrote:
> 
> > > > +		err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context.cqe, wqe,
> > > > +					  with_data);
> > > > +		mutex_unlock(&umrc->lock);
> > > > +		if (err) {
> > > > +			mlx5_ib_warn(dev, "UMR post send failed, err %d\n",
> > > > +				     err);
> > > > +			break;
> > > >  		}
> > > > +
> > > > +		wait_for_completion(&umr_context.done);
> > > 
> > > Nor is sleeping under a semaphore.
> > 
> > Not according to the kernel/locking/semaphore.c. Semaphores can sleep
> > and the code protected by semaphores can sleep too.
> > 
> >    53 void down(struct semaphore *sem)
> >    54 {
> >    55         unsigned long flags;
> >    56
> >    57         might_sleep();
> >    ....
> >    64 }
> >    65 EXPORT_SYMBOL(down);
> 
> Hum, OK, I am confused
> 
> > > And, I'm pretty sure, this entire function is called under a spinlock
> > > in some cases.
> >
> > Can you point to such flow?
> 
> It seems like not anymore, or at least I couldn't find a case.

So are we fine with this patch and it can go as is after merge window?

Thanks

> 
> Jason
