Return-Path: <linux-rdma+bounces-14262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6FC35E89
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC59A3AC420
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D173191AD;
	Wed,  5 Nov 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jsV9AAus"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFD31327F
	for <linux-rdma@vger.kernel.org>; Wed,  5 Nov 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350330; cv=none; b=bGRHY9M9c38EIovKU3QlTf5Ps2PPEH35YHfDkV/vVXHJH5aAXoZZD/dxIV11Clpu+fiG3CNrrSBdS1lDkRjvU2KNauZYQqWnOgiEZM/vI4DzzNqvXbkLjywVaf22eNBsoQJBudYWfR0iV71wcEpxyyCRa7KKJ9J6s0EuZ+wdec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350330; c=relaxed/simple;
	bh=GYmmFoz9gdPzpLZcsQLhnyERQgCuix7jgJcFMR6pn+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+Y2re5NdcU7avN2suiKLzGihv+vsridpoRZoX7T/GdZ7cK53HSgA9y43kfLbQnn7NY9D4PGx2FBgPxrjKjfLzgV2rSQEokh9Z2neDn4+LNx4c1zj3NVYX/uvkpjobth7zAbGPyew+hstq2Rcgnnajbryi3vsph/m9qORTk38+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jsV9AAus; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b22b1d3e7fso44033585a.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Nov 2025 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762350326; x=1762955126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZugSK3HPVoxblK/rLmPO40X5vdiPEexVPxaw32XE0Bw=;
        b=jsV9AAusyEu/Hr1Z9HRkR+AP0Bl480ehBpBAdCl5CN1RI0BVOQNGoVHapjapHpJuDK
         qAYhxh0wQw1PRcTE+ARcLSJ88qk9Ti32kXt2d0SRpgSVokcScRASuJOyfINSeh9R73N5
         f+6Q3WIlZCjJxzrC5WauM0Dp0YxTKzl0AdQJb6VBarnpBN39QYkUXzKrRkYKske3AFDg
         Zt7REAOMdAaN55tQJeoChYnydUUl0Pvg6TkHClyU8tL5gutzF89kjka3ogRQekjj7YIf
         PcBUwsmtZJL3g9Bn2l9H9/RS4wunFabYZ3MEMRbrfxUVeSIC/J+66IuzyG9RdksMc4VO
         4zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350326; x=1762955126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZugSK3HPVoxblK/rLmPO40X5vdiPEexVPxaw32XE0Bw=;
        b=UPT4CFuLCSr1rtXwsUjZ8yEqPrJViTkI7XsDBt1PvX7CuSLhNquvzit7T/7V/nhFNc
         5GFC1EyjLdgCcs9Ci0l/8aVutltpL59/5IcZnGPpJVSIwkVoIJXsEGEGiUe+EeXRthpF
         3qQ8fkHOfESgXV/rde1DHCznYFMl9DNOqZ5RVTTlGx46E61ynaQ9/cBhGFAa2sMWBBd9
         1qC14+m6dWVNxVlmRq72U9Hyx3youeBA7hWodkcUZtF5Kex/KB3au9+KNdEu+uF6lHGE
         F/xvXCm0VgfXbhRXr8gNLmwGJI1BzBKyHkgYqWIMMkum9L8svsrTwMevJJPD7eQU8dYx
         FbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVuUSklfNuWw2/9tEdb5rJ8hPNHBSbjj2kKoEyTRyfjZKvkRxuLnBezm/AgGauJmP/BpOA9BR8kukq@vger.kernel.org
X-Gm-Message-State: AOJu0YxnO4gYLquFPraAVnPL0zGr76W8tTJkcxN0V1W832x9L/lKTrii
	JVG2fVnfIhrhjhCaYUNsG8rvnFN+3ZRz/xM5KRTK+dqgOZgUQot9ahEZvZL7f6a0FR1ew7J8Z6C
	WK5Gh
X-Gm-Gg: ASbGncuqkPrC5uPmVKobI1QP9LG5yTR+FC+XSqfkDrq3mNMk6dxui+aw8earz1T0II3
	cRLB0jWirOqjAHrXGxplTtJ/DnjGUdcgAyMvQM0+OK0ywzuTPY+pm62eFOZBqEuKwSA3vaSxjMa
	EQz9ffsYaGaL2te8FmEvBTrQ2AjZ15sDaoTeiMGvqJYhdIzb5o0pcD45y6+zxDJzTIJRFtPlCZm
	9nK1ZtExfw2JzC6DfT5JG2gkV0tEVx/xo2doG6yGd3fejb5WUesX8f7VsnV/1VCQPHJvNhEmZUh
	wV5TKhOkaNigXNjiupuNQIo86Q02EbTbzAB8jJ34IFGsD5g22ghMozdDxSzlFWCoed9hxYRRKD6
	dGge4efyFglIlK87kHdtrHt6kseuOOE4HdGno0r4KAIscSHOa7YEvB+ut7qfwq9CRxJ1UmTutxK
	v43fK2oJCA4LPvcgcB9RPROCMj/7vyVr8NTMQwuP7qBueBKQ==
