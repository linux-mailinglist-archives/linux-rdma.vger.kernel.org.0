Return-Path: <linux-rdma+bounces-7330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58BEA2291F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 08:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E569C1887256
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10951A2658;
	Thu, 30 Jan 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jfs6ilb7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C3186294
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738221919; cv=none; b=JKVTxRSZmOyD4KxNMtuVg/+qSDZelpLWoS0rgMKfwD0flUMBuLUq2tknh+RO5XJWowsaQD2+q3wQbl9KQVAeFCu7r6gLA9W3N5bFjBLD2CpZ4Xl4OzZ4q0IlRCYiLmDINE7n7NKLS+fUq3vczSlIvM9ifLgAzsdRAg0fhJywSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738221919; c=relaxed/simple;
	bh=MPnYrHNTMSDIcwmlnM1o3VT0DVHuBVurmpj2nb+XE9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fscPKPc6YMjBNM5poxupFElB1pf6ThvFQoEerPwdkqFkJ73n4rzf2fSKMBHPmIK6oLP47WWkalLM6lTbqZH+9RLp6YOS+NOACgQ8nfqsYhV0yDbJIkC0mbjUzWnf4AAvj0Rlo8bJK+J+7mM0ZHwmMXEgenoiQUw6Ek3uvoHdV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jfs6ilb7; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0043edb8-8bba-4675-b0b6-fdb70fb2e091@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738221905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aBdVoYOk1UYxoS6kFBBQpVcD0kNVu6r4+xutia7Dlc=;
	b=jfs6ilb7eMwoovtWlajWP4zHqUaEu4SuaLGvTPlc/N8oP/3J4qLZEqLeo6Bdio8Q49YrOU
	wSObM5lA6R2O0r6NFkrzKXoMsZ3XTsTgawLUlpqjJw00Rn9uIY/xaOQk5mLpnMTRClpCF5
	tR64vgXxtKRgh3J+t7+8pWwruLLculs=
Date: Thu, 30 Jan 2025 08:24:59 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] RDMA/rxe: consolidate code for calculating ICRC of
 packets
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-rdma@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Bernard Metzler <bmt@zurich.ibm.com>,
 linux-kernel@vger.kernel.org
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-3-ebiggers@kernel.org>
 <048daa22-fdc6-4f5f-9fa3-e023dc421aab@linux.dev>
 <20250130021526.GD66821@sol.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250130021526.GD66821@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/30 3:15, Eric Biggers 写道:
> On Wed, Jan 29, 2025 at 07:11:35PM +0100, Zhu Yanjun wrote:
>> 在 2025/1/27 23:38, Eric Biggers 写道:
>>> From: Eric Biggers <ebiggers@google.com>
>>>
>>> Since rxe_icrc_hdr() is always immediately followed by updating the CRC
>>> with the packet's payload, just rename it to rxe_icrc() and make it
>>> include the payload in the CRC, so it now handles the entire packet.
>>>
>>> This is a refactor with no change in behavior.
>>
>> In this commit, currently the entire packet are checked while the header is
>> checked in the original source code.
>>
>> Now it can work between RXE <----> RXE.
>> I am not sure whether RXE <---> MLX can work or not.
>>
>> If it can work well, I am fine with this patch.
>>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
> 
> Both the header and payload are checksummed both before and after this patch.
> Can you elaborate on why you think this patch changed any behavior?

 From the source code, it seems that only the header is checked. And RXE 
can connect to MLX RDMA NIC. That is, the CRC of the header can be 
verified both in RXE and MLX RDMA NIC.

Now in your commit, the header and payload are checked. Thus, the CRC 
value in RDMA header may be different from the CRC of the header(that 
CRC can be verified in RXE and MLX RDMA NIC). Finally the CRC of the 
header and payload will not be verified in MLX RDMA NIC?

IMO, after your patchset is applied, if RXE can connect to MLX RDMA NIC, 
I am fine with it.

In the function rxe_rcv as below,
"
...
     err = rxe_icrc_check(skb, pkt);
     if (unlikely(err))
         goto drop;
...
"
rxe_icrc_check is called to check the RDMA packet. In your commit, the 
icrc is changed. I am not sure whether this icrc can also be verified 
correctly in MLX RDMA NIC or not.

Because RXE can connect to MLX RDMA NIC, after your patchset is applied, 
hope that RXE can also connect to MLX RDMA NIC successfully.

Thanks,
Zhu Yanjun


> 
> - Eric


