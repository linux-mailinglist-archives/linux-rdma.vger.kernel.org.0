Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603517E57AD
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbjKHNEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 08:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbjKHNEO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 08:04:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375D1FD7;
        Wed,  8 Nov 2023 05:04:11 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8Cf27k012360;
        Wed, 8 Nov 2023 13:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5Nn8m0Am600Bnx9YKqymeN1ILa5QqX61g+i3Sxs3PbY=;
 b=TlNJ9OUorHAnP+uE2ZimFj1rpcPwCg4ZSLLMi4Yy0BjVUyG0/ATHOQYK8+wrZCTgEtRS
 szwKVaFBjbETJnQsyabuhnLjbTyX6h6N/tgETMBXVZGECL2tuKSI7KkTerwp7gYyhDzH
 5OhPrDCLjJ1sJuA/LqmdF61GfQkkJ54hrDnH8hgnFRlQ4cMr64/joMws7pkCYfc1gnjx
 akgWmvzWaUlEmJP4pvmqY65UobAT1IFSa24dJJTwKzNBs43pqs1ZPHJwrsT2kJ1gxqaR
 4naoU86uBRlLwNLTObmdnrXhfEgHJ37hKh0HAthR2BDyylDmWrBU1jFyUFYlcyy7r62a 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8abph46f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 13:04:07 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A8CfpaT015654;
        Wed, 8 Nov 2023 13:01:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8abph41e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 13:01:06 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8BeKYn003435;
        Wed, 8 Nov 2023 13:01:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21vsq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 13:01:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8D102Z41877762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 13:01:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD54558043;
        Wed,  8 Nov 2023 13:01:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DF6758053;
        Wed,  8 Nov 2023 13:00:59 +0000 (GMT)
Received: from [9.155.210.178] (unknown [9.155.210.178])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Nov 2023 13:00:59 +0000 (GMT)
Message-ID: <05c29431-c941-45d1-8e14-0527accc3993@linux.ibm.com>
Date:   Wed, 8 Nov 2023 14:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/smc: avoid data corruption caused by decline
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1699436909-22767-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IX57UdHS1tUn_gPYZ3-gU-vI3BQ-VaBu
X-Proofpoint-GUID: A9BPy8xGtgNW8-vhtwnwMx9Cf7Xa7WtR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 08.11.23 10:48, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We found a data corruption issue during testing of SMC-R on Redis
> applications.
> 
> The benchmark has a low probability of reporting a strange error as
> shown below.
> 
> "Error: Protocol error, got "\xe2" as reply type byte"
> 
> Finally, we found that the retrieved error data was as follows:
> 
> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
> 
> It is quite obvious that this is a SMC DECLINE message, which means that
> the applications received SMC protocol message.
> We found that this was caused by the following situations:
> 
> client			server
> 	   proposal
> 	------------->
> 	   accept
> 	<-------------
> 	   confirm
> 	------------->
> wait confirm
> 
> 	 failed llc confirm
> 	    x------
> (after 2s)timeout
> 			wait rsp
> 
> wait decline
> 
> (after 1s) timeout
> 			(after 2s) timeout
> 	    decline
> 	-------------->
> 	    decline
> 	<--------------
> 
> As a result, a decline message was sent in the implementation, and this
> message was read from TCP by the already-fallback connection.
> 
> This patch double the client timeout as 2x of the server value,
> With this simple change, the Decline messages should never cross or
> collide (during Confirm link timeout).
> 
> This issue requires an immediate solution, since the protocol updates
> involve a more long-term solution.
> 
> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index abd2667..5b91f55 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -599,7 +599,7 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
>   	int rc;
>   
>   	/* receive CONFIRM LINK request from server over RoCE fabric */
> -	qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
> +	qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
>   			      SMC_LLC_CONFIRM_LINK);
>   	if (!qentry) {
>   		struct smc_clc_msg_decline dclc;
I'm wondering if the double time (if sufficient) of timeout could be for 
waiting for CLC_DECLINE on the client's side. i.e.

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 35ddebae8894..9b1feef1013d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -605,7 +605,7 @@ static int smcr_clnt_conf_first_link(struct smc_sock 
*smc)
                 struct smc_clc_msg_decline dclc;

                 rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
-                                     SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
+                                     SMC_CLC_DECLINE, 2 * 
CLC_WAIT_TIME_SHORT);
                 return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
         }
         smc_llc_save_peer_uid(qentry);

Because the purpose is to let the server have the control to deline.

