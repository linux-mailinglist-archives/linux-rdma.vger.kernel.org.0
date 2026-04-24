Return-Path: <linux-rdma+bounces-19522-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJfYMCff6mkNFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19522-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 05:10:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70C4595BA
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 05:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2830300B859
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB32868B4;
	Fri, 24 Apr 2026 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="in8g97Pa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27914AD0D
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000227; cv=none; b=mYyt8PhigSrfTSBpMPYv60+mPpMREOW332r6GhBLxK1duqJ9RwVrqx+cdT1PbowLh2sYjPwe4BEwfBl0gMSO8x/kNfBIth1+Fu7S3dgggTIt/bg4cl/WIzvN3K239FBQ5GmaFvQwxZpoINAhnBAKnMRyP0MXyUuxHIyzIMLJImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000227; c=relaxed/simple;
	bh=iYdkwsl9nznfLIp/PffPBhsWkO69rpu9/3olgcnmO6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFNbZTeJrD+L6Bw9JNrUubIU7ZcLqNLAHxFVldSXpsLJVMSRXMZUqJoMXLmlwIYZdjTCGI8vlr8HPr1rv29RiaEPi8JrxJhrtx9Bg1yNALXlpCH1cy3lfmt5RlbiOgM6aY5DgHkir4eLrbTT6jRKu/8RPrOZTsuR5ayZ6aNZXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=in8g97Pa; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14cf9ac5-1f11-428e-abf7-cf5075d6c9f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777000223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34LuSlBT9uayz0YgDfCAkFGE1rNGA4UR49LoJ6SQbKs=;
	b=in8g97PaHd2pb+b7q0IWTFObOIDNM0/a21amd0V7nmqruaSYE8H2JQyNWkiPaqWbUuiGXF
	KbzVQ64isiHwAboCiKaBBTUsB5X/A3+CM4cK2873/l5PTWxLeRlQkbOzejsMmeUzZSSUQg
	4UIpUKHMeUzNg8L6LkZknYrLMm3uYXo=
Date: Thu, 23 Apr 2026 20:10:17 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
To: Kuniyuki Iwashima <kuniyu@google.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260424013759.728288-1-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260424013759.728288-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3D70C4595BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19522-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[google.com,gmail.com,ziepe.ca,kernel.org,linux.dev];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,appspotmail.com:email]


在 2026/4/23 18:37, Kuniyuki Iwashima 写道:
> syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
>
> The problem is rxe_net_del() can be called for the same
> device concurrently.
>
> Multiple threads might call udp_tunnel_sock_release()
> for the same socket.
>
> Let's add a per-netns mutex to synchronise rxe_net_del().
>
> [0]:
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> CPU: 3 UID: 0 PID: 12652 Comm: syz.7.1709 Tainted: G             L      syzkaller #0 PREEMPT(full)
> Tainted: [L]=SOFTLOCKUP
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c e9 46
> RSP: 0018:ffffc9000566f180 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff888058587240 RCX: 0000000000000000
> RDX: 000000000000000d RSI: ffffffff895ced12 RDI: 0000000000000068
> RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1006d98945
> R10: ffff888036cc4a2b R11: 0000003683c25c00 R12: 0000000000000000
> R13: ffff88805c998000 R14: 0000000000000002 R15: 0000000000000018
> FS:  00007f1306d976c0(0000) GS:ffff8880d65db000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1306d97d58 CR3: 00000000404f1000 CR4: 0000000000352ef0
> DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
> DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:202
>   rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>   rxe_sock_put+0xae/0x130 drivers/infiniband/sw/rxe/rxe_net.c:639
>   rxe_net_del+0x83/0x120 drivers/infiniband/sw/rxe/rxe_net.c:660
>   rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>   nldev_dellink+0x289/0x3c0 drivers/infiniband/core/nldev.c:1849
>   rdma_nl_rcv_msg+0x392/0x6f0 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb.constprop.0.isra.0+0x2cb/0x410 drivers/infiniband/core/netlink.c:239
>   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>   netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
>   netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
>   sock_sendmsg_nosec net/socket.c:787 [inline]
>   __sock_sendmsg net/socket.c:802 [inline]
>   ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
>   ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
>   __sys_sendmsg+0x170/0x220 net/socket.c:2784
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1305f9c819
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f1306d97028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f1306216090 RCX: 00007f1305f9c819
> RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000003
> RBP: 00007f1306032c91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f1306216128 R14: 00007f1306216090 R15: 00007ffd8ecad288
>   </TASK>
> Modules linked in:
>
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69ea344f.a00a0220.17a17.0040.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_net.c |  2 ++
>   drivers/infiniband/sw/rxe/rxe_ns.c  | 18 ++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_ns.h  |  2 ++
>   3 files changed, 22 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..1b3615c9262a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -655,6 +655,7 @@ void rxe_net_del(struct ib_device *dev)
>   
>   	net = dev_net(ndev);
>   
> +	rxe_ns_pernet_sk_lock(net);
>   	sk = rxe_ns_pernet_sk4(net);
>   	if (sk)
>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> @@ -662,6 +663,7 @@ void rxe_net_del(struct ib_device *dev)
>   	sk = rxe_ns_pernet_sk6(net);
>   	if (sk)
>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
> +	rxe_ns_pernet_sk_unlock(net);

