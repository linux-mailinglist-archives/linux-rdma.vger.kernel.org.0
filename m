Return-Path: <linux-rdma+bounces-13440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE96B7C613
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632D11883F9B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4F345750;
	Wed, 17 Sep 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp2CBoTN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23028489B
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105586; cv=none; b=CQJTwif8bUokDfob9nPaP3+SJvuJxONacfsUGokS/v6JJQ9seRgRLJDnVP3NTb5XkkTSZMA6VL4KiMaZT828PrqjFkZzpLc0AXFoNYwkN4qu528zJSgm0Rj9go0zmN1KhHF5yx8fIIv0dWmTzaUMKy4PKoiaxLEqdhx4BDr5/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105586; c=relaxed/simple;
	bh=R4CWvOUtCvrgdNMym402PYTJjWgUILHeZKrnJPMuhgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1d6bt9gyLd2kO3uhwcO86yPpyMX1mTtSwz4oZMz6uDZiiqwFZa1MYbakNaOwhsFIZD65H1xb3m7PXnkZTd5Aytz1L/TTXjN5NC99rfqqDbeua/fGKDgA0Lw26Ug8hDLIku5NHEJqiAtCK3yLKBJxzsdI+/ESlYj7va9KPG6D+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp2CBoTN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so6633735e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758105583; x=1758710383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+sQHbuAnUVLK2DcccTjeny/VsR+2o6xAMfUxaFboC4=;
        b=Cp2CBoTNalC9pWPf5OZPZP1oscN+RkKFGAyyVs7kQcsgII9WtM0putFb1oyuIlXPE4
         BfjcAQCWf1ML6yJsT8l9C+dtkQLCeSrAsNKSI2fqVAWZl85J70p9bYxHc7S/zBPC8Wpc
         nqfd+dqpEwbzM7S456aUjosi9hnwumnUl4i4W3Nk5fnvOUS46VdaTNZXpUbZHPoW7AwI
         uBS7UXlt8Esd1t6SmJvDRNBrNnXQ3zKad9pgzOMk4SmC694YNgaaGoZjPDpm1P7L8YC3
         o6XvUa7Job/nOGboGpq0FArTqFGJ1bh1KicVinPuKYMOEEhYgwPdx41Qhag+XMSUNmUn
         N+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758105583; x=1758710383;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+sQHbuAnUVLK2DcccTjeny/VsR+2o6xAMfUxaFboC4=;
        b=hPrDZf3C5J5pVZrDO449fTlvBSjZGFxJ3HJAKfz3zlQ0rLLe1BGI661wFi3WiQLDzI
         NyjQ+/Go1oxsz5H8QX49D3JIumyjrDSkoLMvvLCEEL09+noV1hZEn6Fu44FfiMGz39Xg
         q0Pnkunf9AsxAp9dt6/iPdVFkX3RKMFNF+xcr5+S9xjYxpklDnrUg1vBBOcNWsk1Sq0T
         FdFK56zmsFM6vczTpiwPru/p6XquLryUSEhhs/Ox062NlMx0Z/B3NV6SpJQ1zHxbMxim
         6mpt8ZIVBvEVYG5dH7yVQX2CRHH8QvnHHMnk5KvWS9oPZMy219XN4xdr3hbU2vkYXPtK
         EMHg==
X-Forwarded-Encrypted: i=1; AJvYcCXizebiHrMZ8w+/+jH87jORmjrpeOwt6uFtr35zUBd/NEnjtJHTDaFgDSGTINWzKuSlfq2LWnor9FN2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xRNoi8pnCBqH09MINvtJbT0SlXVTNjWg+g344S0mA8R3Zjzn
	QEJujV7elCNB0ilgWFbUsSTLRYdIWe8T85OzaJm0IqD8oYZuUm5uLPAuyjIS5A==
X-Gm-Gg: ASbGncsiyPuekRnXQLrn9IVs9X0bX0aEdTMo0eL6nYvu8LW+bKrZ1Qk5VOBSJUGfb0h
	nZ1eFBgV1DX4l3jVcVPbNgfw7jMJpPuo+iz4vXDLiAKa5Mo1dlO6rNhVFy8ycnsNhVIceALERwP
	IHSknSOtPahe0KqR1pI0j/+xehrkeKXeYfevqEuXn1hMO2ugnvhA9yT3ftQBVk487M22aR9BOQV
	RDsbosq/R4ar8iM5VSCdlDPLtQSMxOEidHx2L24xMIbeYMr+eyWApBjeiqY1P1eGN/mUKQTKdGz
	YvTOsxsv8WEeJawtamAO7Q8KW6PGmK+7PvaM4CcRoynQlij5ksWg/ibB8D2b9ZJCsttir8hbu4n
	2XTdvsQICkVivox9e2Xkx6dnF+IPJPxTmrrCbhSgf9hfwWmS7AumpBA==
X-Google-Smtp-Source: AGHT+IGusD+yhysHUCpNgRezV67Os0zRE0BcwTnTYY3tkSiddnSyzrDXOcH3hNEFYbbdLLij2+d3RA==
X-Received: by 2002:a05:600c:6d2:b0:45d:d295:fddc with SMTP id 5b1f17b1804b1-45f32d002aemr36748375e9.4.1758105582776;
        Wed, 17 Sep 2025 03:39:42 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775b13sm26083726f8f.10.2025.09.17.03.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:39:42 -0700 (PDT)
Message-ID: <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
Date: Wed, 17 Sep 2025 13:39:40 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
From: Tariq Toukan <ttoukan.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org,
 Alexei Lazar <alazar@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
 <20250825143435.598584-11-mbloch@nvidia.com>
 <20250910170011.70528106@kernel.org> <20250911064732.2234b9fb@kernel.org>
 <fdd4a537-8fa3-42ae-bfab-80c0dc32a7c2@nvidia.com>
 <20250911073630.14cd6764@kernel.org>
 <af70c86b-2345-4403-9078-be5c8ef0886f@gmail.com>
Content-Language: en-US
In-Reply-To: <af70c86b-2345-4403-9078-be5c8ef0886f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/09/2025 10:38, Tariq Toukan wrote:
> 
> 
> On 11/09/2025 17:36, Jakub Kicinski wrote:
>> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>>> older FW versions, too). Looks like the host is not receiving any
>>>>> mcast (ping within a subnet doesn't work because the host receives
>>>>> no ndisc), and most traffic slows down to a trickle.
>>>>> Lost of rx_prio0_buf_discard increments.
>>>>>
>>>>> Please TAL ASAP, this change went to LTS last week.
>>>>
>>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>>> on 6.12.45 LTS.
>>>
>>> We are looking into this, once we have anything I'll update.
>>> Just to make sure, reverting this is one commit solves the
>>> issue you are seeing?
>>
>> It did for me, but Daniel (who is working on the PSP series)
>> mentioned that he had reverted all three to get net-next working:
>>
>>    net/mlx5e: Set local Xoff after FW update
>>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>>    net/mlx5e: Update and set Xon/Xoff upon MTU set
>>
> 
> Hi Jakub,
> 
> Thanks for reporting.
> We're investigating and will update soon.
> 
> Regards,
> Tariq
> 

Hi,

We prefer reverting the single patch [1] for now. We'll submit a fixed 
version later.

Regarding the other two patches [2], initial testing showed no issues.
Can you/Daniel share more info? What issues you see, and the repro steps.

Thanks,
Tariq

[1]
net/mlx5e: Update and set Xon/Xoff upon port speed set

[2]
net/mlx5e: Set local Xoff after FW update
net/mlx5e: Update and set Xon/Xoff upon MTU set


