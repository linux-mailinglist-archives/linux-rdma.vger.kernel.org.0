Return-Path: <linux-rdma+bounces-7584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1356BA2DBBC
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 10:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437E41887527
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A231614885B;
	Sun,  9 Feb 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFLGf6wG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7742AA1;
	Sun,  9 Feb 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739092381; cv=none; b=Jn2s72stYoEx4Y04QwpSXH1anzAmPG5tFigBlqTWLshpWyhFM6FTwzuKHKFBDaVtIKtmM/5LHSxuXQyyJrc/pReUYai8pmcyt/9trCjpmYdtFjZucPCX3DA1GqvMwdjQ068aiFVVPDQp/UFLmCXkzjlAxEUD4Yu4syA6Q2POntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739092381; c=relaxed/simple;
	bh=Zo26W+AxME1VyFaWRMAwG1ZblAxqB3gp560tf9irJRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsU/+OT0CYnEFpQyRPL/eVz1dE65y55R/kKCjcvMDTZs0aJ5LRdoJwQ62Rrey2jEvYKDzVzD8GbOnibB2IIvAHd1npcVRW1J0NpoCYmDINv31XVxrtZU0fT7gebnhVSn7yN/mLgriuV8fuNcI90MQJ1+S/WX9vtQq8BiBej5lqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFLGf6wG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E3EC4CEDD;
	Sun,  9 Feb 2025 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739092380;
	bh=Zo26W+AxME1VyFaWRMAwG1ZblAxqB3gp560tf9irJRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFLGf6wG10UHnnoVElM/XdZEcwWLn0DZx+2bhIS0F+pZ8dZWVlEaGivbGCZJf9uJk
	 j6khniYuArfGfA9JZe2+rtCBu7awnp5ZIACy8FeviU1SGB04mVHYfizm5XFZHtSUZm
	 zuYKnzr1Gx/YL6WNips5A01fJGluefXTOXouf+ArDFZ6L/nE2/5m6IQA/T5Wvb9G9F
	 8vLQmlgO+kehK4ceGX7mgwAWTbEWIugU3Ti8V5jmTzjyL7sRTpykuJpN+IVvqxbv//
	 Xl28TCmnLdfk5oWtElt5i9Kkz14ZhZDadU1gG1PCcGh3ZbHjonNBX+tIXt3CxmIrYt
	 u+FignkpNJaZw==
Date: Sun, 9 Feb 2025 11:12:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/irdma: switch to using the crc32c library
Message-ID: <20250209091255.GA17863@unreal>
References: <20250207033643.59904-1-ebiggers@kernel.org>
 <20250207035750.GA43210@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207035750.GA43210@sol.localdomain>

On Thu, Feb 06, 2025 at 07:57:50PM -0800, Eric Biggers wrote:
> On Thu, Feb 06, 2025 at 07:36:43PM -0800, Eric Biggers wrote:
> > +int irdma_ieq_check_mpacrc(const void *addr, u32 len, u32 val)
> >  {
> > -	u32 crc = 0;
> > -
> > -	crypto_shash_digest(desc, addr, len, (u8 *)&crc);
> > -	if (crc != val)
> > +	if (~crc32c(~0, addr, len) != val)
> >  		return -EINVAL;
> >  
> >  	return 0;
> >  }
> 
> Sorry, I just realized this isn't actually equivalent on big endian CPUs, since
> the byte array produced by crypto_shash_digest() used little endian byte order,
> whereas crc32c() just returns a CPU endian value.
> 
> And of course this broken subsystem uses u32 for the little endian values
> instead of __le32 like the result of the kernel.
> 
> Not sure it's worth my time to continue to try to fix this subsystem properly.

There is no need to be such dramatic. You are not fixing anything by
switch to new APIs, there is nothing broken with old API and you are
changing specific driver and not subsystem.

So there are at least three mistakes in sentence "... fix broken subsystem ...".

Thanks

> 
> - Eric

