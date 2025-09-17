Return-Path: <linux-rdma+bounces-13456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B515FB7EF37
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF67B7A11
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 13:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4A330D56;
	Wed, 17 Sep 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpDI0AcA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD68285073
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114053; cv=none; b=lpgg932iC4YrMzkwF4vjWdOYQG9DZC/vZSFfVc7S1dzkq6nZC5xKpjzzHcHbEHsY9kfxOy/mpjXxgUw/CS70a8PGeWDzQbaQ8P2ndwpoipD62m+0wdblu1jEoqacxjLHVGggyHJPvoo+rKbA6btvUvYEhPdE/HjJu7lLLcFEfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114053; c=relaxed/simple;
	bh=wk9RXuVqpXxxFDzmO7M+cLF30Msy65hjjIojj2YuEdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWffiwsr5qweN/Nc5xFThEE73f2j+5qTW/foPVfpl8ZW4/TST6jAgl7oDbaqJuXo3RUJQRg473B7j2t/+UjwxiyXhJqTzP4bQSPvlCTbwOfRJIpEwdN8I7TqKKqJImvGDKtROrr/fKGMaVoWkWknD/8JF91S/xiOpq93DnE95o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpDI0AcA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b34a3a6f64so56748831cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114051; x=1758718851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X00c/S8lQpFd+72iK9PH+Axt2hlWX60fuXCEoXNETw8=;
        b=ZpDI0AcATciuya53zosHs+bmnW3OTx8VoXWz6sTxo/0uJTbjLtVFUPdnuwYLprGuRy
         bQcJ+kcAJPpDmClQUDIW2adQfTWzvVywMsZtJQgdc6Sv5DSS3SneCPP7ATe4Kt0l9/wd
         uids1L5u3xNU2mPVpMNrLw8YuarAyK5e9L36hcmUR7wSv65wP7MaSf5/ntQmXR5Dfmy3
         +mHR8f4ptCv2QXkdkwqrrQQbupELYcOCFhE2pc0uTB80ERRb6rUJIQWU6RCMDCFz7/0c
         pfb1fb7OSQAFFrpBdeavuT6IKg/opxA6wE7qUkwhulaZ5UMuiC4/WwLrme0FyONloy7N
         zxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114051; x=1758718851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X00c/S8lQpFd+72iK9PH+Axt2hlWX60fuXCEoXNETw8=;
        b=FVPSC0Yc4NybDEEvzvMBuOQ001eAd5s7Vab1LNRPOCirRiehFJzLpyv8xZxsghX9Zt
         iAaqOPvfjmLi6YXliQ8cWvqJ/gaNSXD9IUGAGtxp55tYC5Wg8LAp/S2EBQgXks/I13C6
         4Y3HATqf439YTvx8dlywvD1TPk1YY3R1cbHWUPOVH7dDBFShpNg4eiMMqKMvCIyuJVl1
         jUmvH9HHVmuvULtH+SxuRTlC3Av2ra3dTfAuK3Mnj3DpYh9nR4XI/P1/yVNNMlqA/0y8
         mEN6bXFx2gwt4F0sxQlCqvGRLCwLq4mh83QjQwtM5FsljO1MkCDn/IaX4pfdss11bX3A
         K1ww==
X-Forwarded-Encrypted: i=1; AJvYcCWAvCRw5SpmzGcq/q88zCZPYOGxtHZh0BeFzvqz+Qne1S4PsFL2sDaN55KzlNctwyR6mbL3BtZ85Sv5@vger.kernel.org
X-Gm-Message-State: AOJu0YwinqwABKXOEGYMNJEAvWW6t2r1q/hmQvLiZNYtzMU5CftBlTG3
	SLyG7T35X9zrat4fX7sHkw00yRkOd+JRp6I3u8Vp9yFdqPPjFWq5C8OE
X-Gm-Gg: ASbGncuNIiSo2Z/gg71nqhZkLnmuPI+4itKWuLD0g8AbETG2yWcQoaOOeno180SlCED
	M3HneOewqZwt+T+ZJiSNJcBUHsB2FJIS6dtLm7LJWJCwKW8iPg5hTfFxIvYa8tMaN1ASQtQs6z2
	vNGZhZDGLW+EEm/6hxNoh3Ls0qEp/Ifr4o867M8crbd9dlBPMzdjjYaDfW6s8SJw2FRMguDHpkA
	XSZZoeph/KZz0hrx1V784du3Xhvx/8JashTldSnqGDEIDdic6sojtwqrYJbv9hiYoI3BqE1JzMr
	6fJqg04+hU9JOi27iHQKcvN8SJ0qTgC5hdxEdHghfktqhGx5qvNMXrlzwoX4O0N6BUuILgCeQl0
	lkqYCY6b6bcPEgxQsmCK7vxaax8oqEoWwcvQr1Izbxmxl0OGx+5MnITbb
