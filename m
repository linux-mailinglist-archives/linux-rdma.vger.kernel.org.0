Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A19D15D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 16:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfHZOIK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 10:08:10 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2318 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbfHZOIJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 10:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566828488; x=1598364488;
  h=to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=sHfzyX11PRBAaonZ13btBv9k7p9FIm56hI1tf3G7U8Y=;
  b=leg38IE0QH7+mzeCLeU9u/n2wll1WJdsADlkyuixAGqqE95ZK8JTYXwF
   zghc/uOSYWTc9JzzrfnNBqIqSWFAybGPrtTDDS5UR1wmyu1C7QhqYGQUd
   V5kcfft2LsRmPGtU+gCjNhZtVYGEDESQeqYX+Lz2dDQvOqmAl6PrSY/z3
   o=;
X-IronPort-AV: E=Sophos;i="5.64,433,1559520000"; 
   d="scan'208";a="697532431"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 Aug 2019 14:05:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 717F4A07A7
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 14:05:20 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 14:05:19 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.191) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 14:05:17 +0000
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Subject: ib_umem_get and DMA_API_DEBUG question
Message-ID: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
Date:   Mon, 26 Aug 2019 17:05:12 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.191]
X-ClientProxiedBy: EX13D12UWC003.ant.amazon.com (10.43.162.12) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Lately I've been seeing DMA-API call traces on our automated testing runs which
complain about overlapping mappings of the same cacheline [1].
The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
same address, which as a result DMA maps the same physical addresses more than 7
(ACTIVE_CACHELINE_MAX_OVERLAP) times.

Is this considered a bad behavior by the test? Should this be caught by
ib_core/driver somehow?

Thanks,
Gal

