Return-Path: <linux-rdma+bounces-4506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748E95C7F5
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 10:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B1B1F261B6
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2885144D21;
	Fri, 23 Aug 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W4N/Pu/o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A147773
	for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401389; cv=none; b=XQVatFCg1dBEjEG69mbreHmv6wiZrR1vGjMepFWLQ38r3QrU8ur5Pf4Odjqj9LH3zV6WQOpMKsN3CaKMJtGcIL69RCBE+qBTaDlKgxME7k2JAeTNxAsgaNZcbLTsBeMpop/iUxVxnIiLju+E+qO6pBW9xA4JpWi48xezgwZYF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401389; c=relaxed/simple;
	bh=QGXTkaPruYvdbAjEYNBUg1LJfj52vBR9dyr8zH2c8GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkNicH/EfW06xJr7vQLcgRqP3Y7hYTxmIH7TU+PUvGFuFBtiOuNOyoKiegSlOUa0Qdru/dTrBHo3H2ED1jS3Oq+3/Zeowm28Rn3+4UYQmrErPN2VZk0c7tikoThRXq3AEVGYsRt5JWD804L08ye5sWGdmGVoTPy1og0kikHuyBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W4N/Pu/o; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd8c8b07fbso733525a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724401387; x=1725006187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLOOU3c4VgtE0aDSrc85n2LEe1ifnEKISK8CfLWyb9w=;
        b=W4N/Pu/opcXL7LyHwvi1ImA+i2chAOpKR7hURBYUpGwvXMIwaqpSJKsss/pnX4juut
         RkZUKAE3UHIJqLPQp9aeU53MM5ZCsT1UF7GFQfB/Q3omfwtaQjmcinUrXaQvIKkpixtG
         e8Mx8jNpA5gegMxmeX+4XhjyYrLqBCdVtna39naINiD8sO/Vcc6qNpTVZ9AXhPAswli9
         NytCDjaHDlJDflVH5mjky+Qrx2HGUfRMIEM7ZR6AQIWNQC8CigSTFhPUeTd4OCFlktOU
         lKOovNKifjNj4T9r1YjIIYjLlCnMrKvt4PdzKQ5UltMPQX4gyMAC5dFmatAvMErF+WE0
         Glhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724401387; x=1725006187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLOOU3c4VgtE0aDSrc85n2LEe1ifnEKISK8CfLWyb9w=;
        b=i66swEtvtWBHHgBh3PO5ybYYlPFIlR8mxo0KVVS+qLfbB6ZBUCzpQrsMe7ipXDxw04
         ARrlBsklEV5EodXjbH3jkrJUSnZU/YccYGjapwZUDdRYrdCZwNmjGCsWbVFbFlHBMsBf
         hHvt/WJlUzCtYHkBQA7CLGuCLQe1TBehCPkvOveyHpg+iAZ3JWuF/95skc2O7Uh75daU
         aLADlePqEHcXl6pBql8WKAe2rRXw1hs4bLe8pZS/8eCbMydCux1bo8pTp2y8OXFXF3dq
         pyEJQ+A/E7qoCXwEepq0vd4e/03VMq59ZHpOnTViAFvC8DrvcM4ncqbqAfphc9ppYJqD
         oGWA==
X-Gm-Message-State: AOJu0YzIKWmGTz/D/eDISMPLNEwKwPw90dq4DiMglDxlRusV/nxE75s/
	s4PrF7lKgF5EdPVzMW1IOme5RVwNem+mggeoDtljR3luwaBw+mfZE/TmrtyvSew1ALoaXhrTTcL
	W1a0=
X-Google-Smtp-Source: AGHT+IENUdm5rdulS34yR6Dz4GxtOM56EQg6Uz6YqEoQQmXnbINbba9NJhcmEsBLNkaKSiTGTT2x8g==
X-Received: by 2002:a05:6a20:b598:b0:1c4:b931:e2c4 with SMTP id adf61e73a8af0-1cc8b4bd8bamr1515408637.26.1724401387170;
        Fri, 23 Aug 2024 01:23:07 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac99d0csm2221623a12.12.2024.08.23.01.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:23:06 -0700 (PDT)
Message-ID: <10810dec-37b5-463f-bc7b-f88d2e4385d9@bytedance.com>
Date: Fri, 23 Aug 2024 16:23:03 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/3] RDMA/rxe: Use sizeof instead of hard code number
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, zyjzyj2000@gmail.com, leonro@nvidia.com
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-2-pizhenwei@bytedance.com>
 <d933e865-2b6b-41c1-a0f2-46f8fef3cc17@linux.dev>
 <20240822123649.GP3773488@nvidia.com>
 <CABoGonKvG9AyuVPMG29b3q5bGr7ZAH5RsGg7TOtkcaAZm9F-Dg@mail.gmail.com>
 <70f73586-670e-43d0-adf4-0950a9b3940d@linux.dev>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <70f73586-670e-43d0-adf4-0950a9b3940d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/23/24 13:56, Zhu Yanjun wrote:
> 
> 在 2024/8/23 10:30, zhenwei pi 写道:
>>
>> On 8/22/24 20:36, Jason Gunthorpe wrote:
>> > On Thu, Aug 22, 2024 at 07:59:32PM +0800, Zhu Yanjun wrote:
>> >> 在 2024/8/22 14:52, zhenwei pi 写道:
>> >>> Use 'sizeof(union rdma_network_hdr)' instead of hard code GRH length
>> >>> for GSI and UD.
>> >>>
>> >>> Signed-off-by: zhenwei pi
>> >>> ---
>> >>> drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
>> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/ 
>> infiniband/sw/rxe/rxe_resp.c
>> >>> index 6596a85723c9..bf8f4bc8c5c8 100644
>> >>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> >>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> >>> @@ -351,7 +351,7 @@ static enum resp_states 
>> rxe_resp_check_length(struct rxe_qp *qp,
>> >>> for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
>> >>> recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
>> >>> - if (payload + 40 > recv_buffer_len) {
>> >>> + if (payload + sizeof(union rdma_network_hdr) > recv_buffer_len) {
>> >>
>> >> The definition of union rdma_network_hdr is as below
>> >>
>> >> 797 union rdma_network_hdr {
>> >> 798 struct ib_grh ibgrh;
>> >> 799 struct {
>> >> 800 /* The IB spec states that if it's IPv4, the header
>> >> 801 * is located in the last 20 bytes of the header.
>> >> 802 */
>> >> 803 u8 reserved[20];
>> >> 804 struct iphdr roce4grh;
>> >> 805 };
>> >> 806 };
>> >>
>> >> The length is 40 byte.
>> >
>> > This looks like the right struct to me if this is talking about the
>> > special 40 byte blob that is placed in front of UD verbs completions.
>> >
>> > Jason
>>
>> Yes, this is the front part(40 bytes) of UD/GSI verbs completion.
>>
> When running, you can print the value of the front part (40 bytes) of 
> UD/GSI to confirm that these 40 bytes are the union rdma_network_hdr.
> 
> If these 40 bytes are the union rdma_network_hdr,
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Best Regards,
> 
> Zhu Yanjun
> 

Hi Yanjun,

I test on mlx-cx5 by command: ibv_ud_pingpong -d mlx5_2 -g 3 -r 1 -n 1

Dump the front 64 bytes:
00000000000000000000000000000000000000004502043436f340000111448c
0a0b73120a0b73107b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b7b

Byte[0, 20) (rdma_network_hdr::reserved[20]) are filled by zero, 
byte[20,40) (rdma_network_hdr::roce4grh) are filled by IPv4 header.

>>
>> -- 
>> zhenwei pi
>>


