Return-Path: <linux-rdma+bounces-19176-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBz3IubP12mrTAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19176-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 18:12:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA663CD776
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6339D307AF65
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EA375AAB;
	Thu,  9 Apr 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cp5zddxJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6709F34A76F
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750422; cv=none; b=Vc52R4APDBa3P6kl9y36F9ZbTbYp4/I3cs3WK8GQbtBahwMFyDNHFSd3o3eQQOpey2tcZbC8wn0/f/987M8XNJlQ+0W/38fl1JqwtBK3BUoBrubSxzV6uki+G2I1uRQnDBZHil5oKEwhhAlTr7Sb8gvB67FLBhYooMVVxZvq0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750422; c=relaxed/simple;
	bh=BRyxd8eIqVfbKjDaka/YZtTu3FZfObcLxdyJchr2Uv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFZArDksvMT3mkAgeSEqO9Ra7V+C2MtCepkcfWxw+F+7FzLlEumi9F3AIUwg47cfyA3J6KUjVVLlzfzx9zImHV5433/IuuK6efzJEZnkWS5lOUReCOnxq9l83WrqiH7W7e0G9VE5w1/vU0YqDy0CcRMgmpGr0f5FyT6yGW1F7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cp5zddxJ; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775750421; x=1807286421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=biZbEkI8GC5VHdjWm5IlA1A0M4GLQyJXSe4keEcptJU=;
  b=Cp5zddxJjiKk/INlKITROQv+t0H7IUfwmQCb1eIY+QCH3KCmvgTr3M3N
   3vAJkfMV6xE3/tAZ9f+0cmQaPr/t5kjy3WZC8I67xhg3UuSqbkIvC7por
   RycZn0nWr+ksVZ5By8w74LdI1e1gHEMMQmvzrbOHGoDmAf0NPBXelFqgy
   6OGEwJ1tI+v5HT/uiy3uo12yEOeBpT1ZerWERgqfDdz32btw209wuEEYy
   rWYb2vWy869fsC/LAeZ3u1MDpSfyLW0X3qJUx5pjOKNXqsbeqk551BYOj
   e/gkq23KC0izjuZ2IwLq9EEkcHloL7vU5+a7QEFLzvBymO+N1Nu9E/Etp
   w==;
X-CSE-ConnectionGUID: 10sneoSmR6CPPTNS6ToykA==
X-CSE-MsgGUID: dFRM7t9FSUalOHWQB5tJhA==
X-IronPort-AV: E=Sophos;i="6.23,169,1770595200"; 
   d="scan'208";a="16943415"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 16:00:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:13415]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.233:2525] with esmtp (Farcaster)
 id a5de5fb5-74e5-4495-9deb-4d73159a3216; Thu, 9 Apr 2026 16:00:18 +0000 (UTC)
X-Farcaster-Flow-ID: a5de5fb5-74e5-4495-9deb-4d73159a3216
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 9 Apr 2026 16:00:17 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 9 Apr 2026
 16:00:16 +0000
Date: Thu, 9 Apr 2026 16:00:07 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Yonatan Nachum
	<ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Message-ID: <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260407141731.GC3357077@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19176-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0EA663CD776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:17:31AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 07, 2026 at 11:54:21AM +0000, Michael Margolin wrote:
> > +static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_CREATE)(
> > +	struct uverbs_attr_bundle *attrs)
> > +{
> > +	struct ib_uobject *uobj = uverbs_attr_get_uobject(
> > +		attrs, UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
> > +	struct ib_device *ib_dev = attrs->context->device;
> > +	struct ib_comp_cntr *cc;
> > +	int ret;
> > +
> > +	if (!ib_dev->ops.create_comp_cntr ||
> > +	    !ib_dev->ops.destroy_comp_cntr ||
> > +	    !ib_dev->ops.qp_attach_comp_cntr)
> > +		return -EOPNOTSUPP;
> > +
> > +	cc = rdma_zalloc_drv_obj(ib_dev, ib_comp_cntr);
> > +	if (!cc)
> > +		return -ENOMEM;
> > +
> > +	cc->device = ib_dev;
> > +	cc->uobject = uobj;
> > +
> > +	ret = comp_cntr_get_umem(ib_dev, attrs,
> > +				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_VA,
> > +				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_FD,
> > +				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_OFFSET,
> > +				 &cc->comp_umem);
> > +	if (ret)
> > +		goto err_free;
> > +
> > +	ret = comp_cntr_get_umem(ib_dev, attrs,
> > +				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_VA,
> > +				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_FD,
> > +				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_OFFSET,
> > +				 &cc->err_umem);
> > +	if (ret)
> > +		goto err_comp_umem;
> 
> Seems a bit weird to have two things inside the object? Why not have
> the counter support all events and if userspace wants two it can just
> create two? There is alot of code to support this err/not err split..
> 
> Did any spec define the API this way?
> 
> Jason

EFA actually has a single counter object type that can count all events
as you suggest here, but I chose to define a single container for
success and error completion counts in core for three main reasons:

1. Consistency with userspace - we usually have a 1:1 mapping between
   rdma-core and kernel objects.

2. Although the UE spec does not define HW interfaces, it does couple
   success and error counting.

3. A single object for success and error completions gives more freedom
   to device implementations. For instance, it allows optimizing device
   HW resources by implementing the error counter in a less performant
   way.

I think the main code overhead is in the duplicate add, inc, and read
flows. We can reduce some of it by using a success/error enum instead,
though I personally prefer explicit functions.

Michael


