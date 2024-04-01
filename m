Return-Path: <linux-rdma+bounces-1703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B4893ABE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272A2B21368
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1D21A0A;
	Mon,  1 Apr 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGwQK2jl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC021340;
	Mon,  1 Apr 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972415; cv=none; b=B3cA+TQ9q3UqIwaP9PQVPCVksqWgLWN9mHwE53lMe166qajd0wIMVFjnToqjZIcN6WsbSAbdN/ihDpVI4SsYDCC0h2WW+LzVHMUvvnIf5G9pyLKq+sE9FwddcmIkE+8d9YQFVha9FIWtby4mN1yrA0n2k0uaDtMJro0XpcWNKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972415; c=relaxed/simple;
	bh=9uVLf3becGVUgjaaJtEsn16D5M1Pat2+PNKbE6FqNes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBR1bn4E/K/oHZqSqZBZi07lQtId6xTb4bsQnqTPZVmcn1ybqf4nXV4H8B+DhJOwrgiO4E+reBBLGDuIPWTad8erBRbCuIInm96eBkGsi3eUfuy21RxGbMBunSRrBgAnXw5tmbzJgIihbQRFGq9iOT4Pi/zyteSnsPrqUizVlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGwQK2jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CB8C433C7;
	Mon,  1 Apr 2024 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711972415;
	bh=9uVLf3becGVUgjaaJtEsn16D5M1Pat2+PNKbE6FqNes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGwQK2jlRWX/sZ8JVLzM1IzKZ5E6GVNsKVM7vYSmcJtgBh0jrdZRkOc2rYMK6TBny
	 rVpslyeWYSprKJYxGn0ir5Sil+Zqrm3UCrBMrSXYoJVCa4tvUUJSV1RFQIyYewpffS
	 HFIb4qiOwQaExPz9vy7nxGZtShhuby1y7fgFZO4I5o8GcGsaHJcT/HeqC5ghwUVV8I
	 cAmiL0C2wSMwKo35aegmpLkC0Xm8Ty3yVaXlxYhWr2Z6JAy5EriVn9yDP4sIHBII/u
	 Uku4yGj05z0Z1vxiY7u2Cyt4oJF1KYFUgg834fN5Cl0vvQyRvYT0acOKLAz6yIJ7Zs
	 twlPxQqj7UNtg==
Date: Mon, 1 Apr 2024 14:53:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240401115331.GB73174@unreal>
References: <20240319090944.2021309-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319090944.2021309-1-leitao@debian.org>

On Tue, Mar 19, 2024 at 02:09:43AM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at hfi1_alloc_rx().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

Jakub,

I create shared branch for you, please pull it from:
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=remove-dummy-netdev

Thanks

