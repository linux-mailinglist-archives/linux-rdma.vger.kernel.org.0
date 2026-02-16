Return-Path: <linux-rdma+bounces-16914-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIZkHNj6kmlx0gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16914-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 12:09:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF4C142AFF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25665300B07C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BF2D63E5;
	Mon, 16 Feb 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EsTV1+ma"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F723EA93
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240149; cv=none; b=gJHImbZv9yXiJC7HxjtkTErSM8kGUI/Y9NSqWGZtkK3kdAlCAcSQy6/40Xz7UCtQ+95ff9uM3TvcoN0vhvfqL2ewIEJzlLMr7bHW7IhI8+wyjeqPHeKxo30avd+TeMM0wjhdW363kzvsm+GPqbxXac2CtLfPpQzJ0YdI8B9Oz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240149; c=relaxed/simple;
	bh=WdlO9akZcxOEQ9YP8dyYUzB1ymuVmvj7UoeDv9m2hjg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0RRSPI6jXE5GAL5k5QzFNL90jadr0eL4Ggk8Qaj1d4USOoGZo09fETwgW9RqyXfHAKge/4sitvvRERG0UIZXfOG27KEii9hwDY6Xc4L7uj0nnrv2hfjykJQ8nFoVqk2XF1CU9URiUFpd5OX/v7+zfeYusiCqcyNuDUghkmYRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EsTV1+ma; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771240148; x=1802776148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsbPcjgdLBE68kl7o7TXIeUSh+s94Xi3L3UR2VQV1nQ=;
  b=EsTV1+maFGJUfz3oHBv1dZKp5nZqiN2qqDvRNT0gBSXOJg46wDKEyYoy
   7QibupAALzZ29mZ9wLbAV/74qQKh+OtLhV1iCZlANwnN8nChfb7aCNb1L
   zZQ/xfXJFiFoR3fCflgxRzLxDx9Cfb0v0ggNfM/7NllTXAJI8L1/WF9Bt
   f4Ko5ALrZmAflX6b7Q5TwHTg0/zIRgxmBH/dgQ06L+8O9OOYzXHqguAbz
   99r8cAyeaxYoEX+Seqa5eQ78v3evtH6yYMqjfYzwKRGFogtr44PnkRykq
   bsg6n1CXOU238XcPsfj80LOTwcyrizFyQFrTm0Sw2H1GnnymbIyyJ8rmZ
   w==;
X-CSE-ConnectionGUID: KpPGVMfUQZSGbmcxx/y48A==
X-CSE-MsgGUID: z7hDltksTECJW08CQ/JbmQ==
X-IronPort-AV: E=Sophos;i="6.21,294,1763424000"; 
   d="scan'208";a="13144598"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 11:09:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:24333]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.12:2525] with esmtp (Farcaster)
 id e690f8be-3005-42bf-8279-4aa67f358a5b; Mon, 16 Feb 2026 11:09:05 +0000 (UTC)
X-Farcaster-Flow-ID: e690f8be-3005-42bf-8279-4aa67f358a5b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 11:09:02 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Mon, 16 Feb 2026
 11:09:01 +0000
Date: Mon, 16 Feb 2026 11:08:53 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Gal Pressman <gal.pressman@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
	Tom Sela <tomsela@amazon.com>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260216110853.GA6455@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
 <42c8552c-eb41-43f5-bea5-fdd46edba65a@linux.dev>
 <20260215175707.GC12989@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260215175707.GC12989@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16914-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BFF4C142AFF
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 07:57:07PM +0200, Leon Romanovsky wrote:
> On Sun, Feb 15, 2026 at 07:23:41PM +0200, Gal Pressman wrote:
> > On 15/02/2026 19:15, Leon Romanovsky wrote:
> > >> Stats also doesn't seem as the right place
> > >> for this.
> > 
> > Because?
> > 
> > > 
> > > How can the kernel and this new counter report a different number of AH
> > > objects?
> > > 
> > >>
> > >> In a followup series we will suggest netlink counters extension to
> > >> support driver specific resources.
> > > 
> > > bpftrace is generally the right tool, unless you can detail why it does not  
> > > fit your specific debugging scenario.
> > 
> > I don't understand, how do you use bpftrace for this use case?
> > 
> > Once you get to debug a system in a certain state, bpftrace won't help
> > you see events that happened in the past. You won't be able to know how
> > many AH were created.
> 
> Their proposed counter can be implemented by counting calls to
> efa_com_create_ah minus calls to efa_com_destroy_ah.
> 
> You have two ways to get it:
> 1. run bfptrace with your reproducer
> 2. check FW to get their internal counter
> 

Calls to efa_com_create_ah minus calls to efa_com_destroy_ah will not
always result in correct number of consumed device resources as multiple
calls to efa_com_create_ah can return the same AH number.

Additionally we are looking to expose this info to customers without
requiring a kernel rebuild or the use of debug tools, similar to how
device and port statistics can be read in sysfs or through the rdma
tool.

Michael

