Return-Path: <linux-rdma+bounces-22384-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1XwVMTXANmp8EQcAu9opvQ
	(envelope-from <linux-rdma+bounces-22384-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 18:30:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E586A93A6
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 18:30:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fWXNKPZl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22384-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22384-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB6E3017C06
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C301A6829;
	Sat, 20 Jun 2026 16:30:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE240D572;
	Sat, 20 Jun 2026 16:30:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973035; cv=none; b=IebzE3U9iuq+xSYMcy1j/Oh/pAo3aOeCminH4VnzjXGRnoIamSsKnXB0KZBXru8U8wyO+UxI3WeEuCBj1GRVo26918ySXW9UGFx3tqADOjfJKO7qyvkh1tAu8GPuhEcPwgPxXTvJzasxCTyMnuzK/kNdIxXkjANiur5Y/VwsAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973035; c=relaxed/simple;
	bh=3Dpmmerb0QG1G8KOpjCvUTZKf0T5mNd9JG1LlDJ0JzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHmWPBXnXqlKMNKe5392TG0OnV/RVx1p8v4gSffHXDV6GR41T4S5wgcQBbLv9RIMajmZ13PnGXRaRkDhcQ+ZSTE0AeqWJvLfsWOPSfGRnknM6XJRVmQot2Ct2ssGv69i0XV8LWiLvIEK0EDE5Q+gJIy/2xoZnNPuhmDN0u3QRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWXNKPZl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C4E1F000E9;
	Sat, 20 Jun 2026 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781973034;
	bh=D6t63Jy9/sgsYx1uJL6I1MjmSXoE7TCkLo+nXd+KPuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fWXNKPZlBWyTdQbXzoThXH/SeBRUhorUJKPsfN9xAPKoG18QJhs0snK4JG63X1qVz
	 DRKCkOEr0kbqBzik+DTrrjTGwBlbqhU1Wngff+WgfdG3ti6dAc64vP3XRd+tOcJQ8X
	 oG3Iw10H87jzBYATA1+GK/WvnySc2EQuSOdaFauRHoInJq4E+8br/cDv6xKp4++/80
	 VGTRtUO9n93Not0f5Q2r4VLEDSIVjA3pAle+iii3wQxHsNwBjZ3wS4zZNN+gqZad3S
	 5Co0ua3fxYiceYokKoHpicoxGDja/XL7V0svTXndP5nDm74+VCs3RQQsFaxet02VGD
	 7YSzRd+MHSHlw==
Date: Sat, 20 Jun 2026 17:30:28 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, sd@queasysnail.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, borisp@nvidia.com, raeds@nvidia.com,
	ehakim@nvidia.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net/mlx5e: macsec: fix use-after-free of
 metadata_dst on RX SC delete
Message-ID: <20260620163028.GW827683@horms.kernel.org>
References: <20260618145545.53035-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618145545.53035-1-doruk@0sec.ai>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22384-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,0sec.ai:email,horms.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59E586A93A6

On Thu, Jun 18, 2026 at 04:55:45PM +0200, Doruk Tan Ozturk wrote:
> When an offloaded MACsec RX SC is deleted, macsec_del_rxsc_ctx() released
> the per-SC metadata_dst with metadata_dst_free(), which calls kfree()
> unconditionally and ignores the dst reference count. The RX datapath in
> mlx5e_macsec_offload_handle_rx_skb() looks up the SC under rcu_read_lock()
> via xa_load() and, while still holding only the RCU read lock, takes a
> reference with dst_hold() and attaches the dst to the skb with
> skb_dst_set().
> 
> A reader that has already obtained the rx_sc pointer can therefore race
> with the delete path:
> 
>   CPU0 (del_rxsc)			CPU1 (rx datapath)
>   --------------			------------------
> 					rcu_read_lock();
> 					rx_sc = xa_load(...)->rx_sc;
>   xa_erase(...);
>   metadata_dst_free(rx_sc->md_dst);	/* kfree(), ignores refcount */
> 					dst_hold(&rx_sc->md_dst->dst); /* UAF */
> 					skb_dst_set(skb, &rx_sc->md_dst->dst);
> 
> metadata_dst_free() frees the object even though the datapath still holds
> (or is about to take) a reference, so the subsequent dst_hold() /
> skb_dst_set() and the later skb free operate on freed memory.
> 
> Fix the owner side by dropping the reference with dst_release() instead of
> freeing unconditionally. dst_release() only schedules the RCU-deferred
> dst_destroy() once the reference count reaches zero, so a concurrent reader
> that still holds a reference keeps the object alive.
> 
> Dropping the owner reference is not sufficient on its own: once the owner
> reference is the last one, dst_release() drops the count to zero and the
> destroy is merely RCU-deferred. A racing reader that runs plain dst_hold()
> on that already-dead dst gets rcuref_get() == false but dst_hold() only
> WARNs and attaches the dying dst to the skb anyway; the later skb free then
> calls dst_release() on an object whose destroy is already scheduled, again
> a use-after-free.
> 
> Convert the RX datapath to dst_hold_safe(), which returns false (without
> warning) when the dst is already dead, and only attach it to the skb when a
> reference was successfully taken. When the SC is being deleted the in-flight
> packet simply proceeds without the offload metadata_dst: skb_metadata_dst()
> returns NULL, the MACsec core sees !is_macsec_md_dst and skips this secy
> (rx_uses_md_dst path), which is the correct behaviour for a packet whose SC
> is going away.
> 
> While reworking the datapath lookup, also guard the two NULL dereferences
> on the same path that an automated review (forwarded by Simon Horman)
> flagged: xa_load() can return NULL when the fs_id has just been erased, and
> mlx5e_macsec_add_rxsc() publishes sc_xarray_element via xa_alloc() before
> rx_sc->md_dst is allocated, so a packet carrying a freshly recycled fs_id
> can observe a non-NULL rx_sc whose md_dst is still NULL. Check both before
> dereferencing.
> 
> Note: macsec_del_rxsc_ctx() also kfree()s rx_sc->sc_xarray_element without
> an RCU grace period while the same datapath reads it under rcu_read_lock();
> that is a separate pre-existing issue and is left to a follow-up patch.
> 
> Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v3:
>  - Also guard the RX-datapath NULL dereferences flagged by the automated
>    review: NULL-check the xa_load() result and rx_sc->md_dst before use.

The review of this patch on sashiko.dev flags that this change doesn't
appear to be complete:

  "This is a pre-existing issue, but since xa_alloc() in mlx5e_macsec_add_rxsc()
   publishes sc_xarray_element before rx_sc->md_dst is allocated and initialized,
   is it safe to use a plain read here?
   drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c:mlx5e_macsec_add_rxsc() {
      ...
      err = xa_alloc(&macsec->sc_xarray, &sc_xarray_element->fs_id, sc_xarray_element, ...);
      ...
      rx_sc->md_dst = metadata_dst_alloc(0, METADATA_MACSEC, GFP_KERNEL);
      ...
   }
   Because there are no memory barriers around the assignment and initialization
   of md_dst, could a concurrent datapath reader observe a non-NULL md_dst
   pointer but read uninitialized memory from it in dst_hold_safe()?"

...

