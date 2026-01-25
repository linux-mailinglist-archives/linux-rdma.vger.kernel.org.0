Return-Path: <linux-rdma+bounces-15986-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4RPhJRofdmlaMAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15986-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 14:48:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2502180D37
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DF7B3004262
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BDD2264C9;
	Sun, 25 Jan 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyNJ3nnm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3163CB;
	Sun, 25 Jan 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348887; cv=none; b=gkjPCsrOhvj5puq56PIuk/xi8+cQqSM0u6K4UGTGH738xBHwdUBKsostXtKrjUpcJDBumTsdRQFL9rnI6YmqHUVc1FrYZczWh7t6WKk42E2FOcGJ/s+zpB3Xs7WDDXv+h0EhcWKNA2N/OESIOo93WJ5vbGyz3fLtE/lplRmXGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348887; c=relaxed/simple;
	bh=qm4hGUc2N8j0164v/ctqVfKFMTO4VW+3W+LkYiqq1TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmv/rFI9G1IQhSQCK18k/V7GDGoQOBfPNR+aK/8jIUFiI1WhzglSBQuX1OY0ETaieiOXok8zcbwihRaMrsGnQbj0mnAQY+Vd7ZGVO60tnBhAWHagIbkx9To8mI5t+WDUwOg18FnvfPvtEeEhmQFXN7nmrlninfjVx9EEQlkCO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyNJ3nnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC7EC4CEF1;
	Sun, 25 Jan 2026 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769348887;
	bh=qm4hGUc2N8j0164v/ctqVfKFMTO4VW+3W+LkYiqq1TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyNJ3nnmKpOVP6LmuYp7LsTczIMZ7SSoZE0U+EXET77oPrjHsstxbFHLRsB83XcbH
	 QckljHW6nIF3Cqzm3lpdJASvty4/jkn8SUfnNaTkeEg6teZUm0RB8mhp179GtMmLkt
	 AJta6i8rtJnTvfr2IFdwX96TOHvQSSZZC4XNNfoTKKwCIqLecicXi2E1pRD5BaLjlK
	 3/HKenmJXfvGC102HocQtcQnxXPEinP4yYd6m4D/lkzl5pMK2XfszkErbWmDkrDm4Q
	 F6FYnFyQx7IVh62BpW2jAowJzJ3tdPbggjBnQBAJV1e32fDT58RobAOTCzj0MYiB+y
	 FzZsdgINxz8cQ==
Date: Sun, 25 Jan 2026 15:47:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sharath Srinivasan <sharath.srinivasan@oracle.com>,
	Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: release devices_rwsem when calling
 device_del
Message-ID: <20260125134759.GD13967@unreal>
References: <ec221ec7-6abb-41b7-9237-8e799bbb5683@oracle.com>
 <20260119195329.GK961572@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119195329.GK961572@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15986-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2502180D37
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 03:53:29PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 19, 2026 at 11:43:52AM -0800, Sharath Srinivasan wrote:
> > The sync strategy in remove_all_compat_devs() can improved
> > by adopting that of rdma_dev_exit_net() which releases devices_rwsem
> > before calling remove_one_compat_dev()/device_del().
> > 
> > Also fixes a comment typo in rdma_dev_exit_net().
> 
> You cannot change this locking without writing a huge commit message
> explaining in detail the reason why any change like this is safe..

We can drop this patch, it doesn't even apply.

Thanks

> 
> Jason
> 

