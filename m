Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A45C3B66
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfJAQnm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 12:43:42 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:37988 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732926AbfJAQnl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 12:43:41 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x91Ghaxl013190;
        Tue, 1 Oct 2019 09:43:37 -0700
Date:   Tue, 1 Oct 2019 22:13:36 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in siw_qp_put_ref
Message-ID: <20191001164334.GA28508@chelsio.com>
References: <2b0ae7d3-0dc9-94c0-0092-e32fb2c9cb45@acm.org>
 <OF0B426945.C9BEAB54-ON00258486.00410759-00258486.0042AF87@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0B426945.C9BEAB54-ON00258486.00410759-00258486.0042AF87@notes.na.collabserv.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, October 10/01/19, 2019 at 17:38:23 +0530, Bernard Metzler wrote:
> -----"Bart Van Assche" <bvanassche@acm.org> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>, "linux-rdma"
> ><linux-rdma@vger.kernel.org>
> >From: "Bart Van Assche" <bvanassche@acm.org>
> >Date: 10/01/2019 12:49AM
> >Subject: [EXTERNAL] BUG: KASAN: use-after-free in siw_qp_put_ref
> >
> >Hi Bernard,
> >
> >The complaint shown below was reported while I was running blktests 
> >after having configured the siw driver. I'm not sure whether this is
> >an 
> >NVMe driver or siw driver bug. So far I have encountered this
> >complaint 
> >only with the siw driver but not yet with the rdma_rxe driver.
> >
> >Bart.
> 
> Hi Bart,
> 
> Many thanks for finding this. I expect this to be an siw issue.
> Related/caused by the issue Krishna (on CC) reported recently.
> siw provides specific drain functions for ib_drain_sq() and
> ib_drain_rq(), but does not adhere to its intended semantics
> - waiting until the SQ/RQ is completely drained to the CQ and
> its completions are consumed by the application.
> 
> I see the NVME host calling nvme_rdma_teardown_io_queues()->
> nvme_rdma_stop_io_queues()->nvme_rdma_stop_queue()->
> __nvme_rdma_stop_queue->ib_drain_qp() , which calls
> the driver specific drain routines. 
> 
> So let's fix that.
This issue is due to early freeing of siw_base_qp' in destroy_qp.
I just submitted patch for this
issue(https://patchwork.kernel.org/patch/11169267/).

Thanks,
Krishna.
> 
> Thanks
> Bernard.
> 
> >
> >==================================================================
> >BUG: KASAN: use-after-free in siw_qp_put_ref+0x19/0x40 [siw]
> >Read of size 8 at addr ffff8881024fe490 by task check/9926
> >
> >CPU: 1 PID: 9926 Comm: check Not tainted 5.4.0-rc1-dbg+ #13
> >Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 
> >04/01/2014
> >Call Trace:
> >  dump_stack+0x86/0xca
> >  print_address_description.constprop.7+0x40/0x60
> >  __kasan_report.cold.10+0x1b/0x39
> >  kasan_report+0x12/0x20
> >  __asan_load8+0x54/0x90
> >  siw_qp_put_ref+0x19/0x40 [siw]
> >  destroy_cm_id+0x181/0x330 [iw_cm]
> >  iw_destroy_cm_id+0xe/0x10 [iw_cm]
> >  rdma_destroy_id+0x3ee/0x460 [rdma_cm]
> >  nvme_rdma_free_queue+0x3e/0x50 [nvme_rdma]
> >  nvme_rdma_destroy_io_queues+0x55/0xb0 [nvme_rdma]
> >  nvme_rdma_teardown_io_queues.part.32+0xca/0xe0 [nvme_rdma]
> >  nvme_rdma_shutdown_ctrl+0x50/0xa0 [nvme_rdma]
> >  nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
> >  nvme_do_delete_ctrl+0x97/0xe1 [nvme_core]
> >  nvme_sysfs_delete.cold.95+0x8/0xd [nvme_core]
> >  dev_attr_store+0x3c/0x50
> >  sysfs_kf_write+0x87/0xa0
> >  kernfs_fop_write+0x186/0x240
> >  __vfs_write+0x4d/0x90
> >  vfs_write+0xfa/0x290
> >  ksys_write+0xc3/0x160
> >  __x64_sys_write+0x43/0x50
> >  do_syscall_64+0x6b/0x2d0
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >RIP: 0033:0x7f99db297024
> >Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00
> >00 
> >48 8d 05 b9 d3 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d
> >00 
> >f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
> >RSP: 002b:00007ffe02f8b228 EFLAGS: 00000246 ORIG_RAX:
> >0000000000000001
> >RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99db297024
> >RDX: 0000000000000002 RSI: 00005615bb94ad80 RDI: 0000000000000001
> >RBP: 00005615bb94ad80 R08: 000000000000000a R09: 00000000ffffffff
> >R10: 000000000000000a R11: 0000000000000246 R12: 00007f99db36f760
> >R13: 0000000000000002 R14: 00007f99db370560 R15: 00007f99db36f960
> >
> >Allocated by task 6360:
> >  save_stack+0x21/0x90
> >  __kasan_kmalloc.constprop.9+0xc7/0xd0
> >  kasan_kmalloc+0x9/0x10
> >  kmem_cache_alloc_trace+0x15a/0x3a0
> >  siw_create_qp+0x206/0xe10 [siw]
> >  ib_create_qp_user+0x11e/0x710 [ib_core]
> >  rdma_create_qp+0x6c/0x140 [rdma_cm]
> >  nvme_rdma_create_qp.constprop.58+0x130/0x180 [nvme_rdma]
> >  nvme_rdma_cm_handler+0x716/0xdb0 [nvme_rdma]
> >  addr_handler+0x181/0x2c0 [rdma_cm]
> >  process_one_req+0x8c/0x280 [ib_core]
> >  process_one_work+0x51a/0xa60
> >  worker_thread+0x67/0x5b0
> >  kthread+0x1dc/0x200
> >  ret_from_fork+0x24/0x30
> >
> >Freed by task 9926:
> >  save_stack+0x21/0x90
> >  __kasan_slab_free+0x139/0x190
> >  kasan_slab_free+0xe/0x10
> >  kfree+0x101/0x3a0
> >  siw_destroy_qp+0x1cd/0x290 [siw]
> >  ib_destroy_qp_user+0x155/0x380 [ib_core]
> >  nvme_rdma_destroy_queue_ib+0x78/0xe0 [nvme_rdma]
> >  nvme_rdma_free_queue+0x2c/0x50 [nvme_rdma]
> >  nvme_rdma_destroy_io_queues+0x55/0xb0 [nvme_rdma]
> >  nvme_rdma_teardown_io_queues.part.32+0xca/0xe0 [nvme_rdma]
> >  nvme_rdma_shutdown_ctrl+0x50/0xa0 [nvme_rdma]
> >  nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
> >  nvme_do_delete_ctrl+0x97/0xe1 [nvme_core]
> >  nvme_sysfs_delete.cold.95+0x8/0xd [nvme_core]
> >  dev_attr_store+0x3c/0x50
> >  sysfs_kf_write+0x87/0xa0
> >  kernfs_fop_write+0x186/0x240
> >  __vfs_write+0x4d/0x90
> >  vfs_write+0xfa/0x290
> >  ksys_write+0xc3/0x160
> >  __x64_sys_write+0x43/0x50
> >  do_syscall_64+0x6b/0x2d0
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> >The buggy address belongs to the object at ffff8881024fe300
> >  which belongs to the cache kmalloc-512 of size 512
> >The buggy address is located 400 bytes inside of
> >  512-byte region [ffff8881024fe300, ffff8881024fe500)
> >The buggy address belongs to the page:
> >page:ffffea0004093f00 refcount:1 mapcount:0 mapping:ffff88811a80e580 
> >index:0xffff8881024fd680 compound_mapcount: 0
> >flags: 0x2fff000000010200(slab|head)
> >raw: 2fff000000010200 ffffea000406a300 0000000400000004
> >ffff88811a80e580
> >raw: ffff8881024fd680 0000000080190018 00000001ffffffff
> >0000000000000000
> >page dumped because: kasan: bad access detected
> >
> >Memory state around the buggy address:
> >  ffff8881024fe380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8881024fe400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff8881024fe480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                          ^
> >  ffff8881024fe500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff8881024fe580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >==================================================================
> >
> >
> 
