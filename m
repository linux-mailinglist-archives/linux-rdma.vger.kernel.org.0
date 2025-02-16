Return-Path: <linux-rdma+bounces-7777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB3A3728C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 09:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140897A2BFA
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AB1519A4;
	Sun, 16 Feb 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSxQj75A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A41FC8
	for <linux-rdma@vger.kernel.org>; Sun, 16 Feb 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739693249; cv=none; b=dW8EE+WxPfZIY3oFX734EIKhpVpPd4Bca4WGzZrYPNAUo/pZPw5vOBm195VZYi1RV5O+3lB4nEl2zytIDX8pXktX+h0yt2uyuxL7Ans3KxgftDObJMSNQ/el/0nnmjxUcl7j35anRLQBAfMmzYVRAEphbnwqHGeLzUn2qb2NTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739693249; c=relaxed/simple;
	bh=a3Sxz8u9NpKBzN/sal/n2caQeEgCfBEuaAgutBpRCC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi4aWVqg9hC47/3IF4w70ONw/XSHRRSUp5gJn15YPwAJtrXM0MV+58B91URYW5256NZS2nAUl88X9XqWQEz6Z0G8RVtPu5/ZdE8LqFKscFFYvu9el5stgH5TY3qmh8Uw55eC5QYyHkVsH3EXcyeHo6DvkswdYiGPqh6nWmtI4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSxQj75A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61404C4CEDD;
	Sun, 16 Feb 2025 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739693248;
	bh=a3Sxz8u9NpKBzN/sal/n2caQeEgCfBEuaAgutBpRCC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSxQj75At31DaS3kfPUyMN2U0IZeSndENmwV9XJCwRMqEYsREwB4kLRwfc49ffCxB
	 YpFWu2RCyaHESSEPfbmtVN+uokVK+GzVyqNuhBMn/yaN9d0ofNZoWqSJKNAXIeCp58
	 tlSeWUNVmpkEK4bhijZwVzhPdbBGs5efCMpCb/cPCPxiDo7V4HxFu8km13aNGIzs5c
	 GjbMGcwEYAD4Zkx6tpzv+EuHmQhZmd+1D2oXUamQyOaC+ajcOT7ZKA5DYOFA9Dw8Hs
	 +r1ZyoA0AiQzu4Fd8Ykhs7kq4vzhJRoO8Zhc4GdFgzWyJsHF5xYASM8CRNMhFZS545
	 kDfyC0pT9E5kw==
Date: Sun, 16 Feb 2025 10:07:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250216080724.GS17863@unreal>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
 <20250213173510.GO17863@unreal>
 <20250213174043.GG3754072@nvidia.com>
 <20250213175517.GP17863@unreal>
 <20250213181242.GF3885104@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213181242.GF3885104@nvidia.com>

On Thu, Feb 13, 2025 at 02:12:42PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2025 at 07:55:17PM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 13, 2025 at 01:40:43PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 13, 2025 at 07:35:10PM +0200, Leon Romanovsky wrote:
> > >  
> > > > Initially curr_base is 0xFF.....FF and curr_len is 0.
> > > 
> > > curr base can't be so unaligned can it?
> > 
> > It is only for first iteration where it is compared with
> > sg_dma_address(), immediately after that it is overwritten.
> 
> But this is all working with inherently page aligned stuff, cur_base +
> len1 + len2 + len3 + len_n should be page aligned for interior segments..

This is unknown to static code analyze tools. I'm not concerned about
logical change, but about possible static code analyze failures.

Thanks

