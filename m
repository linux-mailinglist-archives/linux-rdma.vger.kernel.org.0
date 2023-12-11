Return-Path: <linux-rdma+bounces-355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003D80CB4F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C89D281098
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC441741;
	Mon, 11 Dec 2023 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia8K5YU0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87D3D97E
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 13:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EA5C433C7;
	Mon, 11 Dec 2023 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302346;
	bh=Vimk7e5q40vbEzlVSqmm3kbcefcVNReNYU3xVrjn7UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ia8K5YU07aWkSia4+D7y7qWaRQSjVcDxDW60yyrWupGZojJs0MjFRSnA3lYB1ztL5
	 xT9BJBX3m2oTKskbvhVuyIMK9M3rtASK0Rcc3jDUyYVDBRNbY+zj6BtAsMru6dOTA+
	 1f9+4NGo3LpW0314VlkPmTpmk1olfSMGJqC1TV3M3jaMG71JttQ9sqiSFR5ol0aCbI
	 qbvbj4NixxpeOVD7KYX16ZnZTFVMrpZPgpTPviTB9rihySzYIFh+6xNxiPK959LASY
	 gB+OZ3LWpa/naoR/t2GYzpe6vEU1mB75GKvx8YCseHHa293/fZrQUkKE4zGprZjUry
	 4bGhfYhRIis4Q==
Date: Mon, 11 Dec 2023 15:45:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
Subject: Re: [PATCH 1/2] IB/ipoib: Fix mcast list locking
Message-ID: <20231211134542.GG4870@unreal>
References: <20231211130426.1500427-1-neelx@redhat.com>
 <20231211130426.1500427-2-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211130426.1500427-2-neelx@redhat.com>

