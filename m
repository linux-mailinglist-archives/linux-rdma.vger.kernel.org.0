Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68FA7D00CC
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 19:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjJSRlK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjJSRlI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 13:41:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E2CF;
        Thu, 19 Oct 2023 10:41:06 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JHNp5h017916;
        Thu, 19 Oct 2023 17:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XNxuSWlmwFpqmROgKJVOTG1Nz3hnSDWsr+Z+rZVP7lo=;
 b=cxTD0TFaWM/zkb98jUifI8qBrJi5k0q9QFvPjbgbiYj1nmZTKlZ+g3fshLAyVoQ7/Dm5
 WDUMUHXfS9qvY6biW8/o3GgMCvAh5CCuOglTnai25Gl9U5EwI7jB545XNFAZGXvZ+EoF
 9XDyWsNlGyb6GZkf1NnB0+DtcHxQTeQvbQPUC3kPO0DDctqelFPEOX82BNzvLVpC4CHR
 UHWPwXwuIVv4mVHDp4xgTufULRYJrVFaKI0h3272it9OTEl8vbVoSa0E7ZhIafBMWOlv
 flgPUDkt/YyZJhJJrixcgoGf4GEGPJaPrVU+9BzHHm94c3eHfeMo2+84Gj9ol4qXYHv9 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu8pd0nuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 17:40:55 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JHeHEw004606;
        Thu, 19 Oct 2023 17:40:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu8pd0nuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 17:40:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39JFVHgP019700;
        Thu, 19 Oct 2023 17:40:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr8121yrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 17:40:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39JHerKK20644464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 17:40:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E27258065;
        Thu, 19 Oct 2023 17:40:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418D458052;
        Thu, 19 Oct 2023 17:40:47 +0000 (GMT)
Received: from [9.179.18.71] (unknown [9.179.18.71])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Oct 2023 17:40:47 +0000 (GMT)
Message-ID: <990a6b09-135a-41fb-a375-c37ffec6fe99@linux.ibm.com>
Date:   Thu, 19 Oct 2023 19:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/5] net/smc: put sk reference if close work was
 canceled
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
 <bdcb307f-d2a8-4aef-bb7d-dd87e56ff740@linux.ibm.com>
 <ee641ca5-104b-d1ec-5b2a-e20237c5378a@linux.alibaba.com>
 <ad5e4191-227e-4a62-a110-472618ef7de1@linux.ibm.com>
 <305c7ae2-a902-3e30-5e67-b590d848d0ba@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <305c7ae2-a902-3e30-5e67-b590d848d0ba@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C0quyvYEP4WhzEn6KStJRDVYT6ASe0AI
X-Proofpoint-ORIG-GUID: vYMkW1jrXkGUBppO7mOHdx9bREvSSiN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 19.10.23 09:33, D. Wythe wrote:
> 
> 
> On 10/19/23 4:26 AM, Wenjia Zhang wrote:
>>
>>
>> On 17.10.23 04:06, D. Wythe wrote:
>>>
>>>
>>> On 10/13/23 3:04 AM, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 11.10.23 09:33, D. Wythe wrote:
>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>
>>>>> Note that we always hold a reference to sock when attempting
>>>>> to submit close_work. 
>>>> yes
>>>> Therefore, if we have successfully
>>>>> canceled close_work from pending, we MUST release that reference
>>>>> to avoid potential leaks.
>>>>>
>>>> Isn't the corresponding reference already released inside the 
>>>> smc_close_passive_work()?
>>>>
>>>
>>> Hi Wenjia,
>>>
>>> If we successfully cancel the close work from the pending state,
>>> it means that smc_close_passive_work() has never been executed.
>>>
>>> You can find more details here.
>>>
>>> /**
>>> * cancel_work_sync - cancel a work and wait for it to finish
>>> * @work:the work to cancel
>>> *
>>> * Cancel @work and wait for its execution to finish. This function
>>> * can be used even if the work re-queues itself or migrates to
>>> * another workqueue. On return from this function, @work is
>>> * guaranteed to be not pending or executing on any CPU.
>>> *
>>> * cancel_work_sync(&delayed_work->work) must not be used for
>>> * delayed_work's. Use cancel_delayed_work_sync() instead.
>>> *
>>> * The caller must ensure that the workqueue on which @work was last
>>> * queued can't be destroyed before this function returns.
>>> *
>>> * Return:
>>> * %true if @work was pending, %false otherwise.
>>> */
>>> boolcancel_work_sync(structwork_struct *work)
>>> {
>>> return__cancel_work_timer(work, false);
>>> }
>>>
>>> Best wishes,
>>> D. Wythe
>> As I understand, queue_work() would wake up the work if the work is 
>> not already on the queue. And the sock_hold() is just prio to the 
>> queue_work(). That means, cancel_work_sync() would cancel the work 
>> either before its execution or after. If your fix refers to the former 
>> case, at this moment, I don't think the reference can be hold, thus it 
>> is unnecessary to put it.
>>>
> 
> I am quite confuse about why you think when we cancel the work before 
> its execution,
> the reference can not be hold ?
> 
> 
> Perhaps the following diagram can describe the problem in better way :
> 
> smc_close_cancel_work
> smc_cdc_msg_recv_action
> 
> 
> sock_hold
> queue_work
>                                                                 if 
> (cancel_work_sync())        // successfully cancel before execution
> sock_put()                        //  need to put it since we already 
> hold a ref before   queue_work()
> 
> 
ha, I already thought you might ask such question:P

I think here two Problems need to be clarified:

1) Do you think the bh_lock_sock/bh_unlock_sock in the smc_cdc_msg_recv 
does not protect the smc_cdc_msg_recv_action() from cancel_work_sync()?
Maybe that would go back to the discussion in the other patch on the 
behaviors of the locks.

2) If the queue_work returns true, as I said in the last main, the work 
should be (being) executed. How could the cancel_work_sync() cancel the 
work before execution successgully?

>>>>> Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD link 
>>>>> groups")
>>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>>> ---
>>>>>   net/smc/smc_close.c | 3 ++-
>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>>>>> index 449ef45..10219f5 100644
>>>>> --- a/net/smc/smc_close.c
>>>>> +++ b/net/smc/smc_close.c
>>>>> @@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct 
>>>>> smc_sock *smc)
>>>>>       struct sock *sk = &smc->sk;
>>>>>         release_sock(sk);
>>>>> -    cancel_work_sync(&smc->conn.close_work);
>>>>> +    if (cancel_work_sync(&smc->conn.close_work))
>>>>> +        sock_put(sk);
>>>>>       cancel_delayed_work_sync(&smc->conn.tx_work);
>>>>>       lock_sock(sk);
>>>>>   }
>>>
> 
> 
