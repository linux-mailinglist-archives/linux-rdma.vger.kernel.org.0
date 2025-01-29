Return-Path: <linux-rdma+bounces-7318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B45A22446
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 19:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28241884EA2
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF81E0DE3;
	Wed, 29 Jan 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnKNBAZx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390D14F9FF;
	Wed, 29 Jan 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176678; cv=none; b=Hc7xVmvmIteF18ZJUtyF0RXMuaHLt5HuxqgyWK6mH5kheRK2pvQbzINBTfc0G75BpuDQbkkrRzt309M9Pt4o9eWGYX20IHOoP3YOhRTELz0DkvUJMkx7sDNMZu0c1qSt06LyrpeeHtMm84t/WLA51sbrHfYlm7BLZ34zCJUYpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176678; c=relaxed/simple;
	bh=r8KtgGecYFd/yeF5r0KoW3jxaSk038livwh2km4LNvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeC+aB5D4GQbjglu1o5a0ucWQT//xsX4QTNj2jrY5fOxFsTsWAvXAL5TsTKDHDmkk8yHmT6CmNEbq/iG16hxZ1+GGqLk7yGaRN3aYsPdWvbKfnezC2orNEOCw/zJs5HegDwbp+PvLgYTZUqf2usXxX0cII6nSmAc/x8MVXesBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnKNBAZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF70C4CED1;
	Wed, 29 Jan 2025 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738176677;
	bh=r8KtgGecYFd/yeF5r0KoW3jxaSk038livwh2km4LNvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnKNBAZxukoJKUUF17vmpVhhHWe2wtfc9DuGuAcJdGlDE5ik+9iGx8Mqecr8IIwjr
	 fIRaEZYT8fgKnNAKHx+miuQLHW30IvL1osqXv++CgojCLPOTn2ZygXAkLtL7xqH3gO
	 K6EV3S52ym2DfBkiWQdBgoDp094daO1ncc/mz7j2QOvS2M3z7HuDPOeB5kItD0ccSt
	 536b0pAouwj5ed1+LEpf4Wf8Xol9pk8ukJWv8u4MA6xXhD8RSz8AdxpWVeLIor6E0j
	 4pXEw8NGmV5L7Ir98iPoMv1ah4KEzPlKHTZKzsbH0tQ/ZGR/k4dMR1D75lOhKtr95a
	 z8uZodet3sA6w==
Date: Wed, 29 Jan 2025 18:51:15 +0000
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
Message-ID: <20250129185115.GA2619178@google.com>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129183009.GC2120662@ziepe.ca>

Hi Jason,

On Wed, Jan 29, 2025 at 02:30:09PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 10:44:39AM +0100, Zhu Yanjun wrote:
> > 在 2025/1/27 23:38, Eric Biggers 写道:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > The usual big endian convention of InfiniBand does not apply to the
> > > ICRC field, whose transmission is specified in terms of the CRC32
> > > polynomial coefficients.  
> 
> This patch is on to something but this is not a good explanation.
> 
> The CRC32 in IB is stored as big endian and computed in big endian,
> the spec says so explicitly:
> 
> 2) The CRC calculation is done in big endian byte order with the least
>    significant bit of the most significant byte being the first
>    bits in the CRC calculation.

(2) just specifies the order in which the bits are passed to the CRC.  It says
nothing about how the CRC value is stored; that's in (4) instead.

The mention of "big endian" seems to refer to the bytes being passed from first
to last, which is the nearly universal convention.  (I would not have used the
term "big endian" here, as it's confusing.)  The rest clarifies that it's a
least-significant-bit (LSB)-first CRC, i.e. "little endian" or "le" in Linux
terminology.  (The Linux terminology here is a mistake too -- it would be
clearer to call it lsb rather than le, given that it's about bits.)

> In this context saying it is not "big endian" doesn't seem to be quite
> right..
> 
> The spec gives a sample data packet (in offset/value pairs):
> 
> 0  0xF0 15 0xB3 30 0x7A 45 0x8B
> 1  0x12 16 0x00 31 0x05 46 0xC0
> 2  0x37 17 0x0D 32 0x00 47 0x69
> 3  0x5C 18 0xEC 33 0x00 48 0x0E
> 4  0x00 19 0x2A 34 0x00 49 0xD4
> 5  0x0E 20 0x01 35 0x0E 50 0x00
> 6  0x17 21 0x71 36 0xBB 51 0x00
> 7  0xD2 22 0x0A 37 0x88
> 8  0x0A 23 0x1C 38 0x4D
> 9  0x20 24 0x01 39 0x85
> 10 0x24 25 0x5D 40 0xFD
> 11 0x87 26 0x40 41 0x5C
> 12 0xFF 27 0x02 42 0xFB
> 13 0x87 28 0x38 43 0xA4
> 14 0xB1 29 0xF2 44 0x72
> 
> If you feed that to the CRC32 you should get 0x9625B75A in a CPU
> register u32.
> 
> cpu_to_be32() will put it in the right order for on the wire.

I think cpu_to_be32() would put it in the wrong order.  Refer to the following:

    4. The resulting bits are sent in order from the bit representing the
    coefficient of the highest term of the remainder polynomial. The least
    significant bit, most significant byte first ordering of the packet does not
    apply to the ICRC field.

As per (2) it's a least-significant-bit first CRC, i.e. bit 0 represents the
coefficient of x^31 and bit 31 represents the coefficient of x^0.  So the least
significant byte of the u32 has the highest 8 polynomial terms (the coefficients
of x^24 through x^31) and must be sent first.  That's an __le32.  Yes, the fact
that the mapping between bits and polynomial terms is backwards makes it
confusing, but that's how LSB-first CRCs work.

> I assume the Linux CRC32 always gives the same CPU value regardless of
> LE or BE?

Yes, they return a u32.  (Unless you use crypto_shash_final or
crypto_shash_digest in which case you get a u8[4] a.k.a. __le32.)

- Eric

