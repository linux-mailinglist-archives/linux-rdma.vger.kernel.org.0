Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DC4574EE2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiGNNUM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiGNNUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 09:20:12 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0333F5A2DB
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 06:20:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJnf2h_1657804803;
Received: from 30.43.104.223(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VJJnf2h_1657804803)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:20:04 +0800
Message-ID: <23ee6969-c32d-911a-2430-d9e3f6c52a61@linux.alibaba.com>
Date:   Thu, 14 Jul 2022 21:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/siw: Fix duplicated reported
 IW_CM_EVENT_CONNECT_REPLY event
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <BYAPR15MB2631D5F21C907B6145DABE4C99889@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB2631D5F21C907B6145DABE4C99889@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/14/22 8:59 PM, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Cheng Xu <chengyou@linux.alibaba.com>
>> Sent: Thursday, 14 July 2022 03:31
>> To: jgg@ziepe.ca; leon@kernel.org; Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: linux-rdma@vger.kernel.org; chengyou@linux.alibaba.com
>> Subject: [EXTERNAL] [PATCH for-next] RDMA/siw: Fix duplicated reported
>> IW_CM_EVENT_CONNECT_REPLY event
>>
>> If siw_recv_mpa_rr returns -EAGAIN, it means that the MPA reply hasn't
>> been received completely, and should not report IW_CM_EVENT_CONNECT_REPLY
>> in this case. This may trigger a call trace in iw_cm. A simple way to
>> trigger this:
> 
> Great, thanks! I obviously did never hit an incomplete
> MPA hdr. Please make another change to fix it correctly,
> as suggested below.
> 
> 
> case of an incomplete 
>>  server: ib_send_lat
>>  client: ib_send_lat -R <server_ip>
>>
>> The call trace looks like this:
>>
>>  kernel BUG at drivers/infiniband/core/iwcm.c:894!
>>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>  <...>
>>  Workqueue: iw_cm_wq cm_work_handler [iw_cm]
>>  Call Trace:
>>   <TASK>
>>   cm_work_handler+0x1dd/0x370 [iw_cm]
>>   process_one_work+0x1e2/0x3b0
>>   worker_thread+0x49/0x2e0
>>   ? rescuer_thread+0x370/0x370
>>   kthread+0xe5/0x110
>>   ? kthread_complete_and_exit+0x20/0x20
>>   ret_from_fork+0x1f/0x30
>>   </TASK>
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_cm.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> b/drivers/infiniband/sw/siw/siw_cm.c
>> index 17f34d584cd9..f88d2971c2c6 100644
>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -725,11 +725,11 @@ static int siw_proc_mpareply(struct siw_cep *cep)
>>  	enum mpa_v2_ctrl mpa_p2p_mode = MPA_V2_RDMA_NO_RTR;
>>
>>  	rv = siw_recv_mpa_rr(cep);
>> -	if (rv != -EAGAIN)
>> -		siw_cancel_mpatimer(cep);
>>  	if (rv)
>>  		goto out_err;
>>
>> +	siw_cancel_mpatimer(cep);
>> +
> 
> Cancel the MPA timer only if we have a
> real error. -EAGAIN translates to just
> further waiting. So best to add the timer
> cancellation to the error bailout section.
> 
>>  	rep = &cep->mpa.hdr;
>>
>>  	if (__mpa_rr_revision(rep->params.bits) > MPA_REVISION_2) {
>> @@ -895,7 +895,8 @@ static int siw_proc_mpareply(struct siw_cep *cep)
>>  	}
>>
>>  out_err:
>> -	siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -EINVAL);
>> +	if (rv != -EAGAIN)
> {
> cancel MPA timer here.

Indeed we do not need it here, because when siw_proc_mpareply returns error
but not -EAGAIN, the release_cep will be set in the caller (siw_cm_work_handler),
and siw_cancel_mpatimer will be called in the error handle flow.

I think this is better, because the error handle is more unified.

How do you think?

Thanks,
Cheng Xu


> 		siw_cancel_mpatimer(cep);
>> +		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY, -EINVAL);
> }
>>
>>  	return rv;
>>  }
>> --
>> 2.37.0
> 
