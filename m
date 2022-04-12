Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9A4FE3C5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiDLOas (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiDLOar (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 10:30:47 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941655E759
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:28:28 -0700 (PDT)
Message-ID: <a8be1cf3-62d1-43ea-a86c-70e82c6de702@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649773706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/dy5esKEk4NKiqA53s+G0zvC4EJS1bqnur7n8J63Oo=;
        b=mLENF36hraVawyK59JJYiVkA3VukspNWtDp5t/zQHAP3RG4wcjPYikWyJ9flXHqZ074oDf
        h3Kev8OySh1lHD2IrOVLB3TJPpxYhBh+7bxLh3yUCGIL2T8RERpM8O9piaW/VQXMjJ2Raz
        52byqrXQ0CzkRCtlkKwEXJAJYkT+Tl8=
Date:   Tue, 12 Apr 2022 22:28:16 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix a dead lock problem
To:     Jason Gunthorpe <jgg@ziepe.ca>, Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220411200018.1363127-1-yanjun.zhu@linux.dev>
 <20220411115019.GB64706@ziepe.ca>
 <feb4a977-c438-99dd-f31f-08d259c2f75f@linux.dev>
 <20220412135313.GD64706@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220412135313.GD64706@ziepe.ca>
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

在 2022/4/12 21:53, Jason Gunthorpe 写道:
> On Tue, Apr 12, 2022 at 09:43:28PM +0800, Yanjun Zhu wrote:
>> 在 2022/4/11 19:50, Jason Gunthorpe 写道:
>>> On Mon, Apr 11, 2022 at 04:00:18PM -0400, yanjun.zhu@linux.dev wrote:
>>>> @@ -138,8 +139,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>>>>    	elem->obj = obj;
>>>>    	kref_init(&elem->ref_cnt);
>>>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>>> -			      &pool->next, GFP_KERNEL);
>>>> +	xa_lock_irqsave(&pool->xa, flags);
>>>> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>>> +				&pool->next, GFP_ATOMIC);
>>>> +	xa_unlock_irqrestore(&pool->xa, flags);
>>>
>>> No to  using atomics, this needs to be either the _irq or _bh varient
>>
>> If I understand you correctly, you mean that we should use
>> xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh instead of
>> xa_unlock_irqrestore?
> 
> This is correct
> 
>> If so, xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh is used here,
>> the warning as below will appear. This means that __rxe_add_to_pool disables
>> softirq, but fpu_clone enables softirq.
> 
> I don't know what this is, you need to show the whole debug.

The followings are the warnings if xa_lock_bh + 
__xa_alloc(...,GFP_KERNEL) is used. The diff is as below.

If xa_lock_irqsave/irqrestore + __xa_alloc(...,GFP_ATOMIC) is used,
the waring does not appear.

It seems to be related with local_bh_enable/disable.

------------------------------the Diff---------------------------
"
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -138,8 +138,10 @@ void *rxe_alloc(struct rxe_pool *pool)
         elem->obj = obj;
         kref_init(&elem->ref_cnt);

-       err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-                             &pool->next, GFP_KERNEL);
+       xa_lock_bh(&pool->xa);
+       err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+                               &pool->next, GFP_KERNEL);
+       xa_unlock_bh(&pool->xa);
         if (err)
                 goto err_free;

@@ -166,8 +168,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct 
rxe_pool_elem *elem)
         elem->obj = (u8 *)elem - pool->elem_offset;
         kref_init(&elem->ref_cnt);

-       err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-                             &pool->next, GFP_KERNEL);
+       xa_lock_bh(&pool->xa);
+       err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+                               &pool->next, GFP_KERNEL);
+       xa_unlock_bh(&pool->xa);
         if (err)
                 goto err_cnt;
------------the diff-----------------------------------

--------------The warings--------------------------------------------

