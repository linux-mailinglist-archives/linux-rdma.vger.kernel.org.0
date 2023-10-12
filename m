Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C27C73E8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347338AbjJLROt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjJLROs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 13:14:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE482B8;
        Thu, 12 Oct 2023 10:14:46 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CGsp5Y023923;
        Thu, 12 Oct 2023 17:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k2CWVVZ8B4NZOIDm4NIhtMXbmAlxzcG5aG5m2kpBjjI=;
 b=jtMacIhtwVkE7jWvwtMS9r2xhqIOTBk4idWmo7UhG2D9/T9rCTZzPlhhq4gyZp1mh98v
 kumFNwRuPyBIpymJeid2I2zfms1wk2NATsArTm2dgOYLAxU4vZJJgiFkhSkEOvZ5VbFB
 wcJ6k/HAcVwNazxNmO9YvhCrlLw4wPwkDV8r9BtaXe/yZE/j9DN6Pbw86RVMwlghbfHI
 m8Pd1l8iBrtDiZu8yEpXMyr1ICUzMLbfg8qY6hVFFLpkoOv1cgnRM6gFMHKcFDqeAP+E
 c0lAgVTxyUhwW5up/vB1S+/yvs1oe3d5PyLt2eBt1oNS9j7DmItqOXexMz6+UCoCNT/z XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmr48uqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:14:41 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CGsrgQ024001;
        Thu, 12 Oct 2023 17:14:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmr48upb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:14:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CGsrjZ023018;
        Thu, 12 Oct 2023 17:14:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc20kvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 17:14:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CHEc7g3998268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 17:14:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69AA85805D;
        Thu, 12 Oct 2023 17:14:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B2C95805B;
        Thu, 12 Oct 2023 17:14:36 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 17:14:36 +0000 (GMT)
Message-ID: <52133656-4dc6-4f32-9881-b63f19bb8859@linux.ibm.com>
Date:   Thu, 12 Oct 2023 19:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/5] net/smc: protect connection state transitions in
 listen work
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-5-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1697009600-22367-5-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r48zS1rSwpVuoM2sPPRNl_qt73Q-TbBh
X-Proofpoint-ORIG-GUID: a0Q4GEXv5nY9pbdOUmDg-wGd1QE64xBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11.10.23 09:33, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Consider the following scenario:
> 
> 				smc_close_passive_work
> smc_listen_out_connected
> 				lock_sock()
> if (state  == SMC_INIT)
> 				if (state  == SMC_INIT)
> 					state = SMC_APPCLOSEWAIT1;
> 	state = SMC_ACTIVE
> 				release_sock()
> 
> This would cause the state machine of the connection to be corrupted.
> Also, this issue can occur in smc_listen_out_err().
> 
> To solve this problem, we can protect the state transitions under
> the lock of sock to avoid collision.
> 
To this fix, I have to repeat the question from Alexandra.
Did the scenario occur in real life? Or is it just kind of potencial 
problem you found during the code review?

If it is the former one, could you please show us the corresponding 
message, e.g. from dmesg? If it is the latter one, I'd like to deal with 
it more carefully. Going from this scenario, I noticed that there could 
also be other similar places where we need to make sure that no race 
happens. Thus, it would make more sense to find a systematic approach.

> Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 5ad2a9f..3bb8265 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1926,8 +1926,10 @@ static void smc_listen_out_connected(struct smc_sock *new_smc)
>   {
>   	struct sock *newsmcsk = &new_smc->sk;
>   
> +	lock_sock(newsmcsk);
>   	if (newsmcsk->sk_state == SMC_INIT)
>   		newsmcsk->sk_state = SMC_ACTIVE;
> +	release_sock(newsmcsk);
>   
>   	smc_listen_out(new_smc);
>   }
> @@ -1939,9 +1941,12 @@ static void smc_listen_out_err(struct smc_sock *new_smc)
>   	struct net *net = sock_net(newsmcsk);
>   
>   	this_cpu_inc(net->smc.smc_stats->srv_hshake_err_cnt);
> +
> +	lock_sock(newsmcsk);
>   	if (newsmcsk->sk_state == SMC_INIT)
>   		sock_put(&new_smc->sk); /* passive closing */
>   	newsmcsk->sk_state = SMC_CLOSED;
> +	release_sock(newsmcsk);
>   
>   	smc_listen_out(new_smc);
>   }
