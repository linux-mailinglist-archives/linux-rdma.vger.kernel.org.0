Return-Path: <linux-rdma+bounces-17001-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO+/K4r2lWkmXgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17001-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 18:27:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC71584A5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C143300A8FE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 17:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA0344033;
	Wed, 18 Feb 2026 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SNECamYv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E222BE04B
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435653; cv=none; b=mcvG6N9ckG/fpYQGgcHpqAktDoguiCcdnjXiAEkfYJdjiD7TdRrBypsBJ+YjJZUsmMRCWwrFNd8Bg6DxyAzEleXLjiTAz4c1tdVzBfDVVRhdkFD/31ASYkQpHJFRflnCIFsiy46z9YfNFMCx9Bkyb7m1NnIBN6KxJVb08p4uono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435653; c=relaxed/simple;
	bh=CTWHegnRg4eXbrQzilzPDV0aXDg9EwNRZacrTI/nRRA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVCmaT0bQIg9pevKWcY5oZXkpL6cY0/plt1Y/2U90OpIndwuLNRHec3DL/5KYy14zojHYb9+G5okvgDmwG+2vOHlhObkMzq9eK/2Pgp8QJi3DgvbB6+dMyjzZRVT11puGSUaXEYQ30gcl+BmKB1N5xnft8j9sty4ciW5iVRRe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SNECamYv; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771435652; x=1802971652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mOWYGDIqBhxDzDFnYpDvJcwbNF1GkaKgRaSpLVKHi8U=;
  b=SNECamYvnVAwBkiWb5WFQso8gVu9bt5ighSCzTwffYF5izxuq8phSbom
   NTyxOsMJMU/wuMNkH3c6YCnko7fZOdcK+fbqk5PfnSF6pZ0xHtvdJXQ8s
   xjqolwZm+4Fcn3AXRq36Ha60hb8+ZLIjU5YccX5JMIq8PZ4qjGmR0S1mg
   1naJxfYD9Bmu/AbkMSg/XGzwTcwzSpoInrEcQOy1rkAhezeGITyluyrVd
   9qt4Zd9lPSA8ez3j1V1eky/GCde+SnbaRtXN1sEgGYtFMCUOXfXP0fXwM
   hp/1u1taovQMCQ15gDyOzHSbnJQ3ctwtMUKgPxYEptG72VSLboNCF5CZ1
   g==;
X-CSE-ConnectionGUID: XrGpzENNRSql7O+2h76BLg==
X-CSE-MsgGUID: /fqf/5ksR+qJvUlkR+Am+A==
X-IronPort-AV: E=Sophos;i="6.21,298,1763424000"; 
   d="scan'208";a="13310430"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 17:27:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:32217]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.28:2525] with esmtp (Farcaster)
 id c9c293d9-b648-4827-bc73-069bd179c03d; Wed, 18 Feb 2026 17:27:29 +0000 (UTC)
X-Farcaster-Flow-ID: c9c293d9-b648-4827-bc73-069bd179c03d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 17:27:29 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Wed, 18 Feb 2026
 17:27:27 +0000
Date: Wed, 18 Feb 2026 17:27:20 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Gal Pressman <gal.pressman@linux.dev>,
	Tom Sela <tomsela@amazon.com>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260218172720.GA20529@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
 <42c8552c-eb41-43f5-bea5-fdd46edba65a@linux.dev>
 <20260215175707.GC12989@unreal>
 <20260216110853.GA6455@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260216112207.GF12989@unreal>
 <20260217145426.GA9217@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260218001408.GB723117@nvidia.com>
 <20260218091559.GF10368@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260218091559.GF10368@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17001-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1CCC71584A5
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:15:59AM +0200, Leon Romanovsky wrote:
> On Tue, Feb 17, 2026 at 08:14:08PM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 17, 2026 at 02:54:26PM +0000, Michael Margolin wrote:
> > > to monitor AH usage in production. Resource usage and traffic counters
> > > are usually collected periodically (every 1-5 seconds) by dedicated
> > > collectors (e.g., Prometheus node exporter). 
> > 
> > Can you just have two simple stats
> >   '# HW AHs created' 
> >   '# HW AHs destroyed'
> > 
> > and the value you want is the simple difference?

I think that adding two separate counters as you suggest under
/sys/class/infiniband/*/hw_counters/ can work for us.
Will submit a new patch for this option.

> 
> Which can be collected from FW through FWCTL?
> 
> I don't super excited to see slow, unique sysfs UAPI field in RDMA
> subsystem. They are interested to get FW information, let's use
> interfaces which are intended for it.
> 
> Thanks

Leon, the device currently doesn't expose this info and it's generated
in the driver.

Michael