On Mon, Dec 11, 2023 at 02:04:24PM +0100, Daniel Vacek wrote:
> We need an additional protection against list removal between ipoib_mcast_join_task()
> and ipoib_mcast_dev_flush() in case the &priv->lock needs to be dropped while
> iterating the &priv->multicast_list in ipoib_mcast_join_task(). If the mcast
> is removed while the lock was dropped, the for loop spins forever resulting
> in a hard lockup (as was reported on RHEL 4.18.0-372.75.1.el8_6 kernel):
> 
>     Task A (kworker/u72:2 below)       | Task B (kworker/u72:0 below)
>     -----------------------------------+-----------------------------------
>     ipoib_mcast_join_task(work)        | ipoib_ib_dev_flush_light(work)
>       spin_lock_irq(&priv->lock)       | __ipoib_ib_dev_flush(priv, ...)
>       list_for_each_entry(mcast,       | ipoib_mcast_dev_flush(dev = priv->dev)
>           &priv->multicast_list, list) |   mutex_lock(&priv->mcast_mutex)
>         ipoib_mcast_join(dev, mcast)   |
>           spin_unlock_irq(&priv->lock) |
>                                        |   spin_lock_irqsave(&priv->lock, flags)
>                                        |   list_for_each_entry_safe(mcast, tmcast,
>                                        |                  &priv->multicast_list, list)
>                                        |     list_del(&mcast->list);
>                                        |     list_add_tail(&mcast->list, &remove_list)
>                                        |   spin_unlock_irqrestore(&priv->lock, flags)
>           spin_lock_irq(&priv->lock)   |
>                                        |   ipoib_mcast_remove_list(&remove_list)
>    (Here, mcast is no longer on the    |     list_for_each_entry_safe(mcast, tmcast,
>     &priv->multicast_list and we keep  |                            remove_list, list)
>     spinning on the &remove_list of the \ >>>  wait_for_completion(&mcast->done)
>     other thread which is blocked and the|
>     list is still valid on it's stack.)  | mutex_unlock(&priv->mcast_mutex)
> 
> Fix this by adding mutex_lock(&priv->mcast_mutex) to ipoib_mcast_join_task().

I don't entirely understand the issue and the proposed solution.
There is only one spin_unlock_irq() in the middle of list_for_each_entry(mcast, &priv->multicast_list, list)
and it is right before return statement which will break the loop. So
how will loop spin forever?

Thanks

> Unfortunately we could not reproduce the lockup and confirm this fix but
> based on the code review I think this fix should address such lockups.
> 
> crash> bc 31
> PID: 747      TASK: ff1c6a1a007e8000  CPU: 31   COMMAND: "kworker/u72:2"
> --
>     [exception RIP: ipoib_mcast_join_task+0x1b1]
>     RIP: ffffffffc0944ac1  RSP: ff646f199a8c7e00  RFLAGS: 00000002
>     RAX: 0000000000000000  RBX: ff1c6a1a04dc82f8  RCX: 0000000000000000
>                                   work (&priv->mcast_task{,.work})
>     RDX: ff1c6a192d60ac68  RSI: 0000000000000286  RDI: ff1c6a1a04dc8000
>            &mcast->list
>     RBP: ff646f199a8c7e90   R8: ff1c699980019420   R9: ff1c6a1920c9a000
>     R10: ff646f199a8c7e00  R11: ff1c6a191a7d9800  R12: ff1c6a192d60ac00
>                                                          mcast
>     R13: ff1c6a1d82200000  R14: ff1c6a1a04dc8000  R15: ff1c6a1a04dc82d8
>            dev                    priv (&priv->lock)     &priv->multicast_list (aka head)
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #5 [ff646f199a8c7e00] ipoib_mcast_join_task+0x1b1 at ffffffffc0944ac1 [ib_ipoib]
>  #6 [ff646f199a8c7e98] process_one_work+0x1a7 at ffffffff9bf10967
> 
> crash> rx ff646f199a8c7e68
> ff646f199a8c7e68:  ff1c6a1a04dc82f8 <<< work = &priv->mcast_task.work
> 
> crash> list -hO ipoib_dev_priv.multicast_list ff1c6a1a04dc8000
> (empty)
> 
> crash> ipoib_dev_priv.mcast_task.work.func,mcast_mutex.owner.counter ff1c6a1a04dc8000
>   mcast_task.work.func = 0xffffffffc0944910 <ipoib_mcast_join_task>,
>   mcast_mutex.owner.counter = 0xff1c69998efec000
> 
> crash> b 8
> PID: 8        TASK: ff1c69998efec000  CPU: 33   COMMAND: "kworker/u72:0"
> --
>  #3 [ff646f1980153d50] wait_for_completion+0x96 at ffffffff9c7d7646
>  #4 [ff646f1980153d90] ipoib_mcast_remove_list+0x56 at ffffffffc0944dc6 [ib_ipoib]
>  #5 [ff646f1980153de8] ipoib_mcast_dev_flush+0x1a7 at ffffffffc09455a7 [ib_ipoib]
>  #6 [ff646f1980153e58] __ipoib_ib_dev_flush+0x1a4 at ffffffffc09431a4 [ib_ipoib]
>  #7 [ff646f1980153e98] process_one_work+0x1a7 at ffffffff9bf10967
> 
> crash> rx ff646f1980153e68
> ff646f1980153e68:  ff1c6a1a04dc83f0 <<< work = &priv->flush_light
> 
> crash> ipoib_dev_priv.flush_light.func,broadcast ff1c6a1a04dc8000
>   flush_light.func = 0xffffffffc0943820 <ipoib_ib_dev_flush_light>,
>   broadcast = 0x0,
> 
> The mcast(s) on the &remove_list (the remaining part of the ex &priv->multicast_list):
> 
> crash> list -s ipoib_mcast.done.done ipoib_mcast.list -H ff646f1980153e10 | paste - -
> ff1c6a192bd0c200	  done.done = 0x0,
> ff1c6a192d60ac00	  done.done = 0x0,
> 
> Reported-by: Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> index 5b3154503bf4..8e4f2c8839be 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> @@ -580,6 +580,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
>  	}
>  	netif_addr_unlock_bh(dev);
>  
> +	mutex_lock(&priv->mcast_mutex);
>  	spin_lock_irq(&priv->lock);
>  	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
>  		goto out;
> @@ -634,6 +635,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
>  				/* Found the next unjoined group */
>  				if (ipoib_mcast_join(dev, mcast)) {
>  					spin_unlock_irq(&priv->lock);
> +					mutex_unlock(&priv->mcast_mutex);
>  					return;
>  				}
>  			} else if (!delay_until ||
> @@ -655,6 +657,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
>  		ipoib_mcast_join(dev, mcast);
>  
>  	spin_unlock_irq(&priv->lock);
> +	mutex_unlock(&priv->mcast_mutex);
>  }
>  
>  void ipoib_mcast_start_thread(struct net_device *dev)
> -- 
> 2.43.0
> 

