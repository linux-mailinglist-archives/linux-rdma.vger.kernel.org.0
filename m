Return-Path: <linux-rdma+bounces-21615-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKgWGO19HmrnjgkAu9opvQ
	(envelope-from <linux-rdma+bounces-21615-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 08:53:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2B629338
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 08:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CD92305C522
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287D3A962E;
	Tue,  2 Jun 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YZguX6Br"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6FC3A6EFC
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383088; cv=none; b=DjEZQGbzNtm7l8XVWA4EMmNijgaKgoZnVylg1+nW6gnJHfYzXi9hammT6DfvIoMkyfq9g9IRmsKfoXjVqhobchxigXY7D2JK/UvsW7BytS4rHkLQyQrkADLa8FeyerWo2Zy80aLFP9D0/rxpAkmpUMtDyYlg4I6FHbFGdN9UyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383088; c=relaxed/simple;
	bh=p1NyNvK98bwbtrbcELzy79wYit9tJ2YegwiQSmo37O0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y88MmXNpHVpuKp5U/4EXkoQbFtwjEHKP5HdDJJCWGoYUEvxq0ocgTvjOkaj+mz9njeTRhzI3ASOLO6lJpQydHiarYhtXU2Nvy4C3poCoBeWPd6qw2kmI8qdWSKVr0r5ob11KpUSXVDiwjf85xluzwbB7PQMmFRhhJHCq+Kt7yaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YZguX6Br; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780383087; x=1811919087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8l6wervai1SZ9un4cQAdVStzASRtmRPeCe5skJH7ZII=;
  b=YZguX6Brj72vMiet9HYcpS5e8Nqkml37HsN6vbJVFgyCKvN20weKuDbI
   PtARmn03bhrT5/FSmkXIF4KeYReJFzq0Dtap5uhzvhyNMnLt16C/xYFdC
   0U0CLVHaLadt3euVhoq7iBO2MQisv6FHD6QdERLDwzF+p1rCkVvAwRPCB
   RgStpDBB8tuz7yX4h6ML6ZTHDa2jpAze53UXKsI0Y/Npm4UzNpFQrKKcO
   iZivFGWNcr41EgUKQEdwAhmh8Uc+Kb7naZFbka1gz1YNT6gVuFeCK51yt
   pCGNPFM3Ek8va3UyHACqs/0O3YkLiJ0UU43+PdTsh+l+ue8CQZ/gyC2Sx
   Q==;
X-CSE-ConnectionGUID: ZQy6Qcd1RWCIUDcZvxxPAA==
X-CSE-MsgGUID: UbSPNrfdR5iU+1Cww9zeKw==
X-IronPort-AV: E=Sophos;i="6.24,182,1774310400"; 
   d="scan'208";a="20696796"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 06:51:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:13296]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.73:2525] with esmtp (Farcaster)
 id 0239e136-276f-43ed-80d4-15532a53a183; Tue, 2 Jun 2026 06:51:23 +0000 (UTC)
X-Farcaster-Flow-ID: 0239e136-276f-43ed-80d4-15532a53a183
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 2 Jun 2026 06:51:23 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 2 Jun 2026
 06:51:21 +0000
Date: Tue, 2 Jun 2026 06:51:03 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <mrgolin@amazon.com>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: Re: [PATCH for-rc] RDMA/efa: Validate SQ ring size against max LLQ
 sizey
Message-ID: <20260602065103.GA18111@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260526081536.1203553-1-ynachum@amazon.com>
 <20260602003005.GA648279@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260602003005.GA648279@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21615-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9B2B629338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 09:30:05PM -0300, Jason Gunthorpe wrote:
> On Tue, May 26, 2026 at 08:15:36AM +0000, Yonatan Nachum wrote:
> > Validate the SQ ring size against the device's max LLQ size. This
> > ensures that when using 128-byte WQEs, userspace cannot exceed the queue
> > limits.
> > 
> > On create QP, userspace provides the SQ ring size (depth x WQE size)
> > which is validated against the max LLQ size.
> > 
> > Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/efa_verbs.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> The Sashiko comments look like they are worth addressing
> 
> https://sashiko.dev/#/patchset/20260517175216.614494-1-ynachum%40amazon.com
> 
> Jason

Hi, thanks for the answer.
That is not the Sashiko link for the patch, its this:
https://sashiko.dev/#/patchset/20260526081536.1203553-1-ynachum%40amazon.com

I reviewed the comments and none of them is relevant for the patch.

Thanks 

