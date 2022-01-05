Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8448507B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 10:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiAEJ6i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 04:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiAEJ6g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 04:58:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB6C061761;
        Wed,  5 Jan 2022 01:58:36 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h7so43345195lfu.4;
        Wed, 05 Jan 2022 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxXH8VI4wZmAXX9m4NvWpw3z/tZg6/iYEenlHFjwdH0=;
        b=A0QdlXM/UQcCsIPeYRwLvanvCWVtfLTWwePpHr+mJ+mwisjtmg/ZIcsQ3kcNGsJnUk
         9746F9rO2kxABpWjJrjflsdeQhKKvPpORYGYGG81lMAUisD59uXDlWmGryHMWF6oanQB
         t2afLs9kHbtSFizvL+eOny8N1pdWs5l+djVvtUbC+MTcmKrnyUzZzWoZ8KZvJxQqyxof
         fTOvZfRM1qS34QeahT1Ai/TZwkM0Bpitbjzx2S5VWmw0x/e8rSAEn8rxRnoZPsY25h0r
         rDz3UcurJykHeD4OkyJo+5p8OHc5JqVwdgX/eF1EklQhXA7IHjYn3fgVfvMzw0Gg0yJA
         GC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxXH8VI4wZmAXX9m4NvWpw3z/tZg6/iYEenlHFjwdH0=;
        b=qPRZfpmUwTG85zPOklZp2wXafVba0zbW+t1ivnZ63aOKF3tpTt985lYylJZXb2v+qd
         9TTT2lSk+KozMUYJrqIKyh+7sDsjm0hAmmpJ1zaFJwJhfpbubVb6knN3LVcxuaE2L5Ol
         q3emMnXWgFELqTUsqBktHtrYD7SPsEvGVSoOLKhJkDocY+ag47mjDEK5bdl0FkD/cquT
         YnaGfdLwObJcHcATdHRSctmybXcDZNDafDgRGmnv1yDGVfk4kqSkYP+jCezLE7+eDvMB
         QESV+CKjhNOodeXbrpgIj/sk/iMplK95bVv4SVo70iNLoGEMk+qO6+aa1FpB/TxCJjOH
         pQuQ==
X-Gm-Message-State: AOAM532tg4WgWXHx6Mg0bfUkON4lb7vgqOridbom9WlE898Au/hFi4+y
        KvuGtWRDdOHHhEptAvCi9DQJZ1YPXL8JdHtZnrs=
X-Google-Smtp-Source: ABdhPJzR0mtBwvpmhPcPsOddpOKSSVaBlscNdhkFzqpHE57uKccK9i5ZJ6mtcAMk60MSsvMfXZkYjGeRSztQwvG0IAA=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr4755826lfg.281.1641376714308;
 Wed, 05 Jan 2022 01:58:34 -0800 (PST)