[   92.107272] ------------[ cut here ]------------
[   92.107283] WARNING: CPU: 68 PID: 4009 at kernel/softirq.c:363 
__local_bh_enable_ip+0x96/0xe0
[   92.107292] Modules linked in: rdma_rxe(OE) ip6_udp_tunnel udp_tunnel 
rds_rdma rds xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT 
nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc 
vfat fat rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod 
intel_rapl_msr intel_rapl_common target_core_mod ib_iser i10nm_edac 
libiscsi nfit scsi_transport_iscsi libnvdimm rdma_cm iw_cm ib_cm 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm 
iTCO_wdt irdma iTCO_vendor_support irqbypass crct10dif_pclmul 
crc32_pclmul i40e ghash_clmulni_intel rapl ib_uverbs intel_cstate 
isst_if_mbox_pci acpi_ipmi ib_core intel_uncore isst_if_mmio pcspkr 
wmi_bmof ipmi_si mei_me isst_if_common i2c_i801 mei ipmi_devintf 
i2c_smbus intel_pch_thermal ipmi_msghandler acpi_power_meter ip_tables 
xfs libcrc32c sd_mod t10_pi crc64_rocksoft crc64 sg mgag200 i2c_algo_bit 
drm_shmem_helper drm_kms_helper syscopyarea sysfillrect
[   92.107420]  sysimgblt fb_sys_fops ice ahci drm crc32c_intel libahci 
megaraid_sas libata tg3 wmi dm_mirror dm_region_hash dm_log dm_mod fuse
[   92.107445] CPU: 68 PID: 4009 Comm: rping Kdump: loaded Tainted: G S 
         OE     5.18.0-rc2rxe #15
