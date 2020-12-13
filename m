Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F12D8C7C
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Dec 2020 10:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405233AbgLMJLk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Dec 2020 04:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728170AbgLMJLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Dec 2020 04:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607850611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=hdLuYRofGLbzD2Aes1RODIzUkexBoDHfHqf2Iv+a4Xk=;
        b=VsybaQDSlqncWwf27wKH3hsq3Mc8KbvOsc7a/VNO+7HiknB8BRpYWuEORxzVew9Pa/jvQp
        wKGkHEq77cc8bblXFoxtBzyWbnEF02Rcck2kPm6i7I7DatnepVCVoW/JRqrJYOAz6XfCHn
        bFNAkxupufAmQNdCamvYfJaYB2UsGD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-4jclS1jTMZ2axmngYSiCHQ-1; Sun, 13 Dec 2020 04:10:08 -0500
X-MC-Unique: 4jclS1jTMZ2axmngYSiCHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F12107ACF7;
        Sun, 13 Dec 2020 09:10:07 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B031FBC7;
        Sun, 13 Dec 2020 09:10:07 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B0CCF4BB7B;
        Sun, 13 Dec 2020 09:10:06 +0000 (UTC)
Date:   Sun, 13 Dec 2020 04:10:06 -0500 (EST)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Message-ID: <393763922.6141630.1607850606138.JavaMail.zimbra@redhat.com>
In-Reply-To: <2073040338.6085130.1607745779176.JavaMail.zimbra@redhat.com>
Subject: UBSAN observed with blktests use_siw nvme-rdma nvme/003 on
 5.10.0-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.9]
Thread-Topic: UBSAN observed with blktests use_siw nvme-rdma nvme/003 on 5.10.0-rc7
Thread-Index: PAGaaKQOuFahzVU/mJkaAmACvmZYDg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi

I found this UBSAN issue with latest 5.10.0-rc7, could anyone help check it?

