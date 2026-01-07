Return-Path: <linux-rdma+bounces-15342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88CCFCDA8
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 10:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BAB3300DA5E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3512FE571;
	Wed,  7 Jan 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JiVLt+hT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC72FD1C1
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777782; cv=none; b=pA+dFpGjIHi3GXVH9DmlaJvwTY8ktp5n3zl7nCTM+UuLSJtl0wOx4iNTrvsB5aqivxXKhvOi3leQgA6hiVkyliZpQcIR70Hs7lnnCgCy/9sSiEfFZWW6RJE3bAwW7+I3x6G5YDRNAiKqmqXhvwP87lkl+N+HnHhE2coYn2eIQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777782; c=relaxed/simple;
	bh=8t5AfwedzD5UfD3Feb7NPuwC6GKbCNGiKYjIoHFOcqg=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=A4Vb2SdiPzGD2uzUx3f8mLfEAuBeQ7Vrm6X43TYcnfh/E8izYY20qXhSZ6uwt9B+EKGfnyb7HfpQ+v051vPQCfiTTY80VTMs/wIW/KzI9b4oRTawWJQ58EcvuTKOtybBLOmRL5oy7qChb/nRpl8I7mfREB0JpxMeO50munkXJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JiVLt+hT; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1EVOhNNLKnB7P5xQAk/4mV4hgyeZJRPbFz4e54gTGKs=;
	b=JiVLt+hT5md+0me37q0TkjVDjpLovII4omoYoZ0+mcHNv6w8z/Y+HIqdNMzrffHIvmFJh4W9T
	rso5wWeT18xAVM8fZx0dSQuFjj7pKozlaogyfkaneAJIHz2DneudfYw7ucjb0ap9VjmvYPpzlpL
	57W5Y3S+aqnMzbydY9ot+g4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dmMtb3CyKzpStD;
	Wed,  7 Jan 2026 17:19:35 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A06D24036C;
	Wed,  7 Jan 2026 17:22:56 +0800 (CST)