MIME-Version: 1.0
References: <c8376d7517aebe7cc851f0baaeef7b13707cf767.1641372460.git.leonro@nvidia.com>
In-Reply-To: <c8376d7517aebe7cc851f0baaeef7b13707cf767.1641372460.git.leonro@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 5 Jan 2022 17:58:22 +0800
Message-ID: <CAD=hENeZC7x9TTDCLkUzTF=+=EAbFX3dWxQB5A3YSaaS2AS8Ng@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Delete deprecated module parameters interface
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 5, 2022 at 4:50 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Starting from the commit 66920e1b2586 ("rdma_rxe: Use netlink messages
> to add/delete links") from the 2019, the RXE modules parameters are marked
> as deprecated in favour of rdmatool. So remove the kernel code too.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/Makefile    |   1 -
>  drivers/infiniband/sw/rxe/rxe.c       |   4 -
>  drivers/infiniband/sw/rxe/rxe.h       |   2 -
>  drivers/infiniband/sw/rxe/rxe_sysfs.c | 119 --------------------------
>  4 files changed, 126 deletions(-)
>  delete mode 100644 drivers/infiniband/sw/rxe/rxe_sysfs.c
>
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 1e24673e9318..5395a581f4bb 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -22,5 +22,4 @@ rdma_rxe-y := \
>         rxe_mcast.o \
>         rxe_task.o \
>         rxe_net.o \
> -       rxe_sysfs.o \
>         rxe_hw_counters.o
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 8e0f9c489cab..fab291245366 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -13,8 +13,6 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
>  MODULE_DESCRIPTION("Soft RDMA transport");
>  MODULE_LICENSE("Dual BSD/GPL");
>
> -bool rxe_initialized;
> -
>  /* free resources for a rxe device all objects created for this device must
>   * have been destroyed
>   */
> @@ -290,7 +288,6 @@ static int __init rxe_module_init(void)
>                 return err;
>
>         rdma_link_register(&rxe_link_ops);
> -       rxe_initialized = true;
>         pr_info("loaded\n");
>         return 0;
>  }
> @@ -301,7 +298,6 @@ static void __exit rxe_module_exit(void)
>         ib_unregister_driver(RDMA_DRIVER_RXE);
>         rxe_net_exit();
>
> -       rxe_initialized = false;
>         pr_info("unloaded\n");
>  }
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index 1bb3fb618bf5..fb9066e6f5f0 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -39,8 +39,6 @@
>
>  #define RXE_ROCE_V2_SPORT              (0xc000)
>
> -extern bool rxe_initialized;
> -
>  void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
>
>  int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> deleted file mode 100644
> index 666202ddff48..000000000000
> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> -/*
> - * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
> - * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
> - */
> -
> -#include "rxe.h"
> -#include "rxe_net.h"
> -
> -/* Copy argument and remove trailing CR. Return the new length. */
> -static int sanitize_arg(const char *val, char *intf, int intf_len)
> -{
> -       int len;
> -
> -       if (!val)
> -               return 0;
> -
> -       /* Remove newline. */
> -       for (len = 0; len < intf_len - 1 && val[len] && val[len] != '\n'; len++)
> -               intf[len] = val[len];
> -       intf[len] = 0;
> -
> -       if (len == 0 || (val[len] != 0 && val[len] != '\n'))
> -               return 0;
> -
> -       return len;
> -}
> -
> -static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> -{
> -       int len;
> -       int err = 0;
> -       char intf[32];
> -       struct net_device *ndev;
> -       struct rxe_dev *exists;
> -
> -       if (!rxe_initialized) {
> -               pr_err("Module parameters are not supported, use rdma link add or rxe_cfg\n");
> -               return -EAGAIN;
> -       }
> -
> -       len = sanitize_arg(val, intf, sizeof(intf));
> -       if (!len) {
> -               pr_err("add: invalid interface name\n");
> -               return -EINVAL;
> -       }
> -
> -       ndev = dev_get_by_name(&init_net, intf);
> -       if (!ndev) {
> -               pr_err("interface %s not found\n", intf);
> -               return -EINVAL;
> -       }
> -
> -       if (is_vlan_dev(ndev)) {
> -               pr_err("rxe creation allowed on top of a real device only\n");
> -               err = -EPERM;
> -               goto err;
> -       }
> -
> -       exists = rxe_get_dev_from_net(ndev);
> -       if (exists) {
> -               ib_device_put(&exists->ib_dev);
> -               pr_err("already configured on %s\n", intf);
> -               err = -EINVAL;
> -               goto err;
> -       }
> -
> -       err = rxe_net_add("rxe%d", ndev);
> -       if (err) {
> -               pr_err("failed to add %s\n", intf);
> -               goto err;
> -       }
> -
> -err:
> -       dev_put(ndev);
> -       return err;
> -}
> -
> -static int rxe_param_set_remove(const char *val, const struct kernel_param *kp)
> -{
> -       int len;
> -       char intf[32];
> -       struct ib_device *ib_dev;
> -
> -       len = sanitize_arg(val, intf, sizeof(intf));
> -       if (!len) {
> -               pr_err("add: invalid interface name\n");
> -               return -EINVAL;
> -       }
> -
> -       if (strncmp("all", intf, len) == 0) {
> -               pr_info("rxe_sys: remove all");
> -               ib_unregister_driver(RDMA_DRIVER_RXE);
> -               return 0;
> -       }
> -
> -       ib_dev = ib_device_get_by_name(intf, RDMA_DRIVER_RXE);
> -       if (!ib_dev) {
> -               pr_err("not configured on %s\n", intf);
> -               return -EINVAL;
> -       }
> -
> -       ib_unregister_device_and_put(ib_dev);
> -
> -       return 0;
> -}
> -
> -static const struct kernel_param_ops rxe_add_ops = {
> -       .set = rxe_param_set_add,
> -};
> -
> -static const struct kernel_param_ops rxe_remove_ops = {
> -       .set = rxe_param_set_remove,
> -};
> -
> -module_param_cb(add, &rxe_add_ops, NULL, 0200);
> -MODULE_PARM_DESC(add, "DEPRECATED.  Create RXE device over network interface");
> -module_param_cb(remove, &rxe_remove_ops, NULL, 0200);
> -MODULE_PARM_DESC(remove, "DEPRECATED.  Remove RXE device over network interface");
> --
> 2.33.1
>
