Return-Path: <linux-rdma+bounces-2476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8C8C55A3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 14:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA61C227DB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F026AC5;
	Tue, 14 May 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC+UB9dJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD58320F;
	Tue, 14 May 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688147; cv=none; b=jhahq9AROjxjgMb6w0xLpygAO+8XdPNcYMNs4S2w1iwcxu61MFUcvzAW8G0yhUCxZKBO52JY00KGuBIOq6Q0vq/Vd/89Y2GPBk2FWR/BNQUvAuzWtAaRuZSzJArvTcIIjVce2hfTAzbzWOfCs/z4eZDD0nTtERNpO/PHNhOkPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688147; c=relaxed/simple;
	bh=eQWBu0tglvdwToFXPXiES44baSHQMkMNMSe8uLGsxKk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BnsZJPUN/J2Gn3T25HI7d5IHZRapzowemSfkcZz1BjC0C+oPVTPh9ZY63gVfgPWa1/EUHHDrLEzihMnTcOPRX/kHiHLuXej3tmRAOZobwkb+JCW/XuTxRelngOjui0OXCC5z7Pmw95MX4/ui+9UfFAA6438R3QriS/D7J7/3dcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC+UB9dJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so30184475e9.1;
        Tue, 14 May 2024 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688144; x=1716292944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m5CJDmbvNdlQXtrA3K64KhqOlnBIFGsKlxJNYRs4nGU=;
        b=HC+UB9dJNuosu6x53ONo5LeyaF+tDbvrreHl4NLlAghGbLUsyERVdLMIe3NUvTH2or
         SsVYdU/S6SdQ6/Fc5Gs3la7TAGIbWVNWqkZ2tqs+IKcOCmBtIniMkNhDkHcIJHskMA57
         sQkoLKslJRIPvqATfeM7mcqQugOB1UUdLB0kd4Sa8d07lxAB+YMaxdEOuIrs5asMbQmX
         87nHv3R8QJV3OcSjpKHGvPZSfmjqJq1vwQWitnqNghijiVla+0MzC+F2SdtxXgeP7BxQ
         mEhp5kRYFJvxs/omtthK/03Jht8rmJc0Yz4yuGM8RlNdYUJDMqx/QOSXgmMxzOPqCH9h
         JdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688144; x=1716292944;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5CJDmbvNdlQXtrA3K64KhqOlnBIFGsKlxJNYRs4nGU=;
        b=E2KPgk4cNC+EAHMhAlCgErNNVFdwXDB/SlEoUQZyu9WpcALZwmwszoo3xw63etx4pT
         KgWuj4s3Euq4lkmvoIOWGo5XMtZ4JRUXeuxz5Ra5Dr9kKAgCPk9ke6yRKgeiyFa3KYnp
         kWRfSyqpGFyNZYYyq10b2QDGcZefItOfY3tiTlPLbl9jQ5RTo16E9M03ELF+YYoVZWXz
         RBOpdFMY60B2gakZ6HZHkZuHYr0TKMwuLapHBV3RROIxsWQbktQ5OfdbAoSFbjRv+hAv
         88DCbbjXHzrhGhGcgP5PGVU1dMvUfBGwigiG0hkozofSe2WaozGSSJ+MZH42o9bGQ6nJ
         /Zzw==
X-Forwarded-Encrypted: i=1; AJvYcCVQcZdRYOylfse088log+VJa8rIkDQ6m4AqUvioqOIBeNkHrUsPhDEB3F6Yx7URVT4RxphouCQAjdpJIx/9RsZhrFracG4A+VPBSDhnGAB0gtRvS/EjQdU4D55MDvvdp3zrI9FnH+mQwntral2jucRymc+o0Ox7prpk3TUa4z3Qcw==
X-Gm-Message-State: AOJu0YzHjnxWVGmKMwF1krV58btv8ctwXTBnGh9/8NzkYKOWKNHtZZ4C
	6d7tDrR3yfxEHtz7Tzyh1CrpzV2TASvuVMQ1oIh3jxggOinUI+i9M+J8jflT
X-Google-Smtp-Source: AGHT+IFfNsOQLgwhYmj9CSA0qSFQUwPiRB0XLgEJpw+K3tmAOT3zAjRISWx8+qT7Rz/U/EK+pk/IuQ==
X-Received: by 2002:a05:600c:3b0a:b0:41c:73d:63b3 with SMTP id 5b1f17b1804b1-41fea92927amr113248675e9.3.1715688144282;
        Tue, 14 May 2024 05:02:24 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24c0sm192641965e9.17.2024.05.14.05.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 05:02:23 -0700 (PDT)
Message-ID: <54d14e4e-63e7-4bce-866f-0e2f2c801232@gmail.com>
Date: Tue, 14 May 2024 14:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
From: Zhu Yanjun <zyjzyj2000@gmail.com>
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Mark Zhang <markzhang@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Yang Li <yang.lee@linux.alibaba.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <38a5ccc6-d0bc-41e0-99de-fe7902b1951f@linux.dev>
Content-Language: en-US
In-Reply-To: <38a5ccc6-d0bc-41e0-99de-fe7902b1951f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.05.24 10:53, Zhu Yanjun wrote:
> On 13.05.24 14:53, Håkon Bugge wrote:
>> This series enables RDS and the RDMA stack to be used as a block I/O
>> device. This to support a filesystem on top of a raw block device
> 
> This is to support a filesystem ... ?

Sorry. my bad. I mean, normally rds is used to act as a communication 
protocol between Oracle databases. Now in this patch series, it seems 
that rds acts as a communication protocol to support a filesystem. So I 
am curious which filesystem that rds is supporting?

Thanks a lot.
Zhu Yanjun

> 
>> which uses RDS and the RDMA stack as the network transport layer.
>>
>> Under intense memory pressure, we get memory reclaims. Assume the
>> filesystem reclaims memory, goes to the raw block device, which calls
>> into RDS, which calls the RDMA stack. Now, if regular GFP_KERNEL
>> allocations in RDS or the RDMA stack require reclaims to be fulfilled,
>> we end up in a circular dependency.
>>
>> We break this circular dependency by:
>>
>> 1. Force all allocations in RDS and the relevant RDMA stack to use
>>     GFP_NOIO, by means of a parenthetic use of
>>     memalloc_noio_{save,restore} on all relevant entry points.
>>
>> 2. Make sure work-queues inherits current->flags
>>     wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
>>     work-queue inherits the same flag(s).
>>
>> Håkon Bugge (6):
>>    workqueue: Inherit NOIO and NOFS alloc flags
>>    rds: Brute force GFP_NOIO
>>    RDMA/cma: Brute force GFP_NOIO
>>    RDMA/cm: Brute force GFP_NOIO
>>    RDMA/mlx5: Brute force GFP_NOIO
>>    net/mlx5: Brute force GFP_NOIO
>>
>>   drivers/infiniband/core/cm.c                  | 15 ++++-
>>   drivers/infiniband/core/cma.c                 | 20 ++++++-
>>   drivers/infiniband/hw/mlx5/main.c             | 22 +++++--
>>   .../net/ethernet/mellanox/mlx5/core/main.c    | 14 ++++-
>>   include/linux/workqueue.h                     |  2 +
>>   kernel/workqueue.c                            | 17 ++++++
>>   net/rds/af_rds.c                              | 60 ++++++++++++++++++-
>>   7 files changed, 138 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.39.3
>>
> 

-- 
Best

