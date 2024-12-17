Return-Path: <linux-rdma+bounces-6581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917239F4B3D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 13:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8894D7A16DD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4C1F1316;
	Tue, 17 Dec 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CSny3iql"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794671F03DE
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439845; cv=none; b=AsR+SXXCkAHC019Wm/2F6h+cAAvP6PLH/+hETM/aqY32ghOEu/H+QzaMEzWVEZs+tOKxgBWxE0BbOTe3RrzWR+E6HMgiwGe/HFY5Ut6VE2g9Vyh+AusluUuXosbQ1VjwrZLqXmqFzozg81wEZxPQYeg9db5KjkT3XEB6O1GEKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439845; c=relaxed/simple;
	bh=GA+djSqGDY1RFIcv/R7nkdjGtYzmg56B/WzVIh54E7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUos8F/DKbYuFTLxufEZ4AUpHZwCj/g6H4OXkSokX+ThZPNPJ9C8HiNmdQXLqMWAN+/hHxxPyRvrTSmi5XPvCFGvPycp6+KYz2778S8cvoI4aszQ5MtaVIomthn5rAizarz9RKd5dSnHs3x/fDseqQbKCEXP44HRM4cweXNuAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CSny3iql; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3bbcb1d-00bc-4218-85da-291bf368770d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734439839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPYCuEeLDn/6I/UoHhU2pgVxOltCHqKuIo/KzDnZ2bY=;
	b=CSny3iqlXNPVKJB9Zq8GZvfqCx7U88kP6ZsSiNXyj6C8qBpTTlLeeMJf+7WWy2ir2dtuku
	JaDmzxwOtqhm0BDyFonoXGj0Yio+Lld9nPXPoXB9f0CAsaF6vuiXzI/YGEct69mqm6TWs9
	vMjbtcnAYd5CAyFZJcJM0qpnIC1bncY=
Date: Tue, 17 Dec 2024 13:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] rdma_cm: unable to handle kernel NULL pointer dereference
 in process_one_work when disconnect
To: "xiyan@cestc.cn" <xiyan@cestc.cn>, linux-rdma <linux-rdma@vger.kernel.org>
Cc: markzhang <markzhang@nvidia.com>, phaddad <phaddad@nvidia.com>,
 leon <leon@kernel.org>, "yuan.liu" <yuan.liu@cestc.cn>,
 zhangsiyao <zhangsiyao@cestc.cn>, peizhiwei <peizhiwei@cestc.cn>,
 eaujames <eaujames@ddn.com>, ssmirnov <ssmirnov@whamcloud.com>
