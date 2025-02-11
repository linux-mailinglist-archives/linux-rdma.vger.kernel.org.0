Return-Path: <linux-rdma+bounces-7648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0707A2FFE5
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 02:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC89165D67
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 01:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13C13DDD3;
	Tue, 11 Feb 2025 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OARjpvVc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B362A926;
	Tue, 11 Feb 2025 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235864; cv=none; b=TcjAp7oKQzFQSnwLZ9gxtEj/9Qo+DmsN0udWa177qRvGj7GiGYoW//jprR4yDep3yi0WC0yaYPmVDxi+X0//ohv/2S5CLc/97H3vKOc6lIF6eh0SR54f4+2Q0whCUV+6Md8BHnjDSWT/Mbl0MTKkB+DBlNOs8l2SjS/LnzkPF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235864; c=relaxed/simple;
	bh=H1WYWJ3zyHBkyftdYiqP2HvX7Gx4oHPGjNbXY7vSLVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dC2OWHD4lzM+H6flm5gLjMYF8LpPEIrTp3KFFKKUWhQslL0ScxQsB7w8WGW4gfGf3KO1UjFu57CFvMFjsjiyrl7/OYjpF4ivnqsQueMNnQHsGqa2BtefZitcbcFyNyZoOQEwk90UDNP5ZyeJkRAhPjRcPTAuvdF5IZ8c5oayrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OARjpvVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD0EC4CED1;
	Tue, 11 Feb 2025 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739235864;
	bh=H1WYWJ3zyHBkyftdYiqP2HvX7Gx4oHPGjNbXY7vSLVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OARjpvVcSjNmTce0RdSIq45MfsbXn87od8Z3DJCt0eJhO2nNpBXxpfIMzFYs/SFX4
	 ypYzgDCJmT4YjTcq3ohTR+OLnGEBvV8PSdrT+2uowip8l4BkObDqwZ4pylJ8klGZWk
	 X+uBJNXaimLN0Fr47+ANW4KHXz4RJg5YfFHj3m+ERCuIUvddrTgja9oHaxLGxLbwMy
	 S/RiOgjpT0QGgW/EkU3kIWNRFjMYmgRTcNOBEoMOpIRaKI+GQ+w2OIxd5kyX6MKEjt
	 gchRsLJgI9Bmb/t5pDAk0WNX4GmWPqISnmV2TsHzli9mVK1oQnaGJWisewwx89HHAI
	 dr6QJPQKk4dXQ==
Date: Mon, 10 Feb 2025 17:04:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, "Nelson, Shannon"
 <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for
 fwctl_bnxt
Message-ID: <20250210170423.62a2f746@kernel.org>
In-Reply-To: <20250208011647.GH3660748@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<20250206164449.52b2dfef@kernel.org>
	<CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
	<20250207073648.1f0bad47@kernel.org>
	<Z6ZsOMLq7tt3ijX_@x130>
	<20250207135111.6e4e10b9@kernel.org>
	<20250208011647.GH3660748@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
> On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
> 
> > But if you agree the netdev doesn't need it seems like a fairly
> > straightforward way to unblock your progress.  
> 
> I'm trying to understand what you are suggesting here.
> 
> We have many scenarios where mlx5_core spawns all kinds of different
> devices, including recovery cases where there is no networking at all
> and only fwctl. So we can't just discard the aux dev or mlx5_core
> triggered setup without breaking scenarios.
> 
> However, you seem to be suggesting that netdev-only configurations (ie
> netdev loaded but no rdma loaded) should disable fwctl. Is that the
> case? All else would remain the same. It is very ugly but I could see
> a technical path to do it, and would consider it if that brings peace.

Yes, when RDMA driver is not loaded there should be no access to fwctl.
When RDMA is disabled on the device via devlink there should be no
fwctl access.

To disincentivize "creative workarounds" we have to also agree and
document that fwctl must not be used to configure TCP/IP functions
of the device, or host queues used by the netdev stack.

