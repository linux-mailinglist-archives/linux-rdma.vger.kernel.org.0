Return-Path: <linux-rdma+bounces-325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB20809891
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 02:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4B228202F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4276139C;
	Fri,  8 Dec 2023 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLkcZAOe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2C1706;
	Thu,  7 Dec 2023 17:24:27 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so1081773b6e.2;
        Thu, 07 Dec 2023 17:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701998666; x=1702603466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMS6+n4aVtzgvgUdw5Q0dkF5eYM0ZjJiDpGVMl5tPXQ=;
        b=SLkcZAOeTiBhdC1LxgQXNR18tuqYTtMS7rsv4X/GL4HM4uzzd5JpLdCfoRAsL8Bteb
         8BOe8fS/B4jEUDaLli0tpiAKChnFoiFX7w8yqPUGUOtVTcXOguwV1cJodK/gggYM8/5+
         9u2TJwU7/hlbCgCFCPJMtPZtn2aktE3oBZHvt41W4BRLdU8HiWwcEp3h5E8k/j1uE0ky
         wACHg/221s3+LaatOEqztaVoOdV+1C6Ew4ywCYDX58uhoOn5pVqwphOYINbFE23z8Be5
         /gJscwq3RUVwJVBCAQGni8xhjR7TJFyW+utvQnRO1ADFVZTQylvHSQLaRt9QJV05LUHd
         /fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998666; x=1702603466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMS6+n4aVtzgvgUdw5Q0dkF5eYM0ZjJiDpGVMl5tPXQ=;
        b=MaT0I3Uowmns9N/xQb54Q3tJ8FKVLnzx9PiJ9wClna9gKKHw/f0XuyHVTxwyK6GpVC
         bxNiegPmC7cFXB9mL9shRyAyfThJPY1Q2mPO15yawLbp3TjQVUoV/JLbBrIGypJ9tXxR
         twCy+ln8EYz3dhqvvVbFmjV9MXu1pQcqb5j8ARElFIapldLgBOezqxDdg3kzqkJrcP0R
         AVmC1s4oRRioWJIJKnz8cJsfqrbeXLG2WpJSkKTpfXsmGzDPErbCpBO6Kq4T5MJ20ZBM
         8ByTEsPPeHk/ZWzeGed/WhCS8Hbzaz7TULX0RNxGfFO3WFOnXFuz1ZGzlxI3JodiRHAI
         pfBA==
X-Gm-Message-State: AOJu0YxKxRj44yqAXCE5cDK8icPimUKbJPybUpA5vCJ1PWqWJbgqgE0D
	tYfM6wwYcirUPfaSeemXNhVrCBaB4DUd3Swj8/8=
X-Google-Smtp-Source: AGHT+IFW8YM0/X2Dm18iLeCdndAKA2PY30DyHVlPi+CFZUK6JIEbtI71ymaf9+TDJSxjUrs99lTAMx+gjlNGvrne6II=
X-Received: by 2002:a05:6808:1b26:b0:3b9:db4e:fccc with SMTP id
 bx38-20020a0568081b2600b003b9db4efcccmr2789854oib.11.1701998666382; Thu, 07
 Dec 2023 17:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205002613.10219-1-rpearsonhpe@gmail.com> <763abeeb-64b2-496f-9249-b588d1d47e60@linux.dev>
 <7f5d614e-dc1a-47ce-b573-60ba8c5a21fa@linux.dev> <CAJr_XRDphUUTLbXJbbVGjaQ-HBQ59DioQs_0PSVvmLpGiHk1FQ@mail.gmail.com>
 <319ba5c7-1ce8-4417-86de-0b42e8abad16@gmail.com>
In-Reply-To: <319ba5c7-1ce8-4417-86de-0b42e8abad16@gmail.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Fri, 8 Dec 2023 09:24:14 +0800
Message-ID: <CAEz=Lcu0djkY6JS123C8ePfX2cCyUpDiOhbd27EjqZfKThGN7Q@mail.gmail.com>
Subject: Re: [PATCH for-next v5 3/7] RDMA/rxe: Register IP mcast address
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@nvidia.com, 
	linux-rdma@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 3:07=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com> =
