Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEB124F27D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgHXGXt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 02:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgHXGXs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 02:23:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F03823110;
        Mon, 24 Aug 2020 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598250228;
        bh=rGYuCR6xemrFTJKPOSdCL78VucFe+21EcVchJvXF9uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wA2dtYUu4LQ1b5UG2JymBXzA7tSxTETgyblR7LwTpt05OCHh2E1XpfNV5pR7OoKNL
         BJB3kmKB/oe248Jp0F2jhoTt/ZUPN1fGt7zfbLUEWU9oLCaInMU+qk6A6V2wi3n0Qp
         xxTp2DCUnIueLd2hiGnE9hOiFu9n9yNxs6+lnXjI=
Date:   Mon, 24 Aug 2020 09:23:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200824062344.GE571722@unreal>
References: <20200818142504.917186-1-kamalheib1@gmail.com>
 <20200818163157.GY24045@ziepe.ca>
 <20200818211545.GA936143@kheib-workstation>
 <20200820113717.GA24045@ziepe.ca>
 <20200823194558.GA36665@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823194558.GA36665@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 23, 2020 at 10:45:58PM +0300, Kamal Heib wrote:
> On Thu, Aug 20, 2020 at 08:37:17AM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 19, 2020 at 12:15:45AM +0300, Kamal Heib wrote:
> > > On Tue, Aug 18, 2020 at 01:31:57PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 18, 2020 at 05:25:04PM +0300, Kamal Heib wrote:
> > > > > To avoid the following kernel panic when calling kmem_cache_create()
> > > > > with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
> > > > > context of device initialization.
> > > >
> > > > I think you've hit on a bigger bug than just this oops.
> > > >
> > > > rxe_net_add() should never be called before rxe_module_init(), that
> > > > surely subtly breaks all kinds of things.
> > > >
> > > > Maybe it is time to remove these module parameters?
> > > >
> > > Yes, I agree, this can be done in for-next.
> > >
> > > But at least can we take this patch to for-rc (stable) to fix this issue
> > > in stable releases?
> >
> > If you want to fix something in stable then block the module options
> > from working as actual module options - eg before rxe_module_init()
> > runs.
> >
> > Jason
>
> Something like the following patch?

If you want to got this path, it will be more like this: request_module("rdma_rxe")

Thanks

>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 907203afbd99..872ebc57ac06 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -40,6 +40,8 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
>  MODULE_DESCRIPTION("Soft RDMA transport");
>  MODULE_LICENSE("Dual BSD/GPL");
>
> +bool rxe_is_loaded = false;
> +
>  /* free resources for a rxe device all objects created for this device must
>   * have been destroyed
>   */
> @@ -315,6 +317,7 @@ static int __init rxe_module_init(void)
>                 return err;
>
>         rdma_link_register(&rxe_link_ops);
> +       rxe_is_loaded = true;
>         pr_info("loaded\n");
>         return 0;
>  }
> @@ -326,6 +329,7 @@ static void __exit rxe_module_exit(void)
>         rxe_net_exit();
>         rxe_cache_exit();
>
> +       rxe_is_loaded = false;
>         pr_info("unloaded\n");
>  }
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index fb07eed9e402..d9b71b5e2fba 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -67,6 +67,8 @@
>
>  #define RXE_ROCE_V2_SPORT              (0xc000)
>
> +extern bool rxe_is_loaded;
> +
>  static inline u32 rxe_crc32(struct rxe_dev *rxe,
>                             u32 crc, void *next, size_t len)
>  {
> diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> index ccda5f5a3bc0..12c7ca0764d5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> @@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
>         struct net_device *ndev;
>         struct rxe_dev *exists;
>
> +       if (!rxe_is_loaded) {
> +               pr_err("Please make sure to load the rdma_rxe module first\n");
> +               return -EINVAL;
> +       }
> +
>         len = sanitize_arg(val, intf, sizeof(intf));
>         if (!len) {
>                 pr_err("add: invalid interface name\n");
>
> Thanks,
> Kamal
