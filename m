Return-Path: <linux-rdma+bounces-14098-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF1C13F9A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 11:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E91234CBDB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E230215E;
	Tue, 28 Oct 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhSR6RYf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DF2FDC54
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645603; cv=none; b=OBC3uZD+C4LWzz0sDd/ugwJGXmytCPe4cKEoDRXTcQKbmn3tYIXqUtdw/1/vESBv+fAlVUmZv55UsdzjYK2KaOyCRrUoI6PGqLt4ZKY2x9zjQ6KDfaYPJng0BMhMvj33JHKetSS65fYFYcwrsLF7bMc+JNdmkhqdGO9oICtQGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645603; c=relaxed/simple;
	bh=mfTHpsTxrS0GRVOGyogmOgzNBE++mmmkoqWmimNeCDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQBuogm/VpB+MxU4QkHgrfqadK8tV2C56383jVRE4/TLJz0IdNDZbsWoHCvZ4tdp1MWNfWtDiT1iqs3Pr1c2lrlhQPdJAiDyK04/2DCvVM0U4kpNdLahAHhGUwUN68bgDY3OdZzcDvkMwoJdy1zm3Dc8iKpTEv7aIBLpkkPZJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhSR6RYf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761645599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56vwggYHsixFZVV59LtI7c2gTMZmsoUndn9sUNVFrqA=;
	b=RhSR6RYfSuTAdXuUIeF0nBZx2Y0nukk4c37AERH29U4sUs3bCZEwRzpbfZR87SKoMF2QDN
	PWJiZ6U5qQP7zdn78d6Rle907VQKvYfRnX2sx/PCU1Od2YT56c/CDCb0aETG02DFHGTyzH
	cdRmNfkrHVXMfHe1113Hk5e0ElFsWqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-H_fqKH39ODuB2WxpCVT-OA-1; Tue, 28 Oct 2025 05:57:41 -0400
X-MC-Unique: H_fqKH39ODuB2WxpCVT-OA-1
X-Mimecast-MFC-AGG-ID: H_fqKH39ODuB2WxpCVT-OA_1761645460
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47113538d8cso26246485e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 02:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645460; x=1762250260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56vwggYHsixFZVV59LtI7c2gTMZmsoUndn9sUNVFrqA=;
        b=Z2+o21pyfe8v98x5RIKWkG+li/5jdX3ahwxN3Vitgn0KKDXpYSIXo41OBt9gxztt92
         9IzMnw/jE2CHbsHtAkriIYUr1Lml0fyCRWmBdFjP4jMsh9F4j8x31qje97CwQW7LbiZm
         QgVNIGsdw1cd04qiOWctC34ekBv6FXvw0JN0SQDgE/PHwovOwpjDHEYMv2b3zuXtWyAf
         x9fPD3yNxJgW8hfg1VlgAzdJOfC8PzkLI99Ofk8fWx2sYO2b3g+cWE0Pxrttp8r5/Aff
         dK0r3H86DgI7z1X5zgH1deBHOWkBGmMn/9eK7IGAJffNoqqwGBVW9mQ/+ZYTgrVJeuP8
         Qezw==
X-Forwarded-Encrypted: i=1; AJvYcCVc/8XCsttXoU6ABKng7K2dvu7D1FkzKfMOOkfnw04H84Ev/JbZPHrpiuhLKlblaQGSPxShH9+v6WFm@vger.kernel.org
X-Gm-Message-State: AOJu0YxcEzscb8bwbSwssnjoC7nwa+AI7DmCrNuntJjUGSpwZyCWcz9A
	P8mv8Rs1MEFxq2P25LQnfdY8svYZFuy8MmlrZyokMB4o22Smlm6VqxtrHB5SCMZX/JbuJ4JHFvG
	AXa6wheW8tRmwqpSp5aRJcii/ilu87NWMNEkJObyOZHpYpOHWOVSaQ++ob9IW7gY=
