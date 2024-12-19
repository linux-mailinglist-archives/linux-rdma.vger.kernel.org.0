Return-Path: <linux-rdma+bounces-6646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B681F9F7979
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DF516B029
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA643221DB6;
	Thu, 19 Dec 2024 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4PF4eEV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A054727
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603812; cv=none; b=rHMp4MJQ97lgjgjyTDXfE9bqkogSyCkHUGzQHHp0R2a61oDdGYb1ag8ZF/zdWIWvRxBBsLfGTPmquTsxFt+2C4FypuLjVejog7382hC+a/X0SZH+UfAOhtG0ogKsKTSAkQqQVNGxdAKJYDonnrTXYXfKYYAIs0qmhqmK4Ojwp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603812; c=relaxed/simple;
	bh=2YtqgMtLfprAxFVcw/vROtEjmMfIotMyWOhUBIv47C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJG+yMAXRh7PO1cCspTcxsDlkVnFp0+oNIgbjy4tl5svFBaDIov2mYlIGQUDuzbtEDRtZ7ED7LVHCubad1QXJ4rDDwHfE8QC7QDYxHtxUQ7Cwbnf+2A+86oZV9B1cwaa3dVFzcTGQkZIW0Ij7sAwS0eDa40w0ED/XrCeNtKwq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4PF4eEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67368C4CECE;
	Thu, 19 Dec 2024 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734603812;
	bh=2YtqgMtLfprAxFVcw/vROtEjmMfIotMyWOhUBIv47C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4PF4eEVc7vJ7EESG79ZH1Qgx1zDVvdIV+gWy0uBI1YDqzzCwWpsHghnHmhNU8ch/
	 1eo8Wf7KF/GQSaMDPvDBYIMxJradhxUJ9d0tpJUfI5S+4Z3ONS6mK/VJEvs8SM/ADG
	 XWg2EcccTOJZOLQY6JzxRJvT/+6G4tq0nDjHNyjmC15lF0STM8UP88nLEbyybrI8Li
	 7x11r1TQtZeuPf7Ctj1NrtirWkYb3eWxO4J52/oFtgWf9qSFFR+442JAD+IfSFxAZA
	 wMF8/oVNBAelezAvikbcQqjeQWwssEA5uBK9K4IeUQTUGoIqzrvMBHWpmgIAZGlHAr
	 k1/nneWTunRVg==
Date: Thu, 19 Dec 2024 12:23:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH RESEND v2] RDMA/siw: Remove direct link to net_device
Message-ID: <20241219102327.GA82731@unreal>
References: <20241212151848.564872-1-bmt@zurich.ibm.com>
 <163b6d77-3e26-4789-8e87-50b989701c9c@linux.dev>
 <b2a32a23-19b9-4344-9bd8-cc83d657bbeb@linux.dev>
 <BN8PR15MB25132F4B52A7334CBF3AF26E993B2@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR15MB25132F4B52A7334CBF3AF26E993B2@BN8PR15MB2513.namprd15.prod.outlook.com>

