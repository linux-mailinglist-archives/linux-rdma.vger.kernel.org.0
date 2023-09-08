Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A7798490
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjIHJKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbjIHJKR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 05:10:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900A1BF1;
        Fri,  8 Sep 2023 02:10:05 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38896c9I022792;
        Fri, 8 Sep 2023 09:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HSal6POAnTxn4mXSUvG2CN7NaUOa+qNP4LeSP48EDWM=;
 b=FsqE/aqh4Htlvy5K5IDfkOdm4dNL0HZj8Ont5o9uhPVs5xfS1LrgKqUSHB7mb0qeLDf/
 NAfrSNZ8q52U5EB9RjGKSPBP8kNu7/VPtmw+QhHqp73TYc6D6Mf3KbAd2Io1liWnKxRV
 q2XLqpqSFjevqbPgn9WIq++NToAnzApBPZgc/3oPC+mKwCdVQSsE3MOAa1eRI2p6kTwF
 ixAEQxPoojdIkHWJxKdc614BZlwJhj5dGvfk6xuj7Rttz41wMDREloL4chySSpIFPsJi
 d0Yy2F+7fQM+8NyJwhWjrTuyXKwlTjitdW7j42tUVezhu3wT2Ue3rzxBsdd3tWZoEFbd eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t00gw0d2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:10:01 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38896t9k025091;
        Fri, 8 Sep 2023 09:08:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t00gw0985-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:08:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3888ipmn006651;
        Fri, 8 Sep 2023 09:07:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvm2ahm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 09:07:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38897bJw45351550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 09:07:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC70920043;
        Fri,  8 Sep 2023 09:07:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4349820040;
        Fri,  8 Sep 2023 09:07:37 +0000 (GMT)
Received: from [9.171.2.42] (unknown [9.171.2.42])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  8 Sep 2023 09:07:37 +0000 (GMT)
Message-ID: <794f9f68-4671-5e5e-45e4-2c8a4de568b3@linux.ibm.com>
Date:   Fri, 8 Sep 2023 11:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC net-next 0/2] Optimize the parallelism of SMC-R connections
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1694008530-85087-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ep2os8SGSnpKYVSyUgwoH1m4iVvcnAdH
X-Proofpoint-GUID: ADbQ_6StDG1LXKn67n6JzCEta4tr6Ga-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=734
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080083
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 06.09.23 15:55, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patchset attempts to optimize the parallelism of SMC-R connections
> in quite a SIMPLE way, reduce unnecessary blocking on locks.
> 
> According to Off-CPU statistics, SMC worker's off-CPU statistics
> as that: 
> 
> smc_listen_work 			(48.17%)
> 	__mutex_lock.isra.11 		(47.96%)
> 
> An ideal SMC-R connection process should only block on the IO events
> of the network, but it's quite clear that the SMC-R connection now is
> queued on the lock most of the time.
> 
> Before creating a connection, we always try to see if it can be
> successfully created without allowing the creation of an lgr,
> if so, it means it does not rely on new link group.
> In other words, locking on xxx_lgr_pending is not necessary
> any more.
> 
> Noted that removing this lock will not have an immediate effect
> in the current version, as there are still some concurrency issues
> in the SMC handshake phase. However, regardless, removing this lock
> is a prerequisite for other optimizations.
> 
> If you have any questions or suggestions, please let me know.
> 
> D. Wythe (2):
>   net/smc: refactoring lgr pending lock
>   net/smc: remove locks smc_client_lgr_pending and
>     smc_server_lgr_pending
> 
>  net/smc/af_smc.c   | 24 ++++++++++++------------
>  net/smc/smc_clc.h  |  1 +
>  net/smc/smc_core.c | 28 ++++++++++++++++++++++++++--
>  net/smc/smc_core.h | 21 +++++++++++++++++++++
>  4 files changed, 60 insertions(+), 14 deletions(-)
> 


I have to admit that locking in SMC is quite confusing to me, so this is just my thougths.

Your proposal seems to make things even more complex.

I understand the goal to optimize parallelism.
Today we have the global smc_server/client_lgr_pending AND smc_lgr_list.lock (and more).
There seems to be some overlpa in scope..
Maybe there is some way to reduce the length of the locked paths?
Or use other mechanisms than the big fat smc_server/client_lgr_pending mutex?
e.g.
If you think you can unlock after __smc_conn_create in the re-use-existing_LGR case,
why is the lock needed until after smc_clc_send_confirm in the new-LGR case??


Your use of storing the global lock per ini and then double-freeing it sometimes,
seems a bit homebrewed, though.
E.g. I'm afraid the existing lock checking algorithms could not verify this pattern.