References: <2024121711472494997716@cestc.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <2024121711472494997716@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17.12.24 04:47, xiyan@cestc.cn wrote:
> Hello RDMA Community,
> While testing the RoCEv2 feature of the Lustre file system, we encountered a crash issue related to ARP updates. Preliminary analysis suggests that this issue may be kernel-related, and it is also observed in the nvmeof environment，We are eager to receive your assistance. Below are the detailed information regarding the issue  LU-18364.
> Thanks.
> 
> Lustre's client and server are deployed within the VM, The VM uses the network card PF pass-through mode.
> 【OS】
> VM Version: qemu-kvm-7.0.0
> OS Verion: Rocky 8.10
> Kernel Verion: 4.18.0-553.el8_10.x86_64
> 
> 【Network Card】
> Client：
> MLX CX6 1*100G RoCE v2
> MLNX_OFED_LINUX-23.10-3.2.2.0-rhel8.10-x86_64
> firmware-version: 22.35.2000 (MT_0000000359)
> 
> Server:
> MLX CX6 1*100G RoCE v2
> MLNX_OFED_LINUX-23.10-3.2.2.0-rhel8.10-x86_64
> firmware-version: 22.35.2000 (MT_0000000359)
> 
> 【Kernel Commit】
> [PATCH rdma-next v2 2/2] RDMA/core: Add a netevent notifier to cma - Leon Romanovsky
> https://lore.kernel.org/all/bb255c9e301cd50b905663b8e73f7f5133d0e4c5.1654601342.git.leonro@nvidia.com/
> 
> 【Lustre Issue】
> LU-18364：https://jira.whamcloud.com/browse/LU-18364
> LU-18275：https://jira.whamcloud.com/browse/LU-18275
> 
> 【Problem Reproduction Steps】
> We've found a stable reproduction step for the crash issue:
> 1. We only use one network card, and do not use bonding.
> 2. Use vdbench run read/write test case on the lustre client.
> 3. Construct an ARP update for a lustre server IP address on the lustre client.
> 
> for example, the lustre client ip is 192.168.122.220,  the lustre server ip is 192.168.122.115, so do "arp -s 192.168.122.115 10:71:fc:69:92:b8 && arp -d 192.168.122.115" on 192.168.122.220, 10:71:fc:69:92:b8 is a wrong mac address.
> 
> The crash stack is blow:
>        KERNEL: /usr/lib/debug/lib/modules/4.18.0-553.el8_10.x86_64/vmlinux  [TAINTED]
>      DUMPFILE: vmcore  [PARTIAL DUMP]
>          CPUS: 20
>          DATE: Tue Dec  3 14:58:41 CST 2024
>        UPTIME: 00:06:20
> LOAD AVERAGE: 10.14, 2.56, 0.86
>         TASKS: 1076
>      NODENAME: rocky8vm3
>       RELEASE: 4.18.0-553.el8_10.x86_64
>       VERSION: #1 SMP Fri May 24 13:05:10 UTC 2024
>       MACHINE: x86_64  (2599 Mhz)
>        MEMORY: 31.4 GB
>         PANIC: "BUG: unable to handle kernel NULL pointer dereference at 0000000000000008"
>           PID: 607
>       COMMAND: "kworker/u40:28"
>          TASK: ff1e34360b6e0000  [THREAD_INFO: ff1e34360b6e0000]
>           CPU: 1
>         STATE: TASK_RUNNING (PANIC)crash> bt
> PID: 607      TASK: ff1e34360b6e0000  CPU: 1    COMMAND: "kworker/u40:28"
>   #0 [ff4de14b444cbbc0] machine_kexec at ffffffff9c46f2d3
>   #1 [ff4de14b444cbc18] __crash_kexec at ffffffff9c5baa5a
>   #2 [ff4de14b444cbcd8] crash_kexec at ffffffff9c5bb991
>   #3 [ff4de14b444cbcf0] oops_end at ffffffff9c42d811
>   #4 [ff4de14b444cbd10] no_context at ffffffff9c481cf3
>   #5 [ff4de14b444cbd68] __bad_area_nosemaphore at ffffffff9c48206c
>   #6 [ff4de14b444cbdb0] do_page_fault at ffffffff9c482cf7
>   #7 [ff4de14b444cbde0] page_fault at ffffffff9d0011ae
>      [exception RIP: process_one_work+46]
>      RIP: ffffffff9c51944e  RSP: ff4de14b444cbe98  RFLAGS: 00010046
>      RAX: 0000000000000000  RBX: ff1e34360734b5d8  RCX: dead000000000200
>      RDX: 000000010001393f  RSI: ff1e34360734b5d8  RDI: ff1e343ca7eed5c0
>      RBP: ff1e343600019400   R8: ff1e343d37c73bb8   R9: 0000005885358800
>      R10: 0000000000000000  R11: ff1e343d37c71dc4  R12: 0000000000000000
>      R13: ff1e343600019420  R14: ff1e3436000194d0  R15: ff1e343ca7eed5c0
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #8 [ff4de14b444cbed8] worker_thread at ffffffff9c5197e0
>   #9 [ff4de14b444cbf10] kthread at ffffffff9c520e04
> #10 [ff4de14b444cbf50] ret_from_fork at ffffffff9d00028f
> 
> Another stack is below:
> [ 1656.060089] list_del corruption. next->prev should be ff4880c9d81b8d48, but was ff4880ccfb2d45e0

It seems that it is a memory corruption problem. The reason that causes 
this memory corruption is very complicated. Because you can reproduce 
this problem, perhaps some eBPF tools can help you to find out the root 
cause.

Zhu Yanjun

