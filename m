Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B3171581
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 11:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgB0K5g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 27 Feb 2020 05:57:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbgB0K5g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 05:57:36 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-rdma@vger.kernel.org
Subject: [Bug 206687] New: If IB link comes up, oops in port_pkey_list_insert
 triggered with "NULL pointer derefence"
Date:   Thu, 27 Feb 2020 10:57:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: hjl@simulated-universe.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206687-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206687

            Bug ID: 206687
           Summary: If IB link comes up, oops in port_pkey_list_insert
                    triggered with "NULL pointer derefence"
           Product: Drivers
           Version: 2.5
    Kernel Version: v5.4.21 ongoing
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: hjl@simulated-universe.de
        Regression: No

I am running a Fedora home server for testing purpose and using QLA7322
Infinband adapters to connect my workstation.

Since the upgrade to Fedora 31, that comes with a v5.5.5 kernel, the system
crashes as the network manager tries to configure the IPoIB interface.

I checked the last installed fedora 30 kernel and all went fine. 
Next I used the vanilla-kernels v5.4.19, v5.4.20 and v5.4.21 and tracked the
problem down to the v5.4.21

The problem still exists with the v5.5.6-rc3 kernel.

-------------------

Feb 27 09:58:27 odin.langes-netz.home kernel: IPv6: ADDRCONF(NETDEV_CHANGE):
ibp9s0: link becomes ready
Feb 27 09:58:27 odin.langes-netz.home NetworkManager[1046]: <info> 
[1582797507.0677] device (ibp9s0): carrier: link connected
Feb 27 09:58:27 odin.langes-netz.home NetworkManager[1046]: <info> 
[1582797507.0679] device (ibp9s0): state change: unavailable -> disconnected
(reason 'carrier-changed', sys-iface-state: 'managed')
Feb 27 09:58:27 odin.langes-netz.home NetworkManager[1046]: <info> 
[1582797507.0693] policy: auto-activating connection 'fastlane'
(e55b03b4-79d4-4cf7-89af-ea866965c8ba)
Feb 27 09:58:27 odin.langes-netz.home NetworkManager[1046]: <info> 
[1582797507.0700] device (ibp9s0): Activation: starting connection 'fastlane'
(e55b03b4-79d4-4cf7-89af-ea866965c8ba)
Feb 27 09:58:27 odin.langes-netz.home NetworkManager[1046]: <info> 
[1582797507.0702] device (ibp9s0): state change: disconnected -> prepare
(reason 'none', sys-iface-state: 'managed')
Feb 27 09:58:27 odin.langes-netz.home NetworkManager[1046]: <info> 
[1582797507.0708] manager: NetworkManager state is now CONNECTING
Feb 27 09:58:27 odin.langes-netz.home kernel: BUG: kernel NULL pointer
dereference, address: 0000000000000010
Feb 27 09:58:27 odin.langes-netz.home kernel: #PF: supervisor read access in
kernel mode
Feb 27 09:58:27 odin.langes-netz.home kernel: #PF: error_code(0x0000) -
not-present page
Feb 27 09:58:27 odin.langes-netz.home kernel: PGD 0 P4D 0 
Feb 27 09:58:27 odin.langes-netz.home kernel: Oops: 0000 [#1] SMP NOPTI
Feb 27 09:58:27 odin.langes-netz.home kernel: CPU: 0 PID: 1046 Comm:
NetworkManager Not tainted 5.4.21 #8
Feb 27 09:58:27 odin.langes-netz.home kernel: Hardware name: System
manufacturer System Product Name/PRIME X470-PRO, BIOS 5220 09/11/2019
Feb 27 09:58:27 odin.langes-netz.home kernel: RIP:
0010:get_pkey_idx_qp_list+0x5a/0x80 [ib_core]
Feb 27 09:58:27 odin.langes-netz.home kernel: Code: 06 48 69 ff b8 00 00 00 48
03 bd 88 04 00 00 4c 8b 47 20 48 8d 47 20 49 39 c0 74 26 0f b7 53 04 eb 08 4d
8b 00 49 39 c0 74 18 <66> 41 39 50 10 75 f1 48 83 c7 18 c6 07 00 0f 1f 40 00 4c
>
Feb 27 09:58:27 odin.langes-netz.home kernel: RSP: 0018:ffffb430c0b9f318
EFLAGS: 00010203
Feb 27 09:58:27 odin.langes-netz.home kernel: RAX: ffff895f3b41e030 RBX:
ffff895f3667bd80 RCX: 0000000000000000
Feb 27 09:58:27 odin.langes-netz.home kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffff895f3b41e010
Feb 27 09:58:27 odin.langes-netz.home kernel: RBP: ffff895f498d8000 R08:
0000000000000000 R09: ffff895f3667bd80
Feb 27 09:58:27 odin.langes-netz.home kernel: R10: ffffb430c0b9f548 R11:
0000000000000000 R12: 0000000000000071
Feb 27 09:58:27 odin.langes-netz.home kernel: R13: 0000000000000000 R14:
ffff895f498d8000 R15: ffffb430c0b9f430
Feb 27 09:58:27 odin.langes-netz.home kernel: FS:  00007f6a13521bc0(0000)
GS:ffff895f4e800000(0000) knlGS:0000000000000000
Feb 27 09:58:27 odin.langes-netz.home kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 27 09:58:27 odin.langes-netz.home kernel: CR2: 0000000000000010 CR3:
00000003fc056000 CR4: 00000000003406f0
Feb 27 09:58:27 odin.langes-netz.home kernel: Call Trace:
Feb 27 09:58:27 odin.langes-netz.home kernel:  port_pkey_list_insert+0x30/0x1a0
[ib_core]
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
kmem_cache_alloc_trace+0x162/0x220
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
ib_security_modify_qp+0xae/0x3a0 [ib_core]
Feb 27 09:58:27 odin.langes-netz.home kernel: 
ib_security_modify_qp+0x23f/0x3a0 [ib_core]
Feb 27 09:58:27 odin.langes-netz.home kernel:  _ib_modify_qp+0x272/0x3e0
[ib_core]
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? __dev_mc_del+0x53/0x70
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? rt6_age_exceptions+0x61/0x70
Feb 27 09:58:27 odin.langes-netz.home kernel:  ipoib_init_qp+0x78/0x1a0
[ib_ipoib]
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? fib6_clean_tree+0x58/0x80
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? fib6_del+0x250/0x250
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? nf_conntrack_lock+0x17/0x50
[nf_conntrack]
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? node_free_rcu+0x20/0x20
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? ib_find_pkey+0x98/0xe0
[ib_core]
Feb 27 09:58:27 odin.langes-netz.home kernel: 
ipoib_ib_dev_open_default+0x1a/0x180 [ib_ipoib]
Feb 27 09:58:27 odin.langes-netz.home kernel:  ipoib_ib_dev_open+0x66/0xa0
[ib_ipoib]
Feb 27 09:58:27 odin.langes-netz.home kernel:  ipoib_open+0x44/0x110 [ib_ipoib]
Feb 27 09:58:27 odin.langes-netz.home kernel:  __dev_open+0xcf/0x160
Feb 27 09:58:27 odin.langes-netz.home kernel:  __dev_change_flags+0x1a7/0x200
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? __dev_notify_flags+0x96/0xf0
Feb 27 09:58:27 odin.langes-netz.home kernel:  dev_change_flags+0x21/0x60
Feb 27 09:58:27 odin.langes-netz.home kernel:  do_setlink+0x667/0xd70
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
__nla_validate_parse+0x51/0x830
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? cpumask_next+0x17/0x20
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
__nla_validate_parse+0x51/0x830
Feb 27 09:58:27 odin.langes-netz.home kernel:  __rtnl_newlink+0x553/0x8c0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? __nla_reserve+0x38/0x50
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? prep_new_page+0xc4/0xf0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? __nla_reserve+0x38/0x50
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? __nla_put+0xc/0x20
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? prep_new_page+0xc4/0xf0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
get_page_from_freelist+0x772/0x17a0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? nla_put+0x28/0x40
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
get_page_from_freelist+0x772/0x17a0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? new_slab+0x25e/0x4e0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? _cond_resched+0x15/0x30
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
kmem_cache_alloc_trace+0x162/0x220
Feb 27 09:58:27 odin.langes-netz.home kernel:  rtnl_newlink+0x44/0x70
Feb 27 09:58:27 odin.langes-netz.home kernel:  rtnetlink_rcv_msg+0x2b0/0x360
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? _cond_resched+0x15/0x30
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? kmem_cache_alloc+0x165/0x220
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? ktime_get_real_ts64+0x46/0xe0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? _cond_resched+0x15/0x30
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? rtnl_calcit.isra.0+0x110/0x110
Feb 27 09:58:27 odin.langes-netz.home kernel:  netlink_rcv_skb+0x49/0x110
Feb 27 09:58:27 odin.langes-netz.home kernel:  netlink_unicast+0x171/0x200
Feb 27 09:58:27 odin.langes-netz.home kernel:  netlink_sendmsg+0x21e/0x3e0
Feb 27 09:58:27 odin.langes-netz.home kernel:  sock_sendmsg+0x5e/0x60
Feb 27 09:58:27 odin.langes-netz.home kernel:  ____sys_sendmsg+0x1ef/0x260
Feb 27 09:58:27 odin.langes-netz.home kernel:  ?
copy_msghdr_from_user+0xd6/0x150
Feb 27 09:58:27 odin.langes-netz.home kernel:  ___sys_sendmsg+0x88/0xd0
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? do_filp_open+0xa5/0x100
Feb 27 09:58:27 odin.langes-netz.home kernel:  ? list_lru_add+0xb5/0x1d0
Feb 27 09:58:27 odin.langes-netz.home kernel:  __sys_sendmsg+0x59/0xa0
Feb 27 09:58:27 odin.langes-netz.home kernel:  do_syscall_64+0x5b/0x1a0
Feb 27 09:58:27 odin.langes-netz.home kernel: 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb 27 09:58:27 odin.langes-netz.home kernel: RIP: 0033:0x7f6a144ff80d
Feb 27 09:58:27 odin.langes-netz.home kernel: Code: 28 89 54 24 1c 48 89 74 24
10 89 7c 24 08 e8 ea ec ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08
b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 1e ed
>
Feb 27 09:58:27 odin.langes-netz.home kernel: RSP: 002b:00007fff7308a310
EFLAGS: 00000293 ORIG_RAX: 000000000000002e
Feb 27 09:58:27 odin.langes-netz.home kernel: RAX: ffffffffffffffda RBX:
000055fa8bfdb540 RCX: 00007f6a144ff80d
Feb 27 09:58:27 odin.langes-netz.home kernel: RDX: 0000000000000000 RSI:
00007fff7308a360 RDI: 000000000000000c
Feb 27 09:58:27 odin.langes-netz.home kernel: RBP: 00007fff7308a360 R08:
0000000000000000 R09: 0000000000000000
Feb 27 09:58:27 odin.langes-netz.home kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 000055fa8bfdb540
Feb 27 09:58:27 odin.langes-netz.home kernel: R13: 00007fff7308a518 R14:
00007fff7308a50c R15: 0000000000000000
Feb 27 09:58:27 odin.langes-netz.home kernel: Modules linked in: xt_CHECKSUM
xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp tun bridge stp llc
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJECT nf_reject_ipv6
ip6t_rpfilter ipt>
Feb 27 09:58:27 odin.langes-netz.home kernel:  crct10dif_pclmul eeepc_wmi
ib_core crc32_pclmul snd_timer asus_wmi sp5100_tco ghash_clmulni_intel k10temp
i2c_piix4 wmi_bmof snd sparse_keymap rfkill soundcore pcspkr ccp gpio_amdpt
gpio_gen>
Feb 27 09:58:27 odin.langes-netz.home kernel: CR2: 0000000000000010
Feb 27 09:58:27 odin.langes-netz.home kernel: ---[ end trace 8fdfe3a62f9689a5
]---
Feb 27 09:58:27 odin.langes-netz.home kernel: RIP:
0010:get_pkey_idx_qp_list+0x5a/0x80 [ib_core]
Feb 27 09:58:27 odin.langes-netz.home kernel: Code: 06 48 69 ff b8 00 00 00 48
03 bd 88 04 00 00 4c 8b 47 20 48 8d 47 20 49 39 c0 74 26 0f b7 53 04 eb 08 4d
8b 00 49 39 c0 74 18 <66> 41 39 50 10 75 f1 48 83 c7 18 c6 07 00 0f 1f 40 00 4c
>
Feb 27 09:58:27 odin.langes-netz.home kernel: RSP: 0018:ffffb430c0b9f318
EFLAGS: 00010203
Feb 27 09:58:27 odin.langes-netz.home kernel: RAX: ffff895f3b41e030 RBX:
ffff895f3667bd80 RCX: 0000000000000000
Feb 27 09:58:27 odin.langes-netz.home kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffff895f3b41e010
Feb 27 09:58:27 odin.langes-netz.home kernel: RBP: ffff895f498d8000 R08:
0000000000000000 R09: ffff895f3667bd80
Feb 27 09:58:27 odin.langes-netz.home kernel: R10: ffffb430c0b9f548 R11:
0000000000000000 R12: 0000000000000071
Feb 27 09:58:27 odin.langes-netz.home kernel: R13: 0000000000000000 R14:
ffff895f498d8000 R15: ffffb430c0b9f430
Feb 27 09:58:27 odin.langes-netz.home kernel: FS:  00007f6a13521bc0(0000)
GS:ffff895f4e800000(0000) knlGS:0000000000000000
Feb 27 09:58:27 odin.langes-netz.home kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Feb 27 09:58:27 odin.langes-netz.home kernel: CR2: 0000000000000010 CR3:
00000003fc056000 CR4: 00000000003406f0

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
