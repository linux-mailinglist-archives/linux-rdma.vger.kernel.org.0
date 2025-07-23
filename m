Return-Path: <linux-rdma+bounces-12421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E340CB0ED89
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4527218910B5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642B9281375;
	Wed, 23 Jul 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/jQIqzd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189D274B3B;
	Wed, 23 Jul 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260258; cv=none; b=nHsrrxYX1qdPfya+ffVzUY0Q/EXCW9qAtwzys3pZ+HKzcD7TzY5DlRviR23wnmleWLGWzPcVryh/zhMPWpiakI/AlwHFpAaCoRGQ2Zv1kbKFx6h2qkwXpoigCqDuz9WdFtdexVJ4qoytWYQZYH7K3pbhyL1yQuZwsvAKs4KD32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260258; c=relaxed/simple;
	bh=Cj91CGuGavrB/ilqOlKndjatFWOMgTxiTvWRwwSAyXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6laDy29CB3aQbt9MmSBiNlWYm2XxzXrdpezDFmWJXO4ilJ+4XMrnu66vJCwYa9El/QIcs0kFbkcnJh+VGfOw58qdzGMDJ2Fd38zivkZu4kwZg+N08X1faAJ8OdAod09399+ero5xp3/yGRQjZ7pNAesI/hMObv37ei+5O3BAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/jQIqzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077C7C4CEF4;
	Wed, 23 Jul 2025 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753260257;
	bh=Cj91CGuGavrB/ilqOlKndjatFWOMgTxiTvWRwwSAyXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/jQIqzdz82x0nWSTcq4f0buV83Pk0LJSgQODn5pjrmjpwv5oy9a1d8mvYOCYdVOH
	 bdXSPn4PgwRtO9dST3nKHT5TYXR4D0lbuq0VYMy2LK2WQ8tGkqd62MiFZw3E5YA1+V
	 APES5GMOW46WRZWXbPOt0PFGaEfxcmpX5ZU7O9INHYCZGqFw/ylFGGERRmyWD2Q5u+
	 C0riJKs1eAlwPzfqs69FDmjTezmgWk9NwcQbHqxK4y8D01b28cCc7w3FT3bMoQXkso
	 mDdwnRJk7eIzRHR57iMNUzD9DuAxsqerjLb5vvC3jhbdTL1pfEkFX8w1K57J9Sc/r3
	 j+tg72bbOJh1Q==
Date: Wed, 23 Jul 2025 11:44:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] *** GPU Direct RDMA (P2P DMA) for Device Private
 Pages ***
Message-ID: <20250723084413.GO402218@unreal>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250720103003.GH402218@unreal>
 <35ff6080-9cb8-43cf-b77a-9ef3afd2ae59@nvidia.com>
 <20250721064904.GK402218@unreal>
 <aIBfIxVBR/3ig/O/@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIBfIxVBR/3ig/O/@ziepe.ca>

On Wed, Jul 23, 2025 at 01:03:47AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 21, 2025 at 09:49:04AM +0300, Leon Romanovsky wrote:
> > > In fact, hmm_range_fault doesn't have information about the destination
> > > device that will perform the DMA mapping.
> > 
> > So probably you need to teach HMM to perform page_faults on specific device.
> 
> That isn't how the HMM side is supposed to work, this API is just
> giving the one and only P2P page that is backing the device private.

I know, but somehow you need to say: "please give me p2p pages for
specific device and not random device in the system as it is now".
This is what is missing from my PoV.

Thanks

