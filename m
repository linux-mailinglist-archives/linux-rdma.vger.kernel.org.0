Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB42C29F8
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfI3WtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 18:49:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36470 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfI3WtS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 18:49:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so6448066pfr.3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 15:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mz5sbBg5kLkf8l56SWUWa5Dk+jWjIuFthk2+IwfhdVg=;
        b=WYUCNidRoFeZbmiNacy6poofM3v6nYw4wmv8UUKpK+z65HvKinnxhLji2qURCND6ps
         w8NMhMXUmf6rQfLkGTp24/SpNiJ/EK83f2rN5udpaftyHKfNMGrhBQKq6ov00BOpFENU
         foMANihwzKaRRHfaMNgAC2ckIMaFOHY4y79jjShwAqviuiBpU0ERkpDGsq4F1JLsf3wP
         oMqXYAq1+dbwjApLXE9fgxB8EMC3zkK6gVbrxTgg8rezKfPnQWx9ciXA58Ku+nP1ldEE
         XFvYJ7th6z+CWHTo3s7R9TO7j2OOdG0GvxJZoVofnTT/khTT5UKP8YaXhPH2MtccTk+Y
         a4IQ==
X-Gm-Message-State: APjAAAUe6QUf1gR7bR1XJ/lvvYIje66k2pDWK5G6KjhhGJqymWYZcLna
        JtuNT4qZbqFN4LZMRsXMQV9A0qmm
X-Google-Smtp-Source: APXvYqwIzaTUJOzzi20DWzofasCwo2yVc2zFJPlZ6EFH37YQv8GqhtwwR0NB5XrnjtPq7s4VdA0rzg==
X-Received: by 2002:a65:56c8:: with SMTP id w8mr26746294pgs.100.1569883757072;
        Mon, 30 Sep 2019 15:49:17 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s141sm16312959pfs.13.2019.09.30.15.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 15:49:16 -0700 (PDT)
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: BUG: KASAN: use-after-free in siw_qp_put_ref
Message-ID: <2b0ae7d3-0dc9-94c0-0092-e32fb2c9cb45@acm.org>
Date:   Mon, 30 Sep 2019 15:49:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

The complaint shown below was reported while I was running blktests 
after having configured the siw driver. I'm not sure whether this is an 
NVMe driver or siw driver bug. So far I have encountered this complaint 
only with the siw driver but not yet with the rdma_rxe driver.

Bart.

==================================================================
BUG: KASAN: use-after-free in siw_qp_put_ref+0x19/0x40 [siw]
Read of size 8 at addr ffff8881024fe490 by task check/9926

CPU: 1 PID: 9926 Comm: check Not tainted 5.4.0-rc1-dbg+ #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 
04/01/2014
Call Trace:
  dump_stack+0x86/0xca
  print_address_description.constprop.7+0x40/0x60
  __kasan_report.cold.10+0x1b/0x39
  kasan_report+0x12/0x20
  __asan_load8+0x54/0x90
  siw_qp_put_ref+0x19/0x40 [siw]
  destroy_cm_id+0x181/0x330 [iw_cm]
  iw_destroy_cm_id+0xe/0x10 [iw_cm]
  rdma_destroy_id+0x3ee/0x460 [rdma_cm]
  nvme_rdma_free_queue+0x3e/0x50 [nvme_rdma]
  nvme_rdma_destroy_io_queues+0x55/0xb0 [nvme_rdma]
  nvme_rdma_teardown_io_queues.part.32+0xca/0xe0 [nvme_rdma]
  nvme_rdma_shutdown_ctrl+0x50/0xa0 [nvme_rdma]
  nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
  nvme_do_delete_ctrl+0x97/0xe1 [nvme_core]
  nvme_sysfs_delete.cold.95+0x8/0xd [nvme_core]
  dev_attr_store+0x3c/0x50
  sysfs_kf_write+0x87/0xa0
  kernfs_fop_write+0x186/0x240
  __vfs_write+0x4d/0x90
  vfs_write+0xfa/0x290
  ksys_write+0xc3/0x160
  __x64_sys_write+0x43/0x50
  do_syscall_64+0x6b/0x2d0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f99db297024
Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 
48 8d 05 b9 d3 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
RSP: 002b:00007ffe02f8b228 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99db297024
RDX: 0000000000000002 RSI: 00005615bb94ad80 RDI: 0000000000000001
RBP: 00005615bb94ad80 R08: 000000000000000a R09: 00000000ffffffff
R10: 000000000000000a R11: 0000000000000246 R12: 00007f99db36f760
R13: 0000000000000002 R14: 00007f99db370560 R15: 00007f99db36f960

Allocated by task 6360:
  save_stack+0x21/0x90
  __kasan_kmalloc.constprop.9+0xc7/0xd0
  kasan_kmalloc+0x9/0x10
  kmem_cache_alloc_trace+0x15a/0x3a0
  siw_create_qp+0x206/0xe10 [siw]
  ib_create_qp_user+0x11e/0x710 [ib_core]
  rdma_create_qp+0x6c/0x140 [rdma_cm]
  nvme_rdma_create_qp.constprop.58+0x130/0x180 [nvme_rdma]
  nvme_rdma_cm_handler+0x716/0xdb0 [nvme_rdma]
  addr_handler+0x181/0x2c0 [rdma_cm]
  process_one_req+0x8c/0x280 [ib_core]
  process_one_work+0x51a/0xa60
  worker_thread+0x67/0x5b0
  kthread+0x1dc/0x200
  ret_from_fork+0x24/0x30

Freed by task 9926:
  save_stack+0x21/0x90
  __kasan_slab_free+0x139/0x190
  kasan_slab_free+0xe/0x10
  kfree+0x101/0x3a0
  siw_destroy_qp+0x1cd/0x290 [siw]
  ib_destroy_qp_user+0x155/0x380 [ib_core]
  nvme_rdma_destroy_queue_ib+0x78/0xe0 [nvme_rdma]
  nvme_rdma_free_queue+0x2c/0x50 [nvme_rdma]
  nvme_rdma_destroy_io_queues+0x55/0xb0 [nvme_rdma]
  nvme_rdma_teardown_io_queues.part.32+0xca/0xe0 [nvme_rdma]
  nvme_rdma_shutdown_ctrl+0x50/0xa0 [nvme_rdma]
  nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
  nvme_do_delete_ctrl+0x97/0xe1 [nvme_core]
  nvme_sysfs_delete.cold.95+0x8/0xd [nvme_core]
  dev_attr_store+0x3c/0x50
  sysfs_kf_write+0x87/0xa0
  kernfs_fop_write+0x186/0x240
  __vfs_write+0x4d/0x90
  vfs_write+0xfa/0x290
  ksys_write+0xc3/0x160
  __x64_sys_write+0x43/0x50
  do_syscall_64+0x6b/0x2d0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881024fe300
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 400 bytes inside of
  512-byte region [ffff8881024fe300, ffff8881024fe500)
The buggy address belongs to the page:
page:ffffea0004093f00 refcount:1 mapcount:0 mapping:ffff88811a80e580 
index:0xffff8881024fd680 compound_mapcount: 0
flags: 0x2fff000000010200(slab|head)
raw: 2fff000000010200 ffffea000406a300 0000000400000004 ffff88811a80e580
raw: ffff8881024fd680 0000000080190018 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881024fe380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881024fe400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff8881024fe480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881024fe500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881024fe580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
