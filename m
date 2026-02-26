Return-Path: <linux-rdma+bounces-17232-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPoPN31goGmMiwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17232-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 16:02:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284E1A82BB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08A630752EC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F693E95B3;
	Thu, 26 Feb 2026 14:54:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772953B8BAE
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117670; cv=none; b=NaizNjAIGS0SQ0U44rYQWowmicNZPMgYfesMbY6kt/AyhrykBgV4joQ9PwP/il2l+NJd8jleeL4hzvKA4wBUQK+Rkyk2MV4dHdKGf2L68OgOUVXilyZPWfBHdgWiPwwsATOX9lPb+iHxLmJ64bkf6WlnD+tgv0ApzowvylhSQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117670; c=relaxed/simple;
	bh=11se9M3WxkgH+XSdJ4QJzYnJipWb+HqHlJM1U2BHBGE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fz2eut++BefljPrkGw2auZ8cKAuQtmXHEValHjR4rU3RvEqKm2ZnPnnZZ1QY6KYGuldaS16NzVSUO4tPnfBQVlP2fuoDTiurZJ4V+NAuHiBqCqnpTDJOuPze6ppEfwTCT96pE3vrjY5G1jkYdy5GA5ZWcCUiPyg2pfGnCsxQ8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679e73c3766so27998860eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 06:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772117667; x=1772722467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTdraR/QuiVbqb3wiANa4uzSBZNCFSHs9IEQafpt+cM=;
        b=M1RP8Zkf4mZM4AvNIx4aKyh+baerTiAVT+lE7sKkcvwJvkTPM3QZ1IA5DgnPHmQb44
         aETN7PQZpg4XBWXd1r5HvfjbtF12NsCeZApxY3IbGJqaP8OPl3NEIozowoxBDy0hTWj7
         7AScCiKQ3kJTGAf4N/rYqDR5127zGjRrM2fMG8VOYGEboHB8nemR7UkqyJuOth+EUtI0
         HV9X+L7nCTklKsN4jTs1HkCKgi7LCvohjNXda6gXwrHlRf9/rotHrT3/8zt/52tima17
         Vq3JHFM93PupWo+U9RwQlfRaNnEq3Z4z1/qT8uoVvDTUg55hIvBu+9XejXvNObWy8JZD
         rHBg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ieCBdOy3bm5rLjParRYdV38Un/13GVHyrJjPlYYEL0v0+yL4c11tpXeMP59yCeFDhSZTIycr/8WV@vger.kernel.org
X-Gm-Message-State: AOJu0YykX8CoEL594/2HMWF+FI/MYyiO7nUUaGURLiG19pcfW2jDIFKN
	xHWpEwfIN9tBTpGzRLl2neAaT/OCA+5GAJ5gfe/Ic06dI0JZStA7t0amX2oq2x5+wYrYQUEX6+4
	MB6gPYyVI699JrxNarqjNxOd8N2cnmbUV8rflosLi021Ah5zQ1s9/GVN2ztI=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80a:b0:679:c41f:edf with SMTP id
 006d021491bc7-679f2330cc6mr1832140eaf.29.1772117667460; Thu, 26 Feb 2026
 06:54:27 -0800 (PST)
Date: Thu, 26 Feb 2026 06:54:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a05ea3.050a0220.305b49.0023.GAE@google.com>
Subject: [syzbot] [rds?] possible deadlock in rds_tcp_tune (2)
From: syzbot <syzbot+2e2cf5331207053b8106@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6259cfbe2d15cac4];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[appspotmail.com:server fail];
	TAGGED_FROM(0.00)[bounces-17232-lists,linux-rdma=lfdr.de,2e2cf5331207053b8106];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 6284E1A82BB
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    32a92f8c8932 Convert more 'alloc_obj' cases to default GFP..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1171d95a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6259cfbe2d15cac4
dashboard link: https://syzkaller.appspot.com/bug?extid=2e2cf5331207053b8106
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64d473c704b2/disk-32a92f8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/570c8f79c450/vmlinux-32a92f8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3d4ccd686ce/bzImage-32a92f8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e2cf5331207053b8106@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G     U       L     
------------------------------------------------------
kworker/u10:8/15040 is trying to acquire lock:
ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4452 [inline]
ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4807 [inline]
ffffffff8e9aaf80 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x4b/0x6f0 mm/slub.c:5334