[1]
------------[ cut here ]------------
DMA-API: exceeded 7 overlapping mappings of cacheline 0x000000004a0ad6c0
WARNING: CPU: 56 PID: 63572 at kernel/dma/debug.c:501 add_dma_entry+0x1fd/0x230
Modules linked in: sunrpc dm_mirror dm_region_hash dm_log dm_mod efa ib_uverbs
ib_core crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd
cryptd glue_helper button pcspkr evdev ip_tables x_tables xfs libcrc32c nvme
crc32c_intel nvme_core ena ipv6 crc_ccitt autofs4
CPU: 56 PID: 63572 Comm: fi_multi_res Not tainted 5.2.0-g27b7fb1ab-dirty #1
Hardware name: Amazon EC2 c5n.18xlarge/, BIOS 1.0 10/16/2017
RIP: 0010:add_dma_entry+0x1fd/0x230
Code: a7 03 02 80 fb 01 77 44 83 e3 01 75 bb 48 8d 54 24 20 be 07 00 00 00 48 c7
c7 c0 89 29 82 c6 05 00 a7 03 02 01 e8 53 10 f0 ff <0f> 0b eb 9a e8 9a 13 f0 ff
48 63 f0 ba 01 00 00 00 48 c7 c7 00 bf
RSP: 0018:ffff8892c33a7388 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81306f9e
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88ac6a630650
RBP: 000000004a0ad6c0 R08: ffffed158d4c60cb R09: ffffed158d4c60cb
R10: 0000000000000001 R11: ffffed158d4c60ca R12: 0000000000000206
R13: 1ffff11258674e71 R14: ffff88ac60c77a80 R15: 0000000000000202
FS:  00007fec5e4f5740(0000) GS:ffff88ac6a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000263c000 CR3: 0000001425a14006 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 ? dma_debug_init+0x2b0/0x2b0
 ? lockdep_hardirqs_on+0x1b1/0x2d0
 debug_dma_map_sg+0x7a/0x4b0
 ib_umem_get+0x831/0xca0 [ib_uverbs]
 ? __kasan_kmalloc.constprop.6+0xa0/0xd0
 efa_reg_mr+0x26f/0x1920 [efa]
 ? check_chain_key+0x147/0x200
 ? check_flags.part.32+0x240/0x240
 ? efa_create_cq+0x910/0x910 [efa]
 ? lookup_get_idr_uobject.part.7+0x18d/0x290 [ib_uverbs]
 ? match_held_lock+0x1b/0x240
 ? alloc_commit_idr_uobject+0x50/0x50 [ib_uverbs]
 ? _raw_spin_unlock+0x24/0x30
 ? alloc_begin_idr_uobject+0x62/0x90 [ib_uverbs]
 ib_uverbs_reg_mr+0x20e/0x440 [ib_uverbs]
 ? ib_uverbs_ex_create_wq+0x620/0x620 [ib_uverbs]
 ? match_held_lock+0x1b/0x240
 ? match_held_lock+0x1b/0x240
 ? check_chain_key+0x147/0x200
 ? uverbs_fill_udata+0x12f/0x360 [ib_uverbs]
 ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x197/0x1f0 [ib_uverbs]
 ? uverbs_disassociate_api+0x220/0x220 [ib_uverbs]
 ? __bitmap_subset+0xd2/0x120
 ? uverbs_fill_udata+0x2ab/0x360 [ib_uverbs]
 ib_uverbs_cmd_verbs+0xb61/0x1410 [ib_uverbs]
 ? uverbs_disassociate_api+0x220/0x220 [ib_uverbs]
 ? mark_lock+0xcf/0x9a0
 ? uverbs_fill_udata+0x360/0x360 [ib_uverbs]
 ? match_held_lock+0x1b/0x240
 ? lock_acquire+0xdb/0x220
 ? lock_acquire+0xdb/0x220
 ? ib_uverbs_ioctl+0xf2/0x1f0 [ib_uverbs]
 ib_uverbs_ioctl+0x14a/0x1f0 [ib_uverbs]
 ? ib_uverbs_ioctl+0xf2/0x1f0 [ib_uverbs]
 ? ib_uverbs_cmd_verbs+0x1410/0x1410 [ib_uverbs]
 ? match_held_lock+0x1b/0x240
 ? check_chain_key+0x147/0x200
 do_vfs_ioctl+0x131/0x990
 ? ioctl_preallocate+0x170/0x170
 ? syscall_trace_enter+0x2fb/0x5a0
 ? mark_held_locks+0x1c/0xa0
 ? ktime_get_coarse_real_ts64+0x7b/0x120
 ? lockdep_hardirqs_on+0x1b1/0x2d0
 ? ktime_get_coarse_real_ts64+0xc0/0x120
 ? syscall_trace_enter+0x184/0x5a0
 ? trace_event_raw_event_sys_enter+0x2b0/0x2b0
 ? rcu_read_lock_sched_held+0x8f/0xa0
 ? kfree+0x24a/0x2c0
 ksys_ioctl+0x70/0x80
 ? mark_held_locks+0x1c/0xa0
 __x64_sys_ioctl+0x3d/0x50
 do_syscall_64+0x68/0x280
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fec5cc4b1e7
Code: b3 66 90 48 8b 05 99 3c 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3
66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3
48 8b 0d 69 3c 2c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffeba220f48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffeba220f90 RCX: 00007fec5cc4b1e7
RDX: 00007ffeba220fb0 RSI: 00000000c0181b01 RDI: 0000000000000003
RBP: 00007ffeba220fc8 R08: 0000000000000003 R09: 0000000001b8be90
R10: 00000000ffffffff R11: 0000000000000246 R12: 000000000000000c
R13: 0000000001b8bfd0 R14: 00007ffeba221148 R15: 0000000000000001
irq event stamp: 130178
hardirqs last  enabled at (130177): [<ffffffff81c121d2>]
_raw_spin_unlock_irqrestore+0x32/0x60
hardirqs last disabled at (130178): [<ffffffff81c12780>]
_raw_spin_lock_irqsave+0x20/0x60
softirqs last  enabled at (130124): [<ffffffff81abd353>] tcp_recvmsg+0x693/0x1360
softirqs last disabled at (130122): [<ffffffff8198abfb>] release_sock+0x1b/0xe0
---[ end trace 22c97ff4678ca8c1 ]---