> [ 1656.060536] ------------[ cut here ]------------
> [ 1656.060538] kernel BUG at lib/list_debug.c:56!
> [ 1656.060738] invalid opcode: 0000 [#1] SMP NOPTI
> [ 1656.060872] CPU: 4 PID: 606 Comm: kworker/u40:27 Kdump: loaded Tainted: GF          OE     -------- -  - 4.18.0-553.el8_10.x86_64 #1
> [ 1656.061130] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-4.module+el8.9.0+1408+7b966129 04/01/2014
> [ 1656.061261] Workqueue: mlx5_cmd_0000:11:00.0 cmd_work_handler [mlx5_core]
> [ 1656.061457] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x48
> [ 1656.061586] Code: 45 d4 99 e8 5e 52 c7 ff 0f 0b 48 89 fe 48 89 c2 48 c7 c7 00 46 d4 99 e8 4a 52 c7 ff 0f 0b 48 c7 c7 b0 46 d4 99 e8 3c 52 c7 ff <0f> 0b 48 89 f2 48 89 fe 48 c7 c7 70 46 d4 99 e8 28 52 c7 ff 0f 0b
> [ 1656.061846] RSP: 0018:ff650559444dfe90 EFLAGS: 00010046
> [ 1656.061974] RAX: 0000000000000054 RBX: ff4880c9d81b8d40 RCX: 0000000000000000
> [ 1656.062103] RDX: 0000000000000000 RSI: ff4880cf9731e698 RDI: ff4880cf9731e698
> [ 1656.062238] RBP: ff4880c840019400 R08: 0000000000000000 R09: c0000000ffff7fff
> [ 1656.062366] R10: 0000000000000001 R11: ff650559444dfcb0 R12: ff4880c862647b00
> [ 1656.062492] R13: ff4880c879326540 R14: 0000000000000000 R15: ff4880c9d81b8d48
> [ 1656.062619] FS:  0000000000000000(0000) GS:ff4880cf97300000(0000) knlGS:0000000000000000
> [ 1656.062745] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1656.062868] CR2: 000055cc1af6b000 CR3: 000000084b610006 CR4: 0000000000771ee0
> [ 1656.062996] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1656.063127] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1656.063250] PKRU: 55555554
>        KERNEL: /usr/lib/debug/lib/modules/4.18.0-553.el8_10.x86_64/vmlinux  [TAINTED]
>      DUMPFILE: vmcore  [PARTIAL DUMP]
>          CPUS: 20
>          DATE: Fri Nov 29 17:37:31 CST 2024
>        UPTIME: 00:27:35
> LOAD AVERAGE: 350.47, 237.79, 163.91
>         TASKS: 1106
>      NODENAME: rocky8vm3
>       RELEASE: 4.18.0-553.el8_10.x86_64
>       VERSION: #1 SMP Fri May 24 13:05:10 UTC 2024
>       MACHINE: x86_64  (2599 Mhz)
>        MEMORY: 31.4 GB
>         PANIC: "kernel BUG at lib/list_debug.c:56!"
>           PID: 606
>       COMMAND: "kworker/u40:27"
>          TASK: ff4880c8793f8000  [THREAD_INFO: ff4880c8793f8000]
>           CPU: 4
>         STATE: TASK_RUNNING (PANIC)crash> bt
> PID: 606      TASK: ff4880c8793f8000  CPU: 4    COMMAND: "kworker/u40:27"
>   #0 [ff650559444dfc28] machine_kexec at ffffffff98a6f2d3
>   #1 [ff650559444dfc80] __crash_kexec at ffffffff98bbaa5a
>   #2 [ff650559444dfd40] crash_kexec at ffffffff98bbb991
>   #3 [ff650559444dfd58] oops_end at ffffffff98a2d811
>   #4 [ff650559444dfd78] do_trap at ffffffff98a29a27
>   #5 [ff650559444dfdc0] do_invalid_op at ffffffff98a2a766
>   #6 [ff650559444dfde0] invalid_op at ffffffff99600da4
>      [exception RIP: __list_del_entry_valid.cold.1+32]
>      RIP: ffffffff98ef8f98  RSP: ff650559444dfe90  RFLAGS: 00010046
>      RAX: 0000000000000054  RBX: ff4880c9d81b8d40  RCX: 0000000000000000
>      RDX: 0000000000000000  RSI: ff4880cf9731e698  RDI: ff4880cf9731e698
>      RBP: ff4880c840019400   R8: 0000000000000000   R9: c0000000ffff7fff
>      R10: 0000000000000001  R11: ff650559444dfcb0  R12: ff4880c862647b00
>      R13: ff4880c879326540  R14: 0000000000000000  R15: ff4880c9d81b8d48
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #7 [ff650559444dfe90] process_one_work at ffffffff98b19557
>   #8 [ff650559444dfed8] worker_thread at ffffffff98b197e0
>   #9 [ff650559444dff10] kthread at ffffffff98b20e04
> #10 [ff650559444dff50] ret_from_fork at ffffffff9960028f
> 
> This bug seems to be in rdma_cm module on the MOFED/kernel side. So we try to reproduce the crash on the Nvme-oF node:
> 1. Mount the nvme-of disk, do "nvme connect -t rdma -n "nqn.2014-08.org.nvmexpress:67240ebd3fa63ca3" -a 192.168.122.30 -s 4421"
> 2. Use dd run write/read test case, for example, "dd if=/dev/nvme0n17 of=./test bs=32K count=102400 oflag=direct"
> 3. Construct an ARP update, do "arp -s 192.168.122.112 10:71:fe:69:93:b8 && arp -d 192.168.122.112" on the nvme_of client.
> 4. The crash is already reproduce.
> 
> The issue may involve the following key points:
> 1. The RDMA module receives multiple network events simultaneously.
> 2. We have observed that during normal ARP updates, one or more events may be generated, making this issue probabilistic.
> 3. When both ARP update events and connection termination (conn disconnect) events are received at the same time, it triggers issue LU-18275.


