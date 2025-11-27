Return-Path: <linux-rdma+bounces-14798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB6C8CCEB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 05:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88BD934B5C4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 04:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1353226D4F9;
	Thu, 27 Nov 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PABDm7aw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68836E573
	for <linux-rdma@vger.kernel.org>; Thu, 27 Nov 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764218641; cv=none; b=VEktzG54KkcpjOh6N9FwK8XPGvGNVrtUtgeo2MlXb6tbODK3mRfs+gyWk2ZrTMfxby/3TXdyzz0XXLQKlFg9+PWZE4QPHUx/T05Msox44BQM2EijL230TdeLs7gGMe3jnEyembw8/laATxeJxIU0jBuSU00FrFmroIYVG77SDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764218641; c=relaxed/simple;
	bh=aNoLBee7wmlMLQZEba5dljIwZwEs5pG9banx4D2ehPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ih1RYF/iJhs8/72BUcPTiBSqoS++g4XQKLDEa9fiWSEMxMadOKMWrq8XBpAbBtvyMI30qggEGbz7QuIPK2YUQ96dcaTd+mljyFiGqVntysbELo9rkxizxq1qKDAhVIvhSz36sA1IZTAqL3HxnCPMyzU9i0QFC1Jwz4R8Pz348Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PABDm7aw; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f7829be-a60f-4053-ab66-7981cba23175@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764218636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCC0nbZfQ6o92BClTunQY/D6ZUKEsE2vp4CNBcIh0Ws=;
	b=PABDm7awJNkJbHnFWGwRy3Fbdajs3nmqbLSyB2eiuVixCSjmgIxzLiGgPN6sVVOZ9/2PjB
	Z/4Sh6FHs75phonyg+ZY/r7BAUoWo4JKm5F3JPOYEQ3oAQ47KWqsceuF+4t8LHVPS09WCa
	GCQGyR+KTcEN2sEABtBdPLkeYOOpvdE=
Date: Wed, 26 Nov 2025 20:43:51 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: reclassify sockets in order to avoid false
 positives from lockdep
