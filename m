Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47B7EC561
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjKOOdF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 09:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbjKOOdE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 09:33:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C1181;
        Wed, 15 Nov 2023 06:33:01 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDqmaB006569;
        Wed, 15 Nov 2023 14:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vNYzonvJUeWWqXdSrIhWgKiUlZPWCbFb6OfWF1QU2wo=;
 b=j0K2FEMiOBpvWR95/1fICXEeci5Zx5aIP1NbFmh7N3IuHYlSL5QU0ekMwaV7hZ+mvKIZ
 X0TRaoZeWv+ZuIgQMw2yddDtgF6AkR+PYX7BaoNrizYEpWJsNacMi7fcW+KNwAi/KQmf
 M7zgPdGnEVPMk1Jlyn5W5xXGDGzbEUCEXC/DLSiGdKdt9TpXTPL45/QRT6Bwk0VcmpRV
 qjTnhv4MwoCRC79q105kXrP2CabG6jWtXnDL1ohw/H2ULUQaCFhgsUSL2HKSOqDktzkF
 2GypJmlKWJpmMAJhFFFJvjWJDZ67FwPH3CzwJGOyI0UoLwJAKawC8yTsEyKun+3FiqJ/ OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucy8jh80y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:32:54 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFDrNVV007426;
        Wed, 15 Nov 2023 14:32:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucy8jh7x9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:32:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDnCWN021761;
        Wed, 15 Nov 2023 14:06:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamayfrjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:06:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFE6NZM15336056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:06:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56DF58062;
        Wed, 15 Nov 2023 14:06:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 299CD58064;
        Wed, 15 Nov 2023 14:06:22 +0000 (GMT)
Received: from [9.179.28.193] (unknown [9.179.28.193])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 14:06:21 +0000 (GMT)
Message-ID: <17abf559-ec8b-47e9-b4e4-59adfbc6943b@linux.ibm.com>
Date:   Wed, 15 Nov 2023 15:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/smc: avoid data corruption caused by decline
Content-Language: en-GB
To:     dust.li@linux.alibaba.com, "D. Wythe" <alibuda@linux.alibaba.com>,
        kgraul@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
 <20231113034457.GA121324@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231113034457.GA121324@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZDCrUeiQ7dAQAE5ASA8qYCsHI89K-Sqp
X-Proofpoint-ORIG-GUID: e0uqV9OKo_tYLh6jovTcpsmKQ0EjH5fF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 13.11.23 04:44, Dust Li wrote:
> On Wed, Nov 08, 2023 at 05:48:29PM +0800, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> We found a data corruption issue during testing of SMC-R on Redis
>> applications.
>>
>> The benchmark has a low probability of reporting a strange error as
>> shown below.
>>
>> "Error: Protocol error, got "\xe2" as reply type byte"
>>
>> Finally, we found that the retrieved error data was as follows:
>>
>> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
>> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
>>
>> It is quite obvious that this is a SMC DECLINE message, which means that
>> the applications received SMC protocol message.
>> We found that this was caused by the following situations:
>>
>> client			server
>> 	   proposal
>> 	------------->
>> 	   accept
>> 	<-------------
>> 	   confirm
>> 	------------->
>> wait confirm
>>
>> 	 failed llc confirm
>> 	    x------
>> (after 2s)timeout
>> 			wait rsp
>>
>> wait decline
>>
>> (after 1s) timeout
>> 			(after 2s) timeout
>> 	    decline
>> 	-------------->
>> 	    decline
>> 	<--------------
>>
>> As a result, a decline message was sent in the implementation, and this
>> message was read from TCP by the already-fallback connection.
>>
>> This patch double the client timeout as 2x of the server value,
>> With this simple change, the Decline messages should never cross or
>> collide (during Confirm link timeout).
>>
>> This issue requires an immediate solution, since the protocol updates
>> involve a more long-term solution.
>>
>> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>> net/smc/af_smc.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index abd2667..5b91f55 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -599,7 +599,7 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
>> 	int rc;
>>
>> 	/* receive CONFIRM LINK request from server over RoCE fabric */
>> -	qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
>> +	qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
>> 			      SMC_LLC_CONFIRM_LINK);
> 
> It may be difficult for people to understand why LLC_WAIT_TIME is
> different, especially without any comments explaining its purpose.
> People are required to use git to find the reason, which I believe is
> not conducive to easy maintenance.
> 
> Best regards,
> Dust
> 
> 
Good point! @D.Wythe, could you please try to add a simple commet to 
explain it?

Thanks,
Wenjia
> 
>> 	if (!qentry) {
>> 		struct smc_clc_msg_decline dclc;
>> -- 
>> 1.8.3.1
