Return-Path: <linux-rdma+bounces-10514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6BAC0440
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 07:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE78A4E24FE
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37171C3BF1;
	Thu, 22 May 2025 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVs4ryAz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60411ADC8D;
	Thu, 22 May 2025 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893082; cv=none; b=UMsD0Im9TZrBQe11dsBDrhIknVn4o4fkxwg87tH+BF7D3Af71qa1/rKOBFQFXxLOXafOcz+R/RgvN/XFg+ymqMvGVDYsZpJLH0kd3dQ/j9w1aveeWJzsqmbylamyaRahxgH8Y63iyEuJW5uWMqvLLTT64dHBBHxbMFPVJ5RdDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893082; c=relaxed/simple;
	bh=Qk3Cj6CjpTeR1BLwEsG6FyzR/LoZ8ntda/gWEYFIi3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJMBDbEHHKedu8HRd/oqBvArFDeaM9fVXSmKY+Bca74R88b+akpjtvXpZc9ZfjOdef8xW6LBWS4zonxELFIMUZ1hEcp+a70KPWJXa21h4vCpyJNiXwnspdKBU9OM38sNZzVQrmF+svjOqrBgery1qHN3PIQBj101voR4FnbwVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVs4ryAz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so62663865e9.1;
        Wed, 21 May 2025 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747893079; x=1748497879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFkH/rgOWDPIhpLW46/ZrUMu9US2LAcRye9M5MU5gzo=;
        b=hVs4ryAztzVow+oUckIFV/qUoOzIuJM+YERFPtOWMrqyHOUH3seB3m1Kn9ubE5LQVH
         DxdKijmmh9Y8XXpzvLOIGxDRWBUD/2C8mty84UgrKlBXty9OwDIMWD8sPztbD8ZBo3Pm
         CUX/sxMRWkfe7PR9UHH5fMY4/l8p3UxRE6x15z/eEmMzcXTjY+z53/a+ILRqustUgzy6
         gK256YhFWFHEVA28heeae7AGB3g094bCwksfi1ldgwpX9H9sYdlevSc1cfXvlgCesi/c
         dfhaj1jg76T0uBr7o43NO/lQmETH50O7BTIXNUsb5HrLwQjLCptTR/JKwd2l7Tjn4n5s
         BBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747893079; x=1748497879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFkH/rgOWDPIhpLW46/ZrUMu9US2LAcRye9M5MU5gzo=;
        b=mvRbkhkgPT9VazfKLz23nqF+7o3zsq+AiaVhbpdo2vpexk238pB6qOnfTlnT3mua6R
         CD2F1MKW6swVcL79jWIVon+jkjNrnRrKXibMzv8OjYJfMWo25KQMDXfg1TXwettHo27e
         whm+XjF8fSNsDBD3vx54d5XqeicGd0HHJ0EKt0h+p77qlFKfDthckkZvLK2/g8sG2oba
         b7OUPUwGKX583vY6KU/LRVihUUeQPf7s9vRrwKxgSAeu7MJthNFE+epl9a/9sngOOvNZ
         53ni8vAzpGURIq6dnHm+SxDPRs6y/865B0RfCjIK7vkTVvzusvcJPCENlKkv1xOFYBDU
         nBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQk3IiOqLBgylx40FRPNJsKmVwIrywukC3SiDjirgpx2qI8NiUvlG3ys6YhQZyHCarjxoJ6MS1XQLwYg==@vger.kernel.org, AJvYcCWVBkaBGvPut1HZsKEbfOWSN2Wb07VthYuMPm6cLTTZB5/0cpjUgeUjsvaUSUOBVhrB21hESRS4Sbg+5IM=@vger.kernel.org, AJvYcCX6juvNnVlCvPTYwMMBzB5hHK+tmrvkwa8sBh5xfg6NH9GLdjVPzuxE2DuK/Q2SnK4Tpcdk2z7r@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQlsLOnsg/dO9Glh8FXdSt8mdHsMyInRbtdQkf622Yle8vo9i
	4oa5C7ON7RCO9O/7fTDrpIuxcOpZnertsv04uyGK45OnbSnAw2f63le9
X-Gm-Gg: ASbGnctZ9J2ODXKOdkeMhsOWOqbXkdUUO+OGksloItNNsuHsiX/8+XusH/Y3yZaOCBW
	scS2a7Dz8DCDWEKZN8NFgnLN8Pe3bsfWD978QZtzv/qadS3ZBDCwrIcodG2fpCHFOCBkVB0iPab
	bj2mAz5O+97uwASF8ffz6KdJL1wsabOhIAQPV3xVmf6rVOHSAR7Ra0wCwQhWg/PLlzt0Y4nAvAF
	vktkRtXoI9diCGmUPOprjCFhatK0qc0PDJ+2PTRDcw+G/dX1okrouK1wW4X4jCYvhjSEzIIS5iW
	qp3yX1A+TczpKZ0mykDh/uM22agPcEvnnsIUbThEBVqIVbZDU8kYFy2GJAOv61B3uuRR6fzQ
X-Google-Smtp-Source: AGHT+IHKIbmkS6l4fFZZXIBbRHnh8Bt5u7zbUY+LWiOyC6l6/kWioi4tFG8o3ruNOBmuPO8dnPkbHw==
X-Received: by 2002:a05:600c:3e0e:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-442fd60a57cmr227327665e9.7.1747893078670;
        Wed, 21 May 2025 22:51:18 -0700 (PDT)
Received: from [172.27.21.230] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f05581sm91601715e9.13.2025.05.21.22.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 22:51:18 -0700 (PDT)
Message-ID: <5f09fbd0-819a-42df-abf5-02e1286ce2a5@gmail.com>
Date: Thu, 22 May 2025 08:51:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5_core: Add error handling
 inmlx5_query_nic_vport_qkey_viol_cntr()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250521133620.912-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250521133620.912-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2025 16:36, Wentao Liang wrote:
> The function mlx5_query_nic_vport_qkey_viol_cntr() calls the function
> mlx5_query_nic_vport_context() but does not check its return value. This
> could lead to undefined behavior if the query fails. A proper
> implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Target: net
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v3: Explicitly mention target branch. Change improper code.
> v2: Remove redundant reassignment. Fix RCT.
> 
>   drivers/net/ethernet/mellanox/mlx5/core/vport.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index 66e44905c1f0..e4b86633d2fe 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -522,19 +522,22 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
>   {
>   	u32 *out;
>   	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
> +	int err;
>   
>   	out = kvzalloc(outlen, GFP_KERNEL);
>   	if (!out)
>   		return -ENOMEM;
>   
> -	mlx5_query_nic_vport_context(mdev, 0, out);
> +	err = mlx5_query_nic_vport_context(mdev, 0, out);
> +	if (err)
> +		goto out;
>   
>   	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
>   				   nic_vport_context.qkey_violation_counter);
> -
> +out:
>   	kvfree(out);
>   
> -	return 0;
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_qkey_viol_cntr);
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