To: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20251126150744.1836188-1-metze@samba.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251126150744.1836188-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/26 7:07, Stefan Metzmacher 写道:
> While developing IPPROTO_SMBDIRECT support for the code
> under fs/smb/common/smbdirect [1], I noticed false positives like this:
>
> [+0,003927] ============================================
> [+0,000532] WARNING: possible recursive locking detected
> [+0,000611] 6.18.0-rc5-metze-kasan-lockdep.02+ #1 Tainted: G           OE
> [+0,000835] --------------------------------------------
> [+0,000729] ksmbd:r5445/3609 is trying to acquire lock:
> [+0,000709] ffff88800b9570f8 (k-sk_lock-AF_INET){+.+.}-{0:0},
>                                at: inet_shutdown+0x52/0x360
> [+0,000831]
>              but task is already holding lock:
> [+0,000684] ffff88800654af78 (k-sk_lock-AF_INET){+.+.}-{0:0},
>                             at: smbdirect_sk_close+0x122/0x790 [smbdirect]
> [+0,000928]
>              other info that might help us debug this:
> [+0,005552]  Possible unsafe locking scenario:
>
> [+0,000723]        CPU0
> [+0,000359]        ----
> [+0,000377]   lock(k-sk_lock-AF_INET);
> [+0,000478]   lock(k-sk_lock-AF_INET);
> [+0,000498]
>               *** DEADLOCK ***
>
> [+0,001012]  May be due to missing lock nesting notation
>
> [+0,000831] 3 locks held by ksmbd:r5445/3609:
> [+0,000484]  #0: ffff88800654af78 (k-sk_lock-AF_INET){+.+.}-{0:0},
>                             at: smbdirect_sk_close+0x122/0x790 [smbdirect]
> [+0,001000]  #1: ffff888020a40458 (&id_priv->handler_mutex){+.+.}-{4:4},
>                             at: rdma_lock_handler+0x17/0x30 [rdma_cm]
> [+0,000982]  #2: ffff888020a40350 (&id_priv->qp_mutex){+.+.}-{4:4},
>                             at: rdma_destroy_qp+0x5d/0x1f0 [rdma_cm]
> [+0,000934]
>              stack backtrace:
> [+0,000589] CPU: 0 UID: 0 PID: 3609 Comm: ksmbd:r5445 Kdump: loaded
>               Tainted: G           OE
>               6.18.0-rc5-metze-kasan-lockdep.02+ #1 PREEMPT(voluntary)
> [+0,000023] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [+0,000004] Hardware name: innotek GmbH VirtualBox/VirtualBox,
>              BIOS VirtualBox 12/01/2006
> ...
> [+0,000010] print_deadlock_bug+0x245/0x330
> [+0,000014] validate_chain+0x32a/0x590
> [+0,000012] __lock_acquire+0x535/0xc30
> [+0,000013] lock_acquire.part.0+0xb3/0x240
> [+0,000017] ? inet_shutdown+0x52/0x360
> [+0,000013] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000007] ? mark_held_locks+0x46/0x90
> [+0,000012] lock_acquire+0x60/0x140
> [+0,000006] ? inet_shutdown+0x52/0x360
> [+0,000028] lock_sock_nested+0x3b/0xf0
> [+0,000009] ? inet_shutdown+0x52/0x360
> [+0,000008] inet_shutdown+0x52/0x360
> [+0,000010] kernel_sock_shutdown+0x5b/0x90
> [+0,000011] rxe_qp_do_cleanup+0x4ef/0x810 [rdma_rxe]
> [+0,000043] ? __pfx_rxe_qp_do_cleanup+0x10/0x10 [rdma_rxe]
> [+0,000030] execute_in_process_context+0x2b/0x170
> [+0,000013] rxe_qp_cleanup+0x1c/0x30 [rdma_rxe]
> [+0,000021] __rxe_cleanup+0x1cf/0x2e0 [rdma_rxe]
> [+0,000036] ? __pfx___rxe_cleanup+0x10/0x10 [rdma_rxe]
> [+0,000020] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000006] ? __kasan_check_read+0x11/0x20
> [+0,000012] rxe_destroy_qp+0xe1/0x230 [rdma_rxe]
> [+0,000035] ib_destroy_qp_user+0x217/0x450 [ib_core]
> [+0,000074] rdma_destroy_qp+0x83/0x1f0 [rdma_cm]
> [+0,000034] smbdirect_connection_destroy_qp+0x98/0x2e0 [smbdirect]
> [+0,000017] ? __pfx_smb_direct_logging_needed+0x10/0x10 [ksmbd]
> [+0,000044] smbdirect_connection_destroy+0x698/0xed0 [smbdirect]
> [+0,000023] ? __pfx_smbdirect_connection_destroy+0x10/0x10 [smbdirect]
> [+0,000033] ? __pfx_smb_direct_logging_needed+0x10/0x10 [ksmbd]
> [+0,000031] smbdirect_connection_destroy_sync+0x42b/0x9f0 [smbdirect]
> [+0,000029] ? mark_held_locks+0x46/0x90
> [+0,000012] ? __pfx_smbdirect_connection_destroy_sync+0x10/0x10 [smbdirect]
> [+0,000019] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000007] ? trace_hardirqs_on+0x64/0x70
> [+0,000029] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000010] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000006] ? __smbdirect_connection_schedule_disconnect+0x339/0x4b0
> [+0,000021] smbdirect_sk_destroy+0xb0/0x680 [smbdirect]
> [+0,000024] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000006] ? trace_hardirqs_on+0x64/0x70
> [+0,000006] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000005] ? __local_bh_enable_ip+0xba/0x150
> [+0,000011] sk_common_release+0x66/0x340
> [+0,000010] smbdirect_sk_close+0x12a/0x790 [smbdirect]
> [+0,000023] ? ip_mc_drop_socket+0x1e/0x240
> [+0,000013] inet_release+0x10a/0x240
> [+0,000011] smbdirect_sock_release+0x502/0xe80 [smbdirect]
> [+0,000015] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000024] sock_release+0x91/0x1c0
> [+0,000010] smb_direct_free_transport+0x31/0x50 [ksmbd]
> [+0,000025] ksmbd_conn_free+0x1d0/0x240 [ksmbd]
> [+0,000040] smb_direct_disconnect+0xb2/0x120 [ksmbd]
> [+0,000023] ? srso_alias_return_thunk+0x5/0xfbef5
> [+0,000018] ksmbd_conn_handler_loop+0x94e/0xf10 [ksmbd]
> ...
>
> I'll also add reclassify to the smbdirect socket code [1],
> but I think it's better to have it in both direction
> (below and above the RDMA layer).
>
> [1]
> https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/master-ipproto-smbdirect
>
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>
> ---
>
> v2: - use CONFIG_DEBUG_LOCK_ALLOC (Bernard on siw patch)
>      - add a comment (Bernard on siw patch)
>      - AF_INET vs. AF_INET6 (Bernard on siw patch)
> ---
>   drivers/infiniband/sw/rxe/rxe_net.c | 49 +++++++++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_qp.c  | 49 +++++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index ac0183a2ff7a..9fee969f5c6f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -18,6 +18,54 @@
>   #include "rxe_net.h"
>   #include "rxe_loc.h"
>   
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +/*
> + * lockdep can detect false positive circular dependencies
> + * when there are user-space socket API users or in kernel
> + * users switching between a tcp and rdma transport.
> + * Maybe also switching between siw and rxe may cause
> + * problems as per default sockets are only classified
> + * by family and not by ip protocol. And there might
> + * be different locks used between the application
> + * and the low level sockets.
> + *
> + * Problems were seen with ksmbd.ko and cifs.ko,
> + * switching transports, use git blame to find
> + * more details.
> + */
> +static struct lock_class_key rxe_recv_sk_key[2];
> +static struct lock_class_key rxe_recv_slock_key[2];
> +#endif /* CONFIG_DEBUG_LOCK_ALLOC */
> +
> +static inline void rxe_reclassify_recv_socket(struct socket *sock)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct sock *sk = sock->sk;
> +
> +	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
> +		return;
> +
> +	switch (sk->sk_family) {
> +	case AF_INET:
> +		sock_lock_init_class_and_name(sk,
> +					      "slock-AF_INET-RDMA-RXE-RECV",
> +					      &rxe_recv_slock_key[0],
> +					      "sk_lock-AF_INET-RDMA-RXE-RECV",
> +					      &rxe_recv_sk_key[0]);
> +		break;
> +	case AF_INET6:
> +		sock_lock_init_class_and_name(sk,
> +					      "slock-AF_INET6-RDMA-RXE-RECV",
> +					      &rxe_recv_slock_key[1],
> +					      "sk_lock-AF_INET6-RDMA-RXE-RECV",
> +					      &rxe_recv_sk_key[1]);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +#endif /* CONFIG_DEBUG_LOCK_ALLOC */
> +}
> +
>   static struct rxe_recv_sockets recv_sockets;


