Return-Path: <linux-rdma+bounces-22544-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CLQAK7ctQWrjlwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22544-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 16:20:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6A6D40BF
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 16:20:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OVjQcmUI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22544-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22544-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 765A7300879B
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C733A7D73;
	Sun, 28 Jun 2026 14:20:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91836492A
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2026 14:20:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782656434; cv=none; b=XEDm+T4v92tp8r+bpwBcMhBBRAvVgemP9GMiiZbPf3mtCiUPFqmfC0MupPB6OaDCUMY45ojHj4Xy3RBRSX8Rx4lIfFXJRYVWWh3VBbLbviPS7H5yxkr9rg2wVTt0tqnw6jShdh151bhgOPWg5CQgMQCI3QP06ECvWCdJznolBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782656434; c=relaxed/simple;
	bh=DME1A9kYC0vpVXdpuDyjtBzaIRXFuwoE3ygSvRQy6Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofocLKDh7Ioy6ZUDI3/qxoYTUbLboiB97UbtiIGB4b7Z9BaRkbdbhjbnB/aLYXpdjW6kxRkfeSaYGQME+HB+QKQastfN8drk/gg4SJ8CRvlT08TSSEyFFDX7vZvsoxcrRQ+lNPdR5A/k0t7aAWdg8whJpfKCAABGgdcr+YXR024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVjQcmUI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A80C1F00A3D;
	Sun, 28 Jun 2026 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782656433;
	bh=UWuiG7SWAs1hAxC9pRr9Q8Dn50ePtIzwA9LmhKHZhXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVjQcmUImehVDbp+1njEZLH3mvKTCtxnZt2dWSQ7ddQqzVsV6DUJ+03RQL6cVJJHT
	 kmRx4JtJBo7kDLZR8aANb2GxkW6CfUI9OUIYT/qzhGNy8mFrxvxmeS62Ll4N6gzqzc
	 MfimDkGXeTTIpzvDFMo6CbUESRaySP+zPtTeDvY3FdXd3Ol66rD8VLux5W8O/Pnynf
	 WjWjmfa/8YxGyEZpS5eC5qpWTMqZeah/ynRpox2/8/s4g3gzG0bGMJ0Da8JVulDClI
	 LqzYZGNArDuibv0Xh1ulYnqirJdp8QPge8xmMxssoql45w1iuqcEq4OIbsXKNI2NeS
	 OuI4RmFACkJ8Q==
Date: Sun, 28 Jun 2026 17:20:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
	mrgolin@amazon.com
Subject: Re: [PATCH rdma-next v2 4/6] RDMA/uverbs: Add ioctl method for CQ
 resize
Message-ID: <20260628142026.GB33710@unreal>
References: <20260615085040.1396623-1-jiri@resnulli.us>
 <20260615085040.1396623-5-jiri@resnulli.us>
 <20260617110605.GV327369@unreal>
 <cb0200ba-e1f1-4106-9e1e-74e4118d9106@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0200ba-e1f1-4106-9e1e-74e4118d9106@cornelisnetworks.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:jiri@resnulli.us,m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:mrgolin@amazon.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22544-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BC6A6D40BF

On Thu, Jun 18, 2026 at 11:40:29AM -0400, Dennis Dalessandro wrote:
> On 6/17/26 7:06 AM, Leon Romanovsky wrote:
> > On Mon, Jun 15, 2026 at 10:50:38AM +0200, Jiri Pirko wrote:
> > > From: Jiri Pirko <jiri@nvidia.com>
> > > 
> > > Resize CQ is currently only reachable through the legacy write()
> > > uverbs command (IB_USER_VERBS_CMD_RESIZE_CQ). Add an equivalent modern
> > > ioctl method, UVERBS_METHOD_CQ_RESIZE, on the CQ object so the
> > > operation is available through the ioctl interface and can carry
> > > per-attribute extensions. The handler mirrors the legacy command: it
> > > looks up the CQ, calls resize_user_cq() and returns the new cqe count.
> > > The legacy write path is left in place for ABI compatibility.
> > 
> > I have a general question. Do we actually need CQ resizing, given that it is
> > rarely implemented and often incorrect in existing drivers? Maybe this is a
> > good time to consider deprecating that path.
> 
> Can you expand on what you mean by incorrect in existing drivers? I mean I
> see a glaring coding bug in our implementation but I can patch that.

I had "create/resize CQ" series which fixed locking in all .resize_user_cq()
implementations. The series stalled to give Jiri some space with his umem work.

Part of that series can be found here: https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=create-cq-entries-v1&id=c4f7b5999b4015609481657b437a92346a018d2c

Thanks

> 
> -Denny
> 
> 

