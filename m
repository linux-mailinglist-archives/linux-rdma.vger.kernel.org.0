Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5D7C5E83
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjJKUhr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjJKUhr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 16:37:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A790;
        Wed, 11 Oct 2023 13:37:45 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BKK6oJ006249;
        Wed, 11 Oct 2023 20:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9isG40MYYrMsVcHuFQAN5p4+9+E7ozxEC7n2qA1qXeA=;
 b=XI9FEHqcH478I2vjzWC9uLn1fzr24vCmGXylKcXNQqktbm9fyL7s/m07KWQUT/ZZEUyZ
 moedajqfz4xAz8wnBviW9qIybM8CrE1hHLt3nTnZHZ4aDA8TUcBUDUYkpO/VzkdKC091
 wpHClRxVP1k0CpWxTDbIc0gBprJ4nOxWKeht48y5j/Swu5hCyl2X/85RT7WqGOH9ffhr
 uf7D1PynIR8WhE7/tOrcEETK8jslQ4UWVc9jh6hvU2TEw5iSUv4KcP4UPoQ+wofwWrRM
 Uw791d2AnEOaI6yxUPXsjNjbqyJtulTtsYvCkvniTqdWL7zWGib0eygwCaMzPl0VrQ8f 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp2ga8vpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 20:37:40 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BKZsux000525;
        Wed, 11 Oct 2023 20:37:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp2ga8vn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 20:37:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BJGWIB000693;
        Wed, 11 Oct 2023 20:37:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5ktn5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 20:37:39 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BKbcRh29033204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 20:37:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F29755805B;
        Wed, 11 Oct 2023 20:37:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 243BE5804B;
        Wed, 11 Oct 2023 20:37:36 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Oct 2023 20:37:35 +0000 (GMT)
Message-ID: <5e2efb4b-1d26-4159-a2c7-b0107cb6381c@linux.ibm.com>
Date:   Wed, 11 Oct 2023 22:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/5] net/smc: allow cdc msg send rather than drop it
 with NULL sndbuf_desc
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-4-git-send-email-alibuda@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1697009600-22367-4-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4O3lQcSlKbjw33V-zRiqaqoy55qReCp7
X-Proofpoint-GUID: Y2fu8aWMw6eAr7szU0arHfILivWUZgM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_15,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110180
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
> This patch re-fix the issues memtianed by commit 22a825c541d7
> ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").
> 
> Blocking sending message do solve the issues though, but it also
> prevents the peer to receive the final message. Besides, in logic,
> whether the sndbuf_desc is NULL or not have no impact on the processing
> of cdc message sending.
> 
Agree.

> Hence that, this patch allow the cdc message sending but to check the
> sndbuf_desc with care in smc_cdc_tx_handler().
> 
> Fixes: 22a825c541d7 ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/smc_cdc.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 01bdb79..3c06625 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -28,13 +28,15 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
>   {
>   	struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend *)pnd_snd;
>   	struct smc_connection *conn = cdcpend->conn;
> +	struct smc_buf_desc *sndbuf_desc;
>   	struct smc_sock *smc;
>   	int diff;
>   
> +	sndbuf_desc = conn->sndbuf_desc;
>   	smc = container_of(conn, struct smc_sock, conn);
>   	bh_lock_sock(&smc->sk);
> -	if (!wc_status) {
> -		diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
> +	if (!wc_status && sndbuf_desc) {
> +		diff = smc_curs_diff(sndbuf_desc->len,
How could this guarantee that the sndbuf_desc would not be NULL?

>   				     &cdcpend->conn->tx_curs_fin,
>   				     &cdcpend->cursor);
>   		/* sndbuf_space is decreased in smc_sendmsg */
> @@ -114,9 +116,6 @@ int smc_cdc_msg_send(struct smc_connection *conn,
>   	union smc_host_cursor cfed;
>   	int rc;
>   
> -	if (unlikely(!READ_ONCE(conn->sndbuf_desc)))
> -		return -ENOBUFS;
> -
>   	smc_cdc_add_pending_send(conn, pend);
>   
>   	conn->tx_cdc_seq++;
