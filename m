Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A883078EA
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 16:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhA1O7h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 09:59:37 -0500
Received: from gentwo.org ([3.19.106.255]:44600 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhA1O6z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Jan 2021 09:58:55 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 305593F4C1; Thu, 28 Jan 2021 14:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 2DD953F461;
        Thu, 28 Jan 2021 14:58:01 +0000 (UTC)
Date:   Thu, 28 Jan 2021 14:58:01 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Jason Gunthorpe <jgg@nvidia.com>
cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
In-Reply-To: <20210128144435.GG4247@nvidia.com>
Message-ID: <alpine.DEB.2.22.394.2101281453230.11029@www.lameter.com>
References: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com> <20210128140335.GA13699@nvidia.com> <alpine.DEB.2.22.394.2101281433270.10563@www.lameter.com> <20210128144435.GG4247@nvidia.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 28 Jan 2021, Jason Gunthorpe wrote:

> > Well it was quilt ...... Do I need to put it into a git tree somewhere?
>
> If you are doing this a lot get a quilt that can generate git diff
> format output.
>
> https://lists.gnu.org/archive/html/quilt-dev/2015-06/msg00002.html

Sadly that patch was never merged.

Will this do it?


commit 64e734c38f509d591073fc1e1db3caa42be3b874
Author: Christoph Lameter <cl@linux.com>
Date:   Thu Jan 28 14:55:36 2021 +0000

    Fix: Remove racy Subnet Manager sendonly join checks

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

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c51b84b2d2f3..58ee7004c8d8 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4542,17 +4542,6 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
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
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 89a831fa1885..921b097d6035 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1951,30 +1951,6 @@ int ib_sa_guid_info_rec_query(struct ib_sa_client *client,
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
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 3440dc48d02c..179ff1d068e5 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -413,7 +413,6 @@ struct ipoib_dev_priv {
 	u64	hca_caps;
 	struct ipoib_ethtool_st ethtool;
 	unsigned int max_send_sge;
-	bool sm_fullmember_sendonly_support;
 	const struct net_device_ops	*rn_ops;
 };

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index a6f413491321..e16b40c09f82 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -141,8 +141,6 @@ int ipoib_open(struct net_device *dev)

 	set_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags);

-	priv->sm_fullmember_sendonly_support = false;
-
 	if (ipoib_ib_dev_open(dev)) {
 		if (!test_bit(IPOIB_PKEY_ASSIGNED, &priv->flags))
 			return 0;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 86e4ed64e4e2..0a444ed11818 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -333,15 +333,6 @@ void ipoib_mcast_carrier_on_task(struct work_struct *work)
 		ipoib_dbg(priv, "Keeping carrier off until IB port is active\n");
 		return;
 	}
-	/*
-	 * Check if can send sendonly MCG's with sendonly-fullmember join state.
-	 * It done here after the successfully join to the broadcast group,
-	 * because the broadcast group must always be joined first and is always
-	 * re-joined if the SM changes substantially.
-	 */
-	priv->sm_fullmember_sendonly_support =
-		ib_sa_sendonly_fullmem_support(&ipoib_sa_client,
-					       priv->ca, priv->port);
 	/*
 	 * Take rtnl_lock to avoid racing with ipoib_stop() and
 	 * turning the carrier back on while a device is being
@@ -537,9 +528,7 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
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
