Return-Path: <linux-rdma+bounces-5569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1CD9B2847
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 07:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29051F2200E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9118D649;
	Mon, 28 Oct 2024 06:57:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BED1DFFD
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098656; cv=none; b=dAW8+xkaSvfhbovEdqh2184qQ96qPtTk2KZiDDBkPP5k6QS8gukuGO9Xx4Md6wZNL/EOPpdYRT1bQsStwmrpoiuWvK1FkU9C6/1qmWXrQdlST26zSb2NDj05How7UTjiW5ST6nMxv6d1SWfSQhEafvAmSINqAa4Qwflk1flb3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098656; c=relaxed/simple;
	bh=ko9khx49sEALYM24cGzFv+sOAFa7K2lCW3ZtNNnEn4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kYx2lg23wvvxSvIkkLaZj/0LHb3Gau1OXHpzbrxtzcjgehz5Qnq9U6puPJ2yYh2yXn03RWFbAI/11tfje6RYB4ZBNiFq70+dxHIy3PYNUtShkyzrBLkDU7hipO33yy3HG5pFiCAM7Uo3AKZfm4AB/zciDI+53gMzGwtUrHQTKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from sonada.blr.asicdesigners.com (sonada.blr.asicdesigners.com [10.193.186.190])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 49S65jdj025149;
	Sun, 27 Oct 2024 23:05:46 -0700
From: Showrya M N <showrya@chelsio.com>
To: bvanassche@acm.org
Cc: linux-rdma@vger.kernel.org, showrya@chelsio.com, bharat@chelsio.com
Subject: Iser target machine hits kernel panic while running iozone traffic with link toggle on initiator
Date: Mon, 28 Oct 2024 11:52:46 +0530
Message-Id: <20241028062246.10997-1-showrya@chelsio.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I was testing iSER with the latest kernel v6.12-rc4, and within 15 minutes, the target machine encounters a kernel panic.
Git bisect points to these two commits:
a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()") and e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()")

below are the findings on how both commits causing same error:

case 1: Reverted commit e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()") and kept a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()")

        Before 'commit a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()"), cm_work_handler() takes single lock to delete the work and checks for
        list_empty. After the commit, cm_work_handler() now takes separate locks for each operation.
        However, there is a scenario where cm_work_handler() processed all the work in the worklist and is waiting to acquire the lock to check if the
        worklist is empty. Meanwhile, cm_event_handler() may take the lock, check the same condition, add new work to the same worklist,
        and queue this work, assuming the worklist is free. Since cm_work_handler() is still processing the same worklist, it will continue
        to process the newly added work as well, since cm_event_handler() queues the same work, this can lead to reprocessing of the same work, resulting in below error.


case 2: Reverted commit a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()") and kept e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()")

        After 'commit e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()")', cm_event_handler() calls queue_work() whenever work is added to the worklist.
        if the work is added while cm_work_handler() is processing the same worklist, cm_work_handler() may process the newly added work as well.
        Since cm_event_handler() unconditionally calls queue_work(), the same work can be reprocessed, leading to below error.


I am in favor of reverting above commits and restoring the previous code, since these commits are about code rearrange. Please let me know your views on it.


Steps to reproduce the issue:
-> Create 24 targets (12 on each interface), having LUN of 600MB (using ramdisk)
-> Enable iser for the target 
-> Discover and logged into the targets then started iozone traffic.
-> Start link toggling[interface up for 100sec and down for 10 sec] on initiator on the loop.


Here are the logs from crash file:

