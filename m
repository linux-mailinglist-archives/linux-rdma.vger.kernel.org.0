Return-Path: <linux-rdma+bounces-6391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B09EB54E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 16:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34437283F93
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019522080C2;
	Tue, 10 Dec 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mq6LDbTa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07111206296
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845489; cv=none; b=KSb0DDMaog+Oz5E/H2XYJ4fY46IF1wuGBJLhzyBlpF34W4IbTZdnRH52mphmheof+BxxyXlr9grJICK2gE0aQfsqa80wPWkZsR3eL97fPdRbpytc8dHoHpw97wzCi+ZQ08Bgg/Hu/Xhy1X7R9zRTBVaHf+zQkMymCtVqfTdjUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845489; c=relaxed/simple;
	bh=0Qi4vBpbbVjH22ZbyXyDa4bWo1pfWA5pKYV8Gupn/Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGW4DksRccvaeehI50Luq6FFcbg5sPsTLoYu3t1j2e5MGhXYQDEABxZsLdiYMoOj5ucYDztCY+T0XdSjVKqyCLV6PsO4n822vtr8zTRrEgRN/s6OMHtgnkkPdivfPrpbn2Wh+egPN3uHU4hICVMuWu+DcilJNIWvQ2DWUj2C2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mq6LDbTa; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b041177-04a4-4faf-af0a-c71ddcb1153c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733845483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLHcpdlLdfxtYk/AgZuFXaGjG7lDw8ctjmZTbLUoCAk=;
	b=mq6LDbTa0TGTuzmZJrkRYVN/MtwcXlIW65/sDr3QX1gVTME1tCi7OfaKFejcdAcdjXeIYA
	OG5lYJrAaNnwwO0+LyaBlpoGeblTBH26rALzymqyN01IdZ5jGZyvUPul6qww+74wCdMfg7
	Bj3m4fE8tlR9oKcku9u6EU3uz28eer4=
