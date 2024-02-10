Return-Path: <linux-rdma+bounces-995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB08502DC
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Feb 2024 08:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9001F23487
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Feb 2024 07:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E651F941;
	Sat, 10 Feb 2024 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+rwpQ/4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24408168C2;
	Sat, 10 Feb 2024 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548504; cv=none; b=nWxbOhTzuvBe4QJ2on59kUdMV5d78HOxizoRS7WhYverOW5VPUSnCG2uHmZk1gqvWpJEm8jEZDIMYSEjlpsizr2CH19P/L5p+YzGvC93QhsJG964K6ipaxjUEPQg4K3oF2EpwkrH7/55WTYq936tMrPEcAB9tgHeorcEEKZ5MqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548504; c=relaxed/simple;
	bh=WfY5Vzw4CdodMicZUT/TYjchs/KHi2LIld0VVzCzscg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw7SB0gKqXfWGrqB4prryDN9Rxp+Cjr/LvBGvb9rMHUETD9jWZln/Pruo9n8eJ1FNhjrvyyWBk6cMXUeBXd8LvkkQG49VEztV0yo7oLsV07yzvZyLQ1TgAtcQfWrL+jWpEz/j4E1rfYQdq8Leqs6nlYSxq2y4JxCEYA1n7aa4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+rwpQ/4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5116588189aso3025357e87.1;
        Fri, 09 Feb 2024 23:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707548501; x=1708153301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2rRnpKKAEWmGHWyo8ORuFqBigcaw88u6vUWJn5MN8M=;
        b=V+rwpQ/4nbxVw+wmqKUovEbOBovRtsDIznasZxCpWGEoYQfISzm9Y9MYfwlHgMOi4l
         BBVBtx2H6TgIRVEvs4s9dBbYJ9viqBE8u23e7CoKEBKIpzNBwVj9gtP3Nuk8ePlnPMn5
         t2fsfABsP6mCkjpIk2HphDjankSMg5z/ldF/MOIoFIKrjWt8H7R/zGI5AQ7XMCgUtxoo
         r7nzGXemSFDVi4MSFBWp47aNsoOohk5HLb6pTI+iS42syB61TpstOeUN/UzjYqUqPluX
         iVv0E1PDk7i2VKDRKqqbJzp0dCfEhhQ5oafCXLprPCXgnIF1dukJktQYg1eaomcq40Tz
         AAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548501; x=1708153301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2rRnpKKAEWmGHWyo8ORuFqBigcaw88u6vUWJn5MN8M=;
        b=FWJf9xNwYwP6fgzaoUH8dZQnG2idVh2KL/l+YdBNeoyF9qQSfuMQS3LpmWOj4DqCn1
         9Qjm9w0mljRjPvN7tkXdvFomDucaFU8d1xUGF1VUULiMD7cIyjTF5nvU5EZQSL6H8Iq/
         ofYl7sbpR+BoiBBz8Mi7w5labZxdKDQ6gNgn9MmyoWw3DHi46y651EK0BAiowfSs1EQE
         XxoFXoLyUG4GoEj7108M3p5FPQoGiPf/GOenepIAmbIs5yoUJfVh1xBz4oOtfgc1yi6j
         dDqGuPwgMx3thd/YwEK1arZH/t3WcCBgpsHU5S7+Pl5mytMwQlGZf635+gjvf0l7kz3c
         DRcA==
X-Gm-Message-State: AOJu0YxkJeZrWJym7IVGyl3V/a6RgkCb0g3kA5jGzXrPvNlPvkU2HS/l
	LhUe0NF0PMgEg6pZORtrxax4Y6ZTXUiBhroHmXqpFTQWi2KdjSdF
X-Google-Smtp-Source: AGHT+IF5phHdgXEfIgkRa9VA5nyY3E5KVe0PIYcirDcVOhjzcybaPuX8f5XlGld2ENqmBn6JqjJuwQ==
X-Received: by 2002:ac2:46f0:0:b0:511:49e1:6a2b with SMTP id q16-20020ac246f0000000b0051149e16a2bmr637786lfo.46.1707548500817;
        Fri, 09 Feb 2024 23:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3dWZkBya0644V9h/nmFIfhQIyrtq+ASo0tkvGmqXKVYlR2nRtXtacSVREXJhyZFGIVM7mnpFynmGFe7WwQXZboFTN0mJzTZG33Plzk99/CifWXfXBlyDGwzFp8Vo8lYbGHtJsln2iBNTLmDHnQbN2PTiV0vL8luv5AJ3fPZj0+HivA+TXFDd93qSLqL8lzET6Snwr0Lb5y2+gbsFHFfmwvOyikld+L0gvOEAJZU3fQlN7S574v2lRE9w+vAwrjVRRMstKgnSotSd+Ly3UmrKrCF0XJiSQjvSCFumlN6TqjEYPUxVCtXBIjP6yIP5M2nShgAv5Em+8SEJUH8cci2SmhruO0ngK5UolXwGXAECpTSc/M/davwY9ii3JgmDsmWm8/qR8J4w0g7j0QacC2WF8pp7Vdcn0P+1nFMJ/aQCuCVjfzH72/iI8VcUsLfcMeg==
Received: from [172.27.33.117] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x26-20020ac25dda000000b005101bbbfc2bsm153708lfq.263.2024.02.09.23.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:01:40 -0800 (PST)
Message-ID: <42e7e002-a583-42c7-a4a6-67320c625828@gmail.com>
Date: Sat, 10 Feb 2024 09:01:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net/mlx5e: link NAPI instances to queues and
 IRQs
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: tariqt@nvidia.com, rrameshbabu@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Gal Pressman <gal@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240209202312.30181-1-jdamato@fastly.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240209202312.30181-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/02/2024 22:23, Joe Damato wrote:
> Make mlx5 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
> v3 -> v4:
>    - Use sq->netdev and sq->cq.napi to get the netdev and NAPI structures in
>      mlx5e_activate_txqsq and mlx5e_deactivate_txqsq as requested by Tariq
>      Toukan [1]
>    - Only set or unset NETDEV_QUEUE_TYPE_RX when the MLX5E_PTP_STATE_RX bit
>      is on in mlx5e_ptp_activate_channel and mlx5e_ptp_deactivate_channel as
>      requested by Rahul Rameshbabu [2]
> 
> v2 -> v3:
>    - Fix commit message subject
>    - call netif_queue_set_napi in mlx5e_ptp_activate_channel and
>      mlx5e_ptp_deactivate_channel to enable/disable NETDEV_QUEUE_TYPE_RX for
>      the PTP channel.
>    - Modify mlx5e_activate_txqsq and mlx5e_deactivate_txqsq to set
>      NETDEV_QUEUE_TYPE_TX which should take care of all TX queues including
>      QoS/HTB and PTP.
>    - Rearrange mlx5e_activate_channel and mlx5e_deactivate_channel for
>      better ordering when setting and unsetting NETDEV_QUEUE_TYPE_RX NAPI
>      structs
> 
> v1 -> v2:
>    - Move netlink NULL code to mlx5e_deactivate_channel
>    - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
>      irq, after netif_napi_add which itself sets the IRQ to -1
> 
> [1]: https://lore.kernel.org/all/8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com/
> [2]: https://lore.kernel.org/all/871q9mz1a0.fsf@nvidia.com/
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 5 ++++-
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks for your patch.

