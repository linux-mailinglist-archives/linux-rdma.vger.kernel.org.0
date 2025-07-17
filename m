Return-Path: <linux-rdma+bounces-12252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FDB08B6C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD15167723
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D4C29DB97;
	Thu, 17 Jul 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1Y3ePx7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260D29CB41
	for <linux-rdma@vger.kernel.org>; Thu, 17 Jul 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749761; cv=none; b=NDyu/1sJSCPI3vbOBccgQXM2m+3ejna3pLdyOXOkhEP5WyM+2GCVpQXprX5vRQspB5TENGHz+A/j2SNv/b9eW/g7UVDkOWzJ95zq1oTgxYnXMjrmXfJWWjnUTp1tkkYd4cWUTwKBbnoHuqMXo7z24entR5L7ZMNmKrRS0ll3btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749761; c=relaxed/simple;
	bh=gSxihFMQdPhp7IfEUpVtWMpenx++JDqChT8iAbuth6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Axs+ZpqeZhv1UlSrNJPcr6GZ29C4bYmDzElOSsDdD80tbej+V4clMk098ng9ONHsPJgkoFsQQl09Qm19QJJ9KfCJmIAqQIa50vUXWI3k83yiXtbYKCS8codMtsgFNjXUXuldQgUz22H9N4W9qUlxNWZDRdiHS526IXxMpdiKQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1Y3ePx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752749759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayOJzRkHPyVA0X2izytcAplXmRZn6T5HJvLKOLJn4i8=;
	b=D1Y3ePx77ztuAxw5iu3qH8rdtVNUZrpObZtqD3+05ldC2T78RFhz4wYbCWRLliuxuWln8H
	wrrmmGaHZrxpUl2CzyB6evNuq5JYjEk3iZJKlKInmBXOVk2awgnl8RwDdixaGVJE24udGd
	0pTxiEJh3/xVUcdfPOlV6/Gjrr3hbmw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-u2ncRvpUM1GdQ8GjEl7tbA-1; Thu, 17 Jul 2025 06:55:55 -0400
X-MC-Unique: u2ncRvpUM1GdQ8GjEl7tbA-1
X-Mimecast-MFC-AGG-ID: u2ncRvpUM1GdQ8GjEl7tbA_1752749754
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso6856745e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jul 2025 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749754; x=1753354554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayOJzRkHPyVA0X2izytcAplXmRZn6T5HJvLKOLJn4i8=;
        b=omZJ1iYeiklOJ/gNX3eQDihA4eu8OzSyo+md+i98uqbamK7JYvM0RIIfnoskLUxboW
         4u7NJyn/0SiIjuikwIEdhZA2Ka5arL9x+w/ZgOsSBVVPbqxKElHjt5pMRL4xuj2N3eOw
         W4JfoP3E6x29swn/NkgZgdZiRq1AZr+yTbvBkY1SwkL/VarHI2UnIV+6gnLX49pYxrYi
         mc2o2CxR8dJSzgved9MsmjQDXV/bgIh7C7aYXxdBX1QF1AdVeWIE8wHRgH6iHrd5VGs2
         6vcyIYrWTMnXDSgDdXex/mw+LPKN2F/sbRcuHxPepTDpPus3kx/TpC4TZFzbAQWMB7qs
         +DIA==
X-Forwarded-Encrypted: i=1; AJvYcCW8oKJHpU6EpSDow0G3usAAqfEN0ojAnNwggiETQz9n5krTotXjPkPW7BzBxmgyt9qA10eJzoQQqDMM@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRjNhNPyfk+sUjJq5I+zj4+T7AXmjRRL+otb4MdzLh9HP2OMK
	WNQWvQWqHAO2cuD6AlDorJQ5NxGiZKfT6bQcc57ayLnENIRhq19DJUf7TYQxyrnFMHkGn+5gKR3
	/Chixt8yEnVAdxslFEzqEJ3fo9UBT6VwQGGMm0heVVDOsOkhub0cqrH1pjVac2AU=
X-Gm-Gg: ASbGnctXBo0cRRqFCv4fabOuBxIxpHnD43CAPRBfFx4IsBxJFZzZurWnU6mhZvJuFnC
	IOX0x0/0D53r7+duOpj1xYlp4Eb5ClmfBsyneesE9+QZPnFrMsXMMFsKuCoplMPUihxwPoUSqM4
	r38wUw0XZc989/hlCG0hBnAGODJDR0o8oQIvxQgyB1OnY+0KzAQJIiwQIIufW7V0LCV6+rlxyHW
	hvXc4qZzf0GKX06PuUekcPesoI24C74mZN74iJT92+xwN4G0BMOmzoWaCAx9JUSzQh3/dK8vRKx
	fmInMyK3TQt1NScQhgBbf4HZs3MXvlsloQwjZfM9WrqIc7NFH1BYH9b1Af4z/T85lsgows3Rlka
	S4G6SNEJbL0g=
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr48983345e9.23.1752749754326;
        Thu, 17 Jul 2025 03:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hmzgeO6mfBS8jGYj9rG77mwI5Itg2IPeN3BeV/EmE/d7ghhRi3L/99no/15vSa70B3AChg==
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr48983105e9.23.1752749753937;
        Thu, 17 Jul 2025 03:55:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f4c34dsm18920425e9.6.2025.07.17.03.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:55:53 -0700 (PDT)
Message-ID: <650be1b7-a175-4e89-b7ea-808ec0d2a8b3@redhat.com>
Date: Thu, 17 Jul 2025 12:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Support getcyclesx and
 getcrosscycles
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/25 7:15 AM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Implement the getcyclesx64 and getcrosscycles callbacks in ptp_info to
> expose the device’s raw free-running counter.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 74 ++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index b1e2deeefc0c..2f75726674a9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -306,6 +306,23 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
>  	return 0;
>  }
>  
> +static int
> +mlx5_mtctr_syncdevicecyclestime(ktime_t *device_time,
> +				struct system_counterval_t *sys_counterval,
> +				void *ctx)
> +{
> +	struct mlx5_core_dev *mdev = ctx;
> +	u64 device;
> +	int err;
> +
> +	err = mlx5_mtctr_read(mdev, false, sys_counterval, &device);
> +	if (err)
> +		return err;
> +	*device_time = ns_to_ktime(device);

If the goal is providing a raw cycle counter, why still using a timespec
to the user space? A plain u64 would possibly be less ambiguous.

/P