Thanks. The global variable recv_sockets should be placed at the top of 
the newly added source file.
If I recall correctly, the global variable declaration needs to be at 
the beginning of the file and after the header files.

I also read the commit of siw. This commit is similar with the one of siw.

And after applying this commit, RXE still can work well. I am fine with 
this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun


>   
>   static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
> @@ -192,6 +240,7 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>   	err = udp_sock_create(net, &udp_cfg, &sock);
>   	if (err < 0)
>   		return ERR_PTR(err);
> +	rxe_reclassify_recv_socket(sock);
>   
>   	tnl_cfg.encap_type = 1;
>   	tnl_cfg.encap_rcv = rxe_udp_encap_recv;
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 95f1c1c2949d..845bdd03ca28 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -15,6 +15,54 @@
>   #include "rxe_queue.h"
>   #include "rxe_task.h"
>   
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +/*
> + * lockdep can detect false positive circular dependencies
> + * when there are user-space socket API users or in kernel
> + * users switching between a tcp and rdma transport.
> + * Maybe also switching between siw and rxe may cause
> + * problems as per default sockets are only classified
> + * by family and not by ip protocol. And there might
> + * be different locks used between the application
> + * and the low level sockets.
> + *
> + * Problems were seen with ksmbd.ko and cifs.ko,
> + * switching transports, use git blame to find
> + * more details.
> + */
> +static struct lock_class_key rxe_send_sk_key[2];
> +static struct lock_class_key rxe_send_slock_key[2];
> +#endif /* CONFIG_DEBUG_LOCK_ALLOC */
> +
> +static inline void rxe_reclassify_send_socket(struct socket *sock)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct sock *sk = sock->sk;
> +
> +	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
> +		return;
> +
> +	switch (sk->sk_family) {
> +	case AF_INET:
> +		sock_lock_init_class_and_name(sk,
> +					      "slock-AF_INET-RDMA-RXE-SEND",
> +					      &rxe_send_slock_key[0],
> +					      "sk_lock-AF_INET-RDMA-RXE-SEND",
> +					      &rxe_send_sk_key[0]);
> +		break;
> +	case AF_INET6:
> +		sock_lock_init_class_and_name(sk,
> +					      "slock-AF_INET6-RDMA-RXE-SEND",
> +					      &rxe_send_slock_key[1],
> +					      "sk_lock-AF_INET6-RDMA-RXE-SEND",
> +					      &rxe_send_sk_key[1]);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +#endif /* CONFIG_DEBUG_LOCK_ALLOC */
> +}
> +
>   static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
>   			  int has_srq)
>   {
> @@ -244,6 +292,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>   	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
>   	if (err < 0)
>   		return err;
> +	rxe_reclassify_send_socket(qp->sk);
>   	qp->sk->sk->sk_user_data = qp;
>   
>   	/* pick a source UDP port number for this QP based on

-- 
Best Regards,
Yanjun.Zhu


