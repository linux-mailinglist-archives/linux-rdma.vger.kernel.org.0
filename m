Return-Path: <linux-rdma+bounces-15222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10697CDDFED
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D14B304A136
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACAE1CDFD5;
	Thu, 25 Dec 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aOd7/Wgx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED0277007
	for <linux-rdma@vger.kernel.org>; Thu, 25 Dec 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766683220; cv=none; b=sEJ9timyln+gintnRid+QcV25VtPLRrktZvWZINpnwr2iGgzj3MxRBz2fPXPiaR0rK5G34RgozWnhTRVWltNlK0aqFMpj3Vm1k+Ij1I8JA5EdVzs5GX6p1It5uey6RPrfmYtfklmN39piQxRWVOSVoVKQMmec53Em8Zv/mAWh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766683220; c=relaxed/simple;
	bh=rW+UoRxczEliT0FrF29ahZF0QTec0HpAWEcngQJSf+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQGxYR+sxu1MilQWq/sJkGQjS7MNtG2BwjwMjrUpWnZYOV5WFYKd5gI+/jwouDKWuYhPa5arx8FsaHvYSxocaDxs+vknbBHUnMwBRO5S6VVP5mOOiE9fPq6JEZVdfKqvkL6eRhksUDe2/DtSrq1GYeTcr1JL89u170LL2Hf1fWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aOd7/Wgx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b80cb1f1-1a92-4f8e-9c9b-172245184321@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766683204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/I9AlWHmn7qaA3GahI7sYMMSoR3E0rM7fR/3DeR8gw8=;
	b=aOd7/WgxPx27KjvJyGd5Z2bK5QwMY4bMIQBE2G42/4YEllGV26aYuI64e0O2qSKrsTQGqh
	pyBCDt+E3sKu1fiTidSF8tw5cT1l2IAMGVukW+UomPM384D6CAcQuuqnXnIZIk97ks91hq
	We14xD88AMSiLF1md8QcaQsHclQMoN0=
Date: Thu, 25 Dec 2025 09:19:27 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Align struct rxe_sge and struct ib_sge
To: Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251225071959.3037-1-yanjun.zhu@linux.dev>
 <20251225125014.GK11869@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251225125014.GK11869@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/25 4:50, Leon Romanovsky 写道:
> On Thu, Dec 25, 2025 at 02:19:59AM -0500, Zhu Yanjun wrote:
>> Replace struct ib_sge with struct rxe_sge in struct rxe_resp_info.
>> No functional changes.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index fd48075810dd..f1f6dda22b70 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -222,7 +222,7 @@ struct rxe_resp_info {
>>   	/* SRQ only */
>>   	struct {
>>   		struct rxe_recv_wqe	wqe;
>> -		struct ib_sge		sge[RXE_MAX_SGE];
>> +		struct rxe_sge		sge[RXE_MAX_SGE];
> 
> I would expect extra changes in addition to this one. For example, in
> the SRQ code which allocates the WQE size. Maybe in other places too.

Got it. I will do.

Thanks,
Yanjun.Zhu

> 
> Thanks
> 
>>   	} srq_wqe;
>>   
>>   	/* Responder resources. It's a circular list where the oldest
>> -- 
>> 2.39.5
>>


