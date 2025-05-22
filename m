Return-Path: <linux-rdma+bounces-10533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61813AC0CC2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1AB1624C4
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BACD28BA82;
	Thu, 22 May 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liUUg6uh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133328BA9A
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920548; cv=none; b=ECrtilPQTKV+y5BUt6aU/Zfv16OeQWVE0ngkQtfaZv1SfjTyWggzS10U7b9IfyLY6DBqCSNslnFLl1XH2jR8Z5apGpFINh3xtSC0lOtbX4+V1RH3A1ynDYXtQ0Mv1fEkhxlLdcyPImkcW8wbEV4QjdvME7xUDy4l/xZRIcuG03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920548; c=relaxed/simple;
	bh=qjw4rnqr37/XOrKDkd2Lxp+KRhfyhnwGsN7+FBpUT24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRuUUhaGmBNxoyXFp6xb481DSAw2MvkrI3ZxyjxsavZtcGyNiJd0CN26Q+EOP/vX9xmsh6UuJqbftTMCmwXY5t8TQUfxYkvOdD3PYome6sMUbNnTTj6UznmJGV2pNIYhELj9+AiN+dRVp2RE3iasVy9+ywwxOmzvji0SfLFIANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liUUg6uh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c27df0daso4450243b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747920545; x=1748525345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gK4n6E4VOcll5TxrlVGhNj/kWzcbVSmTb4uP4qAj834=;
        b=liUUg6uhCbwdf+K8sc7e2nGoYBIVEiw6AxFKWKZZedbCWanr8R+h3CHmxU2xmvIFRt
         tRMHwyBNwFRNuazQO8HcFKezkb8jGTWg/3HhDBd/x7T9q9dJFYR2pWSjCT24Vp0L4h1x
         oxCwdFvjDphVUJ0XEWdftMYnwo9n8LlE650RU6snenF3mS4yQ0qKmFAMFUSwvsWFLZ8r
         4IApAK5ixUETiVXrQFuAk/LWOr2yuemZ3xf8RdP/ndWYqI/FiyD0Rh7q1f2OtTgrK+kb
         zVHkBWNYpOcq9Bie27orqt8194eVtALa69sH0/oWL5G9TxCGVGrONjMxVIy0ONQH5ODT
         BZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920545; x=1748525345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gK4n6E4VOcll5TxrlVGhNj/kWzcbVSmTb4uP4qAj834=;
        b=J14FKASM38Bm12dEdwY5I9IdS3jGBBy2IL8/K+G2/vGoiWVpDZv5pEerQf24tdWiAM
         mpBCZt7wlw6Db3Po82Qbk57UKIZ4RDw1sRrItVuAq19rW/incV1EpVkeH747hPp29FhP
         o9xSHBa7vfUTA37d034ZAacxT6EPSOnSppU+x4q0vuPl68Dt41rk6aAGZWEkQShgxOiS
         LhxIL0ZDML4T83ITe22Z7nt5dUkPQXcNiiAZmOxyyN42l/8vMgZTE7Q9+RNUP1Giuq14
         dI7q7vATuEPfgbE7RPZirIYnehSU47i5y2zFB9Qfg8fCLnkLWjN/HckygZDgHSKpfnlx
         ubPA==
X-Forwarded-Encrypted: i=1; AJvYcCVFMOZV7FMt+YBxSFnnqG2yJRZrFIySAKiFQqGebj3FRc6qQ36735ldLhGpjljnN1fnnAJB1pz1iuBS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtts8REjT11dFyU4Y3dE9odAPjxo8VhtZHtx6OlCchPOdX/0ws
	WPOdkgwigfObwK8I4looOe1l5d/Fph//9wjKq6V64xWpDN5IY7y3wSqc
X-Gm-Gg: ASbGncsoISAVrJKDbiqc09yCG1suR2gyE8nWirtwry9ohA/AsW6uV+fJttHxcs6kOC6
	PG0suTUiQoBM3aAL3DLMWlhiATFFjIK85m2SNyUwzLJ0ghOKlxooYn4V354JzPPr+7uS7XDZm9i
	Z5enzNLCbI7n2PtU5Xf74aXdBe9hmxOzdn3VkG9QJjK2NIkTPuvQrL1V/v5efk3rvy2bjPq3as4
	YAO6xU4MAbhSd+CrVLtCZ99fxk65inIxwPFufZ52yeyUL9eaeFqSz4LhYcCWfAsUZQ0UJSY/Ket
	z5fnHkgD63t56zMOLzI5JVilX1lJeLk7VW6mLKbbwCwl+XZaLfIQBBBt0Bsif1XwbpUBEqq82fh
	wzi3MQj75uzfMtPK4wtLNFFOl+kE=
X-Google-Smtp-Source: AGHT+IHvebejzdE9uu2QiZ6i1CfxdcHSON9IJx/tto/2YUZTtQ22JFs2RuSlFjguYYkyn99Hr7WPzQ==
X-Received: by 2002:a05:6a00:198e:b0:740:91e4:8107 with SMTP id d2e1a72fcca58-742a963242bmr35547399b3a.0.1747920545420;
        Thu, 22 May 2025 06:29:05 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0b1sm11637181b3a.109.2025.05.22.06.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 06:29:05 -0700 (PDT)
Message-ID: <72a82333-b005-4383-888c-7632bf1ce4ae@gmail.com>
Date: Thu, 22 May 2025 22:29:02 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO
 pages
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 Zhu Yanjun <zyjzyj2000@gmail.com>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025/05/22 20:36, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> RO pages has "perm" equal to 0, that caused to the situation
> where such pages were marked as needed to have fault and caused
> to infinite loop.
> 
> Fixes: eedd5b1276e7 ("RDMA/umem: Store ODP access mask information in PFN")
> Reported-by: Daisuke Matsuda <dskmtsd@gmail.com>
> Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Tested-by: Daisuke Matsuda <dskmtsd@gmail.com>

Thank you!
This change fixes one of the two issues I reported.
The kernel module does not get stuck in rxe_ib_invalidate_range() anymore.


The remaining one is the stuck issue in uverbs_destroy_ufile_hw().
cf. https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/

The issue occurs with test_odp_async_prefetch_rc_traffic, which is not yet
enabled in rxe. It might indicate that the root cause lies in ib_uverbs layer.
I will take a closer look anyway.

Thanks,
Daisuke


> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index a1416626f61a5..0f67167ddddd1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
>   	while (addr < iova + length) {
>   		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
>   
> -		if (!(umem_odp->map.pfn_list[idx] & perm)) {
> +		if (!(umem_odp->map.pfn_list[idx] & HMM_PFN_VALID)) {
>   			need_fault = true;
>   			break;
>   		}


