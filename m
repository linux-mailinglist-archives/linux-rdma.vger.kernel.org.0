Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FA2B997
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfE0RxV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 13:53:21 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37477 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0RxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 13:53:21 -0400
Received: by mail-vk1-f194.google.com with SMTP id j124so4017259vkb.4
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KkzjrLoQMXNpsaUjFUBON9gAQ+cJcBLAcD4Km36nuj4=;
        b=X2yTvhA3ejp9/Bwr9uCb6LmqVT0l0n7yyUtVV7LxQzDHJ7l+02E1eJP7hGtoqfCC8S
         BqMmdfxL1SN6LFjLlVvJGQ+Gn+Y7Dlu2IulhUslTHKzOEQCdXy5BgY4dPNGEvtO7Ys3V
         +VmBFve+GFmm4v77zI2HD/CnFgRL2dxdPfYPASm8jzu4Bch+lRB8ufmrCK1Eoe/ZnS3c
         MJRa2g4gG6qC0PdjFmN5Gz5tz8Iu83AkaAHOIATFzfyWScZHf10ylpfdXl7wm3qFcGLs
         I+49uuMLsxmOtcrSOmWOOzcoM536XZf5HyqdC8pfe4ariiMkezNr6bQhx9UMZOz2G4U6
         9RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KkzjrLoQMXNpsaUjFUBON9gAQ+cJcBLAcD4Km36nuj4=;
        b=eZ2AJu/GuUnPGPGK+yFucz5uBijw0TH14tDglg2d7WslE+SHaumIYGdIVbiyFM9bl3
         0w9uL9VcEOtjelKZH5ZBO7vTD5ZQEhjy0R11gu1+jTXqasA+A47L0Yh/6yBkEpRCU485
         JTvR1akYIJ7ozqQ9zHcYJk9qtm9MdgNFD8m4zyEbudxPJrmL8eVNv+ptS7HMz/xcu6r5
         8aIP3UKj//jzB3w7Tlq38JDokTDlL5598nxulT7gDwtrYojGqAQWVYou8NdVjgb/UhiQ
         3lp5yX38E9v3IXlxEUkbX8lHq4WB/9twC1YJ6oAtPTtcmb2Au7PLLCqDgaD6Gg6Gw/Ip
         zfnQ==
X-Gm-Message-State: APjAAAXwNl8JBgVu1xnecBs/gakg/rkONtwZ+MGWDDThIplDzWKktLC2
        4pZQh1nI/krNzv5LNWvqHfN1BQ==
X-Google-Smtp-Source: APXvYqxcVhZNQmFiE97QK3OwLMjVGuz0+YRhImnTR3X8nkDJYYabq+pMaInyMSPGxsgEZ/0zNIApDg==
X-Received: by 2002:a1f:551:: with SMTP id 78mr20475102vkf.45.1558979599949;
        Mon, 27 May 2019 10:53:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j78sm5912505vkj.47.2019.05.27.10.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 10:53:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVJoE-0001C5-Ou; Mon, 27 May 2019 14:53:18 -0300
Date:   Mon, 27 May 2019 14:53:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/core: Fix panic when port_data isn't
 initialized
Message-ID: <20190527175318.GA4513@ziepe.ca>
References: <20190523071251.7931-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523071251.7931-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 10:12:51AM +0300, Kamal Heib wrote:
> This happens if assign_name() return failure when called from
> ib_register_device(), that will lead to the following panic in every
> time that someone touches the port_data's data members.
> 
> All the functions that touch the port_data during teardown are called
> from ib_device_release() except free_netdevs() that called from multiple
> contexts, that's why the check had to be in both of them.
> 
> BUG: unable to handle kernel NULL pointer dereference at 00000000000000c0
> PGD 0 P4D 0
> Oops: 0002 [#1] SMP PTI
> CPU: 19 PID: 1994 Comm: systemd-udevd Not tainted 5.1.0-rc5+ #1
> Hardware name: HP ProLiant DL360p Gen8, BIOS P71 12/20/2013
> RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
> Code: 85 ff 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 53 9c 58 66 66 90
> 66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00 <f0> 0f b1 17 0f
> 94 c2 84 d2 74 05 48 89 d8 5b c3 89 c6 e8 b4 85 8a
> RSP: 0018:ffffa8d7079a7c08 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: 0000000000000202 RCX: ffffa8d7079a7bf8
> RDX: 0000000000000001 RSI: ffff93607c990000 RDI: 00000000000000c0
> RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffffc08c4dd8
> R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000000c0
> R13: ffff93607c990000 R14: ffffffffc05a9740 R15: ffffa8d7079a7e98
> FS:  00007f1c6ee438c0(0000) GS:ffff93609f6c0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000c0 CR3: 0000000819fca002 CR4: 00000000000606e0
> Call Trace:
>  free_netdevs+0x4d/0xe0 [ib_core]
>  ib_dealloc_device+0x51/0xb0 [ib_core]
>  __mlx5_ib_add+0x5e/0x70 [mlx5_ib]
>  mlx5_add_device+0x57/0xe0 [mlx5_core]
>  mlx5_register_interface+0x85/0xc0 [mlx5_core]
>  ? 0xffffffffc0474000
>  do_one_initcall+0x4e/0x1d4
>  ? _cond_resched+0x15/0x30
>  ? kmem_cache_alloc_trace+0x15f/0x1c0
>  do_init_module+0x5a/0x218
>  load_module+0x186b/0x1e40
>  ? m_show+0x1c0/0x1c0
>  __do_sys_finit_module+0x94/0xe0
>  do_syscall_64+0x5b/0x180
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: 8ceb1357b337 ("RDMA/device: Consolidate ib_device per_port data into one place")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>  drivers/infiniband/core/device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 78dc07c6ac4b..788bd56b6694 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -472,6 +472,9 @@ static void ib_device_release(struct device *device)
>  {
>  	struct ib_device *dev = container_of(device, struct ib_device, dev);
>  
> +	if (!dev->port_data)
> +		return;
> +

This skips the kfree on the device though. I fixed it like this, and
applied to for-rc

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index cd6b679badfe49..29f7b15c81d946 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -491,14 +491,15 @@ static void ib_device_release(struct device *device)
 
 	free_netdevs(dev);
 	WARN_ON(refcount_read(&dev->refcount));
-	ib_cache_release_one(dev);
-	ib_security_release_port_pkey_list(dev);
-	xa_destroy(&dev->compat_devs);
-	xa_destroy(&dev->client_data);
-	if (dev->port_data)
+	if (dev->port_data) {
+		ib_cache_release_one(dev);
+		ib_security_release_port_pkey_list(dev);
 		kfree_rcu(container_of(dev->port_data, struct ib_port_data_rcu,
 				       pdata[0]),
 			  rcu_head);
+	}
+	xa_destroy(&dev->compat_devs);
+	xa_destroy(&dev->client_data);
 	kfree_rcu(dev, rcu_head);
 }
 
@@ -1952,6 +1953,9 @@ static void free_netdevs(struct ib_device *ib_dev)
 	unsigned long flags;
 	unsigned int port;
 
+	if (!ib_dev->port_data)
+		return;
+
 	rdma_for_each_port (ib_dev, port) {
 		struct ib_port_data *pdata = &ib_dev->port_data[port];
 		struct net_device *ndev;
