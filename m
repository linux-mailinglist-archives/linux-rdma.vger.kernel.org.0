Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2539C9689E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfHTSbm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 14:31:42 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:64290 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTSbm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Aug 2019 14:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566325900; x=1597861900;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/3D0vkvli2XjMxnJNd0pe882hijPCHFrMGRiE3hUqlU=;
  b=njxnwrPewNszAss1idcTDUupw+K3k+0CGAYZhg9xT7P4XCpGqeXon05i
   bcSHo36lU/cEKDKFkFYsolr66e85hTgpDyEKhGAyyi4YTry7k1QkTvJm2
   OTvMK3JDMa6OIEbxDdvwBPWpwq003/JZI6R8n9VuvsnMWYfHu7fCe4UQt
   o=;
X-IronPort-AV: E=Sophos;i="5.64,408,1559520000"; 
   d="scan'208";a="780168408"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 20 Aug 2019 18:31:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id D9892A250A;
        Tue, 20 Aug 2019 18:31:37 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 20 Aug 2019 18:31:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.177) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 20 Aug 2019 18:31:31 +0000
Subject: Re: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
To:     Michal Kalderon <michal.kalderon@marvell.com>,
        <mkalderon@marvell.com>, <jgg@ziepe.ca>, <dledford@redhat.com>
CC:     <aelior@marvell.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <aca72068-1155-6755-4494-0436a5d5a31f@amazon.com>
Date:   Tue, 20 Aug 2019 21:31:25 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820121847.25871-1-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.177]
X-ClientProxiedBy: EX13D04UWB004.ant.amazon.com (10.43.161.103) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/08/2019 15:18, Michal Kalderon wrote:
> This patch series uses the doorbell overflow recovery mechanism
> introduced in
> commit 36907cd5cd72 ("qed: Add doorbell overflow recovery mechanism")
> for rdma ( RoCE and iWARP )
> 
> The first five patches modify the core code to contain helper
> functions for managing mmap_xa inserting, getting and freeing
> entries. The code was based on the code from efa driver.
> There is still an open discussion on whether we should take
> this even further and make the entire mmap generic. Until a
> decision is made, I only created the database API and modified
> the efa, qedr, siw driver to use it. The functions are integrated
> witht the umap mechanism.
> 
> The doorbell recovery code is based on the common code.
> 
> Efa driver was compile tested and checked only modprobe/rmmod.
> SIW was compile tested only

Hey Michal,

I haven't had the time to review the patches yet, but I did run it through our
regression and got some dmesg call traces [1].
There are also some kmemleak warnings for suspected memory leaks, don't have the
full information ATM but I can try and extract it if needed.

Thanks!

[1] (this is the first trace of many)
BUG: Bad page state in process ib_send_bw  pfn:1411f76
page:ffffea005047dd80 refcount:-1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffe000000000()
raw: 002fffe000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 ffffffffffffffff 0000000000000000
page dumped because: nonzero _refcount
Modules linked in: sunrpc dm_mirror dm_region_hash dm_log dm_mod efa ib_uverbs
ib_core crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd
cryptd glue_helper button pcspkr evdev ip_tables x_tables xfs libcrc32c nvme
crc32c_intel nvme_core ena ipv6 crc_ccitt nf_defrag_ipv6 autofs4
CPU: 29 PID: 62474 Comm: ib_send_bw Not tainted 5.3.0-rc1-dirty #1
Hardware name: Amazon EC2 c5n.18xlarge/, BIOS 1.0 10/16/2017
Call Trace:
 dump_stack+0x9a/0xeb
 bad_page+0x104/0x180
 free_pcppages_bulk+0x31b/0xdd0
 ? uncharge_batch+0x1d2/0x2b0
 ? free_compound_page+0x40/0x40
 ? free_unref_page_commit+0x152/0x1b0
 free_unref_page_list+0x1b8/0x3e0
 release_pages+0x4c6/0x620
 ? put_pages_list+0xf0/0xf0
 ? free_pages_and_swap_cache+0x97/0x140
 tlb_flush_mmu+0x7a/0x280
 tlb_finish_mmu+0x44/0x170
 exit_mmap+0x147/0x2b0
 ? do_munmap+0x10/0x10
 mmput+0xb4/0x1d0
 do_exit+0x4c2/0x14d0
 ? mm_update_next_owner+0x360/0x360
 ? ktime_get_coarse_real_ts64+0xc0/0x120
 ? syscall_trace_enter+0x22d/0x5f0
 ? __audit_syscall_exit+0x31e/0x460
 ? syscall_slow_exit_work+0x2c0/0x2c0
 ? kfree+0x221/0x290
 ? mark_held_locks+0x1c/0xa0
 do_group_exit+0x6f/0x140
 __x64_sys_exit_group+0x28/0x30
 do_syscall_64+0x68/0x290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f6072a3b928
Code: Bad RIP value.
RSP: 002b:00007ffe4e09ae68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6072a3b928
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007f6072d24898 R08: 00000000000000e7 R09: ffffffffffffff70
R10: 00007f60724ead68 R11: 0000000000000246 R12: 00007f6072d24898
R13: 00007f6072d29d80 R14: 0000000000000000 R15: 0000000000000000
Disabling lock debugging due to kernel taint
