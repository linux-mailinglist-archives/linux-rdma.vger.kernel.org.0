Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7BC33DD
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfJAMIb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 1 Oct 2019 08:08:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbfJAMIa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 08:08:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91C6drx107884
        for <linux-rdma@vger.kernel.org>; Tue, 1 Oct 2019 08:08:29 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vc63s8y96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:08:29 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 1 Oct 2019 12:08:28 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 1 Oct 2019 12:08:23 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019100112082271-436537 ;
          Tue, 1 Oct 2019 12:08:22 +0000 
In-Reply-To: <2b0ae7d3-0dc9-94c0-0092-e32fb2c9cb45@acm.org>
Subject: Re: BUG: KASAN: use-after-free in siw_qp_put_ref
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Date:   Tue, 1 Oct 2019 12:08:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <2b0ae7d3-0dc9-94c0-0092-e32fb2c9cb45@acm.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 20567
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19100112-2475-0000-0000-000000D51F21
X-IBM-SpamModules-Scores: BY=0.229859; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.013010
X-IBM-SpamModules-Versions: BY=3.00011870; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01269155; UDB=6.00671691; IPR=6.01051181;
 MB=3.00028898; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-01 12:08:26
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-01 11:46:59 - 6.00010474
x-cbparentid: 19100112-2476-0000-0000-00002D39579B
Message-Id: <OF0B426945.C9BEAB54-ON00258486.00410759-00258486.0042AF87@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bart Van Assche" <bvanassche@acm.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>, "linux-rdma"
><linux-rdma@vger.kernel.org>
>From: "Bart Van Assche" <bvanassche@acm.org>
>Date: 10/01/2019 12:49AM
>Subject: [EXTERNAL] BUG: KASAN: use-after-free in siw_qp_put_ref
>
>Hi Bernard,
>
>The complaint shown below was reported while I was running blktests 
>after having configured the siw driver. I'm not sure whether this is
>an 
>NVMe driver or siw driver bug. So far I have encountered this
>complaint 
>only with the siw driver but not yet with the rdma_rxe driver.
>
>Bart.

Hi Bart,

Many thanks for finding this. I expect this to be an siw issue.
Related/caused by the issue Krishna (on CC) reported recently.
siw provides specific drain functions for ib_drain_sq() and
ib_drain_rq(), but does not adhere to its intended semantics
- waiting until the SQ/RQ is completely drained to the CQ and
its completions are consumed by the application.

I see the NVME host calling nvme_rdma_teardown_io_queues()->
nvme_rdma_stop_io_queues()->nvme_rdma_stop_queue()->
__nvme_rdma_stop_queue->ib_drain_qp() , which calls
the driver specific drain routines. 

So let's fix that.

Thanks
Bernard.

