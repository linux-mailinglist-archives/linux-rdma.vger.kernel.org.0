Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D27AA5D8
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 01:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjIUX7m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIUX7l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 19:59:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D536F4;
        Thu, 21 Sep 2023 16:59:35 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNaWRW019394;
        Thu, 21 Sep 2023 23:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GqSRrvuzmUHbgVX5ow5+x1HPRKyMaqOJIHeMkbK/UlI=;
 b=H+R6aZ01dXI/TZBQVlI+EvoCZZWuwSI3ZPTpOpVHynxUSSt+FdSGSfyDMsW0hc5JDG99
 YA/N1eoZugtYAzv3gXcrwU5JNUd37RdtO7Se8aIWoAvr9cbGCRvIfxLe5dKYf7Otvojf
 D8Xjeuv5PPR29wbHWLtKYwx95qYGzeb5LU4LJHfp4V6UTOfrSm64POInU1yLqfuHgnSf
 bwIzKvT05qRsboK4jp6WBU3fALYvNP/+csLTJhQ7SN4wi3fE7S+Zfmp8hCJZ0V7PVU0c
 nDbGgDlcPwoy52WvGxW24BwhmlvE7+VJq3oztZnQDPgtgN//6g0OQpj4kPTGVsLlgLn2 fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8xvg9hhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:59:30 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LNaZx3019897;
        Thu, 21 Sep 2023 23:59:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8xvg9hgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:59:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LN7VAC018806;
        Thu, 21 Sep 2023 23:59:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsnn4eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:59:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LNxRQC63177088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:59:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69D895805F;
        Thu, 21 Sep 2023 23:59:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB4AF58043;
        Thu, 21 Sep 2023 23:59:25 +0000 (GMT)
Received: from [9.171.4.137] (unknown [9.171.4.137])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 23:59:25 +0000 (GMT)
Message-ID: <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
Date:   Fri, 22 Sep 2023 01:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UkOgE4FmI97diwg6vitq6lg7NHFC630Z
X-Proofpoint-GUID: On0vEL_-A4dXscm68g4-a-xwmrPsRfZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309210205
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 20.09.23 14:08, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Consider the following scenarios:
> 
> smc_release
> 	smc_close_active
> 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
> 		smc->clcsock->sk->sk_user_data = NULL;
> 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
> 
> smc_tcp_syn_recv_sock
> 	smc = smc_clcsock_user_data(sk);
> 	/* now */
> 	/* smc == NULL */
> 
> Hence, we may read the a NULL value in smc_tcp_syn_recv_sock(). And
> since we only unset sk_user_data during smc_release, it's safe to
> drop the incoming tcp reqsock.
> 
> Fixes:  ("net/smc: net/smc: Limit backlog connections"
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd97..b4acf47 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -125,6 +125,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>   	struct sock *child;
>   
>   	smc = smc_clcsock_user_data(sk);
> +	if (unlikely(!smc))
> +		goto drop;
>   
>   	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
>   				sk->sk_max_ack_backlog)

Hi D.Wythe,

this is unfortunately not sufficient for this fix. You have to make sure 
that is not a life-time problem. Even so, READ_ONCE() is also needed in 
this case.

Thanks,
Wenjia
