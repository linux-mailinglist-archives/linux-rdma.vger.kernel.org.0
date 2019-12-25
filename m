Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F355812A5E7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 05:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLYEzr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 23:55:47 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41815 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYEzq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Dec 2019 23:55:46 -0500
Received: by mail-lf1-f43.google.com with SMTP id m30so16252066lfp.8
        for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2019 20:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=x/KGAnBqN0iOCXgo89W/xGuF4AZmjPuIcnN5hd8NJPU=;
        b=lZlYpOLC8gEa0GYLVjlDg7axWZT/EiL/ZkY9P2C2gjQMY9KpDZRDGmTWKguXLj6Scl
         nDGrMG7v76ydRY6ODvmigOwVr7tEYNLI86Cbn1o98qUazBBFAiT051XOZBjl4dwmNRJG
         Q/zIhX/rZnOfQ4XPqY3pirsip5fsXxFiJuY0iZinAYNmUu2FlQ7Bc0J36NUfNqA9ikxK
         6ij/yuXiJiS1YYv6Mj04PoWIhk6QRx+PudplKeZJ2Oh9ZIvcWPet2u8n9dbtW5SjMjFk
         zD2ihrIGu1HJkuqgem2cGndGjdjM0nGxHIiaCbmDdfv1py7Yg85WxuSxwPav9pccBthl
         nPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x/KGAnBqN0iOCXgo89W/xGuF4AZmjPuIcnN5hd8NJPU=;
        b=CpvsAb8mZ3+aqTTPIbgdnJVHTBbupepA5bK/gbj5VxmOyOQkxtBsCpBEfwJr2/SzQ5
         ZRyTiYXTSuWrhTrEjQSdfboBlxxNkpaz0+Mgnl4cyOkZY+pwzm1aqWfjsQzF3sYRVNFj
         0R+asT1ralf/yD+VjTzQ6vvCuEXwrlDkniZmyQav8Z6ehQZtjj9d9NnqcxWB04AhdXGk
         hWqELQjp8skvVmSw6jCHETXjZ9p96x8TTzMIh12Dd4m5FI0DBbSkm6T+CudNJF5VhSHX
         r4T2E2Xb+SYFdqvf34V4XxJicxbHsCxQscAk7zRSdF2Mz860dmMdnl2S2VkP09+m/Deb
         S2Hg==
X-Gm-Message-State: APjAAAUDak9lLkVvJOvLqrfCaOjBKE9zT4OF/30+JqmSP6JxPJXAsk0Z
        p74kbmgpbQ/Kp3s2xX34YV/PpNoX9vagmA4A5grvpOd6rdo=
X-Google-Smtp-Source: APXvYqwwUhqy7RkiZpLy/AHJzP5riNlsZhtP6ABStlqDWlaik+ewqP+eqW9IiSmx22mwQ8CwPjdnD+SXjbRDdKe5ZjM=
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr22543244lfk.67.1577249744655;
 Tue, 24 Dec 2019 20:55:44 -0800 (PST)
MIME-Version: 1.0
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Wed, 25 Dec 2019 12:55:35 +0800
Message-ID: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
Subject: rxe panic
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hi, there is a panic on rdma_rxe module when the restart
network.service or shutdown the switch.

it looks like a use-after-free error.

everytime it happens, there is the log "rdma_rxe: Unknown layer 3 protocol: 0"

is it a known error?

my kernel version is 4.14.97

[448840.314544] rdma_rxe: Unknown layer 3 protocol: 0
[448840.314626] general protection fault: 0000 [#1] SMP PTI
[448840.314627] Modules linked in: binfmt_misc ib_isert
iscsi_target_mod ib_srpt target_core_mod rpcrdma ib_iser ib_srp
scsi_transport_srp rdma_rxe(OE) ib_ipoib ib_umad ip6_udp_tunnel
udp_tunnel rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs ib_core
ebtable_filter ebtables devlink ip6table_filter ip6_tables
ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink iptable_nat
xt_addrtype xt_conntrack br_netfilter bridge stp llc overlay
ip_set_hash_ip ip_set nfnetlink iscsi_tcp libiscsi_tcp libiscsi
scsi_transport_iscsi sch_ingress openvswitch nf_conntrack_ipv6
nf_nat_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
nf_defrag_ipv6 nf_nat nf_conntrack libcrc32c sunrpc intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp vfat fat kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
intel_cstate
[448840.314677]  intel_uncore intel_rapl_perf mxm_wmi iTCO_wdt
iTCO_vendor_support ipmi_ssif pcspkr i2c_i801 lpc_ich ipmi_si
ipmi_devintf ipmi_msghandler pcc_cpufreq shpchp wmi ast drm_kms_helper
ttm crc32c_intel drm ixgbe igb mdio ptp pps_core dca i2c_algo_bit
[448840.314700] CPU: 1 PID: 17 Comm: ksoftirqd/1 Tainted: G
OE   4.14.97-el7.centos.x86_64 #1
[448840.314701] Hardware name:  /80010211        , BIOS 3.12 11/27/2018
[448840.314703] task: ffff9ce768af8000 task.stack: ffffbd7c4c6c4000
[448840.314710] RIP: 0010:rxe_elem_release+0xf/0x60 [rdma_rxe]
[448840.314711] RSP: 0018:ffffbd7c4c6c7d28 EFLAGS: 00010246
[448840.314713] RAX: 0000000000000000 RBX: 2917351aae258b92 RCX:
0000000000000000
[448840.314714] RDX: ffff9cfb3f64ba40 RSI: 000000000000026c RDI:
ffff9cfb3f678008
[448840.314715] RBP: ffff9cfb3f678000 R08: 0000000000000201 R09:
ffffbd7c4df35000
[448840.314716] R10: 0000000000000000 R11: 0000000000000001 R12:
0000000000000000
[448840.314717] R13: 000000000000001d R14: 0000000000000006 R15:
ffff9cfb3f678000
[448840.314719] FS:  0000000000000000(0000) GS:ffff9ce76f840000(0000)
knlGS:0000000000000000
[448840.314720] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[448840.314721] CR2: 00007f4fc400f000 CR3: 000000260420a005 CR4:
00000000001626e0
[448840.314723] Call Trace:
[448840.314730]  rxe_responder+0xcf0/0x1fe0 [rdma_rxe]
[448840.314738]  ? check_preempt_wakeup+0x125/0x240
[448840.314742]  ? check_preempt_curr+0x84/0x90
[448840.314745]  ? ttwu_do_wakeup+0x19/0x140
[448840.314747]  ? try_to_wake_up+0x54/0x450
[448840.314751]  rxe_do_task+0x8b/0x100 [rdma_rxe]
[448840.314754]  tasklet_action+0xfe/0x110
[448840.314758]  __do_softirq+0xd9/0x2a2
[448840.314761]  run_ksoftirqd+0x1e/0x70
[448840.314763]  smpboot_thread_fn+0x10e/0x160
[448840.314766]  kthread+0xff/0x140
[448840.314768]  ? sort_range+0x20/0x20
[448840.314770]  ? __kthread_parkme+0x90/0x90
[448840.314771]  ret_from_fork+0x35/0x40
[448840.314773] Code: 7a 00 00 74 04 31 c0 eb c3 4c 89 e7 e8 bb f9 ff
ff 31 c0 eb b7 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 8d 6f f8 53
48 8b 5f f8 <48> 8b 43 20 48 85 c0 74 08 48 89 ef e8 60 1c 53 fb 8b 43
30 48
[448840.314817] RIP: rxe_elem_release+0xf/0x60 [rdma_rxe] RSP: ffffbd7c4c6c7d28
