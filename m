Return-Path: <linux-rdma+bounces-949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D039684CB78
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 14:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E71C250F1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E876C8D;
	Wed,  7 Feb 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD/reISh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6D76904;
	Wed,  7 Feb 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312234; cv=none; b=OZ6xNSvJop9HUloCbB4rXXjX8taXKPAvncM5VUI98kMGW/iwn0D8Shn8wxzi++aeQmH8jwIg2d2VG+NBNqraZGJ2nVFeHTau65rc4aig7exAtRg+84H8LTSNj1096jzZi2jex145yqv8E21wiulzM6w18YNrg56pQPD5k1Bq6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312234; c=relaxed/simple;
	bh=n9lnxml7vDWKWDhPukUbe53jnLIHfWyXAPQRkDlN8cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU8DI9PXTOxxWiZbMxnMLtuGBTLUdEbggdY6DhIoMx8c4vCscSYouga1FLA0wjQSnraDBIqzDfu3k0ZbwhhmkEm0Vn14oLAaZgWte3ym5XPLx7qMbB0YGTxp0jf/SSEC2I6WCAPAU1T8XG+T9YhzAMhDnpmBn6LDb7t8L0EHR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD/reISh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511689e01f3so456976e87.1;
        Wed, 07 Feb 2024 05:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707312231; x=1707917031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlrXLQPU7SiDVj92lskAkNYdA49Qzw9WwEfRE3KmueI=;
        b=iD/reIShEmiO5+JLardqIju3x6Wq4Q1z10Md3lFkWHuCalqJC98LnF2p8vlDZ/jN4J
         GY50wgxSKiKQPd8qhQG4yNkcEjmbmun+HYzftngOAlbkC1kXhwOZpGykxh0iWDDYl9SR
         pyF5/b2qd9WhSwwjOONiEYVgrMTvgfxSJiFmOokcutxAsnGQ7HrjXusDiUFDXE/0zjce
         I6u/ZKXEuk22zWV4Oa4i68FYIkKTzAz4c64x/RmmLB7+/qX6y8nZHGYaAM/pikbyDDo8
         qxmicgPcsVvATvMGpcIic/TM7ZIkMg6Rk4oV19FzAe9z9ztHST0QPhnmLXg+TxDfV7DL
         0CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312231; x=1707917031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlrXLQPU7SiDVj92lskAkNYdA49Qzw9WwEfRE3KmueI=;
        b=Fpkx3pL3S8D3DipNBGBywTC8zs51PPBIH8cpinnSMNvBUJ3c+WubMOd46x4Q9oTE+B
         7Auqegh1TRq384MRJ2bplCkCW3YRaEF8Ch2/2r5oj+XcIL0MP/p2XJuqHU/s05Dsx9o2
         ABy/cFexEyiryI8B/xotjuYGseBYQxYclcCfi9mlcEmzUaYjP/bsvPKuw2QVDgakve2a
         78IwdieoqZBeL97R0EpK0O/O0L1nX77X48wiH0v4gwlKifRmwYygaHpPwtIiNUZ2+Jgp
         DYEX9o5JO3fDkCoX2RgIcnR09Tvr/Whqm5A2CCnVS3M5iyBJsBjjLke9A3tdtMn7wmRL
         BHYQ==
X-Gm-Message-State: AOJu0YyoIDiHSVN660D3ZWe90D4+5EHUvnX68ulLXUEmHtck056ozSty
	xUV9a4M7qC+lKAMJSWfhrRiHYwBSSoyap8JconIRDg8dtYno96VN
X-Google-Smtp-Source: AGHT+IEM7csy2zcnsFVgegPV2i9UeAGj/ka+uV0FjlhlxQMcFZq1EuOMBgksb2YSqdTPTk3fQ60+5g==
X-Received: by 2002:ac2:44d5:0:b0:511:4edb:501a with SMTP id d21-20020ac244d5000000b005114edb501amr4064284lfm.15.1707312230865;
        Wed, 07 Feb 2024 05:23:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWM1dxoQWIi4KJuF3E581Mfce4Z9wgU445l4TYSli91UosKlBzuPThtUWOFnifu0Rm+HAtVeMbkYczszS0sz9/vSBy4iwQkSwxPmPV/l0wCvaTttI/JScNUcXZwgCjP1lJxAkkJdv6bd8hXrujxMU9+2WhWcRlo3gEaVBuf7b9RwAa419BxgX9VkAEusda4LdJhoUJ84R8/qFPUoJdmDatC98CITSt6OP46wCqKCl0JTtz0TGp1QUA4hGNRGp1+f69q9b3x879fqmIQ165iC8pp0AXKhXhejWhRj0tilp6mU0aeA9rddpXrJa++2MWoXpYDJfvIRvSfl3tm5CthVpyspIJ0euPH2v2LlaWwm7Y/
Received: from [172.27.55.67] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709064e9700b00a3848ed2ef6sm750772eju.201.2024.02.07.05.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 05:23:50 -0800 (PST)
Message-ID: <b19c4280-df54-409e-b3fd-00de6d6958d4@gmail.com>
Date: Wed, 7 Feb 2024 15:23:47 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, rrameshbabu@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
 <20240206171159.GA11565@fastly.com>
 <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
 <20240206192314.GA11982@fastly.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240206192314.GA11982@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2024 21:23, Joe Damato wrote:
> On Tue, Feb 06, 2024 at 09:10:27PM +0200, Tariq Toukan wrote:
>>
>>
>> On 06/02/2024 19:12, Joe Damato wrote:
>>> On Tue, Feb 06, 2024 at 10:11:28AM +0200, Tariq Toukan wrote:
>>>>
>>>>
>>>> On 06/02/2024 3:03, Joe Damato wrote:
>>>>> Make mlx5 compatible with the newly added netlink queue GET APIs.
>>>>>
>>>>> Signed-off-by: Joe Damato <jdamato@fastly.com>

...

> 
> OK, well I tweaked the v3 I had queued  based on your feedback. I am
> definitiely not an mlx5 expert, so I have no idea if it's correct.
> 
> The changes can be summed up as:
>    - mlx5e_activate_channel and mlx5e_deactivate_channel to use
>      netif_queue_set_napi for each mlx5e_txqsq as it is
>      activated/deactivated. I assumed sq->txq_ix is the correct index, but I
>      have no idea.
>    - mlx5e_activate_qos_sq and mlx5e_deactivate_qos_sq to handle the QOS/HTB
>      case, similar to the above.
>    - IRQ storage removed
> 
> If you think that sounds vaguely correct, I can send the v3 tomorrow when
> it has been >24hrs as per Rahul's request.
> 

Sounds correct.
Please go on and send when it's time so we can review.


