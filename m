Return-Path: <linux-rdma+bounces-2160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78588B762D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157811C21F5F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBA9171671;
	Tue, 30 Apr 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE7Uv54C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994F17166A;
	Tue, 30 Apr 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481453; cv=none; b=knNZHtIyDpzPXmimLD/7jAwT2LAXRAXLkrRimSEryF2V2/76VF5RgXy337gYEpf7hAZkU42IfsJSBiv0rLNOdbEMtOMQvF64vRrROT8wA9H71B20j3Tk/NPftDW7g0TSXYESoUw5OcCQ4NA8RolJKA3FaXUV3bE7Ze2y3/OX7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481453; c=relaxed/simple;
	bh=Gt9uzlCU6Bhi4Wo521ImdXL9omLXvut7bGKwKJCAJXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe9GRInBIHi0ZWIlPq3r8NPs/xtTjV4XUcuo7xzweklFsCEfCzInT+BKZywTm43riA0pEYLuWurBVe01mBmoYTj+l4hsFU0QHbdBPdFTi3ge8fSwAOdlqeGXSi+2uieI61jN0N24IaukaJE8N/sb67rqepk8SwjQi6wU0Tfln1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE7Uv54C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547CDC4AF1A;
	Tue, 30 Apr 2024 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714481453;
	bh=Gt9uzlCU6Bhi4Wo521ImdXL9omLXvut7bGKwKJCAJXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bE7Uv54CxnO5vUHcy5cGiflE6UIDmqH/58vkBioHHnNkPZknthr4CJG6ZCsUSmy7z
	 Ja+JdC3Mde+ZxNCxsEoDd9ZgEQDxlwjsqBrDTtQaC4WtEBVplE9sRTZI2hf1tUCtem
	 xVkkHSGeGfyBlUdpeHQs7YiRs/qzA2hnqGwpTpnpMwEUmj5fh4q07NU9SSLB5RZ9pH
	 gFyKVauphjT9ysqG7KfV7U1tqb3Ayj9Tef9T9zy7mwrLImagyyP/+c+kCAj/EpxmeZ
	 AulEleTnNow1MKJ1GQxXln7LGGaWOa+iXVsUoQ98qVBr2+zXasIFJlAjiNOT+wwlR4
	 u3Q5YBI6/iYvA==
Date: Tue, 30 Apr 2024 15:50:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Breno Leitao <leitao@debian.org>, kuba@kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240430125047.GE100414@unreal>
References: <20240426085606.1801741-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426085606.1801741-1-leitao@debian.org>

On Fri, Apr 26, 2024 at 01:56:05AM -0700, Breno Leitao wrote:
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
> 	* Basically replaced the old alloc_netdev() by the new helper
> 	  alloc_netdev_dummy().
> v4:
> 	* Fix the changelog format
> v3:
> 	* Re-worded the comment, by removing the first paragraph.
> v2:
> 	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
> 	* Pass zero as the private size for alloc_netdev().
> 	* Remove wrong reference for iwl in the comments
> ---
> 
>  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)

Dennis,

Do you plan to send anything to rdma-next which can potentially create
conflicts with netdev in this cycle?

If not, it will be safe to apply this patch directly to net-next.

Thanks