Received: from [10.136.112.207] (10.136.112.207) by
 kwepemk500008.china.huawei.com (7.202.194.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 17:22:56 +0800
Message-ID: <239215b6-5780-4f58-a6f4-5bddf1edf33e@huawei.com>
Date: Wed, 7 Jan 2026 17:22:55 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
From: Chen Zhen <chenzhen126@huawei.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <huyizhen2@huawei.com>
Subject: Question about the relevance of "Fix memory corruption in CM"
 patchset to syzkaller bugs found on stable 5.10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500008.china.huawei.com (7.202.194.93)

Hi everyone,

I am reaching out to consult on two recent syzkaller issues found in the ib/cm module on stable 5.10.
Both issues occur when ib_cancel_mad interacts with cm_id_priv->av.port data.

I noticed the following patchset from Leon:
Fix memory corruption in CM, Link:https://lore.kernel.org/all/cover.1622629024.git.leonro@nvidia.com/
The description of that patchset mentions fixing memory corruption.

I would like to ask:
Is this specific patchset intended to cover the null-ptr-deref and UAF scenarios described below?
If not, is there any other known work regarding these lifetime issues in the CM module?

----------------------------------
Issue 1: null-ptr-deref in ib_modify_mad
This appears to be caused by cm_port->mad_agent being NULL
when ib_cancel_mad attempts to access it

BUG: KASAN: null-ptr-deref in ib_modify_mad+0xe8/0x580
Write of size 4 at addr 0000000000000060 by task syz.7.3487/15508

CPU: 2 PID: 15508 Comm: syz.7.3487 Tainted: G        W         5.10.0-xxxxx #1
Call traqmp_cmd_name: human-monitor-command, arguments: {"command-line": "info registers", "cpu-index": 1}
 dump_backtrace+0x0/0qmp_cmd_name: human-monitor-command, arguments: {"command-line": "info registers", "cpu-index": 2}
 show_stack+0x34/0x44qmp_cmd_name: human-monitor-command, arguments: {"command-line": "info registers", "cpu-index": 3}
 dump_stack+0x1d0/0x248
 __kasan_report+0x138/0x140
 kasan_report+0x44/0x5c
 check_memory_region+0xf8/0x1a0
 __kasan_check_write+0x20/0x30
 ib_modify_mad+0xe8/0x580
 ib_cancel_mad+0x34/0x44
 cm_destroy_id+0xd68/0xfec
 ib_destroy_cm_id+0x2c/0x40
 _destroy_id+0xb4/0x4a4
 destroy_id_handler_unlock+0x194/0x2cc
 rdma_destroy_id+0x30/0x40
 ucma_destroy_private_ctx+0x28c/0x2ac
 ucma_close+0x1a0/0x290
 __fput+0x168/0x5a0

----------------------------------
Issue 2: KASAN: use-after-free in cm_destroy_id
it seems cm_port has freed when ib_cancel_mad path in cm_destroy_id

BUG: KASAN: use-after-free in cm_destroy_id+0x2d4/0xfec
Read of size 8 at addr ffff3ec5e9f1e808 by task syz.8.3746/16234

CPU: 3 PID: 16234 Comm: syz.8.3746 Tainted: G        W         5.10.0-xxxxx #1
Hardware name: QEMU KVM Virtual Maqmp_cmd_name: qmp_capabilities, arguments: {}
Call traceqmp_cmd_name: human-monitor-command, arguments: {"command-line": "info registers", "cpu-index": 0}
 dump_backtrace+0x0/0x4a0
 print_qmp_cmd_name: human-monitor-command, arguments: {"command-line": "info registers", "cpu-index": 3}
 __kasan_report+0xe0/0x140
 kasan_report+0x44/0x5c
 __asan_load8+0xac/0xd0
 cm_destroy_id+0x2d4/0xfec
 ib_destroy_cm_id+0x2c/0x40
 _destroy_id+0xb4/0x4a4
 destroy_id_handler_unlock+0x194/0x2cc
 rdma_destroy_id+0x30/0x40
 ucma_destroy_private_ctx+0x28c/0x2ac
 ucma_close+0x1a0/0x290
 __fput+0x168/0x5a0
 ____fput+0x28/0x40
 task_work_run+0x1f8/0x360
 do_notify_resume+0x3d8/0x3e0
 work_pending+0xc/0x5e4

Allocated by task 6691:
 kasan_save_stack+0x28/0x60
 __kasan_kmalloc.constprop.0+0xa4/0xd0
 kasan_kmalloc+0x10/0x20
 kmem_cache_alloc_trace+0xb4/0x590
 cm_add_one+0x264/0x86c  // alloc cm_port
 add_client_context+0x3bc/0x4c0
 enable_device_and_get+0x178/0x300
 ib_register_device.part.0+0x11c/0x284
 ib_register_device+0x5c/0x7c
 rxe_register_device+0x1c4/0x280
 rxe_add+0x144/0x20c
 rxe_net_add+0x58/0xc0
 rxe_newlink+0xb0/0x100
 nldev_newlink+0x274/0x424
 rdma_nl_rcv_msg+0x244/0x3a0
 rdma_nl_rcv_skb.constprop.0.isra.0+0x220/0x2f4
 rdma_nl_rcv+0x28/0x3c
 netlink_unicast_kernel+0x124/0x290
 netlink_unicast+0x220/0x32c
 netlink_sendmsg+0x4a8/0x8bc
 __sock_sendmsg+0x90/0xd0
 ____sys_sendmsg+0x534/0x60c
 ___sys_sendmsg+0x10c/0x174
 __sys_sendmsg+0xfc/0x1a4
 __arm64_sys_sendmsg+0x58/0x6c
 invoke_syscall+0x70/0x130
 el0_svc_common.constprop.0+0x29c/0x2ac
 do_el0_svc+0x50/0x12c
 el0_svc+0x24/0x34
 el0_sync_handler+0x180/0x18c
 fast_work_pending464+0x178/0x18c

Freed by task 563:
 kasan_save_stack+0x28/0x60
 kasan_set_track+0x28/0x40
 kasan_set_free_info+0x28/0x50
 __kasan_slab_free+0x100/0x190
 kasan_slab_free+0x14/0x20
 kfree+0xac/0x680
 cm_remove_one+0x620/0x88c  //
 remove_client_context+0xc4/0x130
 disable_device+0x12c/0x240
 __ib_unregister_device+0x88/0x140
 ib_unregister_work+0x28/0x40
 process_one_work+0x468/0xabc
 worker_thread+0x120/0x810
 kthread+0x1b8/0x204
 ret_from_fork+0x10/0x18
----------------------------------

Any insights or suggestions would be greatly appreciated.

Best regards,
Chen Zhen


