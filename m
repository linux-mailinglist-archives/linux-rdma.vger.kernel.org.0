Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4431B48541F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiAEOLn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 09:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiAEOLm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 09:11:42 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A028C061761
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 06:11:42 -0800 (PST)
Message-ID: <6cecca31-3b1a-fc74-4680-d556d2cc977b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641391900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NaRhKvFK90HazenoAFiThDD5xNsEH91c15LVPXbzJCc=;
        b=ecapQdSFioW822Uw/l9gUnWknm2d2XlB5ko5UETEWQvRS2SJOzMsT1lKeam6HfKx2xU349
        VIttnEvpkB72ztjXi4T+NyjLoW4QK01MsrqU2Co5H7A8tzoxkhX2wHSgSw4oDDVzSthdH2
        HDB64OhdlOuWhcEYEEskrO8KQwG3Z6E=
Date:   Wed, 5 Jan 2022 22:11:30 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] RDMA/core: Calculate UDP source port based on flow
 label or lqpn/rqpn
To:     Mark Zhang <markzhang@nvidia.com>, liangwenpeng@huawei.com,
        liweihang@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
 <20220105080727.2143737-2-yanjun.zhu@linux.dev>
 <dee99588-0710-c2b2-17b0-ba9d2f959a79@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <dee99588-0710-c2b2-17b0-ba9d2f959a79@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/1/5 21:51, Mark Zhang 写道:
> On 1/5/2022 4:07 PM, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Calculate and set UDP source port based on the flow label. If flow label
>> is not defined in GRH then calculate it based on lqpn/rqpn.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   include/rdma/ib_verbs.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index 6e9ad656ecb7..2f122aa81f0f 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -4749,6 +4749,23 @@ static inline u32 rdma_calc_flow_label(u32 
>> lqpn, u32 rqpn)
>>       return (u32)(v & IB_GRH_FLOWLABEL_MASK);
>>   }
>>   +/**
>> + * rdma_get_udp_sport - Calculate and set UDP source port based on 
>> the flow
>> + *                      label. If flow label is not defined in GRH then
>> + *                      calculate it based on lqpn/rqpn.
>> + *
>> + * @fl:            flow label from GRH
>
> Indent:
> + * @fl:        flow label from GRH

Thanks. In V2, this problem is fixed.

>
>> + * @lqpn:        local qp number
>> + * @rqpn:        remote qp number
>> + */
>> +static inline u16 rdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
>> +{
>> +    if (!fl)
>> +        fl = rdma_calc_flow_label(lqpn, rqpn);
>> +
>> +    return rdma_flow_label_to_udp_sport(fl);
>> +}
>> + >   const struct ib_port_immutable*
>>   ib_port_immutable_read(struct ib_device *dev, unsigned int port);
>>   #endif /* IB_VERBS_H */
>
> Maybe this and next patch can be squashed into one?

Why do you think this commit and next commit should be squashed into one?

Best Regards,

Zhu Yanjun

