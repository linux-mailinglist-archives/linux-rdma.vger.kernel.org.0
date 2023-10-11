Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8992D7C559E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjJKNkZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjJKNkY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 09:40:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455B90;
        Wed, 11 Oct 2023 06:40:22 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BDdFK1031865;
        Wed, 11 Oct 2023 13:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/90o0hhysJ2dZfkY8PrUixl+/WqjqmE0aM1GMqw2c7w=;
 b=E9O1snVVipWPvrj4FYzQGyNN/seYY8CkGCxjRKZyqoPZvDK3zsH2BYnCnTz792/shDOc
 kS+zAIxtfX+40gDeHtx3QMiK28MRCzNt4Ri1X06/Sn5jopvXqJwwKeY26hQok6naz11Z
 WaOAVdft7/M63s0traNn2HA3cf+5TyJ48n4/pEWFY2yeP6tSOsDOkJFS3tWF0OfRai2R
 +l+kLxYeirPaHbDJnp5+aENqYKvU5VDeOAUtO6l2xNF5IcxWHhZM+SgTH0Mtq86We9fY
 C66uxC7KAWrUkOlsSO3A1zsAc+H9fyuJY5V47GJ+ojMvmFK2xgBNzLJIMsN8WGKMIT24 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnvmd88sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 13:40:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BDdUHb001580;
        Wed, 11 Oct 2023 13:39:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnvmd86x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 13:39:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BBI8rQ025907;
        Wed, 11 Oct 2023 12:39:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnfygg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 12:39:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BCdP4r50004436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 12:39:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB7F35805D;
        Wed, 11 Oct 2023 12:39:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 333AD5805F;
        Wed, 11 Oct 2023 12:39:23 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Oct 2023 12:39:23 +0000 (GMT)
Message-ID: <a86a0aff-803d-478c-b26b-d42cb5301070@linux.ibm.com>
Date:   Wed, 11 Oct 2023 14:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
From:   Wenjia Zhang <wenjia@linux.ibm.com>
To:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Cc:     jaka@linux.ibm.com, kgraul@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
 <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
 <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
 <3d1b5c12-971f-3464-5f28-79477f1f9eb2@linux.ibm.com>
 <c03dad67-169a-bf6d-1915-a9bb722a7259@linux.alibaba.com>
 <d18e1a78-3b3a-8f23-6db1-20c16795d3ef@linux.ibm.com>
 <ab417654-8aba-f357-8ac5-16c4c2b291e1@linux.alibaba.com>
 <b4470cec-7b9b-5ce5-01e0-9270f6564fbb@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <b4470cec-7b9b-5ce5-01e0-9270f6564fbb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8JmgypN6CUuRdZmEpe8JLx2eBwaAd5gN
