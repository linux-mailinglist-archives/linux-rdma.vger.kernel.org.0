Return-Path: <linux-rdma+bounces-19549-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNyUHT8x7Wk2ggAAu9opvQ
	(envelope-from <linux-rdma+bounces-19549-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 23:25:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0BD467D5F
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 23:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93069300735F
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0313530F540;
	Sat, 25 Apr 2026 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b8A2a0RA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9E13B293
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152314; cv=none; b=HxxdtzfPxoHAWpDRgGxT1D/CJ9h60Q57fc3ct0ZQmjzKr23N5OOfawKHSlCskgQwiFAPJgtmTvbBysUDAD9UG6J5MZgfM0SSF1IX5RId/uCB9ESAkw7QBLKYEqKpmhjgXNEcsReagRMdIPGON0jlfTBjc6VjY55Gs376hXVGoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152314; c=relaxed/simple;
	bh=8a9jo4sE9u2KYz4OxgDFGIXnKJQlcgzKW6J1LKLIUZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMOX4msIHX5QYJaWiAKhOWQKaRxVziV7spmCWsc07JICFG4UrCleF3jzpOIx+UoqMBSE/3tWiIL2yvqmxUNkhcjsW/KjbAvnFZeu7scUSubHGYAZ6QYuU0WlcnVxAP9US3V7YFxtFCRUbxxAh4uqCkn0beSaQBmBYCr3TafrIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b8A2a0RA; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777152309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TNbF26kceAuUGDr0sq2w2CCtAkiXNyayHdiFyAjNoc=;
	b=b8A2a0RAX4CeJMkls64+rXZpHQCdprLOcAQXDwn8f25m/SwFFXHe2XxXx8THAvuF5wgPNJ
	WnotAj+EWUHeInZ9tYUlsxuy36T6s4ib9ggfWQ5OywcpO8v0w4SmxqDsANYuQAs0LRF04G
	u05hs0Ux+uzny/UgnTnIta+v/PPnAoU=
Date: Sat, 25 Apr 2026 14:25:04 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
To: Kuniyuki Iwashima <kuniyu@google.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-2-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260425060436.2316620-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8F0BD467D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19549-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[google.com,gmail.com,ziepe.ca,kernel.org,linux.dev];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

在 2026/4/24 23:04, Kuniyuki Iwashima 写道:
> syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
> 
> The problem is ->newlink() and ->dellink() can be called
> concurrently with no synchronisation, leading sk leak or
> double free, etc.
> 
> We defer UDP tunnel allocation to the first device creation,
> but this would requrie per-netns locking.
> 
> Let's allocate UDP tunnels in the __init_net hook.
> 
> Now extra sock_hold() and __sock_put() are no longer needed.
> 
> Note that rxe_ns_pernet_sk6() is broken and will be fixed
> in the following patch.
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
> v2: Set up UDP tunnels in __net_init instead of adding mutex.
> v1: https://lore.kernel.org/all/20260424013759.728288-1-kuniyu@google.com/
> ---
>   drivers/infiniband/sw/rxe/rxe.c     |   6 --
>   drivers/infiniband/sw/rxe/rxe_net.c | 126 ++--------------------------
>   drivers/infiniband/sw/rxe/rxe_net.h |   5 +-
>   drivers/infiniband/sw/rxe/rxe_ns.c  |  90 +++++++++-----------
>   drivers/infiniband/sw/rxe/rxe_ns.h  |   1 -
>   5 files changed, 47 insertions(+), 181 deletions(-)
> 

All the commits are functionally correct, but I noticed some regressions 
when running:
make -C tools/testing/selftests/rdma/ TARGET=rdma run_tests

After applying this commit, the UDP port 4791 starts listening in both 
init_net and all other net namespaces as soon as modprobe rdma_rxe is 
executed. This breaks tests that expect the port to be unoccupied until 
a device is actually created.

I have a workaround to fix the current test failures. However, I think 
we should also add a new test case to the RDMA selftests. This test 
should explicitly verify that port 4791 is correctly listening in all 
namespaces immediately after the module is loaded, reflecting the new 
architectural change.

The workaround:
----------------------------Begin--------------------------------------
diff --git a/tools/testing/selftests/rdma/rxe_ipv6.sh 
b/tools/testing/selftests/rdma/rxe_ipv6.sh
index b7059bfd6d7c..e808d9829752 100755
--- a/tools/testing/selftests/rdma/rxe_ipv6.sh
+++ b/tools/testing/selftests/rdma/rxe_ipv6.sh
@@ -56,8 +56,8 @@ echo "Verified: Port $PORT is active."
  echo "Deleting RDMA link..."
  ip netns exec "$NS_NAME" rdma link del "$RXE_NAME"

-if ip netns exec "$NS_NAME" ss -Hul6n sport = :$PORT | grep -q 
":$PORT"; then
-    echo "Error: UDP port $PORT still active after link deletion."
+if ! ip netns exec "$NS_NAME" ss -Hul6n sport = :$PORT | grep -q 
":$PORT"; then
+    echo "Error: UDP port $PORT is not active after link deletion."
      exit 1
  fi
  echo "Verified: Port $PORT closed successfully."
diff --git a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh 
b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
index 002e5098f751..0ad4a8d4d755 100755
--- a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
+++ b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
@@ -68,8 +68,8 @@ echo "Deleting rxe0..."
  rdma link del rxe0

  # Port should now be gone
-if ss -Huln sport = :$PORT | grep -q ":$PORT"; then
-    echo "Error: UDP port $PORT still exists after all links deleted"
+if ! ss -Huln sport = :$PORT | grep -q ":$PORT"; then
+    echo "Error: UDP port $PORT does not exist after all links deleted"
      exit 1
  fi

diff --git a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh 
b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
index 021ca451499d..07efe9ea6a71 100755
--- a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
+++ b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
@@ -55,8 +55,8 @@ if rdma link show "$RXE_NAME" 2>/dev/null; then
      exit 1
  fi

-if ss -Huln sport == :$RDMA_PORT | grep -q ":$RDMA_PORT"; then
-    echo "Error: UDP port $RDMA_PORT still listening after netdev removal."
+if ! ss -Huln sport == :$RDMA_PORT | grep -q ":$RDMA_PORT"; then
+    echo "Error: UDP port $RDMA_PORT is not listening after netdev 
removal."
      exit 1
  fi
---------------------------End-----------------------------------------

The new testcase is like the following:

----------------------------Begin--------------------------------------
# Load module
modprobe rdma_rxe

# Check init_net
ss -lnup | grep -q ":4791" || echo "Test Failed: Port 4791 not listening 
in init_net"

# Check in a new namespace
ip netns add rxe_test
ip netns exec rxe_test ss -lnup | grep -q ":4791" || echo "Test Failed: 
Port 4791 not listening in netns"
---------------------------End-----------------------------------------

Just my 2 cent suggestion. It is up to you about how to fix it.

To now I am fine with these 2 commits. Please David Ahern, Leon and 
Jason comment.

Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun


> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index b0714f9abe3d..111ba4e57261 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -236,10 +236,6 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   		goto err;
>   	}
>   
> -	err = rxe_net_init(ndev);
> -	if (err)
> -		return err;
> -
>   	err = rxe_net_add(ibdev_name, ndev);
>   	if (err) {
>   		rxe_err("failed to add %s\n", ndev->name);
> @@ -251,8 +247,6 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   
>   static int rxe_dellink(struct ib_device *dev)
>   {
> -	rxe_net_del(dev);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..9080d4c893a1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -256,8 +256,8 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>   	return 0;
>   }
>   
> -static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
> -					   bool ipv6)
> +struct sock *rxe_setup_udp_tunnel(struct net *net, __be16 port,
> +				  bool ipv6)
>   {
>   	int err;
>   	struct socket *sock;
> @@ -285,13 +285,12 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>   	/* Setup UDP tunnel */
>   	setup_udp_tunnel_sock(net, sock, &tnl_cfg);
>   
> -	return sock;
> +	return sock->sk;
>   }
>   
> -static void rxe_release_udp_tunnel(struct socket *sk)
> +void rxe_release_udp_tunnel(struct sock *sk)
>   {
> -	if (sk)
> -		udp_tunnel_sock_release(sk);
> +	udp_tunnel_sock_release(sk->sk_socket);
>   }
>   
>   static void prepare_udp_hdr(struct sk_buff *skb, __be16 src_port,
> @@ -629,43 +628,6 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>   	return 0;
>   }
>   
> -static void rxe_sock_put(struct sock *sk,
> -					void (*set_sk)(struct net *, struct sock *),
> -					struct net *net)
> -{
> -	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
> -		__sock_put(sk);
> -	} else {
> -		rxe_release_udp_tunnel(sk->sk_socket);
> -		sk = NULL;
> -		set_sk(net, sk);
> -	}
> -}
> -
> -void rxe_net_del(struct ib_device *dev)
> -{
> -	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
> -	struct net_device *ndev;
> -	struct sock *sk;
> -	struct net *net;
> -
> -	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
> -	if (!ndev)
> -		return;
> -
> -	net = dev_net(ndev);
> -
> -	sk = rxe_ns_pernet_sk4(net);
> -	if (sk)
> -		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> -
> -	sk = rxe_ns_pernet_sk6(net);
> -	if (sk)
> -		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
> -
> -	dev_put(ndev);
> -}
> -
>   static void rxe_port_event(struct rxe_dev *rxe,
>   			   enum ib_event_type event)
>   {
> @@ -722,7 +684,6 @@ static int rxe_notify(struct notifier_block *not_blk,
>   	switch (event) {
>   	case NETDEV_UNREGISTER:
>   		ib_unregister_device_queued(&rxe->ib_dev);
> -		rxe_net_del(&rxe->ib_dev);
>   		break;
>   	case NETDEV_CHANGEMTU:
>   		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
> @@ -752,56 +713,6 @@ static struct notifier_block rxe_net_notifier = {
>   	.notifier_call = rxe_notify,
>   };
>   
> -static int rxe_net_ipv4_init(struct net *net)
> -{
> -	struct sock *sk;
> -	struct socket *sock;
> -
> -	sk = rxe_ns_pernet_sk4(net);
> -	if (sk) {
> -		sock_hold(sk);
> -		return 0;
> -	}
> -
> -	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), false);
> -	if (IS_ERR(sock)) {
> -		pr_err("Failed to create IPv4 UDP tunnel\n");
> -		return -1;
> -	}
> -	rxe_ns_pernet_set_sk4(net, sock->sk);
> -
> -	return 0;
> -}
> -
> -static int rxe_net_ipv6_init(struct net *net)
> -{
> -#if IS_ENABLED(CONFIG_IPV6)
> -	struct sock *sk;
> -	struct socket *sock;
> -
> -	sk = rxe_ns_pernet_sk6(net);
> -	if (sk) {
> -		sock_hold(sk);
> -		return 0;
> -	}
> -
> -	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), true);
> -	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
> -		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
> -		return 0;
> -	}
> -
> -	if (IS_ERR(sock)) {
> -		pr_err("Failed to create IPv6 UDP tunnel\n");
> -		return -1;
> -	}
> -
> -	rxe_ns_pernet_set_sk6(net, sock->sk);
> -
> -#endif
> -	return 0;
> -}
> -
>   int rxe_register_notifier(void)
>   {
>   	int err;
> @@ -819,30 +730,3 @@ void rxe_net_exit(void)
>   {
>   	unregister_netdevice_notifier(&rxe_net_notifier);
>   }
> -
> -int rxe_net_init(struct net_device *ndev)
> -{
> -	struct net *net;
> -	struct sock *sk;
> -	int err;
> -
> -	net = dev_net(ndev);
> -
> -	err = rxe_net_ipv4_init(net);
> -	if (err)
> -		return err;
> -
> -	err = rxe_net_ipv6_init(net);
> -	if (err)
> -		goto err_out;
> -
> -	return 0;
> -
> -err_out:
> -	/* If ipv6 error, release ipv4 resource */
> -	sk = rxe_ns_pernet_sk4(net);
> -	if (sk)
> -		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> -
> -	return err;
> -}
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index 56249677d692..592b0e577f32 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -11,11 +11,12 @@
>   #include <net/if_inet6.h>
>   #include <linux/module.h>
>   
> +struct sock *rxe_setup_udp_tunnel(struct net *net, __be16 port, bool ipv6);
> +void rxe_release_udp_tunnel(struct sock *sk);
> +
>   int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
> -void rxe_net_del(struct ib_device *dev);
>   
>   int rxe_register_notifier(void);
> -int rxe_net_init(struct net_device *ndev);
>   void rxe_net_exit(void);
>   
>   #endif /* RXE_NET_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> index 8b9d734229b2..06eb2e2387a1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -7,8 +7,10 @@
>   #include <linux/skbuff.h>
>   #include <linux/pid_namespace.h>
>   #include <net/udp_tunnel.h>
> +#include <rdma/ib_verbs.h>
>   
>   #include "rxe_ns.h"
> +#include "rxe_net.h"
>   
>   /*
>    * Per network namespace data
> @@ -23,40 +25,54 @@ struct rxe_ns_sock {
>    */
>   static unsigned int rxe_pernet_id;
>   
> -/*
> - * Called for every existing and added network namespaces
> - */
> -static int rxe_ns_init(struct net *net)
> +static __net_init int rxe_ns_init(struct net *net)
>   {
> -	/* defer socket create in the namespace to the first
> -	 * device create.
> -	 */
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +	struct sock *sk;
> +	int err = 0;
> +
> +	sk = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), false);
> +	if (IS_ERR(sk)) {
> +		err = PTR_ERR(sk);
> +		goto out;
> +	}
> +
> +	RCU_INIT_POINTER(ns_sk->rxe_sk4, sk);
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	sk = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), true);
> +	if (IS_ERR(sk)) {
> +		err = PTR_ERR(sk);
> +		if (err == -EAFNOSUPPORT) {
> +			err = 0;
> +			goto out;
> +		}
> +
> +		sk = rcu_dereference_protected(ns_sk->rxe_sk4, 1);
> +		rxe_release_udp_tunnel(sk);
> +		goto out;
> +	}
>   
> -	return 0;
> +	RCU_INIT_POINTER(ns_sk->rxe_sk6, sk);
> +#endif
> +out:
> +	return err;
>   }
>   
> -static void rxe_ns_exit(struct net *net)
> +static __net_exit void rxe_ns_exit(struct net *net)
>   {
> -	/* called when the network namespace is removed
> -	 */
>   	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
>   	struct sock *sk;
>   
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk4);
> -	rcu_read_unlock();
> -	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> -		udp_tunnel_sock_release(sk->sk_socket);
> -	}
> +	sk = rcu_dereference_protected(ns_sk->rxe_sk4, 1);
> +	RCU_INIT_POINTER(ns_sk->rxe_sk4, NULL);
> +	rxe_release_udp_tunnel(sk);
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk6);
> -	rcu_read_unlock();
> +	sk = rcu_dereference_protected(ns_sk->rxe_sk6, 1);
>   	if (sk) {
> -		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
> -		udp_tunnel_sock_release(sk->sk_socket);
> +		RCU_INIT_POINTER(ns_sk->rxe_sk6, NULL);
> +		rxe_release_udp_tunnel(sk);
>   	}
>   #endif
>   }
> @@ -71,26 +87,6 @@ static struct pernet_operations rxe_net_ops = {
>   	.size = sizeof(struct rxe_ns_sock),
>   };
>   
> -struct sock *rxe_ns_pernet_sk4(struct net *net)
> -{
> -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -	struct sock *sk;
> -
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk4);
> -	rcu_read_unlock();
> -
> -	return sk;
> -}
> -
> -void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
> -{
> -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -
> -	rcu_assign_pointer(ns_sk->rxe_sk4, sk);
> -	synchronize_rcu();
> -}
> -
>   #if IS_ENABLED(CONFIG_IPV6)
>   struct sock *rxe_ns_pernet_sk6(struct net *net)
>   {
> @@ -103,14 +99,6 @@ struct sock *rxe_ns_pernet_sk6(struct net *net)
>   
>   	return sk;
>   }
> -
> -void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
> -{
> -	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -
> -	rcu_assign_pointer(ns_sk->rxe_sk6, sk);
> -	synchronize_rcu();
> -}
>   #endif /* IPV6 */
>   
>   int rxe_namespace_init(void)
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
> index 4da2709e6b71..7f48d624fa05 100644
> --- a/drivers/infiniband/sw/rxe/rxe_ns.h
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.h
> @@ -3,7 +3,6 @@
>   #ifndef RXE_NS_H
>   #define RXE_NS_H
>   
> -struct sock *rxe_ns_pernet_sk4(struct net *net);
>   void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
>   
>   #if IS_ENABLED(CONFIG_IPV6)


