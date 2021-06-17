Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3F3AADC8
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFQHkN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 03:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhFQHkM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 03:40:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1D8A613BF;
        Thu, 17 Jun 2021 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623915485;
        bh=XTfpZ4mknpSfGmiQsRsnyn1g9bHN674g17Eg26GA2jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCydjILi/2IM9eO7QsMUegrMTDQizxARKJBfUP2TiNvqD2u+Na5vW9rEAR2e4zg8Z
         jED8Ggk5+jr02Sb77ffbI+uFFlQENP7otNgh5GjVdyP1WgfwFiA94/bWXiBRWA2Q/t
         C4t8Rxa+/WvLJEV5Plh36GB5mtymtsmKvd4oj5/M7gid7NghvZwipbuxlDUnpRT/pU
         tqrrlOllZwPmwPZKbDgjFLm/J0lI8L2aX05/UEartXFLhurhTyR1Csl8Qt0Lq2XWon
         H0MgcjwgREa8XyFD0ijlsY0B+bluHTM1hkd3KlxU1IveYrn88lHW/vtA4hRpsEEdwL
         SBlJ+hnpSn/sQ==
Date:   Thu, 17 Jun 2021 10:38:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <YMr72f1bVgQPPlnv@unreal>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <YMrxDtudALQkYuXP@unreal>
 <E69C3CB3-AE31-4139-816A-11467729ABDC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E69C3CB3-AE31-4139-816A-11467729ABDC@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 06:56:15AM +0000, Haakon Bugge wrote:
