Return-Path: <linux-rdma+bounces-17569-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDo4E3A+qmnGNwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17569-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 03:39:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34521AA86
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 03:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B444C30626F7
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 02:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA6C35F5EB;
	Fri,  6 Mar 2026 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cgxvT4Uo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F246351C3F
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764749; cv=none; b=VyP9qujCpcbI80RVwLX1P7hl5iEE4gDs8eG14IvvFGZEXdLnGn60pwB8DPb87eQvhob3O/2XSDDRUL/QtkOdq614lsNIzXAkrqkMcnIn7RVQ1BdUS7Jq8cSs2D8cJP+U8c8MMTWEwJ3L/2+A2FuYOYjl5TjBlq//esI1L1QWnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764749; c=relaxed/simple;
	bh=FkvuhUBHIqr4E2M4tiQMsiH65e/+r9PO5Eizr83TSRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dHkRcQbO5Sbe5v1HQg/Vtc03Brpq4QfifzAbRbjBoYaTUKfIhqs+R/8ATummm8vOENLGZQLWzoPMEtEgzlBMc3rnIlIuYuY32vZSvDrUFQDOX6dS+njBw12tZ0iKDIIz2cWhiT+z+vzwDDiceoainTKbhyQR83vtAR6TWtsQ8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cgxvT4Uo; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77019524-bd77-4bd8-89ee-ca134eea2a74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772764743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoiZ45jXBjQgIvnQuGIaKFTwI4wWQ2bz00OvLaOPLCc=;
	b=cgxvT4UogbOOGsGU/+e5apsqpGmgF0w8N+FnSQ5eGSbTw3RpRh8g+PC+uvG8sidm40jTV3
	LeO6W2LQbuBfHePzhdr8edN6AWfTGIsxYxEFUKT6rR0upNayJsWJG6gGegAaSLV9yvnDo2
	5JXf9IMWmNe+O5RT1IFtg6kT9hGHliA=
Date: Thu, 5 Mar 2026 18:38:59 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net
 namespace
To: David Ahern <dsahern@kernel.org>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
 <c6b20dd4-2f9e-45d2-9df7-0b15b22d3b5a@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <c6b20dd4-2f9e-45d2-9df7-0b15b22d3b5a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1B34521AA86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17569-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action


On 3/5/26 10:54 AM, David Ahern wrote:
> On 3/3/26 9:16 PM, Zhu Yanjun wrote:
>> When run "ip link add" command to add a rxe rdma link in a net
>> namespace, normally this rxe rdma link can not work in a net
>> name space.
>>
>> The root cause is that a sock listening on udp port 4791 is created
>> in init_net when the rdma_rxe module is loaded into kernel. That is,
>> the sock listening on udp port 4791 is created in init_net. Other net
>> namespace is difficult to use this sock.
>>
>> The following commits will solve this problem.
> you squashed all of the changes into 1 commit, so either the commit
> message needs to be fixed up or you need to do the patch series.
>
> That said, I still think the optimizations around tracking the number of
> devices in the namespace and closing the sockets are unncessary at this
> time. It brings in complications to your set which is delaying the merge
> of namespace support. If it is done, the socket refcount approach seems
> problematic; how about a simpler approach with a device count in the
> net_generic struct used per namespace (again, I really believe this
> should be a follow on patch).

I changed the "#define SK_REF_FOR_TUNNEL    1"  according to the 
comments from Claude.

The followings will appear. If I still use 2, the following will disappear.

Please use Claude to analyze. Thanks a lot.

