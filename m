Return-Path: <linux-rdma+bounces-316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E029809101
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 20:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2467A1C20AEF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78D4EB42;
	Thu,  7 Dec 2023 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5zJZKYL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83EB10DC;
	Thu,  7 Dec 2023 11:07:16 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1fb04b2251bso872993fac.0;
        Thu, 07 Dec 2023 11:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701976036; x=1702580836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NO+bCRkaU0DSrSI6joTFWWkgOisLNkFpllFmbKTXPo=;
        b=e5zJZKYLJGghF9o1X9SAM5Xv/s8UHhTjga89opiCjcYpiicKTus31vX72mnqNhEJSA
         Y+J3pZWR/tfRvVsoOuYScZht0gdKR5BK/kbQxv+Yq1EZIg+Ca9DYRwe4AEiMuBDgxMrf
         UVFovbdQXTu/VMDfiZsKargJRe+/CG1Dp4huFKx5j4sbK6dMDKAR/F9pn5yxj71eXFwV
         bJMtJbG0beKKHP8XYVjyy+jm6jDpbd/r9fObx2MInZzPoSCc48lKO3YFhh6xBnmpO11r
         2EjZyXxA0gOltyxKxgAj2i2YDctk/JTBPvbHG0f0MRACWB85b++nnsn0NR5XCqr9dgzV
         pNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976036; x=1702580836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NO+bCRkaU0DSrSI6joTFWWkgOisLNkFpllFmbKTXPo=;
        b=dtGj9iL6h4jr/eKL7gHp+l4/w+adqqreLJjxeRut5Koe2ANp1SEgC4QCP/rQwbveg4
         c2NY7C1Iw3dnTtg7iUOU/9ldWosJ8QS1hc9S5Wr3NzZnUvaYlIt5sPjOgL//nEjSf+UB
         1swP1Q0PCOzBhnRF1Lwh6z5B8kWvzBhXo65eaTCd5mPgO/fy8j2+Ri6vWsYCUJLT8Gb9
         h6csNFn28ZcFE5TOq39B0ciHllScIsPcN4LuslC07m/uf/fi/OhJkiybm9sGVjGPJ8dM
         Ut7TJd3qiRSnNka4QJ51aJYJcdpTQkyaH5K+fWQ1ZoYHlMvJeW3wAI5q+eup50AKO1G9
         caqg==
X-Gm-Message-State: AOJu0YzIefxPGPO64wCsTOsGUyYMNI7tgX4dXmOj3bXFf8buFUqNgdSV
	tSSnuJ0VsbgyFqAYCMFNDvY=
X-Google-Smtp-Source: AGHT+IFbvzrtU8Rnhw6vNIEX10en57yLLr8MNJrGVLqQ7al+Prp9yviQxjB6qol2pVOL0o/30gT81g==
X-Received: by 2002:a05:6870:4724:b0:1fb:29f8:20e6 with SMTP id b36-20020a056870472400b001fb29f820e6mr3280545oaq.82.1701976035943;
        Thu, 07 Dec 2023 11:07:15 -0800 (PST)
Received: from ?IPV6:2603:8081:1405:679b:ca1f:53fd:59c8:8b84? (2603-8081-1405-679b-ca1f-53fd-59c8-8b84.res6.spectrum.com. [2603:8081:1405:679b:ca1f:53fd:59c8:8b84])
        by smtp.gmail.com with ESMTPSA id xa14-20020a0568707f0e00b001faff1908d3sm80181oab.53.2023.12.07.11.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:07:15 -0800 (PST)
Message-ID: <319ba5c7-1ce8-4417-86de-0b42e8abad16@gmail.com>
Date: Thu, 7 Dec 2023 13:07:14 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v5 3/7] RDMA/rxe: Register IP mcast address
To: Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org
References: <20231205002613.10219-1-rpearsonhpe@gmail.com>
 <763abeeb-64b2-496f-9249-b588d1d47e60@linux.dev>
 <7f5d614e-dc1a-47ce-b573-60ba8c5a21fa@linux.dev>
 <CAJr_XRDphUUTLbXJbbVGjaQ-HBQ59DioQs_0PSVvmLpGiHk1FQ@mail.gmail.com>
