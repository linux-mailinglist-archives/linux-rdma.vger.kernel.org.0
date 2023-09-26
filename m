Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C483B7AE6FE
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjIZHiF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjIZHiE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 03:38:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07009F3;
        Tue, 26 Sep 2023 00:37:56 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q7OWik023749;
        Tue, 26 Sep 2023 07:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fWR1/uuDBcY3PfqAN7mQ2K/NuZL/nN/N9hnZrtG/ukM=;
 b=Pm3RxKuirlYJznbgUZeqEHWes2ve8xrZp2FH4L9c8+XW5WxVo8berTUrnxYBdDXdSsWO
 ZyRqBUN5WLopFY4XqqsdG9oi6PZo4MTI9ZCrEqwNELFIydcvfTlLPIF3/vyvkfV10Let
 7kpcEmg4sVVEUcJsRScmdzsrsbluVHW4ixXurqEjdjWMBoD+YxAAEFaLAfQ682PQKcPl
 zYDaBf/qonPUgQFmXrwELAozWyyLdu9rHK4R6CAeM1Y4q5Gt+VJpDAL1HQggNDMvOBpf
 b1hoJ+biZ+zp737WS8Rb2lpcN1VF8yrp7f/+Gx2LdBKnzr9HhaKHnb73RXYp1xWgo0eM tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbtvu8c58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:37:52 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38Q7Ze0B024089;
        Tue, 26 Sep 2023 07:37:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbtvu8c4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:37:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q5fQN6008126;
        Tue, 26 Sep 2023 07:37:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqya0u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:37:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38Q7bl8Q45089198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 07:37:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8132920080;
        Tue, 26 Sep 2023 07:37:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55D5B2007A;
        Tue, 26 Sep 2023 07:37:47 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 07:37:47 +0000 (GMT)
Message-ID: <d488ff86-8b99-e669-dfbf-ee05bb7b1536@linux.ibm.com>
Date:   Tue, 26 Sep 2023 09:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC net-next 0/2] Optimize the parallelism of SMC-R connections
Content-Language: en-US
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
 <794f9f68-4671-5e5e-45e4-2c8a4de568b3@linux.ibm.com>
 <522d823c-b656-ffb5-bcce-65b96bdfa46d@linux.alibaba.com>
 <c0ba8e0b-f2b2-b65b-e21a-54c3d920ba72@linux.ibm.com>
 <a3e80a67-e8b8-ce94-fc11-254d056d37a9@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <a3e80a67-e8b8-ce94-fc11-254d056d37a9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HpqpkSkRMLNDjhQjDjslhy6XgQIHzkDi
X-Proofpoint-GUID: NTjuWDrNpg3BuHopxLXWXaKAPm2017Ae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_05,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=499 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260065
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 25.09.23 12:10, D. Wythe wrote:
> That's right.  But even if we do nothing, the current implements still has this problem.
> And this problem can be solved by the spinlock inside smc_conn_create, rather than the
> pending lock.
> 

May I kindly propose to fix this problem first and then do performance improvements after that?


> And also deleting the last connection from a link group will not shutting the down right now,
> usually waiting for 10 minutes of idle time.

Still the new connection could come in just the moment when the 10 minutes are over. 
