Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFED94FA1F5
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 05:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiDID3U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiDID3T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 23:29:19 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285FB1F95DF
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 20:27:12 -0700 (PDT)
Message-ID: <e677d777-8646-81d4-3299-e4e390587074@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649474830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wc5RJJ8AgIdBIoK6QMYzWn8gJVUgYyHmdpO6TdksIRA=;
        b=owWDWqhQQjQZtpJlvg1xTKTFA5uWUuykd3QFuW51kopoBIW95JyQIA2WoTuUiDX3vnpZpG
        uC88PhEoA/Z8FGL8U7j7Y9/7qHw7FmL5ePO4ui/tdJhF/t77mG5AYQYk/g6bNnsBPG1z/V
        91dZCeahHnDAeabOF/5ZXPCBQxMRJ7I=
Date:   Sat, 9 Apr 2022 11:27:04 +0800
MIME-Version: 1.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
To:     Yi Zhang <yi.zhang@redhat.com>, Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Robert Pearson <rpearsonhpe@gmail.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <ebcabe3b-56f9-533b-e975-3a9945c3ee99@linux.dev>
 <CAHj4cs-XYMAtoLpVTAKL601SBkz+-8ctcP49MA7T5X-PjoqdMg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <CAHj4cs-XYMAtoLpVTAKL601SBkz+-8ctcP49MA7T5X-PjoqdMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/4/8 17:10, Yi Zhang 写道:
> On Fri, Apr 8, 2022 at 1:09 PM Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>>
>>
>> Hi, all
>>
>> In 5.18-rc1, this commit "[PATCH for-next] RDMA/rxe: Revert changes from
>> irqsave to bh locks" does not exist.
>>
>> The link is
>> https://patchwork.kernel.org/project/linux-rdma/patch/20220215194448.44369-1-rpearsonhpe@gmail.com/
>>
> Hi Yanjun
> I tried rdma/for-next which already included this commit, and this
> issue still can be reproduced.

Hi, Yi

I delved into the source code. And I found the followings:

xa_lock first is acquired in this:

[  296.655588] {SOFTIRQ-ON-W} state was registered at:

[  296.660467]   lock_acquire+0x1d2/0x5a0
[  296.664221]   _raw_spin_lock+0x33/0x80
[  296.667972]   __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
[  296.673112]   __ib_alloc_pd+0xf9/0x550 [ib_core]
[  296.677758]   ib_mad_init_device+0x2d9/0xd20 [ib_core]
[  296.682924]   add_client_context+0x2fa/0x450 [ib_core]
[  296.688088]   enable_device_and_get+0x1b7/0x350 [ib_core]
[  296.693503]   ib_register_device+0x757/0xaf0 [ib_core]
[  296.698660]   rxe_register_device+0x2eb/0x390 [rdma_rxe]
[  296.703973]   rxe_net_add+0x83/0xc0 [rdma_rxe]
[  296.708421]   rxe_newlink+0x76/0x90 [rdma_rxe]
[  296.712865]   nldev_newlink+0x245/0x3e0 [ib_core]
[  296.717597]   rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
[  296.722492]   rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
[  296.727042]   netlink_unicast+0x43b/0x640
[  296.731056]   netlink_sendmsg+0x7eb/0xc40
[  296.735069]   sock_sendmsg+0xe0/0x110
[  296.738734]   __sys_sendto+0x1d7/0x2b0
[  296.742486]   __x64_sys_sendto+0xdd/0x1b0
[  296.746500]   do_syscall_64+0x37/0x80
[  296.750166]   entry_SYSCALL_64_after_hwframe+0x44/0xae
[  296.755304] irq event stamp: 25305
[  296.758710] hardirqs last  enabled at (25304): [<ffffffff89815de8>]
__local_bh_enable_ip+0xa8/0x110
[  296.767750] hardirqs last disabled at (25305): [<ffffffff8b970219>]
_raw_spin_lock_irqsave+0x69/0x90
[  296.776875] softirqs last  enabled at (25294): [<ffffffff8bc0064a>]
__do_softirq+0x64a/0xa4c
[  296.785307] softirqs last disabled at (25299): [<ffffffff898159f2>]
run_ksoftirqd+0x32/0x60
[  296.793654]

xa_lock then is acquired in this:
{IN-SOFTIRQ-W}:

stack backtrace:
[  296.835686] CPU: 30 PID: 188 Comm: ksoftirqd/30 Tainted: G S
I       5.18.0-rc1 #1
[  296.843859] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.11.2 004/21/2021
[  296.851509] Call Trace:
[  296.853964]  <TASK>
[  296.856070]  dump_stack_lvl+0x44/0x57
[  296.859734]  mark_lock.part.52.cold.79+0x3c/0x46
[  296.913364]  __lock_acquire+0x1565/0x34a0
[  296.926529]  lock_acquire+0x1d2/0x5a0
[  296.948247]  _raw_spin_lock_irqsave+0x42/0x90
[  296.957830]  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
[  296.972554]  rxe_get_av+0x168/0x2a0 [rdma_rxe]
[  296.980761]  rxe_requester+0x75b/0x4a90 [rdma_rxe]
[  297.023764]  rxe_do_task+0x134/0x230 [rdma_rxe]
[  297.028297]  tasklet_action_common.isra.12+0x1f7/0x2d0
[  297.033435]  __do_softirq+0x1ea/0xa4c
[  297.040941]  run_ksoftirqd+0x32/0x60
[  297.044518]  smpboot_thread_fn+0x503/0x860
[  297.052110]  kthread+0x29b/0x340
[  297.060137]  ret_from_fork+0x1f/0x30
[  297.063720]  </TASK>

 From the above, in the function __rxe_add_to_pool, xa_lock is acquired.
Then the function __rxe_add_to_pool is interrupted by softirq. The 
function rxe_pool_get_index will also acquire xa_lock.

Finally, the dead lock appears.

[  296.806097]        CPU0
[  296.808550]        ----
[  296.811003]   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
[  296.814583]   <Interrupt>
[  296.817209]     lock(&xa->xa_lock#15); <---- rxe_pool_get_index
[  296.820961]
                 *** DEADLOCK ***

I disable softirq in the function __rxe_add_to_pool. Please make tests 
with the following.
Please let me know the test results. Thanks a lot.

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c 
b/drivers/infiniband/sw/rxe/rxe_pool.c
index 87066d04ed18..9a8f83787d61 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -166,10 +166,14 @@ int __rxe_add_to_pool(struct rxe_pool *pool, 
struct rxe_pool_elem *elem)
         elem->obj = (u8 *)elem - pool->elem_offset;
         kref_init(&elem->ref_cnt);

+       local_bh_disable();
         err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
                               &pool->next, GFP_KERNEL);
-       if (err)
+       if (err) {
+               local_bh_enable();
                 goto err_cnt;
+       }
+       local_bh_enable();

         return 0;

Zhu Yanjun

