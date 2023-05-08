Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6786FA2A1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 May 2023 10:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEHIx7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjEHIx6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 04:53:58 -0400
Received: from out-41.mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F9C55BD
        for <linux-rdma@vger.kernel.org>; Mon,  8 May 2023 01:53:55 -0700 (PDT)
Message-ID: <a694638f-9fb4-88b2-cbba-bb5de2aadc3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683536031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h5YVawohgPKlr5mSWQ9iW/ommw5X1/qkvLvlgOXDro0=;
        b=sBdeLB3Y7Iq8tANppnoVRvMtly1m4IudqDTYW80Cz7dlv4VrDGt6wlQkJo2pX2vMzi/ymG
        SrC44atmVBLptkb0K8Hay/qof/T2qzj9NbuO0OE0xwXJ12qwgqMy2rb1uGU5pJtmjtC4qN
        T8O0euHoqzHdGn87wFGdjLDgqaxuHKw=
Date:   Mon, 8 May 2023 16:53:45 +0800
MIME-Version: 1.0
To:     "leon@kernel.org" <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        akpm@linux-foundation.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: raw_local_irq_restore() called with IRQs enabled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, all

I confronted the following problem. The call traces are as below.

kernel/fork.c:

"

2323 spin_lock_irq(&current->sighand->siglock); <---disable
2324         if (!(clone_flags & CLONE_THREAD))
2325                 hlist_add_head(&delayed.node, 
&current->signal->multiprocess);
2326         recalc_sigpending();
2327 spin_unlock_irq(&current->sighand->siglock); <--enable
"

conflicts with the following

"

1031         spin_lock_irqsave(&qp_info->send_queue.lock, flags); <---save
1032         if (qp_info->send_queue.count < 
qp_info->send_queue.max_active) {
1033                 trace_ib_mad_ib_send_mad(mad_send_wr, qp_info);
1034                 ret = ib_post_send(mad_agent->qp, 
&mad_send_wr->send_wr.wr,
1035                                    NULL);
1036                 list = &qp_info->send_queue.list;
1037         } else {
1038                 ret = 0;
1039                 list = &qp_info->overflow_list;
1040         }
1041
1042         if (!ret) {
1043                 qp_info->send_queue.count++;
1044 list_add_tail(&mad_send_wr->mad_list.list, list);
1045         }
1046 spin_unlock_irqrestore(&qp_info->send_queue.lock, flags); <--restore

"

If we change spin_lock_irq/spin_unlock_irq to 
spin_lock_irqsave/spin_unlock_irqrestore, it seems that this problem is 
resolved.

But not sure if other problems are introduced.

