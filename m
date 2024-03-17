Return-Path: <linux-rdma+bounces-1473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF1687DCA3
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Mar 2024 09:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E460A1C208EF
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Mar 2024 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5140FBEA;
	Sun, 17 Mar 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAV3Kvmz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24D4C9B;
	Sun, 17 Mar 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664913; cv=none; b=TUFqiTzN2+0ccnioyBiEncg3EwaVWiTieAJ2jhat1mo0f5fBtR3220Tyz5YSvfb/9mRjVjSkesZwK7/Ow23yEhhjhM7pxNiiUlQZ3XcxpVve3Ai2h/iQQBIcSeMwY4l2oh0mjqdHxg6CEO25z9SzK7G4DCehzNJdIlPe4ot7+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664913; c=relaxed/simple;
	bh=KYe7mcfbpEyBaVxIu8Von0fzySiopDT2W0zyPdWOo/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWkcxyrwQ4fFDCDkUU4BZADnENva/cn0XrfuAEwhxn4Kr11DEjdgVrSdsqA7kbrzZnZdkKmzx6+1pI0d2oW4lOMZCHE2IXMvV/YqOpoYhIBu6PvSjNt189KdTG8diheoHj8HKF1RRIJmpURZsyW2lcIJJ4bSiLqDmkeUMK/Gvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAV3Kvmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F464C433F1;
	Sun, 17 Mar 2024 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710664912;
	bh=KYe7mcfbpEyBaVxIu8Von0fzySiopDT2W0zyPdWOo/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAV3KvmzOibnLApF7+nQ38GO38iESk7U4xBDCSDfdJNkPn/4OO8FZjR6laExQg0QR
	 BXvDls4icw80XhFTM2Zu1+GwSr/DEzMxIgOM78XOBvKbRwCBNiAfElAfIiO69+ldwt
	 xGP3M6k+cgIbaN8YiU6nRF0M96FWCdUzOJljV3dwMxFS+r9vNxlZHDkaYtkWkAUeaB
	 j8ARepXG8aAWJ1mMmnNyzDgyng0KpQis6VgWoR0XZ/QqrLgWOSZW5BIQQp9bplVwIE
	 J4O42Pe72s914W3P4PqKWA3NLU+Qm+rsdoo2vI8HSs1HnZl9DL1ASSpBineUu1HXWa
	 9kwqpU9/g4KnQ==
Date: Sun, 17 Mar 2024 10:41:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240317084144.GF12921@unreal>
References: <20240313103311.2926567-1-leitao@debian.org>
 <b4cf355e-8310-422c-8ff8-9e96d7efc9e5@cornelisnetworks.com>
 <ZfSKskdFpbGVgnk4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfSKskdFpbGVgnk4@gmail.com>

On Fri, Mar 15, 2024 at 10:51:46AM -0700, Breno Leitao wrote:
> On Fri, Mar 15, 2024 at 12:12:15PM -0400, Dennis Dalessandro wrote:
> > On 3/13/24 6:33 AM, Breno Leitao wrote:
> > > struct net_device shouldn't be embedded into any structure, instead,
> > > the owner should use the priv space to embed their state into net_device.
> > > 
> > > Embedding net_device into structures prohibits the usage of flexible
> > > arrays in the net_device structure. For more details, see the discussion
> > > at [1].
> > > 
> > > Un-embed the net_device from struct hfi1_netdev_rx by converting it
> > > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > > net_device object at hfi1_alloc_rx().
> > > 
> > > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > 
> > > ----
> > > PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
> > > init_dummy_netdev()") in order to apply and build cleanly.
> > > ---
> > > Changelog:
> > > 
> > > v2:
> > > 	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
> > > 	* Pass zero as the private size for alloc_netdev().
> > > 	* Remove wrong reference for iwl in the comments
> > > ---
> > 
> > Very lightly tested, but interface came up and I could send traffic. Code seems
> > OK too.
> > 
> > I'd prefer to at least remove the first sentence of the commit message.
> 
> That is OK for me. Would you like to remove it when merging it, or,
> would you prefer me to resend it?

Please resend together with Dennis's Acked-by.

Thanks

> 
> Thanks

