Return-Path: <linux-rdma+bounces-5773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B49BD35F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 18:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE52B2221C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBD11E1A3B;
	Tue,  5 Nov 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj1ZA9RW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19A1DAC97;
	Tue,  5 Nov 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827740; cv=none; b=f29UY6SHm1EzMwazD5F4jfm/Ya4KjCICyK2IFG5JmcwV8sVJSJH8SmW9lqRfEp4UHt7pFccNDEwRf/7a7Dkzf6DJ7Q7O7fIDLglvdtTLkj0XqIYd5/wK1c0qQORymyu6M9uAq0HuXD1Rdzfs6sGM9N0ZnDhgXZ9BbxwV1AuehKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827740; c=relaxed/simple;
	bh=xzSJ54sE6j/Nzy/nl51Jz3ImdBg22sPxhfbET3yiB/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUPGHeZ6Sr2h6dg3kpejTRYS8HdYeGSc3LP9Jh2LSlVZagisYcPs/hflKjLy+SmiyYBRwqxwBBPH22KlTkooPt8NXe3tiHS6rkxsLEYv1j/Fv+JspABzCdfmS/pPB0ukzEpwJwZdhw9xIICXfm6nyeDYovV2RkYU3jtYahoy9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj1ZA9RW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so4240615a12.1;
        Tue, 05 Nov 2024 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730827737; x=1731432537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=187RsLEuHvSyP/hnMpNWdmPF77wDCR9+I0JKJx3N5uU=;
        b=fj1ZA9RWDcSFY9tGC8oWiy+w72nSpZMhyNfFDyQBnqOfdayfkwo4xtmv1beszNVXTH
         ttMB7bgOI1r9fUXVv405wMw/xhFl8t/I3FMQm1LnvIr7eWARLr5NnyyNT0NfJqs09gHO
         C8pmyWirWL+gScStA3WSdaU4Pptor44NytLfrW+xU/P2d1VKN5Rszrsr+phKqxrd/aqC
         IWsTFE9Ewto6JKvjCtcB+YN4RTnO621RidWuZxhxeo65tfCDzsAU+sVQcCPbbHE9Ynly
         qm9v5UtdC2sphGzImb964qlSGk/DgmM/JuCC6uFe0+ovIy6b73oORGSYf1hOfIOb9/9s
         exFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827737; x=1731432537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=187RsLEuHvSyP/hnMpNWdmPF77wDCR9+I0JKJx3N5uU=;
        b=UyDqwg2gkDy/9HLUvrd94S2ySIMUtr9i2JQnfKxy7Z3eEwcbO85aLuHB3Z7i3YD66k
         dvNNXfT+UponSZQZKGk+OtHTSrY1UQDhx/dq4tpwR55VpfaDuv3lF/LjCt3N1u2MkrFM
         bcQHva6Qq7ejYzTiv/YFLJDvSi5oGe9PTzWy9tEVdVSAgGC1XdqGMpzCWiaaMqNaFkvR
         MpXOpAsMvbvYr8F/pKR2e/rCPwGGeCRur4+nE4zH4R6xmM+QbxqbVEq53XI0CZMu8BOo
         E40P4ojgLSU4Es1EejTmQdtyBk/THPW/RRRhkUuXOQ8Wq25X+GeWOJOIP4RPDt8WBS4J
         wFaw==
X-Forwarded-Encrypted: i=1; AJvYcCWC8Pjx/4PkQzgNdrTF9xpKx8vFW4yonYJFS20SJiVutzgCSQLpDva/5C58R5XBpmFFKmkc7PmU@vger.kernel.org, AJvYcCWpoyZKV4JEMhCysnsaaoYoVdSwIK8vjfY2F41XT9t3p95i5+qiuo0sejZ3KSSbMwgcZU+gBS1X3FqQsA==@vger.kernel.org, AJvYcCX3OernXGiN6uNsGmU6tECm67FLVTIgSiv6eI/maHUh2CegC+B+haY7pfSzvzBzErr4B4c1DjtjRd5VotI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVObL1kA9g3sRlnrWhiRRawLFVdw/Je5+5opG2y/zgvqnu+7i
	/ByMUQybTwxu8t7r2SuvSyFnxOI3/Qtyib4EJLy3Nm0rBnS+2e5DxDMH3g==
X-Google-Smtp-Source: AGHT+IEIvG45n2lgxPAOStyj2awwAFHHMTvEpHdz1CjjOG9fIFBlluWe3TQQVa7qEikgAFu8rYM7hg==
X-Received: by 2002:a17:907:7ba1:b0:a99:509b:f524 with SMTP id a640c23a62f3a-a9de6331190mr3271121366b.57.1730827735342;
        Tue, 05 Nov 2024 09:28:55 -0800 (PST)
Received: from [172.27.60.131] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17ceb1dsm165616266b.101.2024.11.05.09.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 09:28:55 -0800 (PST)
Message-ID: <e12067aa-9465-4c3f-a67e-e8e8dee14c8b@gmail.com>
Date: Tue, 5 Nov 2024 19:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] mlx5/core: Schedule EQ comp tasklet only if
 necessary
To: Paolo Abeni <pabeni@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY8PR12MB7195C97EB164CD3A0E9A99F9DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241031163436.3732948-1-csander@purestorage.com>
 <cf2d112f-7888-4e36-8212-d8c632fd323d@redhat.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <cf2d112f-7888-4e36-8212-d8c632fd323d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/11/2024 14:21, Paolo Abeni wrote:
> On 10/31/24 17:34, Caleb Sander Mateos wrote:
>> Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
>> to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
>> whose completions don't need to be processed in tasklet context, this
>> adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
>> time spent on the tasklet_trylock() in tasklet_action_common(), with a
>> smaller amount spent on the atomic operations in tasklet_schedule(),
>> tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
>> TCP completions are handled by mlx5e_completion_event(), which schedules
>> NAPI to poll the queue, so they don't need tasklet processing.
>>
>> Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
>> overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
>> to be processed in tasklet context, so it can schedule the tasklet. CQs
>> that need tasklet processing have their interrupt comp handler set to
>> mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
>> don't need tasklet processing won't schedule the tasklet. To avoid
>> scheduling the tasklet multiple times during the same interrupt, only
>> schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
>> queue was empty before the new CQ was pushed to it.
>>
>> The additional branch in mlx5_add_cq_to_tasklet(), called for each EQE,
>> may add a small cost for the userspace Infiniband CQs whose completions
>> are processed in tasklet context. But this seems worth it to avoid the
>> tasklet overhead for CQs that don't need it.
>>
>> Note that the mlx4 driver works the same way: it schedules the tasklet
>> in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.
>>
>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
> 
> @Saeed, @Leon, @Tariq: I assume you will apply this one and include in
> the next mlx5 PR. please correct me if I'm wrong.
> 

Hi Paolo,

I am doing the mlx5 core/en maintainer work right now. I work 
differently to Saeed, as I do not have a kernel.org branch of my own 
(nor use Saeed's ofcourse),

Please consider applying this one and any others once I acknowledge/review.

Acked-by: Tariq Toukan <tariqt@nvidia.com>

Regards,
Tariq


