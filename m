Return-Path: <linux-rdma+bounces-6521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE09F1E93
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Dec 2024 13:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25E416773B
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Dec 2024 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4F191F8C;
	Sat, 14 Dec 2024 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oBsLNTw5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984B42A99
	for <linux-rdma@vger.kernel.org>; Sat, 14 Dec 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179875; cv=none; b=GjXC/QNiAUfe53mwDzTMG+wLIOuUYN11DGJmQsorsap0cRjdYsJkuguK/yLUCJUSPSPlZVjSRVTxXErAsObrq7v9X+nAD5IjlZUfrucHbeeAO2RzG8G399g6dXJ6GtRlZlj3gIpsafAWF5qxNgt998WUGquP66gvh8Bx7isKCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179875; c=relaxed/simple;
	bh=+BI/9YwjsHYcz5FBo1iava+AQoqNWdkmlb9ZxVCdqYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKynrbYcXGKz6VbHtpgB3Z70dI8r84XXdqwxipUFmwAgA6U+LSeykm5Yy+AjWlhYXalfsxpRa93TLUpF9B96+IwL+f5NZHHiQqElz49dLzFomAGGvbXBczPx2jdPNJ9QXDprJSDKvJzi1wLEPS74sK4PWDUUCcy3KwY32GwddPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oBsLNTw5; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <163b6d77-3e26-4789-8e87-50b989701c9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734179870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT4PJE5aW1qtMuGZzrImu+KjL/b4C+0J6PXBqXwUoWA=;
	b=oBsLNTw5XhHF9LO/VM8NlW+Vn9AyQWeI6xjrbNLqpMmZebM54SGvKdG9CPRX6dsvWXapMD
	kJJKjullEjBKfPW0OkC3l8jbTkdHcxQMo6zlJEViaGqWruHOyU2gCWAWFWjz+BruZTOv4Q
	T6VBSiuPkvQ1rvYOPQJxbIeyPVvMF8o=