On Mon, Dec 16, 2024 at 12:31:18PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > Sent: Sunday, December 15, 2024 6:38 PM
> > To: Bernard Metzler <BMT@zurich.ibm.com>; linux-rdma@vger.kernel.org
> > Cc: jgg@ziepe.ca; leon@kernel.org; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com;
> > zyjzyj2000@gmail.com; syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> > Subject: [EXTERNAL] Re: [PATCH RESEND v2] RDMA/siw: Remove direct link to
> > net_device
> > 
> > 
> > 
> > 在 2024/12/14 13:37, Zhu Yanjun 写道:
> > > 在 2024/12/12 16:18, Bernard Metzler 写道:
> > >> Do not manage a per device direct link to net_device. Rely
> > >> on associated ib_devices net_device management, not doubling
> > >> the effort locally. A badly managed local link to net_device
> > >> was causing a 'KASAN: slab-use-after-free' exception during
> > >> siw_query_port() call.
> > >>
> > >> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> > >> Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> > >> Link: https% 
> > 3A__syzkaller.appspot.com_bug-3Fextid-
> > 3D4b87489410b4efd181bf&d=DwIDaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbh
> > vovE4tYSbqxyOwdSiLedP4yO55g&m=Sr4DcK0Wb4iQYxeAGdwnJVj231gGpXbdjE0vjQXbpMgNG
> > MrUQnjp4I9ZuzuThnlu&s=JMDawq7uiJd4vTvguvjXj0pC2okvGwSJ-mB05JlZJX4&e=
> > >> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> > >> ---
> > >>   drivers/infiniband/sw/siw/siw.h       |  7 +++---
> > >>   drivers/infiniband/sw/siw/siw_cm.c    | 31 +++++++++++++++++++-----
> > >>   drivers/infiniband/sw/siw/siw_main.c  | 15 +-----------
> > >>   drivers/infiniband/sw/siw/siw_verbs.c | 35 ++++++++++++++++++---------
> > >>   4 files changed, 53 insertions(+), 35 deletions(-)
> > >>
> > >> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/
> > >> siw/siw.h
> > >> index 86d4d6a2170e..ea5eee50dc39 100644
> > >> --- a/drivers/infiniband/sw/siw/siw.h
> > >> +++ b/drivers/infiniband/sw/siw/siw.h
> > >> @@ -46,6 +46,9 @@
> > >>    */
> > >>   #define SIW_IRQ_MAXBURST_SQ_ACTIVE 4
> > >> +/* There is always only a port 1 per siw device */
> > >> +#define SIW_PORT 1
> > >> +
> > >>   struct siw_dev_cap {
> > >>       int max_qp;
> > >>       int max_qp_wr;
> > >> @@ -69,16 +72,12 @@ struct siw_pd {
> > >>   struct siw_device {
> > >>       struct ib_device base_dev;
> > >> -    struct net_device *netdev;
> > >>       struct siw_dev_cap attrs;
> > >>       u32 vendor_part_id;
> > >>       int numa_node;
> > >>       char raw_gid[ETH_ALEN];
> > >> -    /* physical port state (only one port per device) */
> > >> -    enum ib_port_state state;
> > >> -
> > >>       spinlock_t lock;
> > >>       struct xarray qp_xa;
> > >> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/
> > >> sw/siw/siw_cm.c
> > >> index 86323918a570..b157bd01e70b 100644
> > >> --- a/drivers/infiniband/sw/siw/siw_cm.c
> > >> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> > >> @@ -1759,6 +1759,7 @@ int siw_create_listen(struct iw_cm_id *id, int
> > >> backlog)
> > >>   {
> > >>       struct socket *s;
> > >>       struct siw_cep *cep = NULL;
> > >> +    struct net_device *ndev = NULL;
> > >>       struct siw_device *sdev = to_siw_dev(id->device);
> > >>       int addr_family = id->local_addr.ss_family;
> > >>       int rv = 0;
> > >> @@ -1779,9 +1780,15 @@ int siw_create_listen(struct iw_cm_id *id, int
> > >> backlog)
> > >>           struct sockaddr_in *laddr = &to_sockaddr_in(id->local_addr);
> > >>           /* For wildcard addr, limit binding to current device only */
> > >> -        if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
> > >> -            s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
> > >> -
> > >> +        if (ipv4_is_zeronet(laddr->sin_addr.s_addr)) {
> > >> +            ndev = ib_device_get_netdev(id->device, SIW_PORT);
> > >> +            if (ndev) {
> > >> +                s->sk->sk_bound_dev_if = ndev->ifindex;
> > >> +            } else {
> > >> +                rv = -ENODEV;
> > >> +                goto error;
> > >> +            }
> > >> +        }
> > >>           rv = s->ops->bind(s, (struct sockaddr *)laddr,
> > >>                     sizeof(struct sockaddr_in));
> > >>       } else {
> > >> @@ -1797,9 +1804,15 @@ int siw_create_listen(struct iw_cm_id *id, int
> > >> backlog)
> > >>           }
> > >>           /* For wildcard addr, limit binding to current device only */
> > >> -        if (ipv6_addr_any(&laddr->sin6_addr))
> > >> -            s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
> > >> -
> > >> +        if (ipv6_addr_any(&laddr->sin6_addr)) {
> > >> +            ndev = ib_device_get_netdev(id->device, SIW_PORT);
> > >> +            if (ndev) {
> > >> +                s->sk->sk_bound_dev_if = ndev->ifindex;
> > >> +            } else {
> > >> +                rv = -ENODEV;
> > >> +                goto error;
> > >> +            }
> > >> +        }
> > >>           rv = s->ops->bind(s, (struct sockaddr *)laddr,
> > >>                     sizeof(struct sockaddr_in6));
> > >>       }
> > >> @@ -1861,6 +1874,9 @@ int siw_create_listen(struct iw_cm_id *id, int
> > >> backlog)
> > >>       list_add_tail(&cep->listenq, (struct list_head *)id-
> > >> >provider_data);
> > >>       cep->state = SIW_EPSTATE_LISTENING;
> > >> +    if (ndev)
> > >> +        dev_put(ndev);
> > >> +
> > >
> > > <...>
> > >
> > >>       siw_dbg(id->device, "Listen at laddr %pISp\n", &id->local_addr);
> > >>       return 0;
> > >> @@ -1880,6 +1896,9 @@ int siw_create_listen(struct iw_cm_id *id, int
> > >> backlog)
> > >>       }
> > >>       sock_release(s);
> > >> +    if (ndev)
> > >> +        dev_put(ndev);
> > >> +
> > >
> > > dev_put will invoke netdev_put. In netdev_put, dev is checked.
> > > Thus, no need to check ndev before dev_put function?
> > 
> 
> Thanks for the review.
> 
> Sending this to RDMA only for now. Since kernel 5.10,
> this NULL check has been introduced. siw is in Linux
> since 5.4. Shall I care about back porting,
> or just follow Zhu's recommendation with a corrected
> resend?

We prefer do not make backporter's life harder without reasons,
so I don't like patches which add churn just for the sake of churn.

However new added and/or fixed code should follow up-to-the date
kernel coding standards and practices.

I fixed it locally, no need to resend.

Thanks

> 
> Thanks,
> Bernard.
> 
> 
> > Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > Zhu Yanjun
> > 
> > >
> > > static inline void netdev_put(struct net_device *dev,
> > >                    netdevice_tracker *tracker)
> > > {
> > >      if (dev) {
> > >          netdev_tracker_free(dev, tracker);
> > >          __dev_put(dev);
> > >      }
> > > }
> > >
> > >>       return rv;
> > >>   }
> > >> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/
> > >> infiniband/sw/siw/siw_main.c
> > >> index 17abef48abcd..14d3103aee6f 100644
> > >> --- a/drivers/infiniband/sw/siw/siw_main.c
> > >> +++ b/drivers/infiniband/sw/siw/siw_main.c
> > >> @@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct
> > >> net_device *netdev)
> > >>           return NULL;
> > >>       base_dev = &sdev->base_dev;
> > >> -    sdev->netdev = netdev;
> > >>       if (netdev->addr_len) {
> > >>           memcpy(sdev->raw_gid, netdev->dev_addr,
> > >> @@ -381,12 +380,10 @@ static int siw_netdev_event(struct
> > >> notifier_block *nb, unsigned long event,
> > >>       switch (event) {
> > >>       case NETDEV_UP:
> > >> -        sdev->state = IB_PORT_ACTIVE;
> > >>           siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
> > >>           break;
> > >>       case NETDEV_DOWN:
> > >> -        sdev->state = IB_PORT_DOWN;
> > >>           siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
> > >>           break;
> > >> @@ -407,12 +404,8 @@ static int siw_netdev_event(struct notifier_block
> > >> *nb, unsigned long event,
> > >>           siw_port_event(sdev, 1, IB_EVENT_LID_CHANGE);
> > >>           break;
> > >>       /*
> > >> -     * Todo: Below netdev events are currently not handled.
> > >> +     * All other events are not handled
> > >>        */
> > >> -    case NETDEV_CHANGEMTU:
> > >> -    case NETDEV_CHANGE:
> > >> -        break;
> > >> -
> > >>       default:
> > >>           break;
> > >>       }
> > >> @@ -442,12 +435,6 @@ static int siw_newlink(const char *basedev_name,
> > >> struct net_device *netdev)
> > >>       sdev = siw_device_create(netdev);
> > >>       if (sdev) {
> > >>           dev_dbg(&netdev->dev, "siw: new device\n");
> > >> -
> > >> -        if (netif_running(netdev) && netif_carrier_ok(netdev))
> > >> -            sdev->state = IB_PORT_ACTIVE;
> > >> -        else
> > >> -            sdev->state = IB_PORT_DOWN;
> > >> -
> > >>           ib_mark_name_assigned_by_user(&sdev->base_dev);
> > >>           rv = siw_device_register(sdev, basedev_name);
> > >>           if (rv)
> > >> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/
> > >> infiniband/sw/siw/siw_verbs.c
> > >> index 986666c19378..7ca0297d68a4 100644
> > >> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> > >> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> > >> @@ -171,21 +171,29 @@ int siw_query_device(struct ib_device *base_dev,
> > >> struct ib_device_attr *attr,
> > >>   int siw_query_port(struct ib_device *base_dev, u32 port,
> > >>              struct ib_port_attr *attr)
> > >>   {
> > >> -    struct siw_device *sdev = to_siw_dev(base_dev);
> > >> +    struct net_device *ndev;
> > >>       int rv;
> > >>       memset(attr, 0, sizeof(*attr));
> > >>       rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
> > >>                &attr->active_width);
> > >> +    if (rv)
> > >> +        return rv;
> > >> +
> > >> +    ndev = ib_device_get_netdev(base_dev, SIW_PORT);
> > >> +    if (!ndev)
> > >> +        return -ENODEV;
> > >> +
> > >>       attr->gid_tbl_len = 1;
> > >>       attr->max_msg_sz = -1;
> > >> -    attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> > >> -    attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> > >> -    attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
> > >> +    attr->max_mtu = ib_mtu_int_to_enum(ndev->max_mtu);
> > >> +    attr->active_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
> > >> +    attr->phys_state = (netif_running(ndev) && netif_carrier_ok(ndev))
> > ?
> > >>           IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
> > >> +    attr->state = attr->phys_state == IB_PORT_PHYS_STATE_LINK_UP ?
> > >> +        IB_PORT_ACTIVE : IB_PORT_DOWN;
> > >>       attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
> > >> -    attr->state = sdev->state;
> > >>       /*
> > >>        * All zero
> > >>        *
> > >> @@ -199,6 +207,7 @@ int siw_query_port(struct ib_device *base_dev, u32
> > >> port,
> > >>        * attr->subnet_timeout = 0;
> > >>        * attr->init_type_repy = 0;
> > >>        */
> > >> +    dev_put(ndev);
> > >>       return rv;
> > >>   }
> > >> @@ -505,21 +514,24 @@ int siw_query_qp(struct ib_qp *base_qp, struct
> > >> ib_qp_attr *qp_attr,
> > >>            int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
> > >>   {
> > >>       struct siw_qp *qp;
> > >> -    struct siw_device *sdev;
> > >> +    struct net_device *ndev;
> > >> -    if (base_qp && qp_attr && qp_init_attr) {
> > >> +    if (base_qp && qp_attr && qp_init_attr)
> > >>           qp = to_siw_qp(base_qp);
> > >> -        sdev = to_siw_dev(base_qp->device);
> > >> -    } else {
> > >> +    else
> > >>           return -EINVAL;
> > >> -    }
> > >> +
> > >> +    ndev = ib_device_get_netdev(base_qp->device, SIW_PORT);
> > >> +    if (!ndev)
> > >> +        return -ENODEV;
> > >> +
> > >>       qp_attr->qp_state = siw_qp_state_to_ib_qp_state[qp->attrs.state];
> > >>       qp_attr->cap.max_inline_data = SIW_MAX_INLINE;
> > >>       qp_attr->cap.max_send_wr = qp->attrs.sq_size;
> > >>       qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
> > >>       qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
> > >>       qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
> > >> -    qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
> > >> +    qp_attr->path_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
> > >>       qp_attr->max_rd_atomic = qp->attrs.irq_size;
> > >>       qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
> > >> @@ -534,6 +546,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct
> > >> ib_qp_attr *qp_attr,
> > >>       qp_init_attr->cap = qp_attr->cap;
> > >> +    dev_put(ndev);
> > >>       return 0;
> > >>   }
> > >
> > 
> > --
> > Best Regards,
> > Yanjun.Zhu
> 

