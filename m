Return-Path: <linux-rdma+bounces-20807-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIvWI+M1CWrBNgQAu9opvQ
	(envelope-from <linux-rdma+bounces-20807-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 05:28:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D6255F1CF
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 05:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF09300E70D
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DAA2C0323;
	Sun, 17 May 2026 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RKvstPBj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027E70830;
	Sun, 17 May 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778988498; cv=none; b=Ck1Zu5/5cSNeAIzWC58RJCIsJ14Fbita3SfL+vRQ7rdmdN7hzakINh3qoQHsmKe348CSfPPClBfTqh2KXQWVp8NBUukCRyTcQmadhFZlz17djFTKhfsmKLFApXnY8NbzYTWQQhUizhLUoqc/NU61U8wNRphj98aisJhytFaLp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778988498; c=relaxed/simple;
	bh=GTnxUum3geF8r3cTA5Fys4lc9zubykXN/3Q9GM7bHZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9VASTLjzAQHpFgniHaMeZI4yxfh1s8EBef7NclWGBZaWszDzMeuhJ9xZTu5C71dOCvKqwXeSK+qLMizYrnHESnwTBQHwFVbzyV111l0Z9Hsb5Gvs6B+lXUxZaNw6JOyyS4yQmHPBKL+Av8oIuPjKmiS9TqiaHUhu4HMMRL9iCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RKvstPBj; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1dbc6a9d-4933-4123-90d2-a2735f9d8f58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778988492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azqQU+DGwZctWYveotI09InaMqZf929Gl8I+gPfhahY=;
	b=RKvstPBjURmV6HdcJ67yff0oqXXO1W+vuc886SLPwdlyThWbBovmQ/u8df+lZko/bq36QG
	H4nIFVs1AR0Qq4xRbIrKt5zt6MfQYy0p996gcKws8ayEL9Bs00XhUi4xHZBosRUfp7Egvj
	9MVTrTDSWst9ovYDiON/dH7v0VO8fzg=
Date: Sat, 16 May 2026 20:27:54 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RDMA v2] RDMA/rxe: add mutual exclusion in rxe_net_del()
To: Kuniyuki Iwashima <kuniyu@google.com>, "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
 arjan@linux.intel.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, hdanton@sina.com, horms@kernel.org, jgg@ziepe.ca,
 kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <tencent_0106C0D2EA464109986EE86EF40CB5E7D406@qq.com>
 <tencent_330636464A367423778966A63DD1360E9609@qq.com>
 <13bc2e56-ea61-4cde-896f-c10636b29e9d@linux.dev>
 <CAAVpQUB6eRRRpapTxXmidO4ADtFc-ZBA+zwfPFb4dyX55UD4JQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAAVpQUB6eRRRpapTxXmidO4ADtFc-ZBA+zwfPFb4dyX55UD4JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E0D6255F1CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20807-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action


在 2026/5/16 19:15, Kuniyuki Iwashima 写道:
> On Sat, May 16, 2026 at 4:40 PM Yanjun.Zhu <yanjun.zhu@linux.dev> wrote:
>>
>> On 5/16/26 7:00 AM, Edward Adam Davis wrote:
>>> We must serialize calls to rxe_net_del() or risk a crash as syzbot
>>> reported:
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
>>> Call Trace:
>>>    udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
>>>    rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>>>    rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
>>>    rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
>>>    rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>>>
>>> Jason Gunthorpe suggest placing the lock within rxe to protect its racy
>>> implementation of rxe_net_del(), which looks like it is possibly also
>>> triggered by NETDEV_UNREGISTER.
>>>
>>> The patch addressing this issue in nldev_dellink() has already been
>>> applied(0b28000b64f4); however, since the fix has now been relocated
>>> to rxe, the corresponding remedial code in nldev has been removed.
>>>
>>> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
>>> Fixes: 0b28000b64f4 ("RDMA/nldev: Add mutual exclusion in nldev_dellink()")
>>> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>>> ---
>>> v1 -> v2: serialize calls to rxe net del
>>>
>>>    drivers/infiniband/core/nldev.c     | 4 ----
>>>    drivers/infiniband/sw/rxe/rxe_net.c | 7 ++++++-
>>>    2 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>>> index 3cb3cb7629fe..96c745d5bac4 100644
>>> --- a/drivers/infiniband/core/nldev.c
>>> +++ b/drivers/infiniband/core/nldev.c
>>> @@ -1816,8 +1816,6 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>>>        return err;
>>>    }
>>>
>>> -static DEFINE_MUTEX(nldev_dellink_mutex);
>>> -
>>>    static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>>>                          struct netlink_ext_ack *extack)
>>>    {
>>> @@ -1848,9 +1846,7 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>>>         * implicitly scoped to the driver supporting dynamic link deletion like RXE.
>>>         */
>>>        if (device->link_ops && device->link_ops->dellink) {
>>> -             mutex_lock(&nldev_dellink_mutex);
>>>                err = device->link_ops->dellink(device);
>>> -             mutex_unlock(&nldev_dellink_mutex);
>>>                if (err)
>>>                        return err;
>>>        }
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>> index 50a2cb5405e2..92847e955ca2 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>> @@ -642,6 +642,8 @@ static void rxe_sock_put(struct sock *sk,
>>>        }
>>>    }
>>>
>> I read this commit carefully. There are two paths that can invoke
>> rxe_net_del().
>>
>> One is through the rdma link del xxx command, while the other is through
>> the netdevice notification chain.
>>
>> In the netdevice notification chain path, rtnl_lock is already held, and
>> rxe_net_del() is called under that lock.
>>
>> However, in the rdma link del xxx path, no rtnl_lock is taken.
>>
>> Because of this, I would like to use the existing rtnl_lock to serialize
>> calls to rxe_net_del().
> -1 for this.
>
> It's a global mutex and heavily contended because many
> components use it without much care.  We are working
> to reduce the RTNL pressure for years by converting such
> users with a dedicated lock or per-netns RTNL mutex.
>
> RTNL is not needed here at all, so please use a dedicated lock.

