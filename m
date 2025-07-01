Return-Path: <linux-rdma+bounces-11799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84929AEF89E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 14:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DAF7B26B6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B2273D98;
	Tue,  1 Jul 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGR2bUCe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AB273D94
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373180; cv=none; b=uVmrbtx6v7C6UmCEznX5Niuo5+CXkkB7BvXiCTYssjBm9sP4YV/HBkCEu7j4vx6Qa6uvJu9mrGSqxRtMEDRxfumGdzDqAWerd0ujHUQ+SMpxvQy7LPM94Rx5JAQ70g5l/4gcooCk1bCkFOzbziQsl7HpY1nbS/tJW+sIzWlZI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373180; c=relaxed/simple;
	bh=ef5ALmTtfyGzuvPdGNbiElJG03cG0QHgXLWvw+m/TEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA/wNmxPGk+1GJc4g9e0uhRCrciIi+wVVPEIK3RHbtgfZ0PHwQlloSKFVZtFNW3QUp5XTxsDoOFFDwH44b+qM5q41RqtoqKlnYHePn4agOHnSMgCqWLcUJmwU5vUZQ4KZTFhMVcccLi9NiRf+1Ce3zHzvzKIzX8vodzeRtUTdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGR2bUCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E5CC4CEEB;
	Tue,  1 Jul 2025 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373180;
	bh=ef5ALmTtfyGzuvPdGNbiElJG03cG0QHgXLWvw+m/TEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGR2bUCeA1q2UrJc4J+JZ6Db95vQIrZCZnzZvJNftg7b8wI6PUmrAHRCR+17Smvw5
	 6VKrWi+jHxKshlo6ZgJn3Kgfs5BMB2INz2btgL34mheJgWx1xzUyH98FsERZdv1MeD
	 cRh86c5mIB0TuY3sc4YhJ3248vVK3zrvlvLyjkL070yRiiuHXmWWssaOg9U7sDtHSp
	 U50Zq6LcwZWlH0dQ7caloWseuWcBe6+C2QgCD75GzkQjtL0e8b7l8AXw5Xkhz5aWcK
	 dT3P3JrHDdzO23N+AUSSlERToJTVHk2//6SHtT8p78dE8HkoTQwUYd8cQOpOz5HkD1
	 bdeRB5ZE67FzQ==
Date: Tue, 1 Jul 2025 15:32:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 05/23] RDMA/core: Add writev to uverbs file
 descriptor
Message-ID: <20250701123254.GC6278@unreal>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741281.1859400.9193550583285999392.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175129741281.1859400.9193550583285999392.stgit@awdrv-04.cornelisnetworks.com>

On Mon, Jun 30, 2025 at 11:30:12AM -0400, Dennis Dalessandro wrote:
> From: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> Add a writev pass-through between the uverbs file descriptor and
> infiniband devices.  Interested devices may subscribe to this
> functionality.

Aren't we use IOCTL and not write interface now?
Why do we need this?

Thanks

> 
> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/core/device.c      |    1 +
>  drivers/infiniband/core/uverbs_main.c |   22 ++++++++++++++++++++++
>  include/rdma/ib_verbs.h               |    2 ++
>  3 files changed, 25 insertions(+)

