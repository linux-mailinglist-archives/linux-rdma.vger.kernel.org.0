Return-Path: <linux-rdma+bounces-21286-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMtwAMiQFWovWgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21286-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:23:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F55D578B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 534D5300D705
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C13F871B;
	Tue, 26 May 2026 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N2jPbej0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9EC395D8F
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798213; cv=none; b=H8ZWgHn0LYbnhcK8ig8Xb80p8NQVDaQUGl8vQeMn8eQD0sH43nFDHPnjyZPVWMRusEU87WbctNNu3Lo+bxF0+9YlSbTJ4yPuQVCf9dgkkYfXUBfsm3ePZuG1Udacc6f/cAX5alTUmozhuG2ZO/sayWZAyyTSHqEXlYDJvE+khlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798213; c=relaxed/simple;
	bh=qHzTBhBuiiRVcIIH5BT2JepEYDzlIvlJbPiwlXdsMHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j85u1eL0VwK3GkXc9fgJ2aKpG/WRw6XF0/Xz+OvpbHYMvRkUA7O61RBTvRb276wybwllkhN/xQJfginloCbb6zl6nJuaBAwwAZL0OHHPG0SZ3QchyabyBsL8dWKui668U0neEAqzufQntWGn07csA3oZgGCcdya1agpTnYhuapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N2jPbej0; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-911449d9d03so1209098285a.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779798211; x=1780403011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOvLEHi8YfJgqS+zaJD3Y3WESLiMuTb2mTPvxBI5ndM=;
        b=N2jPbej0cSo/qsyh+xPJV6N0GTN6oqcwYe7cIDtGIhPUNxSSK/WL8FHOMFfqp3JLF9
         061P3ItFMCJ8A5LqDG5P9SP/Wyjbd+HsEGX1ya4qWwJQj4Uuotwt/yqiAXA09ul5zQT4
         5rgdJqqO43TlZt+ARKRvaRgi3jMesWETV1Y9P269H3rsJYTC69QgKu9yD2vLVjo5hMeX
         CIv43bPCe5BYUxbY5G569SFaCyYRmTBUISJN+XR9GRvBrH+DTU5W7fyej5Uraaej+qN2
         pH4lW7gpr18BkUUjppyVRom4qfL4psTnwmou8Bw6Zhub8q1Xd8Wbn8VkcEi2qRsdPXBJ
         tWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779798211; x=1780403011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOvLEHi8YfJgqS+zaJD3Y3WESLiMuTb2mTPvxBI5ndM=;
        b=Vg4Bu6I2lx5RlcPKERO0/bdDFBKiJbaLIpHu4Fvg1kQUMD/UZcC9x8gWxHbXL6lnpf
         71Fr4muT9eB4JS8ohEIYC/RzsOeAD70MEtGCZnNapZpJm82MLMvIhjm8H6t3X3DJx43d
         g4Kx21QP2DuBvAWGTTDZIDgAsSZl6IF78ktKeLNs4ystg1W3yrJBDjjlBmXKoaNCaVih
         1sQRjiiTKK9HwoFYy2AtR4VR8UGfyXQcoAeEuh6C3Gth4cUwNdm9j/keoO2eEDO1ZAMd
         bHnX8pVJyBV0O2cHM3O9f942osYh8riFhUS4AstRvxGclGJ9J2ce4sHj6h4g5Gb8vPWq
         3T7w==
X-Forwarded-Encrypted: i=1; AFNElJ/DqC5MEX3FAjLtvqOSDAaRszDUYz+Z5SXpaDQzvE8j4EVJfMWaA5uuHR+u4/+4iS5wAD24poR0p2P5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HbeNixpa1GgtNV3WnYWuPVSutUqywphmm4mmRNxXT2bYfmO5
	VqGzuE86XSVK1nhV48pnbHskD79oRGfiP5UeysRJ5SNG8OmBUXvESJggB3cRDdFxh+E=
X-Gm-Gg: Acq92OGAFJBHFEy1X3d/19a8DjXZyP39DZNIbAK4yYILdmzAgPXMbpeEkygFsM436oz
	0HF25nbZPJd+xJbycXUJM03hG1MnWdOE5QVHAQu9y4wkvRbd4mxznrUDSR7HmVzb9KABWrEDdsG
	BCt4ILBR1q2VIAKoHFewNx8wvYMQmxNdHoSr9GV83YW9ClB9XAdSQDw1P/NpMHeVk1Q4EjjyRQ8
	eRFpyKyCny9K2ggEnNQc7L7xwraX/Uql+DIrHjfqADKUFIYuk7AmpNnWb/yfZcp1NvhhCZR3lyl
	dp5Uv3lUciRXJFNcMC9Cp1fqWvZKOOjheHaBHWUB5qSpB8ltpupxokMQVkZwqcPKuFYp1vpuo4i
	GyhHU0mUc+fJFQu74+sw4MDvxT4LAsr5eIie9cGlxHfCbWJLcpvFVecE+hpZ9C0hgRkcSKC0kkZ
	yvtkkDkr/CqZdqC9g/EUSgErNpxdhwAxrkLRP/yLV2VFG/pjjzZmqcWsBkKjzn22/6xrUCXOxP8
	E5w4W0EfRhDOVVQ
X-Received: by 2002:a05:620a:298f:b0:911:fba0:6d0f with SMTP id af79cd13be357-914b49ddae1mr1408362285a.41.1779798210531;
        Tue, 26 May 2026 05:23:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87cda12sm190384885a.31.2026.05.26.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 05:23:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRqoj-0000000DOAT-1tj1;
	Tue, 26 May 2026 09:23:29 -0300
Date: Tue, 26 May 2026 09:23:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: luoqing <l1138897701@163.com>
Cc: Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
	Mark Zhang <markzhang@nvidia.com>, luoqing <luoqing@kylinos.cn>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma: infiniband: Added __alloc_cq request value Return
 value non-zero value determination
Message-ID: <20260526122329.GC2487554@ziepe.ca>
References: <20260526091816.1873077-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526091816.1873077-1-l1138897701@163.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-21286-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: 560F55D578B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 05:18:16PM +0800, luoqing wrote:
> From: luoqing <luoqing@kylinos.cn>
> 
> Currently, when __alloc_cq allocates memory for an InfiniBand Completion Queue (ib_cq) object,
> it uses memory allocation functions that may not guarantee zero-initialization under certain error paths or memory pressure conditions.
> If the allocated ib_cq object contains non-zero garbage data due to incomplete initialization,
> the function may return a non-NULL pointer even though the object is not in a valid state. This can lead to undefined behavior,
> memory corruption, and potential kernel crashes when the driver subsequently accesses uninitialized fields.
> 
> This patch adds explicit validation to ensure that the allocated ib_cq object is properly zeroed before being considered valid.
> If the object fails the zero-check (i.e., contains non-zero bytes beyond expected initialized fields),
> the function returns an error code (e.g., -ENOMEM or -EINVAL), logs a warning message, and prevents further usage of the corrupted CQ.
> 
> Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  drivers/infiniband/core/cq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 3d7b6cddd131..756bc33c850d 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -224,7 +224,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
>  		return ERR_PTR(-EINVAL);
>  
>  	cq = rdma_zalloc_drv_obj(dev, ib_cq);
> -	if (!cq)
> +	if (unlikely(ZERO_OR_NULL_PTR(cq)))
>  		return ERR_PTR(ret);

Wow, this entire report is unintelligible.

ZERO_OR_NULL_PTR() has nothing to do with the memory contents.

Jason