X-Proofpoint-ORIG-GUID: Q55UimvUzsBVm5Vb8hBivFtTsU47jCly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 05.10.23 20:14, Wenjia Zhang wrote:
>> 
>> 
>> On 26.09.23 11:06, D. Wythe wrote:
>>>
>>>
>>> On 9/26/23 3:18 PM, Alexandra Winter wrote:
>>>>
>>>> On 26.09.23 05:00, D. Wythe wrote:
>>>>> You are right. The key point is how to ensure the valid of smc sock 
>>>>> during the life time of clc sock, If so, READ_ONCE is good
>>>>> enough. Unfortunately, I found  that there are no such guarantee, so 
>>>>> it's still a life-time problem.
>>>> Did you discover a scenario, where clc sock could live longer than 
>>>> smc sock?
>>>> Wouldn't that be a dangerous scenario in itself? I still have some 
>>>> hope that the lifetime of an smc socket is by design longer
>>>> than that of the corresponding tcp socket.
>>>
>>>
>>> Hi Alexandra,
>>>
>>> Yes there is. Considering scenario:
>>>
>>> tcp_v4_rcv(skb)
>>>
>>> /* req sock */
>>> reqsk = _inet_lookup_skb(skb)
>>>
>>> /* listen sock */
>>> sk = reqsk(reqsk)->rsk_listener;
>>> sock_hold(sk);
>>> tcp_check_req(sk)
>>>
>>>
>>>                                                  smc_release /* 
>>> release smc listen sock */
>>>                                                  __smc_release
>>> smc_close_active()         /*  smc_sk->sk_state = SMC_CLOSED; */
>>>                                                      if 
>>> (smc_sk->sk_state == SMC_CLOSED)
>>> smc_clcsock_release();
>>> sock_release(clcsk);        /* close clcsock */
>>>      sock_put(sk);              /* might not  the final refcnt */
>>>
>>> sock_put(smc_sk)    /* might be the final refcnt of smc_sock  */
>>>
>>> syn_recv_sock(sk...)
>>> /* might be the final refcnt of tcp listen sock */
>>> sock_put(sk);
>>>
>>> Fortunately, this scenario only affects smc_syn_recv_sock and 
>>> smc_hs_congested, as other callbacks already have locks to protect smc,
>>> which can guarantee that the sk_user_data is either NULL (set in 
>>> smc_close_active) or valid under the lock.
>>> I'm kind of confused with this scenario. How could the 
>> smc_clcsock_release()->sock_release(clcsk) happen?
>> Because the syn_recv_sock happens short prior to accept(), that means 
>> that the &smc->tcp_listen_work is already triggered but the real 
>> accept() is still not happening. At this moment, the incoming connection 
>> is being added into the accept queue. Thus, if the sk->sk_state is 
>> changed from SMC_LISTEN to SMC_CLOSED in smc_close_active(), there is 
>> still "flush_work(&smc->tcp_listen_work);" after that. That ensures the 
>> smc_clcsock_release() should not happen, if smc_clcsock_accept() is not 
>> finished. Do you think that the execution of the &smc->tcp_listen_work 
>> is already done? Or am I missing something?
>>  > Hi wenjia,
 >
 > Sorry for late reply, we have just returned from vacation.
 >
 > The smc_clcsock_release here release the listen clcsock rather than
 > the child clcsock.
 > So the flush_work might not be helpful for this scenario.
 >
 > Best wishes,
 > D. Wythe

It seems like that I lost some mails these days :-( Just saw your answer.

Maybe I didn't describe my thought clearly. Following data flow is your 
scenario, right?
			–
(sk_state == SMC_LISTEN)|
tcp_check_req()		| smc_release()
			| ->__smc_release()
			|   -> smc_close_active()
			|     -> sk->sk_state = SMC_CLOSED;
			|     -> ...
			|     -> smc->clcsock->sk->sk_user_data = NULL;
			|     -> ...
			|*1)  -> flush_work(&smc->tcp_listen_work);
			|*4)
			|	-> smc_clcsock_accept()
	    		|         -> kernel_accept()
			| 	    -> inet_csk_accept()
			|*5)
			|   if (sk->sk_state == SMC_CLOSED)
			|*3)-> smc_clcsock_release()
-> syn_recv_sock()   *2)|
			|
			v
My question is how the smc_clcsock_release() could happen after the 
syn_recv_sock()?
IMO, the syn_recv_sock() should be called during the 
&smc->tcp_listen_work, which is corresponding to lsmc (listen smc). And 
in smc_clcsock_accept(), the lsmc->clcsock as the listening socket goes 
on to be used to accept a new connection. If the &smc->tcp_listen_work 
is not finished, *1) will wait for its finishing. It can only happen in 
following situation:
*4) sk_state is SMC_CLOSED, then no connection is accepted.
*5) old sk_state is SMC_LISTEN, TCP accept is successful. But current 
sk_state is SMC_CLOSED. Thus, no new smc connection.

What do you think? Please let me know if I have any lapse of thought.

Thanks,
Wenjia
