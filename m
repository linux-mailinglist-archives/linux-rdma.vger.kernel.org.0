Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81C53520E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 18:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiEZQ32 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiEZQ31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 12:29:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01109A987
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 09:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 996A1B82058
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 16:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93DBC385A9;
        Thu, 26 May 2022 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653582564;
        bh=vNroL1pARwyFy6yRQnIrStLA3j0IB2nO/CIDJP7L1Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lquTxRkUKcTwUxufdTSe26TpxCp+goG+iI80MdRYvBUq1gDSY7OX5PRY/VntUUDMy
         9jinZE3vP74SgMTCUYUvXgMd5ND5y+hOQY3rYdhe36P2W0bVKtM9TcplkjgnNHbTlM
         ZSuBes2swCaKjU6XiTkcASWwzpCt/Rl1IxFf7Q0jJGafFB9SiwpYrpoygRkmgSDf6F
         30QImheuQJgpACIAXnJMYnFeAZ4QAmQV3UOdmP8bEe4bQPFovwfAHdYOxi7orHi01b
         FHZbWqnSgTSqDgNf9YSmn4uxi/hdG5cIH0mbIPhHAkHzJd7udXe7dq68Qp1gwC2Cja
         t+ywUcHOWu6+Q==
Date:   Thu, 26 May 2022 19:29:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add a umr recovery flow
Message-ID: <Yo+q4KQ2JU92XZlh@unreal>
References: <6cc24816cca049bd8541317f5e41d3ac659445d3.1652588303.git.leonro@nvidia.com>
 <20220526143212.GA3078527@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526143212.GA3078527@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 26, 2022 at 11:32:12AM -0300, Jason Gunthorpe wrote:
> On Sun, May 15, 2022 at 07:19:53AM +0300, Leon Romanovsky wrote:
> > @@ -270,17 +296,49 @@ static int mlx5r_umr_post_send_wait(struct mlx5_ib_dev *dev, u32 mkey,
> >  	mlx5r_umr_init_context(&umr_context);
> >  
> >  	down(&umrc->sem);
> > +	while (true) {
> > +		mutex_lock(&umrc->lock);
> 
> You need to test this with lockdep, nesing a mutex under a semaphor is
> not allowed, AFAIK.

We are running with lockdep all our tests.

> 
> > +		err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context.cqe, wqe,
> > +					  with_data);
> > +		mutex_unlock(&umrc->lock);
> > +		if (err) {
> > +			mlx5_ib_warn(dev, "UMR post send failed, err %d\n",
> > +				     err);
> > +			break;
> >  		}
> > +
> > +		wait_for_completion(&umr_context.done);
> 
> Nor is sleeping under a semaphore.

Not according to the kernel/locking/semaphore.c. Semaphores can sleep
and the code protected by semaphores can sleep too.

   53 void down(struct semaphore *sem)
   54 {
   55         unsigned long flags;
   56
   57         might_sleep();
   ....
   64 }
   65 EXPORT_SYMBOL(down);

> 
> And, I'm pretty sure, this entire function is called under a spinlock
> in some cases.

Can you point to such flow?

Thanks

> 
> Jason
