Return-Path: <linux-rdma+bounces-5084-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9B98564E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDAA2847FB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423E15B54E;
	Wed, 25 Sep 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czXe/MS5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D715696E;
	Wed, 25 Sep 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256411; cv=none; b=N/S+BQ9Dpm40YFC/5OYUt5QC7mV4EzQBH/n2fyWwzxbHWtHK/x36g0juNs9RmQV3PZcnudoAKO8T/9TIxt6zWdM8sSbhrelKzcBaqr+yzuU9TD90fPhV0hhagcIWPOBvKBnnLYe9jmCslDhNu566mtg8NmKXMzp3k3FSp59b7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256411; c=relaxed/simple;
	bh=BpYw0/PY3nUKuGYmrFd2VEU+1WnGJEzl1EFkES0lhdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5aUEbN9T3yu49E0js7Vkd27XVGmb4/c9+BR+Bv2/25lZbVpMxemt2/nsW7mulUtW4WrpcwxlSI8O9xCc8ioX94nbq4qD4uOaWmaa5pmD4o1omsZY2eAsg9Y/5bLes4hhCEg5FEi8tuDgugkITXTaqt421d2YT3iz2koErJBDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czXe/MS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C31C4CEC3;
	Wed, 25 Sep 2024 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727256410;
	bh=BpYw0/PY3nUKuGYmrFd2VEU+1WnGJEzl1EFkES0lhdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czXe/MS5lkFRAI+SEkAnjfhu8tVNguHaf8ImTy0yb9fzio2as+fvoECKpeYtR2uze
	 4Gm48t6UhqC+fUbmo6hJObNdcnYvvnIuxZ/SDMaFFTyo3RTKcgyq73zPI0unoMatel
	 Ya2XizH2jOdH/+Ne4Ncx2ZoPFx5f1X9FgRWOepGfIghxxddlQCLaOiqd2J8qIzis1A
	 SEYReiUlvGpQbrOperzsiZjwH8kIHx1Sog08usRPqAY2PfermmyAHEvzLKKMBIg518
	 MsYUCjFuiMItHtyzoq+jTkx+KgNYQdNsz94t2UlGnymutiteqkUL4TzyvvhY0zKmHI
	 quDahHav2wtIw==
Date: Wed, 25 Sep 2024 12:26:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Haakon Bugge <haakon.bugge@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Message-ID: <20240925092645.GD967758@unreal>
References: <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
 <ZvFY_4mCGq2upmFl@infradead.org>
 <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
 <ZvJiKGtuX62jkIwY@infradead.org>
 <1ad540cb-bf1b-456b-be2d-6c35999bdaa8@linux.dev>
 <66A7418F-4989-4765-AC0F-1D23342C6950@oracle.com>
 <5b86861b-60f7-4c90-bc0e-d863b422850f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b86861b-60f7-4c90-bc0e-d863b422850f@linux.dev>

On Wed, Sep 25, 2024 at 10:04:21AM +0800, Zhu Yanjun wrote:
> 在 2024/9/24 23:16, Haakon Bugge 写道:
> > 
> > 
> > > On 24 Sep 2024, at 15:59, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> > > 
> > > 在 2024/9/24 14:54, Christoph Hellwig 写道:
> > > > On Tue, Sep 24, 2024 at 09:58:24AM +0800, Zhu Yanjun wrote:
> > > > > The users that I mentioned is not in the kernel tree.
> > > > And why do you think that would matter the slightest?
> > > 
> > > I noticed that the same cq functions are used. And I also made tests with this patch series. Without this patch series, dim mechanism will not be invoked.
> > 
> > Christoph alluded to say: Do not modify the old cq_create_cq() code in order to support DIM, it is better to change the ULP to use ib_alloc_cq(), and get DIM enabled that way.
> 
> Hi, Haakon
> 
> To be honest, I like your original commit that enable DIM for legacy ULPs
> because this can fix this problem once for all and improve the old
> ib_create_cq function.
> 
> The idea from Christoph will cause a lot of changes in ULPs. I am not very
> sure if these changes cause risks or not.
> 
> Thus, I prefer to your original commit. But I will follow the advice from
> Leon and Jason.

Christoph was very clear and he summarized our position very well. We
said similar thing to SMC folks in 2022 [1] and RDS is no different here.

So no, "old ib_create_cq" shouldn't be used by ULPs.

Thanks

[1] https://lore.kernel.org/netdev/YePesYRnrKCh1vFy@unreal/

> 
> Zhu Yanjun
> 
> > 
> > 
> > Thxs, Håkon
> > 
> 
> 

