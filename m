Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A1B7E0F69
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Nov 2023 13:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjKDMmr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Nov 2023 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMmr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Nov 2023 08:42:47 -0400
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB983B8
        for <linux-rdma@vger.kernel.org>; Sat,  4 Nov 2023 05:42:43 -0700 (PDT)
Message-ID: <30513a47-68c6-410f-bbfb-09211f07b082@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699101760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDPzoT0+f22TkepfiIFmMVwxbZqnDSkzBJp2NJo45Zg=;
        b=spx78nLqsvGD86emeDvKS8FDptmFxY24E86Zqdt6+K2VKDANxCkis0l+GAVt7OPl9dz5Ss
        POu7B5C5HJi4VAN02iEq8H6FzzvOoZ5wCQNSo6C1TFIz9QRgBTz+xPqUsmwCjYJ4JcPmJp
        TnFida0kIF43S/IGzyTKg+BABN9u12Y=
Date:   Sat, 4 Nov 2023 20:42:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Register IP mcast address
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
 <20231103204324.9606-4-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231103204324.9606-4-rpearsonhpe@gmail.com>
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


在 2023/11/4 4:43, Bob Pearson 写道:
> Add code to rxe_mcast_add() and rxe_mcast_del() to register/deregister
> the IP multicast address. This is required for multicast traffic to
> reach the rxe driver.
>
> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mcast.c | 110 +++++++++++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
>   drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
>   drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
>   4 files changed, 93 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 86cc2e18a7fd..ec757b955979 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -19,38 +19,107 @@
>    * mcast packets in the rxe receive path.
>    */
>   
> +#include <linux/igmp.h>
> +
>   #include "rxe.h"
>   
> -/**
> - * rxe_mcast_add - add multicast address to rxe device
> - * @rxe: rxe device object
> - * @mgid: multicast address as a gid
> - *
> - * Returns 0 on success else an error
> - */
> -static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
> +/* register mcast IP and MAC addresses with net stack */
> +static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
>   {
>   	unsigned char ll_addr[ETH_ALEN];
> +	struct in6_addr *addr6 = (struct in6_addr *)mgid;
> +	int err;


Using reverse fir tree, a.k.a. reverse Christmas tree or reverse XMAS 
tree, for

variable declarations isn't strictly required, though it is still preferred.

Zhu Yanjun


> +
> +	rtnl_lock();
> +	err = ipv6_sock_mc_join(recv_sockets.sk6->sk, rxe->ndev->ifindex,
> +				addr6);
> +	rtnl_unlock();
> +	if (err && err != -EADDRINUSE)
> +		goto err_out;
>   
>   	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> +	err = dev_mc_add(rxe->ndev, ll_addr);
> +	if (err)
> +		goto err_drop;
> +
> +	return 0;
>   
> -	return dev_mc_add(rxe->ndev, ll_addr);
> +err_drop:
> +	ipv6_sock_mc_drop(recv_sockets.sk6->sk, rxe->ndev->ifindex, addr6);
> +err_out:
> +	return err;
>   }
>   
> -/**
> - * rxe_mcast_del - delete multicast address from rxe device
> - * @rxe: rxe device object
> - * @mgid: multicast address as a gid
> - *
> - * Returns 0 on success else an error
> - */
> -static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
> +static int rxe_mcast_add(struct rxe_mcg *mcg)
>   {
> +	struct rxe_dev *rxe = mcg->rxe;
> +	union ib_gid *mgid = &mcg->mgid;
> +	struct ip_mreqn imr = {};
>   	unsigned char ll_addr[ETH_ALEN];
> +	int err;
> +
> +	if (mcg->is_ipv6)
> +		return rxe_mcast_add6(rxe, mgid);
> +
> +	imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
> +	imr.imr_ifindex = rxe->ndev->ifindex;
> +	rtnl_lock();
> +	err = ip_mc_join_group(recv_sockets.sk4->sk, &imr);
> +	rtnl_unlock();
> +	if (err && err != -EADDRINUSE)
> +		goto err_out;
> +
> +	ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
> +	err = dev_mc_add(rxe->ndev, ll_addr);
> +	if (err)
> +		goto err_leave;
> +
> +	return 0;
> +
> +err_leave:
> +	ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
> +err_out:
> +	return err;
> +}
> +
> +/* deregister mcast IP and MAC addresses with net stack */
> +static int rxe_mcast_del6(struct rxe_dev *rxe, union ib_gid *mgid)
> +{
> +	unsigned char ll_addr[ETH_ALEN];
> +	int err, err2;
>   
>   	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> +	err = dev_mc_del(rxe->ndev, ll_addr);
> +
> +	rtnl_lock();
> +	err2 = ipv6_sock_mc_drop(recv_sockets.sk6->sk,
> +			rxe->ndev->ifindex, (struct in6_addr *)mgid);
> +	rtnl_unlock();
> +
> +	return err ?: err2;
> +}
> +
> +static int rxe_mcast_del(struct rxe_mcg *mcg)
> +{
> +	struct rxe_dev *rxe = mcg->rxe;
> +	union ib_gid *mgid = &mcg->mgid;
> +	struct ip_mreqn imr = {};
> +	unsigned char ll_addr[ETH_ALEN];
> +	int err, err2;
> +
> +	if (mcg->is_ipv6)
> +		return rxe_mcast_del6(rxe, mgid);
> +
> +	imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
> +	imr.imr_ifindex = rxe->ndev->ifindex;
> +	ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
> +	err = dev_mc_del(rxe->ndev, ll_addr);
> +
> +	rtnl_lock();
> +	err2 = ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
> +	rtnl_unlock();
>   
> -	return dev_mc_del(rxe->ndev, ll_addr);
> +	return err ?: err2;
>   }
>   
>   /**
> @@ -164,6 +233,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>   {
>   	kref_init(&mcg->ref_cnt);
>   	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
> +	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
>   	INIT_LIST_HEAD(&mcg->qp_list);
>   	mcg->rxe = rxe;
>   
> @@ -225,7 +295,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>   	spin_unlock_bh(&rxe->mcg_lock);
>   
>   	/* add mcast address outside of lock */
> -	err = rxe_mcast_add(rxe, mgid);
> +	err = rxe_mcast_add(mcg);
>   	if (!err)
>   		return mcg;
>   
> @@ -273,7 +343,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
>   static void rxe_destroy_mcg(struct rxe_mcg *mcg)
>   {
>   	/* delete mcast address outside of lock */
> -	rxe_mcast_del(mcg->rxe, &mcg->mgid);
> +	rxe_mcast_del(mcg);
>   
>   	spin_lock_bh(&mcg->rxe->mcg_lock);
>   	__rxe_destroy_mcg(mcg);
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 2fad56fc95e7..36617d07fddf 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -18,7 +18,7 @@
>   #include "rxe_net.h"
>   #include "rxe_loc.h"
>   
> -static struct rxe_recv_sockets recv_sockets;
> +struct rxe_recv_sockets recv_sockets;
>   
>   static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>   					 struct net_device *ndev,
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index 45d80d00f86b..89cee7d5340f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -15,6 +15,7 @@ struct rxe_recv_sockets {
>   	struct socket *sk4;
>   	struct socket *sk6;
>   };
> +extern struct rxe_recv_sockets recv_sockets;
>   
>   int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index ccb9d19ffe8a..7be9e6232dd9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -352,6 +352,7 @@ struct rxe_mcg {
>   	atomic_t		qp_num;
>   	u32			qkey;
>   	u16			pkey;
> +	bool			is_ipv6;
>   };
>   
>   struct rxe_mca {
