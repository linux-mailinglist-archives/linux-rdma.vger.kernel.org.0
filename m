Return-Path: <linux-rdma+bounces-14265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204CC362DA
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA63934EBF1
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB632E696;
	Wed,  5 Nov 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf6gR9LZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329C32E152
	for <linux-rdma@vger.kernel.org>; Wed,  5 Nov 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354484; cv=none; b=gNY+wXMAjsqLvintjDnSSDUmVkk6WHsy3y4osD3sxJJILYOc1bJmk+YjGCipkEk7scFvGfop7+9XFRMWmXoWUp/S8okTNrLcI0QVjdI5qGzoSMUpSvE1sHl7fubvjpeZQ7S30KMFwUy1pRhtdOXsyFX8PO0L6QMn1dRj6DgiWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354484; c=relaxed/simple;
	bh=/8qZfvbjbGoIrdv11Er/b3nuuQSJpiCcI4HF2EM5h00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBgyuUp21y43Y2sYa1fDAFtcMhzWbhI4vExlbyDixnofP90S8LF3egeeW4QGGW87Vt/32N74VoUxb4dF3j1bqrZbic3fe8A6a4FVXE+Jcq/gKxKeRbfQSPmVpjFs8QWES0bVHBJNyfaOhAuwJRTw6ld7ARTfeoDQnFWw2NS7/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf6gR9LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083FAC4CEF8;
	Wed,  5 Nov 2025 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762354483;
	bh=/8qZfvbjbGoIrdv11Er/b3nuuQSJpiCcI4HF2EM5h00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bf6gR9LZgIBjKd/plZTafnx3oHUY91oSMAP1iVTGbfjfJ4txygkkoT/yDdRAShVeB
	 gz7aLVudhw0kne8VfOSdao0ox7JbxHPE3sSJq9+Dd9yxYs7Vo1uioHiwZqtVkVYcdI
	 iv8XCY5makpG3qFz2pYi1FDqWExpZJ8BwI+OA5ZLJAtc1ki06VI5VnatHDSL8ovMjL
	 YJV0jY2LeO+F7VBndnUGl3Gt59mvf+x6p3A9y7rnFOiigg9DkhbRsBR9gWcsteOqVX
	 kR3fNGgRG8J2D9WT3bNUFvQvKanobX77WvYpG/AUAzthYBMCfjiOwadOpR41e0z8AR
	 G2dafbd8rQAkg==
Date: Wed, 5 Nov 2025 16:54:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/core: Fix WARNING in
 gid_table_release_one
Message-ID: <20251105145438.GH16832@unreal>
References: <20251104233601.1145-1-yanjun.zhu@linux.dev>
 <20251105130958.GE16832@unreal>
 <20251105134524.GL1204670@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105134524.GL1204670@ziepe.ca>

On Wed, Nov 05, 2025 at 09:45:24AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 03:09:58PM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 04, 2025 at 03:36:01PM -0800, Zhu Yanjun wrote:
> > > GID entry ref leak for dev syz1 index 2 ref=615
> > > ...
> > > Call Trace:
> > >  <TASK>
> > >  ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
> > >  device_release+0x99/0x1c0 drivers/base/core.c:-1
> > >  kobject_cleanup lib/kobject.c:689 [inline]
> > >  kobject_release lib/kobject.c:720 [inline]
> > >  kref_put include/linux/kref.h:65 [inline]
> > >  kobject_put+0x228/0x480 lib/kobject.c:737
> > >  process_one_work kernel/workqueue.c:3263 [inline]
> > >  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
> > >  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
> > >  kthread+0x711/0x8a0 kernel/kthread.c:463
> > >  ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >  </TASK>
> > > 
> > > When the state of a GID is GID_TABLE_ENTRY_PENDING_DEL, it indicates
> > > that the GID is about to be released soon. Therefore, it does not
> > > appear to be a leak.
> > > 
> > > Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
> > > Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > > V1->V2: Use flush_workqueue instead of while loop
> > > ---
> > >  drivers/infiniband/core/cache.c | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > > index 81cf3c902e81..74211fb37020 100644
> > > --- a/drivers/infiniband/core/cache.c
> > > +++ b/drivers/infiniband/core/cache.c
> > > @@ -799,16 +799,26 @@ static void release_gid_table(struct ib_device *device,
> > >  	if (!table)
> > >  		return;
> > >  
> > > +	mutex_lock(&table->lock);
> > >  	for (i = 0; i < table->sz; i++) {
> > >  		if (is_gid_entry_free(table->data_vec[i]))
> > >  			continue;
> > >  
> > > -		WARN_ONCE(true,
> > > -			  "GID entry ref leak for dev %s index %d ref=%u\n",
> > > +		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
> > > +			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
> > >  			  dev_name(&device->dev), i,
> > > -			  kref_read(&table->data_vec[i]->kref));
> > > +			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
> > > +		/*
> > > +		 * The entry may be sitting in the WQ waiting for
> > > +		 * free_gid_work(), flush it to try to clean it.
> > > +		 */
> > > +		mutex_unlock(&table->lock);
> > > +		flush_workqueue(ib_wq);
> > > +		mutex_lock(&table->lock);
> > 
> > I can't agree with idea that flush_workqueue() is called in the loop.
> 
> Since we almost never see these WARN_ON's it isn't really called in a
> loop, but sure you could put a conditional around it to do it only
> once.

We have WARN_ONCE(), this is why you don't see many WARN_ON's.

> 
> The WARN on is in the wrong order, it is not a kernel bug if the
> workqueue is still pending. flush the queue and then check again, and
> then do the warn.
> 
> @@ -791,22 +791,31 @@ static struct ib_gid_table *alloc_gid_table(int sz)
>         return NULL;
>  }
>  
> -static void release_gid_table(struct ib_device *device,
> -                             struct ib_gid_table *table)
> +static bool is_gid_table_clean(struct ib_gid_table *table)
>  {
>         int i;
>  
> +       guard(mutex)(&table->lock);
> +       for (i = 0; i < table->sz; i++)
> +               if (!is_gid_entry_free(table->data_vec[i]))
> +                       return false;
> +       return true;
> +}
> +
> +static void release_gid_table(struct ib_device *device,
> +                             struct ib_gid_table *table)
> +{
>         if (!table)
>                 return;
>  
> -       for (i = 0; i < table->sz; i++) {
> -               if (is_gid_entry_free(table->data_vec[i]))
> -                       continue;
> -
> -               WARN_ONCE(true,
> -                         "GID entry ref leak for dev %s index %d ref=%u\n",
> -                         dev_name(&device->dev), i,
> -                         kref_read(&table->data_vec[i]->kref));
> +       if (!is_gid_table_clean(table)) {
> +               /*
> +                * The entry may be sitting in the WQ waiting for
> +                * free_gid_work(), flush it to try to clean it.
> +                */
> +               flush_workqueue(ib_wq);
> +               if (!is_gid_table_clean(table))
> +                       WARN_ONCE(true, "GID entry has leaked");
>         }
>  
>         mutex_destroy(&table->lock);
> 
> Jason

