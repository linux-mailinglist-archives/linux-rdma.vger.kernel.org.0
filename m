Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D251B270BE4
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISInD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 04:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISInD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 04:43:03 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4029821481;
        Sat, 19 Sep 2020 08:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600504982;
        bh=CQ7lqu5EzbKy+fWKkuQ0Z6DrURANb4TxZUkphG/XIEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuEmq1g4H2HEygDnpaxKQdleOiWKKELoRjbbIgWwI/SJQ1hABzl9wXqBTF1/uHEnn
         VrgYSYNICYE40OO3YgdfG4imJcCFL2DKTT2C624D0DYkDySDK3RWv3nHFJunToidUA
         EOGt4qM54m5FUF2+O+Z9Zrpddno00wGtAbcz+Jwc=
Date:   Sat, 19 Sep 2020 11:42:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 06/14] RDMA/restrack: Improve readability in
 task name management
Message-ID: <20200919084257.GZ869610@unreal>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-7-leon@kernel.org>
 <20200918231721.GA374249@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918231721.GA374249@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 08:17:21PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2020 at 03:21:48PM +0300, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index feed3c04979a..3fc3c821743d 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -467,10 +467,13 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
> >  	id_priv->id.route.addr.dev_addr.transport =
> >  		rdma_node_get_transport(cma_dev->device->node_type);
> >  	list_add_tail(&id_priv->list, &cma_dev->id_list);
> > -	if (id_priv->res.kern_name)
> > -		rdma_restrack_add(&id_priv->res);
> > -	else
> > -		rdma_restrack_uadd(&id_priv->res);
> > +	/*
> > +	 * For example UCMA doesn't set kern_name and below function will
> > +	 * attach to "current" task.
> > +	 */
> > +	rdma_restrack_set_name(&id_priv->res, id_priv->res.kern_name);
> > +	rdma_restrack_add(&id_priv->res);
>
> I don't understand why the set_name was added here, looks wrong. For
> the non-null case we either already have a task set because
> rdma_create_id did it, or this is spawned from a listening_id and this
> is WQ, so no reason to capture a WQ as the task.
>
> I suppose the idea is that the rdma_restrack_set_name() in
> rdma_accept() fixes this, but that isn't allowed either, there is no
> locking so calling rdma_restrack_set_name() after rdma_restrack_add()
> can't be done.
>
> Without adding a bunch of locking someplace I think everything must
> flow from the orignial rdma_cm_listen which was created in a
> reasonable context, ie instead of passing name around the parent
> restrack should be passed.
>
> I came up with something like this
>
> Can you put this and the patches here in a series please, up to this
> patch all looks OK otherwise.

It is better than before and will try it.

Thanks

