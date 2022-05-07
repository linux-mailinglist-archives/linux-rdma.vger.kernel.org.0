Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0FD51E2C1
	for <lists+linux-rdma@lfdr.de>; Sat,  7 May 2022 02:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351288AbiEGAd1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445055AbiEGAd0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 20:33:26 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F58A5DA55
        for <linux-rdma@vger.kernel.org>; Fri,  6 May 2022 17:29:40 -0700 (PDT)
Message-ID: <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651883378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADfXQ91crmRqMgfHB2DC/VM+i1X7E0v0GxKY++vnYs8=;
        b=gBR4qVpDiPQgXpebr89TxR6NbYTHqFjwWJdjddH/0TgWQ4znk/ZXCcc9UczbpRGXrZvhkz
        U9RCxXc4G1GJOPiX78+KZP0ZaMoz9RIfbpj9ST9inAsf2Mt8C0FIKWjDWcFEoTn+/m7Ox0
        gebdWL0V64T15u0yycBQJpG9qEcVlPg=
Date:   Sat, 7 May 2022 08:29:31 +0800
MIME-Version: 1.0
Subject: Re: Apparent regression in blktests since 5.18-rc1+
To:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/5/7 8:10, Bart Van Assche 写道:
> On 5/6/22 11:11, Bob Pearson wrote:
>> Before the most recent kernel update I had blktests running OK on 
>> rdma_rxe. Since we went on to 5.18.0-rc1+
>> I have been experiencing hangs. All of this is with the 'revert 
>> scsi-debug' patch which addressed the
>> 3 min timeout related to modprobe -r scsi-debug.
>>
>> You suggested checking with siw and I finally got around to this and 
>> the behavior is exactly the same.
>>
>> Specifically here is a run and dmesgs from that run:
>>
>> root@u-22:/home/bob/src/blktests# use_siw=1 ./check srp
>>
>> srp/001 (Create and remove LUNs)                             [passed]
>>
>>      runtime  3.388s  ...  3.501s
>>
>> srp/002 (File I/O on top of multipath concurrently with logout and 
>> login (mq))
>>
>>      runtime  54.689s  ...
>>    <HANGS HERE>
>>
>> I had to reboot to recover.
>>
>> The dmesg output is attached in a long file called out.
>> The output looks normal until line 1875 where it hangs at an "Already 
>> connected ..." message.
>> This is the same as the other hangs I have been seeing.
>> This is followed by a splat warning that a cpu has hung for 120 seconds.
>>
>> Since this is behaving the same for rxe and siw I am going to stop 
>> chasing this bug since
>> it is most likely outside of the the rxe driver.
> 
> Hi Bob,
> 
> What I see on my test setup is that the SRP tests from the blktests 
> suite pass with
> the SoftiWARP driver (kernel v5.18-rc5 / commit 4b97bac0756a):
> 
> # (cd blktests && use_siw=1 ./check -q srp)
> srp/001 (Create and remove LUNs)                             [passed]
>      runtime  5.781s  ...  5.464s
> srp/002 (File I/O on top of multipath concurrently with logout and login 
> (mq)) [passed]time  40.772s  ...
>      runtime  40.772s  ...  42.039s
> srp/003 (File I/O on top of multipath concurrently with logout and login 
> (sq)) [not run]
>      legacy device mapper support is missing
> srp/004 (File I/O on top of multipath concurrently with logout and login 
> (sq-on-srp/004 (File I/O on top of multipath concurrently with logout 
> and login (sq-on-mq)) [not run]
>      legacy device mapper support is missing
> srp/005 (Direct I/O with large transfer sizes, cmd_sg_entries=255 and 
> bs=4M) [passed]untime  17.870s  ...
>      runtime  17.870s  ...  17.016s
> srp/006 (Direct I/O with large transfer sizes, cmd_sg_entries=255 and 
> bs=8M) [passed]untime  16.369s  ...
>      runtime  16.369s  ...  17.315s
> srp/007 (Direct I/O with large transfer sizes, cmd_sg_entries=1 and 
> bs=4M) [passed] runtime  16.729s  ...
>      runtime  16.729s  ...  17.409s
> srp/008 (Direct I/O with large transfer sizes, cmd_sg_entries=1 and 
> bs=8M) [passed] runtime  16.823s  ...
>      runtime  16.823s  ...  16.453s
> srp/009 (Buffered I/O with large transfer sizes, cmd_sg_entries=255 and 
> bs=4M) [passed]time  17.304s  ...
>      runtime  17.304s  ...  17.838s
> srp/010 (Buffered I/O with large transfer sizes, cmd_sg_entries=255 and 
> bs=8M) [passed]time  17.191s  ...
>      runtime  17.191s  ...  17.117s
> srp/011 (Block I/O on top of multipath concurrently with logout and 
> login) [passed] runtime  40.835s  ...
>      runtime  40.835s  ...  38.728s
> srp/012 (dm-mpath on top of multiple I/O schedulers)         [passed]
>      runtime  23.703s  ...  24.763s
> srp/013 (Direct I/O using a discontiguous buffer)            [passed]
>      runtime  11.279s  ...  9.265s
> srp/014 (Run sg_reset while I/O is ongoing)                  [passed]
>      runtime  39.110s  ...  37.929s
> srp/015 (File I/O on top of multipath concurrently with logout and login 
> (mq) ussrp/015
>      (File I/O on top of multipath concurrently with logout and login 
> (mq) using the SoftiWARP (siw) driver) [passed]
>      runtime  40.027s  ...  40.220s
> 
> If I try to run the SRP test 002 with the soft-RoCE driver, the 
> following appears:
> 
> [  749.901966] ================================
> [  749.903638] WARNING: inconsistent lock state
> [  749.905376] 5.18.0-rc5-dbg+ #1 Not tainted
> [  749.907039] --------------------------------
> [  749.908699] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  749.910646] ksoftirqd/5/40 [HC0[0]:SC1[1]:HE0:SE0] takes:
> [  749.912499] ffff88818244d350 (&xa->xa_lock#14){+.?.}-{2:2}, at: 
> rxe_pool_get_index+0x73/0x170 [rdma_rxe]
> [  749.914691] {SOFTIRQ-ON-W} state was registered at:
> [  749.916648]   __lock_acquire+0x45b/0xce0
> [  749.918599]   lock_acquire+0x18a/0x450
> [  749.920480]   _raw_spin_lock+0x34/0x50
> [  749.922580]   __rxe_add_to_pool+0xcc/0x140 [rdma_rxe]
> [  749.924583]   rxe_alloc_pd+0x2d/0x40 [rdma_rxe]
> [  749.926394]   __ib_alloc_pd+0xa3/0x270 [ib_core]
> [  749.928579]   ib_mad_port_open+0x44a/0x790 [ib_core]
> [  749.930640]   ib_mad_init_device+0x8e/0x110 [ib_core]
> [  749.932495]   add_client_context+0x26a/0x330 [ib_core]
> [  749.934302]   enable_device_and_get+0x169/0x2b0 [ib_core]
> [  749.936217]   ib_register_device+0x26f/0x330 [ib_core]
> [  749.938020]   rxe_register_device+0x1b4/0x1d0 [rdma_rxe]
> [  749.939794]   rxe_add+0x8c/0xc0 [rdma_rxe]
> [  749.941552]   rxe_net_add+0x5b/0x90 [rdma_rxe]
> [  749.943356]   rxe_newlink+0x71/0x80 [rdma_rxe]
> [  749.945182]   nldev_newlink+0x21e/0x370 [ib_core]
> [  749.946917]   rdma_nl_rcv_msg+0x200/0x410 [ib_core]
> [  749.948657]   rdma_nl_rcv+0x140/0x220 [ib_core]
> [  749.950373]   netlink_unicast+0x307/0x460
> [  749.952063]   netlink_sendmsg+0x422/0x750
> [  749.953672]   __sys_sendto+0x1c2/0x250
> [  749.955281]   __x64_sys_sendto+0x7f/0x90
> [  749.956849]   do_syscall_64+0x35/0x80
> [  749.958353]   entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  749.959942] irq event stamp: 1411849
> [  749.961517] hardirqs last  enabled at (1411848): [<ffffffff810cdb28>] 
> __local_bh_enable_ip+0x88/0xf0
> [  749.963338] hardirqs last disabled at (1411849): [<ffffffff81ebf24d>] 
> _raw_spin_lock_irqsave+0x5d/0x60
> [  749.965214] softirqs last  enabled at (1411838): [<ffffffff82200467>] 
> __do_softirq+0x467/0x6e1
> [  749.967027] softirqs last disabled at (1411843): [<ffffffff810cd947>] 
> run_ksoftirqd+0x37/0x60
To this, Please use this patch series 
news://nntp.lore.kernel.org:119/20220422194416.983549-1-yanjun.zhu@linux.dev

Zhu Yanjun
> 
> I think the above is strong evidence that there is something wrong with the
> soft-RoCE driver.
> 
> Thanks,
> 
> Bart.

