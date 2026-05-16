Return-Path: <linux-rdma+bounces-20801-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMlZJAmACGo/sgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20801-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 16:32:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01755C154
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06ABB301CD87
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397AC1DED5C;
	Sat, 16 May 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R41GbAip"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895B175A7D
	for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778941929; cv=none; b=HhcrhBU8VNmvDZaF8E6T4Um+7hO2z40FwlQYOq4B6OVhUaQsNkBZyGfzXVQ/dBd18a2RHeWLymu/j5AlSf7KULJFpmN22e7RgMFraqE7IVvNBzecOyH2J3JAlyBB3CCr99baEozP4hFoMlbdiIxAQUnhyqwNhmkgQeLJuFfcuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778941929; c=relaxed/simple;
	bh=gUw7/It+XjAMDtvU2RcfFQF8ZA+xBALOy25IMlln9lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUIAk5hbJGL5OkblgT1/jq4KnxuNVtAjEJV/UqaXEWGKSHmdBeUhZ5XdVJlNmhWitVdAga4fgvkCwFYUw67+OmtrLc421yTeS7FveZrFPEVIUn7fRJhtKQMeHak590va9zuXJHDEdj27IR19AIsXXFM6DJNTxrg61BXzzpTfeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R41GbAip; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39e752db-f34c-4070-b4c8-974fb76ee7f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778941913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBh1X8F3RQc/zJUrw/MBwchNio7gpTK5UokEqojPi08=;
	b=R41GbAipQCWXqZor4Z0Lp3qlMFDeDvTcfkkezALES+AifCjP1A24Nnvw/cwInwOJSHXXu/
	Lxr9pS39zoRxx+z+IdGNlojIz4Si1V8pREmWHyEIAF5Hgan0mH//YXugiSLaKLp8bqdFlp
	h2PghRx+oYKT6EqMxhdMZbNRg2VOIuA=
Date: Sat, 16 May 2026 07:31:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RDMA v2] RDMA/rxe: add mutual exclusion in rxe_net_del()
To: Edward Adam Davis <eadavis@qq.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuniyu@google.com, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <tencent_0106C0D2EA464109986EE86EF40CB5E7D406@qq.com>
 <tencent_330636464A367423778966A63DD1360E9609@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_330636464A367423778966A63DD1360E9609@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0E01755C154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20801-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[qq.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

在 2026/5/16 7:00, Edward Adam Davis 写道:
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

I looked through the commit. I am not sure if this commit should be sent 
to syzbot to verify.

Zhu Yanjun

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


