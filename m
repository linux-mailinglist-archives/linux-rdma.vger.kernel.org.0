Return-Path: <linux-rdma+bounces-6665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560049F8A08
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 03:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724EA16ABB2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 02:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC171179BD;
	Fri, 20 Dec 2024 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nWFIm1S/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBB134AC
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660643; cv=none; b=uSaLq2xpSo4rx6RMeEmKHhXivZgflOcB5G5BlVftI/+5+2pOW9cZP3ZJo5tVKMLn+du2mi+yYhSyDmgihnqMa9YXQxmUpdfac6b4XWksO31NpKb0wzNVUVHZOQ1rZyepgQdscpENlpE3mnTS4VeU/fop6k/hg8Z/NxZWpy9bock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660643; c=relaxed/simple;
	bh=s8EUEUsYMdIQ36TA0wF/SSpDOzuAe1HmCC0ft9Rzyyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YumyHSX9DAtnnkkPMZ50x2KVI6YIoED6OrsgmxsWGsmYOYExkP8e4g9EYnkAcHw2/wrGDiQi5fn7dbTOionzuNMXb9rraZaap5NSJC4A7CLxQa18ai9uVyoBGfv/sFilntAjdffH8sgI4iUlUsH8/7C+SkUJQuS78JkdBJoc9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nWFIm1S/; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734660632; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s8EUEUsYMdIQ36TA0wF/SSpDOzuAe1HmCC0ft9Rzyyw=;
	b=nWFIm1S/6rjCYK5S7kgyP4g/y4VJ/vFw+acg1LeskAX4ythZ6hxYROBbTlpLxpskQ5Kxn5me2LgNCGhIO+z8DrO6LxrN99Kgk4QMu1syJ8yi+OvEhsVmCUx1d+pBnD892COjil/M93x8gTbr/8qmP1aNA830Du+kIO1x4zdFaIU=
Received: from 30.221.117.29(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WLs2KEU_1734660631 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 10:10:32 +0800
Message-ID: <677e0a62-b751-14af-f4e2-776fd81516fa@linux.alibaba.com>
Date: Fri, 20 Dec 2024 10:10:31 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next v2 8/8] RDMA/erdma: Support UD QPs and UD WRs
Content-Language: en-US
To: Kees Bakker <kees@ijzerbout.nl>, Boshi Yu <boshiyu@linux.alibaba.com>,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com
References: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
 <20241211020930.68833-9-boshiyu@linux.alibaba.com>
 <3853b8d2-0333-4501-9002-aaa677910bb9@ijzerbout.nl>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <3853b8d2-0333-4501-9002-aaa677910bb9@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/20/24 3:09 AM, Kees Bakker wrote:
> Op 11-12-2024 om 03:09 schreef Boshi Yu:
>> The iWARP protocol supports only RC QPs previously. Now we add UD QPs
>> and UD WRs support for the RoCEv2 protocol.
>>
>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/erdma_cq.c    | 20 +++++++
>>   drivers/infiniband/hw/erdma/erdma_hw.h    | 37 +++++++++++-
>>   drivers/infiniband/hw/erdma/erdma_qp.c    | 71 ++++++++++++++++++-----
>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 29 +++++++--
>>   4 files changed, 136 insertions(+), 21 deletions(-)
>>
>> [...]
>> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
>> index 03d93f026fca..4dfb4272ad86 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_qp.c
>> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
>> @@ -398,17 +398,57 @@ static int fill_sgl(struct erdma_qp *qp, const struct ib_send_wr *send_wr,
>>       return 0;
>>   }
>>   +static void init_send_sqe_rc(struct erdma_qp *qp, struct erdma_send_sqe_rc *sqe,
>> +                 const struct ib_send_wr *wr, u32 *hw_op)
>> +{
>> +    u32 op = ERDMA_OP_SEND;
>> +
>> +    if (wr->opcode == IB_WR_SEND_WITH_IMM) {
>> +        op = ERDMA_OP_SEND_WITH_IMM;
>> +        sqe->imm_data = wr->ex.imm_data;
>> +    } else if (op == IB_WR_SEND_WITH_INV) {
>> +        op = ERDMA_OP_SEND_WITH_INV;
>> +        sqe->invalid_stag = cpu_to_le32(wr->ex.invalidate_rkey);
>> +    }
>> +
>> +    *hw_op = op;
>> +}
>> +
> The else if condition is always false. Is there maybe a typo?

Hi, Kees,

Thanks for pointing out this, and it has been fixed by Advait Dhamorikar.

https://lore.kernel.org/lkml/173461061730.349703.2739528249042727020.b4-ty@kernel.org/T/

Thanks,
Cheng Xu


