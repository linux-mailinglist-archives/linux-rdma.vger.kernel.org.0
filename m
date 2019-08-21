Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC939793C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHUMZT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 08:25:19 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54453 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfHUMZT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 08:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566390318; x=1597926318;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OEoT7Hw/vIRaalg4jvaSICT3m4H67yt0XPXV7vtP2Rw=;
  b=ATwBbtcr9kYvxOgdA6WEZ7Wbz7CSGFYjLJsJW2zbCovTdegxSMik4ypQ
   6AGa7/pwmi5UfesK5TjHyXNXsDh6grDbv0oSUf+j3+H5GI3K860+YBWHW
   ExBrxL6ie/vntCvGxqcdEu9WB7REbmV78ejkBEk+5nolCGGEXw43m/zrB
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,412,1559520000"; 
   d="scan'208";a="410807945"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 21 Aug 2019 12:25:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 32A4EA2840;
        Wed, 21 Aug 2019 12:25:14 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 12:25:14 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.211) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 12:25:09 +0000
Subject: Re: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <aca72068-1155-6755-4494-0436a5d5a31f@amazon.com>
 <MN2PR18MB31827364A5B64323681D1B4BA1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <cee52133-ae69-3709-6f3c-187382af054f@amazon.com>
 <MN2PR18MB318297E219BB657ED716C3A3A1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <87468101-ace2-b718-fd1c-aa6d84554773@amazon.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8470780c-7366-dd71-fcb5-372f2c420e8b@amazon.com>
Date:   Wed, 21 Aug 2019 15:25:04 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87468101-ace2-b718-fd1c-aa6d84554773@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.211]
X-ClientProxiedBy: EX13D06UWC002.ant.amazon.com (10.43.162.205) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/08/2019 13:41, Gal Pressman wrote:
> On 21/08/2019 13:32, Michal Kalderon wrote:
>> Thanks Gal, 
>>
>> I think I found the problem for the issue below, attached a patch that should be applied on top of the series. 
>> Please let me know if this fixed the issues you are seeing. 
>> In qedr we work with only single pages, and this issue will only occur with multiple pages. 
> 
> Will apply and rerun, thanks.

I see different traces now:

------------[ cut here ]------------
DMA-API: exceeded 7 overlapping mappings of cacheline 0x00000000a95ac6c0
WARNING: CPU: 22 PID: 23794 at kernel/dma/debug.c:501 add_dma_entry+0x1fd/0x230
Modules linked in: sunrpc dm_mirror dm_region_hash dm_log dm_mod efa ib_uverbs ib_core crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper pcspkr button evdev ip_tables x_tables xfs libcrc32c crc32c_intel nvme nvme_core ena ipv6 crc_ccitt nf_defrag_ipv6 autofs4
CPU: 22 PID: 23794 Comm: fi_multi_res Not tainted 5.3.0-rc1-g27b7fb1ab-dirty #1
Hardware name: Amazon EC2 c5n.18xlarge/, BIOS 1.0 10/16/2017
RIP: 0010:add_dma_entry+0x1fd/0x230
Code: bb 04 02 80 fb 01 77 44 83 e3 01 75 bb 48 8d 54 24 20 be 07 00 00 00 48 c7 c7 e0 c9 29 82 c6 05 ef ba 04 02 01 e8 63 9f ef ff <0f> 0b eb 9a e8 4a a3 ef ff 48 63 f0 ba 01 00 00 00 48 c7 c7 80 13
RSP: 0018:ffff88ac0d2c7370 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8131a0de
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88ac69e30670
RBP: 00000000a95ac6c0 R08: ffffed158d3c60cf R09: ffffed158d3c60cf
R10: 0000000000000001 R11: ffffed158d3c60ce R12: 0000000000000206
R13: 1ffff11581a58e6e R14: ffff88ac614ea000 R15: 0000000000000202
FS:  00007f7b9290d740(0000) GS:ffff88ac69e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000011e8000 CR3: 0000002b1e0f0001 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 ? dma_debug_init+0x2b0/0x2b0
 ? lockdep_hardirqs_on+0x1b2/0x2d0
 debug_dma_map_sg+0x7a/0x4b0
 ib_umem_get+0x791/0x9c0 [ib_uverbs]
 ? __kasan_kmalloc.constprop.7+0xa0/0xd0
 efa_reg_mr+0x274/0x1600 [efa]
 ? lock_downgrade+0x3a0/0x3a0
 ? efa_create_cq+0x930/0x930 [efa]
 ? xa_find_after+0x310/0x310
 ? lookup_get_idr_uobject.part.7+0x18d/0x290 [ib_uverbs]
 ? match_held_lock+0x1b/0x250
 ? alloc_commit_idr_uobject+0x60/0x60 [ib_uverbs]
 ? _raw_spin_unlock+0x24/0x30
 ? alloc_begin_idr_uobject+0x62/0x90 [ib_uverbs]
 ib_uverbs_reg_mr+0x20e/0x470 [ib_uverbs]
 ? ib_uverbs_ex_create_wq+0x620/0x620 [ib_uverbs]
 ? uverbs_fill_udata+0x1be/0x310 [ib_uverbs]
 ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x197/0x1f0 [ib_uverbs]
 ? uverbs_disassociate_api+0x220/0x220 [ib_uverbs]
 ? uverbs_fill_udata+0x222/0x310 [ib_uverbs]
 ib_uverbs_cmd_verbs+0xbbb/0x1500 [ib_uverbs]
 ? uverbs_disassociate_api+0x220/0x220 [ib_uverbs]
 ? uverbs_fill_udata+0x310/0x310 [ib_uverbs]
 ? check_chain_key+0x1d7/0x2d0
 ? check_chain_key+0x1d7/0x2d0
 ? register_lock_class+0x8f0/0x8f0
 ? lock_downgrade+0x3a0/0x3a0
 ? lock_acquire+0xf3/0x250
 ? __might_fault+0x7d/0xe0
 ? lock_acquire+0xf3/0x250
 ? ib_uverbs_ioctl+0xf2/0x1f0 [ib_uverbs]
 ib_uverbs_ioctl+0x14a/0x1f0 [ib_uverbs]
 ? ib_uverbs_ioctl+0xf2/0x1f0 [ib_uverbs]
 ? ib_uverbs_cmd_verbs+0x1500/0x1500 [ib_uverbs]
 do_vfs_ioctl+0x131/0x9c0
 ? ioctl_preallocate+0x170/0x170
 ? syscall_trace_enter+0x365/0x5f0
 ? mark_held_locks+0x1c/0xa0
 ? ktime_get_coarse_real_ts64+0x7b/0x120
 ? lockdep_hardirqs_on+0x1b2/0x2d0
 ? ktime_get_coarse_real_ts64+0xc0/0x120
 ? syscall_trace_enter+0x22d/0x5f0
 ? __audit_syscall_exit+0x31e/0x460
 ? syscall_slow_exit_work+0x2c0/0x2c0
 ? kfree+0x221/0x290
 ksys_ioctl+0x70/0x80
 ? mark_held_locks+0x1c/0xa0
 __x64_sys_ioctl+0x3d/0x50
 do_syscall_64+0x68/0x290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f7b910631e7
Code: b3 66 90 48 8b 05 99 3c 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 3c 2c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffded077f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffded077f70 RCX: 00007f7b910631e7
RDX: 00007ffded077f90 RSI: 00000000c0181b01 RDI: 0000000000000004
RBP: 00007ffded077fa8 R08: 0000000000000003 R09: 0000000000737d70
R10: 00000000ffffffff R11: 0000000000000246 R12: 000000000000000c
R13: 0000000000737eb0 R14: 00007ffded078128 R15: 0000000000000001
irq event stamp: 129540
hardirqs last  enabled at (129539): [<ffffffff81c687e2>] _raw_spin_unlock_irqrestore+0x32/0x60
hardirqs last disabled at (129540): [<ffffffff81c68d90>] _raw_spin_lock_irqsave+0x20/0x60
softirqs last  enabled at (129492): [<ffffffff8200053e>] __do_softirq+0x53e/0x7db
softirqs last disabled at (129415): [<ffffffff810fbd93>] irq_exit+0xf3/0x130
---[ end trace 89664bc28659d1cf ]---
