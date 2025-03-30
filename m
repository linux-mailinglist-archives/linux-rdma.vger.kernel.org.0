Return-Path: <linux-rdma+bounces-9031-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E34A75939
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Mar 2025 11:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9991689EA
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Mar 2025 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619E19C54B;
	Sun, 30 Mar 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="css6jhxY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98367175D50
	for <linux-rdma@vger.kernel.org>; Sun, 30 Mar 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743328438; cv=none; b=PATiC9EDcgSuHz0S+i5XbnOZINRnpQK62ZApTHj1e2/OJvFcBoZMC49R9O/zwQK+3LsnH9O2V1J66Obmpaeni8tKdUbxhQBhHPuzUFAyfPavXAdOIC8yIXpmLZzSAEbtanC6lm8jx5ZYJhj/F/hTaXk3HOzwyN9uGdiLNp5bYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743328438; c=relaxed/simple;
	bh=Y77qOZJg1ztePs3u1ibfM+37emwBml1d4mvWvji+LaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWwMbQMo+7SwvkKnWpEf+BtomsxaeZaYVqh0BjR/77n0jA6OG+p6iec29nCtXglJNO1K0BQGFtwosi4AYHt0zois68iQ/UNXwiwqxUroXUMG7NyBRQ8uRXwypGDrVw0+dIPJpHZayeS0KY0nyrUhOHgLvy1kBmW4zdsfaG9CNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=css6jhxY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdc1fbbb-4299-4283-9bac-f1d7fb6962b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743328424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28ZmjUKSGx9bHyjrPWK8SrKiBbCt6lY+A/8H7faqvwU=;
	b=css6jhxYQSoSJQO+hyUEb6FQkLXz6A011PSJP6LoueaA50IGcM4GFHbzDMaNL4clnzEIFk
	sE7mxlof2wEOKpVizkRCidqSOrRhD3dS5PSCyVWNVfYr7U+7iDTczD1dJQBd405ulhqf1z
	BUeNENUAV9Ac/WGg12TCfqvilw3btDs=
Date: Sun, 30 Mar 2025 11:53:33 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] IB/hfi1: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z-WgwsCYIXaBxnvs@kspp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z-WgwsCYIXaBxnvs@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/27 20:02, Gustavo A. R. Silva 写道:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct opa_mad_notice_attr` is a flexible structure --a structure
> that contains a flexible-array member.
> 
> Fix the following warning:
> 
> drivers/infiniband/hw/hfi1/mad.c:23:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> ---
>   drivers/infiniband/hw/hfi1/mad.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
> index b39f63ce6dfc..3f11a90819d1 100644
> --- a/drivers/infiniband/hw/hfi1/mad.c
> +++ b/drivers/infiniband/hw/hfi1/mad.c
> @@ -20,12 +20,14 @@
>   
>   struct trap_node {
>   	struct list_head list;
> -	struct opa_mad_notice_attr data;
>   	__be64 tid;
>   	int len;
>   	u32 retry;
>   	u8 in_use;
>   	u8 repress;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	struct opa_mad_notice_attr data;
>   };
>   
>   static int smp_length_check(u32 data_size, u32 request_len)


