Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63614488346
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jan 2022 12:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiAHLlq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jan 2022 06:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiAHLlq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jan 2022 06:41:46 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B303C061574
        for <linux-rdma@vger.kernel.org>; Sat,  8 Jan 2022 03:41:46 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n6A6N-0003XL-Qx; Sat, 08 Jan 2022 12:41:39 +0100
Message-ID: <4b335b77-6c68-1fae-bc5f-fd432a24164b@leemhuis.info>
Date:   Sat, 8 Jan 2022 12:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: RDMA/mlx5: Regression since v5.15-rc5: Kernel panic when called
 ib_dereg_mr #forregzbot
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Tony Lu <tonylu@linux.alibaba.com>, Alaa Hleihel <alaa@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Karsten Graul <kgraul@linux.ibm.com>,
        linux-rdma@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com>
 <dde1ef4a-8cc7-9258-8c3d-7188c5182720@leemhuis.info>
In-Reply-To: <dde1ef4a-8cc7-9258-8c3d-7188c5182720@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641642106;0aef83bf;
X-HE-SMSGID: 1n6A6N-0003XL-Qx
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Top-posting for once, to make this easy accessible to everyone.

This is now fixed, thx. A quick note to the patch author and the reviewers:

Next time when you fix a issue, please include a "Link:" tag to all
issue reports on the list and in bug trackers, as explained in
Documentation/process/submitting-patches.rst. To quote:

```
If related discussions or any other background information behind the
change can be found on the web, add 'Link:' tags pointing to it. In case
your patch fixes a bug, for example, add a tag with a URL referencing
the report in the mailing list archives or a bug tracker;
```

This concept is old, but the text was reworked recently to make this use
case for the Link: tag clearer. For details see:
https://git.kernel.org/linus/1f57bd42b77c

These link help others that want to look into the issue now or in a year
from now. There are also tools out there that rely on these links to
connect reports and fixes. Regzbot, the regression tracking bot is such
one such tool which I'm running (there might be others). And because the
link was missing, I now have to tell the bot manually about the fix. :-/

#regzbot fixed-by: 4163cb3d1980383220ad7043002b930995dcba33

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=master&id=4163cb3d1980383220ad7043002b930995dcba33

Ciao, Thorsten

