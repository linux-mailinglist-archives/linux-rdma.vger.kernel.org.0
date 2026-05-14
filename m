Return-Path: <linux-rdma+bounces-20717-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA14BqH7BWrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20717-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:43:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CCE544DE6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 202B830E7B35
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349134214A;
	Thu, 14 May 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUefDRv0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311133C188;
	Thu, 14 May 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776546; cv=none; b=r4t1Ozhny0TbBXKeklew+iT0yGCFtvXJV7gpmvAR5Zo1+9ai1aS99pvge6+j1pd2HKuy17bm0GgrvTEdQcG20ogNAArGbXoTryeC25GXSbZ3aUk+SAXpv5Oq1vKRwY+ab8fX3dK5XiZvR50T2dRQwgDcm4NpdGzz+ureINGLW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776546; c=relaxed/simple;
	bh=4CIiIZXYfKVFyeU61YSFxixJa7H7LcLfmxsAul2bCWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3MbFA51HaWdvazNiJQSqKIa6au1KcwWa/62xI0zsrnH9Jldv9I4rLImGglwAMIzlPuFWHe2zrdfpuTmuOtllHd3DQ5NRVub8vqVXRvidQPTbO2U7po6gkyPEQ5y0hQEjMS8LrneLBXGCPBR5MPQF7XdP1zsAo4jknduwcP02ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUefDRv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BEBC2BCB7;
	Thu, 14 May 2026 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776545;
	bh=4CIiIZXYfKVFyeU61YSFxixJa7H7LcLfmxsAul2bCWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUefDRv0In0PJ3Ep3BNH3Le4aHlzG1szmoLqrFuTjHi/3oXaIyG4Xk3XW4cISjO/l
	 hFTGyqIOLiyzfNBnXroHS9JpOvMi8gkkxwI1cfH9s5qQ/yalb8FRbMhG/dKoHnhPHc
	 2dmaFmwpVk249H5QQ1kO5SImM2KRGVAhujQZECBrpI4Ew398q3mfBMW7YgPWuiUAda
	 dG5mF/Fg7r8TIY+N7yiZp1i1g8UoV/R9GhTBBhMmV1q9W4X6SFY/r3ys3Mc9/wXjps
	 RXodYG4/BSCInFyXF5riz/DRGpzx9pSlsdjhU3jqA6wLinGW8UJHAjGea8QJsFAb0J
	 9fFwfQMlniDCQ==
Date: Thu, 14 May 2026 19:35:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Joyner <eric.joyner@amd.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH net-next 3/4] RDMA/ionic: Add debugfs support
Message-ID: <20260514163540.GT15586@unreal>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506041935.1061-4-eric.joyner@amd.com>
 <20260513072113.GE15586@unreal>
 <20260513172314.35e71e7b@kernel.org>
 <20260514060048.GK15586@unreal>
 <2026051440-devourer-appendix-4326@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026051440-devourer-appendix-4326@gregkh>
X-Rspamd-Queue-Id: 99CCE544DE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20717-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 09:04:08AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 14, 2026 at 09:00:48AM +0300, Leon Romanovsky wrote:
> > On Wed, May 13, 2026 at 05:23:14PM -0700, Jakub Kicinski wrote:
> > > On Wed, 13 May 2026 10:21:13 +0300 Leon Romanovsky wrote:
> > > > 3. The patch is too large and exposes too many details that should be
> > > >    gathered through the FW (fwctl).
> > > 
> > > Why? What's wrong with debugfs? Much easier for people to access.
> > 
> > There is nothing inherently wrong with debugfs. You can see recently
> > accepted debugfs patches from hns [1].
> > 
> > The issue here is what data is being dumped through debugfs, and in what
> > quantity. From a quick look, ionic_dev_info_show() appears to print
> > raw data coming straight from the FW.
> > 
> > In my view, debugfs should expose in‑kernel structures that are shaped
> > and controlled by the kernel itself. IMHO it is not the right place to
> > debug FW state. There can always be exceptions, of course, but in this
> > case the driver is effectively dumping everything from pds_core/FW in
> > the RDMA layer.
> 
> debugfs is for anything you want, there is nothing wrong with doing
> this in debugfs, in fact, it's preferred.  Don't spread debug info out
> into other areas, that makes it harder for admins and users to properly
> secure things from stuff they don't want users to have access to.

We are not discussing a general principle here, but this specific patchset,
which dumps information gathered and consumed by one subsystem into another.

If netdev wants to print raw firmware data, they are free to do so. I do not
want to see this in RDMA.

Thanks

> 
> thanks,
> 
> greg k-h

