Return-Path: <linux-rdma+bounces-2599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06F8CD693
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787441F2191C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870576FA8;
	Thu, 23 May 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WqqiTtbS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217DB641
	for <linux-rdma@vger.kernel.org>; Thu, 23 May 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476599; cv=none; b=iFcr3c86gfrCug+N4PpH70+hOhc5dOQ/lE1VCTmodiVmKilkUFshn0nfZK95Bz04/wOy/5io11p5sABXy8eDB4NSpVsNsS2TKlU1uZhcnCVTo2x96lwfR1MkxFDlOWWD1g1Lil2nqRTdNc37F4sDmnsktkD7Ib1jOk0fonIN4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476599; c=relaxed/simple;
	bh=AwXvZ8Hxey+umxF3F9fkDyrJMFmFmNxSz8zHB0Up0DM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RUjhg7mHXaBY8nYSZyekKoWstfPEkCRljQmAZwcZ/Iqtzjae3aZQd+gXlluWmDKO2DJpxLd60nAqu+xI5VMP7iL5kkpo14mEEbSSzxyinGdG1UROTkcHCU6M4BOe4E1rfDCO3DqVZSRue4WQyG3sS43x6IrIXb2zOnujzDb37XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WqqiTtbS; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: honggangli@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716476594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyoBsTk8fiLXaZK9fb+IVRWVbjfqq0C8nZSBjMnqVJM=;
	b=WqqiTtbSKTDpN9RFt1VWRoV8uJiKgIcVtK7fzTl4N1IwqJk77CznyyMSD6EGaAQpypijY6
	4xB4+iCOX5lnSoT29VsN6/qj9kRnN08X5klAKCASawyYb6g9rsSOZ/u018zEcOF03xnfUb
	HsXTaW5aJjF1Ehk5SyJPcE3Kdu293d4=
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: rpearsonhpe@gmail.com
X-Envelope-To: matsuda-daisuke@fujitsu.com
X-Envelope-To: linux-rdma@vger.kernel.org
Message-ID: <579a7cf1-7eb8-442f-bae7-f929cfa82dda@linux.dev>
Date: Thu, 23 May 2024 17:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
 packets
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Honggang LI <honggangli@163.com>, jgg@ziepe.ca, leon@kernel.org,
 rpearsonhpe@gmail.com, matsuda-daisuke@fujitsu.com,
 linux-rdma@vger.kernel.org
References: <20240523094617.141148-1-honggangli@163.com>
 <593dd175-c9c8-4bd0-a1bb-a7a19d1070d1@linux.dev>
Content-Language: en-US
In-Reply-To: <593dd175-c9c8-4bd0-a1bb-a7a19d1070d1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 23.05.24 14:06, Zhu Yanjun wrote:
>
> On 23.05.24 11:46, Honggang LI wrote:
>> According to the IBA specification:
>> If a UD request packet is detected with an invalid length, the request
>> shall be an invalid request and it shall be silently dropped by
>> the responder. The responder then waits for a new request packet.
>>
>> commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length 
>> checking")
>> defers responder length check for UD QPs in function `copy_data`.
>> But it introduces a regression issue for UD QPs.
>>
>> When the packet size is too large to fit in the receive buffer.
>> `copy_data` will return error code -EINVAL. Then `send_data_in`
>> will return RESPST_ERR_MALFORMED_WQE. UD QP will transfer into
>> ERROR state.
>>
>> Fixes: 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length 
>> checking")
>> Signed-off-by: Honggang LI <honggangli@163.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
>> b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index 963382f625d7..a74f29dcfdc9 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -354,6 +354,18 @@ static enum resp_states 
>> rxe_resp_check_length(struct rxe_qp *qp,
>>        * receive buffer later. For rmda operations additional
>>        * length checks are performed in check_rkey.
>>        */
>> +    if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
>
> From IBA specification:
>
> "
>
> QP1, used for the General Services Interface (GSI).
> •This QP uses the Unreliable Datagram transport service.
> •All traffic to and from this QP uses any VL other than VL15.
> •GSI packets arriving before the current packet’s command completes 
> may be dropped (i.e. the minimum queue depth of QP1 is one).
>
> "
>
> GSI should be MAD packets. And it should have a fixed format. Not sure 
> if the payload of GSI packets will exceed the size of the recv buffer.

Sorry. My bad.

 From IBA specification:

"

C13-3: The data payload (as used in Chapter 9: Transport Layer on page 
233) for all MADs shall be exactly 256 bytes.

"

Zhu Yanjun

>
> Except the above, I am fine with this commit. Please Jason and Leon 
> also comment on it.
>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Thanks,
>
> Zhu Yanjun
>
>> +        unsigned int recv_buffer_len = 0;
>> +        unsigned int payload = payload_size(pkt);
>> +
>> +        for (int i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>> +            recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
>> +        if (payload + 40 > recv_buffer_len) {
>> +            rxe_dbg_qp(qp, "The receive buffer is too small for this 
>> UD packet.\n");
>> +            return RESPST_ERR_LENGTH;
>> +        }
>> +    }
>> +
>>       if (pkt->mask & RXE_PAYLOAD_MASK && ((qp_type(qp) == IB_QPT_RC) ||
>>                            (qp_type(qp) == IB_QPT_UC))) {
>>           unsigned int mtu = qp->mtu;
>
-- 
Best Regards,
Yanjun.Zhu


