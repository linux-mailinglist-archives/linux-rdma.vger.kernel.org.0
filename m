Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C8303539
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 06:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbhAZFhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:37:45 -0500
Received: from gentwo.org ([3.19.106.255]:53792 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbhAYNZY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 08:25:24 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id E5EA83F559; Mon, 25 Jan 2021 11:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id E119A3F558;
        Mon, 25 Jan 2021 11:28:57 +0000 (UTC)
Date:   Mon, 25 Jan 2021 11:28:57 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Leon Romanovsky <leon@kernel.org>
cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
Message-ID: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 24 Jan 2021, Leon Romanovsky wrote:

> > Since all SMs out there have had support for sendonly join for years now
> > we could just remove the check entirely. If there is an old grizzly SM out
> > there then it would not process that join request and would return an
> > error.
>
> I have no idea if it possible, if yes, this will be the best solution.

Ok hier ist ein neuer Patch:

From: Christoph Lameter <cl@linux.com>
Subject: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks

When a system receives a REREG event from the SM, then the SM information in
the kernel is marked as invalid and a request is sent to the SM to update
the information. The SM information is invalid in that time period.

However, receiving a REREG also occurs simultaneously in user space
applications that are now trying to rejoin the multicast groups. Some of those
may be sendonly multicast groups which are then failing.

If the SM information is invalid then ib_sa_sendonly_fullmem_support()
returns false. That is wrong because it just means that we do not know
yet if the potentially new SM supports sendonly joins.

Sendonly join was introduced in 2015 and all the Subnet managers have
supported it ever since. So there is no point in checking if a subnet
manager supports it.

Should an old opensm get a request for a sendonly join then the request
will fail. The code that is removed here accomodated that situation
and fell back to a full join.

Falling back to a full join is problematic in itself. The reason to
use the sendonly join was to reduce the traffic on the Infiniband
fabric otherwise one could have just stayed with the regular join.
So this patch may cause users of very old opensms to discover that
lots of traffic needlessly crosses their IB fabrics.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/drivers/infiniband/core/cma.c
===================================================================
--- linux.orig/drivers/infiniband/core/cma.c	2020-12-17 14:51:15.301206041 +0000
+++ linux/drivers/infiniband/core/cma.c	2021-01-25 09:39:29.191032891 +0000
@@ -4542,17 +4542,6 @@ static int cma_join_ib_multicast(struct
 	rec.pkey = cpu_to_be16(ib_addr_get_pkey(dev_addr));
 	rec.join_state = mc->join_state;

-	if ((rec.join_state == BIT(SENDONLY_FULLMEMBER_JOIN)) &&
-	    (!ib_sa_sendonly_fullmem_support(&sa_client,
-					     id_priv->id.device,
-					     id_priv->id.port_num))) {
-		dev_warn(
-			&id_priv->id.device->dev,
-			"RDMA CM: port %u Unable to multicast join: SM doesn't support Send Only Full Member option\n",
-			id_priv->id.port_num);
-		return -EOPNOTSUPP;
-	}
-
 	comp_mask = IB_SA_MCMEMBER_REC_MGID | IB_SA_MCMEMBER_REC_PORT_GID |
 		    IB_SA_MCMEMBER_REC_PKEY | IB_SA_MCMEMBER_REC_JOIN_STATE |
 		    IB_SA_MCMEMBER_REC_QKEY | IB_SA_MCMEMBER_REC_SL |
Index: linux/drivers/infiniband/core/sa_query.c
===================================================================
--- linux.orig/drivers/infiniband/core/sa_query.c	2021-01-25 09:36:56.000000000 +0000
+++ linux/drivers/infiniband/core/sa_query.c	2021-01-25 09:38:09.818795183 +0000
@@ -1951,30 +1951,6 @@ err1:
 }
 EXPORT_SYMBOL(ib_sa_guid_info_rec_query);

-bool ib_sa_sendonly_fullmem_support(struct ib_sa_client *client,
-				    struct ib_device *device,
-				    u8 port_num)
-{
-	struct ib_sa_device *sa_dev = ib_get_client_data(device, &sa_client);
-	struct ib_sa_port *port;
-	bool ret = false;
-	unsigned long flags;
-
-	if (!sa_dev)
-		return ret;
-
-	port  = &sa_dev->port[port_num - sa_dev->start_port];
-
-	spin_lock_irqsave(&port->classport_lock, flags);
-	if ((port->classport_info.valid) &&
-	    (port->classport_info.data.type == RDMA_CLASS_PORT_INFO_IB))
-		ret = ib_get_cpi_capmask2(&port->classport_info.data.ib)
-			& IB_SA_CAP_MASK2_SENDONLY_FULL_MEM_SUPPORT;
-	spin_unlock_irqrestore(&port->classport_lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(ib_sa_sendonly_fullmem_support);
-
 struct ib_classport_info_context {
 	struct completion	done;
 	struct ib_sa_query	*sa_query;
Index: linux/drivers/infiniband/ulp/ipoib/ipoib.h
===================================================================
--- linux.orig/drivers/infiniband/ulp/ipoib/ipoib.h	2020-08-11 13:08:51.122523955 +0000
+++ linux/drivers/infiniband/ulp/ipoib/ipoib.h	2021-01-25 09:42:34.783587162 +0000
@@ -413,7 +413,6 @@ struct ipoib_dev_priv {
 	u64	hca_caps;
 	struct ipoib_ethtool_st ethtool;
 	unsigned int max_send_sge;
-	bool sm_fullmember_sendonly_support;
 	const struct net_device_ops	*rn_ops;
 };

Index: linux/drivers/infiniband/ulp/ipoib/ipoib_main.c
===================================================================
--- linux.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2020-12-17 14:51:15.333206132 +0000
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_main.c	2021-01-25 09:43:03.911673987 +0000
@@ -141,8 +141,6 @@ int ipoib_open(struct net_device *dev)

 	set_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags);

-	priv->sm_fullmember_sendonly_support = false;
-
 	if (ipoib_ib_dev_open(dev)) {
 		if (!test_bit(IPOIB_PKEY_ASSIGNED, &priv->flags))
 			return 0;
Index: linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
===================================================================
--- linux.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2020-08-11 13:08:51.122523955 +0000
+++ linux/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2021-01-25 09:41:24.415377238 +0000
@@ -334,15 +334,6 @@ void ipoib_mcast_carrier_on_task(struct
 		return;
 	}
 	/*
-	 * Check if can send sendonly MCG's with sendonly-fullmember join state.
-	 * It done here after the successfully join to the broadcast group,
-	 * because the broadcast group must always be joined first and is always
-	 * re-joined if the SM changes substantially.
-	 */
-	priv->sm_fullmember_sendonly_support =
-		ib_sa_sendonly_fullmem_support(&ipoib_sa_client,
-					       priv->ca, priv->port);
-	/*
 	 * Take rtnl_lock to avoid racing with ipoib_stop() and
 	 * turning the carrier back on while a device is being
 	 * removed.  However, ipoib_stop() will attempt to flush
@@ -537,9 +528,7 @@ static int ipoib_mcast_join(struct net_d
 		 * most closely emulates the behavior, from a user space
 		 * application perspective, of Ethernet multicast operation.
 		 */
-		if (test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags) &&
-		    priv->sm_fullmember_sendonly_support)
-			/* SM supports sendonly-fullmember, otherwise fallback to full-member */
+		if (test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags))
 			rec.join_state = SENDONLY_FULLMEMBER_JOIN;
 	}
 	spin_unlock_irq(&priv->lock);
