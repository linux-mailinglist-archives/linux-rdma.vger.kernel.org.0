Return-Path: <linux-rdma+bounces-20804-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKGhJ6wACWqnEQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20804-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 01:41:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7629E55E54B
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D5763009397
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 23:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC393A4513;
	Sat, 16 May 2026 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P4ka37y0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF00389106
	for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778974843; cv=none; b=Zjrmrum/aWyt5dMbHSnd7jn1eLHYtwOUgwowzjyRW005RAdaRnJlSmV7gWDEm9PwSAJ1w0g7DsD2EFr7XnRg5AKQ7lKu6Twnn6OgC7Lu4uwFPBc56UhrNJyiZMnSHzUeNFbIuKPRmROmsNRG81HD7iMSoWKT3pLHTBa+vj5kVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778974843; c=relaxed/simple;
	bh=Yxde21/FpEC9Q/8XqGlNZoSxXAwWMIy1BaDpXVsBMuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2Ll85Ag3phfpO1we0v/h0G/R5pbj3BrNloAPOep6Q0509LgUnfPrZsxMqH9sFDL6MBuwE46YPiQRYJbV4WSuRAXgJxK0kEqSdaO3inmIgEqTlzZPCEWbwjkw23D/jtjsmX6bpyqfk/DJeIP0ym+CWy++0eKMYrhjJ5aDp0UBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P4ka37y0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13bc2e56-ea61-4cde-896f-c10636b29e9d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778974829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67dFB94dGZ1+rRNu0d+XP9s63OVtf5FieeCeuu0lNTc=;
	b=P4ka37y0/RRkQaQR5H7uAZUPbakKSZ07LeFKJcmBQEx99lZRmVHMlRyO2YqoDuqlQWps0G
	xMZyA1MgBos3mNTLz3gEUJwypSc7TyCas+Xd4egqGYiqTdLrPCULKpItuevwDkhwhQxZ14
	RgKeSpY2dN9D6EdVTFY30Bcs2Ceaw94=
Date: Sat, 16 May 2026 16:40:22 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RDMA v2] RDMA/rxe: add mutual exclusion in rxe_net_del()
To: Edward Adam Davis <eadavis@qq.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuniyu@google.com, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <tencent_0106C0D2EA464109986EE86EF40CB5E7D406@qq.com>
 <tencent_330636464A367423778966A63DD1360E9609@qq.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_330636464A367423778966A63DD1360E9609@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7629E55E54B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20804-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action


On 5/16/26 7:00 AM, Edward Adam Davis wrote:
> We must serialize calls to rxe_net_del() or risk a crash as syzbot
> reported:
>
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> Call Trace:
>   udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
>   rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>   rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
>   rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
>   rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>
> Jason Gunthorpe suggest placing the lock within rxe to protect its racy
> implementation of rxe_net_del(), which looks like it is possibly also
> triggered by NETDEV_UNREGISTER.
>
> The patch addressing this issue in nldev_dellink() has already been
> applied(0b28000b64f4); however, since the fix has now been relocated
> to rxe, the corresponding remedial code in nldev has been removed.
>
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
> Fixes: 0b28000b64f4 ("RDMA/nldev: Add mutual exclusion in nldev_dellink()")
> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> v1 -> v2: serialize calls to rxe net del
>
>   drivers/infiniband/core/nldev.c     | 4 ----
>   drivers/infiniband/sw/rxe/rxe_net.c | 7 ++++++-
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 3cb3cb7629fe..96c745d5bac4 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1816,8 +1816,6 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	return err;
>   }
>   
> -static DEFINE_MUTEX(nldev_dellink_mutex);
> -
>   static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   			  struct netlink_ext_ack *extack)
>   {
> @@ -1848,9 +1846,7 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	 * implicitly scoped to the driver supporting dynamic link deletion like RXE.
>   	 */
>   	if (device->link_ops && device->link_ops->dellink) {
> -		mutex_lock(&nldev_dellink_mutex);
>   		err = device->link_ops->dellink(device);
> -		mutex_unlock(&nldev_dellink_mutex);
>   		if (err)
>   			return err;
>   	}
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..92847e955ca2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -642,6 +642,8 @@ static void rxe_sock_put(struct sock *sk,
>   	}
>   }
>   
I read this commit carefully. There are two paths that can invoke 
rxe_net_del().

One is through the rdma link del xxx command, while the other is through 
the netdevice notification chain.

In the netdevice notification chain path, rtnl_lock is already held, and 
rxe_net_del() is called under that lock.

However, in the rdma link del xxx path, no rtnl_lock is taken.

Because of this, I would like to use the existing rtnl_lock to serialize 
calls to rxe_net_del().

My proposed commit is shown below. I am not sure whether it fully 
resolves the problem.

diff --git a/drivers/infiniband/sw/rxe/rxe.c 
b/drivers/infiniband/sw/rxe/rxe.c
index b0714f9abe3d..84266dc416c4 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -251,7 +251,9 @@ static int rxe_newlink(const char *ibdev_name, 
struct net_device *ndev)

  static int rxe_dellink(struct ib_device *dev)
  {
+       rtnl_lock();
         rxe_net_del(dev);
+       rtnl_unlock();

         return 0;
  }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..ac53ea73996d 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -649,6 +649,8 @@ void rxe_net_del(struct ib_device *dev)
         struct sock *sk;
         struct net *net;

+       ASSERT_RTNL();
+
         ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
         if (!ndev)
                 return;

Zhu Yanjun

> +static DEFINE_MUTEX(rxe_net_del_mutex);
> +
>   void rxe_net_del(struct ib_device *dev)
>   {
>   	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
> @@ -649,9 +651,10 @@ void rxe_net_del(struct ib_device *dev)
>   	struct sock *sk;
>   	struct net *net;
>   
> +	mutex_lock(&rxe_net_del_mutex);
>   	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
>   	if (!ndev)
> -		return;
> +		goto out;
>   
>   	net = dev_net(ndev);
>   
> @@ -664,6 +667,8 @@ void rxe_net_del(struct ib_device *dev)
>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
>   
>   	dev_put(ndev);
> +out:
> +	mutex_unlock(&rxe_net_del_mutex);
>   }
>   
>   static void rxe_port_event(struct rxe_dev *rxe,