Content-Language: en-US
From: Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJr_XRDphUUTLbXJbbVGjaQ-HBQ59DioQs_0PSVvmLpGiHk1FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/6/23 19:47, Rain River wrote:
> On Tue, Dec 5, 2023 at 6:30 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>>
>> 在 2023/12/5 13:55, Zhu Yanjun 写道:
>>> Add David S. Miller and  David Ahern.
>>>
>>> They are the maintainers in netdev and very familiar with mcast.
>>>
>>> Zhu Yanjun
>>>
>>> 在 2023/12/5 8:26, Bob Pearson 写道:
>>>> Currently the rdma_rxe driver does not receive mcast packets at all.
>>>>
>>>> Add code to rxe_mcast_add() and rxe_mcast_del() to register/deregister
>>>> the IP mcast address. This is required for mcast traffic to reach the
>>>> rxe driver when coming from an external source.
>>>>
>>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_mcast.c | 119 +++++++++++++++++++++-----
>>>>    drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
>>>>    drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
>>>>    drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
>>>>    4 files changed, 102 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c
>>>> b/drivers/infiniband/sw/rxe/rxe_mcast.c
>>>> index 86cc2e18a7fd..54735d07cee5 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>>>> @@ -19,38 +19,116 @@
>>>>     * mcast packets in the rxe receive path.
>>>>     */
>>>>    +#include <linux/igmp.h>
>>>> +
>>>>    #include "rxe.h"
>>>>    -/**
>>>> - * rxe_mcast_add - add multicast address to rxe device
>>>> - * @rxe: rxe device object
>>>> - * @mgid: multicast address as a gid
>>>> - *
>>>> - * Returns 0 on success else an error
>>>> - */
>>>> -static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
>>>> +static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
>>>>    {
>>>> +    struct in6_addr *addr6 = (struct in6_addr *)mgid;
>>>> +    struct sock *sk = recv_sockets.sk6->sk;
>>>>        unsigned char ll_addr[ETH_ALEN];
>>>> +    int err;
>>>> +
>>>> +    spin_lock_bh(&sk->sk_lock.slock);
>>>> +    rtnl_lock();
>>>> +    err = ipv6_sock_mc_join(sk, rxe->ndev->ifindex, addr6);
>>
>>
>> Normally sk_lock is used. Not sure if spin_lock_bh is correct or not.
> 
> ./net/ipv6/addrconf.c-2915-     lock_sock(sk);
> ./net/ipv6/addrconf.c-2916-     if (join)
> ./net/ipv6/addrconf.c:2917:             ret = ipv6_sock_mc_join(sk,
> ifindex, addr);
> ./net/ipv6/addrconf.c-2918-     else
> ./net/ipv6/addrconf.c-2919-             ret = ipv6_sock_mc_drop(sk,
> ifindex, addr);
> ./net/ipv6/addrconf.c-2920-     release_sock(sk);
> 
> Should be lock_sock?

It works as well as spin_lock_bh() in preventing the RCU splat and
looks like the preferred way. I'll make this change.

Bob
> 
>>
>> Please Jason or experts from netdev comment on this.
>>
>> Thanks,
>>
>> Zhu Yanjun
>>
>>
>>>> +    rtnl_unlock();
>>>> +    spin_unlock_bh(&sk->sk_lock.slock);
>>>> +    if (err && err != -EADDRINUSE)
>>>> +        goto err_out;
>>>>          ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
>>>> +    err = dev_mc_add(rxe->ndev, ll_addr);
>>>> +    if (err)
>>>> +        goto err_drop;
>>>> +
>>>> +    return 0;
>>>>    -    return dev_mc_add(rxe->ndev, ll_addr);
>>>> +err_drop:
>>>> +    spin_lock_bh(&sk->sk_lock.slock);
>>>> +    rtnl_lock();
>>>> +    ipv6_sock_mc_drop(sk, rxe->ndev->ifindex, addr6);
>>>> +    rtnl_unlock();
>>>> +    spin_unlock_bh(&sk->sk_lock.slock);
>>>> +err_out:
>>>> +    return err;
>>>>    }
>>>>    -/**
>>>> - * rxe_mcast_del - delete multicast address from rxe device
>>>> - * @rxe: rxe device object
>>>> - * @mgid: multicast address as a gid
>>>> - *
>>>> - * Returns 0 on success else an error
>>>> - */
>>>> -static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
>>>> +static int rxe_mcast_add(struct rxe_mcg *mcg)
>>>>    {
>>>> +    struct rxe_dev *rxe = mcg->rxe;
>>>> +    union ib_gid *mgid = &mcg->mgid;
>>>>        unsigned char ll_addr[ETH_ALEN];
>>>> +    struct ip_mreqn imr = {};
>>>> +    int err;
>>>> +
>>>> +    if (mcg->is_ipv6)
>>>> +        return rxe_mcast_add6(rxe, mgid);
>>>> +
>>>> +    imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
>>>> +    imr.imr_ifindex = rxe->ndev->ifindex;
>>>> +    rtnl_lock();
>>>> +    err = ip_mc_join_group(recv_sockets.sk4->sk, &imr);
>>>> +    rtnl_unlock();
>>>> +    if (err && err != -EADDRINUSE)
>>>> +        goto err_out;
>>>> +
>>>> +    ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
>>>> +    err = dev_mc_add(rxe->ndev, ll_addr);
>>>> +    if (err)
>>>> +        goto err_leave;
>>>> +
>>>> +    return 0;
>>>> +
>>>> +err_leave:
>>>> +    rtnl_lock();
>>>> +    ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
>>>> +    rtnl_unlock();
>>>> +err_out:
>>>> +    return err;
>>>> +}
>>>> +
>>>> +static int rxe_mcast_del6(struct rxe_dev *rxe, union ib_gid *mgid)
>>>> +{
>>>> +    struct sock *sk = recv_sockets.sk6->sk;
>>>> +    unsigned char ll_addr[ETH_ALEN];
>>>> +    int err, err2;
>>>>          ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
>>>> +    err = dev_mc_del(rxe->ndev, ll_addr);
>>>> +
>>>> +    spin_lock_bh(&sk->sk_lock.slock);
>>>> +    rtnl_lock();
>>>> +    err2 = ipv6_sock_mc_drop(sk, rxe->ndev->ifindex,
>>>> +            (struct in6_addr *)mgid);
>>>> +    rtnl_unlock();
>>>> +    spin_unlock_bh(&sk->sk_lock.slock);
>>>> +
>>>> +    return err ?: err2;
>>>> +}
>>>> +
>>>> +static int rxe_mcast_del(struct rxe_mcg *mcg)
>>>> +{
>>>> +    struct rxe_dev *rxe = mcg->rxe;
>>>> +    union ib_gid *mgid = &mcg->mgid;
>>>> +    unsigned char ll_addr[ETH_ALEN];
>>>> +    struct ip_mreqn imr = {};
>>>> +    int err, err2;
>>>> +
>>>> +    if (mcg->is_ipv6)
>>>> +        return rxe_mcast_del6(rxe, mgid);
>>>> +
>>>> +    imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
>>>> +    imr.imr_ifindex = rxe->ndev->ifindex;
>>>> +    ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
>>>> +    err = dev_mc_del(rxe->ndev, ll_addr);
>>>> +
>>>> +    rtnl_lock();
>>>> +    err2 = ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
>>>> +    rtnl_unlock();
>>>>    -    return dev_mc_del(rxe->ndev, ll_addr);
>>>> +    return err ?: err2;
>>>>    }
>>>>      /**
>>>> @@ -164,6 +242,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe,
>>>> union ib_gid *mgid,
>>>>    {
>>>>        kref_init(&mcg->ref_cnt);
>>>>        memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
>>>> +    mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
>>>>        INIT_LIST_HEAD(&mcg->qp_list);
>>>>        mcg->rxe = rxe;
>>>>    @@ -225,7 +304,7 @@ static struct rxe_mcg *rxe_get_mcg(struct
>>>> rxe_dev *rxe, union ib_gid *mgid)
>>>>        spin_unlock_bh(&rxe->mcg_lock);
>>>>          /* add mcast address outside of lock */
>>>> -    err = rxe_mcast_add(rxe, mgid);
>>>> +    err = rxe_mcast_add(mcg);
>>>>        if (!err)
>>>>            return mcg;
>>>>    @@ -273,7 +352,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>>>>    static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>>>>    {
>>>>        /* delete mcast address outside of lock */
>>>> -    rxe_mcast_del(mcg->rxe, &mcg->mgid);
>>>> +    rxe_mcast_del(mcg);
>>>>          spin_lock_bh(&mcg->rxe->mcg_lock);
>>>>        __rxe_destroy_mcg(mcg);
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
>>>> b/drivers/infiniband/sw/rxe/rxe_net.c
>>>> index 58c3f3759bf0..b481f8da2002 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>>> @@ -18,7 +18,7 @@
>>>>    #include "rxe_net.h"
>>>>    #include "rxe_loc.h"
>>>>    -static struct rxe_recv_sockets recv_sockets;
>>>> +struct rxe_recv_sockets recv_sockets;
>>>>      static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>>>>                         struct net_device *ndev,
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h
>>>> b/drivers/infiniband/sw/rxe/rxe_net.h
>>>> index 45d80d00f86b..89cee7d5340f 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>>>> @@ -15,6 +15,7 @@ struct rxe_recv_sockets {
>>>>        struct socket *sk4;
>>>>        struct socket *sk6;
>>>>    };
>>>> +extern struct rxe_recv_sockets recv_sockets;
>>>>      int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>>>>    diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> index ccb9d19ffe8a..7be9e6232dd9 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> @@ -352,6 +352,7 @@ struct rxe_mcg {
>>>>        atomic_t        qp_num;
>>>>        u32            qkey;
>>>>        u16            pkey;
>>>> +    bool            is_ipv6;
>>>>    };
>>>>      struct rxe_mca {
>>