X-Gm-Gg: ASbGnct1n8tyfHSmh0sjjy2Tj3HR4jLjB2lLSJ2SaOs0k0t3m+dNvVNZUSzrv8iqvcx
	SR72oJCjBUmr+ipvaf46kau3x9PuAFjY7QMi1NpTGdoHYSCmfnxStLLZ8H3PimG8KD7wcEICTpZ
	e19bQQgniM5pKwm1hFMmzba/eXhtoRMJ6Q3akTwBMb1fUDG+6XkyssG3Jx/rElhhnTVMPci1oT8
	wEeC2Lc2KAq+t9o9GrNL9WwsUtlJYze55V7JddAqH49gE0MTE2/RmIrH8B06NXTpaeTubzNQcZ3
	zGVfC/QJ8Nmz+14IN46AmaiF+sCO81TvSD/svwauzJ72hS5Ul1JZ9XqQKBqiz4BITx3NMOL1k9h
	hMmXJbCvMV2oVPk8PXYgtXBx+TH5O5GMkz3HGAq2+UjmoDzA=
X-Received: by 2002:a05:600c:348c:b0:475:dd87:fa32 with SMTP id 5b1f17b1804b1-47717df6965mr24455635e9.1.1761645460298;
        Tue, 28 Oct 2025 02:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfvGvAXIxMGxMt5qnRV9V4eVSHT+20qORZtOfo2sFh3kW29aY8yAm1WYmSttOd9/cvNwTc2Q==
X-Received: by 2002:a05:600c:348c:b0:475:dd87:fa32 with SMTP id 5b1f17b1804b1-47717df6965mr24455415e9.1.1761645459854;
        Tue, 28 Oct 2025 02:57:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm22527595f8f.5.2025.10.28.02.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:57:39 -0700 (PDT)
Message-ID: <76d6ba7e-f428-4a58-bde8-77cca1f5c3b6@redhat.com>
Date: Tue, 28 Oct 2025 10:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
To: Tariq Toukan <ttoukan.linux@gmail.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
 <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
 <aPouFMQsE48tkse9@horms.kernel.org>
 <83aad5ca-21e5-41a2-89c9-e3c8e9006e6a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <83aad5ca-21e5-41a2-89c9-e3c8e9006e6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 1:50 PM, Tariq Toukan wrote:
> On 23/10/2025 16:31, Simon Horman wrote:
>> On Thu, Oct 23, 2025 at 09:43:35AM +0300, Tariq Toukan wrote:
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> index 376a018b2db1..fad6b761f622 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> @@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
>>>   int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
>>>   			 bool enable_mc_lb)
>>
>> ...
>>
>>>   	list_for_each_entry(tir, &mdev->mlx5e_res.hw_objs.td.tirs_list, list) {
>>> -		tirn = tir->tirn;
>>> -		err = mlx5_core_modify_tir(mdev, tirn, in);
>>> +		err = mlx5e_tir_modify(tir, builder);
>>>   		if (err)
>>>   			break;
>>>   	}
>>>   	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
>>>   
>>> -	kvfree(in);
>>> +	mlx5e_tir_builder_free(builder);
>>>   	if (err)
>>>   		mlx5_core_err(mdev,
>>>   			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
>>> -			      tirn,
>>> +			      mlx5e_tir_get_tirn(tir),
>>
>> Sorry, for not noticing this before sending my previous email.
>>
>> Coccinelle complains about the line above like this:
>>
>> .../en_common.c:276:28-31: ERROR: invalid reference to the index variable of the iterator on line 265
>>
>> I think this is a false positive because the problem only occurs if
>> the list iteration runs to completion. But err guards against
>> tir being used in that case.
>>
> 
> Exactly.
> 
>> But, perhaps, to be on the safe side, it would be good practice
>> to stash tir somewhere?
>>
> 
> I tried to keep the error print out of the critical lock section.
> It's not time-sensitive so optimization is not really needed.
> I can simply move the print inside where it belongs.

Yes please!

Also the printk is performed on error, should not affect the path
critical path performances even if that would be time-sensitive.

/P


