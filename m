Return-Path: <linux-rdma+bounces-6048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EE39D489C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 09:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382AB282DAC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE47B1CB9EB;
	Thu, 21 Nov 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbnhOXkb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E281CB50B
	for <linux-rdma@vger.kernel.org>; Thu, 21 Nov 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176937; cv=none; b=TMZ/9KKDG93tNN24VIx0khGNoNaLW6ITOhH7tRws/0oSC914WqWp9eoYklCt6Xw0wzMGWUTS3cpywwm3F37oPRfL6Nke5tLmaO2En25Kvmr0YSnmnibi04EIF+56NV2eX1XtiPCAP1d/KjNx4hO/Dqp6VNeAl/zmivoC/9eWYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176937; c=relaxed/simple;
	bh=vx1+AwLU4UsvAMyNOFMRQ4EEtvnDkA2FBnIl/UudUDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIj1vhDHTm3So9CmpaWAidUIYo3UM3eiOP5hfbOjntEL0yuQafSuY2lbs6XRnzkS+nVHtjySTYzVSRdFmAEZ5siMh8SYvWmddSEPZUZSjAbU7UqGgBj3OGViVQ8doAUjX0tPWtEtWUgxFfizSl2qI/8+s+1vwrkABAb8A/Au7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbnhOXkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732176932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAru0Q7sNpk/HHsEEZWynnmCBFQAz2UJFJPWzmB99Ic=;
	b=DbnhOXkbT3bkxbJ+7lZIsHB2UY52yEd7bHq4HtwMabR9mySvuL1Fv/8X9tWgQnqLfPYy/B
	w0Xacr2tKxQw2VGwNoY2wSLvw8EOMg89bwSStwGkkMLfz/VLsMYlJx3mGgOEbNSbyu0+1y
	PqcIU9ivZA3ud3vVQBcdLKLcSipg7Ak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-qjPKavCfPqGGoswbUaZFpQ-1; Thu, 21 Nov 2024 03:15:31 -0500
X-MC-Unique: qjPKavCfPqGGoswbUaZFpQ-1
X-Mimecast-MFC-AGG-ID: qjPKavCfPqGGoswbUaZFpQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43159c07193so5361045e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Nov 2024 00:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176930; x=1732781730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAru0Q7sNpk/HHsEEZWynnmCBFQAz2UJFJPWzmB99Ic=;
        b=wP1zYqBYHEkDVv9OBpgIhG3WdIcPjjEjk9ztGfA8l/yRn6ROmBi3r+4AqtH6hmnPgz
         j68Vay5xc471zE8igop67Z8ZCL0kKtpx60y8awmanUYH0ZbByiqTkax4CjH0MUP3yfOo
         4x0qfovzjdLNvJ094CB7ViWhqein76LOxmGkC/8uq31QYvrDJlJJeLCKV245ko2exgjC
         700T83paP2yICKC6lHSiCMkgBFPF8kijBxkoaRIPJgw0nNeEjTwtCCtOGA0tpuLq8bO8
         PfeZ3hZnGftWAuFzsR0AeiCCkWGACC4y7w8aOlLxgsgzczu45cZDKQv+B56+6oaY1AhC
         lIcg==
X-Forwarded-Encrypted: i=1; AJvYcCXT7cP1b28B27vtUD+Gu/K56ZbYQOHpuASZlRgF8kk1OjruRz+2KG1rmJ/9wzG6BeEBSDjxR7ISlkPQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EVAnGvqOVRWXDJ6dai4S0bPhugA+Iern5AHduZkPpDy9DzMT
	MQSwOb+TuTbpSExinbQF6yGIVD+ur9ZqTtmTsun+J0EqMrnr7S9j22SBzfGtqO5tQNqdVIaJNLy
	asayFI4h/JL2WXDQL3SVcLcULtK550u9vbr0xZ4WtnwTStuIKBj7GDSNqiQM=
X-Received: by 2002:a05:600c:502a:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-433489a06ebmr58058125e9.11.1732176929991;
        Thu, 21 Nov 2024 00:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAAKP652fy4bHoCxWpHv86UZV5kyYHY85sFR0FghbNa9ObZXs7vQd2NPg/YLhM7rRCI5jfFg==
X-Received: by 2002:a05:600c:502a:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-433489a06ebmr58057935e9.11.1732176929686;
        Thu, 21 Nov 2024 00:15:29 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46343e7sm44946215e9.33.2024.11.21.00.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:15:29 -0800 (PST)
Message-ID: <59c96191-3203-4338-9754-ac7c5ee35e78@redhat.com>
Date: Thu, 21 Nov 2024 09:15:27 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mlx5/core: remove mlx5_core_cq.tasklet_ctx.priv field
To: Caleb Sander Mateos <csander@purestorage.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20241119042448.2473694-1-csander@purestorage.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119042448.2473694-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 05:24, Caleb Sander Mateos wrote:
> The priv field in mlx5_core_cq's tasklet_ctx struct points to the
> mlx5_eq_tasklet tasklet_ctx field of the CQ's mlx5_eq_comp. mlx5_core_cq
> already stores a pointer to the EQ. Use this eq pointer to get a pointer
> to the tasklet_ctx with no additional pointer dereferences and no void *
> casts. Remove the now unused priv field.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

[Under the assumption Tariq is still handling the mlx5 tree, and patches
from 3rd party contributors are supposed to land directly into the
net/net-next tree]

@Caleb: please include the target tree ('net-next') into the subj
prefix. More importantly:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle





