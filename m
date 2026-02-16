Return-Path: <linux-rdma+bounces-16905-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JqdGObZkmnKywEAu9opvQ
	(envelope-from <linux-rdma+bounces-16905-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:48:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A050141A8E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68A183001FCE
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B015B971;
	Mon, 16 Feb 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tpbaq+x/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148D3EBF34
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231714; cv=none; b=fGmvQI7c2Gqj2LO5lkBo0wK8SaEM0Ir9gq4UkaCukwTKP9ffCuYTQyUiOMFO8BCP8y5+NLFfSAHHpthfiVrY9T831VkwMtNukyppMtdUJq2qK3rfLpS/J83SBUIBnc20COm8pojb3smS8yhgTHKh4rIfWtKEuc6U+zMWm47aBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231714; c=relaxed/simple;
	bh=rNAKZoHLQP6JfOdlsFWRqhOLGn7rZyDmhHMPCL2dtsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm7DwHmyYZMsFfL8t85gqKQ0K/k54LH1UCfQngKhbgJdK4p+ww38oOt7wHQYeALALbyd78oPOMb9wNA/MPMuW3DwS6ztj6g0H+qtha1gtOt7U5LIFXV2kWqozg+nITMSwauv0/9rTuGApFW9w4uQGjx6PkfYJbzmCZX6+Cq8Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tpbaq+x/; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771231713; x=1802767713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VKMspGg35kvELrSO3hKxiiqsHE25aEF+mdVmxNFMGXQ=;
  b=tpbaq+x/NHR5Zz60ZMTePaSVDIe6Hl21g2peAuY1rUCfu7CN7YDSp2BU
   0naywKwlyG6JhwInMfroeBstr2tpfoPFd4yNUup0Uf8aQGTlc+rBVfBN6
   xcpikF6u7NegFsk01RhpXHhmibxqQxWkpBfwTku6Blmk6xMMRUOzRkjqW
   XNMdiXwMm+uiJWh0Anxa1TbB2Dsr6Yy8YwHgXrcjpt1VAmFBRLMDEw+rx
   DLKVckb3vwn7CSLJeGUiNyKfoGUxr8Ta6ruKgQXJRcDtsLGiGc+1qOaGV
   spEKeoQnFQqOkGixL915OOk9KeMTDaO8mwoVGaOV1pVPNJivbIdKCkjlH
   Q==;
X-CSE-ConnectionGUID: jPPmGALkQbqqOZv6cgXMFQ==
X-CSE-MsgGUID: NdN1KQkuRFWdShO6FZAApQ==
X-IronPort-AV: E=Sophos;i="6.21,293,1763424000"; 
   d="scan'208";a="12965909"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 08:48:30 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:26223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.156:2525] with esmtp (Farcaster)
 id 1e10dcd6-686c-4ee9-b093-acdc58bc67d6; Mon, 16 Feb 2026 08:48:30 +0000 (UTC)
X-Farcaster-Flow-ID: 1e10dcd6-686c-4ee9-b093-acdc58bc67d6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 08:48:30 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Mon, 16 Feb 2026
 08:48:28 +0000
Date: Mon, 16 Feb 2026 08:48:19 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Gal Pressman <gal.pressman@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
	Tom Sela <tomsela@amazon.com>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260216084819.GA23783@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260215171543.GB12989@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16905-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A050141A8E
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 07:15:43PM +0200, Leon Romanovsky wrote:
> On Sun, Feb 15, 2026 at 01:41:22PM +0000, Michael Margolin wrote:
> > On Thu, Feb 12, 2026 at 06:36:28PM +0200, Leon Romanovsky wrote:
> > > On Thu, Feb 12, 2026 at 08:52:41AM +0200, Gal Pressman wrote:
> > > > On 11/02/2026 15:13, Jason Gunthorpe wrote:
> > > > > On Wed, Feb 11, 2026 at 01:10:48PM +0000, Tom Sela wrote:
> > > > >> +static ssize_t ah_count_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > > >> +{
> > > > >> +	struct efa_dev *efa_dev = pci_get_drvdata(to_pci_dev(dev));
> > > > >> +
> > > > >> +	return sysfs_emit(buf, "%lld\n", atomic64_read(&efa_dev->ah_count));
> > > > >> +}
> > > > >> +
> > > > >> +static DEVICE_ATTR_RO(ah_count);
> > > > >> +
> > > > >> +int efa_sysfs_init(struct efa_dev *dev)
> > > > >> +{
> > > > >> +	struct device *device = &dev->pdev->dev;
> > > > >> +
> > > > >> +	if (device_create_file(device, &dev_attr_ah_count))
> > > > >> +		dev_err(device, "Failed to create AH count sysfs file\n");
> > > > > 
> > > > > This is not the right way to use sysfs in rdma drivers.
> > > > > 
> > > > > Also we have netlink counters as the prefered approach why are you
> > > > > using sysfs?
> > > > 
> > > > Yes, and EFA already supports stats reporting, the sysfs choice is strange..
> > > > 
> > > > BTW, isn't this something that can be added to restrack?
> > > 
> > > Unlikely. Most drivers that implement such counters were written long before
> > > bpftrace became widely used. I don't think modern drivers should carry these
> > > counters, as they are trivial to collect without requiring any kernel changes.
> > > This is especially true for EFA, which does not support kverbs.
> > > 
> > > Thanks.
> > 
> > 
> > This approach was selected since this case doesn't naturally fit any of
> > the suggested ideas. It represents usage level of device AH objects
> > which might be different than the number of kernel objects as usually
> > covered by restrack count. Stats also doesn't seem as the right place
> > for this.
> 
> How can the kernel and this new counter report a different number of AH
> objects?

When application creates multiple AH objects for same peer, the device
reuses the existing resource and returns its AH number. The new counter
counts unique AH numbers thus represents the amount of device resources
currently in use.

> 
> > 
> > In a followup series we will suggest netlink counters extension to
> > support driver specific resources.
> 
> bpftrace is generally the right tool, unless you can detail why it does not  
> fit your specific debugging scenario.

This isn't intended for internal debug use but is aimed for end users to
allow tracking of a limited device resource usage by their applications.

Michael

