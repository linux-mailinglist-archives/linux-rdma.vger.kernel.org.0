Return-Path: <linux-rdma+bounces-8656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E9A5F4A5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F4817304E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CE267383;
	Thu, 13 Mar 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIydCUWm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7026659C
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869408; cv=none; b=CpLZtUxeG0Ta/+vbAz0hAF2AksHKYn9CiaU6KFv1U25508jmUCyal+LuYBRvp0bAx+zm+8UET15NlfUPqSTVc5IkZeD+R7ZeFUmKdjpyUjYMspcIWpyDV8hNSg1ofBtQH7B7Ants0NxIJHHiWr5uJ+EhSK17L5yaOjwHaA9c2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869408; c=relaxed/simple;
	bh=LgHSOcoeWy5Lu7N8toKSsyW+LDCnUJQRGHkL290BvcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAgs49DDUA0vfilWnu4Ple6kd1QRa7y14vVm9lflHIBzVdzpgOqQ33Ekj96h0GUS0HLGT2rXAh4+buHlaEGZU9AB8OoovGDLlWnSuDvc0EdoNNimSZSBdwzcsxKxRvFgG2I8K7BI6y/NHQEX6uTs0Ko9gW9NRNsiYHXdsqMYuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIydCUWm; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36834db5-ae33-4239-91e4-4ee3febfca1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741869403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Hgzo+HATkvGKNIct8RAvPMego6ucMZ25I5yLqPtaV0=;
	b=qIydCUWm5YKRH4HLw8uLYUrMitiwuYbwn+wIMMNin9qR4b35RwIJvxaCmGEX1vRaSXSsS0
	IkBFTjY0zL8BoiIixy9Hb5TktS/JTfnSvD1zCw1mBeu/z1+B0QS5PbY6QvUMB2UAJbEuk3
	E9PoTBt9plu2zPlb1a2VI85ME0KJvfE=
Date: Thu, 13 Mar 2025 13:36:38 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect return value of
 rxe_odp_atomic_op()
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250313064540.2619115-1-matsuda-daisuke@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250313064540.2619115-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13.03.25 07:45, Daisuke Matsuda wrote:
> rxe_mr_do_atomic_op() returns enum resp_states numbers, so the ODP
> counterpart must not return raw errno codes.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

Thanks. I am fine with it.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 94f7bbe14981..9f6e2bb2a269 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -316,7 +316,7 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char),
>   					 RXE_PAGEFAULT_DEFAULT);
>   	if (err < 0)
> -		return err;
> +		return RESPST_ERR_RKEY_VIOLATION;
>   
>   	err = rxe_odp_do_atomic_op(mr, iova, opcode, compare, swap_add,
>   				   orig_val);


