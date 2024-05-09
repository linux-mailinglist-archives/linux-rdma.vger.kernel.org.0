Return-Path: <linux-rdma+bounces-2370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F58C0DA9
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 11:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCCB28379C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9F14A633;
	Thu,  9 May 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/f/Bj14"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6F14A607;
	Thu,  9 May 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247737; cv=none; b=FRlxHUV7Vg5fdbr6UMUUuWI5SLH/0f9g12P7HPFu3RMIJZPk0R6ocQN6kHgLWT0G6AuwlCUuxvcWSaHx7ROQDH/3rEev5zylOMFKNx+9vnahSk0ZRJcdGPJUuESB7VFIfMaVUQe1Wgb1x9mvBQCbV906Y3gcZix1KR02ikc8R3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247737; c=relaxed/simple;
	bh=vbUuMsQkpj5urNgjzxVGrL4w3lmYyfQUVbCuhNO8W8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2eZgKAuGFl8z0cfPJcBZxUoJ8e3vqAwsL8BHy+BDa/ns8ckl8ewJQtUOI9945cK1hyaIhTtTtT3MqAY057BBSWUEo0VinTaL5U6hInCpJjoz6t9JAleNXAIR4/EZcCubJQstJ3diDWD+Wx2oxIz0tIRn1qYRM5mmKyLbDl5pFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/f/Bj14; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41adf155cffso5187905e9.2;
        Thu, 09 May 2024 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715247734; x=1715852534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z06VK901YT4AA0mu0lKiHWnHF+lrDbqE9NkpBOX5zS0=;
        b=g/f/Bj14qKl7veT8RA0Gwp4h3ex/SaY4sebWVwjUWmH+MU0mOjb7fNHJBCLvpW/CS0
         +pBB+5lbIZ6w8e6M23pgTc3cKxx8WpZnLY+nd3+3ct13jTEjAEsp8/BOXrXXmvF0+1gb
         p4EcxtwCKB3NCVLYAFLR/TqKhWkpRvhN/xULEGK58eNPD1/ckNXpp6L1EQ9am0sykFQk
         9utkymvNQyJNKv7+r5xtkIrkuqf/HOBxHh/z3sPfcylHUEzJ9+8FpYeiWNqk7MPRRcWC
         BrKDlwZwWrDNrZAgSw4lqB/d/GkbB6VJD5PmlVdR7i6012xoNZ/2q7RAgUC5pGUzb18z
         5dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715247734; x=1715852534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z06VK901YT4AA0mu0lKiHWnHF+lrDbqE9NkpBOX5zS0=;
        b=NUXKWVL5cIGisaBcvYPQv2mZni+x8l45nKH59YDh+U8WdnvdIZ2PcDDx4Qe00KHvYD
         4Nu2jMLxj2WusJh6XmOGz5xnVKD0lE4d7TNXR6yDfr4sz9bwwh8N/sH/4s+WwIwn7yuB
         pXS863AAMi2EKERxnXyU5RJWpQFF5DN0rRI1LnEH0kE+u/1AjgFt4CR4daDLvIGny29x
         eIBeYN/6hE5j0YactTerj0evIpa+e3RsLPiH7R3AqUJm8E4vEJZ3y34Bvq1SIrDmcgMJ
         EEEl+T6ZmBjuRGELBNyOphKQ/WAmsruY0UYJFHE6axK5eYtur4suHPuV70qVO2D81wgY
         xBVA==
X-Forwarded-Encrypted: i=1; AJvYcCUqnMDWfUxDH9BPQnBUsMRZ0VpfZ3KApV5I70qaxWKN6dfBmL5COhzt6FN+PNJCBFItq9OBXs9+mGaE8yfirsX5N8U5T4kwIZbO6096WOvlSH668lpaYyTRb7Vg+yaxnvSXaGfq1u41e1YlgVpDmKd4fkgzA1ybv08gQrRLNdL30w==
X-Gm-Message-State: AOJu0YzmV42zMQKubAPsAfJkWmt2movN/wayjYpfCbPf4yf3e1raj2LV
	t8xlXHukV+WD1f/u5KUFiqZCMFvPGqY6YTON8DPNoZN7C6URja+z
X-Google-Smtp-Source: AGHT+IE54IK54ssMqput+/vf82wzC7v7aJy4IidT5pFMs/25AkJ6OlBZMh8Gl07P8/wcI7CPoGq3vw==
X-Received: by 2002:a05:600c:1c12:b0:41b:f359:2b53 with SMTP id 5b1f17b1804b1-41f723a2496mr43829985e9.37.1715247733672;
        Thu, 09 May 2024 02:42:13 -0700 (PDT)
Received: from [172.27.51.192] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25d5sm19179325e9.14.2024.05.09.02.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 02:42:13 -0700 (PDT)
Message-ID: <05317efb-14e9-433b-b0b6-657a98500efd@gmail.com>
Date: Thu, 9 May 2024 12:42:11 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
To: Joe Damato <jdamato@fastly.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Leon Romanovsky <leon@kernel.org>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
 <ZjUwT_1SA9tF952c@LQ3V64L9R2> <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2> <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

..

>> The off-channels queues (like PTP) do not exist in default. So they are out
>> of the game unless you explicitly enables them.
> 
> I did not enable them, but if you saw the thread, it sounds like Jakub's
> preference is that in the v2 I include the PTP stats in get_base_stats.
> 
> Are you OK with that?

Sounds good.

> Are there other queue stats I should include as well?
> 

The QOS/HTB queues.
See mlx5e_stats_grp_sw_update_stats_qos.

>> A possible reason for this difference is the queues included in the sum.
>> Our stats are persistent across configuration changes, so they doesn't reset
>> when number of channels changes for example.
>>
>> We keep stats entries for al ring indices that ever existed. Our driver
>> loops and sums up the stats for all of them, while the stack loops only up
>> to the current netdev->real_num_rx_queues.
>>
>> Can this explain the diff here?
> 
> Yes, that was it. Sorry I didn't realize this case. My lab machine runs a
> script to adjust the queue count shortly after booting.
> 
> I disabled that and re-ran:
> 
>    NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
> 
> and all tests pass.
> 

Great!

