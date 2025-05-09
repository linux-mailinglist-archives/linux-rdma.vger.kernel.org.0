Return-Path: <linux-rdma+bounces-10205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9DEAB17B0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A797163CC1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F122F75E;
	Fri,  9 May 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QSJTI811"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719A13C3CD
	for <linux-rdma@vger.kernel.org>; Fri,  9 May 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802137; cv=none; b=ZFF5TpxWdJ7cMaNoS4XBEEWLmKwWXipIg61ljJWqHiFxeOloCvRhbUwDswGkA2kOS1SMc4Ac5vh3SvkKEjjU3tiMndVvyXC272LSUBzG9ORavduO/HBScGOQbnXVHItpkGgW9dCsdObMzS5lU1SReMiVSggnr9UYNmeUe5mJP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802137; c=relaxed/simple;
	bh=mTu1DsijD0oVqCyZWbmPim8DDahuNdNLG+mqQ1vhC+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YYRGANa4SvHXOnn++M+gm4IJY0s+2s+t5+/+WpgGbOlWez1F/WUrwY05zujaHyxbMqgzNI0M+9Liyr9DBeaG7TNDGr+esoGGxbCvYCuqg0HYbxghIxAOVX1rGBblP+rwfPoe/J1i4wdirHU7ETqjlXovP/g556T3YrID236b/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QSJTI811; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9ba2073-7f92-4994-9a23-b2a0dcc3c605@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746802127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qk/Qil/fSS1stmgdJpSbFBZML2dp3/yhMx8HgIrbHzg=;
	b=QSJTI811gF8rJxjVCsjAeaOKV1H1Kg2tYTkXKa2N6AP0KhTeRL3u3b4lO0A8dny+fMZ/Ym
	Q3oYJWKUmljaMZkF8DUh2uc2IsGVDIbdx6n2gAJLP7FMJGAEkKxsL2QUPjPlUnLhQFi/4R
	m+kT6kk2zI+/e7s5H2iyBR4BRw6O3oA=
Date: Fri, 9 May 2025 16:48:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Enable asynchronous prefetch
 for ODP MRs
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-3-dskmtsd@gmail.com>
 <dbc1bcdf-144d-44d2-8fc8-77bc2ad58b51@linux.dev>
 <2a6081b8-1772-4064-97d8-70d636b1868e@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <2a6081b8-1772-4064-97d8-70d636b1868e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 09.05.25 14:19, Daisuke Matsuda wrote:
> 
> 
> On 2025/05/06 0:25, Zhu Yanjun wrote:
>> On 03.05.25 15:42, Daisuke Matsuda wrote:
>>> Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
>>> invokes asynchronous requests. It is best-effort, and thus can safely be
>>> deferred to the system-wide workqueue.
>>>
>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>
>> I have made tests with rdma-core after applying this patch series. It 
>> seems that it can work well.
>> I read through this commit. Other than the following minor problems, I 
>> am fine with this commit.
>>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_odp.c | 81 ++++++++++++++++++++++++++++-
>>>   1 file changed, 80 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c 
>>> b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> index e5c60b061d7e..d98b385a18ce 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> @@ -425,6 +425,73 @@ enum resp_states rxe_odp_do_atomic_write(struct 
>>> rxe_mr *mr, u64 iova, u64 value)
>>>       return RESPST_NONE;
>>>   }
>>> +struct prefetch_mr_work {
>>> +    struct work_struct work;
>>> +    u32 pf_flags;
>>> +    u32 num_sge;
>>> +    struct {
>>> +        u64 io_virt;
>>> +        struct rxe_mr *mr;
>>> +        size_t length;
>>> +    } frags[];
>>> +};
>>
>> The struct prefetch_mr_work should be moved into header file? IMO, it 
>> is better to move this struct to rxe_loc.h?
> 
> This struct is not likely to be used in other files.

Normally a struct should be in a header file. Not mandatory.

Zhu Yanjun

> I think leaving it here would be easier for other developers to 
> understand because relevant codes are gathered.
> If there is any specific reason to move, I will do so.


