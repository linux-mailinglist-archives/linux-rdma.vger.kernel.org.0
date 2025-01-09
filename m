Return-Path: <linux-rdma+bounces-6926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC953A0774A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 14:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637CB1889F43
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6D218821;
	Thu,  9 Jan 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFV6bUwA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1742040BF;
	Thu,  9 Jan 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429142; cv=none; b=R02Z2SDfMhErPn7zFTLAEWmAt0cYokLBsZiI+ox4xoLy+lYb8ne0rthIvMpgeoew083Qo31ysAnIOdc98DQ0OrBHsfR2k5LB6SzpHJ7U6xCc6Pr0Dd0TvjfT9EDZ/+wos7pvdr3vgFDhOQ52MQW9ppProBryHuJ1XtrqDlRI+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429142; c=relaxed/simple;
	bh=WcauYQ2v+oJmfWJOp7J0Cb4eGrakgWLWi6inDubS2c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmudX4jIXA1rLiXuQt/wGFdtUaorHshaWxRZbj698c1sq9/arXxCpwDRNP1cgGpcdXMVX2BBznMRAAN9WtkwBsjwJvrAsyEv8Daswes+l2CONfiWJc1x80/4wq+RAdKGW8GMOMrRgyt662k8K4KtupDXfDyxffP4Q9s0OHNuPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFV6bUwA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so1032791a12.1;
        Thu, 09 Jan 2025 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736429139; x=1737033939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/Cgnni2PUqE4r71m306iwfF9nt2mHGGQjSDjTdkLvQ=;
        b=eFV6bUwADQbOxTsQKPnDGwKBhEoR75GYijWNro0G241dCR2rJqpPaObS5bsdUexDKF
         OCs6MSaHnWfzoHM2E3WBE/BOiyJ/Oz3H/Cw9M3BNR9gAsdlO5MiEv9XdAiHtaFYHgicH
         ++ex+6zsfVhGjdOAhoXgHuGO2lBgAZTDT0avFciYm6rqS/62D8tULX/MNOyoBbPrif0+
         Vb/iJ2U9rI/eLphAUtvcF/CTzHlsFMSzh9fyTpvCnCwPkkStij+D1swKKIQas0R/fBRu
         KlmPlsZ2wsvDYrG/wEo/IaxJPICeof58TEmAFSx5ROth4Y8pns/Ow1RV9wDHMdF7sz78
         5MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736429139; x=1737033939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/Cgnni2PUqE4r71m306iwfF9nt2mHGGQjSDjTdkLvQ=;
        b=BM7U4ei2HlL+WAcDIIWrtKAuHDfWjw/NfVPAYSXsyw8qo6xEHR+JP9jRVaKh33RnQM
         OlOEDPXwvVnfyrCTqW+LlxIR2uXLQtpwP83yUbhRi8z8IHW5fwAZL/a5hATPMRJhJoFC
         uPRQGwVT8FGaage7tppoAhV1fsZ6v/gSMdllbVgwBzdyVIVHtNTn+GlfUKFVhLpnAUbr
         50xLWHyp87peDSXdOGts7u+1EsrmF2OMhulma7iA2uVHu+dq+vijDdFt4/Z312XWKix5
         eUX1yycab3IXP6X4grmNQ50w9YHwrPio4UXExmGBsQDHos1ck0PI3lR874/8oB8yDVHQ
         V2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCsK/T2oM6gRpZUURBEHalMgKkjmc1MUyNHJW+cebC3XK/70Vk9adWKaUB3T7WVb1W5Bf9fnh/HM2K@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoev69KWRtZCDGcHrRAgo19GEm8PwKXaP59T8mBj8l13DRoqTJ
	Gt2t7rkXyGaYCiaT6UWDkHokUSmS7EO6BpftLG+T5+YMP4bwkjuKaPZ8Kw==
