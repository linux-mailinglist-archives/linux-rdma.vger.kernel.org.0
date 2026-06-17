Return-Path: <linux-rdma+bounces-22311-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XCWPKM+UMmqw2QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22311-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:36:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318C699C43
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:36:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YMgMPnRR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22311-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22311-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A9ED31AA26A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04BC3FB7C7;
	Wed, 17 Jun 2026 12:28:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033E3F6C3E
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 12:28:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699332; cv=none; b=H702H1Fe78WA4lm8zF+2kee30YGV4fw2p8D4snjHC+0qcmTPEmAXNoHiopIrXUBrwi+YBgKtIVgn+QYjkOKO/EGzA/THjqfdH0PcYcdnRWAt/9e7gweWetMwdOr7DDsClKlKwVS2X8wbdZUPzNXOGhfYzYtqNpzRR8xtdPIps3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699332; c=relaxed/simple;
	bh=e6Mbx8iGLK2U672Bu1Xhun/H/CuDFlmqhsHKHrmTXFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJm4le9qZWIM1S2KtGQnAQurKyDRfw7LTNYzXUyh3AWVAW6m8sQaMgPfeej4dYY9tglClTDi4R7l1qE3Xlg9EeSbD05xYsKyj/+YrG4gLyj8HzQAxoOiQqoqQJlb23ct5W2qcnBPOiLtuCFYge1C25QmTPVlvTasO3QcuH2jPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMgMPnRR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C67F1F00AC4;
	Wed, 17 Jun 2026 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781699328;
	bh=GrOkZD/dZg9h9C6lFPyYyoN+hS4W+21eMokRnMv3W5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YMgMPnRRglyvJa9OGPfo8GAoQ/Vhp48xNLNqHgCvOjn0qqaamzCMzBRHpLAGyghEL
	 RSyLLJOqEcw3vRMWmNhSDHpoVNBQsRvp0trWJ2md7enKfRwIadBW3RIhXpcLcZRiWM
	 sLsbsklhBxs5ggDT3tbBFpqdq4Z2zBImGENwQj7+CC/R5F3aUzXwmVgvMcSRi28OUF
	 xMm58ej04U9Ynyn0vaSSjypRiJJ7TGWLJvzlzCjsGew+obDAjm4i08w8xIv1mxrniX
	 nVQuGeeFhMxrhSjlvvhDuaXc10phOz1bGaDN5LTcjP1Cpu+DFKiM+XnXEV3WLeAURb
	 VP2VffJjfzNUQ==
Date: Wed, 17 Jun 2026 15:28:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yonatan Nachum <ynachum@amazon.com>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com,
	gal.pressman@linux.dev
Subject: Re: [PATCH for-next v4 0/2] RDMA/efa: Add AH cache for AH reuse
Message-ID: <20260617122842.GZ327369@unreal>
References: <20260608071620.1909543-1-ynachum@amazon.com>
 <20260614071229.GA29713@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260616175033.GQ327369@unreal>
 <20260616193158.GA35672@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260617002145.GB3577711@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617002145.GB3577711@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:ynachum@amazon.com,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22311-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,unreal:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1318C699C43

On Tue, Jun 16, 2026 at 09:21:45PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 16, 2026 at 07:31:58PM +0000, Yonatan Nachum wrote:
> > A global AH cache lock would serialize all AH commands for any PD-GID
> > combination, including the ones that go to the device.
> > The per-entry mutex allows different entries to issue device commands in
> > parallel while only serializing operations on the same entry.
> > 
> > The initialized flag is needed because the entry must exist in the
> > hashtable before the device command completes, so concurrent threads
> > targeting the same PD-GID find it and wait on the per-entry mutex.
> 
> I think it looks so weird because it overloads the refcount in two
> ways.
> 
> The scheme really has two different orthogonal ideas:
>  - A kref which manages the lifetime of the entry and when the kref
>    reaches 0 the entry leaves the hash. The entry is basically just the
>    mutex and a user count. The hash holds a guarenteed singleton
>    locking point to control the HW object creation order.
> 
>  - A user count which counts how many active AH's are using the HW
>    object, and if it is non-zero then the HW object exists.
> 
> The combination of the refcount and initialized is overloading both of
> these different behaviors, along with the funky refcount logic.
> 
> But given the initialized costs as much memory in the struct as
> another refcount you may as well just replace it with a proper user
> count.
> 
> Then it is alot simpler. 
>  Global lock, do the search, get the kref, unlock and return.
>  Local lock, check the usercount == 0 and allocate HW object, incr, unlock.
> 
>  Local lock, check the usercount == 1 and dealloc the HW obhect, decr,
>  unlock. put kref.
> 
> Ideally the kref put would only grab the global lock when the refcount
> is 0, but you have to be able to tolerate multiple 0 kref things in
> the hashtable for that to work.

Jason,

I would suggest that EFA start with the basics. Their command submission
path has spinlocks, so their claim of “performance degradation” should
be viewed with an appropriate degree of skepticism.

Thanks

> 
> Jason
> 
> 
> 
> > 
> > I am open to simplifying to a single globlal lock if you prefer, but it
> > comes at the performance cost of serializing all AH commands.
> > 

