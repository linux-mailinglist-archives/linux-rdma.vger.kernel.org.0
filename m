Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFC1FCC46
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQL2Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 07:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFQL2Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 07:28:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74E620CC7;
        Wed, 17 Jun 2020 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592393295;
        bh=uMUZtfAmMrhJAMLssv8rVjKEsFdEfwWGE0KmDSJhEVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rt0fZJ7CclIEeHetVWCKpS0DwLEW/RxYBD8ARjNXAmK/ontpPUlNt0F9GIlorUJkg
         O71hjLOkOhNitALg+hnC5m7huitZIqvP0mOE2MxAeSGcOJQbnQTvQtu4zTFI6/SC45
         88mNuj8pVwECX3MZky9O7jsBaPVZYkDZDZCd41tk=
Date:   Wed, 17 Jun 2020 14:28:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     haris.iqbal@cloud.ionos.com
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        dledford@redhat.com, jgg@ziepe.ca,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
Message-ID: <20200617112811.GL2383158@unreal>
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 04:07:32PM +0530, haris.iqbal@cloud.ionos.com wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
>
> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
>
> The rnbd_server module's communication manager initialization depends on the
> registration of the "network namespace subsystem" of the RDMA CM agent module.
> As such, when the kernel is configured to load the rnbd_server and the RDMA
> cma module during initialization; and if the rnbd_server module is initialized
> before RDMA cma module, a null ptr dereference occurs during the RDMA bind
> operation.
> This patch delays the initialization of the rnbd_server module to the
> late_initcall level, since RDMA cma module uses module_init which puts it into
> the device_initcall level.
> ---
>  drivers/block/rnbd/rnbd-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 86e61523907b..213df05e5994 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
>  	rnbd_srv_destroy_sysfs_files();
>  }
>
> -module_init(rnbd_srv_init_module);
> +late_initcall(rnbd_srv_init_module);

I don't think that this is correct change. Somehow nvme-rdma works:
module_init(nvme_rdma_init_module);
-> nvme_rdma_init_module
 -> nvmf_register_transport(&nvme_rdma_transport);
  -> nvme_rdma_create_ctrl
   -> nvme_rdma_setup_ctrl
    -> nvme_rdma_configure_admin_queue
     -> nvme_rdma_alloc_queue
      -> rdma_create_id

>  module_exit(rnbd_srv_cleanup_module);
> --
> 2.25.1
>
