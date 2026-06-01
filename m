Return-Path: <linux-rdma+bounces-21567-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HY8J29PHWoDYwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21567-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 11:22:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB561C56B
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 11:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFE29304F8C6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC138D41F;
	Mon,  1 Jun 2026 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OgPRmIBS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7B38F62F
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305286; cv=none; b=FfVrBPVTWAI+UnWgmmDTLQzxJLzraY76SUvP5Rppg8A4qqyxB+gqwOgahyf9oRaMov6V7zDJwfBdRtPDzFi+/ZhelnLea+lguXAbjdHaA9NUqRuEFh7PGoBSbuZhRASM2et6caGsrWasZoem30hHeuluCFl9GfKwvfpVyqQL3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305286; c=relaxed/simple;
	bh=abxmLCbUzc1k4OKqdUGERftd9LBx2yzPUCLu3zagBp4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpsueSwy+rBqN3N2eflYGIb6CXqkgvQT1Hgeusj/0RdCyvuYyBLd9fzRXBK7Px8n1YPbUbB++i5o2s88kjC7B2apT8390vkw6QIITJVPwc4e05zNiCUJyjvYyURvHaBQECGNYh9jE8e4ucDkz9WRqy0yTp+Me57BKFi6ZfOw5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OgPRmIBS; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780305285; x=1811841285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LbSd71pXQFhmHub134zp31i1n5SGDKqW4PXxQFtsn8k=;
  b=OgPRmIBSv2JtAqlE7xdrU80bv146ykIs415+xMRDOJf0uyuo62uweVRb
   a0WuYiEVF0quZAbUYKdCBdE7fc+KrHKVYK1EdH0vneSjulXzndHfFTinL
   NvkG25tqTYw9AFtqt84x5pg00MsDcLeRZQpi7jGporqbcqlMs6ygqV6Hm
   0CZDEVxRRYQf/f5c1ZXYerXt2PLAsDlB+vC6ISWx9bt7ITlGdUL38Jp/O
   6CQ7HF2F2yMdD3QnpG5AQGyQ6oCm8ZavhY0g7TKe2kgMF3sQ6AthWyyl1
   +eTfnl9rp3KiiBICjToDFGkkYwQ1ZRu7Zf2D0g8rAVxED1TGIRZC+ZY/i
   g==;
X-CSE-ConnectionGUID: kqEnrN2XSBmGACCQvMjgXA==
X-CSE-MsgGUID: P81pRX6USSGknfxlSGPMRQ==
X-IronPort-AV: E=Sophos;i="6.24,181,1774310400"; 
   d="scan'208";a="20608907"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:14:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:7414]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.35:2525] with esmtp (Farcaster)
 id d650bdb5-72f7-4159-80da-8c6dfbe6bb5e; Mon, 1 Jun 2026 09:14:39 +0000 (UTC)
X-Farcaster-Flow-ID: d650bdb5-72f7-4159-80da-8c6dfbe6bb5e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 09:14:39 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 1 Jun 2026
 09:14:37 +0000
Date: Mon, 1 Jun 2026 09:14:25 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache
 rhashtable
Message-ID: <20260601091425.GA30963@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-2-ynachum@amazon.com>
 <20260519130755.GV33515@unreal>
 <20260525063051.GA27143@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260525063051.GA27143@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21567-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B7FB561C56B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 06:30:51AM +0000, Yonatan Nachum wrote:
> On Tue, May 19, 2026 at 04:07:55PM +0300, Leon Romanovsky wrote:
> > On Tue, May 12, 2026 at 06:11:20AM +0000, Yonatan Nachum wrote:
> > > New EFA devices don't support the creation of multiple address handles
> > > to the same remote on the same PD.
> > > To overcome this limitation, introduce an AH cache rhashtable which will
> > > store the refcounts of the same AH creation on the same PD and will
> > > allow the driver to manage AH reuse. The hashtable key is the
> > > combination of PD and GID. Add initialization and teardown logic for the
> > > rhashtable.
> > > 
> > > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > > ---
> > >  drivers/infiniband/hw/efa/Makefile       |  4 +--
> > >  drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
> > >  drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
> > >  drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
> > >  drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
> > >  5 files changed, 83 insertions(+), 4 deletions(-)
> > >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
> > >  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> > 
> > <...>
> > 
> > > +struct efa_ah_cache_entry {
> > > +	struct efa_ah_cache_key key;
> > > +	u16 ah;
> > > +	bool initialized;
> > 
> > If this variable is present, it indicates that the reference count is being  
> > used incorrectly. In the uninitialized state, the refcount must be 0.
> > 
> > Thanks
> 
> The refcount and initialized track two separate properties of the entry:
> - refcount represents the number of active users that hold a reference
>   the this cache entry. It is incremented on every create AH call and
>   decremented on every destroy AH call for the same PD, GID.
> 
> - initialized indicates whether the entry holds a valid AH number from
>   the device. An entry exists in the hashtable and can referenced before
>   the device command completes, and also after a successful device
>   destroy (when the entry is recycled fir a new create).
> 
> This two properties are independent - an entry can be referenced by
> multiple users while not yet holding a valid AH, and an entry can
> transition from initialized to uninitialized while still being
> referenced.
> 
> Using refcount=0 to mean 'not yet created on device' would mix two
> unrelated things into one variable.

Hi, kind reminder

Thanks

