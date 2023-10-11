Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A07C5E6A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjJKUbr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjJKUbq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 16:31:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2274091;
        Wed, 11 Oct 2023 13:31:45 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BKErVt006601;
        Wed, 11 Oct 2023 20:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wz952yxI+W2urZ0VD9E40vDqhU0tEtGlzr5j5jcMADw=;
 b=X424MufFhCuSu0IZiWUXDgA0yr1GP+uhey6nLJEXwzaaFwB5jC3dD75dpbCVSzjQAtd8
 si7oeoriz9bNTcLZLjrnnKNelnItVoKzGaAcrS5PIMqPev4coNSQLx7kOIbVLGskDXvE
 emagMB6svEt6hhF6DDCWORfZtY36yLH2fmXTJGxeOTEbLOnAyfHsnGCp7RNlAjhmuZRU
 anODlyEx8hGgMzGc3kKiyl+iZmj4HwiwjYTL+28daFOc4jJQsdE+YFLWsO9UPF1yJ+nM
 uSGmrzCkM/m4sHKVBE6n/YTC7ynRrDBU5OJLrpjrzusiraUWpaDaqyhusppnwjvPx38d oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp2jugjac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 20:31:39 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BKPNL5012901;
        Wed, 11 Oct 2023 20:31:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp2jugja1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 20:31:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BILYbR028188;
        Wed, 11 Oct 2023 20:31:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1yb0f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 20:31:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BKVbUR27394682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 20:31:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42F5158059;
        Wed, 11 Oct 2023 20:31:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 870BC5804B;
        Wed, 11 Oct 2023 20:31:35 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Oct 2023 20:31:35 +0000 (GMT)
Message-ID: <e63b546f-b993-4e42-8269-e4d9afa5b845@linux.ibm.com>
Date:   Wed, 11 Oct 2023 22:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net/smc: fix dangling sock under state
 SMC_APPFINCLOSEWAIT
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-2-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1697009600-22367-2-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GyiSunecSvoAHVnxNuwSVWlrlOcK-b6i
X-Proofpoint-GUID: JqdmAmwyOrN2dAHJjyNZlq23tbcQKitD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_15,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110179
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
> Considering scenario:
> 
> 				smc_cdc_rx_handler_rwwi
> __smc_release
> 				sock_set_flag
> smc_close_active()
> sock_set_flag
> 
> __set_bit(DEAD)			__set_bit(DONE)
> 
> Dues to __set_bit is not atomic, the DEAD or DONE might be lost.
> if the DEAD flag lost, the state SMC_CLOSED  will be never be reached
> in smc_close_passive_work:
> 
> if (sock_flag(sk, SOCK_DEAD) &&
> 	smc_close_sent_any_close(conn)) {
> 	sk->sk_state = SMC_CLOSED;
> } else {
> 	/* just shutdown, but not yet closed locally */
> 	sk->sk_state = SMC_APPFINCLOSEWAIT;
> }
> 
> Replace sock_set_flags or __set_bit to set_bit will fix this problem.
> Since set_bit is atomic.
> 
I didn't really understand the scenario. What is 
smc_cdc_rx_handler_rwwi()? What does it do? Don't it get the lock during 
the runtime?

> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c    | 4 ++--
>   net/smc/smc.h       | 5 +++++
>   net/smc/smc_cdc.c   | 2 +-
>   net/smc/smc_close.c | 2 +-
>   4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd97..5ad2a9f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -275,7 +275,7 @@ static int __smc_release(struct smc_sock *smc)
>   
>   	if (!smc->use_fallback) {
>   		rc = smc_close_active(smc);
> -		sock_set_flag(sk, SOCK_DEAD);
> +		smc_sock_set_flag(sk, SOCK_DEAD);
>   		sk->sk_shutdown |= SHUTDOWN_MASK;
>   	} else {
>   		if (sk->sk_state != SMC_CLOSED) {
> @@ -1742,7 +1742,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
>   		if (new_clcsock)
>   			sock_release(new_clcsock);
>   		new_sk->sk_state = SMC_CLOSED;
> -		sock_set_flag(new_sk, SOCK_DEAD);
> +		smc_sock_set_flag(new_sk, SOCK_DEAD);
>   		sock_put(new_sk); /* final */
>   		*new_smc = NULL;
>   		goto out;
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 24745fd..e377980 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -377,4 +377,9 @@ void smc_fill_gid_list(struct smc_link_group *lgr,
>   int smc_nl_enable_hs_limitation(struct sk_buff *skb, struct genl_info *info);
>   int smc_nl_disable_hs_limitation(struct sk_buff *skb, struct genl_info *info);
>   
> +static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
> +{
> +	set_bit(flag, &sk->sk_flags);
> +}
> +
>   #endif	/* __SMC_H */
> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 89105e9..01bdb79 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -385,7 +385,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>   		smc->sk.sk_shutdown |= RCV_SHUTDOWN;
>   		if (smc->clcsock && smc->clcsock->sk)
>   			smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
> -		sock_set_flag(&smc->sk, SOCK_DONE);
> +		smc_sock_set_flag(&smc->sk, SOCK_DONE);
>   		sock_hold(&smc->sk); /* sock_put in close_work */
>   		if (!queue_work(smc_close_wq, &conn->close_work))
>   			sock_put(&smc->sk);
> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
> index dbdf03e..449ef45 100644
> --- a/net/smc/smc_close.c
> +++ b/net/smc/smc_close.c
> @@ -173,7 +173,7 @@ void smc_close_active_abort(struct smc_sock *smc)
>   		break;
>   	}
>   
> -	sock_set_flag(sk, SOCK_DEAD);
> +	smc_sock_set_flag(sk, SOCK_DEAD);
>   	sk->sk_state_change(sk);
>   
>   	if (release_clcsock) {