Date: Tue, 10 Dec 2024 16:44:40 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
To: Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com, syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241210130351.406603-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10.12.24 14:03, Bernard Metzler wrote:
> Maintain needed network interface information locally, but
> remove a direct link to net_device which can become stale.
> Accessing a stale net_device link was causing a 'KASAN:
> slab-use-after-free' exception during siw_query_port()
> call.
> 
> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>   drivers/infiniband/sw/siw/siw.h       | 11 +++++++----
>   drivers/infiniband/sw/siw/siw_cm.c    |  4 ++--
>   drivers/infiniband/sw/siw/siw_main.c  | 18 ++++++++++++------
>   drivers/infiniband/sw/siw/siw_verbs.c | 11 ++++++-----
>   4 files changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 86d4d6a2170e..c8f75527b513 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -69,16 +69,19 @@ struct siw_pd {
>   
>   struct siw_device {
>   	struct ib_device base_dev;
> -	struct net_device *netdev;
>   	struct siw_dev_cap attrs;
>   
>   	u32 vendor_part_id;
> +	struct {
> +		int ifindex;
> +		enum ib_port_state state;
> +		enum ib_mtu mtu;
> +		enum ib_mtu max_mtu;
> +	} ifinfo;
> +
>   	int numa_node;
>   	char raw_gid[ETH_ALEN];
>   
> -	/* physical port state (only one port per device) */
> -	enum ib_port_state state;
> -
>   	spinlock_t lock;
>   
>   	struct xarray qp_xa;
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index 86323918a570..451b50d92f7f 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1780,7 +1780,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   
>   		/* For wildcard addr, limit binding to current device only */
>   		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
> -			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
> +			s->sk->sk_bound_dev_if = sdev->ifinfo.ifindex;
>   
>   		rv = s->ops->bind(s, (struct sockaddr *)laddr,
>   				  sizeof(struct sockaddr_in));
> @@ -1798,7 +1798,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   
>   		/* For wildcard addr, limit binding to current device only */
>   		if (ipv6_addr_any(&laddr->sin6_addr))
> -			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
> +			s->sk->sk_bound_dev_if = sdev->ifinfo.ifindex;
>   
>   		rv = s->ops->bind(s, (struct sockaddr *)laddr,
>   				  sizeof(struct sockaddr_in6));
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index 17abef48abcd..4db10bdfb515 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>   		return NULL;
>   
>   	base_dev = &sdev->base_dev;
> -	sdev->netdev = netdev;
>   
>   	if (netdev->addr_len) {
>   		memcpy(sdev->raw_gid, netdev->dev_addr,
> @@ -354,6 +353,10 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>   	atomic_set(&sdev->num_mr, 0);
>   	atomic_set(&sdev->num_pd, 0);
>   
> +	sdev->ifinfo.max_mtu = ib_mtu_int_to_enum(netdev->max_mtu);
> +	sdev->ifinfo.mtu = ib_mtu_int_to_enum(READ_ONCE(netdev->mtu));
> +	sdev->ifinfo.ifindex = netdev->ifindex;
> +
>   	sdev->numa_node = dev_to_node(&netdev->dev);
>   	spin_lock_init(&sdev->lock);
>   
> @@ -381,12 +384,12 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
>   
>   	switch (event) {
>   	case NETDEV_UP:
> -		sdev->state = IB_PORT_ACTIVE;
> +		sdev->ifinfo.state = IB_PORT_ACTIVE;
>   		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
>   		break;
>   
>   	case NETDEV_DOWN:
> -		sdev->state = IB_PORT_DOWN;
> +		sdev->ifinfo.state = IB_PORT_DOWN;
>   		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
>   		break;
>   
> @@ -406,10 +409,13 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
>   	case NETDEV_CHANGEADDR:
>   		siw_port_event(sdev, 1, IB_EVENT_LID_CHANGE);
>   		break;
> +
> +	case NETDEV_CHANGEMTU:
> +		sdev->ifinfo.mtu = ib_mtu_int_to_enum(READ_ONCE(netdev->mtu));
> +		break;
>   	/*
>   	 * Todo: Below netdev events are currently not handled.
>   	 */
> -	case NETDEV_CHANGEMTU:
>   	case NETDEV_CHANGE:
>   		break;
>   
> @@ -444,9 +450,9 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
>   		dev_dbg(&netdev->dev, "siw: new device\n");
>   
>   		if (netif_running(netdev) && netif_carrier_ok(netdev))
> -			sdev->state = IB_PORT_ACTIVE;
> +			sdev->ifinfo.state = IB_PORT_ACTIVE;
>   		else
> -			sdev->state = IB_PORT_DOWN;
> +			sdev->ifinfo.state = IB_PORT_DOWN;
>   
>   		ib_mark_name_assigned_by_user(&sdev->base_dev);
>   		rv = siw_device_register(sdev, basedev_name);
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 986666c19378..3ab9c5170637 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -178,14 +178,15 @@ int siw_query_port(struct ib_device *base_dev, u32 port,
>   
>   	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
>   			 &attr->active_width);
> +
>   	attr->gid_tbl_len = 1;
>   	attr->max_msg_sz = -1;
> -	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> -	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> -	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
> +	attr->max_mtu = sdev->ifinfo.max_mtu;
> +	attr->active_mtu = sdev->ifinfo.mtu;
> +	attr->phys_state = sdev->ifinfo.state == IB_PORT_ACTIVE ?
>   		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
>   	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
> -	attr->state = sdev->state;
> +	attr->state = sdev->ifinfo.state;
>   	/*
>   	 * All zero
>   	 *
> @@ -519,7 +520,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
>   	qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
>   	qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
>   	qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
> -	qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> +	qp_attr->path_mtu = sdev->ifinfo.mtu;

The followings are my fix to this kind of problem 
https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf

It seems that it can also fix this problem.
After I delved into your commit, I wonder what happen if the netdev will 
be handled in the future after xxx_query_port?

Thanks,

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c 
b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5c18f7e342f2..7c73eb9115f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -57,7 +57,7 @@ static int rxe_query_port(struct ib_device *ibdev,

         if (attr->state == IB_PORT_ACTIVE)
                 attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
-       else if (dev_get_flags(rxe->ndev) & IFF_UP)
+       else if (rxe && rxe->ndev && (dev_get_flags(rxe->ndev) & IFF_UP))
                 attr->phys_state = IB_PORT_PHYS_STATE_POLLING;
         else
                 attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;

Zhu Yanjun

>   	qp_attr->max_rd_atomic = qp->attrs.irq_size;
>   	qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
>   


