Return-Path: <linux-rdma+bounces-2275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC38BC0AA
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FA71F215A9
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808CC20DD3;
	Sun,  5 May 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+1eoV8j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93CB662;
	Sun,  5 May 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918237; cv=none; b=Sf+6mF6jpUUR7MB5GSYE+XBrI8p237MfqUuLdVwgZ8DW8Z/pQBNfAtd3ARrL4riFmhbOL7aQY/ipgNeT3+BfCoXBY+5FfgmAphqX6uz9uplU4XhFeMQNBqPf7UOugNeu3z11QNwQ1MF8T5EKZa/9HRlKDxRVzIjz/iZ/B0CSfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918237; c=relaxed/simple;
	bh=F+oMsjUMZqKcGqEpkDqhD9UQMjmC1BnqSHXs9vkjGrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfcAWMcROxK3ECTIFXocFtoobHBk+ILomgLAaSNHglqJ/w7+3+yZ1LbhgkaxCgPofPhDHMnbBydy/gxGzOFLAqObTyNCHZzG6kwubNHa9B9oNFzKVSI2n7BMzK+S9M7pJJiotgn5tuptR9i+oWevBUL4jFSsrO1Zqq2Fe7+NfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+1eoV8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2940FC113CC;
	Sun,  5 May 2024 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714918236;
	bh=F+oMsjUMZqKcGqEpkDqhD9UQMjmC1BnqSHXs9vkjGrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+1eoV8j8rE/DJc61bLn1PGqSLLdrgY6exTclaBYnX6+B5qUczVE6bDDIh6Z42um2
	 Q5unLSCs9sytW/XAKeog+WdpjmZ8f7YNf64dJOshhXOeChFuVzH0B51zxS1u7ecYpY
	 9Q0hw2Z1RRzN6tYanOCKmmAw0fPLdqv1NQVWjPcwoD5IKKpkCVFiEj5GywJiYZrp+S
	 +eiN3DLxjfTzi5Om6hiPs2H1s5t1XF3JmTEJVUmluIF2dbGR4JHh35KNYk7f5/JBq/
	 bSeWOBxmxn2+OJa+Ps3KBBZYwnZeWhqUxvDh3vn+wJIsVFP+Cp4xGukRpvn4R627nB
	 hp0N3N/VsTXzQ==
Date: Sun, 5 May 2024 17:10:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] IB/hfi1: Do not use custom stat allocator
Message-ID: <20240505141032.GE68202@unreal>
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
> ---
>  drivers/infiniband/hw/hfi1/ipoib_main.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)

Please use rdma-next in the PATCH subject line, when sending patches for RDMA.

Thanks

