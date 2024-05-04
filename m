Return-Path: <linux-rdma+bounces-2261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982498BBCA2
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 17:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06031280D7A
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5043D38E;
	Sat,  4 May 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2WYKMKw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695C4F890;
	Sat,  4 May 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714835003; cv=none; b=ipWhSUidahn/L7oW3MgzUDOeBLyQvl4gS1fW1nUjNcBfnbh8kX7v0e5WkNMWmXJnODXfqUeLkhNAUiOHWTHYVP9YaR3F7/bEHIhZZ79httHAsrPdLgrykMn+UMQ9FKrocjOjnLOTKhyHgToinCEXFRjVzb6Otxf8mA3QJAzBbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714835003; c=relaxed/simple;
	bh=jLGPDd62/VmNapLCYXtF14n4GE2XFUNRJLO80edDP9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvmoErQXki1OJhMb4+kHmw0MaYM7d8xFIs16Zqib9rIvFFqFkk8hbDz/M8iF2XFQ/3x2P/yhk2caR0zPUT51MYeSwtMmUoRl8EQvurD/je2jbJ5nEuE/NkgupZNw55D+vNku6DI8j5KeY6ZZr5+eRvyOL587d8g+FbzNJ5Lxp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2WYKMKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F536C072AA;
	Sat,  4 May 2024 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714835003;
	bh=jLGPDd62/VmNapLCYXtF14n4GE2XFUNRJLO80edDP9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2WYKMKwx6cltikOJwmSgNOCJMaZ0PFn6LMyBEVfRrgEzhiE4OfKyCaK7xsXFG6yC
	 8eZDayYNxgSIkJ/AjqYJ3QOG1+J1zZ7BX9r7EbXYWT0bzzPQFNSt/a67SYqFlQzKle
	 2jx/w/v6j2zzD1iYKhmx0ah9C2eKs4lbKCJjte86BXaAfIjVeli8k5bAIr705ot0b2
	 86NS7iritlXR3ScKXMRJFtmP8LieprUTRDEhrDKGGljsVZF5BfSlxaEC+0vuq+kyXY
	 A9xkIC89z0aquXC1KdmntemaHbndqhclsvH7YsWioLmCCDLAseZED6zqfu2TZd34Bo
	 Q1WBH4rlhwvcA==
Date: Sat, 4 May 2024 16:03:19 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] IB/hfi1: Remove generic .ndo_get_stats64
Message-ID: <20240504150319.GH2279@kernel.org>
References: <20240503111333.552360-1-leitao@debian.org>
 <20240503111333.552360-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503111333.552360-2-leitao@debian.org>

On Fri, May 03, 2024 at 04:13:32AM -0700, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


