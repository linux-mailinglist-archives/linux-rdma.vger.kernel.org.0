Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804687EC41F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 14:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjKONwn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 08:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjKONwn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 08:52:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD827B3;
        Wed, 15 Nov 2023 05:52:39 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDmIZA027049;
        Wed, 15 Nov 2023 13:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KXn5dn4X8ycSFPLB6sok0nYds37MhbnRCwm2HkJ4QdM=;
 b=nwJf8nc9F9RzLikkQenAEdfCQz/bHz2aH4Tqvbyczr1tu9dwz+cOqZmdybZaRLC4hzSD
 9pXwlQHS2s7PbNprA97o8g/EQ1wbl7gF8unRqRFsj9nZOD5pIIgy9tNT41BQci46wx0p
 fYn++zd1FpesswJstl31aqEsxTjW2B7pThZQvvsHLhDz8JGj8lUbqMnx2xWrytgnKrO/
 ZQchhPuZVbj0BNc451SBCPhAXbMUwOvMPsbK5RKlXwEm36bht5ek22Y1nplnJjFQjD1c
 62XFERExsEj1AaC6Moy0mRWmSfsM910M4siMmVrASpMIRw4hZxChtmAHg8tYWCt3nNwk zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucy6a866v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:52:30 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFDnWMd032085;
        Wed, 15 Nov 2023 13:52:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucy6a865m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:52:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDn7us031626;
        Wed, 15 Nov 2023 13:52:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn1q0up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:52:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFDqREt55640570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 13:52:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C09058054;
        Wed, 15 Nov 2023 13:52:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75FD258052;
        Wed, 15 Nov 2023 13:52:25 +0000 (GMT)
Received: from [9.179.28.193] (unknown [9.179.28.193])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 13:52:25 +0000 (GMT)
Message-ID: <d133643d-0f1b-4cef-bc13-e851a00e2ff9@linux.ibm.com>
Date:   Wed, 15 Nov 2023 14:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/smc: avoid data corruption caused by decline
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
 <05c29431-c941-45d1-8e14-0527accc3993@linux.ibm.com>
 <b3ce2dfe-ece9-919b-024d-051cd66609ed@linux.alibaba.com>
 <3f3080e2-cb2c-16f4-02b1-ca17394d2813@linux.alibaba.com>
 <d099d572-3feb-44a0-8b63-60a18af28943@linux.ibm.com>
 <4fc4e577-1e1f-1f0b-ca0c-1b525fafcce5@linux.alibaba.com>
