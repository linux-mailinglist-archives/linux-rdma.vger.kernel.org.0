Return-Path: <linux-rdma+bounces-4507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD495C905
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 11:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167941C22060
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244314A4FC;
	Fri, 23 Aug 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aZL1PpEh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE841BF3A
	for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404661; cv=none; b=La0h4Kleojm7cr/sbPA47lSRdjS/Dl4sIJA7mhzHgDjrpp5X6OoLJbiNLAFtPlFzbdIYBT0pioYTXwG1BQS3JT/CCX+KWkUA0kZW1L7YJXGKTtwMWhmPw+6cZ7WmJ/4PL0tAbeqzf6PXANXXM9YehTMLfOTjsHMXtpfbcUH30OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404661; c=relaxed/simple;
	bh=4GVbHIIC4eaOibBpLaXkJ71skZHGhocz4QHlAcTLKe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHp7cYdB/kRVJrITflGshX2QSjU+eOyJOrUimoxpokCe9Nj9Pht/qNzEwSCM8qeN+J2XtQxRi1s2/k8CzRZyOjKfOy8sOeFInnRT3it4qGfg3DwJnr6ssViJlSUfGbYgJqeWXXqwlVOEc7bAH+PU69PtjSeqWv21YQJb7fZu/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aZL1PpEh; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e2ddf38-7c42-4ef1-8a7b-8c0f6deec8d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724404655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYAgZEIQ1inCCgirecBe7KorljVm5Cf3XOLj7E/21WE=;
	b=aZL1PpEhIwruD5rmwNy3Z0gC/2++iMXwJJvPRVxXRstK06556ZHe5EeMbY0j8bXLUHZ6IU
	eZpAcXo05xX7Ad+wXn9uubObBMKPDoDJNSED5PxfPyZkw33jGSmRhXvOlbZA3slHFn3ARa
	CxisxadGcbF+h/DL6t4OCPgJ3idJSmU=
Date: Fri, 23 Aug 2024 17:17:26 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] RDMA/rxe: Use sizeof instead of hard code number
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, zyjzyj2000@gmail.com, leonro@nvidia.com
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-2-pizhenwei@bytedance.com>
 <d933e865-2b6b-41c1-a0f2-46f8fef3cc17@linux.dev>
 <20240822123649.GP3773488@nvidia.com>
 <CABoGonKvG9AyuVPMG29b3q5bGr7ZAH5RsGg7TOtkcaAZm9F-Dg@mail.gmail.com>
 <70f73586-670e-43d0-adf4-0950a9b3940d@linux.dev>
 <10810dec-37b5-463f-bc7b-f88d2e4385d9@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <10810dec-37b5-463f-bc7b-f88d2e4385d9@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/23 16:23, zhenwei pi 写道:
>
>
> On 8/23/24 13:56, Zhu Yanjun wrote:
>>
>> 在 2024/8/23 10:30, zhenwei pi 写道:
>>>
>>> On 8/22/24 20:36, Jason Gunthorpe wrote:
>>> > On Thu, Aug 22, 2024 at 07:59:32PM +0800, Zhu Yanjun wrote:
>>> >> 在 2024/8/22 14:52, zhenwei pi 写道:
>>> >>> Use 'sizeof(union rdma_network_hdr)' instead of hard code GRH 
>>> length
>>> >>> for GSI and UD.
>>> >>>
>>> >>> Signed-off-by: zhenwei pi
>>> >>> ---
>>> >>> drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
>>> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> >>>
>>> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/ 
>>> infiniband/sw/rxe/rxe_resp.c
>>> >>> index 6596a85723c9..bf8f4bc8c5c8 100644
>>> >>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>> >>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> >>> @@ -351,7 +351,7 @@ static enum resp_states 
>>> rxe_resp_check_length(struct rxe_qp *qp,
>>> >>> for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>>> >>> recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
>>> >>> - if (payload + 40 > recv_buffer_len) {
>>> >>> + if (payload + sizeof(union rdma_network_hdr) > recv_buffer_len) {
>>> >>
>>> >> The definition of union rdma_network_hdr is as below
>>> >>
>>> >> 797 union rdma_network_hdr {
>>> >> 798 struct ib_grh ibgrh;
>>> >> 799 struct {
>>> >> 800 /* The IB spec states that if it's IPv4, the header
>>> >> 801 * is located in the last 20 bytes of the header.
>>> >> 802 */
>>> >> 803 u8 reserved[20];
>>> >> 804 struct iphdr roce4grh;
>>> >> 805 };
>>> >> 806 };
>>> >>
>>> >> The length is 40 byte.
>>> >
>>> > This looks like the right struct to me if this is talking about the
>>> > special 40 byte blob that is placed in front of UD verbs completions.
>>> >
>>> > Jason
>>>
>>> Yes, this is the front part(40 bytes) of UD/GSI verbs completion.
>>>
>> When running, you can print the value of the front part (40 bytes) of 
>> UD/GSI to confirm that these 40 bytes are the union rdma_network_hdr.
>>
>> If these 40 bytes are the union rdma_network_hdr,
>>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Best Regards,
>>
>> Zhu Yanjun
>>
>
> Hi Yanjun,
>
> I test on mlx-cx5 by command: ibv_ud_pingpong -d mlx5_2 -g 3 -r 1 -n 1
>
> Dump the front 64 bytes:
> 00000000000000000000000000000000000000004502043436f340000111448c
> 0a0b73120a0b73107b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b
>
> Byte[0, 20) (rdma_network_hdr::reserved[20]) are filled by zero, 
> byte[20,40) (rdma_network_hdr::roce4grh) are filled by IPv4 header.

Got it. Thanks a lot.

I am fine with your commit.

Best Regards,

Zhu Yanjun

>
>>>
>>> -- 
>>> zhenwei pi
>>>
>
-- 
Best Regards,
Yanjun.Zhu


