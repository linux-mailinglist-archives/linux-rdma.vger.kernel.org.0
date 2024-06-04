Return-Path: <linux-rdma+bounces-2815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26668FAEB4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133E41F21EAF
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23347143889;
	Tue,  4 Jun 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QHvgFsK7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B5142E63
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493202; cv=none; b=et1e5yrZDtmJV+fwPxGWYjdcDMtv7WsXL23VX6bTYeD3EFBPcMwVBbPDth2ubqxv8OPHGl8qvSqCccLmnZn5vCOzKLN7Rz2ebLQ1rzxmKGNy/b5uv8tm8W1ehfZc83lL2NRZKJ1sgd/NJjfw8ZV1IYc2KL3jqSoJh7uZLIYYl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493202; c=relaxed/simple;
	bh=mLKudeajodV2kVs0/pvTOyil7dr39DcSR7+J/rPaGyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMlWhA62ai1RC4bK3AYS0z9A37znDJgwkoGU183mZ+vCKy/i1/cRv2nVupRrSl5wHxnF5OK7SvSEQYsctl4pGBaNoL81B9LyaAA0ymRuCNKC43QvHwKy5kFxBSwnpCXk2wknJ+GbkgVGn1ZjId1yIxWEcSOCMljiXFazAzKaTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QHvgFsK7; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shinichiro.kawasaki@wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717493197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLXhin5DOqdtJTWDUdkDAnoSI/MLNOK6mPeFzGn11nM=;
	b=QHvgFsK7aX22EOLTrm41W++2NEFBvVrrmOhnAVSTTspxilDNPNJP+kVwNL1YXXfWmi9OMA
	RjDKQQz9a9B+/t3KxdUDKL7IdDymUm/mKB3KN3SSY6w07A6csBCj6td9IYwWDALhfxaQBa
	QIOIgYgqq3pAETRtvFCHFCp/QhGv/48=
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: bvanassche@acm.org
Message-ID: <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
Date: Tue, 4 Jun 2024 11:26:34 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 04.06.24 09:25, Shinichiro Kawasaki wrote:
> As I noted in another thread [1], KASAN slab-use-after-free is observed when
> I repeat the blktests test case srp/002 with the siw driver [2]. The kernel
> version was v6.10-rc2. The failure is recreated in stable manner when the test
> case is repeated around 30 times. It was not observed with the rxe driver.
>
> I think this failure is same as that I reported in Jun/2023 [3]. The Call Trace
> reported is quite similar. Also, I confirmed that the trial fix patch that I
> created in Jun/2023 avoided the KASAN failure at srp/002.

"the trial fix patch that I created in Jun/2023" that you mentioned is 
the commit in the link?

https://lore.kernel.org/linux-rdma/20230612054237.1855292-1-shinichiro.kawasaki@wdc.com/

Thanks,

Zhu Yanjun