Thanks a lot for your review. I think the following commit can fix this 
problem.

Please review.

 From 80525f5b7fb0af18b9759cbde0237aabb76158cc Mon Sep 17 00:00:00 2001

From: Zhu Yanjun <yanjun.zhu@linux.dev>
Date: Sat, 16 May 2026 22:27:35 +0200
Subject: [PATCH 1/1] RDMA/rxe: Fix Use-After-Free problem in rxe_net_del

syzbot reported a general protection fault (KASAN: null-ptr-deref) in
kernel_sock_shutdown() called during the software RoCE (rxe) link
deletion path (rxe_dellink -> rxe_net_del).

The root cause is a TOCTOU (Time-of-Check to Time-of-Use) race condition
in rxe_net_del(). Previously, the function fetched the socket pointer
via rxe_ns_pernet_sk4/6() outside the critical section, and then
acquired the lock to release it via rxe_sock_put().

In a highly concurrent teardown environment, another thread could close
and clear the pernet socket after it was fetched but before the lock
was acquired. This causes rxe_sock_put() to operate on a dangling or
already cleared socket pointer, leading to a NULL pointer dereference
when kernel_sock_shutdown() attempts to access sock->sk.

Fix this by introducing a dedicated, per-device mutex 'release_lock'
and extending its scope. The socket pointers are now fetched, checked,
and released entirely within the same locked critical section. This
ensures the atomicity of the socket lookup and teardown sequence.

Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and 
destruction per net namespace")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
  drivers/infiniband/sw/rxe/rxe.c       | 2 ++
  drivers/infiniband/sw/rxe/rxe_net.c   | 4 ++++
  drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
  3 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c 
b/drivers/infiniband/sw/rxe/rxe.c
index b0714f9abe3d..46967ecdaf7d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -34,6 +34,7 @@ void rxe_dealloc(struct ib_device *ib_dev)
         WARN_ON(!RB_EMPTY_ROOT(&rxe->mcg_tree));

         mutex_destroy(&rxe->usdev_lock);
+       mutex_destroy(&rxe->release_lock);
  }

  static const struct ib_device_ops rxe_ib_dev_odp_ops = {
@@ -186,6 +187,7 @@ static void rxe_init(struct rxe_dev *rxe, struct 
net_device *ndev)
         rxe->mcg_tree = RB_ROOT;

         mutex_init(&rxe->usdev_lock);
+       mutex_init(&rxe->release_lock);
  }

  void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..c3b188538540 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -655,6 +655,8 @@ void rxe_net_del(struct ib_device *dev)

         net = dev_net(ndev);

+       mutex_lock(&rxe->release_lock);
+
         sk = rxe_ns_pernet_sk4(net);
         if (sk)
                 rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
@@ -663,6 +665,8 @@ void rxe_net_del(struct ib_device *dev)
         if (sk)
                 rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);

+       mutex_unlock(&rxe->release_lock);
+
         dev_put(ndev);
  }

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h 
b/drivers/infiniband/sw/rxe/rxe_verbs.h
index d92f80d16f78..3f54aa0a4356 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -422,6 +422,7 @@ struct rxe_dev {
         int                     max_ucontext;
         int                     max_inline_data;
         struct mutex            usdev_lock;
+       struct mutex            release_lock;

         char                    raw_gid[ETH_ALEN];

--
2.43.0

>
>> My proposed commit is shown below. I am not sure whether it fully
>> resolves the problem.
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c
>> b/drivers/infiniband/sw/rxe/rxe.c
>> index b0714f9abe3d..84266dc416c4 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -251,7 +251,9 @@ static int rxe_newlink(const char *ibdev_name,
>> struct net_device *ndev)
>>
>>    static int rxe_dellink(struct ib_device *dev)
>>    {
>> +       rtnl_lock();
>>           rxe_net_del(dev);
>> +       rtnl_unlock();
>>
>>           return 0;
>>    }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
>> b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 50a2cb5405e2..ac53ea73996d 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -649,6 +649,8 @@ void rxe_net_del(struct ib_device *dev)
>>           struct sock *sk;
>>           struct net *net;
>>
>> +       ASSERT_RTNL();
>> +
>>           ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
>>           if (!ndev)
>>                   return;
>>
>> Zhu Yanjun
>>
>>> +static DEFINE_MUTEX(rxe_net_del_mutex);
>>> +
>>>    void rxe_net_del(struct ib_device *dev)
>>>    {
>>>        struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
>>> @@ -649,9 +651,10 @@ void rxe_net_del(struct ib_device *dev)
>>>        struct sock *sk;
>>>        struct net *net;
>>>
>>> +     mutex_lock(&rxe_net_del_mutex);
>>>        ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
>>>        if (!ndev)
>>> -             return;
>>> +             goto out;
>>>
>>>        net = dev_net(ndev);
>>>
>>> @@ -664,6 +667,8 @@ void rxe_net_del(struct ib_device *dev)
>>>                rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
>>>
>>>        dev_put(ndev);
>>> +out:
>>> +     mutex_unlock(&rxe_net_del_mutex);
>>>    }
>>>
>>>    static void rxe_port_event(struct rxe_dev *rxe,

-- 
Best Regards,
Yanjun.Zhu