but task is already holding lock:
ffff88805a3c1ce0 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
ffff88805a3c1ce0 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: rds_tcp_tune+0xd7/0x930 net/rds/tcp.c:493

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (k-sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
       lock_sock include/net/sock.h:1709 [inline]
       inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:913
       nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
       sock_shutdown+0x16b/0x200 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1427 [inline]
       nbd_config_put+0x1eb/0x750 drivers/block/nbd.c:1451
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1756
       blkdev_put_whole+0xb0/0xf0 block/bdev.c:737
       bdev_release+0x47f/0x6d0 block/bdev.c:1160
       blkdev_release+0x15/0x20 block/fops.c:705
       __fput+0x3ff/0xb40 fs/file_table.c:469
       task_work_run+0x150/0x240 kernel/task_work.c:233
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
       exit_to_user_mode_loop+0x100/0x4a0 kernel/entry/common.c:98
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
       do_syscall_64+0x668/0xf80 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x428/0x1080 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
       blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
       blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x584/0x6c0 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
       submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2496
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4096
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:723
       adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
       blkdev_get_whole+0x187/0x290 block/bdev.c:764
       bdev_open+0x2c7/0xe40 block/bdev.c:973
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:949
       vfs_open+0x82/0x3f0 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4830
       do_file_open+0x20e/0x430 fs/namei.c:4859
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       nbd_queue_rq+0xba/0x1080 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
       blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
       blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x584/0x6c0 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
       submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2458
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2496
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4096
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:723
       adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
       blkdev_get_whole+0x187/0x290 block/bdev.c:764
       bdev_open+0x2c7/0xe40 block/bdev.c:973
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:949
       vfs_open+0x82/0x3f0 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4830
       do_file_open+0x20e/0x430 fs/namei.c:4859
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xa1/0x2a0 kernel/rcu/srcutree.c:1505
       blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
       blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
       elevator_switch+0x17b/0x7e0 block/elevator.c:576
       elevator_change+0x352/0x530 block/elevator.c:681
       elevator_set_default+0x29e/0x360 block/elevator.c:754
       blk_register_queue+0x412/0x590 block/blk-sysfs.c:940
       __add_disk+0x73f/0xe40 block/genhd.c:528
       add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
       add_disk include/linux/blkdev.h:785 [inline]
       nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:1984
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       queue_requests_store+0x38b/0x660 block/blk-sysfs.c:117
       queue_attr_store+0x25f/0x2f0 block/blk-sysfs.c:866
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1070 fs/read_write.c:688
       ksys_pwrite64 fs/read_write.c:795 [inline]
       __do_sys_pwrite64 fs/read_write.c:803 [inline]
       __se_sys_pwrite64 fs/read_write.c:800 [inline]
       __x64_sys_pwrite64+0x1eb/0x250 fs/read_write.c:800
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#26){++++}-{0:0}:
       blk_alloc_queue+0x610/0x790 block/blk-core.c:461
       blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4429
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4476
       loop_add+0x498/0xb60 drivers/block/loop.c:2049
       loop_init+0x1d3/0x200 drivers/block/loop.c:2288
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
       fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4452 [inline]
       slab_alloc_node mm/slub.c:4807 [inline]
       __kmalloc_cache_noprof+0x4b/0x6f0 mm/slub.c:5334
       kmalloc_noprof include/linux/slab.h:962 [inline]
       kzalloc_noprof include/linux/slab.h:1200 [inline]
       ref_tracker_alloc+0x190/0x590 lib/ref_tracker.c:270
       __netns_tracker_alloc include/net/net_namespace.h:367 [inline]
       netns_tracker_alloc include/net/net_namespace.h:376 [inline]
       get_net_track include/net/net_namespace.h:393 [inline]
       sk_net_refcnt_upgrade+0x1b4/0x360 net/core/sock.c:2395
       rds_tcp_tune+0x2aa/0x930 net/rds/tcp.c:502
       rds_tcp_accept_one+0x4b8/0xeb0 net/rds/tcp_listen.c:200
       rds_tcp_accept_worker+0x41/0x60 net/rds/tcp.c:524
       process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
       process_scheduled_works kernel/workqueue.c:3358 [inline]
       worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
       kthread+0x370/0x450 kernel/kthread.c:467
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &nsock->tx_lock --> k-sk_lock-AF_INET6

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(k-sk_lock-AF_INET6);
                               lock(&nsock->tx_lock);
                               lock(k-sk_lock-AF_INET6);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by kworker/u10:8/15040:
 #0: ffff888033870148 ((wq_completion)krdsd){+.+.}-{0:0}, at: process_one_work+0x1287/0x1920 kernel/workqueue.c:3250
 #1: ffffc90006ee7d08 ((work_completion)(&rtn->rds_tcp_accept_w)){+.+.}-{0:0}, at: process_one_work+0x93c/0x1920 kernel/workqueue.c:3251
 #2: ffff888077acfc68 (&rtn->rds_tcp_accept_lock){+.+.}-{4:4}, at: rds_tcp_accept_one+0xb1/0xeb0 net/rds/tcp_listen.c:190
 #3: ffff88805a3c1ce0 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #3: ffff88805a3c1ce0 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: rds_tcp_tune+0xd7/0x930 net/rds/tcp.c:493

stack backtrace:
CPU: 0 UID: 0 PID: 15040 Comm: kworker/u10:8 Tainted: G     U       L      syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: krdsd rds_tcp_accept_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
 fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4452 [inline]
 slab_alloc_node mm/slub.c:4807 [inline]
 __kmalloc_cache_noprof+0x4b/0x6f0 mm/slub.c:5334
 kmalloc_noprof include/linux/slab.h:962 [inline]
 kzalloc_noprof include/linux/slab.h:1200 [inline]
 ref_tracker_alloc+0x190/0x590 lib/ref_tracker.c:270
 __netns_tracker_alloc include/net/net_namespace.h:367 [inline]
 netns_tracker_alloc include/net/net_namespace.h:376 [inline]
 get_net_track include/net/net_namespace.h:393 [inline]
 sk_net_refcnt_upgrade+0x1b4/0x360 net/core/sock.c:2395
 rds_tcp_tune+0x2aa/0x930 net/rds/tcp.c:502
 rds_tcp_accept_one+0x4b8/0xeb0 net/rds/tcp_listen.c:200
 rds_tcp_accept_worker+0x41/0x60 net/rds/tcp.c:524
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

