Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96B25F88C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 12:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgIGKhe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 06:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgIGKhA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 06:37:00 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD9D20738;
        Mon,  7 Sep 2020 10:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599475019;
        bh=cYIBz17IwmRUaKJuzAYYXkFVFTfStwkrGVkXUbN4Qck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGgqy19GV0GQd3jtTURkEphSZUfH+7fcqg777RkOdkNmkvaWptyFPDZ8evCZPBk7t
         sa8wNuGiaWAsi4crq68XU79SfRxwhjpmjQS/p68UcYkCYcRdmbCGRsaEyqeZViYAal
         YBkS09yTZhwBu99OdUTaPfBkhK440DNi2RUzMPIQ=
Date:   Mon, 7 Sep 2020 13:36:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v4] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
Message-ID: <20200907103655.GC421756@unreal>
References: <20200907103106.104530-1-haris.iqbal@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907103106.104530-1-haris.iqbal@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 04:01:06PM +0530, Md Haris Iqbal wrote:
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
> Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
> Change in v4:
> 	Add mutex lock to prevent the add/remove of ib device from racing
> Change in v3:
> 	Remove RDMA init error check while rtrs server open
> 	Remove -1 assignment for ib_dev_count on RDMA init error
> Change in v2:
>         Use only single variable to track number of IB devices and failure
>         Change according to kernel coding style
>
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
>  2 files changed, 81 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index a219bd1bdbc2..72a9692d098a 100644
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
> @@ -2033,6 +2035,71 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
>  	kfree(ctx);
>  }
>
> +static int rtrs_srv_add_one(struct ib_device *device)
> +{
> +	struct rtrs_srv_ctx *ctx;
> +	int ret;
> +
> +	mutex_lock(&ib_ctx.ib_dev_mutex);
> +	ret = 0;

int ret = 0;

Other than that,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