Mar  5 18:25:18 localhost kernel: ------------[ cut here ]------------
Mar  5 18:25:18 localhost kernel: refcount_t: decrement hit 0; leaking 
memory.
Mar  5 18:25:18 localhost kernel: WARNING: lib/refcount.c:31 at 
refcount_warn_saturate+0x22/0x90, CPU#6: kworker/u32:0/12
Mar  5 18:25:18 localhost kernel: Modules linked in: rpcrdma rdma_ucm 
ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi 
scsi_transport_iscsi rdma_cm iw_cm ib_cm rdma_rxe(-) ib_uverbs ib_core 
sunrpc qrtr rfkill binfmt_misc intel_rapl_msr intel_rapl_common 
intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery 
pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel kvm irqbypass 
rapl snd_hda_codec_generic iTCO_wdt intel_pmc_bxt snd_hda_intel joydev 
snd_hda_codec snd_hda_core pcspkr i2c_i801 snd_intel_dspcfg i2c_smbus 
snd_intel_sdw_acpi snd_hwdep snd_pcm virtio_net snd_timer virtio_balloon 
snd net_failover soundcore lpc_ich failover dm_multipath loop nfnetlink 
vsock_loopback vmw_vsock_virtio_transport_common 
vmw_vsock_vmci_transport vsock vmw_vmci zram xfs ghash_clmulni_intel 
virtio_gpu virtio_dma_buf serio_raw scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua i2c_dev fuse qemu_fw_cfg [last unloaded: veth]
Mar  5 18:25:18 localhost kernel: CPU: 6 UID: 0 PID: 12 Comm: 
kworker/u32:0 Not tainted 7.0.0-rc2-net-ns+ #25 PREEMPT(lazy)
Mar  5 18:25:18 localhost kernel: Hardware name: QEMU Standard PC (Q35 + 
ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Mar  5 18:25:18 localhost kernel: Workqueue: netns cleanup_net
Mar  5 18:25:18 localhost kernel: RIP: 0010:refcount_warn_saturate+0x22/0x90
Mar  5 18:25:18 localhost kernel: Code: 90 90 90 90 90 90 90 90 f3 0f 1e 
fa c7 07 00 00 00 c0 83 fe 02 74 54 76 1b 83 fe 03 74 3c 83 fe 04 75 26 
48 8d 3d 0e 31 a6 01 <67> 48 0f b9 3a e9 d4 a4 95 00 85 f6 74 44 48 8d 
3d 09 31 a6 01 67
Mar  5 18:25:18 localhost kernel: RSP: 0018:ffffd5544006bd00 EFLAGS: 
00010246
Mar  5 18:25:18 localhost kernel: RAX: 0000000000000001 RBX: 
ffff8de482a58fc0 RCX: ffff8de4824d0000
Mar  5 18:25:18 localhost kernel: RDX: 0000000000000000 RSI: 
0000000000000004 RDI: ffffffffbcea51d0
Mar  5 18:25:18 localhost kernel: RBP: ffff8de4824ccd60 R08: 
000000097fbbc089 R09: 0000000000000001
Mar  5 18:25:18 localhost kernel: R10: 0000000000000006 R11: 
0000000000000000 R12: ffff8de4824ee000
Mar  5 18:25:18 localhost kernel: R13: ffff8de4824ccd6c R14: 
ffffffffbce81fa0 R15: 0000000000007f00
Mar  5 18:25:18 localhost kernel: FS:  0000000000000000(0000) 
GS:ffff8de63a3af000(0000) knlGS:0000000000000000
Mar  5 18:25:18 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Mar  5 18:25:18 localhost kernel: CR2: 00007f935f994cec CR3: 
00000001036d3002 CR4: 0000000000772ef0
Mar  5 18:25:18 localhost kernel: PKRU: 55555554
Mar  5 18:25:18 localhost kernel: Call Trace:
Mar  5 18:25:18 localhost kernel: <TASK>
Mar  5 18:25:18 localhost kernel: udp_lib_unhash+0x259/0x280
Mar  5 18:25:18 localhost kernel: sk_common_release+0x3a/0x100
Mar  5 18:25:18 localhost kernel: inet_release+0x43/0x80
Mar  5 18:25:18 localhost kernel: sock_release+0x24/0x70
Mar  5 18:25:18 localhost kernel: rxe_ns_exit+0x53/0x90 [rdma_rxe]
Mar  5 18:25:18 localhost kernel: ops_undo_list+0xdb/0x220
Mar  5 18:25:18 localhost kernel: cleanup_net+0x1f6/0x370
Mar  5 18:25:18 localhost kernel: process_one_work+0x192/0x390
Mar  5 18:25:18 localhost kernel: worker_thread+0x196/0x300
Mar  5 18:25:18 localhost kernel: ? __pfx_worker_thread+0x10/0x10
Mar  5 18:25:18 localhost kernel: kthread+0xe3/0x120
Mar  5 18:25:18 localhost kernel: ? __pfx_kthread+0x10/0x10
Mar  5 18:25:18 localhost kernel: ret_from_fork+0x1a1/0x270
Mar  5 18:25:18 localhost kernel: ? __pfx_kthread+0x10/0x10
Mar  5 18:25:18 localhost kernel: ret_from_fork_asm+0x1a/0x30
Mar  5 18:25:18 localhost kernel: </TASK>
Mar  5 18:25:18 localhost kernel: ---[ end trace 0000000000000000 ]---
Mar  5 18:25:18 localhost kernel: ------------[ cut here ]------------
Mar  5 18:25:18 localhost kernel: refcount_t: underflow; use-after-free.
Mar  5 18:25:18 localhost kernel: WARNING: lib/refcount.c:28 at 
refcount_warn_saturate+0x59/0x90, CPU#6: kworker/u32:0/12
Mar  5 18:25:18 localhost kernel: Modules linked in: rpcrdma rdma_ucm 
ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi 
scsi_transport_iscsi rdma_cm iw_cm ib_cm rdma_rxe(-) ib_uverbs ib_core 
sunrpc qrtr rfkill binfmt_misc intel_rapl_msr intel_rapl_common 
intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery 
pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel kvm irqbypass 
rapl snd_hda_codec_generic iTCO_wdt intel_pmc_bxt snd_hda_intel joydev 
snd_hda_codec snd_hda_core pcspkr i2c_i801 snd_intel_dspcfg i2c_smbus 
snd_intel_sdw_acpi snd_hwdep snd_pcm virtio_net snd_timer virtio_balloon 
snd net_failover soundcore lpc_ich failover dm_multipath loop nfnetlink 
vsock_loopback vmw_vsock_virtio_transport_common 
vmw_vsock_vmci_transport vsock vmw_vmci zram xfs ghash_clmulni_intel 
virtio_gpu virtio_dma_buf serio_raw scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua i2c_dev fuse qemu_fw_cfg [last unloaded: veth]
Mar  5 18:25:18 localhost kernel: CPU: 6 UID: 0 PID: 12 Comm: 
kworker/u32:0 Tainted: G        W           7.0.0-rc2-net-ns+ #25 
PREEMPT(lazy)
Mar  5 18:25:18 localhost kernel: Tainted: [W]=WARN
Mar  5 18:25:18 localhost kernel: Hardware name: QEMU Standard PC (Q35 + 
ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Mar  5 18:25:18 localhost kernel: Workqueue: netns cleanup_net
Mar  5 18:25:18 localhost kernel: RIP: 0010:refcount_warn_saturate+0x59/0x90
Mar  5 18:25:18 localhost kernel: Code: 44 48 8d 3d 09 31 a6 01 67 48 0f 
b9 3a e9 bf a4 95 00 48 8d 3d 08 31 a6 01 67 48 0f b9 3a c3 cc cc cc cc 
48 8d 3d 07 31 a6 01 <67> 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 06 31 a6 
01 67 48 0f b9 3a
Mar  5 18:25:18 localhost kernel: RSP: 0018:ffffd5544006bd58 EFLAGS: 
00010246
Mar  5 18:25:18 localhost kernel: RAX: 00000000c0000000 RBX: 
ffff8de482a58fc0 RCX: ffff8de4824d0000
Mar  5 18:25:18 localhost kernel: RDX: 00000000000000ff RSI: 
0000000000000003 RDI: ffffffffbcea5200
Mar  5 18:25:18 localhost kernel: RBP: ffff8de491630000 R08: 
000000097fbbc089 R09: 0000000000000001
Mar  5 18:25:18 localhost kernel: R10: 0000000000000006 R11: 
0000000000000000 R12: ffff8de482a58fc0
Mar  5 18:25:18 localhost kernel: R13: ffffffffbcdce910 R14: 
ffffffffbcdce910 R15: ffffd5544006bdb8
Mar  5 18:25:18 localhost kernel: FS:  0000000000000000(0000) 
GS:ffff8de63a3af000(0000) knlGS:0000000000000000
Mar  5 18:25:18 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Mar  5 18:25:18 localhost kernel: CR2: 00007f935f994cec CR3: 
00000001036d3002 CR4: 0000000000772ef0
Mar  5 18:25:18 localhost kernel: PKRU: 55555554
Mar  5 18:25:18 localhost kernel: Call Trace:
Mar  5 18:25:18 localhost kernel: <TASK>
Mar  5 18:25:18 localhost kernel: inet_release+0x43/0x80
Mar  5 18:25:18 localhost kernel: sock_release+0x24/0x70
Mar  5 18:25:18 localhost kernel: rxe_ns_exit+0x53/0x90 [rdma_rxe]
Mar  5 18:25:18 localhost kernel: ops_undo_list+0xdb/0x220
Mar  5 18:25:18 localhost kernel: cleanup_net+0x1f6/0x370
Mar  5 18:25:18 localhost kernel: process_one_work+0x192/0x390
Mar  5 18:25:18 localhost kernel: worker_thread+0x196/0x300
Mar  5 18:25:18 localhost kernel: ? __pfx_worker_thread+0x10/0x10
Mar  5 18:25:18 localhost kernel: kthread+0xe3/0x120
Mar  5 18:25:18 localhost kernel: ? __pfx_kthread+0x10/0x10
Mar  5 18:25:18 localhost kernel: ret_from_fork+0x1a1/0x270
Mar  5 18:25:18 localhost kernel: ? __pfx_kthread+0x10/0x10
Mar  5 18:25:18 localhost kernel: ret_from_fork_asm+0x1a/0x30
Mar  5 18:25:18 localhost kernel: </TASK>
Mar  5 18:25:18 localhost kernel: ---[ end trace 0000000000000000 ]---
Mar  5 18:25:18 localhost kernel: rdma_rxe: unloaded
Mar  5 18:25:18 localhost NetworkManager[762]: <info> [1772763918.8424] 
manager: (veth1): new Veth device 
(/org/freedesktop/NetworkManager/Devices/7)
Mar  5 18:25:18 localhost NetworkManager[762]: <info> [1772763918.8428] 
manager: (veth0): new Veth device 
(/org/freedesktop/NetworkManager/Devices/8)
Mar  5 18:25:18 localhost kernel: rdma_rxe: loaded

Zhu Yanjun

>
> Also, claude has some comments about this patch. See attached. At this
> point surely you have access to some AI model that can do code reviews.
> There are prompts here https://github.com/masoncl/review-prompts.git
> that can be leveraged as I did here.

