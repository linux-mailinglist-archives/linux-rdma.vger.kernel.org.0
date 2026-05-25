Return-Path: <linux-rdma+bounces-21221-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE/qAYzuE2qmHgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21221-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:39:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 600325C6969
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B6F303A8D8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14373A7F52;
	Mon, 25 May 2026 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iYIqggWU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99B3A7D63
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690872; cv=none; b=rhRUfPuZ6yKhMqEHevsn+PfOcdSiI8Y5XwfnMUlGqfGgLRo1m0MwaKpIPVSo6gLQPzxYTqkN+oIZ9HaEYyE4TzBdW/9W2ubBoxdaLfOzeZ3KHFZH1ZCWAmJf6spmWGFBNQMWnjQ81p7aRYWTliryCfQPuj9u3dUYtbUfdQ306P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690872; c=relaxed/simple;
	bh=OK+fOg73jmZziwcmQkoviWIn5eWeEl9tjja83qKXKKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crRm1CTECUKwtODICzoG77fY1f+yvlzT3CXg7KpshIqW5Jt+XdTzEMJT1tq+RzXJD+khXhnH3AibKjog8InCiS4D7vxpCgGWhaWmC/Udkhn0AvtSGLrwAVxM8O96iQmI7cAiOJRLsdf5u3EAuUdoAzYztj/swQxDvL6kB6S8hEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iYIqggWU; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779690869; x=1811226869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ql7olggLYyBWh6isEySNKRamr4w6Gh89XahCMTjru8U=;
  b=iYIqggWUU+R2r/xlvWJOcyhXk0IcKHjwvvfQhZxoSFYrD+Q/1DF3nLEb
   9LgJVFX5eAOtqu4hHY3OklwHrsXo6D6E82nZXhJg1JUnkGxeP7mKfatE+
   pN/QLV46AOsEPuNYiY264ainzNY1QNm+VtQUgLYkuhyjcKUO8nMZraMYQ
   TQx2c0h1fukrVOZpOvJFo/gGgcR6CTqKOlN5Qe7u4a5EET9LrqUtz6uh0
   R8KcFDznBQjx/I3AzrFb4SNKVyZADEwapfiQIzkc8EGJ5RWDJF5xaEL8Q
   brXhuDYjTDgwvN90yFL8VwTgP/zJ9h8aLq56vVkbfpvDPpT/wAQjAAER/
   g==;
X-CSE-ConnectionGUID: MiUN9vNXQfyysndMZ5uC0Q==
X-CSE-MsgGUID: N9rLOefsRoOfsNheQy6YqQ==
X-IronPort-AV: E=Sophos;i="6.24,167,1774310400"; 
   d="scan'208";a="20399589"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:34:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:9780]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.254:2525] with esmtp (Farcaster)
 id 95bc9e9e-557d-47fe-bd82-913334107b6a; Mon, 25 May 2026 06:34:26 +0000 (UTC)
X-Farcaster-Flow-ID: 95bc9e9e-557d-47fe-bd82-913334107b6a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 25 May 2026 06:34:26 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 25 May 2026
 06:34:24 +0000
Date: Mon, 25 May 2026 06:34:15 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/efa: Add AH cache handling on
 create and destroy AH
Message-ID: <20260525063415.GB27143@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-3-ynachum@amazon.com>
 <20260519133857.GW33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260519133857.GW33515@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21221-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 600325C6969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 04:38:57PM +0300, Leon Romanovsky wrote:
> On Tue, May 12, 2026 at 06:11:21AM +0000, Yonatan Nachum wrote:
> > On create AH, first check if the AH cache entry already exists and if
> > so, returns the already stored AH number. If the entry doesn't exist,
> > the driver creates it and calls the device to create the AH. A per-entry
> > mutex serializes concurrent device commands on the same AH cache entry,
> > ensuring only one thread issues the device create while others wait and
> > reuse the result. If the device create fails, the entry remains
> > uninitialized so subsequent threads calls can create the AH.
> > 
> > On destroy AH, the refcount is checked and if it's the last reference,
> > the driver issues the device destroy command while holding the entry
> > mutex. The entry remains in the hashtable during destroy to allow
> > concurrent create threads to find it and wait on the entry mutex,
> > preventing create-before-destroy races on the device. After the device
> > destroy completes, the entry is either recycled if new users arrived or
> > removed and freed.
> > 
> > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/efa_ah_cache.c | 124 +++++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_ah_cache.h |   5 +
> >  drivers/infiniband/hw/efa/efa_com_cmd.c  |  27 +++++
> >  drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
> >  drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
> >  5 files changed, 162 insertions(+), 4 deletions(-)
> 
> <...>
> 
> > +
> > +/**
> > + * efa_ah_cache_put - Release the final reference to an AH cache entry
> > + * @ah_cache: AH cache
> > + * @entry: AH cache entry
> > + *
> > + * Decrement the refcount. If it reaches zero, the entry is removed from the
> > + * hashtable and freed. Otherwise, the entry is kept for reuse.
> > + *
> > + * Called after the device destroy completes or on a failed create to release
> > + * the caller's reference.
> > + */
> > +void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry)
> > +{
> > +	mutex_lock(&ah_cache->lock);
> > +	if (!refcount_dec_and_test(&entry->refcount)) {
> > +		mutex_unlock(&ah_cache->lock);
> > +		return;
> > +	}
> > +
> > +	rhashtable_remove_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
> > +	mutex_unlock(&ah_cache->lock);
> > +
> > +	mutex_destroy(&entry->lock);
> > +	kvfree(entry);
> > +}
> 
> This pattern looks very similar to kref_put_mutex().
> 
> Thanks

We don't follow the kref put semantics here. On last AH put, we don't
decrement the refcount and delete the entry. Instead we keep the entry
in the hash and only do the last decrement after device destroy
completes. This solve s the races where AH create stars while a device
destroy is in progress - by keeping the entry, concurrent create threads
find it and block on the per-entry mutex until destroy completes,
ensuring a device create in initiated only after.

Thanks

