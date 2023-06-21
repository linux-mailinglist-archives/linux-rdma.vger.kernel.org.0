Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2557378BA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 03:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFUBaV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 21:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFUBaU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 21:30:20 -0400
Received: from out-56.mta0.migadu.com (out-56.mta0.migadu.com [91.218.175.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6B10DA
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 18:30:18 -0700 (PDT)
Message-ID: <9bf10fb4-1d2a-17c7-55f2-394936465ff4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687311016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d6ePZe1KuI0g6wCixe/ihVGN4rHQZGF6Fy1R6TyDfE=;
        b=QpXcOum2y1+N7SP+idRKP9kj6kTTwObCC6MR7cdbF9Nef/hMab1fUA8hXkdpalXBzoSgk4
        FVIuXkderz9oy3uxgaG8mRHmZsnWcLCb2UFDReE3PlCcnRZaTA1y3ZTnRLWlfPD0koghu2
        dirDmiOfDeGYbwtRiznJTyMNgpHGBBk=
Date:   Wed, 21 Jun 2023 09:30:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv5 for-rc1 v5 5/8] RDMA/rxe: Replace global variable with
 sock lookup functions
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Rain River <rain.1986.08.12@gmail.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
 <20230428093914.2121131-6-yanjun.zhu@intel.com>
 <db1aa8dc-04f6-e437-9809-b5e63372d53d@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <db1aa8dc-04f6-e437-9809-b5e63372d53d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/6/21 4:28, Bob Pearson 写道:
> On 4/28/23 04:39, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Originally a global variable is to keep the sock of udp listening
>> on port 4791. In fact, sock lookup functions can be used to get
>> the sock.
>>
>> Tested-by: Rain River <rain.1986.08.12@gmail.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c       |  1 +
>>   drivers/infiniband/sw/rxe/rxe_net.c   | 58 ++++++++++++++++++++-------
>>   drivers/infiniband/sw/rxe/rxe_net.h   |  5 ---
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
>>   4 files changed, 45 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index ebfabc6d6b76..e81c2164d77f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -74,6 +74,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>>   			rxe->ndev->dev_addr);
>>   
>>   	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
>> +	rxe->l_sk6				= NULL;
>>   }
>>   
>>   /* initialize port attributes */
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 4cc7de7b115b..b56e2c32fbf7 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -18,8 +18,6 @@
>>   #include "rxe_net.h"
>>   #include "rxe_loc.h"
>>   
>> -static struct rxe_recv_sockets recv_sockets;
>> -
>>   static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>>   					 struct net_device *ndev,
>>   					 struct in_addr *saddr,
>> @@ -51,6 +49,23 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>>   {
>>   	struct dst_entry *ndst;
>>   	struct flowi6 fl6 = { { 0 } };
>> +	struct rxe_dev *rdev;
>> +
>> +	rdev = rxe_get_dev_from_net(ndev);
>> +	if (!rdev->l_sk6) {
>> +		struct sock *sk;
>> +
>> +		rcu_read_lock();
>> +		sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
> This subroutine (and similar udp4) is currently called for every UD packet. This just adds a lot of
> code to packet processing for UD packets. All to save a global variable. Not sure it's worth it.

Thanks, Bob. I also noticed this problem. 2 variables rxe_sk4 and 
rxe_sk6 are added.

The 2 functions udp6_lib_lookup and udp4_lib_lookup are removed.

Zhu Yanjun

>
> Bob
>> +		rcu_read_unlock();
>> +		if (!sk) {
>> +			pr_info("file: %s +%d, error\n", __FILE__, __LINE__);
>> +			return (struct dst_entry *)sk;
>> +		}
>> +		__sock_put(sk);
>> +		rdev->l_sk6 = sk->sk_socket;
>> +	}
>> +
>>   
>>   	memset(&fl6, 0, sizeof(fl6));
>>   	fl6.flowi6_oif = ndev->ifindex;
>> @@ -58,8 +73,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>>   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>>   	fl6.flowi6_proto = IPPROTO_UDP;
>>   
>> -	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
>> -					       recv_sockets.sk6->sk, &fl6,
>> +	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
>> +					       rdev->l_sk6->sk, &fl6,
>>   					       NULL);
>>   	if (IS_ERR(ndst)) {
>>   		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
>> @@ -533,15 +548,33 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>>   #define SK_REF_FOR_TUNNEL	2
>>   void rxe_net_del(struct ib_device *dev)
>>   {
>> -	if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>> -		__sock_put(recv_sockets.sk6->sk);
>> +	struct sock *sk;
>> +
>> +	rcu_read_lock();
>> +	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY), htons(ROCE_V2_UDP_DPORT), 0);
>> +	rcu_read_unlock();
>> +	if (!sk)
>> +		return;
>> +
>> +	__sock_put(sk);
>> +
>> +	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>> +		__sock_put(sk);
>>   	else
>> -		rxe_release_udp_tunnel(recv_sockets.sk6);
>> +		rxe_release_udp_tunnel(sk->sk_socket);
>> +
>> +	rcu_read_lock();
>> +	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
>> +	rcu_read_unlock();
>> +	if (!sk)
>> +		return;
>> +
>> +	__sock_put(sk);
>>   
>> -	if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>> -		__sock_put(recv_sockets.sk4->sk);
>> +	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
>> +		__sock_put(sk);
>>   	else
>> -		rxe_release_udp_tunnel(recv_sockets.sk4);
>> +		rxe_release_udp_tunnel(sk->sk_socket);
>>   }
>>   #undef SK_REF_FOR_TUNNEL
>>   
>> @@ -651,10 +684,8 @@ static int rxe_net_ipv4_init(void)
>>   	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
>>   	if (IS_ERR(sock)) {
>>   		pr_err("Failed to create IPv4 UDP tunnel\n");
>> -		recv_sockets.sk4 = NULL;
>>   		return -1;
>>   	}
>> -	recv_sockets.sk4 = sock;
>>   
>>   	return 0;
>>   }
>> @@ -674,17 +705,14 @@ static int rxe_net_ipv6_init(void)
>>   
>>   	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), true);
>>   	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
>> -		recv_sockets.sk6 = NULL;
>>   		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
>>   		return 0;
>>   	}
>>   
>>   	if (IS_ERR(sock)) {
>> -		recv_sockets.sk6 = NULL;
>>   		pr_err("Failed to create IPv6 UDP tunnel\n");
>>   		return -1;
>>   	}
>> -	recv_sockets.sk6 = sock;
>>   #endif
>>   	return 0;
>>   }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
>> index f48f22f3353b..027b20e1bab6 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>> @@ -11,11 +11,6 @@
>>   #include <net/if_inet6.h>
>>   #include <linux/module.h>
>>   
>> -struct rxe_recv_sockets {
>> -	struct socket *sk4;
>> -	struct socket *sk6;
>> -};
>> -
>>   int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>>   void rxe_net_del(struct ib_device *dev);
>>   
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index c269ae2a3224..ac9bb55820a2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -396,6 +396,7 @@ struct rxe_dev {
>>   
>>   	struct rxe_port		port;
>>   	struct crypto_shash	*tfm;
>> +	struct socket		*l_sk6;
>>   };
>>   
>>   static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