on x86_64:
[  339.588782] run blktests nvme/003 at 2020-12-11 22:58:49
[  340.716474] SoftiWARP attached
[  340.768279] eno2 speed is unknown, defaulting to 1000
[  340.768378] eno2 speed is unknown, defaulting to 1000
[  340.768983] eno2 speed is unknown, defaulting to 1000
[  340.785478] eno3 speed is unknown, defaulting to 1000
[  340.785549] eno3 speed is unknown, defaulting to 1000
[  340.786220] eno3 speed is unknown, defaulting to 1000
[  340.802511] eno4 speed is unknown, defaulting to 1000
[  340.802582] eno4 speed is unknown, defaulting to 1000
[  340.803239] eno4 speed is unknown, defaulting to 1000
[  340.819554] lo speed is unknown, defaulting to 1000
[  340.819625] lo speed is unknown, defaulting to 1000
[  340.820274] lo speed is unknown, defaulting to 1000
[  342.139810] loop: module loaded
[  342.213031] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  342.243137] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[  342.247364] nvmet_rdma: enabling port 0 (10.10.183.223:4420)
[  342.320993] ================================================================================
[  342.321696] UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
[  342.321845] shift exponent 64 is too large for 64-bit type 'long unsigned int'
[  342.322005] CPU: 4 PID: 441 Comm: kworker/u12:9 Tainted: G S                5.10.0-rc7 #1
[  342.322014] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.1.10 03/10/2015
[  342.322029] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
[  342.322045] Call Trace:
[  342.322063]  dump_stack+0x99/0xcb
[  342.322082]  ubsan_epilogue+0x5/0x40
[  342.322092]  __ubsan_handle_shift_out_of_bounds.cold.11+0xb4/0xf3
[  342.322121]  ? down_write+0x183/0x3d0
[  342.322155]  siw_qp_modify.cold.8+0x2d/0x32 [siw]
[  342.322168]  ? __local_bh_enable_ip+0xa5/0xf0
[  342.322199]  siw_accept+0x906/0x1b60 [siw]
[  342.322241]  ? siw_connect+0x17a0/0x17a0 [siw]
[  342.322268]  ? mark_held_locks+0xb7/0x120
[  342.322294]  ? lockdep_hardirqs_on_prepare+0x28f/0x3e0
[  342.322303]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[  342.322332]  iw_cm_accept+0x1f4/0x430 [iw_cm]
[  342.322369]  rdma_accept+0x3fa/0xb10 [rdma_cm]
[  342.322383]  ? check_flush_dependency+0x410/0x410
[  342.322402]  ? cma_rep_recv+0x570/0x570 [rdma_cm]
[  342.322434]  ? complete+0x18/0x70
[  342.322481]  nvmet_rdma_queue_connect+0x1a62/0x2680 [nvmet_rdma]
[  342.322541]  ? nvmet_rdma_alloc_cmds+0xce0/0xce0 [nvmet_rdma]
[  342.322563]  ? lock_downgrade+0x700/0x700
[  342.322583]  ? __xa_alloc_cyclic+0xef/0x350
[  342.322642]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  342.322651]  ? __ww_mutex_die+0x190/0x190
[  342.322685]  cma_cm_event_handler+0xf2/0x500 [rdma_cm]
[  342.322712]  iw_conn_req_handler+0x910/0xcb0 [rdma_cm]
[  342.322726]  ? lock_downgrade+0x700/0x700
[  342.322734]  ? rcu_read_unlock+0x50/0x50
[  342.322748]  ? sched_clock+0x5/0x10
[  342.322789]  ? cma_ib_handler+0x8a0/0x8a0 [rdma_cm]
[  342.322810]  ? __kasan_kmalloc.constprop.7+0xc1/0xd0
[  342.322875]  cm_work_handler+0x121c/0x17a0 [iw_cm]
[  342.322910]  ? iw_cm_reject+0x190/0x190 [iw_cm]
[  342.323005]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  342.323016]  ? lockdep_hardirqs_on_prepare+0x28f/0x3e0
[  342.323043]  process_one_work+0x8fb/0x16c0
[  342.323054]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  342.323091]  ? pwq_dec_nr_in_flight+0x320/0x320
[  342.323141]  worker_thread+0x87/0xb40
[  342.323177]  ? process_one_work+0x16c0/0x16c0
[  342.323191]  kthread+0x35f/0x430
[  342.323203]  ? kthread_mod_delayed_work+0x180/0x180
[  342.323223]  ret_from_fork+0x22/0x30
[  342.323319] ================================================================================
[  342.335402] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:ce2e8205-87d6-4212-b108-e1f267e1c459.
[  342.341153] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.10.183.223:4420
[  352.445399] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

[  352.484535] ======================================================
[  352.484608] WARNING: possible circular locking dependency detected
[  352.484683] 5.10.0-rc7 #1 Tainted: G S               
[  352.484743] ------------------------------------------------------
[  352.484816] kworker/1:1/51 is trying to acquire lock:
[  352.484878] ffff88820928f3e0 (&id_priv->handler_mutex){+.+.}-{3:3}, at: rdma_destroy_id+0x17/0x20 [rdma_cm]
[  352.485013] 
               but task is already holding lock:
[  352.485081] ffff888100f3fe00 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x809/0x16c0
[  352.485215] 
               which lock already depends on the new lock.

[  352.485307] 
               the existing dependency chain (in reverse order) is:
[  352.485392] 
               -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
[  352.485499]        lock_acquire+0x1c8/0x880
[  352.485552]        process_one_work+0x85a/0x16c0
[  352.485610]        worker_thread+0x87/0xb40
[  352.485663]        kthread+0x35f/0x430
[  352.485712]        ret_from_fork+0x22/0x30
[  352.485763] 
               -> #2 ((wq_completion)events){+.+.}-{0:0}:
