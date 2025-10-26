Return-Path: <linux-rdma+bounces-14051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D30C0A83B
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 13:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D2D4E86EA
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E22DECD8;
	Sun, 26 Oct 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTbbJnJR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BB267B9B
	for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761483063; cv=none; b=CHDqLSWE5tO7XijvKSPRhVgqzxHynbj6PuSHTSzNr+ZvMefCJ8eZLMcSNZ7HkTGABtEtl7OC+ZyOXR0/uMbdYKTktwWa3k9VTxDyBo+WiBHyr4ikHhngJ1prcRtohZ0D6r/86CAY6k9BzdVfMol7Z+/MOiLdzv9sZgtLYXjc3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761483063; c=relaxed/simple;
	bh=sC0JIKkXBimdhEy3Volg1/Z15jb+ADR/MxZiHjq4n8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2QJ3+3LwO7pRvxJAkEgT3sLp4g4OtJjGTkhWHk4ZKY3Uv/JQ2NgWkbuwBT6F43oblAKYEdE5XZeUzPcKINrdRTzc79fkBlodqBPdTrMDTYb+0yjougu+JxlGMxpTmCYJxOK/xMjahbp7ngokXr4qyXvWCi3x04uqARvuKdKWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTbbJnJR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47103b6058fso26483275e9.1
        for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761483060; x=1762087860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXj5Wf+44uD1y6UQsG1pQ//IkxTEmThHrLRBULvH6Rk=;
        b=YTbbJnJRBGsFBY58Qgo3Hod4DkpyoJwuK5hjSYg74yh2EGkM1MAJAYaCamzkzuHl/K
         7mJuGB3A4LJ1I63xFBHSQWF+Jn39mBtqt21Sc8/uBwoGlQ5did1Csac0CkZiW8NJPFdD
         OxVLQXUxJZpAerIc2qdcmqSAeKVOF6WBxwH5kpwVaI4nD1puSMskC/7rltTa5oiSAJv+
         0ixGkC24eFkT4WkWhYpdgEaHh6F3hEu1OT+9Jq4ZNK6C5AHBl6RXpxFBryJczQWDZ7SD
         KpCWQTAm7vZu2BaVZMJmsBInO2tDQAMYRQmDwGxJiUJL63MGWOnNqRsc492h1Lq49+m/
         syxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761483060; x=1762087860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXj5Wf+44uD1y6UQsG1pQ//IkxTEmThHrLRBULvH6Rk=;
        b=HPuuALngWjCqJqjPn9rNfSfXmmgLnpmGDtNI8uAONqgKT/l1ttTnhK/O9sJJSRWE9d
         Cq01MxK5b52vVPpl/hAtCyuK7ijS9ri+kC1ArVeMYXuoPrf4DyVN2epgIKddo/LsUwif
         0AysxsO15AXGsRDi03DfF+ekPBEwiL5zZFABiATn4mp1pinkB0k7xSXEjBuokTFjrqgL
         U3etCm/JoMiXYKW+fl3FG1HcTwgarn1Y4LDdtkMbTqzK8YJ+7pTKkSi9F+XjpSjYjt/Z
         AnYouiYdlekfuzsT/sX/lH9Tms7fivgEo+kGgSlZmd/kdWfIwj9j6TIlyACu08AEZ+A+
         prTA==
X-Forwarded-Encrypted: i=1; AJvYcCX0OlLmbwCaKQv/xV6RSiGmb9HzjCftwbPJX1plR6hYFm3Q7pixdfZNYlH0s7NAZ2UhZgSoe9j+Kyyk@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyA9vGeqljH67470pVvKwcCRmkv9Y4Oc8NPi9b4k36pofjMGr
	m0Ep22NaOyoO245xpfmgMfKk14/EXy3rMxIUlNI6kKqmkDGgg4LTvInL
X-Gm-Gg: ASbGncvj7ulCtH5wyHOvTqcQEAL2zg6nPXuPhmSeAd7iJ/zyglrBIjX2GJVlDunN4oa
	qsiGGW/oqAxhzZOsKX4ZlYxTyST1Y+ZdB80fdx6S0JUsVPVI4x7kOeVZZEtHL4l7pm8cYq5Ves0
	7HKhc8WKDhxrTa9sPJ6lExdGVgl1aKRH7bXVB3oW0S95rgc9H0zTL8LpUJz+AdX3ipMvP5y8uZW
	NqI4+f+1JdS3RYybDE2cPs69IbfzkoOwarFPfMnqtHuZwznNR2gDYd6OKZPYWYqDXzx1kfaiign
	mfs/o5xO9u9LAK+pjbJzHIm2nkhkYS4XBQfKFcDobJevT/DztgT0CTHUumNPm99HBwCy5O5XGG9
	T7lFBc8LkWJe+v+y66r3QSrib/dOHgKZAHL71USuvpj7WtuCGJr5NrDUnEs+TwGGhVseIBs0caJ
	eRK3rong1X41lvgUYlq4sYMgBf0Bo3yvcUSQ==
X-Google-Smtp-Source: AGHT+IG91g4W6yyRy1O/9J13waij055moyyErvrzJtpVIyLJEy5+LYF+7HxHgefiVJ+Er3vsDKPDFg==
X-Received: by 2002:a05:600c:a112:b0:46e:24a4:c247 with SMTP id 5b1f17b1804b1-475d2411199mr55666785e9.5.1761483060052;
        Sun, 26 Oct 2025 05:51:00 -0700 (PDT)
Received: from [10.221.206.54] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5768sm8715765f8f.24.2025.10.26.05.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 05:50:59 -0700 (PDT)
Message-ID: <83aad5ca-21e5-41a2-89c9-e3c8e9006e6a@gmail.com>
Date: Sun, 26 Oct 2025 14:50:58 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
 <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
 <aPouFMQsE48tkse9@horms.kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aPouFMQsE48tkse9@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2025 16:31, Simon Horman wrote:
> On Thu, Oct 23, 2025 at 09:43:35AM +0300, Tariq Toukan wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>> index 376a018b2db1..fad6b761f622 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>> @@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
>>   int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
>>   			 bool enable_mc_lb)
> 
> ...
> 
>>   	list_for_each_entry(tir, &mdev->mlx5e_res.hw_objs.td.tirs_list, list) {
>> -		tirn = tir->tirn;
>> -		err = mlx5_core_modify_tir(mdev, tirn, in);
>> +		err = mlx5e_tir_modify(tir, builder);
>>   		if (err)
>>   			break;
>>   	}
>>   	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
>>   
>> -	kvfree(in);
>> +	mlx5e_tir_builder_free(builder);
>>   	if (err)
>>   		mlx5_core_err(mdev,
>>   			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
>> -			      tirn,
>> +			      mlx5e_tir_get_tirn(tir),
> 
> Sorry, for not noticing this before sending my previous email.
> 
> Coccinelle complains about the line above like this:
> 
> .../en_common.c:276:28-31: ERROR: invalid reference to the index variable of the iterator on line 265
> 
> I think this is a false positive because the problem only occurs if
> the list iteration runs to completion. But err guards against
> tir being used in that case.
> 

Exactly.

> But, perhaps, to be on the safe side, it would be good practice
> to stash tir somewhere?
> 

I tried to keep the error print out of the critical lock section.
It's not time-sensitive so optimization is not really needed.
I can simply move the print inside where it belongs.

>>   			      enable_uc_lb, enable_mc_lb, err);
>>   
>>   	return err;
>> -- 
>> 2.31.1
>>
>>
> 


