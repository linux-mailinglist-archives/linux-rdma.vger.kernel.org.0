Return-Path: <linux-rdma+bounces-3866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222AF931237
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D248E283F2E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57A18787B;
	Mon, 15 Jul 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhskEEsn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135218755A;
	Mon, 15 Jul 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039044; cv=none; b=Jlvun8z51xzESgdVqM8UUu3m2baZ4VElKK8RzfY1QRe3EHPSiD3rgxSuzgV3c9EZQLtHNPGnZ9lvgIUTtLXPUHBm9yP0QtJ7fDoajFe6vpqbU4lnGVwFTpvwa6XvxqvWk/vVYlLFWWA/o75XKp4p6+LSutLUrlBm1Cvu16Rb9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039044; c=relaxed/simple;
	bh=HerndJT2b8s2lHxz2nyoxlrdmPVVAxFo+yFWNc6OpT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHd2FO9QZNPPQSMlHCyMn64oVWlBTM5Qf4gX5HnqbrWqYTqd14l24R5/YRzhf1yW6jz14VgXE6/lLG47qXgwo7P8/NLrslhYStPj3ONBzsF/shktA2078RSNuqSiHo2nMuPaCZUv5SO1oG4bnPE94UXPR5e6j7VOJlNRT7BfD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhskEEsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B95C32782;
	Mon, 15 Jul 2024 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721039044;
	bh=HerndJT2b8s2lHxz2nyoxlrdmPVVAxFo+yFWNc6OpT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhskEEsnLLChSu02GT31SKuAMEEcCs26D9PVYcOjGy7SX8jTSBbO4WBvcA3Ot3yqY
	 /JoCP+Jhsm/IXk2J1Jjan0Otb44KeeHmiQZHeUaA9iGBIjqg49BWHCt2FK1n+fhDlK
	 WqSPWv2QkdtsDKxPl1DoXsLaquqiqmg2ZsR6JkZ8cswwnOUkGwpHMKub1zmepaBlXD
	 XAdo/IHmZygJ8Uep9PTCdSrD/G/Gsqr6jpEC7+scLfQ06QGf1BYTkbH9bX9gnaei9w
	 zOEk9OvaXl6nKRNMWnlSbklJ0WE8gJiAgApVhlspA+a7K4Mp2whxEmdZTX+jtgEWqw
	 tPrUTvllh6Wsg==
Date: Mon, 15 Jul 2024 13:23:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Anand Khoje <anand.a.khoje@oracle.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"saeedm@mellanox.com" <saeedm@mellanox.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Message-ID: <20240715102359.GA55002@unreal>
References: <20240619132827.51306-1-anand.a.khoje@oracle.com>
 <20240624095757.GD29266@unreal>
 <3d5b16d332914d4f810bc0ce48fd8772@AcuMS.aculab.com>
 <20240701114949.GB13195@unreal>
 <c702670609914da89e934879b5c89de7@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c702670609914da89e934879b5c89de7@AcuMS.aculab.com>

On Mon, Jul 15, 2024 at 08:22:19AM +0000, David Laight wrote:
> From: Leon Romanovsky
> > Sent: 01 July 2024 12:50
> > To: David Laight <David.Laight@ACULAB.COM>
> ...
> > > > BTW, this can be written as:
> > > > 	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
> > >
> > > That shouldn't need all the (s32) casts.
> > 
> > #define doesn't have a type, so it is better to be explicit here.
> 
> The constant has a type, the cast just hides any checking that might be done.

According to the C standard, type can be int, long int or long long int:
 "The type of an integer constant is the first of the corresponding list
 in which its value can be represented.".

> Would you really write:
> 	if ((s32)npages > (s32)-50000)
> 		...
> Because that is what you are generating.
>

So instead of comparing s32 with int, which can be misleading. I prefer to compare s32 with s32.
 
> Here it probably doesn't matter, but it is really bad practise.
> If, for example, 'npages' is 64 bit than the cast can change the value.

In our case npages is s32.

Thanks

