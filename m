Return-Path: <linux-rdma+bounces-13458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A51B7F83B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D992A639F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901D32BBF9;
	Wed, 17 Sep 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1CGLuQi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909E328980
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116342; cv=none; b=Rr5DyYKyuxS1ro/GiPb8RXL1RLjIOCyBezZgjcjri3HT2QUlhfDV0xyInPumsI/pocglamtRNvl03+UXg2jBJsEYwzCEhbknd3a+JpxVmX28A1sl1ckAs5/0cRPxRqO9E7pmuPFaAbIv7h1WsczjBKBbt74Vv90PWXSF7DqZTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116342; c=relaxed/simple;
	bh=1a1RGyOEU++H/the0LpqR7ztI6UvvUkE+gX4LxX6WQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPCMNryGikTRbAnZAlOPBO8tz4KlMTqN2RPsu/fXY2ddBA1o01Yr/RVtkn7Rqg3wvHRQPpGGaC0UlMOY7qRSWhHFgQJzgRF9CDh4M4b6BP0MC26GodcaTK8fs5CvkWfPTltcVWfiC2T+nB2vCsGAILKvQETTIeCvQVs1lMkWA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1CGLuQi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so3307742f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116339; x=1758721139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBjPagXwVXjct44W+AEh9yq9e3RGS/ToZPXdGSZz0Ms=;
        b=P1CGLuQiSDvsfaWoo3keY/7ekbrh8SzFah2C12INeQgQFAqiLE5FWsJjAzysvye5dK
         OUYiIss1NKXJkdyCYo4wTLB04pDj6UmGjNR8k8tt1kgLBKCqfbgENQK+BOkRM1G8bArG
         a7hxk/7xcfvqeHfcTmd4egX9pXG+5aVerAaxEN4PUk30sml0vhfl/dNnFnKS/MyiQp0Q
         47fyR5W388kwM8Bh2+7r8AjHWfLNymN3yj4K13Dr9wp0boPcIgIMn8VBa9SZJmZZDldW
         WnTfsHEVBuxK3SpXJLjtKHLQnC38dPyoEuAbpAFQhwT5Ij3kc+2GXmi7uRHCLXSodTNv
         7Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116339; x=1758721139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBjPagXwVXjct44W+AEh9yq9e3RGS/ToZPXdGSZz0Ms=;
        b=Uo8kSs+kZ9boeRmuBp9RBZYE+F+6Y0Abr4h+JczxpWWtqf22gKo2d9ni+S0sFelpBM
         JMCl1SoxMqAO0w7+xWQ0sJoSb+JHmjk5Qid9L3ZzTfG4ezvCD93nli5JlSEwAWqJUgQt
         Gqp1G8NGS1PQCIi2DvavmbQa6fYp4g2zlzL0Imp6qfx2ht4KeByCKcZxQq37AmD2Cj3u
         ab+VtgPjmxT973FZQ50a3LEh/TF45lg3a/Xas65reQ1ijIfQnnbLCLeNVyU3weksEaTi
         NbQv3Bzy3YTnGYvJYDqvU6c3B+wptUQDEW0e+8ZHR570vaAi0s3x/w++BbPwpjdGSL9o
         YQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzFy19fN/g38OKAm+QWWNB+cEDLe7nB1KDPTKmWQJ7o7HBufKerolQHis6X4jvO0dEalM78uR6lssp@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRBKywlc33Jpo3ItYr/WBQkUCGrpBrRcFMKt5p0oKPfULRL0W
	lniDqsjBijGbG0lFPjvPgRB1f2r11XhigTd46DhuvVP4vx95qBLjyUr2
X-Gm-Gg: ASbGncvl2iPaaColTTMKHeu3HLfqti825R1DF2BFFzwfbKSRgqHEAa1KGnRKzKMhc94
	p2ug6ZvP8x/pby5jCGRi8F31jcSw84zpLwzd2gn9fofnd3tG3sc7TifINsYrAmFsORpL6rNAgvm
	sHx/V1wFMtDfS5Kr987yg+x/YU6nqd9ZoIFitMYXumWdbcoo3OLgSwTuMr1v68hwVMrw+hhe0pI
	Zau+h8EM8YOAcENIy76uj9cDSyKD521ysLp60qLA2rcga8xGzt3mpBegX41KieTTLKMmCptkaCj
	7zFRSGkYKFoioUsu8sqQoN38ObQ5wJQR5SC9CHH9gf28/13NFOHpJVJRZ7Ctu+sZ4gP0nvQUl7v
	0JspOHoqIXw8+4Vzm9+f3Ui/qQqFQkyGOrjYtL81nHAC0IjKXC5VTcw==
