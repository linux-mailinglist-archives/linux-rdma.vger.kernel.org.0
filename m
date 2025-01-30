Return-Path: <linux-rdma+bounces-7331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49EA22923
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 08:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94141638B0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF71A264A;
	Thu, 30 Jan 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r7LC5MFg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF219DF60
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222072; cv=none; b=VtjXazJXqNvWnMOxy3+PMHjKllz4gWeIX9uwwFpmLKLv8gYBd1fepPl3WecbYvZvSrdp+KWxwd3jV/kHgQdlO7gGKJaE7GqKYilLX44CMUOUr1MPi6XPqqU3SqSAhDhc82sdGamlPVgO7HE9bTBzHV93FEufgaAjx4tsfqwYpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222072; c=relaxed/simple;
	bh=7ooFrYEvXGppgi1m3ADXnhqtmfTzP2mkrJO+malDlR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd+KhPHVC5xpxVwb6+9fVjmvR3KCttaNs9rc+bNyuG21YNSEt6VvsouqaEbeHzYhaB55wQkfc1dFYx1N7jfo3E3/hP7ccMeJUCwxhDB2QkOO9IxsMTA96fLcxn2hGFdnIAsT0RFR99EYl9wKLiQAkTU/U4Qx58stn7XzMgjTkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r7LC5MFg; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3feb12a-aca9-40b8-8a51-cc9fedce45e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738222068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+Av1dENmYikaBPtQcog50en8sIRIC8K1StuKHu6dvA=;
	b=r7LC5MFgaJkLjxdR5esCnPD3wUbYJeEgscYb+Ks2vKqP+lfq1iqkEL9OotkKWLlilxryJn
	efBJK9fS9K9QhFnH+UAFFJa4E35W61e7yJeQXEwhGP9V/r7hiyUtFcsA4uPzXgx69mqqNl
	LGrG3Ke+hbCgGAGlZFvGnNRyDY8gWRQ=
Date: Thu, 30 Jan 2025 08:27:44 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-rdma@vger.kernel.org,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Bernard Metzler <bmt@zurich.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250129183009.GC2120662@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/29 19:30, Jason Gunthorpe 写道:
> On Wed, Jan 29, 2025 at 10:44:39AM +0100, Zhu Yanjun wrote:
>> 在 2025/1/27 23:38, Eric Biggers 写道:
>>> From: Eric Biggers <ebiggers@google.com>
>>>
>>> The usual big endian convention of InfiniBand does not apply to the
>>> ICRC field, whose transmission is specified in terms of the CRC32
>>> polynomial coefficients.
> 
> This patch is on to something but this is not a good explanation.
> 
> The CRC32 in IB is stored as big endian and computed in big endian,
> the spec says so explicitly:
> 
> 2) The CRC calculation is done in big endian byte order with the least
>     31 significant bit of the most significant byte being the first
>     bits in the 32 CRC calculation.
> 
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
> 
> Since rxe doesn't have any cpu_to_be32() on this path, I'm guessing
> the Linux CRC32 implementations gives a u32 with the
> value = 0x5AB72596 ie swapped.
> 
> Probably the issue here is that the Linux CRC32 and the IBTA CRC32 are
> using a different mapping of LFSR bits. I love CRCs. So many different
> ways to implement the same thing.
> 
> Thus, I guess, the code should really read:
>   linux_crc32 = swab32(be32_to_cpu(val));
> 
> Which is a NOP on x86 and requires a swap on BE.
> 
> Zhu, can you check it for Eric? (this is page 229 in the spec).

Got it. In my IBTA spec, I can find what you mentioned in the IBTA spec.
Your explanation is in details and very nice.
Thanks a lot.

Zhu Yanjun

> 
> I assume the Linux CRC32 always gives the same CPU value regardless of
> LE or BE?
> 
> Jason