X-Gm-Gg: ASbGncudIsVjhLRBBgAViP3O6b9ZI9cDf6P5O7Qh3wtCo5bKfgMHhBQ3+qxtQ5dD8Ts
	SLUR35Ke/dDLBFPdAZE7IRFs5CUmWAZHOityThcGkH8ur/Zbgui+uItKi/svLjHBLV3lVWMzK2Z
	t/2fVOCbiefDNKgenBBsX4Q8t4ZEshNWTOoXF2KQ0MuR9O/BLb+20VNlYk3KjapWW3bZXTsr+Zs
	tQGwIm+kOTkB/wIk0iDz7+4kpxwc61XOXXiuaiozKpc5Nq6Pdqc9midzsMRZ8XU8EhcbO9u8EbR
	sg==
X-Google-Smtp-Source: AGHT+IHvw83dREGTSGGLHglwCRhN0H1ptiO+KIVjWD+3DR+Gz0KbzI4XRCU3DMpjiuXNUnxc8iRh1Q==
X-Received: by 2002:a05:6402:2550:b0:5d3:bc03:cb7a with SMTP id 4fb4d7f45d1cf-5d972e4c9b2mr6556582a12.27.1736429138543;
        Thu, 09 Jan 2025 05:25:38 -0800 (PST)
Received: from [172.27.58.138] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c523sm611334a12.8.2025.01.09.05.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:25:38 -0800 (PST)
Message-ID: <f6e79987-a48e-4546-b55e-ec95f7f0befe@gmail.com>
Date: Thu, 9 Jan 2025 15:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: Fix variable not being completed when
 function returns
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Moshe Shemesh <moshe@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250108030009.68520-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250108030009.68520-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2025 5:00, Chenguang Zhao wrote:
>      The cmd_work_handler function returns from the child function
>      cmd_alloc_index because the allocate command entry fails,
>      Before returning, there is no complete ent->slotted.
> 
>      The patch fixes it.
> 

Unnecessary indentation.

>       mlx5_core 0000:01:00.0: cmd_work_handler:877:(pid 3880418): failed to allocate command entry
>       INFO: task kworker/13:2:4055883 blocked for more than 120 seconds.
>             Not tainted 4.19.90-25.44.v2101.ky10.aarch64 #1
>       "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>       kworker/13:2    D    0 4055883      2 0x00000228
>       Workqueue: events mlx5e_tx_dim_work [mlx5_core]
>       Call trace:
>        __switch_to+0xe8/0x150
>        __schedule+0x2a8/0x9b8
>        schedule+0x2c/0x88
>        schedule_timeout+0x204/0x478
>        wait_for_common+0x154/0x250
>        wait_for_completion+0x28/0x38
>        cmd_exec+0x7a0/0xa00 [mlx5_core]
>        mlx5_cmd_exec+0x54/0x80 [mlx5_core]
>        mlx5_core_modify_cq+0x6c/0x80 [mlx5_core]
>        mlx5_core_modify_cq_moderation+0xa0/0xb8 [mlx5_core]
>        mlx5e_tx_dim_work+0x54/0x68 [mlx5_core]
>        process_one_work+0x1b0/0x448
>        worker_thread+0x54/0x468
>        kthread+0x134/0x138
>        ret_from_fork+0x10/0x18
> 
>      Fixes: 485d65e13571 ("net/mlx5: Add a timeout to acquire the command queue semaphore")

Also for the Fixes tag.

Other than that:
Acked-by: Tariq Toukan <tariqt@nvidia.com>


> 
> Signed-off-by: Chenguang Zhao zhaochenguang@kylinos.cn
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> ---
> v2:
> 	add Fixes tag and Reviewed-by
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index 6bd8a18e3af3..e733b81e18a2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -1013,6 +1013,7 @@ static void cmd_work_handler(struct work_struct *work)
>   				complete(&ent->done);
>   			}
>   			up(&cmd->vars.sem);
> +			complete(&ent->slotted);
>   			return;
>   		}
>   	} else {


