Return-Path: <linux-rdma+bounces-7508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7FCA2BE6D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 09:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC7F188ABBC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB91B041C;
	Fri,  7 Feb 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqsAqc5h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A51A4E70
	for <linux-rdma@vger.kernel.org>; Fri,  7 Feb 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918347; cv=none; b=ezZ8wfOGv1hSGOiUjN3AbNGXhwZ9ztqSS91K4wQaRYldzi5Axp6NJr1cgU6ZXjfYk0O0M2nfJncMliixHnboTh3rd7Z4FywdCopQoAHQ05cKoJsZSz4mUAV+ZP8xoS9rn6I/0NrbHohtDSeDW01YbWJAvdbIriJu6c/v8QUdiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918347; c=relaxed/simple;
	bh=0Tik/Re9qta3Hm+2UZJiDEh2w4Yk+x+Rs6oi+bPoPXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwkOo2DTA/ady+Rp7UpyEQgF3FV2IoNrVeWEHZZ0WUI0rc1voirxU67fVyrM6+4TCiPCN7xvcBujt2vL5UOSxxTjxf4e8UQ2v8abGAP5T5ea4BHw14ztbL2M4wODawQIRgyNczwUDZGVzUmIgamVjs3BMBE/06T49BwX0ozBlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqsAqc5h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738918344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1rCOG6P1Gt1O2VVavW0dJMG1YSFwklhplJ4eTKRqnY=;
	b=DqsAqc5ha1FOyURbHfinvlQUVySc1TwHuYqTrGpLACVLIBD/oHk+ravW8xhtGbclTUCtC/
	Z1jb7L8wN+5g2f1BAoJEzipgadI4/Rd/4plqBDqNYr1xgOuqux2ge+ou1hQVPJZERfv5kg
	KIDeKTEQvyG8nsO4ECokp8Cu+Mymvy4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-ceeN-5uSNLSeWOOjE6MaNg-1; Fri,
 07 Feb 2025 03:52:20 -0500
X-MC-Unique: ceeN-5uSNLSeWOOjE6MaNg-1
X-Mimecast-MFC-AGG-ID: ceeN-5uSNLSeWOOjE6MaNg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A30061800875;
	Fri,  7 Feb 2025 08:52:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37FC318004A7;
	Fri,  7 Feb 2025 08:52:13 +0000 (UTC)
Date: Fri, 7 Feb 2025 16:52:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.14-rc1 kernel
Message-ID: <Z6XJuIz012XATr7h@fedora>
References: <uyijd3ufbrfbiyyaajvhyhdyytssubekvymzgyiqjqmkh33cmi@ksqjpewsqlvw>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uyijd3ufbrfbiyyaajvhyhdyytssubekvymzgyiqjqmkh33cmi@ksqjpewsqlvw>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Shinichiro,

On Fri, Feb 07, 2025 at 01:24:09AM +0000, Shinichiro Kawasaki wrote:
> Hi all,
> 
> I ran the latest blktests (git hash: 67aff550bd52) with the v6.14-rc1 kernel.
> I observed 5 failures listed below. Comparing with the previous report with
> the v6.13 kernel [1], one new failure was observed at zbd/009.
> 
> [1] https://lore.kernel.org/linux-nvme/rv3w2zcno7n3bgdy2ghxmedsqf23ptmakvjerbhopgxjsvgzmo@ioece7dyg2og/
> 
> List of failures
> ================
> #1: block/002
> #2: nvme/037 (fc transport)
> #3: nvme/041 (fc transport)
> #4: nvme/058 (loop transport)
> #5: zbd/009 (new)
> 
> 
> Two failures observed with the v6.13 kernel are not observed with the v6.14-rc1.
> 
> Failures no longer observed
> ===========================
> #1: block/001:
>     It looks resolved by fixes in v6.14-rc1 kernel.
> 
> #2: throtl/001 (CKI project, s390 arch)
>     I was not able to find blktests runs by CKI project with the v6.14-rc1
>     kernel.
> 
> 
> Failure description
> ===================
> 
> #1: block/002
> 
>     This test case fails with a lockdep WARN "possible circular locking
>     dependency detected". The lockdep splats shows q->q_usage_counter as one
>     of the involved locks. It was observed with the v6.13-rc2 kernel [2], and
>     still observed with v6.14-rc1 kernel. It needs further debug.
> 
>     [2] https://lore.kernel.org/linux-block/qskveo3it6rqag4xyleobe5azpxu6tekihao4qpdopvk44una2@y4lkoe6y3d6z/

