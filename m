Return-Path: <linux-rdma+bounces-2260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136AC8BBC9F
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 17:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBE7B21885
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169553D3B8;
	Sat,  4 May 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHYXS9gq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD773BBC9;
	Sat,  4 May 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834991; cv=none; b=enbBJWdrMy5h8D/fkgWs1dKyD2BaVCtE0AUiGuC7kiyLpE1xLihRbM/O4LIlFaTq59ISZS/GroRDxQdT90A2haXwLWkNS2qOOkHbQuLw4diRevz9Mp9RWSHP5oGibojZE81ytaUYAeB/3RQJYUUd7FyyrM+CBhXZyQoVFQYQKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834991; c=relaxed/simple;
	bh=nlHEbbDlAr9zsDN0ZnWIgUl+/rNIUoQHhTMpZKbt2p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpjhZpyg087x9e6mI32mggS1I1yIXvRF2o5nsDYlARoxGJ+yl3GoEbRUiN7eNJm+aXWADdrwaWpIGcDl6lwwWq6srtc7pRtTq9kbpllRRR3gBjwyDAR04ZAb0Souf/X0jaUir2vFf67W4Cmqwxz8VxSju1Ndf8W0fLAmgPTOMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHYXS9gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDD5C072AA;
	Sat,  4 May 2024 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714834991;
	bh=nlHEbbDlAr9zsDN0ZnWIgUl+/rNIUoQHhTMpZKbt2p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHYXS9gqNtubOVh4mLAcjfhbAWHcavAF0ANAfBuqwD1y/jPJGqJ24tERiZQwwJ+Lc
	 iIV7pQuXycGvAvOhNRHxkWvu6hlDOouzHXEU9hZn5FJYgsopQtonGsw9Gf2WqKWyk7
	 H3DC2aTrr3/HJeu3hqa+QZ16spqawGDiRWMHiAtAm0FfMrRceZXvAAnoIF7pV5iVU5
	 c5/LzvVXwxrjnTcHuc+7xhRZDlSVZXNulFjcqQoickcCNJKGUDIgT5Ixiv1YPBgw9s
	 Bg+sqLqynaYGG/tn21NTT1wH8hhKPTyd7bZpH5Exj/zMuBd5h0Ug3E9QAm1/7DOggt
	 2dEBkPbwwg/og==
Date: Sat, 4 May 2024 16:03:07 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] IB/hfi1: Do not use custom stat allocator
Message-ID: <20240504150307.GG2279@kernel.org>
References: <20240503111333.552360-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503111333.552360-1-leitao@debian.org>

On Fri, May 03, 2024 at 04:13:31AM -0700, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the hfi1 driver and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


