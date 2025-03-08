Return-Path: <linux-rdma+bounces-8498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C791BA57D83
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14F917234A
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F471EB5EB;
	Sat,  8 Mar 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5NWYhpb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A211E8337;
	Sat,  8 Mar 2025 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459615; cv=none; b=L9aNVfqephq7IOSjIYJhAMHJAgoz7Ob72/3j3KKGxLuq0CLWXWpEOMj6tPuxcrn3XbwTdhSkVJbwVME7ckI1QzkdBv8dkgHO6GZT76vG07oVSvx+LAFTDaNPZSWcdh2VX19fRUyIbLmheYsyjmy3u1vEQglxXFiVJtQ8entYEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459615; c=relaxed/simple;
	bh=QODW/xwdjtYBiu31jaIXaqBRk3n3h2GEjYl7HDeNYwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIDCxJzkCm6i8TUys8WAl0HDffHIVnmGJK2jG4W1ROLHuVM83cJIsYGQJwgl0R3aNe1fCD41goNzo9FFvrgDAaL5Od4AZkEPqJNcUL8ithAOzt7VBL47gdtfyMnPv2yHKJ8rj3SPuB3mEqKDlsdnFloulhHc5fw1UMzz4J4eNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5NWYhpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33084C4CEE3;
	Sat,  8 Mar 2025 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741459614;
	bh=QODW/xwdjtYBiu31jaIXaqBRk3n3h2GEjYl7HDeNYwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5NWYhpbvDKerFfGR3u/9yd9QYvvpB2T0zKDzzOl2FaggNQA7vuH4ztTWPMKAjnYV
	 V3xVCBWtoKc32A0q+URMtUl1yuoXn1w3S+KHidfgGAgkPS0aFSm5i0nv+SxBDZC/xr
	 7/h7xr4vX/rDnQbIPu8XUyNLcyLosK/EFM6dsbGDFcwR5vItpEzgGSRipZn1H9lHfg
	 vq65E+w5R6zYDFc38R+YbRVZ6ZrnYTiUYifDOZgW8tvx+Zv2Rd/NTgw5QYKuzdofb5
	 84fv8M4KrPTUCF6R6iNXufz68J/so6KU8iDWtsmCNxV5FZrSRXIm/Vv8+9dd/u4oHZ
	 8IsJ/RUIEOSJA==
Date: Sat, 8 Mar 2025 20:46:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Nikolay Aleksandrov <nikolay@enfabrica.net>
Cc: netdev@vger.kernel.org, shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250308184650.GV1955273@unreal>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>

On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> Hi all,

<...>

> Ultra Ethernet is a new RDMA transport.

Awesome, and now please explain why new subsystem is needed when
drivers/infiniband already supports at least 5 different RDMA
transports (OmniPath, iWARP, Infiniband, RoCE v1 and RoCE v2).

Maybe after this discussion it will be very clear that new subsystem
is needed, but at least it needs to be stated clearly.

An please CC RDMA maintainers to any Ultra Ethernet related discussions
as it is more RDMA than Ethernet.

Thanks

