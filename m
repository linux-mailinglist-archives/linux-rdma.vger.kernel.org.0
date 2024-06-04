Return-Path: <linux-rdma+bounces-2838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34F8FB4B3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DD92865C9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334CEEEDA;
	Tue,  4 Jun 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0B9ApL3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA04171B0
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509714; cv=none; b=czbf4+5wMH6VLXm23QXOd8yYhCzxE4At6tFFIG11d5Fzp5plMMk8k9x+i0EtKb4M4JujYBMxVHtUwRiW3xLDa2j2hd9Wux1qAaRtj4gNmSsJqArNf9Fx0U+YMH5hm92UIaTczG5pRO045sZ+2yJswcGDUvm5mlE5UBn2z2obQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509714; c=relaxed/simple;
	bh=1V+8rBIMM0Hmk913mLvnBVla6l1KSZ2Ryn3ir4V8wZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoytNDFRlGOEgogjjss8UR7us/p00dEDeUAZfcJr9R8+mQs4ri8XSx4qJyqg/rghnd/zEgkueMJXAtIY2/dTG/SQVR90EyeR3B2I5qxEC5fNX9OHh13FMGovTam8oZV5PG+8C8xsbFy1XqUmQoQIq9jKUEuetl9WMJw1vdBwLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0B9ApL3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V1HiMJVZKeLJ34xIsQNw2KBua11As1yeTY2iuJA/sU0=;
	b=K0B9ApL3psNw8eJ0rKZ2zh41hgcvbQoLo9YrbbyIFTuAxhhlvcdnZihx9w1QEQXRxXz81S
	eZ4N6CB+zFRjrsexEEKDMD47USiaiH4sKS5CZaVqxmQIV8CSaDvIuim81jzXNotpgFwrNd
	PICDEIWRcG0NQUXe4U9zMH1FrKXEJIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-icaTSRnHNkmwKb2re0XFSQ-1; Tue, 04 Jun 2024 10:01:50 -0400
X-MC-Unique: icaTSRnHNkmwKb2re0XFSQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42120e123beso50822735e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jun 2024 07:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717509709; x=1718114509;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V1HiMJVZKeLJ34xIsQNw2KBua11As1yeTY2iuJA/sU0=;
        b=pMsDMie/G837nvnPaQKpeDMkqve+P/tsYitAAk+EhjyHw3/H/GAMixiLQMdo9MhR2g
         lN8J6XubAbahDOTiE9zpYO2HCUqFN/QURcyQxNGcYIuCAau6sXaULxmeS3ymiHQdByoZ
         m1KfxoRk5UiYk8Tl+XbXbtaFmeGphMlbbkHczcCBtjGmmgkhUQd+zsmaVF0yMPKGSsqQ
         pRvTnVpAEKPXu1Yg7opNoPSh+JEtPr9hV5nq6CqFcIluHrhwTuvPPppGSdcuJ//k/lo6
         OyIG0cxXpMnSM9jtN910OD7VhhEhrJvntiYoMzn1k3zSQ7aignqePkfqDrpTSVpZM3+a
         M/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn39flTSci42lulDY7qC1JbMBRyE7JZPBzqO2x5+wqAUh3B9YTl+9y8ujfS/1PHbTzgPrQkw2x57kz+EsSr6+D4OooQnKs1JP30Q==
X-Gm-Message-State: AOJu0YxmTiJ4FeiX/Ye2DZCC3JVcsh0GN0pCf1v9zv89SXamRVEjS+Vi
	g3RxOHjwU/lShckcEtkR8L5t6D5Q5g12h8mAIU1ZYj7OIQ6D+7J1v5awMRLqVA+BvkNAVb61Euz
	1/SEsiAmK3forlUvuXjHOiwpNlqhSLMtU8+i2SSBEQ1NmHSZ0yNLEnYEFb/E=
X-Received: by 2002:a05:600c:34d2:b0:421:10ce:8aff with SMTP id 5b1f17b1804b1-4212e075629mr132627675e9.19.1717509709374;
        Tue, 04 Jun 2024 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3tWPgJcoE45F7MGvr4dXYk5T6TU/GGE6NzwHluA1EiTYAb9UJYSUpPF8NK6vLJsw2R8vH7Q==
X-Received: by 2002:a05:600c:34d2:b0:421:10ce:8aff with SMTP id 5b1f17b1804b1-4212e075629mr132627225e9.19.1717509708899;
        Tue, 04 Jun 2024 07:01:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212c0fb7c2sm152943105e9.26.2024.06.04.07.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:01:48 -0700 (PDT)
Message-ID: <11017c4b-e0db-4f2e-af1d-54bc2c416e5e@redhat.com>
Date: Tue, 4 Jun 2024 16:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] migration: remove RDMA live migration temporarily
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, yu.zhang@ionos.com, mgalaxy@akamai.com,
 elmar.gerdes@ionos.com, zhengchuan@huawei.com, berrange@redhat.com,
 armbru@redhat.com, lizhijian@fujitsu.com, pbonzini@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, linux-rdma@vger.kernel.org,
 lixiao91@huawei.com, jinpu.wang@ionos.com,
 Jialin Wang <wangjialin23@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 14:14, Gonglei via wrote:
> From: Jialin Wang <wangjialin23@huawei.com>
> 
> The new RDMA live migration will be introduced in the upcoming
> few commits.
> 
> Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---

[...]

> -
> -    /* Avoid ram_block_discard_disable(), cannot change during migration. */
> -    if (ram_block_discard_is_required()) {
> -        error_setg(errp, "RDMA: cannot disable RAM discard");
> -        return;
> -    }

I'm particularly interested in the interaction with 
virtio-balloon/virtio-mem.

Do we still have to disable discarding of RAM, and where would you do 
that in the rewrite?

-- 
Cheers,

David / dhildenb


