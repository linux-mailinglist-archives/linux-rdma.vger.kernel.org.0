Return-Path: <linux-rdma+bounces-23253-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qI4GHU8xV2q7HAEAu9opvQ
	(envelope-from <linux-rdma+bounces-23253-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:05:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D069F75B47F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:05:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Jjo+aiA+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23253-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23253-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1010F3014436
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB2330C608;
	Wed, 15 Jul 2026 07:05:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5942BC34;
	Wed, 15 Jul 2026 07:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099146; cv=none; b=KdOLaxapPKkwWyMk4ksjZ1D42XLoRuEfkumUb8+HNuDp7bQIZPdm2tf2ogzW9gmVqmucpZRLSllDfVAifmGqa+GVIkXgehlPQ7Bg0FFqQ2PxEOPWVfXR3F1U5i2d880ZAy1oFAWWghhelSnnQvq8g0VJn7UgM6DoCu8PlCI/NIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099146; c=relaxed/simple;
	bh=I8ty1h5nbfufNOATqGAiDyDSWGohSkv3Naiwna3mylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVhwJwonFj3O6QZSoyCbGJeyD3y2NZIwO38+IJ34ZVTDfyBHCMQ0sqMTsiaBxbLgY8YnGuoSv4NaK07adgsmQuFJ8Koj1Tj3Pnr+wxtrNXD3wrDGBQf2Xbp1+NMX6GresTo3RPo1m8CIRUz37rh7qX0ZxXJZIWJSwN79gQ00+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jjo+aiA+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142361F000E9;
	Wed, 15 Jul 2026 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784099144;
	bh=L9j/qXi7i7tV67rN0hz2c6Jpu6Rio4yZfVPXCNq4jAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jjo+aiA+7ap6SOGbImHj6R8L4BHe6aymFOizTub5nQW9Fwu2EwbhhNpyAGA8+kyTH
	 JvcbGwlqIgVW8frS5YtWGCVP9q6Y9iEixvx6Nokrl052cDt+mjVWC3yD4yse70rECK
	 mv9a2JdS7Xw0n0YuTZS2UbJXB4jGcCVdbdshMm8wwqmJMt+XyKl8S+Dnh1f3uxbaHk
	 DPxYNK8UeaIT4jQ/xQpsYLm0WxOA/73KwEd2g76wOkebt6ii5m56Vay4uVITjpu6S7
	 vtmUlsCl/Cu9PH6+yh8QQtvpua8Cw99B954F0+9g6UWTLYhmwYorkiSdahAZfosL+v
	 U1TtCnruC/63Q==
Date: Wed, 15 Jul 2026 10:05:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: yishaih@nvidia.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] IB/mlx4: Fix stale CM id_map entries when RTU is
 never received
Message-ID: <20260715070540.GB21348@unreal>
References: <20260713111142.1206710-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713111142.1206710-1-praveen.kannoju@oracle.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:praveen.kannoju@oracle.com,m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23253-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D069F75B47F

On Mon, Jul 13, 2026 at 11:11:42AM +0000, Praveen Kumar Kannoju wrote:
> mlx4_ib_multiplex_cm_handler() allocates an id_map_entry for CM
> transactions, but the entry is normally released only on DREQ or REJ
> flows.
> 
> In the duplicate REP handling scenario, cm_dup_rep_handler() may be
> invoked when the remote side receives a REP for which no matching
> cm_id_priv exists. In such cases the CM handshake never reaches RTU, and
> the sender side may never receive either DREQ or REJ cleanup events.
> 
> As a result, the allocated id_map_entry remains indefinitely, resulting in
> a stale mapping leak.
> 
> Fix this by arming an RTU-abandon cleanup timeout when the id_map_entry is
> allocated. The timeout uses the mlx4 CM workqueue and the existing
> schedule_delayed() path, so later DREQ/REJ cleanup can shorten the pending
> timeout with mod_delayed_work().
> 
> Track whether a pending cleanup timeout is still waiting for RTU. RTU
> cancels only that initial timeout; if DREQ/REJ has already converted it to
> normal teardown cleanup, a late or duplicate RTU does not cancel the
> teardown timer. If the RTU timeout callback has already started, leave the
> entry on the timeout path and make the RTU packet lose that race.
> 
> Hold id_map_lock while looking up the entry, canceling the RTU timeout,
> scheduling teardown cleanup, and copying the id values needed by the CM
> handlers. The delayed-work callback rechecks scheduled_delete under the
> same lock before removing and freeing the entry, avoiding use-after-free
> when RTU races with timeout execution.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
> v1: https://lore.kernel.org/linux-rdma/20260507154755.452008-1-praveen.kannoju@oracle.com/T/#u
> v2: https://lore.kernel.org/linux-rdma/BL0PR10MB282074FA0D571F5072DFCB4B8CF12@BL0PR10MB2820.namprd10.prod.outlook.com/T/#t
> 
> Changes in v3:
> - Replace "Lock should be taken before called" comments with
>   lockdep_assert_held(&sriov->id_map_lock).
> 
> Changes in v2:
> - Queue the RTU-abandon timeout on the mlx4 CM workqueue through
>   schedule_delayed() and use mod_delayed_work() so DREQ/REJ cleanup can
>   shorten a pending RTU timeout.
> - Track RTU-abandon cleanup separately from normal DREQ/REJ cleanup so a
>   late or duplicate RTU does not cancel a teardown timer.
> - Hold id_map_lock while looking up id_map entries, canceling or updating
>   delayed work, and copying CM IDs needed by the handlers.
> - Make RTU lose the race when the timeout callback has already started.
> 
>  drivers/infiniband/hw/mlx4/cm.c | 98 ++++++++++++++++++++++++++++++---------
>  1 file changed, 75 insertions(+), 23 deletions(-)

