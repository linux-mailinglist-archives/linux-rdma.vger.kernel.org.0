Return-Path: <linux-rdma+bounces-14259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF4C35C5A
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 14:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174DB1A21BEA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA933168E2;
	Wed,  5 Nov 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzMFZWby"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88118A921
	for <linux-rdma@vger.kernel.org>; Wed,  5 Nov 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348204; cv=none; b=r1EhoJGPbbZQSeVi6T9uOGjYciRjcNUJHaGww9SViGaqHetANOCJQA8++YPSDk8P/Rxdy1jr0bYCaqFPo9VGfaB5yrgAt+nMXaxYhFsH83c1Rpp0qgZw5x8pgj8eaNCtbpM1NlB7jTg2feD48vFtE1witKHWkSKUiKWS81c4778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348204; c=relaxed/simple;
	bh=33eVLwZWon6c02IkTyPtr3R4OvRuvGWNhqVzTN2VsiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODYiYJd1qL4DFpcWMUAsmmexXHDONmsCkVDnP4WpebaYCCyq7N3t5zx9GCHCh2TmEQOIxTWSHU+eXtRgQEEUZTeTdbIpSOgRa/VMPnEq0U+MKwQquru4T8NdF+yBnwR9A7UPKHoqyjlTXLZJXjxxeoFJpP6Rzb0IGeIALd1LIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzMFZWby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7B7C4CEF8;
	Wed,  5 Nov 2025 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762348204;
	bh=33eVLwZWon6c02IkTyPtr3R4OvRuvGWNhqVzTN2VsiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzMFZWby8zQ8sovgzxsNWM47fjjAKTt0CR6rhmN1/yBg3QszuAiH05uDs0ggM112p
	 omxopmKLkh6EsIZd3Q2uz5qBHa7ylh2pGewdrNuK65Zx1bIugOuRSqyPKeKIUBtzME
	 dNJ5B9ia0PrKah5SSIJOl85JPEyR65hol1aW9RIXsMUXcOrhhREDML+12AI+Vy/F2Z
	 NM5NSC2/mhICUXH8jfhjfRM+msx1n0CupWSrP4m6iRz53UbaWDb7qngLN/ysoM8zNo
	 xGysJwyq7Vaptoud/KPCHYOiXeiHWBXpotoNGK/LL4ll3I6KIsYYgg01MWevKlVGVX
	 wqxr3g92Ry3Cw==
Date: Wed, 5 Nov 2025 15:09:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/core: Fix WARNING in
 gid_table_release_one
Message-ID: <20251105130958.GE16832@unreal>
References: <20251104233601.1145-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104233601.1145-1-yanjun.zhu@linux.dev>

On Tue, Nov 04, 2025 at 03:36:01PM -0800, Zhu Yanjun wrote:
> GID entry ref leak for dev syz1 index 2 ref=615
> ...
> Call Trace:
>  <TASK>
>  ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>  device_release+0x99/0x1c0 drivers/base/core.c:-1
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x228/0x480 lib/kobject.c:737
>  process_one_work kernel/workqueue.c:3263 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> When the state of a GID is GID_TABLE_ENTRY_PENDING_DEL, it indicates
> that the GID is about to be released soon. Therefore, it does not
> appear to be a leak.
> 
> Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Use flush_workqueue instead of while loop
> ---
>  drivers/infiniband/core/cache.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 81cf3c902e81..74211fb37020 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -799,16 +799,26 @@ static void release_gid_table(struct ib_device *device,
>  	if (!table)
>  		return;
>  
> +	mutex_lock(&table->lock);
>  	for (i = 0; i < table->sz; i++) {
>  		if (is_gid_entry_free(table->data_vec[i]))
>  			continue;
>  
> -		WARN_ONCE(true,
> -			  "GID entry ref leak for dev %s index %d ref=%u\n",
> +		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
> +			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
>  			  dev_name(&device->dev), i,
> -			  kref_read(&table->data_vec[i]->kref));
> +			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
> +		/*
> +		 * The entry may be sitting in the WQ waiting for
> +		 * free_gid_work(), flush it to try to clean it.
> +		 */
> +		mutex_unlock(&table->lock);
> +		flush_workqueue(ib_wq);
> +		mutex_lock(&table->lock);

I can't agree with idea that flush_workqueue() is called in the loop.

Thanks

>  	}
>  
> +	mutex_unlock(&table->lock);
> +
>  	mutex_destroy(&table->lock);
>  	kfree(table->data_vec);
>  	kfree(table);
> -- 
> 2.51.2
> 