On 22.12.21 08:37, Thorsten Leemhuis wrote:
> 
> [TLDR: I'm adding this regression to regzbot, the Linux kernel
> regression tracking bot; most text you find below is compiled from a few
> templates paragraphs some of you might have seen already.]
> 
> Hi, this is your Linux kernel regression tracker speaking.
> 
> Top-posting for once, to make this easy accessible to everyone.
> 
> Adding the regression mailing list to the list of recipients, as it
> should be in the loop for all regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> 
> To be sure this issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
> 
> #regzbot ^introduced f0ae4afe3d35
> #regzbot monitor
> https://lore.kernel.org/all/f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com/
> #regzbot ignore-activity
> 
> Reminder: when fixing the issue, please add a 'Link:' tag with the URL
> to the report (the parent of this mail) using the kernel.org redirector,
> as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
> then will automatically mark the regression as resolved once the fix
> lands in the appropriate tree. For more details about regzbot see footer.
> 
> Sending this to everyone that got the initial report, to make all aware
> of the tracking. I also hope that messages like this motivate people to
> directly get at least the regression mailing list and ideally even
> regzbot involved when dealing with regressions, as messages like this
> wouldn't be needed then.
> 
> Don't worry, I'll send further messages wrt to this regression just to
> the lists (with a tag in the subject so people can filter them away), as
> long as they are intended just for regzbot. With a bit of luck no such
> messages will be needed anyway.
> 
> Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat).
> 
> P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
> on my table. I can only look briefly into most of them. Unfortunately
> therefore I sometimes will get things wrong or miss something important.
> I hope that's not the case here; if you think it is, don't hesitate to
> tell me about it in a public reply. That's in everyone's interest, as
> what I wrote above might be misleading to everyone reading this; any
> suggestion I gave thus might sent someone reading this down the wrong
> rabbit hole, which none of us wants.
> 
> BTW, I have no personal interest in this issue, which is tracked using
> regzbot, my Linux kernel regression tracking bot
> (https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
> this mail to get things rolling again and hence don't need to be CC on
> all further activities wrt to this regression.
> 
> 
> On 21.12.21 09:04, Tony Lu wrote:
>> Hello,
>>
>> During developing and testing of SMC (net/smc), We found a problem,
>> when SMC released linkgroup or link, it called ib_dereg_mr to release
>> resources, then it panicked in mlx5_ib_dereg_mr. After investigation,
>> we found this panic was introduce by this commit:
>>
>>     f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
>>
>> After reverting this patch, SMC works fine. It looks like that
>> mlx5_ib_dereg_mr should check udata to determine to release umem,
>> because umem is union in struct, it is available when both kernel mr
>> and user mr. It is determined by the value of udata to distinguish
>> from ibv_reg_mr and ib_dereg_mr_user.
>>
>> int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>> {
>>         // udata is NULL when called from ib_dereg_mr
>>         if (mr->umem) { // check udata too
>>                 bool is_odp = is_odp_mr(mr);
>>
>>                 if (!is_odp)
>>                         atomic_sub(ib_umem_num_pages(mr->umem),
>>                                    &dev->mdev->priv.reg_pages);
>>                 ib_umem_release(mr->umem);
>>                 if (is_odp)
>>                         mlx5_ib_free_odp_mr(mr);
>>         }
>>
>> To be caution, this issue would cause local kernel panic, also,
>> it would cause remote kernel panic. SMC would setup passive close
>> progress when server's gone, the clients connected to this server would
>> go to release link, call ib_dreg_mr, and then panic.
>>
>> [   30.083527] smc: adding ib device mlx5_0 with port count 1
>> [   30.084281] smc:    ib device mlx5_0 port 1 has pnetid
>> [   30.085006] smc: adding ib device mlx5_1 with port count 1
>> [   30.085765] smc:    ib device mlx5_1 port 1 has pnetid
>> [   33.883596] smc: SMC-R lg 00010000 link added: id 00000101, peerid 00000101, ibdev mlx5_1, ibport 1
>> [   33.884894] smc: SMC-R lg 00010000 state changed: SINGLE, pnetid
>> [   33.894387] smc: SMC-R lg 00010000 link added: id 00000102, peerid 00000102, ibdev mlx5_0, ibport 1
>> [   33.895612] smc: SMC-R lg 00010000 state changed: SYMMETRIC, pnetid
>> [  696.351054] general protection fault, probably for non-canonical address 0x300610d01000000: 0000 [#1] PREEMPTI
>> [  696.352522] CPU: 0 PID: 976 Comm: kworker/0:0 Not tainted 5.16.0-rc5+ #41
>> [  696.353490] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.q4
>> [  696.355112] Workqueue: events smc_lgr_terminate_work [smc]
>> [  696.355914] RIP: 0010:__ib_umem_release+0x21/0xa0 [ib_uverbs]
>> [  696.356751] Code: ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 55 41 54 41 89 d4 55 53 48 89 f5 f6 46 28 01 76
>> [  696.359372] RSP: 0018:ffffc9000045bd30 EFLAGS: 00010246
>> [  696.360096] RAX: 0000000000000000 RBX: ffff8881108bd000 RCX: ffff888141a3a1a0
>> [  696.361110] RDX: 0000000000000001 RSI: ffff8881108bd000 RDI: 0300610d01000000
>> [  696.362113] RBP: ffff8881108bd000 R08: ffffc9000045bd60 R09: 0000000000000000
>> [  696.363136] R10: ffff888140052864 R11: 0000000000000008 R12: 0000000000000000
>> [  696.364145] R13: ffff888114310000 R14: 0000000000000000 R15: ffff8881426ac168
>> [  696.365153] FS:  0000000000000000(0000) GS:ffff88881fc00000(0000) knlGS:0000000000000000
>> [  696.366279] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  696.367101] CR2: 00007ffeb4ede000 CR3: 0000000147b06006 CR4: 0000000000770ef0
>> [  696.368121] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  696.369118] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  696.370112] PKRU: 55555554
>> [  696.370528] Call Trace:
>> [  696.370877]  <TASK>
>> [  696.371187]  ib_umem_release+0x2a/0x90 [ib_uverbs]
>> [  696.371889]  mlx5_ib_dereg_mr+0x19b/0x400 [mlx5_ib]
>> [  696.372612]  ib_dereg_mr_user+0x40/0xc0 [ib_core]
>> [  696.373293]  smcr_buf_unmap_link+0x3b/0xa0 [smc]
>> [  696.373962]  smcr_link_clear.part.33+0x6d/0x1e0 [smc]
>> [  696.374685]  smc_lgr_free+0x101/0x150 [smc]
>> [  696.375271]  process_one_work+0x1af/0x3c0
>> [  696.375865]  worker_thread+0x4c/0x390
>> [  696.376383]  ? preempt_count_add+0x56/0xa0
>> [  696.376961]  ? rescuer_thread+0x300/0x300
>> [  696.377543]  kthread+0x149/0x190
>> [  696.378003]  ? set_kthread_struct+0x40/0x40
>> [  696.378584]  ret_from_fork+0x1f/0x30
>> [  696.379763]  </TASK>
>> [  696.380723] Modules linked in: smc rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod ib_isers
>> [  696.406206] ---[ end trace 235afb848459d626 ]---
>> [  696.407707] RIP: 0010:__ib_umem_release+0x21/0xa0 [ib_uverbs]
>> [  696.409254] Code: ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 55 41 54 41 89 d4 55 53 48 89 f5 f6 46 28 01 76
>> [  696.413326] RSP: 0018:ffffc9000045bd30 EFLAGS: 00010246
>> [  696.414811] RAX: 0000000000000000 RBX: ffff8881108bd000 RCX: ffff888141a3a1a0
>> [  696.416544] RDX: 0000000000000001 RSI: ffff8881108bd000 RDI: 0300610d01000000
>> [  696.418257] RBP: ffff8881108bd000 R08: ffffc9000045bd60 R09: 0000000000000000
>> [  696.420076] R10: ffff888140052864 R11: 0000000000000008 R12: 0000000000000000
>> [  696.421776] R13: ffff888114310000 R14: 0000000000000000 R15: ffff8881426ac168
>> [  696.423456] FS:  0000000000000000(0000) GS:ffff88881fc00000(0000) knlGS:0000000000000000
>> [  696.425284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  696.426733] CR2: 00007fc639600000 CR3: 0000000147b06006 CR4: 0000000000770ef0
>> [  696.428347] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  696.429953] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  696.431575] PKRU: 55555554
>> [  696.432641] Kernel panic - not syncing: Fatal exception
>> [  696.434024] Kernel Offset: disabled
>> [  696.435126] Rebooting in 1 seconds..
>>
>> Thanks,
>> Tony Lu
> 
> ---
> Additional information about regzbot:
> 
> If you want to know more about regzbot, check out its web-interface, the
> getting start guide, and/or the references documentation:
> 
> https://linux-regtracking.leemhuis.info/regzbot/
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> 
> The last two documents will explain how you can interact with regzbot
> yourself if your want to.
> 
> Hint for reporters: when reporting a regression it's in your interest to
> tell #regzbot about it in the report, as that will ensure the regression
> gets on the radar of regzbot and the regression tracker. That's in your
> interest, as they will make sure the report won't fall through the
> cracks unnoticed.
> 
> Hint for developers: you normally don't need to care about regzbot once
> it's involved. Fix the issue as you normally would, just remember to
> include a 'Link:' tag to the report in the commit message, as explained
> in Documentation/process/submitting-patches.rst
> That aspect was recently was made more explicit in commit 1f57bd42b77c:
> https://git.kernel.org/linus/1f57bd42b77c
