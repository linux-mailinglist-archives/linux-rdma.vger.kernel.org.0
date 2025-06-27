Return-Path: <linux-rdma+bounces-11721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD3AEB6CA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA71C60278
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B60B29DB6E;
	Fri, 27 Jun 2025 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEBAsqeL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D491DA21;
	Fri, 27 Jun 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024755; cv=none; b=tDAKJtH0H/wxUnMjMIB7qCHtj543R/E0DVRLV6KeGIeD/IgMx6n3siJbxX69KwIHaK3AiBWRiHJRar70Rs2HwfkkpkXaiTI83IHy8F8rq4BOokdBSg4u4BtWPICNz3bMaI/1wDAVxijK4n01IQxhA6Y9Ur4Dp8HqcyyNniX/7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024755; c=relaxed/simple;
	bh=jTASXHFJaWtWuGba5uGJqmKPNvhb7UutBVfpBhwr2Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcV2VXhus2fdGSQhR7ByaDYXRcmQpG7FhcRmB1l2v76vkVry5ZPGyNgsuNCkAu7Uu4c2YY43/Ntd9ywDeYSrBRNjiJaiEYk8iOW3e2/4naUbWaT4tbtEVJEPjckW1lf0rnDf2fT1dh3no6JVdEj9IxCO+/dEQxN0eViBqHhBS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEBAsqeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6784C4CEE3;
	Fri, 27 Jun 2025 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751024754;
	bh=jTASXHFJaWtWuGba5uGJqmKPNvhb7UutBVfpBhwr2Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEBAsqeLBf/ZOGonjkm8MylG5wWhZCV5e1/MLmkDxYCtEBPfwmc4vophl+26dnZqz
	 fhH7g/Rkr3CL5iJL9FssXp1VRA5jXHQE1LAWWeIV1il1+aTTT3TxGE/XIwoeAwur9k
	 Rmrrv3pzIGKs3rkwHKkwx42cMf12/UrdeJCYC8d4w2ptmwcGL/nWZU+OesVFsHoWSv
	 0DJmEnY7ltxkJqdDHGdUiCzKvciEbxy7OCrKVSpLvpGu05cycZpFiC0DJ/GFGwxVqI
	 wv/IfNVJj0hh0/6Komwrb1Ja8g/DvCwgEY+GntpTn59hHMCCnKh7bKdvt6TWt/TBOY
	 90RtKH69UybbA==
Date: Fri, 27 Jun 2025 12:45:48 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/9] net/smc: Drop nr_pages_max initialization
Message-ID: <20250627114548.GA1943@horms.kernel.org>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250626-splice-drop-unused-v2-7-3268fac1af89@rbox.co>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626-splice-drop-unused-v2-7-3268fac1af89@rbox.co>

On Thu, Jun 26, 2025 at 10:33:40AM +0200, Michal Luczaj wrote:
> splice_pipe_desc::nr_pages_max was initialized unnecessarily in
> commit b8d199451c99 ("net/smc: Allow virtually contiguous sndbufs or RMBs
> for SMC-R"). Struct's field is unused in this context.
> 
> Remove the assignment. No functional change intended.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>


