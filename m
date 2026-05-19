Return-Path: <linux-rdma+bounces-20965-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFr7FGhpDGo8hQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20965-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:45:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B216F57FEC1
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBB730C7239
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3F34040B;
	Tue, 19 May 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7wADz+c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68613403EC
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197942; cv=none; b=c2i1qPeVimuLM9HoFkl+/Zl+270Fod3p/bMx+pYFRH6CQx2BU6XIzeyuzAL4N4dntQPCvojhhUYSsKjQsTyi1LZEpX1nlozs65IWo76X04azb4qKqM4LlvDTqvsPpyF7O41dyoECoVsEGWluHM+K4I8hlIAyfeF9JpUOUa4ryXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197942; c=relaxed/simple;
	bh=j6kmObGSeK2ZeC0WaITxKLJu1tgkBBxfEV4F1cdLG6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH0dTI8fq+PGkDyu5AKQAA6lfQpHBYHWFweZiTy5n741xg80cP+VBxP+dDTDR1fun7YXvg0s4resJeA5+Nqu8JG5VbObZ135g+qmB1ITyby8jzsvDEbWYVNUSGTCHJtJLQl+4qW7BWSI0u/AM7fD22tCD0Xp8+c/zGa52OkPnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7wADz+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58BC2BCB3;
	Tue, 19 May 2026 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779197942;
	bh=j6kmObGSeK2ZeC0WaITxKLJu1tgkBBxfEV4F1cdLG6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7wADz+cGnL6cRc7KnJNWRHBvIqRVqXDZdxWJwUjPaccBss9axAqf95xwZaqeXrZ/
	 V/T+7YWIvzhYVW8AkR+hOlcInpcgSEo7xZRmnjlf9kExRldrzPB54e44zSHzKGgAig
	 RxVGe8r84T4Vas3Aqng5TeAHpCvNArL1qpUtoPks/bVrtBa9abaHX3CH8AAkH5oMZ3
	 mv84dsE+RwQqMChQTtesRY/VaqDxyM87KgCLYm0P6wwPmX22cgLwmowK6UtqrdXkf1
	 SYZb9U9K2cxD2FOlh4CgIsmu/B1iDxLl06Ds6r4qGieBgDvzOv34xwY/v1zmhbKTse
	 UEwDuy7FKlGGg==
Date: Tue, 19 May 2026 16:38:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/efa: Add AH cache handling on
 create and destroy AH
Message-ID: <20260519133857.GW33515@unreal>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-3-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512061121.2177521-3-ynachum@amazon.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20965-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B216F57FEC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 06:11:21AM +0000, Yonatan Nachum wrote:
> On create AH, first check if the AH cache entry already exists and if
> so, returns the already stored AH number. If the entry doesn't exist,
> the driver creates it and calls the device to create the AH. A per-entry
> mutex serializes concurrent device commands on the same AH cache entry,
> ensuring only one thread issues the device create while others wait and
> reuse the result. If the device create fails, the entry remains
> uninitialized so subsequent threads calls can create the AH.
> 
> On destroy AH, the refcount is checked and if it's the last reference,
> the driver issues the device destroy command while holding the entry
> mutex. The entry remains in the hashtable during destroy to allow
> concurrent create threads to find it and wait on the entry mutex,
> preventing create-before-destroy races on the device. After the device
> destroy completes, the entry is either recycled if new users arrived or
> removed and freed.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_ah_cache.c | 124 +++++++++++++++++++++++
>  drivers/infiniband/hw/efa/efa_ah_cache.h |   5 +
>  drivers/infiniband/hw/efa/efa_com_cmd.c  |  27 +++++
>  drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
>  drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
>  5 files changed, 162 insertions(+), 4 deletions(-)

<...>

> +
> +/**
> + * efa_ah_cache_put - Release the final reference to an AH cache entry
> + * @ah_cache: AH cache
> + * @entry: AH cache entry
> + *
> + * Decrement the refcount. If it reaches zero, the entry is removed from the
> + * hashtable and freed. Otherwise, the entry is kept for reuse.
> + *
> + * Called after the device destroy completes or on a failed create to release
> + * the caller's reference.
> + */
> +void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry)
> +{
> +	mutex_lock(&ah_cache->lock);
> +	if (!refcount_dec_and_test(&entry->refcount)) {
> +		mutex_unlock(&ah_cache->lock);
> +		return;
> +	}
> +
> +	rhashtable_remove_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
> +	mutex_unlock(&ah_cache->lock);
> +
> +	mutex_destroy(&entry->lock);
> +	kvfree(entry);
> +}

This pattern looks very similar to kref_put_mutex().

Thanks

