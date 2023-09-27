Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1485F7AFE05
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjI0IRh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjI0IRB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 04:17:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE55212F;
        Wed, 27 Sep 2023 01:15:07 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R7gTHF031164;
        Wed, 27 Sep 2023 08:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=67eu2ybDU1XYjgg2Q/TGZX+vfsvD66d0X+669lZQ+tA=;
 b=o0IpBFuFysvjJL3Ze4IJ3zvNuGXv6+bplRRYbLKXNEXevoj2YkReJKwBHMAnt+b3MGrF
 wRbZWS6hCMFQsCeNZ3bt3axE6SQCl7dlT0nQTROUwtLkTXLsAu4fBxtP8OjsCMHZGYmi
 QjyEc+dmQPO0YNfal6l9stEu2iGtICKa6EeBOqJF+Du0lTDDSQx7CUn7/3bT3l1jGmME
 r7HZcMKI9ynNhD8Mt23WRepaitFqolWOGPwAG3ipFlRXPH6lEOUJ5471qscoNp5Ln5DD
 tEMAAiXKM6+NvEkUNn+w/d+wp/0aGjoXmai4kXV2IxJj2Mw3uZRzwIWsAY1gp708FilH 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcg84933t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:14:56 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38R7wl1p024814;
        Wed, 27 Sep 2023 08:14:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcg84933k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:14:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38R80du9008185;
        Wed, 27 Sep 2023 08:14:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqyj6fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:14:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38R8EpjU20513426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 08:14:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFA0B2004B;
        Wed, 27 Sep 2023 08:14:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9604920040;
        Wed, 27 Sep 2023 08:14:51 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 08:14:51 +0000 (GMT)
Message-ID: <de8af4f8-6ee9-a76e-a9de-9321f4d43bc8@linux.ibm.com>
Date:   Wed, 27 Sep 2023 10:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
To:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
 <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
 <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
 <3d1b5c12-971f-3464-5f28-79477f1f9eb2@linux.ibm.com>
 <c03dad67-169a-bf6d-1915-a9bb722a7259@linux.alibaba.com>
 <d18e1a78-3b3a-8f23-6db1-20c16795d3ef@linux.ibm.com>
 <ab417654-8aba-f357-8ac5-16c4c2b291e1@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ab417654-8aba-f357-8ac5-16c4c2b291e1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RlG49Eg1QZIZi5-mVF4CJgyeputY_zcP
X-Proofpoint-ORIG-GUID: OGM3AD7b1kabLu7RWeN3ua6mIOH2-6qd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxlogscore=693 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270065
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 26.09.23 11:06, D. Wythe wrote:
>> Considering the const, maybe
>>> we need to do :
>>>
>>> 1. hold a refcnt of smc_sock for syn_recv_sock to keep smc sock valid during life time of clc sock
>>> 2. put the refcnt of smc_sock in sk_destruct in tcp_sock to release the very smc sock .
>>>
>>> In that way, we can always make sure the valid of smc sock during the life time of clc sock. Then we can use READ_ONCE rather
>>> than lock.  What do you think ?
>> I am not sure I fully understand the details what you propose to do. And it is not only syn_recv_sock(), right?
>> You need to consider all relations between smc socks and tcp socks; fallback to tcp, initial creation, children of listen sockets, variants of shutdown, ... Preferrably a single simple mechanism covers all situations. Maybe there is such a mechanism already today?
>> (I don't think clcsock->sk->sk_user_data or sk_callback_lock provide this general coverage)
>> If we really have a gap, a general refcnt'ing on smc sock could be a solution, but needs to be designed carefully.
> 
> You are right , we need designed it with care, we will try the referenced solutions internally first, and I will also send some RFCs so that everyone can track the latest progress
> and make it can be all agreed.
>> Many thanks to you and the team to help make smc more stable and robust.
> 
> Our pleasure 😁.  The stability of smc is important to us too.
> 
> Best wishes,
> D. Wythe


Just one more thought: I noticed that 
9744d2bf1976 ("smc: Fix use-after-free in tcp_write_timer_handler().")
states that unlike MPTCP, smc_clcsock_release() does not call __tcp_close().
(which matches your explanation). 
Maybe we something similar to the MPTCP approach could also solve this issue?