>
>==================================================================
>BUG: KASAN: use-after-free in siw_qp_put_ref+0x19/0x40 [siw]
>Read of size 8 at addr ffff8881024fe490 by task check/9926
>
>CPU: 1 PID: 9926 Comm: check Not tainted 5.4.0-rc1-dbg+ #13
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 
>04/01/2014
>Call Trace:
>  dump_stack+0x86/0xca
>  print_address_description.constprop.7+0x40/0x60
>  __kasan_report.cold.10+0x1b/0x39
>  kasan_report+0x12/0x20
>  __asan_load8+0x54/0x90
>  siw_qp_put_ref+0x19/0x40 [siw]
>  destroy_cm_id+0x181/0x330 [iw_cm]
>  iw_destroy_cm_id+0xe/0x10 [iw_cm]
>  rdma_destroy_id+0x3ee/0x460 [rdma_cm]
>  nvme_rdma_free_queue+0x3e/0x50 [nvme_rdma]
>  nvme_rdma_destroy_io_queues+0x55/0xb0 [nvme_rdma]
>  nvme_rdma_teardown_io_queues.part.32+0xca/0xe0 [nvme_rdma]
>  nvme_rdma_shutdown_ctrl+0x50/0xa0 [nvme_rdma]
>  nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
>  nvme_do_delete_ctrl+0x97/0xe1 [nvme_core]
>  nvme_sysfs_delete.cold.95+0x8/0xd [nvme_core]
>  dev_attr_store+0x3c/0x50
>  sysfs_kf_write+0x87/0xa0
>  kernfs_fop_write+0x186/0x240
>  __vfs_write+0x4d/0x90
>  vfs_write+0xfa/0x290
>  ksys_write+0xc3/0x160
>  __x64_sys_write+0x43/0x50
>  do_syscall_64+0x6b/0x2d0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>RIP: 0033:0x7f99db297024
>Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00
>00 
>48 8d 05 b9 d3 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d
>00 
>f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
>RSP: 002b:00007ffe02f8b228 EFLAGS: 00000246 ORIG_RAX:
>0000000000000001
>RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99db297024
>RDX: 0000000000000002 RSI: 00005615bb94ad80 RDI: 0000000000000001
>RBP: 00005615bb94ad80 R08: 000000000000000a R09: 00000000ffffffff
>R10: 000000000000000a R11: 0000000000000246 R12: 00007f99db36f760
>R13: 0000000000000002 R14: 00007f99db370560 R15: 00007f99db36f960
>
>Allocated by task 6360:
>  save_stack+0x21/0x90
>  __kasan_kmalloc.constprop.9+0xc7/0xd0
>  kasan_kmalloc+0x9/0x10
>  kmem_cache_alloc_trace+0x15a/0x3a0
>  siw_create_qp+0x206/0xe10 [siw]
>  ib_create_qp_user+0x11e/0x710 [ib_core]
>  rdma_create_qp+0x6c/0x140 [rdma_cm]
>  nvme_rdma_create_qp.constprop.58+0x130/0x180 [nvme_rdma]
>  nvme_rdma_cm_handler+0x716/0xdb0 [nvme_rdma]
>  addr_handler+0x181/0x2c0 [rdma_cm]
>  process_one_req+0x8c/0x280 [ib_core]
>  process_one_work+0x51a/0xa60
>  worker_thread+0x67/0x5b0
>  kthread+0x1dc/0x200
>  ret_from_fork+0x24/0x30
>
>Freed by task 9926:
>  save_stack+0x21/0x90
>  __kasan_slab_free+0x139/0x190
>  kasan_slab_free+0xe/0x10
>  kfree+0x101/0x3a0
>  siw_destroy_qp+0x1cd/0x290 [siw]
>  ib_destroy_qp_user+0x155/0x380 [ib_core]
>  nvme_rdma_destroy_queue_ib+0x78/0xe0 [nvme_rdma]
>  nvme_rdma_free_queue+0x2c/0x50 [nvme_rdma]
>  nvme_rdma_destroy_io_queues+0x55/0xb0 [nvme_rdma]
>  nvme_rdma_teardown_io_queues.part.32+0xca/0xe0 [nvme_rdma]
>  nvme_rdma_shutdown_ctrl+0x50/0xa0 [nvme_rdma]
>  nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
>  nvme_do_delete_ctrl+0x97/0xe1 [nvme_core]
>  nvme_sysfs_delete.cold.95+0x8/0xd [nvme_core]
>  dev_attr_store+0x3c/0x50
>  sysfs_kf_write+0x87/0xa0
>  kernfs_fop_write+0x186/0x240
>  __vfs_write+0x4d/0x90
>  vfs_write+0xfa/0x290
>  ksys_write+0xc3/0x160
>  __x64_sys_write+0x43/0x50
>  do_syscall_64+0x6b/0x2d0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
>The buggy address belongs to the object at ffff8881024fe300
>  which belongs to the cache kmalloc-512 of size 512
>The buggy address is located 400 bytes inside of
>  512-byte region [ffff8881024fe300, ffff8881024fe500)
>The buggy address belongs to the page:
>page:ffffea0004093f00 refcount:1 mapcount:0 mapping:ffff88811a80e580 
>index:0xffff8881024fd680 compound_mapcount: 0
>flags: 0x2fff000000010200(slab|head)
>raw: 2fff000000010200 ffffea000406a300 0000000400000004
>ffff88811a80e580
>raw: ffff8881024fd680 0000000080190018 00000001ffffffff
>0000000000000000
>page dumped because: kasan: bad access detected
>
>Memory state around the buggy address:
>  ffff8881024fe380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8881024fe400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8881024fe480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff8881024fe500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8881024fe580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>==================================================================
>
>

