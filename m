Return-Path: <linux-rdma+bounces-3424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D2B914636
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E841C20AF4
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A87130A68;
	Mon, 24 Jun 2024 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoZd/vEN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6BF1304AA;
	Mon, 24 Jun 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220931; cv=none; b=I+2NQRHF6pW8mbTdE+L57+EkKEgdKpNdjaFh6nO2/8sRzprIkghx0C6TJMITjTIOJiTdXa75S45uJKi8AhcVCuL+7QdfqJquFrMhkjrcT43VClYQDvsqAjjsgnn/ys5C9j4u/IJx1iu2jjpGbsgCymtSo6EOZTs2IfLNqhAT0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220931; c=relaxed/simple;
	bh=002yBRgSFu/CHEstMDbsYVZPqrpw0FyS58gS7blKuso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjeKn5HoqzbjkrggYHvbcdzt1FxiyE3zmkDoY6B2BYdrBCL9uWyg0rHsvxhhLYUFQ89kx7rYSjBw8LDHFV6Crrc0gZenoxy5yb0fZOrC0kxcuSHJFepjzBtP7cKEuSIr5GvYnXguZ5fLpAVBC6LGkPPnmL1VOLfDaZsWvn4c0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoZd/vEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A8FC2BBFC;
	Mon, 24 Jun 2024 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719220931;
	bh=002yBRgSFu/CHEstMDbsYVZPqrpw0FyS58gS7blKuso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoZd/vENI49T0cdteZWrOm3AF7CqRqtk3mQ+5VeD4C7vK0JCqbm7ZmTMbmvuRgQHk
	 8VMgRV1RbwUMdnC2jdnRy5KbEqQqVk2TcbqimQxw6xDfCWqf4HCTf8DisCiqO+sGyd
	 xyc3nCoCiUYr9fr5fiYJINL4URfe1Cm5xO8iCQF4YccQ8qoGMFclXzBEl2v9rq9wZr
	 /H6E36FzN6l5MIHgGVlBEKL8RXEc7fy5cPSXG1BqLF6UIhki35Secdf8AufhHSRjXg
	 0HGKSL2OxjkFJ2CZ48CMVKScN1C/ujDQnFHNCRHOCr2Cgnm5rW0/xAiKDRrIKyX7yq
	 /7VQ4YEjtwfoQ==
Date: Mon, 24 Jun 2024 12:22:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Omer Shpigelman <oshpigelman@habana.ai>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 06/15] net: hbl_cn: debugfs support
Message-ID: <20240624092207.GC29266@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-7-oshpigelman@habana.ai>
 <BY3PR18MB473757A4F450A2F5C115D5A9C6CF2@BY3PR18MB4737.namprd18.prod.outlook.com>
 <ac16e551-b8d6-4ca7-9e3c-f2e8de613947@habana.ai>
 <060ac3a6-bbac-400c-bfd9-cb1a32c653b4@lunn.ch>
 <a1a3bafb-c64e-4960-a826-f49d4679d7a0@habana.ai>
 <b40391d5-66d2-44be-bc83-4ac3b7bcfe08@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40391d5-66d2-44be-bc83-4ac3b7bcfe08@lunn.ch>

On Sun, Jun 23, 2024 at 05:02:44PM +0200, Andrew Lunn wrote:
> > > If there is no netdev, what is the point of putting it into loopback?
> > > How do you send packets which are to be looped back? How do you
> > > receive them to see if they were actually looped back?
> > > 
> > > 	Andrew
> > 
> > To run RDMA test in loopback.
> 
> What is special about your RDMA? Why do you need something which other
> vendors don't? Please solve this problem for all RDMA devices, not
> yours.

I'm not aware of anything special here, which require special treatment.
All RDMA devices support loopback natively and can "put" traffic from
their TX directly to their RX. This is how we can run RDMA tests, which
are part of rdma-core https://github.com/linux-rdma/rdma-core/tree/master/tests.

Thanks

