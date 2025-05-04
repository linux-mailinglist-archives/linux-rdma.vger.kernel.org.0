Return-Path: <linux-rdma+bounces-9958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2470AA856C
	for <lists+linux-rdma@lfdr.de>; Sun,  4 May 2025 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A21790D2
	for <lists+linux-rdma@lfdr.de>; Sun,  4 May 2025 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB81199939;
	Sun,  4 May 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQb5AV22"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DF1F948;
	Sun,  4 May 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746350612; cv=none; b=AgPjk7Ptzx0pklCuUgWVDUmOBw6IeK2brBorvCAZcbXcfuiWpMRE4mn4cVJ1Tkta8Me/Ammxavb7KfKnHh50OeXVZXLHEIP8uG5b7gGYl2jMlTRyAxM+oMdFDtSegTq94Ko72uR74OyBrviFustAGQz2IMqj9K7JW6lIFQNcHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746350612; c=relaxed/simple;
	bh=D8CmpEX+akOScouJwEkOSdOqEGc4J0EbIcSdXI6sou8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bFfV+WStGnu+ywYQkcNZhJ5pAyklijwQlHR7x6hPfxWpfdBxNkOpvpLmQccxOVP4L2u2Ykuw4uX/33DgBQEmOE+f8VqhVp5mid2+qCUNCBZ68yXdmX60X+ojXwxcbV0+jQwUeXWyUtwQsyazyqgpPJMJElhS1ka1q8GfgfJhQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQb5AV22; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22423adf751so40778655ad.2;
        Sun, 04 May 2025 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746350611; x=1746955411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4vvIIMUjGPWvlpk7tTHWDKYFTzP4XJtC/Wv6x1ii98=;
        b=MQb5AV22qe6YgOhzZvCr0ThBEIObVnayDxBWPKTT3kd35xoC8SvKdD2/ZkBGSACLOe
         7ZZ18YrWRZjnfNRiDjExt5w1mYnL797eS085+6uTK9jV/ANhhFyLOVp5Xm+zseZLOVko
         3FvAjGGGz3SqGFuQ8wmodc8sFL9t+UqJdnrgjg/CeN0TgohNjV1Fef/2pEeye60NT362
         YM1ek6xikqa1YjFmuKii7E33Eh2IlV4wt0s+gSI2jv4uMBdUCJoquGwoL7tEaky+9UUo
         jqaBDmeUFXr5KO9N4lSlwRMMtm/AmhVXcqNRYBokaY5KaTvygJPyR0jw2NqiTK8Vl52k
         dEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746350611; x=1746955411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4vvIIMUjGPWvlpk7tTHWDKYFTzP4XJtC/Wv6x1ii98=;
        b=K//HyqxmwoQNg4XHn/EFqAUoyZGvytvY98xg/5OZ0+OxPejlsWh6Smav+5sOLKStrQ
         YrL+waoGdi+JI8gy8N1YZGcT4hyHMq5xMGfz07iImBonsqpf1/J+4AoO9AOHV/IFExMd
         1oNpiUBiibSbluLPuaeBWprcthsuUq7fHdCI4JZn3+j26YdF1CyfUQW9APNTJ4gjai1A
         R16a+e/wQ3pfmBWftNAc2nAUKvTXGszr8G37/Hy87StYJhogA8tclFkWnGHp+bDKiWQp
         nqDcHGM2XIluBsDtsnR2ZDjXfNVqFS5/ha+SaANnm6ZurUtGGBdaf3wY/Yr/zYNQQhPa
         dpbw==
X-Forwarded-Encrypted: i=1; AJvYcCUWcs7gneMd1QxkOqj6LuMY+hHYmKYOX09/+VUqv8QAPFesKCCMJDyFtuVvrLc8SRqienv4DkP6Vz5UvQ==@vger.kernel.org, AJvYcCWJDeL8mZm/XqWYlLlOvy9yWKq+CdHy+/dJSonNtLqSDDjokoHH+xH1R/czSEOod+tg6ScesRq7b0AYD+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5mZRx1/509UsKic2Pz1zMLqsuePTFSvx666m9B+obmC+6Tkl
	Tp3rWQD3w+7B9HPQ9+lBu38tkwemklMPNOuKYQTpX2Lu0IMoVbId
