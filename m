Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D07AE6A0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjIZHTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 03:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIZHTK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 03:19:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C51DE;
        Tue, 26 Sep 2023 00:19:03 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q7A15E015626;
        Tue, 26 Sep 2023 07:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DwDcd930NdzNkQaREgPfs7I2dqCv/G7qRVY8hh7bIy0=;
 b=XAXbL3iCiDtdB4ZguTEJ9+ng4Pa4WeflaXcz9Tp/3XIGfMXVHWFAoYPIuQI7P/ii04Fl
 IaasmTXMWy9UfNnwfuaOFB469LHGa7KYL3L8cwurLwh0eBUjJvdTxbkbGQmkqfZgGNlD
 dQgFEOUjGsb9aPa8PPceABBjY55ZZqfw8o8uo+/vnjhAThqcFKApUjJkwXuJ3FKJfZ4G
 LnXsyVYHKhkStt61zRBI8jmnISMMNnx3Mk2+2jJ4fHKD8ipDpe8AtBNGWS+qTWToOYsg
 AQkOSwATjN2DFYBb3CGV7SyOJdUFS5XCBa8DRsfEvAl6IanoVwVFHGxz+0o1LQKrx8+a 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbtnxgbcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:18:52 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38Q7A9m0016469;
        Tue, 26 Sep 2023 07:18:52 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbtnxgbck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:18:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q4xNt2008386;
        Tue, 26 Sep 2023 07:18:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabsj1cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:18:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38Q7Im3q45547926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 07:18:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 679502004B;
        Tue, 26 Sep 2023 07:18:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 388AF20049;
        Tue, 26 Sep 2023 07:18:48 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 07:18:48 +0000 (GMT)
Message-ID: <d18e1a78-3b3a-8f23-6db1-20c16795d3ef@linux.ibm.com>
Date:   Tue, 26 Sep 2023 09:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Content-Language: en-US
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
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <c03dad67-169a-bf6d-1915-a9bb722a7259@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BMaaFTI2aHsZSinIykFdLODB2dlnw9Fx
X-Proofpoint-ORIG-GUID: NGi10lIQGMU5B0CvHARjXWTEpb40cirI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_05,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=843
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260062
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 26.09.23 05:00, D. Wythe wrote:
> You are right. The key point is how to ensure the valid of smc sock during the life time of clc sock, If so, READ_ONCE is good
> enough. Unfortunately, I found  that there are no such guarantee, so it's still a life-time problem.  

Did you discover a scenario, where clc sock could live longer than smc sock? 
Wouldn't that be a dangerous scenario in itself? I still have some hope that the lifetime of an smc socket is by design longer
than that of the corresponding tcp socket.

Considering the const, maybe
> we need to do :
> 
> 1. hold a refcnt of smc_sock for syn_recv_sock to keep smc sock valid during life time of clc sock
> 2. put the refcnt of smc_sock in sk_destruct in tcp_sock to release the very smc sock .
> 
> In that way, we can always make sure the valid of smc sock during the life time of clc sock. Then we can use READ_ONCE rather
> than lock.  What do you think ?

I am not sure I fully understand the details what you propose to do. And it is not only syn_recv_sock(), right?
You need to consider all relations between smc socks and tcp socks; fallback to tcp, initial creation, children of listen sockets, variants of shutdown, ... Preferrably a single simple mechanism covers all situations. Maybe there is such a mechanism already today?
(I don't think clcsock->sk->sk_user_data or sk_callback_lock provide this general coverage)
If we really have a gap, a general refcnt'ing on smc sock could be a solution, but needs to be designed carefully.

Many thanks to you and the team to help make smc more stable and robust.
