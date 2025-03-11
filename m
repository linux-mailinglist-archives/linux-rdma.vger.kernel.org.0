Return-Path: <linux-rdma+bounces-8587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392EBA5D118
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 21:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDB8189D0B0
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E750264A71;
	Tue, 11 Mar 2025 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVNO6MgX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38C1C07F6;
	Tue, 11 Mar 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726231; cv=none; b=Jz9pIxnxIUt5z7PCT/AuLBF6JyxlrG0pULf8MSuADHKsk5PtB8w8uqKJDLJuGDf9SKk+AY+z9fqsMDUIHkMx5kmwztQLR8sGb4qxs/VNlYBHvhmd6xV61+Inz0OujLMRIIirp7DBOzzBUUOYKqI0YsJfOvCFjxWzs1LLodx7v5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726231; c=relaxed/simple;
	bh=oVKq5TbENWHyPMyjXS5YAxHWzJmVViDoKuMy7xMuJl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qR2vYjUtWqJOhI2CxSY+00CGAlHoME6XPeyRSwZTaArj8LbAiDO3wJI0rtBbwAWm7QNYur8ayFZIIcJUCzjGEg60NUijaJsSo3nKfUiEkfaR1x4GTPpkfKAwOKhQCtS2l1CsK8HnU9DVSx6XXKZF3RvMCLWjXNUdV93obkEsOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVNO6MgX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25d2b2354so758815166b.1;
        Tue, 11 Mar 2025 13:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741726228; x=1742331028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/l+hci5LxmrsX7kXt4haDLTY6mALyMMCg0pgcAEwgTc=;
        b=jVNO6MgXZbVbzt7YWVifbf1s1xX8CDQTAu8eNJI1n+dfZYjihP3p8+LezMDtNIDswB
         CwsWYJOi88+YrWm+BgKIpOU2neItkh1LIFiowydSxcxtuz7IB4e0V5HzVjKG1kD4g+w7
         0wKWU8dH5p4TgFKRKramL1ctbVFRsQiXd9obNLJECBBNU+znxrDZkADgMdIm/AJRmAqh
         RR+59S5jytHgjbSo3JwongQ36/ZLhj7SoStoTP1WRIL5T9DwxMjrsSEXQos1nDGp1UsI
         xLXnxGe2x4nNXG9D5dqO6sPBMEzbEkn2GraURLDnibKAm7AlPRbGy+2Y51Fp0PICngW1
         r39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741726228; x=1742331028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l+hci5LxmrsX7kXt4haDLTY6mALyMMCg0pgcAEwgTc=;
        b=ZqrBsM+tNF6jVQquzF8BYMFOzQfNDUa0XK74tE+egWK12nW/ve3TVWji6N28ArbyfH
         /7G3xTpgWGkN6Ghj/UCK0HIXPWRAxSiLO9Kp1lJXGDOKRJHJq7kmM1oQCtk/0U6/Ut2g
         iCbjys/OlmsYCxcWonrRdvCda63+Cnrqisoh+5tS7gG66TrtRw2wS4Uva0UOqbJFphYq
         A5DVhrVRUwjdRWPG6OW4p5WhqYyQQeLzgawLvGWBTeGCJLFQ2eyHNcvV/dcv3Yj9Zz04
         ghqAGh6qjV2myCR6378Hzng5FhdMdzNvISJuuMKO9pAocKfmbbj7dffuC/57vIFAx2ap
         NnNg==
X-Forwarded-Encrypted: i=1; AJvYcCUIU/mg9x7XmwGHIs+NkxmeujckZY8c+FygbcRrL7dOXiN5nN1KMVxy+qkjawjrM98ewQwAu4RRJQTCb+Q=@vger.kernel.org, AJvYcCVzXLZ752p2JhRJRf2JkTZi+adGdJxsaEQPw75TtB4MGa5PMh4vZbEn9Kqgv5SsMrpxThdCMHL7@vger.kernel.org, AJvYcCWJlrZVX1MJjvbZt3b7nbTUA+cR16FdwILBmAZKqdsmNm8j1Feu2QHCUCo7BOgJGbT7PJYCt6gu6Ohe3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3R1hu9w2iXm02ZHRD7+RgZIhrgBHRjFmCcyH6wjn+gqeb5xDX
	3HfogseHMup+wVCcFeP6bdc+8vMbf6GKtL9mQdsS0520Jnl5KhCF
X-Gm-Gg: ASbGncvZYPqF7lq6+khtzpmR7i7Q1fY2TM1JoQn/u65wzIJHKyl5bvsfBMgyvjCQ+hY
	VI2z0lHB1Uzkog1FWv4dciuMWIX6rr6U1LwSnGj62pLQIzGwhJPukbn1CWGyTKGuqEVUi1un063
	0AKMcTjFDtVgp06vzaHVwSEj0+Fz3pTuAKSELJ5ircn4hlqzkQaiqTCDPjIPGv9nbonmBIvBO0p
	6+mcRndEOQCQ7BBqhpGLdMaAyBpy1wfnCTEnh+/oF+9tpG3PsRmsoDz0WPgcoupkQBT/twhvT18
	6UcXG0cx4RKRzADs2bPNOziLxyt2lHw3CgcMY1TN0f8eh45jCCwozlWUhRliJjnz
X-Google-Smtp-Source: AGHT+IGiAdrC0XMxxtZh8QiPtM1d+V4mARMfjlRF1592uT00GQfzYvmUE5WVe0dDQcSS8tqykimrWw==
X-Received: by 2002:a17:907:2d8d:b0:abf:6db5:c9a9 with SMTP id a640c23a62f3a-ac252f9f653mr2726299466b.39.1741726227378;
        Tue, 11 Mar 2025 13:50:27 -0700 (PDT)
Received: from [172.27.51.89] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac28cf931d0sm505636866b.95.2025.03.11.13.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 13:50:27 -0700 (PDT)
Message-ID: <9960fce1-991e-4aa3-b2a9-b3b212a03631@gmail.com>
Date: Tue, 11 Mar 2025 22:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pull-request] mlx5-next updates 2025-03-10
To: patchwork-bot+netdevbpf@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, leon@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, mbloch@nvidia.com, moshe@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leonro@nvidia.com, ychemla@nvidia.com,
 Tariq Toukan <tariqt@nvidia.com>
References: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
 <174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/03/2025 12:42, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This pull request was applied to bpf/bpf-next.git (net)

Seems to be mistakenly applied to bpf-next instead of net-next.

> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 10 Mar 2025 14:04:53 +0200 you wrote:
>> Hi,
>>
>> The following pull-request contains common mlx5 updates for your *net-next* tree.
>> Please pull and let me know of any problem.
>>
>> Regards,
>> Tariq
>>
>> [...]
> 
> Here is the summary with links:
>    - [pull-request] mlx5-next updates 2025-03-10
>      https://git.kernel.org/bpf/bpf-next/c/ef4a47a8abb3
> 
> You are awesome, thank you!


