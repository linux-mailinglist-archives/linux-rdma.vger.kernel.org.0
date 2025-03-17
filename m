Return-Path: <linux-rdma+bounces-8743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728EA64ECE
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35736188CFF8
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255423BD02;
	Mon, 17 Mar 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3nJSHWB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1692623BCE9;
	Mon, 17 Mar 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214610; cv=none; b=eJGblA9qjNMHFJr102YGp/zuzL8niRxa/D3MLBQUdUZKHTbZr6cwLdkEgK+Ojl5RIWU7b7lwWKV/sTgPRNyAhs+JgdIDyEOkPl6sSJWkyX+ZIwP4r8m2AF1+rtyYvN64pGuwSqbnMdd4w5MyMpeJG7rE43Ffcxma3utnhV8Iy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214610; c=relaxed/simple;
	bh=veUB5/lvZImGVhjpD0lDG5HFUre8yRMr6MNFn4V52Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkq0+WY0jnzsmPbPn/7DbmVADgPHwwkTLAAnARgcsXtdXioYbin+vKyVCb910w87eHv/+1zRlo83/tXHFRphTS26yj4XDxwSbumm4NzgFGaiultmKvY0fyk4Oh3rrOst/rZ3uiCSLBTUabolV7YyP195f3yQqwbFkevf9MoXF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3nJSHWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE3BC4CEE3;
	Mon, 17 Mar 2025 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214609;
	bh=veUB5/lvZImGVhjpD0lDG5HFUre8yRMr6MNFn4V52Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3nJSHWBh8TU62q+Vys7O20muLzNKN0x2uohhcD/1h2VXCvBMnUvnBiahs9Xfp/qf
	 bXMqbnr1rfdhihVToENq5fHixiznPWTNoI4RPH6Py6Rgbfo3Q5B/QSs5Zh51JVOecQ
	 R0U64UBRrla2TraHc0AKqdXbFGUDz6rk5B+bEVMzFDNcN5qfvCay4zOjIdE7uUc8EF
	 I+AX0SCMrS4IvtbAbitJ//zlByXAJxRKwl11CajPtVw1z/uZc2ZUG6kJ1G7iblaVLD
	 8Ev9Z2GOU8sa7i4gQekS3BQV+F4kafTU3WwZek0/wP6SoodEiTn0tCuA970XLmQvhi
	 UzdA9kq3JFL+g==
Date: Mon, 17 Mar 2025 14:30:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>, netdev@vger.kernel.org,
	shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250317123004.GU1322339@unreal>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <Z9SW1WI6EKtA_2KL@mini-arch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9SW1WI6EKtA_2KL@mini-arch>

On Fri, Mar 14, 2025 at 01:51:33PM -0700, Stanislav Fomichev wrote:
> On 03/12, Leon Romanovsky wrote:
> > On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> > > On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > > > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> > > >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > > >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > > [snip]
> > > >> Also we have the ephemeral PDC connections>> that come and go as
> > > needed. There more such objects coming with more
> > > >> state, configuration and lifecycle management. That is why we added a
> > > >> separate netlink family to cleanly manage them without trying to fit
> > > >> a square peg in a round hole so to speak.
> > > > 
> > > > Yeah, I saw that you are planning to use netlink to manage objects,
> > > > which is very questionable. It is slow, unreliable, requires sockets,
> > > > needs more parsing logic e.t.c
> > > > 
> > > > To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> > > > fits better for object configurations.
> > > > 
> > > > Thanks
> > > 
> > > We'd definitely like to keep using netlink for control path object
> > > management. Also please note we're talking about genetlink family. It is
> > > fast and reliable enough for us, very easily extensible,
> > > has a nice precise object definition with policies to enforce various
> > > limitations, has extensive tooling (e.g. ynl), communication can be
> > > monitored in realtime for debugging (e.g. nlmon), has a nice human
> > > readable error reporting, gives the ability to easily dump large object
> > > groups with filters applied, YAML family definitions and so on.
> > > Having sockets or parsing are not issues.
> > 
> > Of course it is issue as netlink relies on Netlink sockets, which means
> > that you constantly move your configuration data instead of doing
> > standard to whole linux kernel pattern of allocating configuration
> > structs in user-space and just providing pointer to that through ioctl
> > call.
> 
> And you still call copy_from_user on that user-space pointer. So how
> is it an improvement over netlink? netlink is just a flexible tlv,
> if you don't like read/write calls, we can add netlink_ioctl with
> a pointer to netlink message...

You need to built that netlink message, which you do by multiple copying
in the user space.

I understand your desire to see netdev patterns everywhere and agree
with the position that netlink is a perfect choice for dynamic configurations.
However I hold a position that it is not good fit to configure strictly dependent
hardware objects.

You already have TLB-based API in drivers/infiniband, there is no need
to invent new one.

Thanks