[  352.485851]        lock_acquire+0x1c8/0x880
[  352.485904]        flush_workqueue+0x109/0x1390
[  352.485963]        nvmet_rdma_queue_connect+0x1b52/0x2680 [nvmet_rdma]
[  352.486046]        cma_cm_event_handler+0xf2/0x500 [rdma_cm]
[  352.486121]        iw_conn_req_handler+0x910/0xcb0 [rdma_cm]
[  352.486192]        cm_work_handler+0x121c/0x17a0 [iw_cm]
[  352.486257]        process_one_work+0x8fb/0x16c0
[  352.486315]        worker_thread+0x87/0xb40
[  352.486367]        kthread+0x35f/0x430
[  352.486415]        ret_from_fork+0x22/0x30
[  352.486466] 
               -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
[  352.490786]        lock_acquire+0x1c8/0x880
[  352.492963]        __mutex_lock+0x163/0x1410
[  352.495140]        iw_conn_req_handler+0x343/0xcb0 [rdma_cm]
[  352.497264]        cm_work_handler+0x121c/0x17a0 [iw_cm]
[  352.499321]        process_one_work+0x8fb/0x16c0
[  352.501358]        worker_thread+0x87/0xb40
[  352.503412]        kthread+0x35f/0x430
[  352.505469]        ret_from_fork+0x22/0x30
[  352.507474] 
               -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
[  352.511362]        check_prevs_add+0x3fd/0x2460
[  352.513280]        __lock_acquire+0x255e/0x3080
[  352.515151]        lock_acquire+0x1c8/0x880
[  352.517001]        __mutex_lock+0x163/0x1410
[  352.518830]        rdma_destroy_id+0x17/0x20 [rdma_cm]
[  352.520648]        nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
[  352.522470]        nvmet_rdma_release_queue_work+0x3b/0x90 [nvmet_rdma]
[  352.524288]        process_one_work+0x8fb/0x16c0
[  352.526052]        worker_thread+0x87/0xb40
[  352.527758]        kthread+0x35f/0x430
[  352.529456]        ret_from_fork+0x22/0x30
[  352.531091] 
               other info that might help us debug this:

[  352.535736] Chain exists of:
                 &id_priv->handler_mutex --> (wq_completion)events --> (work_completion)(&queue->release_work)

[  352.540596]  Possible unsafe locking scenario:

[  352.543799]        CPU0                    CPU1
[  352.545393]        ----                    ----
[  352.546972]   lock((work_completion)(&queue->release_work));
[  352.548588]                                lock((wq_completion)events);
[  352.550243]                                lock((work_completion)(&queue->release_work));
[  352.551928]   lock(&id_priv->handler_mutex);
[  352.553604] 
                *** DEADLOCK ***

[  352.558447] 2 locks held by kworker/1:1/51:
[  352.560048]  #0: ffff888100052d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7d5/0x16c0
[  352.561773]  #1: ffff888100f3fe00 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x809/0x16c0
[  352.563557] 
               stack backtrace:
