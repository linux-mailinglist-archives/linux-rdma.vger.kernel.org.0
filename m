Return-Path: <linux-rdma+bounces-22780-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MH2wL5VlSmqjCQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22780-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:09:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAD70A3FA
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=KIMWx7vR;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22780-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22780-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2293F300EA85
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F43815DD;
	Sun,  5 Jul 2026 14:09:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF63644A4
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:09:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260552; cv=none; b=iQpI2TvwXubQlQ8PKusIM7vqYdV7GxEavHQCImCPr/Ti0+bx/6weQ/yYB5A73WogmElGA4tabp5nTHMl7wCfeMD0PraMLEBwT5dZlTH3pf30Rw0L+75LjrhCV7tGQGMXL/lWK7OuSwNqs8c5cic9++FTfatzxm0i+9KiEh6iEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260552; c=relaxed/simple;
	bh=WJtoKtR2DDhu7zLDSsgF/HsXPrQbs3alp9wE24xLx2Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+h+BALutIDjKaIK+HXfzBqPjJXbBIrKOw3fM3beq1sBi3xz36/xqS9q5ZyB3IGbEL1MPohuOZexFeyhWzoMhG+G36U3ioCICWQ8IDbN0fqtcAxqtyxL6Q/lWnEha0Lf6jc12IqEPLKRM08ax4ARxhFL5DO/KHA1sWejUbi5UpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KIMWx7vR; arc=none smtp.client-ip=44.246.1.125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783260551; x=1814796551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JLMqM4FjSH3zbwr5CEHyqp8LlN+KfTlcF3DDOa6RVVg=;
  b=KIMWx7vRbKjALP0vlRpe8XQhPrQOCK+3GdxocxGpnLOe0NtFgVsDJtBs
   QKXaJaTXMvvNu+pmQqgmFHRzArqYqTZeAI2Gtcu2w866WZgJiYoLIGN/A
   u4WgVfHVZ5PF10ZSNQ0O53zraYFsB0RbEed0DjwWdaCzz4J5kNGtnX4O/
   oNExWwUcTnTldaqAlLohpEIZYPlPLYrqw80McbgHPuxpf+lt8X4h8n1J7
   4zxHa1lcn7abtVPV4cti1f+FLdEGf483rjQJ2HPO/wGAOu16wfptBvCLj
   oNbfKgU0EOjkjRe8aV6GN93vco0dxMh4Hg4U25IcYu8KgpH1QLbQdGKbC
   w==;
X-CSE-ConnectionGUID: 4VCFZaplTh2UVneb6qTa/Q==
X-CSE-MsgGUID: kivPgt64TGyYq0cRVPIvzw==
X-IronPort-AV: E=Sophos;i="6.25,149,1779148800"; 
   d="scan'208";a="23096643"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 14:09:08 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:1076]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.18:2525] with esmtp (Farcaster)
 id dcbc347f-cfc6-452c-ac47-1c73fb2fa814; Sun, 5 Jul 2026 14:09:08 +0000 (UTC)
X-Farcaster-Flow-ID: dcbc347f-cfc6-452c-ac47-1c73fb2fa814
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 5 Jul 2026 14:09:08 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Sun, 5 Jul 2026
 14:09:06 +0000
Date: Sun, 5 Jul 2026 14:08:52 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>
Subject: Re: [PATCH for-next v5 2/2] RDMA/efa: Add AH cache handling on
 create and destroy AH
Message-ID: <20260705140852.GA25788@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260628133422.523230-1-ynachum@amazon.com>
 <20260628133422.523230-3-ynachum@amazon.com>
 <20260705133506.GF15188@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260705133506.GF15188@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22780-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com:mid];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:firasj@amazon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10EAD70A3FA

On Sun, Jul 05, 2026 at 04:35:06PM +0300, Leon Romanovsky wrote:
> > +/**
> > + * efa_ah_cache_put - Put a refcount of an AH cache entry
> > + * @ah_cache: AH cache
> > + * @entry: AH cache entry
> > + *
> > + * Drop the refcount. If it reaches zero, remove the entry from the hashtable
> > + * and free it.
> > + */
> > +void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry)
> > +{
> > +	if (!refcount_dec_and_mutex_lock(&entry->refcount, &ah_cache->lock))
> > +		return;
> > +
> > +	/* AH cache lock is held here */
> > +	rhashtable_remove_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
> > +	mutex_unlock(&ah_cache->lock);
> > +
> > +	mutex_destroy(&entry->lock);
> > +	kfree_rcu(entry, rcu_head);
> 
> Where do you use RCU locking in this series? Why do you call
> kfree_rcu() instead of kfree()?
> 
> Thanks

Originally I used kfree directly, but changed to kfree_rcu in v3
following this Sashiko review and Jason's comment:
https://sashiko.dev/#/patchset/20260512061121.2177521-1-ynachum%40amazon.com

If you think its not needed I can delete it.

Thanks