Date: Sat, 14 Dec 2024 13:37:43 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v2] RDMA/siw: Remove direct link to net_device
To: Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com, syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
References: <20241212151848.564872-1-bmt@zurich.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241212151848.564872-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/12/12 16:18, Bernard Metzler 写道:
> Do not manage a per device direct link to net_device. Rely
> on associated ib_devices net_device management, not doubling
> the effort locally. A badly managed local link to net_device
> was causing a 'KASAN: slab-use-after-free' exception during
> siw_query_port() call.
> 
> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>   drivers/infiniband/sw/siw/siw.h       |  7 +++---
>   drivers/infiniband/sw/siw/siw_cm.c    | 31 +++++++++++++++++++-----
>   drivers/infiniband/sw/siw/siw_main.c  | 15 +-----------
>   drivers/infiniband/sw/siw/siw_verbs.c | 35 ++++++++++++++++++---------
>   4 files changed, 53 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 86d4d6a2170e..ea5eee50dc39 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -46,6 +46,9 @@
>    */
>   #define SIW_IRQ_MAXBURST_SQ_ACTIVE 4
>   
> +/* There is always only a port 1 per siw device */
> +#define SIW_PORT 1
> +
>   struct siw_dev_cap {
>   	int max_qp;
>   	int max_qp_wr;
> @@ -69,16 +72,12 @@ struct siw_pd {
>   
>   struct siw_device {
>   	struct ib_device base_dev;
> -	struct net_device *netdev;
>   	struct siw_dev_cap attrs;
>   
>   	u32 vendor_part_id;
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
> index 86323918a570..b157bd01e70b 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1759,6 +1759,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   {
>   	struct socket *s;
>   	struct siw_cep *cep = NULL;
> +	struct net_device *ndev = NULL;
>   	struct siw_device *sdev = to_siw_dev(id->device);
>   	int addr_family = id->local_addr.ss_family;
>   	int rv = 0;
> @@ -1779,9 +1780,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   		struct sockaddr_in *laddr = &to_sockaddr_in(id->local_addr);
>   
>   		/* For wildcard addr, limit binding to current device only */
> -		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
> -			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
> -
> +		if (ipv4_is_zeronet(laddr->sin_addr.s_addr)) {
> +			ndev = ib_device_get_netdev(id->device, SIW_PORT);
> +			if (ndev) {
> +				s->sk->sk_bound_dev_if = ndev->ifindex;
> +			} else {
> +				rv = -ENODEV;
> +				goto error;
> +			}
> +		}
>   		rv = s->ops->bind(s, (struct sockaddr *)laddr,
>   				  sizeof(struct sockaddr_in));
>   	} else {
> @@ -1797,9 +1804,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   		}
>   
>   		/* For wildcard addr, limit binding to current device only */
> -		if (ipv6_addr_any(&laddr->sin6_addr))
> -			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
> -
> +		if (ipv6_addr_any(&laddr->sin6_addr)) {
> +			ndev = ib_device_get_netdev(id->device, SIW_PORT);
> +			if (ndev) {
> +				s->sk->sk_bound_dev_if = ndev->ifindex;
> +			} else {
> +				rv = -ENODEV;
> +				goto error;
> +			}
> +		}
>   		rv = s->ops->bind(s, (struct sockaddr *)laddr,
>   				  sizeof(struct sockaddr_in6));
>   	}
> @@ -1861,6 +1874,9 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   	list_add_tail(&cep->listenq, (struct list_head *)id->provider_data);
>   	cep->state = SIW_EPSTATE_LISTENING;
>   
> +	if (ndev)
> +		dev_put(ndev);
> +

<...>

>   	siw_dbg(id->device, "Listen at laddr %pISp\n", &id->local_addr);
>   
>   	return 0;
> @@ -1880,6 +1896,9 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>   	}
>   	sock_release(s);
>   
> +	if (ndev)
> +		dev_put(ndev);
> +

dev_put will invoke netdev_put. In netdev_put, dev is checked.
Thus, no need to check ndev before dev_put function?

static inline void netdev_put(struct net_device *dev,
                   netdevice_tracker *tracker)
{
     if (dev) {
         netdev_tracker_free(dev, tracker);
         __dev_put(dev);
     }
}

>   	return rv;
>   }
>   
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index 17abef48abcd..14d3103aee6f 100644
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
> @@ -381,12 +380,10 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
>   
>   	switch (event) {
>   	case NETDEV_UP:
> -		sdev->state = IB_PORT_ACTIVE;
>   		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
>   		break;
>   
>   	case NETDEV_DOWN:
> -		sdev->state = IB_PORT_DOWN;
>   		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
>   		break;
>   
> @@ -407,12 +404,8 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
>   		siw_port_event(sdev, 1, IB_EVENT_LID_CHANGE);
>   		break;
>   	/*
> -	 * Todo: Below netdev events are currently not handled.
> +	 * All other events are not handled
>   	 */
> -	case NETDEV_CHANGEMTU:
> -	case NETDEV_CHANGE:
> -		break;
> -
>   	default:
>   		break;
>   	}
> @@ -442,12 +435,6 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
>   	sdev = siw_device_create(netdev);
>   	if (sdev) {
>   		dev_dbg(&netdev->dev, "siw: new device\n");
> -
> -		if (netif_running(netdev) && netif_carrier_ok(netdev))
> -			sdev->state = IB_PORT_ACTIVE;
> -		else
> -			sdev->state = IB_PORT_DOWN;
> -
>   		ib_mark_name_assigned_by_user(&sdev->base_dev);
>   		rv = siw_device_register(sdev, basedev_name);
>   		if (rv)
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 986666c19378..7ca0297d68a4 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -171,21 +171,29 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
>   int siw_query_port(struct ib_device *base_dev, u32 port,
>   		   struct ib_port_attr *attr)
>   {
> -	struct siw_device *sdev = to_siw_dev(base_dev);
> +	struct net_device *ndev;
>   	int rv;
>   
>   	memset(attr, 0, sizeof(*attr));
>   
>   	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
>   			 &attr->active_width);
> +	if (rv)
> +		return rv;
> +
> +	ndev = ib_device_get_netdev(base_dev, SIW_PORT);
> +	if (!ndev)
> +		return -ENODEV;
> +
>   	attr->gid_tbl_len = 1;
>   	attr->max_msg_sz = -1;
> -	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> -	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> -	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
> +	attr->max_mtu = ib_mtu_int_to_enum(ndev->max_mtu);
> +	attr->active_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
> +	attr->phys_state = (netif_running(ndev) && netif_carrier_ok(ndev)) ?
>   		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
> +	attr->state = attr->phys_state == IB_PORT_PHYS_STATE_LINK_UP ?
> +		IB_PORT_ACTIVE : IB_PORT_DOWN;
>   	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
> -	attr->state = sdev->state;
>   	/*
>   	 * All zero
>   	 *
> @@ -199,6 +207,7 @@ int siw_query_port(struct ib_device *base_dev, u32 port,
>   	 * attr->subnet_timeout = 0;
>   	 * attr->init_type_repy = 0;
>   	 */
> +	dev_put(ndev);
>   	return rv;
>   }
>   
> @@ -505,21 +514,24 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
>   		 int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
>   {
>   	struct siw_qp *qp;
> -	struct siw_device *sdev;
> +	struct net_device *ndev;
>   
> -	if (base_qp && qp_attr && qp_init_attr) {
> +	if (base_qp && qp_attr && qp_init_attr)
>   		qp = to_siw_qp(base_qp);
> -		sdev = to_siw_dev(base_qp->device);
> -	} else {
> +	else
>   		return -EINVAL;
> -	}
> +
> +	ndev = ib_device_get_netdev(base_qp->device, SIW_PORT);
> +	if (!ndev)
> +		return -ENODEV;
> +
>   	qp_attr->qp_state = siw_qp_state_to_ib_qp_state[qp->attrs.state];
>   	qp_attr->cap.max_inline_data = SIW_MAX_INLINE;
>   	qp_attr->cap.max_send_wr = qp->attrs.sq_size;
>   	qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
>   	qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
>   	qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
> -	qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> +	qp_attr->path_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
>   	qp_attr->max_rd_atomic = qp->attrs.irq_size;
>   	qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
>   
> @@ -534,6 +546,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
>   
>   	qp_init_attr->cap = qp_attr->cap;
>   
> +	dev_put(ndev);
>   	return 0;
>   }
>   


