Return-Path: <linux-rdma+bounces-14038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8BC0546F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 11:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE231189DF29
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06A3090CD;
	Fri, 24 Oct 2025 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVV3oa1E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACC3081D0
	for <linux-rdma@vger.kernel.org>; Fri, 24 Oct 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297148; cv=none; b=ItctZfXR4uoeJcsfmwvVqNgLmwZbqSdvAptHkYUT1wPndUZ2Rcwa9yscuuUeoiEnkdjzsJXmaW/VTlcZXYCnLtSwqzkn8PFpRXiQhuzQ5PxjutjUvdEgu00QZbBcZL5/aIvnmiOfCgbpPfoV5dHNn6X3ajagLvjqBodbE0IDQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297148; c=relaxed/simple;
	bh=wc+ndK7ZVigCF1aKHyTwRArlX30Ea+mugDfGLgg95eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOvvK8vVLQoFC2LGGjrbtGTDV8tF2hsvA3Q9lciaM5qjn0pGfzsQvuwSSn0oyRzSYTFEyV03/PxZY2czQTg50gCvFMTqxlpRqm43J5bCVj00VY0yTWE8MZ3jdRAUNFSTC5nic0v7PwSpaPDc2d0uoQ/4j5tvj9cnIKSxInEBAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GVV3oa1E; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcab6fso17352987b3.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 Oct 2025 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761297146; x=1761901946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3jA06nHXo6DksjSpZmORK00GGM7rTS20lPorjM6G8PE=;
        b=GVV3oa1EugINDGsBVuNY3m2Isb5EGTeAFqHaKKB/oPCxzB7lzE4irSxH2DBVKniTxW
         ZcB47GYRsr2sziJg6RWuD2GGHn+VLR16YCEv/pWXB7JO8RkDSGxCnGNgwWIJpmtT0SdQ
         Sw2WGiyN1NKXbqP/rFRs2Mv2QFDC2i7h4EIQxkjTJfKbBP/CyhV9nOfPOfCOt3MQvhYt
         OHxOvMKfpERr1NtdcCUPH+3Yd00SPdeR2zzwIoUbJEig/Ld0Jdu4MHU4hpjTvIZSYF3G
         8KJbhY1Ink7Dh12YGd3oXwh0agXmaKKVMURlT5Lwi+Qx27dcuiA00ryDvKurNGSnKjkm
         TNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297146; x=1761901946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jA06nHXo6DksjSpZmORK00GGM7rTS20lPorjM6G8PE=;
        b=HUh0vpePuOSggn2noq2f1jmGcV5+0s6UbvbS+kpzi6LzYFA+iwBoE+WeyR20/V5W93
         ydvn1yMFMtgg6K2/8f+bPSST2T5JbyLkb/mhGyEwrwx70Keo/hcEIO3ZNPMlSw5mUEH6
         20OCJRRBPcW+u9ZkgzMvsxjYqKh7PinmuW8R2B7IKj+eT9xDIV8HTVQLKCK7pcoRtUdc
         8fvT8oRzWnK2T5/lYYRYo65qdtEKa4uUxguJtNosXkO52V20Gbbzcz4Fw6fWSC7mdTLN
         WOfreLMLba6SAj8kGBW9xra0pU4VR+UcmK2NwwswIJcLFeVP0X2IXulk0+rK3mSbgyG9
         Rq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfYjsPc7X+GVi1TUT881R8bushWyqVo40P3inPaI4WIIrW8J8eoh6/5FKzHujSgKfSbK/YsdlSxAfo@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBAgrbLEdlJwh99a1sGEiTbd9ksmKO6FblSHiLe22RaeaJINI
	BXED7KcHseMDH6zqYC5hJzP39PS057CTliYl2DO80m6JSZDYSLzOLSU3MEzj0f6L9fVXRQI/mj/
	TGr6foTI3y+vl4G4MkHFIG3NLVv7MblfqQhzTDKHxtQ==
X-Gm-Gg: ASbGncvsNNE9/02v78hUB6wKOMqhq7WxDzTZ2dJewlOcTSqzRoRTksOxA7xy4b+B6IR
	JZZC06pfURJqDRNUBJfdYEt8h8DuNu4CgwhJnmdeUVmN+1V3Evbuw73GfafcA5/YfR+XtEQqsUd
	UfL7mHUcbfg4ChWsFAz1e0wdN+G5oaDiBKywxk5gsvufkmza6Qa94cLyI8GrtcdiELorrmLyls6
	YpnRgXfjBQzgTyo4+JewKCq5Hp7Kv/uNAlhU6bioibWKsosd/NGzcixmqb7QfXKMcV1binewVrJ
	n7XDFB8jv6N2x6UHxAI9okNBTIz3naLaMWYy8s6KqMqxtacJv0E=
X-Google-Smtp-Source: AGHT+IGdc+BRmw6hWK1X2qJ1pVpkvZiid5Wdxp4xbNssFczs6yf46ChHI/J1GHXrGP+2f5H8Uhh6CTcUaGSrm6b9FDw=
X-Received: by 2002:a05:690c:620e:b0:782:d992:c2de with SMTP id
 00721157ae682-785e009dec5mr11688457b3.23.1761297145630; Fri, 24 Oct 2025
 02:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com> <1758532715-820422-2-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758532715-820422-2-git-send-email-tariqt@nvidia.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 Oct 2025 12:11:49 +0300
X-Gm-Features: AS18NWDleNxSyCBKorudX13AjbaF-JB3xUjh3nVML1Q1EGfm0OWdJk1Wbh5vT6I
Message-ID: <CAC_iWjLGw7eEYTUwwNjFKy2yYFdZRtwafHxjrDyBo-ugvhbkhQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: page_pool: Expose internal limit
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 12:19, Tariq Toukan <tariqt@nvidia.com> wrote:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> page_pool_init() has a check for pool_size < 32K. But page_pool users
> have no access to this limit so there is no way to trim the pool_size in
> advance. The E2BIG error doesn't help much for retry as the driver has
> to guess the next size and retry.
>
> This patch exposes this limit to in the page_pool header.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  include/net/page_pool/types.h | 2 ++
>  net/core/page_pool.c          | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 1509a536cb85..22aee9a65a26 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -163,6 +163,8 @@ struct pp_memory_provider_params {
>         const struct memory_provider_ops *mp_ops;
>  };
>
> +#define PAGE_POOL_SIZE_LIMIT 32768
> +
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 36a98f2bcac3..1f0fdfb02f08 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -214,7 +214,7 @@ static int page_pool_init(struct page_pool *pool,
>                 ring_qsize = pool->p.pool_size;
>
>         /* Sanity limit mem that can be pinned down */
> -       if (ring_qsize > 32768)
> +       if (ring_qsize > PAGE_POOL_SIZE_LIMIT)
>                 return -E2BIG;
>
>         /* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
> --
> 2.31.1
>

