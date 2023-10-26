Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A1D7D7CF7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJZGm5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGm4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 02:42:56 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 23:42:53 PDT
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D00AC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 23:42:53 -0700 (PDT)
Message-ID: <354714dd-3f9d-9083-97f6-5b9d543563f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698302571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZMjQkpz505ENPp/vMXOaGFuSUzVzNeqQqkEGfcgcUo=;
        b=PQF5RayzJMSOOeYwt3jPvXFcMZcF6gMaVeKWNR1Au25gFwptNVi0AEdbcCvDSIwJk1e+SP
        4Rtmf2BtjbLbVcEmhj1xblpLRqUSQa8XxXvO3dvYSpj+9TKmEcZ/A/AqiPLq0UQ1Mtc91X
        YudGfCioZva4ncl+UAm/3oq5rAqPmYo=
Date:   Thu, 26 Oct 2023 14:42:48 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 13/19] RDMA/siw: Simplify siw_qp_id2obj
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-14-guoqing.jiang@linux.dev>
 <SN7PR15MB5755FBAC40BA3C94DFE20DE799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB5755FBAC40BA3C94DFE20DE799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
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



On 10/25/23 21:04, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang<guoqing.jiang@linux.dev>
>> Sent: Monday, October 9, 2023 9:18 AM
>> To: Bernard Metzler<BMT@zurich.ibm.com>;jgg@ziepe.ca;leon@kernel.org
>> Cc:linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH 13/19] RDMA/siw: Simplify siw_qp_id2obj
>>
>> Let's set qp and return it.
>>
>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw.h | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw.h
>> b/drivers/infiniband/sw/siw/siw.h
>> index 44684b74550f..e127ef493296 100644
>> --- a/drivers/infiniband/sw/siw/siw.h
>> +++ b/drivers/infiniband/sw/siw/siw.h
>> @@ -601,12 +601,10 @@ static inline struct siw_qp *siw_qp_id2obj(struct
>> siw_device *sdev, int id)
>>
>>   	rcu_read_lock();
>>   	qp = xa_load(&sdev->qp_xa, id);
>> -	if (likely(qp && kref_get_unless_zero(&qp->ref))) {
>> -		rcu_read_unlock();
>> -		return qp;
>> -	}
>> +	if (likely(qp && !kref_get_unless_zero(&qp->ref)))
>> +		qp = NULL;
>>   	rcu_read_unlock();
>> -	return NULL;
>> +	return qp;
>>   }
>>
>>   static inline u32 qp_id(struct siw_qp *qp)
>> --
>> 2.35.3
> No let's keep it as is. It openly codes the likely case
> first.
>
> Your code makes the unlikely thing likely.

How about change likely to unlikely? If not, I will drop both 13 and 14.

Thanks,
Guoqing