If one thread is calling rxe_net_del (destroying the socket) while 
another thread simultaneously

calls rxe_newlink to create the socket, I am not sure if a race 
condition will occur or not.

If yes, I think all locations that modify these pointers should hold the 
mutex.

>   
>   	dev_put(ndev);
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 8b9d734229b2..375c7d79d9d3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -16,6 +16,7 @@
>   struct rxe_ns_sock {
>   	struct sock __rcu *rxe_sk4;
>   	struct sock __rcu *rxe_sk6;
> +	struct mutex rxe_sk_lock;
>   };
>   
>   /*
> @@ -28,9 +29,12 @@ static unsigned int rxe_pernet_id;
>    */
>   static int rxe_ns_init(struct net *net)
>   {
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
>   	/* defer socket create in the namespace to the first
>   	 * device create.
>   	 */
> +	mutex_init(&ns_sk->rxe_sk_lock);

The lock is initialized in rxe_ns_init, but this lock is not handled in 
rxe_ns_exit

(or the corresponding cleanup function).

Although a mutex typically does not require special operations upon 
destruction,

the presence of pending lock contention could potentially cause the 
namespace destruction process to hang.

So in rxe_ns_exit or other cleanup functions, add 
"mutex_destroy(&ns_sk->rxe_sk_lock);"

This seems more professional.

>   
>   	return 0;
>   }
> @@ -71,6 +75,20 @@ static struct pernet_operations rxe_net_ops = {
>   	.size = sizeof(struct rxe_ns_sock),
>   };
>   
> +void rxe_ns_pernet_sk_lock(struct net *net)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	mutex_lock(&ns_sk->rxe_sk_lock);
> +}
> +
> +void rxe_ns_pernet_sk_unlock(struct net *net)
> +{
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +
> +	mutex_unlock(&ns_sk->rxe_sk_lock);
> +}
> +

Introducing a mutex lock will serialize all RXE device deletion operations

within the same network namespace (netns). Although deletion is not a

fast path operation, it may increase control-plane latency in environments

with a large number of virtual adapters. It is necessary to verify 
whether a more

lightweight solution (such as an xchg atomic exchange operation) exists to

handle the extraction and nullification of the socket pointers.

Although rxe is a simulation driver, it does not focus on the 
performance. But a lighter lock

might as well benefit the whole system

Thanks a lot.

Zhu Yanjun

>   struct sock *rxe_ns_pernet_sk4(struct net *net)
>   {
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
> index 4da2709e6b71..c5262843bb63 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.h
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.h
> @@ -3,6 +3,8 @@
>   #ifndef RXE_NS_H
>   #define RXE_NS_H
>   
> +void rxe_ns_pernet_sk_lock(struct net *net);
> +void rxe_ns_pernet_sk_unlock(struct net *net);
>   struct sock *rxe_ns_pernet_sk4(struct net *net);
>   void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
>   

-- 
Best Regards,
Yanjun.Zhu