X-Google-Smtp-Source: AGHT+IH7qzQEHfiS4gG1DZC2jmRra+O7WyeZowBozu0NNUNL9xvNAPAEdUNJh9cvbkkud3VZ5XgSwQ==
X-Received: by 2002:a5d:64c8:0:b0:3ea:e0fd:290b with SMTP id ffacd0b85a97d-3ecdfa0d2f1mr2162241f8f.40.1758116338491;
        Wed, 17 Sep 2025 06:38:58 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46137a252fasm37570245e9.7.2025.09.17.06.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:38:58 -0700 (PDT)
Message-ID: <22c4fa32-43dc-4c92-87d3-88e2ce3dfd00@gmail.com>
Date: Wed, 17 Sep 2025 16:38:56 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
To: Daniel Zahka <daniel.zahka@gmail.com>, Jakub Kicinski <kuba@kernel.org>
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
 <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
 <71ce45fc-5214-4d40-b8c4-abab1d44314a@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <71ce45fc-5214-4d40-b8c4-abab1d44314a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/09/2025 16:00, Daniel Zahka wrote:
> 
> 
> On 9/17/25 6:39 AM, Tariq Toukan wrote:
>>
>>
>> On 15/09/2025 10:38, Tariq Toukan wrote:
>>>
>>>
>>> On 11/09/2025 17:36, Jakub Kicinski wrote:
>>>> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>>>>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>>>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>>>>> older FW versions, too). Looks like the host is not receiving any
>>>>>>> mcast (ping within a subnet doesn't work because the host receives
>>>>>>> no ndisc), and most traffic slows down to a trickle.
>>>>>>> Lost of rx_prio0_buf_discard increments.
>>>>>>>
>>>>>>> Please TAL ASAP, this change went to LTS last week.
>>>>>>
>>>>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>>>>> on 6.12.45 LTS.
>>>>>
>>>>> We are looking into this, once we have anything I'll update.
>>>>> Just to make sure, reverting this is one commit solves the
>>>>> issue you are seeing?
>>>>
>>>> It did for me, but Daniel (who is working on the PSP series)
>>>> mentioned that he had reverted all three to get net-next working:
>>>>
>>>>    net/mlx5e: Set local Xoff after FW update
>>>>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>>>>    net/mlx5e: Update and set Xon/Xoff upon MTU set
>>>>
>>>
>>> Hi Jakub,
>>>
>>> Thanks for reporting.
>>> We're investigating and will update soon.
>>>
>>> Regards,
>>> Tariq
>>>
>>
>> Hi,
>>
>> We prefer reverting the single patch [1] for now. We'll submit a fixed 
>> version later.
>>
>> Regarding the other two patches [2], initial testing showed no issues.
>> Can you/Daniel share more info? What issues you see, and the repro steps.
>>
>> Thanks,
>> Tariq
>>
>> [1]
>> net/mlx5e: Update and set Xon/Xoff upon port speed set
>>
>> [2]
>> net/mlx5e: Set local Xoff after FW update
>> net/mlx5e: Update and set Xon/Xoff upon MTU set
>>
> 
> Hello Tariq,
> 
> My notes for the situation were that I was running a vanilla net-next 
> kernel on a dual host, CX7 system, with the 28.45.1300 FW at commit:
> 
> deb105f49879 net: phy: marvell: Fix 88e1510 downshift counter errata
> 
> and I was having the issues that Jakub described. No ping working in a 
> subnet. Extremely slow bandwidth on a large transfer. My notes say that 
> reverting just [1] (from your message) did not fix the problem, but then 
> reverting [2] and [3] restored normal behavior.
> 
> However, I did attempt to reproduce again on the same system this 
> morning, and now I'm seeing that reverting just [1] is sufficient to fix 
> the issues.

I see.
For now, I'll submit a revert only for [1].

Let us know of any related issue you still hit after the revert.

Thanks.

