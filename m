Return-Path: <linux-rdma+bounces-17794-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPCOBqTnrmlRKAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17794-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:30:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDC423BB0A
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B909305172C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887E3DFC82;
	Mon,  9 Mar 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCV5crke"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390153D9059;
	Mon,  9 Mar 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069939; cv=none; b=HsosmeQJ0vffhp1nJ1qSrb/Z/DSZFM/jG22AgYnv6fbpVN2vZxzT9fl37kKWksb04wP1QKTSHBwSbt3Fqj9jQ1MMS0rP3czEIh1tw/dRFK95LRcVONFS60r8yYXH2yCksVInFtpQtLaKhGU7HpgRXsMO+4VDL8lipGFpzG9+nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069939; c=relaxed/simple;
	bh=+3gB+EKre5DN7odYujKBBsbV40NgRajx+jcsCeWsbG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lbp/DAPtTl24Ey9AYY8eSiSgLKkbmaDefgqKDjvSpY1aIv1ON6f6qfeLl54GAtSCtTGr9RhRSqiwCaJdaTko+WZrx9a1Pw6fWdqiQUjqAVOQ+vLXoHatWR8B5u/tbYQ8p+WY+Q1InCkfInROG3pCa0IWUC/NEZYH+Vwa1U46RvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCV5crke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633E4C4CEF7;
	Mon,  9 Mar 2026 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069938;
	bh=+3gB+EKre5DN7odYujKBBsbV40NgRajx+jcsCeWsbG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCV5crke2AZzv++bgjrbQAQz9FXlqWPeGt2Ii5/JvphAwRNpTYQcXl17rPy3w0z3V
	 oPke+SSwo3PN6meSM3BriEccNUMLqblr4x/kXUFtYTVMnfK7yVMY6km9G1qXSjIQt4
	 93ZjoZnmYPdn2JeqwDTH6ZE4rfm4vRqSeV3Pl1rJ43HWU3HHFgfjMXem4NL6XW/GWO
	 nP21cCikOJkXLHPJgPL8CtHT4YN3NirT1VGNUNDn2MDuy+X5HmHxy1JAShAX9H/OnN
	 eLCrKVNKox5WJyavABbPwWe/Pi620VNTB+keSjUPnkGoMkPHke8S84/Pu3tGXv8Oz+
	 euY+1VJNmY+Zg==
Date: Mon, 9 Mar 2026 17:25:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH 1/3] lsm: add hook for firmware command validation
Message-ID: <20260309152534.GY12611@unreal>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <20260309-fw-lsm-hook-v1-1-4a6422e63725@nvidia.com>
 <20260309150253.00001ec7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309150253.00001ec7@huawei.com>
X-Rspamd-Queue-Id: ECDC423BB0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17794-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.918];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:02:53PM +0000, Jonathan Cameron wrote:
> On Mon,  9 Mar 2026 13:15:18 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > From: Chiara Meiohas <cmeiohas@nvidia.com>
> > 
> > Drivers typically communicate with device firmware either via
> > register-based commands (writing parameters into device registers)
> > or by passing a command buffer using shared-memory mechanisms.
> > 
> > This hook targets the command buffer mechanism, which is commonly
> > used on modern, complex devices.
> > 
> > Add the LSM hook fw_validate_cmd. This hook allows inspecting
> > firmware command buffers before they are sent to the device.
> > The hook receives the command buffer, device, command class, and a
> > class-specific id:
> >   - class_id (enum fw_cmd_class) allows security modules to
> >     differentiate between classes of firmware commands.
> >     In this series, class_id distinguishes between commands from the
> >     RDMA uverbs interface and from fwctl.
> >   - id is a class-specific device identifier. For uverbs, id is the
> >     RDMA driver identifier (enum rdma_driver_id). For fwctl, id is the
> >     device type (enum fwctl_device_type).
> > 
> > Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> > Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> > Signed-off-by: Edward Srouji <edwards@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Hi Leon,
> 
> To me this seems sensible, but LSM isn't an area I know that much about.
> 
> With that in mind:
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> A few formatting related comments inline.

Thanks for the feedback. I’ve addressed all comments and will send a new
revision within the next few days.

Thanks