[   92.107448] Hardware name: Dell Inc. PowerEdge R750/06V45N, BIOS 
1.2.4 05/28/2021
[   92.107450] RIP: 0010:__local_bh_enable_ip+0x96/0xe0
[   92.107454] Code: 00 e8 7e 17 03 00 e8 c9 8c 14 00 fb 65 8b 05 b1 54 
93 56 85 c0 75 05 0f 1f 44 00 00 5b 5d c3 65 8b 05 5a 5c 93 56 85 c0 75 
9d <0f> 0b eb 99 e8 51 89 14 00 eb 9a 48 89 ef e8 a7 7f 07 00 eb a3 0f
[   92.107457] RSP: 0018:ff6d2e1209887a70 EFLAGS: 00010046
[   92.107461] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 
000000000163f5c1
[   92.107464] RDX: ff303e1d677c6118 RSI: 0000000000000201 RDI: 
ffffffffc0866336
[   92.107466] RBP: ffffffffc0866336 R08: ff303e1d677c6190 R09: 
00000000fffffffe
[   92.107468] R10: 000000002c8f236f R11: 00000000bf76f5c6 R12: 
ff303e1e6166b368
[   92.107470] R13: ff303e1e6166a000 R14: ff6d2e1209887ae8 R15: 
ff303e1e8d815a68
[   92.107472] FS:  00007ff6d3bf4740(0000) GS:ff303e2c7f900000(0000) 
knlGS:0000000000000000
[   92.107475] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.107477] CR2: 00007ff6cd7fdfb8 CR3: 000000103ee6c004 CR4: 
0000000000771ee0
[   92.107479] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   92.107481] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   92.107483] PKRU: 55555554
[   92.107485] Call Trace:
[   92.107486]  <TASK>
[   92.107490]  __rxe_add_to_pool+0x76/0xa0 [rdma_rxe]
[   92.107500]  rxe_create_ah+0x59/0xe0 [rdma_rxe]
[   92.107511]  _rdma_create_ah+0x148/0x180 [ib_core]
[   92.107546]  rdma_create_ah+0xb7/0xf0 [ib_core]
[   92.107565]  cm_alloc_msg+0x5c/0x170 [ib_cm]
[   92.107577]  cm_alloc_priv_msg+0x1b/0x50 [ib_cm]
[   92.107584]  ib_send_cm_req+0x213/0x3f0 [ib_cm]
[   92.107613]  rdma_connect_locked+0x238/0x8e0 [rdma_cm]
[   92.107637]  rdma_connect+0x2b/0x40 [rdma_cm]
[   92.107646]  ucma_connect+0x128/0x1a0 [rdma_ucm]
[   92.107690]  ucma_write+0xaf/0x140 [rdma_ucm]
[   92.107698]  vfs_write+0xb8/0x370
[   92.107707]  ksys_write+0xbb/0xd0
[   92.107709]  ? syscall_trace_enter.isra.15+0x169/0x220
[   92.107719]  do_syscall_64+0x37/0x80
[   92.107725]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   92.107730] RIP: 0033:0x7ff6d3011847
[   92.107733] Code: c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89 fb 48 83 
ec 10 e8 1b fd ff ff 4c 89 e2 48 89 ee 89 df 41 89 c0 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 54 fd ff ff 48
[   92.107736] RSP: 002b:00007ffdd7b90af0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
[   92.107740] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007ff6d3011847
[   92.107742] RDX: 0000000000000128 RSI: 00007ffdd7b90b20 RDI: 
0000000000000003
[   92.107744] RBP: 00007ffdd7b90b20 R08: 0000000000000000 R09: 
00007ff6cd7fe700
[   92.107745] R10: 00000000ffffffff R11: 0000000000000293 R12: 
0000000000000128
[   92.107747] R13: 0000000000000011 R14: 0000000000000000 R15: 
000056360dabca18
[   92.107768]  </TASK>
[   92.107769] irq event stamp: 12947
[   92.107771] hardirqs last  enabled at (12945): [<ffffffffaa199135>] 
_raw_read_unlock_irqrestore+0x55/0x70
[   92.107775] hardirqs last disabled at (12946): [<ffffffffaa19895c>] 
_raw_spin_lock_irqsave+0x4c/0x50
[   92.107779] softirqs last  enabled at (12900): [<ffffffffa9630d26>] 
fpu_clone+0xf6/0x570
[   92.107783] softirqs last disabled at (12947): [<ffffffffc0866309>] 
__rxe_add_to_pool+0x49/0xa0 [rdma_rxe]
[   92.107788] ---[ end trace 0000000000000000 ]---
[   92.108017] ------------[ cut here ]------------
[   92.108024] raw_local_irq_restore() called with IRQs enabled
[   92.108029] WARNING: CPU: 68 PID: 4009 at 
kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20
[   92.108034] Modules linked in: rdma_rxe(OE) ip6_udp_tunnel udp_tunnel 
rds_rdma rds xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT 
nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc 
vfat fat rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod 
intel_rapl_msr intel_rapl_common target_core_mod ib_iser i10nm_edac 
libiscsi nfit scsi_transport_iscsi libnvdimm rdma_cm iw_cm ib_cm 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm 
iTCO_wdt irdma iTCO_vendor_support irqbypass crct10dif_pclmul 
crc32_pclmul i40e ghash_clmulni_intel rapl ib_uverbs intel_cstate 
isst_if_mbox_pci acpi_ipmi ib_core intel_uncore isst_if_mmio pcspkr 
wmi_bmof ipmi_si mei_me isst_if_common i2c_i801 mei ipmi_devintf 
i2c_smbus intel_pch_thermal ipmi_msghandler acpi_power_meter ip_tables 
xfs libcrc32c sd_mod t10_pi crc64_rocksoft crc64 sg mgag200 i2c_algo_bit 
drm_shmem_helper drm_kms_helper syscopyarea sysfillrect
[   92.108160]  sysimgblt fb_sys_fops ice ahci drm crc32c_intel libahci 
megaraid_sas libata tg3 wmi dm_mirror dm_region_hash dm_log dm_mod fuse
[   92.108184] CPU: 68 PID: 4009 Comm: rping Kdump: loaded Tainted: G S 
      W  OE     5.18.0-rc2rxe #15
