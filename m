Return-Path: <linux-rdma+bounces-4488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2895B481
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9D1C208E0
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE661C9EC1;
	Thu, 22 Aug 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J0rU6Lpa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23617B500
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328080; cv=none; b=dP5W+QfaoCDLNyPJaUdJoeHQ51o8LOgXOEHhaqkBexBEFFFtRT2PK1pZRsMLxC4ixS1USS1sRyy+dzu9yLph6ulj5LV510kzzzrDc2qtaJGo2pFAYDzPm+7kdnxulX9dJB2rbDylFA5w0lSoWu52IpiVV50aNv0Y1VCabiHUvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328080; c=relaxed/simple;
	bh=B1GmYG22aYb2qwX2+iovsKSPoDaIn5LWJpKX7nGJmN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ8idUIN/NUt3TfJx68N5XTMQgdeeJJ3z3VQVmpcc5mAX66GaNE61m/J13gJe9RQiaXnC9mcpqzstMtVLZcpvUnvl+rTgG9+XHniO9jRxaL3Y8WIBAnMxCa0mEYNXZ4y4tQfwEXEIHNjPPF+8/jn2zSbYmvJBzl193BXBRgMTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J0rU6Lpa; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <498e1a80-f00f-4b63-904e-223d5fb1b196@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724328071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxRa/K+FICy0WD8g8V6RZ+fEAgwo3fL45kQ+ET0XDYU=;
	b=J0rU6Lpamyw8Syj9XyjOPPPJUeicnkEqBgcdoL+vQMuo3zW95PxX/7pe2+XsOB8IDfWifN
	zDNfFHPbvEwvIKkP7q8j7fsO7fE9PoaA1C9fjTDGp6oaA59d93Wa5hAtDOllAX6xK3J0lt
	3JFF+/OcTW5d2yTMWCGZ3aQuLD02hzU=
Date: Thu, 22 Aug 2024 20:01:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] RDMA/rxe: Typo fix
To: zhenwei pi <pizhenwei@bytedance.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-3-pizhenwei@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240822065223.1117056-3-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/22 14:52, zhenwei pi 写道:
> Fix 'rmda' into 'RDMA'.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Thanks.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index bf8f4bc8c5c8..c11ab280551a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -341,7 +341,7 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
>   	/*
>   	 * See IBA C9-92
>   	 * For UD QPs we only check if the packet will fit in the
> -	 * receive buffer later. For rmda operations additional
> +	 * receive buffer later. For RDMA operations additional
>   	 * length checks are performed in check_rkey.
>   	 */
>   	if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {


