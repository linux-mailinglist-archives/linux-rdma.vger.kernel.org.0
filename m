Return-Path: <linux-rdma+bounces-5213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860AD99032E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 14:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086C41F23569
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5C1D4327;
	Fri,  4 Oct 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l4bA74dJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB31D0E37
	for <linux-rdma@vger.kernel.org>; Fri,  4 Oct 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045647; cv=none; b=OQRl+dYUXL3Cj6kl4k1udB1qow6NUj4wEks6PR7R30tpiAlpDPfyOw2TTIPwWELG0xPAdnSMzUEcNGp3XoHQBoOmOm4+lKgTJDE6CJDKBJzs0ySTEcOEx+ALpC2xB5XT5j0ujCqtM9mMSoAW6Rj4T2qSuB9mCj2+7pbdS8Zmuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045647; c=relaxed/simple;
	bh=22manBKxJlrvPLPzVgv/G2qodFQGaHOT7FOUpbQbW1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEXNYvTwW2nyr1CuNL7NQ/jWqqQUrrfMGGTHQyuw4kQOV2uG1zmgOZBBTJxlc6GH8xuk5tLoA+IwcAmprqlb0WtVj3qYt5JkiXIuo1VtY9kZm3+mLaj1l+X8uoSeDRHGcji52qFQQbgmlIR8DLW1bcpLYmwshKUA4bZ8CXKwzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l4bA74dJ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728045642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljNGHTx1Vey+gMA+7+An5He7ufB1Ct6PjDSNRWnhftU=;
	b=l4bA74dJQey/YADueu/OvaMdIKugW18fx9yIVRQ7hn8PnaLQJuJfgYpB0SXYuEgxU8GO/v
	H7UHNbEg8uSNFuRrFaMrtKULLwH6lH0glDJsodhz5spiqS3upYzCmgJ+QR8efkbvV8IPFf
	iqQSgl2IUVllcAmSIa14Yh8ZUmWwLzE=
Date: Fri, 4 Oct 2024 20:40:31 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/4 10:40, Shinichiro Kawasaki 写道:
> On Oct 03, 2024 / 13:56, Bart Van Assche wrote:
>> On 10/3/24 1:02 AM, Shinichiro Kawasaki wrote:
>>> #3: srp/001,002,011,012,013,014,016
>>>
>>>      The seven test cases in srp test group failed due to the WARN
>>>      "kmem_cache of name 'srpt-rsp-buf' already exists" [4]. The failures are
>>>      recreated in stable manner. They need further debug effort.
>>
>> Does the patch below help?
> 
> Thanks Bart, but unfortunately, still the test cases fail with the message
> below. I also noticed that similar WARN for 'srpt-req-buf' is observed. This
> problem apply to both 'srpt-rsp-buf' and 'srpt-req-buf', probably.
> 

Hi, Bart

I read the following commit in the link:

https://patchwork.kernel.org/project/linux-rdma/patch/20240920181129.37156-1-sebott@redhat.com/#:~:text=Add%20the%20device%20name%20to%20the%20per%20device

Maybe the root cause of this problem is the same with the above link.
So I add a jiffies (u64) value into the name.

Hope this can solve this problem.

Hi, Shinichiro

The following is the same with Bart's patch except that a jiffies value 
is added to make the name unique. I am not sure if you can make tests to 
verify this patch or not.