>
> In Jun/2023, the KASAN failure was observed with the test cases nvme/030 and
> nvme/031. But the symptom disappeared in Sep/2023 [4]. I guess the failure has
> got observable again with srp/002.
>
> As for the root cause, it was advised that "There is something wrong with the
> iwarp cm if it is destroying IDs in handlers" [5]. Actions for fix will be
> appreciated. I'm willing to test fix patches.
>
> [1] https://lore.kernel.org/linux-block/n2adhqzr6x5fss6jff7pxhubkkalvxeyesmg7jre4uomfcdudb@dwn3wgkqhmj7/
>
> [2]
>
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000006d1c31fe with status 5
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 00000000916ce050 with status 5
> Jun 04 09:23:11 testnode2 kernel: ==================================================================
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000001770ef1b with status 5
> Jun 04 09:23:11 testnode2 kernel: BUG: KASAN: slab-use-after-free in __mutex_lock+0x1110/0x13c0
> Jun 04 09:23:11 testnode2 kernel: Read of size 8 at addr ffff888131a3e418 by task kworker/u16:6/1345
> Jun 04 09:23:11 testnode2 kernel:
> Jun 04 09:23:11 testnode2 kernel: CPU: 1 PID: 1345 Comm: kworker/u16:6 Not tainted 6.10.0-rc2+ #288
> Jun 04 09:23:11 testnode2 kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> Jun 04 09:23:11 testnode2 kernel: Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> Jun 04 09:23:11 testnode2 kernel: Call Trace:
> Jun 04 09:23:11 testnode2 kernel:  <TASK>
> Jun 04 09:23:11 testnode2 kernel:  dump_stack_lvl+0x6a/0x90
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 00000000f727e5c2 with status 5
> Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
> Jun 04 09:23:11 testnode2 kernel:  print_report+0x174/0x505
> Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
> Jun 04 09:23:11 testnode2 kernel:  ? __virt_addr_valid+0x1b9/0x400
> Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
> Jun 04 09:23:11 testnode2 kernel:  kasan_report+0xa7/0x180
> Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
> Jun 04 09:23:11 testnode2 kernel:  __mutex_lock+0x1110/0x13c0
> Jun 04 09:23:11 testnode2 kernel:  ? cma_iw_handler+0xac/0x500 [rdma_cm]
> Jun 04 09:23:11 testnode2 kernel:  ? __lock_acquire+0x139d/0x5d60
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx___mutex_lock+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel:  ? mark_lock+0xf5/0x1580
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_mark_lock+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000009bc71497 with status 5
> Jun 04 09:23:11 testnode2 kernel:  ? cma_iw_handler+0xac/0x500 [rdma_cm]
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 0000000041c0fa4b with status 5
> Jun 04 09:23:11 testnode2 kernel:  cma_iw_handler+0xac/0x500 [rdma_cm]
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_cma_iw_handler+0x10/0x10 [rdma_cm]
> Jun 04 09:23:11 testnode2 kernel:  ? mark_held_locks+0x94/0xe0
> Jun 04 09:23:11 testnode2 kernel:  ? _raw_spin_unlock_irqrestore+0x4c/0x60
> Jun 04 09:23:11 testnode2 kernel:  cm_work_handler+0xb54/0x1c50 [iw_cm]
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_cm_work_handler+0x10/0x10 [iw_cm]
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_lock_release+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 00000000f48094cb with status 5
> Jun 04 09:23:11 testnode2 kernel:  process_one_work+0x865/0x1410
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000001c3faa8a with status 5
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_lock_acquire+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_process_one_work+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel:  ? assign_work+0x16c/0x240
> Jun 04 09:23:11 testnode2 kernel:  ? lock_is_held_type+0xd5/0x130
> Jun 04 09:23:11 testnode2 kernel:  worker_thread+0x5e2/0x1010
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_worker_thread+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel:  kthread+0x2d1/0x3a0
> Jun 04 09:23:11 testnode2 kernel:  ? _raw_spin_unlock_irq+0x24/0x50
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_kthread+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel:  ret_from_fork+0x30/0x70
> Jun 04 09:23:11 testnode2 kernel:  ? __pfx_kthread+0x10/0x10
> Jun 04 09:23:11 testnode2 kernel:  ret_from_fork_asm+0x1a/0x30
> Jun 04 09:23:11 testnode2 kernel:  </TASK>
> Jun 04 09:23:11 testnode2 kernel:
> Jun 04 09:23:11 testnode2 kernel: Allocated by task 75327:
> Jun 04 09:23:11 testnode2 kernel:  kasan_save_stack+0x2c/0x50
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000001bd9ea09 with status 5
> Jun 04 09:23:11 testnode2 kernel:  kasan_save_track+0x10/0x30
> Jun 04 09:23:11 testnode2 kernel:  __kasan_kmalloc+0xa6/0xb0
> Jun 04 09:23:11 testnode2 kernel:  __rdma_create_id+0x5b/0x5d0 [rdma_cm]
> Jun 04 09:23:11 testnode2 kernel:  __rdma_create_kernel_id+0x12/0x40 [rdma_cm]
> Jun 04 09:23:11 testnode2 kernel:  srp_new_rdma_cm_id+0x7c/0x200 [ib_srp]
> Jun 04 09:23:11 testnode2 kernel:  add_target_store+0x135e/0x29f0 [ib_srp]
> Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000005afc8065 with status 5
> Jun 04 09:23:11 testnode2 kernel:  kernfs_fop_write_iter+0x3a4/0x5a0
> Jun 04 09:23:11 testnode2 kernel:  vfs_write+0x5e3/0xe70
> Jun 04 09:23:11 testnode2 kernel:  ksys_write+0xf7/0x1d0
> Jun 04 09:23:11 testnode2 kernel:  do_syscall_64+0x93/0x180
> Jun 04 09:23:11 testnode2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Jun 04 09:23:11 testnode2 kernel:
> Jun 04 09:23:11 testnode2 kernel: Freed by task 66344:
> Jun 04 09:23:11 testnode2 kernel:  kasan_save_stack+0x2c/0x50
> Jun 04 09:23:11 testnode2 kernel:  kasan_save_track+0x10/0x30
> Jun 04 09:23:11 testnode2 kernel:  kasan_save_free_info+0x37/0x60
> Jun 04 09:23:11 testnode2 kernel:  poison_slab_object+0x109/0x180
> Jun 04 09:23:11 testnode2 kernel:  __kasan_slab_free+0x2e/0x50
> Jun 04 09:23:11 testnode2 kernel:  kfree+0x11a/0x390
> Jun 04 09:23:11 testnode2 kernel:  srp_free_ch_ib+0x895/0xc80 [ib_srp]
> Jun 04 09:23:11 testnode2 kernel:  srp_remove_work+0x309/0x6c0 [ib_srp]
> Jun 04 09:23:11 testnode2 kernel:  process_one_work+0x865/0x1410
> Jun 04 09:23:11 testnode2 kernel:  worker_thread+0x5e2/0x1010
> Jun 04 09:23:11 testnode2 kernel:  kthread+0x2d1/0x3a0
> Jun 04 09:23:11 testnode2 kernel:  ret_from_fork+0x30/0x70
> Jun 04 09:23:11 testnode2 kernel:  ret_from_fork_asm+0x1a/0x30
> Jun 04 09:23:11 testnode2 kernel:
> Jun 04 09:23:11 testnode2 kernel: The buggy address belongs to the object at ffff888131a3e000
>                                     which belongs to the cache kmalloc-2k of size 2048
> Jun 04 09:23:11 testnode2 kernel: The buggy address is located 1048 bytes inside of
>                                     freed 2048-byte region [ffff888131a3e000, ffff888131a3e800)
> Jun 04 09:23:11 testnode2 kernel:
> Jun 04 09:23:11 testnode2 kernel: The buggy address belongs to the physical page:
> Jun 04 09:23:11 testnode2 kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888131a38000 pfn:0x131a38
> Jun 04 09:23:11 testnode2 kernel: head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> Jun 04 09:23:11 testnode2 kernel: flags: 0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
> Jun 04 09:23:11 testnode2 kernel: page_type: 0xffffefff(slab)
> Jun 04 09:23:11 testnode2 kernel: raw: 0017ffffc0000240 ffff888100042f00 ffffea0004c89610 ffffea0004a3c010
> Jun 04 09:23:11 testnode2 kernel: raw: ffff888131a38000 0000000000080006 00000001ffffefff 0000000000000000
> Jun 04 09:23:11 testnode2 kernel: head: 0017ffffc0000240 ffff888100042f00 ffffea0004c89610 ffffea0004a3c010
> Jun 04 09:23:11 testnode2 kernel: head: ffff888131a38000 0000000000080006 00000001ffffefff 0000000000000000
> Jun 04 09:23:11 testnode2 kernel: head: 0017ffffc0000003 ffffea0004c68e01 ffffffffffffffff 0000000000000000
> Jun 04 09:23:11 testnode2 kernel: head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> Jun 04 09:23:11 testnode2 kernel: page dumped because: kasan: bad access detected
> Jun 04 09:23:11 testnode2 kernel:
> Jun 04 09:23:11 testnode2 kernel: Memory state around the buggy address:
> Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Jun 04 09:23:11 testnode2 kernel: >ffff888131a3e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Jun 04 09:23:11 testnode2 kernel:                             ^
> Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> Jun 04 09:23:11 testnode2 kernel: ==================================================================
> Jun 04 09:23:11 testnode2 kernel: Disabling lock debugging due to kernel taint
> Jun 04 09:23:11 testnode2 kernel: device-mapper: multipath: 253:2: Failing path 8:80.
> Jun 04 09:23:11 testnode2 kernel: device-mapper: uevent: dm_send_uevents: skipping sending uevent for lost device
> ...
>
> [3] https://lore.kernel.org/linux-rdma/20230612054237.1855292-1-shinichiro.kawasaki@wdc.com/
> [4] https://lore.kernel.org/linux-rdma/g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv/
> [5] https://lore.kernel.org/linux-rdma/ZIn6ul5jPuxC+uIG@ziepe.ca/

-- 
Best Regards,
Yanjun.Zhu


