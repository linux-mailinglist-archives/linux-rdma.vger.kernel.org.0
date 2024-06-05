Return-Path: <linux-rdma+bounces-2870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B543E8FC2ED
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 07:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5060B242A0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 05:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBAE13AD04;
	Wed,  5 Jun 2024 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/KTrWJs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3B433A9;
	Wed,  5 Jun 2024 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564458; cv=none; b=OgUx/GmpWqamD9xnU9ZLi2LtBV1TPp1LhGJBtzNMycRhu+p88eN4kCk9Ga8dcNNbD2zZX5wf7QWHgU+cXBpSw6coGGDznf5eyxZETLab24mCv72DUhlPA5rjeBRHIhbt3ciwj0G3z9T4msVedGzPycXWUWS1YD5vrsOf+42jvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564458; c=relaxed/simple;
	bh=4CSeCQRBrK7B/rF7JMLZrY1jem8f+EQ5gVQE8NBY2v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9MKYPcVLk2QUt6c1YVAFNzhLPY3w7geWzX1bM30nTr8q9p3swPXOwa/4UArFyl3GRDa18b38GGECr8e8+9edlUa8HKC+ZJFgQn95iLiUcWyzrTqTMXBo5bEjWWARjnD7FYPk6v3hqsA3Pi4HbMWuY0/2aJeWV9qpn4EL9jUYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/KTrWJs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4212a3e82b6so2522065e9.0;
        Tue, 04 Jun 2024 22:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717564455; x=1718169255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hz2bHZtX3f+zFyCE0m3xAZ11MmegeTVU6m8LqM4mjuU=;
        b=k/KTrWJsYMBPGvi47CC89dqT+CK5Ts605Icb2iM92mUBjZFovHJ2d6VAkvLpkDjzRq
         5e5S5ljc1TcdySTuPJdMuHXGH0JXr+5YCqeLmNwp/IHmTuYFSrZ2cXGikwTnedzH+bRp
         A9+KcQcZdqn3ouc9Jm8YJAKH6qa0PXLoXgO87NoPat/nhUBp2T9Votf4ZHZ+QU+aDMpl
         mx1SX02wC6xr5lgijnJOXOG2froC+s4kfZkLobcuxoQeYmlIOYtNWgTiasF8eZ3+/vMU
         OZPQblJ0rytEZ1aMM61UU8a6V7UZeRuoIOaG3Pq9UQTyT1+RzFTTfRmGQTfTTuCHweUv
         fUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717564455; x=1718169255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz2bHZtX3f+zFyCE0m3xAZ11MmegeTVU6m8LqM4mjuU=;
        b=XH9JimD829F8s+UX70CDqswXfnyQRaPWsYEgsvFvlUNcyW6TUEhVsp5lK2ySqBd9PJ
         KOdadYvKBHUkdwvmW/6/jX03LyW+nCL0G58VmilsuR1My/Q+ToC2M9R3JVxtEqw0jEmQ
         Wc2BE6KczqA/8ruOD5PJnxOVa3qNlJpnAdGF34QqabCLip6QpnssXeRdkPP85joGpDwe
         3+t0FvyqsNsRf0Te5f1d8i6P2YCGZKFvzOSs1MxVM6JqlJf4803CWqg4Z54WwBVtDygs
         XPEoU3gzifbOeg61XDlQ81Ou8r3GFhuhO+KBxDMgqgOhbtHKFqNKvN07CFl4lTTuwT55
         GLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqWfgHJZTGF5UVAd3m1NECoFsqd+vK76oFfSU7JHto5z3eCAp2Ce2S9dBaK/0TiM0my/zJB/sil/29UHdGu7hDoWcR46Bg5f9X7xXgz7PeC9Mu3cpraZtaZ5Ja2Hyss/QkKRKglEUHRRREjGasl75iv2v7ErJ7r6N01viIDg5Tpw==
X-Gm-Message-State: AOJu0Yze0ps2ynqHX5BKxt7qWxSlN4J9SOIDCK1Pmr0Wv3F/ngN+TEaV
	Tu8J7xjz4cs8mJGgcN5CH7C3L4och+JzvT3JfFAngxitx4fTRWgH
X-Google-Smtp-Source: AGHT+IHxCBFRWasWWhYTD9MCCOZ7NuRVX5iIe+NDiyW/MQwV1vA0+XY6Zld1lSRWZ6y6e5TolnfuMg==
X-Received: by 2002:a05:600c:1d06:b0:421:56f2:957c with SMTP id 5b1f17b1804b1-42156f29970mr7935725e9.20.1717564454791;
        Tue, 04 Jun 2024 22:14:14 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158132f0fsm6900855e9.29.2024.06.04.22.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 22:14:14 -0700 (PDT)
Message-ID: <4e7a80f7-d650-4deb-b331-b9de7951cfa1@gmail.com>
Date: Wed, 5 Jun 2024 08:14:10 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix tainted pointer delete is case of flow
 rules creation fail
To: Aleksandr Mishin <amishin@t-argos.ru>, Mark Bloch <mbloch@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Shay Drory <shayd@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240604100552.25201-1-amishin@t-argos.ru>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240604100552.25201-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/06/2024 13:05, Aleksandr Mishin wrote:
> In case of flow rule creation fail in mlx5_lag_create_port_sel_table(),
> instead of previously created rules, the tainted pointer is deleted
> deveral times.
> Fix this bug by using correct flow rules pointers.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 352899f384d4 ("net/mlx5: Lag, use buckets in hash mode")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> index c16b462ddedf..ab2717012b79 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> @@ -88,9 +88,13 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
>   								      &dest, 1);
>   			if (IS_ERR(lag_definer->rules[idx])) {
>   				err = PTR_ERR(lag_definer->rules[idx]);
> -				while (i--)
> -					while (j--)
> +				do {
> +					while (j--) {
> +						idx = i * ldev->buckets + j;
>   						mlx5_del_flow_rules(lag_definer->rules[idx]);
> +					}
> +					j = ldev->buckets;
> +				} while (i--);
>   				goto destroy_fg;
>   			}
>   		}

Reviewed-by: Tariq Toukan <tariqt@nvidia.com> 
 
 


Thanks.

