Return-Path: <linux-rdma+bounces-4692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA84968108
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 09:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFF41C220D6
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 07:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C256178388;
	Mon,  2 Sep 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENzNdgIp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CE3C00;
	Mon,  2 Sep 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263671; cv=none; b=bQsmFKs9pXWO/dHTSPepg8ZjiefDdXKpY6+4TIs92EJUyXWrFnr3ra7LAf8zaV5XPS/kjrzLjp+Hr2LSvI1qXknk81HVSimOVkwQY4U/2yxCkSFdfXVm7QrAdloTSAmW8PHu029NMUdojvdK4qz1U3SPdHeUp26/b6MkTwwSwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263671; c=relaxed/simple;
	bh=ir0bV4eWCqfzpJUlzWATHLEghsh+Zq9eBFPUPJ47oNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwReGWE/bUzx/g06lEzUEORj6Xq5YZ8sjw53MqQ5+Zi21B5caaujFYI4JM9RNkSj4jffFQJ/oYYUNG6q06MB4Az+MNo2ptrPjT+0do17asDabNSSjZYYgF07PNRFjBwABnt1XmBNTLKGzVFIiBP0ZbLq7CEJUi7VX8NbyZuKJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENzNdgIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F33C4CEC2;
	Mon,  2 Sep 2024 07:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725263670;
	bh=ir0bV4eWCqfzpJUlzWATHLEghsh+Zq9eBFPUPJ47oNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENzNdgIpOVhGUWeCnUtagyLIoYwOKUvIzy8cGvYJeQ5LBP+GTusQFXPzhDSliQfZ6
	 XPo10nuFx7EXVss9n4ub/iX/KHfTAxMZE/X/wvCZbgUdsknKSdk4s3POAdDInFt/cr
	 9ULGSkDJXqLYv41i4V/tZsmWEwLSs3N9z1LYFahcTKqEZdE1eVwAa6tPm7fXJi+iOB
	 Yof0lzY1JU0eVA12Ju9KLlbnc4/sEd1HIdvAGeiSmIA/4JEtjCcj/lGQShZ+sV+lYA
	 EX+fcK4zoa2aJQsOPQ49oByyoeTx+vUwfFDKIA/9HZEbyp/1fmZnJ+A7fe3P8RNIvo
	 PWZDn78Qeea/g==
Date: Mon, 2 Sep 2024 10:54:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>
Subject: Re: [RFC iproute2-next 2/4] rdma: Add support for rdma monitor
Message-ID: <20240902075426.GD4026@unreal>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
 <20240901005456.25275-3-michaelgur@nvidia.com>
 <cad1d443-ccfb-4d10-ac2d-26bb10c99d05@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad1d443-ccfb-4d10-ac2d-26bb10c99d05@gmail.com>

On Sun, Sep 01, 2024 at 08:22:50PM -0600, David Ahern wrote:
> On 8/31/24 6:54 PM, Michael Guralnik wrote:
> > $ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
> > [NETDEV_ATTACH]	dev 6 port 2 netdev 7
> > [NETDEV_ATTACH]	dev 6 port 3 netdev 8
> > [NETDEV_ATTACH]	dev 6 port 4 netdev 9
> > [NETDEV_ATTACH]	dev 6 port 5 netdev 10
> > [REGISTER]	dev 7
> > [NETDEV_ATTACH]	dev 7 port 1 netdev 11
> > [REGISTER]	dev 8
> > [NETDEV_ATTACH]	dev 8 port 1 netdev 12
> > [REGISTER]	dev 9
> > [NETDEV_ATTACH]	dev 9 port 1 netdev 13
> > [REGISTER]	dev 10
> > [NETDEV_ATTACH]	dev 10 port 1 netdev 14
> > 
> 
> at a minimum the netdev output can be device names not indices; I would
> expect the same for IB devices (I think that is the `dev N` in the
> output) though infrastructure might be needed in iproute2.

I understand the request and it is a good one for the users of the tool.

However, we will need to remember that "real" users of this monitoring
UAPI (from kernel side) are the orchestration tools and they won't care
about the names, but about the IDs, which won't be used in rdmatool.

Thanks

> 
> 

