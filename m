Return-Path: <linux-rdma+bounces-16897-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D0ynKRbNkWn+mwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16897-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 14:41:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0339C13EBDF
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C4C300E713
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D829DB9A;
	Sun, 15 Feb 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="F9saNJ1R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6813AD26
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771162897; cv=none; b=Xncpgrk/DUrqUqE2ixRgFHEhi9NQveD/U7cQr+fNPSP5hFHqUxR5VHeCAOEw/4z454o671FIuplbyw+QqJg1xH1jBFvjwunCgAW5eyhx736DsC0hrDs4MubXedooxTenT1lzI8see7KF72ywbJhh5MZzV+6gRbtu3fxkICwCjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771162897; c=relaxed/simple;
	bh=wy0jxEuWYf4uWTPJjOd3wpmXcU2PoIV5HzVpYwS5xug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAPqECkC+j0BJBvvELo6gJX3jQmpw0fmzs9TguHefo6WinXGxY6ZEL2Tz/6vp781hr9tFdjHS/Ga2RWyiSci3tCLmkpi3eM1n2wQ+cb/fcTZyPhcOn4ZxKFbipcTlgSoG5ZnOQkCFZAQCHaycGgob+RY1pdMFfiXqswPcEmQKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=F9saNJ1R; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771162896; x=1802698896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWv4YqBB0rYHqU4qRdLNsncctuJf8kOiJOv5p8GPZ4U=;
  b=F9saNJ1RFLnvj5MKuRXwFF+l0+LJCx/tMDkO5VNR+/qyI7Uhh8Lvbk0Y
   0IkiXsD+lR1tJ8Y+L2spEHwWfKyuyC9X6bxIdSSgA+hLA8WbMtcd94O4r
   xSTnFtEJPD8PsaTied+VtQoZhlSzbKDlcKg/4STzuUAVSW1Ftd1pfdQN1
   RH+id3rffz01USpOBREbluSFdnCPOWPsRBKRWH2PG5wv/9yUIHbMWzP+g
   5Be3xH+2svNeEmYa10X3QB4T33nk9TFozgLM/m5h6D8v85nkSRoBLZgcc
   fOZ9AhFbD/pTU9C6PK+p66Xsd6VigPR7hSm49V8JSCfuZQijpYDW8UhgR
   A==;
X-CSE-ConnectionGUID: JZ5hjsdnSi6F5pi5/5sqZQ==
X-CSE-MsgGUID: njqFZafDTHeuHl8tg0zZkA==
X-IronPort-AV: E=Sophos;i="6.21,292,1763424000"; 
   d="scan'208";a="12984025"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 13:41:33 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:26334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.156:2525] with esmtp (Farcaster)
 id a4764176-1160-4674-92bc-a7e1461c2554; Sun, 15 Feb 2026 13:41:32 +0000 (UTC)
X-Farcaster-Flow-ID: a4764176-1160-4674-92bc-a7e1461c2554
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Sun, 15 Feb 2026 13:41:32 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Sun, 15 Feb 2026
 13:41:31 +0000
Date: Sun, 15 Feb 2026 13:41:22 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Gal Pressman <gal.pressman@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
	Tom Sela <tomsela@amazon.com>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260212163628.GG12887@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[amazon.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16897-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0339C13EBDF
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 06:36:28PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 12, 2026 at 08:52:41AM +0200, Gal Pressman wrote:
> > On 11/02/2026 15:13, Jason Gunthorpe wrote:
> > > On Wed, Feb 11, 2026 at 01:10:48PM +0000, Tom Sela wrote:
> > >> +static ssize_t ah_count_show(struct device *dev, struct device_attribute *attr, char *buf)
> > >> +{
> > >> +	struct efa_dev *efa_dev = pci_get_drvdata(to_pci_dev(dev));
> > >> +
> > >> +	return sysfs_emit(buf, "%lld\n", atomic64_read(&efa_dev->ah_count));
> > >> +}
> > >> +
> > >> +static DEVICE_ATTR_RO(ah_count);
> > >> +
> > >> +int efa_sysfs_init(struct efa_dev *dev)
> > >> +{
> > >> +	struct device *device = &dev->pdev->dev;
> > >> +
> > >> +	if (device_create_file(device, &dev_attr_ah_count))
> > >> +		dev_err(device, "Failed to create AH count sysfs file\n");
> > > 
> > > This is not the right way to use sysfs in rdma drivers.
> > > 
> > > Also we have netlink counters as the prefered approach why are you
> > > using sysfs?
> > 
> > Yes, and EFA already supports stats reporting, the sysfs choice is strange..
> > 
> > BTW, isn't this something that can be added to restrack?
> 
> Unlikely. Most drivers that implement such counters were written long before
> bpftrace became widely used. I don't think modern drivers should carry these
> counters, as they are trivial to collect without requiring any kernel changes.
> This is especially true for EFA, which does not support kverbs.
> 
> Thanks.


This approach was selected since this case doesn't naturally fit any of
the suggested ideas. It represents usage level of device AH objects
which might be different than the number of kernel objects as usually
covered by restrack count. Stats also doesn't seem as the right place
for this.

In a followup series we will suggest netlink counters extension to
support driver specific resources.

Michael


