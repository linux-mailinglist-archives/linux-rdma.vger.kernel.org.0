Return-Path: <linux-rdma+bounces-267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C93805032
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 11:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EB42817D9
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41514F1F3;
	Tue,  5 Dec 2023 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qTMdZEMB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3DFB0;
	Tue,  5 Dec 2023 02:30:01 -0800 (PST)
Message-ID: <7f5d614e-dc1a-47ce-b573-60ba8c5a21fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701772199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeIuqHWIUIscHS3ok9zJAgV8tn/E5lU12Oglw+Mwgkk=;
	b=qTMdZEMBJsUKD2sXI30yLkPA1pbynvuACDKuVkLkdLfs3XbUpXiA/DblZ615eM7lRwiM1R
	HVEgf+i8A8RC0/LGl90YGPV65p5s50om0vxQBfS5LS2z18cTmGoEfnu1YX166+7fNN9vBr
	aZOLEhQfS3f9sVwm8bM7KKPSY+dyXA4=
Date: Tue, 5 Dec 2023 18:29:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 3/7] RDMA/rxe: Register IP mcast address
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org
References: <20231205002613.10219-1-rpearsonhpe@gmail.com>
 <763abeeb-64b2-496f-9249-b588d1d47e60@linux.dev>
In-Reply-To: <763abeeb-64b2-496f-9249-b588d1d47e60@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2023/12/5 13:55, Zhu Yanjun 写道:
> Add David S. Miller and  David Ahern.
>
> They are the maintainers in netdev and very familiar with mcast.
>
> Zhu Yanjun
>
> 在 2023/12/5 8:26, Bob Pearson 写道:
>> Currently the rdma_rxe driver does not receive mcast packets at all.
>>
>> Add code to rxe_mcast_add() and rxe_mcast_del() to register/deregister
>> the IP mcast address. This is required for mcast traffic to reach the
>> rxe driver when coming from an external source.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_mcast.c | 119 +++++++++++++++++++++-----
>>   drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
>>   drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
>>   4 files changed, 102 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c 
>> b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> index 86cc2e18a7fd..54735d07cee5 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> @@ -19,38 +19,116 @@
>>    * mcast packets in the rxe receive path.
>>    */
>>   +#include <linux/igmp.h>
>> +
>>   #include "rxe.h"
>>   -/**
>> - * rxe_mcast_add - add multicast address to rxe device
>> - * @rxe: rxe device object
>> - * @mgid: multicast address as a gid
>> - *
>> - * Returns 0 on success else an error
>> - */
>> -static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
>> +static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
>>   {
>> +    struct in6_addr *addr6 = (struct in6_addr *)mgid;
>> +    struct sock *sk = recv_sockets.sk6->sk;
>>       unsigned char ll_addr[ETH_ALEN];
>> +    int err;
>> +
>> +    spin_lock_bh(&sk->sk_lock.slock);
>> +    rtnl_lock();
>> +    err = ipv6_sock_mc_join(sk, rxe->ndev->ifindex, addr6);


Normally sk_lock is used. Not sure if spin_lock_bh is correct or not.

Please Jason or experts from netdev comment on this.

Thanks,

Zhu Yanjun


>> +    rtnl_unlock();
>> +    spin_unlock_bh(&sk->sk_lock.slock);
>> +    if (err && err != -EADDRINUSE)
>> +        goto err_out;
>>         ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
>> +    err = dev_mc_add(rxe->ndev, ll_addr);
>> +    if (err)
>> +        goto err_drop;
>> +
>> +    return 0;
>>   -    return dev_mc_add(rxe->ndev, ll_addr);
>> +err_drop:
>> +    spin_lock_bh(&sk->sk_lock.slock);
>> +    rtnl_lock();
>> +    ipv6_sock_mc_drop(sk, rxe->ndev->ifindex, addr6);
>> +    rtnl_unlock();
>> +    spin_unlock_bh(&sk->sk_lock.slock);
>> +err_out:
>> +    return err;
>>   }
>>   -/**
>> - * rxe_mcast_del - delete multicast address from rxe device
>> - * @rxe: rxe device object
>> - * @mgid: multicast address as a gid
>> - *
>> - * Returns 0 on success else an error
>> - */
>> -static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
>> +static int rxe_mcast_add(struct rxe_mcg *mcg)
>>   {
>> +    struct rxe_dev *rxe = mcg->rxe;
>> +    union ib_gid *mgid = &mcg->mgid;
>>       unsigned char ll_addr[ETH_ALEN];
>> +    struct ip_mreqn imr = {};
>> +    int err;
>> +
>> +    if (mcg->is_ipv6)
>> +        return rxe_mcast_add6(rxe, mgid);
>> +
>> +    imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
>> +    imr.imr_ifindex = rxe->ndev->ifindex;
>> +    rtnl_lock();
>> +    err = ip_mc_join_group(recv_sockets.sk4->sk, &imr);
>> +    rtnl_unlock();
>> +    if (err && err != -EADDRINUSE)
>> +        goto err_out;
>> +
>> +    ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
>> +    err = dev_mc_add(rxe->ndev, ll_addr);
>> +    if (err)
>> +        goto err_leave;
>> +
>> +    return 0;
>> +
>> +err_leave:
>> +    rtnl_lock();
>> +    ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
>> +    rtnl_unlock();
>> +err_out:
>> +    return err;
>> +}
>> +
>> +static int rxe_mcast_del6(struct rxe_dev *rxe, union ib_gid *mgid)
>> +{
>> +    struct sock *sk = recv_sockets.sk6->sk;
>> +    unsigned char ll_addr[ETH_ALEN];
>> +    int err, err2;
>>         ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
>> +    err = dev_mc_del(rxe->ndev, ll_addr);
>> +
>> +    spin_lock_bh(&sk->sk_lock.slock);
>> +    rtnl_lock();
>> +    err2 = ipv6_sock_mc_drop(sk, rxe->ndev->ifindex,
>> +            (struct in6_addr *)mgid);
>> +    rtnl_unlock();
>> +    spin_unlock_bh(&sk->sk_lock.slock);
>> +
>> +    return err ?: err2;
>> +}
>> +
>> +static int rxe_mcast_del(struct rxe_mcg *mcg)
>> +{
>> +    struct rxe_dev *rxe = mcg->rxe;
>> +    union ib_gid *mgid = &mcg->mgid;
>> +    unsigned char ll_addr[ETH_ALEN];
>> +    struct ip_mreqn imr = {};
>> +    int err, err2;
>> +
>> +    if (mcg->is_ipv6)
>> +        return rxe_mcast_del6(rxe, mgid);
>> +
>> +    imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
>> +    imr.imr_ifindex = rxe->ndev->ifindex;
>> +    ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
>> +    err = dev_mc_del(rxe->ndev, ll_addr);
>> +
>> +    rtnl_lock();
>> +    err2 = ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
>> +    rtnl_unlock();
>>   -    return dev_mc_del(rxe->ndev, ll_addr);
>> +    return err ?: err2;
>>   }
>>     /**
>> @@ -164,6 +242,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, 
>> union ib_gid *mgid,
>>   {
>>       kref_init(&mcg->ref_cnt);
>>       memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
>> +    mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
>>       INIT_LIST_HEAD(&mcg->qp_list);
>>       mcg->rxe = rxe;
>>   @@ -225,7 +304,7 @@ static struct rxe_mcg *rxe_get_mcg(struct 
>> rxe_dev *rxe, union ib_gid *mgid)
>>       spin_unlock_bh(&rxe->mcg_lock);
>>         /* add mcast address outside of lock */
>> -    err = rxe_mcast_add(rxe, mgid);
>> +    err = rxe_mcast_add(mcg);
>>       if (!err)
>>           return mcg;
>>   @@ -273,7 +352,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>>   static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>>   {
>>       /* delete mcast address outside of lock */
>> -    rxe_mcast_del(mcg->rxe, &mcg->mgid);
>> +    rxe_mcast_del(mcg);
>>         spin_lock_bh(&mcg->rxe->mcg_lock);
>>       __rxe_destroy_mcg(mcg);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
>> b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 58c3f3759bf0..b481f8da2002 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -18,7 +18,7 @@
>>   #include "rxe_net.h"
>>   #include "rxe_loc.h"
>>   -static struct rxe_recv_sockets recv_sockets;
>> +struct rxe_recv_sockets recv_sockets;
>>     static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>>                        struct net_device *ndev,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h 
>> b/drivers/infiniband/sw/rxe/rxe_net.h
>> index 45d80d00f86b..89cee7d5340f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>> @@ -15,6 +15,7 @@ struct rxe_recv_sockets {
>>       struct socket *sk4;
>>       struct socket *sk6;
>>   };
>> +extern struct rxe_recv_sockets recv_sockets;
>>     int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>>   diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h 
>> b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index ccb9d19ffe8a..7be9e6232dd9 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -352,6 +352,7 @@ struct rxe_mcg {
>>       atomic_t        qp_num;
>>       u32            qkey;
>>       u16            pkey;
>> +    bool            is_ipv6;
>>   };
>>     struct rxe_mca {

