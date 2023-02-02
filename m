Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA81668732D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 02:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBBBrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 20:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjBBBrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 20:47:22 -0500
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 17:47:21 PST
Received: from out-237.mta1.migadu.com (out-237.mta1.migadu.com [95.215.58.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E65877526
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 17:47:20 -0800 (PST)
Message-ID: <6bcba397-f4f1-26df-f8cd-1dbebf111932@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675302075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElhoAreAYR1TbjbwQ16BwanBaQNglPJB2VKy5kIlALI=;
        b=IL+ConhL4Aq1PfgSd0YNZLsUVNPapOJ3rbBhwqsJyPz4heUDPwzsvUmMl5hXz4N1WdqeDp
        6AGvve0L0sFRyrInv32g0DLSYiWPlHT6qiApq2fpfSkU82jj7gCT/l+sXiSEL9pyZ5+262
        TR+t8CZLAfdk+HvNCltkGakB9uvIxrQ=
Date:   Thu, 2 Feb 2023 09:41:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
To:     Li Zhijian <lizhijian@fujitsu.com>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org
References: <1675261833-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <1675261833-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/1/23 22:30, Li Zhijian wrote:
> As the mention in commmit f7452a7e96c1 ("RDMA/rtrs-srv: fix memory leak by missing kobject free"),
> it's intended to remove the kobject_del for srv_path->kobj.
>
> A kernel panic will be triggered by following script
> -----------------------
> $ while true;
> do
>          echo "sessname=foo path=ip:<ip address> device_path=/dev/nvme0n1" > /sys/devices/virtual/rnbd-client/ctl/map_device
>          echo "normal" > /sys/block/rnbd0/rnbd/unmap_device
> done
> -----------------------
> The bisection pointed to commit 6af4609c18b3 ("RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files")
> at last.
>
>   rnbd_server L777: </dev/nvme0n1@foo>: Opened device 'nvme0n1'
>   general protection fault, probably for non-canonical address 0x765f766564753aea: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 PID: 3558 Comm: systemd-udevd Kdump: loaded Not tainted 6.1.0-rc3-roce-flush+ #51
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:kernfs_dop_revalidate+0x36/0x180
>   Code: 00 00 41 55 41 54 55 53 48 8b 47 68 48 89 fb 48 85 c0 0f 84 db 00 00 00 48 8b a8 60 04 00 00 48 8b 45 30 48 85 c0 48 0f 44 c5 <4c> 8b 60 78 49 81 c4 d8 00 00 00 4c 89 e7 e8 b7 78 7b 00 8b 05 3d
>   RSP: 0018:ffffaf1700b67c78 EFLAGS: 00010206
>   RAX: 765f766564753a72 RBX: ffff89e2830849c0 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff89e2830849c0
>   RBP: ffff89e280361bd0 R08: 0000000000000000 R09: 0000000000000001
>   R10: 0000000000000065 R11: 0000000000000000 R12: ffff89e2830849c0
>   R13: ffff89e283084888 R14: d0d0d0d0d0d0d0d0 R15: 2f2f2f2f2f2f2f2f
>   FS:  00007f13fbce7b40(0000) GS:ffff89e2bbc00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f93e055d340 CR3: 0000000104664002 CR4: 00000000001706f0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    lookup_fast+0x7b/0x100
>    walk_component+0x21/0x160
>    link_path_walk.part.0+0x24d/0x390
>    path_openat+0xad/0x9a0
>    do_filp_open+0xa9/0x150
>    ? lock_release+0x13c/0x2e0
>    ? _raw_spin_unlock+0x29/0x50
>    ? alloc_fd+0x124/0x1f0
>    do_sys_openat2+0x9b/0x160
>    __x64_sys_openat+0x54/0xa0
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   RIP: 0033:0x7f13fc9d701b
>   Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
>   RSP: 002b:00007ffddf242640 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
>   RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13fc9d701b
>   RDX: 0000000000080000 RSI: 00007ffddf2427c0 RDI: 00000000ffffff9c
>   RBP: 00007ffddf2427c0 R08: 00007f13fcc5b440 R09: 21b2131aa64b1ef2
>   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
>   R13: 00007ffddf2427c0 R14: 000055ed13be8db0 R15: 0000000000000000
>
> Fixes: 6af4609c18b3 ("RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index da8e205ce331..7fe905424109 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -313,7 +313,6 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
>   
>   	if (srv_path->kobj.state_in_sysfs) {
>   		sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
> -		kobject_del(&srv_path->kobj);
>   		kobject_put(&srv_path->kobj);
>   	}
>   

Thanks for the fix, it would be better to comment that why kobject_del can't
be called here.

Anyway, Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