I wanted to apply this patch, but it has merge conflicts. Please
rebase it onto the latest rdma-next.

As you are probably the only person using this device in that mode, I
will take it as-is after the rebase. Strictly speaking, however, the
lock around id_map_get() does not make much sense. There is no
reference counting on the returned ID, so it can disappear immediately
after the lock is released.

Thanks.

> 
> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> index 63a868a..f7905df 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -40,6 +40,7 @@
>  #include "mlx4_ib.h"
>  
>  #define CM_CLEANUP_CACHE_TIMEOUT  (30 * HZ)
> +#define CM_RTU_TIMEOUT		  (60 * HZ)
>  
>  struct id_map_entry {
>  	struct rb_node node;
> @@ -48,6 +49,7 @@ struct id_map_entry {
>  	u32 pv_cm_id;
>  	int slave_id;
>  	int scheduled_delete;
> +	bool rtu_timeout;
>  	struct mlx4_ib_dev *dev;
>  
>  	struct list_head list;
> @@ -184,6 +186,10 @@ static void id_map_ent_timeout(struct work_struct *work)
>  	struct rb_root *sl_id_map = &sriov->sl_id_map;
>  
>  	spin_lock(&sriov->id_map_lock);
> +	if (!ent->scheduled_delete) {
> +		spin_unlock(&sriov->id_map_lock);
> +		return;
> +	}
>  	if (!xa_erase(&sriov->pv_id_table, ent->pv_cm_id))
>  		goto out;
>  	found_ent = id_map_find_by_sl_id(&dev->ib_dev, ent->slave_id, ent->sl_cm_id);
> @@ -228,8 +234,12 @@ static void sl_id_map_add(struct ib_device *ibdev, struct id_map_entry *new)
>  	rb_insert_color(&new->node, sl_id_map);
>  }
>  
> +static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id,
> +			     unsigned long timeout, bool rtu_timeout);
> +
>  static struct id_map_entry *
> -id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
> +id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id,
> +	     u32 *pv_cm_id)
>  {
>  	int ret;
>  	struct id_map_entry *ent;
> @@ -242,6 +252,7 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
>  	ent->sl_cm_id = sl_cm_id;
>  	ent->slave_id = slave_id;
>  	ent->scheduled_delete = 0;
> +	ent->rtu_timeout = false;
>  	ent->dev = to_mdev(ibdev);
>  	INIT_DELAYED_WORK(&ent->timeout, id_map_ent_timeout);
>  
> @@ -251,6 +262,8 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
>  		spin_lock(&sriov->id_map_lock);
>  		sl_id_map_add(ibdev, ent);
>  		list_add_tail(&ent->list, &sriov->cm_list);
> +		*pv_cm_id = ent->pv_cm_id;
> +		schedule_delayed(ibdev, ent, CM_RTU_TIMEOUT, true);
>  		spin_unlock(&sriov->id_map_lock);
>  		return ent;
>  	}
> @@ -261,48 +274,47 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
>  	return ERR_PTR(-ENOMEM);
>  }
>  
>  static struct id_map_entry *
>  id_map_get(struct ib_device *ibdev, int *pv_cm_id, int slave_id, int sl_cm_id)
>  {
>  	struct id_map_entry *ent;
>  	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
>  
> -	spin_lock(&sriov->id_map_lock);
> +	lockdep_assert_held(&sriov->id_map_lock);
>  	if (*pv_cm_id == -1) {
>  		ent = id_map_find_by_sl_id(ibdev, slave_id, sl_cm_id);
>  		if (ent)
>  			*pv_cm_id = (int) ent->pv_cm_id;
>  	} else
>  		ent = xa_load(&sriov->pv_id_table, *pv_cm_id);
> -	spin_unlock(&sriov->id_map_lock);
>  
>  	return ent;
>  }
>  
> -static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
> +static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id,
> +			     unsigned long timeout, bool rtu_timeout)
>  {
>  	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
>  	unsigned long flags;
>  
> -	spin_lock(&sriov->id_map_lock);
> +	lockdep_assert_held(&sriov->id_map_lock);
>  	spin_lock_irqsave(&sriov->going_down_lock, flags);
>  	/*make sure that there is no schedule inside the scheduled work.*/
> -	if (!sriov->is_going_down && !id->scheduled_delete) {
> +	if (!sriov->is_going_down || id->scheduled_delete) {
>  		id->scheduled_delete = 1;
> -		queue_delayed_work(cm_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
> -	} else if (id->scheduled_delete) {
> -		/* Adjust timeout if already scheduled */
> -		mod_delayed_work(cm_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
> +		id->rtu_timeout = rtu_timeout;
> +		mod_delayed_work(cm_wq, &id->timeout, timeout);
>  	}
>  	spin_unlock_irqrestore(&sriov->going_down_lock, flags);
> -	spin_unlock(&sriov->id_map_lock);
>  }
>  
>  #define REJ_REASON(m) be16_to_cpu(((struct cm_generic_msg *)(m))->rej_reason)
>  int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id,
>  		struct ib_mad *mad)
>  {
> +	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
>  	struct id_map_entry *id;
> +	u32 pv_cm_id_to_set = 0;
>  	u32 sl_cm_id;
>  	int pv_cm_id = -1;
>  
> @@ -312,10 +323,15 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  	    mad->mad_hdr.attr_id == CM_SIDR_REQ_ATTR_ID ||
>  	    (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID && REJ_REASON(mad) == IB_CM_REJ_TIMEOUT)) {
>  		sl_cm_id = get_local_comm_id(mad);
> +		spin_lock(&sriov->id_map_lock);
>  		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
> +		if (id)
> +			pv_cm_id_to_set = id->pv_cm_id;
> +		spin_unlock(&sriov->id_map_lock);
>  		if (id)
>  			goto cont;
> -		id = id_map_alloc(ibdev, slave_id, sl_cm_id);
> +		id = id_map_alloc(ibdev, slave_id, sl_cm_id,
> +				  &pv_cm_id_to_set);
>  		if (IS_ERR(id)) {
>  			mlx4_ib_warn(ibdev, "%s: id{slave: %d, sl_cm_id: 0x%x} Failed to id_map_alloc\n",
>  				__func__, slave_id, sl_cm_id);
> @@ -326,7 +342,25 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  		return 0;
>  	} else {
>  		sl_cm_id = get_local_comm_id(mad);
> +		spin_lock(&sriov->id_map_lock);
>  		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
> +		if (id) {
> +			if (mad->mad_hdr.attr_id == CM_RTU_ATTR_ID &&
> +			    id->rtu_timeout) {
> +				id->rtu_timeout = false;
> +				if (cancel_delayed_work(&id->timeout))
> +					id->scheduled_delete = 0;
> +				else
> +					id = NULL;
> +			}
> +			if (id)
> +				pv_cm_id_to_set = id->pv_cm_id;
> +			if (id && mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
> +				schedule_delayed(ibdev, id,
> +						 CM_CLEANUP_CACHE_TIMEOUT,
> +						 false);
> +		}
> +		spin_unlock(&sriov->id_map_lock);
>  	}
>  
>  	if (!id) {
> @@ -336,10 +370,7 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  	}
>  
>  cont:
> -	set_local_comm_id(mad, id->pv_cm_id);
> -
> -	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
> -		schedule_delayed(ibdev, id);
> +	set_local_comm_id(mad, pv_cm_id_to_set);
>  	return 0;
>  }
>  
> @@ -429,7 +460,10 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
>  	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
>  	u32 rem_pv_cm_id = get_local_comm_id(mad);
>  	u32 pv_cm_id;
> +	u32 sl_cm_id = 0;
>  	struct id_map_entry *id;
> +	int pv_cm_id_int;
> +	int slave_id = 0;
>  	int sts;
>  
>  	if (mad->mad_hdr.attr_id == CM_REQ_ATTR_ID ||
> @@ -457,7 +491,28 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
>  	}
>  
>  	pv_cm_id = get_remote_comm_id(mad);
> -	id = id_map_get(ibdev, (int *)&pv_cm_id, -1, -1);
> +	pv_cm_id_int = pv_cm_id;
> +	spin_lock(&sriov->id_map_lock);
> +	id = id_map_get(ibdev, &pv_cm_id_int, -1, -1);
> +	if (id) {
> +		if (mad->mad_hdr.attr_id == CM_RTU_ATTR_ID &&
> +		    id->rtu_timeout) {
> +			id->rtu_timeout = false;
> +			if (cancel_delayed_work(&id->timeout))
> +				id->scheduled_delete = 0;
> +			else
> +				id = NULL;
> +		}
> +		if (id && slave)
> +			slave_id = id->slave_id;
> +		if (id)
> +			sl_cm_id = id->sl_cm_id;
> +		if (id && (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
> +			   mad->mad_hdr.attr_id == CM_REJ_ATTR_ID))
> +			schedule_delayed(ibdev, id,
> +					 CM_CLEANUP_CACHE_TIMEOUT, false);
> +	}
> +	spin_unlock(&sriov->id_map_lock);
>  
>  	if (!id) {
>  		if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID &&
> @@ -472,12 +527,8 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
>  	}
>  
>  	if (slave)
> -		*slave = id->slave_id;
> -	set_remote_comm_id(mad, id->sl_cm_id);
> -
> -	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
> -	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
> -		schedule_delayed(ibdev, id);
> +		*slave = slave_id;
> +	set_remote_comm_id(mad, sl_cm_id);
>  
>  	return 0;
>  }

