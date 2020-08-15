Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90E92453E5
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgHOWHD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgHOVus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0CC06123E
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 23:58:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x25so5621107pff.4
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SOOz+GJINtT7dlMD6lZUGPq5Qi7+nu3DK24u7Ap9sDg=;
        b=fmWK/tmrP3K2r7cYsV6GQbXTbT02Zo8cd5mRDDSoFLXR9qSxi5FM9ylJ5dJCiPV+SZ
         /VPr8JHLoAdh03PTFLIqUX5PdoUdVAmC+n4zrHvFTjLeoECURUlpSrRAiLqrFNi6Mtri
         587ZPTTs0KdPgAVnrLvpfco3RYwEN0rtX/fSTBNQH6q03vePADfGH9M9v4itrNRQxWi5
         LaefytfQNiDxAEQh4ZuhxWkuTdivUic7AETA8PxNM/94Juue+fuPkNLZY1xRaqCdbj5A
         5Y4a6pUpP75wtyAZyn8G9wgq6ndMW8GqFNbENhpI14r3uRKnkCZIaOWpfPiR+X3qE2Rk
         tdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SOOz+GJINtT7dlMD6lZUGPq5Qi7+nu3DK24u7Ap9sDg=;
        b=Bfb4uC3PTP/aHProCzLGxsOdJc9XeW3rQm8mHnvsn5yuUwH45sPHBBXFBsvsZN9Owl
         prDEGTT/0ujxtZI67n2FSjbmpAcG/ApLH8qGqEsu3fT9HZV8bJWZL5pZeJSqD+OVP4bU
         JwkGJADyPHmkb+yXMOBUjG3fOlYKEth117QgjvdN4VY6bxPvRLJY/zpPvNrZRhgZlQ9y
         Z806yiWRtqPI2H+DIU6IY0BUpmKYEuv4a6pEDsQZ3QqKOnRjuBCg54Nosteu2JGhFNi0
         jC0zQmT+H+kl2/JmL8SpaFjhPphio97pbcNgPVfup45qu2zfndg7cf/J295eUYfaO1vl
         kYbQ==
X-Gm-Message-State: AOAM532n04blDsztaopeFYvl6FUpWUd0rH1joON1Mo9jqYnzMHfEGWqW
        tNO3D8FOfTfpJ2pFICPKwaI=
X-Google-Smtp-Source: ABdhPJx87hZy9VD1Z1J/kATBM/EuVw9LcpWy5hs97Xuw0UTyTyW+2OO95+SjyenozR1wx1K1/GVVzw==
X-Received: by 2002:a63:e312:: with SMTP id f18mr4154125pgh.216.1597474729325;
        Fri, 14 Aug 2020 23:58:49 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id 74sm10389867pfv.191.2020.08.14.23.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 23:58:48 -0700 (PDT)
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20200812111447.256822-1-kamalheib1@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <9701a68d-c377-474a-5f65-c4e045a67e11@gmail.com>
Date:   Sat, 15 Aug 2020 14:58:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200812111447.256822-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/12/2020 7:14 PM, Kamal Heib wrote:
> To avoid the following kernel panic when calling kmem_cache_create()
> with a NULL pointer from pool_cache(),

What is the root cause of this kernel panic?

Zhu Yanjun

>   move the rxe_cache_init() to the
> context of device creation.
>
>   BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP NOPTI
>   CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
>   Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
>   RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
>   Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
>   RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
>   RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
>   RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
>   R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
>   R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
>   FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
>   Call Trace:
>    rxe_alloc+0xc8/0x160 [rdma_rxe]
>    rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
>    __ib_alloc_pd+0xcb/0x160 [ib_core]
>    ib_mad_init_device+0x296/0x8b0 [ib_core]
>    add_client_context+0x11a/0x160 [ib_core]
>    enable_device_and_get+0xdc/0x1d0 [ib_core]
>    ib_register_device+0x572/0x6b0 [ib_core]
>    ? crypto_create_tfm+0x32/0xe0
>    ? crypto_create_tfm+0x7a/0xe0
>    ? crypto_alloc_tfm+0x58/0xf0
>    rxe_register_device+0x19d/0x1c0 [rdma_rxe]
>    rxe_net_add+0x3d/0x70 [rdma_rxe]
>    ? dev_get_by_name_rcu+0x73/0x90
>    rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
>    parse_args+0x179/0x370
>    ? ref_module+0x1b0/0x1b0
>    load_module+0x135e/0x17e0
>    ? ref_module+0x1b0/0x1b0
>    ? __do_sys_init_module+0x13b/0x180
>    __do_sys_init_module+0x13b/0x180
>    do_syscall_64+0x5b/0x1a0
>    entry_SYSCALL_64_after_hwframe+0x65/0xca
>   RIP: 0033:0x7f9137ed296e
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c       | 14 +++++++-------
>   drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +++
>   drivers/infiniband/sw/rxe/rxe_sysfs.c |  7 +++++++
>   3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 5642eefb4ba1..60d5086dd34d 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -318,6 +318,13 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   		goto err;
>   	}
>   
> +	/* initialize slab caches for managed objects */
> +	err = rxe_cache_init();
> +	if (err) {
> +		pr_err("unable to init object pools\n");
> +		goto err;
> +	}
> +
>   	err = rxe_net_add(ibdev_name, ndev);
>   	if (err) {
>   		pr_err("failed to add %s\n", ndev->name);
> @@ -336,13 +343,6 @@ static int __init rxe_module_init(void)
>   {
>   	int err;
>   
> -	/* initialize slab caches for managed objects */
> -	err = rxe_cache_init();
> -	if (err) {
> -		pr_err("unable to init object pools\n");
> -		return err;
> -	}
> -
>   	err = rxe_net_init();
>   	if (err)
>   		return err;
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index fbcbac52290b..06c6d1f835b7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -139,6 +139,9 @@ int rxe_cache_init(void)
>   	for (i = 0; i < RXE_NUM_TYPES; i++) {
>   		type = &rxe_type_info[i];
>   		size = ALIGN(type->size, RXE_POOL_ALIGN);
> +		if (type->cache)
> +			continue;
> +
>   		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
>   			type->cache =
>   				kmem_cache_create(type->name, size,
> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> index ccda5f5a3bc0..d0af48ba0110 100644
> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> @@ -81,6 +81,13 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
>   		goto err;
>   	}
>   
> +	/* initialize slab caches for managed objects */
> +	err = rxe_cache_init();
> +	if (err) {
> +		pr_err("unable to init object pools\n");
> +		goto err;
> +	}
> +
>   	err = rxe_net_add("rxe%d", ndev);
>   	if (err) {
>   		pr_err("failed to add %s\n", intf);


