Return-Path: <linux-rdma+bounces-15487-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B10D16C01
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 06:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFCF303092E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EBE3570BD;
	Tue, 13 Jan 2026 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUhY7zAC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1036402C
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283606; cv=none; b=mmq9OA1WhSvt1VZSf7F9v/YEm3b4tY7rXJzADw2RQTo3w2WsnrqTz6pNZDeCaniunWZazJtUTd+E7ZnFRPaCIi+sU3x1FYI2lAgW/0FJrAAoFWS4gFmaOnJR92LCBgTrOl+iITq0MojeVgvjmQSfDhvBN3yok8IYrG1m6QO7wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283606; c=relaxed/simple;
	bh=19vdQo6pYfLOqyUW2a2rZf9ayU9mlx5fbadNgHNsOsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgaoCq735cJTlSmDocJBs6vZg6s91xoayejziepboPzAVkYXCp3gGVCRO3FKDiZIcCWsvdUk7mEwWxBkG7XTr3ZABzTULhcIjTJR1o9UKn+52xtBK3zi2BOkCAOFuXXF+gw+NUCb+CQ09LpFXAuUbRBydanVXZcFzlGuZAs2+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUhY7zAC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305914so5077463f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 21:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768283601; x=1768888401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88pm3P6g81XtGnprrTXJfTCXXLwIxJufnowFgUK1NPI=;
        b=CUhY7zACyQqSbtyWkASj38wKtk3Qx+ufSfDyWRcAFPP2aoXqPpf7mPmDlv3/ym436L
         CPEGfO7jpYDy/IXrLBWiQkXujXCK6jlKBzHQu1Bd1/Plvq+RLTWwHU5McINusb9vkn1d
         PLTBDM747TQKhWS8Q95+HLxaJoY1yBf2I7gfRQiUQsf8kGbJoFvdF1bQbsn4tT8UL/mU
         BsWt50uqTYWGmuWmDoIrAXjeMQv1V/DLn4dLe+ft6x9zT/2AGO+pGLcvjcNVgaihGzGd
         fU+/lZbrYsb92JBBf9KywTexTU4CbO91CmMmSY3Re0SFWPA/Z9yYTza5wnW4auYK8/vM
         cZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768283601; x=1768888401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88pm3P6g81XtGnprrTXJfTCXXLwIxJufnowFgUK1NPI=;
        b=smDn1auxtbm3g9PhZG1GtZ477BEykRQBEkPTExU7Xy+Y3kPg7xbhdCxc+oThC9lxjL
         S+XBA0JM0lJdzu89CTrQIfFUGQGjtIYzvopEBcshzBg/LFyfhEvNfRdAGLD9cZJJFCoq
         2ccsjh4BUZmV3Ef5Tf58gwhtQ/Ui5zUjvqeuqGuLaiXx4jYwv9UIYySGj9Dlt7d9e5lY
         /T/0W5OhLbQ56pW37a0S7U5Hiw1klvn5jXrejLSeBwktAtZQIpVG5/k3u7jDWVH6qSjL
         Bv0wdk/8ZkbHP5ZWVdgSorMPUP7lYxBHJrXltISg0TfUzwfAuO8ajUJ/AcvFG70LmM6Q
         JLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIbCUBJCBa99qrkX1fb+u9NEMJcBdS/TcsyUytm5kWW/VyxTeXMNvZ5PR7IM3KBgGJ/f7FlkahoGJC@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfyexTPsz+2uEXv3kDXxp/e4bz3056BalSxbZ7ohWN3sHeT2R
	ALgnLTeqycNNPSKMWsB8rCbucP51fQ15MSkVjo0KpSpQCrh45u1/KJVF
X-Gm-Gg: AY/fxX5E5hAdB7pbjGde/PIvQCORrtUUQlBjzlPWbVqSZf4YdCSR8IR+v0nVDnAWuqm
	/WsdvGRlf5D+gdijF9whC/Dh76inzCIy1WSYe/6mgqwqeArlN+JLCx0ov0rZQx7UAgTmInAkJSA
	z/dgjnOIV2aF0BrKnrtMdu/lZdIyDLT90coVzZZ1E0l37Ny/75zyIbsTCrT01nHJCrB1zaYLfTi
	xIMY66UAP3KOuSy5cezHczcBlHz7V60ctxwzfHInshb1UmHo3SEEJbMJsjNbIloaNvfZCiaBhGn
	re2OZljZQX7SMKYaa8Hc1enm2qVfkOy316ZkWBAcd1mXe4I+1ZnIarwm3f3dLCMsT5dGftwrBMJ
	HY5B83V1nBKGqmx309SqwwnPIG0rWMyjenl2WTzDTDxpdwd7YZDmIrSRUlda1ugsWeq6dMA1DNi
	2IsmJ5TYa07Psh4IZw1AIVXlgKoOL4Thzh3XbGt1Mbr3c8TQ==
X-Google-Smtp-Source: AGHT+IF68TWf4Pq2Z9GvExTY2L9ytnAtr4ik5TJl9gx8maZgQ9A4SM9KuPGxVZgVMoqKVWvHWhCqpQ==
X-Received: by 2002:a05:6000:4387:b0:42c:b8fd:21b3 with SMTP id ffacd0b85a97d-432c37a756bmr26203367f8f.57.1768283601377;
        Mon, 12 Jan 2026 21:53:21 -0800 (PST)
Received: from [10.221.200.118] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dfa6dc4esm20377651f8f.23.2026.01.12.21.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 21:53:21 -0800 (PST)
Message-ID: <9c8a5d43-2c1e-4a3b-8708-c92a11ad56ff@gmail.com>
Date: Tue, 13 Jan 2026 07:53:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
To: Zeng Chi <zeng_chi911@163.com>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn
References: <20260109090650.1734268-1-zeng_chi911@163.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260109090650.1734268-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/01/2026 11:06, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 

Thanks for your patch.

Please specify target branch.

> The function mlx5_esw_vport_vhca_id() is declared to return bool,
> but returns -EOPNOTSUPP (-45), which is an int error code. This
> causes a signedness bug as reported by smatch.
> 
> This patch fixes this smatch report:
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
> warn: signedness bug returning '(-45)'
> 

Missing Fixes tag.

> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index ad1073f7b79f..e7fe43799b23 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -1009,7 +1009,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
>   static inline bool
>   mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>   {
> -	return -EOPNOTSUPP;
> +	return false;
>   }
>   
>   #endif /* CONFIG_MLX5_ESWITCH */


Regards,
Tariq

