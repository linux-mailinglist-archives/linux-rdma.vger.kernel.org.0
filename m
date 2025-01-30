Return-Path: <linux-rdma+bounces-7328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A97A2279A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 03:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E553162452
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 02:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471C2556E;
	Thu, 30 Jan 2025 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAInSLwM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605128F3;
	Thu, 30 Jan 2025 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738202645; cv=none; b=JsJ4nrKgy/zgp9mLSgNY1Vt5k4rIYTWYDUOvKOnkGFFVreqAYNn1LvtDrGu7NAJH82ND4BYE1gSyrlMP3Hw1bk2dVs4nYp0+nHPC0c7zenPBVEIFMDyGmyM2272ZJ+IwQB6hvu3LXRjtOUnEkwuHmaCy0VhSUrTJF0+6By6wLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738202645; c=relaxed/simple;
	bh=vDVk3WjfELp5mGUJQoP5luT3xyiNzrWqp1d23UCVtqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti0HL6FGB2B1BTImZXU7ZU5qKJ6PrQo9tF4LT17A4KIhMcOy2B4XtT8ob8DQ/EaKNnK5u1eQ5Xaj0vA4a89hjubm05OAkiMgl8uXV1gtyMTX4ZvnrIJhH8WMPpnsRgFaP6FNykDtmO3Vm84cN1+JUjnlKB5Of/15lOZqFeJhZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAInSLwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF07AC4CED1;
	Thu, 30 Jan 2025 02:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738202645;
	bh=vDVk3WjfELp5mGUJQoP5luT3xyiNzrWqp1d23UCVtqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAInSLwMd999eA8iUfoe8TPSEOiOUDa21YWDgQiqRXvara6Vyw7Lkk6dBDwY4shIa
	 Y5cq2rxT4jjCZCv8HedxS3SkxGB7atx8Bch7RbACGHza5m227UxSgKbahvJTO3poZE
	 RQnkmARx2++kk5G0RxTnMknljpmq6CBhaR/buO2jvSpAd8jquMTJ6pb3lS5xjesnVW
	 cvVEdtHhFNDFcH/Qs41DjRfgb4FEnsPnnnTsnGilwbnhT+J8L4YgYBXTAPYl+XH+1g
	 M8am0a8n3o9favkNPw5aPY9twrqjMXb7Du6Z0LN3WLSCIy+3QhqgtkDh7gySVwIvcS
	 9rRZO+ofoh5zw==
Date: Wed, 29 Jan 2025 18:04:03 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
Message-ID: <20250130020403.GC66821@sol.localdomain>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca>
 <20250129185115.GA2619178@google.com>
 <20250129194344.GD2120662@ziepe.ca>
 <20250129202537.GA66821@sol.localdomain>
 <20250129211651.GE2120662@ziepe.ca>
 <20250129222147.GC2619178@google.com>
 <20250130012951.GF2120662@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130012951.GF2120662@ziepe.ca>

On Wed, Jan 29, 2025 at 09:29:51PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 10:21:47PM +0000, Eric Biggers wrote:
> 
> > > To be most clear this should be written as:
> > > 
> > >   u32 ibta_crc = swab32(~crc32_le(..)) // Gives you the IBTA defined value
> > >   *packet = cpu_to_be32(ibta_crc); // Puts it in the packet
> > > 
> > > It follows the spec clearly and exactly.
> > > 
> > > Yes, you can get the same net effect using le:
> > > 
> > >   u32 not_ibta_crc = ~crc32_le(..)
> > >   *packet = cpu_to_le32(not_ibta_crc)
> > > 
> > > It does work, but it is very hard to follow how that relates to the
> > > specification when the u32 is not in the spec's format anymore.
> > > 
> > > What matters here, in rxe, is how to use the Linux crc32 library to
> > > get exactly the value written down in the spec.
> > > 
> > > IMHO the le approach is an optimization to avoid the dobule swap, and
> > > it should simply be described as such in a comment:
> > > 
> > >  The crc32 library gives a byte swapped result compared to the IBTA
> > >  specification. swab32(~crc32_le(..)) will give values that match
> > >  IBTA.
> > > 
> > >  To avoid double swapping we can instead write:
> > >     *icrc = cpu_to_le32(~crc32_le(..))
> > >  The value will still be big endian on the network.
> > > 
> > > No need to talk about coefficients.
> > 
> > We are looking at the same spec, right?  The following is the specification for
> > the ICRC field:
> > 
> >     The resulting bits are sent in order from the bit representing the
> >     coefficient of the highest term of the remainder polynomial. The least
> >     significant bit, most significant byte first ordering of the packet does not
> >     apply to the ICRC field.
> > 
> > So it does talk about the polynomial coefficients.
> 
> Of course it does, it is defining a CRC.

Yes.

> From a spec perspective is *total nonsense* to describe something the
> spec explicitly says is big endian as little endian.

The spec also says "The least significant bit, most significant byte first
ordering of the packet does not apply to the ICRC field."  I.e. it is not big
endian.  The full explanation would need to point out the two seemingly
conflicting parts of the spec and how they are resolved.

> Yes from a maths perspective coefficients are reversed and whatever,
> but that doesn't matter to someone reading the code. 

It does matter.  Besides the above, it's also the only way to know whether the
least-significant-bit-first CRC32 (crc32_le()) or most-significant-bit-first
CRC32 (crc32_be()) is the correct function to call.

> There are an obnoxious number of ways to make, label and describe these LFSRs.
> IBTA choose their representation, Linux choose a different one.

It's a CRC, not an LFSR.  LFSR is an implementation choice.

> If you want to keep the le32 optimization, then keep it, but have a
> comment to explain that it is an optimization based on the logical
> be32 double swap that matches the plain text of the spec.

I will plan to clarify the comment to point out the two seemingly conflicting
parts of the spec and how they apply.

But feel free to send your own patches that you would approve of though, since
you seem very opinionated about this.

- Eric

