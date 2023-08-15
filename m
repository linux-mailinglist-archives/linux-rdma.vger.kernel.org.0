Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF777C745
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjHOF4H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 01:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjHOFzr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 01:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57993
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 22:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A57E561376
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 05:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF4CC433C7;
        Tue, 15 Aug 2023 05:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692078944;
        bh=NbGtzLAgTQNJAHNBtuX5Wb0Bxfe0FxRGiig5wSIelV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3VbwgL/FrgGLwdE7oSo5P6UisrSyVOZTOlJmkZinSfRf7a61Zj0Qm7QGs67pyshi
         SXdEAvVRChLhwb+h6h6R/XLLSRgJG/TC3N8/RJ38lZzGkaEGP5PHyIpiwJ4EN0wTYo
         wPuDrcvqq855GbbgFSwdWSTLa4LiXOF0OnxxmimQwcVjuyEhCfAE8nWr3T5uxdcDy5
         Ajh1cIaPIOmg5z9smDxjqFxUELJ+HOZJXeNvrD7mduUhiqRDsocH96tG/9ipNaJKGK
         IEXjjh0Cuzo7Y+053OoiVu7EtnQ5RWJFH6rXp3RWy9JjoRnWIWOsvdV14l7eXQi4Id
         ysYmxNKWPFV2w==
Date:   Tue, 15 Aug 2023 08:55:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     saeedm@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        tariqt@nvidia.com, lkayal@nvidia.com, msanalla@nvidia.com,
        kliteyn@nvidia.com, valex@nvidia.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Remove unused declaration
Message-ID: <20230815055540.GD22185@unreal>
References: <20230814140804.47660-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814140804.47660-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 10:08:04PM +0800, Yue Haibing wrote:
> Commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> declared mlx5e_ipsec_inverse_table_init() but never implemented it.
> Commit f52f2faee581 ("net/mlx5e: Introduce flow steering API")
> declared mlx5e_fs_set_tc() but never implemented it.
> Commit f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")
> declared mlx5_eq_comp_cpumask() but never implemented it.
> Commit cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")
> removed mlx5_lag_update() but not its declaration.
> Commit 35ba005d820b ("net/mlx5: DR, Set flex parser for TNL_MPLS dynamically")
> removed mlx5dr_ste_build_tnl_mpls() but not its declaration.
> 
> Commit e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> declared but never implemented mlx5_alloc_cmd_mailbox_chain() and mlx5_free_cmd_mailbox_chain().
> Commit 0cf53c124756 ("net/mlx5: FWPage, Use async events chain")
> removed mlx5_core_req_pages_handler() but not its declaration.
> Commit 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
> removed mlx5_query_odp_caps() but not its declaration.
> Commit f6a8a19bb11b ("RDMA/netdev: Hoist alloc_netdev_mqs out of the driver")
> removed mlx5_rdma_netdev_alloc() but not its declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |  1 -
>  .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |  1 -
>  drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |  1 -
>  .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  2 --
>  .../mellanox/mlx5/core/steering/dr_types.h         |  4 ----
>  include/linux/mlx5/driver.h                        | 14 --------------
>  6 files changed, 23 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
