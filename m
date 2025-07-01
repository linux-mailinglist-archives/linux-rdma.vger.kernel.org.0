Return-Path: <linux-rdma+bounces-11805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE428AEFF16
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5049D52283A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC9C27F16A;
	Tue,  1 Jul 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM/jtR8z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8E27B50F
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385860; cv=none; b=B5tgq2OK0DDodohY52leRa/toaAiq6HEFXCq7WKZyofgj7Rahk102GyvrFm2GCRwmry5BRklb3kqzVQObTGXeuRAi3+jc2SfrelGbnzg0rPOKOPtZN8reln3nbIBxNVo3gevkJAwUYZCX5mAoIWeSwHeujQhB301AIxl94291P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385860; c=relaxed/simple;
	bh=pmC5dqdt80v0R0xAr0IeKL/z+IYnI1KVHYe1tHy9Ka8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTwaRL1mv+mP2bW1DSrb6zVJ/bDkTYZRznHR0JTvBTaCdQzlL7SE3EBV5y7S0Nh7DS/IDEApXy7tt0L+kJE1UFv+HFRDwajpg/uuZ4PGGgBLBiG7Rq3jwQKLMkb6iYeJ+7qStP4et8b7TiOAxrFu+syT5HYv2lh+EWBW1XI6ITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM/jtR8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D192EC4CEEB;
	Tue,  1 Jul 2025 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751385860;
	bh=pmC5dqdt80v0R0xAr0IeKL/z+IYnI1KVHYe1tHy9Ka8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rM/jtR8zahTvH0IeNWDSEQGyr1jgmrM2Q0weIWJ6JUWK6Wa5wBcvVWj+zWufbrrZX
	 b6lMtejiQZKw9cEWNmXfpB0W9Ohrv30hzxsl/6eHe65WXm0I4kSUXaXJ/YmaRc0Xga
	 eXOStMDJPN5nj3MCZCPqThXSmTFOCJLbyuKGNhGWdetWn8Umr0m+e9rXHr8sQMeo7z
	 suJl689BaS6sU7lRhtWY80336oiSXYfPlJoUOTewILRYgD2nwoUW++k3WYQi1XNHFs
	 K89BAh2Zob46p+Xk03ZVP0ON5QkLDaQnfDbgefrIDRBUwR/m0Xs3rmIet1vi47vDAq
	 3nXAd5Jkf88dQ==
Date: Tue, 1 Jul 2025 19:04:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 05/23] RDMA/core: Add writev to uverbs file
 descriptor
Message-ID: <20250701160415.GG6278@unreal>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741281.1859400.9193550583285999392.stgit@awdrv-04.cornelisnetworks.com>
 <20250701123254.GC6278@unreal>
 <32fb1fe6-b21a-4105-ac2c-cbdcd277a59d@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32fb1fe6-b21a-4105-ac2c-cbdcd277a59d@cornelisnetworks.com>

On Tue, Jul 01, 2025 at 09:57:23AM -0400, Dennis Dalessandro wrote:
> On 7/1/25 8:32 AM, Leon Romanovsky wrote:
> > On Mon, Jun 30, 2025 at 11:30:12AM -0400, Dennis Dalessandro wrote:
> >> From: Dean Luick <dean.luick@cornelisnetworks.com>
> >>
> >> Add a writev pass-through between the uverbs file descriptor and
> >> infiniband devices.  Interested devices may subscribe to this
> >> functionality.
> > 
> > Aren't we use IOCTL and not write interface now?
> > Why do we need this?
> 
> We wanted to keep all the semantics of the user interface the same so it's an
> easy migration to the uverbs cdev from the private cdev. The idea is that all
> the command and control is still ioctl, but the "data path" is still using the
> writev() to pass in the iovecs.

ok, just add this to the commit message.

> 
> By the way I'll get the rdma_core (user space) changes posted soon so you can
> see both sides.

BTW, I looked whole series and upto MAD/verbs interface everything looks ok.
The latter simply broke me with >3K LOC in single patch.

Thanks

> 
> -Denny

