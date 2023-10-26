Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D237D7D15
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 08:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJZGzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 02:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZGzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 02:55:18 -0400
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2B129
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 23:55:15 -0700 (PDT)
Message-ID: <fae6fdff-6437-b24d-1427-8e954153c32f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698303313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdhnJsWeFpYrU8SmRX64910JlFd78VNRKO/cPWdAIh4=;
        b=wSEQowGawhkX5M6lcyddt4kaoY79NCHb/UUWhzY+EUWt5hn0rx25GVyaZft91+cYghyqUY
        Lzmswmtw4GkUs4yX+phgjBGONq8F8WoWX9SyuUVqgSDpeICwa2eaICRlq0bvGXglFj37Xr
        ekE5LY6bwjkOfGpY2S+v65hto+e5W6Q=
Date:   Thu, 26 Oct 2023 14:55:08 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 18/20] RDMA/siw: Only check attrs->cap.max_send_wr in
 siw_create_qp
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231013020053.2120-19-guoqing.jiang@linux.dev>
 <SN7PR15MB57558847D886D3A0F1882B7099DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB57558847D886D3A0F1882B7099DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/25/23 21:27, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang<guoqing.jiang@linux.dev>
>> Sent: Friday, October 13, 2023 4:01 AM
>> To: Bernard Metzler<BMT@zurich.ibm.com>;jgg@ziepe.ca;leon@kernel.org
>> Cc:linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH V2 18/20] RDMA/siw: Only check attrs-
>>> cap.max_send_wr in siw_create_qp
>> We can just check max_send_wr here given both max_send_wr and
>> max_recv_wr are defined as u32 type, and we also need to ensure
>> num_sqe (derived from max_send_wr) shouldn't be zero.
>>
>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_verbs.c | 18 +++++-------------
>>   1 file changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> b/drivers/infiniband/sw/siw/siw_verbs.c
>> index dcd69fc01176..ef149ed98946 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -333,11 +333,10 @@ int siw_create_qp(struct ib_qp *ibqp, struct
>> ib_qp_init_attr *attrs,
>>   		goto err_atomic;
>>   	}
>>   	/*
>> -	 * NOTE: we allow for zero element SQ and RQ WQE's SGL's
>> -	 * but not for a QP unable to hold any WQE (SQ + RQ)
>> +	 * NOTE: we don't allow for a QP unable to hold any SQ WQE
>>   	 */
>> -	if (attrs->cap.max_send_wr + attrs->cap.max_recv_wr == 0) {
>> -		siw_dbg(base_dev, "QP must have send or receive queue\n");
>> +	if (attrs->cap.max_send_wr == 0) {
>> +		siw_dbg(base_dev, "QP must have send queue\n");
>>   		rv = -EINVAL;
>>   		goto err_atomic;
>>   	}
>> @@ -357,21 +356,14 @@ int siw_create_qp(struct ib_qp *ibqp, struct
>> ib_qp_init_attr *attrs,
>>   	if (rv)
>>   		goto err_atomic;
>>
>> -	num_sqe = attrs->cap.max_send_wr;
>> -	num_rqe = attrs->cap.max_recv_wr;
>>
>>   	/* All queue indices are derived from modulo operations
>>   	 * on a free running 'get' (consumer) and 'put' (producer)
>>   	 * unsigned counter. Having queue sizes at power of two
>>   	 * avoids handling counter wrap around.
>>   	 */
>> -	if (num_sqe)
>> -		num_sqe = roundup_pow_of_two(num_sqe);
>> -	else {
>> -		/* Zero sized SQ is not supported */
>> -		rv = -EINVAL;
>> -		goto err_out_xa;
>> -	}
>> +	num_sqe = roundup_pow_of_two(attrs->cap.max_send_wr);
>> +	num_rqe = attrs->cap.max_recv_wr;
>>   	if (num_rqe)
>>   		num_rqe = roundup_pow_of_two(num_rqe);
>>
>> --
>> 2.35.3
> No the original code allows for a QP which cannot send but
> just receive or vice versa. A QP which cannot send should be allowed.
> Only a QP which cannot do anything should be refused to be created.
> Keep it as is.

Seems it is not consistent with the original code, because Zero sized SQ
(num_seq = 0) is not supported, also num_seq is got from max_send_wr,
which means a QP without sq is not permitted here.

But I probably misunderstood something.

Thanks,
Guoqing