X-Google-Smtp-Source: AGHT+IGhnNN7z9gkl0AmloL+E8c5qndPqYVP4BEpuE39NWUhZntBXi+U+xCFEW7dOkj0J/NGLLcYOw==
X-Received: by 2002:a05:620a:454b:b0:8a2:234a:17c8 with SMTP id af79cd13be357-8b22081b9bamr428116985a.12.1762350325972;
        Wed, 05 Nov 2025 05:45:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f543a3c5sm407454885a.13.2025.11.05.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:45:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGdpE-000000079MV-3Zbf;
	Wed, 05 Nov 2025 09:45:24 -0400
Date: Wed, 5 Nov 2025 09:45:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/core: Fix WARNING in
 gid_table_release_one
Message-ID: <20251105134524.GL1204670@ziepe.ca>
References: <20251104233601.1145-1-yanjun.zhu@linux.dev>
 <20251105130958.GE16832@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105130958.GE16832@unreal>

On Wed, Nov 05, 2025 at 03:09:58PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 04, 2025 at 03:36:01PM -0800, Zhu Yanjun wrote:
> > GID entry ref leak for dev syz1 index 2 ref=615
> > ...
> > Call Trace:
> >  <TASK>
> >  ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
> >  device_release+0x99/0x1c0 drivers/base/core.c:-1
> >  kobject_cleanup lib/kobject.c:689 [inline]
> >  kobject_release lib/kobject.c:720 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >  kobject_put+0x228/0x480 lib/kobject.c:737
> >  process_one_work kernel/workqueue.c:3263 [inline]
> >  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
> >  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
> >  kthread+0x711/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> > 
> > When the state of a GID is GID_TABLE_ENTRY_PENDING_DEL, it indicates
> > that the GID is about to be released soon. Therefore, it does not
> > appear to be a leak.
> > 
> > Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
> > Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > ---
> > V1->V2: Use flush_workqueue instead of while loop
> > ---
> >  drivers/infiniband/core/cache.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > index 81cf3c902e81..74211fb37020 100644
> > --- a/drivers/infiniband/core/cache.c
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -799,16 +799,26 @@ static void release_gid_table(struct ib_device *device,
> >  	if (!table)
> >  		return;
> >  
> > +	mutex_lock(&table->lock);
> >  	for (i = 0; i < table->sz; i++) {
> >  		if (is_gid_entry_free(table->data_vec[i]))
> >  			continue;
> >  
> > -		WARN_ONCE(true,
> > -			  "GID entry ref leak for dev %s index %d ref=%u\n",
> > +		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
> > +			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
> >  			  dev_name(&device->dev), i,
> > -			  kref_read(&table->data_vec[i]->kref));
> > +			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
> > +		/*
> > +		 * The entry may be sitting in the WQ waiting for
> > +		 * free_gid_work(), flush it to try to clean it.
> > +		 */
> > +		mutex_unlock(&table->lock);
> > +		flush_workqueue(ib_wq);
> > +		mutex_lock(&table->lock);
> 
> I can't agree with idea that flush_workqueue() is called in the loop.

Since we almost never see these WARN_ON's it isn't really called in a
loop, but sure you could put a conditional around it to do it only
once.

The WARN on is in the wrong order, it is not a kernel bug if the
workqueue is still pending. flush the queue and then check again, and
then do the warn.

@@ -791,22 +791,31 @@ static struct ib_gid_table *alloc_gid_table(int sz)
        return NULL;
 }
 
-static void release_gid_table(struct ib_device *device,
-                             struct ib_gid_table *table)
+static bool is_gid_table_clean(struct ib_gid_table *table)
 {
        int i;
 
+       guard(mutex)(&table->lock);
+       for (i = 0; i < table->sz; i++)
+               if (!is_gid_entry_free(table->data_vec[i]))
+                       return false;
+       return true;
+}
+
+static void release_gid_table(struct ib_device *device,
+                             struct ib_gid_table *table)
+{
        if (!table)
                return;
 
-       for (i = 0; i < table->sz; i++) {
-               if (is_gid_entry_free(table->data_vec[i]))
-                       continue;
-
-               WARN_ONCE(true,
-                         "GID entry ref leak for dev %s index %d ref=%u\n",
-                         dev_name(&device->dev), i,
-                         kref_read(&table->data_vec[i]->kref));
+       if (!is_gid_table_clean(table)) {
+               /*
+                * The entry may be sitting in the WQ waiting for
+                * free_gid_work(), flush it to try to clean it.
+                */
+               flush_workqueue(ib_wq);
+               if (!is_gid_table_clean(table))
+                       WARN_ONCE(true, "GID entry has leaked");
        }
 
        mutex_destroy(&table->lock);

Jason

