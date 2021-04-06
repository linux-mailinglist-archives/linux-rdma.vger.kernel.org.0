Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2B35531E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbhDFMGI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbhDFMGH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:06:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B9C061756
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:05:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z1so16245341edb.8
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmL7U6+BA0iy7JOsRi7eOMjkS5W/YZa2DhQz8FWYzU4=;
        b=R4V1Ylg63XgQtKSChPI+PWsEP18znS4dEMJKfGUeqEP+i0cioL41T9xYprAy2JsqPj
         CquSmmuAscozF/J7jWaKL64dUgrr2KZ6SuYQdexCL03VaBXE1HtuusrUeSYjR/hO2ww4
         JIXMExUA7xorBBNHiDI2u1AnvoEkFYkMQ3I5jh3ZnCCfwy0QYcwgM249jSd6eeg2VUdn
         kdxzaTdwJMMKAK7G0PVTYWKMykN++3MiDnjg1L5aPntReYyxqGlDV+tyHlMVDfISqaMe
         ywpSneoz6vvd9CbFj5xOCr3CUbXvpxDQ4JesQwVvR4veV06eRBHB+eKJ/CoTtXE7QhKW
         Ooqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmL7U6+BA0iy7JOsRi7eOMjkS5W/YZa2DhQz8FWYzU4=;
        b=mMEgevCnG/cLfNrknzMZNgn0oF1pPoVegIUW7ouLIdvZ62e7VYYHWoJJ4OPIBohqDZ
         xkbbokwY63939Wb9bjHd5Ygw13/fIa3wIaYTKFHLBrbuyvdjEmZdegAWYP7rlYil0FvW
         XlTp/tx97rKt8k226q2i6HKPQpCDiz64lAnKnrOW7rnct9Vu5nwJ6xynnwDIislsDlj2
         9j1XolEhLNdym0PHw6NDx9wbMxwAPtkRIBcFrK9BWPbMWRJ4kQCHhNVOJUV1d6A3mgVv
         akYk4ddc5RmDho2KbHlYNKGGNQI2SjkWrk29SAC/GCtr9PNeW9RCpkTv44VkyRJZ5f5I
         g74A==
X-Gm-Message-State: AOAM530A6kCRcPnTxN9Q0ZZYzeVdSFeTISZZXhVLxUqyVCO9lU0GlulH
        zTM28rthKWqKWh4KMnjq0fAB0OeNfuv1NJDB
X-Google-Smtp-Source: ABdhPJx8NK98qmRZEPmAdpCAXdjCciswjvJN8fDivRB6P49GmfJU9S4tA+S/shSBtKAhmj2m/VeAtg==
X-Received: by 2002:a05:6402:1759:: with SMTP id v25mr15770085edx.177.1617710757723;
        Tue, 06 Apr 2021 05:05:57 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id jj15sm10987694ejc.99.2021.04.06.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:05:57 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 3/4] RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its stats
Date:   Tue,  6 Apr 2021 14:05:52 +0200
Message-Id: <20210406120553.197848-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406120553.197848-1-gi-oh.kim@ionos.com>
References: <20210406120553.197848-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

KASAN detected the following BUG:
[  230.436512] ==================================================================
[  230.437182] BUG: KASAN: use-after-free in get_next_path_min_inflight+0x95/0x150 [rtrs_client]
[  230.437632] Read of size 4 at addr ffff88a796b4bb50 by task fio/4130