Thanks a lot.

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c 
b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9632afbd727b..ea1f8e6072ac 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2164,6 +2164,7 @@ static int srpt_cm_req_recv(struct srpt_device 
*const sdev,
         u32 it_iu_len;
         int i, tag_num, tag_size, ret;
         struct srpt_tpg *stpg;
+    char *cache_name;

         WARN_ON_ONCE(irqs_disabled());

@@ -2245,8 +2246,13 @@ static int srpt_cm_req_recv(struct srpt_device 
*const sdev,
         INIT_LIST_HEAD(&ch->cmd_wait_list);
         ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;

-       ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", 
ch->max_rsp_size,
+    cache_name = kasprintf(GFP_KERNEL, "srpt-rsp-buf-%s-%s-%d-%llu", 
src_addr,
+                   dev_name(&sport->sdev->device->dev), port_num, 
get_jiffies_64());
+    if (!cache_name)
+        goto free_ch;
+    ch->rsp_buf_cache = kmem_cache_create(cache_name, ch->max_rsp_size,
                                               512, 0, NULL);
+    kfree(cache_name);
         if (!ch->rsp_buf_cache)
                 goto free_ch;

Zhu Yanjun

> ------------[ cut here ]------------
> kmem_cache of name 'srpt-rsp-buf-fec0:0000:0000:0000:5054:00ff:fe12:3456-ens3_siw-1' already exists
> WARNING: CPU: 0 PID: 47 at mm/slab_common.c:107 __kmem_cache_create_args+0xa3/0x300
> Modules linked in: ib_srp scsi_transport_srp target_core_user target_core_pscsi target_core_file ib_srpt target_core_iblock target_core_mod rdma_cm iw_cm ib_cm ib_umad scsi_debug dm_service_time siw ib_uverbs null_blk ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc 9pnet_virtio ppdev 9pnet netfs e1000 i2c_piix4 parport_pc pcspkr parport i2c_smbus fuse loop nfnetlink zram bochs drm_vram_helper drm_ttm_helper ttm drm_kms_helper xfs nvme drm floppy nvme_core sym53c8xx scsi_transport_spi nvme_auth serio_raw ata_generic pata_acpi dm_multipath qemu_fw_cfg
> CPU: 0 UID: 0 PID: 47 Comm: kworker/u16:2 Not tainted 6.12.0-rc1+ #335
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> RIP: 0010:__kmem_cache_create_args+0xa3/0x300
> Code: 8d 58 98 48 3d d0 a7 25 b2 74 21 48 8b 7b 60 48 89 ee e8 30 cd 06 02 85 c0 75 e0 48 89 ee 48 c7 c7 d0 db b0 b1 e8 dd 92 82 ff <0f> 0b be 20 00 00 00 48 89 ef e8 8e cd 06 02 48 85 c0 0f 85 02 02
> RSP: 0018:ffff88810135f508 EFLAGS: 00010292
> RAX: 0000000000000000 RBX: ffff888100289400 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffffb11bea60 RDI: 0000000000000001
> RBP: ffff8881144bbb00 R08: 0000000000000001 R09: ffffed102026be4b
> R10: ffff88810135f25f R11: 0000000000000001 R12: 0000000000000100
> R13: ffff88810135f6c8 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8883ae000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4f8d878c58 CR3: 00000001376da000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ? __warn.cold+0x5f/0x1f8
>   ? __kmem_cache_create_args+0xa3/0x300
>   ? report_bug+0x1ec/0x390
>   ? handle_bug+0x58/0x90
>   ? exc_invalid_op+0x13/0x40
>   ? asm_exc_invalid_op+0x16/0x20
>   ? __kmem_cache_create_args+0xa3/0x300
>   ? __kmem_cache_create_args+0xa3/0x300
>   srpt_cm_req_recv.cold+0x12e0/0x46a4 [ib_srpt]
>   ? vsnprintf+0x38b/0x18f0
>   ? __pfx_vsnprintf+0x10/0x10
>   ? __pfx_srpt_cm_req_recv+0x10/0x10 [ib_srpt]
>   ? snprintf+0xa5/0xe0
>   ? __pfx_snprintf+0x10/0x10
>   ? lock_release+0x460/0x7a0
>   srpt_rdma_cm_req_recv+0x35d/0x460 [ib_srpt]
>   ? __pfx_srpt_rdma_cm_req_recv+0x10/0x10 [ib_srpt]
>   ? rcu_is_watching+0x11/0xb0
>   ? trace_cm_event_handler+0xf5/0x140 [rdma_cm]
>   cma_cm_event_handler+0x88/0x210 [rdma_cm]
>   iw_conn_req_handler+0x7a8/0xf10 [rdma_cm]
>   ? __pfx_iw_conn_req_handler+0x10/0x10 [rdma_cm]
>   ? alloc_work_entries+0x12f/0x260 [iw_cm]
>   cm_work_handler+0x143f/0x1ba0 [iw_cm]
>   ? __pfx_cm_work_handler+0x10/0x10 [iw_cm]
>   ? process_one_work+0x7de/0x1460
>   ? lock_acquire+0x2d/0xc0
>   ? process_one_work+0x7de/0x1460
>   process_one_work+0x85a/0x1460
>   ? __pfx_lock_acquire.part.0+0x10/0x10
>   ? __pfx_process_one_work+0x10/0x10
>   ? assign_work+0x16c/0x240
>   ? lock_is_held_type+0xd5/0x130
>   worker_thread+0x5e2/0xfc0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x2d1/0x3a0
>   ? _raw_spin_unlock_irq+0x24/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x30/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> irq event stamp: 53809
> hardirqs last  enabled at (53823): [<ffffffffae3d59ce>] __up_console_sem+0x5e/0x70
> hardirqs last disabled at (53834): [<ffffffffae3d59b3>] __up_console_sem+0x43/0x70
> softirqs last  enabled at (53864): [<ffffffffae2277ab>] __irq_exit_rcu+0xbb/0x1c0
> softirqs last disabled at (53843): [<ffffffffae2277ab>] __irq_exit_rcu+0xbb/0x1c0
> ---[ end trace 0000000000000000 ]---
> ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset = 68
> ------------[ cut here ]------------


