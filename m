Return-Path: <linux-rdma+bounces-19299-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCXJH+IZ3WkJaAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19299-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:29:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A79F3EF118
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5904830C7D54
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A3627466A;
	Mon, 13 Apr 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="i/BK/T06"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8526ED41
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096885; cv=none; b=ou2T08+yT01KjvlVffl+DtTmqtWwQL7s9ICLG01Q30iGbd/LC5AKgrQzZNNPq5iPf7vE+xIEw1M+dhezEpkvRfA2UN9rbEOGSwsQZqsBZtDmYshJLvcQelUcgp+DDj4dhHm2WpP6VQ6IwL+VqkzIlyFQLa77wfvj116KW8KKIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096885; c=relaxed/simple;
	bh=jnhs0qRfDaBez6uPsEJ2WjSuZEkX6w80ruwJEhbMBmc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsbgDGgh7bOrQDNrJ9/oYCnipiV8KXsvLfyqHObHNbjQFXQQqNWxgcDj4gyDCVLDbYp2x1BBSuZ4bZLIYjl2bPctx3ScF1jfIv5nFWZ2xVyahHOAwwPPkd1ejuZXZ/R+3xdLqiubcpecdcw2vfucNs4HW2EVruNEnrIo1pLcRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=i/BK/T06; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776096884; x=1807632884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lAxh83/jP7K/hnTfdaW6ebMP30MkMWuz/1amLaXlEwk=;
  b=i/BK/T06wBOICiUETLs6sLTbuq4EULFtgL9vAR+bb6MGIw1D2BFX62av
   dDjcjLTeQtn6HZ8qjVAHd/RHKO3CA40puHNy7akTTyzxyIICYRPTV2w2O
   MkZ2a6zdxyu9kVhTxg7UfWV2aDJCSTqA8s9QfQTMuHzznyf/ScAchp3bZ
   isgHV3bQf9fp5MhYhLFXo+zn1E1RNxM/KoCyzzlpdmH9KmaJ/iXUy1lgw
   zcCzyqtHxSc09TfDBykFrhGQ65Xe4vdIFP7/uLdfFo+Z14CkiyhQlAvoA
   plJ/dFUrG72SAQAxxBmhAbcOC3jz7LUIkci92pk686kt4WM6OY7QyWmto
   A==;
X-CSE-ConnectionGUID: wPD53d/hRCWmOHgNQDsqYw==
X-CSE-MsgGUID: eVTpB7E3Sd+BkBWzBNpOuQ==
X-IronPort-AV: E=Sophos;i="6.23,177,1770595200"; 
   d="scan'208";a="17068013"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 16:14:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:17898]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.2:2525] with esmtp (Farcaster)
 id c54ac15b-9fed-4b90-8fb1-6b231abd83e8; Mon, 13 Apr 2026 16:14:41 +0000 (UTC)
X-Farcaster-Flow-ID: c54ac15b-9fed-4b90-8fb1-6b231abd83e8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 13 Apr 2026 16:14:40 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 13 Apr 2026
 16:14:39 +0000
Date: Mon, 13 Apr 2026 16:14:11 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Sean Hefty <shefty@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"sleybo@amazon.com" <sleybo@amazon.com>, "matua@amazon.com"
	<matua@amazon.com>, "gal.pressman@linux.dev" <gal.pressman@linux.dev>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Message-ID: <20260413161323.GA10653@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
 <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260409161357.GL3357077@nvidia.com>
 <CH8PR12MB97416FB899448DE69BF3082EBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20260409185537.GQ3357077@nvidia.com>
 <CH8PR12MB9741DAD52C2D8078B6D366DDBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20260409194420.GT3357077@nvidia.com>
 <CH8PR12MB974152A7540EADBDE6018FC0BD582@CH8PR12MB9741.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CH8PR12MB974152A7540EADBDE6018FC0BD582@CH8PR12MB9741.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19299-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1A79F3EF118
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 10:23:21PM +0000, Sean Hefty wrote:

> > > > > I view this as an implementation option.  One vendor may implement
> > > > > independent counters, which software can then piece together.
> > > > > However, another implementation may have a tight coupling.
> > > >
> > > > Well, this is a problematic state to end up in when deciding the OS
> > > > and library abstraction. If we don't have joined counters then we
> > > > can't really support implementations that have tight coupling
> > > >
> > > > But if we never see an implementation like that then we wasted our
> > > > efforts making them combined.
> > > >
> > > > It seems like if portals and libfabric defined them as joined
> > > > together then we probably better support it that way too as someone
> > probably made HW like that.
> > >
> > > Can we make this some general counter array, with properties applied
> > > to the array and no concern with how any specific entry might be used
> > > (at least from the view of the kernel)?
> > 
> > How does the API work? Who decides where the counter is stored?
> 
> The counters are treated as a group for the purposes of create/destroy/QP attach.  That is, they can't be individually configured.  However, they can be individually set/read, so instead of:
> 
> +       SET_DEVICE_OP(dev_ops, inc_comp_cntr);
> +       SET_DEVICE_OP(dev_ops, inc_err_comp_cntr);
> 
> There's just one 'inc_comp_cntr' call that takes the group + an index.
> 
> - Sean

That's about what I suggested above. Tried doing so and it does make it
look better IMO, will send it as part of v2.

Michael


