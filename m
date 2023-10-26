Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329437D7CF3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 08:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJZGlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGlI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 02:41:08 -0400
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639ABAC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 23:41:06 -0700 (PDT)
Message-ID: <c2eca8cc-1e0f-566b-d00d-16c648044b99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698302463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfgbs/M/14Sm/VVvGh0A75ArYPKvidvFMJbtWFKrNEE=;
        b=Pk6LYgqP/CqGC1kBbJA3zFkHkXoKPBs2l4yfgxQogWIETu5iIVQMNrdmQOBi2UEbvMRqRr
        cbjDKcX6ts7VWnZ0g54SmUnVVjPn3cAew8AhIA2kPw6kXZbsga2BFUjVzgOjT6Hwgxc5dx
        VHqaUllM7zxwZIKyGVjyOHSRog9rEHo=
Date:   Thu, 26 Oct 2023 14:41:00 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-13-guoqing.jiang@linux.dev>
 <SN7PR15MB57559DCCEC92E6B64B30873E99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB57559DCCEC92E6B64B30873E99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
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



On 10/25/23 21:02, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang<guoqing.jiang@linux.dev>
>> Sent: Monday, October 9, 2023 9:18 AM
>> To: Bernard Metzler<BMT@zurich.ibm.com>;jgg@ziepe.ca;leon@kernel.org
>> Cc:linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
>>
>> Factor out a helper to simplify code.
>>
>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_cm.c | 36 +++++++++++++-----------------
>>   1 file changed, 16 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> b/drivers/infiniband/sw/siw/siw_cm.c
>> index 2f338bb3a24c..987084828786 100644
>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -364,6 +364,17 @@ static int siw_cm_upcall(struct siw_cep *cep, enum
>> iw_cm_event_type reason,
>>   	return id->event_handler(id, &event);
>>   }
>>
>> +void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
>> +{
>> +	if (!cep->cm_id)
>> +		return;
>> +
>> +	cep->cm_id->rem_ref(cep->cm_id);
>> +	cep->cm_id = NULL;
> I suggest not including cep_put() here, but to keep
> cep reference counting explicit in the code.
>
>> +	if (put_cep)
>> +		siw_cep_put(cep);
>> +}

Ok, will remove it in next version.

Thanks,
Guoqing