X-Google-Smtp-Source: AGHT+IGo7e3giCzoRWJPH5fuNrErSKA+sW5Jg+vdwA1lvHisc0+bw0iNJTwvMQIo5DNK9p/Hsz6KRg==
X-Received: by 2002:a05:622a:59ca:b0:4b3:50b0:d7f with SMTP id d75a77b69052e-4ba6b089cdemr27166391cf.61.1758114050366;
        Wed, 17 Sep 2025 06:00:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:d14c:9eca:ff3a:fa00? ([2620:10d:c091:500::5:59da])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce19df73sm1094771885a.51.2025.09.17.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:00:48 -0700 (PDT)
Message-ID: <71ce45fc-5214-4d40-b8c4-abab1d44314a@gmail.com>
Date: Wed, 17 Sep 2025 09:00:46 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon port
 speed set
To: Tariq Toukan <ttoukan.linux@gmail.com>, Jakub Kicinski <kuba@kernel.org>
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
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <1407e41e-2750-4594-adaf-77f8d9f8ccf7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/25 6:39 AM, Tariq Toukan wrote:
>
>
> On 15/09/2025 10:38, Tariq Toukan wrote:
>>
>>
>> On 11/09/2025 17:36, Jakub Kicinski wrote:
>>> On Thu, 11 Sep 2025 17:25:22 +0300 Mark Bloch wrote:
>>>> On 11/09/2025 16:47, Jakub Kicinski wrote:
>>>>> On Wed, 10 Sep 2025 17:00:11 -0700 Jakub Kicinski wrote:
>>>>>> Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
>>>>>> older FW versions, too). Looks like the host is not receiving any
>>>>>> mcast (ping within a subnet doesn't work because the host receives
>>>>>> no ndisc), and most traffic slows down to a trickle.
>>>>>> Lost of rx_prio0_buf_discard increments.
>>>>>>
>>>>>> Please TAL ASAP, this change went to LTS last week.
>>>>>
>>>>> Any news on this? I heard that it also breaks DCB/QoS configuration
>>>>> on 6.12.45 LTS.
>>>>
>>>> We are looking into this, once we have anything I'll update.
>>>> Just to make sure, reverting this is one commit solves the
>>>> issue you are seeing?
>>>
>>> It did for me, but Daniel (who is working on the PSP series)
>>> mentioned that he had reverted all three to get net-next working:
>>>
>>>    net/mlx5e: Set local Xoff after FW update
>>>    net/mlx5e: Update and set Xon/Xoff upon port speed set
>>>    net/mlx5e: Update and set Xon/Xoff upon MTU set
>>>
>>
>> Hi Jakub,
>>
>> Thanks for reporting.
>> We're investigating and will update soon.
>>
>> Regards,
>> Tariq
>>
>
> Hi,
>
> We prefer reverting the single patch [1] for now. We'll submit a fixed 
> version later.
>
> Regarding the other two patches [2], initial testing showed no issues.
> Can you/Daniel share more info? What issues you see, and the repro steps.
>
> Thanks,
> Tariq
>
> [1]
> net/mlx5e: Update and set Xon/Xoff upon port speed set
>
> [2]
> net/mlx5e: Set local Xoff after FW update
> net/mlx5e: Update and set Xon/Xoff upon MTU set
>

Hello Tariq,

My notes for the situation were that I was running a vanilla net-next 
kernel on a dual host, CX7 system, with the 28.45.1300 FW at commit:

deb105f49879 net: phy: marvell: Fix 88e1510 downshift counter errata

and I was having the issues that Jakub described. No ping working in a 
subnet. Extremely slow bandwidth on a large transfer. My notes say that 
reverting just [1] (from your message) did not fix the problem, but then 
reverting [2] and [3] restored normal behavior.

However, I did attempt to reproduce again on the same system this 
morning, and now I'm seeing that reverting just [1] is sufficient to fix 
the issues.