[21088.907704] ------------[ cut here ]------------
[21088.907710] WARNING: CPU: 8 PID: 134019 at kernel/workqueue.c:1680 __pwq_activate_work+0x90/0xa0
[21088.907721] Modules linked in: ib_isert rdma_ucm iw_cxgb4 cxgb4 target_core_user uio target_core_pscsi target_core_file target_core_iblock rpcrdma ib_srpt libiscsi scsi_transport_iscsi iscsi_target_mod target_core_mod snd_seq_dummy snd_hrtimer snd_seq snd_timer snd_seq_device snd soundcore qrtr rfkill sunrpc intel_powerclamp ib_uverbs coretemp kvm_intel libcxgb rdma_cm kvm iw_cm ib_cm ib_core ipmi_si intel_cstate iTCO_wdt gpio_ich ioatdma intel_uncore iTCO_vendor_support ipmi_devintf i2c_i801 lpc_ich ipmi_msghandler pcspkr acpi_cpufreq dca i2c_smbus i7core_edac i5500_temp dm_mod ext4 mbcache jbd2 mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper sd_mod sg ata_generic drm crct10dif_pclmul crc32_pclmul ata_piix crc32c_intel e1000e libata ghash_clmulni_intel serio_raw tls nvme_core scsi_transport_fc fuse [last unloaded: cxgb4]
[21088.907781] CPU: 8 UID: 0 PID: 134019 Comm: kworker/u96:2 Kdump: loaded Not tainted 6.11.0-rc3 #1
[21088.907784] Hardware name: Supermicro X8DT6/X8DT6, BIOS 2.0c    05/15/2012
[21088.907786] Workqueue:  0x0 (iw_cm_wq)
[21088.907791] RIP: 0010:__pwq_activate_work+0x90/0xa0
[21088.907795] Code: e8 d5 e2 ff ff 65 ff 0d 06 37 13 6b 75 a0 0f 1f 44 00 00 eb 99 48 8b 15 ee a6 70 01 48 89 50 18 48 8b 75 00 48 83 c6 28 eb 95 <0f> 0b e9 7b ff ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[21088.907798] RSP: 0018:ffffb62388597e58 EFLAGS: 00010046
[21088.907801] RAX: 0000000000000000 RBX: ffff956f03ce8200 RCX: 0000000000000001
[21088.907802] RDX: ffff95720d89b268 RSI: ffff956f03ce8200 RDI: ffff95720d89b200
[21088.907804] RBP: ffff95720d89b200 R08: ffff95720d89b200 R09: ffff9572051f1c24
[21088.907805] R10: 0000000000000001 R11: 0000000000000009 R12: ffff9572051f1c30
[21088.907807] R13: ffff956ec0059c00 R14: ffff9572051f1c20 R15: ffff95720d89b200
[21088.907808] FS:  0000000000000000(0000) GS:ffff9571efb00000(0000) knlGS:0000000000000000
[21088.907810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21088.907812] CR2: 00007ffadc487df8 CR3: 000000020aa20003 CR4: 00000000000206f0
[21088.907814] Call Trace:
[21088.907816]  <TASK>
[21088.907818]  ? __warn+0x7f/0x120
[21088.907823]  ? __pwq_activate_work+0x90/0xa0
[21088.907826]  ? report_bug+0x18a/0x1a0
[21088.907831]  ? handle_bug+0x3c/0x70
[21088.907834]  ? exc_invalid_op+0x14/0x70
[21088.907837]  ? asm_exc_invalid_op+0x16/0x20
[21088.907844]  ? __pwq_activate_work+0x90/0xa0
[21088.907848]  pwq_dec_nr_in_flight+0x28f/0x330
[21088.907852]  worker_thread+0x23d/0x350
[21088.907855]  ? __pfx_worker_thread+0x10/0x10
[21088.907857]  kthread+0xcf/0x100
[21088.907861]  ? __pfx_kthread+0x10/0x10
[21088.907864]  ret_from_fork+0x30/0x50
[21088.907869]  ? __pfx_kthread+0x10/0x10
[21088.907871]  ret_from_fork_asm+0x1a/0x30
[21088.907878]  </TASK>
[21088.907879] ---[ end trace 0000000000000000 ]---
[21088.907888] BUG: kernel NULL pointer dereference, address: 0000000000000008
[21088.907897] #PF: supervisor read access in kernel mode
[21088.907900] #PF: error_code(0x0000) - not-present page
[21088.907902] PGD 0 P4D 0
[21088.907906] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[21088.907910] CPU: 5 UID: 0 PID: 134156 Comm: kworker/u96:1 Kdump: loaded Tainted: G        W          6.11.0-rc3 #1
[21088.907915] Tainted: [W]=WARN
[21088.907917] Hardware name: Supermicro X8DT6/X8DT6, BIOS 2.0c    05/15/2012
[21088.907919] Workqueue:  cm_work_handler [iw_cm] (iw_cxgb4)
[21088.907930] RIP: 0010:process_one_work+0xbf/0x390
[21088.907936] Code: 74 0b 48 8b 80 d8 00 00 00 48 89 43 28 49 8b 06 be 20 00 00 00 4c 8d bb 80 00 00 00 48 89 04 24 48 c1 e8 04 83 e0 0f 89 43 30 <48> 8b 45 08 4c 8d a8 c0 00 00 00 4c 89 ef e8 de 96 bd 00 48 89 c2
[21088.907939] RSP: 0018:ffffb62388867e88 EFLAGS: 00010046
[21088.907942] RAX: 0000000000000000 RBX: ffff9572101e63c0 RCX: ffff956ec0059c00
[21088.907945] RDX: ffff956ec0059e08 RSI: 0000000000000020 RDI: ffff9572101e63c0
[21088.907947] RBP: 0000000000000000 R08: ffff9572101e6400 R09: ffff9572101e6400
[21088.907949] R10: 0000000000000000 R11: 0000000002ef1c5e R12: ffff956ec0059c00
[21088.907951] R13: ffff956ec0059c28 R14: ffff956f03ce8200 R15: ffff9572101e6440
[21088.907953] FS:  0000000000000000(0000) GS:ffff9575efa40000(0000) knlGS:0000000000000000
[21088.907956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21088.907958] CR2: 0000000000000008 CR3: 000000020aa20004 CR4: 00000000000206f0
[21088.907960] Call Trace:
[21088.907962]  <TASK>
[21088.907964]  ? __die+0x20/0x70
[21088.907970]  ? page_fault_oops+0x75/0x170
[21088.907977]  ? exc_page_fault+0x64/0x140
[21088.907983]  ? asm_exc_page_fault+0x22/0x30
[21088.907991]  ? process_one_work+0xbf/0x390
[21088.907994]  worker_thread+0x23d/0x350
[21088.907998]  ? __pfx_worker_thread+0x10/0x10
[21088.908001]  kthread+0xcf/0x100
[21088.908006]  ? __pfx_kthread+0x10/0x10
[21088.908010]  ret_from_fork+0x30/0x50
[21088.908015]  ? __pfx_kthread+0x10/0x10
[21088.908018]  ret_from_fork_asm+0x1a/0x30
[21088.908025]  </TASK>
[21088.908027] Modules linked in: ib_isert rdma_ucm iw_cxgb4 cxgb4 target_core_user uio target_core_pscsi target_core_file target_core_iblock rpcrdma ib_srpt libiscsi scsi_transport_iscsi iscsi_target_mod target_core_mod snd_seq_dummy snd_hrtimer snd_seq snd_timer snd_seq_device snd soundcore qrtr rfkill sunrpc intel_powerclamp ib_uverbs coretemp kvm_intel libcxgb rdma_cm kvm iw_cm ib_cm ib_core ipmi_si intel_cstate iTCO_wdt gpio_ich ioatdma intel_uncore iTCO_vendor_support ipmi_devintf i2c_i801 lpc_ich ipmi_msghandler pcspkr acpi_cpufreq dca i2c_smbus i7core_edac i5500_temp dm_mod ext4 mbcache jbd2 mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper sd_mod sg ata_generic drm crct10dif_pclmul crc32_pclmul ata_piix crc32c_intel e1000e libata ghash_clmulni_intel serio_raw tls nvme_core scsi_transport_fc fuse [last unloaded: cxgb4]
[21088.908084] CR2: 0000000000000008

