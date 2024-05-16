Return-Path: <linux-rdma+bounces-2506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C798C7789
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6061C21CD1
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 13:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54E146D7F;
	Thu, 16 May 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1PlxhBT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5366BB4E
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865900; cv=none; b=qxncHju6BfxjsCai+1/XnGzhwzsWCyMAj3b6DQ5OB/epSctWUCTkPdI3X5x8ecNYMXA2fbMZhCQmlRhsqWPZX0d+Luqs7C2l1i/yz7unQWAzHPwTiPKOPCWNpYj/HfZShG1gXQawWmzpJg/+vToBZj84+B38/4xmPW6xyjr3PSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865900; c=relaxed/simple;
	bh=Z4ZmspIExBc5RzuO84fy5iwkRywNRGg58BsjK+MJaz0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TtPNAB/DqCG0H2WbwglCw/JUjQnz3fRo2r/ebyfgR8Jyp/Ui2h9N8cqvuFpUD6YZbaEBnayuPZ4fO3SsglsOrJqnE5HOYaZKBWVR7sWqKShVnsU7e4YJ4kvl/3F4vksWkhaOqmQeDW/Sr3k08dqu88P7JUvJXkJdPsquMDig/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1PlxhBT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so4166175e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715865897; x=1716470697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gwwpbDUfIO5J29D+UntXzvWFR3lgAROpPDkXpN02A3c=;
        b=H1PlxhBTJmcXmIMW2eczOxDmbiTyVdr5I3kfsPomkmEjhsucYvK+KHKyOcMFqmNQJ9
         qy9n7pNhrYQqu/C70eP2EGwyK9SncEw4tYbGANj5dWESbsgo3XCYcwv/XwY1cnC1GCP+
         jPmH+aV/24DM2nK3EtdIFuPBlWqlvLxqleAIn6TDj+/Ski+Ax6y0xueVRNGrCDDBUpaF
         6C1rN7/G1/vbK+15geuQR5Dpw19WAK4arjYGPolK3d01h30ToM2oY4oVOUSKBi/8KwYZ
         +B8oVlaLC0UYpMn8X2+xHDbz2TqzgTd/jxUzQFBPa8shwa5Agxgrz9bOgMhHwhJ8VeGg
         tuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865897; x=1716470697;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwwpbDUfIO5J29D+UntXzvWFR3lgAROpPDkXpN02A3c=;
        b=eDL7PGjb3zbIWMypEzYbnuHdHHoKGAnRMm/Ngx24jMIskA8i35EOuAMEGOX9yfvd5q
         Z3FrqXZbet7VmtBMEP2aj5XWPgCoso8BMPOD3vG/80vjOIGgkxs3FFmRRsiDk9ubk7Z1
         8xoTYEuH+GqXSx1a3RWnDnmxOS4R+Wn1FdKI4/YDZT3PK+/wUr52mpEtY4GKscc2rAKh
         7fiLL6ts1luZ3MffDJB+74iP9vk9VK+nyspoAicJKytM3qjp90vitPj35yZ+zhRcO29J
         ity7+kBxqFscZeWRqGYxnDeqW/cUdEj93zcz4tWwFLuDuKd34G+4fp6AzNdApFF7HKWC
         OZsA==
X-Gm-Message-State: AOJu0YytVrKvIImcWT4Z+C4JlNJ8aXkBRaxoeTdTlTjkbgBXSpZs8PIR
	N3NN54PqLOa9c7KZuAEpLzHdofc5RrMN6iJbHiNiPG9pqS0QAjsEOECB7w==
X-Google-Smtp-Source: AGHT+IErGnxSLu4dsvwrcViuS32E+lOKD2dBTPylw/KNIsMoscEtPXY3ovkmp2vPkOQQtWrwsmLexw==
X-Received: by 2002:a05:600c:198f:b0:420:fcd:10e0 with SMTP id 5b1f17b1804b1-4200fcd133emr118464805e9.15.1715865897344;
        Thu, 16 May 2024 06:24:57 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79be05sm19154244f8f.9.2024.05.16.06.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 06:24:57 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <e383001a-902d-496e-bccc-f9fbda87be96@linux.dev>
Date: Thu, 16 May 2024 15:24:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
To: Honggang LI <honggangli@163.com>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20240516095052.542767-1-honggangli@163.com>
Content-Language: en-US
In-Reply-To: <20240516095052.542767-1-honggangli@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.24 11:50, Honggang LI wrote:
> For RDMA Send and Write with IB_SEND_INLINE, the memory buffers
> specified in sge list will be placed inline in the Send Request.
> 
> The data should be copied by CPU from the virtual addresses of
> corresponding sge list DMA addresses.
> 
> Fixes: 8d7c7c0eeb74 ("RDMA: Add ib_virt_dma_to_page()")
> Signed-off-by: Honggang LI <honggangli@163.com>

Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 614581989b38..b94d05e9167a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -812,7 +812,7 @@ static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
>   	int i;
>   
>   	for (i = 0; i < ibwr->num_sge; i++, sge++) {
> -		memcpy(p, ib_virt_dma_to_page(sge->addr), sge->length);
> +		memcpy(p, ib_virt_dma_to_ptr(sge->addr), sge->length);
>   		p += sge->length;
>   	}
>   }


