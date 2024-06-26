Return-Path: <linux-rdma+bounces-3491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391B917830
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 07:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EACE1C21BA8
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 05:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F0A1448EA;
	Wed, 26 Jun 2024 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmMGT4Ct"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4B2F5E;
	Wed, 26 Jun 2024 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380083; cv=none; b=uh9QQdycxDwosqVlMHTiNvQY9RnhHQMSm0hDH6/OGHbLVSoguNXp/qt1ee5oHKA2WCmc9KOCBOaJjvIjYAhmNLKroMvIy5PTFXdHN/N9wsbN+XJrBPiVNywUqJjY1I6rI4rlB9qiD3Bzq+oFJIfR8f5uUfaUS0bB26f1rMOXUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380083; c=relaxed/simple;
	bh=SuWvqN8B1pUjcJ2bF1x2UYwmAnEJqRPmd+gWediLTaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9shdUFChJH5QHL2WqHHC2Z8VLSHHpHb2Bto5GvkoMazo7pBD+d3ARMxW+a4iQevYYYLtY3S8kGYTMLxUl76yrav9G714w/edT5XiKTb/iWDEv9LKbENDj42bLfor/XO6AIBQv4OUhIq1xcEXOxHZE9S2g/QrwOKvOwsok8R0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmMGT4Ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0088C2BD10;
	Wed, 26 Jun 2024 05:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719380082;
	bh=SuWvqN8B1pUjcJ2bF1x2UYwmAnEJqRPmd+gWediLTaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmMGT4Ct4Jp2ZQIYj+5v9vlxHr9S2vHpVvRaTsCjW2Xp2UF/dgNyNSvmxXnm8++bz
	 eCywY2BHWasTKjKo6OMG0N99Qh3KPpmjuFCcyPW+XRjDvXcAgS93cq2+C2pOlJUr5s
	 Hy9AWT9Gjf5idqa1DWKJkbfY8EQBm78oVpICRfG7XjMrcQuxN5LOAWZ1/6QjSzehiB
	 dE8UhRNhzwabvCaSXBSqdjuU6ItR9jmsiY5G3B+/3WR3oMK0mle187JPq8qwDwo4DV
	 VSG5fs88ZG8xAkRrUUuYCEsz+uDNZu57RU0FagMGh5Tj1eCsaV9bQfLI5GHwTuM0gc
	 U3AvfxlvTKTdw==
Date: Wed, 26 Jun 2024 08:34:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Anand Khoje <anand.a.khoje@oracle.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@mellanox.com, tariqt@nvidia.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
Message-ID: <20240626053437.GM29266@unreal>
References: <20240624153321.29834-1-anand.a.khoje@oracle.com>
 <0b926745-f2c9-4313-a874-4b7e059b8d64@intel.com>
 <1f9868a7-a336-4a79-bc51-d29461295444@oracle.com>
 <c5a8b1b0-ce6e-4c35-aa00-2a4a1469b3ce@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5a8b1b0-ce6e-4c35-aa00-2a4a1469b3ce@linux.dev>

On Wed, Jun 26, 2024 at 04:19:17AM +0800, Zhu Yanjun wrote:
> 在 2024/6/25 13:00, Anand Khoje 写道:
> > 
> > On 6/25/24 02:11, Jesse Brandeburg wrote:
> > > On 6/24/2024 8:33 AM, Anand Khoje wrote:
> > > 
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> > > > @@ -608,6 +608,7 @@ enum {
> > > >       RELEASE_ALL_PAGES_MASK = 0x4000,
> > > >   };
> > > > +#define MAX_RECLAIM_NPAGES -50000
> > > Can you please explain why this is negative? There doesn't seem to be
> > > any reason mentioned in the commit message or code.
> > > 
> > > At the very least it's super confusing to have a MAX be negative, and at
> > > worst it's a bug. I don't have any other context on this code besides
> > > this patch, so an explanation would be helpful.
> > > 
> > > 
> > > 
> > Hi Jesse,
> > 
> > The way Mellanox ConnectX5 driver handles 'release of allocated pages
> > from HCA' or 'allocation of pages to HCA', is by sending an event to the
> > host. This event will have number of pages in it. If the number is
> > positive, that indicates HCA is requesting that number of pages to be
> > allocated. And if that number is negative, it is the HCA indicating that
> > that number of pages can be reclaimed by the host.
> > 
> > In this patch we are restricting the maximum number of pages that can be
> > reclaimed to be 50000 (effectively this would be -50000 as it is
> > reclaim). This limit is based on the capability of the firmware as it
> > cannot release more than 50000 back to the host in one go.
> > 
> > I hope that explains.
> 
> To be honest, I am also obvious why this MACRO is defined as a negative
> number. From the above, I can understand why. I think, perhaps many people
> also wonder why it is defined as a negative. IMO, it is better that you put
> the above explanations into the source code as comments.
> When users check the source code, from the comments, users will know why it
> is defined as a negative number.

I see no problem with adding a comment to the code, but I think that it
won't help anyone. The whole reclaim/give page logic inside the mlx5
driver is written with the assumption that the number of pages is
negative for reclaim and positive for give.

Thanks

> 
> Thanks a lot.
> Zhu Yanjun
> 
> > 
> > Thanks,
> > 
> > Anand
> > 
> 
> 