[  342.568086][ T1023] -> #0 (&mm->mmap_lock){++++}-{4:4}:
[  342.569658][ T1023]        __lock_acquire+0x2e8b/0x6010
[  342.570577][ T1023]        lock_acquire+0x1b1/0x540
[  342.571463][ T1023]        __might_fault+0xb9/0x120
[  342.572338][ T1023]        _copy_from_user+0x34/0xa0
[  342.573231][ T1023]        __blk_trace_setup+0xa0/0x140
[  342.574129][ T1023]        blk_trace_ioctl+0x14e/0x270
[  342.575033][ T1023]        blkdev_ioctl+0x38f/0x5c0
[  342.575919][ T1023]        __x64_sys_ioctl+0x130/0x190
[  342.576824][ T1023]        do_syscall_64+0x93/0x180
[  342.577714][ T1023]        entry_SYSCALL_64_after_hwframe+0x76/0x7e

The above dependency between ->mmap_lock and ->debugfs_mutex has been cut by
commit b769a2f409e7 ("blktrace: move copy_[to|from]_user() out of ->debugfs_lock"),
so I'd suggest to double check this one.

You mentioned it can be reproduced in v6.14-rc1, but not see such warning
from v6.14-rc1.

> #5: zbd/009 (new)
> 
>     This test case fails with a lockdep WARN "possible circular locking
>     dependency detected" [5]. The lockdep splats shows q->q_usage_counter as one
>     of the involved locks. This is common as the block/002 failure. It needs
>     further debug.
> 
> [5] kernel message during zbd/009 run
> 
> [  204.099296] [   T1004] run blktests zbd/009 at 2025-02-07 10:01:36
> [  204.155021] [   T1040] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
> [  204.553613] [   T1041] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
> [  204.554438] [   T1041] scsi host9: scsi_debug: version 0191 [20210520]
>                             dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
> [  204.558331] [   T1041] scsi 9:0:0:0: Direct-Access-ZBC Linux    scsi_debug       0191 PQ: 0 ANSI: 7
> [  204.560269] [      C2] scsi 9:0:0:0: Power-on or device reset occurred
> [  204.562871] [   T1041] sd 9:0:0:0: Attached scsi generic sg3 type 20
> [  204.563013] [    T100] sd 9:0:0:0: [sdd] Host-managed zoned block device
> [  204.564518] [    T100] sd 9:0:0:0: [sdd] 262144 4096-byte logical blocks: (1.07 GB/1.00 GiB)
> [  204.565477] [    T100] sd 9:0:0:0: [sdd] Write Protect is off
> [  204.565948] [    T100] sd 9:0:0:0: [sdd] Mode Sense: 5b 00 10 08
> [  204.566245] [    T100] sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [  204.567453] [    T100] sd 9:0:0:0: [sdd] permanent stream count = 5
> [  204.568276] [    T100] sd 9:0:0:0: [sdd] Preferred minimum I/O size 4096 bytes
> [  204.569067] [    T100] sd 9:0:0:0: [sdd] Optimal transfer size 4194304 bytes
> [  204.571080] [    T100] sd 9:0:0:0: [sdd] 256 zones of 1024 logical blocks
> [  204.593822] [    T100] sd 9:0:0:0: [sdd] Attached SCSI disk
> [  204.901514] [   T1067] BTRFS: device fsid 15196e63-e303-48ed-9dcb-9ec397479c42 devid 1 transid 8 /dev/sdd (8:48) scanned by mount (1067)
> [  204.910330] [   T1067] BTRFS info (device sdd): first mount of filesystem 15196e63-e303-48ed-9dcb-9ec397479c42
> [  204.913129] [   T1067] BTRFS info (device sdd): using crc32c (crc32c-generic) checksum algorithm
> [  204.914856] [   T1067] BTRFS info (device sdd): using free-space-tree
> [  204.925816] [   T1067] BTRFS info (device sdd): host-managed zoned block device /dev/sdd, 256 zones of 4194304 bytes
> [  204.929320] [   T1067] BTRFS info (device sdd): zoned mode enabled with zone size 4194304
> [  204.935403] [   T1067] BTRFS info (device sdd): checking UUID tree
> [  215.637712] [   T1103] BTRFS info (device sdd): last unmount of filesystem 15196e63-e303-48ed-9dcb-9ec397479c42
> 
> [  215.762293] [   T1110] ======================================================
> [  215.763636] [   T1110] WARNING: possible circular locking dependency detected
> [  215.765092] [   T1110] 6.14.0-rc1 #252 Not tainted
> [  215.766271] [   T1110] ------------------------------------------------------
> [  215.767615] [   T1110] modprobe/1110 is trying to acquire lock:
> [  215.768999] [   T1110] ffff888100ac83e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0x38f/0xb60
> [  215.770700] [   T1110] 
>                           but task is already holding lock:
> [  215.773077] [   T1110] ffff8881205b6f20 (&q->q_usage_counter(queue)#16){++++}-{0:0}, at: sd_remove+0x85/0x130
> [  215.774685] [   T1110] 
>                           which lock already depends on the new lock.
> 
> [  215.778184] [   T1110] 
>                           the existing dependency chain (in reverse order) is:
> [  215.780532] [   T1110] 
>                           -> #3 (&q->q_usage_counter(queue)#16){++++}-{0:0}:
> [  215.782937] [   T1110]        blk_queue_enter+0x3d9/0x500
> [  215.784175] [   T1110]        blk_mq_alloc_request+0x47d/0x8e0
> [  215.785434] [   T1110]        scsi_execute_cmd+0x14f/0xb80
> [  215.786662] [   T1110]        sd_zbc_do_report_zones+0x1c1/0x470
> [  215.787989] [   T1110]        sd_zbc_report_zones+0x362/0xd60
> [  215.789222] [   T1110]        blkdev_report_zones+0x1b1/0x2e0
> [  215.790448] [   T1110]        btrfs_get_dev_zones+0x215/0x7e0 [btrfs]
> [  215.791887] [   T1110]        btrfs_load_block_group_zone_info+0x6d2/0x2c10 [btrfs]
> [  215.793342] [   T1110]        btrfs_make_block_group+0x36b/0x870 [btrfs]
> [  215.794752] [   T1110]        btrfs_create_chunk+0x147d/0x2320 [btrfs]
> [  215.796150] [   T1110]        btrfs_chunk_alloc+0x2ce/0xcf0 [btrfs]
> [  215.797474] [   T1110]        start_transaction+0xce6/0x1620 [btrfs]
> [  215.798858] [   T1110]        btrfs_uuid_scan_kthread+0x4ee/0x5b0 [btrfs]
> [  215.800334] [   T1110]        kthread+0x39d/0x750
> [  215.801479] [   T1110]        ret_from_fork+0x30/0x70
> [  215.802662] [   T1110]        ret_from_fork_asm+0x1a/0x30

Not sure why fs_info->dev_replace is required for reporting zones.

> [  215.803902] [   T1110] 
>                           -> #2 (&fs_info->dev_replace.rwsem){++++}-{4:4}:
> [  215.805993] [   T1110]        down_read+0x9b/0x470
> [  215.807088] [   T1110]        btrfs_map_block+0x2ce/0x2ce0 [btrfs]
> [  215.808366] [   T1110]        btrfs_submit_chunk+0x2d4/0x16c0 [btrfs]
> [  215.809687] [   T1110]        btrfs_submit_bbio+0x16/0x30 [btrfs]
> [  215.810983] [   T1110]        btree_write_cache_pages+0xb5a/0xf90 [btrfs]
> [  215.812295] [   T1110]        do_writepages+0x17f/0x7b0
> [  215.813416] [   T1110]        __writeback_single_inode+0x114/0xb00
> [  215.814575] [   T1110]        writeback_sb_inodes+0x52b/0xe00
> [  215.815717] [   T1110]        wb_writeback+0x1a7/0x800
> [  215.816924] [   T1110]        wb_workfn+0x12a/0xbd0
> [  215.817951] [   T1110]        process_one_work+0x85a/0x1460
> [  215.818985] [   T1110]        worker_thread+0x5e2/0xfc0
> [  215.820013] [   T1110]        kthread+0x39d/0x750
> [  215.821000] [   T1110]        ret_from_fork+0x30/0x70
> [  215.822010] [   T1110]        ret_from_fork_asm+0x1a/0x30
> [  215.822988] [   T1110] 
>                           -> #1 (&fs_info->zoned_meta_io_lock){+.+.}-{4:4}:
> [  215.824855] [   T1110]        __mutex_lock+0x1aa/0x1360
> [  215.825856] [   T1110]        btree_write_cache_pages+0x252/0xf90 [btrfs]
> [  215.827089] [   T1110]        do_writepages+0x17f/0x7b0
> [  215.828027] [   T1110]        __writeback_single_inode+0x114/0xb00
> [  215.829141] [   T1110]        writeback_sb_inodes+0x52b/0xe00
> [  215.830129] [   T1110]        wb_writeback+0x1a7/0x800
> [  215.831084] [   T1110]        wb_workfn+0x12a/0xbd0
> [  215.831950] [   T1110]        process_one_work+0x85a/0x1460
> [  215.832862] [   T1110]        worker_thread+0x5e2/0xfc0
> [  215.833826] [   T1110]        kthread+0x39d/0x750
> [  215.834715] [   T1110]        ret_from_fork+0x30/0x70
> [  215.835669] [   T1110]        ret_from_fork_asm+0x1a/0x30
> [  215.836594] [   T1110] 
>                           -> #0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
> [  215.838347] [   T1110]        __lock_acquire+0x2f52/0x5ea0
> [  215.839258] [   T1110]        lock_acquire+0x1b1/0x540
> [  215.840156] [   T1110]        __flush_work+0x3ac/0xb60
> [  215.841041] [   T1110]        wb_shutdown+0x15b/0x1f0
> [  215.841915] [   T1110]        bdi_unregister+0x172/0x5b0
> [  215.842793] [   T1110]        del_gendisk+0x841/0xa20
> [  215.843724] [   T1110]        sd_remove+0x85/0x130
> [  215.844660] [   T1110]        device_release_driver_internal+0x368/0x520
> [  215.845757] [   T1110]        bus_remove_device+0x1f1/0x3f0
> [  215.846755] [   T1110]        device_del+0x3bd/0x9c0
> [  215.847712] [   T1110]        __scsi_remove_device+0x272/0x340
> [  215.848727] [   T1110]        scsi_forget_host+0xf7/0x170
> [  215.849710] [   T1110]        scsi_remove_host+0xd2/0x2a0
> [  215.850682] [   T1110]        sdebug_driver_remove+0x52/0x2f0 [scsi_debug]
> [  215.851788] [   T1110]        device_release_driver_internal+0x368/0x520
> [  215.852853] [   T1110]        bus_remove_device+0x1f1/0x3f0
> [  215.853885] [   T1110]        device_del+0x3bd/0x9c0
> [  215.854840] [   T1110]        device_unregister+0x13/0xa0
> [  215.855850] [   T1110]        sdebug_do_remove_host+0x1fb/0x290 [scsi_debug]
> [  215.856947] [   T1110]        scsi_debug_exit+0x17/0x70 [scsi_debug]
> [  215.857968] [   T1110]        __do_sys_delete_module.isra.0+0x321/0x520
> [  215.858999] [   T1110]        do_syscall_64+0x93/0x180
> [  215.859930] [   T1110]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  215.860974] [   T1110] 
>                           other info that might help us debug this:

This warning looks one real issue.


Thanks,
Ming


