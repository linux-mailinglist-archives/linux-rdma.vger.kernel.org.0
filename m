Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9197A9EF8
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjIUUPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 16:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIUUPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 16:15:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7907A43CB4;
        Thu, 21 Sep 2023 10:16:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LCaUDN029973;
        Thu, 21 Sep 2023 12:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iySTcB8YPzCuneBG/HH3M+8tVPuZgnLJvVYQh59frdk=;
 b=tdzvLqZ3rB0vbquq4pgg3CC9893HAupuqpwi9JDn30Gs/98hs4+Zm60Zzgqr2Y7Uwl63
 DXIvJrQzWi4m1+GoRPyqxObiC79ahSA2f6SVo4LM6vgRity/0w9jx7plJKnIBdOD6U6r
 eQ1XgEHKa/mNyERKFbu8jChljAz3zms5wbDmzNtkEyoYcelXBSVkzpkpxL1cqDrNlbbO
 LWaA7bgJw5acMYCNXCU8AX1GgUplt+GWEqT/0b54nO0/yFGlLuwOWn/qRtC+E4JqyiVp
 EUYVwUGQNSGM7fEsZo4PCNE5DaGPumJq1N6t0j2bB/abd0eT9jj6ompYjU9GXwlteahK Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t855eyy66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 12:37:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LCabdW030858;
        Thu, 21 Sep 2023 12:36:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t855eyx3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 12:36:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LBfGVE018185;
        Thu, 21 Sep 2023 12:36:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5ppt9yh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 12:36:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LCab6C59900370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 12:36:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15E372005A;
        Thu, 21 Sep 2023 12:36:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5A5220040;
        Thu, 21 Sep 2023 12:36:36 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 12:36:36 +0000 (GMT)
Message-ID: <c0ba8e0b-f2b2-b65b-e21a-54c3d920ba72@linux.ibm.com>
Date:   Thu, 21 Sep 2023 14:36:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC net-next 0/2] Optimize the parallelism of SMC-R connections
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
 <794f9f68-4671-5e5e-45e4-2c8a4de568b3@linux.ibm.com>
 <522d823c-b656-ffb5-bcce-65b96bdfa46d@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <522d823c-b656-ffb5-bcce-65b96bdfa46d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zQHcU6IWTThM4VmpFRZJtWe-KBM2aC_p
X-Proofpoint-GUID: zFotIsyC8_fziOcjR2d03rmbctIchod0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210111
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 18.09.23 05:58, D. Wythe wrote:
> Hi Alexandra,
> 
> Sorry for the late reply. I have been thinking about the question you mentioned for a while, and this is a great opportunity to discuss this issue.
> My point is that the purpose of the locks is to minimize the expansion of the number of link groups as much as possible.
> 
> As we all know, the SMC-R protocol has the following specifications:
> 
>  * A SMC-R connection MUST be mapped into one link group.
>  * A link group is usually created by a connection, which is also known
>    as "First Contact."
> 
> If we start from scratch, we can design the connection process as follows:
> 
> 1. Check if there are any available link groups. If so, map the
>    connection into it and go to step 3.
> 2. Mark this connection as "First Contact," create a link group, and
>    mark the new link group as unavailable.
> 3. Finish connection establishment.
> 4. If the connection is "First Contact," mark the new link group as
>    available and map the connection into it.
> 
> I think there is no logical problem with this process, but there is a practical issue where burst traffic can result in burst link groups.
> 
> For example, if there are 10,000 incoming connections, based on the above logic, the most extreme scenario would be to create 10,000 link groups.
> This can cause significant memory pressure and even be used for security attacks.
> 
> To address this goal, the simplest way is to make each connection process mutually exclusive, having the following process:
> 
> 1. Block other incoming connections.
> 2. Check if there are any available link groups. If so, map the
>    connection into it and go to step 4.
> 3. Mark this connection as "First Contact," create a link group, and
>    mark it as unavailable.
> 4. Finish connection establishment.
> 5. If the connection is "First Contact," mark the new link group as
>    available and map the connection into it.
> 6. Allow other connections to come in.
> 
> And this is our current process now!
> 
> Regarding the purpose of the locks, to minimize the expansion of the number of link groups. If we agree with this point, we can observe that
> in phase 2 going to phase 4, this process will never create a new link group. Obviously, the lock is not needed here.

Well, you still have issue of a link group going away. Thread 1 is deleting the last connection from a link group and shutting it down. Thread 2 is adding a 'second' connection (from its poitn ov view) to the linkgroup.

> 
> Then the last question: why is the lock needed until after smc_clc_send_confirm in the new-LGR case? We can try to move phase 6 ahead as follows:
> 
> 1. Block other incoming connections.
> 2. Check if there are any available link groups. If so, map the
>    connection into it and go to step 4.
> 3. Mark this connection as "First Contact," create a link group, and
>    mark it as unavailable.
> 4. Allow other connections to come in.
> 5. Finish connection establishment.
> 6. If the connection is "First Contact," mark the new link group as
>    available and map the connection into it.
> 
> There is also no problem with this process! However, note that this logic does not address burst issues.
> Burst traffic will still result in burst link groups because a new link group can only be marked as available when the "First Contact" is completed,
> which is after sending the CLC Confirm.
> 
> Hope my point is helpful to you. If you have any questions, please let me know. Thanks.
> 
> Best wishes,
> D. Wythe

You are asking exactly the right questions here. Creation of new connections is on the critical path,
and if the design can be optimized for parallelism that will increase perfromance, while insufficient
locking will create nasty bugs.
Many programmers have dealt with these issues before us. I would recommend to consult existing proven
patterns; e.g. the ones listed in Paul McKenney's book 
(https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/) 
e.g. 'Chapter 10.3 Read-Mostly Data Structures' and of course the kernel documentation folder.
Improving an existing codebase like smc without breaking is not trivial. Obviuosly a step-by-step approach,
works best. So if you can identify actions that can be be done under a smaller (as in more granular) lock
instead of under a global lock. OR change a mutex into R/W or RCU.
Smaller changes are easier to review (and bisect in case of regressions).


