Return-Path: <linux-rdma+bounces-10411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE014ABBD10
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 13:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3CB3AB7AA
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0899275875;
	Mon, 19 May 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG3NkFmM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDF275840;
	Mon, 19 May 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655899; cv=none; b=VeMcaARQpIPOTd59HNhP1VO9Xfh2HZ+BiosDX8LZcdRxcwAFTH3zMvfE2B0y56JGHBFs+TghRqc5wD9jDoF5dDycYxFfA+J3sCcWJXW0+JX7PbIPkv0gP+WOSMxjAyENUm3N1J8SAs4UKrYTzA4SX1Ov7TRKrVRWN7hk1MKz5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655899; c=relaxed/simple;
	bh=Z9JbD8IB1GnpCS9qtautwpk4ez5vTFIL8zpyJ3eRpCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbP9d12u/dnVFcTAOPUh7F6KuH/LUO3yx7/NzbxfJ7hPSN0nmPFKEWQThdAKXF9tqViyQ5QAzRRlVufEN0ChbZSuNH4Nl4hJPYbohYcF5SPy6x3ntVAH6v8Uu0VCb5KqsS6tsIhJAYDQDveEmFPEI4lj6vKfd5N59OnSD8B6EXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG3NkFmM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2302d90c7f7so54445535ad.3;
        Mon, 19 May 2025 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747655897; x=1748260697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UeYE/ve3ScVgc6vDvChyrxgVb3RTOIVsd/hUlA5hwrc=;
        b=bG3NkFmMx9BbOrJW/pRIhLuDoaOR/k+MHZ6lOgptAci1EznfBk/nMg3WA88+gmXune
         1Ui/OLizgFaSRrkmM5GxRF/AynkZHhF5VELYS8Zuz2yomIJ0mCazQND1YxNFIBt3+un1
         cUlTXSru+ES8ClsKYiael880U9jOGqXYBj4dwiSvLrLVEmpUdUvEPbM5KGQWFKi8MJhL
         kgE8R93Oi0o6hkbawG4s/6NCZfJ//EkoLgDAIprErYJtMnemcE8yaZrAbvcWj7YqQ573
         SdsEOXeD8SwR/P1klky7oda2NazrpIPFjCv9f1XoBWqUhNPEuEVyZKnZm3Na6PmjeNwu
         Ss4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747655897; x=1748260697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeYE/ve3ScVgc6vDvChyrxgVb3RTOIVsd/hUlA5hwrc=;
        b=TOumEqp3vyj/74XI7m243VSzCVy31Jt9wKn6GsiGnMrJsIDmw9Dma2MoGpwhcj+Qf+
         xForoWHSc7Vo8w4rY36R113OocVuB08rJHooZ6KHiU8aaTjz07NB/drtaFe7s+65SHaw
         Gt4WW5289v+uy00CjZQx7ehHkSJ3UCDGpc4aRZtEruki2XaoCqr5vddRCAl90ceMvGlZ
         pgVLeajPJ0zKCFV1PwtSjm9TFQSU8bWvKVsDpOTBynbTnlvCpyJfc6mTxA105o/YRlT/
         l+6IVf9nMpqXiZfxcKEis0TA6sf8qNJyrG1OZ9L0iWFL9mtcMf7bzWGuTNFxAhH6Ps/F
         HZxw==
X-Forwarded-Encrypted: i=1; AJvYcCWUdHzaJMxCf+XokieEEZM4jic+kZWt12VxCxq1rtwj5/qcVvJEnpZIIu1N2lEBcNSkglyQ+G6j02R+@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGHwwpC8N2uJO1lkXAaV5azpzeKGKxW5xPdcdXP9LifMp/g4+
	2m2ngUwUJVJoSuGM3Ow3oMbLzeijSRmF8u9LYV0BfJAn8fsM5FeICsJKCSY9iAdz
X-Gm-Gg: ASbGncviDHGy7V7g4+cXqCwxd7YqF2D/fV2GGgBAi/CqavOexo0GgbPFoDxeBwcfDpR
	WOhgLeL0F/JdFJ4mZxXLBNrjRULNq8KfcJKW/KmgRM77l31zlnMyAovoDZLy8oD3xMnBSvfaidN
	ZWy7wEk2QGr9WrAbVTKZer/zGJvh6WQ8gilsv0fBmtDjuR7P28F3MKLa8ZldFyXkrBpFJNllVpT
	jKegzIDFFIWQdD/2veU5oS6kBo0eYYRRSyBfXlvaZceEhbUfOTt8Ehby9SCDQiznzdwqfZiZ07u
	B0mjH6CGd2IE6iy3YSA5g6emytcdwNcYApydHiK7RxJb8UY8ylCw+9BozQxmrkLMhWHC2SK+Ddy
	hqqa3lp4m134xvAMA++gvLwf/uBw=
X-Google-Smtp-Source: AGHT+IGOEh8NbLSE8slO8ikzUOgFSWvPQV3MD9xwXEE6Es9Z4gzKKb/25+c6pNh+epYMl0fN/UWqtw==
X-Received: by 2002:a17:903:2f43:b0:22e:3c2:d477 with SMTP id d9443c01a7336-231d43bdf52mr195431745ad.25.1747655897474;
        Mon, 19 May 2025 04:58:17 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adbfe1sm58120175ad.66.2025.05.19.04.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 04:58:17 -0700 (PDT)
Message-ID: <1720c440-719b-4bc9-9685-148c20d4cdfe@gmail.com>
Date: Mon, 19 May 2025 20:58:14 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Enable asynchronous prefetch
 for ODP MRs
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com, Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20250513050405.3456-1-dskmtsd@gmail.com>
 <20250513050405.3456-3-dskmtsd@gmail.com> <20250518055405.GA7435@unreal>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <20250518055405.GA7435@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025/05/18 14:54, Leon Romanovsky wrote:
> On Tue, May 13, 2025 at 05:04:05AM +0000, Daisuke Matsuda wrote:
>> Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
>> invokes asynchronous request. It is best-effort, and thus can safely be
>> deferred to the system-wide workqueue.
>>
>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_odp.c | 84 ++++++++++++++++++++++++++++-
>>   1 file changed, 82 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>> index 4c98a02d572c..0f3b281a265f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>> @@ -425,6 +425,73 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>>   	return RESPST_NONE;
>>   }
> 
> <...>
> 
>> +static int rxe_init_prefetch_work(struct ib_pd *ibpd,
>> +				  enum ib_uverbs_advise_mr_advice advice,
>> +				  u32 pf_flags, struct prefetch_mr_work *work,
>> +				  struct ib_sge *sg_list, u32 num_sge)
> 
> There is no need one-time called function. It can be embedded into rxe_ib_advise_mr_prefetch().

Certainly.

> 
>> +{
> 
> <...>
> 
>> @@ -475,6 +542,8 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>>   				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
>>   {
> 
> <...>
> 
>> +	queue_work(system_unbound_wq, &work->work);
> 
> How do you ensure that this work isn't running after RXE is destroyed?

I think we can use per-pd reference counter in struct rxe_pd.
I will fix it in v4.

Thanks,
Daisuke

> 
> Thanks
> 
>> +
>> +	return 0;
>>   }
>>   
>>   int rxe_ib_advise_mr(struct ib_pd *ibpd,
>> -- 
>> 2.43.0
>>


