Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA41124B01E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgHTH0x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 03:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHTH0t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Aug 2020 03:26:49 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EC920855;
        Thu, 20 Aug 2020 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597908408;
        bh=t4bKEsISjU+swqbptv5TvmTEq7sSsFd1uw+cTCm1aSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIuVzkp5KnbkFf3wGZ/5tCP04z35GGkYqL9GzlriEU+FErnjJSVAS522IM5Q+it0x
         utSNoqGX9iP3ZIgoIDVNp/XqTqLwcS4SAd/Y5J0peQ86x1sThLSWAaszolECFu3+Ma
         x44nNqhsK2WUSClVj9kWInkZC1BYyU1ZgiC/l0rw=
Date:   Thu, 20 Aug 2020 10:26:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v3] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
Message-ID: <20200820072644.GY7555@unreal>
References: <20200820034152.1660135-1-haris.iqbal@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820034152.1660135-1-haris.iqbal@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 09:11:52AM +0530, Md Haris Iqbal wrote:
> The rnbd_server module's communication manager (cm) initialization depends
> on the registration of the "network namespace subsystem" of the RDMA CM
> agent module. As such, when the kernel is configured to load the
> rnbd_server and the RDMA cma module during initialization; and if the
> rnbd_server module is initialized before RDMA cma module, a null ptr
> dereference occurs during the RDMA bind operation.
>
> Call trace below,
>
> [    1.904782] Call Trace:
> [    1.904782]  ? xas_load+0xd/0x80
> [    1.904782]  xa_load+0x47/0x80
> [    1.904782]  cma_ps_find+0x44/0x70
> [    1.904782]  rdma_bind_addr+0x782/0x8b0
> [    1.904782]  ? get_random_bytes+0x35/0x40
> [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> [    1.904782]  rtrs_srv_open+0x102/0x180
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  rnbd_srv_init_module+0x34/0x84
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  do_one_initcall+0x4a/0x200
> [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> [    1.904782]  ? rest_init+0xb0/0xb0
> [    1.904782]  kernel_init+0xe/0x100
> [    1.904782]  ret_from_fork+0x22/0x30
> [    1.904782] Modules linked in:
> [    1.904782] CR2: 0000000000000015
> [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
>
> All this happens cause the cm init is in the call chain of the module init,
> which is not a preferred practice.
>
> So remove the call to rdma_create_id() from the module init call chain.
> Instead register rtrs-srv as an ib client, which makes sure that the
> rdma_create_id() is called only when an ib device is added.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> ---
> Change in v3:
> 	Removed RDMA init error check while rtrs server open
> 	Removed -1 assignment for ib_dev_count on RDMA init error
> Change in v2:
>         Use only single variable to track number of IB devices and failure
>         Change according to kernel coding style
>
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 69 ++++++++++++++++++++++++--
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 +++
>  2 files changed, 72 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index a219bd1bdbc2..febc1478b96f 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -16,6 +16,7 @@
>  #include "rtrs-srv.h"
>  #include "rtrs-log.h"
>  #include <rdma/ib_cm.h>
> +#include <rdma/ib_verbs.h>
>
>  MODULE_DESCRIPTION("RDMA Transport Server");
>  MODULE_LICENSE("GPL");
> @@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
>  static struct rtrs_rdma_dev_pd dev_pd;
>  static mempool_t *chunk_pool;
>  struct class *rtrs_dev_class;
> +static struct rtrs_srv_ib_ctx ib_ctx;
>
>  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
>  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> @@ -2033,6 +2035,63 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
>  	kfree(ctx);
>  }
>
> +static int rtrs_srv_add_one(struct ib_device *device)
> +{
> +	struct rtrs_srv_ctx *ctx;
> +	int ret;
> +
> +	if (ib_ctx.ib_dev_count)
> +		goto out;
> +
> +	/*
> +	 * Since our CM IDs are NOT bound to any ib device we will create them
> +	 * only once
> +	 */
> +	ctx = ib_ctx.srv_ctx;
> +	ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> +	if (ret) {
> +		/*
> +		 * We errored out here.
> +		 * According to the ib code, if we encounter an error here then the
> +		 * error code is ignored, and no more calls to our ops are made.
> +		 */
> +		pr_err("Failed to initialize RDMA connection");
> +		return ret;
> +	}
> +
> +out:
> +	/*
> +	 * Keep a track on the number of ib devices added
> +	 */
> +	ib_ctx.ib_dev_count++;
> +
> +	return 0;
> +}
> +
> +static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
> +{
> +	struct rtrs_srv_ctx *ctx;
> +
> +	ib_ctx.ib_dev_count--;
> +
> +	if (ib_ctx.ib_dev_count)
> +		return;
> +
> +	/*
> +	 * Since our CM IDs are NOT bound to any ib device we will remove them
> +	 * only once, when the last device is removed
> +	 */
> +	ctx = ib_ctx.srv_ctx;
> +	rdma_destroy_id(ctx->cm_id_ip);
> +	rdma_destroy_id(ctx->cm_id_ib);
> +}
> +
> +static struct ib_client rtrs_srv_client = {
> +	.name	= "rtrs_server",
> +	.add	= rtrs_srv_add_one,
> +	.remove	= rtrs_srv_remove_one
> +};
> +
>  /**
>   * rtrs_srv_open() - open RTRS server context
>   * @ops:		callback functions
> @@ -2051,7 +2110,12 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
>  	if (!ctx)
>  		return ERR_PTR(-ENOMEM);
>
> -	err = rtrs_srv_rdma_init(ctx, port);
> +	ib_ctx = (struct rtrs_srv_ib_ctx) {
> +		.srv_ctx	= ctx,
> +		.port		= port,
> +	};

It can be my personal issue, but I prefer to see this type of assignment in variable declarations only.
In the code, the better style will be to use direct assignment, e.g. "ib.ctx.port = port;"
It will simplify future refactoring.

Thanks

> +
> +	err = ib_register_client(&rtrs_srv_client);
>  	if (err) {
>  		free_srv_ctx(ctx);
>  		return ERR_PTR(err);
> @@ -2090,8 +2154,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
>   */
>  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
>  {
> -	rdma_destroy_id(ctx->cm_id_ip);
> -	rdma_destroy_id(ctx->cm_id_ib);
> +	ib_unregister_client(&rtrs_srv_client);
>  	close_ctx(ctx);
>  	free_srv_ctx(ctx);
>  }
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> index dc95b0932f0d..e8f7e99a9a6e 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> @@ -118,6 +118,12 @@ struct rtrs_srv_ctx {
>  	struct list_head srv_list;
>  };
>
> +struct rtrs_srv_ib_ctx {
> +	struct rtrs_srv_ctx	*srv_ctx;
> +	u16			port;
> +	int			ib_dev_count;
> +};
> +
>  extern struct class *rtrs_dev_class;
>
>  void close_sess(struct rtrs_srv_sess *sess);
> --
> 2.25.1
>
