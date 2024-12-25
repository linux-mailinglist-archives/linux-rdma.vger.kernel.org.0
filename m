Return-Path: <linux-rdma+bounces-6743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099CD9FC6E8
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 00:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0221881AD1
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2521531C2;
	Wed, 25 Dec 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dU/lwiYv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD08BFF
	for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735170633; cv=none; b=CFDIoEXu6C9C7lwdFb04TIPmM4J8Nt9WKVc6bRJ7ZUrNPdRdv2t3Zs1fdKd/39Xp2Tdk0EqKUrsyJ307WKWXBgCKGx+hM9cZqKXRciGZ3bLOobya7hXvthXq4KcRvR1rtMAHbQTM03RjmD/TZjjCrDdajhUtH7y+uZXT5oC8/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735170633; c=relaxed/simple;
	bh=Vzz2PYxxvTtruOZj69hM7ffxIqPxM/tmP6SZ85cDw7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FWXN/Y91LXw1LE6MID6ssh2obdmhJP3OGOMbyv8r2r4i7qG8CwcYU2HBqX2D0cJPZbUahkLwNC+BEkFjccXYez6DffRu40b+VAygKhqtvzHrZAiphXAT0Z2A0e7kZEOpXPStx1FjH5ZhpLlL2AEfvUGbzKpr1B2pit+PGzFsXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dU/lwiYv; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4b877ca-acbd-4c7a-9d32-00ee56ea6cf0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735170627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oK1qdxdeQ0Z+ZATU+i+6FP/CUQaIImIRKbnL69tn9IY=;
	b=dU/lwiYvec8TSbiwdGdAh3M0pDfOefhw1DSW+KjglUG5zxnfNYri+BKkjxocy8bRFRekCT
	+AH6V/yZUIx+Ead+PaRIXyWB/kMugLphbg3Mt/9aGEbh1xVfrxL/FyPBPUYs3kQxdGe2qH
	Korg2BLOFJLaizY/hV84MufokWq5fzg=
Date: Thu, 26 Dec 2024 00:50:25 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: When upgrading to kernel 6.12.4, I got the following error with
 rdma_rxe module.
To: Yiyi Hu <yiyihu@gmail.com>, linux-rdma@vger.kernel.org
References: <CA+-1TMMRS7C7015ZSCJ1zXCWenqxskzNONZdsSVW9TmFPDXBYA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CA+-1TMMRS7C7015ZSCJ1zXCWenqxskzNONZdsSVW9TmFPDXBYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/12/25 21:04, Yiyi Hu 写道:
> Hi, I'm using 6.6.x kernel, after I upgraded to kernel 6.12.x for my
> home server, I got the following error. Which causes soft rdma doesn't
> work for 6.12.x with my setup.

I read this bug descriptions for several times. To be honest, I am also 
confused with this problem.

It seems that with 6.6.x kernel, it can work well. And with 6.12.x, it 
can not work.

So maybe "git bisect" is a good tool to find the commit that causes this 
problems.

Zhu Yanjun

