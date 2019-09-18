Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA21B624F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIRLg0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 07:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfIRLg0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Sep 2019 07:36:26 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D9721907;
        Wed, 18 Sep 2019 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568806584;
        bh=9eUbzJGeeW3QcBlQjvakfVAr5/IIkA+qsCftMzHfyYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ku3rLil+YeQnnm9Vh6wKsWq2qYISdpi7/BROZuVTXNWjvOg0fbzZpVSv9PAl5dcwT
         7qHRvlG5zvFDKqz4DPINaiA/jf0TrXKQnRbly1UrjXgmjsUe45QKuDJ79lL9Wle4wA
         b3e23hqxd9MSzxXTu/txNU6WWqqIkwUw/Y/WN/Fo=
Date:   Wed, 18 Sep 2019 14:36:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Message-ID: <20190918113621.GA14368@unreal>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-2-leon@kernel.org>
 <20190916184544.GG2585@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916184544.GG2585@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 06:45:48PM +0000, Jason Gunthorpe wrote:
> On Mon, Sep 16, 2019 at 10:11:51AM +0300, Leon Romanovsky wrote:
> > From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> >
> > In the process of moving the debug counters sysfs entries, the commit
> > mentioned below eliminated the cm_infiniband sysfs directory.
> >
> > This sysfs directory was tied to the cm_port object allocated in procedure
> > cm_add_one().
> >
> > Before the commit below, this cm_port object was freed via a call to
> > kobject_put(port->kobj) in procedure cm_remove_port_fs().
> >
> > Since port no longer uses its kobj, kobject_put(port->kobj) was eliminated.
> > This, however, meant that kfree was never called for the cm_port buffers.
> >
> > Fix this by adding explicit kfree(port) calls to functions cm_add_one()
> > and cm_remove_one().
> >
> > Note: the kfree call in the first chunk below (in the cm_add_one error
> > flow) fixes an old, undetected memory leak.
> >
> > Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant IB device")
> > Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > index da10e6ccb43c..5920c0085d35 100644
> > +++ b/drivers/infiniband/core/cm.c
> > @@ -4399,6 +4399,7 @@ static void cm_add_one(struct ib_device *ib_device)
> >  error1:
> >  	port_modify.set_port_cap_mask = 0;
> >  	port_modify.clr_port_cap_mask = IB_PORT_CM_SUP;
> > +	kfree(port);
> >  	while (--i) {
> >  		if (!rdma_cap_ib_cm(ib_device, i))
> >  			continue;
> > @@ -4407,6 +4408,7 @@ static void cm_add_one(struct ib_device *ib_device)
> >  		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
> >  		ib_unregister_mad_agent(port->mad_agent);
> >  		cm_remove_port_fs(port);
> > +		kfree(port);
> >  	}
> >  free:
> >  	kfree(cm_dev);
> > @@ -4460,6 +4462,7 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
> >  		spin_unlock_irq(&cm.state_lock);
> >  		ib_unregister_mad_agent(cur_mad_agent);
> >  		cm_remove_port_fs(port);
> > +		kfree(port);
> >  	}
>
> This whole thing is looking pretty goofy now, and I suspect there are
> more error unwind bugs here.
>
> How about this instead:

It looks OK to me.

Thanks

>
> From e8dad20c7b69436e63b18f16cd9457ea27da5bc1 Mon Sep 17 00:00:00 2001
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Date: Mon, 16 Sep 2019 10:11:51 +0300
> Subject: [PATCH] RDMA/cm: Fix memory leak in cm_add/remove_one
>
> In the process of moving the debug counters sysfs entries, the commit
> mentioned below eliminated the cm_infiniband sysfs directory, and created
> some missing cases where the port pointers were not being freed as the
> kobject_put was also eliminated.
>
> Rework this to not allocate port pointers and consolidate all the error
> unwind into one sequence.
>
> This also fixes unlikely racey bugs where error-unwind after unregistering
> the MAD handler would miss flushing the WQ and other clean up that is
> necessary once concurrency starts.
>
> Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant IB device")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 187 ++++++++++++++++++-----------------
>  1 file changed, 94 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index da10e6ccb43cd0..30a764e763dec1 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -223,7 +223,7 @@ struct cm_device {
>  	struct ib_device *ib_device;
>  	u8 ack_delay;
>  	int going_down;
> -	struct cm_port *port[0];
> +	struct cm_port port[];
>  };
>
>  struct cm_av {
> @@ -520,7 +520,7 @@ get_cm_port_from_path(struct sa_path_rec *path, const struct ib_gid_attr *attr)
>  		read_lock_irqsave(&cm.device_lock, flags);
>  		list_for_each_entry(cm_dev, &cm.device_list, list) {
>  			if (cm_dev->ib_device == attr->device) {
> -				port = cm_dev->port[attr->port_num - 1];
> +				port = &cm_dev->port[attr->port_num - 1];
>  				break;
>  			}
>  		}
> @@ -539,7 +539,7 @@ get_cm_port_from_path(struct sa_path_rec *path, const struct ib_gid_attr *attr)
>  					     sa_conv_pathrec_to_gid_type(path),
>  					     NULL);
>  			if (!IS_ERR(attr)) {
> -				port = cm_dev->port[attr->port_num - 1];
> +				port = &cm_dev->port[attr->port_num - 1];
>  				break;
>  			}
>  		}
> @@ -4319,23 +4319,99 @@ static void cm_remove_port_fs(struct cm_port *port)
>
>  }
>
> -static void cm_add_one(struct ib_device *ib_device)
> +static void cm_destroy_one_port(struct cm_device *cm_dev, unsigned int port_num)
>  {
> -	struct cm_device *cm_dev;
> -	struct cm_port *port;
> +	struct cm_port *port = &cm_dev->port[port_num - 1];
> +	struct ib_port_modify port_modify = {
> +		.clr_port_cap_mask = IB_PORT_CM_SUP
> +	};
> +	struct ib_mad_agent *cur_mad_agent;
> +	struct cm_id_private *cm_id_priv;
> +
> +	if (!rdma_cap_ib_cm(cm_dev->ib_device, port_num))
> +		return;
> +
> +	ib_modify_port(cm_dev->ib_device, port_num, 0, &port_modify);
> +
> +	/* Mark all the cm_id's as not valid */
> +	spin_lock_irq(&cm.lock);
> +	list_for_each_entry (cm_id_priv, &port->cm_priv_altr_list, altr_list)
> +		cm_id_priv->altr_send_port_not_ready = 1;
> +	list_for_each_entry (cm_id_priv, &port->cm_priv_prim_list, prim_list)
> +		cm_id_priv->prim_send_port_not_ready = 1;
> +	spin_unlock_irq(&cm.lock);
> +
> +	/*
> +	 * We flush the queue here after the going_down set, this verifies
> +	 * that no new works will be queued in the recv handler, after that we
> +	 * can call the unregister_mad_agent
> +	 */
> +	flush_workqueue(cm.wq);
> +
> +	spin_lock_irq(&cm.state_lock);
> +	cur_mad_agent = port->mad_agent;
> +	port->mad_agent = NULL;
> +	spin_unlock_irq(&cm.state_lock);
> +
> +	if (cur_mad_agent)
> +		ib_unregister_mad_agent(cur_mad_agent);
> +
> +	cm_remove_port_fs(port);
> +}
> +
> +static int cm_init_one_port(struct cm_device *cm_dev, unsigned int port_num)
> +{
> +	struct cm_port *port = &cm_dev->port[port_num - 1];
>  	struct ib_mad_reg_req reg_req = {
>  		.mgmt_class = IB_MGMT_CLASS_CM,
>  		.mgmt_class_version = IB_CM_CLASS_VERSION,
>  	};
>  	struct ib_port_modify port_modify = {
> -		.set_port_cap_mask = IB_PORT_CM_SUP
> +		.set_port_cap_mask = IB_PORT_CM_SUP,
>  	};
> -	unsigned long flags;
>  	int ret;
> +
> +	if (!rdma_cap_ib_cm(cm_dev->ib_device, port_num))
> +		return 0;
> +
> +	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
> +
> +	port->cm_dev = cm_dev;
> +	port->port_num = port_num;
> +
> +	INIT_LIST_HEAD(&port->cm_priv_prim_list);
> +	INIT_LIST_HEAD(&port->cm_priv_altr_list);
> +
> +	ret = cm_create_port_fs(port);
> +	if (ret)
> +		return ret;
> +
> +	port->mad_agent =
> +		ib_register_mad_agent(cm_dev->ib_device, port_num, IB_QPT_GSI,
> +				      &reg_req, 0, cm_send_handler,
> +				      cm_recv_handler, port, 0);
> +	if (IS_ERR(port->mad_agent)) {
> +		cm_destroy_one_port(cm_dev, port_num);
> +		return PTR_ERR(port->mad_agent);
> +	}
> +
> +	ret = ib_modify_port(cm_dev->ib_device, port_num, 0, &port_modify);
> +	if (ret) {
> +		cm_destroy_one_port(cm_dev, port_num);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cm_add_one(struct ib_device *ib_device)
> +{
> +	struct cm_device *cm_dev;
> +	unsigned long flags;
>  	int count = 0;
>  	u8 i;
>
> -	cm_dev = kzalloc(struct_size(cm_dev, port, ib_device->phys_port_cnt),
> +	cm_dev = kvzalloc(struct_size(cm_dev, port, ib_device->phys_port_cnt),
>  			 GFP_KERNEL);
>  	if (!cm_dev)
>  		return;
> @@ -4344,41 +4420,9 @@ static void cm_add_one(struct ib_device *ib_device)
>  	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
>  	cm_dev->going_down = 0;
>
> -	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
>  	for (i = 1; i <= ib_device->phys_port_cnt; i++) {
> -		if (!rdma_cap_ib_cm(ib_device, i))
> -			continue;
> -
> -		port = kzalloc(sizeof *port, GFP_KERNEL);
> -		if (!port)
> -			goto error1;
> -
> -		cm_dev->port[i-1] = port;
> -		port->cm_dev = cm_dev;
> -		port->port_num = i;
> -
> -		INIT_LIST_HEAD(&port->cm_priv_prim_list);
> -		INIT_LIST_HEAD(&port->cm_priv_altr_list);
> -
> -		ret = cm_create_port_fs(port);
> -		if (ret)
> -			goto error1;
> -
> -		port->mad_agent = ib_register_mad_agent(ib_device, i,
> -							IB_QPT_GSI,
> -							&reg_req,
> -							0,
> -							cm_send_handler,
> -							cm_recv_handler,
> -							port,
> -							0);
> -		if (IS_ERR(port->mad_agent))
> -			goto error2;
> -
> -		ret = ib_modify_port(ib_device, i, 0, &port_modify);
> -		if (ret)
> -			goto error3;
> -
> +		if (!cm_init_one_port(cm_dev, i))
> +			goto error;
>  		count++;
>  	}
>
> @@ -4392,35 +4436,16 @@ static void cm_add_one(struct ib_device *ib_device)
>  	write_unlock_irqrestore(&cm.device_lock, flags);
>  	return;
>
> -error3:
> -	ib_unregister_mad_agent(port->mad_agent);
> -error2:
> -	cm_remove_port_fs(port);
> -error1:
> -	port_modify.set_port_cap_mask = 0;
> -	port_modify.clr_port_cap_mask = IB_PORT_CM_SUP;
> -	while (--i) {
> -		if (!rdma_cap_ib_cm(ib_device, i))
> -			continue;
> -
> -		port = cm_dev->port[i-1];
> -		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
> -		ib_unregister_mad_agent(port->mad_agent);
> -		cm_remove_port_fs(port);
> -	}
> +error:
> +	while (--i)
> +		cm_destroy_one_port(cm_dev, i);
>  free:
> -	kfree(cm_dev);
> +	kvfree(cm_dev);
>  }
>
>  static void cm_remove_one(struct ib_device *ib_device, void *client_data)
>  {
>  	struct cm_device *cm_dev = client_data;
> -	struct cm_port *port;
> -	struct cm_id_private *cm_id_priv;
> -	struct ib_mad_agent *cur_mad_agent;
> -	struct ib_port_modify port_modify = {
> -		.clr_port_cap_mask = IB_PORT_CM_SUP
> -	};
>  	unsigned long flags;
>  	int i;
>
> @@ -4435,34 +4460,10 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
>  	cm_dev->going_down = 1;
>  	spin_unlock_irq(&cm.lock);
>
> -	for (i = 1; i <= ib_device->phys_port_cnt; i++) {
> -		if (!rdma_cap_ib_cm(ib_device, i))
> -			continue;
> -
> -		port = cm_dev->port[i-1];
> -		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
> -		/* Mark all the cm_id's as not valid */
> -		spin_lock_irq(&cm.lock);
> -		list_for_each_entry(cm_id_priv, &port->cm_priv_altr_list, altr_list)
> -			cm_id_priv->altr_send_port_not_ready = 1;
> -		list_for_each_entry(cm_id_priv, &port->cm_priv_prim_list, prim_list)
> -			cm_id_priv->prim_send_port_not_ready = 1;
> -		spin_unlock_irq(&cm.lock);
> -		/*
> -		 * We flush the queue here after the going_down set, this
> -		 * verify that no new works will be queued in the recv handler,
> -		 * after that we can call the unregister_mad_agent
> -		 */
> -		flush_workqueue(cm.wq);
> -		spin_lock_irq(&cm.state_lock);
> -		cur_mad_agent = port->mad_agent;
> -		port->mad_agent = NULL;
> -		spin_unlock_irq(&cm.state_lock);
> -		ib_unregister_mad_agent(cur_mad_agent);
> -		cm_remove_port_fs(port);
> -	}
> +	for (i = 1; i <= ib_device->phys_port_cnt; i++)
> +		cm_destroy_one_port(cm_dev, i);
>
> -	kfree(cm_dev);
> +	kvfree(cm_dev);
>  }
>
>  static int __init ib_cm_init(void)
> --
> 2.23.0
>