[ 6020.091840] ------------[ cut here ]------------
[ 6020.091846] raw_local_irq_restore() called with IRQs enabled
[ 6020.091857] WARNING: CPU: 82 PID: 10603 at 
kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x21/0x30
[ 6020.091872] Modules linked in: rdma_rxe ip6_udp_tunnel udp_tunnel 
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 
nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 nf_tables nfnetlink tun bridge stp llc vfat fat ext4 
mbcache jbd2 rpcrdma sunrpc intel_rapl_msr intel_rapl_common rdma_ucm 
i10nm_edac ib_srpt nfit ib_isert libnvdimm iscsi_target_mod 
target_core_mod x86_pkg_temp_thermal ib_iser intel_powerclamp libiscsi 
coretemp scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm kvm_intel 
ib_cm ipmi_ssif kvm mlx5_ib i40e irqbypass crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel ib_uverbs sha512_ssse3 iTCO_wdt rapl 
iTCO_vendor_support mei_me intel_cstate ib_core joydev acpi_ipmi 
intel_uncore mei ipmi_si pcspkr i2c_i801 dax_hmem isst_if_mmio 
isst_if_mbox_pci wmi_bmof isst_if_common intel_pch_thermal i2c_smbus 
ipmi_devintf ipmi_msghandler acpi_power_meter ip_tables xfs libcrc32c 
sd_mod t10_pi crc64_rocksoft crc64 sg mgag200 mlx5_core drm_kms_helper 
syscopyarea mlxfw sysfillrect
[ 6020.092063]  sysimgblt tls i2c_algo_bit ahci drm_shmem_helper libahci 
ice pci_hyperv_intf crc32c_intel drm psample megaraid_sas libata tg3 wmi 
dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded: irdma]
[ 6020.092108] CPU: 82 PID: 10603 Comm: rping Kdump: loaded Tainted: G 
S  B              6.4.0-rc1+ #30
[ 6020.092115] Hardware name: Dell Inc. PowerEdge R750/06V45N, BIOS 
1.2.4 05/28/2021
[ 6020.092119] RIP: 0010:warn_bogus_irq_restore+0x21/0x30
[ 6020.092126] Code: 90 90 90 90 90 90 90 90 90 80 3d 35 50 79 01 00 74 
05 c3 cc cc cc cc 48 c7 c7 a0 d7 e9 ae c6 05 20 50 79 01 01 e8 1f 15 da 
fe <0f> 0b c3 cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90
[ 6020.092131] RSP: 0018:ff11000180e477e8 EFLAGS: 00010286
[ 6020.092137] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[ 6020.092141] RDX: 0000000000000004 RSI: dffffc0000000000 RDI: 
ffffffffb27b31c0
[ 6020.092144] RBP: ff110001175d69e8 R08: ffe21c02006d7f6a R09: 
ffe21c02006d7f6a
[ 6020.092148] R10: ff110010036bfb4b R11: ffe21c02006d7f69 R12: 
ff110001175d6a28
[ 6020.092152] R13: ff110001175d6a30 R14: ff110001175d69e8 R15: 
0000000000000000
[ 6020.092155] FS:  00007f215281c740(0000) GS:ff11001003680000(0000) 
knlGS:0000000000000000
[ 6020.092160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6020.092163] CR2: 00007f2147fffda0 CR3: 00000001a1b2c005 CR4: 
0000000000771ee0
[ 6020.092167] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 6020.092170] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 6020.092173] PKRU: 55555554
[ 6020.092175] Call Trace:
[ 6020.092178]  <TASK>
[ 6020.092181]  _raw_spin_unlock_irqrestore+0x67/0x70
[ 6020.092190]  ib_send_mad+0x3fa/0x7d0 [ib_core]
[ 6020.092299]  ? __pfx_ib_send_mad+0x10/0x10 [ib_core]
[ 6020.092429]  ib_post_send_mad+0x338/0x4c0 [ib_core]
[ 6020.092519]  ib_send_cm_rep+0x4b0/0x790 [ib_cm]
[ 6020.092553]  rdma_accept+0x432/0x550 [rdma_cm]
[ 6020.092585]  ? __pfx_rdma_accept+0x10/0x10 [rdma_cm]
[ 6020.092613]  ? do_raw_spin_unlock+0x97/0x130
[ 6020.092623]  ? preempt_count_sub+0x14/0xc0
[ 6020.092632]  ? _raw_spin_unlock+0x29/0x50
[ 6020.092637]  ? ucma_get_ctx+0xab/0x180 [rdma_ucm]
[ 6020.092650]  ? check_stack_object+0x22/0x70
[ 6020.092659]  ucma_accept+0x1e7/0x2e0 [rdma_ucm]
[ 6020.092671]  ? __pfx_ucma_accept+0x10/0x10 [rdma_ucm]
[ 6020.092683]  ? 
__pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
[ 6020.092720]  ? _find_next_bit+0x37/0xc0
[ 6020.092741]  ucma_write+0x139/0x1f0 [rdma_ucm]
[ 6020.092752]  ? __pfx_ucma_write+0x10/0x10 [rdma_ucm]
[ 6020.092764]  ? security_file_permission+0x4b/0x2b0
[ 6020.092774]  vfs_write+0x161/0x740
[ 6020.092781]  ? ib_uverbs_ioctl+0x17f/0x210 [ib_uverbs]
[ 6020.092815]  ? __pfx_vfs_write+0x10/0x10
[ 6020.092822]  ? __fget_files+0x158/0x230
[ 6020.092831]  ? __fget_light+0xe2/0x100
[ 6020.092838]  ksys_write+0x13f/0x160
[ 6020.092843]  ? __pfx_ksys_write+0x10/0x10
[ 6020.092847]  ? ktime_get_coarse_real_ts64+0x107/0x120
[ 6020.092854]  ? ktime_get_coarse_real_ts64+0xaf/0x120
[ 6020.092863]  do_syscall_64+0x37/0x90
[ 6020.092870]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 6020.092877] RIP: 0033:0x7f2151e11847
[ 6020.092882] Code: c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89 fb 48 83 
ec 10 e8 1b fd ff ff 4c 89 e2 48 89 ee 89 df 41 89 c0 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 54 fd ff ff 48
[ 6020.092886] RSP: 002b:00007ffc2439a0f0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
[ 6020.092892] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f2151e11847
[ 6020.092896] RDX: 0000000000000130 RSI: 00007ffc2439a120 RDI: 
0000000000000003
[ 6020.092899] RBP: 00007ffc2439a120 R08: 0000000000000000 R09: 
0000000000000000
[ 6020.092902] R10: 00000000ffffffff R11: 0000000000000293 R12: 
0000000000000130
[ 6020.092905] R13: 0000000000000011 R14: 0000000000000000 R15: 
000055c0ea6ffa18
[ 6020.092914]  </TASK>
[ 6020.092917] irq event stamp: 0
[ 6020.092919] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 6020.092923] hardirqs last disabled at (0): [<ffffffffad94dae6>] 
copy_process+0x13e6/0x3720
[ 6020.092931] softirqs last  enabled at (0): [<ffffffffad94dae6>] 
copy_process+0x13e6/0x3720
[ 6020.092936] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 6020.092939] ---[ end trace 0000000000000000 ]---

Zhu Yanjun

