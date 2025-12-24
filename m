Return-Path: <linux-rdma+bounces-15194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC472CDB225
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 03:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DDB7300525E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA32BD5A1;
	Wed, 24 Dec 2025 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pPPJefsp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325429DB86;
	Wed, 24 Dec 2025 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766542314; cv=none; b=UgkvT8E55XeMv5VqVX5egrV2RBcSGqDi3ivM0eBs7vdb/Gz6t6Y614bFv+JW6WLOHFJoRwLLVg2LuuyPMGxJ2xoMqHC+htbRFkPlYYYGfEbNW/P8FRVExFKKMII7Yt6nOhigUybp/EYgJoLTpiKc3fXszcek1yy/e5aNQpJ3rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766542314; c=relaxed/simple;
	bh=DBWlmYAyf29FL9SJ4hyALu15K0OPfhX/tfhstKLU1vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFy/1iYDsm6OWQrd+AsLkMtLcDahzrUKi7+jL1h8O9KjeFW4c6xVYM9Z4zSpgMCnU9knhxdLg+2jhbeRUjiBPpdk6xUYOXI7Ek/1S88WnpWaR+qV7wDZ3gtqIWmE4T13efHinmpagAI905F0F5h9epOPikhIcYTiBo6mUJDsfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pPPJefsp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=DFR+EF4MRtoAZqJUpf2vt2SeECHkRANPxw9XNTzk3bg=;
	b=pPPJefspcMC3ecNBKbhN0QRyntCsCrOyks4mhakiq8P8tPoN3+d+JVcotLoDu/
	H9TGbWe32krIARlNc7kLHbrlZAHPZvv30nbIpO6chPlfFDvH6XWdBGpKS6NK0gr8
	0NswKWRGHusqElCBAyrx1QKSLZRfAGwdWR/xN1ih89hZU=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHUdTAS0tprbCbJg--.48369S2;
	Wed, 24 Dec 2025 10:11:14 +0800 (CST)
Date: Wed, 24 Dec 2025 10:11:12 +0800
From: Honggang LI <honggangli@163.com>
To: Michael Gur <michaelgur@nvidia.com>
Cc: jinpu.wang@ionos.com, danil.kipnis@cloud.ionos.com, jgg@ziepe.ca,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr
 calculation
Message-ID: <aUtLwLfNVGEH6lEI@fedora>
References: <20251223034324.13706-1-honggangli@163.com>
 <eb0d0439-c09b-4c10-be5d-a338ede83742@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0d0439-c09b-4c10-be5d-a338ede83742@nvidia.com>
X-CM-TRANSID:PSgvCgBHUdTAS0tprbCbJg--.48369S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jr15Zw15WF4UWrWxurW3Wrg_yoW8JF48pa
	y7ZF9ruw4vyrZIywn7Aw4kZrn7Ars8CFWrGry8XryrCF17Xa42vry0yrW5W3srJr1xZr45
	t3yDXFnaya4rZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLa9hUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbC7AIwdWlLS8Lm2AAA3+

On Tue, Dec 23, 2025 at 04:08:19PM +0200, Michael Gur wrote:
> Subject: Re: [PATCH] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr
>  calculation
> From: Michael Gur <michaelgur@nvidia.com>
> Date: Tue, 23 Dec 2025 16:08:19 +0200
> 
> 
> On 12/23/2025 5:43 AM, Honggang LI wrote:
> > If the low two bytes of ib_dev::attrs::max_mr_size are zeros, the `min3`
> > function will set clt_path::max_pages_per_mr to zero.
> 
> Can't see how if the low two bytes of max_mr_size are zero it would cause
> the local variable max_pages_per_mr to zero.
> The more probable cause is that max_mr_size bits in the range
> [mr_page_shift+31:mr_page_shift] are zero. Since that's what's left after
> division and cast to u32.

Yes, you are right. The irdma support max_mr_size is 0x200000000000.
[mr_page_shift+31:mr_page_shift], a.k.a [43,12] are zeros.

> This means you are working on a device supporting more pages_per_mr than can
> fit in a u32.
> 
> > -		min3(clt_path->max_pages_per_mr, (u32)max_pages_per_mr,
> > +		min(min_not_zero(clt_path->max_pages_per_mr, (u32)max_pages_per_mr),
> 
> This still fixes the issue, but for readability, if max_pages_per_mr is
> larger than U32_MAX, I'd set it to be U32_MAX.

I will set it to U32_MAX as you suggested.

thanks


