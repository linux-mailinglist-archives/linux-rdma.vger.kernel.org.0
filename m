Return-Path: <linux-rdma+bounces-4490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A295B522
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6801C23082
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9DC1C9453;
	Thu, 22 Aug 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tpCBY1KW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095ED13A244
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330266; cv=none; b=pS9OXJ3ZMUrkvJAt5sJ4RMCvwGOFC4nM+yE8SuZxS3wf/rN2WufYQ49J+zmZElt5P73so8HOnjdb+1HCjFYYCaj9aTOQDJpE/nEe+fYzmj1C3TZKAC3mB170u5Idom+wnuUzZt4fo9pAPGwerPZpbI39DJyjuIdJ4uDwUaJDeko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330266; c=relaxed/simple;
	bh=m4eAqlOALYiNADHtZcTKBreDzy7UXLRpycdyENC6K6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkDyDbbx34LVskIU90rr0YXcioKQvjjh94uLbONlkCv2YcOLLpzR6sSfBCST268ouIyH8Cv7bkuECcxSg0p8KOf4nbI/smP1X+HRV1ZTPBd36O4M7dxDKys6Dacqy2T2PRW67xIMVbDX7EggYxM+8eqLxKC3K1jv8mWtNYKBwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tpCBY1KW; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b3ca8f8-7e08-4ced-9f95-23130fafb9a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724330262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvjTSWHl+hPsPL2upFPMulHKLi9FzDpQcEiaaYK/0Wg=;
	b=tpCBY1KWhFdfuJ6EhC68J30YaSH3M3C0LNp2v9EWz9qxzKEOHd4zVa6IeCzGYMvD5m+DCy
	IcdHr2UiAfwfLdHcML9gjRPgCwekwlis4xLoVh20zGp/MvJnqQpRnMD9jRVOtsW3G7Mz4k
	szwqh+/DbG1C45HGoSN0Ww6gTHveVb0=
Date: Thu, 22 Aug 2024 20:37:36 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] RDMA/rxe: Fix __bth_set_resv6a
To: zhenwei pi <pizhenwei@bytedance.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-4-pizhenwei@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240822065223.1117056-4-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/22 14:52, zhenwei pi 写道:
> __bth_set_resv6a is used to clear BIT [24, 29] of rxe_bth::qpn, the
> wrong expression leads other BITs into 1.

 From the spec
"
9.2.11 RESERVE 6(RESV6) - 6 BITS
Reserved (variant) - 6 bits. Transmitted as 0, ignored on receive. This 
field
is not included in the invariant CRC.
C9-6: When generating a packet, the sender shall set the Resv6, F/Res1
and B/Res1 fields to zero. In general, the receiver shall ignore the 
reserved
fields.
"
I agree with you.
Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_hdr.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
> index 46f82b27fcd2..1f0322491d8c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hdr.h
> +++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
> @@ -234,7 +234,7 @@ static inline void __bth_set_resv6a(void *arg)
>   {
>   	struct rxe_bth *bth = arg;
>   
> -	bth->qpn = cpu_to_be32(~BTH_RESV6A_MASK);
> +	bth->qpn &= cpu_to_be32(~BTH_RESV6A_MASK);
>   }
>   
>   static inline int __bth_ack(void *arg)


