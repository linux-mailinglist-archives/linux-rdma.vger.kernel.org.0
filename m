Return-Path: <linux-rdma+bounces-21220-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDWjLtrtE2qHHgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21220-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:36:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF35C6895
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD9FE300363D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDBE313532;
	Mon, 25 May 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sUktgrn5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169F344040
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690674; cv=none; b=WzUDMbmVG38SB5Q2QdQccuVv78JqVCJoI+U9/UNNfHIuXlgb/YGP9XPmymQ2NbIrnrG1M0/tABnRfEivy790sSUNJyr22NnZIsfJmUvUzNGA+vVCekY5Gs0g8nQwFopjmFV6QpzXF2v+q7ApNe8FqFtU2wh+l180Y0oXXlTsJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690674; c=relaxed/simple;
	bh=m3AHjAGf7wNGQRONduP2WpaF02GYVMNP79JHLZ4bZXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WccsgD1iH59etZKb0pEVEuZo1mHBKo4vHBvsqWplkk/iFvZfU0zktJ4Ax9+XwuNhIDOkaXgosF4vPMGbkAOVetNVj7RmGmYJrcp4WUffZPheNzKYtKqnnQxuArXpOsACvQjIsvUXIBVv1RjKtPp6AhAz3qL5Nbbk8JDTX/Kd2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sUktgrn5; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779690672; x=1811226672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G7IRILx4fqbdy4M6asrDtYanPlHZYggTE05t50wLN+U=;
  b=sUktgrn5ILIMhqSwq/izN7EWIYLpLgE551/3/Nei8h0rT1D1hjoprPUZ
   4ZgDGcsdTYsRiOsln70eVt1vUo458wfjWrxJOTJAMhAQNjUQwZOorwp7e
   q6DzvflIGdlmU6M4MttAGhFm7yNhhfs/wNz0tX7er2T+FmFNWTlbzjlbk
   yLdtBVUcn8k4T8n9T619wBWmKxsVjaNcokJ/F+rzwDx2gmaCnixS3/mMg
   9Q5lqStgCka0x7YogGyKrflxbqhpwxt7DHGXWHPk7BvehB9KeEFvm2VvF
   VKg7iIpz7wleJwVOwwiri4yrFC1H6dhsKUEz2V9lWUvgL6ApxTXdeNpnZ
   w==;
X-CSE-ConnectionGUID: xPfPd1IMQ2CT+3qYej2Q4g==
X-CSE-MsgGUID: MHpTL54PSeG26bPIVuYVEQ==
X-IronPort-AV: E=Sophos;i="6.24,167,1774310400"; 
   d="scan'208";a="19900785"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 06:31:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:14838]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.249:2525] with esmtp (Farcaster)
 id 80645f9c-31d8-48c9-a924-52c030d69703; Mon, 25 May 2026 06:31:09 +0000 (UTC)
X-Farcaster-Flow-ID: 80645f9c-31d8-48c9-a924-52c030d69703
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 25 May 2026 06:31:09 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 25 May 2026
 06:31:07 +0000
Date: Mon, 25 May 2026 06:30:51 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache
 rhashtable
Message-ID: <20260525063051.GA27143@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-2-ynachum@amazon.com>
 <20260519130755.GV33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260519130755.GV33515@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
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
	TAGGED_FROM(0.00)[bounces-21220-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 35CF35C6895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 04:07:55PM +0300, Leon Romanovsky wrote:
> On Tue, May 12, 2026 at 06:11:20AM +0000, Yonatan Nachum wrote:
> > New EFA devices don't support the creation of multiple address handles
> > to the same remote on the same PD.
> > To overcome this limitation, introduce an AH cache rhashtable which will
> > store the refcounts of the same AH creation on the same PD and will
> > allow the driver to manage AH reuse. The hashtable key is the
> > combination of PD and GID. Add initialization and teardown logic for the
> > rhashtable.
> > 
> > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/Makefile       |  4 +--
> >  drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
> >  drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
> >  drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
> >  5 files changed, 83 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
> >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> 
> <...>
> 
> > +struct efa_ah_cache_entry {
> > +	struct efa_ah_cache_key key;
> > +	u16 ah;
> > +	bool initialized;
> 
> If this variable is present, it indicates that the reference count is being  
> used incorrectly. In the uninitialized state, the refcount must be 0.
> 
> Thanks

The refcount and initialized track two separate properties of the entry:
- refcount represents the number of active users that hold a reference
  the this cache entry. It is incremented on every create AH call and
  decremented on every destroy AH call for the same PD, GID.

- initialized indicates whether the entry holds a valid AH number from
  the device. An entry exists in the hashtable and can referenced before
  the device command completes, and also after a successful device
  destroy (when the entry is recycled fir a new create).

This two properties are independent - an entry can be referenced by
multiple users while not yet holding a valid AH, and an entry can
transition from initialized to uninitialized while still being
referenced.

Using refcount=0 to mean 'not yet created on device' would mix two
unrelated things into one variable.

