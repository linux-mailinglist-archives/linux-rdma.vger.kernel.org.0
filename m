Return-Path: <linux-rdma+bounces-11623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28302AE7FC4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 12:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE4B7B087A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA42BD01A;
	Wed, 25 Jun 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4Yvtps7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F62882AE;
	Wed, 25 Jun 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848081; cv=none; b=fgJM3+0bagnOrs+62mpDKZEORQCm+uPXcWpWJ5tidtl7o7SeV+NHrXKhk6f3llhxXVJrJaU0YgpivdgUwcaQedSjTjDrneWQXjadKsJu12E9ilPWUOuOIQx5KHXdbLF8VfeMjZc3Rsjzn1SkXEL8VKcqI6TTKNbg/ceEGgRIEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848081; c=relaxed/simple;
	bh=ryiSRspiIu/wkeSXQlap1GFlD0iyPfd6nzncNwWyfrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWfCVdDWUywwN6Pl11OYdLzJUS6ygf9pIJQuOApmOUw61+akpr1ZRdfWNcuyLHWm1Y/wH3fk2bcp0N/SC0q7XoyIkhJFt35OzI8NoBj1jLzm3I+x6ppPb6hC38Os6MfoD6XKpTSu707cbbUA2snQ213kcmHzKkc+P9kAoKqGiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4Yvtps7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2CDC4CEEE;
	Wed, 25 Jun 2025 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750848079;
	bh=ryiSRspiIu/wkeSXQlap1GFlD0iyPfd6nzncNwWyfrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4Yvtps7GF1EG0qj/Zi9nTU0T8U3WUIkHllgVT0TQNgZ0XLFGJE5fDKl91/e2Hbyc
	 peCczBHBcHTYG+T52wHbl9m5DtPda/0Is43xoD4oPS68GSJAM2U69Xp8T3g3uw5e7I
	 0gk/dvg4/Enk7xlgjckz2lzVTWf+r33Czb4u21sQ6p3cuTmV49MRqwYxLx2tmKBisC
	 /xEsFfMt6W0ykJi3ucyGHLgvEwy8E37kZfsDXYUypKbclGAcOIKm+OtzAUnqnD5Bs2
	 vVKC6s9Y60GUrZXSQ5UI6nXM4saLMQYQ0LbVFVwK4pEc0gDVWLd2xCROFG7Howb4Zw
	 UYPhj2X6T8GTw==
Date: Wed, 25 Jun 2025 13:41:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] RDMA: hfi1: cpumasks usage fixes
Message-ID: <20250625104113.GE17401@unreal>
References: <20250604193947.11834-1-yury.norov@gmail.com>
 <20250612081229.GQ10669@unreal>
 <aFbJpqbP-tU4q84P@yury>
 <ed72aae3-e9c2-4768-a400-cb99cb2a0f24@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed72aae3-e9c2-4768-a400-cb99cb2a0f24@cornelisnetworks.com>

On Mon, Jun 23, 2025 at 12:23:36PM -0400, Dennis Dalessandro wrote:
> On 6/21/25 11:03 AM, Yury Norov wrote:
> > On Thu, Jun 12, 2025 at 11:12:29AM +0300, Leon Romanovsky wrote:
> >> On Wed, Jun 04, 2025 at 03:39:36PM -0400, Yury Norov wrote:
> >>> The driver uses cpumasks API in a non-optimal way; partially because of
> >>> absence of proper functions. Fix this and nearby logic.
> >>>
> >>> Yury Norov [NVIDIA] (7):
> >>>   cpumask: add cpumask_clear_cpus()
> >>>   RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
> >>>   RDMA: hfi1: simplify find_hw_thread_mask()
> >>>   RDMA: hfi1: simplify init_real_cpu_mask()
> >>>   RDMA: hfi1: use rounddown in find_hw_thread_mask()
> >>>   RDMA: hfi1: simplify hfi1_get_proc_affinity()
> >>>   RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c
> >>>
> >>>  drivers/infiniband/hw/hfi1/affinity.c | 96 +++++++++++----------------
> >>>  include/linux/cpumask.h               | 12 ++++
> >>>  2 files changed, 49 insertions(+), 59 deletions(-)
> >>
> >> Dennis?
> > 
> > So?.. Any feedback?
> 
> I'm ambivalent about this patch series. It looks OK but I don't think it's
> really fixing anything.

Yeas, I applied because more code was deleted than added.

