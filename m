Return-Path: <linux-rdma+bounces-7334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A7A22A21
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 10:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E8A7A273C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE71ACEB3;
	Thu, 30 Jan 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qnbfDMAV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67602139B
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228655; cv=none; b=God5Upm6OSok42GXi/rIgRGQqb/sFPpZMcvnHQPpBulGRK7nhteq7cpR+uKX38PLKe66UzzgbhHJC0iZ4uzxnZC4vjeLBeGLi2D29ZT5VMSl7o+RIfaqaMKRwa2dUmOa2LJN+Aw3OBvJ1J2044dgTGgF37CFjF1IiVflkBJqhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228655; c=relaxed/simple;
	bh=4c+G/QXyXIyW+db+AzIawUuoUqLWZPB7WUowgajOpw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9DYm7nFLVHpnGvjLT1uiGjUXfLa/N9d/XIINXmtqIgBW2yTzLlZiojw/OvM9JA18QHWWsPDYyAchkxx2wFFbapA8Llfz958eCTRuW3PMHmtKQhKGftQk0onXGa8+MALJADPcj+gQmaiGLlsKjQJhP37Ly2tzfrZXZOi8vXJRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qnbfDMAV; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb650c16-8d22-4527-9378-2025a6ad1cb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738228641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKj8xiJaOUldXpOs/fuN9givLSKmgfZHEO8V0DKV1/I=;
	b=qnbfDMAVXL64TU8kZRudE9HgUdUo3DqDEn/amkeKgJSTf97adcvPni2vA5tzPtYKWATcku
	fVKLtdm25pbHRXg1y0zl5ZeTZHCFZ35eRw/qfz4YxVSjYP5BqRkEACwLUGX1zSx8jsCt8K
	v6LS3yMTvgA3kpTDrS8SmQW6T1mcNeo=
Date: Thu, 30 Jan 2025 10:17:17 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
To: Jason Gunthorpe <jgg@ziepe.ca>, Eric Biggers <ebiggers@kernel.org>
Cc: linux-rdma@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Bernard Metzler <bmt@zurich.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca> <20250129185115.GA2619178@google.com>
 <20250129194344.GD2120662@ziepe.ca>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250129194344.GD2120662@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29.01.25 20:43, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 06:51:15PM +0000, Eric Biggers wrote:
>> Hi Jason,
>>
>> On Wed, Jan 29, 2025 at 02:30:09PM -0400, Jason Gunthorpe wrote:
>>> On Wed, Jan 29, 2025 at 10:44:39AM +0100, Zhu Yanjun wrote:
>>>> 在 2025/1/27 23:38, Eric Biggers 写道:
>>>>> From: Eric Biggers <ebiggers@google.com>
>>>>>
>>>>> The usual big endian convention of InfiniBand does not apply to the
>>>>> ICRC field, whose transmission is specified in terms of the CRC32
>>>>> polynomial coefficients.
>>>
>>> This patch is on to something but this is not a good explanation.
>>>
>>> The CRC32 in IB is stored as big endian and computed in big endian,
>>> the spec says so explicitly:
>>>
>>> 2) The CRC calculation is done in big endian byte order with the least
>>>     significant bit of the most significant byte being the first
>>>     bits in the CRC calculation.
>>
>> (2) just specifies the order in which the bits are passed to the CRC.  It says
>> nothing about how the CRC value is stored; that's in (4) instead.
> 
> It could be. The other parts of the spec are more definitive.
>   
>> The mention of "big endian" seems to refer to the bytes being passed
>> from first to last, which is the nearly universal convention.
> 
> The LFSR Figure 57 shows how the numerical representation the spec
> uses (ie the 0x9625B75A) maps to the LFSR, and it could be called big
> endian.
> 
> Regardless, table 29 makes this crystal clear, it shows how the
> numerical representation of 0x9625B75A is placed on the wire, it is
> big endian as all IBTA values are - byte 52 is 0x96, byte 55 is 0x5A.
> 
>> (I would not have used the term "big endian" here, as it's
>> confusing.)
> 
> It could be read as going byte-by-byte, or it could be referring to
> the layout of the numerical representation..
> 
>>> If you feed that to the CRC32 you should get 0x9625B75A in a CPU
>>> register u32.
>>>
>>> cpu_to_be32() will put it in the right order for on the wire.
>>
>> I think cpu_to_be32() would put it in the wrong order.  Refer to the following:
> 
> It is fully explicit in table 29, 0x9625B75A is stored in big
> endian format starting at byte 52.
> 
> It is easy to answer without guessing, Zhu should just run the sample
> packet through the new crc library code and determine what the u32
> value is. It is either 0x9625B75A or swab(0x9625B75A) and that will
> tell what the code should be.

Got it. I will run the sample packet through the new crc library code 
and determine what the u32 value is.

Zhu Yanjun

> 
> Jason


