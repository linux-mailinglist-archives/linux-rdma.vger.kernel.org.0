Return-Path: <linux-rdma+bounces-8646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD0A5EF0D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6C73AC1C5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86313264FAC;
	Thu, 13 Mar 2025 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4QRz7V6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C5263F31;
	Thu, 13 Mar 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856899; cv=none; b=dntR7IpYoHOqnj8mOpufFhxx+8rVUqEjQT8TBDpOeOo66kW6/5buoVswhJcTCCA8ZQ6YN10lA3484KoWA3sE3d79T1v+4WTvaPou5ZmXV2uuEZeyDO5MfeE3wGUv+c1qi5OwXwnt9NF/zXQi7VqIMvEvyveTkUx3P0Is/INhr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856899; c=relaxed/simple;
	bh=Y46uAjc2WwsYW0kvpCtRMIkFelQx1ayGujrqPyP8wFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkSBQJuGEmcitUljNHYTx8E3k0f7MAjJGdg0YDOVOTzSb2sLPgESpM0JC1cyZha9yjr8u6gOm4CTJ+orE2MtetgiEhDHffoB5Ntz2QX42Pxo4kuAfOY1I+74X7OvnPLOjbtHF0QYUz/KzbSSuTj3gxCmh7pgE1yizfhIatBk72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4QRz7V6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso3779835e9.2;
        Thu, 13 Mar 2025 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741856894; x=1742461694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qq8chwA6KqjCz+471khnFvPik6MocooRpqaoLoCyprM=;
        b=b4QRz7V65Kl19ymt5Ju6lb4Yck6QCXLx7hB5NJCwAg8i6CFvlDEIWlWTOvpfnYTvTk
         1ED/dZK8Tk2FH0Z4+Xg2dra+1tuLJ6/zooPjEqKb2Az7aIO7v5zWqL+VO/wrLHmJBtvk
         O7OCprWC/3JWMTjwK/+mXY185IljtfJu6FTHLHnK7XNSJkyzbo85S3YN18Z+QXjgdQiG
         l6ZYt8rFHhq8Nz9kS2XGSE+00RFKrQiRTCYDV0jqJUvidCUsii97x7SjA23Iublx90+h
         81RuE7wOoTUJ++EkD3iLLWB49wcXMyiRpM3OqFl4Nw5+9gpfO1Vu50bKfavwthDQVCnT
         bqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856894; x=1742461694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qq8chwA6KqjCz+471khnFvPik6MocooRpqaoLoCyprM=;
        b=vJEsmbyao1Fz5A8SFvvYfJCxQY6u5DzkMErDWq3xULRKLLTYZwIffDpXeD1dOko5H/
         +yokKuVdeiPJmUky8VtonBfgdQkLTdvBrnIJiPQcHkDH4WD09WHGzbEuHit4KrOKp0Fv
         69BgheJlGJI+YjUWuHz6/z8/6Bo+XqTR27Kr8XaRyc7VZabxLMtSsJTEHE7rn1JuFU5Z
         WmPNkb6ZMcxpnVgcsxmOHlEdXPUktVq3skVd1wfrN595cVPW//yGH0J2OnAf1fu1Wd50
         74Tl//ueTeSGl6ZCiaY/iA4KGw3Fd0ZvZ29TWfkLJ0dFc0WOwCA3T/unGYAhpGb0Oyz9
         VbHA==
X-Forwarded-Encrypted: i=1; AJvYcCVLrk7jZzf6cpEP6Sg4ITa6qcQ+W9g3zqpDCCzdCs47Nm9N9QX4jdezgt9sHm/s902DAcVDIoiw@vger.kernel.org, AJvYcCWuwmJxbILG1qpFtQtI6Ht4OKjW0C1IhKnUiQO/dEnnkedYduNsNuSyN/TB8CKQrZafWcWBaHVq/i4EJA==@vger.kernel.org, AJvYcCXxojT443RBH6RtYikP9Y0qxlgY5MmAoK57H1GS+XlMF5V/OjLYO6pj62Zc5/+24VzZLjO0B6AJhtt1Mpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgZxdrDOkdBn9Q+D9/vUc0GAMBLL4Ba/PQ1N0sEJNmO9y9xd4
	PGsY0qz02mKaQHSwfKJGpgnkj1g8IVeXdHOY20hgagsv5PNfEiOI
