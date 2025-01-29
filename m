Return-Path: <linux-rdma+bounces-7324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4282DA22624
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 23:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EDE18858E2
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778171E32CD;
	Wed, 29 Jan 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjghEIxB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D31E25FA;
	Wed, 29 Jan 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738189310; cv=none; b=S3XAq3blG3fpmFw0sVy4fzR/jc2qXb0bW58zQsc/ZEGayHyv6UMNCTvI/Y4RFuUC0olwVh8jvnnlD5n36U3JzOjIo62UjIumCNmEhwZVqFo4Pb0VZLEUYPO1DGakR8a4dQP0JAk68CNgQXXl2qMOJLMJsHuGw/RoCtLhcNyDhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738189310; c=relaxed/simple;
	bh=wMExSQshQTC/YkHmuY+dEp/nWZfX+pSy85NmmWgXJmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1vJT6bx2EHR7EONeSbGePy/LrwMpfdsfd4i3KXq1aUo+Znm4OBDLqj3+MlWiIqCPhHajfns65uJupTFdlTBiPqcFA/WhFQbrpXJnR0IUla/HC+PJjN7/I1JOIXW0zlRpGv510trFOed3IbmHeR9v3KugeCtVV0xUl0P9uPZH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjghEIxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60801C4CEE2;
	Wed, 29 Jan 2025 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738189309;
	bh=wMExSQshQTC/YkHmuY+dEp/nWZfX+pSy85NmmWgXJmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjghEIxBkt1EEdDhIkrMInNpiAnZPni1sESw+ZXXMqDs9GddcoZGsb5GFf3ac1QVO
	 mBIr0jhBs7kxxhKDdRw2yAg2DXTwOdZAz3wlsLp1X5jLsGyED6JHpZK1tI2wgjpklY
	 M0ePiBDrfp2U0uYixNrhsiD8HG3ZfykuXdxn4ORLo+ao5bMjt/XqYU6QD406JhSk+L
	 40MEVKpgL+sNoiUTTfSildI1BePChn+Eu3BEWVqBmvLHe0AgHCBHPMSqnlLxF7MoBr
	 5Y3bRI63R9mar0knW28bMQWwnMcQ66YrcCRJ+nmad8soXW+INfHEKorum+7bHUlhYv
	 5Z2GGGUkYWtmw==
Date: Wed, 29 Jan 2025 22:21:47 +0000
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
Message-ID: <20250129222147.GC2619178@google.com>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca>
 <20250129185115.GA2619178@google.com>
 <20250129194344.GD2120662@ziepe.ca>
 <20250129202537.GA66821@sol.localdomain>
 <20250129211651.GE2120662@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129211651.GE2120662@ziepe.ca>

On Wed, Jan 29, 2025 at 05:16:51PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 12:25:37PM -0800, Eric Biggers wrote:
> >         static const u8 data[52] = {
> >                 0xf0, 0x12, 0x37, 0x5c, 0x00, 0x0e, 0x17, 0xd2, 0x0a, 0x20, 0x24, 0x87, 0xff, 0x87, 0xb1,
> >                 0xb3, 0x00, 0x0d, 0xec, 0x2a, 0x01, 0x71, 0x0a, 0x1c, 0x01, 0x5d, 0x40, 0x02, 0x38, 0xf2,
> >                 0x7a, 0x05, 0x00, 0x00, 0x00, 0x0e, 0xbb, 0x88, 0x4d, 0x85, 0xfd, 0x5c, 0xfb, 0xa4, 0x72,
> >                 0x8b, 0xc0, 0x69, 0x0e, 0xd4, 0x00, 0x00
> >         };
> >         pr_info("crcval=0x%x\n", ~crc32_le(~0,data,sizeof(data)));
> > 
> > crcval=0x5ab72596
> > 
> > So yes, the InfiniBand spec gives swab(0x5ab72596) = 0x9625B75A.
> > 
> > It's a least-significant-bit first CRC32, so bits 0 through 31 of 0x5ab72596
> > represent the coefficients of x^31 through x^0 in that order.  The byte swap to
> > 0x9625B75A reorders the coefficients to x^7 through x^0, x^15 through x^8, x^23
> > through x^16, x^31 through x^24.  (This is no longer a sequential order, so this
> > order is not usually used.)  The spec then stores the swapped value in big
> > endian order to cancel out the extra swap, resulting in the polynomial
> > coefficients being in a sequential order again.
> 
> > IMO, it's easier to think about this as storing the least-significant-bit first
> > CRC32 value using little endian byte order.
> 
> To be most clear this should be written as:
> 
>   u32 ibta_crc = swab32(~crc32_le(..)) // Gives you the IBTA defined value
>   *packet = cpu_to_be32(ibta_crc); // Puts it in the packet
> 
> It follows the spec clearly and exactly.
> 
> Yes, you can get the same net effect using le:
> 
>   u32 not_ibta_crc = ~crc32_le(..)
>   *packet = cpu_to_le32(not_ibta_crc)
> 
> It does work, but it is very hard to follow how that relates to the
> specification when the u32 is not in the spec's format anymore.
> 
> What matters here, in rxe, is how to use the Linux crc32 library to
> get exactly the value written down in the spec.
> 
> IMHO the le approach is an optimization to avoid the dobule swap, and
> it should simply be described as such in a comment:
> 
>  The crc32 library gives a byte swapped result compared to the IBTA
>  specification. swab32(~crc32_le(..)) will give values that match
>  IBTA.
> 
>  To avoid double swapping we can instead write:
>     *icrc = cpu_to_le32(~crc32_le(..))
>  The value will still be big endian on the network.
> 
> No need to talk about coefficients.

We are looking at the same spec, right?  The following is the specification for
the ICRC field:

    The resulting bits are sent in order from the bit representing the
    coefficient of the highest term of the remainder polynomial. The least
    significant bit, most significant byte first ordering of the packet does not
    apply to the ICRC field.

So it does talk about the polynomial coefficients.

It sounds like you want to add two unnecessary byteswaps to match the example in
Table 25, which misleadingly shows a byte-swapped ICRC value as a u32 without
mentioning it is byte-swapped.  I don't agree that would be clearer, but we can
do it if you prefer.

- Eric

