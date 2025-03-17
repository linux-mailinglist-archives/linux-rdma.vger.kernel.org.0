Return-Path: <linux-rdma+bounces-8734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1BEA63B8F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 03:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5563AE132
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C31527B4;
	Mon, 17 Mar 2025 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qLF6FJz4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE451C5A;
	Mon, 17 Mar 2025 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742178468; cv=none; b=Ze/ZUeFJMIH/PF4SaoM8syLnk1Sw7jU4x9QDXfvO38MlJHm+ANLk165zGZfuxnaUt6bjb35XFQN1V50AmQsCutwOR+kjv0kkNlnFAGemwaVdZHlKUlYeeczdW33fJbKaA4itQsXKm4hBScdN0EL8mgyi2onYK9K0MuNyPGFbFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742178468; c=relaxed/simple;
	bh=mUzG+ik7zIOlXc8Gp465g6xDPDL5Ez55ulzZYdJhjHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TV6VTroD4odZCQ+HkBzFs1lI+qO/OBMc2q1GzJ7FUNZ5zdM3C6PcEz48EbIFQt4D8J4Adw2UzaDhIwvbE8KZOykimw2SLUJGJqbUwGsJv+qs37W6bvj6DHQ7U2sT2yQ2G1X3w8LYalVmJKYEC8/c1u3gatmuepDgq26hq7nCEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qLF6FJz4; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742178454; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EJ8I6/uv4gDuHu2hvbLCTYuIGGwSQNob954hSFwxMc0=;
	b=qLF6FJz40MncyjKiyeTOctQcBe9lw6wNbxfVXX5WmU1DW+eR3w0WtQK73jk15YE0r83aTvIWxT/TV8VmueBEEvP5V0tPK+v7qLMztzQeUyUgVGIJW8iT5yS4zLe9dRvj0lTGU8IRx68yTAQbed59/knRH09Yx5n4u81Y+xyvqwQ=
Received: from 30.221.64.192(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WRXrLf._1742178452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 10:27:33 +0800
Message-ID: <67a12e7e-51ff-36bf-a575-b77c09b56110@linux.alibaba.com>
Date: Mon, 17 Mar 2025 10:27:32 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] RDMA/erdma: Fix exception handling in
 erdma_accept_newconn()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kai Shen <kaishen@linux.alibaba.com>,
 Leon Romanovsky <leon@kernel.org>, Yang Li <yang.lee@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <2e9ae1d6-4bbb-470f-957f-bb6ea2e0829e@web.de>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <2e9ae1d6-4bbb-470f-957f-bb6ea2e0829e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/13/25 8:10 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 13 Mar 2025 11:44:50 +0100
> 
> The label “error” was used to jump to another pointer check despite of
> the detail in the implementation of the function “erdma_accept_newconn”
> that it was determined already that corresponding variables contained
> still null pointers.
> 
> 1. Thus return directly if
>    * the cep state is not the value “ERDMA_EPSTATE_LISTENING”
>      or
>    * a call of the function “erdma_cep_alloc” failed.
> 
> 2. Use more appropriate labels instead.
> 
> 3. Delete two questionable checks.
> 
> 4. Omit extra initialisations (for the variables “new_cep”, “new_s” and “ret”)
>    which became unnecessary with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 920d93eac8b9 ("RDMA/erdma: Add connection management (CM) support")


I think this patch does not fix issues, so fix line is not needed.

Thanks,
Cheng Xu


> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

<...>


