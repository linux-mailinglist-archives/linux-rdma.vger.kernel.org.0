Return-Path: <linux-rdma+bounces-13655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0FBA0672
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 17:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2B8A4E1A66
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF72F7ADA;
	Thu, 25 Sep 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iozdQ2hY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A41DE4E0
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814948; cv=none; b=X/Y1kA/1nRTag+fJLaysXxjp8JpcjeWuO1A1+TUyXZXUTaH0+NRcZaJmLtk5R80cief7sNSjdSh8XdFzvnFU1pTL+AHlIPaeLJnXb+1EUEULTkYF713FMNJ1sPytp24t3UuSTKvtyUtzFFVs76uF/heQkiZIdYxnnKIOc/tlEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814948; c=relaxed/simple;
	bh=LhDkyJuwGceVSUcNSeREAlWI1ETmNdprkTkUlk7sbNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqGtb7zYwK7eF8mTVssB1JI2vapUOWnop/hS1yczoWJOBe/Km94GdjbVr9ErdGzFe2ukgqTrFVol9PyF+pykJhnYSaLHtmU8aKkwlmi2Kyp0e+P11UQy5yIOizb7cp7kT78eUZQyf2OGfSr6Blga8WRLGVK3qhVAR7iV9BqAoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iozdQ2hY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758814945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoWyNGq2+WEDxr2I8yMYU8hP5EE3I7EnsFFg3yAOwPM=;
	b=iozdQ2hY7njN3FOnbbCehisHx0WO4R48EGtd6B2HWZInvKZ98GdLisfD/IDlzrK9R5K97Y
	8DdaWqbecKnr+BWvSTSVXzP3bCpmPIBInqmaM967zv0r7S4/haDYLJjezwJExduQ4YkH4U
	05K+C0gSB42FyL+MWESMIk0ArKGMV9A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-kYMjGlRuMRi7adNrAqE3YQ-1; Thu, 25 Sep 2025 11:42:23 -0400
X-MC-Unique: kYMjGlRuMRi7adNrAqE3YQ-1
X-Mimecast-MFC-AGG-ID: kYMjGlRuMRi7adNrAqE3YQ_1758814942
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e31191379so7348685e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 08:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814942; x=1759419742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoWyNGq2+WEDxr2I8yMYU8hP5EE3I7EnsFFg3yAOwPM=;
        b=PKVLP/hvct7vPF9vqfm/DCUn9ePrwH93M22LKEJOd7EYBNU75rqkYddSs/on0ymAVn
         vkEYy6h+RIrvKtY2nmZ+9BPpaBZc3G70X1odI0qv2tHSRJmEo3Ug5jxm6ZWy4ORRnyo1
         rJuxyaG4wIO/NKwwfKNP/u92HX6mSeHI7NQYXlYpoqvFIOD6hC56lhCk40oX1Cb+3Rbi
         3ndzbfpGP9/vLXoNiRxMsGBoUHxqH4+ZzYdOAPNh7nVZjkXnF5dcNT/iP1FLQrwYY4dU
         Gy1y6pAtYCF+nhZPxMxE5ARKatAnE/N4IUaYs3pniKFPDydkXKTtCUnD18eIPUQXa9id
         1y8A==
X-Forwarded-Encrypted: i=1; AJvYcCUYCJV2MDARy2Xr7us2UTeaBzu4Q6+vxcHERJpfnFmWivj4s9lC7NrbNGVD3DP+kiVDV5BHq8rna7/q@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdG4lu4qFRxKXnP4IX0I32q2iaSq2J3AqQFhE2UKZtVbstjrR
	XkDuUnnyss1g7Re7smiSZL6jr+46UvqrXt2pidQihGOV5B9sLKP9mjURixYfgXbWSkDZsTKH0PK
	AMIcfee5iC0bK0gA174rVB+CiwiO+7xtTEh2OAX3p+do4XevP37PM1R/yCgONOXE=
