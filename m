Return-Path: <linux-rdma+bounces-23096-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dLgdLRKkVGqsogMAu9opvQ
	(envelope-from <linux-rdma+bounces-23096-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:38:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45781748CE6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:38:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PUCHi83R;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23096-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23096-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56D5D3016032
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC63B2FC8;
	Mon, 13 Jul 2026 08:36:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A34399CEC;
	Mon, 13 Jul 2026 08:36:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931769; cv=none; b=mDIBIneZNft3SrPkUeY1mEY3a+S9pow4xElhmuck8SiwY0NjSzmu8WtZN5bDXJyhjZAEQzbHy0R0dQWTDDBp7efzClvDBxpu3R3JQ+TcWfgfo2FGRiDLMmo+op24LlTEI2NeBsuBU70dGsYZYNHcecdXPeK2N0wxEUthL1fIKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931769; c=relaxed/simple;
	bh=cArLHVdjV4div3LZV81g7GIfNNFWac/t5xm4JqWc1FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyQlaF5vifGG50J9fLr5kFe36jROT8xZ4mgZB0fZ7gZTTUak7Pc9Q1VVPXlZQD6I6Z0vx4MUFfBw5sBWrRmYechSdqSLFir3RaL6KhCJTDIw9DtmbqZCxYDiSW1khrFBFAU6irvB2HlZi5iT2DeJL1sH9of+/zzQbWHkRiUFK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUCHi83R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8136C1F000E9;
	Mon, 13 Jul 2026 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783931768;
	bh=it49xh5pBQ5AuRG2Y5geozNDkPWp2BCA3ganYpKFHzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PUCHi83RsBHnpfOkGMMgmVIiv+qh/HGhbnPW/v22Wx20thmCBZGrGcO8PxtUTEbz4
	 DhBfkcsxG0nvIz7sjTgFL+c6uwnxd1dBTzXYjTDjj6XWYq0rRL/F1GPox24J0wJz/y
	 5V+7N3NkzuZ5yMlav4zH5nibOZSuwHqCJMvLvwChvjA6KoxppbZDCOs7TMHUOdvBFK
	 GdJvmafd9P9pKL+YNQYTz3jLJjTclOVsoDRCBqEqG7Sguj+S0UZpM5C50Qz9/8rER4
	 iXzAou0rZU3E4kHSEwA3N52gfjZq79pWeyU41QExFh3C1m6J6v/+VxYqUdsSRbgRby
	 LZSU9o47jjcpA==
Date: Mon, 13 Jul 2026 11:36:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: yishaih@nvidia.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] IB/mlx4: Fix stale CM id_map entries when RTU is
 never received
Message-ID: <20260713083604.GI33197@unreal>
References: <20260706120255.639985-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706120255.639985-1-praveen.kannoju@oracle.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-23096-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45781748CE6

On Mon, Jul 06, 2026 at 12:02:55PM +0000, Praveen Kumar Kannoju wrote:
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
>  drivers/infiniband/hw/mlx4/cm.c | 101 ++++++++++++++++++++++++++++++----------
>  1 file changed, 76 insertions(+), 25 deletions(-)
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
> @@ -261,48 +274,46 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +/* Lock should be taken before called */

/* Lock should be taken before called */ sentence needs to be replaced 
by lockdep_held(&sriov->id_map_lock);

Thanks

