Return-Path: <linux-rdma+bounces-1661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA0890DBB
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 23:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033281F27DA3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 22:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C392D783;
	Thu, 28 Mar 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeX/vjxD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06715225CF;
	Thu, 28 Mar 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665571; cv=none; b=Q2sD969OZih307MK3vzacwHJxwOB5PPmgI8PDBJIsOP864sP0MeHMXvLlSmbRrNTe/lASbW+5rwK9z1kErrwwqh+VdMRN6Sj0iZSL8+N1G1NrAx/BHUfvvT8tHo8KjM+m1Df65PJeN8DnQ57pjh3unhZ+eNA9RpKXYTRqu5wfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665571; c=relaxed/simple;
	bh=SItJvabCDnAcEk1FDDPnUYg29uH0ygr0YwnH/xLN6Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSEANzzWJoRLF2RHsL1HXcuKLtFFJJ3NAuEOujZvhvmmUir9aSaUnhSEJUJS3/Dt9U5ExuODxtfh5SxoAa1B30QzZwpOVKJ83Dvviu8Np6HH1h4GNPVrbtDYHv+fkt7cByb5bdPX8nwX8Ah4w4EbbwOJ5Hij/2zK8F7tR4itJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeX/vjxD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41544650225so8083935e9.2;
        Thu, 28 Mar 2024 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711665568; x=1712270368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxAkMuGKIXRo2hx02pxk/kvCrTlB4fgMbIxtUPHcx7A=;
        b=CeX/vjxDVFb+gKZePatHrHD/K8Q4U/tXXArPq9Kw/B7WdQEGri43vrz6nn+Ai8Yt6z
         ZqSswQGbEP3e/N1/W5EClNW+hGNu7uwHLGOmO01hAyQKd9429Wk0z+nlHnemH3CeWTX3
         8f54KDaaVtrz6/tTvYc32XzNIgEqH0MfmB+wrEO/f6T9q7y34p8PzBo+PX1ty81/6PfK
         sDh1n8D/VQefufy07Fyjpp+69n0RiP5B5g2RnHxe0+kNCL5ALhreF+RU4V56k4QsiJzW
         UD36UqDCaWTq5tOWulTh3rYfGNM/UrGs9lfoHonufun88JVxeWHLdERCPsckCf/1jsuK
         meWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711665568; x=1712270368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxAkMuGKIXRo2hx02pxk/kvCrTlB4fgMbIxtUPHcx7A=;
        b=aoAE6UDsD5OUqnVvmUtDmzThKtjTsafkclXG/upAsYbX20RMgVvhikb/5KPm54H5vi
         7YFYf5aHe8wg6wQdTbcQDY4pEq8INZtAOlWCfDjRDBbxqAR0AzkWQ8wmqvu3VkMAFKCe
         /LZSC0vc6+x30/LMbs7okxFATE0drrt/6p0f6oitCj8glskDMaLUNBrLX2MuzmQ5Kjuw
         E4wAhdPT6Ivi71kX7zz0dalf0tDtxP3qmiT6F3oh/Sv9RZjzElYD6JdR5PHOBwz4C812
         fJyaH+Al9+9rm+ApVs3QRyGBJ/N8TcvDOzpyJXHzohoMMNwGHRrDAlZKEcJY4wzGvn4a
         2Jvg==
X-Forwarded-Encrypted: i=1; AJvYcCXwGjO0jvgti+izKkYVc7mdnL/c/DOm91kuULQtO4yWzhx8i19sGgbwfFEzRaFAVQsqGo1tgguZAw7SNyi35ATguZxCSFG/Yv/Gtp4tc36urnccG6RNfL5+VuSWfcgNwuGCwbZqLmbsELBTjdBIxe5ARrp0nwWB9d4pNf6wbzHcrQ==
X-Gm-Message-State: AOJu0YyacI8T8Gm7SXz2mxcphhueoQ8g2CRXDuBnYKa6VMs7x07k8SXB
	11RX2knOKQ94Q+olowB7tz2/SjMtshHkGKUNcjvxKo7kK6vZIt9B
X-Google-Smtp-Source: AGHT+IGtuupE/qp9ctW5zpvMpCcAD6pw+81arQy9Ewg8HbRTEXTfNfS1uS63GnRpo9iBoBdI63Whow==
X-Received: by 2002:a05:600c:4f85:b0:414:8a28:6c88 with SMTP id n5-20020a05600c4f8500b004148a286c88mr433614wmq.14.1711665568247;
        Thu, 28 Mar 2024 15:39:28 -0700 (PDT)
Received: from [172.27.34.173] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b0041478393b8fsm6625632wmq.42.2024.03.28.15.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 15:39:28 -0700 (PDT)
Message-ID: <d8381c87-6123-4df0-97d3-ea8d0e17c6bb@gmail.com>
Date: Fri, 29 Mar 2024 00:39:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] mlx5: stop warning for 64KB pages
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Gal Pressman <gal@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-9-arnd@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240328143051.1069575-9-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/03/2024 16:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building with 64KB pages, clang points out that xsk->chunk_size
> can never be PAGE_SIZE:
> 
> drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c:19:22: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>          if (xsk->chunk_size > PAGE_SIZE ||
>              ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
> 
> In older versions of this code, using PAGE_SIZE was the only
> possibility, so this would have never worked on 64KB page kernels,
> but the patch apparently did not address this case completely.
> 
> As Maxim Mikityanskiy suggested, 64KB chunks are really not all that
> useful, so just shut up the warning by adding a cast.
> 
> Fixes: 282c0c798f8e ("net/mlx5e: Allow XSK frames smaller than a page")
> Link: https://lore.kernel.org/netdev/20211013150232.2942146-1-arnd@kernel.org/
> Link: https://lore.kernel.org/lkml/a7b27541-0ebb-4f2d-bd06-270a4d404613@app.fastmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


