Return-Path: <linux-rdma+bounces-13640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E69B9E742
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 11:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7677A8C63
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC412E9EA6;
	Thu, 25 Sep 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8bxq8jc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4312D6639
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793248; cv=none; b=dTWHvIbh6H1Yi7ewpbdfHF6eqCy9gPbYnrnbLD6KTrdClE29CRn4HI3rL8LZzj2qOt1rS8CdFy3xcWOXzw9waJwVlSc4s9evTqfwyM6qkL8K1D28jOWgquo3sAKNzW6FPNLaBcI0BMFNASs0j4fRf9CLWy5JBZkgVatWLZ3d5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793248; c=relaxed/simple;
	bh=Ismx6yKHMCrWAtzO1V+zHu5cuIvgP8WRaG1URDkbiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g3iWmtQqwD/8DSAymE8lJSD3FO7txQEt9Y25U+mXH4NEkac7BbHMf5pi2yu292DVnQZMRHoK69xhQiUdQKI3i7Xr5jvYfyEBydyPqdqYuZ4a1lK5tCBW1l5/ayOwoWZq96u6N/1v8AQOZYaHSvxI3DG0wlXCfFnizx6GzrVSTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8bxq8jc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758793245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OC7o0y5NqDwPgeMke0PyEOvsv7ZIPwi/d2lkMqYclw=;
	b=g8bxq8jctekI2CVxna1wY6e9FN79aL9pJk8/OZxIux0NCaE0AzSEEbgowX59jpFxJ0RIWH
	nQuEu0GJiyJg0xEIiaKnlrkqJ0/XRYnQVUqe/fQHCRRm18Y/47RdxshzEowoaD8uXM9yVX
	P2EgbKb386sMEMxN5ca8D4puRbKoRS8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-S94t6pFcMium-m_O08yeow-1; Thu, 25 Sep 2025 05:40:44 -0400
X-MC-Unique: S94t6pFcMium-m_O08yeow-1
X-Mimecast-MFC-AGG-ID: S94t6pFcMium-m_O08yeow_1758793243
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso741560f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 02:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793243; x=1759398043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OC7o0y5NqDwPgeMke0PyEOvsv7ZIPwi/d2lkMqYclw=;
        b=PZmAgxB/DUNbpzkynIWF6mAc9kRM2aTxrLoAxbpt4lmg/EcwGcEafDmdJgnqxwXKZg
         amHQqpxdTsVmaJkptvEV8w1uWqVLPxwcqibZxMx1SXSy2hddwv5WdxI6yUpiYIsv1W4s
         IKNKvqIhDVzFlTb7nJ90NI3mujC+LU3ORm6f/0u+ory5RElMXMhg5GIeiI22h3mFyI9g
         rwBMRzxQY9xdKGZLa0bHgMt1AmlxDIpuzKMpTpCi1Zij8jf3aOjNQ66vCK2SNRi5Kj+2
         7OMvI9XwV1eupETah5oK9gO7SV0LgE5BoKAl8nlFQhK36xStmHSoI9TepgTLHbHmBom/
         Z0iw==
X-Forwarded-Encrypted: i=1; AJvYcCVk8s44dlgrRmJPsQdIF7XAoTjtaLffflimuTSy3V6ccRQWN8jRtsZGZdkRjYfMI7eAhNYwM+A5BjqP@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPiTWffAZPqU2Aashx0B3ypb3VyMImtlH4hxvAL7Dqi2yS+A2
	LKUcM+qdY6Nhfv9VRPpuHlkIBv2CcHahM+pyOtCf17ke8b6ztR+w5FB2VyDY7mMTVgxQOdbbKfz
	HAtY8+EKO0o9WjkeSHDgvscpQaWxi0gm2GzQ54EermatWfxF09nQRQv5eH8qcg1g=
X-Gm-Gg: ASbGncu5CmRiqJoQ1z2zHUAdtQqvRt+9hunOSZwICToXtuE+2P5kXKFbhY0M8H3wcrm
	RAbj+F9ps4ms/LjpJhJJDmXqBzVpiIL/xpNjPn2SRLDFEwp90+qAvA/dsapttT0tmN24nGeBGsk
	0Ls/uoGq55SvV/HyydVBAt7mNpBmZxOHwCemZTpEQcn9ZvUi+4lkzEAoQ2+Sd8iOXp8jHah/8gZ
	xPB+D/p5KgbRT5++e17RIls0eu9T1pXexogYsjNuXp3Viv/9GL+gS6L6UXcdBgsmHVb0pPNX+07
	dRm7ngAM20cK7DaT9/kkoty5NQXPl/DVidHbKQhTJyarUn/LEYEK9V/fLNP1nkEhDuSZDr2du58
	gKDaZuY2dF2Hg
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr2786403f8f.32.1758793243367;
        Thu, 25 Sep 2025 02:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrxeBRnYoMGSl0W8MRr9kJ35noutUmBpUjFhjol2reKWsJgQ/uDYSHftZAJXtiFbd/sSnPig==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr2786379f8f.32.1758793242960;
        Thu, 25 Sep 2025 02:40:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e902sm25724495e9.5.2025.09.25.02.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:40:42 -0700 (PDT)
Message-ID: <cd1c6040-0a8f-45fb-91aa-2df2c5ae085a@redhat.com>
Date: Thu, 25 Sep 2025 11:40:40 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 11:44 PM, Halil Pasic wrote:
> @@ -836,27 +838,39 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	rc = smc_llc_link_init(lnk);
>  	if (rc)
>  		goto out;
> -	rc = smc_wr_alloc_link_mem(lnk);
> -	if (rc)
> -		goto clear_llc_lnk;
>  	rc = smc_ib_create_protection_domain(lnk);
>  	if (rc)
> -		goto free_link_mem;
> -	rc = smc_ib_create_queue_pair(lnk);
> -	if (rc)
> -		goto dealloc_pd;
> +		goto clear_llc_lnk;
> +	do {
> +		rc = smc_ib_create_queue_pair(lnk);
> +		if (rc)
> +			goto dealloc_pd;
> +		rc = smc_wr_alloc_link_mem(lnk);
> +		if (!rc)
> +			break;
> +		else if (rc != -ENOMEM) /* give up */
> +			goto destroy_qp;
> +		/* retry with smaller ... */
> +		lnk->max_send_wr /= 2;
> +		lnk->max_recv_wr /= 2;
> +		/* ... unless droping below old SMC_WR_BUF_SIZE */
> +		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
> +			goto destroy_qp;

If i.e. smc.sysctl_smcr_max_recv_wr == 2048, and
smc.sysctl_smcr_max_send_wr == 16, the above loop can give-up a little
too early - after the first failure. What about changing the termination
condition to:

	lnk->max_send_wr < 16 && lnk->max_recv_wr < 48

and use 2 as a lower bound for both lnk->max_send_wr and lnk->max_recv_wr?

Thanks,

Paolo