> 
> 
> > On 17 Jun 2021, at 08:51, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Jun 16, 2021 at 04:35:53PM +0200, Håkon Bugge wrote:
> >> The struct rdma_id_private contains three bit-fields, tos_set,
> >> timeout_set, and min_rnr_timer_set. These are set by accessor
> >> functions without any synchronization. If two or all accessor
> >> functions are invoked in close proximity in time, there will be
> >> Read-Modify-Write from several contexts to the same variable, and the
> >> result will be intermittent.
> >> 
> >> Replace with a flag variable and inline functions for set and get.
> >> 
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> Signed-off-by: Hans Westgaard Ry<hans.westgaard.ry@oracle.com>
> >> ---
> >> drivers/infiniband/core/cma.c      | 24 +++++++++++-------------
> >> drivers/infiniband/core/cma_priv.h | 28 +++++++++++++++++++++++++---
> >> 2 files changed, 36 insertions(+), 16 deletions(-)
> >> 
> >> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> >> index 2b9ffc2..fe609e7 100644
> >> --- a/drivers/infiniband/core/cma.c
> >> +++ b/drivers/infiniband/core/cma.c
> >> @@ -844,9 +844,7 @@ static void cma_id_put(struct rdma_id_private *id_priv)
> >> 	id_priv->id.event_handler = event_handler;
> >> 	id_priv->id.ps = ps;
> >> 	id_priv->id.qp_type = qp_type;
> >> -	id_priv->tos_set = false;
> >> -	id_priv->timeout_set = false;
> >> -	id_priv->min_rnr_timer_set = false;
> >> +	id_priv->flags = 0;
> > 
> > It is not needed, id_priv is allocated with kzalloc.
> 
> I agree. Did put it in due the foo = false.
> > 
> >> 	id_priv->gid_type = IB_GID_TYPE_IB;
> >> 	spin_lock_init(&id_priv->lock);
> >> 	mutex_init(&id_priv->qp_mutex);
> >> @@ -1134,10 +1132,10 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
> >> 		ret = -ENOSYS;
> >> 	}
> >> 
> >> -	if ((*qp_attr_mask & IB_QP_TIMEOUT) && id_priv->timeout_set)
> >> +	if ((*qp_attr_mask & IB_QP_TIMEOUT) && get_TIMEOUT_SET(id_priv->flags))
> >> 		qp_attr->timeout = id_priv->timeout;
> >> 
> >> -	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && id_priv->min_rnr_timer_set)
> >> +	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && get_MIN_RNR_TIMER_SET(id_priv->flags))
> >> 		qp_attr->min_rnr_timer = id_priv->min_rnr_timer;
> >> 
> >> 	return ret;
> >> @@ -2472,7 +2470,7 @@ static int cma_iw_listen(struct rdma_id_private *id_priv, int backlog)
> >> 		return PTR_ERR(id);
> >> 
> >> 	id->tos = id_priv->tos;
> >> -	id->tos_set = id_priv->tos_set;
> >> +	id->tos_set = get_TOS_SET(id_priv->flags);
> >> 	id->afonly = id_priv->afonly;
> >> 	id_priv->cm_id.iw = id;
> >> 
> >> @@ -2533,7 +2531,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
> >> 	cma_id_get(id_priv);
> >> 	dev_id_priv->internal_id = 1;
> >> 	dev_id_priv->afonly = id_priv->afonly;
> >> -	dev_id_priv->tos_set = id_priv->tos_set;
> >> +	dev_id_priv->flags = id_priv->flags;
> >> 	dev_id_priv->tos = id_priv->tos;
> >> 
> >> 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
> >> @@ -2582,7 +2580,7 @@ void rdma_set_service_type(struct rdma_cm_id *id, int tos)
> >> 
> >> 	id_priv = container_of(id, struct rdma_id_private, id);
> >> 	id_priv->tos = (u8) tos;
> >> -	id_priv->tos_set = true;
> >> +	set_TOS_SET(id_priv->flags);
> >> }
> >> EXPORT_SYMBOL(rdma_set_service_type);
> >> 
> >> @@ -2610,7 +2608,7 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
> >> 
> >> 	id_priv = container_of(id, struct rdma_id_private, id);
> >> 	id_priv->timeout = timeout;
> >> -	id_priv->timeout_set = true;
> >> +	set_TIMEOUT_SET(id_priv->flags);
> >> 
> >> 	return 0;
> >> }
> >> @@ -2647,7 +2645,7 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
> >> 
> >> 	id_priv = container_of(id, struct rdma_id_private, id);
> >> 	id_priv->min_rnr_timer = min_rnr_timer;
> >> -	id_priv->min_rnr_timer_set = true;
> >> +	set_MIN_RNR_TIMER_SET(id_priv->flags);
> >> 
> >> 	return 0;
> >> }
> >> @@ -3033,7 +3031,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
> >> 
> >> 	u8 default_roce_tos = id_priv->cma_dev->default_roce_tos[id_priv->id.port_num -
> >> 					rdma_start_port(id_priv->cma_dev->device)];
> >> -	u8 tos = id_priv->tos_set ? id_priv->tos : default_roce_tos;
> >> +	u8 tos = get_TOS_SET(id_priv->flags) ? id_priv->tos : default_roce_tos;
> >> 
> >> 
> >> 	work = kzalloc(sizeof *work, GFP_KERNEL);
> >> @@ -3081,7 +3079,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
> >> 	 * PacketLifeTime = local ACK timeout/2
> >> 	 * as a reasonable approximation for RoCE networks.
> >> 	 */
> >> -	route->path_rec->packet_life_time = id_priv->timeout_set ?
> >> +	route->path_rec->packet_life_time = get_TIMEOUT_SET(id_priv->flags) ?
> >> 		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
> >> 
> >> 	if (!route->path_rec->mtu) {
> >> @@ -4107,7 +4105,7 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
> >> 		return PTR_ERR(cm_id);
> >> 
> >> 	cm_id->tos = id_priv->tos;
> >> -	cm_id->tos_set = id_priv->tos_set;
> >> +	cm_id->tos_set = get_TOS_SET(id_priv->flags);
> >> 	id_priv->cm_id.iw = cm_id;
> >> 
> >> 	memcpy(&cm_id->local_addr, cma_src_addr(id_priv),
> >> diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
> >> index 5c463da..2c1694f 100644
> >> --- a/drivers/infiniband/core/cma_priv.h
> >> +++ b/drivers/infiniband/core/cma_priv.h
> >> @@ -82,11 +82,9 @@ struct rdma_id_private {
> >> 	u32			qkey;
> >> 	u32			qp_num;
> >> 	u32			options;
> >> +	unsigned long		flags;
> >> 	u8			srq;
> >> 	u8			tos;
> >> -	u8			tos_set:1;
> >> -	u8                      timeout_set:1;
> >> -	u8			min_rnr_timer_set:1;
> >> 	u8			reuseaddr;
> >> 	u8			afonly;
> >> 	u8			timeout;
> >> @@ -127,4 +125,28 @@ int cma_set_default_roce_tos(struct cma_device *dev, u32 port,
> >> 			     u8 default_roce_tos);
> >> struct ib_device *cma_get_ib_dev(struct cma_device *dev);
> >> 
> >> +#define BIT_ACCESS_FUNCTIONS(b)							\
> >> +	static inline void set_##b(unsigned long flags)				\
> >> +	{									\
> >> +		/* set_bit() does not imply a memory barrier */			\
> >> +		smp_mb__before_atomic();					\
> >> +		set_bit(b, &flags);						\
> >> +		/* set_bit() does not imply a memory barrier */			\
> >> +		smp_mb__after_atomic();						\
> >> +	}									\
> >> +	static inline bool get_##b(unsigned long flags)				\
> >> +	{									\
> >> +		return test_bit(b, &flags);					\
> >> +	}
> >> +
> >> +enum cm_id_flag_bits {
> 
> This should be called cm_id_priv_flags_bits.
> 
> >> +	TOS_SET,
> >> +	TIMEOUT_SET,
> >> +	MIN_RNR_TIMER_SET,
> >> +};
> >> +
> >> +BIT_ACCESS_FUNCTIONS(TIMEOUT_SET);
> >> +BIT_ACCESS_FUNCTIONS(TOS_SET);
> >> +BIT_ACCESS_FUNCTIONS(MIN_RNR_TIMER_SET);
> > 
> > I would prefer one function that has same syntax as set_bit() instead of
> > introducing two new that built with macros.
> > 
> > Something like this:
> > static inline set_bit_mb(long nr, unsigned long *flags)
> > {
> >   smp_mb__before_atomic();
> >   set_bit(nr, flags); 
> >   smp_mb__after_atomic();
> > }
> 
> OK. I should also probably move this to cma.c, since it is not used outside cma.c?

Yes, please

> 
> Also, do you want it checkpatch clean? Then I need the /* set_bit() does not imply a memory barrier */ comments.

It is always safer to send checkpatch clean patches. The most important
part is to have W=1 clean patches, our subsystem is one warning away from
being warnings-free one.

> 
> Thanks for you review, Leon.

Thank you for listening :)

> 
> 
> Håkon
> 
> > 
> >> +
> >> #endif /* _CMA_PRIV_H */
> >> -- 
> >> 1.8.3.1
> 