[  352.567023] CPU: 1 PID: 51 Comm: kworker/1:1 Tainted: G S                5.10.0-rc7 #1
[  352.568839] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.1.10 03/10/2015
[  352.570699] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[  352.572587] Call Trace:
[  352.574452]  dump_stack+0x99/0xcb
[  352.576304]  check_noncircular+0x27f/0x320
[  352.578171]  ? print_circular_bug+0x440/0x440
[  352.580032]  ? print_irqtrace_events+0x270/0x270
[  352.581887]  ? mark_lock.part.29+0x107/0x14e0
[  352.583740]  ? print_irqtrace_events+0x270/0x270
[  352.585597]  check_prevs_add+0x3fd/0x2460
[  352.587460]  ? check_irq_usage+0xe30/0xe30
[  352.589328]  ? find_held_lock+0x1c0/0x1c0
[  352.591197]  ? sched_clock_cpu+0x18/0x1d0
[  352.593054]  __lock_acquire+0x255e/0x3080
[  352.594901]  lock_acquire+0x1c8/0x880
[  352.596748]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  352.598610]  ? rcu_read_unlock+0x50/0x50
[  352.600474]  __mutex_lock+0x163/0x1410
[  352.602333]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  352.604190]  ? wait_for_completion+0x89/0x260
[  352.606044]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  352.607883]  ? mutex_lock_io_nested+0x12e0/0x12e0
[  352.609729]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  352.611577]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  352.613428]  ? nvmet_sq_destroy+0x164/0x530 [nvmet]
[  352.615296]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  352.617160]  rdma_destroy_id+0x17/0x20 [rdma_cm]
[  352.619022]  nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
[  352.620914]  ? lockdep_hardirqs_on_prepare+0x28f/0x3e0
[  352.622769]  nvmet_rdma_release_queue_work+0x3b/0x90 [nvmet_rdma]
[  352.624602]  process_one_work+0x8fb/0x16c0
[  352.626428]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  352.628265]  ? pwq_dec_nr_in_flight+0x320/0x320
[  352.630121]  worker_thread+0x87/0xb40
[  352.631987]  ? __kthread_parkme+0xd1/0x1a0
[  352.633841]  ? process_one_work+0x16c0/0x16c0
[  352.635674]  kthread+0x35f/0x430
[  352.637490]  ? kthread_mod_delayed_work+0x180/0x180
[  352.639293]  ret_from_fork+0x22/0x30
[  353.044114] infiniband lo_siw: ib_query_port failed (-19)
[  353.046030] infiniband eno1_siw: ib_query_port failed (-19)
[  353.047937] infiniband eno2_siw: ib_query_port failed (-19)
[  353.049822] infiniband eno3_siw: ib_query_port failed (-19)
[  353.051627] infiniband eno4_siw: ib_query_port failed (-19)
[  353.053566] SoftiWARP detached

on ppc64le:
[10815.999304] run blktests nvme/003 at 2020-12-12 21:30:01
[10819.200531] SoftiWARP attached
[10819.260326] lo speed is unknown, defaulting to 1000
[10819.260338] lo speed is unknown, defaulting to 1000
[10819.260360] lo speed is unknown, defaulting to 1000
[10819.560036] loop: module loaded
[10819.660726] Loading iSCSI transport class v2.0-870.
[10819.710612] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[10819.719478] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[10819.719777] nvmet_rdma: enabling port 0 (10.16.224.162:4420)
[10819.731002] kworker/u16:2: vmalloc: allocation failure: 0 bytes, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
[10819.731022] CPU: 5 PID: 344 Comm: kworker/u16:2 Not tainted 5.10.0-rc7 #1
[10819.731033] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
[10819.731038] Call Trace:
[10819.731044] [c000000007eeb370] [c00000000079cce0] dump_stack+0xc4/0x114 (unreliable)
[10819.731052] [c000000007eeb3b0] [c00000000044cf4c] warn_alloc+0x12c/0x1c0
[10819.731058] [c000000007eeb450] [c000000000442f9c] __vmalloc_node_range+0x24c/0x3e0
[10819.731063] [c000000007eeb500] [c000000000443348] vzalloc+0x58/0x70
[10819.731072] [c000000007eeb570] [c008000000f499ec] siw_qp_modify+0x604/0x7f0 [siw]
[10819.731080] [c000000007eeb600] [c008000000f43ec0] siw_accept+0x248/0x860 [siw]
[10819.731086] [c000000007eeb6e0] [c0080000008f02c8] iw_cm_accept+0xf0/0x290 [iw_cm]
[10819.731096] [c000000007eeb740] [c008000000e92b7c] rdma_accept+0x144/0x340 [rdma_cm]
[10819.731102] [c000000007eeb7b0] [c008000000a14390] nvmet_rdma_queue_connect+0xae8/0xe20 [nvmet_rdma]
[10819.731112] [c000000007eeb910] [c008000000e92448] cma_cm_event_handler+0x50/0x150 [rdma_cm]
[10819.731121] [c000000007eeb950] [c008000000e98bc0] iw_conn_req_handler+0x388/0x470 [rdma_cm]
[10819.731129] [c000000007eeba50] [c0080000008f2288] cm_work_handler+0x780/0x820 [iw_cm]
[10819.731136] [c000000007eebc70] [c00000000017cdf0] process_one_work+0x260/0x530
[10819.731143] [c000000007eebd10] [c00000000017d148] worker_thread+0x88/0x5e0
[10819.731149] [c000000007eebdb0] [c000000000187f10] kthread+0x1a0/0x1b0
[10819.731155] [c000000007eebe20] [c00000000000d3f0] ret_from_kernel_thread+0x5c/0x6c
[10819.731161] Mem-Info:
[10819.731168] active_anon:71 inactive_anon:3279 isolated_anon:0
                active_file:7133 inactive_file:25899 isolated_file:0
                unevictable:0 dirty:2 writeback:0
                slab_reclaimable:2660 slab_unreclaimable:4555
                mapped:1630 shmem:197 pagetables:80 bounce:0
                free:84961 free_pcp:82 free_cma:0
