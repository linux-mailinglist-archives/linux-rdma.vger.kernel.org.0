Return-Path: <linux-rdma+bounces-14789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C39C8A446
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F43D4E5621
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BFB270ED9;
	Wed, 26 Nov 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ax3yLXFB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CA2D6E4A
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166608; cv=none; b=PkXsSQ1QfLWjAr5Py9jE1UGYF+Biti1VOdknM7i4vfsgIW0SqAkdLc0l1bfd7+RwDGIiCWKdo2F9aUYseDAkBmCs9Fegciu/NJBFEp+XMNTeC0oIGaZxSiD9H4qQmn+XVsyFlGtxJ2qVrxT/77qd0EnTYcuIp5SKFroLq/cXSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166608; c=relaxed/simple;
	bh=AEDGAQM1/PF1m0UH1fIaRJ1Q+AToRWT6itSQj3b2oVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGUG30zwA1OUFf06hWNoV8sh0XigGkOVmMZzqOc0mTLvHytVWtY/yTk0odm5OC/ygtSZvRL3R7l8cdfvr+WtpDLgSBi4y6FRQ5ud3BfBoj5T5i/5lGboYrCZk98k10nxw266blQKMFa2k8uFQI6v6LMx1CaPm8hDxoAAGVZlq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ax3yLXFB; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25ae6db1-856f-4592-a4fa-8a927426ed72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764166603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn1Lc3gEV2pfftZ9XKs0zcUYmlQ97wa6T4ZGjCCqTy0=;
	b=Ax3yLXFBjFyT2vbBi6ihHz0fk81f6PZRPeXhzTSsMqsb9ErfWjc+5UZ7Juc1uiQWwE6Re5
	z7f4PixpQPE9GEhEmVx+H46HOQA1lw7BWDzE/qFBaNc+g3cv3VGIqsTGf1xyFSBR5x7I+g
	RWm+bxLUwx5NpUVFGGHnHsYnlX5S0vY=
Date: Wed, 26 Nov 2025 15:16:40 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: reclassify sockets in order to avoid false
 positives from lockdep