X-Gm-Gg: ASbGncu3du1DHCQk9L1095smiajqBqyTffScjQ94uNgzhUQ/CtXidkBxw21Icb04uNT
	PVShR7F3QiVGMy1+UhRT/eVqigMEICGFC9a7Fm5jgdQ7W8ziN19h7kB/P7jyz9gcijW9HrGi9w9
	7Gea18piS+ggy+VbDCEKZ8wrUHsiCMHP4mCCYCNGq5akHfBkxIjqnp1JU+cGRSCp6Af8SiPqawt
	ZXiGya/6JPxfamXkjSIuIgJ2EQRH+c5G8x9Eji+nRN/sKfTej8/b8sLjViUJ8OnWuNP/2JegC2b
	geFbXnvF13LLpzsFLVExexhXf/1r3lM1u4QKGcvqoJuXxpZc2ts2mmThdr8+vOUsdQmd5TA1/2q
	9WB9ZRIW2US8G
X-Received: by 2002:a05:600c:5290:b0:46e:394b:4991 with SMTP id 5b1f17b1804b1-46e394b4b1emr8849555e9.11.1758814942093;
        Thu, 25 Sep 2025 08:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY7q5cCEKSY5G+qO3YdgamXeF+8HAdkjrLynzDo9gNcCUiRa67Z8FZ6kXO+htyHwA/0LS8Aw==
X-Received: by 2002:a05:600c:5290:b0:46e:394b:4991 with SMTP id 5b1f17b1804b1-46e394b4b1emr8821345e9.11.1758814896033;
        Thu, 25 Sep 2025 08:41:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bef4b4sm37808335e9.20.2025.09.25.08.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 08:41:31 -0700 (PDT)
Message-ID: <30a1dc4e-e1ef-43bd-8a63-7a8ff48297d2@redhat.com>
Date: Thu, 25 Sep 2025 17:41:29 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-3-pasic@linux.ibm.com>
 <cd1c6040-0a8f-45fb-91aa-2df2c5ae085a@redhat.com>
 <20250925170524.7adc1aa3.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250925170524.7adc1aa3.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 5:05 PM, Halil Pasic wrote:
> On Thu, 25 Sep 2025 11:40:40 +0200
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
>>> +	do {
>>> +		rc = smc_ib_create_queue_pair(lnk);
>>> +		if (rc)
>>> +			goto dealloc_pd;
>>> +		rc = smc_wr_alloc_link_mem(lnk);
>>> +		if (!rc)
>>> +			break;
>>> +		else if (rc != -ENOMEM) /* give up */
>>> +			goto destroy_qp;
>>> +		/* retry with smaller ... */
>>> +		lnk->max_send_wr /= 2;
>>> +		lnk->max_recv_wr /= 2;
>>> +		/* ... unless droping below old SMC_WR_BUF_SIZE */
>>> +		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
>>> +			goto destroy_qp;  
>>
>> If i.e. smc.sysctl_smcr_max_recv_wr == 2048, and
>> smc.sysctl_smcr_max_send_wr == 16, the above loop can give-up a little
>> too early - after the first failure. What about changing the termination
>> condition to:
>>
>> 	lnk->max_send_wr < 16 && lnk->max_recv_wr < 48
>>
>> and use 2 as a lower bound for both lnk->max_send_wr and lnk->max_recv_wr?
> 
> My intention was to preserve the ratio (max_recv_wr/max_send_wr) because 
> I assume that the optimal ratio is workload dependent, and that scaling
> both down at the same rate is easy to understand. And also to never dip
> below the old values to avoid regressions due to even less WR buffers
> than before the change.
> 
> I get your point, but as long as the ratio is kept I think the problem,
> if considered a problem is there to stay. For example for 
> smc.sysctl_smcr_max_recv_wr == 2048 and smc.sysctl_smcr_max_send_wr == 2
> we would still give up after the first failure even with 2 as a lower
> bound.
> 
> Let me also state that in my opinion giving up isn't that bad, because
> SMC-R is supposed to be an optimization, and we still have the TCP
> fallback. If we end up much worse than TCP because of back-off going
> overboard, that is probably worse than just giving up on SMC-R and
> going with TCP.
> 
> On the other hand, making the ratio change would make things more
> complicated, less predictable, and also possibly take more iterations.
> For example smc.sysctl_smcr_max_recv_wr == 2048 and
> smc.sysctl_smcr_max_send_wr == 2000.
> 
> So I would prefer sticking to the current logic.

Ok, makes sense to me. Please capture some of the above either in the
commit message or in a code comment.

Thanks,

Paolo


