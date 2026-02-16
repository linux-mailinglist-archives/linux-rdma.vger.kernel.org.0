Return-Path: <linux-rdma+bounces-16912-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF36JTbmkmlSzwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16912-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 10:41:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F44142055
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 10:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55FC330011B3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F72E7BCC;
	Mon, 16 Feb 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j22ZHtnO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260882D060D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234865; cv=none; b=R9X+Mwp9KGuEBwcf3ywdCC57cLDtrVsRYWZ/n4nNXenfMv8YTgoqu6igf8AjrmbKKDkNWIuHBH5YewIiTAOHhciXDUDWDc/LcC2OmSYPol8z6lrAwfqr3WvsCSs1lUdtX9ZzctAYoqK7QbQ0kuN9vDCFooJPlGkobNR59z1smi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234865; c=relaxed/simple;
	bh=5axDNY+vXH2JoQ5esyl3EJ8ZxDybqM7dqMvn88FCUWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etBdltToJWm8pSJNScfnMDsS4ACQlnIkpgXFq1SkghLX9dUiDeTM0mx9RE2cfcOD/FlVk3/2F5lvRwfY5J8rmSjHP8Evs1h8Gg7tLKIOP7I6NwNJRKFOP/3HY/NJ3Q4tdGWh751t/GOGdOOisNsgT0EWKOFj6eEjFiE3T6wdQdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j22ZHtnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36187C116C6;
	Mon, 16 Feb 2026 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771234864;
	bh=5axDNY+vXH2JoQ5esyl3EJ8ZxDybqM7dqMvn88FCUWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j22ZHtnOJpghZgrbTIhgXFmICUVE5OhJqamXEdRcy0l6gBHYYaWj+2lqQGdPo3KsI
	 KJ/0rSXKtFVXWv/+ZKfOiJlqS9iFHk0ejbomW28Ku27+GwZivwB9lqbZnA/LrhBKXJ
	 drgU5/WkKNOYHIXfOakKyFtYAFA5u3Yaae0XX+SBH37+5tePrW9ytgonw0dMwOO6J0
	 KbB6m+fRruOlVa1eGeduTpqb40+B9F/mxkksxgbae/KBGEt5ipvdAkl+4KCSMsXebQ
	 Gn8UoiTJ8cIzRcqYliK6GyOgXW0x9S6kKIIGJAMHlS2gjjZZjejDJHscYG2ukEI8QQ
	 LtZuWHficxLfQ==
Date: Mon, 16 Feb 2026 11:41:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
	Tom Sela <tomsela@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260216094100.GE12989@unreal>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
 <20260216084819.GA23783@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216084819.GA23783@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16912-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2F44142055
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 08:48:19AM +0000, Michael Margolin wrote:
> On Sun, Feb 15, 2026 at 07:15:43PM +0200, Leon Romanovsky wrote:
> > On Sun, Feb 15, 2026 at 01:41:22PM +0000, Michael Margolin wrote:
> > > On Thu, Feb 12, 2026 at 06:36:28PM +0200, Leon Romanovsky wrote:
> > > > On Thu, Feb 12, 2026 at 08:52:41AM +0200, Gal Pressman wrote:
> > > > > On 11/02/2026 15:13, Jason Gunthorpe wrote:
> > > > > > On Wed, Feb 11, 2026 at 01:10:48PM +0000, Tom Sela wrote:
> > > > > >> +static ssize_t ah_count_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > > > >> +{
> > > > > >> +	struct efa_dev *efa_dev = pci_get_drvdata(to_pci_dev(dev));
> > > > > >> +
> > > > > >> +	return sysfs_emit(buf, "%lld\n", atomic64_read(&efa_dev->ah_count));
> > > > > >> +}
> > > > > >> +
> > > > > >> +static DEVICE_ATTR_RO(ah_count);
> > > > > >> +
> > > > > >> +int efa_sysfs_init(struct efa_dev *dev)
> > > > > >> +{
> > > > > >> +	struct device *device = &dev->pdev->dev;
> > > > > >> +
> > > > > >> +	if (device_create_file(device, &dev_attr_ah_count))
> > > > > >> +		dev_err(device, "Failed to create AH count sysfs file\n");
> > > > > > 
> > > > > > This is not the right way to use sysfs in rdma drivers.
> > > > > > 
> > > > > > Also we have netlink counters as the prefered approach why are you
> > > > > > using sysfs?
> > > > > 
> > > > > Yes, and EFA already supports stats reporting, the sysfs choice is strange..
> > > > > 
> > > > > BTW, isn't this something that can be added to restrack?
> > > > 
> > > > Unlikely. Most drivers that implement such counters were written long before
> > > > bpftrace became widely used. I don't think modern drivers should carry these
> > > > counters, as they are trivial to collect without requiring any kernel changes.
> > > > This is especially true for EFA, which does not support kverbs.
> > > > 
> > > > Thanks.
> > > 
> > > 
> > > This approach was selected since this case doesn't naturally fit any of
> > > the suggested ideas. It represents usage level of device AH objects
> > > which might be different than the number of kernel objects as usually
> > > covered by restrack count. Stats also doesn't seem as the right place
> > > for this.
> > 
> > How can the kernel and this new counter report a different number of AH
> > objects?
> 
> When application creates multiple AH objects for same peer, the device
> reuses the existing resource and returns its AH number. The new counter
> counts unique AH numbers thus represents the amount of device resources
> currently in use.

https://lore.kernel.org/all/20260215175707.GC12989@unreal

Thanks

