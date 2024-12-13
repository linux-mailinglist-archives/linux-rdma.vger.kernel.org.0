Return-Path: <linux-rdma+bounces-6515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63D9F154F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 19:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C331886665
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FDC1E0B86;
	Fri, 13 Dec 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fx2oquCN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADD1547CA
	for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116150; cv=none; b=Heigdf0P4vp4y7NL0cPUJW9DetZmSut0gDUB6eNTiS6J5x0tq0v4dccD/BojX5sg+7Sp1KwgJbE3Y5BQzsJXUMy4dl/VnKwxDIqRf8u4eKbGrXTFEA930Oj6w1ZAaZ2eI0oezAXhTU+gfjyh0G9Qgp8DCpacBuyLmSnFre0h9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116150; c=relaxed/simple;
	bh=soq1yXGsHXMUm07UoCdXANyKB+lioDphdGzNzMsUaOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oa8U9z+uO2m8WOqWowMvC6Gp5jUaxc3uqI/kgFIH5I4+/aSMndtwLC2pfKO6ZrVfzEg7nLKaIQRKwK+xW/rjzuM6mh/PzRaoUOVsIxkwFRz6g3Ujqa4Y422xmJAM+TeFMxQYl6DL4hG3pTWQyg6dvRj76FzSnst/uH9+nYqCsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fx2oquCN; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6067519-26ab-4851-ba58-3ebe254e88d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734116143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyvTGbyEjGvxf1i83uqubIH3AF5GIztZsZ1bOoFH9TM=;
	b=fx2oquCNqiKVebHZ6DW5UdEDbZ+4YL2eBZLs1nkAYKiQFLF+JQWEvTg3/VZOLiTETTFW0+
	X1zIKLi5gLS3WZLyh71fDMpfwEgw6avLKU74TuN7sfbTsutKHd2iCzkTyHqd74OiyGitKc
	83X8wxrNNiYir5eQR4yoNxG16MAbraU=
Date: Fri, 13 Dec 2024 19:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker
 [irdma]
To: Honggang LI <honggangli@163.com>, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org
References: <Z1wBEgluXUDrDJmN@fc39>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z1wBEgluXUDrDJmN@fc39>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/12/13 10:40, Honggang LI 写道:
> It is 100% reproducible. The NVMEoRDMA client side is running RXE.
> To reproduce it, the clinet side repeat to connect and disconnect
> to the NVMEoRDMA target.
> 
> [ 685.757357] ------------[ cut here ]------------
> [ 685.758725] workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker [irdma]
> [ 685.758809] WARNING: CPU: 16 PID: 1897 at kernel/workqueue.c:2966 check_flush_dependency+0x11f/0x140
> [ 685.762880] Modules linked in: nvmet_rdma nvmet nvme_keyring tcm_loop target_core_user uio target_core_pscsi target_core_file target_core_iblock rpcrdma qrtr rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod rfkill ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp sunrpc kvm_intel kvm irqbypass binfmt_misc rapl intel_cstate irdma ipmi_ssif i40e iTCO_wdt intel_pmc_bxt iTCO_vendor_support ib_uverbs acpi_ipmi intel_uncore joydev ipmi_si pcspkr mxm_wmi ib_core mei_me ipmi_devintf i2c_i801 mei i2c_smbus lpc_ich ioatdma ipmi_msghandler loop dm_multipath nfnetlink zram ice crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic nvme isci nvme_core ghash_clmulni_intel sha512_ssse3 igb sha256_ssse3 libsas sha1_ssse3 nvme_auth mgag200 scsi_transport_sas dca gnss i2c_algo_bit wmi scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tables ip_tables fuse
> [ 685.773891] CPU: 16 PID: 1897 Comm: kworker/16:2 Kdump: loaded Tainted: G S 6.8.4-300.patched.fc40.x86_64 #1
> [ 685.775267] Hardware name: Sugon I620-G10/X9DR3-F, BIOS 3.0b 07/22/2014
> [ 685.776627] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
> [ 685.777993] RIP: 0010:check_flush_dependency+0x11f/0x140

Maybe it is related with this line. What is the above line?

Zhu Yanjun

