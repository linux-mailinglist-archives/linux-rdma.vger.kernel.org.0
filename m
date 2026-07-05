Return-Path: <linux-rdma+bounces-22769-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T2Y/CZVdSmpiBwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22769-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 15:35:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7153170A1E2
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 15:35:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SqOU0Wut;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22769-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22769-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 932FE3003624
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BB370D79;
	Sun,  5 Jul 2026 13:35:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDF433E7A
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 13:35:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783258514; cv=none; b=DaVqiwfeJuTWOyRJYuVQqVPiR9XfjGRUmN7TrjqB45BdttcDhTKKIkf0tiYvSkpA8m+KoELZJOGCGwxtemhp3wjj7XrTeoHxoY1f0Pon8051NOH/0lZokqaeaFf3cOYwcrWspNfzZZwpbPq4QxtON4vXqyCZ1PmzBRZ6gfYj9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783258514; c=relaxed/simple;
	bh=cBS3qFEaW79accbTRK1zgHcviy833cROtSxOdY6pmVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku0xjgBTRSkXlY6Kjxi3+6683WPuBo2xx4FdK/XOj+C+IDPEG8dP7uFLq8ztdrqNIZowLgFL3rSuTe379KlAroQ5tXammehk9sIlewr31zkU0SYnDFnATsIpWyb/Si3lgYQiYJMa8HIG5CI6V/PqJATQtiovyO6PqWQNHVRETs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqOU0Wut; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59501F000E9;
	Sun,  5 Jul 2026 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783258512;
	bh=lP8xjZhB7sYJdDvpTEzzGgU+2ZsJo3rEOTSDsW5awRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SqOU0Wut2sKLinFz8YHoMVaF2yov49R8jqS+8DQqIV5YGKQegIY1OuoBDx4RCIvGt
	 ozQozhNuXoAHtSyPhMVwTd9/kWfqmp5YFfRe86/ktAjgEooxxEbC6vAPNFIR8ITW/h
	 YgFgJ8IydY/1TGThT+oKa65UvkDKe/ic9biItUYytDaI5+RK/9kTOPkUrtjAr9KZKJ
	 Bm7I3Xm3bqijdw5EOf016ZcfbB5MtzYJkZDb+jvmEnHTOSONNRkFAD55I56GcSqtTm
	 vuQkg1qKkLQ943JdhSyweIrDVMfI7iagJIaoiQr2WFpAzhVpEWdOF26gaSHipwJd77
	 Hdb/z6VSRHP5g==
Date: Sun, 5 Jul 2026 16:35:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v5 2/2] RDMA/efa: Add AH cache handling on
 create and destroy AH
Message-ID: <20260705133506.GF15188@unreal>
References: <20260628133422.523230-1-ynachum@amazon.com>
 <20260628133422.523230-3-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628133422.523230-3-ynachum@amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ynachum@amazon.com,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:firasj@amazon.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22769-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7153170A1E2

On Sun, Jun 28, 2026 at 01:34:22PM +0000, Yonatan Nachum wrote:
> On create AH, first check if the AH cache entry already exists and if
> so, returns the already stored AH number. If the entry doesn't exist,
> the driver creates it and calls the device to create the AH. A per-entry
> mutex serializes concurrent device commands on the same AH cache entry,
> ensuring only one thread issues the device create while others wait and
> reuse the result. If the device create fails, the entry's user count
> remains zero so subsequent threads will retry the device create.
> 
> On destroy AH, the user count is decremented under the entry mutex. If
> it reaches zero, the driver issues the device destroy command. After
> the device destroy completes, it removes the entry from the hashtable
> and frees it if no other references exist.  If new users arrived during
> the destroy, the entry remains in the hashtable for reuse.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_ah_cache.c | 94 ++++++++++++++++++++++++
>  drivers/infiniband/hw/efa/efa_ah_cache.h |  3 +
>  drivers/infiniband/hw/efa/efa_com_cmd.c  | 41 ++++++++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.h  |  1 +
>  drivers/infiniband/hw/efa/efa_verbs.c    |  9 ++-
>  5 files changed, 140 insertions(+), 8 deletions(-)

<...>

> +/**
> + * efa_ah_cache_put - Put a refcount of an AH cache entry
> + * @ah_cache: AH cache
> + * @entry: AH cache entry
> + *
> + * Drop the refcount. If it reaches zero, remove the entry from the hashtable
> + * and free it.
> + */
> +void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry)
> +{
> +	if (!refcount_dec_and_mutex_lock(&entry->refcount, &ah_cache->lock))
> +		return;
> +
> +	/* AH cache lock is held here */
> +	rhashtable_remove_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
> +	mutex_unlock(&ah_cache->lock);
> +
> +	mutex_destroy(&entry->lock);
> +	kfree_rcu(entry, rcu_head);

Where do you use RCU locking in this series? Why do you call
kfree_rcu() instead of kfree()?

Thanks

