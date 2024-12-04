Return-Path: <linux-rdma+bounces-6228-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D59E39CB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 13:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A52B2A02A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455D1B393A;
	Wed,  4 Dec 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgmI0N14"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284941AE863;
	Wed,  4 Dec 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312546; cv=none; b=GCTByFqlPt5BiI7X+d6FDYjhQJ6xPEBjEFvQLMSVB8vZjFP96oT+heXhBMmSVUyTp3nmFD+tT5X7mw35K4gAWsubWFudpsyOV7mwhvf+GDn0rDI2dHxPxrlub+lFHxc9YC4LyaPxpJSuSe9U6UI8KcZckm1RcieK4vRTjfOyTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312546; c=relaxed/simple;
	bh=JfGLt86JfMp+l2oMWcRQN9UvEP1p3aKLpmiuThKuOCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5paqEuaDSt/0SBaKkFyyNaVYDdfX8bVz78Vy6rfDmtbOQ/7140scslB3oJNLdJRVGXqk6Gk5kvkMRJFI/SeqISlNixwB2z7okLPLC4GWze15Lw+JJJlVod8LTOIi2Q4MDUxwab/bupGTX1Mw4pCDZWb2SKco5qlcTpv2pIPAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgmI0N14; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382610c7116so4440746f8f.0;
        Wed, 04 Dec 2024 03:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733312543; x=1733917343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UA0b79SK+4P39kH716wuDD02mSgK0ycMPPEkZWb8AU=;
        b=mgmI0N146rKYkGxUhPJA6q96tNsExqDyueZzA2Ysve7PViwDLInYubENH2DdPl06Ld
         8GfLCgCf/Az40iXJOBPBNeFQoecnxPeRH9agq4jIdygNQ+xaaY1gUFIpvivxsIOSiPMF
         0G2n3BPP01xF7Jc4upJ/hgZPMxp6PoOW0kjagvV4PxzGFzo8JvF+vcfZ72eW7Zanao8l
         xkP1I1owM7B48cPIlDXwRdSL9aQThcj6zbqfqZNpovEk0+5xHytgD4qYeytdNbzH8MOs
         U7Qryfb5dCiymelSDp4ObQZbX1BKfBcjIKFGpkLW2SmdaWhj6Tlexzt4/CBjPiT/6ZDO
         ufug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733312543; x=1733917343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UA0b79SK+4P39kH716wuDD02mSgK0ycMPPEkZWb8AU=;
        b=uLD5ZRz7+nSAt/xntsi+ivSCjhhsR6LA23BuUftgWdJxbQMgRt11egpJeuxfv0dK2Z
         YaTE7vgV/+w2EIQFq3qkTaV7OCOGxkKiXfvccZRu+smExPHjWkfDAaderUZASITOgZqr
         RDYdSnfT4JU6JMyw/Ge99kdZMxUiH3DD+gNH2gnxQVSJ3lQxPqfxFx4mWX6szIwCiOhL
         /xGD8rsDi0RjBA+kIIjLsHghtddbTN9EhV/qP5n5UX6OLK8QDZxwNcZDxHUIESTkCgkM
         1R9dH+zi/qxLCqt0VbpY28mfi43rjFxOcKfN+e5azDOgalie55L7H/NCQup56a3w4nMr
         2HsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD2weGQkb+QmjqXzU8jQKLI9qxvEK8n3Tj0U4lAYL09K9Fffhg91K5KAttIOb0A+7CRJxB7UhxpbRfGQ==@vger.kernel.org, AJvYcCUyF2Ijs9e5WmSi/eMtg64Lw8fwvChR1BgVmiRqRXT1Pt4+dYSxJKeuxMr8Ig/jlcF5utFo4SzY1DBBhz8c@vger.kernel.org, AJvYcCWbKYsFM4qEJWdP5pgjRpGKiyquSlMc6SUV2FdwTV01YKQkdvSPAGdVc7WhTsvPxKI3oIVDvnCD@vger.kernel.org, AJvYcCXbtI0hhtOrEzYu9yUWm4RumDOE9aKjGsA6G83xsNOjVHpIoRbsvEVXwlBWbvvx9VdVw58sNdotYFr/RBlFDaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLTwLUSgi9dQQE/dPXAm8X7KKqloo5mzlDYXkivRWArksBV62
	vnN7PswkaY33VMJz0T8IpDC2+XARwuHMuZP0eRGKQHAoQJ0IVXzK
X-Gm-Gg: ASbGncuu00HbZKfrWmFDj569GgQkn/OYKrtG/Qj3nFE6Q9Aparn3YzGlVnQJTnIxBb5
	7E8H9Si0Rvo6iDqRFO7WPHcKDswzEiHBUnOoFhtA5O/+DLYbcNafPXgFg1dc5/D2NRTCMMtT8Gn
	XMov5R1q0LFKjarvjrXxyGNOgqsK6x5ildP4i6RdAQaqtKiYV2zjXtkN12LRvmnu4Q0qVTnyFbj
	+8twOJzV1jHazuZ2rMDCydjzMa0DDpc31wEkiU9HATcfwcJ/irVY2Z2kb7ndrWxaHs9foE=
X-Google-Smtp-Source: AGHT+IE0/j/X2n/zINy4aZRLBv+W4/ETg0gFc43Cr7FW8pBuls7jIQHjRV8Rp8rEiiqyXtZBK+15xA==
X-Received: by 2002:a05:6000:144e:b0:385:ebea:969d with SMTP id ffacd0b85a97d-385fd3ee279mr5260414f8f.22.1733312543032;
        Wed, 04 Dec 2024 03:42:23 -0800 (PST)
Received: from [172.27.34.104] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280746sm21691035e9.21.2024.12.04.03.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:42:22 -0800 (PST)
Message-ID: <cd5d7a20-7c34-4d0a-8f75-3cfca5f30b8a@gmail.com>
Date: Wed, 4 Dec 2024 13:42:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net/mlx5: DR, prevent potential error pointer
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
References: <Z07TKoNepxLApF49@stanley.mountain>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <Z07TKoNepxLApF49@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/12/2024 11:45, Dan Carpenter wrote:
> The dr_domain_add_vport_cap() function generally returns NULL on error
> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> and if it's and -ENOMEM then the error pointer is propogated back and
> eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().
> 
> Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> ---
> v2: Fix a typo in the commit message.  "generally".
> 
>   .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c    | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> index 3d74109f8230..a379e8358f82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> @@ -297,6 +297,8 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
>   	if (ret) {
>   		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
>   		kvfree(vport_caps);
> +		if (ret != -EBUSY)
> +			return NULL;
>   		return ERR_PTR(ret);
>   	}
>   

Thanks for your patch.

It would be clearer to the reader if you test against -EBUSY and return 
ERR_PTR(-EBUSY).
Otherwise, return NULL.

Or at least modify ERR_PTR(ret) to be ERR_PTR(-EBUSY).

Keeping "return ERR_PTR(ret);" does not make it clear that we have only 
2 possible return values here.