> [ 685.779331] Code: 8b 45 18 48 8d b2 b0 00 00 00 49 89 e8 48 8d 8b b0 00 00 00 48 c7 c7 28 fe b1 b2 c6 05 4f 97 59 02 01 48 89 c2 e8 a1 91 fd ff <0f> 0b e9 fc fe ff ff 80 3d 3a 97 59 02 00 75 93 e9 2a ff ff ff 66
> [ 685.782050] RSP: 0018:ffffb31348793cc8 EFLAGS: 00010082
> [ 685.783398] RAX: 0000000000000000 RBX: ffff96c705754800 RCX: 0000000000000027
> [ 685.784744] RDX: ffff96ce5fca18c8 RSI: 0000000000000001 RDI: ffff96ce5fca18c0
> [ 685.786077] RBP: ffffffffc0d217f0 R08: 0000000000000000 R09: ffffb31348793b38
> [ 685.787390] R10: ffffffffb3516808 R11: 0000000000000003 R12: ffff96c70d2aa8c0
> [ 685.788688] R13: ffff96c7043c6a80 R14: 0000000000000001 R15: ffff96c704147400
> [ 685.789970] FS: 0000000000000000(0000) GS:ffff96ce5fc80000(0000) knlGS:0000000000000000
> [ 685.791239] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 685.792495] CR2: 00007f8207151000 CR3: 0000000d15422006 CR4: 00000000001706f0
> [ 685.793745] Call Trace:
> [ 685.794973] <TASK>
> [ 685.796179] ? check_flush_dependency+0x11f/0x140
> [ 685.797382] ? __warn+0x81/0x130
> [ 685.798563] ? check_flush_dependency+0x11f/0x140
> [ 685.799732] ? report_bug+0x16f/0x1a0
> [ 685.800882] ? handle_bug+0x3c/0x80
> [ 685.802003] ? exc_invalid_op+0x17/0x70
> [ 685.803107] ? asm_exc_invalid_op+0x1a/0x20
> [ 685.804200] ? __pfx_irdma_flush_worker+0x10/0x10 [irdma]
> [ 685.805315] ? check_flush_dependency+0x11f/0x140
> [ 685.806373] ? check_flush_dependency+0x11f/0x140
> [ 685.807407] __flush_work.isra.0+0x10d/0x290
> [ 685.808420] __cancel_work_timer+0x103/0x1a0
> [ 685.809418] irdma_destroy_qp+0xd4/0x180 [irdma]
> [ 685.810437] ib_destroy_qp_user+0x93/0x1a0 [ib_core]
> [ 685.811474] nvmet_rdma_free_queue+0x35/0xc0 [nvmet_rdma]
> [ 685.812437] nvmet_rdma_release_queue_work+0x1d/0x50 [nvmet_rdma]
> [ 685.813385] process_one_work+0x170/0x330
> [ 685.814300] worker_thread+0x280/0x3d0
> [ 685.815201] ? __pfx_worker_thread+0x10/0x10
> [ 685.816090] kthread+0xe8/0x120
> [ 685.816956] ? __pfx_kthread+0x10/0x10
> [ 685.817801] ret_from_fork+0x34/0x50
> [ 685.818633] ? __pfx_kthread+0x10/0x10
> [ 685.819439] ret_from_fork_asm+0x1b/0x30
> [ 685.820232] </TASK>
> [ 685.820994] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [ 685.821749] CPU: 16 PID: 1897 Comm: kworker/16:2 Kdump: loaded Tainted: G S 6.8.4-300.patched.fc40.x86_64 #1
> [ 685.822513] Hardware name: Sugon I620-G10/X9DR3-F, BIOS 3.0b 07/22/2014
> [ 685.823259] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
> [ 685.824002] Call Trace:
> [ 685.824706] <TASK>
> [ 685.825386] dump_stack_lvl+0x4d/0x70
> [ 685.826060] panic+0x33e/0x370
> [ 685.826724] ? check_flush_dependency+0x11f/0x140
> [ 685.827383] check_panic_on_warn+0x44/0x60
> [ 685.828021] __warn+0x8d/0x130
> [ 685.828629] ? check_flush_dependency+0x11f/0x140
> [ 685.829229] report_bug+0x16f/0x1a0
> [ 685.829819] handle_bug+0x3c/0x80
> [ 685.830396] exc_invalid_op+0x17/0x70
> [ 685.830972] asm_exc_invalid_op+0x1a/0x20
> [ 685.831548] RIP: 0010:check_flush_dependency+0x11f/0x140
> [ 685.832129] Code: 8b 45 18 48 8d b2 b0 00 00 00 49 89 e8 48 8d 8b b0 00 00 00 48 c7 c7 28 fe b1 b2 c6 05 4f 97 59 02 01 48 89 c2 e8 a1 91 fd ff <0f> 0b e9 fc fe ff ff 80 3d 3a 97 59 02 00 75 93 e9 2a ff ff ff 66
> [ 685.833341] RSP: 0018:ffffb31348793cc8 EFLAGS: 00010082
> [ 685.833954] RAX: 0000000000000000 RBX: ffff96c705754800 RCX: 0000000000000027
> [ 685.834569] RDX: ffff96ce5fca18c8 RSI: 0000000000000001 RDI: ffff96ce5fca18c0
> [ 685.835196] RBP: ffffffffc0d217f0 R08: 0000000000000000 R09: ffffb31348793b38
> [ 685.835823] R10: ffffffffb3516808 R11: 0000000000000003 R12: ffff96c70d2aa8c0
> [ 685.836450] R13: ffff96c7043c6a80 R14: 0000000000000001 R15: ffff96c704147400
> [ 685.837079] ? __pfx_irdma_flush_worker+0x10/0x10 [irdma]
> [ 685.837755] ? check_flush_dependency+0x11f/0x140
> [ 685.838394] __flush_work.isra.0+0x10d/0x290
> [ 685.839037] __cancel_work_timer+0x103/0x1a0
> [ 685.839679] irdma_destroy_qp+0xd4/0x180 [irdma]
> [ 685.840354] ib_destroy_qp_user+0x93/0x1a0 [ib_core]
> [ 685.841049] nvmet_rdma_free_queue+0x35/0xc0 [nvmet_rdma]
> [ 685.841707] nvmet_rdma_release_queue_work+0x1d/0x50 [nvmet_rdma]
> [ 685.842367] process_one_work+0x170/0x330
> [ 685.843020] worker_thread+0x280/0x3d0
> [ 685.843670] ? __pfx_worker_thread+0x10/0x10
> [ 685.844316] kthread+0xe8/0x120
> [ 685.844955] ? __pfx_kthread+0x10/0x10
> [ 685.845590] ret_from_fork+0x34/0x50
> [ 685.846223] ? __pfx_kthread+0x10/0x10
> [ 685.846853] ret_from_fork_asm+0x1b/0x30
> [ 685.847485] </TASK>
> 


