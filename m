Return-Path: <linux-rdma+bounces-7321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC55A22519
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 21:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B981888564
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35B1E231A;
	Wed, 29 Jan 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUJoaTk6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8B199EBB;
	Wed, 29 Jan 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182340; cv=none; b=r4ITPvwDXd0GBsA+Twr5lAtxI7CZAwCOO4bpGnqueSFCIVdfDVneJdyKEfA7N1GzyQyocyFtXA2ZMxpg8iYs3P4idIprxTgrW6dkIZT0poBWuWbU42roTeOBfJt+7TMzDyKhJII0qWxua50QaYPUB9bYexxOUVXm7RKeI6wsHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182340; c=relaxed/simple;
	bh=jWYBgTZ+e713q1truIMeBpIfqf1mHmj6NxMwHo8FFSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4EOJWVCoD+6XuT80cTUPZHpEHdTvg6IfpnK4imCCS3/kIat972bZiXytfzwOimu1RGPDUTq4vn7GI18qPjGN/p4LB5u4T/bdhNqXM9AKDLUIIeV2oHhHakOKZPzKpArSI1yqo6JufS0WIBVNqBJWirCot5Q9nAJ75Cg2CE08KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUJoaTk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66680C4CED1;
	Wed, 29 Jan 2025 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182339;
	bh=jWYBgTZ+e713q1truIMeBpIfqf1mHmj6NxMwHo8FFSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUJoaTk65DBXA+PoVCm5Au570I6BncU6nyGlNIcvXOHATYvmkZI2lxwin5JExqcum
	 tkmRCMZWMEcIo3dOkKP4+bKIXGAYm+XnCRlodbgyQFBz9QOlR+Szxhkisy/9Mr7GUT
	 YdVjbQKH6+aIAxKNADhYBZ41iKGS83ZZZWZuN2hHb1cu6sk1xIibHfFq2kPAmRBixP
	 pe4QZvF+bloECBF/xE/2HX6OQfmpHSkqdDu9jPt0fJsnsEJ3zjqu+ZASWuv3hcTQSc
	 mY/eFl2PyBdBxBn0fKPUz2+dFap790vl6GAwjfq2ZlpJbIRd5LAFOcvPDX8euiWHB5
	 zQIfdcK8+hMlQ==
Date: Wed, 29 Jan 2025 12:25:37 -0800
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
Message-ID: <20250129202537.GA66821@sol.localdomain>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca>
 <20250129185115.GA2619178@google.com>
 <20250129194344.GD2120662@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129194344.GD2120662@ziepe.ca>

On Wed, Jan 29, 2025 at 03:43:44PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 06:51:15PM +0000, Eric Biggers wrote:
> > Hi Jason,
> > 
> > On Wed, Jan 29, 2025 at 02:30:09PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 29, 2025 at 10:44:39AM +0100, Zhu Yanjun wrote:
> > > > 在 2025/1/27 23:38, Eric Biggers 写道:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > 
> > > > > The usual big endian convention of InfiniBand does not apply to the
> > > > > ICRC field, whose transmission is specified in terms of the CRC32
> > > > > polynomial coefficients.  
> > > 
> > > This patch is on to something but this is not a good explanation.
> > > 
> > > The CRC32 in IB is stored as big endian and computed in big endian,
> > > the spec says so explicitly:
> > > 
> > > 2) The CRC calculation is done in big endian byte order with the least
> > >    significant bit of the most significant byte being the first
> > >    bits in the CRC calculation.
> > 
> > (2) just specifies the order in which the bits are passed to the CRC.  It says
> > nothing about how the CRC value is stored; that's in (4) instead.
> 
> It could be. The other parts of the spec are more definitive.
>  
> > The mention of "big endian" seems to refer to the bytes being passed
> > from first to last, which is the nearly universal convention.
> 
> The LFSR Figure 57 shows how the numerical representation the spec
> uses (ie the 0x9625B75A) maps to the LFSR, and it could be called big
> endian.
> 
> Regardless, table 29 makes this crystal clear, it shows how the
> numerical representation of 0x9625B75A is placed on the wire, it is
> big endian as all IBTA values are - byte 52 is 0x96, byte 55 is 0x5A.
> 
> > (I would not have used the term "big endian" here, as it's
> > confusing.) 
> 
> It could be read as going byte-by-byte, or it could be referring to
> the layout of the numerical representation..
> 
> > > If you feed that to the CRC32 you should get 0x9625B75A in a CPU
> > > register u32.
> > > 
> > > cpu_to_be32() will put it in the right order for on the wire.
> > 
> > I think cpu_to_be32() would put it in the wrong order.  Refer to the following:
> 
> It is fully explicit in table 29, 0x9625B75A is stored in big
> endian format starting at byte 52.
> 
> It is easy to answer without guessing, Zhu should just run the sample
> packet through the new crc library code and determine what the u32
> value is. It is either 0x9625B75A or swab(0x9625B75A) and that will
> tell what the code should be.
> 
> Jason

        static const u8 data[52] = {
                0xf0, 0x12, 0x37, 0x5c, 0x00, 0x0e, 0x17, 0xd2, 0x0a, 0x20, 0x24, 0x87, 0xff, 0x87, 0xb1,
                0xb3, 0x00, 0x0d, 0xec, 0x2a, 0x01, 0x71, 0x0a, 0x1c, 0x01, 0x5d, 0x40, 0x02, 0x38, 0xf2,
                0x7a, 0x05, 0x00, 0x00, 0x00, 0x0e, 0xbb, 0x88, 0x4d, 0x85, 0xfd, 0x5c, 0xfb, 0xa4, 0x72,
                0x8b, 0xc0, 0x69, 0x0e, 0xd4, 0x00, 0x00
        };
        pr_info("crcval=0x%x\n", ~crc32_le(~0,data,sizeof(data)));

crcval=0x5ab72596

So yes, the InfiniBand spec gives swab(0x5ab72596) = 0x9625B75A.

It's a least-significant-bit first CRC32, so bits 0 through 31 of 0x5ab72596
represent the coefficients of x^31 through x^0 in that order.  The byte swap to
0x9625B75A reorders the coefficients to x^7 through x^0, x^15 through x^8, x^23
through x^16, x^31 through x^24.  (This is no longer a sequential order, so this
order is not usually used.)  The spec then stores the swapped value in big
endian order to cancel out the extra swap, resulting in the polynomial
coefficients being in a sequential order again.

IMO, it's easier to think about this as storing the least-significant-bit first
CRC32 value using little endian byte order.

- Eric