>
> Jason
>
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index aecc60a5f8c3fe..b123811f33234a 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -457,7 +457,6 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
>  	 * For example UCMA doesn't set kern_name and below function will
>  	 * attach to "current" task.
>  	 */
> -	rdma_restrack_set_name(&id_priv->res, id_priv->res.kern_name);
>  	rdma_restrack_add(&id_priv->res);
>
>  	trace_cm_id_attach(id_priv, cma_dev->device);
> @@ -825,10 +824,10 @@ static void cma_id_put(struct rdma_id_private *id_priv)
>  		complete(&id_priv->comp);
>  }
>
> -struct rdma_cm_id *__rdma_create_id(struct net *net,
> -				    rdma_cm_event_handler event_handler,
> -				    void *context, enum rdma_ucm_port_space ps,
> -				    enum ib_qp_type qp_type, const char *caller)
> +static struct rdma_id_private *
> +__rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
> +		 void *context, enum rdma_ucm_port_space ps,
> +		 enum ib_qp_type qp_type, const struct rdma_id_private *parent)
>  {
>  	struct rdma_id_private *id_priv;
>
> @@ -856,11 +855,44 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
>  	id_priv->seq_num &= 0x00ffffff;
>
>  	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
> -	rdma_restrack_set_name(&id_priv->res, caller);
> +	if (parent)
> +		rdma_restrack_parent_name(&id_priv->res, &parent->res);
>
> -	return &id_priv->id;
> +	return id_priv;
> +}
> +
> +struct rdma_cm_id *
> +__rdma_create_kernel_id(struct net *net, rdma_cm_event_handler event_handler,
> +			void *context, enum rdma_ucm_port_space ps,
> +			enum ib_qp_type qp_type, const char *caller)
> +{
> +	struct rdma_id_private *ret;
> +
> +	ret = __rdma_create_id(net, event_handler, context, ps, qp_type, NULL);
> +	if (IS_ERR(ret))
> +		return ERR_CAST(ret);
> +
> +	rdma_restrack_set_name(&ret->res, caller);
> +	return &ret->id;
> +}
> +EXPORT_SYMBOL(__rdma_create_kernel_id);
> +
> +struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
> +				       void *context,
> +				       enum rdma_ucm_port_space ps,
> +				       enum ib_qp_type qp_type)
> +{
> +	struct rdma_id_private *ret;
> +
> +	ret = __rdma_create_id(current->nsproxy->net_ns, event_handler, context,
> +			       ps, qp_type, NULL);
> +	if (IS_ERR(ret))
> +		return ERR_CAST(ret);
> +
> +	rdma_restrack_set_name(&ret->res, NULL);
> +	return &ret->id;
>  }
> -EXPORT_SYMBOL(__rdma_create_id);
> +EXPORT_SYMBOL(rdma_create_user_id);
>
>  static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
>  {
> @@ -2032,14 +2064,15 @@ cma_ib_new_conn_id(const struct rdma_cm_id *listen_id,
>  	int ret;
>
>  	listen_id_priv = container_of(listen_id, struct rdma_id_private, id);
> -	id = __rdma_create_id(listen_id->route.addr.dev_addr.net,
> -			    listen_id->event_handler, listen_id->context,
> -			    listen_id->ps, ib_event->param.req_rcvd.qp_type,
> -			    listen_id_priv->res.kern_name);
> -	if (IS_ERR(id))
> +	id_priv = __rdma_create_id(listen_id->route.addr.dev_addr.net,
> +				   listen_id->event_handler, listen_id->context,
> +				   listen_id->ps,
> +				   ib_event->param.req_rcvd.qp_type,
> +				   listen_id_priv);
> +	if (IS_ERR(id_priv))
>  		return NULL;
>
> -	id_priv = container_of(id, struct rdma_id_private, id);
> +	id = &id_priv->id;
>  	if (cma_save_net_info((struct sockaddr *)&id->route.addr.src_addr,
>  			      (struct sockaddr *)&id->route.addr.dst_addr,
>  			      listen_id, ib_event, ss_family, service_id))
> @@ -2093,13 +2126,13 @@ cma_ib_new_udp_id(const struct rdma_cm_id *listen_id,
>  	int ret;
>
>  	listen_id_priv = container_of(listen_id, struct rdma_id_private, id);
> -	id = __rdma_create_id(net, listen_id->event_handler, listen_id->context,
> -			      listen_id->ps, IB_QPT_UD,
> -			      listen_id_priv->res.kern_name);
> -	if (IS_ERR(id))
> +	id_priv = __rdma_create_id(net, listen_id->event_handler,
> +				   listen_id->context, listen_id->ps, IB_QPT_UD,
> +				   listen_id_priv);
> +	if (IS_ERR(id_priv))
>  		return NULL;
>
> -	id_priv = container_of(id, struct rdma_id_private, id);
> +	id = &id_priv->id;
>  	if (cma_save_net_info((struct sockaddr *)&id->route.addr.src_addr,
>  			      (struct sockaddr *)&id->route.addr.dst_addr,
>  			      listen_id, ib_event, ss_family,
> @@ -2335,7 +2368,6 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
>  static int iw_conn_req_handler(struct iw_cm_id *cm_id,
>  			       struct iw_cm_event *iw_event)
>  {
> -	struct rdma_cm_id *new_cm_id;
>  	struct rdma_id_private *listen_id, *conn_id;
>  	struct rdma_cm_event event = {};
>  	int ret = -ECONNABORTED;
> @@ -2355,16 +2387,14 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
>  		goto out;
>
>  	/* Create a new RDMA id for the new IW CM ID */
> -	new_cm_id = __rdma_create_id(listen_id->id.route.addr.dev_addr.net,
> -				     listen_id->id.event_handler,
> -				     listen_id->id.context,
> -				     RDMA_PS_TCP, IB_QPT_RC,
> -				     listen_id->res.kern_name);
> -	if (IS_ERR(new_cm_id)) {
> +	conn_id = __rdma_create_id(listen_id->id.route.addr.dev_addr.net,
> +				   listen_id->id.event_handler,
> +				   listen_id->id.context, RDMA_PS_TCP,
> +				   IB_QPT_RC, listen_id);
> +	if (IS_ERR(conn_id)) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	conn_id = container_of(new_cm_id, struct rdma_id_private, id);
>  	mutex_lock_nested(&conn_id->handler_mutex, SINGLE_DEPTH_NESTING);
>  	conn_id->state = RDMA_CM_CONNECT;
>
> @@ -2469,7 +2499,6 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
>  			      struct cma_device *cma_dev)
>  {
>  	struct rdma_id_private *dev_id_priv;
> -	struct rdma_cm_id *id;
>  	struct net *net = id_priv->id.route.addr.dev_addr.net;
>  	int ret;
>
> @@ -2478,13 +2507,12 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
>  	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
>  		return;
>
> -	id = __rdma_create_id(net, cma_listen_handler, id_priv, id_priv->id.ps,
> -			      id_priv->id.qp_type, id_priv->res.kern_name);
> -	if (IS_ERR(id))
> +	dev_id_priv =
> +		__rdma_create_id(net, cma_listen_handler, id_priv,
> +				 id_priv->id.ps, id_priv->id.qp_type, id_priv);
> +	if (IS_ERR(dev_id_priv))
>  		return;
>
> -	dev_id_priv = container_of(id, struct rdma_id_private, id);
> -
>  	dev_id_priv->state = RDMA_CM_ADDR_BOUND;
>  	memcpy(cma_src_addr(dev_id_priv), cma_src_addr(id_priv),
>  	       rdma_addr_size(cma_src_addr(id_priv)));
> @@ -2497,7 +2525,7 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
>  	dev_id_priv->tos_set = id_priv->tos_set;
>  	dev_id_priv->tos = id_priv->tos;
>
> -	ret = rdma_listen(id, id_priv->backlog);
> +	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
>  	if (ret)
>  		dev_warn(&cma_dev->device->dev,
>  			 "RDMA CMA: cma_listen_on_dev, error %d\n", ret);
> @@ -4152,8 +4180,25 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
>  	return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
>  }
>
> -int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> -		  const char *caller)
> +/**
> + * rdma_accept - Called to accept a connection request or response.
> + * @id: Connection identifier associated with the request.
> + * @conn_param: Information needed to establish the connection.  This must be
> + *   provided if accepting a connection request.  If accepting a connection
> + *   response, this parameter must be NULL.
> + *
> + * Typically, this routine is only called by the listener to accept a connection
> + * request.  It must also be called on the active side of a connection if the
> + * user is performing their own QP transitions.
> + *
> + * In the case of error, a reject message is sent to the remote side and the
> + * state of the qp associated with the id is modified to error, such that any
> + * previously posted receive buffers would be flushed.
> + *
> + * This function is for use by kernel ULPs and must be called from under the
> + * handler callback.
> + */
> +int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
>  {
>  	struct rdma_id_private *id_priv =
>  		container_of(id, struct rdma_id_private, id);
> @@ -4161,8 +4206,6 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
>
>  	lockdep_assert_held(&id_priv->handler_mutex);
>
> -	rdma_restrack_set_name(&id_priv->res, caller);
> -
>  	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
>  		return -EINVAL;
>
> @@ -4201,10 +4244,10 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
>  	rdma_reject(id, NULL, 0, IB_CM_REJ_CONSUMER_DEFINED);
>  	return ret;
>  }
> -EXPORT_SYMBOL(__rdma_accept);
> +EXPORT_SYMBOL(rdma_accept);
>
> -int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> -		      const char *caller, struct rdma_ucm_ece *ece)
> +int rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> +		    struct rdma_ucm_ece *ece)
>  {
>  	struct rdma_id_private *id_priv =
>  		container_of(id, struct rdma_id_private, id);
> @@ -4212,9 +4255,9 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
>  	id_priv->ece.vendor_id = ece->vendor_id;
>  	id_priv->ece.attr_mod = ece->attr_mod;
>
> -	return __rdma_accept(id, conn_param, caller);
> +	return rdma_accept(id, conn_param);
>  }
> -EXPORT_SYMBOL(__rdma_accept_ece);
> +EXPORT_SYMBOL(rdma_accept_ece);
>
>  void rdma_lock_handler(struct rdma_cm_id *id)
>  {
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 0c67acf2169d69..4aeeaaed0f17dd 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -189,7 +189,7 @@ EXPORT_SYMBOL(rdma_restrack_set_name);
>   * @parent: parent resource entry
>   */
>  void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
> -			       struct rdma_restrack_entry *parent)
> +			       const struct rdma_restrack_entry *parent)
>  {
>  	if (rdma_is_kernel_res(parent))
>  		dst->kern_name = parent->kern_name;
> diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
> index 49c1d84cca2da4..6a04fc41f73801 100644
> --- a/drivers/infiniband/core/restrack.h
> +++ b/drivers/infiniband/core/restrack.h
> @@ -32,5 +32,5 @@ void rdma_restrack_new(struct rdma_restrack_entry *res,
>  void rdma_restrack_set_name(struct rdma_restrack_entry *res,
>  			    const char *caller);
>  void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
> -			       struct rdma_restrack_entry *parent);
> +			       const struct rdma_restrack_entry *parent);
>  #endif /* _RDMA_CORE_RESTRACK_H_ */
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index a5595bd489b089..2901847a01021a 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -456,8 +456,7 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
>  		return -ENOMEM;
>
>  	ctx->uid = cmd.uid;
> -	cm_id = __rdma_create_id(current->nsproxy->net_ns,
> -				 ucma_event_handler, ctx, cmd.ps, qp_type, NULL);
> +	cm_id = rdma_create_user_id(ucma_event_handler, ctx, cmd.ps, qp_type);
>  	if (IS_ERR(cm_id)) {
>  		ret = PTR_ERR(cm_id);
>  		goto err1;
> @@ -1126,7 +1125,7 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
>  		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
>  		mutex_lock(&ctx->mutex);
>  		rdma_lock_handler(ctx->cm_id);
> -		ret = __rdma_accept_ece(ctx->cm_id, &conn_param, NULL, &ece);
> +		ret = rdma_accept_ece(ctx->cm_id, &conn_param, &ece);
>  		if (!ret) {
>  			/* The uid must be set atomically with the handler */
>  			ctx->uid = cmd.uid;
> @@ -1136,7 +1135,7 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
>  	} else {
>  		mutex_lock(&ctx->mutex);
>  		rdma_lock_handler(ctx->cm_id);
> -		ret = __rdma_accept_ece(ctx->cm_id, NULL, NULL, &ece);
> +		ret = rdma_accept_ece(ctx->cm_id, NULL, &ece);
>  		rdma_unlock_handler(ctx->cm_id);
>  		mutex_unlock(&ctx->mutex);
>  	}
> diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> index c1334c9a7aa858..c672ae1da26bb5 100644
> --- a/include/rdma/rdma_cm.h
> +++ b/include/rdma/rdma_cm.h
> @@ -110,11 +110,14 @@ struct rdma_cm_id {
>  	u8			 port_num;
>  };
>
> -struct rdma_cm_id *__rdma_create_id(struct net *net,
> -				    rdma_cm_event_handler event_handler,
> -				    void *context, enum rdma_ucm_port_space ps,
> -				    enum ib_qp_type qp_type,
> -				    const char *caller);
> +struct rdma_cm_id *
> +__rdma_create_kernel_id(struct net *net, rdma_cm_event_handler event_handler,
> +			void *context, enum rdma_ucm_port_space ps,
> +			enum ib_qp_type qp_type, const char *caller);
> +struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
> +				       void *context,
> +				       enum rdma_ucm_port_space ps,
> +				       enum ib_qp_type qp_type);
>
>  /**
>   * rdma_create_id - Create an RDMA identifier.
> @@ -132,9 +135,9 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
>   * The event handler callback serializes on the id's mutex and is
>   * allowed to sleep.
>   */
> -#define rdma_create_id(net, event_handler, context, ps, qp_type) \
> -	__rdma_create_id((net), (event_handler), (context), (ps), (qp_type), \
> -			 KBUILD_MODNAME)
> +#define rdma_create_id(net, event_handler, context, ps, qp_type)               \
> +	__rdma_create_kernel_id(net, event_handler, context, ps, qp_type,      \
> +				KBUILD_MODNAME)
>
>  /**
>    * rdma_destroy_id - Destroys an RDMA identifier.
> @@ -250,34 +253,12 @@ int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
>   */
>  int rdma_listen(struct rdma_cm_id *id, int backlog);
>
> -int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> -		  const char *caller);
> +int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
>
>  void rdma_lock_handler(struct rdma_cm_id *id);
>  void rdma_unlock_handler(struct rdma_cm_id *id);
> -int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> -		      const char *caller, struct rdma_ucm_ece *ece);
> -
> -/**
> - * rdma_accept - Called to accept a connection request or response.
> - * @id: Connection identifier associated with the request.
> - * @conn_param: Information needed to establish the connection.  This must be
> - *   provided if accepting a connection request.  If accepting a connection
> - *   response, this parameter must be NULL.
> - *
> - * Typically, this routine is only called by the listener to accept a connection
> - * request.  It must also be called on the active side of a connection if the
> - * user is performing their own QP transitions.
> - *
> - * In the case of error, a reject message is sent to the remote side and the
> - * state of the qp associated with the id is modified to error, such that any
> - * previously posted receive buffers would be flushed.
> - *
> - * This function is for use by kernel ULPs and must be called from under the
> - * handler callback.
> - */
> -#define rdma_accept(id, conn_param) \
> -	__rdma_accept((id), (conn_param),  KBUILD_MODNAME)
> +int rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> +		    struct rdma_ucm_ece *ece);
>
>  /**
>   * rdma_notify - Notifies the RDMA CM of an asynchronous event that has
> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> index 10bfed0fcd3262..d3a1cc5be7bcef 100644
> --- a/include/rdma/restrack.h
> +++ b/include/rdma/restrack.h
> @@ -110,7 +110,7 @@ int rdma_restrack_count(struct ib_device *dev,
>   * rdma_is_kernel_res() - check the owner of resource
>   * @res:  resource entry
>   */
> -static inline bool rdma_is_kernel_res(struct rdma_restrack_entry *res)
> +static inline bool rdma_is_kernel_res(const struct rdma_restrack_entry *res)
>  {
>  	return !res->user;
>  }