X-Gm-Gg: ASbGncvF6GeCwleaOp/O3MzNKfGO0WBMAFM+v9ZOWMMx3enOPlZsC0LAABKwn2hLNRZ
	32+a1LywYKVyJQqKge0PhLD/mJDuCp9q4n5Vg9vzxGDm6TxqO6HtEw0DRngKbhUDJ31jLVbmRuf
	Hd+aw8p7siHWhUSZEqMECnzbDYZNwOOwvtFWz3/qP1gegZb9dNQ8XiPyVSx2h2MDENTKq+MCbfU
	Q1SE7aUVc85oL+0CMzA5VbTWFiTwXYuPeI3FuT30LxYzK2MJEZ8NxrIFW4Rc3AtYxt2rwwT9HXd
	EslHCKKnCqHHUVd9Uo4Oj1F5BKcNdGzm8Fcs8/ORqoGAsuoFuPBfAjl5N5h+p1FYGx0D3cLIYiI
	MjyVelOsiHoNlhW3a
X-Google-Smtp-Source: AGHT+IENnOKUUkHFH+TnWk3OHl36odvv4VMQ80wl5aHy+VyKS+N0Ak00/T7Y7LEMELxqaTm9O4ju1g==
X-Received: by 2002:a17:903:234e:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22e1038ea74mr140776695ad.48.1746350610579;
        Sun, 04 May 2025 02:23:30 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fc85sm35017215ad.110.2025.05.04.02.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 02:23:30 -0700 (PDT)
Message-ID: <7e7d944b-b211-458a-8a03-b9b7b5f3dcde@gmail.com>
Date: Sun, 4 May 2025 18:23:27 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 0/2] RDMA/rxe: Prefetching pages with explicit
 ODP
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <526be00d-98e6-45fb-a5d3-eb26fd7a88d0@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <526be00d-98e6-45fb-a5d3-eb26fd7a88d0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/05/04 2:08, Zhu Yanjun wrote:
> 在 2025/5/3 15:42, Daisuke Matsuda 写道:
>> There is ibv_advise_mr(3) that can be used by applications to optimize
>> memory access. This series enables the feature on rxe driver, which has
>> already been available in mlx5.
>>
>> There is a tiny change on the rdma-core util.
>> cf. https://github.com/linux-rdma/rdma-core/pull/1605
> 
> Hi, Daisuke
> 
> Thanks a lot for your efforts to this patch series. It is very nice. With this patch series, we can make prefetch for ODP MRs of RXE.
> 
> I read through this patch series. And it seems fine with me.^_^
> 
> IIRC, you have added ODP testcases in rdma-core. To verify this prefetch work well for ODP MRs, can you add this synchronous/asynchronous prefetch to the ODP testcases in rdma-core?
> 
> Thus, we can verify this patch series. And in the future, we can use these testcases to confirm this prefetch feature work well.
> 
> To now, it seems that no tool can verify this prefetch feature.

Hi, Thank you for taking a look!

There are already relevant testcases implemented in ./tests/test_odp.py:
  - test_odp_sync_prefetch_rc_traffic
  - test_odp_async_prefetch_rc_traffic
  - test_odp_prefetch_sync_no_page_fault_rc_traffic
  - test_odp_prefetch_async_no_page_fault_rc_traffic
On my node (x86-64/linux-6.15.0-rc1+), this series can pass all these tests.

Other than that, this feature is required by librpma as far as I know.
Though it is not maintained anymore, perhaps this could also be used for testing.
cf. https://github.com/pmem/rpma

Thanks,
Daisuke

> 
> Thanks a lot.
> Zhu Yanjun
> 
>>
>> Daisuke Matsuda (2):
>>    RDMA/rxe: Implement synchronous prefetch for ODP MRs
>>    RDMA/rxe: Enable asynchronous prefetch for ODP MRs
>>
>>   drivers/infiniband/sw/rxe/rxe.c     |   7 ++
>>   drivers/infiniband/sw/rxe/rxe_loc.h |  10 ++
>>   drivers/infiniband/sw/rxe/rxe_odp.c | 165 ++++++++++++++++++++++++++++
>>   3 files changed, 182 insertions(+)
>>
> 