> 
> The kernel warning is:
> 
> # [  134.041117] ------------[ cut here ]------------
> # [  134.041120] WARNING: CPU: 9 PID: 0 at
> drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0xbc/0x110
> [rdma_rxe]
> # [  134.041128] Modules linked in: dm_cache_smq dm_cache
> dm_persistent_data dm_bio_prison 8021q garp mrp macvtap macvlan veth
> dummy bridge stp llc nft_ct nf_tables sch_fq_codel virtio_vdpa vduse
> vdpa rdma_rxe ip6_udp_tunnel udp_tunnel nvme_rdma nvmet_rdma raid456
> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq raid1 raid0 bcache nvmet nvme_auth dm_writecache msr thermal
> rpcrdma rdma_ucm ib_iser ib_umad rdma_cm ib_ipoib iw_cm ib_cm
> rt2800usb rt2x00usb rt2800lib rt2x00lib ee1004 wmi_bmof mxm_wmi evdev
> mac80211 snd_hda_codec_realtek snd_hda_codec_generic
> snd_hda_scodec_component cfg80211 rfkill snd_hda_intel
> snd_intel_dspcfg nf_conntrack_tftp snd_intel_sdw_acpi
> nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp
> nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> snd_hda_codec nct6775 snd_hda_core nct6775_core snd_hwdep hwmon_vid
> vhost_net snd_pcm mlx4_ib tun kvm_amd snd_timer vhost gpio_amdpt
> ib_uverbs vhost_iotlb i2c_piix4 snd tap rapl pcspkr soundcore
> i2c_smbus rtc_cmos wmi
> # [  134.041242]  button gpio_generic ib_core kvm k10temp drm fuse
> loop dmi_sysfs dm_snapshot dm_bufio mlx4_en sd_mod nvme_tcp
> nvme_fabrics nvme ixgbe crct10dif_pclmul mdio crc32_pclmul mdio_devres
> crc32c_intel igb ghash_clmulni_intel i2c_algo_bit sha512_ssse3 libphy
> nvme_core sha256_ssse3 ptp sha1_ssse3 hwmon xhci_pci aesni_intel ahci
> mlx4_core crypto_simd libahci xhci_hcd libata i2c_core sunrpc
> dm_mirror dm_region_hash dm_log be2iscsi iscsi_tcp libiscsi_tcp
> libiscsi scsi_transport_iscsi dm_multipath dm_mod efivarfs
> # [  134.041324] CPU: 9 UID: 0 PID: 0 Comm: swapper/9 Tainted: G
>   W          6.12.4-gentoo #2
> # [  134.041329] Tainted: [W]=WARN
> # [  134.041331] Hardware name: To Be Filled By O.E.M. X370 Killer
> SLI/X370 Killer SLI, BIOS P10.31 08/23/2024
> # [  134.041335] RIP: 0010:rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> # [  134.041342] Code: 00 f0 0f c1 87 80 00 00 00 83 f8 01 74 39 85 c0
> 7f 96 5b 5d be 03 00 00 00 48 89 d7 41 5c e9 7b 43 39 e0 41 f6 04 24
> 01 75 26 <0f> 0b 5b 5d 41 5c c3 ff c8 83 f8 0f 77 a4 49 8d bc 24 d8 03
> 00 00
> # [  134.041347] RSP: 0018:ffffc90000338d20 EFLAGS: 00010246
> # [  134.041352] RAX: 0000000000000000 RBX: ffff888101b38200 RCX:
> 0000000000000000
> # [  134.041355] RDX: ffff88810092de80 RSI: 000000000000000e RDI:
> ffff88810092de80
> # [  134.041358] RBP: 0000000000000000 R08: ffff8881253b0000 R09:
> 0000000000000001
> # [  134.041360] R10: ffff8881251fac00 R11: 0000000000000080 R12:
> ffff888125220000
> # [  134.041364] R13: 0000000000000056 R14: 0000000000010000 R15:
> ffff888101b38200
> # [  134.041367] FS:  0000000000000000(0000) GS:ffff889fbee40000(0000)
> knlGS:0000000000000000
> # [  134.041370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> # [  134.041373] CR2: 000055ec3e726750 CR3: 000000000341b000 CR4:
> 0000000000350ef0
> # [  134.041376] Call Trace:
> # [  134.041379]  <IRQ>
> # [  134.041381]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> # [  134.041388]  ? __warn.cold+0x93/0xed
> # [  134.041392]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> # [  134.041398]  ? report_bug+0xe2/0x170
> # [  134.041402]  ? handle_bug+0x4f/0x90
> # [  134.041405]  ? exc_invalid_op+0x13/0x60
> # [  134.041409]  ? asm_exc_invalid_op+0x16/0x20
> # [  134.041413]  ? rxe_skb_tx_dtor+0xbc/0x110 [rdma_rxe]
> # [  134.041420]  skb_release_head_state+0x20/0x90
> # [  134.041424]  napi_consume_skb+0x3e/0x100
> # [  134.041428]  mlx4_en_free_tx_desc+0x11d/0x200 [mlx4_en]
> # [  134.041433]  mlx4_en_process_tx_cq+0x182/0x560 [mlx4_en]
> # [  134.041439]  mlx4_en_poll_tx_cq+0x28/0x70 [mlx4_en]
> # [  134.041443]  __napi_poll+0x25/0x150
> # [  134.041447]  net_rx_action+0x300/0x370
> # [  134.041452]  ? mlx4_msi_x_interrupt+0xd/0x20 [mlx4_core]
> # [  134.041465]  handle_softirqs+0xf0/0x2a0
> # [  134.041469]  irq_exit_rcu+0x74/0xd0
> # [  134.041473]  common_interrupt+0xb8/0xd0
> # [  134.041476]  </IRQ>
> # [  134.041478]  <TASK>
> # [  134.041480]  asm_common_interrupt+0x22/0x40
> # [  134.041484] RIP: 0010:cpuidle_enter_state+0xaf/0x410
> # [  134.041488] Code: de 01 00 00 e8 d2 9c 5f ff e8 dd f2 ff ff 49 89
> c5 0f 1f 44 00 00 31 ff e8 9e bd 5e ff 45 84 ff 0f 85 b0 01 00 00 fb
> 45 85 f6 <0f> 88 88 01 00 00 48 8b 04 24 49 63 ce 4c 89 ea 48 6b f1 68
> 48 29
> # [  134.041492] RSP: 0018:ffffc9000013be78 EFLAGS: 00000202
> # [  134.041496] RAX: ffff889fbee40000 RBX: ffff888104c68400 RCX:
> 0000000000000000
> # [  134.041500] RDX: 0000001f357196a8 RSI: ffffffff82142fc3 RDI:
> ffffffff82146c8f
> # [  134.041503] RBP: 0000000000000002 R08: 0000000000000002 R09:
> 0000000000000000
> # [  134.041506] R10: 0000000000000018 R11: ffff889fbee72144 R12:
> ffffffff824dfd40
> # [  134.041509] R13: 0000001f357196a8 R14: 0000000000000002 R15:
> 0000000000000000
> # [  134.041513]  ? cpuidle_enter_state+0xa2/0x410
> # [  134.041517]  cpuidle_enter+0x29/0x40
> # [  134.041520]  do_idle+0x19a/0x200
> # [  134.041524]  cpu_startup_entry+0x25/0x30
> # [  134.041527]  start_secondary+0xfe/0x120
> # [  134.041530]  common_startup_64+0x13e/0x141
> # [  134.041535]  </TASK>
> # [  134.041537] ---[ end trace 0000000000000000 ]---
> 
> the system has a "Hewlett-Packard Company InfiniBand FDR/Ethernet
> 10Gb/40Gb 2-port 544+FLR-QSFP Adapter"
> I created a software bridge named br-fp and bridge 2 ports on this adapter,
> I also created a veth pair (venfp <-> venfpbr), venfpbr is connected
> to bridge br-fp.
> then I do 'rdma link add rxe_venfp type rxe netdev venfp', If I try to
> do rdma connect to remote storge, the error occurs.
> 
> if you need other info, Please tell me.
> 
> Thanks.


