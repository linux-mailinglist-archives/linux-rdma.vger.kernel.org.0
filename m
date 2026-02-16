Return-Path: <linux-rdma+bounces-16915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEswN+n9kmkn0wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 12:22:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE9142D99
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E19530013AA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 11:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BAF2C0299;
	Mon, 16 Feb 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLwC/zyi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BF15A86D
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240932; cv=none; b=R4DNS7e8XFAMsjH2Nm9FzEgDcCMl+CUK8VbJGgfh0AtHCoDgxeSmKx9VDJGb2QfZJ4hrOv3gIfFVa8VUr1nnWySpRNrq+b+ZuzmuUP6tWBR0gzoybpdTOr8huADEw7MvmvSzTS4LDY7yKHaEOk2qGjwKE5ejyF3AFpFJjoeOlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240932; c=relaxed/simple;
	bh=R9U1GS3NPSuyaNAdW+lacV0M3jRZQqrmQfS92XSKPMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqddRZ5sY7t5lSeFjk0TxdWzdHY0fQF5FkYs4rxl9E/I60f5nzQ2lBh8d+Hhzd/QSV6gk96u1LZOrUlK5qgK1Ha0GwY4HR0qC3ZCCxwTgjS1+Y4PxAjGJ1CTcISr53YsDrlN+A3KxgKQFayfRFjI1gRrNTbT19ppLCpvJBJCJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLwC/zyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49B9C116C6;
	Mon, 16 Feb 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771240932;
	bh=R9U1GS3NPSuyaNAdW+lacV0M3jRZQqrmQfS92XSKPMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLwC/zyinmLBzD8Xc2XUUsqjABc/jwxbMivyhhurt5yS3dCsmiWf0osLAQ/2MiRGV
	 /qpn6qb3p18+krbVZJCpxE8wMTCaDTfFeFFnC4MPcrayekFXLC3E9yu/LNu9VuStFn
	 5GgYMo+S8M+Yx98hTl1HT2+eAiReS+T5bi5P6HpUuEPh6fjeEGX6k5nDfhxAQwJH7g
	 dr6dc3NLiOyWx3JHynhx4NDtY3ucpjhN+vLnP51HFQl0KjqOLtXmNTGAFdqPBSaz1J
	 19xdVw7KXlYxxLdZK2QX+0aP4RTDxwsUujstDUCQw4CQNUekJnZ9wNq/qLocBw6Wk/
	 f+KVCcMLVJbwA==
Date: Mon, 16 Feb 2026 13:22:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
	Tom Sela <tomsela@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260216112207.GF12989@unreal>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
 <42c8552c-eb41-43f5-bea5-fdd46edba65a@linux.dev>
 <20260215175707.GC12989@unreal>
 <20260216110853.GA6455@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216110853.GA6455@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
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
	TAGGED_FROM(0.00)[bounces-16915-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 03AE9142D99
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 11:08:53AM +0000, Michael Margolin wrote:
> On Sun, Feb 15, 2026 at 07:57:07PM +0200, Leon Romanovsky wrote:
> > On Sun, Feb 15, 2026 at 07:23:41PM +0200, Gal Pressman wrote:
> > > On 15/02/2026 19:15, Leon Romanovsky wrote:
> > > >> Stats also doesn't seem as the right place
> > > >> for this.
> > > 
> > > Because?
> > > 
> > > > 
> > > > How can the kernel and this new counter report a different number of AH
> > > > objects?
> > > > 
> > > >>
> > > >> In a followup series we will suggest netlink counters extension to
> > > >> support driver specific resources.
> > > > 
> > > > bpftrace is generally the right tool, unless you can detail why it does not  
> > > > fit your specific debugging scenario.
> > > 
> > > I don't understand, how do you use bpftrace for this use case?
> > > 
> > > Once you get to debug a system in a certain state, bpftrace won't help
> > > you see events that happened in the past. You won't be able to know how
> > > many AH were created.
> > 
> > Their proposed counter can be implemented by counting calls to
> > efa_com_create_ah minus calls to efa_com_destroy_ah.
> > 
> > You have two ways to get it:
> > 1. run bfptrace with your reproducer
> > 2. check FW to get their internal counter
> > 
> 
> Calls to efa_com_create_ah minus calls to efa_com_destroy_ah will not
> always result in correct number of consumed device resources as multiple
> calls to efa_com_create_ah can return the same AH number.

bpftrace supports map and can count unique ids.

> 
> Additionally we are looking to expose this info to customers without
> requiring a kernel rebuild or the use of debug tools, similar to how
> device and port statistics can be read in sysfs or through the rdma
> tool.

BPF doesn't require any kernel rebuild. It works out-of-the-box on even
old kernels.

Thanks

> 
> Michael
> 