wrote:
>
>
>
> On 12/6/23 19:47, Rain River wrote:
> > On Tue, Dec 5, 2023 at 6:30=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev=
> wrote:
> >>
> >>
> >> =E5=9C=A8 2023/12/5 13:55, Zhu Yanjun =E5=86=99=E9=81=93:
> >>> Add David S. Miller and  David Ahern.
> >>>
> >>> They are the maintainers in netdev and very familiar with mcast.
> >>>
> >>> Zhu Yanjun
> >>>
> >>> =E5=9C=A8 2023/12/5 8:26, Bob Pearson =E5=86=99=E9=81=93:
> >>>> Currently the rdma_rxe driver does not receive mcast packets at all.
> >>>>
> >>>> Add code to rxe_mcast_add() and rxe_mcast_del() to register/deregist=
er
> >>>> the IP mcast address. This is required for mcast traffic to reach th=
e
> >>>> rxe driver when coming from an external source.
> >>>>
> >>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> >>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>> ---
> >>>>    drivers/infiniband/sw/rxe/rxe_mcast.c | 119 +++++++++++++++++++++=
-----
> >>>>    drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
> >>>>    drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
> >>>>    drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
> >>>>    4 files changed, 102 insertions(+), 21 deletions(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c
> >>>> b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >>>> index 86cc2e18a7fd..54735d07cee5 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> >>>> @@ -19,38 +19,116 @@
> >>>>     * mcast packets in the rxe receive path.
> >>>>     */
> >>>>    +#include <linux/igmp.h>
> >>>> +
> >>>>    #include "rxe.h"
> >>>>    -/**
> >>>> - * rxe_mcast_add - add multicast address to rxe device
> >>>> - * @rxe: rxe device object
> >>>> - * @mgid: multicast address as a gid
> >>>> - *
> >>>> - * Returns 0 on success else an error
> >>>> - */
> >>>> -static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>> +static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>>    {
> >>>> +    struct in6_addr *addr6 =3D (struct in6_addr *)mgid;
> >>>> +    struct sock *sk =3D recv_sockets.sk6->sk;
> >>>>        unsigned char ll_addr[ETH_ALEN];
> >>>> +    int err;
> >>>> +
> >>>> +    spin_lock_bh(&sk->sk_lock.slock);
> >>>> +    rtnl_lock();
> >>>> +    err =3D ipv6_sock_mc_join(sk, rxe->ndev->ifindex, addr6);
> >>
> >>
> >> Normally sk_lock is used. Not sure if spin_lock_bh is correct or not.
> >
> > ./net/ipv6/addrconf.c-2915-     lock_sock(sk);
> > ./net/ipv6/addrconf.c-2916-     if (join)
> > ./net/ipv6/addrconf.c:2917:             ret =3D ipv6_sock_mc_join(sk,
> > ifindex, addr);
> > ./net/ipv6/addrconf.c-2918-     else
> > ./net/ipv6/addrconf.c-2919-             ret =3D ipv6_sock_mc_drop(sk,
> > ifindex, addr);
> > ./net/ipv6/addrconf.c-2920-     release_sock(sk);
> >
> > Should be lock_sock?
>
> It works as well as spin_lock_bh() in preventing the RCU splat and
> looks like the preferred way. I'll make this change.

This is the implementation of lock_sock. lock_sock has not only spin_lock_b=
h,
but also other protections for sk.
You should use lock_sock, instead of spin_lock_bh.

void lock_sock_nested(struct sock *sk, int subclass)
{
        /* The sk_lock has mutex_lock() semantics here. */
        mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);

        might_sleep();
        spin_lock_bh(&sk->sk_lock.slock);
        if (sock_owned_by_user_nocheck(sk))
                __lock_sock(sk);
        sk->sk_lock.owned =3D 1;
        spin_unlock_bh(&sk->sk_lock.slock);
}
EXPORT_SYMBOL(lock_sock_nested);

>
> Bob
> >
> >>
> >> Please Jason or experts from netdev comment on this.
> >>
> >> Thanks,
> >>
> >> Zhu Yanjun
> >>
> >>
> >>>> +    rtnl_unlock();
> >>>> +    spin_unlock_bh(&sk->sk_lock.slock);
> >>>> +    if (err && err !=3D -EADDRINUSE)
> >>>> +        goto err_out;
> >>>>          ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> >>>> +    err =3D dev_mc_add(rxe->ndev, ll_addr);
> >>>> +    if (err)
> >>>> +        goto err_drop;
> >>>> +
> >>>> +    return 0;
> >>>>    -    return dev_mc_add(rxe->ndev, ll_addr);
> >>>> +err_drop:
> >>>> +    spin_lock_bh(&sk->sk_lock.slock);
> >>>> +    rtnl_lock();
> >>>> +    ipv6_sock_mc_drop(sk, rxe->ndev->ifindex, addr6);
> >>>> +    rtnl_unlock();
> >>>> +    spin_unlock_bh(&sk->sk_lock.slock);
> >>>> +err_out:
> >>>> +    return err;
> >>>>    }
> >>>>    -/**
> >>>> - * rxe_mcast_del - delete multicast address from rxe device
> >>>> - * @rxe: rxe device object
> >>>> - * @mgid: multicast address as a gid
> >>>> - *
> >>>> - * Returns 0 on success else an error
> >>>> - */
> >>>> -static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>> +static int rxe_mcast_add(struct rxe_mcg *mcg)
> >>>>    {
> >>>> +    struct rxe_dev *rxe =3D mcg->rxe;
> >>>> +    union ib_gid *mgid =3D &mcg->mgid;
> >>>>        unsigned char ll_addr[ETH_ALEN];
> >>>> +    struct ip_mreqn imr =3D {};
> >>>> +    int err;
> >>>> +
> >>>> +    if (mcg->is_ipv6)
> >>>> +        return rxe_mcast_add6(rxe, mgid);
> >>>> +
> >>>> +    imr.imr_multiaddr =3D *(struct in_addr *)(mgid->raw + 12);
> >>>> +    imr.imr_ifindex =3D rxe->ndev->ifindex;
> >>>> +    rtnl_lock();
> >>>> +    err =3D ip_mc_join_group(recv_sockets.sk4->sk, &imr);
> >>>> +    rtnl_unlock();
> >>>> +    if (err && err !=3D -EADDRINUSE)
> >>>> +        goto err_out;
> >>>> +
> >>>> +    ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
> >>>> +    err =3D dev_mc_add(rxe->ndev, ll_addr);
> >>>> +    if (err)
> >>>> +        goto err_leave;
> >>>> +
> >>>> +    return 0;
> >>>> +
> >>>> +err_leave:
> >>>> +    rtnl_lock();
> >>>> +    ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
> >>>> +    rtnl_unlock();
> >>>> +err_out:
> >>>> +    return err;
> >>>> +}
> >>>> +
> >>>> +static int rxe_mcast_del6(struct rxe_dev *rxe, union ib_gid *mgid)
> >>>> +{
> >>>> +    struct sock *sk =3D recv_sockets.sk6->sk;
> >>>> +    unsigned char ll_addr[ETH_ALEN];
> >>>> +    int err, err2;
> >>>>          ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> >>>> +    err =3D dev_mc_del(rxe->ndev, ll_addr);
> >>>> +
> >>>> +    spin_lock_bh(&sk->sk_lock.slock);
> >>>> +    rtnl_lock();
> >>>> +    err2 =3D ipv6_sock_mc_drop(sk, rxe->ndev->ifindex,
> >>>> +            (struct in6_addr *)mgid);
> >>>> +    rtnl_unlock();
> >>>> +    spin_unlock_bh(&sk->sk_lock.slock);
> >>>> +
> >>>> +    return err ?: err2;
> >>>> +}
> >>>> +
> >>>> +static int rxe_mcast_del(struct rxe_mcg *mcg)
> >>>> +{
> >>>> +    struct rxe_dev *rxe =3D mcg->rxe;
> >>>> +    union ib_gid *mgid =3D &mcg->mgid;
> >>>> +    unsigned char ll_addr[ETH_ALEN];
> >>>> +    struct ip_mreqn imr =3D {};
> >>>> +    int err, err2;
> >>>> +
> >>>> +    if (mcg->is_ipv6)
> >>>> +        return rxe_mcast_del6(rxe, mgid);
> >>>> +
> >>>> +    imr.imr_multiaddr =3D *(struct in_addr *)(mgid->raw + 12);
> >>>> +    imr.imr_ifindex =3D rxe->ndev->ifindex;
> >>>> +    ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
> >>>> +    err =3D dev_mc_del(rxe->ndev, ll_addr);
> >>>> +
> >>>> +    rtnl_lock();
> >>>> +    err2 =3D ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
> >>>> +    rtnl_unlock();
> >>>>    -    return dev_mc_del(rxe->ndev, ll_addr);
> >>>> +    return err ?: err2;
> >>>>    }
> >>>>      /**
> >>>> @@ -164,6 +242,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe,
> >>>> union ib_gid *mgid,
> >>>>    {
> >>>>        kref_init(&mcg->ref_cnt);
> >>>>        memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
> >>>> +    mcg->is_ipv6 =3D !ipv6_addr_v4mapped((struct in6_addr *)mgid);
> >>>>        INIT_LIST_HEAD(&mcg->qp_list);
> >>>>        mcg->rxe =3D rxe;
> >>>>    @@ -225,7 +304,7 @@ static struct rxe_mcg *rxe_get_mcg(struct
> >>>> rxe_dev *rxe, union ib_gid *mgid)
> >>>>        spin_unlock_bh(&rxe->mcg_lock);
> >>>>          /* add mcast address outside of lock */
> >>>> -    err =3D rxe_mcast_add(rxe, mgid);
> >>>> +    err =3D rxe_mcast_add(mcg);
> >>>>        if (!err)
> >>>>            return mcg;
> >>>>    @@ -273,7 +352,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg =
*mcg)
> >>>>    static void rxe_destroy_mcg(struct rxe_mcg *mcg)
> >>>>    {
> >>>>        /* delete mcast address outside of lock */
> >>>> -    rxe_mcast_del(mcg->rxe, &mcg->mgid);
> >>>> +    rxe_mcast_del(mcg);
> >>>>          spin_lock_bh(&mcg->rxe->mcg_lock);
> >>>>        __rxe_destroy_mcg(mcg);
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> >>>> b/drivers/infiniband/sw/rxe/rxe_net.c
> >>>> index 58c3f3759bf0..b481f8da2002 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> >>>> @@ -18,7 +18,7 @@
> >>>>    #include "rxe_net.h"
> >>>>    #include "rxe_loc.h"
> >>>>    -static struct rxe_recv_sockets recv_sockets;
> >>>> +struct rxe_recv_sockets recv_sockets;
> >>>>      static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
> >>>>                         struct net_device *ndev,
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h
> >>>> b/drivers/infiniband/sw/rxe/rxe_net.h
> >>>> index 45d80d00f86b..89cee7d5340f 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> >>>> @@ -15,6 +15,7 @@ struct rxe_recv_sockets {
> >>>>        struct socket *sk4;
> >>>>        struct socket *sk6;
> >>>>    };
> >>>> +extern struct rxe_recv_sockets recv_sockets;
> >>>>      int rxe_net_add(const char *ibdev_name, struct net_device *ndev=
);
> >>>>    diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>>> b/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>>> index ccb9d19ffe8a..7be9e6232dd9 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>>> @@ -352,6 +352,7 @@ struct rxe_mcg {
> >>>>        atomic_t        qp_num;
> >>>>        u32            qkey;
> >>>>        u16            pkey;
> >>>> +    bool            is_ipv6;
> >>>>    };
> >>>>      struct rxe_mca {
> >>
>

