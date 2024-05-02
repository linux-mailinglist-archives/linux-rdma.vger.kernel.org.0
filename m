Return-Path: <linux-rdma+bounces-2208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B728B9C9D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 16:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510C3282EE9
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58356153509;
	Thu,  2 May 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg2BGsYZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38F12DDBF;
	Thu,  2 May 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660985; cv=none; b=mTNId4/L5XG1NPg6kcPabP696Fvq8QLVvYdsJCZjtrcDuSumlEhVJSWlfTfdRyXKIWF6FCIYhGUsxvcV/VAy055gK4aNx2meOWLZ326FvV5O6nJgaFDdsCgz9Snw+3T382SbgHuUBvvNrds6Q88k/BNiJrpf7THJLCN/zP4w16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660985; c=relaxed/simple;
	bh=x0bc3ezuQ3DV2EhWzPw50heSwOCJAgNfC0IH1Y0Sx9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA9FD9lw4cFBXwa65q3OmkT0UNDvAMJMCL7rHZo9ybaHGZEUTR3MXo4d53G3oLYhNbSzaIQAh9Hy9RfvAcip0aV7rwyxXb6lZI/6OHtdchb2xgzJYvacudXKHLAHiQr/ZftRlU5tvXq0Tht7uGtXb03k/lwAT/otT8HeMAYkyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg2BGsYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F1CC113CC;
	Thu,  2 May 2024 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714660984;
	bh=x0bc3ezuQ3DV2EhWzPw50heSwOCJAgNfC0IH1Y0Sx9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg2BGsYZY99RQG+6CeKVR2f808dxrpoUrCqttNZlgnyq97AWnj7uNw+i+9NUts4y9
	 oMNrNvWlL4M748qDJGWXfVEcpxEz+BRZgylJoto2QVlfIhcFZKbKw4uLmcndRiE1iq
	 IlfiT5CVw6nDY+uUPEkP3d71DQ1SyWpOOAXjtWnc28/n3ZDI6W/WUfMuDjTWuK3mPq
	 6a934sdlA0Ql6U14zYSSlz2HqbKaf3GUKjU+Y2tUqIDU909MRQ1XYg+juJggokMyYS
	 f+Vs+447jzCiPrGp1afYBPP/8E92M8J7OZsXi8MXxJHeMgtvSdiq8dNlBgK1K39k8P
	 YpMFldvnPIR8Q==
Date: Thu, 2 May 2024 17:42:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net-next v5] IB/hfi1: allocate dummy net_device
 dynamically
Message-ID: <20240502144258.GJ100414@unreal>
References: <20240430162213.746492-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430162213.746492-1-leitao@debian.org>

On Tue, Apr 30, 2024 at 09:22:11AM -0700, Breno Leitao wrote:
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
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog
> 
> v5:
>        	* Basically replaced the old alloc_netdev() by the new helper
>           alloc_netdev_dummy().
> v4:
>        	* Fix the changelog format
> v3:
>        	* Re-worded the comment, by removing the first paragraph.
> v2:
>        	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
>        	* Pass zero as the private size for alloc_netdev().
>        	* Remove wrong reference for iwl in the comments
> ---
>  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

