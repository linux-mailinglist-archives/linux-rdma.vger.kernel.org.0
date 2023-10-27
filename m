Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220507D9938
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJ0ND2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0ND1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 09:03:27 -0400
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9D10E
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 06:03:25 -0700 (PDT)
Message-ID: <85544915-a777-d19d-dde4-bd2bfb37a675@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698411804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yc9J6Wl5w0Qqh7M+AmbYG4mXyIkqjq+x+O92AKPp5Zw=;
        b=oPvvVuEWX6r9TwuI6y3E6UjajaRUq7/kSYJNKIlSMVDnvY1i7uzMP0NygyD0yIf8nM9Bib
        yncSryRizYYeZY6bSAwo+g+8EypbQVumRfdn+NQGU8tc4InsGycAqAIMK9jkmnakEOJ7ib
        e6piAiUS9HEkD6Zuu+7gtiAehHnpHzw=
Date:   Fri, 27 Oct 2023 21:03:21 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V3 12/18] RDMA/siw: Introduce siw_free_cm_id
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-13-guoqing.jiang@linux.dev>
 <SN7PR15MB57558DB29895931CEBD33E6299DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <SN7PR15MB57558DB29895931CEBD33E6299DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/27/23 20:40, Bernard Metzler wrote:
>
>> -----Original Message-----
>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Sent: Friday, October 27, 2023 4:33 AM
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
>> Cc: linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH V3 12/18] RDMA/siw: Introduce siw_free_cm_id
>>
>> Factor out a helper to simplify code.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: INVALID URI REMOVED
>> 3A__lore.kernel.org_oe-2Dkbuild-2Dall_202310091656.JlrmcNXB-2Dlkp-
>> 40intel.com_&d=DwIDAg&c=jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-
>> r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&m=jcLol9KAEfaBk2TluRpduOxKYYBXhnRmUiRsGk
>> F1es3nam0Db9DqJGrHbGh6Dxev&s=046yLPELHuHW8OJFi9dwmPygAP11lnZQi6DpfngHzJ8&e=
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_cm.c | 34 +++++++++++++-----------------
>>   1 file changed, 15 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> b/drivers/infiniband/sw/siw/siw_cm.c
>> index 2f338bb3a24c..1d2438fbf7c7 100644
>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -364,6 +364,15 @@ static int siw_cm_upcall(struct siw_cep *cep, enum
>> iw_cm_event_type reason,
>>   	return id->event_handler(id, &event);
>>   }
>>
>> +static void siw_free_cm_id(struct siw_cep *cep)
>> +{
>> +	if (!cep->cm_id)
>> +		return;
>> +
>> +	cep->cm_id->rem_ref(cep->cm_id);
>> +	cep->cm_id = NULL;
>> +}
>> +
>>   /*
>>    * siw_qp_cm_drop()
>>    *
>> @@ -415,8 +424,7 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
>>   			default:
>>   				break;
>>   			}
>> -			cep->cm_id->rem_ref(cep->cm_id);
>> -			cep->cm_id = NULL;
>> +			siw_free_cm_id(cep);
>>   			siw_cep_put(cep);
>>   		}
>>   		cep->state = SIW_EPSTATE_CLOSED;
>> @@ -1175,11 +1183,8 @@ static void siw_cm_work_handler(struct work_struct
>> *w)
>>   			sock_release(cep->sock);
>>   			cep->sock = NULL;
>>   		}
>> -		if (cep->cm_id) {
>> -			cep->cm_id->rem_ref(cep->cm_id);
>> -			cep->cm_id = NULL;
>> -			siw_cep_put(cep);
>> -		}
>> +		siw_free_cm_id(cep);
>> +		siw_cep_put(cep);
> We must decrement the cep reference only if it had referenced
> a cm_id. So here we need to put both into ' if (cep->cm_id) {'
> clause again.

You are right, I somehow overlooked this ..

Thanks,
Guoqing