> 
>> Please apply this commit and make tests again.
>> Please let me know the test result.
>>
>> Best Regards,
>>
>> Zhu Yanjun
>>
>> 在 2022/4/6 11:08, Yi Zhang 写道:
>>> Hello
>>>
>>> Below WARNING triggered during blktests srp/ tests with 5.18.0-rc1
>>> debug kernel, pls help check it, let me know if you need any info for
>>> it, thanks.
>>>
>>> [  290.308984] run blktests srp/001 at 2022-04-05 23:01:02
>>> [  290.999913] null_blk: module loaded
>>> [  291.260285] device-mapper: multipath service-time: version 0.3.0 loaded
>>> [  291.262990] device-mapper: table: 253:3: multipath: error getting
>>> device (-EBUSY)
>>> [  291.270535] device-mapper: ioctl: error adding target to table
>>> [  291.362284] rdma_rxe: loaded
>>> [  291.428444] infiniband eno1_rxe: set active
>>> [  291.428462] infiniband eno1_rxe: added eno1
>>> [  291.467142] eno2 speed is unknown, defaulting to 1000
>>> [  291.472327] eno2 speed is unknown, defaulting to 1000
>>> [  291.477680] eno2 speed is unknown, defaulting to 1000
>>> [  291.516123] infiniband eno2_rxe: set down
>>> [  291.516130] infiniband eno2_rxe: added eno2
>>> [  291.516649] eno2 speed is unknown, defaulting to 1000
>>> [  291.542551] eno2 speed is unknown, defaulting to 1000
>>> [  291.558995] eno3 speed is unknown, defaulting to 1000
>>> [  291.564127] eno3 speed is unknown, defaulting to 1000
>>> [  291.569462] eno3 speed is unknown, defaulting to 1000
>>> [  291.607876] infiniband eno3_rxe: set down
>>> [  291.607883] infiniband eno3_rxe: added eno3
>>> [  291.608430] eno3 speed is unknown, defaulting to 1000
>>> [  291.632891] eno2 speed is unknown, defaulting to 1000
>>> [  291.638180] eno3 speed is unknown, defaulting to 1000
>>> [  291.655089] eno4 speed is unknown, defaulting to 1000
>>> [  291.660213] eno4 speed is unknown, defaulting to 1000
>>> [  291.665569] eno4 speed is unknown, defaulting to 1000
>>> [  291.703975] infiniband eno4_rxe: set down
>>> [  291.703982] infiniband eno4_rxe: added eno4
>>> [  291.704642] eno4 speed is unknown, defaulting to 1000
>>> [  291.822650] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
>>> ffffc90001801000
>>> [  291.825441] scsi_debug:sdebug_driver_probe: scsi_debug: trim
>>> poll_queues to 0. poll_q/nr_hw = (0/1)
>>> [  291.834505] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
>>> [  291.834513] scsi host15: scsi_debug: version 0191 [20210520]
>>>                    dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
>>> [  291.837267] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
>>>      0191 PQ: 0 ANSI: 7
>>> [  291.839793] sd 15:0:0:0: Power-on or device reset occurred
>>> [  291.840110] sd 15:0:0:0: Attached scsi generic sg1 type 0
>>> [  291.845521] sd 15:0:0:0: [sdb] Enabling DIF Type 3 protection
>>> [  291.845878] sd 15:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
>>> MB/32.0 MiB)
>>> [  291.845939] sd 15:0:0:0: [sdb] Write Protect is off
>>> [  291.845954] sd 15:0:0:0: [sdb] Mode Sense: 73 00 10 08
>>> [  291.846049] sd 15:0:0:0: [sdb] Write cache: enabled, read cache:
>>> enabled, supports DPO and FUA
>>> [  291.846254] sd 15:0:0:0: [sdb] Optimal transfer size 524288 bytes
>>> [  291.859380] sd 15:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC protection
>>> [  291.859398] sd 15:0:0:0: [sdb] DIF application tag size 6
>>> [  291.860158] sd 15:0:0:0: [sdb] Attached SCSI disk
>>> [  292.666414] eno2 speed is unknown, defaulting to 1000
>>> [  292.771984] eno3 speed is unknown, defaulting to 1000
>>> [  292.876762] eno4 speed is unknown, defaulting to 1000
>>> [  293.033291] Rounding down aligned max_sectors from 4294967295 to 4294967288
>>> [  293.102261] ib_srpt:srpt_add_one: ib_srpt device = 0000000047a39f45
>>> [  293.102363] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno1_rxe):
>>> use_srq = 0; ret = 0
>>> [  293.102369] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>> [  293.102680] ib_srpt:srpt_add_one: ib_srpt added eno1_rxe.
>>> [  293.102692] ib_srpt:srpt_add_one: ib_srpt device = 00000000b2dfcbe9
>>> [  293.102725] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno2_rxe):
>>> use_srq = 0; ret = 0
>>> [  293.102730] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>> [  293.102741] eno2 speed is unknown, defaulting to 1000
>>> [  293.107884] ib_srpt:srpt_add_one: ib_srpt added eno2_rxe.
>>> [  293.107893] ib_srpt:srpt_add_one: ib_srpt device = 0000000061e03247
>>> [  293.107922] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno3_rxe):
>>> use_srq = 0; ret = 0
>>> [  293.107926] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>> [  293.107936] eno3 speed is unknown, defaulting to 1000
>>> [  293.113038] ib_srpt:srpt_add_one: ib_srpt added eno3_rxe.
>>> [  293.113046] ib_srpt:srpt_add_one: ib_srpt device = 00000000c0e3d43d
>>> [  293.113081] ib_srpt:srpt_use_srq: ib_srpt srpt_use_srq(eno4_rxe):
>>> use_srq = 0; ret = 0
>>> [  293.113085] ib_srpt:srpt_add_one: ib_srpt Target login info:
>>> id_ext=f2d4e2fffee6e1e0,ioc_guid=f2d4e2fffee6e1e0,pkey=ffff,service_id=f2d4e2fffee6e1e0
>>> [  293.113096] eno4 speed is unknown, defaulting to 1000
>>> [  293.118198] ib_srpt:srpt_add_one: ib_srpt added eno4_rxe.
>>> [  293.584001] Rounding down aligned max_sectors from 255 to 248
>>> [  293.654030] Rounding down aligned max_sectors from 255 to 248
>>> [  293.724363] Rounding down aligned max_sectors from 4294967295 to 4294967288
>>> [  296.450772] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>> [  296.450783] ib_srp:srp_add_one: ib_srp: eno1_rxe: mr_page_shift =
>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>> mr_max_size = 0x200000
>>> [  296.451222] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>> [  296.451229] ib_srp:srp_add_one: ib_srp: eno2_rxe: mr_page_shift =
>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>> mr_max_size = 0x200000
>>> [  296.451517] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>> [  296.451523] ib_srp:srp_add_one: ib_srp: eno3_rxe: mr_page_shift =
>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>> mr_max_size = 0x200000
>>> [  296.451769] ib_srp:srp_add_one: ib_srp: srp_add_one:
>>> 18446744073709551615 / 4096 = 4503599627370495 <> 512
>>> [  296.451774] ib_srp:srp_add_one: ib_srp: eno4_rxe: mr_page_shift =
>>> 12, device->max_mr_size = 0xffffffffffffffff,
>>> device->max_fast_reg_page_list_len = 512, max_pages_per_mr = 512,
>>> mr_max_size = 0x200000
>>> [  296.605925] ib_srp:srp_parse_in: ib_srp: 10.16.221.116 -> 10.16.221.116:0
>>> [  296.605956] ib_srp:srp_parse_in: ib_srp: 10.16.221.116:5555 ->
>>> 10.16.221.116:5555
>>> [  296.606014] ib_srp:add_target_store: ib_srp: max_sectors = 1024;
>>> max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr =
>>> 4096; mr_per_cmd = 2
>>> [  296.606021] ib_srp:srp_max_it_iu_len: ib_srp: max_iu_len = 8260
>>>
>>> [  296.616660] ================================
>>> [  296.620931] WARNING: inconsistent lock state
>>> [  296.625207] 5.18.0-rc1 #1 Tainted: G S        I
>>> [  296.630259] --------------------------------
>>> [  296.634531] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>>> [  296.640535] ksoftirqd/30/188 [HC0[0]:SC1[1]:HE0:SE0] takes:
>>> [  296.646106] ffff888151491468 (&xa->xa_lock#15){+.?.}-{2:2}, at:
>>> rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>> [  296.655588] {SOFTIRQ-ON-W} state was registered at:
>>> [  296.660467]   lock_acquire+0x1d2/0x5a0
>>> [  296.664221]   _raw_spin_lock+0x33/0x80
>>> [  296.667972]   __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>>> [  296.673112]   __ib_alloc_pd+0xf9/0x550 [ib_core]
>>> [  296.677758]   ib_mad_init_device+0x2d9/0xd20 [ib_core]
>>> [  296.682924]   add_client_context+0x2fa/0x450 [ib_core]
>>> [  296.688088]   enable_device_and_get+0x1b7/0x350 [ib_core]
>>> [  296.693503]   ib_register_device+0x757/0xaf0 [ib_core]
>>> [  296.698660]   rxe_register_device+0x2eb/0x390 [rdma_rxe]
>>> [  296.703973]   rxe_net_add+0x83/0xc0 [rdma_rxe]
>>> [  296.708421]   rxe_newlink+0x76/0x90 [rdma_rxe]
>>> [  296.712865]   nldev_newlink+0x245/0x3e0 [ib_core]
>>> [  296.717597]   rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
>>> [  296.722492]   rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
>>> [  296.727042]   netlink_unicast+0x43b/0x640
>>> [  296.731056]   netlink_sendmsg+0x7eb/0xc40
>>> [  296.735069]   sock_sendmsg+0xe0/0x110
>>> [  296.738734]   __sys_sendto+0x1d7/0x2b0
>>> [  296.742486]   __x64_sys_sendto+0xdd/0x1b0
>>> [  296.746500]   do_syscall_64+0x37/0x80
>>> [  296.750166]   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [  296.755304] irq event stamp: 25305
>>> [  296.758710] hardirqs last  enabled at (25304): [<ffffffff89815de8>]
>>> __local_bh_enable_ip+0xa8/0x110
>>> [  296.767750] hardirqs last disabled at (25305): [<ffffffff8b970219>]
>>> _raw_spin_lock_irqsave+0x69/0x90
>>> [  296.776875] softirqs last  enabled at (25294): [<ffffffff8bc0064a>]
>>> __do_softirq+0x64a/0xa4c
>>> [  296.785307] softirqs last disabled at (25299): [<ffffffff898159f2>]
>>> run_ksoftirqd+0x32/0x60
>>> [  296.793654]
>>>                  other info that might help us debug this:
>>> [  296.800177]  Possible unsafe locking scenario:
>>>
>>> [  296.806097]        CPU0
>>> [  296.808550]        ----
>>> [  296.811003]   lock(&xa->xa_lock#15);
>>> [  296.814583]   <Interrupt>
>>> [  296.817209]     lock(&xa->xa_lock#15);
>>> [  296.820961]
>>>                   *** DEADLOCK ***
>>>
>>> [  296.826880] no locks held by ksoftirqd/30/188.
>>> [  296.831326]
>>>                  stack backtrace:
>>> [  296.835686] CPU: 30 PID: 188 Comm: ksoftirqd/30 Tainted: G S
>>> I       5.18.0-rc1 #1
>>> [  296.843859] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
>>> 2.11.2 004/21/2021
>>> [  296.851509] Call Trace:
>>> [  296.853964]  <TASK>
>>> [  296.856070]  dump_stack_lvl+0x44/0x57
>>> [  296.859734]  mark_lock.part.52.cold.79+0x3c/0x46
>>> [  296.864355]  ? lock_chain_count+0x20/0x20
>>> [  296.868367]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>> [  296.872994]  ? orc_find.part.4+0x310/0x310
>>> [  296.877096]  ? __module_text_address.part.55+0x13/0x140
>>> [  296.882326]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>> [  296.886947]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>> [  296.891566]  ? is_module_text_address+0x41/0x60
>>> [  296.896098]  ? rxe_do_task+0x26/0x230 [rdma_rxe]
>>> [  296.900718]  ? kernel_text_address+0x13/0xd0
>>> [  296.904991]  ? create_prof_cpu_mask+0x20/0x20
>>> [  296.909351]  ? sched_clock_cpu+0x15/0x200
>>> [  296.913364]  __lock_acquire+0x1565/0x34a0
>>> [  296.917377]  ? rcu_read_lock_sched_held+0xaf/0xe0
>>> [  296.922079]  ? rcu_read_lock_bh_held+0xc0/0xc0
>>> [  296.926529]  lock_acquire+0x1d2/0x5a0
>>> [  296.930193]  ? rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>> [  296.935429]  ? rcu_read_unlock+0x50/0x50
>>> [  296.939353]  ? mark_lock.part.52+0xa3d/0x1c00
>>> [  296.943712]  ? _raw_spin_lock_irqsave+0x69/0x90
>>> [  296.948247]  _raw_spin_lock_irqsave+0x42/0x90
>>> [  296.952603]  ? rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>> [  296.957830]  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>> [  296.962882]  ? __rxe_add_to_pool+0x230/0x230 [rdma_rxe]
>>> [  296.968108]  ? __rxe_get+0xc1/0x140 [rdma_rxe]
>>> [  296.972554]  rxe_get_av+0x168/0x2a0 [rdma_rxe]
>>> [  296.977007]  ? lockdep_lock+0xcb/0x1c0
>>> [  296.980761]  rxe_requester+0x75b/0x4a90 [rdma_rxe]
>>> [  296.985557]  ? rxe_do_task+0xe2/0x230 [rdma_rxe]
>>> [  296.990183]  ? sched_clock_cpu+0x15/0x200
>>> [  296.994193]  ? find_held_lock+0x3a/0x1c0
>>> [  296.998119]  ? rnr_nak_timer+0x80/0x80 [rdma_rxe]
>>> [  297.002826]  ? lock_release+0x42f/0xc90
>>> [  297.006664]  ? lock_downgrade+0x6b0/0x6b0
>>> [  297.010676]  ? lock_acquired+0x262/0xb10
>>> [  297.014605]  ? __local_bh_enable_ip+0xa8/0x110
>>> [  297.019051]  ? rnr_nak_timer+0x80/0x80 [rdma_rxe]
>>> [  297.023764]  rxe_do_task+0x134/0x230 [rdma_rxe]
>>> [  297.028297]  tasklet_action_common.isra.12+0x1f7/0x2d0
>>> [  297.033435]  __do_softirq+0x1ea/0xa4c
>>> [  297.037100]  ? tasklet_kill+0x1c0/0x1c0
>>> [  297.040941]  run_ksoftirqd+0x32/0x60
>>> [  297.044518]  smpboot_thread_fn+0x503/0x860
>>> [  297.048618]  ? sort_range+0x20/0x20
>>> [  297.052110]  kthread+0x29b/0x340
>>> [  297.055342]  ? kthread_complete_and_exit+0x20/0x20
>>> [  297.060137]  ret_from_fork+0x1f/0x30
>>> [  297.063720]  </TASK>
>>>
>>
> 
> 

