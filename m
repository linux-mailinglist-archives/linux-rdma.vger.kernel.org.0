Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065E57BA8DE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjJESPY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 14:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjJESOt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 14:14:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBD490;
        Thu,  5 Oct 2023 11:14:48 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IATn3009789;
        Thu, 5 Oct 2023 18:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+L4uBN3V6SGI+UzD1bnXmWtYj0cde2bUpvKlk/TPzJ0=;
 b=tWknqM8xVf8eXnsHxPcSs+bCLDcGgWUVaAoywcvdi+NpqumGRm6u2ER76g+8LJhBhgw4
 OJYdN1EwC/la1p66EfxiHo7PeV9F2eprPWnHv3Pydp+fzYpMBIQImVUaiYDL40Z1nwr8
 cx3HkbvhWb+0rZb//z9023DJpXrHSLw78uO/pd5nr4PVFOMKciJgsR1TrAQINYbnbjJQ
 XzmM7Wxv3Ny7Op11iKBpjd6N9UwN3IH/392/cWUczoTZCWdXCaEqZfrXFiD+iwu5x5N5
 xGRmiMM6zj4ug9oz332kRfFKBayGQfa9E8NM1UMRpzCLc3z0y3bEo3V+L9QhuM0h4aaU 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj26h866n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 18:14:43 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395IAXfk010416;
        Thu, 5 Oct 2023 18:14:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj26h8664-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 18:14:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395HstF9005868;
        Thu, 5 Oct 2023 18:14:42 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0tgjug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 18:14:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395IEed42622178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 18:14:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E79E58062;
        Thu,  5 Oct 2023 18:14:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9B3B58052;
        Thu,  5 Oct 2023 18:14:38 +0000 (GMT)
Received: from [9.171.41.118] (unknown [9.171.41.118])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 18:14:38 +0000 (GMT)
Message-ID: <b4470cec-7b9b-5ce5-01e0-9270f6564fbb@linux.ibm.com>
Date:   Thu, 5 Oct 2023 20:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
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
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <ab417654-8aba-f357-8ac5-16c4c2b291e1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wMYgbD3jlaPQC1CoZLS2I20axn_izngw
X-Proofpoint-GUID: eshURJbDpCklhdltI2Sf_VWvncdgshg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_12,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050137
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 26.09.23 11:06, D. Wythe wrote:
> 
> 
> On 9/26/23 3:18 PM, Alexandra Winter wrote:
>>
>> On 26.09.23 05:00, D. Wythe wrote:
>>> You are right. The key point is how to ensure the valid of smc sock 
>>> during the life time of clc sock, If so, READ_ONCE is good
>>> enough. Unfortunately, I found  that there are no such guarantee, so 
>>> it's still a life-time problem.
>> Did you discover a scenario, where clc sock could live longer than smc 
>> sock?
>> Wouldn't that be a dangerous scenario in itself? I still have some 
>> hope that the lifetime of an smc socket is by design longer
>> than that of the corresponding tcp socket.
> 
> 
> Hi Alexandra,
> 
> Yes there is. Considering scenario:
> 
> tcp_v4_rcv(skb)
> 
> /* req sock */
> reqsk = _inet_lookup_skb(skb)
> 
> /* listen sock */
> sk = reqsk(reqsk)->rsk_listener;
> sock_hold(sk);
> tcp_check_req(sk)
> 
> 
>                                                  smc_release /* release 
> smc listen sock */
>                                                  __smc_release
> smc_close_active()         /*  smc_sk->sk_state = SMC_CLOSED; */
>                                                      if 
> (smc_sk->sk_state == SMC_CLOSED)
> smc_clcsock_release();
> sock_release(clcsk);        /* close clcsock */
>      sock_put(sk);              /* might not  the final refcnt */
> 
> sock_put(smc_sk)    /* might be the final refcnt of smc_sock  */
> 
> syn_recv_sock(sk...)
> /* might be the final refcnt of tcp listen sock */
> sock_put(sk);
> 
> Fortunately, this scenario only affects smc_syn_recv_sock and 
> smc_hs_congested, as other callbacks already have locks to protect smc,
> which can guarantee that the sk_user_data is either NULL (set in 
> smc_close_active) or valid under the lock.
> I'm kind of confused with this scenario. How could the 
smc_clcsock_release()->sock_release(clcsk) happen?
Because the syn_recv_sock happens short prior to accept(), that means 
that the &smc->tcp_listen_work is already triggered but the real 
accept() is still not happening. At this moment, the incoming connection 
is being added into the accept queue. Thus, if the sk->sk_state is 
changed from SMC_LISTEN to SMC_CLOSED in smc_close_active(), there is 
still "flush_work(&smc->tcp_listen_work);" after that. That ensures the 
smc_clcsock_release() should not happen, if smc_clcsock_accept() is not 
finished. Do you think that the execution of the &smc->tcp_listen_work 
is already done? Or am I missing something?

>> Considering the const, maybe
>>> we need to do :
>>>
>>> 1. hold a refcnt of smc_sock for syn_recv_sock to keep smc sock valid 
>>> during life time of clc sock
>>> 2. put the refcnt of smc_sock in sk_destruct in tcp_sock to release 
>>> the very smc sock .
>>>
>>> In that way, we can always make sure the valid of smc sock during the 
>>> life time of clc sock. Then we can use READ_ONCE rather
>>> than lock.  What do you think ?
>> I am not sure I fully understand the details what you propose to do. 
>> And it is not only syn_recv_sock(), right?
>> You need to consider all relations between smc socks and tcp socks; 
>> fallback to tcp, initial creation, children of listen sockets, 
>> variants of shutdown, ... Preferrably a single simple mechanism covers 
>> all situations. Maybe there is such a mechanism already today?
>> (I don't think clcsock->sk->sk_user_data or sk_callback_lock provide 
>> this general coverage)
>> If we really have a gap, a general refcnt'ing on smc sock could be a 
>> solution, but needs to be designed carefully.
> 
> You are right , we need designed it with care, we will try the 
> referenced solutions internally first, and I will also send some RFCs so 
> that everyone can track the latest progress
> and make it can be all agreed.
>> Many thanks to you and the team to help make smc more stable and robust.
> 
> Our pleasure 😁.  The stability of smc is important to us too.
> 
> Best wishes,
> D. Wythe
> 
> 
