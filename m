Return-Path: <linux-rdma+bounces-16788-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL3iBvYBjmm0+AAAu9opvQ
	(envelope-from <linux-rdma+bounces-16788-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 17:38:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA7E12F869
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 385FB300D33C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F935CBA8;
	Thu, 12 Feb 2026 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMU86rGe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33342A96
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914193; cv=none; b=unyRhJe39crEWKbNNaELAszBOBiqdUAu1ID5AMQHd66nG1txbQpjb45eaXOY17CtBfd24yIHDuD63feI7v91dnjdCCeH5cX5wSt/b+hRXh+IyyLV14L+b+vdoKivdDnQW4FnKiI+qJ2YwtMF5S/p983HlMHh5tyjKfogerxfyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914193; c=relaxed/simple;
	bh=jmHRpnxPK3cUlrIKti/BbXXqgLhtmDyOa7VBeGPm0Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFVWddx+IJQQ4kmPbHKwLTPcMj/DrLY0Xzr6cbkt7auUkEzQHzZT9f9jZ6qWSORoF5Ge4HeHLdhSnPlBNRc7Y5evuCHLDxbxFkgplf52eWGHBEeyzx3Kv/HVoX9vP9sfBjMEloyD6dKeWDt9NgwpFBvzhR/bNALjVLWJOIng+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMU86rGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C90C4CEF7;
	Thu, 12 Feb 2026 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770914192;
	bh=jmHRpnxPK3cUlrIKti/BbXXqgLhtmDyOa7VBeGPm0Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMU86rGeZ919MTayUZVtacd4PFP9nIg0aFl8shkC2lKzgdlnF1tetzDUnXuy+ymRv
	 ULwdZc+JBzoiJvrcECIlQYRiiQVRqE+Nql2cSXe7tY4vNpe8ALKHsOa07eDjrn4RCc
	 qXQfpy9RgD3qCF80dVMCuIqnP5tvk9VYc8zGtp8eYOHnMtpfIxQP04lsVugZR1H3kp
	 ZMG57n7uFwjNvc7+72lMojfbRTmQ39JFCc5sn30A9lAEw1JYCCuQ+9yZq+lIZHvHeK
	 4fWI1gm81u6eZX39VWI/rNg4EseSG3m1v/TPKWDQnGFkNayjoTV1tPFVtZsssWscus
	 FqKnpUzR8ASTw==
Date: Thu, 12 Feb 2026 18:36:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Gal Pressman <gal.pressman@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Tom Sela <tomsela@amazon.com>,
	mrgolin@amazon.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260212163628.GG12887@unreal>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16788-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AA7E12F869
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 08:52:41AM +0200, Gal Pressman wrote:
> On 11/02/2026 15:13, Jason Gunthorpe wrote:
> > On Wed, Feb 11, 2026 at 01:10:48PM +0000, Tom Sela wrote:
> >> +static ssize_t ah_count_show(struct device *dev, struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct efa_dev *efa_dev = pci_get_drvdata(to_pci_dev(dev));
> >> +
> >> +	return sysfs_emit(buf, "%lld\n", atomic64_read(&efa_dev->ah_count));
> >> +}
> >> +
> >> +static DEVICE_ATTR_RO(ah_count);
> >> +
> >> +int efa_sysfs_init(struct efa_dev *dev)
> >> +{
> >> +	struct device *device = &dev->pdev->dev;
> >> +
> >> +	if (device_create_file(device, &dev_attr_ah_count))
> >> +		dev_err(device, "Failed to create AH count sysfs file\n");
> > 
> > This is not the right way to use sysfs in rdma drivers.
> > 
> > Also we have netlink counters as the prefered approach why are you
> > using sysfs?
> 
> Yes, and EFA already supports stats reporting, the sysfs choice is strange..
> 
> BTW, isn't this something that can be added to restrack?

Unlikely. Most drivers that implement such counters were written long before
bpftrace became widely used. I don't think modern drivers should carry these
counters, as they are trivial to collect without requiring any kernel changes.
This is especially true for EFA, which does not support kverbs.

Thanks.

