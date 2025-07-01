Return-Path: <linux-rdma+bounces-11814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6BEAF070F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 01:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A2F4820E3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 23:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54602277C87;
	Tue,  1 Jul 2025 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNhSx3eI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AF2192F4;
	Tue,  1 Jul 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751413930; cv=none; b=a+SxPIJTfojyXMknuphFHE5qfMlsFCWqBN67rPhN3BVkqgnjT+MZgM2Hn6Dfpiv8DApERVMRB9EWWzTENMnJGKNDf9k6NcHl9/p1GES+k8TEobn+l8kGoaUZZWP90In22ZZvxOley9TGKRYZ4TEQpmtVI82lt2BR9wII9pDiyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751413930; c=relaxed/simple;
	bh=+uG+vjDFrpA/LC1O/R/RAZPKUIfakduvGLBMULSE3rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZguOi+lAZIa9UczhwN/3y5yd+2P/apr1uOkw1qNxKFrkPHSQl3EzcerRU6RiKEzNZ+MaEd3WRDe1tKLVif/kOpFRtC3+Gj+AC0ZF8T21ia1x5nkqJFvYZrnJLW3ai9Yi1v9G0uiyjP1cN2pVtnGD/S0PkyN3E1HVQs/j4XXOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNhSx3eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9BDC4CEEB;
	Tue,  1 Jul 2025 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751413929;
	bh=+uG+vjDFrpA/LC1O/R/RAZPKUIfakduvGLBMULSE3rU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNhSx3eImVJzNJpQRWlN1v90JVow5O0ge9WJVC+Q+ixzJOpv3nlGNngnD/+5cMedN
	 4HFP6fhfS/RTqSLw7NrEltAC09f9WHi7egLRHZc/VK9ML2fNBUhwKCXNAHWPlbMuPK
	 hsaeEiKCxZpnKuyBRXJBGRZAikqONXyupBJjuWznJpzZDkIZo54syOvRJ8gNLIqfND
	 SuQZPpRVAx7K8dfjJfHyJiwDxfFrWuGSbNpKfKQ5pEt9zjHnRYjHJKu2nCOabz0+2g
	 d/8M+wvy9tNshMhxP4cxF+TVNJF8Gs6MC2KhlbjO465SS8Fgtd7hrbQwj1qjiInuRX
	 KcLv6HaIz29MQ==
Date: Tue, 1 Jul 2025 16:52:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, Ayush Sawal
 <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Wenjia
 Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] net: Remove unused function parameters
 in skbuff.c
Message-ID: <20250701165208.2e3443a0@kernel.org>
In-Reply-To: <c405f957-0f88-4c88-98d7-3a27e5230fc8@redhat.com>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
	<20250630181847.525a0ad6@kernel.org>
	<beea4b9f-657f-4f98-a853-e40a503e2274@rbox.co>
	<c405f957-0f88-4c88-98d7-3a27e5230fc8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 11:02:50 +0200 Paolo Abeni wrote:
> >> I feel a little ambivalent about the removal of the flags arguments.
> >> I understand that they are unused now, but theoretically the operation
> >> as a whole has flags so it's not crazy to pass them along.. Dunno.  
> > 
> > I suspect you can say the same about @gfp. Even though they've both became
> > irrelevant for the functions that define them. But I understand your
> > hesitation. Should I post v3 without this/these changes?  
> 
> Yes please, I think it would make the series less controversial.
> 
> Also I feel like the gfp flag removal is less controversial, as is IMHO
> reasonable that skb_splice_from_iter() would not allocate any memory.

+1, FWIW, gfp flags are more as need be the callee.

> > What's netdev's stance on using __always_unused in such cases?

Subjectively, I find the unused argument warnings in the kernel
to usually be counter-productive. If a maintainer of a piece of code
wants to clean them up -- perfectly fine. But taking cleanup patches
and annotating with __always_unused doesn't see very productive.

