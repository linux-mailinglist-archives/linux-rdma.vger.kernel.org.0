Return-Path: <linux-rdma+bounces-3302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00190E6A5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D428343B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FECD7F47F;
	Wed, 19 Jun 2024 09:16:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00C57CAC
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788602; cv=none; b=rAJLv5al6Uq6mkl70OHsP2iU4QCwGgfOSdSiy1n0crO7uIerktU2SUxQSHaUe6o8qFkI3naSzT6oQPS17hERfYAjp123fiBvOVnhqn0P7LLoYOvhd3AdL4VHaskmk8fmaTdT3kqeYuFV33crIh0bblS3maXK1WO3n0zZ+23OWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788602; c=relaxed/simple;
	bh=NXMDx7HOF64tGEF5DDMgqAQsYHOdelVfoPIS4gGTooY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhotHW53znsBTr7rC9zkb6rsm5dOFGcOBovEsf3EStcDILH1WLJgHmNkKheRMYtdON+EeXblIum7wwTA1Aujgrxf8CUV3/wAHdssIwaRuxin+KoBpH0CoLKK9ZuC4kqdIZANS2wC8M8JY6MSGW9hxYV9GNVvPCO/qVVKLymRHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f23f3da48so541517f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 02:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788599; x=1719393399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0//pStmFFHWSOtCfn6ToCqy8bpe4PxQfeFWHsR89dJY=;
        b=fudCnNJWIqEmjMX+heC0IGSsoYLs6fe0GxizcRJrsKLUkOu2V89BIXReSVU6Ngg/+7
         mnHhVvV0vvfB4qSWvrxLyDGF/HnfDXADOd6NELjX3nEHFCJHLqP0jrTt9vngmH4QXpG6
         Gle8yPTbYaaQTJeJvDPYDXJEAF3mVtDgUJDL0CB6nCkuq/dEwz9Vajd7/vUjFXZUNKjQ
         8puZPcfC6S/A2f9teST0a050tPUBWU1z5pFXvGDwkwL2SY1Wj4Xwhe4+R8QZu2ju5ZJz
         gI/n/3SO3MyE9JsSXWWPoENnwmkeR8WN3/liEbTqq/ceZNp+tTzNqwQVI8tKZbyw/ok1
         0kTA==
X-Forwarded-Encrypted: i=1; AJvYcCVAoJnGmFoi2TUj0PpmdjHkSUv6yhDngWeWeMsrifN4hvmGaZD7NFCaaS60wXNj3WvtSrOI4RpvQRlwHFt7P9jiTC5j82RoFctjIQ==
X-Gm-Message-State: AOJu0YzijecFX/ac7W9bT0hwxuYIdBmJYtr+0f8r4TEDrAO9RaB/jig7
	MU8k2t05mdwUY/DU3aJHmGdT6Jvrjrf18X9dTz6JmcK+WcE0Q/OD
X-Google-Smtp-Source: AGHT+IEswHHQeRdbk/+Kn9td75vu7SYTc1eJTpQjs6DfmKMqwqQQbE3ZDyG7JU/dOZVdF0AQYBuMKw==
X-Received: by 2002:a5d:47cc:0:b0:360:874b:af9a with SMTP id ffacd0b85a97d-363195b2c64mr1430622f8f.3.1718788598839;
        Wed, 19 Jun 2024 02:16:38 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2295sm16637925f8f.82.2024.06.19.02.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:16:38 -0700 (PDT)
Message-ID: <f12e1a75-2fd1-46ef-aee9-520cced08f11@grimberg.me>
Date: Wed, 19 Jun 2024 12:16:37 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] IB/isert: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-3-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240618001034.22681-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/06/2024 3:10, Max Gurtovoy wrote:
> This event is handled by the RDMA core layer.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/infiniband/ulp/isert/ib_isert.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 00a7303c8cc6..42977a5326ee 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -91,9 +91,6 @@ isert_qp_event_callback(struct ib_event *e, void *context)
>   	case IB_EVENT_COMM_EST:
>   		rdma_notify(isert_conn->cm_id, IB_EVENT_COMM_EST);
>   		break;
> -	case IB_EVENT_QP_LAST_WQE_REACHED:
> -		isert_warn("Reached TX IB_EVENT_QP_LAST_WQE_REACHED\n");
> -		break;

Don't think you need to touch the ulps, they want to log these events, 
so be it.
Although, a warn is not appropriate at all here.

