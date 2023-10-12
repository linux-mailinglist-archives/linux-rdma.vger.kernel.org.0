Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3607C7638
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbjJLTE0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 15:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLTEZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 15:04:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB483;
        Thu, 12 Oct 2023 12:04:23 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CIxTJ3027496;
        Thu, 12 Oct 2023 19:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TcbF7u6h8UanVvB4kjio1B54RIcwpdiPlHJIrm5KHLw=;
 b=HSJ3N7rC8AhJnjY7E/03t16tnbHGAo1F4E47rBxpe7IJbNl2E0tiyhTk6Bk6Nk9J6P8M
 atiCAR4PAZxS2DlCTtfgI+f5C/VxVyFxKRbQVJT5VXor4uesldSsk1U3zDYfj+SSDula
 lee6BXBtI8w6Y0FaYro9GcjmZ8H1qQaV6uwv9PjReHuhxJ2hQBIHcPpYNz5hsJB5Z6sa
 9XoFmNaT+M3hEOc0KCCapgdC6wcJ33MPMTrpbiq2Zl0/yXWkueMCpPoG2qm2urPygxhu
 I23uihDhzjsSGx6X6Kjk9IFcHv6omueOZl9cNAj6DlgJqRJ6tLnJSty6rc+K1BHOJ4aH JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tppjbr8p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:04:18 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CJ0uDc004429;
        Thu, 12 Oct 2023 19:04:18 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tppjbr8n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:04:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CIq8Fn001270;
        Thu, 12 Oct 2023 19:04:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk9cnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:04:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CJ4G0j2163202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 19:04:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7642E5805B;
        Thu, 12 Oct 2023 19:04:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DE7B58058;
        Thu, 12 Oct 2023 19:04:13 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 19:04:12 +0000 (GMT)
Message-ID: <bdcb307f-d2a8-4aef-bb7d-dd87e56ff740@linux.ibm.com>
Date:   Thu, 12 Oct 2023 21:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/5] net/smc: put sk reference if close work was
 canceled
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xTSy0oJ5xzOmyXfFWym16YkPX7EqljP4
X-Proofpoint-ORIG-GUID: dZIvluRzZfjkAwF0iy6-331tX2Cvbcyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_11,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11.10.23 09:33, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Note that we always hold a reference to sock when attempting
> to submit close_work. 
yes
Therefore, if we have successfully
> canceled close_work from pending, we MUST release that reference
> to avoid potential leaks.
> 
Isn't the corresponding reference already released inside the 
smc_close_passive_work()?

> Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD link groups")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/smc_close.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
> index 449ef45..10219f5 100644
> --- a/net/smc/smc_close.c
> +++ b/net/smc/smc_close.c
> @@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct smc_sock *smc)
>   	struct sock *sk = &smc->sk;
>   
>   	release_sock(sk);
> -	cancel_work_sync(&smc->conn.close_work);
> +	if (cancel_work_sync(&smc->conn.close_work))
> +		sock_put(sk);
>   	cancel_delayed_work_sync(&smc->conn.tx_work);
>   	lock_sock(sk);
>   }