Content-Language: en-GB
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <4fc4e577-1e1f-1f0b-ca0c-1b525fafcce5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x-w6IZ8PvvQlAekzPGHYh05Wx3ITpjio
X-Proofpoint-ORIG-GUID: 1QUidg2BA_RhSlH3-sNi6yR8y0c-FZCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 14.11.23 10:52, D. Wythe wrote:
> 
> 
> On 11/13/23 6:57 PM, Wenjia Zhang wrote:
>>
>>
>> On 13.11.23 03:50, D. Wythe wrote:
>>>
>>>
>>> On 11/10/23 10:51 AM, D. Wythe wrote:
>>>>
>>>>
>>>> On 11/8/23 9:00 PM, Wenjia Zhang wrote:
>>>>>
>>>>>
>>>>> On 08.11.23 10:48, D. Wythe wrote:
>>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>
>>>>>> We found a data corruption issue during testing of SMC-R on Redis
>>>>>> applications.
>>>>>>
>>>>>> The benchmark has a low probability of reporting a strange error as
>>>>>> shown below.
>>>>>>
>>>>>> "Error: Protocol error, got "\xe2" as reply type byte"
>>>>>>
>>>>>> Finally, we found that the retrieved error data was as follows:
>>>>>>
>>>>>> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
>>>>>> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>>>> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
>>>>>>
>>>>>> It is quite obvious that this is a SMC DECLINE message, which 
>>>>>> means that
>>>>>> the applications received SMC protocol message.
>>>>>> We found that this was caused by the following situations:
>>>>>>
>>>>>> client            server
>>>>>>        proposal
>>>>>>     ------------->
>>>>>>        accept
>>>>>>     <-------------
>>>>>>        confirm
>>>>>>     ------------->
>>>>>> wait confirm
>>>>>>
>>>>>>      failed llc confirm
>>>>>>         x------
>>>>>> (after 2s)timeout
>>>>>>             wait rsp
>>>>>>
>>>>>> wait decline
>>>>>>
>>>>>> (after 1s) timeout
>>>>>>             (after 2s) timeout
>>>>>>         decline
>>>>>>     -------------->
>>>>>>         decline
>>>>>>     <--------------
>>>>>>
>>>>>> As a result, a decline message was sent in the implementation, and 
>>>>>> this
>>>>>> message was read from TCP by the already-fallback connection.
>>>>>>
>>>>>> This patch double the client timeout as 2x of the server value,
>>>>>> With this simple change, the Decline messages should never cross or
>>>>>> collide (during Confirm link timeout).
>>>>>>
>>>>>> This issue requires an immediate solution, since the protocol updates
>>>>>> involve a more long-term solution.
>>>>>>
>>>>>> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the 
>>>>>> LLC flow")
>>>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>>>> ---
>>>>>>   net/smc/af_smc.c | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>>>>> index abd2667..5b91f55 100644
>>>>>> --- a/net/smc/af_smc.c
>>>>>> +++ b/net/smc/af_smc.c
>>>>>> @@ -599,7 +599,7 @@ static int smcr_clnt_conf_first_link(struct 
>>>>>> smc_sock *smc)
>>>>>>       int rc;
>>>>>>         /* receive CONFIRM LINK request from server over RoCE 
>>>>>> fabric */
>>>>>> -    qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
>>>>>> +    qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
>>>>>>                     SMC_LLC_CONFIRM_LINK);
>>>>>>       if (!qentry) {
>>>>>>           struct smc_clc_msg_decline dclc;
>>>>> I'm wondering if the double time (if sufficient) of timeout could 
>>>>> be for waiting for CLC_DECLINE on the client's side. i.e.
>>>>>
>>>>
>>>> It depends. We can indeed introduce a sysctl to allow server to 
>>>> manager their Confirm Link timeout,
>>>> but if there will be protocol updates, this introduction will no 
>>>> longer be necessary, and we will
>>>> have to maintain it continuously.
>>>>
>> no, I don't think, either, that we need a sysctl for that.
> 
> I am okay about that.
> 
>>>> I believe the core of the solution is to ensure that decline 
>>>> messages never cross or collide. Increasing
>>>> the client's timeout by twice as much as the server's timeout can 
>>>> temporarily solve this problem.
>>
>> I have no objection with that, but my question is why you don't 
>> increase the timeout waiting for CLC_DECLINE instead of waiting 
>> LLC_Confirm_Link? Shouldn't they have the same effect?
>>
> 
> Logically speaking, of course, they have the same effect, but there are 
> two reasons that i choose to increase LLC timeout here:
> 
> 1. to avoid DECLINE  cross or collide, we need a bigger time gap, a 
> simple math is
> 
>      2 ( LLC_Confirm_Link) + 1 (CLC_DECLINE) = 3
>      2 (LLC_Confirm_Link)  + 1 * 2 (CLC_DECLINE) = 4
>      2 * 2(LLC_Confirm_Link) + 1 (CLC_DECLINE) = 5
> 
> Obviously, double the LLC_Confirm_Link will result in more time gaps.
> 
That's already clear to me. That's why I stressed "(if sufficient)".

> 2. increase LLC timeout to allow as many RDMA link as possible to 
> succeed, rather than fallback.
> 
ok, that sounds reasonable. And I think that's the answer which 
persuaded me. Thank you!

> D. Wythe
> 
>>>> If Jerry's proposed protocol updates are too complex or if there 
>>>> won't be any future protocol updates,
>>>> it's still not late to let server manager their Confirm Link timeout 
>>>> then.
>>>>
>>>> Best wishes,
>>>> D. Wythe
>>>>
>>>
>>> FYI:
>>>
>>> It seems that my email was not successfully delivered due to some 
>>> reasons. Sorry
>>> for that.
>>>
>>> D. Wythe
>>>
>>>
>>
>>>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>>>> index 35ddebae8894..9b1feef1013d 100644
>>>>> --- a/net/smc/af_smc.c
>>>>> +++ b/net/smc/af_smc.c
>>>>> @@ -605,7 +605,7 @@ static int smcr_clnt_conf_first_link(struct 
>>>>> smc_sock *smc)
>>>>>                 struct smc_clc_msg_decline dclc;
>>>>>
>>>>>                 rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
>>>>> -                                     SMC_CLC_DECLINE, 
>>>>> CLC_WAIT_TIME_SHORT);
>>>>> +                                     SMC_CLC_DECLINE, 2 * 
>>>>> CLC_WAIT_TIME_SHORT);
>>>>>                 return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
>>>>>         }
>>>>>         smc_llc_save_peer_uid(qentry);
>>>>>
>>>>> Because the purpose is to let the server have the control to deline.
>>>>
>>>
> 