X-Gm-Gg: ASbGnctJwfICNHzv+NKO6y315gexSeM2g6qb2EW2dXnUAv8665+HRIMkeQkpwUNWasN
	JJ0OBxEAZ6wLyVbi4OPSwHxk9SISwozicjLoS08209I6q7vc0jHJU5RczRH56PiLQfIx+Tu84hC
	BrKYJC0A67BSACYeCkGSG5cBJn5diC+T7gHPCIPBpZ6IxYSEQ2BQwEQEHfeFNvj1GlyqzjkxaB5
	HhX9RskrhOHFcK//tnWB1k7qY+6NXiw4/j3bsfEmbXaf0nuNDKWHmg8H5e/kynGL0rcDPZBpH11
	kAtVsB3ZrO1UwL5t6xOBSIDqC5b44GM6+SWto0bnI7292E6pomcE+fBJyNeJatsP1Q==
X-Google-Smtp-Source: AGHT+IEx/vxoywpLDtliIf06LUvxQQPA669OYg9JK8g+lJBkZEhkeL9LDTGRU2nz7ga7JcF45nzaAw==
X-Received: by 2002:a05:600c:1d1d:b0:43c:f8fc:f687 with SMTP id 5b1f17b1804b1-43d01c25c75mr90143395e9.27.1741856893725;
        Thu, 13 Mar 2025 02:08:13 -0700 (PDT)
Received: from [172.27.56.126] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a73127esm47706005e9.8.2025.03.13.02.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 02:08:13 -0700 (PDT)
Message-ID: <a26fd105-deae-4efd-8d77-d5d9e0cac13a@gmail.com>
Date: Thu, 13 Mar 2025 11:08:08 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pull-request] mlx5-next updates 2025-03-10
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, leon@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, mbloch@nvidia.com, moshe@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leonro@nvidia.com, ychemla@nvidia.com,
 Tariq Toukan <tariqt@nvidia.com>
References: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
 <174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
 <9960fce1-991e-4aa3-b2a9-b3b212a03631@gmail.com>
 <20250312212942.56d778e7@kernel.org>
 <f30ee793-6538-4ec8-b90d-90e7513a5b3c@gmail.com>
 <2ff2d876-84b4-4f2f-a8cc-5eeb0affed2b@redhat.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <2ff2d876-84b4-4f2f-a8cc-5eeb0affed2b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 10:56, Paolo Abeni wrote:
> On 3/13/25 9:07 AM, Tariq Toukan wrote:
>> On 12/03/2025 22:29, Jakub Kicinski wrote:
>>> On Tue, 11 Mar 2025 22:50:24 +0200 Tariq Toukan wrote:
>>>>> This pull request was applied to bpf/bpf-next.git (net)
>>>>
>>>> Seems to be mistakenly applied to bpf-next instead of net-next.
>>>
>>> The bot gets confused. You should probably throw the date into the tag
>>> to make its job a little easier.
>>
>> It did not pull the intended patch in this PR:
>> f550694e88b7 net/mlx5: Add IFC bits for PPCNT recovery counters group
>>
>> Anything wrong with the PR itself?
>> Or it is bot issue?
>>
>>> In any case, the tag pulls 6 commits
>>> for me now.. (I may have missed repost, I'm quite behind on the ML
>>> traffic)
>>
>> How do we get the patch pulled?
> 
> My [limited] understanding is as follow: nobody actually processed the
> PR yet, the bot was just confused by the generic tag name.
> 
> I can pull the tag right now/soon, if you confirm that this tag:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next
> 
> is still valid/correct.
> 

Yes please. Confirmed. Thank you.

>> It's necessary for my next feature in queue...
> 
> Please note that due to the concurrent NetDev conference we are
> processing patches with limited capacity, please expect considerable delay.
> 

Of course! That's totally expected.
I wouldn't nudge pulling this without the bot's weird misleading reply.

Regards,
Tariq

