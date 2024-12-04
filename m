Return-Path: <linux-rdma+bounces-6231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F109E3A67
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8468716595F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C01BE871;
	Wed,  4 Dec 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMeGr35B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8CC1B983E;
	Wed,  4 Dec 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316797; cv=none; b=IC0UE5stDpI+2q/po3d+nRdt0rN5Rs2ym6dInv9KGxQ2drGdlN1agx/XME2lhsOlwEIUaszINT+TNNsB9fZKkRqpV32KJgn6Fey2adoVq7L55C6DC7CIqNz+1W5/gTTlsdtbLtV0CJgrsflDJy/GvDha1zfhFfq8KIX3AdSRxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316797; c=relaxed/simple;
	bh=4KB7IhX41Jdx7R0pUSh4XrjrTpiCnCVaZJyu8gjdkpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dckPkZIHYlbXMI7ol2GJcLrLXt0LwGCfs1TqmmfUVz4r0QyT1RSMjzzqNdYcOvr61nb+KSyZZU7dmz0XqujkQWDaAe8EN/5DjJR5zn+WQN0TLAoSwBAETkbOIpJuAW3k5R5BAfh0+eivRwdV9xZSvgV5dgbD3eZk1ywjlNvmSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMeGr35B; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a742481aso55859685e9.3;
        Wed, 04 Dec 2024 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733316794; x=1733921594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2aCUMfq9PreWWxmmta62wgfEIacoacSv9wLVfG0EG4=;
        b=HMeGr35BHm4xrFK031+WpJUM/Tqqaj8cv23XNuTykB3/GHkgUgE7iHD2JE2Zclp547
         sFK6aGVnNcDcqiWEJh+Y9wtEEr1s4E+UCW32DXBRvn8vdr0pTSgPq9239WumoJAmTJHx
         OcMA1ZlarQLSlx9ThIugGidCDV5Dmp3F1Fc8QvWnM8PL4W3f11uvf0NJXNPtHCfQTXyu
         cykTDlrqLh4TgMIXNn9Ok0MfqyZlxVXPPRcYT5znR25ptSWP+A5CeHx8OcD9bwlQG4pl
         hMBfXBMe4MM4dRiZpoe2zPNXYrStsdxSfTyswW9uQ7hc3yexIleRyIXqhz8d+XS0qMPG
         LK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316794; x=1733921594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2aCUMfq9PreWWxmmta62wgfEIacoacSv9wLVfG0EG4=;
        b=iIvYRVxeLnr84KOeyEwX+6CgJ76bpAI61p9rU12TZAqHzV5CBJzWiANyNmjuEcUkSv
         Ieyl9o0HAEsjVc8ccgZN4X3m5kwwzRZ9CEMWqyVrAniMx0GWNCZToO3oswQEet0Ix9Aw
         qHSUq30vv/A3sp8DESsfe2E39umNGiatXHwAtOGdmEZdS0sTV05OHtOH/kWNpkhga0Bf
         wFck3JA1IZnPmUYxVmrz6Bkcy51v+dpFk+5cO5lsr2tSLXvpFoeaV9D4d5XoEGpFPlJ4
         zXzAqa8EyBJ2iRswvayT+YjJkzXhkuBYPOBOZ96tt2LT56hJ7A+ZmNJyRi1eJpxS/LkI
         vzIg==
X-Forwarded-Encrypted: i=1; AJvYcCVTp5hDxH7+sQ+w6H9kqwEhNzJxKRC7WcVcjhl+2qNyDQfHaVrUmXyze9MaD2SYASY3Bl3gZOaJY8V7jw==@vger.kernel.org, AJvYcCWK94TUoKFDyZsj4EXGd0NBBCtk3bFaV02dY48xXw+vAJTPnMU+XPoIqluoSxvX2HChjs+x634r@vger.kernel.org, AJvYcCWVdqwpSHiVTp6gE0AiHTUqJ+pRNJdEGTIZglZOmxvE0TtPG4ZELNN5lf9R8fBSWyjtSbOeOhLxQvotaS2q@vger.kernel.org, AJvYcCWfiSv3JCxJBgYpVMQ2PTJzvbnUEJ5Kno861G2QEOHKbaLdKidFwVio/8hHShqtH7IqxSvyOgBPhcnx/+Z34w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqUd1VakuPrdss3tV8JStSyKo+gOJcEYbl1He6sunJApPdqor
	A15xykJ7JLjyy8+2cHwSnxfIk4s2a0hS68mAt3I16e6yMazEu0wnN5TN0w==
X-Gm-Gg: ASbGncsJOtgRveQOBthWRlsci5MnFkl3aTIopIKWPOMnGRJQBNZryUpUmpOZNNiFagZ
	KxmXgwixKpPpJIHCzr1oc/GDt+cceGGSTUuX2m23UBPY0y74Jmr/M2Jqx+1Q2NDF2uY9/mWSzjr
	hZce1fzc4MLeFWIQKbcJk+fp1QFsNx2WyOGWz2EkzbO+BrWSrSH/NAtV8HQFbwr+4tIvJdhvom+
	3JXyhSpe0boS6sj+GXCezkoH2O0zsZVXU0rFHwIAD/eg8USic+gnIi4Tb7uxtEb3V604QI=
X-Google-Smtp-Source: AGHT+IEAjhyCi0OQTbfcNqIUsFj4yLHAHGPEiHTTUIeK2/a5ydVX5KehPnGynnnKDQWpIUjUjZeADQ==
X-Received: by 2002:a05:600c:3ba1:b0:434:9dfe:20e6 with SMTP id 5b1f17b1804b1-434d4102563mr30395095e9.23.1733316793815;
        Wed, 04 Dec 2024 04:53:13 -0800 (PST)
Received: from [172.27.34.104] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280b60sm23327285e9.25.2024.12.04.04.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:53:13 -0800 (PST)
Message-ID: <f334a5d0-3eb1-44ea-860d-b0a5235a973c@gmail.com>
Date: Wed, 4 Dec 2024 14:53:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net/mlx5: DR, prevent potential error pointer
 dereference
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/12/2024 14:06, Dan Carpenter wrote:
> The dr_domain_add_vport_cap() function generally returns NULL on error
> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> and if it's and -ENOMEM then the error pointer is propogated back and
> eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().
> 
> Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: fix typo in commit message
> v3: better style
> 
>   .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c  | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> index 3d74109f8230..49f22cad92bf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> @@ -297,7 +297,9 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
>   	if (ret) {
>   		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
>   		kvfree(vport_caps);
> -		return ERR_PTR(ret);
> +		if (ret == -EBUSY)
> +			return ERR_PTR(-EBUSY);
> +		return NULL;
>   	}
>   
>   	return vport_caps;

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