[  230.438069] CPU: 32 PID: 4130 Comm: fio Tainted: G           O      5.4.84-pserver #5.4.84-1+feature+linux+5.4.y+dbg+20201216.1319+b6b887b~deb10
[  230.438079] Hardware name: Supermicro H8QG6/H8QG6, BIOS 3.00       09/04/2012
[  230.438088] Call Trace:
[  230.438111]  dump_stack+0x96/0xe0
[  230.438136]  print_address_description.constprop.4+0x1f/0x300
[  230.438150]  ? irq_work_claim+0x2e/0x50
[  230.438172]  __kasan_report.cold.8+0x78/0x92
[  230.438203]  ? get_next_path_min_inflight+0x95/0x150 [rtrs_client]
[  230.438234]  kasan_report+0x10/0x20
[  230.438249]  check_memory_region+0x144/0x1c0
[  230.438274]  get_next_path_min_inflight+0x95/0x150 [rtrs_client]
[  230.438312]  rtrs_clt_request+0x1fe/0x700 [rtrs_client]
[  230.438364]  ? rtrs_clt_close_work+0x40/0x40 [rtrs_client]
[  230.438395]  ? rtrs_clt_change_state_get_old+0x70/0x70 [rtrs_client]
[  230.438417]  ? blk_mq_start_request+0x1a4/0x2c0
[  230.438430]  ? blk_rq_map_sg+0x3d5/0xaa0
[  230.438468]  ? round_jiffies_up+0x60/0x90
[  230.438511]  rnbd_queue_rq+0x3e2/0x870 [rnbd_client]
[  230.438567]  ? rnbd_softirq_done_fn+0x90/0x90 [rnbd_client]
[  230.438587]  ? rnbd_get_permit+0x50/0x50 [rnbd_client]
[  230.438601]  ? __lock_acquire+0x68e/0x23a0
[  230.438635]  ? blk_mq_get_driver_tag+0xbe/0x250
[  230.438652]  ? blk_mq_dequeue_from_ctx+0x4d0/0x4d0
[  230.438663]  ? lock_acquire+0xf3/0x210
[  230.438726]  __blk_mq_try_issue_directly+0x272/0x390
[  230.438752]  ? blk_mq_get_driver_tag+0x250/0x250
[  230.438785]  ? rcu_is_watching+0x34/0x50
[  230.438816]  blk_mq_request_issue_directly+0xa8/0xf0
[  230.438833]  ? blk_mq_flush_plug_list+0x690/0x690
[  230.438859]  ? lock_downgrade+0x390/0x390
[  230.438892]  ? lock_acquire+0xf3/0x210
[  230.438920]  blk_mq_try_issue_list_directly+0xa1/0x160
[  230.438952]  blk_mq_sched_insert_requests+0x23c/0x390
[  230.438992]  blk_mq_flush_plug_list+0x361/0x690
[  230.439037]  ? blk_mq_insert_requests+0x300/0x300
[  230.439058]  ? current_time+0x8c/0xe0
[  230.439074]  ? timestamp_truncate+0x180/0x180
[  230.439101]  ? file_remove_privs+0xb4/0x1f0
[  230.439139]  blk_flush_plug_list+0x1d1/0x210
[  230.439167]  ? blk_insert_cloned_request+0x1e0/0x1e0
[  230.439220]  blk_finish_plug+0x3c/0x54
[  230.439243]  blkdev_write_iter+0x173/0x260
[  230.439272]  ? bd_finish_claiming+0xe0/0xe0
[  230.439298]  ? 0xffffffff9a000000
[  230.439330]  ? rw_verify_area+0xd9/0x130
[  230.439359]  aio_write+0x1d3/0x300
[  230.439387]  ? aio_read+0x260/0x260
[  230.439477]  ? lock_downgrade+0x390/0x390
[  230.439497]  ? lock_acquire+0xf3/0x210
[  230.439512]  ? __might_fault+0x7d/0xe0
[  230.439570]  io_submit_one+0xccc/0x1920
[  230.439633]  ? aio_poll_complete_work+0x850/0x850
[  230.439735]  ? __x64_sys_io_submit+0x118/0x380
[  230.439748]  __x64_sys_io_submit+0x118/0x380
[  230.439777]  ? __ia32_compat_sys_io_submit+0x360/0x360
[  230.439793]  ? __x64_sys_io_getevents+0xd7/0x150
[  230.439807]  ? mark_held_locks+0x29/0xa0
[  230.439827]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  230.439840]  ? trace_hardirqs_off_caller+0x15/0x110
[  230.439857]  ? mark_held_locks+0x29/0xa0
[  230.439893]  ? do_syscall_64+0x68/0x270
[  230.439903]  do_syscall_64+0x68/0x270
[  230.439924]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  230.439936] RIP: 0033:0x7f8f10233f59
[  230.439948] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 89 01 48
[  230.439958] RSP: 002b:00007fff1df1d238 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
[  230.439970] RAX: ffffffffffffffda RBX: 00007f8f104ec360 RCX: 00007f8f10233f59
[  230.439980] RDX: 0000555c4c1f9440 RSI: 0000000000000001 RDI: 00007f8f04730000
[  230.439989] RBP: 00007f8f04730000 R08: 0000555c4c1c97f0 R09: 00000000000001e0
[  230.439998] R10: 0000555c4c1f9670 R11: 0000000000000246 R12: 0000000000000001
[  230.440007] R13: 0000000000000000 R14: 0000555c4c1f9440 R15: 00007f8ee30b5210