Here are some debug logs:
[ 2608.281933] cm_event_handler: &work->work 000000004183c37b if
[ 2608.281939] process_one_work: work 000000004183c37b pwq 000000006c3c00e4
[ 2608.281945] cm_work_handler: begin _work 000000004183c37b no. of works 1
[ 2608.281947] cm_work_handler: empty 1 _work 000000004183c37b
[ 2608.282517] cm_event_handler: &work->work 000000004183c37b if
[ 2608.283159] cm_work_handler: count 1 before lock _work 000000004183c37b
[ 2608.283161] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.283451] cm_event_handler: &work->work 000000004183c37b else
[ 2608.284200] cm_work_handler: count 2 before lock _work 000000004183c37b
[ 2608.284204] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.285225] cm_work_handler: count 3 before lock _work 000000004183c37b
[ 2608.285229] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.285486] cm_event_handler: &work->work 000000004183c37b else
[ 2608.286210] cm_work_handler: count 4 before lock _work 000000004183c37b
[ 2608.286213] cm_work_handler: empty 0 _work 000000004183c37b
[ 2608.287149] cm_work_handler: count 5 before lock _work 000000004183c37b
[ 2608.287151] cm_work_handler: empty 1 _work 000000004183c37b
[ 2608.288161] cm_work_handler: count 6 before lock _work 000000004183c37b
[ 2608.288164] __pwq_activate_work: work 000000004183c37b
[ 2608.288170] ------------[ cut here ]------------
[ 2608.288172] WARNING: CPU: 1 PID: 69 at kernel/workqueue.c:1681 __pwq_activate_work+0xa6/0xb0


Thanks,
Showrya M N