[   92.108187] Hardware name: Dell Inc. PowerEdge R750/06V45N, BIOS 
1.2.4 05/28/2021
[   92.108189] RIP: 0010:warn_bogus_irq_restore+0x1d/0x20
[   92.108193] Code: 24 48 c7 c7 48 4f 94 aa e8 79 03 fb ff 80 3d cc ce 
0f 01 00 74 01 c3 48 c7 c7 68 c7 94 aa c6 05 bb ce 0f 01 01 e8 67 02 fb 
ff <0f> 0b c3 44 8b 05 b5 14 14 01 55 53 65 48 8b 1c 25 80 f1 01 00 45
[   92.108196] RSP: 0018:ff6d2e1209887b88 EFLAGS: 00010282
[   92.108199] RAX: 0000000000000000 RBX: 0000000000000200 RCX: 
0000000000000002
[   92.108201] RDX: 0000000000000002 RSI: ffffffffaa99de72 RDI: 
00000000ffffffff
[   92.108203] RBP: ff303e1d60ba2c78 R08: 0000000000000000 R09: 
c0000000ffff7fff
[   92.108205] R10: 0000000000000001 R11: ff6d2e12098879a8 R12: 
ff303e1d60ba4138
[   92.108207] R13: ff303e1d60ba4000 R14: ff303e1d60ba2c78 R15: 
0000000000000206
[   92.108209] FS:  00007ff6d3bf4740(0000) GS:ff303e2c7f900000(0000) 
knlGS:0000000000000000
[   92.108212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.108214] CR2: 00007ff6cd7fdfb8 CR3: 000000103ee6c004 CR4: 
0000000000771ee0
[   92.108216] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   92.108218] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   92.108219] PKRU: 55555554
[   92.108221] Call Trace:
[   92.108223]  <TASK>
[   92.108225]  _raw_spin_unlock_irqrestore+0x63/0x70
[   92.108230]  ib_send_cm_req+0x2c0/0x3f0 [ib_cm]
[   92.108257]  rdma_connect_locked+0x238/0x8e0 [rdma_cm]
[   92.108383]  rdma_connect+0x2b/0x40 [rdma_cm]
[   92.108393]  ucma_connect+0x128/0x1a0 [rdma_ucm]
[   92.108429]  ucma_write+0xaf/0x140 [rdma_ucm]
[   92.108437]  vfs_write+0xb8/0x370
[   92.108444]  ksys_write+0xbb/0xd0
[   92.108446]  ? syscall_trace_enter.isra.15+0x169/0x220
[   92.108454]  do_syscall_64+0x37/0x80
[   92.108459]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   92.108463] RIP: 0033:0x7ff6d3011847
[   92.108466] Code: c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89 fb 48 83 
ec 10 e8 1b fd ff ff 4c 89 e2 48 89 ee 89 df 41 89 c0 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 54 fd ff ff 48
[   92.108469] RSP: 002b:00007ffdd7b90af0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
[   92.108473] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007ff6d3011847
[   92.108474] RDX: 0000000000000128 RSI: 00007ffdd7b90b20 RDI: 
0000000000000003
[   92.108476] RBP: 00007ffdd7b90b20 R08: 0000000000000000 R09: 
00007ff6cd7fe700
[   92.108478] R10: 00000000ffffffff R11: 0000000000000293 R12: 
0000000000000128
[   92.108480] R13: 0000000000000011 R14: 0000000000000000 R15: 
000056360dabca18
[   92.108498]  </TASK>
[   92.108499] irq event stamp: 13915
[   92.108501] hardirqs last  enabled at (13921): [<ffffffffa976dfa7>] 
__up_console_sem+0x67/0x70
[   92.108507] hardirqs last disabled at (13926): [<ffffffffa976df8c>] 
__up_console_sem+0x4c/0x70
[   92.108510] softirqs last  enabled at (13806): [<ffffffffaa40032a>] 
__do_softirq+0x32a/0x48c
[   92.108514] softirqs last disabled at (13761): [<ffffffffa96e9e83>] 
irq_exit_rcu+0xe3/0x120
[   92.108517] ---[ end trace 0000000000000000 ]---
-----------The warnings----------------------------------------------

Zhu Yanjun
> 
> fpu_clone does not call rxe_add_to_pool
>   
>> As such, it is better to use xa_unlock_irqrestore +
>> __xa_alloc(...,GFP_ATOMIC/GFP_NOWAIT).
> 
> No
> 
> Jason

