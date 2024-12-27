Return-Path: <linux-rdma+bounces-6757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491A9FD28A
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 10:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A0A7A1153
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B047155741;
	Fri, 27 Dec 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUrqt32G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC514317E
	for <linux-rdma@vger.kernel.org>; Fri, 27 Dec 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735291396; cv=none; b=llBBH3V+WH140dvWtWrG0Rlu962t9jjH17r2RJzuML/tc4fESCNfs89LO0KDaztdwNObGxPVYKLw6OpgQmsF7fHpuC7Ad3l+fz0jjwitD9nZKXDpWAN8cP6qCyoLK4eiFHZ+y3GvadFwp1ZTvHSH8CsvLthQPl+ydu0qa1yiIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735291396; c=relaxed/simple;
	bh=MXQGgZNlSSpRUgV4LVRH6ur2AIl36nVqYusWxsnw/AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7aIbATVuon/k6viupAiNs+QriVdSF0/cckSc2V6zQOe1BxLJuMdzkLB7Dtf0eo+fyqwoTjDF3I+8EBIMbLvFSCf7Org8SMK6/bqTHqHBFlQFT0x2Ynhl2+duSjfTglYhST4qa45mOHEvtGLfjkcdGnlYtWtlX+kBzPH4GwBRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUrqt32G; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0487df3d-63cf-40a8-a23b-104fbde319e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735291388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7W4TmjLjLwZ2AscMx2sw/OXdWApgph7E/ld/WNfwgs=;
	b=QUrqt32Gb2qy8wjAa0MA1LoZ0RzNJFxvwP+0ApKwCjdiXAGnSJSUV+dYU9eUVYizv6enoa
	XpcFpXGXlETv6lQvV24wbOv1DRD26hEza/Sa63fu9ZVVJGr57M8ZHz6yrCHeZ6bahsFmx5
	zq2vxo4sjzyQp13Ve+3JmvqwVgwpMwE=
Date: Fri, 27 Dec 2024 10:23:04 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH blktests v2 2/2] [NOT-FOR-MERGE] just for testing
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20241225093751.307267-1-lizhijian@fujitsu.com>
 <20241225093751.307267-2-lizhijian@fujitsu.com>
 <fzj26m4oig4yd2qffkcz6j5xblpqmcvtiln4d7l5ru2cdizjfs@nxhi2lvif7qk>
 <6a1f3e8f-deb0-49f9-bc69-a9b03ecfcda7@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6a1f3e8f-deb0-49f9-bc69-a9b03ecfcda7@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27.12.24 06:37, Zhijian Li (Fujitsu) wrote:
> Hi, Shin'ichiro,
> 
> Your attached kconfig+this rnbd test triggered another BUG.
> 
> Cced: RDMA
> 
> Is this a known issue in RDMA/RXE communities?

 From my side, it should not be a known issue. It seems that it is 
related with this rnbd test.

In previous tests, this problem does not appear.

I am not sure if others also find this problem or not. To me, it is my 
first time to find this problem.

Zhu Yanjun

