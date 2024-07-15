Return-Path: <linux-rdma+bounces-3874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CA931A34
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 20:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EE11C21D1B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E361FCA;
	Mon, 15 Jul 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efM7impE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C8482EF
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067588; cv=none; b=FHfnWp5m63cE2BCKI7k0Y56Z5WY2s9RjQdIVBh6kDX0kll6wcxxUukX+pqoAB84eB3iUgKHfn+fp2t/kPNCp0pBC7F0fdEPxd0gF0v2ZKbsbRHdcxUwpLB4GWxHJWB9ZIfka1wCz87hKCdw96fYG7sOYsLgnNL4BIn9/eHAD2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067588; c=relaxed/simple;
	bh=SSOYVxnAQkS1TJ3Bvs79DLpFJv5oEzfThOygmzifS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNw/j6mhaOaItZPJ5oDI/3Q1KJri5nXd40O89PrM8R4Tv6mojiyPnIrLJnpKJaLbZn/v12Dnm3Alfj4uWveVGS/TnmgibryJTTk0jVu00j+2s/afEQea8KU9Q8a076Pjc9OT6RS1pZxPaIKkNY2byJkKGl4vzPiCzFPVoFm7BZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efM7impE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8832C32782;
	Mon, 15 Jul 2024 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721067588;
	bh=SSOYVxnAQkS1TJ3Bvs79DLpFJv5oEzfThOygmzifS0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efM7impE4AlzD7gfjZ6nTavD8XaXbKob4IGmeFucavX79PCRvsCfdiTlfyKhqAune
	 JgrZjV1hKT3QMRtvC2AXGD+uVh0+5iEQXMCC/mrZOVsLBwjozj76b178ebSRfCcl47
	 o4eXEfBc5D77Jjm8KRPvP0lHMkHNSucsMOFy/fPtLOlk6nxoWrZpeFpZBOYJJQPfMd
	 w0GALbnOXEs5+QXXU3DxrPqZZiIEBy31kFRI5+N+bHXY2qz7Po1pCLQV3aZ9xofulP
	 jSBUkGsexNR8VFMzikyoBVo9JwGORxF8hAZINR45XgzXliauadSg5vCZhr3PPBrK32
	 dfV9pb8sHZxkg==
Date: Mon, 15 Jul 2024 21:19:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Linux RDMA <linux-rdma@vger.kernel.org>
Subject: Re: How rdma-next gets synchronized with other trees
Message-ID: <20240715181943.GA5630@unreal>
References: <PAXPR83MB0559757CEB2E7CB902B8E6FFB4A12@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559757CEB2E7CB902B8E6FFB4A12@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Mon, Jul 15, 2024 at 02:07:00PM +0000, Konstantin Taranov wrote:
> Hi Leon,
> 
> I wanted to ask some questions about the merging process and its schedule.
> 
> Are patches from the net-next applied to the rdma-next during merge windows only?
> A more direct question is I want to send a patch to rdma-next, but it depends on a patch
> in net-next 382d1741b5b2 ("net: mana: Add support for page sizes other than 4KB on ARM64").
> When will this patch be in rdma-next?

RDMA tree follows standard kernel development process, which means that
we start rdma-rc and rdma-next right after (or week later) the merge window
is closed. The exact timing depends on the quality of Linus's master
after merge window ends.

After these branches are created, rdma-rc is used for bug fixes and
rdma-next is used for new features.

We are relatively lax about the quality of bug fixes up to -rc4. After that,
fixes are going under more scrutiny and can/will be applied to rdma-next
if they are not critical.

The rdma-next branch is for features and bug fixes that are not
critical.

> 
> If I sent a patch to rdma-rc, will it be merged to rdma-next later?

Yes, it can be merged to rdma-next later, but you shouldn't rely on it.

It is happening when we are required to merge something from later -rxX,
which already contains your rdma-rc patch. We are not merging
"explicitly" patches from rdma-rc to rdma-next.

> 
> Also is there somewhere a public schedule of merging windows? Or is there a mailing list with
> the merge announcements?

Linus's announcements are on LKML:
https://lore.kernel.org/all/CAHk-=wjV_O2g_K19McjGKrxFxMFDqex+fyGcKc3uac1ft_O2gg@mail.gmail.com/

And semi-joke-semi-real schedule is here:
http://deb.tandrin.de/phb-crystal-ball.htm

It is based on assumption that kernel cycle is 7-8 weeks.

Thanks

> 
> Thanks,
> Konstantin
> 