[10819.731185] Node 0 active_anon:4544kB inactive_anon:209856kB active_file:456512kB inactive_file:1657536kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:104320kB dirty:128kB writeback:0kB shmem:12608kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:3632kB all_unreclaimable? no
[10819.731195] Node 0 Normal free:5437504kB min:180224kB low:225280kB high:270336kB reserved_highatomic:0KB active_anon:4544kB inactive_anon:209856kB active_file:456512kB inactive_file:1657536kB unevictable:0kB writepending:128kB present:8388608kB managed:8297472kB mlocked:0kB pagetables:5120kB bounce:0kB free_pcp:5248kB local_pcp:256kB free_cma:0kB
[10819.731210] lowmem_reserve[]: 0 0 0
[10819.731216] Node 0 Normal: 6*64kB (ME) 11*128kB (UME) 65*256kB (M) 111*512kB (UME) 41*1024kB (UM) 5*2048kB (UM) 4*4096kB (UM) 2*8192kB (UE) 322*16384kB (M) = 5435904kB
[10819.731241] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=16384kB
[10819.731243] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=16777216kB
[10819.731244] 33258 total pagecache pages
[10819.731248] 0 pages in swap cache
[10819.731251] Swap cache stats: add 0, delete 0, find 0/0
[10819.731255] Free swap  = 4222912kB
[10819.731258] Total swap = 4222912kB
[10819.731261] 131072 pages RAM
[10819.731263] 0 pages HighMem/MovableOnly
[10819.731266] 1424 pages reserved
[10819.731269] 0 pages cma reserved
[10819.731273] 0 pages hwpoisoned
[10819.731304] nvmet_rdma: rdma_accept failed (error code = -12)
[10819.823296] nvme nvme0: Connect rejected: status -104 (reset by remote host).
[10819.823312] nvme nvme0: rdma connection establishment failed (-104)
[10820.011181] iscsi: registered transport (iser)
[10820.680443] Rounding down aligned max_sectors from 4294967295 to 4294967168
[10820.680501] db_root: cannot open: /etc/target
[10821.539792] lo speed is unknown, defaulting to 1000
[10821.539804] ib_srpt MAD registration failed for lo_siw-1.
[10821.539811] ib_srpt srpt_add_one(lo_siw) failed.
[10823.310251] RPC: Registered rdma transport module.
[10823.310253] RPC: Registered rdma backchannel transport module.
[10830.441052] lo speed is unknown, defaulting to 1000
[10830.441415] SoftiWARP detached


Best Regards,
  Yi Zhang


