Return-Path: <linux-rdma+bounces-8507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92193A583D6
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1A516B5AA
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9B1C3029;
	Sun,  9 Mar 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNXbnjar"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D62F2A;
	Sun,  9 Mar 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741520626; cv=none; b=IyylbTr84KKQg8zuCM0rNH63Fb+BKFV1W8zZb62g8Do1JEmwM/yi6YFFiHqbxL55KEHCA4K0KvDG4nStCdsFSzrS8v0xnfIXgZ6OuqiVBMpobRjA6zB4jsLiIWQ1R6m77O5rchQB5hIVFiYpiBeNgDQDVaoO9/ymWn7fo9d/zOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741520626; c=relaxed/simple;
	bh=2sv+Z6u0e63RMs+eEz2YCcrjaLa9sh0py9xQ9g7VzTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbavF3MBzKbc/4LlBMhtTw/y4NOgdAG7ON5eZXp0JnJ4tbtBJ+rlfWWd2F7Nx03l7X8jPfPhzGnRSbcUjQD1dfuH8WFeLGFoyYv/vczum/zYOXOgj9X9jDq/FnpGkFOMy5LJoio5/YPGA98dxKisDK+sm1wIUIi+vcIOISvfN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNXbnjar; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso776555a12.2;
        Sun, 09 Mar 2025 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741520623; x=1742125423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2Foe3XwhvNs3FCKXrg4j2vvhvp7L38WiHksGts8MLY=;
        b=aNXbnjartxx66eSX5hpxdMNJDvTqkvlBna3b4MKELTNHj71K5rInqGWeFhPDrAFBVQ
         y6CdTnbfrv0Tovc5JxJcsmFmKa6S5qc6azUt7Ktbnr2s7NTJBTCZ4T8w07CKTsPRhIf+
         PrHg7WUjbLeTqOg5hJHjecyw3BhwabcF2D/pQnoO+yMLI+4nvJl6Wizz9tdkbRTtePwu
         PchsnTIWr4PpgI7MWJFQzS0U83OOxyCJfKE2iTvD/a0VTTeh87zK5ZBOw/kG4QHClUft
         wQ3GMcRFCbaHk4ERYoTxkFhf9SiwylPw4GsEC9Bn/lXY9BTspQ/pEaOWR8YUM9gD3j5/
         LlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741520623; x=1742125423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Foe3XwhvNs3FCKXrg4j2vvhvp7L38WiHksGts8MLY=;
        b=WJYGTmdiXVsA/8DC7k0pKlj6QxUW2sFmnUrwlKs1RcmXAML+WIDhTJXoFieiqYYu3h
         dqBlz1bElhBtoSnOPOl9onXBEzOMQS4KCbDNa/IWRIvLG5tL5byx0AUTApEEKxh9zfsg
         XyD1TgEdz74hVQFmv2g3Ania26dfzNuWkpbzUXy3m/eq3o0fhuNEhHTLwlyC2pcPorFY
         LW/0lH3NjQpqlWP66xiZ1RA2lJ/v/AhBYovCYDui3XlooAKyE4bjeiA7ZKlSjcKxA+w2
         QJEhk9X6bc9mSCKSZtXZR0ER8xthVJ15s+BaJyLDS7Bn5dJ91NH4JxLdOYc2mRkPqV+k
         QY1A==
X-Forwarded-Encrypted: i=1; AJvYcCVXRgylh7vyzKiswjv3+Fb0T9in7WPTPaBOqwkPRrXd5LgaGaysIO1xasHAr3CtnGgBy1L+uNAL@vger.kernel.org, AJvYcCWwL9u6OkVlssNuZuCOZn7eD2Ews1IZKE+KaKlrQCf0nY9hHP3cLWFESlNJi847GcXtUr+sM8Ec0YBB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3hhhqfXHN997mth0DGPxj7VeG3OzMmReGI11ZVog/CRZe+Uq
	KwDSuzqfneAVZBV/hmNdo6ojbHaIajnOYbb+cJ3n4fDqe02+4cot
X-Gm-Gg: ASbGncv5698k4aO5goLkocRKcGTxIcr7BQr3bs6PYH2U5ux870OgE+IDEZfRbG14AAM
	lO96qerhlIUmm3EO0cNMhoxgi+VeTzGjihY4/+l9uP8WEof2T9LRzBKAE/gwtx2c6UWrLAxws5U
	hLBNC44tY6jdU5I2aCM/XRn/Xk5PXCd0YeuIQ4vNW7eD+AAvTkuSDu7S0sVGfJgfVAIwNTNZIUo
	isJHu29Yz79AvaT3DhvrcatQum7dzt7h7Lr8qOiPF2cxLe5Efc1ZV+r53Mu/DSQJ3o2KZXiI0Qm
	Zm0dXlB0e8Fo68WXnXbK6ucMO8SepVN8K/s6og3KwnMf7bVyRuV+q2NyQYDHmd3NtQ==
X-Google-Smtp-Source: AGHT+IGCkQvpCYvt8DAq7HNsPYTi3N6A3lqWQRF/jPpIMAUqN8kHt8G03ChJPrJbXKeLJIlJ8+vj8w==
X-Received: by 2002:a05:6402:50c9:b0:5e5:db72:122a with SMTP id 4fb4d7f45d1cf-5e5e24d6e07mr10815399a12.20.1741520622082;
        Sun, 09 Mar 2025 04:43:42 -0700 (PDT)
Received: from [172.27.60.223] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768fa17sm5153804a12.72.2025.03.09.04.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 04:43:41 -0700 (PDT)
Message-ID: <fd6b1fef-8854-451f-9b7a-94df82adebc4@gmail.com>
Date: Sun, 9 Mar 2025 13:43:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Avoid unnecessary use of comma
 operator
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev
References: <20250307-mlx5-comma-v1-1-934deb6927bb@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250307-mlx5-comma-v1-1-934deb6927bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/03/2025 14:39, Simon Horman wrote:
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','.
> 
> Flagged by clang-19 -Wcomma
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> index c862dd28c466..e8cc91a9bd82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> @@ -700,7 +700,7 @@ mlx5_chains_create_global_table(struct mlx5_fs_chains *chains)
>   		goto err_ignore;
>   	}
>   
> -	chain = mlx5_chains_get_chain_range(chains),
> +	chain = mlx5_chains_get_chain_range(chains);
>   	prio = mlx5_chains_get_prio_range(chains);
>   	level = mlx5_chains_get_level_range(chains);
>   
> 
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

