Return-Path: <linux-rdma+bounces-7646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE9BA2F63D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 19:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5480A188439C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A5255E42;
	Mon, 10 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3xzQ8S4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5624418C;
	Mon, 10 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210407; cv=none; b=TYvH9nXa0b/B/UGYJ/c0CaP0XC/tGSMC3CK5LjOyvO5GfsdRePZHPbP6UHUjb6cEKnXBMWcP3wUnWMRazL1uyTN2lY3YVDDrkvrZeOWNDzDyrdR1EJsE4qxZeOeYGpeK65YEGMI9HKQbsmqWFgUZlfvq+7H2Qe6ZFc0of1ptMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210407; c=relaxed/simple;
	bh=1sRd6SLf08idOZTnt/wPTPKpubV5V6E4Po7IfkUz+8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaevGlvYzYK/PFZRC+ZE8LuMn9iwiC+05JEVh3nqzIrKU75VmwCrYPRJQ7yNy4MOAXS163+fz8kgoeRqfwe2JWYBG1edj7X7NDO6T7WI/Udf7So8Q1Y/EKMDSeKOrfs8or1eAH9oUrPpZ86ttHIsxiRC5QDdpJHp6F4wy8JncUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3xzQ8S4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BD0C4CED1;
	Mon, 10 Feb 2025 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739210407;
	bh=1sRd6SLf08idOZTnt/wPTPKpubV5V6E4Po7IfkUz+8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3xzQ8S4OvU62D3PyL1n9Bty9HiMFu2U/qRNCNnCpXIu3uAEl7BhnuXisblKVKdhH
	 16/0JFfqI9+50Dt0nOc7d7cyhbIEIXXm/ECIJZXQl2cs+EpykoN2Tqy5s5QNW8kug2
	 XtsCDh9elsA+zf4BNS4yeZ6eWCpCvQnxxU6KyC1EwgP1hOnPQisBWzJjmCg7fJ1DFy
	 TUFjRVFpe7jNunbaiX1zqtSrvxsG3cFu4Ew6qu+IuhNGObjP7E+ElaHMeJvpX5UrgW
	 CapbRj1L4bu/kHDZ0qFlnRkOBL5LQDMoasGpX8fIS48UBS2NnzdHqfUMhKN4Su1sKb
	 fKD6u61u+dckw==
Date: Mon, 10 Feb 2025 10:00:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/irdma: switch to using the crc32c library
Message-ID: <20250210180005.GE1264@sol.localdomain>
References: <20250207033643.59904-1-ebiggers@kernel.org>
 <20250207035750.GA43210@sol.localdomain>
 <20250209091255.GA17863@unreal>
 <20250209154416.GA1230@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209154416.GA1230@sol.localdomain>

On Sun, Feb 09, 2025 at 07:44:18AM -0800, Eric Biggers wrote:
> On Sun, Feb 09, 2025 at 11:12:55AM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 06, 2025 at 07:57:50PM -0800, Eric Biggers wrote:
> > > On Thu, Feb 06, 2025 at 07:36:43PM -0800, Eric Biggers wrote:
> > > > +int irdma_ieq_check_mpacrc(const void *addr, u32 len, u32 val)
> > > >  {
> > > > -	u32 crc = 0;
> > > > -
> > > > -	crypto_shash_digest(desc, addr, len, (u8 *)&crc);
> > > > -	if (crc != val)
> > > > +	if (~crc32c(~0, addr, len) != val)
> > > >  		return -EINVAL;
> > > >  
> > > >  	return 0;
> > > >  }
> > > 
> > > Sorry, I just realized this isn't actually equivalent on big endian CPUs, since
> > > the byte array produced by crypto_shash_digest() used little endian byte order,
> > > whereas crc32c() just returns a CPU endian value.
> > > 
> > > And of course this broken subsystem uses u32 for the little endian values
> > > instead of __le32 like the result of the kernel.
> > > 
> > > Not sure it's worth my time to continue to try to fix this subsystem properly.
> > 
> > There is no need to be such dramatic. You are not fixing anything by
> > switch to new APIs
> 
> Exactly.  That's because I dropped the patches that actually did fix real
> endianness bugs, because of the pointless pushback I received -- see
> https://lore.kernel.org/linux-rdma/20250127223840.67280-1-ebiggers@kernel.org/T/#u

Anyway, I already sent v3 of this patch that keeps the cpu_to_le32() to maintain
the exact same behavior as the old code, so please consider that if you are
interested.  Note that I had to add '(__force u32)' to be compatible with this
driver's incorrect types, but that was effectively already there before, just
hidden by writing bytes into a u32.

- Eric

