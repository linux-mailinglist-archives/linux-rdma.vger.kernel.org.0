Return-Path: <linux-rdma+bounces-2626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3718D1925
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 13:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCD71C22A5B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DAF16ABCD;
	Tue, 28 May 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF+uddle"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1013E3F6
	for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894605; cv=none; b=fPM6BRutzBoeey1kDv0NnWmt2rDyLnrm4ipH4HQzarc0UsXUCfEccnrWKGCHZ0bEnooabUbYt4IAs0g0Kp/s45+Pojgk51NDSy1Q53JRDVM33YCdFQiJCMoO8CZoiymsJic5ApmnExvw7GHGGIyboEf0TUh/B5RyUXzbZzFPqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894605; c=relaxed/simple;
	bh=Rh5zmruI6leT5q5/NGFs68kytpLTcTqq0SNKaqFhtTo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gu8Sa8GbH47GGOUdP+JaKbGoUiUfJ6oIpm5xGhp5JSQSRoMn08yalcEeHXQg3t4ur47VXlRdns1hB9N0km5bmG89bdskBD5WQ5aYbk/RV86qcDJ3/tqXH8pcAez3XelB8aa3NsOeZjtnqOYhcIIrg64yxyUs7DNqY73Lx7hdf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF+uddle; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so5523875e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716894602; x=1717499402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2nkm69XtzOKc2Jv3MYUxb9b6F4nuScSPBMTLGnSXyDY=;
        b=FF+uddleMdyD8czvRqzBANLbHNxWHuNK9wYTfuVwe8bZ/uvP8oxvKKfEntlOHvuVjm
         45qc/70ytpAwGNoTuuqvgNO7yb82vA65++f1AFVJZfu80ssY4sHexQ4XF498fsS6A28l
         wUYEe4e/2HekGuh3tnVPtIDnGNTwRKx/F9QrO47v6GGu/202kcGrhhWR9U6Q56Y3J9X+
         zZU9wnNodKYLbwKOPx91Q7Y6rRb/O/bz+Gk+r2l5Xg014PB7MNVdQVZxUl4O167IzpYC
         UKpfCo052BKnvlJQ4jQOFCXLhymBUcwyapTryUha0FUk4Sp4fyEDWP3CuUhObYJ4rYNQ
         3IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716894602; x=1717499402;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nkm69XtzOKc2Jv3MYUxb9b6F4nuScSPBMTLGnSXyDY=;
        b=c6eSh8uVBytTiZ8cRzbXEiwrgOdVpsU908XdUSNmkmRVT+gzXOaG5dI9DCF5IYq9hL
         D4nwWjrgV9dgCBG61Rbk5zfbMxr7OsRFENV/mbmpannmcsoluhwPok2d5ueHXiEDD8O1
         buQSnrog6IMyJk6rjLHyIm7nTAQtP1AGdsBo1PcS/MNALbojlIKuBwgJIfgrF+PdGSOZ
         jIf1f1P3XzA4ZAP+g5XW9lEu0OVyl3xwfsqCBl21Wv32DsLot3mnoYIgFKqItGmhvVwh
         theXubOb80/ZoJhEmANWXgfiNAuwl+kDE2eMlJ9EQCHnyRb25Xue4c02CJ0i6c2DdIQ1
         nmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkscfu7pE8Jk5Un1NwSsJoRXwU6q6p8xGy6Je6CHg/kq7WxCnvT6SfDeTpGAYRODnjggUg6dTPYm31QtM9RYwx+4qSTPZ/7ZcTBg==
X-Gm-Message-State: AOJu0YzKqM70eh+gpWXwexu02dSAW3RLTo828i40EFUHDT4LxNymxoo5
	fHaLHiLTt6i3FuBy6+JWoTMHTdT8cazZ9zpFYRJOUQVZgGCWUJvP363nTw==
X-Google-Smtp-Source: AGHT+IGLFBHcn6pEiGRSllUXrAucntMhGHyKQ1q5ao6q1DzzqYi5jaq4LW1Z37/uALl42vMUumAN9w==
X-Received: by 2002:a5d:4cc1:0:b0:354:de21:2145 with SMTP id ffacd0b85a97d-35526c2bd2amr8541342f8f.22.1716894601448;
        Tue, 28 May 2024 04:10:01 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a8dfsm11336138f8f.30.2024.05.28.04.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 04:10:00 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <71e37594-818a-493d-b3fa-9616e34bfe75@linux.dev>
Date: Tue, 28 May 2024 13:10:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
 packets
To: Honggang LI <honggangli@163.com>
Cc: jgg@ziepe.ca, leon@kernel.org, rpearsonhpe@gmail.com,
 matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
References: <20240523094617.141148-1-honggangli@163.com>
 <593dd175-c9c8-4bd0-a1bb-a7a19d1070d1@linux.dev>
 <579a7cf1-7eb8-442f-bae7-f929cfa82dda@linux.dev> <Zk_y-DYV_2fOSxOF@fc39>
Content-Language: en-US
In-Reply-To: <Zk_y-DYV_2fOSxOF@fc39>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.05.24 03:52, Honggang LI wrote:
> On Thu, May 23, 2024 at 05:03:12PM +0200, Zhu Yanjun wrote:
>> Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
>>   packets
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>> Date: Thu, 23 May 2024 17:03:12 +0200
>>
>>
>> On 23.05.24 14:06, Zhu Yanjun wrote:
>>>
>>> On 23.05.24 11:46, Honggang LI wrote:
>>>> According to the IBA specification:
>>>> If a UD request packet is detected with an invalid length, the request
>>>> shall be an invalid request and it shall be silently dropped by
>>>> the responder. The responder then waits for a new request packet.
>>>>
>>>> commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length
>>>> checking")
>>>> defers responder length check for UD QPs in function `copy_data`.
>>>> But it introduces a regression issue for UD QPs.
>>>>
>>>> When the packet size is too large to fit in the receive buffer.
>>>> `copy_data` will return error code -EINVAL. Then `send_data_in`
>>>> will return RESPST_ERR_MALFORMED_WQE. UD QP will transfer into
>>>> ERROR state.
>>>>
>>>> Fixes: 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length
>>>> checking")
>>>> Signed-off-by: Honggang LI <honggangli@163.com>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_resp.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> index 963382f625d7..a74f29dcfdc9 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> @@ -354,6 +354,18 @@ static enum resp_states
>>>> rxe_resp_check_length(struct rxe_qp *qp,
>>>>         * receive buffer later. For rmda operations additional
>>>>         * length checks are performed in check_rkey.
>>>>         */
>>>> +    if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
>>>
>>>  From IBA specification:
>>>
>>> "
>>>
>>> QP1, used for the General Services Interface (GSI).
>>> •This QP uses the Unreliable Datagram transport service.
>>> •All traffic to and from this QP uses any VL other than VL15.
>>> •GSI packets arriving before the current packet’s command completes may
>>> be dropped (i.e. the minimum queue depth of QP1 is one).
>>>
>>> "
>>>
>>> GSI should be MAD packets. And it should have a fixed format. Not sure
>>> if the payload of GSI packets will exceed the size of the recv buffer.
> 
> It's dangerous to trust remote GSI request packets always fit in local
> receive buffer. A well-designed hostile GSI request packet can render
> remote QP1 into ERROR state. That means the remote node can't establish
> new RC QP connections.

Thanks, Honggang.
Based on our discussion, this seems to be a security problem. It seems 
that this problem is related with MLX5. Before MLX5 engineers jump into 
this problem, to RXE, this commit can avoid RXE hang in ERROR state.

LGTM.

Zhu Yanjun

> 
> Thanks
> 


