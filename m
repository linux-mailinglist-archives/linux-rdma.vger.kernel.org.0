Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707897D569F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjJXPhB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjJXPhA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 11:37:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A2410A;
        Tue, 24 Oct 2023 08:36:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98C3C433C8;
        Tue, 24 Oct 2023 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698161818;
        bh=Qeb3y3GkI5YoTa2Z4FvcJRz+qDQD4OJYM3FJEUsXO34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghsfOXO4bRyLYAyP1GocDXRWIgd24qRSrh12T2JyWKv6ZvFXdSnB4luJTywl7TDQE
         Ld58FWuinLtJkVLpt1KSACDB7d59v366qOgpr80y52zb1xmMbNCSvdcrGAbAVFUFso
         Q/D4nWLjKTlLzMGbs5kN7J6K0k2u4ZqsVnWnnhfTW4ZRWew2bW2EiP6/6n3Qdy5E/6
         dlSRvqRU2TSyo40CoB3NQPBK8/MwJgNBKrJrm05zOuvpG+R6gwqlLq6o7mFt7RmI2c
         OFnHAqbj40J+/Wzfgve0orNf2xeH/5bLY9d1nfnuf8/NF5fmG7soid8TJ1D+UkKZs6
         ACKW1vI+4Y/sg==
Date:   Tue, 24 Oct 2023 18:36:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     jgg@ziepe.ca, sd@queasysnail.net, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tom.hromatka@oracle.com, harshit.m.mogalapalli@oracle.com
Subject: Re: [PATCH] mlx5: reset state to avoid attempted QP double free and
 UAF
Message-ID: <20231024153653.GC1939579@unreal>
References: <1698147005-5396-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698147005-5396-1-git-send-email-george.kennedy@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 24, 2023 at 06:30:05AM -0500, George Kennedy wrote:
> In the unlikely event that workqueue allocation fails and returns
> NULL in mlx5_mkey_cache_init(), reset the state to
> MLX5_UMR_STATE_UNINIT in mlx5_ib_stage_post_ib_reg_umr_init()
> after the call to mlx5r_umr_resource_cleanup(), which frees
> the QP. This will avoid attempted double free of the same QP
> when __mlx5_ib_add() does its cleanup.
> 
> Syzkaller reported a UAF in ib_destroy_qp_user
> 
> workqueue: Failed to create a rescuer kthread for wq "mkey_cache": -EINTR
> infiniband mlx5_0: mlx5_mkey_cache_init:981:(pid 1642):
>     failed to create work queue
> infiniband mlx5_0: mlx5_ib_stage_post_ib_reg_umr_init:4075:(pid 1642):
>     mr cache init failed -12
> ==================================================================
> BUG: KASAN: slab-use-after-free in ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
> Read of size 8 at addr ffff88810da310a8 by task repro_upstream/1642
> 
> Call Trace:
>  <TASK>
> kasan_report (mm/kasan/report.c:590)
> ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2073)
> mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4178)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
>  </TASK>
> 
> Allocated by task 1642:
> __kmalloc (./include/linux/kasan.h:198 mm/slab_common.c:1026
>     mm/slab_common.c:1039)
> create_qp (./include/linux/slab.h:603 ./include/linux/slab.h:720
>     ./include/rdma/ib_verbs.h:2795 drivers/infiniband/core/verbs.c:1209)
> ib_create_qp_kernel (drivers/infiniband/core/verbs.c:1347)
> mlx5r_umr_resource_init (drivers/infiniband/hw/mlx5/umr.c:164)
> mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4070)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
> 
> Freed by task 1642:
> __kmem_cache_free (mm/slub.c:1826 mm/slub.c:3809 mm/slub.c:3822)
> ib_destroy_qp_user (drivers/infiniband/core/verbs.c:2112)
> mlx5r_umr_resource_cleanup (drivers/infiniband/hw/mlx5/umr.c:198)
> mlx5_ib_stage_post_ib_reg_umr_init (drivers/infiniband/hw/mlx5/main.c:4076
>     drivers/infiniband/hw/mlx5/main.c:4065)
> __mlx5_ib_add (drivers/infiniband/hw/mlx5/main.c:4168)
> mlx5r_probe (drivers/infiniband/hw/mlx5/main.c:4402)
> ...
> 
> The buggy address belongs to the object at ffff88810da31000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 168 bytes inside of
>  freed 2048-byte region [ffff88810da31000, ffff88810da31800)
> 
> The buggy address belongs to the physical page:
> page:000000003b5e469d refcount:1 mapcount:0 mapping:0000000000000000
>     index:0x0 pfn:0x10da30
> head:000000003b5e469d order:3 entire_mapcount:0 nr_pages_mapped:0
>     pincount:0
> flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> page_type: 0xffffffff()
> raw: 0017ffffc0000840 ffff888100042f00 ffffea0004180800 dead000000000002
> raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88810da30f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88810da31000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88810da31080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                   ^
>  ffff88810da31100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88810da31180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> Disabling lock debugging due to kernel taint
> 
> Fixes: 04876c12c19e ("RDMA/mlx5: Move init and cleanup of UMR to umr.c")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks for the report,

I think that the following change will be better aligned to mlx5_ib code.
Can you please resend your patch?

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index ec7c45272764..b1f8914abf44 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4092,10 +4092,8 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 		return ret;
 
 	ret = mlx5_mkey_cache_init(dev);
-	if (ret) {
+	if (ret)
 		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
-		mlx5r_umr_resource_cleanup(dev);
-	}
 	return ret;
 }
 
