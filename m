Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B460C526
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJYHaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 03:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJYHae (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 03:30:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD161DA59;
        Tue, 25 Oct 2022 00:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D807B81BAD;
        Tue, 25 Oct 2022 07:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A60C433C1;
        Tue, 25 Oct 2022 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666683030;
        bh=9PQO5EeSNbSv5VDIsFCn2UxUU606aDLQ0vkNteEU2j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdjwytLU9yA+Pi6WQOAdhZrkQQcDgTvtaupSFZ2aSBfsb01O1ZihfEhi/TNquJbOk
         Qk4s5kz/rkR+Dr2QS2i8YktcnOm060YUtKP5lXz7AxHvV6B48y6N8VOp32c+82G/bk
         R4GHGmUQilUS0ERNQHH5NZ3wTF7nHpcRD9jneP012afF2RuHZTwHBI81n+MuD3aQzL
         G1j+2E+XiTmMoQixLNKafcJJ+Vs4xNSrJBVZHZK3eQv3pfRCh7yd6iyq7xjGo7wE0f
         LRAadl1dNRQ2UYtUGZrm7mk0dMRnw8Trfln81pq2+MqgvANCiFhAaGDS6/q1vRNPtB
         v0xVwow2K8njQ==
Date:   Tue, 25 Oct 2022 10:30:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca, wsa+renesas@sang-engineering.com, avihaih@nvidia.com,
        raeds@nvidia.com, penguin-kernel@i-love.sakura.ne.jp,
        dledford@redhat.com, matanb@mellanox.com
Subject: Re: [PATCH] RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
Message-ID: <Y1eQkzttmSDcSIrU@unreal>
References: <20221025024146.109137-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025024146.109137-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 25, 2022 at 10:41:46AM +0800, Chen Zhongjin wrote:
> KASAN reported a null-ptr-deref error:
> 
> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
> CPU: 1 PID: 379
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> RIP: 0010:destroy_workqueue+0x2f/0x740
> RSP: 0018:ffff888016137df8 EFLAGS: 00000202
> ...
> Call Trace:
>  <TASK>
>  ib_core_cleanup+0xa/0xa1 [ib_core]
>  __do_sys_delete_module.constprop.0+0x34f/0x5b0
>  do_syscall_64+0x3a/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fa1a0d221b7
> ...
>  </TASK>
> 
> It is because the fail of roce_gid_mgmt_init() is ignored:
> 
> ib_core_init()
>   roce_gid_mgmt_init()
>     gid_cache_wq = alloc_ordered_workqueue # fail
> ...
> ib_core_cleanup()
>   roce_gid_mgmt_cleanup()
>     destroy_workqueue(gid_cache_wq)
>     # destroy an unallocated wq
> 
> Fix this by catching the fail of roce_gid_mgmt_init() in ib_core_init().
> 
> Fixes: 03db3a2d81e6 ("IB/core: Add RoCE GID table management")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  drivers/infiniband/core/device.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index ae60c73babcc..b45431e6817b 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2815,10 +2815,18 @@ static int __init ib_core_init(void)
>  
>  	nldev_init();
>  	rdma_nl_register(RDMA_NL_LS, ibnl_ls_cb_table);
> -	roce_gid_mgmt_init();
> +	ret = roce_gid_mgmt_init();
> +	if (ret) {
> +		pr_warn("Couldn't init RoCE GID management\n");
> +		goto err_parent;
> +	}
>  
>  	return 0;
>  
> +err_parent:
> +	nldev_exit();
> +	rdma_nl_unregister(RDMA_NL_LS);
> +	unregister_pernet_device(&rdma_dev_net_ops);

I fixed release flow and applied to -rc.

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b45431e6817b..b69e2c4e4d2a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2824,8 +2824,8 @@ static int __init ib_core_init(void)
        return 0;

 err_parent:
-       nldev_exit();
        rdma_nl_unregister(RDMA_NL_LS);
+       nldev_exit();
        unregister_pernet_device(&rdma_dev_net_ops);
 err_compat:
        unregister_blocking_lsm_notifier(&ibdev_lsm_nb);

Thanks


>  err_compat:
>  	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
>  err_sa:
> -- 
> 2.17.1
> 
