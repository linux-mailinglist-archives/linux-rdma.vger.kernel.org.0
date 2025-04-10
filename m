Return-Path: <linux-rdma+bounces-9335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA7A8456D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C3F1B84F69
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275928A3FE;
	Thu, 10 Apr 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXj1ixJ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43526ACB;
	Thu, 10 Apr 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293312; cv=none; b=RVhKpAqR8uLCFUbJt4JP1YgT/VFgHTKsUG7ipXT19HCC903/a350/O7z1rgPkjN/5xBjvvq3KhcJ10kMP7RopECAYFZHC397hMrxONSisn2P0iPH7ZVQ3w59kDYZMpB7LHIgOO2SNpEEfLg96ENN0MHylcwqqXt9SxCgZpGVku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293312; c=relaxed/simple;
	bh=p6SCvTMZTG8S3u0hXcPVYGmdpHI9zrLpcY6+qewRNrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKQPtaXQmVIHEXhkpFM/cA6g+PfmRzVq5mLnieQ2Zn7xVnZqaIIP7FfNSRtLLyArkSsM6v8TlHCFjDdF7rkgBSIQsCgTQJfuwZOEk7HUo0/WR7+C2s5epZk6RdJiDEI5z/IKg7qLACP6DrZx1ux7hAC+ggot+IiXVUdSGK2l21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXj1ixJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B88C4CEDD;
	Thu, 10 Apr 2025 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744293310;
	bh=p6SCvTMZTG8S3u0hXcPVYGmdpHI9zrLpcY6+qewRNrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXj1ixJ4ZhLovviw79iMjdKUdRXCSLBKuSD/Y/oGP8+vJFA9tg+AZh3ot8Pm03tAR
	 XiZOfzKtQDkSR8oRjnmKKIoMf5GU0RUg/h6/OliDtAnR1glTDexTq9ZtrnhaWBGnUM
	 7eFldfm9vLY+WjK/So/+Tx4q5UUkVlNnGPNyZuLgAEiR8+hvIJzcY8OiDy+IvCS4TI
	 3BYcrE1W/mmfEzwS96p1cDQyp8q+kWabBwP899n4gaK6/wMQp3ZDdskLSECQTjsEI8
	 5NTEzOwHI+0G8VwPpED4MiEOijmi/z70TFIRwol4l2J3LteMyQGrIiiMR9xUkzqpcC
	 9Z+e6eey+c+XA==
Date: Thu, 10 Apr 2025 16:55:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 3/3] RDMA/mana_ib: Add support
 of 4M, 1G, and 2G pages
Message-ID: <20250410135504.GU199604@unreal>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
 <1743777955-2316-4-git-send-email-kotaranov@linux.microsoft.com>
 <20250409122743.GK199604@unreal>
 <PA1PR83MB0662BB595EEA7FE39B97422EB4B72@PA1PR83MB0662.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1PR83MB0662BB595EEA7FE39B97422EB4B72@PA1PR83MB0662.EURPRD83.prod.outlook.com>

On Thu, Apr 10, 2025 at 01:38:39PM +0000, Konstantin Taranov wrote:
> > 
> > >  enum gdma_page_type {
> > >  	GDMA_PAGE_TYPE_4K,
> > > +	GDMA_PAGE_SIZE_8K,
> > > +	GDMA_PAGE_SIZE_16K,
> > > +	GDMA_PAGE_SIZE_32K,
> > > +	GDMA_PAGE_SIZE_64K,
> > > +	GDMA_PAGE_SIZE_128K,
> > > +	GDMA_PAGE_SIZE_256K,
> > > +	GDMA_PAGE_SIZE_512K,
> > > +	GDMA_PAGE_SIZE_1M,
> > > +	GDMA_PAGE_SIZE_2M,
> > > +	/* Only when
> > GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB is set */
> > > +	GDMA_PAGE_SIZE_4M,
> > > +	GDMA_PAGE_SIZE_1G = 18,
> > > +	GDMA_PAGE_SIZE_2G
> > 
> > Where are all these defines used?
> 
> There are not used explicitly in this patch, but they can be used in theory.

Yes, please.

> I can remove unused defines in V2.
> 
> > 
> > Thanks