To: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-cifs@vger.kernel.org
References: <20251126104254.1779732-1-metze@samba.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20251126104254.1779732-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26.11.2025 11:42, Stefan Metzmacher wrote:
> While developing IPPROTO_SMBDIRECT support for the code
> under fs/smb/common/smbdirect [1], I noticed false positives like this:
> 
> [T79] ======================================================
> [T79] WARNING: possible circular locking dependency detected
> [T79] 6.18.0-rc4-metze-kasan-lockdep.01+ #1 Tainted: G           OE
> [T79] ------------------------------------------------------
> [T79] kworker/2:0/79 is trying to acquire lock:
> [T79] ffff88801f968278 (sk_lock-AF_INET){+.+.}-{0:0},
>                          at: sock_set_reuseaddr+0x14/0x70
> [T79]
>          but task is already holding lock:
> [T79] ffffffffc10f7230 (lock#9){+.+.}-{4:4},
>                          at: rdma_listen+0x3d2/0x740 [rdma_cm]
> [T79]
>          which lock already depends on the new lock.
> 
> [T79]
>          the existing dependency chain (in reverse order) is:
> [T79]
>          -> #1 (lock#9){+.+.}-{4:4}:
> [T79]        __lock_acquire+0x535/0xc30
> [T79]        lock_acquire.part.0+0xb3/0x240
> [T79]        lock_acquire+0x60/0x140
> [T79]        __mutex_lock+0x1af/0x1c10
> [T79]        mutex_lock_nested+0x1b/0x30
> [T79]        cma_get_port+0xba/0x7d0 [rdma_cm]
> [T79]        rdma_bind_addr_dst+0x598/0x9a0 [rdma_cm]
> [T79]        cma_bind_addr+0x107/0x320 [rdma_cm]
> [T79]        rdma_resolve_addr+0xa3/0x830 [rdma_cm]
> [T79]        destroy_lease_table+0x12b/0x420 [ksmbd]
> [T79]        ksmbd_NTtimeToUnix+0x3e/0x80 [ksmbd]
> [T79]        ndr_encode_posix_acl+0x6e9/0xab0 [ksmbd]
> [T79]        ndr_encode_v4_ntacl+0x53/0x870 [ksmbd]
> [T79]        __sys_connect_file+0x131/0x1c0
> [T79]        __sys_connect+0x111/0x140
> [T79]        __x64_sys_connect+0x72/0xc0
> [T79]        x64_sys_call+0xe7d/0x26a0
> [T79]        do_syscall_64+0x93/0xff0
> [T79]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [T79]
>          -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
> [T79]        check_prev_add+0xf3/0xcd0
> [T79]        validate_chain+0x466/0x590
> [T79]        __lock_acquire+0x535/0xc30
> [T79]        lock_acquire.part.0+0xb3/0x240
> [T79]        lock_acquire+0x60/0x140
> [T79]        lock_sock_nested+0x3b/0xf0
> [T79]        sock_set_reuseaddr+0x14/0x70
> [T79]        siw_create_listen+0x145/0x1540 [siw]
> [T79]        iw_cm_listen+0x313/0x5b0 [iw_cm]
> [T79]        cma_iw_listen+0x271/0x3c0 [rdma_cm]
> [T79]        rdma_listen+0x3b1/0x740 [rdma_cm]
> [T79]        cma_listen_on_dev+0x46a/0x750 [rdma_cm]
> [T79]        rdma_listen+0x4b0/0x740 [rdma_cm]
> [T79]        ksmbd_rdma_init+0x12b/0x270 [ksmbd]
> [T79]        ksmbd_conn_transport_init+0x26/0x70 [ksmbd]
> [T79]        server_ctrl_handle_work+0x1e5/0x280 [ksmbd]
> [T79]        process_one_work+0x86c/0x1930
> [T79]        worker_thread+0x6f0/0x11f0
> [T79]        kthread+0x3ec/0x8b0
> [T79]        ret_from_fork+0x314/0x400
> [T79]        ret_from_fork_asm+0x1a/0x30
> [T79]
>          other info that might help us debug this:
> 
> [T79]  Possible unsafe locking scenario:
> 
> [T79]        CPU0                    CPU1
> [T79]        ----                    ----
> [T79]   lock(lock#9);
> [T79]                                lock(sk_lock-AF_INET);
> [T79]                                lock(lock#9);
> [T79]   lock(sk_lock-AF_INET);
> [T79]
>           *** DEADLOCK ***
> 
> [T79] 5 locks held by kworker/2:0/79:
> [T79] #0: ffff88800120b158 ((wq_completion)events_long){+.+.}-{0:0},
>                             at: process_one_work+0xfca/0x1930
> [T79] #1: ffffc9000474fd00 ((work_completion)(&ctrl->ctrl_work))
>                             {+.+.}-{0:0},
>                             at: process_one_work+0x804/0x1930
> [T79] #2: ffffffffc11307d0 (ctrl_lock){+.+.}-{4:4},
>                             at: server_ctrl_handle_work+0x21/0x280 [ksmbd]
> [T79] #3: ffffffffc11347b0 (init_lock){+.+.}-{4:4},
>                             at: ksmbd_conn_transport_init+0x18/0x70 [ksmbd]
> [T79] #4: ffffffffc10f7230 (lock#9){+.+.}-{4:4},
>                              at: rdma_listen+0x3d2/0x740 [rdma_cm]
> [T79]
>          stack backtrace:
> [T79] CPU: 2 UID: 0 PID: 79 Comm: kworker/2:0 Kdump: loaded
>        Tainted: G           OE
>        6.18.0-rc4-metze-kasan-lockdep.01+ #1 PREEMPT(voluntary)
> [T79] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [T79] Hardware name: innotek GmbH VirtualBox/VirtualBox,
>        BIOS VirtualBox 12/01/2006
> [T79] Workqueue: events_long server_ctrl_handle_work [ksmbd]
> ...
> [T79]  print_circular_bug+0xfd/0x130
> [T79]  check_noncircular+0x150/0x170
> [T79]  check_prev_add+0xf3/0xcd0
> [T79]  validate_chain+0x466/0x590
> [T79]  __lock_acquire+0x535/0xc30
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  lock_acquire.part.0+0xb3/0x240
> [T79]  ? sock_set_reuseaddr+0x14/0x70
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? __kasan_check_write+0x14/0x30
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? apparmor_socket_post_create+0x180/0x700
> [T79]  lock_acquire+0x60/0x140
> [T79]  ? sock_set_reuseaddr+0x14/0x70
> [T79]  lock_sock_nested+0x3b/0xf0
> [T79]  ? sock_set_reuseaddr+0x14/0x70
> [T79]  sock_set_reuseaddr+0x14/0x70
> [T79]  siw_create_listen+0x145/0x1540 [siw]
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? local_clock_noinstr+0xe/0xd0
> [T79]  ? __pfx_siw_create_listen+0x10/0x10 [siw]
> [T79]  ? trace_preempt_on+0x4c/0x130
> [T79]  ? __raw_spin_unlock_irqrestore+0x4a/0x90
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? preempt_count_sub+0x52/0x80
> [T79]  iw_cm_listen+0x313/0x5b0 [iw_cm]
> [T79]  cma_iw_listen+0x271/0x3c0 [rdma_cm]
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  rdma_listen+0x3b1/0x740 [rdma_cm]
> [T79]  ? _raw_spin_unlock+0x2c/0x60
> [T79]  ? __pfx_rdma_listen+0x10/0x10 [rdma_cm]
> [T79]  ? rdma_restrack_add+0x12c/0x630 [ib_core]
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  cma_listen_on_dev+0x46a/0x750 [rdma_cm]
> [T79]  rdma_listen+0x4b0/0x740 [rdma_cm]
> [T79]  ? __pfx_rdma_listen+0x10/0x10 [rdma_cm]
> [T79]  ? cma_get_port+0x30d/0x7d0 [rdma_cm]
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? rdma_bind_addr_dst+0x598/0x9a0 [rdma_cm]
> [T79]  ksmbd_rdma_init+0x12b/0x270 [ksmbd]
> [T79]  ? __pfx_ksmbd_rdma_init+0x10/0x10 [ksmbd]
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? register_netdevice_notifier+0x1dc/0x240
> [T79]  ksmbd_conn_transport_init+0x26/0x70 [ksmbd]
> [T79]  server_ctrl_handle_work+0x1e5/0x280 [ksmbd]
> [T79]  process_one_work+0x86c/0x1930
> [T79]  ? __pfx_process_one_work+0x10/0x10
> [T79]  ? srso_alias_return_thunk+0x5/0xfbef5
> [T79]  ? assign_work+0x16f/0x280
> [T79]  worker_thread+0x6f0/0x11f0
> 
> I was not able to reproduce this as I was testing with various
> runs switching siw and rxe as well as IPPROTO_SMBDIRECT sockets,
> while the above stack used siw with the non IPPROTO_SMBDIRECT
> patches [1].
> 
> Even if this patch doesn't solve the above I think it's
> a good idea to reclassify the sockets used by siw,
> I also send patches for rxe to reclassify, as well
> as my IPPROTO_SMBDIRECT socket patches [1] will do it,
> this should minimize potential false positives.
> 
> [1]
> https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/master-ipproto-smbdirect
> 
> Cc: Bernard Metzler <bernard.metzler@linux.dev>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>   drivers/infiniband/sw/siw/siw_cm.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index 708b13993fdf..b83abf0ea15e 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -39,6 +39,22 @@ static void siw_cm_llp_error_report(struct sock *s);
>   static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
>   			 int status);
>   
> +
> +static struct lock_class_key siw_sk_key;
> +static struct lock_class_key siw_slock_key;
> +
> +static inline void siw_reclassify_socket(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
> +		return;
> +
> +	sock_lock_init_class_and_name(sk,
> +				      "slock-RDMA-SIW", &siw_slock_key,
> +				      "sk_lock-RDMA-SIW", &siw_sk_key);
> +}
> +
>   static void siw_sk_assign_cm_upcalls(struct sock *sk)
>   {
>   	struct siw_cep *cep = sk_to_cep(sk);
> @@ -1394,6 +1410,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
>   	rv = sock_create(v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
>   	if (rv < 0)
>   		goto error;
> +	siw_reclassify_socket(s);
>   
>   	/*
>   	 * NOTE: For simplification, connect() is called in blocking
> @@ -1770,6 +1787,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   	rv = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
>   	if (rv < 0)
>   		return rv;
> +	siw_reclassify_socket(s);
>   
>   	/*
>   	 * Allow binding local port when still in TIME_WAIT from last close.

Thanks very much, makes all sense to me. I stumbled across it a while
ago as well and quietly ignored it. Your solution is better.
If I look through the other use cases of sock_lock_init_class_and_name(),
I found it gated by
#ifdef CONFIG_DEBUG_LOCK_ALLOC
(see for example drivers/nvme/host/tcp.c). I think wee need that
since only then the related sock_lock_xxx objects and functions are
defined.
drivers/nvme/host/tcp.c also has a nice comment on why this is
needed. I think we shall have such comment as well - just to remind us
later what we did.

Thank you!
Bernard.