> 
> 
> On 26/12/2024 21:17, Shinichiro Kawasaki wrote:
>> On Dec 25, 2024 / 17:37, Li Zhijian wrote:
>>> Hi, Shin'ichiro
>>>
>>> All your comments has been addressed except the success ratio one. Could
>>> you help to check this patch([NOT-FOR-MERGE] just for testing) that can tell
>>> where it fails at in your envrionment.
>>>
>>> I tested it today in my QEMU enviroment, It almost 100% success
>>
>> Thanks for this effort. I ran rnbd/001 with this series in my QEMU environment.
>> It looks still failing. Please find the 001.out.bad file generated [X]. The
>> kernel was v6.13-rc4 with the fix patch "RDMA/ulp: Add missing deinit() call".
>>
>> I wonder what is the difference between your environment and mine. FYI, my QEMU
>> environment has 4 CPUs and 16GB DRAM. It runs Fedora 40. I also attach the
>> kernel config I used just in case you are interested in.
> 
> 
> Due to this bug, I cannot finish rnbd/001 at all.
> 
> However, I can reproduce your log by adding `_start_rnbd_client` before the iteration.
> And it can be fixed by calling `_stop_rnbd_client` regardless of whether `_start_rnbd_client`
> succeeds or not(Please feel free to give it a try when you have the opportunity).
> 
> diff --git a/tests/rnbd/001 b/tests/rnbd/001
> index 9c6d56e3ee98..321c4c010e78 100755
> --- a/tests/rnbd/001
> +++ b/tests/rnbd/001
> @@ -26,6 +26,7 @@ test_start_stop()
>           local loop_dev i j=0
>           loop_dev="$(losetup -f)"
>    
> +       _start_rnbd_client    # this makes the _start_rnbd_client in below iteration fails
>           for ((i=0;i<100;i++))
>           do
>                   if _start_rnbd_client "${loop_dev}" &>/dev/null; then
> @@ -33,6 +34,7 @@ test_start_stop()
>                           _stop_rnbd_client &>/dev/null && echo 'disconnect ok' || echo 'disconnect not ok'
>                           ((j++))
>                   else
> +                       _stop_rnbd_client  # always stop rnbd so that we can connect again.
>                           echo 'connect not ok'
>                   fi
>           done
> 
> ===========================
> 
> [   27.864420] run blktests rnbd/001 at 2024-12-27 13:21:37
> [   27.888742] infiniband eth0_rxe: set active
> [   27.889497] infiniband eth0_rxe: added eth0
> [   27.910304] rnbd_client L599: Mapping device /dev/loop0 on session blktest, (access_mode: rw, nr_poll_queues: 0)
> [   27.924065] rnbd_client L1190: [session=blktest] mapped 4/4 default/read queues.
> [   27.925825] rnbd_server L782: </dev/loop0@blktest>: Opened device 'loop0'
> [   27.927554] rnbd_client L1612: </dev/loop0@blktest> map_device: Device mapped as rnbd0 (nsectors: 0, logical_block_size: 512, physical_block_size: 512, max_write_zeroes_sectors: 0, max_discard_sectors: 0, discard_granularity: 51
> 2, discard_alignment: 0, secure_discard: 0, max_segments: 128, max_hw_sectors: 248, wc: 0, fua: 0)
> [   27.938295] rnbd_client L323: </dev/loop0@blktest> Unmapping device, option: normal.
> [   27.962570] rnbd_server L238: </dev/loop0@blktest>: Device closed
> [   27.967500] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   27.967500] BUG: kernel NULL pointer dereference, address: 0000000000000000                                                                                                                                       13:21:38 [11/9189]
> [   27.976554] #PF: supervisor read access in kernel mode
> [   27.984926] #PF: error_code(0x0000) - not-present page
> [   27.989126] PGD 0 P4D 0
> [   27.991067] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [   27.993226] CPU: 3 UID: 0 PID: 304 Comm: kworker/u20:2 Not tainted 6.13.0-rc3+ #1
> [   27.996697] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   27.999333] Workqueue: rxe_wq do_work [rdma_rxe]
> [   28.000309] RIP: 0010:memcpy_orig+0xd5/0x140
> [   28.001304] Code: 16 f8 4c 89 07 4c 89 4f 08 4c 89 54 17 f0 4c 89 5c 17 f8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 fa 08 72 1b <4c> 8b 06 4c 8b 4c 16 f8 4c 89 07 4c 89 4c 17 f8 c3 cc cc cc cc 66
> [   28.004932] RSP: 0018:ffffb934c0643cc0 EFLAGS: 00010246
> [   28.005845] RAX: ffff976bc1e12d5a RBX: 0000000000000000 RCX: 0000000000000000
> [   28.007090] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff976bc1e12d5a
> [   28.008380] RBP: ffff976bc1e12d5a R08: 0000000000000001 R09: 0000000000000001
> [   28.009639] R10: 0000000000000005 R11: 0000000000000000 R12: 0000000080000000
> [   28.010836] R13: 0000000000000008 R14: 0000000000000008 R15: 0000000000000008
> [   28.011948] FS:  0000000000000000(0000) GS:ffff976f2fd80000(0000) knlGS:0000000000000000
> [   28.013335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   28.014275] CR2: 0000000000000000 CR3: 00000001837da002 CR4: 00000000001706f0
> [   28.015424] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   28.016598] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   28.017728] Call Trace:
> [   28.018114]  <TASK>
> [   28.018453]  ? __die_body.cold+0x19/0x27
> [   28.019167]  ? page_fault_oops+0x15a/0x2d0
> [   28.019861]  ? search_module_extables+0x19/0x60
> [   28.020617]  ? search_bpf_extables+0x5f/0x80
> [   28.021611]  ? exc_page_fault+0x7e/0x180
> [   28.022488]  ? asm_exc_page_fault+0x26/0x30
> [   28.023547]  ? memcpy_orig+0xd5/0x140
> [   28.024396]  rxe_mr_copy+0x1c3/0x200 [rdma_rxe]
> [   28.025476]  ? rxe_pool_get_index+0x4b/0x80 [rdma_rxe]
> [   28.026612]  copy_data+0xa5/0x230 [rdma_rxe]
> [   28.027611]  rxe_requester+0xd9b/0xf70 [rdma_rxe]
> [   28.028727]  ? finish_task_switch.isra.0+0x99/0x2e0
> [   28.029878]  rxe_sender+0x13/0x40 [rdma_rxe]
> [   28.030920]  do_task+0x68/0x1e0 [rdma_rxe]
> [   28.031893]  process_one_work+0x177/0x330
> [   28.032854]  worker_thread+0x252/0x390
> [   28.033748]  ? __pfx_worker_thread+0x10/0x10
> [   28.034665]  kthread+0xd2/0x100
> [   28.035382]  ? __pfx_kthread+0x10/0x10
> [   28.036252]  ret_from_fork+0x34/0x50
> [   28.037220]  ? __pfx_kthread+0x10/0x10
> [   28.038072]  ret_from_fork_asm+0x1a/0x30
> [   28.038991]  </TASK>
> [   28.039543] Modules linked in: loop rnbd_client rtrs_client rnbd_server rtrs_server rtrs_core rdma_cm iw_cm ib_cm rdma_rxe ib_uverbs ib_core ip6_udp_tunnel udp_tunnel rfkill intel_rapl_msr intel_rapl_common kmem rapl cxl_mem iTC
> O_wdt intel_pmc_bxt cxl_pmem dax_hmem iTCO_vendor_support device_dax cxl_acpi cxl_pci cxl_port joydev qxl cxl_core pcspkr drm_ttm_helper lpc_ich ttm i2c_i801 virtio_balloon i2c_smbus nd_pmem nd_btt dax_pmem einj ip_tables crct10dif
> _pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtiofs fuse virtio_net nfit virtio_console net_failover libnvdimm serio_raw virtio_blk failover qemu_fw_cf
> g dm_multipath sunrpc
> [   28.051034] CR2: 0000000000000000
> [   28.052072] ---[ end trace 0000000000000000 ]---
> [   28.053099] RIP: 0010:memcpy_orig+0xd5/0x140
> [   28.054188] Code: 16 f8 4c 89 07 4c 89 4f 08 4c 89 54 17 f0 4c 89 5c 17 f8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 fa 08 72 1b <4c> 8b 06 4c 8b 4c 16 f8 4c 89 07 4c 89 4c 17 f8 c3 cc cc cc cc 66
> [   28.058290] RSP: 0018:ffffb934c0643cc0 EFLAGS: 00010246
> [   28.059514] RAX: ffff976bc1e12d5a RBX: 0000000000000000 RCX: 0000000000000000
> [   28.061194] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff976bc1e12d5a
> [   28.062588] RBP: ffff976bc1e12d5a R08: 0000000000000001 R09: 0000000000000001
> 
> 
> 
> 
>>
>>
>> [X]
>>
>> 001.out.bad
>> ----------------------------------------------------------------------------
>> Running rnbd/001
>> connect ok
>> disconnect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> connect not ok
>> Failed: 1/100
>> Test complete