[  230.440257] Allocated by task 3440:
[  230.440471]  save_stack+0x19/0x80
[  230.440482]  __kasan_kmalloc.constprop.9+0xc1/0xd0
[  230.440492]  kmem_cache_alloc_trace+0x15b/0x350
[  230.440508]  alloc_sess+0xf4/0x570 [rtrs_client]
[  230.440524]  rtrs_clt_open+0x3b4/0x780 [rtrs_client]
[  230.440538]  find_and_get_or_create_sess+0x649/0x9d0 [rnbd_client]
[  230.440551]  rnbd_clt_map_device+0xd7/0xf50 [rnbd_client]
[  230.440565]  rnbd_clt_map_device_store+0x4ee/0x970 [rnbd_client]
[  230.440577]  kernfs_fop_write+0x141/0x240
[  230.440587]  vfs_write+0xf3/0x280
[  230.440598]  ksys_write+0xba/0x150
[  230.440608]  do_syscall_64+0x68/0x270
[  230.440619]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  230.440806] Freed by task 4148:
[  230.441013]  save_stack+0x19/0x80
[  230.441024]  __kasan_slab_free+0x125/0x170
[  230.441034]  kfree+0xe7/0x3f0
[  230.441045]  kobject_put+0xd3/0x240
[  230.441061]  rtrs_clt_destroy_sess_files+0x3f/0x60 [rtrs_client]
[  230.441076]  rtrs_clt_remove_path_from_sysfs+0x95/0xe0 [rtrs_client]
[  230.441092]  rtrs_clt_remove_path_store+0x3e/0xa0 [rtrs_client]
[  230.441103]  kernfs_fop_write+0x141/0x240
[  230.441113]  vfs_write+0xf3/0x280
[  230.441123]  ksys_write+0xba/0x150
[  230.441133]  do_syscall_64+0x68/0x270
[  230.441145]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  230.441333] The buggy address belongs to the object at ffff88a796b4bb00
                which belongs to the cache kmalloc-96 of size 96
[  230.441705] The buggy address is located 80 bytes inside of
                96-byte region [ffff88a796b4bb00, ffff88a796b4bb60)
[  230.442063] The buggy address belongs to the page:
[  230.442294] page:ffffea009e5ad2c0 refcount:1 mapcount:0 mapping:ffff8887c6016e00 index:0x0
[  230.442305] flags: 0x12ffff8000000200(slab)
[  230.442320] raw: 12ffff8000000200 dead000000000100 dead000000000122 ffff8887c6016e00
[  230.442332] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
[  230.442340] page dumped because: kasan: bad access detected

[  230.442525] Memory state around the buggy address:
[  230.442756]  ffff88a796b4ba00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  230.443059]  ffff88a796b4ba80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  230.443359] >ffff88a796b4bb00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  230.443681]                                                  ^
[  230.443935]  ffff88a796b4bb80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[  230.444233]  ffff88a796b4bc00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  230.444529] ==================================================================

When get_next_path_min_inflight is called to select the next path, it
iterates over the list of available rtrs_clt_sess (paths). It then reads
the number of inflight IOs for that path to select one which has the least

But it may so happen that that rtrs_clt_sess (path) is no longer in the
connected state, and like in the above BUG its resources have also been
freed.

So, check the state of the rtrs_clt_sess (path) before going ahead to read
its inflight stats.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 4ccdd364777a..8dc1381d8ae5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -812,6 +812,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
 	int inflight;
 
 	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
+		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
+			continue;
+
 		if (unlikely(!list_empty(raw_cpu_ptr(sess->mp_skip_entry))))
 			continue;
 
-- 
2.25.1

