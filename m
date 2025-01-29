Return-Path: <linux-rdma+bounces-7319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD822A2245B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 20:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26923188707F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E81E102D;
	Wed, 29 Jan 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs4L1aca"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03C1DE2AD;
	Wed, 29 Jan 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738177337; cv=none; b=DBvpucEizM/3rhEDMtZaEeAwM9x4Dm5Mv+RmOH4YnrZNWbJ3typJJ9ZvucgMiTa+ygt6JPR9z5+v47h1RDrF1wye1nJCXnsNjcMpdD37b6arQRGUkChqKvrh4K5hdCQPMPBgPkUCBoEzBQrhjAfRNNLz+Z3loC4GF0/sAOLqi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738177337; c=relaxed/simple;
	bh=oAQdIZYEB/M1UM7YZv1r2cNCJCd2w9Lm7XA+6+u1ko4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK1URhcxa9R3mkIWY9pUyjVIKvu+ZgQ7n20avjRwHd5EAn1rT2bzRRf6vNSif+gpoTaH39kgsPtoeM8DBZoglsmO2Tc9v34OLuTOfpXHTc+15kG7+ycGgRlvgRNK2yOHYX8IMivKvxztf2SyRhNHTasXgK3TlqrZ8e/sosik8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs4L1aca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF65C4CED1;
	Wed, 29 Jan 2025 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738177336;
	bh=oAQdIZYEB/M1UM7YZv1r2cNCJCd2w9Lm7XA+6+u1ko4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fs4L1acaZYshDCsmrzvUnoJYRuHAp9ksLyCJp1lWVbI2LSZRhXdsBRmh4rXI+y76Q
	 ZmRF5creNJ8QJ6NBtDhJ1A5K2w/1F4BoSfU41pcojCDXYBqe30szIX0zwN4IN4BlAX
	 eK4qmu6cOoT+GTTPrNhMB/ypZyqBOcYFmlFY3Fkpd3FhE2ajw0bHrjStEpRQ5D7Cz3
	 8E1/zJ8HW2ndi/bQCiI9XaXKVIII6R6p6znx3sfSAxcfICgyDpqEJ+aSbanOx14CV7
	 uigLZCHnIgagozoMv1c7Annj5bLT3LAeaoepY6964cwR+Q/U0+j6pyG3tFjm7Cpu7F
	 laY25pBzIsllw==
Date: Wed, 29 Jan 2025 19:02:15 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
Message-ID: <20250129190215.GB2619178@google.com>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <d0d05601-0eee-4684-9ed0-d6da8938603b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0d05601-0eee-4684-9ed0-d6da8938603b@linux.dev>

On Wed, Jan 29, 2025 at 07:27:20PM +0100, Zhu Yanjun wrote:
> 在 2025/1/27 23:38, Eric Biggers 写道:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > The usual big endian convention of InfiniBand does not apply to the
> > ICRC field, whose transmission is specified in terms of the CRC32
> > polynomial coefficients.  The coefficients are transmitted in
> > descending order from the x^31 coefficient to the x^0 one.  When the
> > result is interpreted as a 32-bit integer using the required reverse
> > mapping between bits and polynomial coefficients, it's a __le32.
> In InfiniBand Architecture Specification, the following
> "
> The resulting bits are sent in order from the bit representing the
> coefficient of the highest term of the remainder polynomial. The least
> significant bit, most significant byte first ordering of the packet does not
> apply to the ICRC field.
> "
> and
> "
> The 32 Flip-Flops are initialized to 1 before every ICRC generation. The
> packet is fed to the reference design of Figure 57 one bit at a time in the
> order specified in Section 7.8.1 on page 222. The Remainder is the bitwise
> NOT of the value stored at the 32 Flip-Flops after the last bit of the
> packet was clocked into the ICRC Generator. ICRC Field is obtained from the
> Remainder as shown in Figure 57. ICRC Field is transmitted using Big Endian
> byte ordering like every field of an InfiniBand packet.
> "
> 
> It seems that big endian byte ordering is needed in ICRC field. I am not
> sure if MLX NIC can connect to RXE after this patchset is applied.

As I mentioned in my response to Jason, it's a least-significant-bit first CRC,
so the mapping between bits and polynomial coefficients is reversed from the
natural order.  So that needs to be kept in mind.

In "Figure 56 ICRC Generator" (looking at
https://www.afs.enea.it/asantoro/V1r1_2_1.Release_12062007.pdf) that shows the
sample hardware, it looks like what's going on is that the bytes are already
reversed in the hardware, i.e. what it calls bits 0 through 7 are the
coefficients of x^0 through x^7, which in a software implementation are actually
in bits 31 through 24.  Thus in software it would be a __le32.

- Eric

